#!/usr/bin/env python3
"""Layout of the flip-flop bank (revision of 25 Nov 2026) and of its connections into the existing tile.

Called by tools/chip_gds.py after the existing part of the tile has been placed and routed exactly as before.
Coordinates in um, as in layout_gen.py.

  * The bank lies in the free band below the existing rows (y < 198.72 um, the bottom of the existing
    channel 0), right-aligned like the existing rows: four rows, from the bottom
        B0  N1: the 3.3 V NAND flip-flop block meta_n3ffb (layout/blocks/meta_n3ffb.gds), one hard block
        B1  N3: copy of DUT3, the nine cells in the order of the DUT rows
        B2  trial clock copy, capture and data drivers
        B3  selector, observation clock buffer, early observer, tie cell, the two join multiplexers
    with routing channels between them, routed like the existing tile: Metal2 escapes, Metal3 trunks,
    Metal4 columns between channels.
  * Splices (build_master.SPLICE): the existing router still sees the controller inputs on selected_q and
    early_q. Each of these nets leaves channel 1 upwards through one Metal4 column to the controller. Here
    the Via3 that joins that column to the net's trunk in channel 1 is removed, the column is extended down
    to the bank (it becomes the join output, ctrl_q / ctrl_early), and a new Via3 on the trunk with its own
    Metal4 column takes the net (selected_q / early_q) down to its join multiplexer. Nothing else of the
    existing layout changes.
  * Pins ui_in[1], ui_in[2], ui_in[5], ui_in[7], uio_in[0] (unused before) get Metal4 drops straight down
    to the bank, with one short Metal4 jog under the pin where the column under the pin is not free.
    clk continues its pin drop straight down on the right of the rows; rst_n gets a Via3 on its trunk in
    the top channel and a Metal4 column down.
"""
import sys, math
from collections import defaultdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import build_master as BM
import layout_gen as LG
import route_gen as RG
import gds
from layout_gen import EXT, HW, HV, EPS, ROWH, R

BLOCKS = LG.CHIP / 'layout' / 'blocks'
BANK_TOP = 198.72            # top of the bank's top channel = bottom of the existing channel 0 (199.37 lowest shape)
PAD = 0.22                   # rail Via-stack pads, as in chip_gds.py
M4S = R['Ms']                # Metal4 spacing (0.28)

# ------------------------------------------------------------------ hard blocks (3.3 V flip-flops)
# Pins: the Via1 centre on the cell pin that the block's own Metal2 stub starts from (block coordinates); the
# escape continues that stub upwards. Rails: Metal1 VSS at y = -0.30..0.30, VDD at 3.62..4.22 over the whole width.
# 'pad': pins without a Via1 of their own in the block (a Metal1 pad and a Via1 are drawn on top of the block's Metal1).
MACROS = {
    'meta_dut_n3ffb': {'cell': 'meta_n3ffb', 'gds': BLOCKS / 'meta_n3ffb.gds', 'w': 44.80, 'x': 264.32,
                       'pins': {'d': (5.89, 1.825), 'clk': (33.0, 1.83), 'q': (39.24, 2.24)}, 'pad': {}},
    # j3a abuts N1 on its left (tap cell against tap cell). d: the Via1 of the Y-stack data gate; clk: a slave clock
    # pad; q: the output column (Metal1 0.23 um wide), which gets a Metal1 pad 0.26 um wide and a Via1
    'meta_dut_j3a': {'cell': 'meta_j3a', 'gds': BLOCKS / 'meta_j3a.gds', 'w': 30.32, 'x': 234.00,
                     'pins': {'d': (22.72, 2.10), 'clk': (18.20, 3.05), 'q': (24.96, 2.75)},
                     'pad': {'q': (24.83, 2.56, 25.09, 2.94)}},
}

# x of the new Metal4 columns through the existing tile, chosen in the columns that are free over the whole
# height (tools/bank_layout.py reports the clearance of each to the existing Metal4 in the plan's 'bank' entry)
SPLICE_X = {'selected_q': 246.68, 'early_q': 270.20}      # new Via3 on the net's trunk in channel 1
# pin -> (x of the column, y of the jog under the pin; None = straight down). The columns stay out of the rows of the
# flip-flops under test (x 275.5 to 316.4 um at y 211 to 231 um) except ui_in[5], for which no free column exists
# between the pin drops of ui_in[6] and ui_in[4]; uio_in[0] goes down over a filler cell of row F1 (x 254.80 to 255.92).
PIN_ROUTE = {'uio_in[0]': (255.36, 323.46), 'ui_in[7]': (265.72, None), 'ui_in[5]': (277.76, 323.46),
             'ui_in[2]': (314.86, 322.76), 'ui_in[1]': (315.42, 323.46)}
STRAP_Y = {'VGND': 6.0, 'VDPWR': 7.0}                     # Metal3 supply straps (centre y), see add_bank

def macro_areas(sub):
    """Antenna data of a block's pins from build_master's subcircuit: gate area (W x L of every gate on the pin)
    and diffusion area (drain or source area of the devices whose drain or source is the pin), um2."""
    out = defaultdict(lambda: [0.0, 0.0])
    def add(devs, pmap):
        for d in devs:
            for role in ('g', 'd', 's'):
                net = pmap(d[role])
                if net in ('d', 'clk', 'q'):
                    if role == 'g':
                        out[net][0] += d['W'] * d['L'] * 1e12
                    else:
                        out[net][1] += d['W'] * 0.5e-6 * 1e12      # junction area estimate as in pdk_cells.py
    if sub in BM.BANK_DEVICE_SUBCKTS:
        add(BM.BANK_DEVICE_SUBCKTS[sub], lambda n: n)
    else:
        for i in BM.BANK_SUBCKTS[sub]:
            cell = BM.CELLS[i['cell']]
            add(cell['devices'], lambda n, i=i: i['conns'].get(n))
    return out

def macro_lef(m, sub=None):
    areas = macro_areas(sub) if sub else {}
    pins = {}
    for p, (x, y) in m['pins'].items():
        # a pin rectangle that admits exactly one Via1 position: the block's own Via1
        r = [(x - HV, y - HV - R['Venc']), (x + HV, y - HV - R['Venc']), (x + HV, y + HV + R['Venc']), (x - HV, y + HV + R['Venc'])]
        ga, da = areas.get(p, (0.0, 0.0))
        pins[p] = {'polys': [('Metal1', r)], 'dir': 'OUTPUT' if p == 'q' else 'INPUT', 'use': 'signal',
                   'gate_area': round(ga, 4), 'diff_area': round(da, 4)}
    return {'w': m['w'], 'h': ROWH, 'pins': pins, 'obs': []}

for _sub, _m in MACROS.items():
    LG._LEF[_m['cell']] = macro_lef(_m, _sub)

# ------------------------------------------------------------------ instances and rows
EXTERNAL = ['clk', 'rst_n', 'uio_in[0]', 'ui_in[1]', 'ui_in[2]', 'ui_in[5]', 'ui_in[7]',
            'selected_q', 'early_q', 'ctrl_q', 'ctrl_early']

def bank_instances():
    out = []
    for box, i in BM.BANK:
        out.append({'name': i['name'], 'cell': i['cell'].replace(BM.LIB, ''), 'conns': dict(i['conns']), 'box': box})
    for box, name, sub, nets in BM.BANK_SUB:
        pmap = dict(zip(['d', 'clk', 'q'], nets))
        if sub in MACROS:
            out.append({'name': name, 'cell': MACROS[sub]['cell'], 'conns': pmap, 'box': box, 'macro': sub})
        else:
            for i in BM.DUT_SUBCKTS[sub]:
                conns = {p: pmap.get(n, f'{name}/{n}') for p, n in i['conns'].items()}
                out.append({'name': f'{name}/{i["name"]}', 'cell': i['cell'].replace(BM.LIB, ''), 'conns': conns,
                            'box': box, 'dut': name})
    return out

DUT_ORDER = ['u_cki', 'u_mg1', 'u_mg2', 'u_mfw', 'u_mkp', 'u_sg1', 'u_sg2', 'u_sfw', 'u_skp']
ROW_B2 = ['bank_data0', 'bank_data1', 'bank_b_ff', 'bank_a_inv', 'bank_a_ff', 'bank_cap0', 'bank_cap1']
ROW_B3 = ['join_q', 'join_e', 'bank_observer', 'bank_obs1', 'bank_obs0', 'bank_select', 'bank_tie']

def bank_rows(insts):
    by = {i['name']: i for i in insts}
    rows = [('B0', sorted([i for i in insts if i.get('macro')], key=lambda i: MACROS[i['macro']]['x'])),
            ('B1', [by[f'bank_n3/{c}'] for c in DUT_ORDER]),
            ('B2', [by[n] for n in ROW_B2]),
            ('B3', [by[n] for n in ROW_B3])]
    placed_names = {i['name'] for _, cells in rows for i in cells}
    missing = [i['name'] for i in insts if i['name'] not in placed_names]
    if missing:
        raise ValueError(f'bank instances without a row: {missing}')
    return rows

def place(rows):
    placed = []
    for name, cells in rows:
        if cells and cells[0].get('macro'):
            items, x = [], None
            for inst in cells:
                m = MACROS[inst['macro']]
                items.append((m['x'], m['cell'], inst))
            placed.append(items)
        else:
            placed.append(LG.place_row(cells))
    return placed

# ------------------------------------------------------------------ Metal4 occupancy
class M4Map:
    """Vertical and horizontal Metal4 shapes (x1, y1, x2, y2, net) for clearance checks."""
    def __init__(self, rects):
        self.r = list(rects)
    def free(self, x1, y1, x2, y2, net=None, space=M4S):
        for a, b, c, d, n in self.r:
            if n == net and net is not None:
                continue
            if x1 < c + space - EPS and a < x2 + space - EPS and y1 < d + space - EPS and b < y2 + space - EPS:
                # corner-to-corner: Euclidean spacing
                gx = max(a - x2, x1 - c); gy = max(b - y2, y1 - d)
                if gx > 0 and gy > 0 and math.hypot(gx, gy) >= space - EPS:
                    continue
                return False
        return True
    def add(self, x1, y1, x2, y2, net):
        self.r.append((x1, y1, x2, y2, net))

def find_column(m4, x0, ylo, yhi, net, step=0.56, grid=True, limit=60, avoid=()):
    """Nearest x (on the 0.28 + 0.56 k grid unless grid is False) to x0 where a 0.28 um Metal4 column from ylo to
    yhi keeps the spacing to every other Metal4 shape."""
    base = round(round((x0 - 0.28) / 0.56) * 0.56 + 0.28, 3) if grid else x0
    for k in range(limit):
        for sgn in ((1,) if k == 0 else (1, -1)):
            x = round(base + sgn * k * step, 3)
            if any(abs(x - a) < 0.56 - EPS for a in avoid):
                continue
            if m4.free(x - HW, ylo, x + HW, yhi, net):
                return x
    raise RuntimeError(f'no free Metal4 column near x = {x0} for {net}')

# ------------------------------------------------------------------ the bank
def add_bank(P):
    """Add the bank, the splices and the pin drops to the plan P of chip_gds.build() (shapes in P['shapes'])."""
    S = P['shapes']
    ch, ych = P['chans'], P['ych']
    def core_track(c, net):
        lvl = ch[c]['level'][net]
        return round(ych[c] + RG.TRACK0 + RG.PITCH * (ch[c]['ntr'] - 1 - lvl), 4)
    insts = bank_instances()
    rows = bank_rows(insts)
    placed = place(rows)
    nb = len(rows)
    # ---- net -> bank rows; external nets count as one row above the bank
    netrows = defaultdict(list)
    for r, (_, cells) in enumerate(rows):
        for inst in cells:
            for p, n in inst['conns'].items():
                if n not in ('VDPWR', 'VGND'):
                    netrows[n].append(r)
    for n in EXTERNAL:
        assert n in netrows, f'external net {n} has no pin in the bank'
    def pref_for(r):
        # up whenever another pin of the net lies in a higher row (or outside the bank); the drivers of the
        # flip-flop inputs sit above the flip-flops, so their nets reach each row from above
        def pref(net):
            others = [x for x in netrows[net] if x != r] + ([nb] if net in EXTERNAL else [])
            if not others or max(others) > r:
                return 'up'
            return 'down'
        return pref
    access = {}
    for r, items in enumerate(placed):
        acc, nets = LG.access_row(items, pref_for(r))
        for k, (x, y, d) in acc.items():
            access[k] = (r, x, y, d, nets[k])
    macro_pins = {(i['name'], p) for _, cells in rows for i in cells if i.get('macro') for p in i['conns']
                  if p not in MACROS[i['macro']]['pad']}
    macro_pads = {(i['name'], p): (MACROS[i['macro']]['x'], MACROS[i['macro']]['pad'][p])
                  for _, cells in rows for i in cells if i.get('macro') for p in MACROS[i['macro']]['pad']}
    term = defaultdict(lambda: defaultdict(list))
    for (iname, pin), (r, x, y, d, net) in access.items():
        if len(netrows[net]) < 2 and net not in EXTERNAL:
            continue
        c = r + 1 if d == 'up' else r
        term[c][net].append((x, 'B' if d == 'up' else 'T', (iname, pin, r, y)))
    nets_ch = defaultdict(set)
    for c, nets in term.items():
        for n in nets:
            nets_ch[n].add(c)

    # ---- Metal4 already in the tile (power stripes, the ua[0] drop, every column of the existing routing)
    m4 = M4Map(S.r['M4'])
    for xa, xb, net in LG.STRIPES:
        m4.add(xa, LG.TILE_H * 0 + 5.0, xb, 320.36, net)
    y_bank_floor = 120.0      # nothing of the bank goes below this (checked at the end)

    # ---- splices: selected_q / early_q leave channel 1 through one column each (existing routing)
    ext_cols = {}             # net -> (x, y_top): a Metal4 column from y_top (in the existing tile) down into the bank
    new_m4 = []               # other Metal4 drawn here (x1, y1, x2, y2, net)
    removed_v3 = []
    for ctrl_net, net in BM.SPLICE.items():
        x, lo, hi = P['ft'][net]
        assert lo == 1 and net in ch[1]['level'], f'{net}: expected one column from channel 1 up, found {P["ft"][net]}'
        ty = core_track(1, net)
        k = [i for i, r in enumerate(S.r['V3']) if r[4] == net and abs((r[0] + r[2]) / 2 - x) < EPS and abs((r[1] + r[3]) / 2 - ty) < EPS]
        assert len(k) == 1, (net, k)
        removed_v3.append(S.r['V3'].pop(k[0]))
        # relabel the column and everything of the net above channel 1 (labels are used by this generator's checks only)
        ylim = ych[lo + 1] - EPS
        for layer in ('M4', 'M3', 'V3', 'V2', 'M2', 'V1'):
            S.r[layer] = [(a, b, c_, d, ctrl_net) if n == net and ((layer == 'M4' and abs((a + c_) / 2 - x) < EPS) or
                          (layer != 'M4' and b > ylim)) else (a, b, c_, d, n) for a, b, c_, d, n in S.r[layer]]
        ext_cols[ctrl_net] = (x, ty)
        # the controller pins on this net now belong to the join output (as in netlist/chip.cdl)
        for items in P['placed']:
            for x0, cell, inst in items:
                if inst is not None and inst['name'].startswith('controller/'):
                    for pn, nn in list(inst['conns'].items()):
                        if nn == net:
                            inst['conns'][pn] = ctrl_net
        xs = SPLICE_X[net]
        xa, xb = [(a, c_) for a, b, c_, d, n in S.r['M3'] if n == net and abs((b + d) / 2 - ty) < EPS][0]
        if xs + EXT > xb + EPS or xs - EXT < xa - EPS:      # extend the trunk to reach the new via
            S.add('M3', min(xa, xs - EXT), ty - HW, max(xb, xs + EXT), ty + HW, net)
        S.via('V3', xs, ty, net)
        ext_cols[net] = (xs, ty)
    # ---- pins that were unused: drops from the pin straight down, or with a jog under the pin (PIN_ROUTE)
    tp = P['tp']
    for pin, (xj, yj) in PIN_ROUTE.items():
        x1, y1, x2, y2, d = tp[pin]
        xc = round((x1 + x2) / 2, 3)
        if yj is None:                                       # straight: the column overlaps the pin
            assert abs(xj - xc) <= 0.15 + EPS, pin
            ext_cols[pin] = (xj, y1 + 0.1)
            continue
        new_m4.append((xc - HW, yj - HW, xc + HW, y1 + 0.1, pin))                     # pin to jog
        new_m4.append((min(xj, xc) - HW, yj - HW, max(xj, xc) + HW, yj + HW, pin))   # jog
        ext_cols[pin] = (xj, yj)
    # clk and rst_n: their pin drops (to their trunks in the top channel) continue straight down on the right of the rows
    nrows = P['nrows']
    for pin in ('clk', 'rst_n'):
        x1, y1, x2, y2, d = tp[pin]
        ext_cols[pin] = (round((x1 + x2) / 2, 3), core_track(nrows, pin))
    # every new Metal4 column in the existing tile must keep the spacing; report its clearance to the old Metal4
    clear = {}
    for net, (x, ytop) in ext_cols.items():
        lo_y = y_bank_floor
        own = [(x - HW, lo_y, x + HW, ytop + EXT)]
        others = [r_ for r_ in m4.r if r_[4] not in (net, BM.SPLICE.get(net), {v: k for k, v in BM.SPLICE.items()}.get(net))
                  and not (r_[4] == net)]
        assert M4Map(others).free(*own[0], net), f'Metal4 column of {net} at x = {x} violates the spacing'
        gap = min((max(r_[0] - own[0][2], own[0][0] - r_[2]) for r_ in others
                   if r_[1] < ytop + EXT and r_[3] > lo_y and r_[4] not in ('VDPWR', 'VGND')), default=99)
        clear[net] = round(gap, 3)
    for r_ in new_m4:
        assert M4Map([o for o in m4.r if o[4] != r_[4]]).free(*r_[:4], r_[4]), f'Metal4 jog of {r_[4]} violates the spacing'
    for net, (x, ytop) in ext_cols.items():
        m4.add(x - HW, y_bank_floor, x + HW, ytop + EXT, net)
    for r_ in new_m4:
        m4.add(*r_)

    # ---- terminals of the external columns, then bank-internal columns for nets that span several channels
    top_ch = nb
    for net in EXTERNAL:
        x, _ = ext_cols[net]
        for c in sorted(nets_ch[net]):
            term[c][net].append((x, 'F', ('ext', net)))
    ft = {}
    for net in sorted(nets_ch, key=lambda n: -(max(nets_ch[n]) - min(nets_ch[n]))):
        if net in EXTERNAL or len(nets_ch[net]) < 2:
            continue
        xs_ = sorted(x for c in nets_ch[net] for x, s, i in term[c][net])
        xm = xs_[len(xs_) // 2]
        ft[net] = (xm, min(nets_ch[net]), max(nets_ch[net]))       # x fixed below, once the channel heights are known
    # bank columns are placed on x positions that no other Metal4 uses anywhere in the bank band
    used_x = [v[0] for v in ext_cols.values()]
    bank_m4 = M4Map([r for r in m4.r])
    for net, (xm, lo, hi) in list(ft.items()):
        x = find_column(bank_m4, xm, y_bank_floor, BANK_TOP, net, avoid=used_x)
        used_x.append(x)
        bank_m4.add(x - HW, y_bank_floor, x + HW, BANK_TOP, net)
        ft[net] = (x, lo, hi)
        for c in nets_ch[net]:
            term[c][net].append((x, 'F', ('ft', net)))

    # ---- tracks per bank channel (splitting a net with a Metal4 jumper where the vertical constraints cycle)
    chans, jumpers = {}, []
    for c in range(nb + 1):
        nets = {n: list(t) for n, t in term[c].items() if t}
        for attempt in range(60):
            try:
                level, ntr = RG.assign_tracks(nets) if nets else ({}, 1)
                break
            except RG.CycleError as e:
                stuck = e.args[0]
                cand = [n for n in stuck if {'T', 'B'} <= {s_ for x, s_, i in nets[n]}]
                if not cand:
                    raise RuntimeError(f'bank channel {c}: cannot resolve vertical constraints {stuck[:5]}')
                n = max(cand, key=lambda n: len(nets[n]))
                xs_ = sorted(x for x, s_, i in nets[n])
                xj = find_column(bank_m4, xs_[len(xs_) // 2], y_bank_floor, BANK_TOP, n, avoid=used_x)
                used_x.append(xj)
                t_part = [t for t in nets[n] if t[1] != 'B'] + [(xj, 'F', ('jumper', n))]
                b_part = [t for t in nets[n] if t[1] == 'B'] + [(xj, 'F', ('jumper', n))]
                del nets[n]
                nets[n + '#T'] = t_part; nets[n + '#B'] = b_part
                jumpers.append((c, xj, n + '#T', n + '#B'))
        else:
            raise RuntimeError(f'bank channel {c}: too many splits')
        chans[c] = {'nets': nets, 'level': level, 'ntr': ntr}
    # ---- vertical stack from BANK_TOP down: channel nb (top), row nb-1, ..., row 0, channel 0
    heights = {c: 2 * RG.TRACK0 + RG.PITCH * (chans[c]['ntr'] - 1) for c in chans}
    yb_ch, yb_row = {}, {}
    y = BANK_TOP
    for c in range(nb, -1, -1):
        y -= heights[c]; yb_ch[c] = round(y, 4)
        if c > 0:
            y -= ROWH; yb_row[c - 1] = round(y, 4)
    def track_y(c, sn):
        lvl = chans[c]['level'][sn]
        return round(yb_ch[c] + RG.TRACK0 + RG.PITCH * (chans[c]['ntr'] - 1 - lvl), 4)
    def subnet(c, net, side):
        if net in chans[c]['level']:
            return net
        return net + ('#B' if side == 'B' else '#T')

    # ---- Via2 of one net on one trunk: either at the same x or at least one via plus one spacing apart
    for c, chd in chans.items():
        for sn, terms in chd['nets'].items():
            xs_ = sorted({round(x, 3) for x, s_, i in terms if s_ in ('T', 'B')})
            for a_, b_ in zip(xs_, xs_[1:]):
                assert b_ - a_ >= 2 * HV + R['Vs'] - EPS, f'bank channel {c}, net {sn}: Via2 at x = {a_} and {b_} too close'
    # ---- draw: escapes, Via1, Via2
    block_vias = []
    for (iname, pin), (r, x, yrel, d, net) in access.items():
        c = r + 1 if d == 'up' else r
        if net not in term[c] and net + '#T' not in chans[c]['level']:
            continue
        sn = subnet(c, net, 'B' if d == 'up' else 'T')
        yv = yb_row[r] + yrel
        ty = track_y(c, sn)
        if (iname, pin) not in macro_pins:
            S.via('V1', x, yv, net)
        else:
            block_vias.append((x - HV, yv - HV, x + HV, yv + HV, net))     # the block's own Via1 (not drawn here)
        if (iname, pin) in macro_pads:
            bx, (a, b, c_, d_) = macro_pads[(iname, pin)]
            S.add('M1', bx + a, yb_row[r] + b, bx + c_, yb_row[r] + d_, net)
        if d == 'up':
            S.add('M2', x - HW, yv - EXT, x + HW, ty + EXT, net)
        else:
            S.add('M2', x - HW, ty - EXT, x + HW, yv + EXT, net)
        S.via('V2', x, ty, net)
    # ---- trunks and Via3
    for c, chd in chans.items():
        for sn, terms in chd['nets'].items():
            net = sn.split('#')[0]
            ty = track_y(c, sn)
            xa, xb = RG.trunk_x([x for x, s, i in terms])
            S.add('M3', xa, ty - HW, xb, ty + HW, net)
            for x, s, info in terms:
                if s == 'F':
                    S.via('V3', x, ty, net)
    # ---- Metal4: bank columns, jumpers, external columns down to their lowest bank channel
    for net, (x, lo, hi) in ft.items():
        ys = [track_y(c, sn) for c in range(lo, hi + 1) for sn in chans[c]['level'] if sn.split('#')[0] == net
              and any(t[1] == 'F' and abs(t[0] - x) < EPS for t in chans[c]['nets'][sn])]
        S.add('M4', x - HW, min(ys) - EXT, x + HW, max(ys) + EXT, net)
    for c, xj, a, b in jumpers:
        ya, yb_ = track_y(c, a), track_y(c, b)
        S.add('M4', xj - HW, min(ya, yb_) - EXT, xj + HW, max(ya, yb_) + EXT, a.split('#')[0])
    for net, (x, ytop) in ext_cols.items():
        lows = [track_y(c, sn) for c in nets_ch[net] for sn in chans[c]['level'] if sn.split('#')[0] == net]
        S.add('M4', x - HW, min(lows) - EXT, x + HW, ytop + EXT, net)
    for r_ in new_m4:
        S.add('M4', *r_)
    # ---- power: rail Via stacks of the standard-cell rows; Metal1 rail extension and stacks for the blocks
    def stack(xs, yr, net):
        S.via('V1', xs, yr, net)
        S.add('M2', xs - PAD, yr - PAD, xs + PAD, yr + PAD, net)
        S.via('V2', xs, yr, net)
        S.add('M3', xs - PAD, yr - PAD, xs + PAD, yr + PAD, net)
        S.via('V3', xs, yr, net)
    rails = []
    for r, items in enumerate(placed):
        yb = yb_row[r]
        if items and items[0][2] is not None and items[0][2].get('macro'):
            x0 = min(it[0] for it in items)
            x1 = max(it[0] + MACROS[it[2]['macro']]['w'] for it in items)
            pairs = [(xa, xb, net) for xa, xb, net in LG.STRIPES if xa > x1 - 1]
            assert pairs, 'no power stripe to the right of the block row'
            xe = max(xb for xa, xb, net in pairs[:2]) + 0.5
            S.add('M1', x1 - 0.1, yb - 0.30, xe, yb + 0.30, 'VGND')
            S.add('M1', x1 - 0.1, yb + ROWH - 0.30, xe, yb + ROWH + 0.30, 'VDPWR')
            for xa, xb, net in pairs[:2]:
                yr = yb + ROWH if net == 'VDPWR' else yb
                for xs in ((xa + xb) / 2 - 0.5, (xa + xb) / 2 + 0.5):
                    stack(xs, yr, net)
            rails.append((r, x0, xe, yb))
            continue
        x0 = items[0][0]; x1 = items[-1][0] + 1.12
        rails.append((r, x0, x1, yb))
        for xa, xb, net in LG.STRIPES:
            if xa > x0 + 1 and xb < x1 - 1:
                yr = yb + ROWH if net == 'VDPWR' else yb
                for xs in ((xa + xb) / 2 - 0.5, (xa + xb) / 2 + 0.5):
                    stack(xs, yr, net)
    # ---- supply straps at the foot of the stripes. Each supply's three stripes are otherwise joined only through
    # the rails of the cells, so in the top cell's own geometry they are three nodes with the same label, and
    # Magic's 'extract unique' renames two of them (_uq0, _uq1); which name the merged net keeps then depends on
    # the order of the merges. One Metal3 strap per supply, with Via3 under each of its stripes, makes each
    # supply one node of the top cell.
    for k_, net in enumerate(('VGND', 'VDPWR')):
        ys = STRAP_Y[net]
        st = [(xa, xb) for xa, xb, n in LG.STRIPES if n == net]
        S.add('M3', min(a for a, b in st) + 0.2, ys - 0.28, max(b for a, b in st) - 0.2, ys + 0.28, net)
        for xa, xb in st:
            for xs in ((xa + xb) / 2 - 0.5, (xa + xb) / 2 + 0.5):
                S.via('V3', xs, ys, net)
    assert yb_ch[0] > y_bank_floor
    P['bank'] = dict(rows=rows, placed=placed, access=access, chans=chans, ych=yb_ch, yrow=yb_row, heights=heights,
                     ft=ft, jumpers=jumpers, ext_cols=ext_cols, removed_v3=removed_v3, rails=rails, nets_ch=dict(nets_ch),
                     clearance=clear, block_vias=block_vias)
    return P

def gds_cells():
    """GDS cells of the hard blocks (each file holds the block and its 3.3 V library cells)."""
    out = []
    for m in MACROS.values():
        src = gds.read(m['gds'])
        assert m['cell'] in src.cells, f'{m["gds"]} has no cell {m["cell"]}'
        out += list(src.cells.values())
    return out

def plan_json(P):
    B = P['bank']
    return {'rows': [{'name': B['rows'][r][0], 'y': B['yrow'][r],
                      'x0': min(it[0] for it in B['placed'][r]),
                      'cells': [(x, c, i['name'] if i else None) for x, c, i in B['placed'][r]]} for r in range(len(B['rows']))],
            'channels': {c: {'y': B['ych'][c], 'h': B['heights'][c], 'tracks': B['chans'][c]['ntr'], 'nets': len(B['chans'][c]['nets'])}
                         for c in B['chans']},
            'columns': {n: v[0] for n, v in B['ft'].items()}, 'jumpers': len(B['jumpers']),
            'pin_and_splice_columns': {n: v[0] for n, v in B['ext_cols'].items()}}

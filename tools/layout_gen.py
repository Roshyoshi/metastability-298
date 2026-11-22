#!/usr/bin/env python3
"""Physical layout of the whole tile, generated from the master netlist.

Architecture (all coordinates in um, written to GDS in nm):
  * standard cells (GF180 mcu7t5v0, 3.92 um rows) placed in rows; every row starts and ends with an
    endcap; filltie well/substrate taps at most every 25 um; filltie gap columns under the power stripes
  * routing channels between rows: pins reach a channel through Metal2 escapes (Via1 on the cell pin);
    Metal3 trunks run along channel tracks; Metal4 columns connect channels and reach the template pins
  * Metal4 power stripes VDPWR/VGND (2 um) from y = 5 um to 320.36 um; Via1-Via3 stacks tie each row's
    Metal1 rails to the stripes inside the filltie gap columns
  * the delay line's current-starved stage is a custom cell (meta_dly_cs) derived from inv_1, whose
    PMOS/NMOS have exactly the delay line's MP/MN sizes; the starving NMOS MC is added in series and the
    timing capacitor MCT (an NMOS gate capacitor) sits on the slow node
"""
import sys, math, json, itertools, re
from collections import defaultdict, OrderedDict, Counter
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import build_master as BM
import lefparse as LP
import gds

CHIP = Path(__file__).resolve().parent.parent
SC = LP.SC
# Pin positions of the 1x2 analog tile, from TinyTapeout/tt-support-tools:
# tech/gf180mcuD/def/analog/tt_analog_1x2.def
TT_DEF = LP.ext_path('TT_ANALOG_DEF', "tt-support-tools' tech/gf180mcuD/def/analog/tt_analog_1x2.def")
LIB = BM.LIB
SITE, ROWH = 0.56, 3.92
TILE_W, TILE_H = 346.64, 325.36
EPS = 1e-6

# ------------------------------------------------------------------ layer map (GF180MCU, design manual table 06)
L = {'COMP': (22, 0), 'NWELL': (21, 0), 'POLY': (30, 0), 'NPLUS': (32, 0), 'PPLUS': (31, 0), 'CONT': (33, 0),
     'M1': (34, 0), 'V1': (35, 0), 'M2': (36, 0), 'V2': (38, 0), 'M3': (42, 0), 'V3': (40, 0), 'M4': (46, 0),
     'DUALGATE': (55, 0), 'V5XTOR': (112, 1), 'LVPWELL': (204, 0), 'PRBND': (0, 0),
     'M1L': (34, 10), 'M2L': (36, 10), 'M3L': (42, 10), 'M4L': (46, 10)}

# ------------------------------------------------------------------ rules used by the generator (um)
R = {'M1w': 0.23, 'M1s': 0.23, 'Mw': 0.28, 'Ms': 0.28, 'V': 0.26, 'Vs': 0.26, 'Venc': 0.06, 'Marea': 0.1444,
     'PITCH': 0.56}
HV = R['V'] / 2              # half via
EXT = HV + R['Venc']         # metal extension past a via centre along a 0.28 wire (0.19)
HW = R['Mw'] / 2             # half wire (0.14)

def nm(v):
    return int(round(v * 1000))

def grid5(v):
    """Round down to the 5 nm manufacturing grid (um)."""
    return round(math.floor(v * 200 + 1e-6) / 200, 3)

# ------------------------------------------------------------------ instances from the master netlist
def instances():
    """Flat list of placed objects: dict(name, cell, conns{pin: net}, box). Nets are flat (hierarchy with '/')."""
    out = []
    for box, i in BM.TOP:
        out.append({'name': i['name'], 'cell': i['cell'].replace(LIB, ''), 'conns': dict(i['conns']), 'box': box.split(':')[0]})
    for box, name, sub, nets in BM.TOP_SUB:
        if sub.startswith('meta_dut'):
            pmap = dict(zip(['d', 'clk', 'q'], nets))
            for i in BM.DUT_SUBCKTS[sub]:
                conns = {p: pmap.get(n, f'{name}/{n}') for p, n in i['conns'].items()}
                out.append({'name': f'{name}/{i["name"]}', 'cell': i['cell'].replace(LIB, ''), 'conns': conns, 'box': box, 'dut': name})
        else:  # delay line: custom current-starved stage + three restorers
            pmap = dict(zip(['launch', 'control', 'sample_clk'], nets))
            out.append({'name': f'{name}/MCS', 'cell': 'meta_dly_cs', 'box': box, 'internal': {'slow': True},
                        'conns': {'launch': pmap['launch'], 'control': pmap['control'], 'slow': f'{name}/slow'}})
            for i in BM.DELAY_CELLS:
                conns = {p: pmap.get(n, f'{name}/{n}') for p, n in i['conns'].items()}
                extra = {'internal': {'I': True}, 'glue_prev': True} if i['name'] == 'XR0' else {}
                out.append({'name': f'{name}/{i["name"]}', 'cell': i['cell'].replace(LIB, ''), 'conns': conns, 'box': box, **extra})
    for i in BM.CTRL:
        conns = {p: BM.CTRL_MAP.get(n, n) for p, n in i['conns'].items()}
        conns = {p: ('VDPWR' if n == 'VDPWR' else n) for p, n in conns.items()}
        out.append({'name': f'controller/{i["name"]}', 'cell': i['cell'].replace(LIB, ''), 'conns': conns, 'box': i['box']})
    # controller-internal nets get a prefix so they cannot collide with front-end nets
    ctrl_ports = set(BM.CTRL_MAP.values())
    for o in out:
        if o['name'].startswith('controller/'):
            o['conns'] = {p: (n if (n in ctrl_ports or n in ('VDPWR', 'VGND')) else f'controller/{n}') for p, n in o['conns'].items()}
    return out

# ------------------------------------------------------------------ cell abstracts (LEF) + the custom cell
_LEF = {}
def lef(cell):
    if cell not in _LEF:
        if cell == 'meta_dly_cs':
            _LEF[cell] = DLY_LEF
        else:
            _LEF[cell] = LP.read_lef(cell)
    return _LEF[cell]

# meta_dly_cs: inv_1 geometry shifted right by 1.68 um, NMOS source becomes node foot, MC added on the left,
# timing capacitor MCT (NMOS gate capacitor, W/L = 0.82/1.0) added on the right
DLY_W = 6.16
DLY_LEF = {'w': DLY_W, 'h': ROWH, 'pins': {
    # antenna data as in the library LEFs: gate area = W x L of the gates on the pin, diff area = drain junctions
    'launch': {'polys': [('Metal1', [(2.39, 1.2), (2.715, 1.2), (2.715, 2.2), (2.39, 2.2)])], 'dir': 'INPUT', 'use': 'signal',
               'gate_area': 1.22 * 0.5 + 0.82 * 0.6, 'diff_area': 0.0},
    'control': {'polys': [('Metal1', [(1.09, 1.25), (1.43, 1.25), (1.43, 1.81), (1.09, 1.81)])], 'dir': 'INPUT', 'use': 'signal',
                'gate_area': 0.36 * 0.6, 'diff_area': 0.0},
    'slow': {'polys': [('Metal1', [(2.945, 0.53), (3.275, 0.53), (3.275, 3.39), (2.945, 3.39)]),
                       ('Metal1', [(4.81, 1.25), (5.15, 1.25), (5.15, 1.81), (4.81, 1.81)])], 'dir': 'OUTPUT', 'use': 'signal',
             'gate_area': 0.82 * 1.0, 'diff_area': 0.8976},
}, 'obs': []}

def build_dly_cell():
    """GDS cell meta_dly_cs (nm). Returns gds.Cell."""
    src = gds.read(SC / 'inv' / f'{LIB}inv_1.gds').cells[f'{LIB}inv_1']
    c = gds.Cell('meta_dly_cs')
    S = 1680; W = 6160
    full = {L['NWELL']: (-430, 1760, W + 430, 4350), L['LVPWELL']: (-430, -430, W + 430, 1760),
            L['DUALGATE']: (-280, -280, W + 280, 4200), L['NPLUS']: (-200, -200, W + 200, 1760),
            L['PPLUS']: (-200, 1760, W + 200, 4120), L['V5XTOR']: (0, 0, W, 3920), L['PRBND']: (0, 0, W, 3920)}
    for (ly, dt), r in full.items():
        c.rect(ly, dt, *r)
    for ly, dt, pts in src.polys:
        if (ly, dt) in full:
            continue
        if (ly, dt) == L['CONT'] and gds.bbox(pts) == (250, 735, 470, 955):
            continue                               # NMOS source contact of inv_1: becomes the internal node foot
        if (ly, dt) == L['M1'] and gds.bbox(pts)[1] == -300:
            continue                               # VSS rail with stub to the removed contact: redrawn below
        c.polys.append((ly, dt, [(x + S, y) for x, y in pts]))
    # VSS rail across the whole cell, plus a stub to the MC source contact
    c.rect(*L['M1'], 0, -300, W, 300)
    c.rect(*L['M1'], 530, 300, 870, 690)
    # VDD rail extension to the left edge (inv_1's VDD polygon was shifted and starts at x = 1680)
    c.rect(*L['M1'], 0, 3620, S + 10, 4220)
    # MC: narrow diffusion (W = 0.36 um) joined to the NMOS diffusion, L = 0.6 um gate, source contact, gate contact
    c.rect(*L['COMP'], 520, 340, 1860, 700)
    c.rect(*L['POLY'], 960, 120, 1560, 1710)
    c.rect(*L['CONT'], 590, 410, 810, 630)
    c.rect(*L['CONT'], 1150, 1420, 1370, 1640)
    c.rect(*L['M1'], 1090, 1250, 1430, 1810)
    # MCT: timing capacitor. NMOS W = 0.82 um (same diffusion height as inv_1's NMOS), L = 1.0 um; gate on slow
    # (contacted above the diffusion), source and drain contacted and strapped to the VSS rail
    c.rect(*L['COMP'], 4040, 340, 5920, 1160)
    c.rect(*L['POLY'], 4480, 120, 5480, 1710)
    c.rect(*L['CONT'], 4110, 735, 4330, 955)
    c.rect(*L['CONT'], 5630, 735, 5850, 955)
    c.rect(*L['CONT'], 4870, 1420, 5090, 1640)
    c.rect(*L['M1'], 4810, 1250, 5150, 1810)
    c.rect(*L['M1'], 4050, 300, 4390, 1015)
    c.rect(*L['M1'], 5570, 300, 5910, 1015)
    c.rect(*L['M1'], 3900, 3620, W, 4220)              # VDD rail over the capacitor section
    for name, (x, y) in {'launch': (2550, 1700), 'control': (1260, 1530), 'slow': (3110, 1960), 'VDD': (1960, 3920), 'VSS': (1960, -80)}.items():
        c.text(*L['M1L'], x, y, name, 0.2)
    return c

# ------------------------------------------------------------------ floorplan: rows
X_LEFT = 150.08          # row start (site grid: 3.36 + 0.56 k)
X_RIGHT = 316.4          # row end
TAP_MAX = 25.0           # max cell run between well/substrate taps
def _snap(x):
    return round(round((x - 3.36) / 0.56) * 0.56 + 3.36, 3)
GAP_W = 6.72                                              # 12 sites of filltie under each stripe pair
GAPS = [(g, round(g + GAP_W, 3)) for g in (_snap(153.5), _snap(230.0), round(X_RIGHT - 1.12 - GAP_W, 3))]
STRIPE_W = 2.0
STRIPES = []                                              # (x_left, x_right, net)
for ga, gb in GAPS:
    STRIPES += [(round(ga + 0.84, 3), round(ga + 0.84 + STRIPE_W, 3), 'VDPWR'), (round(ga + 3.88, 3), round(ga + 3.88 + STRIPE_W, 3), 'VGND')]

def snap(x):
    return _snap(x)

def row_plan(insts):
    """Assign instances to rows in order. Returns list of rows, each a list of instance dicts (order = left to right)."""
    by = {i['name']: i for i in insts}
    rows = []
    # F1: front-end services, delay line at the right end (close to ua[0] at x = 327 um)
    f1 = ['monitor_early_b', 'monitor_early_a', 'monitor_capture_b', 'monitor_capture_a', 'data0', 'data1',
          'u_dut1', 'select_dut', 'early_observer', 'cap0', 'cap1', 'iso0', 'iso1', 'ant_ctrl',
          'delay/MCS', 'delay/XR0', 'delay/XR1', 'delay/XR2']
    rows.append(('F1', [by[n] for n in f1]))
    dut_order = ['u_cki', 'u_mg1', 'u_mg2', 'u_mfw', 'u_mkp', 'u_sg1', 'u_sg2', 'u_sfw', 'u_skp']
    for d in ['u_dut2', 'u_dut3', 'u_dut4']:
        rows.append((d, [by[f'{d}/{c}'] for c in dut_order]))
    # controller: flow box order, connectivity-ordered inside each box, packed into rows
    ctrl = [i for i in insts if i['name'].startswith('controller/')]
    order = []
    # Bottom to top, using the flow boxes of build_master.CTRL_BLOCKS: the
    # readings sit next to the front end that feeds them, the readout under
    # the uo_out pins at the top edge.
    boxes = ['Late observers + compare', 'Sequencer', 'Counter N', 'Status', 'Counter K', 'Readout']
    unplaced = sorted({i['box'] for i in ctrl} - set(boxes))
    if unplaced:
        raise ValueError(f'controller flow boxes with no row order: {unplaced}')
    for box in boxes:
        members = [i for i in ctrl if i['box'] == box]
        order += connectivity_order(members)
    rows += pack_rows(order, 'C')
    # top row: the output-pin drivers (tie-low cells, ena buffers), right under the pins they drive
    pins = [by[i['name']] for i in BM.PIN_DRIVERS]
    pins.sort(key=lambda i: PIN_X.get(next(n for p, n in i['conns'].items() if p in ('Z', 'ZN')), 0))
    for i in pins:
        i['align'] = 'left'          # their pins (uio_oe, uio_out) are left of the core
    rows.append(('P1', pins))
    return rows

def _pin_x():
    import re as _re
    t = TT_DEF.read_text()
    out = {}
    for n, x1, x2, px in _re.findall(r'- (\S+) \+ NET \S+ \+ DIRECTION \S+.*?LAYER \S+ \( (-?\d+) -?\d+ \) \( (-?\d+) -?\d+ \)\s+\+ PLACED \( (\d+) \d+ \)', t, _re.S):
        out[n] = (int(px) + (int(x1) + int(x2)) / 2) / 2000
    return out
PIN_X = _pin_x()

def connectivity_order(members):
    """Greedy chain: start from the first flip-flop, repeatedly take the unplaced cell sharing most nets."""
    if not members:
        return []
    nets = {i['name']: set(n for n in i['conns'].values() if n not in ('VDPWR', 'VGND')) for i in members}
    left = {i['name']: i for i in members}
    start = next((i for i in members if 'dff' in i['cell']), members[0])
    seq = [start]; del left[start['name']]
    while left:
        last = nets[seq[-1]['name']]
        recent = set().union(*[nets[s['name']] for s in seq[-4:]])
        best = max(left.values(), key=lambda i: (len(nets[i['name']] & last) * 2 + len(nets[i['name']] & recent), -list(left).index(i['name'])))
        seq.append(best); del left[best['name']]
    return seq

def row_capacity():
    """Usable cell length of a full row: between the endcaps, minus the gap columns."""
    return (X_RIGHT - 1.12) - (X_LEFT + 1.12) - sum(b - a for a, b in GAPS)

def pack_rows(order, prefix):
    cap = row_capacity() * 0.80
    rows, cur, used = [], [], 0.0
    for i in order:
        w = lef(i['cell'])['w']
        if used + w > cap and cur:
            rows.append((f'{prefix}{len(rows) + 1}', cur)); cur, used = [], 0.0
        cur.append(i); used += w
    if cur:
        rows.append((f'{prefix}{len(rows) + 1}', cur))
    return rows

def fill_to(items, x, target, tie=True):
    """Fill [x, target) with fillties (1.12 um) and, for an odd site, one fill_1 (0.56 um)."""
    while x + 1.12 <= target + EPS:
        items.append((round(x, 3), 'filltie' if tie else 'fill_2', None)); x += 1.12
    if x + 0.56 <= target + EPS:
        items.append((round(x, 3), 'fill_1', None)); x += 0.56
    return x

def _layout(cells, x):
    """Lay out from x; return (items, x_end_of_last_cell)."""
    items = [(round(x, 3), 'endcap', None)]; x += 1.12
    since = 0.0
    for inst in cells:
        w = lef(inst['cell'])['w']
        moved = True
        while moved:
            moved = False
            for ga, gb in GAPS:
                if x < gb - EPS and x + w > ga + EPS:
                    x = fill_to(items, x, ga)
                    x = fill_to(items, x, gb)
                    since = 0.0; moved = True
            if since + w > TAP_MAX and not inst.get('glue_prev'):
                items.append((round(x, 3), 'filltie', None)); x += 1.12; since = 0.0; moved = True
        items.append((round(x, 3), inst['cell'], inst)); x += w; since += w
    return items, x

def row_start(cells):
    """Right-align: the last cell ends at (or just before) the right gap column."""
    if cells and cells[0].get('align') == 'left':
        return X_LEFT
    target = GAPS[-1][0]
    x = X_LEFT
    for _ in range(60):
        items, end = _layout(cells, x)
        if end > target + EPS:
            raise RuntimeError('row too long')
        shift = _snap(target - end + 3.36) - 3.36
        if shift < SITE - EPS:
            return x
        x = round(x + shift, 3)
        items, end2 = _layout(cells, x)
        if end2 > target + EPS:      # moving right pushed a cell across a gap column: step back
            x = round(x - shift, 3)
            return x
    return x

def place_row(cells):
    """x positions: endcap | cells with filltie taps (<= TAP_MAX apart) | filltie gap columns | endcap.
    Returns list of (x, cell, inst or None)."""
    items, x = _layout(cells, row_start(cells))
    x = fill_to(items, x, X_RIGHT - 1.12)
    items.append((round(x, 3), 'endcap', None))
    return items

# ------------------------------------------------------------------ pin access (Via1 + Metal2 escape) per row
def pin_rects(cell, pin):
    return [r for lay, pts in lef(cell)['pins'][pin]['polys'] if lay == 'Metal1' for r in LP.poly_to_rects(pts)]

def via_candidates(rects, step=0.02):
    """Via1 centres (cell coordinates) legal inside the pin's Metal1: enclosure >= 0.06 on both sides of one axis."""
    cands = set()
    for x1, y1, x2, y2 in rects:
        w, h = x2 - x1, y2 - y1
        if w + EPS >= 2 * HV and h + EPS >= 2 * HV + 2 * R['Venc']:      # vertical strip: enclosed top/bottom
            cx = grid5((x1 + x2) / 2)
            ys = [y1 + HV + R['Venc'] + k * step for k in range(int((h - 2 * HV - 2 * R['Venc']) / step + EPS) + 1)]
            cands |= {(cx, round(y, 3)) for y in ys}
        if h + EPS >= 2 * HV and w + EPS >= 2 * HV + 2 * R['Venc']:      # horizontal strip: enclosed left/right
            cy = grid5((y1 + y2) / 2)
            xs = [x1 + HV + R['Venc'] + k * step for k in range(int((w - 2 * HV - 2 * R['Venc']) / step + EPS) + 1)]
            cands |= {(round(x, 3), cy) for x in xs}
    return sorted(cands)

def access_row(placed, pref):
    """Choose a via and an escape direction for every signal pin in a row so that all Metal2 escapes keep
    0.28 um spacing. pref(net) -> 'up' | 'down' preferred direction. Returns {(inst, pin): (x, y, dir)} in
    row coordinates (x absolute, y relative to the row bottom)."""
    pins = []
    for x0, cell, inst in placed:
        if inst is None:
            continue
        for p, net in inst['conns'].items():
            if lef(cell)['pins'].get(p, {}).get('use', 'signal') != 'signal':
                continue
            if inst.get('internal', {}).get(p):
                continue
            cands = [(x0 + cx, cy) for cx, cy in via_candidates(pin_rects(cell, p))]
            if not cands:
                raise RuntimeError(f'no via position on {inst["name"]}.{p}')
            pins.append({'key': (inst['name'], p), 'net': net, 'cands': cands})
    # order candidates: preferred direction first, then via near the middle of the pin
    TOPY, BOTY = ROWH + 0.6, -0.6
    def shape(c, d):
        x, y = c
        y1, y2 = (y - EXT, TOPY) if d == 'up' else (BOTY, y + EXT)
        return (x - HW, y1, x + HW, y2)
    def clash(a, b):
        gx = max(a[0], b[0]) - min(a[2], b[2]); gy = max(a[1], b[1]) - min(a[3], b[3])
        if gx >= R['Ms'] - EPS or gy >= R['Ms'] - EPS:
            return False
        if gx > 0 and gy > 0 and math.hypot(gx, gy) >= R['Ms'] - EPS:
            return False
        return True
    options = []
    for p in pins:
        d0 = pref(p['net'])
        mid = sum(c[1] for c in p['cands']) / len(p['cands']), sum(c[0] for c in p['cands']) / len(p['cands'])
        opts = []
        for d in ([d0, 'down' if d0 == 'up' else 'up']):
            for c in sorted(p['cands'], key=lambda c: abs(c[1] - mid[0]) + abs(c[0] - mid[1])):
                opts.append((c, d, shape(c, d)))
        options.append(opts)
    order = sorted(range(len(pins)), key=lambda k: min(c[0] for c in pins[k]['cands']))
    choice = {}
    # neighbours that can interact (x ranges within 0.6 um)
    xr = [(min(c[0] for c in p['cands']) - HW, max(c[0] for c in p['cands']) + HW) for p in pins]
    near = {k: [j for j in range(len(pins)) if j != k and xr[j][0] - 0.6 < xr[k][1] and xr[k][0] - 0.6 < xr[j][1]] for k in range(len(pins))}
    sys.setrecursionlimit(10000)
    def ok(k, opt):
        for j in near[k]:
            if j in choice and pins[j]['net'] != pins[k]['net'] and clash(opt[2], choice[j][2]):
                return False
        return True
    def solve(idx):
        if idx == len(order):
            return True
        k = order[idx]
        for opt in options[k]:
            if ok(k, opt):
                choice[k] = opt
                if solve(idx + 1):
                    return True
                del choice[k]
        return False
    if not solve(0):
        raise RuntimeError('pin access failed in a row')
    return {pins[k]['key']: (choice[k][0][0], choice[k][0][1], choice[k][1]) for k in choice}, {pins[k]['key']: pins[k]['net'] for k in choice}

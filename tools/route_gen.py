#!/usr/bin/env python3
"""Routing for the tile: pin escapes (Metal2), channel trunks (Metal3), columns (Metal4), pins, power.

Channel c lies between row c-1 and row c (channel 0 under the bottom row, channel N above the top row).
A net enters a channel through terminals: 'B' (a Metal2 escape rising from the row below), 'T' (an escape
coming down from the row above) or 'F' (a Via3 to a Metal4 column: a chip pin, a stripe, or a feedthrough to
another channel). Each net gets one Metal3 trunk per channel, on one track, spanning its terminals.
Constraints: trunks on one track do not overlap; where a 'T' escape of net A and a 'B' escape of net B are
closer than 0.56 um in x, A's track must be at least two tracks above B's (so the two Metal2 escapes keep
0.28 um apart).
"""
import sys, re, json, math
from collections import defaultdict, OrderedDict, Counter
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import layout_gen as LG
from layout_gen import R, EXT, HW, HV, EPS, ROWH

PITCH = 0.56
TRACK0 = 0.84               # first track above the channel bottom (clears the Via-stack pads on the rails)
MINLEN = 0.52               # shortest Metal3 trunk: 0.28 x 0.52 = 0.1456 um2 >= Mn.3 (0.1444 um2)

def g5(v, up=False):
    """Snap to the 5 nm manufacturing grid."""
    k = v / 0.005
    return round((math.ceil(k - 1e-6) if up else math.floor(k + 1e-6)) * 0.005, 3)

def trunk_x(xs):
    """x extent of a Metal3 trunk joining via centres xs (via enclosure at the ends, minimum area)."""
    a, b = min(xs) - EXT, max(xs) + EXT
    if b - a < MINLEN - EPS:
        a = g5((a + b) / 2 - MINLEN / 2); b = round(a + MINLEN, 3)
    return round(a, 3), round(b, 3)
DEF = LG.TT_DEF

def template_pins():
    t = DEF.read_text()
    pins = {}
    for n, d, l, x1, y1, x2, y2, px, py in re.findall(
            r'- (\S+) \+ NET \S+ \+ DIRECTION (\S+).*?LAYER (\S+) \( (-?\d+) (-?\d+) \) \( (-?\d+) (-?\d+) \)\s+\+ PLACED \( (\d+) (\d+) \)', t, re.S):
        x1, y1, x2, y2, px, py = [int(v) / 2000 for v in (x1, y1, x2, y2, px, py)]
        pins[n] = (px + x1, py + y1, px + x2, py + y2, d)
    return pins

TIES = {}      # constant outputs are driven by tie-low / buffer cells (build_master.PIN_DRIVERS), not by metal ties

def plan():
    insts = LG.instances()
    rows = LG.row_plan(insts)
    nrows = len(rows)
    placed = [LG.place_row(cells) for _, cells in rows]
    tp = template_pins()
    # net -> rows of its cell pins
    netrows = defaultdict(list)
    for r, (_, cells) in enumerate(rows):
        for inst in cells:
            for p, n in inst['conns'].items():
                if n in ('VDPWR', 'VGND') or inst.get('internal', {}).get(p):
                    continue
                netrows[n].append(r)
    chip_pin_nets = {}
    for pin in tp:
        if pin in netrows:
            chip_pin_nets[pin] = pin
    for pin, net in TIES.items():
        chip_pin_nets[pin] = net
    def pref_for(r):
        def pref(net):
            others = [x for x in netrows[net] if x != r]
            if net in chip_pin_nets.values():
                others.append(-1 if net == 'ua[0]' else nrows)
            if not others:
                return 'up'
            avg = sum(others) / len(others)
            return 'up' if avg >= r else 'down'
        return pref
    access = {}
    for r, items in enumerate(placed):
        acc, nets = LG.access_row(items, pref_for(r))
        for k, (x, y, d) in acc.items():
            access[k] = (r, x, y, d, nets[k])
    # terminals per channel
    term = defaultdict(lambda: defaultdict(list))    # chan -> net -> [(x, side, info)]
    for (iname, pin), (r, x, y, d, net) in access.items():
        if len(netrows[net]) < 2 and net not in chip_pin_nets.values():
            continue
        c = r + 1 if d == 'up' else r
        term[c][net].append((x, 'B' if d == 'up' else 'T', (iname, pin, r, y)))
    top = nrows
    for pin, net in chip_pin_nets.items():
        x1, y1, x2, y2, d = tp[pin]
        xc = round((x1 + x2) / 2, 3)
        if pin == 'ua[0]':
            term[0][net].append((xc, 'F', ('pin', pin)))
        else:
            term[top][net].append((xc, 'F', ('pin', pin)))
    vgnd_stripe = [s for s in LG.STRIPES if s[2] == 'VGND'][0]
    term[top]['VGND'].append((round((vgnd_stripe[0] + vgnd_stripe[1]) / 2, 3), 'F', ('stripe', 'VGND')))
    return dict(insts=insts, rows=rows, placed=placed, access=access, term=term, nrows=nrows, tp=tp, chip_pin_nets=chip_pin_nets)

# ------------------------------------------------------------------ Metal4 columns for nets that use several channels
def m4_blocked(x, w=0.28):
    for a, b, net in LG.STRIPES:
        if x + w / 2 > a - R['Ms'] - EPS and x - w / 2 < b + R['Ms'] + EPS:
            return True
    return False

def assign_feedthroughs(P):
    term, nrows, tp = P['term'], P['nrows'], P['tp']
    nets_ch = defaultdict(set)
    for c, nets in term.items():
        for n in nets:
            nets_ch[n].add(c)
    cols = defaultdict(list)          # x -> [(cmin, cmax)]
    # pin drops and ua[0] occupy their columns in the top / bottom channel
    reserved = []
    for pin, (x1, y1, x2, y2, d) in tp.items():
        reserved.append(((x1 + x2) / 2, x2 - x1, nrows if y1 > 100 else 0))
    ft = {}
    for net in sorted(nets_ch, key=lambda n: -(max(nets_ch[n]) - min(nets_ch[n]))):
        S = nets_ch[net]
        if len(S) < 2:
            continue
        lo, hi = min(S), max(S)
        xs = sorted(x for c in S for x, side, info in term[c][net])
        xm = xs[len(xs) // 2]
        best = None
        for k in range(0, 400):
            for sgn in (1, -1):
                x = round(round((xm - 0.28) / PITCH) * PITCH + 0.28 + sgn * k * PITCH, 3)
                if x < 10 or x > LG.TILE_W - 10 or m4_blocked(x):
                    continue
                if any(abs(x - rx) < (rw + 0.28) / 2 + R['Ms'] + EPS and lo <= rc <= hi for rx, rw, rc in reserved):
                    continue
                if any(not (hi < a or lo > b) for a, b in cols[x]):
                    continue
                best = x; break
            if best is not None:
                break
        cols[best].append((lo, hi))
        ft[net] = (best, lo, hi)
        for c in S:
            term[c][net].append((best, 'F', ('ft', net)))
    P['cols'] = cols
    P['reserved'] = reserved
    return ft

# ------------------------------------------------------------------ channel track assignment
class CycleError(Exception):
    pass

def free_column(P, c, xm):
    for k in range(0, 600):
        for sgn in (1, -1):
            x = round(round((xm - 0.28) / PITCH) * PITCH + 0.28 + sgn * k * PITCH, 3)
            if x < 10 or x > LG.TILE_W - 10 or m4_blocked(x):
                continue
            if any(abs(x - rx) < (rw + 0.28) / 2 + R['Ms'] + EPS and rc == c for rx, rw, rc in P['reserved']):
                continue
            if any(not (c < a or c > b) for a, b in P['cols'][x]):
                continue
            return x
    raise RuntimeError('no free Metal4 column')

def assign_tracks(nets, force=()):
    """nets: {net: [(x, side, info)]}. Returns ({net: level}, n_tracks); level 0 = top track.
    Nets in `force` are placed as high as their constraints allow (pin drops that sit over a power stripe)."""
    span = {n: trunk_x([x for x, s, i in t]) for n, t in nets.items()}
    above = defaultdict(set)          # net -> nets that must be above it (by >= 2 tracks)
    tops = [(x, n) for n, t in nets.items() for x, s, i in t if s == 'T']
    bots = [(x, n) for n, t in nets.items() for x, s, i in t if s == 'B']
    for xa, a in tops:
        for xb, b in bots:
            if a != b and abs(xa - xb) < 2 * HW + R['Ms'] - EPS:
                above[b].add(a)
    level = {}
    remaining = set(nets)
    L = 0
    while remaining:
        ready = [n for n in remaining if all(a in level and level[a] <= L - 2 for a in above[n])]
        if not ready:
            if L > 4 * len(nets) + 10:
                cyc = sorted(remaining)[:6]
                raise CycleError(sorted(remaining))
            L += 1
            continue
        ready.sort(key=lambda n: (n not in force, span[n][0]))
        chosen = []
        for n in ready:
            a, b = span[n]
            if all(a >= cb + R['Ms'] - EPS or b <= ca - R['Ms'] + EPS for ca, cb in chosen):
                level[n] = L; chosen.append((a, b)); remaining.discard(n)
        L += 1
    ntr = max(level.values()) + 1 if level else 1
    return level, ntr

def route():
    P = plan()
    ft = assign_feedthroughs(P)
    chans = {}
    P['jumpers'] = []                 # (channel, x, net_a, net_b): Metal4 jumper joining two trunks of one net
    for c in range(P['nrows'] + 1):
        nets = {n: list(t) for n, t in P['term'][c].items() if t}
        force = set()
        if c == P['nrows']:
            for pin, net in P['chip_pin_nets'].items():
                x1, y1, x2, y2, d = P['tp'][pin]
                if pin != 'ua[0]' and any(x2 > a - R['Ms'] and x1 < b + R['Ms'] for a, b, n in LG.STRIPES):
                    force.add(net)
        P['force_top'] = force if c == P['nrows'] else P.get('force_top', set())
        for attempt in range(60):
            try:
                level, ntr = assign_tracks(nets, force) if nets else ({}, 1)
                break
            except CycleError as e:
                stuck = e.args[0]
                # split a stuck net that has both T and B terminals into two trunks joined by a Metal4 jumper
                cand = [n for n in stuck if {'T', 'B'} <= {s_ for x, s_, i in nets[n]}]
                if not cand:
                    raise RuntimeError(f'cannot resolve vertical constraints in channel {c}: {stuck[:5]}')
                n = max(cand, key=lambda n: len(nets[n]))
                xs = sorted(x for x, s_, i in nets[n])
                xj = free_column(P, c, xs[len(xs) // 2])
                P['cols'][xj].append((c, c))
                t_part = [t for t in nets[n] if t[1] != 'B'] + [(xj, 'F', ('jumper', n))]
                b_part = [t for t in nets[n] if t[1] == 'B'] + [(xj, 'F', ('jumper', n))]
                del nets[n]
                nets[n + '#T'] = t_part; nets[n + '#B'] = b_part
                P['jumpers'].append((c, xj, n + '#T', n + '#B'))
        else:
            raise RuntimeError(f'channel {c}: too many splits')
        chans[c] = {'nets': nets, 'level': level, 'ntr': ntr}
    P['ft'] = ft; P['chans'] = chans
    return P

if __name__ == '__main__':
    P = route()
    tot = 0
    for c, ch in P['chans'].items():
        print(f'channel {c:2d}: {len(ch["nets"]):3d} nets, {ch["ntr"]:2d} tracks')
        tot += ch['ntr']
    print('feedthrough columns:', len(P['ft']), ' jumpers:', len(P['jumpers']), ' total tracks', tot)

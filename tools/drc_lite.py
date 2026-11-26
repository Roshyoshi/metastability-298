#!/usr/bin/env python3
"""Checks on everything the generator draws on top of the foundry standard cells, plus a connectivity
comparison against the netlist.

Geometry (GF180MCU design manual, tables 22 and 23):
  grid      every coordinate on the 5 nm manufacturing grid
  Mn.1      width   Metal1 0.23, Metal2-4 0.28
  Mn.2a     space   Metal1 0.23, Metal2-4 0.28 (Euclidean, any nets, notches included)
  Mn.3      area    0.1444 um2 per merged shape
  Vn.1      via size exactly 0.26 x 0.26
  Vn.2a     via space 0.26
  Vn.3/4    via enclosure: >= 0.00 (Metal1) / 0.01 (Metal2-4) on every side, and where a side is < 0.04 the
            two adjacent sides >= 0.06
  short     overlapping or touching shapes of different nets
  M1 strap  the delay line's Metal1 strap against all other Metal1 of the two cells it touches
Connectivity: union of all routing shapes, cell pins (LEF Metal1), cell rails (LEF power pins) and template
pins; every component must carry exactly one net, and every net with two or more terminals must be one
component.
"""
import sys, math, json
from collections import defaultdict
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import chip_gds as CG
import layout_gen as LG
import lefparse as LP
import gds
from layout_gen import L, ROWH, EPS

MIN_W = {'M1': 0.23, 'M2': 0.28, 'M3': 0.28, 'M4': 0.28}
MIN_S = {'M1': 0.23, 'M2': 0.28, 'M3': 0.28, 'M4': 0.28, 'V1': 0.26, 'V2': 0.26, 'V3': 0.26}
VIA = {'V1': ('M1', 'M2'), 'V2': ('M2', 'M3'), 'V3': ('M3', 'M4')}
MIN_AREA = 0.1444

class Index:
    def __init__(self, rects, cell=4.0):
        self.cell = cell; self.b = defaultdict(list); self.rects = rects
        for k, r in enumerate(rects):
            for bx in range(int(r[0] // cell), int(r[2] // cell) + 1):
                for by in range(int(r[1] // cell), int(r[3] // cell) + 1):
                    self.b[(bx, by)].append(k)
    def near(self, r, d=0.5):
        out = set()
        for bx in range(int((r[0] - d) // self.cell), int((r[2] + d) // self.cell) + 1):
            for by in range(int((r[1] - d) // self.cell), int((r[3] + d) // self.cell) + 1):
                out.update(self.b.get((bx, by), ()))
        return out

def gap(a, b):
    gx = max(a[0], b[0]) - min(a[2], b[2]); gy = max(a[1], b[1]) - min(a[3], b[3])
    return gx, gy

def touching(a, b):
    gx, gy = gap(a, b)
    return gx <= EPS and gy <= EPS and not (abs(gx) < EPS and abs(gy) < EPS)   # corner-only contact is not a join

def dist(a, b):
    gx, gy = gap(a, b)
    if gx <= 0 and gy <= 0:
        return 0.0
    return math.hypot(max(gx, 0), max(gy, 0))

def union_area(rects):
    xs = sorted({r[0] for r in rects} | {r[2] for r in rects})
    area = 0.0
    for xa, xb in zip(xs[:-1], xs[1:]):
        iv = sorted((r[1], r[3]) for r in rects if r[0] <= xa + EPS and r[2] >= xb - EPS)
        tot, cur = 0.0, None
        for a, b in iv:
            if cur is None or a > cur[1]:
                if cur: tot += cur[1] - cur[0]
                cur = [a, b]
            else:
                cur[1] = max(cur[1], b)
        if cur: tot += cur[1] - cur[0]
        area += tot * (xb - xa)
    return area

def all_rows(P):
    """(row key, placed items, y of the row) for the existing rows and the rows of the flip-flop bank."""
    rows = [(r, items, P['yrow'][r]) for r, items in enumerate(P['placed'])]
    if 'bank' in P:
        rows += [(('bank', r), items, P['bank']['yrow'][r]) for r, items in enumerate(P['bank']['placed'])]
    return rows

def collect(P):
    """All shapes as (layer, x1, y1, x2, y2, net, tag). tag: 'route', ('pin', inst, pin), ('rail', row, net), ('chip', pin)."""
    shapes = []
    for layer, rects in P['shapes'].r.items():
        for x1, y1, x2, y2, net in rects:
            shapes.append((layer, x1, y1, x2, y2, net, 'route'))
    for r, items, yb in all_rows(P):
        for x0, cell, inst in items:
            lf = LG.lef(cell)
            for pin, info in lf['pins'].items():
                if info['use'] in ('POWER', 'GROUND') or pin in ('VDD', 'VSS', 'VNW', 'VPW'):
                    net = 'VDPWR' if (info['use'] == 'POWER' or pin in ('VDD', 'VNW')) else 'VGND'
                    for lay, pts in info['polys']:
                        if lay == 'Metal1':
                            for a, b, c, d in LP.poly_to_rects(pts):
                                shapes.append(('M1', round(x0 + a, 3), round(yb + b, 3), round(x0 + c, 3), round(yb + d, 3), net, ('rail', r, net)))
                    continue
                if inst is None or pin not in inst['conns']:
                    continue
                net = inst['conns'][pin]
                for a, b, c, d in LG.pin_rects(cell, pin):
                    shapes.append(('M1', round(x0 + a, 3), round(yb + b, 3), round(x0 + c, 3), round(yb + d, 3), net, ('pin', inst['name'], pin)))
    for pin, net, (x1, y1, x2, y2) in P['pins_drawn']:
        shapes.append(('M4', x1, y1, x2, y2, net, ('chip', pin)))
    # the Via1 of a bank block under each escape that starts on it (drawn in the block, not by the generator)
    for x1, y1, x2, y2, net in P.get('bank', {}).get('block_vias', []):
        shapes.append(('V1', x1, y1, x2, y2, net, 'route'))
    return shapes

def check_geometry(P, shapes):
    viol = []
    def v(kind, layer, r, msg):
        viol.append({'kind': kind, 'layer': layer, 'at': [round(t, 3) for t in r[:4]], 'msg': msg})
    by = defaultdict(list)
    for s in shapes:
        by[s[0]].append(s)
    # grid, width, via size: generator shapes only (cell pins are the foundry's)
    for s in shapes:
        if s[6] != 'route':
            continue
        layer, x1, y1, x2, y2, net = s[:6]
        for c in (x1, y1, x2, y2):
            if abs(c * 200 - round(c * 200)) > 1e-6:
                v('grid', layer, s[1:5], f'{c} off the 5 nm grid'); break
        if layer in VIA:
            if abs(x2 - x1 - 0.26) > EPS or abs(y2 - y1 - 0.26) > EPS:
                v('via size', layer, s[1:5], f'{x2 - x1:.3f} x {y2 - y1:.3f}')
        elif min(x2 - x1, y2 - y1) < MIN_W[layer] - EPS:
            v('width', layer, s[1:5], f'{min(x2 - x1, y2 - y1):.3f} < {MIN_W[layer]} ({net})')
    # spacing and shorts per layer (Metal1: only the generator's own Metal1 against everything)
    for layer, ss in by.items():
        rects = [s[1:5] for s in ss]
        idx = Index(rects)
        for k, s in enumerate(ss):
            if layer == 'M1' and s[6] != 'route':
                continue
            for j in idx.near(s[1:5], 0.4):
                if j <= k and not (layer == 'M1'):
                    continue
                if j == k:
                    continue
                t = ss[j]
                if layer == 'M1' and t[6] == 'route' and j < k:
                    continue
                d = dist(s[1:5], t[1:5])
                gx, gy = gap(s[1:5], t[1:5])
                overl = gx <= EPS and gy <= EPS
                if overl:
                    if s[5] != t[5] and not (abs(gx) < EPS and abs(gy) < EPS and gx > -EPS and gy > -EPS):
                        v('short', layer, s[1:5], f'{s[5]} touches {t[5]} at {t[1:5]}')
                    continue
                if d < MIN_S[layer] - EPS:
                    v('space', layer, s[1:5], f'{d:.3f} < {MIN_S[layer]}: {s[5]} / {t[5]} at {t[1:5]}')
    # via enclosure: the via grown by (0.06, floor) or by (floor, 0.06) must be covered by the merged metal
    idx_by = {layer: Index([t[1:5] for t in ss]) for layer, ss in by.items()}
    def covered(box, ml):
        parts = []
        for j in idx_by[ml].near(box, 0.01):
            t = by[ml][j][1:5]
            a = (max(box[0], t[0]), max(box[1], t[1]), min(box[2], t[2]), min(box[3], t[3]))
            if a[2] > a[0] + EPS and a[3] > a[1] + EPS:
                parts.append((a, by[ml][j][5]))
        if not parts:
            return False, set()
        area = union_area([a for a, n in parts])
        return area >= (box[2] - box[0]) * (box[3] - box[1]) - 1e-9, {n for a, n in parts}
    for vl, (lo, hi) in VIA.items():
        for s in by.get(vl, []):
            vr = s[1:5]
            for ml in (lo, hi):
                floor = 0.0 if ml == 'M1' else 0.01
                ok = False; nets = set()
                for ex, ey in ((0.06, floor), (floor, 0.06)):
                    box = (vr[0] - ex, vr[1] - ey, vr[2] + ex, vr[3] + ey)
                    c, n_ = covered(box, ml)
                    nets |= n_
                    ok = ok or c
                if not ok:
                    v('enclosure', vl, vr, f'{ml} does not enclose the via by 0.06 on two opposite sides and {floor} on the others ({s[5]})')
                if nets - {s[5]}:
                    v('short', vl, vr, f'via of {s[5]} touches {ml} of {sorted(nets - {s[5]})}')
    # minimum area per merged same-layer group (generator shapes)
    for layer in ('M2', 'M3', 'M4'):
        ss = by.get(layer, [])
        rects = [s[1:5] for s in ss]
        idx = Index(rects)
        parent = list(range(len(ss)))
        def f(a):
            while parent[a] != a:
                parent[a] = parent[parent[a]]; a = parent[a]
            return a
        for k, s in enumerate(ss):
            for j in idx.near(s[1:5], 0.01):
                if j > k:
                    gx, gy = gap(s[1:5], ss[j][1:5])
                    if gx <= EPS and gy <= EPS:
                        parent[f(j)] = f(k)
        groups = defaultdict(list)
        for k in range(len(ss)):
            groups[f(k)].append(ss[k][1:5])
        for g in groups.values():
            if max((r[2] - r[0]) * (r[3] - r[1]) for r in g) >= MIN_AREA - 1e-9:
                continue
            a = union_area(g)
            if a < MIN_AREA - 1e-9:
                v('area', layer, g[0], f'{a:.4f} < {MIN_AREA}')
    return viol

def check_strap(P):
    """The delay line's Metal1 strap against the flattened Metal1 of the two cells it joins."""
    out = []
    straps = [s for s in P['shapes'].r['M1']]
    lib = gds.Library('chk')
    lib.add(LG.build_dly_cell())
    for name, cell in gds.read(LG.LP.cell_dir('inv_1') / f'{LG.LIB}inv_1.gds').cells.items():
        lib.add(cell)
    for r, items in enumerate(P['placed']):
        for k, (x, cell, inst) in enumerate(items):
            if cell != 'meta_dly_cs':
                continue
            xr0 = items[k + 1][0]; yb = P['yrow'][r]
            polys = [(x, 'meta_dly_cs', 'slow'), (xr0, LG.LIB + 'inv_1', 'I')]
            for st in straps:
                srect = st[:4]
                for x0, cname, conn_pin in polys:
                    pin_rects = [(x0 + a, yb + b, x0 + c, yb + d) for a, b, c, d in
                                 LG.pin_rects('meta_dly_cs' if cname == 'meta_dly_cs' else 'inv_1', conn_pin)]
                    for lay, dt, pts in lib.cells[cname].polys:
                        if (lay, dt) != L['M1']:
                            continue
                        for a, b, c, d in LP.poly_to_rects([(px / 1000, py / 1000) for px, py in pts]):
                            rr = (x0 + a, yb + b, x0 + c, yb + d)
                            same = any(dist(rr, pr) == 0 and gap(rr, pr)[0] < 0 and gap(rr, pr)[1] < 0 for pr in pin_rects)
                            dd = dist(srect, rr)
                            if same:
                                continue
                            if dd < 0.23 - EPS:
                                out.append({'kind': 'M1 strap', 'at': [round(t, 3) for t in rr], 'msg': f'{dd:.3f} from the strap ({cname})'})
    return out

def connectivity(P, shapes):
    n = len(shapes)
    parent = list(range(n))
    def f(a):
        while parent[a] != a:
            parent[a] = parent[parent[a]]; a = parent[a]
        return a
    def u(a, b):
        ra, rb = f(a), f(b)
        if ra != rb:
            parent[ra] = rb
    by = defaultdict(list)
    for k, s in enumerate(shapes):
        by[s[0]].append(k)
    idxs = {layer: Index([shapes[k][1:5] for k in ks]) for layer, ks in by.items()}
    for layer, ks in by.items():
        idx = idxs[layer]
        for a_i, k in enumerate(ks):
            for b_i in idx.near(shapes[k][1:5], 0.01):
                j = ks[b_i]
                if j > k and touching(shapes[k][1:5], shapes[j][1:5]):
                    u(k, j)
    for vl, (lo, hi) in VIA.items():
        for k in by.get(vl, []):
            for ml in (lo, hi):
                if ml not in idxs:
                    continue
                for b_i in idxs[ml].near(shapes[k][1:5], 0.01):
                    j = by[ml][b_i]
                    gx, gy = gap(shapes[k][1:5], shapes[j][1:5])
                    if gx < -EPS and gy < -EPS:
                        u(k, j)
    comps = defaultdict(list)
    for k in range(n):
        comps[f(k)].append(k)
    problems = []
    net_comps = defaultdict(set)
    for c, ks in comps.items():
        nets = {shapes[k][5] for k in ks}
        terms = [shapes[k][6] for k in ks if shapes[k][6] != 'route']
        if len(nets) > 1:
            problems.append({'kind': 'short', 'nets': sorted(nets)[:8], 'n_shapes': len(ks)})
        for nt in nets:
            if terms:
                net_comps[nt].add(c)
    # expected terminals per net
    expect = defaultdict(set)
    for r, items, yb in all_rows(P):
        for x0, cell, inst in items:
            if inst is None:
                continue
            for pin, net in inst['conns'].items():
                if pin in LG.lef(cell)['pins'] and LG.lef(cell)['pins'][pin]['use'] == 'signal':
                    expect[net].add(('pin', inst['name'], pin))
    for pin, net, rect in P['pins_drawn']:
        expect[net].add(('chip', pin))
    found = defaultdict(set)
    for c, ks in comps.items():
        for k in ks:
            if shapes[k][6] != 'route' and shapes[k][6][0] in ('pin', 'chip'):
                found[c].add(shapes[k][6])
    term_comp = {}
    for c, ts in found.items():
        for t in ts:
            term_comp[t] = c
    opens = []
    for net, ts in expect.items():
        if net in ('VDPWR', 'VGND'):
            continue
        cs = {term_comp.get(t) for t in ts}
        if len(ts) >= 2 and len(cs) > 1:
            opens.append({'kind': 'open', 'net': net, 'pieces': len(cs), 'terminals': len(ts)})
    # power: every row's rails reach the stripes, VDPWR and VGND never meet
    pw = defaultdict(set)
    for c, ks in comps.items():
        for k in ks:
            t = shapes[k][6]
            if t != 'route' and t[0] == 'rail':
                pw[(t[1], t[2])].add(c)
    stripe_comp = {}
    for k, s in enumerate(shapes):
        if s[0] == 'M4' and s[6] == 'route' and s[5] in ('VDPWR', 'VGND') and (s[3] - s[2]) > 100 or False:
            pass
    for net in ('VDPWR', 'VGND'):
        cs = set()
        for (r, nn), c in pw.items():
            if nn == net:
                cs |= c
        if len(cs) > 1:
            opens.append({'kind': 'power open', 'net': net, 'pieces': len(cs)})
    return problems, opens, len(comps)

# ------------------------------------------------------------------ antenna (design manual table 27/28)
T_METAL = 0.54          # Metal1-4 thickness: "perimeter area" = perimeter x thickness
MF_THICK = 15           # ANT.16: thick (5 V) gate, diffusion multiplying factor

def union_perimeter(rects):
    xs = sorted({r[0] for r in rects} | {r[2] for r in rects})
    def cover(xa, xb):
        iv = sorted((r[1], r[3]) for r in rects if r[0] <= xa + EPS and r[2] >= xb - EPS)
        out = []
        for a, b in iv:
            if out and a <= out[-1][1] + EPS:
                out[-1][1] = max(out[-1][1], b)
            else:
                out.append([a, b])
        return out
    def length(iv):
        return sum(b - a for a, b in iv)
    def symdiff(i1, i2):
        pts = sorted({p for a, b in i1 + i2 for p in (a, b)})
        tot = 0.0
        for a, b in zip(pts[:-1], pts[1:]):
            m = (a + b) / 2
            in1 = any(x <= m <= y for x, y in i1); in2 = any(x <= m <= y for x, y in i2)
            if in1 != in2:
                tot += b - a
        return tot
    per, prev = 0.0, []
    for xa, xb in zip(xs[:-1], xs[1:]):
        cur = cover(xa, xb)
        per += 2 * len(cur) * (xb - xa) + symdiff(prev, cur)
        prev = cur
    per += length(prev)
    return per

def antenna(P, shapes):
    """Per process step (Metal1..Metal4, Via1..Via3): metal connected to a gate through the layers made so far,
    against that gate's area (plus 15x any diffusion already connected)."""
    order = ['M1', 'V1', 'M2', 'V2', 'M3', 'V3', 'M4']
    pinfo = {}
    for r, items, yb in all_rows(P):
        for x0, cell, inst in items:
            if inst is None:
                continue
            for pin, info in LG.lef(cell)['pins'].items():
                pinfo[(inst['name'], pin)] = (info.get('gate_area', 0.0), info.get('diff_area', 0.0))
    results = []
    for step in range(len(order)):
        layer = order[step]
        if layer == 'M1':
            continue                        # Metal1 of the cells is the foundry's; ours is the 4 um delay strap
        upto = set(order[:step + 1])
        ks = [k for k, s in enumerate(shapes) if s[0] in upto]
        parent = {k: k for k in ks}
        def f(a):
            while parent[a] != a:
                parent[a] = parent[parent[a]]; a = parent[a]
            return a
        by = defaultdict(list)
        for k in ks:
            by[shapes[k][0]].append(k)
        idx = {l: Index([shapes[k][1:5] for k in v]) for l, v in by.items()}
        for l, v in by.items():
            for k in v:
                for b in idx[l].near(shapes[k][1:5], 0.01):
                    j = v[b]
                    if j > k and touching(shapes[k][1:5], shapes[j][1:5]):
                        parent[f(j)] = f(k)
        for vl, (lo, hi) in VIA.items():
            if vl not in upto:
                continue
            for k in by.get(vl, []):
                for ml in (lo, hi):
                    if ml not in by:
                        continue
                    for b in idx[ml].near(shapes[k][1:5], 0.01):
                        j = by[ml][b]
                        gx, gy = gap(shapes[k][1:5], shapes[j][1:5])
                        if gx < -EPS and gy < -EPS:
                            parent[f(j)] = f(k)
        comp = defaultdict(list)
        for k in ks:
            comp[f(k)].append(k)
        for c, members in comp.items():
            gate = diff = 0.0; seen = set(); net = None
            for k in members:
                t = shapes[k][6]
                if t != 'route' and t[0] == 'pin' and (t[1], t[2]) not in seen:
                    seen.add((t[1], t[2]))
                    g_, d_ = pinfo.get((t[1], t[2]), (0.0, 0.0))
                    gate += g_; diff += d_
                net = shapes[k][5]
            if gate <= 0:
                continue
            eff = gate + MF_THICK * diff if diff > 0 else gate
            mine = [shapes[k][1:5] for k in members if shapes[k][0] == layer]
            if not mine:
                continue
            if layer.startswith('V'):
                val = sum((r[2] - r[0]) * (r[3] - r[1]) for r in mine) / eff
                lim = 20.0
            else:
                val = union_perimeter(mine) * T_METAL / eff
                lim = 400.0
            results.append({'step': layer, 'net': net, 'ratio': round(val, 1), 'limit': lim, 'gate_um2': round(gate, 3),
                            'diff_um2': round(diff, 3)})
    return results

def run():
    P = CG.build()
    shapes = collect(P)
    geo = check_geometry(P, shapes)
    strap = check_strap(P)
    shorts, opens, ncomp = connectivity(P, shapes)
    ant = antenna(P, shapes)
    return P, shapes, geo, strap, shorts, opens, ncomp, ant

if __name__ == '__main__':
    P, shapes, geo, strap, shorts, opens, ncomp, ant = run()
    from collections import Counter
    print('shapes:', len(shapes), ' components:', ncomp)
    print('geometry violations:', len(geo), Counter((g['kind'], g['layer']) for g in geo))
    for g in geo[:25]:
        print('  ', g)
    print('M1 strap:', len(strap), strap[:5])
    print('shorts:', len(shorts), shorts[:5])
    print('opens:', len(opens), opens[:10])
    bad = [a for a in ant if a['ratio'] > a['limit']]
    worst = sorted(ant, key=lambda a: -a['ratio'] / a['limit'])[:8]
    print('antenna: checked', len(ant), 'net/step pairs, over the limit:', len(bad))
    for a in worst:
        print('   ', a)
    out = LG.CHIP / 'layout' / 'drc_lite_report.json'
    out.write_text(json.dumps({'geometry': geo, 'strap': strap, 'shorts': shorts, 'opens': opens,
                               'antenna_over': bad, 'antenna_worst': worst}, indent=1))

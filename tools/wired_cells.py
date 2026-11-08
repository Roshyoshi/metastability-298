#!/usr/bin/env python3
"""Transistor-level cell schematics drawn with real wires (the way a CMOS gate is drawn in a textbook).

For each standard cell:
  * the transistors are split into stages (groups joined through drain/source, rails excluded) and the stages
    are placed left to right in signal order;
  * inside a stage the PMOS hang from VDD at the top and the NMOS stand on ground at the bottom: series
    transistors are stacked, parallel ones sit side by side;
  * every source/drain on VDD or ground gets a supply symbol; every body gets a short wire to its supply;
  * every other net (internal nodes, gates, the cell's ports) is drawn as wires found by a grid maze router
    (wires may cross; a crossing is not a connection; joins are made only at wire ends);
  * the result is checked by netlisting the wires back (tools/sch_check.py) against the cell netlist.
"""
import heapq, sys
from collections import defaultdict, OrderedDict
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))

G = 10                      # routing grid (Xschem units)
RAIL_P = {'VDD', 'VNW'}
RAIL_N = {'VSS', 'VPW'}
COLW, ROWH = 200, 150       # transistor pitch inside a stage
STAGE_GAP = 160

# MOSFET symbol pins (PDK nfet_06v0 / pfet_06v0): nfet D top, S bottom; pfet S top, D bottom; G left; B right
PIN = {'nfet': {'top': (20, -30), 'g': (-20, 0), 'bot': (20, 30), 'b': (20, 0)},
       'pfet': {'top': (20, -30), 'g': (-20, 0), 'bot': (20, 30), 'b': (20, 0)}}

def is_rail(n):
    return n in RAIL_P or n in RAIL_N

# ------------------------------------------------------------------ placement
def stages(devs):
    parent = {}
    def f(a):
        parent.setdefault(a, a)
        while parent[a] != a:
            parent[a] = parent[parent[a]]; a = parent[a]
        return a
    for k, d in enumerate(devs):
        f(('t', k))
        for n in (d['d'], d['s']):
            if not is_rail(n):
                parent[f(('t', k))] = f(('n', n))
    groups = defaultdict(list)
    for k in range(len(devs)):
        groups[f(('t', k))].append(k)
    return list(groups.values())

def order_stages(devs, groups, inputs):
    nodes = [{n for k in g for n in (devs[k]['d'], devs[k]['s']) if not is_rail(n)} for g in groups]
    gates = [{devs[k]['g'] for k in g} for g in groups]
    feeds = {i: {j for j in range(len(groups)) if j != i and nodes[i] & gates[j]} for i in range(len(groups))}
    placed, order = set(), []
    while len(order) < len(groups):
        cand = [i for i in range(len(groups)) if i not in placed]
        def score(i):
            unmet = sum(1 for j in cand if j != i and i in feeds[j])
            ext = len(gates[i] & set(inputs))
            return (unmet, -ext, i)
        i = min(cand, key=score)
        order.append(i); placed.add(i)
    return [groups[i] for i in order]

def depth_from(devs, ks, rails):
    adj = defaultdict(list)
    for k in ks:
        a, b = devs[k]['d'], devs[k]['s']
        adj[a].append(b); adj[b].append(a)
    dist = {}
    frontier = [n for n in adj if n in rails]
    for n in frontier:
        dist[n] = 0
    while frontier:
        nxt = []
        for n in frontier:
            for m in adj[n]:
                if m not in dist:
                    dist[m] = dist[n] + 1; nxt.append(m)
        frontier = nxt
    return dist

def place_stage(devs, ks, x0):
    """Returns ({k: (x, y, top_net, bot_net)}, width, (pdepth, ndepth))."""
    P = [k for k in ks if devs[k]['model'].startswith('p')]
    N = [k for k in ks if devs[k]['model'].startswith('n')]
    dp, dn = depth_from(devs, P, RAIL_P), depth_from(devs, N, RAIL_N)
    info = {}
    for k in P:
        a, b = devs[k]['d'], devs[k]['s']
        da, db = dp.get(a), dp.get(b)
        if da is None and db is None:
            info[k] = (None, a, b)                       # floating (transmission-gate) PMOS
        elif db is not None and (da is None or db <= da):
            info[k] = (db, b, a)                         # row, top (toward VDD), bottom
        else:
            info[k] = (da, a, b)
    for k in N:
        a, b = devs[k]['d'], devs[k]['s']
        da, db = dn.get(a), dn.get(b)
        if da is None and db is None:
            info[k] = (None, a, b)
        elif db is not None and (da is None or db <= da):
            info[k] = (db, a, b)                         # row (from ground), top, bottom (toward ground)
        else:
            info[k] = (da, b, a)
    return info, P, N

def layout_cell(devs, inputs, outputs):
    groups = order_stages(devs, stages(devs), inputs)
    if all('rank' in d for d in devs):          # caller fixed the stage order (e.g. functional order of a flip-flop)
        groups.sort(key=lambda g: min(devs[k]['rank'] for k in g))
    infos = {}
    for g in groups:
        info, P, N = place_stage(devs, g, 0)
        infos.update(info)
    maxp = max([infos[k][0] for k in infos if devs[k]['model'].startswith('p') and infos[k][0] is not None] + [0])
    maxn = max([infos[k][0] for k in infos if devs[k]['model'].startswith('n') and infos[k][0] is not None] + [0])
    ytop = 0
    ytg_p = ytop + ROWH * (maxp + 1) + 40            # floating transistors sit between the networks
    ytg_n = ytg_p + ROWH
    ybot = ytg_n + 40 + ROWH * (maxn + 1)
    pos = {}
    x = 140
    for g in groups:
        P = [k for k in g if devs[k]['model'].startswith('p')]
        N = [k for k in g if devs[k]['model'].startswith('n')]
        cols = {}                                        # (kind,row) -> next col
        colof = {}
        ncol = 0
        def put(k, kind, row, prefer=None):
            nonlocal ncol
            used = {c for (kk, (c, kd, rw)) in colof.items() if kd == kind and rw == row}
            c = prefer if (prefer is not None and prefer not in used) else 0
            while c in used:
                c += 1
            colof[k] = (c, kind, row)
            ncol = max(ncol, c + 1)
        for kind, lst in (('p', P), ('n', N)):
            rooted = sorted([k for k in lst if infos[k][0] is not None], key=lambda k: infos[k][0])
            for k in rooted:
                row, top, bot = infos[k]
                prefer = None
                for kk, (c, kd, rw) in colof.items():
                    if kd == kind and rw == row - 1:
                        if kind == 'p' and infos[kk][2] == top:
                            prefer = c
                        if kind == 'n' and infos[kk][1] == bot:
                            prefer = c
                put(k, kind, row, prefer)
        # match N columns to the P column driving the same output where possible (left alignment is fine)
        floating = [k for k in g if infos[k][0] is None]
        fcol = ncol
        for k in floating:
            kind = 'p' if devs[k]['model'].startswith('p') else 'n'
            used = {c for (kk, (c, kd, rw)) in colof.items() if kd == 'f' + kind}
            c = fcol
            while c in used:
                c += 1
            colof[k] = (c, 'f' + kind, 0)
            ncol = max(ncol, c + 1)
        for k, (c, kind, row) in colof.items():
            xx = x + COLW * c
            if kind == 'p':
                yy = ytop + ROWH * row + 60
            elif kind == 'n':
                yy = ybot - ROWH * row - 60
            elif kind == 'fp':
                yy = ytg_p + 30
            else:
                yy = ytg_n + 30
            pos[k] = (xx, yy)
        x += COLW * max(ncol, 1) + STAGE_GAP
    return pos, infos, (x, ybot + 120)

# ------------------------------------------------------------------ routing
class Grid:
    def __init__(self, w, h):
        self.W, self.H = w // G + 8, h // G + 8
        self.block = set()                 # points no wire may enter
        self.pinnet = {}                   # point -> net (pins / wire ends / bends / joins)
        self.use = {}                      # (point, 'H'|'V') -> net

    def free_for(self, p, net):
        return p not in self.block and self.pinnet.get(p, net) == net

def neighbors(p):
    x, y = p
    return [((x + 1, y), 'H'), ((x - 1, y), 'H'), ((x, y + 1), 'V'), ((x, y - 1), 'V')]

def route_net(grid, net, terms):
    """terms: grid points. Connects them into a tree. Returns list of unit edges."""
    terms = list(dict.fromkeys(terms))
    tree = {terms[0]}
    edges = []
    rest = sorted(terms[1:], key=lambda t: abs(t[0] - terms[0][0]) + abs(t[1] - terms[0][1]))
    for t in rest:
        if t in tree:
            continue
        # Dijkstra from t to any tree point; state (point, dir)
        start = (t, None)
        dist = {start: 0}
        prev = {}
        pq = [(0, 0, t, None)]
        goal = None
        cnt = 0
        while pq:
            c, _, p, d = heapq.heappop(pq)
            if dist.get((p, d), 1e18) < c:
                continue
            if p in tree and p != t:
                goal = (p, d); break
            for q, nd in neighbors(p):
                if not (0 <= q[0] < grid.W and 0 <= q[1] < grid.H):
                    continue
                if not grid.free_for(q, net):
                    continue
                if grid.use.get((p, nd), net) != net or grid.use.get((q, nd), net) != net:
                    continue
                bend = d is not None and nd != d
                # bending at p is not allowed where another net crosses p
                if bend and any(grid.use.get((p, dd), net) != net for dd in 'HV'):
                    continue
                # cannot end/turn on a point that another net passes through: handled at the goal by the tree check
                other = 1 if grid.use.get((q, 'H' if nd == 'V' else 'V'), net) != net else 0
                if other and q in tree:
                    continue
                # keep a free track between parallel wires of different nets where possible (room for names)
                if nd == 'H':
                    near = [((q[0], q[1] + 1), 'H'), ((q[0], q[1] - 1), 'H')]
                else:
                    near = [((q[0] + 1, q[1]), 'V'), ((q[0] - 1, q[1]), 'V')]
                hug = sum(1 for k in near if grid.use.get(k, net) != net)
                nc = c + 1 + (6 if bend else 0) + 4 * other + 2 * hug
                if nc < dist.get((q, nd), 1e18):
                    dist[(q, nd)] = nc; prev[(q, nd)] = (p, d)
                    cnt += 1
                    heapq.heappush(pq, (nc, cnt, q, nd))
        if goal is None:
            raise RuntimeError(f'cannot route net {net}')
        # walk back
        path = [goal]
        while path[-1] in prev:
            path.append(prev[path[-1]])
        pts = [s[0] for s in path]
        dirs = [s[1] for s in path]
        for a, b in zip(pts[:-1], pts[1:]):
            dirn = 'H' if a[1] == b[1] else 'V'
            edges.append((a, b))
            grid.use[(a, dirn)] = net; grid.use[(b, dirn)] = net
        # mark ends, bends and the join as nodes of this net
        grid.pinnet[pts[0]] = net; grid.pinnet[pts[-1]] = net
        for i in range(1, len(pts) - 1):
            d1 = 'H' if pts[i - 1][1] == pts[i][1] else 'V'
            d2 = 'H' if pts[i][1] == pts[i + 1][1] else 'V'
            if d1 != d2:
                grid.pinnet[pts[i]] = net
        tree |= set(pts)
    return edges

def segments(edges, keep):
    """Merge unit edges into straight wires, split at keep points, bends and junctions."""
    adj = defaultdict(set)
    for a, b in edges:
        adj[a].add(b); adj[b].add(a)
    node = set(keep)
    for p, ns in adj.items():
        if len(ns) != 2:
            node.add(p)
        else:
            a, b = list(ns)
            if not (a[0] == b[0] == p[0] or a[1] == b[1] == p[1]):
                node.add(p)
    segs, seen = [], set()
    for p in adj:
        if p not in node:
            continue
        for q in adj[p]:
            if (p, q) in seen:
                continue
            run = [p, q]
            while run[-1] not in node:
                nxt = [r for r in adj[run[-1]] if r != run[-2]][0]
                run.append(nxt)
            for a, b in zip(run[:-1], run[1:]):
                seen.add((a, b)); seen.add((b, a))
            segs.append((run[0], run[-1]))
    return segs

def wired_cell(devs, ports_in, ports_out, attrs_of):
    """devs: [{'name','d','g','s','b','model','w','l',...}]. Returns dict with instances, wires, symbols."""
    pos, infos, (W, H) = layout_cell(devs, ports_in, ports_out)
    grid = Grid(W + 400, H + 300)
    off = (20, 15)                         # grid offset so nothing sits on the border
    gp = lambda x, y: (x // G + off[0], y // G + off[1])
    inst, supplies = [], []
    terms = defaultdict(list)
    for k, d in enumerate(devs):
        x, y = pos[k]
        kind = 'pfet' if d['model'].startswith('p') else 'nfet'
        row, top, bot = infos[k]
        pins = {'top': top, 'bot': bot, 'g': d['g'], 'b': d['b']}
        dd = dict(d)
        if kind == 'nfet':
            dd['d'], dd['s'] = top, bot
        else:
            dd['s'], dd['d'] = top, bot
        inst.append((kind, x, y, dd))
        # block the symbol body
        for i in range(x // G - 2, x // G + 3):
            for j in range(y // G - 3, y // G + 4):
                grid.block.add((i + off[0], j + off[1]))
        for pn, (dx, dy) in PIN[kind].items():
            net = pins[pn]
            p = gp(x + dx, y + dy)
            grid.block.discard(p)
            if pn == 'b':
                sup = 'VDD' if kind == 'pfet' else '0'
                # body: short wire to the right, then the supply symbol
                supplies.append(((x + dx, y + dy), (x + dx + 30, y + dy), sup))
                for i in range(0, 4):
                    grid.block.add((p[0] + i, p[1]))
                grid.pinnet[p] = '__body'
                continue
            if is_rail(net):
                sup = 'VDD' if net in RAIL_P else '0'
                end = (x + dx, y + dy - 20) if pn == 'top' else (x + dx, y + dy + 20)
                supplies.append(((x + dx, y + dy), end, sup))
                q = gp(*end)
                for j in range(min(p[1], q[1]), max(p[1], q[1]) + 1):
                    grid.block.add((p[0], j))
                grid.pinnet[p] = '__rail'
                continue
            grid.pinnet[p] = net
            terms[net].append(p)
    # ports: inputs on the left edge, outputs on the right edge, spread over the height
    ports = []
    ymid = H // 2
    for i, n in enumerate(ports_in):
        y = (ymid - 40 * (len(ports_in) - 1) // 2 + 40 * i) // G * G
        ports.append(('ipin', -60, y, n))
    for i, n in enumerate(ports_out):
        y = (ymid - 40 * (len(ports_out) - 1) // 2 + 40 * i) // G * G
        ports.append(('opin', W + 40, y, n))
    for kind, x, y, n in ports:
        p = gp(x, y)
        grid.pinnet[p] = n
        terms[n].append(p)
    # route: nets with more terminals first, then longer spans; a net that fails moves to the front and all
    # nets are routed again on a clean grid
    import copy
    base_block, base_pin = set(grid.block), dict(grid.pinnet)
    order = sorted(terms, key=lambda n: (-len(terms[n]), -(max(t[0] for t in terms[n]) - min(t[0] for t in terms[n]))))
    for attempt in range(len(order) + 1):
        grid.block, grid.pinnet, grid.use = set(base_block), dict(base_pin), {}
        wires = []
        try:
            for n in order:
                if len(terms[n]) < 2:
                    continue
                edges = route_net(grid, n, terms[n])
                for a, b in segments(edges, set(terms[n])):
                    wires.append(((a[0] - off[0]) * G, (a[1] - off[1]) * G, (b[0] - off[0]) * G, (b[1] - off[1]) * G, n))
            break
        except RuntimeError as e:
            bad = str(e).split()[-1]
            order.remove(bad); order.insert(0, bad)
    else:
        raise RuntimeError('routing failed after reordering')
    return {'inst': inst, 'supplies': supplies, 'ports': ports, 'wires': wires, 'size': (W, H),
            'unconnected': [n for n in terms if len(terms[n]) < 2]}

# ------------------------------------------------------------------ gate level: cell boxes joined by wires
def route_all(grid, terms, off):
    base_block, base_pin = set(grid.block), dict(grid.pinnet)
    order = sorted(terms, key=lambda n: (-len(terms[n]), -(max(t[0] for t in terms[n]) - min(t[0] for t in terms[n]))))
    for attempt in range(len(order) + 1):
        grid.block, grid.pinnet, grid.use = set(base_block), dict(base_pin), {}
        wires = []
        try:
            for n in order:
                if len(terms[n]) < 2:
                    continue
                edges = route_net(grid, n, terms[n])
                for a, b in segments(edges, set(terms[n])):
                    wires.append(((a[0] - off[0]) * G, (a[1] - off[1]) * G, (b[0] - off[0]) * G, (b[1] - off[1]) * G, n))
            return wires
        except RuntimeError as e:
            bad = str(e).split()[-1]
            order.remove(bad); order.insert(0, bad)
    raise RuntimeError('routing failed after reordering')

def wired_symbols(syms, ports_in, ports_out):
    """syms: [{'x','y','x1','y1','x2','y2' (body, absolute), 'pins': {pin: (px, py) absolute}, 'conns': {pin: net}}].
    Returns {'ports': [...], 'wires': [...], 'size': (W, H)}."""
    W = max(s['x2'] for s in syms) + 120
    H = max(s['y2'] for s in syms) + 120
    grid = Grid(W + 600, H + 400)
    off = (30, 20)
    gp = lambda x, y: (x // G + off[0], y // G + off[1])
    terms = defaultdict(list)
    for s in syms:
        for i in range(s['x1'] // G - 1, s['x2'] // G + 2):
            for j in range(s['y1'] // G - 1, s['y2'] // G + 2):
                grid.block.add((i + off[0], j + off[1]))
        for p, (px, py) in s['pins'].items():
            q = gp(px, py)
            grid.block.discard(q)
            # the pin stub between body and pin end stays clear of other wires
            net = s['conns'][p]
            grid.pinnet[q] = net
            terms[net].append(q)
    ports = []
    ymid = H // 2
    for i, n in enumerate(ports_in):
        ports.append(('ipin', -160, (ymid - 40 * (len(ports_in) - 1) // 2 + 40 * i) // G * G, n))
    for i, n in enumerate(ports_out):
        ports.append(('opin', W + 80, (ymid - 40 * (len(ports_out) - 1) // 2 + 40 * i) // G * G, n))
    for kind, x, y, n in ports:
        q = gp(x, y); grid.pinnet[q] = n; terms[n].append(q)
    wires = route_all(grid, terms, off)
    return {'ports': ports, 'wires': wires, 'size': (W, H)}

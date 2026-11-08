#!/usr/bin/env python3
"""v3 gate-level sheets: each standard cell (or block) is a readable box with its name and type inside,
inputs on the left, outputs on the right, joined by real wires. Captions sit above the top row so they cross
nothing; important nets carry colours (via the .hl file) and a key. Pressing e on a box opens the cell's
transistor schematic (instance attribute schematic=...).
"""
import sys
from collections import defaultdict
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import wired_cells as WC
import xschem_gen as XG
import pretty as PR

G = WC.G
KIT = XG.CHIP / 'rounds' / 'round2' / 'kit'
PIN_SIZE = 0.2
NAME_SIZE = 0.3
TYPE_SIZE = 0.22

def pins_of(sympath):
    ins, outs = [], []
    for line in Path(sympath).read_text().splitlines():
        if line.startswith('B 5'):
            name = line.split('name=')[1].split()[0].rstrip('}')
            (outs if 'dir=out' in line else ins).append(name)
    return ins, outs

def gate_symbol(name, kind, ref, ins, outs, layer):
    """Box symbol; returns (text, pins {pin: (x, y)}, body (x1, y1, x2, y2))."""
    n = max(len(ins), len(outs), 1)
    pin_w = max([PR.tw(p, PIN_SIZE) for p in ins] + [0]) + max([PR.tw(p, PIN_SIZE) for p in outs] + [0])
    w = max(160, PR.tw(name, NAME_SIZE) + 30, PR.tw(ref, TYPE_SIZE) + 30, pin_w + 50)
    w = int((w + 19) // 20 * 20)
    h = 60 + 40 * (n - 1) + 50
    x1, x2 = -w // 2, w // 2
    y1 = -60
    y2 = y1 + h
    L = [f'L {layer} {x1} {y1} {x2} {y1} {{}}', f'L {layer} {x2} {y1} {x2} {y2} {{}}',
         f'L {layer} {x2} {y2} {x1} {y2} {{}}', f'L {layer} {x1} {y2} {x1} {y1} {{}}']
    pins = {}
    def py(i, cnt):
        return 10 + 40 * i + (20 * (n - cnt))
    for i, p in enumerate(ins):
        y = py(i, len(ins)) // 10 * 10
        L.append(f'L 4 {x1 - 20} {y} {x1} {y} {{}}')
        L.append(f'B 5 {x1 - 22.5} {y - 2.5} {x1 - 17.5} {y + 2.5} {{name={p} dir=in}}')
        L.append(f'T {{{p}}} {x1 + 5} {y - 7} 0 0 {PIN_SIZE} {PIN_SIZE} {{}}')
        pins[p] = (x1 - 20, y)
    for i, p in enumerate(outs):
        y = py(i, len(outs)) // 10 * 10
        L.append(f'L 4 {x2} {y} {x2 + 20} {y} {{}}')
        L.append(f'B 5 {x2 + 17.5} {y - 2.5} {x2 + 22.5} {y + 2.5} {{name={p} dir=out}}')
        L.append(f'T {{{p}}} {x2 - 5} {y - 7} 0 1 {PIN_SIZE} {PIN_SIZE} {{}}')
        pins[p] = (x2 + 20, y)
    L.append(f'T {{@name}} {x1 + 10} {y1 + 6} 0 0 {NAME_SIZE} {NAME_SIZE} {{}}')
    L.append(f'T {{{ref}}} {x1 + 10} {y1 + 28} 0 0 {TYPE_SIZE} {TYPE_SIZE} {{layer=13}}')
    txt = ('v {xschem version=3.4.4 file_version=1.2}\nG {}\nK {type=subcircuit\nformat="@name @pinlist ' + ref +
           '"\ntemplate="name=x1"\n}\nV {}\nS {}\nE {}\n' + '\n'.join(L) + '\n')
    return txt, pins, (x1, y1, x2, y2)

def gsheet(path, *a, **kw):
    last = None
    for gap in (170, 230, 290, 350, 420):
        try:
            return _gsheet(path, *a, colgap=gap, **kw)
        except RuntimeError as e:
            last = e
    raise last

def _gsheet(path, title, note, insts, ins, outs, cols, captions, colours=(), changed=(), labels=(), colgap=170):
    """insts: [(inst, kind 'cell'|'block', ref, conns)], cols: {inst: column}; captions: [(col, text, layer)]."""
    symdir = XG.CHIP / 'schematics_focus' / 'sym'
    symdir.mkdir(parents=True, exist_ok=True)
    made = {}
    for inst, kind, ref, conns in insts:
        src = KIT / ('cells_tx' if kind == 'cell' else 'blocks') / f'{ref}.sym'
        pi, po = pins_of(src)
        layer = 7 if inst in changed else 4
        txt, pins, body = gate_symbol(inst, kind, ref, pi, po, layer)
        sname = f'g_{path.stem[:3]}_{inst}.sym'
        (symdir / sname).write_text(txt)
        made[inst] = (sname, pins, body, f'@@ROOT@@/{"cells_tx" if kind == "cell" else "blocks"}/{ref}.sch')
    # columns
    colw = defaultdict(int)
    for inst, *_ in insts:
        b = made[inst][2]
        colw[cols[inst]] = max(colw[cols[inst]], b[2] - b[0] + 40)
    ncol = max(cols.values()) + 1
    colx, x = {}, 0
    for c in range(ncol):
        colx[c] = x + colw[c] // 2
        x += colw[c] + colgap
    coly = defaultdict(lambda: 0)
    syms, place = [], {}
    for inst, kind, ref, conns in insts:
        sname, pins, (bx1, by1, bx2, by2), sch = made[inst]
        c = cols[inst]
        xx = colx[c] // G * G
        yy = coly[c] - by1
        yy = int(yy // G * G)
        coly[c] = yy + by2 + 110
        place[inst] = (xx, yy)
        syms.append({'x1': xx + bx1, 'y1': yy + by1, 'x2': xx + bx2, 'y2': yy + by2,
                     'pins': {p: (xx + px, yy + py) for p, (px, py) in pins.items()},
                     'conns': {p: XG.san(conns[p]) for p in pins}})
    ins_s = [XG.san(n) for n in ins]; outs_s = [XG.san(n) for n in outs]
    # router (as WC.wired_symbols, but nothing may run above the top row or below the bottom one)
    W = max(s['x2'] for s in syms) + 200
    H = max(s['y2'] for s in syms) + 120
    grid = WC.Grid(W + 900, H + 500)
    off = (40, 20)
    gp = lambda x, y: (int(x // G) + off[0], int(y // G) + off[1])
    for i in range(grid.W):
        for j in range(grid.H):
            yy = (j - off[1]) * G
            if yy < -30 or yy > H:
                grid.block.add((i, j))
    terms = defaultdict(list)
    for s in syms:
        for i in range(int(s['x1'] // G) - 1, int(s['x2'] // G) + 2):
            for j in range(int(s['y1'] // G) - 1, int(s['y2'] // G) + 2):
                grid.block.add((i + off[0], j + off[1]))
        for p, (px, py) in s['pins'].items():
            q = gp(px, py)
            grid.block.discard(q)
            net = s['conns'][p]
            grid.pinnet[q] = net
            terms[net].append(q)
    xl, xr = -260, W
    ports = []
    ymid = H // 2
    def spread(k):
        return [int((ymid - 50 * (k - 1) // 2 + 50 * i) // G * G) for i in range(k)]
    for y, n in zip(spread(len(ins_s)), ins_s):
        ports.append(('ipin', xl, y, n))
    for y, n in zip(spread(len(outs_s)), outs_s):
        ports.append(('opin', xr, y, n))
    for kind, x, y, n in ports:
        q = gp(x, y); grid.block.discard(q); grid.pinnet[q] = n; terms[n].append(q)
        w = PR.tw(n, 0.33)
        rng = range(int(-(w + 30) // G), 0) if kind == 'ipin' else range(1, int((w + 30) // G) + 1)
        for i in rng:
            for j in (-1, 0, 1):
                grid.block.add((q[0] + i, q[1] + j))
    wires = WC.route_all(grid, {n: t for n, t in terms.items() if len(t) > 1}, off)
    # labels for coloured nets that are not ports
    R = {'wires': wires, 'stubs': [], 'ports': ports, 'pos': {}}
    want = [XG.san(n) for ns, _, _ in colours for n in ((ns,) if isinstance(ns, str) else ns)] + [XG.san(n) for n in labels]
    want = [n for n in dict.fromkeys(want) if n not in ins_s + outs_s]
    boxes = [(s['x1'] - 5, s['y1'] - 5, s['x2'] + 5, s['y2'] + 5) for s in syms]
    for kind, x, y, n in ports:
        w = PR.tw(n, 0.33)
        boxes.append((x - w - 25, y - 12, x, y + 12) if kind == 'ipin' else (x, y - 12, x + w + 25, y + 12))
    labs = []
    for net in want:
        w = PR.tw(net, PR.LAB_SIZE); h = PR.th(PR.LAB_SIZE)
        cands = []
        for x1, y1, x2, y2, n in wires:
            if n == net and y1 == y2:
                a, b = sorted((x1, x2)); xx = b - 10
                while xx - w - 6 >= a:
                    cands.append((xx, y1, (xx - 2.5 - w, y1 - 1.25 - h, xx - 2.5, y1 - 1.25))); xx -= 10
        ok = None
        for xx, yy, bb in cands:
            if any(n != net and PR.on_seg((xx, yy), (x1, y1, x2, y2)) for x1, y1, x2, y2, n in wires):
                continue
            if any(bb[0] < q[2] and q[0] < bb[2] and bb[1] < q[3] and q[1] < bb[3] for q in boxes):
                continue
            if any(min(x1, x2) < bb[2] and bb[0] < max(x1, x2) and min(y1, y2) < bb[3] and bb[1] < max(y1, y2) + 0.1
                   and not (n == net and y1 == y2 and abs(y1 - bb[3]) < 3) for x1, y1, x2, y2, n in wires):
                continue
            ok = (xx, yy, net); boxes.append(bb); PR.split(wires, xx, yy, net); break
        if ok is None:
            raise RuntimeError(f'{path.name}: no free place for the label of {net}')
        labs.append(ok)
    sh = PR.Sheet()
    for inst, kind, ref, conns in insts:
        sname, pins, body, sch = made[inst]
        x, y = place[inst]
        sh.inst(f'@@ROOT@@/sym/{sname}', x, y, f'name={inst} schematic={sch}')
    for x1, y1, x2, y2, n in wires:
        sh.wire(x1, y1, x2, y2, n)
    for kind, x, y, n in ports:
        sh.inst(f'devices/{kind}.sym', x, y, f'name=p_{n} lab={n}')
    for x, y, n in labs:
        sh.label('devices/lab_wire.sym', x, y, n)
    # captions above the top row, staggered so they never overlap
    ytop = min(s['y1'] for s in syms)
    rows_end, ys = [], []
    for c, text, layer in captions:
        xs = [s for (inst, *_), s in zip(insts, syms) if cols[inst] == c]
        a, b = min(s['x1'] for s in xs), max(s['x2'] for s in xs)
        w = PR.tw(text, PR.CAP_SIZE)
        lvl = 0
        while lvl < len(rows_end) and rows_end[lvl] > a - 20:
            lvl += 1
        if lvl == len(rows_end):
            rows_end.append(-1e9)
        rows_end[lvl] = max(b, a + w)
        y = ytop - 70 - 50 * lvl
        sh.line(a, y, b, y, layer); sh.line(a, y, a, y + 12, layer); sh.line(b, y, b, y + 12, layer)
        sh.text(text, a, y - PR.th(PR.CAP_SIZE) - 4, PR.CAP_SIZE, layer)
        ys.append(y)
    top_cap = min(ys + [ytop - 70]) - PR.th(PR.CAP_SIZE) - 10
    yt = top_cap - 30 - PR.th(0.24) * 1.35 * len(note)
    sh.text(title, xl - 80, yt - PR.th(0.45) - 16, 0.45)
    for i, s in enumerate(note):
        sh.text(s, xl - 80, yt + PR.th(0.24) * 1.35 * i, 0.24)
    y = max(s['y2'] for s in syms) + 90
    for ns, col, meaning in colours:
        ns = (ns,) if isinstance(ns, str) else ns
        xx = xl
        for net in ns:
            n = XG.san(net); w = max(100, PR.tw(n, PR.LAB_SIZE) + 30)
            sh.wire(xx, y, xx + w, y, n); sh.label('devices/lab_wire.sym', xx + w, y, n); xx += w + 20
        sh.text(meaning, xx + 10, y - PR.th(0.24) / 2 - 2, 0.24)
        y += 40
    sh.text('Each box is one cell (name, then cell type). Click a box and press e to see its transistors; Ctrl+e comes back. '
            'A dot marks a connection; wires that cross without a dot are not connected.', xl, y - 6, 0.2)
    path.write_text(sh.sch())
    path.with_suffix('.hl').write_text(''.join(f'{XG.san(n)} {PR.COLOUR[c]}\n' for ns, c, _ in colours
                                               for n in ((ns,) if isinstance(ns, str) else ns)))
    return len(insts)

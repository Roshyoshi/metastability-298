#!/usr/bin/env python3
"""Presentation transistor sheets (v3): compact, textbook layout, few labels, no overlapping text.

  * One VDD rail across the top and one VSS rail across the bottom, each named once. PMOS hang from VDD,
    NMOS stand on VSS; series transistors are stacked, parallel ones sit side by side. Transistor bodies are
    tied to the rails inside the symbol (3-terminal symbols sym/pmos3.sym, sym/nmos3.sym), so no body wires.
  * Each transistor shows only its pin letters and a short name (P1, N2, tp8, ...).
  * Groups of stages are marked by a bracket and caption ABOVE the VDD rail, so captions never cross wires.
  * Only important nets carry a name (on a wire, where the text touches nothing else); a few nets are given
    colours (clock, reset, storage nodes) with a key under the VSS rail. The colours are applied by Xschem's
    net highlight (the .hl file next to each sheet; view.sh / export_svg.sh apply it).
  * Every sheet is netlisted back and compared with the master netlist (check_focus.py), and drawn here by
    preview.py, which counts text-on-text, text-on-wire and wire-through-symbol collisions (must be zero).
"""
import sys
from collections import OrderedDict, defaultdict
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import wired_cells as WC
import xschem_gen as XG

G = WC.G
CW = 0.56
ROWH = 100
NAME_SIZE = 0.2
LAB_SIZE = 0.27
CAP_SIZE = 0.3
# Xschem highlight colour index -> layer 7 + i (dark scheme): 0 red, 1 yellow, 3 magenta, 4 green, 6 olive,
# 8 pink, 10 cyan-green, 13 salmon, 14 orange
COLOUR = {'orange': 14, 'yellow': 1, 'magenta': 3, 'green': 4, 'salmon': 13, 'pink': 8, 'cyan': 10, 'red': 0}

PMOS3 = """v {xschem version=3.4.4 file_version=1.2}
G {}
K {type=pmos
format="@spiceprefix@name @pinlist VDD @model L=@L W=@W nf=1 m=1"
template="name=M1 L=0.5u W=1u model=pfet_05v0 spiceprefix=X"
}
V {}
S {}
E {}
L 4 7.5 -22.5 7.5 22.5 {}
L 4 20 -30 20 -17.5 {}
L 4 20 17.5 20 30 {}
L 4 -2.5 -15 -2.5 15 {}
L 4 7.5 17.5 20 17.5 {}
L 4 12.5 -17.5 20 -17.5 {}
L 4 -20 0 -12.5 0 {}
B 5 17.5 27.5 22.5 32.5 {name=D dir=inout}
B 5 -22.5 -2.5 -17.5 2.5 {name=G dir=in}
B 5 17.5 -32.5 22.5 -27.5 {name=S dir=inout}
A 4 -7.5 0 5 180 360 {}
P 4 4 12.5 -20 7.5 -17.5 12.5 -15 12.5 -20 {fill=true}
T {D} 22.5 17.5 0 0 0.15 0.15 {layer=7}
T {S} 22.5 -17.5 2 1 0.15 0.15 {layer=7}
T {G} -12.5 -12.5 0 1 0.15 0.15 {layer=7}
T {@name} 30 -6 0 0 0.2 0.2 {}
"""
NMOS3 = """v {xschem version=3.4.4 file_version=1.2}
G {}
K {type=nmos
format="@spiceprefix@name @pinlist VSS @model L=@L W=@W nf=1 m=1"
template="name=M1 L=0.6u W=1u model=nfet_05v0 spiceprefix=X"
}
V {}
S {}
E {}
L 4 7.5 -22.5 7.5 22.5 {}
L 4 -20 0 -2.5 0 {}
L 4 20 -30 20 -17.5 {}
L 4 20 17.5 20 30 {}
L 4 -2.5 -15 -2.5 15 {}
L 4 7.5 -17.5 20 -17.5 {}
L 4 7.5 17.5 15 17.5 {}
B 5 17.5 -32.5 22.5 -27.5 {name=D dir=inout}
B 5 -22.5 -2.5 -17.5 2.5 {name=G dir=in}
B 5 17.5 27.5 22.5 32.5 {name=S dir=inout}
P 4 4 15 15 20 17.5 15 20 15 15 {fill=true}
T {S} 22.5 17.5 0 0 0.15 0.15 {layer=7}
T {D} 22.5 -17.5 2 1 0.15 0.15 {layer=7}
T {G} -10 -10 0 1 0.15 0.15 {layer=7}
T {@name} 30 -6 0 0 0.2 0.2 {}
"""

def tw(s, size):
    return len(s) * 52 * size * CW

def th(size, lines=1):
    return 52 * size * 1.147 * lines

class Sheet:
    def __init__(self):
        self.lines = []
        self.k = 0
    def text(self, s, x, y, size, layer=None, rot=0, flip=0):
        lay = f'layer={layer}' if layer is not None else ''
        self.lines.append(f'T {{{s}}} {x:g} {y:g} {rot} {flip} {size} {size} {{{lay}}}')
    def wire(self, x1, y1, x2, y2, net):
        self.lines.append(f'N {x1:g} {y1:g} {x2:g} {y2:g} {{lab={net}}}')
    def inst(self, sym, x, y, attrs, rot=0, flip=0):
        self.lines.append(f'C {{{sym}}} {x:g} {y:g} {rot} {flip} {{{attrs}}}')
    def label(self, sym, x, y, lab):
        self.k += 1
        self.inst(sym, x, y, f'name=l{self.k} lab={lab}')
    def line(self, x1, y1, x2, y2, layer, dash=False):
        self.lines.append(f'L {layer} {x1:g} {y1:g} {x2:g} {y2:g} {{{"dash=4" if dash else ""}}}')
    def sch(self):
        return 'v {xschem version=3.4.4 file_version=1.2}\nG {}\nK {}\nV {}\nS {}\nE {}\n' + '\n'.join(self.lines) + '\n'

# ------------------------------------------------------------------ placement
def columns(devs, g, infos):
    """Column per transistor inside one stage (series stacks share a column, parallel ones sit side by side)."""
    P = [k for k in g if devs[k]['model'].startswith('p')]
    N = [k for k in g if devs[k]['model'].startswith('n')]
    colof, ncol = {}, 0
    def put(k, kind, row, prefer=None):
        nonlocal ncol
        used = {c for kk, (c, kd, rw) in colof.items() if kd == kind and rw == row}
        c = prefer if (prefer is not None and prefer not in used) else 0
        while c in used:
            c += 1
        colof[k] = (c, kind, row); ncol = max(ncol, c + 1)
    for kind, lst in (('p', P), ('n', N)):
        rooted = sorted([k for k in lst if infos[k][0] is not None], key=lambda k: (infos[k][0], devs[k].get('order', 0)))
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
    fl = [k for k in g if infos[k][0] is None]
    for k in fl:
        kind = 'f' + devs[k]['model'][0]
        used = {c for kk, (c, kd, rw) in colof.items() if kd == kind}
        c = 0
        while c in used:
            c += 1
        colof[k] = (c, kind, 0); ncol = max(ncol, c + 1)
    return colof, max(ncol, 1)

def build(devs, ins, outs, names, sp):
    """sp: spacing dict (colw, gap, ch). Returns geometry dict or raises RuntimeError when routing fails."""
    groups = WC.order_stages(devs, WC.stages(devs), ins)
    if all('rank' in d for d in devs):
        groups.sort(key=lambda g: (min(devs[k]['rank'] for k in g), min(k for k in g)))
    infos = {}
    for g in groups:
        info, _, _ = WC.place_stage(devs, g, 0)
        infos.update(info)
    maxp = max([infos[k][0] for k in infos if devs[k]['model'][0] == 'p' and infos[k][0] is not None] + [0])
    maxn = max([infos[k][0] for k in infos if devs[k]['model'][0] == 'n' and infos[k][0] is not None] + [0])
    hasf = any(infos[k][0] is None for k in infos)
    ytop = 0
    p_bot = 60 + maxp * ROWH + 30
    ch = sp['ch'] + (100 if hasf else 0)
    n_top = p_bot + ch
    yg = n_top + 30 + maxn * ROWH + 60
    pos, stage_x = {}, []
    x = 0
    namew = max(tw(names[k], NAME_SIZE) for k in range(len(devs)))
    colw = max(sp['colw'], int((30 + namew + 50) // G * G + G))
    for g in groups:
        colof, ncol = columns(devs, g, infos)
        x0 = x
        for k, (c, kind, row) in colof.items():
            xx = x + colw * c
            if kind == 'p':
                yy = 60 + ROWH * row
            elif kind == 'n':
                yy = yg - 60 - ROWH * row
            elif kind == 'fp':
                yy = p_bot + ch // 2 - 50
            else:
                yy = p_bot + ch // 2 + 50
            pos[k] = (xx, yy)
        x += colw * ncol + sp['gap']
        stage_x.append((x0, x - sp['gap'], g))
    xr = x - sp['gap'] + colw - 40
    xl = -((sp['colw'] // 2 + 60) // G + 1) * G
    # ---- grid
    W, H = xr - xl + 400, yg + 300
    grid = WC.Grid(W, H)
    off = ((-xl + 200) // G, 10)
    gp = lambda x, y: (x // G + off[0], y // G + off[1])
    for i in range(0, grid.W):                        # nothing routes on or beyond the rails
        for j in range(0, grid.H):
            yy = (j - off[1]) * G
            if yy <= ytop or yy >= yg:
                grid.block.add((i, j))
    terms = defaultdict(list)
    stubs = []
    for k, d in enumerate(devs):
        x, y = pos[k]
        kind = 'p' if d['model'][0] == 'p' else 'n'
        row, top, bot = infos[k]
        nmw = tw(names[k], NAME_SIZE)
        # symbol body, the space right of it up to the end of the name, and the pin stubs
        for i in range(-1, int((30 + nmw) // G) + 2):
            for j in range(-2, 3):
                grid.block.add(gp(x + i * G, y + j * G))
        for pin, (dx, dy), net in (('g', (-20, 0), d['g']), ('top', (20, -30), top), ('bot', (20, 30), bot)):
            p = gp(x + dx, y + dy)
            grid.block.discard(p)
            if WC.is_rail(net):
                rail_y = ytop if net in WC.RAIL_P else yg
                if (pin == 'top' and rail_y == ytop) or (pin == 'bot' and rail_y == yg):
                    stubs.append((x + dx, y + dy, x + dx, rail_y, 'VDD' if rail_y == ytop else 'VSS'))
                    for j in range(min(p[1], gp(0, rail_y)[1]), max(p[1], gp(0, rail_y)[1]) + 1):
                        grid.block.add((p[0], j))
                    continue
                # rail on the inner pin (e.g. a capacitor with D = S = ground): routed to the rail like a net
                rp = gp(x + dx + 4 * G, rail_y)
                key = '__rail_' + ('VSS' if rail_y == yg else 'VDD') + str(k)
                grid.block.discard(rp); grid.pinnet[rp] = key; grid.pinnet[p] = key
                terms[key] = [rp, p]
                continue
            grid.pinnet[p] = net
            terms[net].append(p)
    # ports: inputs left, outputs right, spread over the channel
    ports = []
    mid = (p_bot + n_top) // 2
    def spread(n):
        return [((mid - 40 * (n - 1) // 2 + 40 * i) // G * G) for i in range(n)]
    for y, n in zip(spread(len(ins)), ins):
        ports.append(('ipin', xl, y, n))
    for y, n in zip(spread(len(outs)), outs):
        ports.append(('opin', xr, y, n))
    for kind, x, y, n in ports:
        p = gp(x, y); grid.block.discard(p); grid.pinnet[p] = n; terms[n].append(p)
        # keep the pin's own text area clear
        w = tw(n, 0.33)
        rng = range(int(-(w + 30) // G), 0) if kind == 'ipin' else range(1, int((w + 30) // G) + 1)
        for i in rng:
            for j in (-1, 0, 1):
                grid.block.add((p[0] + i, p[1] + j))
    wires = WC.route_all(grid, {n: t for n, t in terms.items() if len(t) > 1}, off)
    wires = [(a, b, c, d_, (('VSS' if 'VSS' in n else 'VDD') if n.startswith('__rail_') else n)) for a, b, c, d_, n in wires]
    return {'pos': pos, 'infos': infos, 'groups': stage_x, 'ytop': ytop, 'yg': yg, 'xl': xl, 'xr': xr,
            'wires': wires, 'stubs': stubs, 'ports': ports, 'colw': colw}

# ------------------------------------------------------------------ sheet assembly
def text_boxes_of(R, devs, names):
    boxes = []
    for k, (x, y) in R['pos'].items():
        boxes.append((x - 25, y - 35, x + 30 + tw(names[k], NAME_SIZE) + 4, y + 35))
    for kind, x, y, n in R['ports']:
        w = tw(n, 0.33)
        boxes.append((x - w - 25, y - 12, x, y + 12) if kind == 'ipin' else (x, y - 12, x + w + 25, y + 12))
    return boxes

def on_seg(p, s):
    x, y = p; x1, y1, x2, y2 = s
    return (x1 == x2 == x and min(y1, y2) <= y <= max(y1, y2)) or (y1 == y2 == y and min(x1, x2) <= x <= max(x1, x2))

def split(wires, x, y, net):
    """Cut the wire of net that passes through (x, y) so the label sits on a wire end (Xschem joins there)."""
    for i, (x1, y1, x2, y2, n) in enumerate(wires):
        if n == net and y1 == y2 == y and min(x1, x2) < x < max(x1, x2):
            wires[i:i + 1] = [(x1, y1, x, y, n), (x, y, x2, y2, n)]
            return

def place_labels(R, nets, devs, names):
    """One name per net, on a horizontal wire of that net, where the text hits no wire, symbol or other text."""
    boxes = text_boxes_of(R, devs, names)
    segs = [w for w in R['wires']] + [s for s in R['stubs']]
    out = []
    def clear(b, net):
        if any(b[0] < q[2] and q[0] < b[2] and b[1] < q[3] and q[1] < b[3] for q in boxes):
            return False
        for x1, y1, x2, y2, n in segs:
            if min(x1, x2) < b[2] and b[0] < max(x1, x2) and min(y1, y2) < b[3] and b[1] < max(y1, y2) + 0.1:
                if not (n == net and y1 == y2 and abs(y1 - b[3]) < 3):
                    return False
        return True
    for net in nets:
        w = tw(net, LAB_SIZE); h = th(LAB_SIZE)
        cands = []
        for x1, y1, x2, y2, n in R['wires']:
            if n != net:
                continue
            if y1 == y2:
                a, b = sorted((x1, x2))
                xx = b - 10
                while xx - w - 6 >= a:
                    cands.append((xx, y1, (xx - 2.5 - w, y1 - 1.25 - h, xx - 2.5, y1 - 1.25)))
                    xx -= 10
        cands.sort(key=lambda c: (-c[0]))
        for xx, yy, b in cands:
            if any(n != net and on_seg((xx, yy), (x1, y1, x2, y2)) for x1, y1, x2, y2, n in segs):
                continue
            if clear(b, net):
                out.append((xx, yy, net)); boxes.append(b)
                split(R['wires'], xx, yy, net); break
        else:
            raise RuntimeError(f'no free place for the label of {net}')
    return out

def tsheet(path, title, note, devs, ins, outs, roles, labels=(), colours=(), key_text=None, sp0=None):
    """roles: [(caption, predicate(dev), layer)] - each stage is captioned by the role that covers it;
    colours: [(net, colour name, meaning)]."""
    devs = [dict(d) for d in devs]
    for d in devs:
        for t in 'dgsb':
            d[t] = XG.san(d[t])
    ins = [XG.san(n) for n in ins]; outs = [XG.san(n) for n in outs]
    names = [d.get('show') or d['name'] for d in devs]
    colours = [((n,) if isinstance(n, str) else tuple(n), c, m) for n, c, m in colours]
    cnets = [XG.san(n) for ns, _, _ in colours for n in ns]
    sp = dict(sp0 or {'colw': 110, 'gap': 70, 'ch': 140})
    for attempt in range(12):
        try:
            R = build(devs, ins, outs, names, sp)
            want = [n for n in cnets + [XG.san(n) for n in labels] if n not in ins + outs]
            lab = place_labels(R, list(dict.fromkeys(want)), devs, names)
            break
        except RuntimeError as e:
            last = e
            sp['ch'] += 30; sp['gap'] += 20; sp['colw'] += 10
    else:
        raise RuntimeError(f'{path.name}: {last}')
    sh = Sheet()
    xl, xr, yg = R['xl'], R['xr'], R['yg']
    # ---- transistors
    for k, d in enumerate(devs):
        x, y = R['pos'][k]
        row, top, bot = R['infos'][k]
        if d['model'][0] == 'p':
            sym, dn, sn = '@@ROOT@@/sym/pmos3.sym', bot, top
        else:
            sym, dn, sn = '@@ROOT@@/sym/nmos3.sym', top, bot
        W = float(d['w']) * 1e6; L = float(d['l']) * 1e6
        sh.inst(sym, x, y, f'name={names[k]} model={d["model"]} W={W:.4g}u L={L:.4g}u spiceprefix=X')
    # ---- rails (named once) and stubs
    sh.wire(xl - 40, 0, xr + 40, 0, 'VDD'); sh.label('devices/lab_pin.sym', xl - 40, 0, 'VDD')
    sh.wire(xl - 40, yg, xr + 40, yg, 'VSS'); sh.label('devices/lab_pin.sym', xl - 40, yg, 'VSS')
    for x1, y1, x2, y2, n in R['stubs']:
        sh.wire(x1, y1, x2, y2, n)
    for x1, y1, x2, y2, n in R['wires']:
        sh.wire(x1, y1, x2, y2, n)
    for kind, x, y, n in R['ports']:
        sh.inst(f'devices/{kind}.sym', x, y, f'name=p_{n} lab={n}')
    for x, y, n in lab:
        sh.label('devices/lab_wire.sym', x, y, n)
    # ---- brackets and captions above the VDD rail
    spans = []
    for x0, x1, g in R['groups']:
        best = None
        for r, (cap, pred, layer) in enumerate(roles):
            c = sum(1 for k in g if pred(devs[k]))
            if c and (best is None or c > best[0]):
                best = (c, r)
        spans.append((best[1] if best else None, x0, x1))
    merged = []
    for r, x0, x1 in spans:
        if merged and merged[-1][0] == r and r is not None:
            merged[-1][2] = x1
        else:
            merged.append([r, x0, x1])
    rows_end = []
    bracket_y = []
    for r, x0, x1 in merged:
        if r is None:
            continue
        cap, _, layer = roles[r]
        a, b = x0 - 40, x1 - R['colw'] + 80
        w = tw(cap, CAP_SIZE)
        lvl = 0
        while lvl < len(rows_end) and rows_end[lvl] > a - 20:
            lvl += 1
        if lvl == len(rows_end):
            rows_end.append(-1e9)
        rows_end[lvl] = max(b, a + w)
        y = -40 - 50 * lvl
        sh.line(a, y, b, y, layer); sh.line(a, y, a, y + 12, layer); sh.line(b, y, b, y + 12, layer)
        sh.text(cap, a, y - th(CAP_SIZE) - 4, CAP_SIZE, layer)
        bracket_y.append(y)
    top_cap = min(bracket_y + [-40]) - th(CAP_SIZE) - 10
    # ---- title and note
    yt = top_cap - 30 - th(0.24) * 1.35 * len(note)
    sh.text(title, xl - 60, yt - th(0.45) - 16, 0.45)
    for i, s in enumerate(note):
        sh.text(s, xl - 60, yt + th(0.24) * 1.35 * i, 0.24)
    # ---- colour key under the VSS rail, then the body note
    y = yg + 50
    for nets, col, meaning in colours:
        xx = xl
        for net in nets:
            n = XG.san(net)
            w = max(100, tw(n, LAB_SIZE) + 30)
            sh.wire(xx, y, xx + w, y, n)
            sh.label('devices/lab_wire.sym', xx + w, y, n)
            xx += w + 20
        sh.text(meaning, xx + 10, y - th(0.24) / 2 - 2, 0.24)
        y += 40
    sh.text(key_text or 'Rails: VDD at the top, VSS at the bottom; every PMOS body is on VDD and every NMOS body on VSS '
            '(drawn inside the symbol). A dot marks a connection; wires that cross without a dot are not connected.',
            xl, y - 6, 0.2)
    path.write_text(sh.sch())
    hl = ''.join(f'{XG.san(n)} {COLOUR[c]}\n' for ns, c, _ in colours for n in ns)
    path.with_suffix('.hl').write_text(hl)
    return len(devs)

def write_symbols(kit):
    (kit / 'sym').mkdir(parents=True, exist_ok=True)
    (kit / 'sym' / 'pmos3.sym').write_text(PMOS3)
    (kit / 'sym' / 'nmos3.sym').write_text(NMOS3)

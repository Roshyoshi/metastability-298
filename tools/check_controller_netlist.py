#!/usr/bin/env python3
"""Check a SPICE netlist that Xschem wrote from blocks/controller.sch against src/gf180/compact_control.v.

  1. In Xschem open blocks/controller.sch and press Netlist (or: xschem -n -s -q -o <dir> blocks/controller.sch).
  2. python3 tools/check_controller_netlist.py <dir>/controller.spice

Both sides are opened down to single transistors and compared: every MOSFET's model, W, L and the nets
on its drain, gate, source and body. The reference side is netlist/controller_synth.v (the Verilog as a
cell list, from tools/controller_netlist.py) with each cell replaced by the library's own netlist in
pdk_cells/cdl/. Drain and source may be swapped, and the wires inside a cell may have any names (Xschem
numbers them itself); nothing else may differ.
"""
import re, sys
from collections import Counter
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import build_master as BM

def san(n):
    return n.replace('[', '_').replace(']', '').lower()

def um(v):
    v = v.lower()
    mult = {'u': 1.0, 'n': 1e-3, 'p': 1e-6}
    return round(float(v[:-1]) * mult[v[-1]] if v[-1] in mult else float(v) * 1e6, 4)

def key(model, w, l, d, g, s, b):
    return (model, w, l, tuple(sorted((d, s))), g, b)

def canonical(devs):
    """Rename the wires inside each cell (names like inst.net) by what is connected to them, so that two
    netlists that differ only in those names give the same result."""
    items = list(devs.elements())
    internal = lambda n: '.' in n
    colour = {n: 'i' for k in items for n in (*k[3], k[4], k[5]) if internal(n)}
    col = lambda n: colour.get(n, n)
    for _ in range(24):
        seen = {n: [] for n in colour}
        for model, w, l, ds, g, b in items:
            inst = next((n.split('.')[0] for n in (*ds, g, b) if internal(n)), '')
            base = (inst, model, w, l, tuple(sorted(col(n) for n in ds)), col(g), col(b))
            for n in ds:
                if internal(n): seen[n].append(('ds',) + base)
            if internal(g): seen[g].append(('g',) + base)
            if internal(b): seen[b].append(('b',) + base)
        colour = {n: n.split('.')[0] + '.' + format(hash(tuple(sorted(v))) & 0xffffffffffff, 'x') for n, v in seen.items()}
    return Counter(key(model, w, l, col(ds[0]), col(g), col(ds[1]), col(b)) for model, w, l, ds, g, b in items)

def reference():
    devs = Counter(); cells = {}
    rail = {'VDD': 'vdd', 'VNW': 'vdd', 'VSS': '0', 'VPW': '0'}
    for i in BM.CTRL:
        conns = {p: san(BM.CTRL_MAP.get(n, n)) for p, n in i['conns'].items()}
        cells[i['name'].lower()] = (i['cell'].replace(BM.LIB, ''), conns)
        for d in BM.CELLS[i['cell']]['devices']:
            net = lambda n: rail.get(n) or conns.get(n) or f"{i['name'].lower()}.{n.lower()}"
            devs[key(d['model'], round(d['W'] * 1e6, 4), round(d['L'] * 1e6, 4), net(d['d']), net(d['g']), net(d['s']), net(d['b']))] += 1
    return devs, cells

def xschem(path):
    text = Path(path).read_text().replace('\n+', ' ')
    subs, cur, top = {}, None, []
    for line in text.splitlines():
        t = line.split()
        if not t:
            continue
        if t[0].lower() == '.subckt':
            cur = {'ports': [p.lower() for p in t[2:]], 'inst': []}; subs[t[1].lower()] = cur
        elif t[0].lower() == '.ends':
            cur = None
        elif t[0][0] in 'xX':
            k = next((j for j, x in enumerate(t) if '=' in x), len(t))
            prm = {a.split('=')[0].lower(): a.split('=')[1] for a in t[k:]}
            (cur['inst'] if cur is not None else top).append((t[0][1:].lower(), [n.lower() for n in t[1:k - 1]], t[k - 1].lower(), prm))
    devs = Counter(); cells = {}
    glob = {'vdd', '0', 'gnd'}
    def walk(insts, netmap, path, depth):
        for name, nets, ref, prm in insts:
            nets = [n if n in glob else netmap.get(n, f'{path}{n}') for n in nets]
            nets = ['0' if n == 'gnd' else n for n in nets]
            if ref in subs:
                sub = subs[ref]
                if all(r not in subs for _, _, r, _ in sub['inst']):         # a cell: its transistors are next
                    cells[name] = (ref, None)
                    walk(sub['inst'], dict(zip(sub['ports'], nets)), f'{name}.', depth + 1)
                else:                                                         # a block: nets keep their names
                    walk(sub['inst'], dict(zip(sub['ports'], nets)), '', depth + 1)
            else:
                d, g, s, b = nets
                devs[key(ref, um(prm['w']), um(prm['l']), d, g, s, b)] += 1
    walk(top, {}, '', 0)
    return devs, cells

def main(path):
    ref, rcells = reference()
    got, gcells = xschem(path)
    ref, got = canonical(ref), canonical(got)
    ok = True
    if {n: c[0] for n, c in rcells.items()} != {n: c[0] for n, c in gcells.items()}:
        ok = False
        print('cell instances differ:', sorted(set(rcells) ^ set(gcells))[:10])
    missing = ref - got; extra = got - ref
    for label, bag in (('in the Verilog but not in the Xschem netlist', missing), ('in the Xschem netlist but not in the Verilog', extra)):
        if bag:
            ok = False
            print(f'{sum(bag.values())} transistors {label}, for example:')
            for k in list(bag)[:5]:
                print('   ', k)
    print(f'{len(gcells)} cells and {sum(got.values())} transistors in the Xschem netlist; '
          f'{len(rcells)} cells and {sum(ref.values())} transistors from the Verilog')
    print('MATCH: the Xschem controller is the Verilog controller, transistor for transistor' if ok else 'MISMATCH')
    return 0 if ok else 1

if __name__ == '__main__':
    sys.exit(main(sys.argv[1]))

#!/usr/bin/env python3
"""Check the flat controller sheets (xschem/flat/ctrl_<block>.sch) against src/gf180/compact_control.v.

  1. Netlist each sheet into one folder (in Xschem: open it and press Netlist; or
     xschem -n -s -q -o <dir> flat/ctrl_<block>.sch).
  2. python3 tools/check_controller_flats.py <dir>

A flat sheet draws one controller block with every transistor on one page. Each is compared with the
cells that block holds in netlist/controller_synth.v: every MOSFET's model, W, L and nets. Only wires
that leave the block carry a name on a flat sheet, so those must agree by name and the rest by what is
connected to them.
"""
import sys, re
from collections import Counter
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import check_controller_netlist as C
BM = C.BM
rail = {'VDD': 'vdd', 'VNW': 'vdd', 'VSS': '0', 'VPW': '0'}
def mapped(n): return C.san(BM.CTRL_MAP.get(n, n))
outside = {mapped(p) for p in BM.CTRL_MAP} | {'vdd', '0'}
def block_ref(blk):
    devs = Counter()
    mine = {mapped(n) for i in BM.CTRL if i['block'] == blk for n in i['conns'].values()}
    others = {mapped(n) for i in BM.CTRL if i['block'] != blk for n in i['conns'].values()}
    ports = mine & (others | outside)
    for i in BM.CTRL:
        if i['block'] != blk: continue
        conns = {p: mapped(n) for p, n in i['conns'].items()}
        for d in BM.CELLS[i['cell']]['devices']:
            net = lambda n: rail.get(n) or conns.get(n) or f"{i['name'].lower()}.{n.lower()}"
            devs[C.key(d['model'], round(d['W']*1e6, 4), round(d['L']*1e6, 4), net(d['d']), net(d['g']), net(d['s']), net(d['b']))] += 1
    return devs, ports
def canon(devs, ports):
    ren = lambda n: n if (n in ports or n in ('vdd', '0')) else 'x.' + n.replace('.', '_')
    return C.canonical(Counter({(m, w, l, tuple(sorted((ren(ds[0]), ren(ds[1])))), ren(g), ren(b)): c for (m, w, l, ds, g, b), c in devs.items()}))
ok = True; total = 0
for blk, box, title, _ in BM.CTRL_BLOCKS:
    p = Path(f'{sys.argv[1]}/ctrl_{blk}.spice')
    if not p.exists():
        print(f'ctrl_{blk:15s} not netlisted'); ok = False; continue
    text = p.read_text().replace('\n+', ' ')
    got = Counter(); named = set()
    for line in text.splitlines():
        t = line.split()
        if t and t[0][0] in 'xX' and len(t) > 6 and t[5].lower() in ('nfet_05v0', 'pfet_05v0'):
            prm = {a.split('=')[0].lower(): a.split('=')[1] for a in t[6:] if '=' in a}
            d, g, s, b = [('0' if n.lower() == 'gnd' else n.lower()) for n in t[1:5]]
            named |= {n for n in (d, g, s, b) if not re.fullmatch(r'net\d+', n)}
            got[C.key(t[5].lower(), C.um(prm['w']), C.um(prm['l']), d, g, s, b)] += 1
    ref, ports = block_ref(blk)
    same = canon(got, ports) == canon(ref, ports) and named - {'vdd', '0'} == ports - {'vdd', '0'}
    ok &= same; total += sum(got.values())
    print(f'ctrl_{blk:15s} {sum(got.values()):4d} transistors in the flat sheet, {sum(ref.values()):4d} expected, {len(ports - {"vdd","0"}):2d} named wires: {"MATCH" if same else "MISMATCH"}')
    if not same:
        print('   named only in flat:', sorted(named - ports - {'vdd','0'})[:8], ' only in reference:', sorted(ports - named - {'vdd','0'})[:8])
print(f'{total} transistors in all:', 'every flat sheet matches the Verilog' if ok else 'MISMATCH')
sys.exit(0 if ok else 1)

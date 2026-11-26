#!/usr/bin/env python3
"""Independent check of the generated Xschem hierarchy against the master netlist.

Netlists chip.sch the way Xschem connects things in these files (a pin is connected to the
net named by the label sitting exactly on it; equal names are one net; ipin/opin name ports),
flattens it to transistors, and compares the transistor/net graph with netlist/chip.cdl using a
Weisfeiler-Lehman graph hash (identical hashes = same circuit up to renaming of internal nets).
"""
import re, sys
from collections import Counter, defaultdict
from pathlib import Path
import networkx as nx

CHIP = Path(__file__).resolve().parent.parent
MOSPIN = {'nfet': {'D': (20, -30), 'G': (-20, 0), 'S': (20, 30), 'B': (20, 0)},
          'pfet': {'S': (20, -30), 'G': (-20, 0), 'D': (20, 30), 'B': (20, 0)}}
SUPPLY = {'VDD': 'VDPWR', '0': 'VGND', 'VSS': 'VGND'}

def parse_attrs(s):
    return dict(re.findall(r'(\w+)=("[^"]*"|\S+)', s))

def read_sch(path, root):
    insts = []
    for line in path.read_text().splitlines():
        m = re.match(r'C \{([^}]*)\} (\S+) (\S+) (\S+) (\S+) \{(.*)\}$', line)
        if not m:
            continue
        sym, x, y, rot, flip, attrs = m.groups()
        insts.append((sym.replace('@@ROOT@@', str(root)), float(x), float(y), parse_attrs(attrs)))
    return insts

def sym_pins(sym):
    if sym.endswith('nfet_06v0.sym') or sym.endswith('nfet_03v3.sym'):
        return list(MOSPIN['nfet'].items()), 'nfet'
    if sym.endswith('pfet_06v0.sym') or sym.endswith('pfet_03v3.sym'):
        return list(MOSPIN['pfet'].items()), 'pfet'
    if sym.endswith('nmos3.sym'):
        return [(k, v) for k, v in MOSPIN['nfet'].items() if k != 'B'], 'nfet3'
    if sym.endswith('pmos3.sym'):
        return [(k, v) for k, v in MOSPIN['pfet'].items() if k != 'B'], 'pfet3'
    if sym.endswith('capa.sym'):
        return [('p', (0, -30)), ('m', (0, 30))], 'cap'
    pins = []
    for line in Path(sym).read_text().splitlines():
        if line.startswith('B 5'):
            t = line.split()
            x1, y1, x2, y2 = map(float, t[2:6])
            name = line.split('name=')[1].split()[0].rstrip('}')
            pins.append((name, ((x1 + x2) / 2, (y1 + y2) / 2)))
    return pins, 'sub'

def read_wires(path):
    w = []
    for line in path.read_text().splitlines():
        m = re.match(r'N (\S+) (\S+) (\S+) (\S+) \{', line)
        if m:
            w.append(tuple(round(float(v), 3) for v in m.groups()))
    return w

def on_seg(p, s):
    x, y = p; x1, y1, x2, y2 = s
    if x1 == x2 == x:
        return min(y1, y2) <= y <= max(y1, y2)
    if y1 == y2 == y:
        return min(x1, x2) <= x <= max(x1, x2)
    return False

def wire_nets(wires):
    """Union-find over wires: shared end points, and an end point lying on another wire, join them."""
    parent = list(range(len(wires)))
    def f(a):
        while parent[a] != a:
            parent[a] = parent[parent[a]]; a = parent[a]
        return a
    for i, a in enumerate(wires):
        for j, b in enumerate(wires):
            if j <= i:
                continue
            if any(on_seg(pt, b) for pt in ((a[0], a[1]), (a[2], a[3]))) or any(on_seg(pt, a) for pt in ((b[0], b[1]), (b[2], b[3]))):
                parent[f(i)] = f(j)
    return [f(i) for i in range(len(wires))]

def netlist(sch, root, prefix, portmap, out):
    insts = read_sch(sch, root)
    wires = read_wires(sch)
    comp = wire_nets(wires)
    def wire_at(pt):
        for k, sgm in enumerate(wires):
            if on_seg(pt, sgm):
                return comp[k]
        return None
    labels = {}
    wlab = {}
    for sym, x, y, a in insts:
        if sym.startswith(('devices/lab_pin', 'devices/lab_wire', 'devices/ipin', 'devices/opin', 'devices/vdd', 'devices/gnd')):
            pt = (round(x, 3), round(y, 3))
            labels[pt] = a['lab']
            w = wire_at(pt)
            if w is not None:
                if wlab.get(w, a['lab']) != a['lab']:
                    raise RuntimeError(f'{sch.name}: labels {wlab[w]} and {a["lab"]} on one wire net (short)')
                wlab[w] = a['lab']
    for pt in list(labels):
        pass
    def label_at(pt):
        w = wire_at(pt)
        if w is not None:
            return wlab.get(w, f'_w{w}')
        return labels.get(pt)
    def net(n):
        if n in SUPPLY:
            return SUPPLY[n]
        if n in portmap:
            return portmap[n]
        return prefix + n
    for sym, x, y, a in insts:
        if sym.startswith('devices/'):
            if sym.endswith('capa.sym'):
                out['caps'] += 1
            if sym.endswith('diode.sym'):
                pa, pc = (round(x, 3), round(y - 30, 3)), (round(x, 3), round(y + 30, 3))
                area = a['area'].strip('"').split()[0]
                out['diodes'].append((prefix + a['name'], a['model'], area, net(label_at(pa)), net(label_at(pc))))
            continue
        pins, kind = sym_pins(sym)
        conn = {}
        for pn, (px, py) in pins:
            key = (round(x + px, 3), round(y + py, 3))
            lab = label_at(key)
            if lab is None:
                raise RuntimeError(f'{sch.name}: pin {pn} of {a.get("name")} at {key} has no label or wire')
            conn[pn] = net(lab)
        if kind in ('nfet3', 'pfet3'):
            conn['B'] = 'VDPWR' if kind == 'pfet3' else 'VGND'
            out['mos'].append((prefix + a['name'], a['model'], a['W'], a['L'], conn['D'], conn['G'], conn['S'], conn['B']))
        elif kind in ('nfet', 'pfet'):
            out['mos'].append((prefix + a['name'], a['model'], a['W'], a['L'], conn['D'], conn['G'], conn['S'], conn['B']))
        elif kind == 'sub':
            child = Path(a['schematic'].replace('@@ROOT@@', str(root))) if 'schematic' in a else Path(sym[:-4] + '.sch')
            netlist(child, root, prefix + a['name'] + '/', conn, out)

PINS = {'VDPWR', 'VGND', 'clk', 'rst_n', 'ena', 'ua_0', 'ui_in_3', 'ui_in_4', 'ui_in_6', 'uio_in_6'} | \
       {f'uo_out_{k}' for k in range(8)} | {f'uio_out_{k}' for k in range(1, 6)}

def to_graph(mos, diodes=()):
    G = nx.Graph()
    for i, (name, model, area, a, c) in enumerate(diodes):
        t = f'd{i}'
        G.add_node(t, lab=f'{model}:{area}')
        for term, n in (('a', a), ('c', c)):
            G.add_node('n:' + n, lab=('NET:' + n) if n in PINS else 'net')
            G.add_edge(t, 'n:' + n, lab=term)
    for i, (name, model, W, L, d, g, s, b) in enumerate(mos):
        t = f't{i}'
        G.add_node(t, lab=f'{model}:{float(str(W).rstrip("u"))*1e3:.0f}:{float(str(L).rstrip("u"))*1e3:.0f}')
        for term, n in (('ds', d), ('g', g), ('ds', s), ('b', b)):
            G.add_node('n:' + n, lab=('NET:' + n) if n in PINS else 'net')
            if G.has_edge(t, 'n:' + n):
                G[t]['n:' + n]['lab'] = '+'.join(sorted(G[t]['n:' + n]['lab'].split('+') + [term]))
            else:
                G.add_edge(t, 'n:' + n, lab=term)
    return G

DIODES = []

def cdl_mos():
    sys.path.insert(0, str(CHIP / 'tools'))
    txt = (CHIP / 'netlist' / 'chip.cdl').read_text()
    for inc in re.findall(r'^\.include (\S+)', txt, re.M):
        txt += '\n' + (CHIP / 'netlist' / inc).read_text().replace('\n+', ' ')
    subs, cur = {}, None
    for line in txt.splitlines():
        s = line.strip().split()
        if not s or s[0].startswith('*'):
            continue
        if s[0].upper() == '.SUBCKT':
            cur = s[1]; subs[cur] = {'pins': s[2:], 'el': []}
        elif s[0].upper() == '.ENDS':
            cur = None
        elif cur and s[0][0] in 'MXmxDd':
            subs[cur]['el'].append(s)
    mos = []
    sup = {'VDD': 'VDPWR', 'VNW': 'VDPWR', 'VSS': 'VGND', 'VPW': 'VGND'}
    def flat(name, mp, path):
        for e in subs[name]['el']:
            if e[0][0] in 'Dd':
                a, c = [sup.get(n, mp.get(n, path + n)) for n in e[1:3]]
                DIODES.append((path + e[0], e[3], e[4], a, c))
            elif e[0][0] in 'Mm':
                prm = {k.upper(): v for k, v in (t.split('=') for t in e[6:] if '=' in t)}
                nets = [mp.get(n, path + n) for n in e[1:5]]
                nets = [{'VDD': 'VDPWR', 'VNW': 'VDPWR', 'VSS': 'VGND', 'VPW': 'VGND'}.get(n, n) for n in nets]
                import build_master as BM
                mos.append((path + e[0], e[5], f'{BM._num(prm["W"])*1e6:g}u', f'{BM._num(prm["L"])*1e6:g}u', *nets))
            else:
                sub = e[-1]; pins = subs[sub]['pins']
                flat(sub, {p: mp.get(n, path + n) for p, n in zip(pins, e[1:-1])}, path + e[0] + '/')
    top = 'tt_um_metastability_characterizer'
    flat(top, {p: p for p in subs[top]['pins']}, '')
    return mos

def san(n):
    return n.replace('[', '_').replace(']', '')

if __name__ == '__main__':
    root = Path(sys.argv[1]) if len(sys.argv) > 1 else CHIP / 'rounds' / 'round1' / 'kit'
    out = {'mos': [], 'caps': 0, 'diodes': []}
    top_ports = {}
    netlist(root / 'chip.sch', root, '', top_ports, out)
    sch_mos = out['mos']
    ref = cdl_mos()
    # top-level names: the Xschem side uses sanitized pin names
    ref = [(n, m, W, L, *[san(x) if '/' not in x else x for x in nets]) for (n, m, W, L, *nets) in ref]
    ref_d = [(n, m, a, san(x) if '/' not in x else x, san(y) if '/' not in y else y) for (n, m, a, x, y) in DIODES]
    print(f'Xschem hierarchy: {len(sch_mos)} transistors, {len(out["diodes"])} diodes '
          f'({out["caps"]} capacitors: pre-layout wiring estimates, not in the LVS netlist)')
    print(f'master netlist:   {len(ref)} transistors, {len(ref_d)} diodes')
    print('diodes equal:', sorted(d[1:] for d in out['diodes']) == sorted(d[1:] for d in ref_d))
    c1 = Counter((m, float(W.rstrip('u')), float(L.rstrip('u'))) for _, m, W, L, *_ in sch_mos)
    c2 = Counter((m, float(W.rstrip('u')), float(L.rstrip('u'))) for _, m, W, L, *_ in ref)
    print('device multisets equal:', c1 == c2)
    # top-level nets: the same multiset of (device size, terminal) on each named net
    def top_profile(mos):
        prof = defaultdict(Counter)
        for _, m, W, L, d, g, s, b in mos:
            for term, n in (('ds', d), ('g', g), ('ds', s)):
                if n in PINS:
                    prof[n][(m, round(float(W.rstrip('u')), 3), term)] += 1
        return prof
    p1, p2 = top_profile(sch_mos), top_profile(ref)
    bad = [n for n in set(p1) | set(p2) if p1.get(n) != p2.get(n)]
    print('chip pins and supplies with identical connections:', len(set(p1) | set(p2)) - len(bad), 'of', len(set(p1) | set(p2)))
    for n in sorted(bad)[:10]:
        print('   differs:', n, dict(p1.get(n, {})), '|', dict(p2.get(n, {})))
    h1 = nx.weisfeiler_lehman_graph_hash(to_graph(sch_mos, out['diodes']), node_attr='lab', edge_attr='lab', iterations=6)
    h2 = nx.weisfeiler_lehman_graph_hash(to_graph(ref, ref_d), node_attr='lab', edge_attr='lab', iterations=6)
    print('graph hash Xschem :', h1)
    print('graph hash master :', h2)
    print('SAME CIRCUIT' if h1 == h2 else 'DIFFERENT')

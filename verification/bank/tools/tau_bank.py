#!/usr/bin/env python3
"""Latch time constants (growth method) of the flip-flops of the bank revision, from its Magic 8.3.573 extraction.

  DUT2, DUT3, DUT4 and the bank's N3 (5 V NAND master-slave flip-flops): the method of
      /home/claude/r4/final_ind/xcheck_corners.py ("flip-flop alone", the frozen values of numbers.json 'alone'):
      the nine extracted cells (library '5x', Magic 8.3.573) with the wiring capacitance that the extraction of the
      tile places on the two latch nodes (each node's top-level capacitance to all other nets as a capacitor to
      ground, and the capacitance between the two nodes), 1.0 fF on each of the six other internal nets.
  N1 (meta_n3ffb) and N2 (meta_j3a): the block instance flattened out of the extracted tile (its 3.3 V devices with
      the extracted junction geometry, every capacitor inside the block and every top-level capacitor on its nodes;
      a capacitor to a net outside the block goes to ground), latch nodes mq/mqb and x/y.
  Growth method of /home/claude/r5/meta.py (imported read only): the latch nodes start at the balance voltage plus
  and minus 10 uV with the clock high (master holding); tau from the growth of their difference.
usage: tau_bank.py <pex> <netmap.json> <workdir> <out.json>
"""
import sys, os, re, json, math
sys.dont_write_bytecode = True
sys.path.insert(0, '/home/claude/r5')
sys.path.insert(0, '/home/claude/r3/tools')
import meta, cands                     # read only
import pexlib as PL                    # read only

pex_path, map_path, work, out_path = sys.argv[1:5]
os.makedirs(work, exist_ok=True)
pex = PL.read_pex(pex_path)
m = json.load(open(map_path))['map']
inv = {v: k for k, v in m.items()}
CONDS = [('typical', 3.3, 27.0), ('ss', 3.0, 125.0), ('ff', 3.6, -40.0), ('ss', 3.0, -40.0)]

# ---- 5 V NAND flip-flops: top-level wiring capacitance on the latch nodes
caps, pair = {}, {}
for name, a, b, v in pex['top']['caps']:
    c = PL.capval(v) * 1e15
    na, nb = inv.get(a, a), inv.get(b, b)
    caps[na] = caps.get(na, 0.0) + c; caps[nb] = caps.get(nb, 0.0) + c
    k = tuple(sorted((na, nb))); pair[k] = pair.get(k, 0.0) + c
FK = {'xu_dut2': (2, 1), 'xu_dut3': (2, 2), 'xu_dut4': (4, 1), 'xbank_n3': (2, 2)}
res = {'wiring': {}, 'tau': {}}
if os.path.exists(out_path):
    res = json.load(open(out_path))
for d, (f, k) in FK.items():
    cc = pair.get(tuple(sorted((f'{d}/mq', f'{d}/mqb'))), 0.0)
    w = {'cq': caps[f'{d}/mq'] - cc, 'cqb': caps[f'{d}/mqb'] - cc, 'cc': cc}
    res['wiring'][d] = {kk: round(vv, 5) for kk, vv in w.items()}
    for corner, vdd, temp in CONDS:
        key = f'{d}_{corner}_{vdd}_{temp}'
        if key in res['tau']:
            continue
        ff = cands.nand_ms('5x', f, k, cq=w['cq'], cw=w['cqb'], cc=w['cc'], cnode=1.0, name=f'bk_{d}')
        r = meta.tau_growth(ff, work, corner=corner, vdd=vdd, temp=temp)
        res['tau'][key] = {'tau_ps': r['tau_ps'], 'local_ps': r['local_ps'], 'vb': r['vb']}
        print(key, '%.3f ps' % r['tau_ps'], ['%.2f' % x for x in r['local_ps']], flush=True)
        json.dump(res, open(out_path, 'w'), indent=1)

# ---- 3.3 V blocks: flatten the instance out of the extraction
def flatten(inst, cellname):
    subs = {}
    for c, body in pex['subckts'].items():
        subs[c] = body
    top_inst = [i for i in pex['top']['inst'] if i[0].lower() == ('x' + inst).lower()]
    assert len(top_inst) == 1, inst
    _, cell, args = top_inst[0]
    pins = pex['pins'][cell]
    portmap = dict(zip(pins, args))
    san = lambda n: re.sub(r'[^A-Za-z0-9_]', '_', n)
    sup = {'VDPWR': 'vdd', 'VGND': '0', 'VSUBS': '0', 'VDD': 'vdd', 'VSS': '0', '0': '0'}
    lines = []
    blocknodes = set()
    def node(n, pmap, prefix):
        if n in pmap:
            return pmap[n]
        if n in sup:
            return sup[n]
        return prefix + san(n)
    def walk(cname, pmap, prefix):
        body = subs[cname]
        hdr = body[0].split()
        cpins = hdr[2:]
        for line in body[1:]:
            t = line.split()
            if not t or t[0].lower() == '.ends':
                continue
            if t[0][0] in 'Xx':
                sub = t[-1] if t[-1] in subs else None
                if sub is None:              # a device: X<name> d g s b model params
                    nets = [node(x, pmap, prefix) for x in t[1:5]]
                    lines.append(' '.join([f'X{prefix}{san(t[0][1:])}'] + nets + t[5:]))
                else:
                    args_ = [x for x in t[1:-1] if '=' not in x]
                    spins = pex['pins'][sub]
                    walk(sub, {p: node(a, pmap, prefix) for p, a in zip(spins, args_)}, prefix + san(t[0]) + '_')
            elif t[0][0] in 'Cc':
                a, b = node(t[1], pmap, prefix), node(t[2], pmap, prefix)
                if a != b:
                    lines.append(f'C{prefix}{san(t[0][1:])} {a} {b} {t[3]}')
    # ports of the block instance: supplies stay supplies, the three signal pins are named, everything else is internal
    pmap = {}
    for p, a in portmap.items():
        if a in sup:
            pmap[p] = sup[a]
        elif p in ('d', 'clk', 'q'):
            pmap[p] = p
        else:
            pmap[p] = 'b_' + san(p)
        blocknodes.add(a)
    walk(cell, pmap, 'b_')
    # top-level capacitors on the block's nodes: kept between block nodes, to ground otherwise
    tn = {a: pmap[p] for p, a in portmap.items()}
    ntop = 0
    for name, a, b, v in pex['top']['caps']:
        ina, inb = a in tn, b in tn
        if not (ina or inb):
            continue
        x = tn[a] if ina else '0'
        y = tn[b] if inb else '0'
        if x == y:
            continue
        lines.append(f'Ctop_{san(name)} {x} {y} {v}'); ntop += 1
    return lines, pmap, ntop

BLOCKS = {'meta_n3ffb_0': ('meta_n3ffb', 'mq', 'mqb'), 'meta_j3a_0': ('meta_j3a', 'x', 'y')}
for inst, (cell, n1, n2) in BLOCKS.items():
    body, pmap, ntop = flatten(inst, cell)
    open(os.path.join(work, f'flat_{inst}.spice'), 'w').write('\n'.join(body) + '\n')
    a = pmap.get(n1, 'b_' + n1); b = pmap.get(n2, 'b_' + n2)
    res['wiring'][inst] = {'lines': len(body), 'top_caps': ntop, 'nodes': [a, b]}
    for corner, vdd, temp in CONDS:
        key = f'{inst}_{corner}_{vdd}_{temp}'
        if key in res['tau']:
            continue
        ff = meta.FF(f'bk_{inst}', body, (a, b), libs=(), hold=['VCLK clk 0 {vdd}', 'VD d 0 0'])
        r = meta.tau_growth(ff, work, corner=corner, vdd=vdd, temp=temp)
        res['tau'][key] = {'tau_ps': r['tau_ps'], 'local_ps': r['local_ps'], 'vb': r['vb']}
        print(key, '%.3f ps' % r['tau_ps'], ['%.2f' % x for x in r['local_ps']], flush=True)
        json.dump(res, open(out_path, 'w'), indent=1)
json.dump(res, open(out_path, 'w'), indent=1)
print('done')

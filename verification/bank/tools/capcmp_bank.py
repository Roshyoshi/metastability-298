#!/usr/bin/env python3
"""Compare top-level extracted wiring capacitance per net (schematic names) between two extractions.
usage: capcmp_bank.py <pex A> <netmap A> <pex B> <netmap B> <out.json>
For each net: total capacitance of the top-level capacitors on it (fF), and for each DUT latch pair the three
values used by the growth method 'alone' (node to everything except the other node; between the two nodes)."""
import sys, json, re
from collections import defaultdict
sys.path.insert(0, '/home/claude/r3/tools')
import pexlib as P

def load(pex_path, map_path):
    pex = P.read_pex(pex_path)
    m = json.load(open(map_path))['map']
    inv = {v: k for k, v in m.items()}
    caps = defaultdict(float); pair = defaultdict(float)
    for name, a, b, v in pex['top']['caps']:
        c = P.capval(v) * 1e15
        na, nb = inv.get(a, a), inv.get(b, b)
        caps[na] += c; caps[nb] += c
        pair[tuple(sorted((na, nb)))] += c
    return caps, pair

A = load(sys.argv[1], sys.argv[2]); B = load(sys.argv[3], sys.argv[4])
NETS = ['capture', 'capture_b', 'capture_local', 'capture_iso_b', 'capture_iso', 'early_clk', 'data_b', 'data_local',
        'q[0]', 'q[1]', 'q[2]', 'q[3]', 'selected_q', 'early_q', 'ctrl_q', 'ctrl_early', 'ua[0]', 'xdelay/slow', 'xdelay/r0', 'xdelay/r1',
        'clk', 'rst_n', 'ui_in[3]', 'uio_in[6]', 'ui_in[6]', 'uio_out[4]', 'uio_out[5]']
out = {'nets': {}, 'latch': {}}
print(f'{"net":16s} {"06823df":>9s} {"bank":>9s} {"diff":>8s}  (fF, top-level wiring capacitance)')
for n in NETS:
    a, b = A[0].get(n, 0.0), B[0].get(n, 0.0)
    out['nets'][n] = {'old': round(a, 4), 'new': round(b, 4), 'diff': round(b - a, 4)}
    print(f'{n:16s} {a:9.4f} {b:9.4f} {b - a:+8.4f}')
for d in ('xu_dut2', 'xu_dut3', 'xu_dut4'):
    r = {}
    for tag, (caps, pair) in (('old', A), ('new', B)):
        cc = pair.get(tuple(sorted((f'{d}/mq', f'{d}/mqb'))), 0.0)
        r[tag] = {'cq': round(caps[f'{d}/mq'] - cc, 5), 'cqb': round(caps[f'{d}/mqb'] - cc, 5), 'cc': round(cc, 5)}
    out['latch'][d] = r
    print(d, 'old', r['old'], 'new', r['new'], 'IDENTICAL' if r['old'] == r['new'] else 'DIFFERENT')
json.dump(out, open(sys.argv[5], 'w'), indent=1)

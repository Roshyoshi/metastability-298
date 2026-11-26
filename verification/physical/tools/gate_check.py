#!/usr/bin/env python3
"""Floating-gate check on the hierarchical netlist extracted by Magic: every net that reaches a transistor gate must
also reach a source, a drain or a diode somewhere in the tile, or be a pin of the tile.
usage: gate_check.py <extracted .spice>"""
import re, sys, collections
subs, pins, cur = {}, {}, None
def lines(p):
    acc = None
    for l in open(p):
        l = l.rstrip("\n")
        if l.startswith("+"): acc += " " + l[1:]; continue
        if acc is not None: yield acc
        acc = l
    if acc is not None: yield acc
for l in lines(sys.argv[1]):
    w = l.split()
    if not w: continue
    k = w[0].lower()
    if k == ".subckt": cur = w[1]; pins[cur] = w[2:]; subs[cur] = []
    elif k == ".ends": cur = None
    elif cur and w[0][0] in "xXmMdD": subs[cur].append(w)
top = [s for s in subs if s.startswith("tt_um")][0]
gate, sd, ndev = collections.defaultdict(int), collections.defaultdict(int), collections.Counter()
def walk(cell, prefix, pmap):
    for w in subs[cell]:
        t = [x for x in w if "=" not in x]; name, model, nets = t[0], t[-1], t[1:-1]
        g = lambda n: pmap.get(n, prefix + n)
        if model in subs:
            walk(model, prefix + name + "/", {p: g(n) for p, n in zip(pins[model], nets)})
        else:
            ndev[model] += 1
            if model.startswith(("nfet", "pfet")) and len(nets) >= 4:
                d, gt, s, b = [g(n) for n in nets[:4]]; gate[gt] += 1; sd[d] += 1; sd[s] += 1
            else:
                for n in nets: sd[g(n)] += 1
walk(top, "", {p: p for p in pins[top]})
ports = set(pins[top])
fl = sorted(n for n in gate if sd[n] == 0 and n not in ports)
print("devices:", dict(ndev))
print("nets that reach a gate:", len(gate))
print("of these, with no source, drain or diode and not a tile pin:", len(fl), fl[:20])
print("driven only from a tile pin:", sorted(n for n in gate if sd[n] == 0 and n in ports))

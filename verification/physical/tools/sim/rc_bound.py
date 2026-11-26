#!/usr/bin/env python3
"""Upper bound of the delay that wire resistance adds on each net: R_max x C, where R_max is the largest resistance
between a source or drain terminal (a driver) and a gate terminal (a load) of the net in the resistor network that
Magic's extresist writes, and C the whole capacitance on the net in the flat extraction without resistance.
usage: rc_bound.py <flat netlist with resistance> <flat netlist without resistance> [n]"""
import sys, re, collections
import numpy as np
fr, fc = sys.argv[1], sys.argv[2]; N = int(sys.argv[3]) if len(sys.argv) > 3 else 12
def val(s):
    m = re.match(r"([-0-9.e+]+)([a-z]*)", s.lower()); return float(m.group(1)) * {"": 1, "f": 1e-15, "p": 1e-12, "a": 1e-18}[m.group(2)]
base = lambda n: re.sub(r"\.(t|n)\d+$", "", n)
res = collections.defaultdict(list); drv = collections.defaultdict(set); load = collections.defaultdict(set)
for l in open(fr):
    w = l.split()
    if not w: continue
    if w[0][0] == "R" and len(w) >= 4: res[base(w[1])].append((w[1], w[2], float(w[3])))
    elif w[0][0] == "X":
        t = [x for x in w[1:] if "=" not in x]
        if t[-1].startswith(("nfet", "pfet")) and len(t) >= 5:
            d, g, s = t[0], t[1], t[2]; load[base(g)].add(g); drv[base(d)].add(d); drv[base(s)].add(s)
cap = collections.defaultdict(float)
for l in open(fc):
    w = l.split()
    if w and w[0][0] == "C" and len(w) >= 4:
        v = val(w[3]); cap[w[1]] += v; cap[w[2]] += v
rows = []
for net, R in res.items():
    if net in ("VDPWR", "VGND") or not load[net]: continue
    nodes = sorted({a for a, b, r in R} | {b for a, b, r in R}); ix = {n: i for i, n in enumerate(nodes)}
    D = [n for n in drv[net] if n in ix] or ([net] if net in ix else [])       # a pin of the tile drives it if no transistor does
    Lo = [n for n in load[net] if n in ix]
    if not D or not Lo: continue
    G = np.zeros((len(nodes), len(nodes)))
    for a, b, r in R:
        i, j = ix[a], ix[b]; g = 1 / max(r, 1e-6); G[i, i] += g; G[j, j] += g; G[i, j] -= g; G[j, i] -= g
    Z = np.linalg.pinv(G)
    rmax = max(Z[ix[a], ix[a]] + Z[ix[b], ix[b]] - 2 * Z[ix[a], ix[b]] for a in D for b in Lo)
    rows.append((rmax * cap[net], rmax, cap[net], net, len(Lo)))
rows.sort(reverse=True)
print(f"nets with a resistor network and at least one gate: {len(rows)}")
print("| Net (as the flat extraction names it) | Gates on it | Largest driver-to-gate resistance (ohm) | Capacitance (fF) | R x C (ps) |\n| --- | --- | --- | --- | --- |")
for rc, r, c, n, k in rows[:N]: print(f"| `{n}` | {k} | {r:.0f} | {c*1e15:.1f} | {rc*1e12:.2f} |")
want = sys.argv[4:]
for rc, r, c, n, k in rows:
    if n in want: print(f"| `{n}` | {k} | {r:.0f} | {c*1e15:.1f} | {rc*1e12:.2f} |")
print("median over all nets: %.3f ps; nets above 1 ps: %d; above 5 ps: %d" % (float(np.median([x[0] for x in rows])) * 1e12, sum(1 for x in rows if x[0] > 1e-12), sum(1 for x in rows if x[0] > 5e-12)))

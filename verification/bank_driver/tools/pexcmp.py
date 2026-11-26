#!/usr/bin/env python3
"""Compare two extracted netlists written by Magic (ext2spice) without regard to the order of lines, the names of
capacitors, the order of a capacitor's two nodes, or the order of a subcircuit's ports.
usage: pexcmp.py <a.spice> <b.spice>
Prints the number of devices and capacitors in each, and every entry that is in one file only. Capacitors of value 0
are listed separately: Magic writes or omits them from run to run."""
import sys, collections
def val(s):
    s = s.lower()
    for suf, m in (("ff", 1e-15), ("f", 1e-15), ("pf", 1e-12), ("p", 1e-12), ("a", 1e-18), ("n", 1e-9), ("u", 1e-6)):
        if s.endswith(suf):
            try: return float(s[:-len(suf)]) * m
            except ValueError: pass
    return float(s)
def canon(p):
    lines, cur = [], ""
    for l in open(p):
        l = l.rstrip("\n")
        if l.startswith("+"): cur += " " + l[1:].strip(); continue
        if cur: lines.append(cur)
        cur = l
    if cur: lines.append(cur)
    ports, dev, cap, zero, sub = {}, collections.Counter(), collections.Counter(), collections.Counter(), None
    for l in lines:
        t = l.split()
        if not t or l.startswith("*"): continue
        if t[0].lower() == ".subckt": sub = t[1]; ports[sub] = t[2:]; continue
        if t[0].lower() == ".ends": sub = None; continue
        if t[0][0] in "Cc" and len(t) == 4:
            a, b = sorted(t[1:3]); v = val(t[3])
            (zero if v == 0 else cap)[(sub, a, b, f"{v:.6g}")] += 1
        elif t[0][0] in "Xx" and t[-1] in ports:
            dev[(sub, t[-1], tuple(sorted(zip(ports[t[-1]], t[1:-1]))))] += 1     # connection by port name
        else:
            dev[(sub, " ".join(t[1:]))] += 1
    return ports, dev, cap, zero
(pa, da, ca, za), (pb, db, cb, zb) = canon(sys.argv[1]), canon(sys.argv[2])
print(f"a: {sum(da.values())} devices and instances, {sum(ca.values())} capacitors, {sum(za.values())} capacitors of value 0")
print(f"b: {sum(db.values())} devices and instances, {sum(cb.values())} capacitors, {sum(zb.values())} capacitors of value 0")
print("subcircuits whose ports are the same set in another order:", sorted(s for s in pa if s in pb and pa[s] != pb[s] and sorted(pa[s]) == sorted(pb[s])))
print("subcircuits with different ports:", sorted(s for s in set(pa) | set(pb) if sorted(pa.get(s, [])) != sorted(pb.get(s, []))))
for name, x, y in (("devices and instances", da, db), ("capacitors", ca, cb)):
    only_a, only_b = x - y, y - x
    print(f"{name} only in a: {sum(only_a.values())}; only in b: {sum(only_b.values())}")
    for k in list(only_a)[:10]: print("   a:", k)
    for k in list(only_b)[:10]: print("   b:", k)
print("total capacitance, a and b (fF):", round(sum(float(k[3]) * n for k, n in ca.items()) * 1e15, 4), round(sum(float(k[3]) * n for k, n in cb.items()) * 1e15, 4))

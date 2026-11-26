#!/usr/bin/env python3
"""Edge times and edge rates of the clock nets from the raw file of a whole-tile run (bench of
layout/make_tb_chip.py with the probes of isup_gen.py).

usage: edges_raw.py <raw> <vdd> [clk edge ns = 774.5] [window ns = 25]

For the trial whose capture edge follows the rising clk edge nearest the given time: the first crossing of vdd/2 after
that clk edge for clk, capture_local, bank_cap, bank_obs_clk, early_clk, selected_q, bank_selected_q and bank_early_q,
relative to the clk edge; and the time from 10 % to 90 % of vdd of the same edge for the four clock nets.
A net that does not cross in the window is reported as "no edge"."""
import sys, os, json
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from rawread import read_raw

raw, vdd = sys.argv[1], float(sys.argv[2])
tclk = float(sys.argv[3]) * 1e-9 if len(sys.argv) > 3 else 774.5e-9
win = float(sys.argv[4]) * 1e-9 if len(sys.argv) > 4 else 25e-9
names, D = read_raw(raw)
t = D[:, 0]
col = {n: i for i, n in enumerate(names)}

def v(n):
    for k in (f"v({n})", n):
        if k in col:
            return D[:, col[k]]
    return None

def cross(y, level, t0, t1, direction=None):
    """first crossing of level in [t0, t1]; returns (time, 'rise'|'fall') or None"""
    m = np.where((t >= t0) & (t <= t1))[0]
    for i in m[:-1]:
        a, b = y[i] - level, y[i + 1] - level
        if a == b:
            continue
        if (a < 0 <= b) or (a > 0 >= b):
            d = "rise" if b > a else "fall"
            if direction and d != direction:
                continue
            return t[i] + (t[i + 1] - t[i]) * (-a) / (b - a), d
    return None

clk = v("clk")
c0 = cross(clk, vdd / 2, tclk - 5e-9, tclk + 5e-9, "rise")
if c0 is None:
    sys.exit("no rising clk edge near %.1f ns" % (tclk * 1e9))
t0 = c0[0]
out = {"clk_edge_ns": t0 * 1e9, "edges_ps": {}, "rise_10_90_ps": {}}
print(f"rising clk edge at {t0 * 1e9:.3f} ns; times after it, at vdd/2 = {vdd / 2:.3f} V")
for n in ("clk", "p_capture_local", "p_bank_cap", "p_bank_obs_clk", "p_early_clk", "p_selected_q", "p_bank_selected_q", "p_bank_early_q"):
    y = v(n)
    if y is None:
        continue
    c = (t0, "rise") if n == "clk" else cross(y, vdd / 2, t0, t0 + win)
    lab = n[2:] if n.startswith("p_") else n
    if c is None:
        print(f"{lab:16s} no edge in {win * 1e9:.0f} ns")
        out["edges_ps"][lab] = None
        continue
    print(f"{lab:16s} {c[1]:4s} {(c[0] - t0) * 1e12:9.1f} ps")
    out["edges_ps"][lab] = [c[1], round((c[0] - t0) * 1e12, 1)]
    if lab in ("capture_local", "bank_cap", "bank_obs_clk", "early_clk") and c[1] == "rise":
        a = cross(y, 0.1 * vdd, c[0] - win, c[0] + win, "rise")
        # the 10 % crossing that belongs to this edge is the last one before the 50 % crossing
        m = np.where((t >= c[0] - win) & (t <= c[0]))[0]
        ta = None
        for i in m[:-1][::-1]:
            if y[i] < 0.1 * vdd <= y[i + 1]:
                ta = t[i] + (t[i + 1] - t[i]) * (0.1 * vdd - y[i]) / (y[i + 1] - y[i]); break
        b = cross(y, 0.9 * vdd, c[0], c[0] + win, "rise")
        if ta is not None and b is not None:
            out["rise_10_90_ps"][lab] = round((b[0] - ta) * 1e12, 1)
            print(f"{'':16s} rise 10 to 90 %: {(b[0] - ta) * 1e12:7.1f} ps")
if len(sys.argv) > 5:
    json.dump(out, open(sys.argv[5], "w"), indent=1)

#!/usr/bin/env python3
"""One floor at one condition: predicts the floor delay from the typical floors of the revised layout (25 C,
verification/bank/sim/floors.txt) scaled by the ratio of the plateau delay d(ua[0] = VDD) of this condition to that
of the typical corner, and calls floor.py. The prediction only places the first bracket of the bisection.
usage: floors_job.py <573|703> <corner> <vdd> <temp> <dut> <rise|fall>"""
import sys, os, json, subprocess
ext, corner, vdd, temp, dut, pol = sys.argv[1:7]
W = "/home/claude/work"
TYP = {(1, "rise"): 2347.1, (1, "fall"): 2734.2, (2, "rise"): 1692.6, (2, "fall"): 2255.0,
       (3, "rise"): 1827.6, (3, "fall"): 2451.8, (4, "rise"): 1772.3, (4, "fall"): 2391.5}
def curve(e, c, v, t): return f"{W}/sim/dly/dly_post{e}_{c}_{float(v)}_{float(t)}.json"
def dcap(path):
    P = json.load(open(path))["points"]; k = max(float(u) for u, p in P.items() if p.get("d_ps")); return P[f"{k:.4f}"]["d_ps"]
ctemp = temp if os.path.exists(curve(ext, corner, vdd, temp)) else "27.0"
cv = curve(ext, corner, vdd, ctemp)
s = dcap(cv) / dcap(curve("573", "typical", 3.3, 27))
dpred = TYP[(int(dut), pol)] * s
print(f"predicted floor {dpred:.0f} ps (scale {s:.3f})", flush=True)
sys.exit(subprocess.run(["python3", f"{W}/scripts/floor.py", f"{W}/sim/cut/body_{ext}.spice", f"{W}/sim/floor", "post" + ext,
                         corner, vdd, temp, dut, pol, cv, f"{dpred:.1f}"]).returncode)

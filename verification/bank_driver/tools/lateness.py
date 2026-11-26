#!/usr/bin/env python3
"""Movement of the last output crossing with the distance of the data edge from the critical time.
usage: lateness.py <tchar json> [<tchar json> ...]
For each file (clocked captures of tchar.py): the last crossing of the output, on a fixed time axis (the capture edge
of the ordinary capture), for the captures on the side where the new value is taken; its step for each factor of
sqrt(10) in the distance; the smallest and largest step for distances from 1.5e-12 s to 1.5e-15 s; and the slope
of a straight line of the last crossing against ln(distance) for distances of 1.5e-13 s and less (tail)."""
import sys, json, math
import numpy as np
def lateness(path):
    T = json.load(open(path))
    new = sorted((r for r in T["rows"] if r["side"] == "new"), key=lambda r: -r["delta_s"]); ref = new[0]["tcl"]
    d = [r["delta_s"] for r in new]; tl = [(r["ts"] - ref) * 1e12 for r in new]
    st = [(d[i + 1], tl[i + 1] - tl[i]) for i in range(len(d) - 1)]
    sel = [x for dd, x in st if 1.4e-15 <= dd <= 1.6e-12]
    m = [i for i in range(len(d)) if d[i] <= 1.5e-13 * 1.001]
    tau = -np.polyfit(np.log([d[i] for i in m]), [tl[i] for i in m], 1)[0]
    return {"steps_ps": [min(sel), max(sel)], "tail_ps": float(tau), "all_steps": [[dd, round(x, 2)] for dd, x in st],
            "last_crossing_ps": [[dd, round(x, 1)] for dd, x in zip(d, tl)]}
if __name__ == "__main__":
    k = math.log(math.sqrt(10))
    for p in sys.argv[1:]:
        L = lateness(p)
        print(p.split("/")[-1])
        print("   steps per factor of sqrt(10), distance 1.5e-12 to 1.5e-15 s: %.1f to %.1f ps  (local time constant %.1f to %.1f ps)" % (L["steps_ps"][0], L["steps_ps"][1], L["steps_ps"][0] / k, L["steps_ps"][1] / k))
        print("   tail (distance <= 1.5e-13 s): %.2f ps" % L["tail_ps"])
        print("   distance (s), step (ps): " + ", ".join(f"{dd:.1e}: {x}" for dd, x in L["all_steps"]))

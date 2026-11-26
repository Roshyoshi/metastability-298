#!/usr/bin/env python3
"""Predicted count against the delay for one flip-flop, from its clocked captures (tchar.py) and its floors.
Count model of the second check (verification/independent/README.md, Section 8), written again for the result
files of this folder: the early observer samples the selected output at t_ord + (d - d_F) after the capture edge
at the flip-flop, where t_ord is the last crossing of half the supply by the ordinary transition (the capture 1.5 ns
ahead of the critical time) and d_F the floor for that data direction. Every time is counted from the capture edge
at the flip-flop of its own capture. A capture on the side where the new value is taken
counts when the output crosses later than the sample. With the last crossing rising steadily as the data edge
approaches the critical time, the counted data times are those closer than delta*(d), found by interpolation of
ln(delta) in the stored last crossings and, beyond the closest stored capture, by a straight line through the
captures at 1.5e-13 s and closer. On the other side a capture counts between the first and the last crossing, if the
output crosses at all. w(d) is the sum over both data directions; K per block = 65,535 f w.
usage: count_model.py <label> <tchar rise json> <tchar fall json> <d_F rise ps> <d_F fall ps> <latch tau ps> [out json]"""
import sys, os, json, math
import numpy as np
label, frise, ffall, dfr, dff, tau = sys.argv[1:7]; dfr, dff, tau = float(dfr), float(dff), float(tau)
out = sys.argv[7] if len(sys.argv) > 7 else None

class Side:
    def __init__(self, path, dF):
        J = json.load(open(path)); self.J = J; self.dF = dF * 1e-12; T_C = J["T_C"]
        new = sorted((r for r in J["rows"] if r["side"] == "new"), key=lambda r: -r["delta_s"])
        # Times are counted from the capture edge at the flip-flop in each capture (tcl). That edge moves with the state
        # of the master latch (tcl_shift: up to tens of ps between an ordinary and a near-critical capture), and the
        # early clock is made from the same edge, so it moves with it (33 of 38 ps in the case examined).
        # With ABS=1 (the bank) every time is counted from the capture edge of the ordinary capture instead: the bank's
        # early clock comes from a pin and does not move with the capture edge at the flip-flops.
        ref = new[0]["tcl"]; ABS = os.environ.get("ABS") == "1"
        self.delta = np.array([r["delta_s"] for r in new]); self.tl = np.array([r["ts"] - (ref if ABS else r["tcl"]) for r in new])
        self.tcl_shift = [float((r["tcl"] - ref) * 1e12) for r in new]
        self.raw_tl = self.tl.copy()
        self.tl = np.maximum.accumulate(self.tl) + 1e-18 * np.arange(len(self.tl))     # non-decreasing towards the critical time
        self.t_ord = self.tl[0]
        self.not_rising = int(np.sum(np.diff(self.raw_tl) <= 0))        # captures whose last crossing is not later than that of the capture before
        m = self.delta <= 1.5e-13 * 1.001
        self.slope, self.icpt = np.polyfit(np.log(self.delta[m]), self.tl[m], 1)       # tl = icpt + slope ln(delta); slope = -tau_c
        self.tail_tau = -self.slope; self.tail_n = int(m.sum())
        self.old = [(r["delta_s"], r["ts1"] - r["tcl"], r["ts"] - r["tcl"]) for r in J["rows"] if r["side"] == "old" and r["ts1"] > r["tcl"]]      # only crossings after the capture edge at the flip-flop
    def w_new(self, d):
        ts = self.t_ord + (d - self.dF)
        if ts <= self.tl[0]: return self.delta[0]
        if ts <= self.tl[-1]: return math.exp(np.interp(ts, self.tl, np.log(self.delta)))
        return math.exp((ts - self.icpt) / self.slope)
    def local_tau(self):
        ld = np.log(self.delta); return [(float(self.delta[i + 1]), float(-(self.tl[i + 1] - self.tl[i]) / (ld[i + 1] - ld[i]))) for i in range(len(ld) - 1)]

R, F = Side(frise, dfr), Side(ffall, dff)
w = lambda d: R.w_new(d) + F.w_new(d)
def fit(a, b):
    g = np.arange(a, b + 1e-15, 10e-12); return float(-1 / np.polyfit(g, [math.log(w(x)) for x in g], 1)[0])
def local(d, h=50e-12): return -(2 * h) / (math.log(w(d + h)) - math.log(w(d - h)))
lo = max(R.dF, F.dF)
ds = None
for d0 in np.arange(lo, lo + 3.0e-9, 10e-12):
    tc = fit(d0, d0 + 0.6e-9)
    if all(abs(local(x) / tc - 1) <= 0.05 for x in np.arange(d0, d0 + 0.6e-9 + 1e-15, 10e-12)):
        ds = float(d0); break
res = {"label": label, "floor_rise_ps": dfr, "floor_fall_ps": dff, "latch_tau_ps": tau,
       "t_ord_rise_ps": R.t_ord * 1e12, "t_ord_fall_ps": F.t_ord * 1e12,
       "tail_tau_rise_ps": R.tail_tau * 1e12, "tail_tau_fall_ps": F.tail_tau * 1e12, "tail_points": [R.tail_n, F.tail_n],
       "other_side_crossings": {"rise": R.old, "fall": F.old},
       "time_reference": "ordinary capture" if os.environ.get("ABS") == "1" else "each capture", "not_rising": [R.not_rising, F.not_rising],
       "capture_edge_at_the_flip_flop_later_than_in_the_ordinary_capture_ps": {"rise": R.tcl_shift, "fall": F.tcl_shift},
       "local_tau_of_last_crossing_ps": {"rise": [(d, t * 1e12) for d, t in R.local_tau()], "fall": [(d, t * 1e12) for d, t in F.local_tau()]},
       "straight_part_from_ps": ds * 1e12 if ds else None, "table": []}
print(f"## {label}: floors {dfr:.1f} (rising) and {dff:.1f} ps (falling); latch tau {tau:.2f} ps")
print(f"ordinary transition, last crossing after the capture edge: {R.t_ord*1e12:.1f} ps (rising), {F.t_ord*1e12:.1f} ps (falling)")
print(f"tail fit of the last crossing (captures at 1.5e-13 s and closer): {R.tail_tau*1e12:.2f} ps (rising, {R.tail_n} points), {F.tail_tau*1e12:.2f} ps (falling, {F.tail_n} points)")
print(f"crossings on the side where the new value is not taken: rising {len(R.old)}, falling {len(F.old)}")
print(f"time reference: {'the capture edge of the ordinary capture (ABS=1)' if os.environ.get('ABS') == '1' else 'the capture edge at the flip-flop of each capture'}; captures whose last crossing is not later than the one before: {R.not_rising} (rising), {F.not_rising} (falling)")
print(f"capture edge at the flip-flop, later than in the ordinary capture when the data edge is within 1e-13 s of the critical time: {R.tcl_shift[-1]:.1f} ps (rising), {F.tcl_shift[-1]:.1f} ps (falling)")
print(f"straight part (local time constants within 5 % of the fit over 0.6 ns) begins at d = {ds*1e12:.0f} ps, {ds*1e12-lo*1e12:.0f} ps above the higher floor" if ds else "no straight part found within 3 ns of the higher floor")
print("| d (ns) | above the higher floor (ns) | w (s) | share of rising data | events per block per MHz | local time constant (ps) |\n| --- | --- | --- | --- | --- | --- |")
for x in np.arange(math.ceil(lo * 1e10) / 1e10, lo + 3.25e-9, 0.2e-9):
    wr, wf = R.w_new(x), F.w_new(x); k = 65535 * 1e6 * (wr + wf)
    res["table"].append({"d_ns": x * 1e9, "w_s": wr + wf, "w_rise_s": wr, "w_fall_s": wf, "events_per_block_per_MHz": k, "local_tau_ps": local(x) * 1e12})
    print(f"| {x*1e9:.2f} | {(x-lo)*1e9:.2f} | {wr+wf:.3g} | {wr/(wr+wf):.2g} | {k:.3g} | {local(x)*1e12:.1f} |")
if ds:
    res["fits"] = {}
    for a, b in ((ds, ds + 0.6e-9), (ds + 1.0e-9, ds + 2.0e-9)):
        t = fit(a, b); res["fits"][f"{a*1e9:.2f}-{b*1e9:.2f}"] = t * 1e12
        print(f"counted time constant over d = {a*1e9:.2f} to {b*1e9:.2f} ns: {t*1e12:.2f} ps, {t*1e12/tau:.3f} of the latch time constant")
if out: json.dump(res, open(out, "w"), indent=1)

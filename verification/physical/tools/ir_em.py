#!/usr/bin/env python3
"""Supply current, voltage drop and electromigration ratios of the tile.

usage: ir_em.py <tag>.raw <tag>_probes.json <rail_geom.json> <out json> [--vdd 3.3] [--t0 ns] [--rs 0.090] [--rvia 4.5]

Inputs
  <tag>.raw            whole-tile transient written by the bench of isup_gen.py: i(VDD), i(VGS) and the supply
                       currents of every cell instance (0 V sources in series with its VDPWR and VGND pins)
  rail_geom.json       from rail_geom.py: the Metal1 rails (0.60 um), their via stacks and the rail of each instance
Model of the supply network (resistances only):
  rail      Metal1, bare width from the GDS, sheet resistance --rs (ohm per square)
  stack     Via1 + Via2 + Via3 in series, --rvia each; one stack per Via1 found on the rail
  stripe    Metal4, 2.00 um wide, sheet resistance --rs; three per supply
  strap     the Metal3 strap that joins the three stripes of a supply near y = 6 to 7 um (0.56 um wide)
  feed      where the shuttle's Metal5 straps meet the stripes (not part of the tile's layout). Two cases:
            "straps"  VDPWR at y = 162.68 + k x 41.16 um, k = -1, 0, 1 (19.75 um wide); VGND at
                      y = 162.68 + (k + 1/2) x 41.16 um (8.75 um wide); from tt-multiplexer, ol2/tt_top
            "end"     only at the lower end of the stripes (y = 5 um), the far end from every cell: an upper bound
  load      each cell's current enters its rail at the centre of the cell
Outputs: totals (average, rms, peak); per cell, the drop of its VDPWR rail and the rise of its VGND rail, for the
average current (static) and the largest value over time (all cell currents at each instant, no capacitance);
average currents of stripes, rails and via stacks against the limits of design manual section 14.2.
"""
import sys, json, argparse, numpy as np
import scipy.sparse as sp, scipy.sparse.linalg as spl
sys.path.insert(0, __import__("os").path.dirname(__file__))
from rawread import read_raw

ap = argparse.ArgumentParser()
ap.add_argument("raw"); ap.add_argument("probes"); ap.add_argument("geom"); ap.add_argument("out")
ap.add_argument("--vdd", type=float, default=3.3)
ap.add_argument("--t0", type=float, default=None, help="statistics from this time (ns); default: after `run` rises (700 ns)")
ap.add_argument("--rs", type=float, default=0.090); ap.add_argument("--rvia", type=float, default=4.5)
A = ap.parse_args()
names, D = read_raw(A.raw)
t = D[:, 0]; col = {n: i for i, n in enumerate(names)}
P = json.load(open(A.probes)); G = json.load(open(A.geom))
def cur(name):
    for k in (f"i({name})", f"{name}#branch"):
        if k in col: return D[:, col[k]]
    raise KeyError(name)
def stats(x, m):
    tt, xx = t[m], x[m]; T = tt[-1] - tt[0]
    avg = np.trapezoid(xx, tt) / T; rms = np.sqrt(np.trapezoid(xx * xx, tt) / T)
    k = np.abs(xx).argmax()
    return {"avg_uA": avg * 1e6, "rms_uA": rms * 1e6, "peak_uA": xx[k] * 1e6, "t_peak_ns": tt[k] * 1e9}
t0 = (A.t0 if A.t0 is not None else 700.0) * 1e-9
# whole trials only: the stimulus repeats every 200 ns (count pulses from 924.6 ns)
m_run = (t >= t0) & (t <= t0 + 200e-9 * int((t[-1] - t0) / 200e-9))
m_all = t >= 0
idd = -cur("vdd"); ignd = cur("vgs")
res = {"window_ns": [t[m_run][0] * 1e9, t[m_run][-1] * 1e9], "points": int(len(t)),
       "total": {"VDPWR": stats(idd, m_run), "VGND": stats(ignd, m_run),
                 "VDPWR_whole_run": stats(idd, m_all), "VGND_whole_run": stats(ignd, m_all)}}
# charge per edge: the largest charge drawn from VDPWR above the average within 1 ns and within 5 ns
def qmax(x, m, win):
    tt, xx = t[m], x[m]; q = np.concatenate([[0], np.cumsum(0.5 * (xx[1:] + xx[:-1]) * np.diff(tt))])
    grid = np.arange(tt[0], tt[-1] - win, 20e-12); qa = np.interp(grid, tt, q); qb = np.interp(grid + win, tt, q)
    k = (qb - qa).argmax(); return (qb - qa)[k], grid[k]
for win in (0.2e-9, 1e-9, 5e-9):
    q, tq = qmax(idd, m_run, win); res["total"][f"charge_fC_in_{win*1e9:g}ns"] = {"fC": q * 1e15, "t_ns": tq * 1e9}
# per-cell currents
inst = [n for n in P if n in G["inst"]]
miss = [n for n in P if n not in G["inst"]]
assert not miss, miss[:5]
Ip = np.array([cur(P[n]["ip"]) for n in inst]); Ig = np.array([cur(P[n]["ig"]) for n in inst])
res["sum_check"] = {"sum_cells_VDPWR_avg_uA": float(np.trapezoid(Ip.sum(0)[m_run], t[m_run]) / (t[m_run][-1] - t[m_run][0]) * 1e6),
                    "sum_cells_VGND_avg_uA": float(np.trapezoid(Ig.sum(0)[m_run], t[m_run]) / (t[m_run][-1] - t[m_run][0]) * 1e6)}

from irnet import network as _network, FEEDS, STRIPE_X
def network(net, feed):
    return _network(G, inst, net, feed, A.rs, A.rvia)

EM = {"metal_mA_per_um": {"85C": 2.09, "110C": 1.0, "125C": 0.67}, "via_mA": {"85C": 0.58, "110C": 0.28, "125C": 0.18}}
res["model"] = {"rs_ohm_sq": A.rs, "rvia_ohm": A.rvia, "feeds": {k: v for k, v in FEEDS.items()}, "em_limits": EM}
tm = t[m_run]; T = tm[-1] - tm[0]
avgp = np.trapezoid(Ip[:, m_run], tm, axis=1) / T; avgg = np.trapezoid(Ig[:, m_run], tm, axis=1) / T
res["cells"] = {}
for fname, feed in FEEDS.items():
    out = {}
    for net, I, avg in (("VDPWR", Ip, avgp), ("VGND", Ig, avgg)):
        nw = network(net, feed)
        dc = nw["Z"] @ avg                              # static drop at each cell, V
        dyn = nw["Z"] @ I[:, m_all]                     # at each instant
        kmax = np.unravel_index(np.abs(dyn).argmax(), dyn.shape)
        per = {n: {"static_mV": float(dc[i] * 1e3), "peak_mV": float(dyn[i, np.abs(dyn[i]).argmax()] * 1e3),
                   "t_peak_ns": float(t[m_all][np.abs(dyn[i]).argmax()] * 1e9)} for i, n in enumerate(inst)}
        # branch currents for the average load
        v = nw["V"] @ avg; vfull = np.zeros(len(nw["nodes"])); vfull[nw["free"]] = v
        ib = [(vfull[a] - vfull[b]) / R for a, b, R in nw["edges"]]
        rail_i = max(((abs(ib[k]), r, a, b, w) for k, r, a, b, w in nw["meta"]["rail_seg"]), default=(0,))
        stack_i = max(((abs(ib[k]), r, x) for k, r, x in nw["meta"]["stack"]), default=(0,))
        stripe_i = max(((abs(ib[k]), s, a, b) for k, s, a, b in nw["meta"]["stripe_seg"]), default=(0,))
        # per-stripe total current delivered = sum of stack currents per stripe
        per_stripe = [0.0, 0.0, 0.0]
        for k, r, x in nw["meta"]["stack"]:
            s = int(np.argmin([abs(x - sx) for sx in STRIPE_X[net]])); per_stripe[s] += abs(ib[k])
        wi = int(np.abs(dc).argmax())
        out[net] = {"worst_static": {"cell": inst[wi], "mV": float(dc[wi] * 1e3)},
                    "worst_peak": {"cell": inst[kmax[0]], "mV": float(dyn[kmax] * 1e3), "t_ns": float(t[m_all][kmax[1]] * 1e9)},
                    "rail_max_avg_uA": rail_i[0] * 1e6, "rail_at": list(rail_i[1:]),
                    "stack_max_avg_uA": stack_i[0] * 1e6, "stack_at": list(stack_i[1:]),
                    "stripe_seg_max_avg_uA": stripe_i[0] * 1e6, "stripe_at": list(stripe_i[1:]),
                    "per_stripe_avg_uA": [x * 1e6 for x in per_stripe],
                    "em_ratio_125C": {"rail": rail_i[0] * 1e3 / (EM["metal_mA_per_um"]["125C"] * 0.60),
                                      "stripe": stripe_i[0] * 1e3 / (EM["metal_mA_per_um"]["125C"] * 2.0),
                                      "via": stack_i[0] * 1e3 / EM["via_mA"]["125C"]},
                    "r_eff_ohm": {n: float(nw["Z"][i, i]) for i, n in enumerate(inst)}}
        for n in inst:
            res["cells"].setdefault(n, {"cell": P[n]["cell"], "bbox": G["inst"][n]["bbox"]})[f"{fname}_{net}"] = per[n]
    res[fname] = out
for i, n in enumerate(inst):
    res["cells"][n].update({"avg_uA": float(avgp[i] * 1e6), "peak_uA": float(Ip[i, np.abs(Ip[i]).argmax()] * 1e6),
                            "gnd_avg_uA": float(avgg[i] * 1e6), "gnd_peak_uA": float(Ig[i, np.abs(Ig[i]).argmax()] * 1e6)})
json.dump(res, open(A.out, "w"), indent=1)
T_ = res["total"]
print(f"window {res['window_ns'][0]:.1f} to {res['window_ns'][1]:.1f} ns, {res['points']} points")
for k in ("VDPWR", "VGND"):
    s = T_[k]; print(f"  {k}: average {s['avg_uA']:.1f} uA, rms {s['rms_uA']:.1f} uA, peak {s['peak_uA']:.1f} uA at {s['t_peak_ns']:.2f} ns")
s = T_["VDPWR_whole_run"]; print(f"  VDPWR whole run: average {s['avg_uA']:.1f} uA, rms {s['rms_uA']:.1f}, peak {s['peak_uA']:.1f} uA at {s['t_peak_ns']:.2f} ns")
print("  charge:", {k: (round(v['fC'], 1), round(v['t_ns'], 2)) for k, v in T_.items() if k.startswith("charge")})
print("  sum of cell currents:", res["sum_check"])
for fname in FEEDS:
    for net in ("VDPWR", "VGND"):
        o = res[fname][net]
        print(f"  feed {fname:6s} {net}: worst static {o['worst_static']['mV']:.3f} mV ({o['worst_static']['cell'][-22:]}), worst peak {o['worst_peak']['mV']:.2f} mV "
              f"({o['worst_peak']['cell'][-22:]} at {o['worst_peak']['t_ns']:.2f} ns); avg current max: rail {o['rail_max_avg_uA']:.1f} uA, stack {o['stack_max_avg_uA']:.1f} uA, "
              f"stripe segment {o['stripe_seg_max_avg_uA']:.1f} uA; EM ratios at 125 C: rail {o['em_ratio_125C']['rail']:.4f}, stripe {o['em_ratio_125C']['stripe']:.4f}, via {o['em_ratio_125C']['via']:.4f}")

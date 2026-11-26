#!/usr/bin/env python3
"""Floor of the early sample in continuous operation, on the cut-out (bench of r7/prereg/tools/floor7.py, which is
that of the second check, Section 7): three trials 10 ns x SCALE apart, the data toggled 2 ns x SCALE before each
capture, the third trial examined; ua[0] bisected until the early sample catches the new value; the floor is the
delay d (capture_local to early_clk) of the third trial at that voltage. tran 2p, no .options line; if ngspice
stops with "timestep too small" the run is repeated once with a maximum step of 5 ps.
usage: floor.py <body> <outdir> <tag> <corner> <vdd> <temp> <dut 1-4> <rise|fall> <delay-curve json> <d_pred_ps>
env: SCALE (default 1), VTOL (default 2.5e-4 V), FRAC (default 0.08). Restart-safe (cache per floor)."""
import sys, os, json, math, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import simlib as S
body, outdir, tag, corner, vdd, temp, dut, pol, curve, dpred = sys.argv[1:11]
vdd = float(vdd); temp = float(temp); dut = int(dut); dpred = float(dpred); h = vdd / 2
SC = float(os.environ.get("SCALE", "1")); VTOL = float(os.environ.get("VTOL", "2.5e-4")); FRAC = float(os.environ.get("FRAC", "0.08"))
outdir = os.path.abspath(outdir); os.makedirs(outdir + "/decks", exist_ok=True); os.makedirs(outdir + "/cache", exist_ok=True)
name = f"floor_{tag}_{corner}_{vdd}_{temp}_d{dut}{pol}"; rpath = f"{outdir}/{name}.json"
if os.path.exists(rpath):
    print(f"RESULT {name}: exists, skipped"); sys.exit(0)
cpath = f"{outdir}/cache/{name}.json"; cache = S.jload(cpath)
seq = [1, 0, 1] if pol == "rise" else [0, 1, 0]
T = lambda x: f"{x*SC:g}n"
lvl = lambda b: vdd if b else 0.0
dpwl = f"PWL(0 {lvl(seq[0])} {T(9)} {lvl(seq[0])} {T(9.1)} {lvl(seq[1])} {T(19)} {lvl(seq[1])} {T(19.1)} {lvl(seq[2])})"
cpwl = "PWL(" + " ".join(f"{T(a) if a else 0} {x}" for a, x in [(0, 0), (1, 0), (1.05, vdd), (7, vdd), (7.05, 0), (11, 0), (11.05, vdd),
                                                                (17, vdd), (17.05, 0), (21, 0), (21.05, vdd), (27, vdd), (27.05, 0)]) + ")"
edge = "rise" if seq[2] else "fall"

def run(v):
    key = f"{v:.9f}"
    if key not in cache:
        def deck(tmax):
            L = S.header(f"floor {tag} dut{dut} {pol} {corner} {vdd} {temp} V={v}", body, corner, vdd, temp)
            L += S.pins(vdd, dut=dut, data=dpwl, ua0=key, capture=cpwl)
            L += [".control", "set filetype=ascii", "set num_threads=1", f"tran 2p {T(31)}" + (f" 0 {tmax}" if tmax else ""),
                  "let d3=-1", "let d2=-1", "let ar=-1",
                  f"meas tran d3 trig v(capture_local) val={h} td={T(20)} rise=1 targ v(early_clk) val={h} td={T(20)} rise=1",
                  f"meas tran d2 trig v(capture_local) val={h} td={T(10)} rise=1 targ v(early_clk) val={h} td={T(10)} rise=1",
                  f"meas tran ar trig v(capture_local) val={h} td={T(20)} rise=1 targ v(selected_q) val={h} td={T(20)} {edge}=1",
                  f"meas tran e3 find v(early_q) at={T(30)}", f"meas tran s3 find v(selected_q) at={T(30)}",
                  f"meas tran e2 find v(early_q) at={T(20.5)}", f"meas tran s2 find v(selected_q) at={T(20.5)}",
                  "let a=d3*1e12", "let b=d2*1e12", "let c=ar*1e12",
                  "echo RESULT d3 $&a", "echo RESULT d2 $&b", "echo RESULT e3 $&e3", "echo RESULT s3 $&s3",
                  "echo RESULT e2 $&e2", "echo RESULT s2 $&s2", "echo RESULT ar $&c", ".endc", ".end"]
            return L
        p = f"{outdir}/decks/{name}_{key}.spice"
        r, out = S.run(p, deck(None))
        if r.get("d3") is None or r.get("e3") is None or r["d3"] < -1e11:
            r, out = S.run(p.replace(".spice", "_tmax5p.spice"), deck("5p"))
        if r.get("d3") is None or r.get("e3") is None:
            open(p.replace(".spice", ".log"), "w").write(out); raise SystemExit(f"no result for {p}")
        cache[key] = [r["d3"], r["d2"], r["e3"], r["s3"], r["e2"], r["s2"], r["ar"]]; S.jsave(cpath, cache)
        if os.path.exists(p): os.remove(p)
    d3, d2, e3, s3, e2, s2, ar = cache[key]
    if d3 <= 0: raise SystemExit(f"{name}: no early clock in the third trial at V={v}")
    assert (s3 > h) == bool(seq[2]), f"selected output did not take the new value: {s3}"
    return d3, (e3 > h) != (s3 > h), (e2 > h) != (s2 > h), ar

pts = sorted((float(k), p["d_ps"]) for k, p in json.load(open(curve))["points"].items() if p.get("d_ps"))
def v_of_d(d):
    for (v1, d1), (v2, d2) in zip(pts, pts[1:]):
        if d1 >= d >= d2:
            return v1 + (v2 - v1) * (math.log(d1) - math.log(d)) / (math.log(d1) - math.log(d2))
    return pts[0][0] if d > pts[0][1] else pts[-1][0]
t0 = time.time(); dmax_ok = 4.6e3 * SC; frac = FRAC
while True:
    lo = v_of_d(min(dpred * (1 + frac), dmax_ok)); hi = v_of_d(dpred * (1 - frac))
    dlo, evlo, _, _ = run(lo); dhi, evhi, _, _ = run(hi)
    if (not evlo) and evhi: break
    if frac > 0.6:
        print(f"RESULT {name}: bracket fails (event at lo={evlo}, at hi={evhi}; d {dlo:.1f}/{dhi:.1f} ps at V {lo:.4f}/{hi:.4f})"); sys.exit(1)
    frac *= 2.2
hist = []
while hi - lo > VTOL:
    mid = 0.5 * (lo + hi); d3, ev3, ev2, ar = run(mid); hist.append((mid, d3, ev3, ev2, ar))
    if ev3: hi, dhi = mid, d3
    else: lo, dlo = mid, d3
_, _, _, ar_lo = run(lo)
S.jsave(rpath, {"tag": tag, "dut": dut, "pol": pol, "corner": corner, "vdd": vdd, "temp": temp, "scale": SC, "body": os.path.abspath(body),
                "V_floor": [lo, hi], "d_floor_ps": [dlo, dhi], "arrival_selected_q_ps": ar_lo, "d_pred_ps": dpred,
                "history": hist, "simulations": len(cache), "wall_s": round(time.time() - t0, 1)})
print(f"RESULT {name}: floor d = {dlo:.1f} .. {dhi:.1f} ps at V = {lo:.5f} .. {hi:.5f}; arrival {ar_lo:.1f} ps; {len(cache)} simulations, {time.time()-t0:.0f} s", flush=True)

#!/usr/bin/env python3
"""Floor of the early sample of the bank in continuous operation, on the cut-out: the bench of floor.py (three
trials 10 ns apart, the bank data toggled 2 ns before each capture, the third trial examined) with the bank's own
path: the capture edge is applied as a 50 ps ramp on `bank_a` (output of the bank's trial flip-flop; the extracted
buffers carry it to the flip-flops as `bank_cap`), the early observer is clocked from the pin ui_in[5], whose rising
edge (0.1 ns) comes x after the start of each capture ramp. x is bisected until the early sample catches the new
value. Reported: t = bank_cap -> bank_obs_clk (both rising through VDD/2) of the third trial at the boundary, the
quantity that plays the part of d for the bank; x itself; and the arrival of the new value at the bank selector.
usage: floor_bank.py <body> <outdir> <tag> <corner> <vdd> <temp> <n1|n2|n3> <rise|fall>      (restart-safe)"""
import sys, os, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import simlib as S
body, outdir, tag, corner, vdd, temp, ff, pol = sys.argv[1:9]
vdd = float(vdd); temp = float(temp); h = vdd / 2; k = int(ff[1])
XTOL = float(os.environ.get("XTOL", "0.5e-12"))
outdir = os.path.abspath(outdir); os.makedirs(outdir + "/decks", exist_ok=True); os.makedirs(outdir + "/cache", exist_ok=True)
name = f"floorbank_{tag}_{corner}_{vdd}_{temp}_{ff}{pol}"; rpath = f"{outdir}/{name}.json"
if os.path.exists(rpath):
    print(f"RESULT {name}: exists, skipped"); sys.exit(0)
cpath = f"{outdir}/cache/{name}.json"; cache = S.jload(cpath)
seq = [1, 0, 1] if pol == "rise" else [0, 1, 0]
lvl = lambda b: vdd if b else 0.0
dpwl = f"PWL(0 {lvl(seq[0])} 9n {lvl(seq[0])} 9.1n {lvl(seq[1])} 19n {lvl(seq[1])} 19.1n {lvl(seq[2])})"
cpwl = "PWL(" + " ".join(f"{a}n {x}" for a, x in [(0, 0), (1, 0), (1.05, vdd), (7, vdd), (7.05, 0), (11, 0), (11.05, vdd),
                                                 (17, vdd), (17.05, 0), (21, 0), (21.05, vdd), (27, vdd), (27.05, 0)]) + ")"
edge = "rise" if seq[2] else "fall"
def run(x):
    key = f"{x:.6e}"
    if key not in cache:
        pts = []
        for t0 in (1e-9, 11e-9, 21e-9):
            pts += [(t0 + x, 0), (t0 + x + 0.1e-9, vdd), (t0 + x + 3.0e-9, vdd), (t0 + x + 3.1e-9, 0)]
        opwl = "PWL(0 0 " + " ".join(f"{t:.7e} {v}" for t, v in pts) + ")"
        L = S.header(f"bank floor {tag} {ff} {pol} {corner} {vdd} {temp} x={x}", body, corner, vdd, temp)
        L += S.pins(vdd, dut=2, data="0", ua0="1.8", capture="0", bank={"sel": k - 1, "data": dpwl, "obs": opwl}, extra=[f"VFBA bank_a 0 {cpwl}"])
        L0 = list(L)
        L += [".control", "set filetype=ascii", "set num_threads=1", "tran 2p 34n", "let t3=-1", "let ar=-1",
              f"meas tran t3 trig v(bank_cap) val={h} td=20n rise=1 targ v(bank_obs_clk) val={h} td=20n rise=1",
              f"meas tran ar trig v(bank_cap) val={h} td=20n rise=1 targ v(bank_selected_q) val={h} td=20n {edge}=1",
              "meas tran e3 find v(bank_early_q) at=30.5n", "meas tran s3 find v(bank_selected_q) at=30.5n",
              "let a=t3*1e12", "let c=ar*1e12", "echo RESULT t3 $&a", "echo RESULT e3 $&e3", "echo RESULT s3 $&s3", "echo RESULT ar $&c", ".endc", ".end"]
        p = f"{outdir}/decks/{name}_{key}.spice"; r, out = S.run(p, L)
        if r.get("t3") is None or r.get("e3") is None or r["t3"] < -1e11:
            # ngspice stopped ("timestep too small"): repeat once with a maximum step of 5 ps, as floor.py does
            L2 = [x.replace("tran 2p 34n", "tran 2p 34n 0 5p") for x in L]
            r, out = S.run(p.replace(".spice", "_tmax5p.spice"), L2)
        if r.get("t3") is None or r.get("e3") is None:
            open(p.replace(".spice", ".log"), "w").write(out); raise SystemExit(f"no result for {p}")
        cache[key] = [r["t3"], r["e3"], r["s3"], r["ar"]]; S.jsave(cpath, cache); os.remove(p)
    t3, e3, s3, ar = cache[key]
    assert (s3 > h) == bool(seq[2]), f"selected output did not take the new value: {s3}"
    return t3, (e3 > h) != (s3 > h), ar
t0 = time.time(); lo, hi = 0.3e-9, 6.5e-9          # short x: event; long x: none
tlo, evlo, _ = run(lo); thi, evhi, _ = run(hi)
if not (evlo and not evhi):
    print(f"RESULT {name}: bracket fails (event at x={lo}: {evlo}; at x={hi}: {evhi})"); sys.exit(1)
while hi - lo > XTOL:
    mid = 0.5 * (lo + hi); t3, ev, ar = run(mid)
    if ev: lo, tlo = mid, t3
    else: hi, thi, arr = mid, t3, ar
_, _, ar_hi = run(hi)
S.jsave(rpath, {"tag": tag, "ff": ff, "pol": pol, "corner": corner, "vdd": vdd, "temp": temp, "body": os.path.abspath(body),
                "x_floor_s": [lo, hi], "t_floor_ps": [tlo, thi], "arrival_bank_selected_q_ps": ar_hi, "simulations": len(cache),
                "wall_s": round(time.time() - t0, 1)})
print(f"RESULT {name}: floor t = {tlo:.1f} .. {thi:.1f} ps (x = {lo*1e12:.1f} .. {hi*1e12:.1f} ps after the start of the capture ramp); arrival {ar_hi:.1f} ps; {len(cache)} simulations, {time.time()-t0:.0f} s", flush=True)

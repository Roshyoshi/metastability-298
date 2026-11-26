#!/usr/bin/env python3
"""Clocked characterisation of one flip-flop in the cut-out: the critical data time by bisection of the data-edge
time, then captures at distances from it (the method of the second check, Section 8, and of
r7/prereg/tools/tchar7.py; same deck, stimulus and solver options: gear, reltol 1e-6, abstol 1e-12, vntol 1e-12,
chgtol 1e-14, trtol 1; tran 1p; capture edge as a 50 ps ramp at T_C = 4 ns; data edge of 100 ps at the pin).
Differences: the bisection stops at BTOL (default 1e-17 s; the original used 1e-19 s) and the captures are taken at
NDIST distances from 1.5 ns downwards, two per decade (default 15, down to 1.5e-16 s; the original 19), on the side
where the new value is taken, and at three distances on the other side; waveforms are not stored, the crossing
times of the selected output are measured in ngspice (first and last crossing of VDD/2 after the capture edge).
Flip-flops: 1..4 = DUT1..DUT4 (capture on `capture`, data on ui_in[6], output selected_q, ua[0] = 0.95 V so that the
early clock comes late); n1, n2, n3 = bank (capture on `bank_a`, data on uio_in[0], output bank_selected_q).
usage: tchar.py <body> <workdir> <tag> <corner> <vdd> <temp> <1|2|3|4|n1|n2|n3> <rise|fall>     (restart-safe)"""
import sys, os, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import simlib as S
body, work, tag, corner, vdd, temp, ff, pol = sys.argv[1:9]
vdd = float(vdd); temp = float(temp); h = vdd / 2
SC = float(os.environ.get("SCALE", "1")); BTOL = float(os.environ.get("BTOL", "1e-17")); NDIST = int(os.environ.get("NDIST", "15"))
work = os.path.abspath(work); os.makedirs(work, exist_ok=True)
outname = f"{work}/tchar_{tag}_{corner}_{vdd}_{temp}_{ff}{pol}.json"
if os.path.exists(outname):
    print(f"RESULT {tag} {ff} {pol}: exists, skipped"); sys.exit(0)
cpath = f"{work}/cache_{ff}{pol}.json"; cache = S.jload(cpath)
bank = ff.startswith("n")
old, new = (0.0, vdd) if pol == "rise" else (vdd, 0.0)
T_C = 4.0e-9 * SC; TEND = T_C + (8e-9 if not bank or ff == "n3" else 6e-9) * SC; EDGE = 100e-12
cpwl = f"PWL(0 0 {1e-9*SC:.6e} 0 {1e-9*SC+50e-12:.6e} {vdd} {2.5e-9*SC:.6e} {vdd} {2.5e-9*SC+50e-12:.6e} 0 {T_C:.6e} 0 {T_C+50e-12:.6e} {vdd})"
if bank:
    k = int(ff[1]); q = f"bank_q_{k-1}"; sel = "bank_selected_q"; clkn = "bank_cap"
    lat = {1: ("e_meta_n3ffb_0_mq", "e_meta_n3ffb_0_mqb"), 2: ("e_meta_j3a_0_x", "e_meta_j3a_0_y"), 3: ("bank_n3_mq", "bank_n3_mqb")}[k]
else:
    k = int(ff); q = f"q_{k-1}"; sel = "selected_q"; clkn = "capture_local"
    lat = (f"u_dut{k}_mq", f"u_dut{k}_mqb") if k > 1 else None
nsim = 0; t_start = time.time()

def run(td, name):
    global nsim
    key = f"{name}|{td:.20e}"
    if key in cache: return cache[key]
    L = S.header(f"tchar {tag} {ff} {pol} td={td:.20e}", body, corner, vdd, temp)
    dpw = f"PWL(0 {old} {td:.20e} {old} {td+EDGE:.20e} {new})"
    if bank:
        # FASTCAP=1: the capture edge is also forced on bank_cap itself, as a 50 ps ramp, to see the flip-flop with a
        # fast clock edge (the extracted driver gives it a 10-90 % rise time of about 1 ns at the typical corner)
        fast = [f"VFAST bank_cap 0 {cpwl}"] if os.environ.get("FASTCAP") == "1" else []
        if os.environ.get("EXTRA"): fast += [l.strip() for l in open(os.environ["EXTRA"]) if l.strip() and not l.startswith("*")]     # added devices
        L += S.pins(vdd, dut=2, data="0", ua0="0.95", capture="0", bank={"sel": k - 1, "data": dpw, "obs": 0}, extra=[f"VFBA bank_a 0 {cpwl}"] + fast)
    else:
        L += S.pins(vdd, dut=k, data=dpw, ua0="0.95", capture=cpwl)
    L += [".options method=gear reltol=1e-6 abstol=1e-12 vntol=1e-12 chgtol=1e-14 trtol=1",
          ".control", "set filetype=ascii", "set num_threads=1", f"tran 1p {TEND:.6e}",
          "let tcl=-1", "let ts=-1", "let ts1=-1", "let tq=-1",
          f"meas tran qend find v({q}) at={TEND*0.999:.6e}", f"meas tran send find v({sel}) at={TEND*0.999:.6e}",
          f"meas tran tcl when v({clkn})={h} rise=1 td={T_C-0.5e-9:.6e}",
          f"meas tran tq when v({q})={h} cross=LAST", f"meas tran ts when v({sel})={h} cross=LAST",
          f"meas tran ts1 when v({sel})={h} cross=1 td={T_C:.6e}",
          "echo RESULT qend $&qend", "echo RESULT send $&send", "echo RESULT tcl $&tcl", "echo RESULT tq $&tq",
          "echo RESULT ts $&ts", "echo RESULT ts1 $&ts1", ".endc", ".end"]
    p = f"{work}/tc_{ff}{pol}_{name}.spice"
    r, out = S.run(p, L)
    if "qend" not in r:
        open(p.replace(".spice", ".log"), "w").write(out); raise SystemExit(f"no result for {p}")
    os.remove(p)
    cache[key] = r; S.jsave(cpath, cache); nsim += 1
    return r

took_new = lambda r: (r["qend"] > h) == (new > h)
a, b = T_C - 1.5e-9, T_C + 0.6e-9
ra, rb = run(a, "ba"), run(b, "bb")
if not (took_new(ra) and not took_new(rb)):
    raise SystemExit(f"bracket fails: qend {ra['qend']} at {a:.4e} s, {rb['qend']} at {b:.4e} s")
n = 0
while b - a > BTOL:
    m = 0.5 * (a + b); r = run(m, f"b{n:02d}"); n += 1
    if took_new(r): a = m
    else: b = m
tcrit = 0.5 * (a + b)
print(f"critical data time {tcrit*1e9:.12f} ns after {n} steps ({nsim} new simulations, {time.time()-t_start:.0f} s)", flush=True)
rows = []
for i in range(NDIST):
    dl = 1.5e-9 * 10 ** (-0.5 * i)
    sides = [("new", tcrit - dl)] + ([("old", tcrit + dl)] if i in (6, 10, 14) else [])
    for side, td in sides:
        r = run(td, f"{side}{i:02d}")
        rows.append({"side": side, "delta_s": dl, **r})
S.jsave(outname, {"tag": tag, "ff": ff, "pol": pol, "corner": corner, "vdd": vdd, "temp": temp, "T_C": T_C, "scale": SC,
                  "body": os.path.abspath(body), "tcrit": tcrit, "bisect_steps": n, "btol": BTOL, "rows": rows})
print(f"RESULT {tag} {ff} {pol}: critical data time {tcrit*1e9:.12f} ns after {n} steps; {nsim} new simulations, {time.time()-t_start:.0f} s", flush=True)

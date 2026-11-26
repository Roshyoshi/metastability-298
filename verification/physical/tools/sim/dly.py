#!/usr/bin/env python3
"""Delay of the early sample against ua[0] on the cut-out (deck and stimulus of r7/prereg/tools/dly7.py, STIM=pulsed:
pulses on `capture` at 1 and 2 ns, measured edge at 5 ns; tran 5p; no .options line; 0.2 pF on the monitor pins).
d: capture_local -> early_clk; M: uio_out[4] -> uio_out[5]; dcap: capture -> capture_local; all at VDD/2.
usage: dly.py <body> <outdir> <tag> <corner> <vdd> <temp> <v1,v2,...>   (restart-safe: finished voltages are skipped)"""
import sys, os, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import simlib as S
body, outdir, tag, corner, vdd, temp, vlist = sys.argv[1:8]
vdd = float(vdd); temp = float(temp); h = vdd / 2
outdir = os.path.abspath(outdir); os.makedirs(outdir + "/decks", exist_ok=True)
name = f"dly_{tag}_{corner}_{vdd}_{temp}"; jpath = f"{outdir}/{name}.json"
J = S.jload(jpath, {"tag": tag, "corner": corner, "vdd": vdd, "temp": temp, "body": os.path.abspath(body), "points": {}})
DMAX = float(os.environ.get("DMAX_NS", "100"))
for v in sorted({round(float(x), 6) for x in vlist.split(",")}, reverse=True):
    key = f"{v:.4f}"
    if key in J["points"]: continue
    above = sorted((float(k), p["d_ps"]) for k, p in J["points"].items() if p.get("d_ps") and float(k) > v)
    est = 0.0
    if len(above) >= 2 and above[0][1] > above[1][1]:
        (v1, d1), (v2, d2) = above[0], above[1]; est = d1 * (d1 / d2) ** ((v1 - v) / (v2 - v1)) * 1e-3
    elif above: est = above[0][1] * 1e-3
    tstop = min(max(30.0, 5.0 + 2.0 * est + 5.0), 5.0 + DMAX + 10.0); t0 = time.time()
    while True:
        L = S.header(f"delay {tag} {corner} {vdd} V {temp} C ua0={v}", body, corner, vdd, temp)
        L += S.pins(vdd, dut=2, data="0", ua0=f"{v:.6f}", capture=f"PWL(0 0 1n 0 1.05n {vdd} 2n {vdd} 2.05n 0 5n 0 5.05n {vdd})")
        if os.environ.get("KLU", "0") == "1": L.append(".options klu")
        L += [".control", "set filetype=ascii", "set num_threads=1", f"tran 5p {tstop:g}n"]
        for k, spec in (("dly", f"trig v(capture_local) val={h} td=4n rise=1 targ v(early_clk) val={h} td=4n rise=1"),
                        ("dmon", f"trig v(uio_out[4]) val={h} td=4n rise=1 targ v(uio_out[5]) val={h} td=4n rise=1"),
                        ("dcap", f"trig v(capture) val={h} td=4n rise=1 targ v(capture_local) val={h} td=4n rise=1"),
                        ("tsl", f"trig v(capture_local) val={h} td=4n rise=1 targ v(delay_slow) val={h} td=4n fall=1")):
            L += [f"let {k}=-1", f"meas tran {k} {spec}", f"let {k}p={k}*1e12", f"echo RESULT {k} $&{k}p"]
        L += [".endc", ".end"]
        r, out = S.run(f"{outdir}/decks/{name}_{key}.spice", L)
        if (r.get("dly") or -1) > 0 or tstop >= 5.0 + DMAX + 10.0: break
        tstop = min(tstop * 2.0, 5.0 + DMAX + 10.0)
    ok = (r.get("dly") or -1) > 0
    J["points"][key] = {"d_ps": r["dly"] if ok else None, "M_ps": r.get("dmon"), "dcap_ps": r.get("dcap"), "tslow_ps": r.get("tsl"),
                        "tstop_ns": tstop, "wall_s": round(time.time() - t0, 1)}
    S.jsave(jpath, J)
    print(f"RESULT {name} V={key} d={J['points'][key]['d_ps']} M={r.get('dmon')} dcap={r.get('dcap')} wall={J['points'][key]['wall_s']}s", flush=True)

#!/usr/bin/env python3
"""The bank's capture edge made by the bank's own divider, on the cut-out.
usage: realdiv.py <body> <corner> <vdd> <temp> <out json>
The bench of the cut-out with the reset released at 0.6 ns and six clock edges 6 ns apart (the 5 V flip-flops of the
divider need more than 1.3 ns from clock to output at 3.3 V). The divider is the two flip-flops bank_b_ff and
bank_a_ff; `bank_a` rises on the second and on the sixth clock edge. Measured on the sixth: the edge of `bank_a`
(input of the driver), of `bank_cap_b` and of `bank_cap` (the capture edge at N1, N2 and N3)."""
import sys, os, json
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import simlib as S
body, corner, vdd, temp, out = sys.argv[1], sys.argv[2], float(sys.argv[3]), float(sys.argv[4]), sys.argv[5]
h = vdd / 2
L = S.header("capture edge made by the divider", os.path.abspath(body), corner, vdd, temp)
P = S.pins(vdd, dut=2, data="0", ua0="0.95", capture="0", bank={"sel": 1, "data": "0", "obs": 0})
pts = [(0, 0)]
for e in (2, 8, 14, 20, 26, 32):
    pts += [(e, 0), (e + 0.1, vdd), (e + 3, vdd), (e + 3.1, 0)]
clk = "PWL(" + " ".join(f"{t}n {v}" for t, v in pts) + ")"
P = [(f"VCLK clk 0 {clk}" if l.startswith("VCLK ") else (f"VRSTN rst_n 0 PWL(0 0 0.5n 0 0.6n {vdd})" if l.startswith("VRSTN ") else l)) for l in P]
M = [("tck", f"when v(clk)={h} rise=6"), ("ta", f"when v(bank_a)={h} rise=2"), ("a10", f"when v(bank_a)={0.1*vdd} rise=2"), ("a90", f"when v(bank_a)={0.9*vdd} rise=2"),
     ("t10", f"when v(bank_cap)={0.1*vdd} rise=2"), ("t50", f"when v(bank_cap)={h} rise=2"), ("t90", f"when v(bank_cap)={0.9*vdd} rise=2"),
     ("b90", f"when v(bank_cap_b)={0.9*vdd} fall=2"), ("b10", f"when v(bank_cap_b)={0.1*vdd} fall=2"), ("f90", f"when v(bank_cap)={0.9*vdd} fall=1"), ("f10", f"when v(bank_cap)={0.1*vdd} fall=1")]
wave = sys.argv[6] if len(sys.argv) > 6 else None            # optional: write the waveform of bank_a at the measured edge
dat = os.path.abspath(out).replace(".json", ".dat")
L += P + [".control", "set filetype=ascii", "set num_threads=1", "tran 2p 40e-9"] + [f"meas tran {n} {e}" for n, e in M] + [f"echo RESULT {n} $&{n}" for n, _ in M] + ([f"wrdata {dat} v(bank_a)"] if wave else []) + [".endc", ".end"]
r, o = S.run(out.replace(".json", ".spice"), L)
ps = lambda a, b: round((r[a] - r[b]) * 1e12, 1)
res = {"body": os.path.abspath(body), "corner": corner, "vdd": vdd, "temp": temp,
       "clk_to_bank_a_ps": ps("ta", "tck"), "bank_a_rise_10_90_ps": ps("a90", "a10"), "bank_cap_b_fall_90_10_ps": ps("b10", "b90"),
       "bank_cap_rise_10_90_ps": ps("t90", "t10"), "bank_cap_rise_10_50_ps": ps("t50", "t10"), "bank_cap_rise_50_90_ps": ps("t90", "t50"),
       "bank_a_to_bank_cap_ps": ps("t50", "ta"), "clk_to_bank_cap_ps": ps("t50", "tck"), "bank_cap_fall_90_10_ps": ps("f10", "f90")}
json.dump(res, open(out, "w"), indent=1)
if wave:
    import numpy as np
    D = np.loadtxt(dat); t, a = D[:, 0], D[:, 1]; m = t > 32e-9; t, a = t[m], a[m]
    rel = np.concatenate([np.arange(-900, -300, 100), np.arange(-300, 300, 20), np.arange(300, 1000, 50), np.arange(1000, 2600, 200)]) * 1e-12 * (r["a90"] - r["a10"]) / 877e-12
    v = np.interp(r["ta"] + rel, t, a)
    k0 = max(int(np.where(v > 0.002 * vdd)[0][0]) - 1, 0)
    pts = [[float(rel[k]), float(round(v[k], 5))] for k in range(k0, len(rel))]; pts[0][1] = 0.0; pts[-1][1] = vdd
    json.dump({"comment": "v(bank_a) at the capture edge made by the bank's own divider flip-flop on the cut-out; time in s relative to the crossing of vdd/2",
               "corner": corner, "vdd": vdd, "temp": temp, "points": pts}, open(wave, "w"), indent=0)
    os.remove(dat)
print(json.dumps(res))

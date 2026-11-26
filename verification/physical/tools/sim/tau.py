#!/usr/bin/env python3
"""Latch time constants by the growth method on the cut-out of the extracted tile (the method of
r7/prereg/tools/tau7g.py and of the second check, Section 5, "growth"):
the clock of the flip-flop is held high (master latch closed), its two latch nodes start at the balance voltage
plus and minus 10 uV, and tau = (t(|difference| = 20 mV) - t(|difference| = 0.632 mV)) / ln(20 / 0.632).
The balance voltage is found for each latch in the same netlist: operating point with the two latch nodes joined.
Both signs of the starting offset are run. Options: gear, reltol 1e-6, abstol 1e-12, vntol 1e-12, chgtol 1e-14,
trtol 1; tran 1p.
usage: tau.py <body> <out json> <corner:vdd:temp> ...      env FFS=dut2,dut3,dut4,n3,n1,n2 (default all)"""
import sys, os, math, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import simlib as S
body, out = os.path.abspath(sys.argv[1]), os.path.abspath(sys.argv[2])
work = os.path.join(os.path.dirname(out), "decks_tau"); os.makedirs(work, exist_ok=True)
FF = {"dut2": ("u_dut2_mq", "u_dut2_mqb", "core"), "dut3": ("u_dut3_mq", "u_dut3_mqb", "core"), "dut4": ("u_dut4_mq", "u_dut4_mqb", "core"),
      "n3": ("bank_n3_mq", "bank_n3_mqb", "bank"), "n1": ("e_meta_n3ffb_0_mq", "e_meta_n3ffb_0_mqb", "bank"),
      "n2": ("e_meta_j3a_0_x", "e_meta_j3a_0_y", "bank")}
want = os.environ.get("FFS", "dut2,dut3,dut4,n3,n1,n2").split(",")
A, B = 0.632e-3, 20e-3
res = S.jload(out)
OPT = ".options method=gear reltol=1e-6 abstol=1e-12 vntol=1e-12 chgtol=1e-14 trtol=1"
def base(title, corner, vdd, temp, which):
    L = S.header(title, body, corner, vdd, temp)
    L += S.pins(vdd, dut=2, data="0", ua0="1.8", capture=(f"{vdd}" if which == "core" else "0"))
    L.append(f"VFBC bank_cap 0 {vdd if which == 'bank' else 0}")
    return L
for spec in sys.argv[3:]:
    corner, vdd, temp = spec.split(":"); vdd = float(vdd); temp = float(temp); cond = f"{corner}_{vdd}_{temp}"
    for ff in want:
        a, b, which = FF[ff]
        others = [(x, y) for k, (x, y, w) in FF.items() if k != ff]
        kb = f"{cond}|{ff}|vb"
        if kb not in res:
            L = base(f"balance {kb}", corner, vdd, temp, which) + [f"VSHORT {a} {b} 0", ".options rshunt=1e12"]
            L += [".nodeset " + " ".join(f"v({x})={vdd} v({y})=0" for x, y in others) + f" v({a})={vdd*0.44:.3f}"]
            L += [".control", "set num_threads=1", "op", f"let vb = v({a})", "echo RESULT vb $&vb", ".endc", ".end"]
            r, o = S.run(f"{work}/{kb.replace('|', '_')}.spice", L)
            if "vb" not in r: print("no balance for", kb, flush=True); continue
            res[kb] = r["vb"]; S.jsave(out, res)
        VB = res[kb]
        for sgn in (+1, -1):
            key = f"{cond}|{ff}|{'p' if sgn > 0 else 'm'}"
            if key in res: continue
            t0 = time.time()
            L = base(f"growth tau {key}", corner, vdd, temp, which) + [OPT]
            ics = [f"v({a})={VB + sgn*10e-6:.12f}", f"v({b})={VB - sgn*10e-6:.12f}"] + [f"v({x})={vdd} v({y})=0" for x, y in others]
            L.append(".ic " + " ".join(ics))
            L += [".control", "set filetype=ascii", "set num_threads=1", "tran 1p 6n", f"let dm = abs(v({a}) - v({b}))",
                  "let ta=-1", "let tb=-1", f"meas tran ta when dm={A} cross=1", f"meas tran tb when dm={B} cross=1",
                  f"meas tran vend find v({a}) at=5.99n", "let tap=ta*1e12", "let tbp=tb*1e12",
                  "echo RESULT ta $&tap", "echo RESULT tb $&tbp", "echo RESULT vend $&vend", ".endc", ".end"]
            r, o = S.run(f"{work}/{key.replace('|', '_')}.spice", L)
            if r.get("ta") is None or r.get("tb") is None or r["ta"] <= 0 or r["tb"] <= 0:
                open(f"{work}/{key.replace('|', '_')}.log", "w").write(o); print("no result", key, r, flush=True); continue
            tau = (r["tb"] - r["ta"]) / math.log(B / A)
            res[key] = {"tau_ps": tau, "ta_ps": r["ta"], "tb_ps": r["tb"], "end_V": r["vend"], "vb": VB, "wall_s": round(time.time() - t0, 1)}
            S.jsave(out, res)
            print(f"RESULT {key} tau={tau:.3f} ps (ta {r['ta']:.2f}, tb {r['tb']:.2f}, node ends at {r['vend']:.2f} V, balance {VB:.5f} V) {time.time()-t0:.0f} s", flush=True)

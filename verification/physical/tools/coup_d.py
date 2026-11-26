#!/usr/bin/env python3
"""Delay of the second and third trial of the floor bench at one ua[0], on a given cut-out body.
usage: coup_d.py <body> <workdir> <tag> <v> <rise|fall> [dut]"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import simlib as S
body, wd, tag, v, pol = sys.argv[1:6]; dut = int(sys.argv[6]) if len(sys.argv) > 6 else 2
vdd = 3.3; h = vdd / 2; os.makedirs(wd, exist_ok=True)
seq = [1, 0, 1] if pol == "rise" else [0, 1, 0]
T = lambda x: f"{x:g}n"; lvl = lambda b: vdd if b else 0.0
dpwl = f"PWL(0 {lvl(seq[0])} {T(9)} {lvl(seq[0])} {T(9.1)} {lvl(seq[1])} {T(19)} {lvl(seq[1])} {T(19.1)} {lvl(seq[2])})"
cpwl = "PWL(" + " ".join(f"{T(a) if a else 0} {x}" for a, x in [(0, 0), (1, 0), (1.05, vdd), (7, vdd), (7.05, 0), (11, 0), (11.05, vdd), (17, vdd), (17.05, 0), (21, 0), (21.05, vdd), (27, vdd), (27.05, 0)]) + ")"
L = S.header(f"coupling test {tag}", body, "typical", vdd, 25.0)
L += S.pins(vdd, dut=dut, data=dpwl, ua0=v, capture=cpwl)
L += [".control", "set num_threads=1", "tran 2p 31n",
      f"meas tran d3 trig v(capture_local) val={h} td=20n rise=1 targ v(early_clk) val={h} td=20n rise=1",
      f"meas tran d2 trig v(capture_local) val={h} td=10n rise=1 targ v(early_clk) val={h} td=10n rise=1",
      "meas tran g1 max v(early_clk) from=8.9n to=9.6n", "meas tran g2 max v(early_clk) from=18.9n to=19.6n",
      "meas tran g1n min v(early_clk) from=8.9n to=9.6n", "meas tran g2n min v(early_clk) from=18.9n to=19.6n",
      "let a=d3*1e12", "let b=d2*1e12", "echo RESULT d3 $&a", "echo RESULT d2 $&b",
      "echo RESULT g1 $&g1", "echo RESULT g2 $&g2", "echo RESULT g1n $&g1n", "echo RESULT g2n $&g2n", ".endc", ".end"]
r, out = S.run(f"{wd}/{tag}.spice", L, keep=True)
print(tag, r)

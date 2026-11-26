#!/usr/bin/env python3
"""Write verification/physical/SIMULATIONS.md from the result files of the work folder.
usage: make_sim_md.py <work dir> <out md>"""
import sys, os, json, glob, subprocess
W, OUT = sys.argv[1], sys.argv[2]
J = lambda p: json.load(open(p)) if os.path.exists(p) else None
frag = lambda n: open(f"{W}/build/{n}").read().strip() if os.path.exists(f"{W}/build/{n}") else None
COND = [("typical", 3.3, 27.0, "typical, 3.3 V, 27 C"), ("ss", 3.0, 125.0, "ss, 3.0 V, 125 C"), ("ff", 3.6, -40.0, "ff, 3.6 V, -40 C")]
L = []; A = L.append

A("# Simulations of the revised layout added on 26 Nov 2026\n")
A("Layout: commit e449093, GDS SHA-1 `4b6e7df96942da64c25916530b39da4a2fdb39d1`. These runs complete the list that\n"
  "`README_analog.md` gave as \"not repeated for the revised layout\". The audit of the supply, of latch-up and of\n"
  "coupling is in `README.md` of this folder.\n")
A("## 1. Tools and method\n")
A("| Item | Version |\n| --- | --- |\n"
  "| Extraction | Magic 8.3.573 and Magic 8.3.703, `ext2spice` with coupling capacitance, hierarchical; PDK `gf180mcuD` (wafer-space/gf180mcu, commit ac7d869) |\n"
  "| Checks on both extractions | Magic DRC 0 errors; Netgen 1.5.133 against `layout/chip_lvs.spice`: \"Circuits match uniquely\", 208 devices, 209 nets (`checks/`) |\n"
  "| Simulator | ngspice 42, models `sm141064.ngspice`, one thread |\n"
  "| Bench | the cut-out of `verification/bank/tools/cutout_bank.py`, written again as `tools/sim/cutout.py`: front end and bank from the extracted netlist with every wire capacitance, the controller replaced by sources at its boundary |\n")
A("The scripts are those of the second check (`verification/independent/`) and of the bank revision, written again for\n"
  "this folder (`tools/sim/`). Three earlier results were reproduced first, with the 8.3.573 extraction at the typical\n"
  "corner: *d* at `ua[0]` = 1.0, 1.3 and 3.3 V (4539.76, 2687.54, 1401.69 ps: equal to the recorded values); the floors\n"
  "of DUT2 at 25 C (1692.6 and 2255.0 ps: equal); and the time constants of the six NAND and jamb latches (within\n"
  "0.1 % of `verification/bank/sim/tau.txt`, which uses a bench written separately).\n")

# ---- capacitance of the two extractions
A("## 2. The two extractions\n")
A("Wire capacitance at the top level of the extracted netlist, each capacitor counted once:\n")
A("| Extraction | Capacitors | Signal net to `VGND` | Signal net to `VDPWR` | Between signal nets | Sum | Between `VDPWR` and `VGND` |\n| --- | --- | --- | --- | --- | --- | --- |\n"
  "| Magic 8.3.573 | 9,910 | 0.130 pF | 0.789 pF | 1.251 pF | 2.170 pF | 0.085 pF |\n"
  "| Magic 8.3.703 | 9,281 | 0.164 pF | 0.097 pF | 0.733 pF | 0.994 pF | -0.147 pF |\n")
A("The two versions differ by a factor of 2.2 in the wire capacitance they report for the same layout. The negative\n"
  "value between the supplies with 8.3.703 is a correction term of the hierarchical extraction; it has no effect on\n"
  "the benches, in which both supplies are ideal sources. Which version is nearer the silicon is not established\n"
  "(`README_analog.md`, \"The version of Magic\").\n")

# ---- delay
curves = {}
for ext in ("573", "703"):
    for c, v, t, lab in COND:
        d = J(f"{W}/sim/dly/dly_post{ext}_{c}_{v}_{t}.json")
        if d: curves[(ext, lab)] = {float(k): p for k, p in d["points"].items() if p.get("d_ps")}
A("## 3. Delay of the early sample against `ua[0]`\n")
A("*d* from the capture edge at the flip-flops (`capture_local`) to the clock of the early observer (`early_clk`), both\n"
  "at half the supply; data input low; ps.\n")
keys = list(curves); vs = sorted({v for c in curves.values() for v in c})
A("| `ua[0]` (V) | " + " | ".join(f"8.3.{e}, {l}" for e, l in keys) + " |\n| --- |" + " --- |" * len(keys))
for v in vs:
    A(f"| {v:.2f} | " + " | ".join((f"{curves[k][v]['d_ps']:.1f}" if v in curves[k] else "") for k in keys) + " |")
A("")
def off(k): return ", ".join(f"{curves[k][v]['d_ps'] - curves[k][v]['M_ps']:.0f} ps at {v:g} V" for v in (1.0, 1.8, 3.0) if v in curves[k])
A("The delay between the monitor pins `uio_out[4]` and `uio_out[5]` is shorter than *d* by: " + "; ".join(f"{l} (8.3.{e}): {off((e, l))}" for e, l in keys) + ".\n")
k5, k7 = ("573", COND[0][3]), ("703", COND[0][3])
if k5 in curves and k7 in curves:
    common = [v for v in vs if v in curves[k5] and v in curves[k7]]
    r = [curves[k5][v]["d_ps"] / curves[k7][v]["d_ps"] - 1 for v in common]
    A(f"With 8.3.703 *d* is {min(r)*100:.1f} to {max(r)*100:.1f} % shorter than with 8.3.573 at the typical corner.\n")
sl = lambda k, a, b: (curves[k][a]["d_ps"] - curves[k][b]["d_ps"]) / ((b - a) * 1000)
A("Sensitivity of *d* to `ua[0]` at the typical corner (8.3.573): "
  f"{sl(k5, 0.9, 0.95):.1f} ps per mV between 0.90 and 0.95 V, {sl(k5, 1.0, 1.05):.1f} between 1.00 and 1.05 V, "
  f"{sl(k5, 1.15, 1.2):.1f} between 1.15 and 1.20 V, {sl(k5, 1.4, 1.5):.2f} between 1.4 and 1.5 V.\n")

# ---- tau
T = {e: J(f"{W}/sim/tau/tau_{e}.json") or {} for e in ("573", "703")}
A("## 4. Time constants of the master latches\n")
A("Growth method on the cut-out: the latch is balanced and released with a small imbalance, and the time between two\n"
  "fixed levels of the difference of its nodes gives tau. Two values per entry: released towards either side. ps.\n")
A("| Flip-flop | " + " | ".join(f"8.3.{e}, {l}" for e in ("573", "703") for _, _, _, l in COND) + " |\n| --- |" + " --- |" * 6)
def tv(e, c, v, t, ff, s="p"):
    a = T[e].get(f"{c}_{v}_{t}|{ff}|{s}"); return a["tau_ps"] if a else None
for ff, lab in (("dut2", "DUT2"), ("dut3", "DUT3"), ("dut4", "DUT4"), ("n3", "N3"), ("n1", "N1"), ("n2", "N2")):
    A(f"| {lab} | " + " | ".join((f"{tv(e,c,v,t,ff):.2f}, {tv(e,c,v,t,ff,'m'):.2f}" if tv(e, c, v, t, ff) else "") for e in ("573", "703") for c, v, t, _ in COND) + " |")
A("\n| Ratio | " + " | ".join(f"8.3.{e}, {l}" for e in ("573", "703") for _, _, _, l in COND) + " |\n| --- |" + " --- |" * 6)
for num, den, lab in (("dut3", "dut2", "DUT3 / DUT2"), ("dut4", "dut2", "DUT4 / DUT2"), ("n3", "dut3", "N3 / DUT3"), ("n1", "dut2", "N1 / DUT2"), ("n2", "dut2", "N2 / DUT2"), ("n2", "n1", "N2 / N1")):
    A(f"| {lab} | " + " | ".join((f"{tv(e,c,v,t,num)/tv(e,c,v,t,den):.4f}" if tv(e, c, v, t, num) and tv(e, c, v, t, den) else "") for e in ("573", "703") for c, v, t, _ in COND) + " |")
rr = [tv("573", c, v, t, ff) / tv("703", c, v, t, ff) - 1 for c, v, t, _ in COND for ff in ("dut2", "dut3", "dut4", "n3", "n1", "n2") if tv("703", c, v, t, ff)]
A(f"\nWith 8.3.573 tau is {min(rr)*100:.1f} to {max(rr)*100:.1f} % longer than with 8.3.703. The ratio of DUT3 to DUT2 is the same with both to\n"
  "0.0003; that of DUT4 to DUT2 differs by 0.012. N3, the copy of DUT3 in the bank, is within 0.1 % of DUT3.\n")
V = J(f"{W}/sim/tau/tau_573_vdd.json")
if V:
    g = lambda vdd, ff: V.get(f"typical_{vdd}_27.0|{ff}|p", {}).get("tau_ps")
    row = [(ff.upper().replace("DUT", "DUT"), g(3.25, ff), tv("573", "typical", 3.3, 27.0, ff), g(3.35, ff)) for ff in ("n2", "n1", "dut2")]
    A("Against the supply voltage (typical corner, 27 C, 8.3.573), tau at 3.25, 3.30 and 3.35 V: " + "; ".join(
        f"{n} " + ", ".join(f"{x:.2f}" for x in (a, b, c) if x) + " ps" for n, a, b, c in row) + ".\n")

# ---- floors
A("## 5. Floors in continuous operation\n")
A("Bench of the second check (Section 7): three trials 10 ns apart (15 ns at the slow corner), the data toggled 2 ns\n"
  "before each capture edge, the third trial examined; `ua[0]` is bisected until the early sample catches the new\n"
  "value; the floor is *d* of that trial. Below the floor every trial in which the output changed is counted.\n")
fl = sorted(glob.glob(f"{W}/sim/floor/floor_post573_*.json"), key=lambda f: (["typical", "ff", "ss"].index(json.load(open(f))["corner"]), json.load(open(f))["dut"], json.load(open(f))["pol"] != "rise"))
A("| Condition (8.3.573) | Flip-flop | Data | Floor (ps) | `ua[0]` at the floor (V) | New value at the selector output, after the capture edge (ps) |\n| --- | --- | --- | --- | --- | --- |")
for f in fl:
    r = json.load(open(f))
    A(f"| {r['corner']}, {r['vdd']} V, {r['temp']:g} C | DUT{r['dut']} | {'rising' if r['pol'] == 'rise' else 'falling'} | {max(r['d_floor_ps']):.1f} | {sum(r['V_floor'])/2:.3f} | {r['arrival_selected_q_ps']:.1f} |")
A("")
x = frag("floor_notes.md")
if x: A(x + "\n")
fb = sorted(glob.glob(f"{W}/sim/floor/floorbank_post573_*.json"))
if fb:
    A("**The bank.** The same bench with the bank's own path: the capture edge is applied at the output of the bank's trial\n"
      "flip-flop, and the early observer is clocked from the pin `ui_in[5]`. *t* is the time from the capture edge at the\n"
      "flip-flops (`bank_cap`) to the clock of the bank's early observer; it plays the part of *d*. *x* is the time of the\n"
      "edge at the pin after the start of the capture edge at the trial flip-flop's output.\n")
    A("| Condition (8.3.573) | Flip-flop | Data | Floor *t* (ps) | *x* at the floor (ps) | New value at the bank selector output, after the capture edge (ps) |\n| --- | --- | --- | --- | --- | --- |")
    for f in fb:
        r = json.load(open(f))
        A(f"| {r['corner']}, {r['vdd']} V, {r['temp']:g} C | {r['ff'].upper()} | {'rising' if r['pol'] == 'rise' else 'falling'} | {max(r['t_floor_ps']):.1f} | {max(r['x_floor_s'])*1e12:.1f} | {r['arrival_bank_selected_q_ps']:.1f} |")
    A("")
for n, title in (("rc_section.md", "## 6. The whole tile with wire resistance\n"), ("count_section.md", "## 7. Predicted count against the delay\n")):
    x = frag(n)
    if x: A(title); A(x + "\n")
x = frag("notdone_section.md")
if x: A("## 8. Not done\n"); A(x + "\n")
A("## 9. Files\n")
A("| File | Contents |\n| --- | --- |\n"
  "| `sim/dly_*.json`, `sim/tau_*.json`, `sim/floor*_*.json`, `sim/tchar_*.json`, `sim/count_*.json` | the results behind every table above |\n"
  "| `sim/rc_*` | extraction scripts, bench and result lines of the runs with wire resistance; the edges of the two flat netlists; the bound per net; the rail voltages |\n"
  "| `sim/tcdiag_edges.txt` | the two captures that show the capture edge moving with the state of the master latch |\n"
  "| `checks/` | Magic DRC and Netgen LVS on both extractions |\n"
  "| `tools/sim/cutout.py`, `simlib.py` | the cut-out and the bench library |\n"
  "| `tools/sim/dly.py`, `tau.py`, `floor.py`, `floors_job.py`, `floor_bank.py`, `tchar.py`, `count_model.py` | one script per quantity; the usage line is at the top of each |\n"
  "| `tools/sim/runq.sh`, `collect.py`, `make_sim_md.py` | the job queue and the scripts that write the tables of this document |\n")
A("To repeat: extract the GDS with Magic (`layout/magic_checks.tcl`), run `tools/sim/cutout.py` on the extracted netlist,\n"
  "then the script of the quantity wanted. Every script skips results that already exist.\n")
open(OUT, "w").write("\n".join(L).rstrip("\n") + "\n")
print("wrote", OUT, len(L), "blocks")

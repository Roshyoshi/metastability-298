#!/usr/bin/env python3
"""Documents for the layout of 26 Nov 2026 (stronger driver of the bank's capture edge).

Run on the branch that holds the new layout, after finalize.py (which writes the documents of the audit of e449093
and the text fragments in build/). This script
  1. copies build/ to build_rev2/ and changes the fragments whose numbers the new layout moves,
  2. rebuilds README_analog.md and docs/info.md from the e449093 versions with those fragments, then edits the
     section on the bank and adds the section on the capture driver,
  3. edits verification/FAILURE_SPACE.md, and adds a note to the documents that describe e449093,
  4. writes verification/bank_driver/README.md and copies the result files there.
Every edit asserts that the text it replaces is present exactly once."""
import os, re, sys, json, glob, math, shutil, subprocess, textwrap
W = "/home/claude/work"; R = f"{W}/repo"; S = f"{W}/sim"; B = f"{W}/build"; B2 = f"{W}/build_rev2"; P = f"{B}/rev2_phys"
D = f"{R}/verification/bank_driver"
sys.path.insert(0, f"{W}/scripts")
import rev2_data as RD
V = RD.gather(); K = RD.K
MISSING = list(V["missing"])
GDS_NEW = subprocess.run(["sha1sum", f"{R}/gds/tt_um_metastability_characterizer.gds"], capture_output=True, text=True).stdout.split()[0]
GDS_OLD = "4b6e7df96942da64c25916530b39da4a2fdb39d1"

def rsub(s, old, new, what, count=1):
    """replace `old` (any run of white space in it matches any white space) by `new`; must occur exactly `count` times"""
    pat = r"\s+".join(re.escape(x) for x in old.split())
    n = len(re.findall(pat, s))
    assert n == count, (what, n)
    return re.sub(pat, lambda m: new, s)
def wrap(t, width=118):
    out = []
    for para in t.strip("\n").split("\n\n"):
        if para.lstrip().startswith(("|", "    ", "- ", "#")) or "\n|" in para:
            out.append(para)
        else:
            out.append(textwrap.fill(" ".join(para.split()), width, break_long_words=False, break_on_hyphens=False))
    return "\n\n".join(out) + "\n"
def nc(x, f="{:.1f}"): return "not computed" if x is None else f.format(x)

# ------------------------------------------------------------------------------------------------ numbers
T, E, IR = V["tile"], V["edges"], V["ir"]
def edge(tag, net, old=False):
    e = (V["edges_old"] if old else E).get(tag)
    return None if not e or not e["edges_ps"].get(net) else e["edges_ps"][net][1]
def rise(tag, net, old=False):
    e = (V["edges_old"] if old else E).get(tag)
    return None if not e else e["rise_10_90_ps"].get(net)
ns = lambda ps, d=2: None if ps is None else round(ps / 1000, d)
clk_cap = {c: edge(t, "bank_cap") for c, t in (("typ", "b2_early"), ("ff", "b2_early_ff"), ("ss", "b2_early_ss"))}
obs_d = {c: (None if edge(t, "bank_obs_clk") is None else edge(t, "bank_obs_clk") - 200.0) for c, t in (("typ", "b2_early"), ("ff", "b2_early_ff"), ("ss", "b2_early_ss"))}
cap_rise = {"typ_off": rise("core", "bank_cap"), "typ": rise("b2_early", "bank_cap"), "ff": rise("b2_early_ff", "bank_cap"), "ss": rise("b2_early_ss", "bank_cap")}
cap_rise_old = {"typ_off": rise("core", "bank_cap", True), "typ": rise("b2_early", "bank_cap", True), "ff": rise("b2_early_ff", "bank_cap", True)}
arr = {}
for ff, tag in (("n1", "b1_early"), ("n2", "b2_early"), ("n3", "b3_early"), ("n2ff", "b2_early_ff"), ("n2ss", "b2_early_ss")):
    r = T.get(tag)
    arr[ff] = None if not r else (r.get("bank_q_arrives_rising_ps"), r.get("bank_q_arrives_falling_ps"))
lead = None if edge("b2_early", "capture_local") is None or clk_cap["typ"] is None else edge("b2_early", "capture_local") - clk_cap["typ"]
kfall = None
if all(arr.get(f) for f in ("n1", "n2", "n3")) and clk_cap["typ"] and obs_d["typ"] is not None:
    xs = [clk_cap["typ"] + a - obs_d["typ"] for f in ("n1", "n2", "n3") for a in arr[f]]
    kfall = (min(xs) / 1000, max(xs) / 1000)
irs = {k: RD.ir_summary(d) for k, d in IR.items()}
LAT = V["lat"]
def steps(key, x, f="{:.1f} to {:.1f}"):
    L = LAT[key].get(x)
    return None if not L else f.format(*L["steps_ps"])
def local(key, x):
    L = LAT[key].get(x)
    return None if not L else (L["steps_ps"][0] / K, L["steps_ps"][1] / K)
def tot(key, x):
    L = LAT[key].get(x)
    return float("nan") if not L else L["total_ps"]
TAU = V["tau"]; TAUO = V["tau_old"]
tau = lambda d, c, f: d[f"{c}|{f}|p"]["tau_ps"]
TYP, SS, FF = "typical_3.3_27.0", "ss_3.0_125.0", "ff_3.6_-40.0"
tau_maxdiff = max(abs(tau(TAU, c, f) - tau(TAUO, c, f)) for c in (TYP, SS, FF) for f in ("dut2", "dut3", "dut4", "n1", "n2", "n3"))
tau_maxdiff_core = max(abs(tau(TAU, c, f) - tau(TAUO, c, f)) for c in (TYP, SS, FF) for f in ("dut2", "dut3", "dut4", "n1", "n2"))
dmax = max(abs(V["dly"]["points"][k]["d_ps"] - V["dly_old"]["points"][k]["d_ps"]) for k in V["dly"]["points"])
RDV = {k: RD.J(f"{S}/rev2/realdiv/{k}_typical.json") for k in ("e449093", "26nov")}
FB, FBO = V["fb"], V["fb_old"]
fmid = lambda a: None if a is None else sum(a["t_floor_ps"]) / 2
# count model of N2 with the divider's edge (preferred) or with the ramp
CNT = V["count"].get("rev2w") or V["count"].get("rev2"); CNT_KIND = "rev2w" if V["count"].get("rev2w") else "rev2"
cfit = None
if CNT and CNT.get("fits"):
    v = list(CNT["fits"].values()); cfit = (min(v), max(v))
wave_ok = all(x in LAT["wave"] for x in ("n2fall", "n2rise"))
CK = "wave" if wave_ok else "ramp"                       # which captures the top-level documents quote
n2_steps_lo = min(LAT[CK][x]["steps_ps"][0] for x in ("n2fall", "n2rise") if x in LAT[CK])
n2_steps_hi = max(LAT[CK][x]["steps_ps"][1] for x in ("n2fall", "n2rise") if x in LAT[CK])
n2_tail = [LAT[CK][x]["tail_ps"] for x in ("n2fall", "n2rise") if x in LAT[CK]]
TAU_N2 = tau(TAU, TYP, "n2"); TAU_N1 = tau(TAU, TYP, "n1")
n1k = "wave" if any(x in LAT["wave"] for x in ("n1fall", "n1rise")) else None
ev = lambda tag: None if tag not in T else int(T[tag]["events"])
flags_ok = all(abs(r["busy_V"] - RD.TAGS[t]) < 0.05 and abs(r["done_V"]) < 0.05 and abs(r["fault_V"]) < 0.05 for t, r in T.items())
fd2 = {p: V["fd2"].get(p) for p in ("rise", "fall")}
RDV9 = 174.1                                             # rise time of bank_cap in the trial with the two inverters x3 and x9 of inv_2 (sim/capfix/driver_sweep.json)

# ------------------------------------------------------------------------------------------------ texts
why = f"""The count model was run for N2 on the layout of 25 Nov (commit e449093). It showed that a slope measured on N2
would not have been the time constant of its latch. The bank's capture edge, the net `bank_cap`, was driven by two
`inv_2` in series and rose in {cap_rise_old['typ_off']/1000:.2f} ns from 10 to 90 % at the typical corner. The slave of N2 is opened by
that edge through two transistors 0.3 um wide, and while the edge is still rising the slave cannot follow the latch. Most
of the lateness of the latch therefore did not reach the output: in a capture 1.5e-16 s from the critical time the
output came {tot('old','n2rise'):.0f} ps (rising data) and {tot('old','n2fall'):.0f} ps (falling data) later than in an ordinary capture, where the same
captures with a 50 ps edge forced on `bank_cap` give {tot('fast','n2rise'):.0f} and {tot('fast','n2fall'):.0f} ps. In terms of steps, the last crossing
of the output moved by {steps('old','n2fall')} ps (falling data) and {steps('old','n2rise')} ps (rising data) for each factor of
sqrt(10) in the distance of the data edge from the critical time, where the latch's {TAU_N2:.1f} ps correspond to
{TAU_N2*K:.0f} ps. N1, DUT1 to DUT4 and N3 were not affected in this way (`verification/physical/SIMULATIONS.md`,
Section 7)."""

change = f"""In `tools/build_master.py`, list `BANK`, the cell `bank_cap0` is now `inv_4` and `bank_cap1` is `inv_12`
(sheet `xschem/blocks/bank_capture_drivers.sch`). Instance names, nets and the row are the same. The tile has 2,002
transistors and 2 diodes, 24 more than before, in the same 180 library cells and two custom blocks. Row B2, which
holds the trial clock copy, the data drivers and the capture drivers, is longer to the left: its transistors span
x = 240.98 to 307.98 um, before 255.54 to 308.01 um, and the generator routed the bank's nets again. Above
y = 199 um, where DUT1 to DUT4, the delay line, the controller and the pin drivers are, the GDS is identical to that
of e449093 on every layer (`verification/bank_driver/layout/xor_against_e449093.txt`). The LEF is unchanged."""

pin_note = """`inv_4` and `inv_12` draw their input pin as two Metal1 pieces, each on contacts to the one polysilicon shape that
forms all their gates; the library's LEF lists both pieces in one port. The router reaches one piece. `tools/drc_lite.py`
used to count every Metal1 piece of a pin as a terminal of its own and reported the other piece as an open; it now
reads the cell's GDS, follows Metal1, contacts and polysilicon, and counts such a pin as one terminal only if they
join the pieces (reported under `pins_joined_inside_cell` in `layout/drc_lite_report.json`). The polysilicon strap
between the pieces is 0.96 um wide and about two squares long, 15 ohm at 7.3 ohm per square, which with half of the
gate capacitance of `inv_12` is a time constant of about 0.3 ps. Netgen compares the extracted layout, in which all
fingers share one gate net, with the netlist: the circuits match."""

def results_table():
    r = []
    a, b = RDV["e449093"], RDV["26nov"]
    r.append(("`bank_cap` in the whole extracted tile: rise time 10 to 90 %, bank not selected and selected",
              f"{cap_rise_old['typ_off']:.0f} ps, {cap_rise_old['typ']:.0f} ps", f"{nc(cap_rise['typ_off'],'{:.0f}')} ps, {nc(cap_rise['typ'],'{:.0f}')} ps"))
    r.append(("The same at ff 3.6 V -40 C" + ("" if cap_rise["ss"] is None else " and at ss 3.0 V 125 C"),
              f"{cap_rise_old['ff']:.0f} ps" + ("" if cap_rise["ss"] is None else "; not recorded"),
              f"{nc(cap_rise['ff'],'{:.0f}')} ps" + ("" if cap_rise["ss"] is None else f"; {cap_rise['ss']:.0f} ps")))
    if a and b:
        r.append(("On the cut-out, edge made by the bank's own divider: rise of `bank_a` (input of the driver); rise and fall of `bank_cap`; delay from `bank_a` to `bank_cap`",
                  f"{a['bank_a_rise_10_90_ps']:.0f} ps; {a['bank_cap_rise_10_90_ps']:.0f} and {a['bank_cap_fall_90_10_ps']:.0f} ps; {a['bank_a_to_bank_cap_ps']:.0f} ps",
                  f"{b['bank_a_rise_10_90_ps']:.0f} ps; {b['bank_cap_rise_10_90_ps']:.0f} and {b['bank_cap_fall_90_10_ps']:.0f} ps; {b['bank_a_to_bank_cap_ps']:.0f} ps"))
    r.append(("Clock pin to `bank_cap` at the flip-flops (typical; ff; ss)", "1.92 ns; 1.14 ns; 3.66 ns",
              "; ".join(nc(ns(clk_cap[c]), "{:.2f} ns") for c in ("typ", "ff", "ss"))))
    for d_, lab in (("fall", "falling"), ("rise", "rising")):
        new = steps(CK, "n2" + d_); extra = ""
        if CK == "wave" and steps("ramp", "n2" + d_): extra = f" ({steps('ramp','n2'+d_)} ps with a 50 ps ramp at the input of the driver)"
        r.append((f"N2: step of the last output crossing per factor of sqrt(10), {lab} data ({TAU_N2*K:.1f} ps corresponds to the latch's tau)",
                  f"{steps('old','n2'+d_)} ps", f"{nc(new,'{}')} ps{extra}"))
    if CAP_SS:
        r.append((f"N2 at ss 3.0 V 125 C, falling data, edge of the divider at that corner: step per factor of sqrt(10) ({TAU_N2_SS*K:.1f} ps corresponds to the latch's tau of {TAU_N2_SS:.1f} ps)",
                  "not simulated", f"{CAP_SS['steps_ps'][0]:.1f} to {CAP_SS['steps_ps'][1]:.1f} ps"))
    if all(x in LAT[CK] for x in ("n2rise", "n2fall")):
        r.append(("N2: output later in a capture 1.5e-16 s from the critical time than in an ordinary capture, rising and falling data",
                  f"{tot('old','n2rise'):.0f}, {tot('old','n2fall'):.0f} ps ({tot('fast','n2rise'):.0f}, {tot('fast','n2fall'):.0f} ps with a 50 ps edge forced on `bank_cap`)",
                  f"{tot(CK,'n2rise'):.0f}, {tot(CK,'n2fall'):.0f} ps"))
    if CNT:
        o = V["count_old"]
        r.append(("N2: time constant of the predicted count (count model)", "7 to 14 ps",
                  (f"{cfit[0]:.1f} ps" if cfit and abs(cfit[1] - cfit[0]) < 0.05 else (f"{cfit[0]:.1f} to {cfit[1]:.1f} ps" if cfit else "not computed"))
                  + (f", {cfit[0]/TAU_N2:.2f} of the latch's {TAU_N2:.2f} ps" if cfit else "")))
    if n1k:
        ks = [x for x in ("n1fall", "n1rise") if x in LAT["wave"]]
        r.append(("N1: step per factor of sqrt(10), " + " and ".join("falling" if x.endswith("fall") else "rising" for x in ks) + f" data ({TAU_N1*K:.1f} ps corresponds to the latch's tau)",
                  "; ".join(steps("old", x) for x in ks) + " ps", "; ".join(steps("wave", x) for x in ks) + " ps"))
    r.append(("Latch tau of N1, N2, N3 (typical)", ", ".join(f"{tau(TAUO, TYP, f):.2f}" for f in ("n1", "n2", "n3")) + " ps", ", ".join(f"{tau(TAU, TYP, f):.2f}" for f in ("n1", "n2", "n3")) + " ps"))
    r.append(("Latch tau of DUT2, DUT3, DUT4, N1 and N2 at typical, ss 3.0 V 125 C and ff 3.6 V -40 C", "", f"equal to {max(tau_maxdiff_core, 0.001):.3f} ps in all fifteen cases; N3 within {tau_maxdiff:.3f} ps"))
    r.append(("*d* at `ua[0]` = 1.0, 1.3, 1.8 and 3.3 V", ", ".join(f"{V['dly_old']['points'][k]['d_ps']:.2f}" for k in sorted(V['dly']['points'], key=float)) + " ps",
              "equal to 0.01 ps" if dmax < 0.0101 else f"within {dmax:.2f} ps"))
    if fd2["rise"] and fd2["fall"]:
        r.append(("Floor of DUT2, rising and falling data (25 C)", f"{fd2['rise']['old']:.1f}, {fd2['fall']['old']:.1f} ps", f"{fd2['rise']['new']:.1f}, {fd2['fall']['new']:.1f} ps"))
    for ff in ("n1", "n2", "n3"):
        if FB.get(ff + "rise") and FB.get(ff + "fall"):
            r.append((f"Bank, {ff.upper()}: floor, from `bank_cap` to the early observer's clock, rising and falling data",
                      f"{fmid(FBO[ff+'rise']):.1f}, {fmid(FBO[ff+'fall']):.1f} ps", f"{fmid(FB[ff+'rise']):.1f}, {fmid(FB[ff+'fall']):.1f} ps"))
    return "| Quantity (extracted with Magic 8.3.573; typical corner, 3.3 V, 27 C unless stated) | Layout of 25 Nov (e449093) | Layout of 26 Nov |\n| --- | --- | --- |\n" + "\n".join(f"| {a} | {b} | {c} |" for a, b, c in r)

def tile_sentence():
    need = ("core", "b1_early", "b2_early", "b3_early", "b2_late", "b2_early_ff", "b2_early_ss")
    have = [t for t in need if t in T]
    parts = []
    if "core" in T: parts.append(f"with `ui_in[7]` low and the data of DUT2 toggled once per trial at `ua[0]` = 1.8 V, {ev('core')} of 4 counted trials are events")
    early = [(n, t) for n, t in (("N1", "b1_early"), ("N2", "b2_early"), ("N3", "b3_early")) if t in T]
    if early: parts.append("with the bank selected and an early clock on `ui_in[5]` 0.2 ns after the clock edge, " + ", ".join(f"{ev(t)} of 4 for {n}" for n, t in early))
    cor = [(c, t) for c, t in (("ff 3.6 V -40 C", "b2_early_ff"), ("ss 3.0 V 125 C", "b2_early_ss")) if t in T]
    if cor: parts.append("for N2 " + " and ".join(f"{ev(t)} of 4 at {c}" for c, t in cor))
    if "b2_late" in T: parts.append(f"with the early clock 6 ns after the clock edge, {ev('b2_late')} of 4 for N2")
    s = "The whole extracted tile was simulated again (`layout/make_tb_chip.py`): " + "; ".join(parts) + "."
    s += " `busy` is high and `done` and `fault` are low at the end of every run." if flags_ok else " NOTE: the flags are not as expected in every run."
    miss = [t for t in need if t not in T]
    if miss: s += " Not run: " + ", ".join(miss) + "."
    return s

def supply_sentence():
    if not all(k in irs for k in ("core", "b2", "ff")): return None
    o = V["ir_old"]
    return (f"With the stronger driver the tile draws {irs['core']['avg_uA']:.1f} uA on average while counting (before, {o['core']['VDPWR']['avg_uA']:.1f} uA), "
            f"{irs['b2']['avg_uA']:.1f} uA with the bank selected ({o['b2']['VDPWR']['avg_uA']:.1f} uA) and {irs['ff']['avg_uA']:.1f} uA at ff 3.6 V -40 C with both data inputs toggled "
            f"({o['ff']['VDPWR']['avg_uA']:.1f} uA); the peaks are {irs['core']['peak_mA']:.2f}, {irs['b2']['peak_mA']:.2f} and {irs['ff']['peak_mA']:.2f} mA "
            f"({o['core']['VDPWR']['peak_uA']/1000:.2f}, {o['b2']['VDPWR']['peak_uA']/1000:.2f} and {o['ff']['VDPWR']['peak_uA']/1000:.2f} mA). The static drop at a cell is at most "
            f"{max(v['static_mV_max'] for v in irs.values()):.2f} mV, and the largest instantaneous drop is {min(min(v['peak_mV_straps']) for v in irs.values()):.0f} to "
            f"{max(max(v['peak_mV_end']) for v in irs.values()):.0f} mV, at N2 as before (before, 9 to 55 mV). The largest average current is {max(v['em_max'] for v in irs.values())*100:.1f} % "
            f"of an electromigration limit.")

CHECKS = [("DRC", "Magic 8.3.573 and Magic 8.3.703, PDK `gf180mcuD`", "0 errors in both", "`drc_magic_8.3.573.txt`, `drc_magic_8.3.703.txt`"),
          ("DRC, main rule deck of the PDK", "KLayout 0.28.16, flat, on a private copy of the deck patched for this KLayout version", "0 violations", "`klayout_main_deck.txt`"),
          ("LVS against `layout/chip_lvs.spice`", "Netgen 1.5.133 on the extractions of both Magic versions", "\"Circuits match uniquely\": 208 devices, 209 nets at the top level", "`lvs_report_magic8.3.573_netgen1.5.133.txt`, `lvs_report_magic8.3.703_netgen1.5.133.txt`"),
          ("Antenna", "Magic 8.3.573", "0", "`antenna_magic_8.3.573.txt`"),
          ("The generator's own checks", "`tools/drc_lite.py`", "no rule violation, short or open; two pins joined inside their cell; worst antenna ratio 188 of 400", "`layout/drc_lite_report.json`"),
          ("Schematics against the netlist", "`tools/sch_check.py`, `tools/check_focus.py`", "SAME CIRCUIT (2,002 transistors, 2 diodes); ALL SAME", "`sch_check.txt`, `check_focus.txt`"),
          ("File checks of the Tiny Tapeout precheck", "`tools/precheck_lite.py`", "ALL PASS", "`precheck_lite.txt`"),
          ("Tiny Tapeout precheck, offline", "tt-support-tools 21568ef, `precheck.py`", "the nine steps that can run here pass: pin labels, zero area, KLayout checks, pins, boundary, power pins, layers, cell names, analog pins. "
           "The rule-deck step and the antenna step do not run their rules with the PDK installed here, and the Verilog step lacks its tool; the `gds` workflow on GitHub runs all twelve", "`tt_precheck_offline.md`"),
          ("Unchanged part of the tile", "KLayout XOR against the GDS of e449093", "0 polygons above y = 199 um on every layer", "`xor_against_e449093.txt`"),
          ("Latch-up distances, taps", "`verification/physical/tools/lu_check.py`, `tap_rows.py`", "largest distance 14.39 um against 15 um, in N2, as before; 445 substrate and 445 well taps", "`lu_check.txt`, `tap_rows.txt`"),
          ("No gate undriven", "`verification/physical/tools/gate_check.py`", "506 nets reach a gate; none without a source, drain, diode or pin", "`gate_check.txt`"),
          ("`layout/mag/`, the copy for Magic", "written by `layout/gds2mag.tcl` with Magic 8.3.703, then loaded and checked", "0 DRC errors; circuits match uniquely", "`mag_copy_check.txt`")]
def checks_table(prefix):
    return "| Check | Tool | Result | Log |\n| --- | --- | --- | --- |\n" + "\n".join(f"| {a} | {b} | {c} | {d.replace('`drc', '`'+prefix+'drc') if False else d} |" for a, b, c, d in CHECKS)

CAP_SS = LAT["wave_ss"].get("n2fall") if "wave_ss" in LAT else None      # captures of N2 at the slow corner, falling data
TAU_N2_SS = tau(TAU, SS, "n2")
NOT_REPEATED = ("the Tiny Tapeout precheck with the PDK's KLayout decks in deep mode and its antenna deck, which the `gds` workflow on GitHub "
                "runs on the pushed commit; the count model of DUT2 and the other numbers of `verification/physical/SIMULATIONS.md` for DUT1 to DUT4, whose cells and "
                "wiring above y = 199 um are identical (*d*, the time constants and the floors of DUT2 were repeated, see the table); extraction with Magic 8.3.703 beyond DRC and LVS; "
                + ("captures of N2 at the fast corner and of N1 at the corners; " if CAP_SS else "captures of N2 and N1 at the slow and the fast corner; ")
                + ("" if n1k else "captures of N1 on the present layout; ") + "wire resistance; any run on ecetesla0")

def lat_sentence():
    k = "the capture edge made by the bank's own divider" if CK == "wave" else "a 50 ps ramp at the input of the driver"
    s = (f"With {k}, the last crossing of N2's output moves by {n2_steps_lo:.1f} to {n2_steps_hi:.1f} ps per factor of sqrt(10) for distances of 1.5e-12 to 1.5e-15 s, "
         f"which is a local time constant of {n2_steps_lo/K:.1f} to {n2_steps_hi/K:.1f} ps, {n2_steps_lo/K/TAU_N2:.2f} to {n2_steps_hi/K/TAU_N2:.2f} of the latch's {TAU_N2:.2f} ps")
    if cfit: s += f"; the count model gives {cfit[0]:.1f} ps, {cfit[0]/TAU_N2:.2f} of it"
    return s + "."

def readme_section():
    t = f"""### The bank's capture driver (changed on 26 November 2026)

**Why.** {why}

**What changed.** {change}

{pin_note}

**Result.** The edge now rises in {nc(cap_rise['typ_off'],'{:.0f}')} ps in the whole tile. {lat_sentence()} Everything that does not involve the
bank's capture edge is as before.

{results_table()}

The driver is not the fastest that the library allows. The flip-flop of the divider drives `bank_a` with a rise time
of {RDV['26nov']['bank_a_rise_10_90_ps']:.0f} ps ({RDV['e449093']['bank_a_rise_10_90_ps']:.0f} ps before), because its output stage is of unit strength and now drives `inv_4`; a
50 ps ramp at the same point gives {265:.0f} ps on `bank_cap` instead of {RDV['26nov']['bank_cap_rise_10_90_ps']:.0f} ps. A trial with both inverters one and a half times as
strong again, in the netlist of the cut-out with a 50 ps ramp at the input, gave {RDV9:.0f} ps on `bank_cap` and moved the steps of N2 by 1.9 ps
(`verification/bank_driver/sim/lateness.txt`), so the layout was not changed further.

{tile_sentence()}

{supply_sentence() or 'Supply current and voltage drop were not recomputed.'}

**Checks of the present layout** (GDS SHA-1 `{GDS_NEW}`; logs in `verification/bank_driver/layout/`).

{checks_table('')}

**Not repeated on the present layout:** {NOT_REPEATED}. `verification/bank_driver/README.md` lists every file.
"""
    return wrap(t)

# ------------------------------------------------------------------------------------------------ 1. fragments
if os.path.isdir(B2): shutil.rmtree(B2)
shutil.copytree(B, B2, ignore=shutil.ignore_patterns("*.patch", "kdeck", "e449*", "rev2*", "rc", "ant_*", "kdrc_*"))
F = lambda n: open(f"{B2}/{n}").read()
def put(n, s): open(f"{B2}/{n}", "w").write(s)

s = F("frag_physical.md")
s = rsub(s, "The numbers come from the audit of 26 Nov 2026 in `verification/physical/README.md`, made on the layout of commit e449093.",
         "The numbers come from the audit of 26 Nov 2026 in `verification/physical/README.md`, made on the layout of commit e449093; where the change of the bank's capture "
         "driver on the same day moved a number, the number of the present layout is given (`verification/bank_driver/README.md`, Section 5).", "physical intro")
s = rsub(s, "444 substrate taps on `VGND` and 444 well taps on `VDPWR`", "445 substrate taps on `VGND` and 445 well taps on `VDPWR`", "taps")
if all(k in irs for k in ("core", "b2", "ff")):
    s = rsub(s, "the tile draws 46 uA on average while counting (52 uA with the bank selected, 62 uA at the fast corner at 3.6 V), with peaks of 1.6 to 4.9 mA at the capture edge. "
                "The static drop at any cell is at most 0.33 mV. The largest instantaneous drop is 9 to 55 mV, at N2,",
             f"the tile draws {irs['core']['avg_uA']:.0f} uA on average while counting ({irs['b2']['avg_uA']:.0f} uA with the bank selected, {irs['ff']['avg_uA']:.0f} uA at the fast corner at 3.6 V), "
             f"with peaks of {irs['core']['peak_mA']:.1f} to {irs['ff']['peak_mA']:.1f} mA at the capture edge. The static drop at any cell is at most {max(v['static_mV_max'] for v in irs.values()):.2f} mV. "
             f"The largest instantaneous drop is {min(min(v['peak_mV_straps']) for v in irs.values()):.0f} to {max(max(v['peak_mV_end']) for v in irs.values()):.0f} mV, at N2,", "supply numbers")
    s = rsub(s, "the largest average current is 10 uA in a rail (limit 402 uA), 6 uA in a via (180 uA) and 29 uA in a stripe (1340 uA): at most 3.2 % of a limit.",
             f"the largest average current is {max(v['rail_uA'] for v in irs.values()):.0f} uA in a rail (limit 402 uA), {max(v['via_uA'] for v in irs.values()):.0f} uA in a via (180 uA) and "
             f"{max(v['stripe_uA'] for v in irs.values()):.0f} uA in a stripe (1340 uA): at most {max(v['em_max'] for v in irs.values())*100:.1f} % of a limit.", "EM numbers")
else:
    MISSING.append("supply numbers of the README (left as for e449093)")
s = rsub(s, "**What was decided.** The layout of e449093 is unchanged by the audit. The reasons are in `verification/physical/README.md`, Section 1.",
         "**What was decided.** The audit changed nothing in the supply network, the taps or the wells; the reasons are in `verification/physical/README.md`, Section 1. "
         "The simulations of the same day led to one change of the layout, the driver of the bank's capture edge (\"The bank's capture driver\" above).", "decision")
put("frag_physical.md", s)

s = F("frag_testing.md")
s = rsub(s, "Magic DRC (8.3.573 and 8.3.703): 0 errors. KLayout GF180MCU deck and antenna deck in the `gds` workflow on GitHub (run 45730953549): 0 violations each",
         "Magic DRC (8.3.573 and 8.3.703): 0 errors; KLayout GF180MCU main deck, flat: 0 violations; Magic antenna check: 0. The `gds` workflow on GitHub runs the KLayout deck in deep mode "
         "and the antenna deck on every push (for e449093, run 45730953549: 0 violations each)", "testing drc")
s = rsub(s, "precheck in the `gds` workflow: passed; revision e449093 submitted as pull request 65",
         "precheck in the `gds` workflow on the pushed commit. For e449093 it passed, and Tiny Tapeout merged the revision into the shuttle on 26 Nov (pull request 65); the layout of 26 Nov is submitted in the same way after its push", "testing tt")
if "b2" in irs:
    s = rsub(s, "20 uA and 46 uA at the typical corner (52 uA with the bank selected).", f"20 uA and {irs['core']['avg_uA']:.0f} uA at the typical corner ({irs['b2']['avg_uA']:.0f} uA with the bank selected).", "bench current")
put("frag_testing.md", s)

s = F("readme_open.md")
s = rsub(s, "Until Tiny Tapeout merges it, the shuttle lists commit 22956c2, the layout with the old controller.",
         "Tiny Tapeout merged it on 26 Nov 2026 at 09:23 UTC: since then the shuttle's record of the project, `projects/tt_um_metastability_characterizer/commit_id.json`, "
         "names commit e449093 (before, 22956c2, the layout with the old controller). The layout of 26 Nov takes the same steps after its push: "
         "the `gds` workflow must pass on the pushed commit, the commit is then submitted in the Tiny Tapeout app as a new revision of project 6616, and Tiny Tapeout merges it. Until then "
         "the chip that would be made is e449093; it differs from the present layout only in the driver of the bank's capture edge.", "open tt")
_open = ("- **N2 on the present layout.** The count model of N2 was computed at the typical corner only. The capture edge and the latch slow down together: the edge rises in "
         + (f"{cap_rise['ff']:.0f}, {cap_rise['typ_off']:.0f} and {cap_rise['ss']:.0f} ps at the fast, the typical and the slow corner, where the latch of N2 has 20.3, 29.6 and 48.1 ps" if cap_rise["ss"] and cap_rise["ff"] else "more slowly at the slow corner, where the latch is slower as well")
         + (f". Captures at the slow corner, with falling data, give a step of {CAP_SS['steps_ps'][0]:.1f} to {CAP_SS['steps_ps'][1]:.1f} ps where {TAU_N2_SS*K:.1f} ps is ideal; rising data and the fast corner were not simulated." if CAP_SS
            else "; that the count follows the latch there as well was not checked by captures at the corners."))
_lines = wrap(_open[2:], 116).rstrip("\n").split("\n")
s = s.rstrip("\n") + "\n- " + _lines[0] + "".join("\n  " + l for l in _lines[1:]) + "\n"
put("readme_open.md", s)

s = F("readme_rows.md").rstrip("\n")
s += "\n| `verification/bank_driver/` | The change of 26 Nov 2026 to the driver of the bank's capture edge: reason, checks of the new GDS, simulations repeated on its extraction. |\n"
put("readme_rows.md", s)

s = F("readme_added.md")
s = rsub(s, "(falling and rising data).", "(falling and rising data). These numbers for N2 describe the layout of 25 Nov; the driver of that edge was strengthened on 26 Nov (next section).", "added N2 note")
s = rsub(s, "For the bank, the floor is the delay from the bank's capture edge at the flip-flops to the clock of its early observer (typical corner):",
         "For the bank, the floor is the delay from the bank's capture edge at the flip-flops to the clock of its early observer (typical corner; these are the values of the layout of 25 Nov, "
         "and those of the present layout are in the table of the next section):", "added bank floors")
put("readme_added.md", s)

s = F("info_add.md")
if "b2" in irs:
    s = rsub(s, "46 µA from the 3.3 V supply while it counts (52 µA with the bank selected),", f"{irs['core']['avg_uA']:.0f} µA from the 3.3 V supply while it counts ({irs['b2']['avg_uA']:.0f} µA with the bank selected),", "info current")
    s = rsub(s, "the peaks at each capture edge are 1.6 to 4.9 mA.", f"the peaks at each capture edge are {irs['core']['peak_mA']:.1f} to {irs['ff']['peak_mA']:.1f} mA.", "info peaks")
s = rsub(s, "The audit led to no change of the layout.", "The audit led to no change of the supply network; `verification/bank_driver/README.md` describes the one change made on 26 Nov, to the driver of the bank's capture edge.", "info audit")
put("info_add.md", s)

cau = (f"**Capture driver of the bank, changed on 26 Nov 2026.** On the layout of 25 Nov the bank's capture edge reached N1, N2 and N3 with a rise time of about 1 ns. "
       f"The slave of N2 is opened by this edge, and most of the lateness of its latch was hidden behind it: the simulated count of N2 fell with a local time constant of 7 to 14 ps, "
       f"not with the {TAU_N2:.1f} ps of the latch. The two inverters that drive the edge were therefore replaced by stronger ones. The edge now rises in {nc(ns(cap_rise['typ_off']),'{:.2f}')} ns, "
       f"and in the same simulation the last output crossing of N2 follows a time constant of {n2_steps_lo/K:.0f} to {n2_steps_hi/K:.0f} ps"
       + (f"; the predicted count falls with {cfit[0]:.1f} ps" if cfit else "") + ". Nothing above the bank was changed, and τ of all six latches is the same as before. "
       "Details: `verification/bank_driver/README.md` in the repository.")
put("info_caution.md", wrap(cau, 78))

# ------------------------------------------------------------------------------------------------ 2. README, info.md
subprocess.run(["git", "checkout", "e449093", "--", "README_analog.md", "docs/info.md"], cwd=R, check=True)
print(subprocess.run(["python3", f"{W}/scripts/apply_docs.py", R, B2], capture_output=True, text=True).stdout.strip())
p = f"{R}/README_analog.md"; s = open(p).read()
s = rsub(s, "| Capture edge, data input | two `inv_2` each; the data comes from `uio_in[0]` |",
         "| Capture edge | `inv_4` and `inv_12` in series (two `inv_2` until 26 Nov 2026; see \"The bank's capture driver\" below) |\n| Data input | two `inv_2`; the data comes from `uio_in[0]` |", "bank table")
s = rsub(s, "The tile now has 1,978 transistors and 2 diodes.", "The tile now has 2,002 transistors and 2 diodes (1,978 until the capture driver was changed on 26 Nov).", "transistors")
s = rsub(s, f"**Checks of the revised layout** (GDS SHA-1 `{GDS_OLD}`).",
         f"**Checks of the layout of 25 Nov** (commit e449093, GDS SHA-1 `{GDS_OLD}`). The checks of the present layout are listed under \"The bank's capture driver\" below.", "checks heading")
s = rsub(s, "## Physical design\n", readme_section() + "\n## Physical design\n", "new section") if False else s
i = s.index("\n## Physical design\n"); assert s.count("\n## Physical design\n") == 1
s = s[:i + 1] + readme_section() + "\n" + s[i + 1:]
open(p, "w").write(s)

p = f"{R}/docs/info.md"; s = open(p).read()
if clk_cap["typ"] and clk_cap["ff"]:
    s = rsub(s, "| Clock pin to the bank's capture edge at the flip-flops | 1.92 ns (1.14 ns, 3.66 ns) |",
             f"| Clock pin to the bank's capture edge at the flip-flops | {ns(clk_cap['typ']):.2f} ns ({ns(clk_cap['ff']):.2f} ns, {nc(ns(clk_cap['ss']),'{:.2f} ns')}) |", "info clk")
else: MISSING.append("info.md: clock pin to capture edge")
if obs_d["typ"] is not None and obs_d["ff"] is not None and obs_d["ss"] is not None:
    s = rsub(s, "| `ui[5]` pin to the clock of the early observer | 0.27 ns (0.17 ns, 0.49 ns) |",
             f"| `ui[5]` pin to the clock of the early observer | {ns(obs_d['typ']):.2f} ns ({ns(obs_d['ff']):.2f} ns, {ns(obs_d['ss']):.2f} ns) |", "info obs")
def arow(ff, old, corners=False):
    global s
    a = arr.get(ff)
    if not a or None in a: MISSING.append(f"info.md: arrival {ff}"); return
    new = f"{a[0]/1000:.2f} ns rising, {a[1]/1000:.2f} ns falling"
    if corners:
        f_, s_ = arr.get("n2ff"), arr.get("n2ss")
        if f_ and s_ and None not in f_ and None not in s_: new += f" ({f_[0]/1000:.2f} and {f_[1]/1000:.2f} ns, {s_[0]/1000:.2f} and {s_[1]/1000:.2f} ns)"
        elif f_ and None not in f_: new += f" ({f_[0]/1000:.2f} and {f_[1]/1000:.2f} ns at the fast corner; slow corner not computed)"
    s = rsub(s, f"| Capture edge to new value at the early observer, {ff.upper()} | {old} |", f"| Capture edge to new value at the early observer, {ff.upper()} | {new} |", "info arrival " + ff)
arow("n1", "1.23 ns rising, 1.40 ns falling")
arow("n2", "1.96 ns rising, 2.59 ns falling (1.21 and 1.62 ns, 3.71 and 4.83 ns)", True)
arow("n3", "1.74 ns rising, 2.05 ns falling")
if lead is not None:
    s = rsub(s, "The bank's capture edge comes 0.16 ns before the capture edge of DUT1 to DUT4.", f"The bank's capture edge comes {lead/1000:.2f} ns before the capture edge of DUT1 to DUT4.", "info lead")
if kfall:
    s = rsub(s, "to fall when the `ui[5]` edge is about 2.9 to 4.2 ns after the clock edge at the typical corner,", f"to fall when the `ui[5]` edge is about {kfall[0]:.1f} to {kfall[1]:.1f} ns after the clock edge at the typical corner,", "info kfall")
else: MISSING.append("info.md: range of the ui[5] delay at which K starts to fall")
open(p, "w").write(s)

# ------------------------------------------------------------------------------------------------ 3. FAILURE_SPACE and notes
subprocess.run(["git", "checkout", "audit/physical-design", "--", "verification/FAILURE_SPACE.md", "verification/physical/README.md",
                "verification/physical/SIMULATIONS.md", "verification/bank/README.md"], cwd=R, check=True)       # the versions of the audit of e449093
p = f"{R}/verification/FAILURE_SPACE.md"; s = open(p).read()
s = rsub(s, f"Layout: commit e449093, GDS SHA-1 `{GDS_OLD}`.",
         f"Layout: the layout of 26 Nov 2026, GDS SHA-1 `{GDS_NEW}`. It is the layout of commit e449093 (GDS SHA-1 `{GDS_OLD}`) with a stronger driver for the bank's capture edge "
         "(`verification/bank_driver/README.md`); above y = 199 um, where DUT1 to DUT4, the delay line and the controller are, the two are identical. Checks named below without a "
         "layout were repeated on the layout of 26 Nov. Of the simulations of the identical part, *d*, the time constants and the floors of DUT2 were repeated and agree to 0.01 ps, 0.001 ps and 0.4 ps; the others were not repeated.", "FS layout")
s = rsub(s, "the `gds` workflow run 45730953549 on GitHub for commit e449093.", "the `gds` workflow run 45730953549 on GitHub for commit e449093; `verification/bank_driver/` for the layout of 26 Nov.", "FS sources")
s = rsub(s, "KLayout GF180MCU deck in the GitHub precheck: 0 violations. Magic DRC 8.3.573 and 8.3.703: 0 errors",
         "Magic DRC 8.3.573 and 8.3.703: 0 errors. KLayout GF180MCU main deck, flat: 0 violations. In the GitHub precheck the deck runs in deep mode on the pushed commit (e449093: 0 violations)", "FS 1.1")
s = rsub(s, "KLayout antenna deck (GitHub): 0. Magic antenna check: 0", "Magic antenna check: 0. The KLayout antenna deck runs in the GitHub precheck on the pushed commit (e449093: 0)", "FS 1.2")
s = rsub(s, "Tiny Tapeout precheck on GitHub: passed", "`tools/precheck_lite.py`: ALL PASS. The Tiny Tapeout precheck on GitHub runs on the pushed commit (e449093: passed)", "FS 1.3")
s = rsub(s, "SAME CIRCUIT, 1,978 transistors and 2 diodes", "SAME CIRCUIT, 2,002 transistors and 2 diodes", "FS 2.2")
if all(k in irs for k in ("core", "b2", "ff")):
    s = rsub(s, "static drop at most 0.33 mV", f"static drop at most {max(v['static_mV_max'] for v in irs.values()):.2f} mV", "FS 5.2")
    s = rsub(s, "9 to 55 mV for an instant, at N2", f"{min(min(v['peak_mV_straps']) for v in irs.values()):.0f} to {max(max(v['peak_mV_end']) for v in irs.values()):.0f} mV for an instant, at N2", "FS 5.3")
s = rsub(s, "444 substrate and 444 well taps", "445 substrate and 445 well taps", "FS 5.6")
i = s.index("| 6.9 |"); j = s.index("\n", i)
row = (f"| 6.9 | The bank's capture edge is too slow for its fast flip-flops | bounded | found on 26 Nov on the layout of e449093: `bank_cap` rose in 1.05 ns and the slave of N2, which that edge opens, "
       f"hid the latch's lateness (local time constant of the count 7 to 14 ps where the latch has {TAU_N2:.1f} ps). Removed the same day by a stronger driver: `bank_cap` now rises in "
       f"{nc(cap_rise['typ_off'],'{:.0f}')} ps, and N2's last crossing moves with {n2_steps_lo/K:.1f} to {n2_steps_hi/K:.1f} ps"
       + (f"; count model {cfit[0]:.1f} ps, {cfit[0]/TAU_N2:.2f} of the latch's" if cfit else "") + " (`bank_driver/README.md`). " + (f"Count model at the typical corner; at the slow corner captures with falling data give {CAP_SS['steps_ps'][0]/K:.1f} to {CAP_SS['steps_ps'][1]/K:.1f} ps where the latch has {TAU_N2_SS:.1f} ps |" if CAP_SS else "Typical corner only |"))
s = s[:i] + row + s[j:]
s = rsub(s, "Excluded or bounded: every entry except 1.6, 1.7, 5.5, 5.7, 5.9, 6.3, 6.7, 6.8, 6.9, 7.4 and 7.5, and the jitter part of 4.6. Of the open entries, 6.9 is a limit of the layout as "
            "submitted and has a known remedy; 6.3 and 6.7",
         "Excluded or bounded: every entry except 1.6, 1.7, 5.5, 5.7, 5.9, 6.3, 6.7, 6.8, 7.4 and 7.5, and the jitter part of 4.6. Entry 6.9 was open for the layout of e449093, which is the "
         "revision submitted to Tiny Tapeout until the layout of 26 Nov is pushed and submitted. Of the open entries, 6.3 and 6.7", "FS summary")
open(p, "w").write(s)

NOTE = ("> This document describes the layout of commit e449093 (25 Nov 2026). On 26 Nov the driver of the bank's capture edge was strengthened; "
        "`{rel}bank_driver/README.md` gives the reason, the checks of the new GDS and the numbers that changed. Above y = 199 um the two layouts are identical.\n\n")
for f, rel in (("verification/physical/README.md", "../"), ("verification/physical/SIMULATIONS.md", "../"), ("verification/bank/README.md", "../")):
    p = f"{R}/{f}"; s = open(p).read()
    if "bank_driver/README.md" not in s.split("\n## ")[0]:
        i = s.index("\n") + 1
        s = s[:i] + "\n" + wrap(NOTE.format(rel=rel)).replace("\n", "\n> ").rstrip("> ").rstrip() + "\n" + s[i:]
        open(p, "w").write(s)

# ------------------------------------------------------------------------------------------------ 4. bank_driver folder
for d in ("sim", "tile"): os.makedirs(f"{D}/{d}", exist_ok=True)
cp = lambda a, b: shutil.copy(a, b) if os.path.exists(a) else MISSING.append("file " + a)
for tag in RD.TAGS:
    if tag in T:
        cp(f"{S}/rev2/tile/isup_{tag}.results.txt", f"{D}/tile/{tag}.results.txt"); cp(f"{P}/edges_{tag}.txt", f"{D}/tile/{tag}.edges.txt")
json.dump({k: dict(v, condition={"core": "bank not selected, DUT2 data toggled, typical 3.3 V 27 C", "b2": "bank selected (N2), bank data toggled, typical 3.3 V 27 C",
                                  "ff": "bank selected (N2), both data inputs toggled, ff 3.6 V -40 C"}[k]) for k, v in irs.items()}, open(f"{D}/tile/supply_summary.json", "w"), indent=1)
for k in ("core", "b2", "ff"): cp(f"{P}/irem_{k}.txt", f"{D}/tile/supply_{k}.txt")
for f in glob.glob(f"{P}/window_*.txt"): cp(f, f"{D}/tile/" + os.path.basename(f).replace("window_", "delay_line_supply_").replace("b2_early_ff", "ff").replace("b2_early", "b2"))
cp(f"{S}/rev2/tau_573.json", f"{D}/sim/tau_magic8.3.573.json"); cp(f"{S}/rev2/dly/dly_rev2_typical_3.3_27.0.json", f"{D}/sim/delay_typical.json")
for f in glob.glob(f"{S}/rev2/floor/floor*.json"): cp(f, f"{D}/sim/" + os.path.basename(f))
for f in glob.glob(f"{S}/tchar_rev2t/tchar_*.json"): cp(f, f"{D}/sim/" + os.path.basename(f).replace("tchar_rev2t_", "captures_ramp_"))
for f in glob.glob(f"{S}/tchar_rev2w/tchar_*.json"): cp(f, f"{D}/sim/" + os.path.basename(f).replace("tchar_rev2w_", "captures_divider_edge_"))
for k in ("rev2", "rev2w"):
    for e in ("json", "txt"):
        if os.path.exists(f"{S}/rev2/count/count_n2_{k}.{e}"): cp(f"{S}/rev2/count/count_n2_{k}.{e}", f"{D}/sim/count_n2_{'ramp' if k == 'rev2' else 'divider_edge'}.{e}")
for f in glob.glob(f"{S}/tchar_9x3/tchar_*.json"): cp(f, f"{D}/sim/captures_trial_inverters_1.5_times_as_strong_" + os.path.basename(f).split("_")[-1])
cp(f"{S}/capfix/driver_sweep.json", f"{D}/sim/driver_sweep_netlist_level.json")
for k in ("e449093", "26nov"): cp(f"{S}/rev2/realdiv/{k}_typical.json", f"{D}/sim/capture_edge_from_the_divider_{k}.json")
cp(f"{S}/rev2/capramp/bank_a_edge_typical.json", f"{D}/sim/bank_a_edge_typical.json")
if CAP_SS:
    cp(f"{S}/rev2/capramp/bank_a_edge_ss.json", f"{D}/sim/bank_a_edge_ss.json"); cp(f"{S}/rev2/realdiv/26nov_ss.json", f"{D}/sim/capture_edge_from_the_divider_26nov_ss.json")
for f in ("realdiv.py", "rev2_data.py", "rev2_docs.py", "tchar.py"): cp(f"{W}/scripts/{f}", f"{D}/tools/{f}")
lat_lines = []
for key, lab in (("old", "layout of 25 Nov (e449093)"), ("ramp", "layout of 26 Nov, 50 ps ramp at the input of the driver"), ("wave", "layout of 26 Nov, edge of the bank's own divider"),
                 ("fast", "layout of 25 Nov, 50 ps ramp forced on bank_cap itself"), ("x9x3", "26 Nov netlist with both inverters 1.5 times as strong, ramp"), ("wave_ss", "layout of 26 Nov, edge of the divider, ss 3.0 V 125 C")):
    for x in ("n2fall", "n2rise", "n1fall", "n1rise"):
        L = LAT[key].get(x)
        if L: lat_lines.append(f"{lab:58s} {x[:2].upper()} {'falling' if x.endswith('fall') else 'rising ':7s}  steps {L['steps_ps'][0]:5.1f} to {L['steps_ps'][1]:5.1f} ps   local time constant {L['steps_ps'][0]/K:5.1f} to {L['steps_ps'][1]/K:5.1f} ps   tail {L['tail_ps']:6.2f} ps")
open(f"{D}/sim/lateness.txt", "w").write("Step of the last output crossing per factor of sqrt(10) in the distance of the data edge from the critical time\n(distances 1.5e-12 to 1.5e-15 s), "
                                         "the local time constant step / ln(sqrt(10)), and the slope for distances of 1.5e-13 s and less (tools/lateness.py).\n"
                                         f"Latch time constants at the typical corner: N2 {TAU_N2:.2f} ps, N1 {TAU_N1:.2f} ps; N2 at ss 3.0 V 125 C: {tau(TAU, SS, 'n2'):.2f} ps.\n\n" + "\n".join(lat_lines) + "\n")

_rss = RD.J(f"{S}/rev2/realdiv/26nov_ss.json")
SS_METHOD = ("" if not (CAP_SS and _rss) else " The run at the slow corner uses the waveform recorded at that corner (`sim/bank_a_edge_ss.json`): there the divider gives `bank_cap` a rise time of "
             f"{_rss['bank_cap_rise_10_90_ps']:.0f} ps on the cut-out and {cap_rise['ss']:.0f} ps in the whole tile.")
def bd_readme():
    files = sorted(os.listdir(f"{D}/layout")); sims = sorted(os.listdir(f"{D}/sim")); tiles = sorted(os.listdir(f"{D}/tile")); tools = sorted(os.listdir(f"{D}/tools"))
    sup = ""
    if all(k in irs for k in ("core", "b2", "ff")):
        o = V["ir_old"]
        rows = []
        for k, lab in (("core", "bank not selected, typical"), ("b2", "bank selected (N2), typical"), ("ff", "bank selected, both data inputs toggled, ff 3.6 V -40 C")):
            a = irs[k]; b = o[k]
            rows.append(f"| {lab} | {b['VDPWR']['avg_uA']:.2f} uA, {b['VDPWR']['peak_uA']/1000:.2f} mA | {a['avg_uA']:.2f} uA, {a['peak_mA']:.2f} mA | "
                        f"{min(b['straps']['VDPWR']['worst_peak_mV'], b['straps']['VGND']['worst_peak_mV']):.1f} to {max(b['end']['VDPWR']['worst_peak_mV'], b['end']['VGND']['worst_peak_mV']):.1f} mV | "
                        f"{min(a['peak_mV_straps']):.1f} to {max(a['peak_mV_end']):.1f} mV | {a['em_max']*100:.1f} % |")
        sup = ("| Run | Average and peak supply current, 25 Nov | 26 Nov | Largest instantaneous drop at a cell (two cases of the feed), 25 Nov | 26 Nov | Largest current against an electromigration limit, 26 Nov |\n"
               "| --- | --- | --- | --- | --- | --- |\n" + "\n".join(rows))
    t = f"""# The bank's capture driver: layout of 26 Nov 2026

This folder holds the logs behind the section "The bank's capture driver" of `README_analog.md`. The layout
described here is the GDS whose SHA-1 is in `layout/gds.sha1`. It differs from the layout of commit e449093 (25 Nov
2026; `verification/bank/`, `verification/physical/`) in two cells. Tools: Magic 8.3.573 and 8.3.703, Netgen
1.5.133, KLayout 0.28.16, ngspice 42, PDK `gf180mcuD`. No chip has been measured. Paths inside the scripts are those
of the machine on which they ran.

## 1. Reason

{why}

The check that found this was the count model, not a rule check or a functional simulation. DRC, LVS and the
whole-tile runs of e449093 all passed, and rightly: the layout obeyed the rules, was the circuit of the netlist,
and counted 4 events in 4 trials with an early clock and 0 in 4 with a late one. None of these asks how the count
falls between the two. The control for the diagnosis was a 50 ps ramp forced on `bank_cap` itself in the same
bench: the steps of N2 returned to {steps('fast','n2fall')} ps (falling data) and {steps('fast','n2rise')} ps (rising data).

## 2. The change

{change}

{pin_note}

## 3. Checks of the new GDS

Logs in `layout/`.

{checks_table('layout/')}

The netlist that was simulated was extracted from an earlier run of the generators on the same sources. Compared
with the extraction of the committed GDS it has the same devices and the same 7,302 capacitors (2607.26 fF); the
two differ in the order of two ports of one subcircuit and in capacitors of value 0
(`layout/extraction_compared_with_simulated_netlist.txt`, `tools/pexcmp.py`).

## 4. Simulations on the new extraction (Magic 8.3.573)

{results_table()}

Methods. The whole-tile numbers are from the bench of `layout/make_tb_chip.py` with a current probe on every cell
(`tools/tile_run.sh`, `tools/edges_raw.py`). The cut-out is the front end and the bank taken from the extraction,
with the controller replaced by sources (`verification/physical/tools/sim/cutout.py`). In it the capture edge is
applied at `bank_a`, the output of the divider's flip-flop and the input of the driver. Three forms of that edge
were used: a 50 ps ramp; the waveform that the divider's own flip-flop produces when the divider is clocked
(`tools/realdiv.py`, recorded in `sim/bank_a_edge_typical.json`); and, for the control on the old layout, a 50 ps
ramp forced on `bank_cap` itself. With the recorded waveform the cut-out reproduces the edge of the whole tile:
{RDV['26nov']['bank_cap_rise_10_90_ps']:.1f} ps against {nc(cap_rise['typ_off'])} ps, and {RDV['26nov']['clk_to_bank_cap_ps']:.1f} ps against {nc(clk_cap['typ'])} ps from the clock. The captures
are those of `tools/tchar.py`, which is the bench of `verification/physical/tools/sim/tchar.py` with the option
`CAPWAVE` for the recorded waveform: the critical data time is found by bisection to 1e-17 s,
and captures are then taken at 15 distances from it, from 1.5 ns down to 1.5e-16 s (`sim/lateness.txt`).{SS_METHOD}

{lat_sentence()} The step still grows slowly as the distance shrinks, so the local time constant depends a little on
where it is taken; the count model takes this into account (`sim/count_n2_*.txt`).

{tile_sentence()}

## 5. Supply current and voltage drop

The model and the limits are those of `verification/physical/README.md`, Sections 3 to 5, with the rails and taps
of the new GDS (`layout/tap_rows.txt`; all rails 0.60 um wide as before).

{sup or 'Not computed.'}

In every run the cell with the largest instantaneous drop is N2, as before. With the bank not selected the drop is
larger than before because the bank's divider and capture driver run in every trial whether the bank is selected or
not, and the edge is now faster. At the delay line the mean rise of the ground rail during the delay interval is
0.79 to 0.96 mV as before (`tile/delay_line_supply_*.txt`). The static drop is at most {max(v['static_mV_max'] for v in irs.values()) if irs else float('nan'):.2f} mV. The decision of the audit
stands: no guard ring, decoupling cell or additional tap.

## 6. Not repeated

{NOT_REPEATED[0].upper() + NOT_REPEATED[1:]}.

## 7. Files

| Folder | Files |
| --- | --- |
| `layout/` | {', '.join('`'+f+'`' for f in files)} |
| `sim/` | {', '.join('`'+f+'`' for f in sims)} |
| `tile/` | {', '.join('`'+f+'`' for f in tiles)} |
| `tools/` | {', '.join('`'+f+'`' for f in tools)} |
"""
    return wrap(t)
open(f"{D}/README.md", "w").write(bd_readme())
NUM = {"gds": GDS_NEW, "cap_rise": cap_rise, "cap_rise_old": cap_rise_old, "clk_cap": clk_cap, "obs_d": obs_d, "arr": arr, "lead_ps": lead, "kfall_ns": kfall,
       "irs": irs, "captures_used": CK, "n2_steps": [n2_steps_lo, n2_steps_hi], "n2_local": [n2_steps_lo / K, n2_steps_hi / K], "n2_tail": n2_tail, "count_fit": cfit, "count_kind": CNT_KIND,
       "n2_ss": (None if not CAP_SS else {"steps": CAP_SS["steps_ps"], "ideal": TAU_N2_SS * K, "tail": CAP_SS["tail_ps"], "tau": TAU_N2_SS}),
       "n2_total": {k: {x: LAT[k][x]["total_ps"] for x in LAT[k] if x.startswith("n2")} for k in LAT}, "tau_n2": TAU_N2, "tau_n1": TAU_N1, "n1_steps": {x: LAT["wave"][x]["steps_ps"] for x in ("n1fall", "n1rise") if x in LAT["wave"]},
       "n2_steps_by": {k: {x: LAT[k][x]["steps_ps"] for x in LAT[k] if x.startswith("n2")} for k in LAT},
       "events": {t: ev(t) for t in RD.TAGS}, "flags_ok": flags_ok, "realdiv": RDV, "tau_maxdiff": tau_maxdiff, "tau_maxdiff_core": tau_maxdiff_core, "d_maxdiff": dmax,
       "fb": {k: [fmid(v), v["arrival_bank_selected_q_ps"]] for k, v in FB.items()}, "fd2": fd2, "missing": MISSING}
json.dump(NUM, open(f"{B}/rev2_numbers.json", "w"), indent=1, default=str)
print("missing:", MISSING)

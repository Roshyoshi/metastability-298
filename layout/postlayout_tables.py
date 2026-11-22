#!/usr/bin/env python3
"""Markdown tables from the RESULT lines of layout/run_postlayout.sh.
usage: postlayout_tables.py <results_postlayout.txt>

Every run has a tag: pre_ (schematic netlist) or post_ (netlist extracted from the layout), then what the run
was: a corner (tt_3v3_27c, ss_3v0_m40c, ss_3v0_125c, ff_3v6_m40c), a delay setting (ua0_1v8), a flip-flop
(dut3) or the event check (events_3v3). The tau benches are tau_pre_<corner> and tau_post_<corner>; an event check at another corner is
events_1v1_ss_3v0_125c."""
import sys
from collections import defaultdict

R = defaultdict(dict)
for line in open(sys.argv[1]):
    t = line.split()
    if len(t) >= 4 and t[0] == "RESULT":
        R[t[1]][t[2]] = t[3]

def val(tag, name, scale=1.0):
    """The measurement as a number, or None if the run is missing or the measurement failed."""
    try:
        return float(R[tag][name]) * scale
    except (KeyError, ValueError):
        return None

def fmt(v, digits=2):
    return "n/a" if v is None else f"{round(v, digits) + 0.0:.{digits}f}"      # + 0.0: no "-0.0"

def slowest(vals):
    vals = [v for v in vals if v is not None]
    return max(vals) if vals else None

def mean(vals):
    vals = [v for v in vals if v is not None]
    return sum(vals) / len(vals) if vals else None

def table(head, rows):
    out = ["| " + " | ".join(head) + " |", "|" + "|".join(" --- " for _ in head) + "|"]
    return "\n".join(out + ["| " + " | ".join(r) + " |" for r in rows])

def d_ns(tag):
    """d: capture edge at the flip-flops under test to the early-sample clock, captures 2 and 3."""
    return mean([val(tag, f"d_trial{k}_ps", 1e-3) for k in (2, 3)])

W = (("pre", "schematic"), ("post", "layout"))
out = []

# ---- d against ua[0]
volts = sorted({t.split("_ua0_")[1] for t in R if "_ua0_" in t}, key=lambda v: float(v.replace("v", ".")))
if volts:
    rows = [[v.replace("v", ".") + " V"] + [fmt(d_ns(f"{w}_ua0_{v}")) for w, _ in W] for v in volts]
    out += ["Delay *d* against `ua[0]`, typical corner, 3.3 V, 27 C (ns). *d* is from the capture edge at the "
            "flip-flops under test to the early-sample clock at the early observer.", "",
            table(["`ua[0]`"] + [f"*d*, {n}" for _, n in W], rows), ""]

# ---- arrival of the new value at the early observer
duts = {1: "library `dffq_1`", 2: "NAND, baseline", 3: "NAND, keeper doubled", 4: "NAND, forward gate doubled"}
def arrival_tag(w, k):
    return f"{w}_ua0_1v8" if k == 2 else f"{w}_dut{k}"
if any(arrival_tag(w, k) in R for w, _ in W for k in duts):
    rows = [[f"DUT{k}: {duts[k]}"] + [fmt(val(arrival_tag(w, k), f"q_arrives_{e}_ps", 1e-3))
                                      for w, _ in W for e in ("rising", "falling")] for k in duts]
    out += ["When the chosen flip-flop's new value reaches the early observer, after the same capture edge (ns). "
            "An early sample taken before this reads the old value, so *d* has to be longer.", "",
            table(["Flip-flop"] + [f"{e}, {n}" for _, n in W for e in ("rising", "falling")], rows), ""]

# ---- tau of the three NAND flip-flops
CORNERS = [("tt_3v3_27c", "typical 3.3 V 27 C"), ("ss_3v0_m40c", "slow 3.0 V -40 C"),
           ("ss_3v0_125c", "slow 3.0 V 125 C"), ("ff_3v6_m40c", "fast 3.6 V -40 C")]
kinds = [("base", "DUT2: NAND, baseline"), ("keeper", "DUT3: NAND, keeper doubled"), ("forward", "DUT4: NAND, forward gate doubled")]
tau_corners = [(c, n) for c, n in CORNERS if any(f"tau_{w}_{c}" in R for w, _ in W)]
if tau_corners:
    rows = [[n] + [fmt(val(f"tau_{w}_{c}", f"tau_{k}_ps"), 1) for c, _ in tau_corners for w, _ in W] for k, n in kinds]
    out += ["Regeneration time constant tau of the master latch (ps). The schematic carries its wiring estimates: "
            "0.25 fF on each latch node and 0.05 fF between them.", "",
            table(["Flip-flop"] + [f"{n}, {wn}" for _, n in tau_corners for _, wn in W], rows), ""]
    t = f"tau_post_{tau_corners[0][0]}"
    wires = [(n, val(t, f"wiring_on_{k}_mq_fF"), val(t, f"wiring_on_{k}_mqb_fF")) for k, n in kinds]
    if all(a is not None and b is not None for _, a, b in wires):
        out += ["Wiring capacitance Magic extracted on the latch nodes `mq` and `mqb`: " +
                "; ".join(f"{n.split(':')[0]} {a:.2f} and {b:.2f} fF" for n, a, b in wires) + ".", ""]

# ---- controller timing at the corners
corners = [(c, n) for c, n in CORNERS if any(f"{w}_{c}" in R for w, _ in W)]
def settle(tag):
    """Longest path of the last count: b rising, tick_n, n[0], n[1] and fifteen more counter stages."""
    first = [val(tag, n, 1e-3) for n in ("b_rise_to_tick_n_fall_ps", "tick_n_to_n0_ps", "n0_to_n1_through_inverter_ps")]
    stage = [val(tag, n, 1e-3) for n in ("stage_n1_fall_to_n2_rise_ps", "stage_n1_fall_to_n2_fall_ps", "stage_n2_fall_to_n3_rise_ps")]
    if None in first or all(s is None for s in stage):
        return None
    return sum(first) + 15 * max(s for s in stage if s is not None)
measures = [
    ("`run` edge, 10 % to 90 % (ns)", lambda t: val(t, "run_edge_10_90_ps", 1e-3), 2),
    ("`allow_count` rises after `b` falls (ns)", lambda t: val(t, "b_fall_to_allow_count_ps", 1e-3), 2),
    ("lowest `tick_n` before the first count (V)", lambda t: val(t, "tick_n_min_V_before_first_count"), 2),
    ("`b` rising to `tick_n` falling (ns)", lambda t: val(t, "b_rise_to_tick_n_fall_ps", 1e-3), 2),
    ("count pulse width (ns)", lambda t: val(t, "count_pulse_width_ns"), 1),
    ("`tick_n` to `n[0]` (ns)", lambda t: val(t, "tick_n_to_n0_ps", 1e-3), 2),
    ("`n[0]` to `n[1]`, through the inverter (ns)", lambda t: val(t, "n0_to_n1_through_inverter_ps", 1e-3), 2),
    ("counter stage, output rising, the slower of `n[2]` and `n[3]` (ns)", lambda t: slowest([val(t, "stage_n1_fall_to_n2_rise_ps", 1e-3), val(t, "stage_n2_fall_to_n3_rise_ps", 1e-3)]), 2),
    ("counter stage, output falling (ns)", lambda t: val(t, "stage_n1_fall_to_n2_fall_ps", 1e-3), 2),
    ("last count settled after `b` rises: the steps above and 15 more stages (ns)", settle, 1),
    ("*d* at this `ua[0]` (ns)", d_ns, 2),
    ("new value at the early observer, rising (ns)", lambda t: val(t, "q_arrives_rising_ps", 1e-3), 2),
    ("new value at the early observer, falling (ns)", lambda t: val(t, "q_arrives_falling_ps", 1e-3), 2),
    ("events counted after 8 count pulses", lambda t: val(t, "events"), 0),
    ("busy, done, fault (V)", None, 0),
]
if corners:
    head = ["Measured"] + [f"{n}, {wn}" for c, n in corners for _, wn in W]
    rows = []
    for name, f, digits in measures:
        cells = []
        for c, _ in corners:
            for w, _ in W:
                t = f"{w}_{c}"
                if f is None:
                    cells.append(", ".join(fmt(val(t, k + "_V"), 1) for k in ("busy", "done", "fault")))
                else:
                    cells.append(fmt(f(t), digits))
        rows.append([name] + cells)
    out += ["Controller timing over eight count pulses, `ui_in[6]` toggling before every capture, `ua[0]` = 1.3 V.",
            "", table(head, rows), ""]

# ---- the event path: every trial an event with the shortest d, none with a long one
ev = [(w, n, t) for w, n in W for t in sorted(R) if t.startswith(f"{w}_events_")]
if ev:
    rows = []
    for w, n, t in ev:
        volts, _, corner = t.split("_events_")[1].partition("_")
        rows.append([n, dict(CORNERS).get(corner, "typical 3.3 V 27 C"), volts.replace("v", ".") + " V", fmt(d_ns(t)),
                     fmt(val(t, "q_arrives_rising_ps", 1e-3)), fmt(val(t, "q_arrives_falling_ps", 1e-3)),
                     fmt(val(t, "events"), 0), ", ".join(fmt(val(t, k + "_V"), 1) for k in ("busy", "done", "fault"))])
    out += ["Event path, four count pulses, `ui_in[6]` toggling before every capture. With *d* shorter than the "
            "arrival the early reading is the old value and every counted trial is an event; with *d* well beyond "
            "it no trial is.", "",
            table(["Netlist", "Corner", "`ua[0]`", "*d* (ns)", "arrival, rising (ns)", "arrival, falling (ns)", "events",
                   "busy, done, fault (V)"], rows), ""]

failed = sorted(f"{t} {n}" for t in R for n, v in R[t].items() if v in ("not_measured", "not_found"))
if failed:
    out += ["Not measured: " + "; ".join(failed), ""]
print("\n".join(out))

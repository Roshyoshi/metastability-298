#!/usr/bin/env python3
"""Write a whole-tile transient bench around a netlist whose top subcircuit is the tile.
usage: make_tb_chip.py <netlist> <bench out> <pdk dir> <tag>
           [--corner typical|ss|ff] [--vdd 3.3] [--temp 27] [--counts 4]
           [--data high|toggle] [--ua0 1.8] [--dut 2] [--solver klu|sparse] [--threads 4]

<tag> names the run in every RESULT line and in tb_chip_<tag>.dat, e.g. pre, post, post_ss_3v0_m40.

Stimulus: 20 MHz clock, reset held across two rising clock edges and released at 100 ns, START (ui_in[4]) raised at
300 ns and held (compact_control takes START as a level), flip-flop --dut (2 = baseline NAND), ua[0] = --ua0.
The clock edges are at 24.5 + 50 k ns whatever the corner, so with this stimulus `run` rises after the edge at
674.6 ns, `allow_count` after the one at 824.6 ns, and count pulse j (from 1) starts after 924.6 + 200 (j - 1) ns.
The run lasts 0.8 us + 0.2 us x --counts, so --counts 8 covers eight count pulses (2.4 us). The capture edge
does not wait for START: it comes every 200 ns from 174.6 ns on, so --counts 0 already holds four captures.

--data high holds ui_in[6] high: the flip-flop under test never changes, so no events are counted and uo_out
stays 0. --data toggle flips it 100 ns before every capture edge; whether each trial then counts as an event
depends on --ua0 (a short delay samples early before the new value arrives).

--solver klu (the default) and --threads only change how fast ngspice runs: with 8 threads on an idle machine
the extracted tile's 1.6 us take 9 minutes instead of 17. The measured values agree with the sparse solver's to
0.01 ps, except those of the first capture, which follows the operating point and differs by up to 1 ps.
--solver sparse writes the bench as it was before.

Measured at the pins: the delay between the two clock monitors (uio_out[4] = capture edge, uio_out[5] =
early-sample clock), which is what an oscilloscope sees of d: the two buffer paths are nearly but not exactly
equal, and it comes out 0.05 to 0.2 ns shorter than d; busy, done, fault; the event count.

Measured inside the front end, see frontend_nets(): d itself, from the capture edge at the flip-flops under
test (capture_local) to the early-sample clock at the early observer (early_clk), for the first three captures;
and, with --data toggle, how long after the capture edge the new value of the chosen flip-flop reaches the early
observer (selected_q). The early sample is only meaningful once d is longer than that.

Measured inside the controller, for the timing its logic tests cannot establish (design note in
src/gf180/compact_control.v): see controller_nets() and the RESULT lines below it. The nets are found from the
cells around them, not by name, because the extracted netlist does not keep the controller's net names. If
they cannot be found the bench is still written, with `RESULT <tag> controller_nets not_found` (and likewise
`frontend_nets not_found`)."""
import argparse, re
from collections import Counter

TOP = "tt_um_metastability_characterizer"
LIB = "gf180mcu_fd_sc_mcu7t5v0__"
ap = argparse.ArgumentParser()
ap.add_argument("net"); ap.add_argument("out"); ap.add_argument("pdk"); ap.add_argument("tag")
ap.add_argument("--corner", default="typical", choices=["typical", "ss", "ff"])
ap.add_argument("--vdd", type=float, default=3.3)
ap.add_argument("--temp", type=float, default=27.0)
ap.add_argument("--counts", type=int, default=4)
ap.add_argument("--data", default="high", choices=["high", "toggle"])
ap.add_argument("--ua0", type=float, default=1.8)
ap.add_argument("--dut", type=int, default=2, choices=[1, 2, 3, 4])
ap.add_argument("--solver", default="klu", choices=["klu", "sparse"])
ap.add_argument("--threads", type=int, default=4)
A = ap.parse_args()
net, out, pdk, tag = A.net, A.out, A.pdk, A.tag
vdd, vth = f"{A.vdd:g}", f"{A.vdd / 2:g}"

# A misspelt section name makes ngspice run without models, so check it here.
models = f"{pdk}/libs.tech/ngspice/sm141064.ngspice"
sections = [A.corner, "diode_" + A.corner]
have = set(s.lower() for s in re.findall(r"^\s*\.lib\s+(\S+)\s*$", open(models).read(), re.M | re.I))
missing = [s for s in sections if s not in have]
if missing:
    raise SystemExit(f"{models} has no section {missing}; it has {sorted(have)}")

txt = open(net).read().replace("\n+", " ")

def subckts(txt):
    """{subcircuit (lower case): (ports, [(instance, nets, cell)])}"""
    subs, cur = {}, None
    for line in txt.splitlines():
        t = line.split()
        if not t:
            continue
        if t[0].lower() == ".subckt":
            cur = t[1].lower(); subs[cur] = ([p for p in t[2:] if "=" not in p], [])
        elif t[0].lower() == ".ends":
            cur = None
        elif cur and t[0][0] in "xX":
            a = [p for p in t[1:] if "=" not in p]
            subs[cur][1].append((t[0], a[:-1], a[-1].lower()))
    return subs

def cells(subs, sub, kind):
    """The instances of library cell `kind` in subcircuit sub, each as {PIN: net}."""
    c = LIB + kind
    return [dict(zip((p.upper() for p in subs[c][0]), nets))
            for _, nets, cell in subs[sub][1] if cell == c and c in subs]

def frontend_nets(subs):
    """(subcircuit holding the selector, {name: net}) or None.
    Each net is identified by the cells on it:
      selected_q     Z of the one mux4_1, the selector
      capture_local  the clock of the dffq_1 whose Q is the selector's I0 (the library flip-flop under test)
      early_clk      the clock of the dffq_1 that samples selected_q for the early reading. In an extracted
                     netlist the controller's second late reading (l2_ff) is a dffq_1 on selected_q too; its
                     clock a_n comes from an inv_1, the early clock from the delay line's last inv_2."""
    try:
        home = [s for s in subs if len(cells(subs, s, "mux4_1")) == 1]
        if len(home) != 1:
            return None
        s = home[0]
        mux = cells(subs, s, "mux4_1")[0]
        ffs = cells(subs, s, "dffq_1")
        dut1 = [f for f in ffs if f["Q"] == mux["I0"]]
        early = [f for f in ffs if f["D"] == mux["Z"]]
        if len(early) > 1:
            from_inv_2 = {g["ZN"] for g in cells(subs, s, "inv_2")}
            early = [f for f in early if f["CLK"] in from_inv_2]
        if len(dut1) != 1 or len(early) != 1:
            return None
        return s, {"capture_local": dut1[0]["CLK"], "early_clk": early[0]["CLK"], "selected_q": mux["Z"]}
    except KeyError:      # a cell without the pin names of the library
        return None

def controller_nets(subs):
    """(subcircuit holding the controller's cells, {name: net}) or None.
    Each net is identified by the cells on it:
      run          the reset (RN) of all but one of the dffnrnq_1 flip-flops
      allow_count  Q of the one whose reset is not run (allow_ff); b is its clock
      tick_n       output of the nand2_1 whose inputs are b and allow_count
      n0           Q of the flip-flop clocked by tick_n whose D is its own Q inverted
      n1, n2, n3   Q of the flip-flop clocked by the stage below (n1 by NOT n0)"""
    try:
        home = [s for s in subs if len(cells(subs, s, "dffnrnq_1")) >= 2]
        if len(home) != 1:
            return None
        s = home[0]
        ffs = cells(subs, s, "dffnrnq_1")
        run = Counter(f["RN"] for f in ffs).most_common(1)[0][0]
        allow_ff = [f for f in ffs if f["RN"] != run]
        if len(allow_ff) != 1:
            return None
        b, allow = allow_ff[0]["CLKN"], allow_ff[0]["Q"]
        tick = [g["ZN"] for g in cells(subs, s, "nand2_1") if {g["A1"], g["A2"]} == {b, allow}]
        inverted = {g["ZN"]: g["I"] for g in cells(subs, s, "inv_1")}
        n0 = [f for f in ffs if tick and f["CLKN"] == tick[0] and inverted.get(f["D"]) == f["Q"]]
        if len(tick) != 1 or len(n0) != 1:
            return None
        found = {"b": b, "allow_count": allow, "tick_n": tick[0], "run": run, "n0": n0[0]["Q"]}
        clock = n0[0]["D"]
        for k in (1, 2, 3):
            stage = [f for f in ffs if f["CLKN"] == clock]
            if len(stage) != 1:
                return None
            found[f"n{k}"] = clock = stage[0]["Q"]
        return s, found
    except KeyError:      # a cell without the pin names of the library
        return None

def instance_path(subs, sub, target):
    """Instances from sub down to the subcircuit target: [(instance, nets, cell)], or None."""
    if sub == target:
        return []
    for inst in subs[sub][1]:
        if inst[2] in subs:
            below = instance_path(subs, inst[2], target)
            if below is not None:
                return [inst] + below
    return None

def flat_node(subs, path, home, name):
    """The name ngspice gives net `name` of subcircuit home, reached from the bench through XDUT and path."""
    chain = [("XDUT", None, TOP.lower())] + path
    while name in subs[chain[-1][2]][0]:        # a port: the net is the one outside
        inst = chain.pop()
        if not chain:
            return None                         # a tile pin, not an internal net
        name = inst[1][subs[inst[2]][0].index(name)]
    return ".".join([i[0].lower() for i in chain] + [name.lower()])

m = re.search(r"^\.subckt\s+" + re.escape(TOP) + r"\s+(.*)$", txt, re.M | re.I)
ports = m.group(1).split()
ports = [p for p in ports if "=" not in p]
def node(p):
    return p.replace("[", "_").replace("]", "")
data = f"VDATA ui_in_6 0 {vdd}" if A.data == "high" else \
       f"VDATA ui_in_6 0 PULSE(0 {vdd} 75n 0.1n 0.1n 199.9n 400n)"
L = [f"* whole-tile bench ({tag}: {A.corner}, {vdd} V, {A.temp} C), generated by make_tb_chip.py",
     f".include {pdk}/libs.tech/ngspice/design.ngspice"] + \
    [f".lib {models} {s}" for s in sections] + \
    [".param sw_stat_global=0 sw_stat_mismatch=0",
     f".temp {A.temp}",
     f".include {net}",
     f"VDD vdpwr 0 {vdd}",
     f"VCLK clk 0 PULSE(0 {vdd} 24.5n 0.1n 0.1n 24.9n 50n)",
     f"VRST rst_n 0 PWL(0 0 100n 0 100.1n {vdd})",
     f"VENA ena 0 {vdd}",
     f"VSTART ui_in_4 0 PWL(0 0 300n 0 300.1n {vdd})",
     f"VCFG0 ui_in_3 0 {vdd if (A.dut - 1) & 1 else 0}", f"VCFG1 uio_in_6 0 {vdd if (A.dut - 1) & 2 else 0}",
     data, f"VBIAS ua_0 0 {A.ua0}"]
inputs = {"clk", "rst_n", "ena", "ui_in_4", "ui_in_3", "uio_in_6", "ui_in_6", "ua_0"}
nodes = []
for p in ports:
    n = node(p)
    if p == "VDPWR": nodes.append("vdpwr")
    elif p == "VGND" or p.upper() in ("VSUBS", "VSUB", "SUB", "GND"): nodes.append("0")
    elif n.startswith("ua") and n != "ua_0":
        nodes.append(n); L.append(f"R{n} {n} 0 1G")
    else:
        nodes.append(n)
        if n.startswith(("ui_in", "uio_in")) and n not in inputs:
            L.append(f"V{n} {n} 0 0")
        if n.startswith(("uo_out", "uio_out", "uio_oe")):
            L.append(f"C{n} {n} 0 0.2p")
L.append("XDUT " + " ".join(nodes) + " " + TOP)

# Internal nets come out as p_<name>, each through a unity-gain source, so
# that the measurements do not depend on what the netlist calls them.
subs = subckts(txt)
def probe(nets):
    """{name: node as ngspice names it} for a finder's result, or {} if any net cannot be reached."""
    if not nets:
        return {}
    home, found = nets
    path = instance_path(subs, TOP.lower(), home)
    flat = {k: flat_node(subs, path, home, v) for k, v in found.items()} if path is not None else {}
    return flat if flat and all(flat.values()) else {}
probes = probe(controller_nets(subs))
front = probe(frontend_nets(subs))
for k, v in {**front, **probes}.items():
    L += [f"* {k} = {v}", f"Ep_{k} p_{k} 0 {v} 0 1"]

tstop = 800 + 200 * A.counts                     # ns
at = f"{tstop - 10}n"
bits = " ".join(f"v(uo_out_{k})" for k in range(8))
def timing(vec, spec, name, scale):
    """A measured time or delay and its RESULT line. If the edges it waits for are not in the run, the line
    says not_measured: ngspice would otherwise print the previous measurement's value under this name."""
    return [f"let {vec}=-1", f"meas tran {vec} {spec}", f"if {vec} < 0", f"echo RESULT {tag} {name} not_measured",
            "else", f"let r={vec}*{scale}", f"echo RESULT {tag} {name} $&r", "end"]
def delay(vec, a, ea, b, eb, td=None, td_b=None):
    """From an edge of v(a) to an edge of v(b), in ps. td: look for the edge of a only after this time
    (and td_b likewise for b)."""
    t, tb = (f" td={td}" if td else ""), (f" td={td_b}" if td_b else "")
    return timing(vec, f"trig v({a}) val={vth} {ea}{t} targ v({b}) val={vth} {eb}{tb}", vec + "_ps", "1e12")
if A.solver == "klu":
    L.append(".options klu")
L += [".control", "set filetype=ascii"] + ([f"set num_threads={A.threads}"] if A.solver == "klu" else []) + \
     [f"tran 10p {tstop}n"]
L += timing("first_cap", f"when v(uio_out_4)={vth} rise=1", "first_capture_ns", "1e9")
for k in (1, 2, 3):
    L += timing(f"d{k}", f"trig v(uio_out_4) val={vth} rise={k} targ v(uio_out_5) val={vth} rise={k}",
                f"monitor_delay_ps_trial{k}", "1e12")
for name, pin in (("busy", 1), ("done", 2), ("fault", 3)):
    L += [f"meas tran {name} find v(uio_out_{pin}) at={at}", f"echo RESULT {tag} {name}_V $&{name}"]
L += [f"meas tran ev{k} find v(uo_out_{k}) at={at}" for k in range(8)]
L += ["let ev=" + "+".join(f"{2 ** k}*(ev{k} gt {vth})" for k in range(8)),
      f"echo RESULT {tag} events $&ev"]
if front:
    # Capture k is the first rise of capture_local after 100 + 200 (k - 1) ns, whatever the corner and
    # whatever state the trial clock woke up in.
    def after(vec, b, eb, k):
        td = f"{100 + 200 * (k - 1)}n"
        return delay(vec, "p_capture_local", "rise=1", "p_" + b, eb, td, td)
    for k in (1, 2, 3):
        L += after(f"d_trial{k}", "early_clk", "rise=1", k)
    if A.data == "toggle":
        # ui_in[6] is high at capture 1, low at capture 2, high at capture 3
        L += after("q_arrives_falling", "selected_q", "fall=1", 2)
        L += after("q_arrives_rising", "selected_q", "rise=1", 3)
else:
    L.append(f"echo RESULT {tag} frontend_nets not_found")
if probes:
    lo, hi = f"{0.1 * A.vdd:g}", f"{0.9 * A.vdd:g}"
    # `run` drives 35 reset pins: its edge, and tick_n quiet while they release
    # and while allow_count rises (700 to 900 ns holds both, and no count pulse).
    L += timing("run_edge", f"trig v(p_run) val={lo} rise=1 targ v(p_run) val={hi} rise=1", "run_edge_10_90_ps", "1e12")
    if A.counts >= 1:
        L += ["meas tran tick_min min v(p_tick_n) from=700n to=900n",
              f"echo RESULT {tag} tick_n_min_V_before_first_count $&tick_min"]
        # The fall of b must reach tick_nand before the new allow_count does:
        # allow_count rises this long after b falls (the edge at 824.6 ns).
        L += delay("b_fall_to_allow_count", "p_b", "fall=1", "p_allow_count", "rise=1", td="800n")
        L += delay("b_rise_to_tick_n_fall", "p_b", "rise=1", "p_tick_n", "fall=1", td="900n")
        L += timing("tick_w", f"trig v(p_tick_n) val={vth} fall=1 targ v(p_tick_n) val={vth} rise=1",
                    "count_pulse_width_ns", "1e9")
        # The trial counter: n0 and n1 change on count 1, n2 on count 3 (up) and
        # 7 (down), n3 on count 7. One stage is a flip-flop clocked by the stage
        # below; the last count passes through 17 of them.
        L += delay("tick_n_to_n0", "p_tick_n", "fall=1", "p_n0", "rise=1")
        L += delay("n0_to_n1_through_inverter", "p_n0", "rise=1", "p_n1", "rise=1")
    if A.counts >= 3:
        L += delay("stage_n1_fall_to_n2_rise", "p_n1", "fall=1", "p_n2", "rise=1")
    if A.counts >= 7:
        L += delay("stage_n1_fall_to_n2_fall", "p_n1", "fall=2", "p_n2", "fall=1")
        L += delay("stage_n2_fall_to_n3_rise", "p_n2", "fall=1", "p_n3", "rise=1")
else:
    L.append(f"echo RESULT {tag} controller_nets not_found")
internal = " ".join(f"v(p_{k})" for k in {**front, **probes})
L += [f"wrdata tb_chip_{tag}.dat v(clk) v(uio_out_4) v(uio_out_5) v(uio_out_1) {bits} {internal}".rstrip(),
      ".endc", ".end"]
open(out, "w").write("\n".join(L) + "\n")
print("wrote", out, "with", len(ports), "tile ports;",
      "controller nets", "found;" if probes else "NOT found;",
      "front-end nets", "found" if front else "NOT found")

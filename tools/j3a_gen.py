#!/usr/bin/env python3
"""Bank flip-flop N2 (copied unchanged, apart from the cell path, from the layout study of November 2026,
the generator of the design study; run by tools/bank_blocks.py).

Generates a Magic script that draws the asymmetric jamb-latch flip-flop "j3a" (3.3 V transistors):
master NMOS 4 x 1.0 um, master PMOS 2 x 1.0 um, clock-gated write transistor 2 x 1.0 um next to each latch
node, data transistor 4 x 1.0 um at the bottom of each write stack, minimum-size slave (NMOS 0.5, PMOS 0.3,
input stacks 0.3 um), clock / data / output inverters NMOS 1.0 / PMOS 1.38 um, L = 0.28 um. Sizes are those of
the row "4/2/2/4, small slave" of the design study.

One custom row of 3.92 um height with the rails, wells and implant hints of gf180mcu_as_sc_mcu7t3v3; one
library tap cell (tap_2) at each end.

Floor plan (left to right):
  clock inverter | data inverter | X write stack | s input stack, X inverter, Y inverter, sb input stack |
  Y write stack | slave half (q, s) | slave half (sb, qn)
The write stacks lie at the two outer ends of the master. In each stack the four data fingers come first
(seen from the outside), then the two clock-gated fingers, which share the latch-node contact; the internal
stack node (ax, ay) is contacted between every pair of fingers and joined by one Metal1 line in the middle
channel. The latch-node contact of a stack is therefore the stack's column nearest to the inverters, and the
data fingers lie outside the span of the latch-node wiring. The two slave input fingers gated by the latch
nodes are 0.3 um fingers at the outer ends of the two inverter gate bars (poly), so that no latch-node wire
runs to the slave; the slave nodes s / sb are brought to the slave latch by Metal3 straps instead.

Latch-node wiring, option --route (all three were drawn, checked and extracted; m2j is the fastest and is "j3a"):
  m2j Metal2 runs directly on the latch-node columns (Via1 only), no Metal3 on x and y.
      x: one run over the NMOS strip on the stack column and the two inverter columns; the inverter's through
         column (NMOS and PMOS drain) reaches the pad of the x gate bar, placed at the centre of the master, by
         a Metal1 jumper in the middle channel.
      y: one run in the middle channel from the pad of the y gate bar to the through column of the Y inverter,
         one run over the NMOS strip to the second inverter column and the stack column.
  m2  as m2j, but both gate bars are reached by Metal2 runs (two parallel runs in the middle channel).
  m3  Metal3 straps over the row with Via1 / Metal2 stub / Via2 at every column, as in j3ffb and j3w.

usage: gen_j3a.py <out.tcl> <name> [--route m2j|m2|m3] [--set key=value ...]
keys of --set (defaults are the checked layout): t_<net>=<Metal3 track y>, yn / ym1 / ym2 / ymy (levels of the
Metal2 runs), jh (half height of the jumper), cko (offset of the slave-input clock pads), lowx=0 (full-height
stack columns), and for deliberate-violation controls only: gap, pj, nocheck=1.
Writes <out.tcl> and <name>_info.json (coordinates, wire lengths). The generator checks the spacing of Metal1,
Metal2, Metal3, poly, Via1 and Via2 shapes of different nets itself and stops on a conflict."""
import sys, json, os

args = [a for a in sys.argv[1:] if not a.startswith("--")]
out, name = args[0], args[1]
opt = {"route": "m2j"}
av = sys.argv[1:]
for i, a in enumerate(av):
    if a == "--route":
        opt["route"] = av[i + 1]
    if a == "--set":
        k, v = av[i + 1].split("=")
        opt[k] = v
ROUTE = opt["route"]
assert ROUTE in ("m2", "m2j", "m3")

G = 0.005


def r(v):
    return round(round(v / G) * G, 3)


# the tap cell comes from the 3.3 V library checkout (GF180_AS_CELLS, see tools/bank_blocks.py)
T = [f"addpath {os.environ.get('GF180_AS_CELLS', '../cells')}", "snap internal", "drc off", f"load {name} -force"]
RECTS = {}          # layer -> list of (x1, y1, x2, y2, net) for the generator's own spacing checks


def box(x1, y1, x2, y2):
    return f"box values {r(x1):.3f}um {r(y1):.3f}um {r(x2):.3f}um {r(y2):.3f}um"


def paint(layer, x1, y1, x2, y2, net=None):
    assert x2 - x1 > 1e-6 and y2 - y1 > 1e-6, (layer, x1, y1, x2, y2, net)
    T.append(box(x1, y1, x2, y2))
    T.append(f"paint {layer}")
    RECTS.setdefault(layer, []).append((r(x1), r(y1), r(x2), r(y2), net))


# ---------------------------------------------------------------- vertical plan
NB, NT = 0.34, 1.34          # NMOS strip
PB = 2.20                    # PMOS strip bottom
F = (NB, NT)                 # full 1.0 um NMOS finger
N3 = (NT - 0.30, NT)         # 0.3 um NMOS finger, at the top of the strip (short gate poly)
N3C = (NT - 0.37, NT)        # contact column of a 0.3 um finger (flare, 0.37 um)
N5 = (NT - 0.50, NT)         # 0.5 um NMOS finger and its contact column
P138 = (PB, PB + 1.38)
P10 = (PB, PB + 1.00)
P3 = (PB, PB + 0.30)
P3C = (PB, PB + 0.36)        # contact column of a 0.3 um PMOS finger (flare)
MID = (1.585, 1.955, 1.77)   # middle poly channel and pad centre
UP = (2.87, 3.23, 3.05)      # upper poly channel (only where no PMOS)
HI = (1.915, 2.285, 2.10)    # raised middle channel (only where no PMOS)
CH = {"mid": MID, "up": UP, "hi": HI}
AXL = (1.43, 1.66)           # Metal1 line of the internal stack node, between the stack columns and the "hi" pads
STK_T = 1.14                 # top of the contacts of the stack columns that pass under that line

YN = float(opt.get("yn", 0.84))          # level of the Metal2 run over the NMOS strip (m2, m2j)
# ---------------------------------------------------------------- horizontal plan
X0 = 1.44                    # first column (left tap cell occupies 0..1.12)
GAP = float(opt.get("gap", 0.64))        # column to column across a diffusion break (0.18 + 0.28 + 0.18)
P4, PJ, PS = 0.40, float(opt.get("pj", 0.42)), 0.52      # contact-gate pitch; the same next to a diffusion jog; series gates
NOCHECK = int(opt.get("nocheck", 0))     # 1: skip the generator's own rule checks (for deliberate-violation controls only)
SEQ = [("i_ckb", 0), ("g_clk", P4), ("i_s1", P4), ("i_s2", GAP), ("g_d", P4), ("i_db", P4),
       # X write stack: ax db vss db ax db vss db ax ckb x ckb ax
       ("a0", GAP), ("gdb1", P4), ("v1", P4), ("gdb2", P4), ("a1", P4), ("gdb3", P4), ("v2", P4), ("gdb4", P4),
       ("a2", P4), ("gckb1", P4), ("xs", P4), ("gckb2", P4), ("a3", P4),
       # s input stack, X inverter, Y inverter, sb input stack (one NMOS island)
       ("sS", GAP), ("gck1", PJ), ("gy0", PS), ("v0", PJ), ("gy1", P4), ("x2", P4), ("gy2", P4), ("v4", P4),
       ("gy3", P4), ("x6", P4), ("gy4", P4), ("v8", P4), ("gx1", P4), ("y10", P4), ("gx2", P4), ("v12", P4),
       ("gx3", P4), ("y14", P4), ("gx4", P4), ("v16", P4), ("gx5", PJ), ("gck2", PS), ("sB", PJ),
       # Y write stack: ay ckb y ckb ay d vss d ay d vss d ay
       ("b0", GAP), ("gckb3", P4), ("ys", P4), ("gckb4", P4), ("b1", P4), ("gd1", P4), ("w1", P4), ("gd2", P4),
       ("b2", P4), ("gd3", P4), ("w2", P4), ("gd4", P4), ("b3", P4),
       # slave half 1: q sb vss sb(0.5/0.3) s ; slave half 2: sb s(0.5/0.3) vss s qn
       ("q", GAP), ("gsb1", P4), ("sv1", P4), ("gsb2", PJ), ("s2", PJ),
       ("sb2", GAP), ("gs1", PJ), ("sv2", PJ), ("gs2", P4), ("qn", P4)]
X = {}
cur = X0
for nm, dx in SEQ:
    cur = r(cur + dx)
    X[nm] = cur
XL, XR = 1.12, r(cur + 0.18 + 0.14)
W = r(XR + 1.12)

# islands: lists of (name, kind, net, (y bottom, y top)); kind c = contact column, g = gate
NISL = [
    [("i_ckb", "c", "ckb", F), ("g_clk", "g", "clk", F), ("i_s1", "c", "vss", F)],
    [("i_s2", "c", "vss", F), ("g_d", "g", "d", F), ("i_db", "c", "db", F)],
    [("a0", "c", "ax", F), ("gdb1", "g", "db", F), ("v1", "c", "vss", F), ("gdb2", "g", "db", F), ("a1", "c", "ax", F),
     ("gdb3", "g", "db", F), ("v2", "c", "vss", F), ("gdb4", "g", "db", F), ("a2", "c", "ax", F),
     ("gckb1", "g", "ckb", F), ("xs", "c", "x", F), ("gckb2", "g", "ckb", F), ("a3", "c", "ax", F)],
    [("sS", "c", "s", N3C), ("gck1", "g", "clk", N3), ("gy0", "g", "y", N3), ("v0", "c", "vss", F),
     ("gy1", "g", "y", F), ("x2", "c", "x", F), ("gy2", "g", "y", F), ("v4", "c", "vss", F),
     ("gy3", "g", "y", F), ("x6", "c", "x", F), ("gy4", "g", "y", F), ("v8", "c", "vss", F),
     ("gx1", "g", "x", F), ("y10", "c", "y", F), ("gx2", "g", "x", F), ("v12", "c", "vss", F),
     ("gx3", "g", "x", F), ("y14", "c", "y", F), ("gx4", "g", "x", F), ("v16", "c", "vss", F),
     ("gx5", "g", "x", N3), ("gck2", "g", "clk", N3), ("sB", "c", "sb", N3C)],
    [("b0", "c", "ay", F), ("gckb3", "g", "ckb", F), ("ys", "c", "y", F), ("gckb4", "g", "ckb", F), ("b1", "c", "ay", F),
     ("gd1", "g", "d", F), ("w1", "c", "vss", F), ("gd2", "g", "d", F), ("b2", "c", "ay", F),
     ("gd3", "g", "d", F), ("w2", "c", "vss", F), ("gd4", "g", "d", F), ("b3", "c", "ay", F)],
    [("q", "c", "q", F), ("gsb1", "g", "sb", F), ("sv1", "c", "vss", F), ("gsb2", "g", "sb", N5), ("s2", "c", "s", N5)],
    [("sb2", "c", "sb", N5), ("gs1", "g", "s", N5), ("sv2", "c", "vss", F), ("gs2", "g", "s", F), ("qn", "c", "qn", F)],
]
PISL = [
    [("i_ckb", "c", "ckb", P138), ("g_clk", "g", "clk", P138), ("i_s1", "c", "vdd", P138)],
    [("i_s2", "c", "vdd", P138), ("g_d", "g", "d", P138), ("i_db", "c", "db", P138)],
    [("v4", "c", "vdd", P10), ("gy3", "g", "y", P10), ("x6", "c", "x", P10), ("gy4", "g", "y", P10), ("v8", "c", "vdd", P10),
     ("gx1", "g", "x", P10), ("y10", "c", "y", P10), ("gx2", "g", "x", P10), ("v12", "c", "vdd", P10)],
    [("q", "c", "q", P138), ("gsb1", "g", "sb", P138), ("sv1", "c", "vdd", P138), ("gsb2", "g", "sb", P3), ("s2", "c", "s", P3C)],
    [("sb2", "c", "sb", P3C), ("gs1", "g", "s", P3), ("sv2", "c", "vdd", P138), ("gs2", "g", "s", P138), ("qn", "c", "qn", P138)],
]
LOWX = int(opt.get("lowx", 1))          # 1: short latch-node column in the stacks, short neighbouring internal-node columns
AX_NEAR = {"a2", "a3", "b0", "b1"}
STACK_COLS = {"a0", "v1", "a1", "v2", "a2", "xs", "a3", "b0", "ys", "b1", "w1", "b2", "w2", "b3"}
LINES = [("ax", "a0", "a3"), ("ay", "b0", "b3")]                    # Metal1 lines of the internal stack nodes
UPCOL = {"sS": 1.97, "sB": 1.97}                                    # columns drawn up into the middle channel (Via1 at 1.77)

# pad of the x gate bar: above the supply column v12, or (m2j) at the centre of the master, 0.24 um from the last y gate
XPADX = r(X["v8"] + 0.16) if ROUTE == "m2j" else X["v12"]
# poly bars: (net, channel, first gate, last gate, pad x)
CKO = float(opt.get("cko", 0.26))                                   # offset of the slave-input clock pads from their gates
BARS = [("clk", "mid", "g_clk", "g_clk", X["i_s1"]), ("d", "mid", "g_d", "g_d", X["i_s2"]),
        ("db", "hi", "gdb1", "gdb4", X["a1"]), ("ckb", "hi", "gckb1", "gckb2", X["xs"]),
        ("clk", "up", "gck1", "gck1", r(X["gck1"] + CKO)),
        ("y", "mid", "gy0", "gy4", X["v4"]), ("x", "mid", "gx1", "gx5", XPADX),
        ("clk", "up", "gck2", "gck2", r(X["gck2"] - CKO)),
        ("ckb", "hi", "gckb3", "gckb4", X["ys"]), ("d", "hi", "gd1", "gd4", X["b2"]),
        ("sb", "mid", "gsb1", "gsb2", X["sv1"]), ("s", "mid", "gs1", "gs2", X["sv2"])]

# ---------------------------------------------------------------- diffusion
gate = {}            # gate name -> dict(net, n=(yb, yt), p=(yb, yt))
ncol, pcol = {}, {}  # column name -> (net, (yb, yt))
for isl, typ in [(i, "n") for i in NISL] + [(i, "p") for i in PISL]:
    layer = "ndiff" if typ == "n" else "pdiff"
    for k, (nm, kind, net, (yb, yt)) in enumerate(isl):
        x = X[nm]
        if kind == "c":
            paint(layer, x - 0.18, yb, x + 0.18, yt)
            (ncol if typ == "n" else pcol)[nm] = (net, (yb, yt))
            continue
        gi = gate.setdefault(nm, {"net": net})
        assert gi["net"] == net, (nm, gi, net)
        gi[typ] = (yb, yt)
        bounds = []
        for nb in (isl[k - 1], isl[k + 1]):
            nn, nk, _, (cb, ct) = nb
            if nk == "c":
                bounds.append(X[nn] + (0.18 if X[nn] < x else -0.18))
                assert cb <= yb + 1e-9 and ct >= yt - 1e-9, f"column {nn} is shorter than gate {nm}"
                if cb < yb - 1e-9 or ct > yt + 1e-9:        # jog next to this gate: 0.10 um from the gate poly
                    assert NOCHECK or abs(X[nn] - x) >= 0.42 - 1e-9, f"jog too near gate {nm} at column {nn}"
            else:
                assert (cb, ct) == (yb, yt), f"series gates {nm}, {nn} of different width"
                assert abs(X[nn] - x) >= 0.52 - 1e-9
                bounds.append((X[nn] + x) / 2)
        paint(layer, min(bounds), yb, max(bounds), yt)

# ---------------------------------------------------------------- gates and bars
bar_of = {}
order = [nm for nm, _ in SEQ]
for net, ch, a, b, xp in BARS:
    for nm in order[order.index(a):order.index(b) + 1]:
        if nm in gate:
            assert gate[nm]["net"] == net, (nm, gate[nm], net)
            bar_of[nm] = ch
for nm, gi in gate.items():
    lo = min(v[0] for k, v in gi.items() if k in "np") - 0.22
    hi = max(v[1] for k, v in gi.items() if k in "np") + 0.22
    assert nm in bar_of, f"gate {nm} is on no bar"
    hi = max(hi, CH[bar_of[nm]][1])
    paint("polysilicon", X[nm] - 0.14, lo, X[nm] + 0.14, hi, gi["net"])
pads = {}
for net, ch, a, b, xp in BARS:
    y1, y2, yc = CH[ch]
    paint("polysilicon", min(X[a] - 0.14, xp - 0.18), y1, max(X[b] + 0.14, xp + 0.18), y2, net)
    paint("polycontact", xp - 0.115, yc - 0.115, xp + 0.115, yc + 0.115, net)
    paint("metal1", xp - 0.175, yc - 0.21, xp + 0.175, yc + 0.21, net)
    pads.setdefault(net, []).append((xp, yc))
for nm, gi in gate.items():
    if "n" in gi:
        paint("nmos", X[nm] - 0.14, gi["n"][0], X[nm] + 0.14, gi["n"][1])
    if "p" in gi:
        paint("pmos", X[nm] - 0.14, gi["p"][0], X[nm] + 0.14, gi["p"][1])

# ---------------------------------------------------------------- contacts and their Metal1
m1col = {}           # column name -> list of (y1, y2) Metal1 pieces
for nm, (net, (yb, yt)) in ncol.items():
    x = X[nm]
    sup = net == "vss"
    if yt - yb < 0.45:                       # flare of a 0.3 um finger: one contact
        cb, ct = yt - 0.07 - 0.23, yt - 0.07
    elif yt - yb < 0.60:                     # 0.5 um
        cb, ct = yb + 0.07, yt - 0.07
    else:
        cb, ct = (0.45 if sup else 0.59), yt - 0.11
    if nm in STACK_COLS and not net.startswith("a"):
        ct = STK_T                           # passes under the Metal1 line of the internal node
        if sup:
            cb = 0.44                        # 0.70 um: two contact cuts
        elif LOWX:
            ct = cb + 0.23                   # latch-node column of the stack: one cut at the bottom (as short as the Via1 patch allows)
    if nm in AX_NEAR and LOWX:
        cb = ct - 0.23                       # internal-node columns next to it: one cut at the top
    paint("ndiffc", x - 0.115, cb, x + 0.115, ct, net)
    y1 = -0.30 if sup else max(0.53, cb - 0.06) if yt - yb >= 0.60 else cb - 0.06
    y2 = ct + 0.06
    if nm in ("xs", "ys") and LOWX:
        y2 = max(y2, YN + 0.19)              # room for the Via1 patch
    if net.startswith("a"):
        y2 = AXL[1]
    if nm in UPCOL:
        y2 = UPCOL[nm]
    m1col[nm] = [y1, y2]
for nm, (net, (yb, yt)) in pcol.items():
    x = X[nm]
    sup = net == "vdd"
    if yt - yb < 0.45:
        cb, ct = yb + 0.065, yb + 0.065 + 0.23
    else:
        cb, ct = yb + 0.11, yt - 0.11 if sup else min(yt - 0.11, 3.33)
    paint("pdiffc", x - 0.115, cb, x + 0.115, ct, net)
    y1 = cb - 0.06
    y2 = 4.22 if sup else min(ct + 0.06, 3.385)
    if nm in m1col and ncol[nm][0] == net:   # the same net on both strips: one column through the middle channel
        m1col[nm][1] = y2
        m1col[nm].append("through")
    else:
        paint("metal1", x - 0.115, y1, x + 0.115, y2, "VDD" if sup else net)
for nm, v in m1col.items():
    net = ncol[nm][0]
    hw = 0.15 if (nm in ("xs", "ys") and LOWX) else 0.115        # the short column is drawn 0.30 um wide (Metal1 area 0.15 um2)
    paint("metal1", X[nm] - hw, v[0], X[nm] + hw, v[1], "VSS" if net == "vss" else net)
for net, a, b in LINES:
    paint("metal1", X[a] - 0.115, AXL[0], X[b] + 0.115, AXL[1], net)

# ---------------------------------------------------------------- rails, wells, taps
paint("metal1", XL, -0.30, XR, 0.30, "VSS")
paint("metal1", XL, 3.62, XR, 4.22, "VDD")
paint("nwell", XL - 0.43, 1.77, XR + 0.43, 4.35)
paint("pwell", XL - 0.43, -0.43, XR + 0.43, 1.77)
P3L = "gf180mcu_as_sc_mcu7t3v3__"
T += [box(0, 0, 0, 0), f"getcell {P3L}tap_2 child 0 0"]
T += [box(XR, 0, XR, 0), f"getcell {P3L}tap_2 child 0 0"]

# ---------------------------------------------------------------- routing
info = {"width": W, "route": ROUTE, "nets": {}, "latch": {}}


def via1(px, py, net):
    paint("metal1", px - 0.13, py - 0.19, px + 0.13, py + 0.19, net)      # Metal1 patch: 0.06 beyond the via in y
    paint("via1", px - 0.13, py - 0.13, px + 0.13, py + 0.13, net)


def stack(px, py, yt, net):
    """Via1, Metal2 stub and Via2 from the point (px, py) to the Metal3 track at yt."""
    via1(px, py, net)
    lo, hi = min(py, yt) - 0.27, max(py, yt) + 0.27
    paint("metal2", px - 0.14, lo, px + 0.14, hi, net)
    paint("via2", px - 0.14, yt - 0.14, px + 0.14, yt + 0.14, net)


YM1 = float(opt.get("ym1", 1.77))        # Metal2 run in the middle channel (pad level)
YM2 = float(opt.get("ym2", 2.33))        # second Metal2 run, 0.28 um above the first
if ROUTE in ("m2", "m2j"):
    # d over the VSS rail; s and sb away from the two clock phases; nothing over the Metal2 runs of x and y
    TRACK = {"d": 0.0, "sb": 1.68, "s": 2.24, "db": 2.80, "ckb": 3.36, "clk": 3.92}
else:
    TRACK = {"y": 0.0, "x": 1.12, "sb": 1.12, "ckb": 2.24, "d": 2.80, "clk": 3.36, "db": 3.92, "s": 3.92}
for k, v in opt.items():
    if k.startswith("t_"):
        TRACK[k[2:]] = float(v)
PORTS = ["d", "clk"]
# Via1 landing points on columns (pads get theirs automatically)
CVIA = {"ckb": [("i_ckb", 2.24)], "db": [("i_db", 3.19)],
        "s": [("sS", 1.77), ("s2", YM2)], "sb": [("sB", 1.77), ("sb2", 1.77)]}
if ROUTE == "m3":
    CVIA["x"] = [("xs", 0.72), ("x2", 0.72), ("x6", 0.72)]
    CVIA["y"] = [("y10", 0.72), ("y14", 0.72), ("ys", 0.72)]
lab = []
for net, yt in TRACK.items():
    pts = [(X[k], y) for k, y in CVIA.get(net, [])] + pads.get(net, [])
    for px, py in pts:
        stack(px, py, yt, net)
    xs_ = [p[0] for p in pts]
    x1, x2 = min(xs_) - 0.33, max(xs_) + 0.33
    if net in PORTS:
        x1 = 0.30
    paint("metal3", x1, yt - 0.14, x2, yt + 0.14, net)
    info["nets"][net] = dict(track=yt, x1=r(x1), x2=r(x2), m3_um=r(x2 - x1), vias=len(pts))
    lab.append((net, "metal3", x2 - 0.25, yt))
E = 0.20                                      # Metal2 run end beyond the last Via1 centre
if ROUTE == "m2":
    # x: stack column, the two inverter columns; through column x6 up to the second middle run; pad of the x gate bar
    for k in ("xs", "x2", "x6"):
        via1(X[k], YN, "x")
    paint("metal2", X["xs"] - E, YN - 0.14, X["x6"] + E, YN + 0.14, "x")
    via1(X["x6"], YM2, "x")
    via1(X["v12"], MID[2], "x")
    paint("metal2", X["x6"] - E, YM2 - 0.14, X["v12"] + 0.14, YM2 + 0.14, "x")
    paint("metal2", X["v12"] - 0.14, MID[2] - E, X["v12"] + 0.14, YM2 + 0.14, "x")
    # y: pad of the y gate bar to the through column y10 in the middle channel; inverter columns and stack column
    via1(X["v4"], YM1, "y")
    via1(X["y10"], YM1, "y")
    paint("metal2", X["v4"] - E, YM1 - 0.14, X["y10"] + E, YM1 + 0.14, "y")
    for k in ("y10", "y14", "ys"):
        via1(X[k], YN, "y")
    paint("metal2", X["y10"] - E, YN - 0.14, X["ys"] + E, YN + 0.14, "y")
    info["latch"]["x"] = dict(m1_um=0.0, m2_um=r(X["x6"] - X["xs"] + 2 * E + X["v12"] - X["x6"] + E + 0.14 + YM2 - MID[2] + E - 0.14), m3_um=0.0, via1=5)
    info["latch"]["y"] = dict(m1_um=0.0, m2_um=r(X["y10"] - X["v4"] + 2 * E + X["ys"] - X["y10"] + 2 * E), m3_um=0.0, via1=5)
    lab += [("x", "metal2", X["x2"], YN), ("y", "metal2", X["y14"], YN)]
elif ROUTE == "m2j":
    # x: Metal2 run over the NMOS strip on the stack column and the two inverter columns; the through column x6
    #    reaches the pad of the x gate bar by a Metal1 jumper in the middle channel (no via)
    for k in ("xs", "x2", "x6"):
        via1(X[k], YN, "x")
    paint("metal2", X["xs"] - E, YN - 0.14, X["x6"] + E, YN + 0.14, "x")
    JH = float(opt.get("jh", 0.115))          # half height of the jumper
    paint("metal1", X["x6"] - 0.115, MID[2] - JH, XPADX + 0.175, MID[2] + JH, "x")
    # y: pad of the y gate bar -> through column y10 (Metal2 in the middle channel), inverter columns and stack column
    YMY = float(opt.get("ymy", 1.77))
    via1(X["v4"], MID[2], "y")
    via1(X["y10"], YMY, "y")
    if abs(YMY - MID[2]) < 1e-6:
        paint("metal2", X["v4"] - E, YMY - 0.14, X["y10"] + E, YMY + 0.14, "y")
        ylen = X["y10"] - X["v4"] + 2 * E
    else:
        paint("metal2", X["v4"] - 0.14, MID[2] - E, X["v4"] + 0.14, YMY + 0.14, "y")
        paint("metal2", X["v4"] - 0.14, YMY - 0.14, X["y10"] + E, YMY + 0.14, "y")
        ylen = X["y10"] - X["v4"] + E + 0.14 + YMY - MID[2] + E - 0.14
    for k in ("y10", "y14", "ys"):
        via1(X[k], YN, "y")
    paint("metal2", X["y10"] - E, YN - 0.14, X["ys"] + E, YN + 0.14, "y")
    info["latch"]["x"] = dict(m1_um=r(XPADX + 0.175 - X["x6"] - 0.115), m2_um=r(X["x6"] - X["xs"] + 2 * E), m3_um=0.0, via1=3)
    info["latch"]["y"] = dict(m1_um=0.0, m2_um=r(ylen + X["ys"] - X["y10"] + 2 * E), m3_um=0.0, via1=5)
    lab += [("x", "metal2", X["x2"], YN), ("y", "metal2", X["y14"], YN)]
else:
    for n_ in ("x", "y"):
        d = info["nets"][n_]
        stub = sum(abs(py - d["track"]) + 0.54 for px, py in [(X[k], y) for k, y in CVIA[n_]] + pads[n_])
        info["latch"][n_] = dict(m1_um=0.0, m2_um=r(stub), m3_um=d["m3_um"], via1=d["vias"])
lab += [("ax", "metal1", X["a1"] + 0.4, (AXL[0] + AXL[1]) / 2), ("ay", "metal1", X["b1"] + 0.4, (AXL[0] + AXL[1]) / 2)]

# ---------------------------------------------------------------- the generator's own checks
def dist(a, b):
    dx = max(a[0] - b[2], b[0] - a[2], 0.0)
    dy = max(a[1] - b[3], b[1] - a[3], 0.0)
    return (dx * dx + dy * dy) ** 0.5


bad = []
for layer, sp in (("metal1", 0.23), ("metal2", 0.28), ("metal3", 0.28), ("polysilicon", 0.24), ("via1", 0.26), ("via2", 0.26)):
    L = RECTS.get(layer, [])
    for i, a in enumerate(L):
        for b in L[i + 1:]:
            if a[4] is not None and a[4] == b[4]:
                continue
            d = dist(a, b)
            if d < sp - 1e-6:
                bad.append(f"{layer}: {a[4]} {a[:4]} and {b[4]} {b[:4]} are {d:.3f} um apart (< {sp})")
if bad and not NOCHECK:
    print("\n".join(bad[:40]))
    raise SystemExit(f"{len(bad)} spacing conflicts")

# ---------------------------------------------------------------- labels, ports, properties
n = 1
for net in PORTS:
    d = info["nets"][net]
    T += [box(d["x1"], d["track"] - 0.14, d["x1"] + 0.28, d["track"] + 0.14), f"label {net} c metal3", f"port make {n}"]
    n += 1
T += [box(X["q"] - 0.115, 2.6, X["q"] + 0.115, 2.9), "label q c metal1", f"port make {n}"]; n += 1
T += [box(XL + 0.5, 3.70, XL + 0.9, 4.10), "label VDD c metal1", f"port make {n}"]; n += 1
T += [box(XL + 0.5, -0.20, XL + 0.9, 0.20), "label VSS c metal1", f"port make {n}"]
for net, layer, lx, ly in lab:
    if net in PORTS:
        continue
    T += [box(lx - 0.1, ly - 0.1, lx + 0.1, ly + 0.1), f"label {net} c {layer}"]
u = lambda v: int(round(v / G))
T += [f"property MASKHINTS_NPLUS \"{u(XL - 0.08)} {u(-0.23)} {u(XR + 0.08)} {u(1.77)}\"",
      f"property MASKHINTS_PPLUS \"{u(XL - 0.08)} {u(1.77)} {u(XR + 0.08)} {u(4.15)}\"",
      f"property FIXED_BBOX \"0 0 {u(W)} {u(3.92)}\""]
T += [f"save {name}"]
open(out, "w").write("\n".join(T) + "\n")
info["x"] = X
json.dump(info, open(out.replace(".tcl", "_info.json"), "w"), indent=1)
print(f"{name}: row {W:.2f} um x 3.92 um ({W * 3.92:.1f} um2), latch-node wiring option {ROUTE}")
for n_, d in info["latch"].items():
    print(f"  {n_:4s} latch node: Metal3 {d['m3_um']:.2f} um, Metal2 {d['m2_um']:.2f} um, Metal1 jumper {d['m1_um']:.2f} um, {d['via1']} Via1")
for net, d in info["nets"].items():
    print(f"  {net:4s} Metal3 y={d['track']:.2f} x {d['x1']:.2f}..{d['x2']:.2f} ({d['m3_um']:.2f} um), {d['vias']} vias")

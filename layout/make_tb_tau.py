#!/usr/bin/env python3
"""Write a bench that measures tau, the regeneration time constant, of the three NAND flip-flops under test,
on the schematic netlist or on the netlist Magic extracted from the layout.
usage: make_tb_tau.py <netlist> <bench out> <pdk dir> <tag>
           [--corner typical|ss|ff] [--vdd 3.3] [--temp 27] [--estimates]

Method, as in xschem/benches/tb_tau.sch: with the clock high the master latch is closed and regenerates from
wherever it stands. Each flip-flop is in the bench twice. Both copies start at the latch's balance point, a
short current pulse between mq and mqb tips one copy 100 times further than the other, and the two cross
0.75 VDD a time tau x ln(100) apart. The balance point is the operating point ngspice finds when told to look
at the NAND gates' switching voltage (.nodeset); the bench prints it, and it is not a result unless it is
near 0.44 VDD on both nodes.

On the extracted netlist the bench holds the nine cells of each flip-flop as Magic extracted them, found from
how they are connected (see flip_flops()), and every wiring capacitor that touches one of their nets. Where
the other end of a capacitor is a net outside the flip-flop, that end is tied to ground: the net is taken to
be quiet. On the schematic netlist the bench holds the meta_dut_* subcircuits; --estimates adds the wiring
estimates the Xschem sheets carry (0.25 fF on mq and on mqb, 0.05 fF between them), the conditions under which
tb_tau measured 88.9, 80.5 and 102.3 ps.

The library flip-flop (DUT1) is not measured: its latch nodes are inside the cell."""
import argparse, re

TOP = "tt_um_metastability_characterizer"
LIB = "gf180mcu_fd_sc_mcu7t5v0__"
KINDS = {("nand2_2", "nand2_1"): "base", ("nand2_2", "nand2_2"): "keeper", ("nand2_4", "nand2_1"): "forward"}
SCHEMATIC = {"base": "meta_dut_baseline", "keeper": "meta_dut_keeper", "forward": "meta_dut_forward"}
ap = argparse.ArgumentParser()
ap.add_argument("net"); ap.add_argument("out"); ap.add_argument("pdk"); ap.add_argument("tag")
ap.add_argument("--corner", default="typical", choices=["typical", "ss", "ff"])
ap.add_argument("--vdd", type=float, default=3.3)
ap.add_argument("--temp", type=float, default=27.0)
ap.add_argument("--estimates", action="store_true")
A = ap.parse_args()
tag = A.tag

def farads(s):
    s = s.lower()
    scale = {"a": 1e-18, "f": 1e-15, "p": 1e-12, "n": 1e-9, "u": 1e-6}
    return float(s[:-1]) * scale[s[-1]] if s[-1] in scale else float(s)

def read(path):
    """({subcircuit (lower case): (ports, [(instance, nets, cell)])}, capacitors of the tile [(a, b, farads)])"""
    subs, caps, cur = {}, [], None
    for line in open(path).read().replace("\n+", " ").splitlines():
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
        elif cur == TOP.lower() and t[0][0] in "cC":
            caps.append((t[1], t[2], farads(t[3])))
    return subs, caps

def flip_flops(subs):
    """The NAND flip-flops among the tile's own cells: [(kind, {role: instance}, {name: net})].
    A latch is two NAND gates, each with the other's output on A1. Its two gating NANDs drive their A2 inputs:
    the second takes the first's output on A1, and both take the same clock on A2. In the master latch that
    clock comes from an inv_1 (clkn); the slave's first gating NAND takes mq, and its clock is that inverter's
    input. The gates' sizes say which of the three flip-flops it is."""
    def gates(kind):
        c = LIB + kind
        return [{"inst": i, "kind": kind, **dict(zip((p.upper() for p in subs[c][0]), i[1]))}
                for i in subs[TOP.lower()][1] if i[2] == c and c in subs]
    nands = gates("nand2_1") + gates("nand2_2") + gates("nand2_4")
    drives = {g["ZN"]: g for g in nands}
    inverter = {g["ZN"]: g for g in gates("inv_1")}
    latches = []
    for x in nands:
        for y in nands:
            if x is y or x["ZN"] != y["A1"] or y["ZN"] != x["A1"]:
                continue
            gx, gy = drives.get(x["A2"]), drives.get(y["A2"])
            if gx and gy and gy["A1"] == gx["ZN"] and gx["A2"] == gy["A2"]:
                latches.append({"fw": x, "kp": y, "g1": gx, "g2": gy, "clock": gx["A2"]})
    found = []
    for m in latches:
        cki = inverter.get(m["clock"])
        kind = KINDS.get((m["fw"]["kind"], m["kp"]["kind"]))
        slave = [s for s in latches if cki and s["g1"]["A1"] == m["fw"]["ZN"] and s["clock"] == cki["I"]]
        if not cki or not kind or len(slave) != 1:
            continue
        s = slave[0]
        cells = {"cki": cki, "mg1": m["g1"], "mg2": m["g2"], "mfw": m["fw"], "mkp": m["kp"],
                 "sg1": s["g1"], "sg2": s["g2"], "sfw": s["fw"], "skp": s["kp"]}
        nets = {"d": m["g1"]["A1"], "clk": cki["I"], "mq": m["fw"]["ZN"], "mqb": m["kp"]["ZN"], "q": s["fw"]["ZN"]}
        found.append((kind, {r: g["inst"] for r, g in cells.items()}, nets))
    return found

models = f"{A.pdk}/libs.tech/ngspice/sm141064.ngspice"
sections = [A.corner, "diode_" + A.corner]
have = set(s.lower() for s in re.findall(r"^\s*\.lib\s+(\S+)\s*$", open(models).read(), re.M | re.I))
missing = [s for s in sections if s not in have]
if missing:
    raise SystemExit(f"{models} has no section {missing}; it has {sorted(have)}")

subs, caps = read(A.net)
vdd = f"{A.vdd:g}"
small = 5e-9                                      # A for 20 ps: about 10 uV on 10 fF
L = [f"* tau of the NAND flip-flops ({tag}: {A.corner}, {vdd} V, {A.temp} C), generated by make_tb_tau.py",
     f".include {A.pdk}/libs.tech/ngspice/design.ngspice"] + [f".lib {models} {s}" for s in sections] + \
    [".param sw_stat_global=0 sw_stat_mismatch=0", f".temp {A.temp}", f".include {A.net}", f"VDD vdd 0 {vdd}",
     ".options method=gear reltol=1e-6 abstol=1e-12 vntol=1e-12 chgtol=1e-14 trtol=1"]
nodes = {}                                        # copy name -> (mq, mqb) as the bench names them
notes = []
schematic = all(s in subs for s in SCHEMATIC.values())
if schematic:
    for kind, sub in SCHEMATIC.items():
        for k in (0, 1):
            c = f"{kind}{k}"
            L.append(f"X{c} 0 vdd q_{c} vdd 0 {sub}")
            nodes[c] = (f"x{c}.mq", f"x{c}.mqb")
            if A.estimates:
                L += [f"Cmq_{c} x{c}.mq 0 0.25f", f"Cmqb_{c} x{c}.mqb 0 0.25f", f"Cmut_{c} x{c}.mq x{c}.mqb 0.05f"]
else:
    ffs = flip_flops(subs)
    if sorted(k for k, _, _ in ffs) != sorted(SCHEMATIC):
        raise SystemExit(f"expected one flip-flop of each kind in {A.net}, found {[k for k, _, _ in ffs]}")
    for kind, cells, nets in ffs:
        fixed = {"VDPWR": "vdd", "VGND": "0", nets["d"]: "0", nets["clk"]: "vdd"}
        own = sorted({n for i in cells.values() for n in i[1]} - set(fixed))
        wire = {n: sum(v for a, b, v in caps if n in (a, b)) for n in (nets["mq"], nets["mqb"])}
        notes.append((kind, wire[nets["mq"]], wire[nets["mqb"]]))
        for k in (0, 1):
            c = f"{kind}{k}"
            name = {n: f"{c}_n{j}" for j, n in enumerate(own)}
            name.update({nets["mq"]: f"{c}_mq", nets["mqb"]: f"{c}_mqb", nets["q"]: f"{c}_q"})
            at = lambda n: fixed.get(n) or name.get(n) or "0"       # a net outside the flip-flop: quiet
            L.append(f"* {c}: the cells of the {kind} flip-flop and the wiring capacitance on its nets")
            for role, (inst, pins, cell) in cells.items():
                L.append(f"X{c}_{role} " + " ".join(at(n) for n in pins) + f" {cell}")
            j = 0
            for a, b, v in caps:
                if v > 0 and (a in name or b in name) and at(a) != at(b):
                    L.append(f"C{c}_{j} {at(a)} {at(b)} {v:.6g}"); j += 1
            nodes[c] = (f"{c}_mq", f"{c}_mqb")

# The kick: copy 0 is tipped 100 times further than copy 1. Both start at the balance point.
for c, (mq, mqb) in nodes.items():
    amp = small * (100 if c.endswith("0") else 1)
    L += [f"Ikick_{c} {mqb} {mq} PULSE(0 {amp:g} 20p 1p 1p 20p)",
          f".nodeset v({mq})={0.437 * A.vdd:.4f} v({mqb})={0.437 * A.vdd:.4f}"]
# Expressions cannot hold the netlist's node names, so each latch node is copied to a plain one.
for c, (mq, mqb) in nodes.items():
    L += [f"Emq_{c} mq_{c} 0 {mq} 0 1", f"Emqb_{c} mqb_{c} 0 {mqb} 0 1"]
L += [".control", "set filetype=ascii", "tran 1p 8n"]
for kind in SCHEMATIC:
    for k in (0, 1):
        c = f"{kind}{k}"
        L += [f"let t_{c}=-1", f"meas tran t_{c} when v(mq_{c})={0.75 * A.vdd:g} cross=1"]
    L += [f"meas tran bal_mq_{kind} find v(mq_{kind}1) at=10p", f"meas tran bal_mqb_{kind} find v(mqb_{kind}1) at=10p",
          f"echo RESULT {tag} balance_{kind}_mq_V $&bal_mq_{kind}", f"echo RESULT {tag} balance_{kind}_mqb_V $&bal_mqb_{kind}",
          f"if t_{kind}0 < 0 | t_{kind}1 < 0", f"echo RESULT {tag} tau_{kind}_ps not_measured", "else",
          f"let tau=(t_{kind}1-t_{kind}0)/ln(100)*1e12", f"echo RESULT {tag} tau_{kind}_ps $&tau", "end"]
for kind, cmq, cmqb in notes:
    L += [f"echo RESULT {tag} wiring_on_{kind}_mq_fF {cmq * 1e15:.3f}", f"echo RESULT {tag} wiring_on_{kind}_mqb_fF {cmqb * 1e15:.3f}"]
plain = " ".join(f"v(mq_{c}) v(mqb_{c})" for c in nodes)
L += [f"wrdata tb_tau_{tag}.dat {plain}", ".endc", ".end"]
open(A.out, "w").write("\n".join(L) + "\n")
print("wrote", A.out, "from the", "schematic" if schematic else "extracted", "netlist")

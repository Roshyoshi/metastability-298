#!/usr/bin/env python3
"""Cut the extracted front end (and the flip-flop bank with its joins) out of the extracted tile.
(Copy of /home/claude/r3/tools/cutout.py for the bank revision: every cell outside the controller is kept, which now
includes the bank and the two join multiplexers; the bank inputs are ports; all subcircuits of the extraction are
written, so that the hierarchical blocks meta_n3ffb and meta_j3a keep their 3.3 V cells.)

Kept: every cell that the master netlist places outside the controller, plus the controller cells
that load or drive front-end nets (the capture register, the gates that read selected_q, early_q
and capture). The configuration registers and the gates that read static nets are replaced by
ideal sources on those nets. Every extracted capacitor between two kept nets is kept; a capacitor
from a kept net to a net that is not kept is connected to ground, and its total is reported.

Writes a subcircuit 'fe_pex' with named ports, for the benches to instantiate.
usage: cutout.py <pex netlist> <netmap.json> <instmap.json> <out.spice>
"""
import sys, json, re
sys.path.insert(0, "/home/claude/r3/tools")     # pexlib (read only)
import pexlib as P

import os
DESIGN = os.environ.get("DESIGN", "meta")
if DESIGN == "compact":
    PORTS = ["VDPWR", "VGND", "ena", "ui_in[6]", "ua[0]", "ui_in[3]", "uio_in[6]", "clk", "cap_d", "cap_rn",
             "uio_out[4]", "uio_out[5]", "ui_in[1]", "ui_in[2]", "ui_in[5]", "ui_in[7]", "uio_in[0]", "rst_n"]
else:
    PORTS = ["VDPWR", "VGND", "ena", "ui_in[6]", "ua[0]", "cfg[0]", "cfg[1]", "clk", "cap_d", "cap_rn",
             "uio_out[4]", "uio_out[5]"]
# controller cells kept: schematic name -> {pin: tie}  ('keep' = connect as in the layout)
BOUNDARY_META = {
    "xcontroller/x_256_": {"D": "cap_d", "RN": "cap_rn", "CLK": "clk"},   # capture register
    "xcontroller/x_125_": {},                                            # reads capture
    "xcontroller/x_243_": {"*in": "VDPWR"},                              # reads selected_q
    "xcontroller/x_247_": {"*in": "VGND"},                               # reads early_q
    "xcontroller/x_248_": {"*in": "VGND"},                               # reads early_q
}
# compact_control: capture is the output of a_ff (clocked by clk20); a_inv reads it; l1_ff (falling
# edge, clocked by b, which is high around the capture) and l2_ff (rising edge, clocked by a_n, which
# is low around the capture) read selected_q; event_xor reads early_q
BOUNDARY_COMPACT = {
    "xcontroller/xa_ff": {"D": "cap_d", "CLK": "clk"},
    "xcontroller/xa_inv": {},
    "xcontroller/xl1_ff": {"CLKN": "VDPWR"},
    "xcontroller/xl2_ff": {"CLK": "VGND"},
    "xcontroller/xevent_xor": {"*in": "VGND"},
}
BOUNDARY = BOUNDARY_COMPACT if DESIGN == "compact" else BOUNDARY_META
INPINS = {"A1", "A2", "A3", "A4", "B", "B1", "B2", "C", "I", "I0", "I1", "I2", "I3", "S", "S0", "S1", "D", "CLK", "CLKN", "E", "RN", "SETN", "d", "clk"}

def main():
    pex_path, netmap, instmap, out = sys.argv[1:5]
    pex = P.read_pex(pex_path)
    m = json.load(open(netmap))["map"]
    im = json.load(open(instmap))
    byname = {i[0]: i for i in pex["top"]["inst"]}
    keep = {v for k, v in im.items() if not k.startswith("xcontroller/")}
    keepnets = set()
    for n in keep:
        keepnets.update(byname[n][2])
    lines, sources = [], {}
    def san(s):
        return re.sub(r"[^A-Za-z0-9_]", "_", s).strip("_")
    portset = set(PORTS) | {"VSUBS"}
    rename = {}
    for sname, lname in m.items():
        if lname in portset:
            continue
        rename[lname] = san(sname)
    if DESIGN != "compact":
        rename[m["cfg[0]"]] = "cfg[0]"; rename[m["cfg[1]"]] = "cfg[1]"
    def nm(n):
        if n in portset:
            return n
        return rename.get(n, san(n))
    for n in sorted(keep):
        name, cell, args = byname[n]
        lines.append(" ".join([name] + [nm(a) for a in args] + [cell]))
    # boundary cells
    for sname, ties in BOUNDARY.items():
        lname = im[sname]
        name, cell, args = byname[lname]
        pins = pex["pins"][cell]
        new = []
        for p, a in zip(pins, args):
            if a in keepnets or a in ("VDPWR", "VGND", "VSUBS"):
                new.append(nm(a))
            elif p in ties:
                new.append(ties[p])
            elif p in INPINS and "*in" in ties:
                new.append(ties["*in"])
            else:
                new.append(f"bnd_{name}_{p}".replace("#", "_").replace("/", "_"))
        lines.append(" ".join([name] + new + [cell]))
        keepnets.update(a for a in new)
    # capacitors
    kept, grounded, gsum, dropped = 0, 0, 0.0, 0
    caplines = []
    for cname, a, b, v in pex["top"]["caps"]:
        ina, inb = a in keepnets, b in keepnets
        if ina and inb:
            caplines.append(f"{cname} {nm(a)} {nm(b)} {v}"); kept += 1
        elif ina or inb:
            k = nm(a) if ina else nm(b)
            caplines.append(f"{cname} {k} VGND {v}"); grounded += 1; gsum += P.capval(v)
        else:
            dropped += 1
    # undriven-net check: every net that reaches an input pin must be driven by a kept cell or be a port
    OUTP = {"Z", "ZN", "Q", "slow", "q"}
    drv, rd = set(), {}
    allinst = [(byname[n][1], byname[n][2]) for n in keep] + [(byname[im[s]][1], None) for s in BOUNDARY]
    for line in lines:
        t = line.split(); cell = t[-1]; args = t[1:-1]
        for p, a in zip(pex["pins"][cell], args):
            if p in OUTP: drv.add(a)
            elif p in INPINS or p in ("launch", "control"): rd.setdefault(a, []).append(t[0])
    und = [a for a in rd if a not in drv and a not in PORTS and a not in ("VDPWR", "VGND")]
    print("undriven nets read by kept cells:", und if und else "none")
    used = set(pex["order"])                       # every subcircuit (the blocks hold 3.3 V cells)
    with open(out, "w") as f:
        f.write(f"* Extracted front end cut from {pex_path}\n")
        f.write(f"* kept caps {kept}, caps to controller nets grounded {grounded} ({gsum*1e15:.2f} fF), dropped {dropped}\n")
        for c in pex["order"]:
            if c in used:
                f.write("\n".join(pex["subckts"][c]) + "\n")
        f.write(".subckt fe_pex " + " ".join(PORTS) + "\n")
        f.write("* the substrate of the extraction is ground\nVsubs_tie VSUBS VGND 0\n")
        f.write("\n".join(lines) + "\n")
        f.write("\n".join(caplines) + "\n")
        f.write(".ends fe_pex\n")
    with open(out.replace(".spice", "_body.spice"), "w") as f:
        f.write(f"* Extracted front end (top-level body, nets global) cut from {pex_path}\n")
        for c in pex["order"]:
            if c in used:
                f.write("\n".join(pex["subckts"][c]) + "\n")
        f.write("Vsubs_tie VSUBS VGND 0\n")
        f.write("\n".join(lines) + "\n")
        f.write("\n".join(caplines) + "\n")
    print(f"instances {len(lines)}, caps kept {kept}, grounded {grounded} ({gsum*1e15:.2f} fF), dropped {dropped}")
    # node names for the benches
    nodes = {k: nm(v) for k, v in m.items()}
    json.dump(nodes, open(out.replace(".spice", "_nodes.json"), "w"), indent=1)

if __name__ == "__main__":
    main()

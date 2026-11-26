#!/usr/bin/env python3
"""Cut the front end and the flip-flop bank out of the extracted tile (the method of verification/independent,
Section 4, and of verification/bank/tools/cutout_bank.py, written again for this workspace).

Kept: every cell that the master netlist places outside the controller (flip-flops under test, selector, delay line,
early observer, data inverters, monitor drivers, the bank and the two joins) and the five controller cells that touch
their nets: a_ff (the capture flip-flop; D tied to the port cap_d, CLK to the port clk), a_inv, l1_ff (CLKN tied
high), l2_ff (CLK tied low) and event_xor (its other input tied low). Every extracted capacitor between two kept
nets is kept; a capacitor from a kept net to a net that is not kept is connected to VGND.

Writes <out>: the subcircuits of the extraction and the top-level body with global nets named as in the master
netlist (characters other than letters, digits and _ replaced by _, e.g. u_dut2/mq -> u_dut2_mq, q[1] -> q_1);
the tile pins keep their names (ui_in[6], ua[0], ...). Also <out>.nodes.json.
usage: cutout.py <pex netlist> <top .ext> <layout_plan.json> <chip_lvs.spice> <out.spice>
"""
import sys, re, json, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import pexflat as PL
pex_path, ext, plan, lvs, out = sys.argv[1:6]
pex = PL.read_pex(pex_path); place = PL.placement(ext, plan); cdl = PL.read_cdl(lvs)
m, mc = PL.netmap(pex, cdl, place)
PORTS = ["VDPWR", "VGND", "ena", "ui_in[6]", "ua[0]", "ui_in[3]", "uio_in[6]", "clk", "uio_out[4]", "uio_out[5]",
         "ui_in[1]", "ui_in[2]", "ui_in[5]", "ui_in[7]", "uio_in[0]", "rst_n"]
BOUNDARY = {"controller/a_ff": {"D": "cap_d", "CLK": "clk"}, "controller/a_inv": {},
            "controller/l1_ff": {"CLKN": "VDPWR"}, "controller/l2_ff": {"CLK": "VGND"}, "controller/event_xor": {"*in": "VGND"}}
INPINS = {"A1", "A2", "A3", "A4", "B", "B1", "B2", "C", "I", "I0", "I1", "I2", "I3", "S", "S0", "S1", "D", "CLK", "CLKN", "E", "RN", "SETN"}
byname = {i[0]: i for i in pex["top"]["inst"]}
inv = {v: k for k, v in place.items()}
keep = [e for e, n in place.items() if not n.startswith("controller/") and e in byname]
san = lambda s: re.sub(r"[^A-Za-z0-9_]", "_", s).strip("_")
portset = set(PORTS) | {"VSUBS"}
rename = {l: san(s) for s, l in m.items() if l not in portset}
def nm(n): return n if n in portset else rename.get(n, "e_" + san(n))
keepnets = set()
for e in keep: keepnets.update(byname[e][2])
lines = []
for e in sorted(keep):
    name, cell, args = byname[e]
    lines.append(" ".join(["X" + san(place[e])] + [nm(a) for a in args] + [cell]))
for sname, ties in BOUNDARY.items():
    name, cell, args = byname[inv[sname]]; new = []
    for p, a in zip(pex["pins"][cell], args):
        if a in keepnets or a in ("VDPWR", "VGND", "VSUBS"): new.append(nm(a))
        elif p in ties: new.append(ties[p])
        elif p in INPINS and "*in" in ties: new.append(ties["*in"])
        else: new.append("bnd_" + san(sname) + "_" + san(p))
    lines.append(" ".join(["X" + san(sname)] + new + [cell]))
    keepnets.update(a for p, a in zip(pex["pins"][cell], args) if a in keepnets)
kept = grounded = dropped = 0; gsum = 0.0; caplines = []
for cname, a, b, v in pex["top"]["caps"]:
    ina, inb = a in keepnets, b in keepnets
    if ina and inb:
        if nm(a) != nm(b): caplines.append(f"{cname} {nm(a)} {nm(b)} {v}"); kept += 1
    elif ina or inb:
        k = nm(a) if ina else nm(b)
        if k != "VGND": caplines.append(f"{cname} {k} VGND {v}"); grounded += 1; gsum += PL.capval(v)
    else: dropped += 1
txt = open(pex_path).read().replace("\n+", " ")
defs = txt[:txt.index(".subckt " + PL.TOP)]
with open(out, "w") as f:
    f.write(f"* Front end and bank cut from {os.path.basename(pex_path)}: {len(lines)} cells, capacitors kept {kept}, to nets outside grounded {grounded} ({gsum*1e15:.2f} fF), dropped {dropped}\n")
    f.write(defs + "Vsubs_tie VSUBS VGND 0\n" + "\n".join(lines) + "\n" + "\n".join(caplines) + "\n")
json.dump({k: nm(v) for k, v in m.items()}, open(out + ".nodes.json", "w"), indent=1)
print(f"{out}: {len(lines)} cells, capacitors kept {kept}, grounded {grounded} ({gsum*1e15:.2f} fF), dropped {dropped}")

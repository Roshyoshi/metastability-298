#!/usr/bin/env python3
"""Whole-tile supply-current bench.

usage: isup_gen.py <extracted netlist> <bench from make_tb_chip.py> <out dir> <tag> [--both-data]

Takes a bench written by layout/make_tb_chip.py and the extracted netlist it includes, and writes
  <out dir>/<tag>_net.spice   the netlist with a 0 V source in series with the VDPWR pin and the VGND pin of
                              every cell instance of the top level (supply current of each cell)
  <out dir>/<tag>.spice       the bench: VGND of the tile through a 0 V source (ground current of the tile),
                              .save of the supply currents and of the pin voltages, binary raw file
  <out dir>/<tag>_probes.json instance -> (cell, probe names)
The stimulus, the loads (0.2 pF on every output pin) and the RESULT measurements are those of make_tb_chip.py,
so the RESULT lines can be compared with the recorded runs.
--both-data: ui_in[6] toggles once per trial as well (highest activity with the bank enabled).
"""
import sys, re, json, os
net, bench, outdir, tag = sys.argv[1:5]
both = "--both-data" in sys.argv
TOP = "tt_um_metastability_characterizer"
os.makedirs(outdir, exist_ok=True)

raw = open(net).read()
head, sep, top = raw.partition(".subckt " + TOP)
assert sep, "top subcircuit not found"
top = (sep + top).replace("\n+", " ")
out, probes, k = [], {}, 0
for line in top.splitlines():
    if line[:1] in ("x", "X"):
        t = line.split()
        args = [p for p in t[1:] if "=" not in p]
        cell = args[-1]
        nv = sum(1 for p in t[1:-1] if p == "VDPWR"); ng = sum(1 for p in t[1:-1] if p == "VGND")
        assert nv and ng, line[:80]
        new = [t[0]] + [f"vp_{k}" if p == "VDPWR" else f"vg_{k}" if p == "VGND" else p for p in t[1:]]
        out.append(" ".join(new))
        out.append(f"Vp_{k} VDPWR vp_{k} 0")       # positive current = into the cell from VDPWR
        out.append(f"Vg_{k} vg_{k} VGND 0")        # positive current = out of the cell into VGND
        probes[t[0][1:]] = {"cell": cell, "k": k, "ip": f"v.xdut.vp_{k}", "ig": f"v.xdut.vg_{k}",
                            "n_vdpwr_pins": nv, "n_vgnd_pins": ng}
        k += 1
    else:
        out.append(line)
open(f"{outdir}/{tag}_net.spice", "w").write(head + "\n".join(out) + "\n")
json.dump(probes, open(f"{outdir}/{tag}_probes.json", "w"), indent=1)

b = open(bench).read().splitlines()
L, pins = [], []
for line in b:
    if line.startswith(".include") and line.rstrip().endswith("_pex.spice"):
        L.append(f".include {os.path.abspath(outdir)}/{tag}_net.spice")
    elif line.startswith("VDD "):
        L.append(line)                               # i(VDD) is minus the current drawn from VDPWR
    elif line.startswith("XDUT "):
        t = line.split()
        assert t[-1] == TOP and t[-2] == "0" and t[-3] == "vdpwr", t[-4:]
        t[-2] = "vgnd"
        pins = [p for p in t[1:-3]]
        L.append(" ".join(t)); L.append("VGS vgnd 0 0")   # i(VGS) = current from the tile's VGND to ground
    elif both and line.startswith("VDATA "):
        vdd = re.search(r"VDD vdpwr 0 (\S+)", "\n".join(b)).group(1)
        L.append(f"VDATA ui_in_6 0 PULSE(0 {vdd} 75n 0.1n 0.1n 199.9n 400n)")
    elif line.startswith("set filetype"):
        L.append("set filetype=binary")
    elif line.startswith("set num_threads"):
        L.append("set num_threads=1")
    elif line.startswith("wrdata "):
        L.append(f"write {tag}.raw")
    elif line.strip() == ".control":
        sv = ["i(VDD)", "i(VGS)"] + [f"i({p['ip']})" for p in probes.values()] + [f"i({p['ig']})" for p in probes.values()]
        sv += [f"v({p})" for p in sorted(set(pins)) if p != "0"]
        sv += [f"v({m.group(1)})" for m in (re.match(r"E(p_\w+) ", x) for x in b) if m]
        for i in range(0, len(sv), 12):
            L.append(".save " + " ".join(sv[i:i + 12]))
        L.append(line)
    else:
        L.append(line)
open(f"{outdir}/{tag}.spice", "w").write("\n".join(L) + "\n")
print("wrote", f"{outdir}/{tag}.spice;", len(probes), "cell instances probed")

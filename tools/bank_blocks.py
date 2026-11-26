#!/usr/bin/env python3
"""Hard blocks of the flip-flop bank, built with Magic from the 3.3 V cell library.

  N1: meta_n3ffb, the NAND master-slave flip-flop of 3.3 V cells (forward and keeper nand2_4, the rest nand2_2 /
      inv_2 of gf180mcu_as_sc_mcu7t3v3), cells placed by abutment in one 3.92 um row with four tap cells, every net
      on a Metal3 strap over the row (Via1, Metal2 stub, Via2). This is the block n3ffb (variant b) of the
      layout study of November 2026, unchanged except for its name: Magic DRC 0, KLayout decks 0, LVS unique.

  export GF180_AS_CELLS=<gf180mcu_as_sc_mcu7t3v3 checkout>/pdk/libs.ref/gf180mcu_as_sc_mcu7t3v3/mag
  python3 tools/bank_blocks.py            # layout/blocks/meta_n3ffb.gds (and .mag), needs magic (8.3.573 used)

  N2: meta_j3a, the asymmetric jamb-latch flip-flop j3a of 3.3 V transistors (master NMOS 4 x 1.0 um, PMOS 2 x 1.0 um,
      clock-gated write 2 um, data transistor 4 um, minimum slave), drawn by tools/j3a_gen.py (route m2j): Magic
      DRC 0, KLayout 621 rules 0, conservative well deck 0, LVS unique in the study.

Coordinates in um. The pins of meta_n3ffb are its Metal3 straps d, clk, q; tools/bank_layout.py connects to them
at the Via1 of mg1.B (d), sg2.A (clk) and sfw.Y (q).
"""
import os, re, subprocess, sys, json
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import lefparse as LP

CHIP = Path(__file__).resolve().parent.parent
OUT = CHIP / 'layout' / 'blocks'
CELLS = LP.ext_path('GF180_AS_CELLS', 'the mag/ folder of a gf180mcu_as_sc_mcu7t3v3 checkout')
P3 = "gf180mcu_as_sc_mcu7t3v3__"
U = 0.005                                    # um per unit of the .mag files


def parse(cell):
    labels, bbox = {}, None
    for line in open(CELLS / f"{P3}{cell}.mag"):
        t = line.split()
        if line.startswith("flabel ") or line.startswith("rlabel "):
            i = 3 if t[2] == "s" else 2
            try:
                box = tuple(int(v) * U for v in t[i:i + 4])
            except ValueError:
                continue
            labels[t[-1]] = box
        if "FIXED_BBOX" in line:
            bbox = tuple(int(v) * U for v in t[2:6])
    return labels, bbox


LIB = {c: parse(c) for c in ("inv_2", "nand2_2", "nand2_4", "tap_2")}

# placement: (instance, cell, mirrored)
ROW = [("tapl", "tap_2", False), ("cki", "inv_2", False), ("mg1", "nand2_2", False), ("mg2", "nand2_2", False),
       ("tapm1", "tap_2", False), ("mfw", "nand2_4", False), ("mkp", "nand2_4", True), ("sg1", "nand2_2", True),
       ("tapm2", "tap_2", False), ("sg2", "nand2_2", False), ("sfw", "nand2_2", False), ("skp", "nand2_2", False),
       ("tapr", "tap_2", False)]
# nets: pins as (instance, pin). 'top' input of the NAND cells is B, 'bottom' is A.
NETS = {
    "clk":  [("cki", "A"), ("sg1", "A"), ("sg2", "A")],
    "clkn": [("cki", "Y"), ("mg1", "A"), ("mg2", "A")],
    "d":    [("mg1", "B")],
    "g1":   [("mg1", "Y"), ("mg2", "B"), ("mfw", "A")],
    "g2":   [("mg2", "Y"), ("mkp", "A")],
    "mq":   [("mfw", "Y"), ("mkp", "B"), ("sg1", "B")],
    "mqb":  [("mkp", "Y"), ("mfw", "B")],
    "s1":   [("sg1", "Y"), ("sg2", "B"), ("sfw", "A")],
    "s2":   [("sg2", "Y"), ("skp", "A")],
    "sqb":  [("skp", "Y"), ("sfw", "B")],
    "q":    [("sfw", "Y"), ("skp", "B")],
}
TRACKS = [0.56, 1.12, 1.68, 2.24, 2.80, 3.36]             # Metal3 strap centres (um)
PREF = {"mq": 2.24, "mqb": 1.12, "clk": 3.36, "clkn": 0.56, "g2": 0.56, "g1": 1.68, "d": 2.80,
        "s1": 1.68, "s2": 0.56, "sqb": 2.80, "q": 2.24}
# variant b: the clock strap and the g2 strap moved onto the supply rails (y = 3.92 and 0), s1 and s2 moved,
# so that the tracks next to the two master straps stay empty along the master latch
PREF_B = dict(PREF, clk=3.92, g2=0.0, s1=0.56, s2=1.12)
VARIANTS = {"a": PREF, "b": PREF_B}
PORTS = ["d", "clk", "q"]


def build(name="n3ff", pref=PREF, xsel=None, bad=False):
    xsel = xsel or {}
    x = 0.0
    place, pinpos = [], {}
    for inst, cell, mir in ROW:
        labels, bbox = LIB[cell]
        w = bbox[2] - bbox[0]
        place.append((inst, cell, mir, x, w))
        for pn, (x1, y1, x2, y2) in labels.items():
            if pn in ("VDD", "VSS", "VNW", "VPW"):
                continue
            if mir:
                x1, x2 = w - x2, w - x1
            pinpos[(inst, pn)] = (x + x1, y1, x + x2, y2)
        x += w
    width = x
    # landing point on each pin: default the middle of the pin; xsel may give a fraction along the pin
    land = {}
    for net, pins in NETS.items():
        yt = pref[net]
        for p in pins:
            x1, y1, x2, y2 = pinpos[p]
            fx = xsel.get(p, 0.5)
            px = round((x1 + 0.19 + fx * (x2 - x1 - 0.38)) / U) * U if x2 - x1 > 0.40 else round((x1 + x2) / 2 / U) * U
            lo, hi = y1 + 0.19, y2 - 0.19                      # via centre range that keeps 0.06 of Metal1 above and below
            py = min(max(yt, lo), hi) if hi >= lo else (y1 + y2) / 2
            py = round(py / U) * U
            land[p] = (px, py)
    T = []
    T += [f"addpath {CELLS}", "snap internal", "drc off", f"load {name} -force"]

    def box(x1, y1, x2, y2):
        return f"box values {x1:.3f}um {y1:.3f}um {x2:.3f}um {y2:.3f}um"
    for inst, cell, mir, x0, w in place:
        if mir:
            T += [box(x0 + w, 0, x0 + w, 0), f"getcell {P3}{cell} h child 0 0"]
        else:
            T += [box(x0, 0, x0, 0), f"getcell {P3}{cell} child 0 0"]
    info = {"width": width, "nets": {}}
    for net, pins in NETS.items():
        yt = pref[net]
        xs = []
        for p in pins:
            px, py = land[p]
            xs.append(px)
            # Via1 on the pin, Metal2 stub from the pin to the strap, Via2 under the strap
            T += [box(px - 0.13, py - 0.13, px + 0.13, py + 0.13), "paint via1"]
            T += [box(px - 0.14, min(py, yt) - 0.27, px + 0.14, max(py, yt) + 0.27), "paint metal2"]
            T += [box(px - 0.14, yt - 0.14, px + 0.14, yt + 0.14), "paint via2"]
        x1, x2 = min(xs) - 0.33, max(xs) + 0.33
        if net in PORTS:
            x1 -= 0.4
        T += [box(x1, yt - 0.14, x2, yt + 0.14), "paint metal3"]
        info["nets"][net] = dict(track=yt, x1=x1, x2=x2, pins={f"{a}.{b}": land[(a, b)] for a, b in pins})
    # ports
    n = 1
    for net in PORTS:
        d = info["nets"][net]
        T += [box(d["x1"], d["track"] - 0.14, d["x1"] + 0.28, d["track"] + 0.14), f"label {net} c metal3", f"port make {n}"]
        n += 1
    # the supply labels need paint of this cell under them, otherwise they do not attach to the rails of the cells
    T += [box(0.2, 3.70, 0.6, 4.10), "paint metal1", "label VDD c metal1", f"port make {n}"]; n += 1
    T += [box(0.2, -0.20, 0.6, 0.20), "paint metal1", "label VSS c metal1", f"port make {n}"]
    # labels on the internal nets so that the extraction keeps their names
    for net in NETS:
        if net in PORTS:
            continue
        d = info["nets"][net]
        xm = d["x2"] - 0.3
        T += [box(xm - 0.1, d["track"] - 0.1, xm + 0.1, d["track"] + 0.1), f"label {net} c metal3"]
    if bad:        # deliberate violation, to prove that the check reports one: Metal3 0.10 um from the mq strap
        d = info["nets"]["mq"]
        T += [box(d["x1"] + 2.0, d["track"] + 0.24, d["x1"] + 3.0, d["track"] + 0.52), "paint metal3"]
    T += [f"save {name}"]
    return T, info



def magic_cmd():
    rc = os.environ.get('PDK_ROOT', '/usr/local/share/pdk') + '/gf180mcuD/libs.tech/magic/gf180mcuD.magicrc'
    return [os.environ.get('MAGIC', 'magic'), '-dnull', '-noconsole', '-rcfile', rc]

def make_n3ffb():
    name = 'meta_n3ffb'
    T, info = build(name, pref=VARIANTS['b'], xsel={("mfw", "B"): 1.0, ("mkp", "B"): 0.0})
    by = {}
    for net, d in info["nets"].items():
        by.setdefault(d["track"], []).append((d["x1"], d["x2"], net))
    for yt, lst in by.items():
        lst.sort()
        for a, b in zip(lst, lst[1:]):
            assert b[0] - a[1] >= 0.28, f"straps of {a[2]} and {b[2]} collide on the track at {yt}"
    OUT.mkdir(parents=True, exist_ok=True)
    T = [t for t in T if not t.startswith('save ')]
    T += [f'save {name}', 'select top cell', f'gds write {name}.gds', 'quit -noprompt']     # magic runs in OUT
    tcl = OUT / f'{name}.tcl'
    tcl.write_text('\n'.join(T) + '\n')
    (OUT / f'{name}_info.json').write_text(json.dumps(info, indent=1))
    r = subprocess.run(magic_cmd() + [str(tcl)], cwd=OUT, stdin=subprocess.DEVNULL, capture_output=True, text=True)
    (OUT / f'{name}_magic.log').write_text(r.stdout + r.stderr)
    tcl.unlink()
    if r.returncode != 0 or not (OUT / f'{name}.gds').exists():
        raise SystemExit(f'magic failed, see {OUT}/{name}_magic.log')
    print(OUT / f'{name}.gds', f'width {info["width"]:.2f} um')

def make_j3a():
    """N2: meta_j3a, the asymmetric jamb-latch flip-flop j3a (route m2j) drawn by tools/j3a_gen.py."""
    name = 'meta_j3a'
    OUT.mkdir(parents=True, exist_ok=True)
    tcl = OUT / f'{name}.tcl'
    r = subprocess.run([sys.executable, str(Path(__file__).resolve().parent / 'j3a_gen.py'), str(tcl), name, '--route', 'm2j'],
                       capture_output=True, text=True, env={**os.environ, 'GF180_AS_CELLS': str(CELLS)})
    if r.returncode != 0:
        raise SystemExit('j3a_gen.py failed: ' + r.stdout + r.stderr)
    T = [t for t in tcl.read_text().splitlines() if not t.startswith('save ')]
    T += [f'save {name}', 'select top cell', f'gds write {name}.gds', 'quit -noprompt']
    tcl.write_text('\n'.join(T) + '\n')
    r = subprocess.run(magic_cmd() + [str(tcl)], cwd=OUT, stdin=subprocess.DEVNULL, capture_output=True, text=True)
    (OUT / f'{name}_magic.log').write_text(r.stdout + r.stderr)
    tcl.unlink()
    if r.returncode != 0 or not (OUT / f'{name}.gds').exists():
        raise SystemExit(f'magic failed, see {OUT}/{name}_magic.log')
    print(OUT / f'{name}.gds')

if __name__ == '__main__':
    make_n3ffb()
    make_j3a()

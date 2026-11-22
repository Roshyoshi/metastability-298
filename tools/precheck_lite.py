#!/usr/bin/env python3
"""The file-format checks of the Tiny Tapeout precheck (tt-support-tools/precheck/precheck.py, gf180mcuD,
analog 1x2), re-implemented on our own GDS reader because gdstk/klayout cannot be installed here.

Covered: top cell unique and named, boundary (bbox = die, PR_bndry rectangle in the top cell), valid layers,
cell names, pin check (LEF against the template DEF, and every LEF port covered by a Metal4_Label polygon
in the GDS), analog pin check (ua[0] connected, ua[1..7] not), power pin check (Verilog and LEF), zero-area
shapes. Not covered: the KLayout GF180 rule deck and antenna deck (run on ecetesla0, round-2 kit).
"""
import re, sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import gds
import route_gen as RG

CHIP = Path(__file__).resolve().parent.parent
TOP = 'tt_um_metastability_characterizer'
# Only its "calma <layer> <datatype>" lines are read, for the valid layer list.
TECH = RG.LG.LP.ext_path('GF180_MAGIC_TECH', "the PDK's libs.tech/magic/gf180mcuD.tech")
ANALOG_PINS = 1                      # info.yaml analog_pins
USED_ANALOG = {'ua[0]'}              # info.yaml pinout ua[0] non-empty

def nmv(v):
    return int(round(v * 1000))

def run(gds_path, lef_path, v_path):
    res = []
    def check(name, ok, msg=''):
        res.append((name, ok, msg))
    lib = gds.read(gds_path)
    refd = {r['sname'] for c in lib.cells.values() for r in c.refs}
    tops = [n for n in lib.cells if n not in refd]
    check('top cell unique and named ' + TOP, tops == [TOP], str(tops))
    top = lib.cells[TOP]
    flat = gds.flatten(lib, TOP)
    xs = [x for l, d, p in flat for x, y in p]; ys = [y for l, d, p in flat for x, y in p]
    die = (0, 0, nmv(RG.LG.TILE_W), nmv(RG.LG.TILE_H))
    check('boundary: bbox equals die', (min(xs), min(ys), max(xs), max(ys)) == die, str((min(xs), min(ys), max(xs), max(ys))))
    check('PR_bndry (0/0) rectangle of die size in the top cell',
          any((l, d) == (0, 0) and gds.bbox(p) == die for l, d, p in top.polys))
    valid = {(int(a), int(b)) for a, b in re.findall(r'calma\s+(\d+)\s+(\d+)', TECH.read_text())} | {(63, 63)}
    used = {(l, d) for c in lib.cells.values() for l, d, p in c.polys} | \
           {(t[0], t[1]) for c in lib.cells.values() for t in getattr(c, 'texts', [])}
    check('valid layers only (no Metal5)', not (used - valid) and (81, 0) not in used, str(sorted(used - valid)))
    check('cell names without # or /', all('#' not in n and '/' not in n for n in lib.cells))
    zero = [(l, d) for l, d, p in flat if (lambda b: (b[2] - b[0]) * (b[3] - b[1]))(gds.bbox(p)) == 0]
    check('no zero-area shapes', not zero, str(zero[:3]))
    # ---- pin check
    tp = RG.template_pins()
    lef = lef_path.read_text()
    m = re.search(r'MACRO (\S+)(.*?)END \1', lef, re.S)
    check('LEF macro name', m and m.group(1) == TOP)
    body = m.group(2)
    size = re.search(r'SIZE (\S+) BY (\S+) ;', body)
    check('LEF size equals die', (nmv(float(size.group(1))), nmv(float(size.group(2)))) == die[2:])
    ports = {}
    for pm in re.finditer(r'PIN (\S+)(.*?)END \1', body, re.S):
        ports[pm.group(1)] = [(lay, *[nmv(float(v)) for v in r]) for lay, rects in
                              re.findall(r'LAYER (\S+) ;((?:\s*RECT [^;]+;)+)', pm.group(2), re.S)
                              for r in re.findall(r'RECT (\S+) (\S+) (\S+) (\S+) ;', rects)]
    bad = []
    for pin, (x1, y1, x2, y2, d) in tp.items():
        want = ('Metal4', nmv(x1), nmv(y1), nmv(x2), nmv(y2))
        if ports.get(pin) != [want]:
            bad.append(pin)
    check('every template pin in the LEF with the template rectangle', not bad, str(bad[:5]))
    extra = set(ports) - set(tp) - {'VDPWR', 'VGND'}
    check('no extra LEF pins', not extra, str(extra))
    pw = []
    for p in ('VDPWR', 'VGND'):
        for lay, x1, y1, x2, y2 in ports.get(p, []):
            if lay != 'Metal4' or x2 - x1 < 800 or y1 > 10000 or die[3] - y2 > 10000:
                pw.append((p, x1, y1, x2, y2))
    check('power ports on Metal4, >= 0.8 um wide, within 10 um of bottom and top edges',
          not pw and 'VDPWR' in ports and 'VGND' in ports, str(pw))
    check('power USE lines', bool(re.search(r'PIN VDPWR.*?USE POWER', body, re.S)) and bool(re.search(r'PIN VGND.*?USE GROUND', body, re.S)))
    allr = [(p, r) for p, rs in ports.items() for r in rs]
    ov = []
    for i in range(len(allr)):
        for j in range(i + 1, len(allr)):
            (p1, a), (p2, b) = allr[i], allr[j]
            if p1 != p2 and a[0] == b[0] and not (a[3] < b[1] or b[3] < a[1] or a[4] < b[2] or b[4] < a[2]):
                ov.append((p1, p2))
    check('no overlapping or abutting LEF pins', not ov, str(ov[:3]))
    labels = [gds.bbox(p) for l, d, p in top.polys if (l, d) == (46, 10)]
    miss = []
    for p, rs in ports.items():
        for lay, x1, y1, x2, y2 in rs:
            if not any(a <= x1 + 1 and b <= y1 + 1 and c >= x2 - 1 and e >= y2 - 1 for a, b, c, e in labels):
                miss.append(p)
    check('every LEF port covered by a Metal4_Label polygon in the GDS', not miss, str(miss[:5]))
    # ---- analog pins: metal in the 0.1-0.5 um ring around the pin, or Via3 inside it
    m4 = [gds.bbox(p) for l, d, p in flat if (l, d) == (46, 0)]
    v3 = [gds.bbox(p) for l, d, p in flat if (l, d) == (40, 0)]
    an = []
    for k in range(8):
        x1, y1 = nmv(325.82 - 43.68 * k), 0
        x2, y2 = x1 + 3000, 1000
        outer = (x1 - 500, y1 - 500, x2 + 500, y2 + 500); inner = (x1 - 100, y1 - 100, x2 + 100, y2 + 100)
        def hits_ring(r):
            if r[2] <= outer[0] or r[0] >= outer[2] or r[3] <= outer[1] or r[1] >= outer[3]:
                return False
            return not (r[0] >= inner[0] and r[2] <= inner[2] and r[1] >= inner[1] and r[3] <= inner[3])
        conn = any(hits_ring(r) for r in m4) or any(not (r[2] <= x1 or r[0] >= x2 or r[3] <= y1 or r[1] >= y2) for r in v3)
        expect = k < ANALOG_PINS and f'ua[{k}]' in USED_ANALOG
        if conn != expect:
            an.append((k, conn, expect))
    check('analog pins: ua[0] connected, ua[1..7] free', not an, str(an))
    # ---- power pin check on the Verilog
    v = re.sub(r'//.*', '', v_path.read_text())
    check('Verilog has VDPWR and VGND, no VAPWR', 'VDPWR' in v and 'VGND' in v and 'VAPWR' not in v)
    return res

if __name__ == '__main__':
    res = run(CHIP / 'gds' / f'{TOP}.gds', CHIP / 'lef' / f'{TOP}.lef', CHIP / 'src' / 'project.v')
    for name, ok, msg in res:
        print(('PASS ' if ok else 'FAIL ') + name + ('' if ok else '   ' + msg))
    print('ALL PASS' if all(ok for _, ok, _ in res) else 'FAILURES')

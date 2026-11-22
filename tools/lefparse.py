#!/usr/bin/env python3
"""Read GF180 standard-cell LEF abstracts: SIZE, signal/power pins (Metal1 polygons) and OBS."""
import os, re
from pathlib import Path

def ext_path(var, what):
    """Path of an input kept outside the repository, named by environment variable var."""
    v = os.environ.get(var)
    if not v:
        raise SystemExit(f'{var} is not set: point it at {what}')
    p = Path(v).expanduser()
    if not p.exists():
        raise SystemExit(f'{var}={v} does not exist: point it at {what}')
    return p

# The same checkout tools/pdk_cells.py reads: <lib>/cells/<family>/<cell>.lef
# and .gds.
SC = ext_path('GF180_SC_CELLS', 'the cells/ folder of a gf180mcu_fd_sc_mcu7t5v0 checkout')
LIB = 'gf180mcu_fd_sc_mcu7t5v0__'

def cell_dir(cell):
    fam = cell if cell in ('filltie', 'endcap', 'antenna') else cell.rsplit('_', 1)[0]
    if cell.startswith('fill_'):
        fam = 'fill'
    if cell.startswith('fillcap_'):
        fam = 'fillcap'
    return SC / fam

def read_lef(cell):
    txt = (cell_dir(cell) / f'{LIB}{cell}.lef').read_text()
    m = re.search(r'SIZE\s+([\d.]+)\s+BY\s+([\d.]+)', txt)
    w, h = float(m.group(1)), float(m.group(2))
    pins = {}
    for pm in re.finditer(r'PIN (\S+)(.*?)END \1', txt, re.S):
        name, body = pm.group(1), pm.group(2)
        polys = []
        for lay, geo in re.findall(r'LAYER (\S+) ;(.*?)(?=LAYER|END)', body, re.S):
            for poly in re.findall(r'POLYGON ([\d.\s-]+);', geo):
                v = [float(t) for t in poly.split()]
                polys.append((lay, list(zip(v[0::2], v[1::2]))))
            for rect in re.findall(r'RECT ([\d.\s-]+);', geo):
                x1, y1, x2, y2 = [float(t) for t in rect.split()]
                polys.append((lay, [(x1, y1), (x2, y1), (x2, y2), (x1, y2)]))
        direction = re.search(r'DIRECTION (\S+)', body)
        use = re.search(r'USE (\S+)', body)
        ga = re.search(r'ANTENNAGATEAREA ([\d.]+)', body)
        da = re.search(r'ANTENNADIFFAREA ([\d.]+)', body)
        pins[name] = {'polys': polys, 'dir': direction.group(1) if direction else None, 'use': ({'clock': 'signal'}.get(use.group(1).lower(), use.group(1).lower()) if use else 'signal'),   # a clock pin is routed like any signal
                      'gate_area': float(ga.group(1)) if ga else 0.0, 'diff_area': float(da.group(1)) if da else 0.0}
    obs = []
    om = re.search(r'OBS(.*?)END\s*\n', txt, re.S)
    if om:
        for lay, geo in re.findall(r'LAYER (\S+) ;(.*?)(?=LAYER|$)', om.group(1), re.S):
            for poly in re.findall(r'POLYGON ([\d.\s-]+);', geo):
                v = [float(t) for t in poly.split()]
                obs.append((lay, list(zip(v[0::2], v[1::2]))))
            for rect in re.findall(r'RECT ([\d.\s-]+);', geo):
                x1, y1, x2, y2 = [float(t) for t in rect.split()]
                obs.append((lay, [(x1, y1), (x2, y1), (x2, y2), (x1, y2)]))
    return {'w': w, 'h': h, 'pins': pins, 'obs': obs}

def poly_to_rects(pts):
    """Decompose a Manhattan polygon into rectangles (horizontal slabs). Coordinates in um."""
    ys = sorted(set(y for _, y in pts))
    rects = []
    n = len(pts)
    edges = [(pts[i], pts[(i + 1) % n]) for i in range(n)]
    vert = [((x1, min(y1, y2), max(y1, y2))) for (x1, y1), (x2, y2) in edges if x1 == x2]
    for ya, yb in zip(ys[:-1], ys[1:]):
        ym = (ya + yb) / 2
        xs = sorted(x for x, lo, hi in vert if lo < ym < hi)
        for xa, xb in zip(xs[0::2], xs[1::2]):
            rects.append((xa, ya, xb, yb))
    # merge vertically adjacent slabs with identical x extents
    merged = []
    for r in sorted(rects, key=lambda r: (r[0], r[2], r[1])):
        if merged and merged[-1][0] == r[0] and merged[-1][2] == r[2] and abs(merged[-1][3] - r[1]) < 1e-9:
            merged[-1] = (r[0], merged[-1][1], r[2], r[3])
        else:
            merged.append(r)
    return merged

if __name__ == '__main__':
    import sys
    for c in sys.argv[1:] or ['inv_1', 'dffrnq_1', 'mux4_1', 'filltie', 'endcap']:
        L = read_lef(c)
        print(c, L['w'], L['h'], {p: [poly_to_rects(pp) for _, pp in v['polys']] for p, v in L['pins'].items() if v['use'] == 'signal'})

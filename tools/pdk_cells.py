#!/usr/bin/env python3
"""Rebuild pdk_cells/ (kept out of the repository) from a checkout of the GF180 standard-cell library.

  git clone --depth 1 https://github.com/google/globalfoundries-pdk-libs-gf180mcu_fd_sc_mcu7t5v0 <dir>
  python3 tools/pdk_cells.py <dir>

Writes  pdk_cells/cdl/<cell>.cdl       the library's own transistor netlists, copied unchanged
        pdk_cells/sim/cells_jx.spice   the same cells for simulation: every MOSFET as an X instance with
                                       junction geometry  ad = as = W x 0.5 um,  pd = ps = 2 x (W + 0.5 um)
"""
import shutil, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

def num(v):
    v = v.strip().lower()
    mult = {'u': 1e-6, 'n': 1e-9, 'p': 1e-12, 'f': 1e-15, 'm': 1e-3}
    return float(v[:-1]) * mult[v[-1]] if v[-1] in mult else float(v)

def jx(cdl_text):
    out = []
    for line in cdl_text.replace('\n+', ' ').splitlines():
        t = line.split()
        if not t or t[0].startswith('*'):
            continue
        if t[0].upper() == '.SUBCKT':
            out.append(' '.join(['.SUBCKT'] + t[1:]))
        elif t[0].upper() == '.ENDS':
            out.append('.ENDS')
        elif t[0][0] in 'Mm':
            prm = {k.upper(): num(v) for k, v in (x.split('=') for x in t[6:] if '=' in x)}
            w, l = prm['W'], prm['L']
            out.append(f'X{t[0][1:]} {t[1]} {t[2]} {t[3]} {t[4]} {t[5]} W={w:.4g} L={l:.4g} '
                       f'ad={w * 0.5e-6:.4g} as={w * 0.5e-6:.4g} pd={2 * (w + 0.5e-6):.4g} ps={2 * (w + 0.5e-6):.4g}')
        elif t[0][0] in 'Dd':
            out.append(f'{t[0].upper()} {t[1]} {t[2]} {t[3]} AREA={t[4]} PJ={t[5]} M=1')
    return '\n'.join(out)

def main(lib):
    cdl = ROOT / 'pdk_cells' / 'cdl'; sim = ROOT / 'pdk_cells' / 'sim'
    cdl.mkdir(parents=True, exist_ok=True); sim.mkdir(parents=True, exist_ok=True)
    blocks = []
    for f in sorted(Path(lib).glob('cells/*/gf180mcu_fd_sc_mcu7t5v0__*.cdl')):
        shutil.copy(f, cdl / f.name)
        blocks.append(jx(f.read_text()))
    (sim / 'cells_jx.spice').write_text('\n'.join(blocks) + '\n')
    print(f'{len(blocks)} cells -> {cdl} and {sim / "cells_jx.spice"}')

if __name__ == '__main__':
    main(sys.argv[1])

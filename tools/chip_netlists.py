#!/usr/bin/env python3
"""Write the two SPICE netlists of the whole tile that the layout checks read, from netlist/chip.cdl.

  layout/chip_sim.spice   pre-layout simulation netlist: the cell subcircuits of pdk_cells/sim/cells_jx.spice
                          (which carry junction areas) and the custom devices written as X instances
  layout/chip_lvs.spice   the same netlist under its LVS title: the reference netgen compares the layout with

Run from the repository root after tools/build_master.py:  python3 tools/chip_netlists.py
"""
import re
from pathlib import Path

CHIP = Path(__file__).resolve().parent.parent
TOP = 'tt_um_metastability_characterizer'

def sim_netlist():
    """Pre-layout simulation netlist of the whole tile: chip.cdl with PDK-simulation cell subcircuits
    (cells_jx.spice, which carry junction areas) and the custom devices written as X instances."""
    cdl = (CHIP / 'netlist' / 'chip.cdl').read_text()
    used = sorted(set(re.findall(r'^\.include \.\./pdk_cells/cdl/(\S+)\.cdl', cdl, re.M)))
    sim = (CHIP / 'pdk_cells' / 'sim' / 'cells_jx.spice').read_text().replace('\n+', ' ')
    cells = {}
    for m in re.finditer(r'^\.SUBCKT (\S+).*?^\.ENDS', sim, re.S | re.M):
        cells[m.group(1)] = m.group(0)
    out = ['* Pre-layout simulation netlist of ' + TOP + ' (generated; PDK cell subcircuits with junction geometry)']
    out += [cells[c] for c in used]
    for line in cdl.splitlines():
        if line.startswith('.include') or line.startswith('*'):
            continue
        m = re.match(r'(M\S+) (\S+) (\S+) (\S+) (\S+) (\S+) W=(\S+) L=(\S+)', line)
        if m:
            name, d, g, s, b, model, W, L = m.groups()
            W, L = float(W), float(L)
            ext = 0.5e-6
            out.append(f'X{name} {d} {g} {s} {b} {model} w={W:.4g} l={L:.4g} ad={W * ext:.4g} as={W * ext:.4g} '
                       f'pd={2 * (W + ext):.4g} ps={2 * (W + ext):.4g}')
        else:
            out.append(line)
    return '\n'.join(out) + '\n'

def lvs_netlist():
    return sim_netlist().replace('Pre-layout simulation netlist', 'LVS reference netlist')

if __name__ == '__main__':
    L = CHIP / 'layout'
    for name, text in (('chip_sim.spice', sim_netlist()), ('chip_lvs.spice', lvs_netlist())):
        (L / name).write_text(text)
        print(L / name, len(text.splitlines()), 'lines')

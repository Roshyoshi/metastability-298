#!/usr/bin/env python3
"""Write netlist/controller_synth.v: compact_control as a flat list of GF180 cells.

Yosys reads src/gf180/compact_control.v (which already instantiates one cell per part), and this
script writes the same 93 cells back out with plain instance and net names, in the form
tools/build_master.py parses. Run from the repository root:  python3 tools/controller_netlist.py
"""
import json, re, subprocess, sys
from collections import OrderedDict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
OUT = ROOT / 'netlist'
LIB = 'gf180mcu_fd_sc_mcu7t5v0__'
PORTS = ['clk20', 'rst_n', 'ena', 'start', 'q_selected', 'early_e', 'byte_sel', 'capture', 'busy', 'done', 'fault',
         'result_byte']
PIN_ORDER = ['D', 'RN', 'CLK', 'CLKN', 'I', 'I0', 'I1', 'S', 'A1', 'A2', 'Q', 'Z', 'ZN']

def inst_name(n):
    m = re.fullmatch(r'g_(n|k)\[(\d+)\]\.bit_(ff|inv)', n)
    if m:
        return f'{m.group(1)}{m.group(2)}_{m.group(3)}'
    m = re.fullmatch(r'g_byte\[(\d+)\]\.bit_mux', n)
    if m:
        return f'byte{m.group(1)}_mux'
    return n

def main():
    OUT.mkdir(exist_ok=True)
    js = OUT / 'compact_control.json'
    subprocess.run(['yosys', '-Q', '-q', '-p',
                    f'read_verilog -lib test/models/gf180_cells.v; read_verilog src/gf180/compact_control.v; '
                    f'hierarchy -check -top compact_control; proc; opt_clean; write_json {js}'], cwd=ROOT, check=True)
    mod = json.loads(js.read_text())['modules']['compact_control']
    js.unlink()
    name = {}
    def claim(netname, bits, offset=0):
        for i, b in enumerate(bits):
            name.setdefault(b, netname if len(bits) == 1 else f'{netname}[{i + offset}]')
    for p in PORTS:                                   # a port name wins over the internal name of the same wire
        claim(p, mod['ports'][p]['bits'])
    for n, nn in sorted(mod['netnames'].items(), key=lambda kv: (kv[1].get('hide_name', 0), len(kv[0]), kv[0])):
        if n in ('result_k', 'n_clkn', 'k16') or n in mod['ports']:
            continue
        claim(n, nn['bits'], nn.get('offset', 0))
    lines = ['// compact_control as a flat list of cells. Written by tools/controller_netlist.py from',
             '// src/gf180/compact_control.v. Do not edit by hand.',
             'module compact_control (' + ', '.join(PORTS) + ');']
    cells = OrderedDict((inst_name(n), c) for n, c in mod['cells'].items())
    for n, c in cells.items():
        conns = [(p, name[c['connections'][p][0]]) for p in PIN_ORDER if p in c['connections']]
        assert len(conns) == len(c['connections']), (n, c['connections'].keys())
        lines.append(f"  {c['type']} {n} ( " + ', '.join(f'.{p}({net})' for p, net in conns) + ' );')
    lines.append('endmodule')
    (OUT / 'controller_synth.v').write_text('\n'.join(lines) + '\n')
    print(f'{len(cells)} cells -> {OUT / "controller_synth.v"}')

if __name__ == '__main__':
    sys.exit(main())

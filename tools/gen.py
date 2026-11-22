"""Xschem symbols for the GF180 7-track cells we use, plus an inverter test bench."""
from pathlib import Path
HOME = '~/ece298a/xschem'
LIB = 'gf180mcu_fd_sc_mcu7t5v0'
CELLS = {  # name: (inputs, outputs)
    'inv_1': (['I'], ['ZN']), 'inv_2': (['I'], ['ZN']),
    'nand2_1': (['A1', 'A2'], ['ZN']), 'nand2_2': (['A1', 'A2'], ['ZN']), 'nand2_4': (['A1', 'A2'], ['ZN']),
    'dffq_1': (['D', 'CLK'], ['Q']),
    'mux4_1': (['I0', 'I1', 'I2', 'I3', 'S0', 'S1'], ['Z']),
}
def sym(name, ins, outs):
    n = max(len(ins), len(outs)); h = 20 * n + 20; top = -h // 2
    order = ins + outs
    fmt = '@name ' + ' '.join('@@' + p for p in order) + f' VDD VDD 0 0 {LIB}__{name}'
    L = ['v {xschem version=3.4.4 file_version=1.2}', 'G {}',
         'K {type=primitive', f'format="{fmt}"', 'template="name=x1"', '}', 'V {}', 'S {}', 'E {}',
         f'L 4 -30 {top} 30 {top} {{}}', f'L 4 -30 {top+h} 30 {top+h} {{}}',
         f'L 4 -30 {top} -30 {top+h} {{}}', f'L 4 30 {top} 30 {top+h} {{}}']
    for i, p in enumerate(ins):
        y = top + 20 + 20 * i
        L += [f'L 4 -50 {y} -30 {y} {{}}', f'B 5 -52.5 {y-2.5} -47.5 {y+2.5} {{name={p} dir=in}}',
              f'T {{{p}}} -27 {y-6} 0 0 0.15 0.15 {{}}']
    for i, p in enumerate(outs):
        y = top + 20 + 20 * i
        L += [f'L 4 30 {y} 50 {y} {{}}', f'B 5 47.5 {y-2.5} 52.5 {y+2.5} {{name={p} dir=out}}',
              f'T {{{p}}} 27 {y-6} 0 1 0.15 0.15 {{}}']
    L += [f'T {{{name}}} -28 {top-16} 0 0 0.2 0.2 {{}}', f'T {{@name}} -28 {top+h+4} 0 0 0.15 0.15 {{}}']
    return '\n'.join(L) + '\n'
for c, (i, o) in CELLS.items():
    Path(f'cells/{c}.sym').write_text(sym(c, i, o))
PDK = '/usr/local/share/pdk/gf180mcuD'
code = (f'.include {PDK}/libs.tech/ngspice/design.ngspice\n'
        f'.lib {PDK}/libs.tech/ngspice/sm141064.ngspice typical\n'
        f'.include {PDK}/libs.ref/{LIB}/spice/{LIB}.spice\n'
        '.control\n'
        'dc Vin 0 3.3 0.005\n'
        'meas dc switch_point find v(in) when v(out)=v(in)\n'
        'plot v(out) v(in)\n'
        '.endc')
tb = f'''v {{xschem version=3.4.4 file_version=1.2}}
G {{}}
K {{}}
V {{}}
S {{}}
E {{}}
T {{inv_1 transfer curve: expect switch_point = 1.39 V (our reference simulation)}} 0 120 0 0 0.3 0.3 {{}}
C {{devices/vsource.sym}} 100 300 0 0 {{name=Vdd value=3.3}}
C {{devices/lab_pin.sym}} 100 270 0 0 {{name=p1 lab=VDD}}
C {{devices/gnd.sym}} 100 330 0 0 {{name=l1 lab=0}}
C {{devices/vsource.sym}} 220 300 0 0 {{name=Vin value=0}}
C {{devices/lab_pin.sym}} 220 270 0 0 {{name=p2 lab=in}}
C {{devices/gnd.sym}} 220 330 0 0 {{name=l2 lab=0}}
C {{{HOME}/cells/inv_1.sym}} 400 300 0 0 {{name=x1}}
C {{devices/lab_pin.sym}} 350 300 0 0 {{name=p3 lab=in}}
C {{devices/lab_pin.sym}} 450 300 0 0 {{name=p4 lab=out}}
C {{devices/code_shown.sym}} 560 160 0 0 {{name=s1 only_toplevel=false value="{code}"}}
'''
Path('tb_inv_vtc.sch').write_text(tb)

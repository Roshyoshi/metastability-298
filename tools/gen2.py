"""Task 2 schematics: NAND flip-flops (3 variants), delay line, DUT and front-end test benches."""
from pathlib import Path
H = '~/ece298a/xschem'
C = H + '/cells'
PDK = '/usr/local/share/pdk/gf180mcuD'
LIB = 'gf180mcu_fd_sc_mcu7t5v0'
HEAD = 'v {xschem version=3.4.4 file_version=1.2}\nG {}\nK {}\nV {}\nS {}\nE {}\n'
PIN = {'inv': {'I': (-50, 0), 'ZN': (50, 0)}, 'nand2': {'A1': (-50, -10), 'A2': (-50, 10), 'ZN': (50, -10)},
       'dffq': {'D': (-50, -10), 'CLK': (-50, 10), 'Q': (50, -10)},
       'mux4': {'I0': (-50, -50), 'I1': (-50, -30), 'I2': (-50, -10), 'I3': (-50, 10), 'S0': (-50, 30), 'S1': (-50, 50), 'Z': (50, -50)},
       'ff': {'d': (-50, -10), 'cap': (-50, 10), 'q': (50, -10)},
       'dly': {'launch': (-50, -10), 'control': (-50, 10), 'sample_clk': (50, -10)}}
class Sch:
    def __init__(s): s.L = []; s.k = 0
    def inst(s, sym, x, y, name, kind, nets, extra=''):
        s.L.append(f'C {{{sym}}} {x} {y} 0 0 {{name={name}{(" " + extra) if extra else ""}}}')
        for pin, net in nets.items():
            dx, dy = PIN[kind][pin]; s.k += 1
            s.L.append(f'C {{devices/lab_pin.sym}} {x+dx} {y+dy} 0 {0 if dx < 0 else 1} {{name=l{s.k} lab={net}}}')
    def raw(s, line): s.L.append(line)
    def text(s, t, x, y, size=0.3): s.L.append(f'T {{{t}}} {x} {y} 0 0 {size} {size} {{}}')
    def port(s, kind, net, x, y): s.k += 1; s.L.append(f'C {{devices/{kind}.sym}} {x} {y} 0 0 {{name=p{s.k} lab={net}}}')
    def vsrc(s, name, pos, value, x, y):
        s.L.append(f'C {{devices/vsource.sym}} {x} {y} 0 0 {{name={name} value="{value}"}}'); s.k += 1
        s.L.append(f'C {{devices/lab_pin.sym}} {x} {y-30} 0 0 {{name=l{s.k} lab={pos}}}'); s.k += 1
        s.L.append(f'C {{devices/gnd.sym}} {x} {y+30} 0 0 {{name=l{s.k} lab=0}}')
    def code(s, text, x, y): s.k += 1; s.L.append(f'C {{devices/code_shown.sym}} {x} {y} 0 0 {{name=s{s.k} only_toplevel=false value="{text}"}}')
    def write(s, path): Path(path).write_text(HEAD + '\n'.join(s.L) + '\n')

def box_sym(path, pins_in, pins_out, title, kind_attrs):
    n = max(len(pins_in), len(pins_out)); h = 20 * n + 20; top = -h // 2
    L = ['v {xschem version=3.4.4 file_version=1.2}', 'G {}', 'K {' + kind_attrs + '}', 'V {}', 'S {}', 'E {}',
         f'L 4 -30 {top} 30 {top} {{}}', f'L 4 -30 {top+h} 30 {top+h} {{}}', f'L 4 -30 {top} -30 {top+h} {{}}', f'L 4 30 {top} 30 {top+h} {{}}']
    for i, p in enumerate(pins_in):
        y = top + 20 + 20 * i
        L += [f'L 4 -50 {y} -30 {y} {{}}', f'B 5 -52.5 {y-2.5} -47.5 {y+2.5} {{name={p} dir=in}}', f'T {{{p}}} -27 {y-6} 0 0 0.15 0.15 {{}}']
    for i, p in enumerate(pins_out):
        y = top + 20 + 20 * i
        L += [f'L 4 30 {y} 50 {y} {{}}', f'B 5 47.5 {y-2.5} 52.5 {y+2.5} {{name={p} dir=out}}', f'T {{{p}}} 27 {y-6} 0 1 0.15 0.15 {{}}']
    L += [f'T {{{title}}} -28 {top-16} 0 0 0.2 0.2 {{}}', f'T {{@name}} -28 {top+h+4} 0 0 0.15 0.15 {{}}']
    Path(path).write_text('\n'.join(L) + '\n')

PIN['cap'] = {'p': (0, -30), 'm': (0, 30)}
# --- NAND flip-flops: same drawing, two gate sizes differ
for var, fw, kp in [('base', 'nand2_2', 'nand2_1'), ('keeper', 'nand2_2', 'nand2_2'), ('forward', 'nand2_4', 'nand2_1')]:
    name = f'nand_ff_{var}'
    box_sym(f'{name}.sym', ['d', 'cap'], ['q'], name, 'type=subcircuit\nformat="@name @pinlist @symname"\ntemplate="name=x1"\n')
    s = Sch()
    s.text(f'{name}: NAND master-slave flip-flop (forward {fw}, keeper {kp}). Feedback on pin A1.', 0, -120, 0.4)
    s.port('ipin', 'd', 0, 0); s.port('ipin', 'cap', 0, 60); s.port('opin', 'q', 1100, 0)
    s.text('master door', 160, -60); s.text('master latch (measured)', 360, -60); s.text('slave door', 600, -60); s.text('slave latch', 820, -60)
    s.inst(f'{C}/inv_1.sym', 100, 300, 'xci', 'inv', {'I': 'cap', 'ZN': 'cn'})
    s.inst(f'{C}/nand2_1.sym', 200, 50, 'xg1', 'nand2', {'A1': 'd', 'A2': 'cn', 'ZN': 'g1'})
    s.inst(f'{C}/nand2_1.sym', 200, 200, 'xg2', 'nand2', {'A1': 'g1', 'A2': 'cn', 'ZN': 'g2'})
    s.inst(f'{C}/{fw}.sym', 420, 50, 'xfw', 'nand2', {'A1': 'mqb', 'A2': 'g1', 'ZN': 'mq'})
    s.inst(f'{C}/{kp}.sym', 420, 200, 'xkp', 'nand2', {'A1': 'mq', 'A2': 'g2', 'ZN': 'mqb'})
    s.inst(f'{C}/nand2_1.sym', 640, 50, 'xs1', 'nand2', {'A1': 'mq', 'A2': 'cap', 'ZN': 's1'})
    s.inst(f'{C}/nand2_1.sym', 640, 200, 'xs2', 'nand2', {'A1': 's1', 'A2': 'cap', 'ZN': 's2'})
    s.inst(f'{C}/nand2_1.sym', 860, 50, 'xsq', 'nand2', {'A1': 'sqb', 'A2': 's1', 'ZN': 'q'})
    s.inst(f'{C}/nand2_1.sym', 860, 200, 'xsqb', 'nand2', {'A1': 'q', 'A2': 's2', 'ZN': 'sqb'})
    s.text('estimated wiring: 0.25 fF per master node, 0.05 fF between them', 360, 330, 0.25)
    s.inst('devices/capa.sym', 380, 420, 'Cmq', 'cap', {'p': 'mq', 'm': '0'}, 'value=0.25f m=1')
    s.inst('devices/capa.sym', 460, 420, 'Cmqb', 'cap', {'p': 'mqb', 'm': '0'}, 'value=0.25f m=1')
    s.inst('devices/capa.sym', 540, 420, 'Cmut', 'cap', {'p': 'mq', 'm': 'mqb'}, 'value=0.05f m=1')
    s.write(f'{name}.sch')

# --- analog delay line (transistor level in its own netlist block for now)
DLY = ('.subckt delay_analog launch control sample_clk\n'
       'xmp slow launch VDD VDD pfet_06v0 w=1.22u l=0.5u ad=0.61p as=0.61p pd=3.44u ps=3.44u\n'
       'xmn slow launch foot 0 nfet_06v0 w=0.82u l=0.6u ad=0.41p as=0.41p pd=2.64u ps=2.64u\n'
       'xmc foot control 0 0 nfet_06v0 w=0.36u l=0.6u ad=0.18p as=0.18p pd=1.72u ps=1.72u\n'
       'ctiming slow 0 2f\n'
       f'xr0 slow r0 VDD VDD 0 0 {LIB}__inv_1\n'
       f'xr1 r0 r1 VDD VDD 0 0 {LIB}__inv_2\n'
       f'xr2 r1 sample_clk VDD VDD 0 0 {LIB}__inv_2\n'
       '.ends')
box_sym('delay_analog.sym', ['launch', 'control'], ['sample_clk'], 'delay_analog', 'type=subcircuit\nformat="@name @pinlist @symname"\ntemplate="name=xdly"\n')
SYM = PDK + '/libs.tech/xschem/symbols'
PIN['nfet'] = {'D': (20, -30), 'G': (-20, 0), 'S': (20, 30), 'B': (20, 0)}
PIN['pfet'] = {'S': (20, -30), 'G': (-20, 0), 'D': (20, 30), 'B': (20, 0)}
PIN['cap'] = {'p': (0, -30), 'm': (0, 30)}
def mos(s, kind, x, y, name, nets, W, L, ad, pd):
    model = 'nfet_05v0' if kind == 'nfet' else 'pfet_05v0'
    s.inst(f'{SYM}/{kind}_06v0.sym', x, y, name, kind, nets,
           f'L={L} W={W} nf=1 m=1 ad={ad} as={ad} pd={pd} ps={pd} nrd=0 nrs=0 sa=0 sb=0 sd=0 model={model} spiceprefix=X')
d = Sch()
d.text('delay_analog: current-starved inverter + 3 restoring inverters. Lower control voltage = less current = longer delay.', 0, -120, 0.35)
d.port('ipin', 'launch', 0, 0); d.port('ipin', 'control', 0, 60); d.port('opin', 'sample_clk', 900, 0)
mos(d, 'pfet', 200, 100, 'MP', {'S': 'VDD', 'G': 'launch', 'D': 'slow', 'B': 'VDD'}, '1.22u', '0.5u', '0.61p', '3.44u')
mos(d, 'nfet', 200, 220, 'MN', {'D': 'slow', 'G': 'launch', 'S': 'foot', 'B': '0'}, '0.82u', '0.6u', '0.41p', '2.64u')
mos(d, 'nfet', 200, 340, 'MC', {'D': 'foot', 'G': 'control', 'S': '0', 'B': '0'}, '0.36u', '0.6u', '0.18p', '1.72u')
d.inst('devices/capa.sym', 350, 200, 'Ctiming', 'cap', {'p': 'slow', 'm': '0'}, 'value=2f m=1')
d.inst(f'{C}/inv_1.sym', 500, 150, 'xr0', 'inv', {'I': 'slow', 'ZN': 'r0'})
d.inst(f'{C}/inv_2.sym', 620, 150, 'xr1', 'inv', {'I': 'r0', 'ZN': 'r1'})
d.inst(f'{C}/inv_2.sym', 740, 150, 'xr2', 'inv', {'I': 'r1', 'ZN': 'sample_clk'})
d.write('delay_analog.sch')
MODELS = (f'.include {PDK}/libs.tech/ngspice/design.ngspice\n'
          f'.lib {PDK}/libs.tech/ngspice/sm141064.ngspice typical\n'
          f'.include {H}/cells_jx.spice\n.global VDD\n'
          '.param sw_stat_global=0 sw_stat_mismatch=0\n')

def frontend(s, x0=0, y0=0):
    s.inst(f'{C}/inv_2.sym', 100, 300, 'xcin0', 'inv', {'I': 'clk', 'ZN': 'c0'})
    s.inst(f'{C}/inv_2.sym', 220, 300, 'xcin1', 'inv', {'I': 'c0', 'ZN': 'cap'})
    s.inst(f'{C}/inv_2.sym', 100, 100, 'xdin0', 'inv', {'I': 'd', 'ZN': 'd0'})
    s.inst(f'{C}/inv_2.sym', 220, 100, 'xdin1', 'inv', {'I': 'd0', 'ZN': 'data'})
    s.inst(f'{C}/dffq_1.sym', 420, 0, 'xlib', 'dffq', {'D': 'data', 'CLK': 'cap', 'Q': 'q0'})
    for i, v in enumerate(['base', 'keeper', 'forward'], 1):
        s.inst(f'{H}/nand_ff_{v}.sym', 420, 100 * i, f'x{v}', 'ff', {'d': 'data', 'cap': 'cap', 'q': f'q{i}'})
    s.inst(f'{C}/mux4_1.sym', 650, 150, 'xselect', 'mux4', {'I0': 'q0', 'I1': 'q1', 'I2': 'q2', 'I3': 'q3', 'S0': 's0', 'S1': 's1', 'Z': 'selected'})
    s.inst(f'{C}/inv_1.sym', 420, 500, 'xiso0', 'inv', {'I': 'cap', 'ZN': 'capb'})
    s.inst(f'{C}/inv_2.sym', 540, 500, 'xiso1', 'inv', {'I': 'capb', 'ZN': 'capd'})
    s.inst(f'{H}/delay_analog.sym', 700, 500, 'xdly', 'dly', {'launch': 'capd', 'control': 'control', 'sample_clk': 'eclk'})
    s.inst(f'{C}/dffq_1.sym', 880, 150, 'xearly', 'dffq', {'D': 'selected', 'CLK': 'eclk', 'Q': 'early'})

CLK = 'PWL(0 0 1n 0 1.05n 3.3 2n 3.3 2.05n 0 5n 0 5.05n 3.3)'
# --- DUT test bench: harmless capture, clock-to-Q of all four flip-flops
s = Sch()
s.text('tb_duts: data rises 2 ns before the capture edge at 5 ns. All four q must go to 1; tcq = capture edge to q.', 0, -200, 0.4)
s.vsrc('vvdd', 'VDD', '3.3', -300, 0); s.vsrc('vclk', 'clk', CLK, -200, 0); s.vsrc('vd', 'd', 'PWL(0 0 2.975n 0 3.025n 3.3)', -100, 0)
s.inst(f'{C}/inv_2.sym', 100, 300, 'xcin0', 'inv', {'I': 'clk', 'ZN': 'c0'}); s.inst(f'{C}/inv_2.sym', 220, 300, 'xcin1', 'inv', {'I': 'c0', 'ZN': 'cap'})
s.inst(f'{C}/inv_2.sym', 100, 100, 'xdin0', 'inv', {'I': 'd', 'ZN': 'd0'}); s.inst(f'{C}/inv_2.sym', 220, 100, 'xdin1', 'inv', {'I': 'd0', 'ZN': 'data'})
s.inst(f'{C}/dffq_1.sym', 420, 0, 'xlib', 'dffq', {'D': 'data', 'CLK': 'cap', 'Q': 'q0'})
for i, v in enumerate(['base', 'keeper', 'forward'], 1):
    s.inst(f'{H}/nand_ff_{v}.sym', 420, 100 * i, f'x{v}', 'ff', {'d': 'data', 'cap': 'cap', 'q': f'q{i}'})
for i in range(4):
    s.inst('devices/capa.sym', 640, 100 * i, f'Cq{i}', 'cap', {'p': f'q{i}', 'm': '0'}, 'value=2f m=1')
meas = '\n'.join(f'meas tran tcq{i} trig v(cap) val=1.65 td=4n rise=1 targ v(q{i}) val=1.65 td=4n rise=1' for i in range(4))
s.code(MODELS + '.control\ntran 1p 8n\n' + meas + '\nplot v(cap) v(q0) v(q1) v(q2) v(q3)\n.endc', 700, -150)
s.write('tb_duts.sch')
# --- front-end test bench: the false-event bug and its fix
s = Sch()
s.text('tb_frontend: harmless capture on DUT 1. Run 1: ua[0] = 3.0 V, early look before the output arrives (expect early not equal final: a false event). Run 2: 1.41 V, allowed delay (expect early = final).', 0, -200, 0.4)
s.vsrc('vvdd', 'VDD', '3.3', -400, 0); s.vsrc('vclk', 'clk', CLK, -300, 0); s.vsrc('vd', 'd', 'PWL(0 0 2.975n 0 3.025n 3.3)', -200, 0)
s.vsrc('vs0', 's0', '3.3', -400, 200); s.vsrc('vs1', 's1', '0', -300, 200); s.vsrc('vbias', 'pad', '3.0', -200, 200)
frontend(s)
ctl = ('ranalog pad control 500\ncanalog control 0 5p\n.control\n'
       'tran 2p 14n\nmeas tran d_short trig v(cap) val=1.65 td=4n rise=1 targ v(eclk) val=1.65 td=4n rise=1\n'
       'meas tran arrive trig v(cap) val=1.65 td=4n rise=1 targ v(selected) val=1.65 td=4n rise=1\n'
       'meas tran early_short find v(early) at=13.9n\nmeas tran final_short find v(selected) at=13.9n\n'
       'alter vbias 1.41171875\ntran 2p 14n\nmeas tran d_allowed trig v(cap) val=1.65 td=4n rise=1 targ v(eclk) val=1.65 td=4n rise=1\n'
       'meas tran early_allowed find v(early) at=13.9n\nmeas tran final_allowed find v(selected) at=13.9n\n'
       'plot v(cap) v(selected) v(eclk) v(early)\n.endc')
s.code(MODELS + ctl, 1050, -150)
s.write('tb_frontend.sch')
print('ok')

# --- delay line test bench: delay vs control voltage (TT)
s = Sch()
s.text('tb_delay: early-look delay (capture edge -> eclk) vs the ua[0] control voltage, through the isolation buffer as on the chip.', 0, -200, 0.4)
s.vsrc('vvdd', 'VDD', '3.3', -300, 0); s.vsrc('vclk', 'clk', CLK, -200, 0); s.vsrc('vbias', 'pad', '1.41', -100, 0)
s.inst(f'{C}/inv_2.sym', 100, 300, 'xcin0', 'inv', {'I': 'clk', 'ZN': 'c0'}); s.inst(f'{C}/inv_2.sym', 220, 300, 'xcin1', 'inv', {'I': 'c0', 'ZN': 'cap'})
s.inst(f'{C}/inv_1.sym', 420, 300, 'xiso0', 'inv', {'I': 'cap', 'ZN': 'capb'}); s.inst(f'{C}/inv_2.sym', 540, 300, 'xiso1', 'inv', {'I': 'capb', 'ZN': 'capd'})
s.inst(f'{H}/delay_analog.sym', 700, 300, 'xdly', 'dly', {'launch': 'capd', 'control': 'control', 'sample_clk': 'eclk'})
s.inst(f'{C}/dffq_1.sym', 900, 300, 'xload', 'dffq', {'D': '0', 'CLK': 'eclk', 'Q': 'qload'})
dl = ('ranalog pad control 500\ncanalog control 0 5p\n.control\n'
      'foreach b 1.1 1.3 1.5 1.8 2.4 3.0\nalter vbias $b\ntran 5p 14n\n'
      'meas tran delay trig v(cap) val=1.65 td=4n rise=1 targ v(eclk) val=1.65 td=4n rise=1\necho control_V $b\nend\n.endc')
s.code(MODELS + dl, 1000, -150)
s.write('tb_delay.sch')

# --- tau test bench: start each master latch slightly off its balance point
VM = 1.442142
s = Sch()
s.text('tb_tau: each master latch starts a small gap (1 mV or 10 uV) from its balance point (1.442142 V); clock held high.', 0, -200, 0.4)
s.text('Each 100x smaller start adds tau*ln(100) to the decision time, so tau = (t1 - t0)/ln(100).', 0, -170, 0.4)
s.vsrc('vvdd', 'VDD', '3.3', -300, 0)
ics, ms = [], []
for i, v in enumerate(['base', 'keeper', 'forward']):
    for j, dv in enumerate([1e-3, 1e-5]):
        n = f'x{v}{j}'
        s.inst(f'{H}/nand_ff_{v}.sym', 200 + 300 * j, 120 * i, n, 'ff', {'d': '0', 'cap': 'VDD', 'q': f'q{v}{j}'})
        s.inst(f'{C}/inv_1.sym', 200 + 300 * j + 120, 120 * i + 60, f'xo{v}{j}', 'inv', {'I': f'q{v}{j}', 'ZN': f'qo{v}{j}'})
        s.inst('devices/capa.sym', 200 + 300 * j + 90, 120 * i + 60, f'Cq{v}{j}', 'cap', {'p': f'q{v}{j}', 'm': '0'}, 'value=2f m=1')
        ics.append(f'v({n}.mq)={VM + dv / 2:.10g} v({n}.mqb)={VM - dv / 2:.10g}')
        ms.append(f'meas tran t_{v}{j} when v({n}.mq)=2.5 cross=1')
taus = '\n'.join(f'let tau_{v}=(t_{v}1-t_{v}0)/ln(100)' for v in ['base', 'keeper', 'forward'])
tc = ('.options method=gear reltol=1e-6 abstol=1e-12 vntol=1e-12 chgtol=1e-14 trtol=1\n.ic ' + ' '.join(ics) +
      '\n.control\ntran 1p 3n\n' + '\n'.join(ms) + '\n' + taus + '\nprint tau_base tau_keeper tau_forward\n'
      'plot v(xbase1.mq) v(xbase1.mqb) v(xkeeper1.mq) v(xkeeper1.mqb) v(xforward1.mq) v(xforward1.mqb)\n.endc')
s.code(MODELS + tc, 900, -150)
s.write('tb_tau.sch')
print('ok2')

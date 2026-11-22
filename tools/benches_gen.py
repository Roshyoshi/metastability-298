#!/usr/bin/env python3
"""Round-2 simulation benches, built on the round-1 Xschem hierarchy (blocks/*.sym, cells at transistor level).

Each bench prints lines 'RESULT <name> <value>' and writes waveform files with wrdata, so run_round2.sh can
collect everything. Expected values come from the earlier verified simulations (same devices, same
junction geometry) or, for the controller, from the logic simulation of src/gf180/compact_control.v with the
same inputs (make check-control uses the same cells with 1 ns stand-in delays).
"""
import sys, json
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
from xschem_gen import Scene, ROOT, HEAD, box_pins

PDK = '/usr/local/share/pdk/gf180mcuD'
MODELS = (f'.include {PDK}/libs.tech/ngspice/design.ngspice\n'
          f'.lib {PDK}/libs.tech/ngspice/sm141064.ngspice typical\n'
          f'.lib {PDK}/libs.tech/ngspice/sm141064.ngspice diode_typical\n'
          '.global VDD\n'
          '.param sw_stat_global=0 sw_stat_mismatch=0\n')

class Bench(Scene):
    def vsrc(self, name, pos, value, x, y):
        self.inst('devices/vsource.sym', x, y, f'name={name} value="{value}"', ('vsrc',))
        self.lab(x, y - 30, pos, right=False)
        self.inst('devices/gnd.sym', x, y + 30, f'name=g{name}', ('gnd',))
    def block(self, sym, x, y, name, pins_in, pins_out, nets, w=None):
        pos, h, top = box_pins(pins_in, pins_out)
        w = w or (30 if max([len(p) for p in pins_in + pins_out] + [1]) < 6 else 60)
        self.inst(sym, x, y, f'name={name}', ('box', 'block', sym.split('/')[-1][:-4], pins_in, pins_out, w, name))
        for p in pins_in + pins_out:
            px, py = pos[p]
            px = px - (w - 30) if px < 0 else px + (w - 30)
            self.lab(x + px, y + py, nets.get(p, p), right=px > 0)
    def cap(self, name, a, b, value, x, y):
        self.inst('devices/capa.sym', x, y, f'name={name} value={value} m=1', ('cap', value))
        self.lab(x, y - 30, a, right=False); self.lab(x, y + 30, b, right=False)
    def code(self, text, x, y):
        self.inst('devices/code_shown.sym', x, y, f'name=SIM only_toplevel=false value="{text}"', ('code',))

def sym(kind, name):
    return f'{ROOT}/{kind}/{name}.sym'

DUT = {'pins_in': ['d', 'clk'], 'pins_out': ['q']}
CELL_IO = {'inv_1': (['I'], ['ZN']), 'inv_2': (['I'], ['ZN']), 'nand2_1': (['A1', 'A2'], ['ZN']),
           'dffq_1': (['D', 'CLK'], ['Q']), 'mux4_1': (['I0', 'I1', 'I2', 'I3', 'S0', 'S1'], ['Z'])}

def ports_of(blockname):
    """Read the pin order of a generated block symbol (ins, outs)."""
    txt = (KIT / 'blocks' / f'{blockname}.sym').read_text()
    ins, outs = [], []
    for line in txt.splitlines():
        if line.startswith('B 5'):
            name = line.split('name=')[1].split()[0].rstrip('}')
            (ins if 'dir=in' in line else outs).append(name)
    return ins, outs

BENCHES = {}
EXPECT = {}

def bench(name, title, expect):
    def deco(f):
        BENCHES[name] = (title, f)
        EXPECT[name] = expect
        return f
    return deco

@bench('tb_inv_balance', 'Balance point: inv_1 and nand2_1 (A2 high) transfer curves',
       {'inv1_switch_V': '1.39 (earlier inv_1 reference)', 'nand2_switch_V': 'about 1.44 (master-latch balance 1.442 V)'})
def tb_inv_balance(b):
    b.vsrc('vvdd', 'VDD', '3.3', -200, 0)
    b.vsrc('vin', 'vin', '0', -80, 0)
    b.inst(sym('cells_tx', 'inv_1'), 200, 0, 'name=xinv', ('box', 'cell', 'inv_1', ['I'], ['ZN'], 30, 'xinv'))
    b.lab(150, 0, 'vin', False); b.lab(250, 0, 'vout_inv', True)
    b.inst(sym('cells_tx', 'nand2_1'), 200, 150, 'name=xnand', ('box', 'cell', 'nand2_1', ['A1', 'A2'], ['ZN'], 30, 'xnand'))
    b.lab(150, 140, 'vin', False); b.lab(150, 160, 'VDD', False); b.lab(250, 140, 'vout_nand', True)
    b.code(MODELS + '.control\n'
           'set filetype=ascii\n'
           'dc vin 0 3.3 0.001\n'
           'meas dc sw_inv find v(vin) when v(vout_inv)=v(vin)\n'
           'meas dc sw_nand find v(vin) when v(vout_nand)=v(vin)\n'
           'echo RESULT inv1_switch_V $&sw_inv\n'
           'echo RESULT nand2_switch_V $&sw_nand\n'
           'wrdata tb_inv_balance.dat v(vout_inv) v(vout_nand)\n'
           '.endc', 420, -150)

@bench('tb_tau', 'Resolution time constant of the three master latches (two starts, 1 mV and 10 uV)',
       {'tau_base_ps': 88.9, 'tau_keeper_ps': 80.5, 'tau_forward_ps': 102.3})
def tb_tau(b):
    VM = 1.442142
    b.vsrc('vvdd', 'VDD', '3.3', -200, 0)
    ics, ms = [], []
    for i, v in enumerate(['baseline', 'keeper', 'forward']):
        for j, dv in enumerate([1e-3, 1e-5]):
            n = f'x{v}{j}'
            b.block(sym('blocks', f'meta_dut_{v}'), 200 + 360 * j, 160 * i, n, ['d', 'clk'], ['q'], {'d': '0', 'clk': 'VDD', 'q': f'q{v}{j}'})
            b.inst(sym('cells_tx', 'inv_1'), 200 + 360 * j + 140, 160 * i, f'name=xo{v}{j}', ('box', 'cell', 'inv_1', ['I'], ['ZN'], 30, f'xo{v}{j}'))
            b.lab(200 + 360 * j + 90, 160 * i, f'q{v}{j}', False); b.lab(200 + 360 * j + 190, 160 * i, f'qo{v}{j}', True)
            b.cap(f'cq{v}{j}', f'q{v}{j}', '0', '2f', 200 + 360 * j + 110, 160 * i + 70)
            ics.append(f'v({n}.mq)={VM + dv / 2:.10g} v({n}.mqb)={VM - dv / 2:.10g}')
            ms.append(f'meas tran t_{v}{j} when v({n}.mq)=2.5 cross=1')
    code = (MODELS + '.options method=gear reltol=1e-6 abstol=1e-12 vntol=1e-12 chgtol=1e-14 trtol=1\n'
            '.ic ' + ' '.join(ics) + '\n.control\nset filetype=ascii\ntran 1p 3n\n' + '\n'.join(ms) + '\n' +
            '\n'.join(f'let tau_{v}=(t_{v}1-t_{v}0)/ln(100)*1e12\necho RESULT tau_{"base" if v == "baseline" else v}_ps $&tau_{v}'
                      for v in ['baseline', 'keeper', 'forward']) +
            '\nwrdata tb_tau.dat v(xbaseline1.mq) v(xbaseline1.mqb) v(xkeeper1.mq) v(xkeeper1.mqb) v(xforward1.mq) v(xforward1.mqb)\n.endc')
    b.code(code, 1000, -150)

TB_CLK = 'PWL(0 0 1n 0 1.05n 3.3 2n 3.3 2.05n 0 5n 0 5.05n 3.3)'

@bench('tb_duts', 'Capture check and clock-to-output delay of all four flip-flops',
       {'tcq_lib_ps': 712, 'tcq_base_ps': 406, 'tcq_keeper_ps': 406, 'tcq_forward_ps': 405})
def tb_duts(b):
    b.vsrc('vvdd', 'VDD', '3.3', -300, 0)
    b.vsrc('vcap', 'capture', TB_CLK, -180, 0)
    b.vsrc('vd', 'ui_in_6', 'PWL(0 0 2.975n 0 3.025n 3.3)', -60, 0)
    di, do = ports_of('data_input'); ci, co = ports_of('capture_drivers'); ui, uo = ports_of('duts')
    b.block(sym('blocks', 'data_input'), 200, 0, 'xdata', di, do, {})
    b.block(sym('blocks', 'capture_drivers'), 200, 120, 'xcapd', ci, co, {})
    b.block(sym('blocks', 'duts'), 520, 60, 'xduts', ui, uo, {})
    for k in range(4):
        b.cap(f'cl{k}', f'q_{k}', '0', '2f', 760 + 70 * k, 220)  # 2 fF output load, as in the reported bench
    names = ['lib', 'base', 'keeper', 'forward']
    code = (MODELS + '.control\nset filetype=ascii\ntran 1p 8n\n' +
            '\n'.join(f'meas tran tcq{k} trig v(capture_local) val=1.65 td=4n rise=1 targ v(q_{k}) val=1.65 td=4n rise=1\n'
                      f'let tcq{k}ps=tcq{k}*1e12\necho RESULT tcq_{names[k]}_ps $&tcq{k}ps' for k in range(4)) +
            '\nwrdata tb_duts.dat v(capture_local) v(data_local) v(q_0) v(q_1) v(q_2) v(q_3)\n.endc')
    b.code(code, 1000, -150)

IDEAL_D = {1.1: 2.244, 1.3: 1.601, 1.5: 1.279, 1.8: 1.026, 2.4: 0.816, 3.0: 0.741}

@bench('tb_delay', 'Delay d versus ua[0]: the layout delay line (MCT gate capacitor) and an ideal-2 fF copy',
       {**{f'd_ideal_ns_at_ua0 {v}': d for v, d in IDEAL_D.items()},
        **{f'd_ns_at_ua0 {v}': f'within about 10% of {d}' for v, d in IDEAL_D.items()}})
def tb_delay(b):
    b.vsrc('vvdd', 'VDD', '3.3', -300, 0)
    b.vsrc('vcap', 'capture', TB_CLK, -180, 0)
    b.vsrc('vbias', 'ua_0', '3.0', -60, 0)
    ci, co = ports_of('capture_drivers'); li, lo = ports_of('delay'); ei, eo = ports_of('early_observer')
    b.block(sym('blocks', 'capture_drivers'), 200, 0, 'xcapd', ci, co, {})
    b.block(sym('blocks', 'delay'), 480, 0, 'xdelay', li, lo, {})
    b.block(sym('blocks', 'early_observer'), 760, 0, 'xearly', ei, eo, {'selected_q': '0'})
    # reference copy with the ideal 2 fF capacitor of the pre-layout design (same devices, same junction geometry),
    # driven by its own isolation buffer and loaded by its own early-observer flip-flop
    ideal = ('* ideal-capacitor reference copy of the delay line\n'
             'xri0 capture_local isob_r inv_1\nxri1 isob_r iso_r inv_2\n'
             'xmp_r slow_r iso_r VDD VDD pfet_05v0 w=1.22u l=0.5u ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06\n'
             'xmn_r slow_r iso_r foot_r 0 nfet_05v0 w=0.82u l=0.6u ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06\n'
             'xmc_r foot_r ua_0 0 0 nfet_05v0 w=0.36u l=0.6u ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06\n'
             'cct_r slow_r 0 2f\n'
             'xrr0 slow_r r0_r inv_1\nxrr1 r0_r r1_r inv_2\nxrr2 r1_r early_r inv_2\n'
             'xer 0 early_r q_r dffq_1\n')
    code = (MODELS + ideal + '.control\nset filetype=ascii\n'
            'foreach vb 1.1 1.3 1.5 1.8 2.4 3.0\n alter vbias $vb\n tran 5p 14n\n'
            ' meas tran dly trig v(capture_local) val=1.65 td=4n rise=1 targ v(early_clk) val=1.65 td=4n rise=1\n'
            ' meas tran dlr trig v(capture_local) val=1.65 td=4n rise=1 targ v(early_r) val=1.65 td=4n rise=1\n'
            ' let dns=dly*1e9\n let dnr=dlr*1e9\n echo RESULT d_ns_at_ua0 $vb $&dns\n echo RESULT d_ideal_ns_at_ua0 $vb $&dnr\n'
            'end\n.endc')
    b.code(code, 1000, -150)
    # the copy uses the cell subcircuits inv_1, inv_2 and dffq_1, which Xschem writes because these symbols are used
    # elsewhere in the bench (capture drivers, delay block, early observer)

@bench('tb_frontend', 'Front end: false event at ua[0] = 3.0 V, correct early sample at 1.41 V',
       {'d_short_ps': '795 (bench without monitors; monitors add a few ps)', 'arrive_ps': 901, 'early_short_V': 0.0,
        'final_short_V': 3.3, 'd_allowed_ps': '1448 to 1458', 'early_allowed_V': 3.3, 'final_allowed_V': 3.3})
def tb_frontend(b):
    b.vsrc('vvdd', 'VDD', '3.3', -400, 0)
    b.vsrc('vcap', 'capture', TB_CLK, -280, 0)
    b.vsrc('vd', 'ui_in_6', 'PWL(0 0 2.975n 0 3.025n 3.3)', -160, 0)
    b.vsrc('vs0', 'ui_in_3', '3.3', -400, 140)
    b.vsrc('vs1', 'uio_in_6', '0', -280, 140)
    b.vsrc('vbias', 'ua_0', '3.0', -160, 140)
    x = 200
    for blk, xy in [('data_input', (200, 0)), ('capture_drivers', (200, 120)), ('duts', (500, 60)), ('selector', (800, 60)),
                    ('delay', (500, 300)), ('early_observer', (1100, 60)), ('monitors', (800, 300))]:
        i, o = ports_of(blk)
        b.block(sym('blocks', blk), xy[0], xy[1], f'x{blk}', i, o, {})
    code = (MODELS + '.control\nset filetype=ascii\ntran 2p 14n\n'
            'meas tran d_short trig v(capture_local) val=1.65 td=4n rise=1 targ v(early_clk) val=1.65 td=4n rise=1\n'
            'meas tran arrive trig v(capture_local) val=1.65 td=4n rise=1 targ v(selected_q) val=1.65 td=4n rise=1\n'
            'meas tran early_short find v(early_q) at=13.9n\nmeas tran final_short find v(selected_q) at=13.9n\n'
            'wrdata tb_frontend_short.dat v(capture_local) v(selected_q) v(early_clk) v(early_q)\n'
            'let a=d_short*1e12\necho RESULT d_short_ps $&a\nlet a=arrive*1e12\necho RESULT arrive_ps $&a\n'
            'echo RESULT early_short_V $&early_short\necho RESULT final_short_V $&final_short\n'
            'alter vbias 1.41171875\ntran 2p 14n\n'
            'meas tran d_allowed trig v(capture_local) val=1.65 td=4n rise=1 targ v(early_clk) val=1.65 td=4n rise=1\n'
            'meas tran early_allowed find v(early_q) at=13.9n\nmeas tran final_allowed find v(selected_q) at=13.9n\n'
            'wrdata tb_frontend_allowed.dat v(capture_local) v(selected_q) v(early_clk) v(early_q)\n'
            'let a=d_allowed*1e12\necho RESULT d_allowed_ps $&a\n'
            'echo RESULT early_allowed_V $&early_allowed\necho RESULT final_allowed_V $&final_allowed\n.endc')
    b.code(code, 1400, -150)

@bench('tb_selector', 'Selector: each select code passes its own flip-flop output',
       {'sel0_V': 3.3, 'sel1_V': 0.0, 'sel2_V': 3.3, 'sel3_V': 0.0})
def tb_selector(b):
    b.vsrc('vvdd', 'VDD', '3.3', -300, 0)
    b.vsrc('vs0', 'ui_in_3', 'PWL(0 0 10n 0 10.1n 3.3 20n 3.3 20.1n 0 30n 0 30.1n 3.3)', -180, 0)
    b.vsrc('vs1', 'uio_in_6', 'PWL(0 0 20n 0 20.1n 3.3)', -60, 0)
    i, o = ports_of('selector')
    b.block(sym('blocks', 'selector'), 300, 0, 'xsel', i, o, {'q_0': 'VDD', 'q_1': '0', 'q_2': 'VDD', 'q_3': '0'})
    code = (MODELS + '.control\nset filetype=ascii\ntran 10p 40n\n' +
            '\n'.join(f'meas tran s{k} find v(selected_q) at={9 + 10 * k}n\necho RESULT sel{k}_V $&s{k}' for k in range(4)) +
            '\nwrdata tb_selector.dat v(ui_in_3) v(uio_in_6) v(selected_q)\n.endc')
    b.code(code, 700, -150)

# compact_control with every trial an event (selected_q high, early_q low). Reset is held across two rising
# clk edges and released at 100 ns. start rises at 300 ns and stays high: start_meta loads it at 475 ns, run
# at 675 ns, allow_count at 825 ns, so the first count is the b rising edge at 925 ns and the eighth is at
# 2,325 ns. A full block is 65,535 trials (13.1 ms), far too long to run here: the bench shows the start of
# one, including the carry from k = 7 to k = 8.
CTRL_EXPECT = {'events_after_8_trials': 8, 'busy_V': 3.3, 'done_V': 0.0, 'fault_V': 0.0,
               'first_capture_ns': 'about 175 (clock edge at 174.6 ns plus clock-to-output)',
               'first_count_ns': 'about 927 (clock edge at 924.6 ns, then four cells: b, the count-pulse gate, k[0], the output selector)'}

@bench('tb_controller', 'Controller at transistor level: the first eight counted trials of a block (1,388 transistors)', CTRL_EXPECT)
def tb_controller(b):
    b.vsrc('vvdd', 'VDD', '3.3', -400, 0)
    b.vsrc('vclk', 'clk', 'PULSE(0 3.3 24.5n 0.1n 0.1n 24.9n 50n)', -280, 0)
    b.vsrc('vrst', 'rst_n', 'PWL(0 0 100n 0 100.1n 3.3)', -160, 0)
    b.vsrc('vstart', 'ui_in_4', 'PWL(0 0 300n 0 300.1n 3.3)', -400, 140)
    b.vsrc('vena', 'ena', '3.3', -280, 140)
    b.vsrc('vbyte', 'ui_in_0', '0', -160, 140)
    b.vsrc('vdq', 'selected_q', '3.3', -400, 280)
    b.vsrc('vea', 'early_q', '0', -280, 280)
    i, o = ports_of('controller')
    b.block(sym('blocks', 'controller'), 300, 100, 'xctrl', i, o, {})
    bits = ' '.join(f'v(uo_out_{k})' for k in range(8))
    code = (MODELS + '.control\nset filetype=ascii\ntran 50p 2.5u\n'
            'meas tran first_cap when v(capture)=1.65 rise=1\nlet a=first_cap*1e9\necho RESULT first_capture_ns $&a\n'
            'meas tran first_cnt when v(uo_out_0)=1.65 rise=1\nlet a=first_cnt*1e9\necho RESULT first_count_ns $&a\n' +
            '\n'.join(f'meas tran b{k} find v(uo_out_{k}) at=2.49u' for k in range(8)) +
            '\nlet ev=(b0 gt 1.65)+2*(b1 gt 1.65)+4*(b2 gt 1.65)+8*(b3 gt 1.65)+16*(b4 gt 1.65)+32*(b5 gt 1.65)+64*(b6 gt 1.65)+128*(b7 gt 1.65)\n'
            'echo RESULT events_after_8_trials $&ev\n'
            'meas tran busy find v(uio_out_1) at=2.49u\nmeas tran done find v(uio_out_2) at=2.49u\nmeas tran fault find v(uio_out_3) at=2.49u\n'
            'echo RESULT busy_V $&busy\necho RESULT done_V $&done\necho RESULT fault_V $&fault\n'
            f'wrdata tb_controller.dat v(clk) v(capture) v(uio_out_1) {bits}\n.endc')
    b.code(code, 800, -150)

def build(kit):
    global KIT
    KIT = Path(kit)
    (KIT / 'benches').mkdir(exist_ok=True)
    for name, (title, f) in BENCHES.items():
        b = Bench(name)
        b.text(f'{name}: {title}', -400, -260, 0.45)
        b.text('Expected: ' + '; '.join(f'{k} = {v}' for k, v in EXPECT[name].items()), -400, -225, 0.22)
        f(b)
        (KIT / 'benches' / f'{name}.sch').write_text(b.sch())
    (KIT / 'benches' / 'expected.json').write_text(json.dumps(EXPECT, indent=1))
    return list(BENCHES)

if __name__ == '__main__':
    print(build(sys.argv[1] if len(sys.argv) > 1 else str(Path(__file__).resolve().parent.parent / 'rounds' / 'round1' / 'kit')))

#!/usr/bin/env python3
"""Netlist every focused sheet back (wires, labels, symbols down to transistors) and compare with the netlist."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import networkx as nx
import sch_check as SC, flat_blocks as FB, xschem_gen as XG, build_master as BM
KIT = XG.CHIP / 'rounds' / 'round2' / 'kit'          # the build folder the kits were packed in
if not KIT.exists():
    KIT = XG.CHIP / 'xschem'                         # this repository
SUP = {'VDD': 'VDPWR', 'VNW': 'VDPWR', 'VSS': 'VGND', 'VPW': 'VGND'}

def ref_graph(devs, pins):
    nn = lambda n: SUP.get(XG.san(n), XG.san(n))
    ref = [(d['name'], d['model'], f"{float(d['w'])*1e6:g}u", f"{float(d['l'])*1e6:g}u", *[nn(d[t]) for t in 'dgsb']) for d in devs]
    return ref

def check(sheet, devs, ins, outs):
    ins2 = [XG.san(n) for n in ins]; outs2 = [XG.san(n) for n in outs]
    out = {'mos': [], 'caps': 0, 'diodes': []}
    SC.netlist(KIT / 'focus' / f'{sheet}.sch', KIT, '', {p: p for p in ins2 + outs2}, out)
    ref = ref_graph(devs, ins2 + outs2)
    SC.PINS = {'VDPWR', 'VGND'} | set(ins2 + outs2)
    h = [nx.weisfeiler_lehman_graph_hash(SC.to_graph(m), node_attr='lab', edge_attr='lab', iterations=8) for m in (out['mos'], ref)]
    return len(out['mos']), len(ref), h[0] == h[1]

if __name__ == '__main__':
    import focus_sheets as F
    # rebuild the device lists exactly as the sheets were made
    ml = ['u_mfw', 'u_mkp']
    trio = (F.pref(F.cells_of('meta_dut_baseline', ml), 'base_') + F.pref(F.cells_of('meta_dut_keeper', ml), 'keep_') +
            F.pref(F.cells_of('meta_dut_forward', ml), 'fwd_'))
    cs = [{**m, **{t: ({'control': 'ua_0'}.get(m[t], m[t])) for t in 'dgsb'}} for m in BM.DELAY_DEVICES]
    B = FB.blocks()
    cases = {
        'F01_master_latch_baseline': (FB.flatten(F.cells_of('meta_dut_baseline', ml)), ['g1', 'g2'], ['mq', 'mqb']),
        'F02_master_latch_keeper': (FB.flatten(F.cells_of('meta_dut_keeper', ml)), ['g1', 'g2'], ['mq', 'mqb']),
        'F03_master_latch_forward': (FB.flatten(F.cells_of('meta_dut_forward', ml)), ['g1', 'g2'], ['mq', 'mqb']),
        'F04_master_latch_comparison': (FB.flatten(trio), [], [f'{p}{n}' for p in ('base_', 'keep_', 'fwd_') for n in ('mq', 'mqb')]),
        'F05_master_door': (FB.flatten(F.cells_of('meta_dut_baseline', ['u_cki', 'u_mg1', 'u_mg2'])), ['d', 'clk'], ['g1', 'g2']),
        'F06_slave': (FB.flatten(F.cells_of('meta_dut_baseline', ['u_sg1', 'u_sg2', 'u_sfw', 'u_skp'])), ['mq', 'clk'], ['q']),
        'F07_library_flipflop': (FB.flatten([('dut1', 'dffq_1', {'D': 'D', 'CLK': 'CLK', 'Q': 'Q'})]), ['D', 'CLK'], ['Q']),
        'F08_current_starved_stage': (FB.flatten([], cs), ['launch', 'ua_0'], ['slow']),
        'F09_delay_line': (B['delay_line'][2], B['delay_line'][3], B['delay_line'][4]),
        'F10_selector': (B['selector'][2], B['selector'][3], B['selector'][4]),
        'F11_controller_register': (FB.flatten([('reg', 'dffrnq_1', {'D': 'D', 'RN': 'RN', 'CLK': 'CLK', 'Q': 'Q'})]), ['D', 'RN', 'CLK'], ['Q']),
    }
    for sub, code in [('meta_dut_baseline', 'G01'), ('meta_dut_keeper', 'G02'), ('meta_dut_forward', 'G03')]:
        cases[f'{code}_{sub}_gates'] = (FB.flatten(FB.dut_cells(sub)), ['d', 'clk'], ['q'])
    # front end: every cell, the three NAND flip-flops and the delay line, flattened
    top = {i['name']: i for _, i in BM.TOP}
    cells = [(n, top[n]['cell'].replace(BM.LIB, ''), dict(top[n]['conns'])) for n in
             ('data0', 'data1', 'cap0', 'cap1', 'u_dut1', 'select_dut', 'iso0', 'iso1', 'early_observer',
              'monitor_capture_a', 'monitor_capture_b', 'monitor_early_a', 'monitor_early_b')]
    for _b, name, sub, nets in BM.TOP_SUB:
        if sub.startswith('meta_dut'):
            pm = dict(zip(['d', 'clk', 'q'], nets))
            cells += [(f'{name}.{i}', c, {p: pm.get(n, f'{name}.{n}') for p, n in cn.items()}) for i, c, cn in FB.dut_cells(sub)]
    dl = [('XR0', 'inv_1', {'I': 'slow', 'ZN': 'r0'}), ('XR1', 'inv_2', {'I': 'r0', 'ZN': 'r1'}), ('XR2', 'inv_2', {'I': 'r1', 'ZN': 'early_clk'})]
    cells += [(f'delay.{i}', c, {p: (n if n == 'early_clk' else f'delay.{n}') for p, n in cn.items()}) for i, c, cn in dl]
    mos = [{**m, **{t: {'launch': 'capture_iso', 'control': 'ua[0]'}.get(m[t], m[t] if m[t] in ('VDPWR', 'VGND') else f'delay.{m[t]}') for t in 'dgsb'}}
           for m in BM.DELAY_DEVICES]
    cases['G04_front_end'] = (FB.flatten(cells, mos), ['ui_in[6]', 'capture', 'ui_in[3]', 'uio_in[6]', 'ua[0]'],
                              ['selected_q', 'early_q', 'uio_out[4]', 'uio_out[5]'])
    bad = 0
    for sheet, (devs, ins, outs) in cases.items():
        a, b, same = check(sheet, devs, ins, outs)
        bad += not same
        print(f'{sheet:34s} {a:4d}/{b:<4d} {"SAME" if same else "DIFFERENT"}')
    print('ALL SAME' if not bad else f'{bad} DIFFERENT')

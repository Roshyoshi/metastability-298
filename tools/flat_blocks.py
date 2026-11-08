#!/usr/bin/env python3
"""Every front-end block (and each flip-flop under test) drawn flat at transistor level, every MOSFET wired.

One schematic per block in flat/: the cells are opened up, all their transistors placed stage by stage in
signal order (PMOS from VDD at the top, NMOS to ground at the bottom), and all nets drawn as wires.
Each stage carries the instance name of the cell it came from; the block's named nets (mq, mqb, slow, ...)
carry a label so they can be found. Checked by netlisting the wires back against the master netlist.
"""
import sys
from collections import OrderedDict
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import build_master as BM
import xschem_gen as XG
import wired_cells as WC

RAIL = {'VDD': 'VDD', 'VNW': 'VNW', 'VSS': 'VSS', 'VPW': 'VPW'}
TOPNET = {'VDPWR': 'VDD', 'VGND': 'VSS'}

def flatten(cells, mos=()):
    """cells: [(inst, cell, conns)]; mos: custom devices [{name,d,g,s,b,model,W,L}]. Returns device list."""
    devs = []
    for inst, cell, conns in cells:
        for d in XG.SIM[cell]['dev']:
            dd = dict(d)
            for t in 'dgsb':
                n = d[t]
                if n in RAIL:
                    dd[t] = RAIL[n]
                elif n in conns:
                    dd[t] = TOPNET.get(conns[n], conns[n])
                else:
                    dd[t] = f'{inst}.{n}'
            dd['name'] = f'{inst}_{d["name"].lstrip("_")}'
            dd['cell'] = inst
            devs.append(dd)
    for m in mos:
        W, L = m['W'], m['L']
        devs.append({'name': m['name'], 'model': m['model'], 'w': f'{W:.4g}', 'l': f'{L:.4g}',
                     'ad': f'{W * 0.5e-6:.3g}', 'as': f'{W * 0.5e-6:.3g}', 'pd': f'{2 * (W + 0.5e-6):.3g}',
                     'ps': f'{2 * (W + 0.5e-6):.3g}', 'cell': m['name'],
                     **{t: TOPNET.get(m[t], m[t]) for t in 'dgsb'}})
    return devs

def x_name(n):
    return XG.san(n)

ORDER = ['u_cki', 'u_mg1', 'u_mg2', 'u_mfw', 'u_mkp', 'u_sg1', 'u_sg2', 'u_sfw', 'u_skp',
         'iso0', 'iso1', 'MP', 'MN', 'MC', 'MCT', 'XR0', 'XR1', 'XR2', 'data0', 'data1', 'cap0', 'cap1',
         'monitor_capture_a', 'monitor_capture_b', 'monitor_early_a', 'monitor_early_b']

def scene(title, note, devs, ins, outs, label_nets):
    if all(d.get('cell') in ORDER for d in devs):
        devs = [dict(d, rank=ORDER.index(d['cell'])) for d in devs]
    devs = [dict(d, d=x_name(d['d']), g=x_name(d['g']), s=x_name(d['s']), b=x_name(d['b'])) for d in devs]
    ins = [x_name(n) for n in ins]; outs = [x_name(n) for n in outs]
    R = WC.wired_cell(devs, ins, outs, None)
    sc = XG.Scene(title)
    sc.text(title, 0, -230, 0.45)
    for k, line in enumerate(note):
        sc.text(line, 0, -190 + 28 * k, 0.26)
    first = OrderedDict()
    for kind, x, y, d in R['inst']:
        attrs, mname, W, L = XG.mos_attrs(d)
        sc.inst(f'{XG.PDKSYM}/{kind}_06v0.sym', x, y, attrs, ('mos', kind, mname, W, L))
        c = d.get('cell', '')
        if c not in first or x < first[c][0]:
            first[c] = (x, min(y, first.get(c, (0, 1e9))[1]))
    tops = min(y for _, _, y, _ in R['inst'])
    for c, (x, y) in first.items():
        sc.text(c, x - 30, tops - 95, 0.3)
    for (x1, y1), (x2, y2), sup in R['supplies']:
        sc.wire(x1, y1, x2, y2, sup)
        sym = 'devices/vdd.sym' if sup == 'VDD' else 'devices/gnd.sym'
        sc.k += 1
        sc.items.append(('supply', sym, x2, y2, sup, f's{sc.k}'))
    for x1, y1, x2, y2, net in R['wires']:
        sc.wire(x1, y1, x2, y2, net)
    for kind, x, y, n in R['ports']:
        sc.pin(kind, x, y, n)
    # name tags on the block's own nets, at one gate pin of that net
    want = {x_name(n) for n in label_nets} - set(ins) - set(outs)
    done = set()
    for kind, x, y, d in R['inst']:
        if d['g'] in want and d['g'] not in done:
            sc.lab(x - 20, y, d['g'], right=False); done.add(d['g'])
    return sc, len(devs)

def dut_cells(sub):
    cells = []
    for i in BM.DUT_SUBCKTS[sub]:
        cells.append((i['name'], i['cell'].replace(BM.LIB, ''), dict(i['conns'])))
    return cells

ROLE = {'u_cki': 'clock inverter', 'u_mg1': 'master door', 'u_mg2': 'master door', 'u_mfw': 'master forward',
        'u_mkp': 'master keeper', 'u_sg1': 'slave door', 'u_sg2': 'slave door', 'u_sfw': 'slave latch',
        'u_skp': 'slave latch'}

def blocks():
    B = OrderedDict()
    top = {i['name']: (i['name'], i['cell'].replace(BM.LIB, ''), dict(i['conns'])) for _, i in BM.TOP}
    dut_note = {
        'meta_dut_baseline': 'Baseline: forward gate u_mfw = nand2_2, keeper gate u_mkp = nand2_1.',
        'meta_dut_keeper': 'Keeper strengthened: u_mfw = nand2_2, u_mkp = nand2_2 (keeper transistors twice as wide in effect, doubled).',
        'meta_dut_forward': 'Forward strengthened: u_mfw = nand2_4 (four copies in parallel), u_mkp = nand2_1.'}
    for k, (sub, nm) in enumerate([('meta_dut_baseline', 'dut2_baseline'), ('meta_dut_keeper', 'dut3_keeper'),
                                   ('meta_dut_forward', 'dut4_forward')]):
        cells = dut_cells(sub)
        B[nm] = (f'{nm}: NAND flip-flop {sub} at transistor level',
                 [dut_note[sub], 'Stages left to right: clock inverter, master door (u_mg1, u_mg2), master latch '
                  '(u_mfw forward, u_mkp keeper: the cross-coupled pair that goes metastable, nodes mq and mqb),',
                  'slave door (u_sg1, u_sg2), slave latch (u_sfw, u_skp).'],
                 flatten(cells), ['d', 'clk'], ['q'], ['clkn', 'g1', 'g2', 'mq', 'mqb', 's1', 's2', 'sqb'])
    B['dut1_library'] = ('dut1_library: GF180 library flip-flop dffq_1 at transistor level (the paper\'s "regular library FF")',
                         ['Clock inverters, master latch (three-state inverters), transmission gate, slave latch, output inverter.'],
                         flatten([('u_dut1', 'dffq_1', {'D': 'D', 'CLK': 'CLK', 'Q': 'Q'})]), ['D', 'CLK'], ['Q'], [])
    dl = [('XR0', 'inv_1', {'I': 'slow', 'ZN': 'r0'}), ('XR1', 'inv_2', {'I': 'r0', 'ZN': 'r1'}),
          ('XR2', 'inv_2', {'I': 'r1', 'ZN': 'early_clk'})]
    B['delay_line'] = ('delay_line: isolation buffer + current-starved inverter + timing capacitor + three restorers',
                       ['iso0, iso1: buffer from capture_local. MP/MN: inverter on launch; MC (gate ua_0) starves the pull-down; '
                        'MCT: gate capacitor on slow. XR0-XR2 restore a sharp edge.'],
                       flatten([('iso0', 'inv_1', {'I': 'capture_local', 'ZN': 'capture_iso_b'}),
                                ('iso1', 'inv_2', {'I': 'capture_iso_b', 'ZN': 'launch'})] + dl,
                               [dict(m, d={'launch': 'launch'}.get(m['d'], m['d'])) for m in BM.DELAY_DEVICES] and
                               [{**m, **{t: ({'launch': 'launch', 'control': 'ua_0'}.get(m[t], m[t])) for t in 'dgsb'}}
                                for m in BM.DELAY_DEVICES]),
                       ['capture_local', 'ua_0'], ['early_clk'], ['launch', 'slow', 'foot', 'r0', 'r1'])
    B['selector'] = ('selector: mux4_1 at transistor level', ['Picks q[0..3] by cfg[1:0].'],
                     flatten([top['select_dut']]), ['q[0]', 'q[1]', 'q[2]', 'q[3]', 'cfg[0]', 'cfg[1]'], ['selected_q'], [])
    B['early_observer'] = ('early_observer: dffq_1 clocked by the delay line', ['Samples selected_q at time d after capture.'],
                           flatten([top['early_observer']]), ['selected_q', 'early_clk'], ['early_q'], [])
    B['data_and_capture'] = ('data input buffers and capture drivers', ['data0, data1: ui_in[6] to data_local. cap0, cap1: capture to capture_local.'],
                             flatten([top['data0'], top['data1'], top['cap0'], top['cap1']]),
                             ['ui_in[6]', 'capture'], ['data_local', 'capture_local'], ['data_b', 'capture_b'])
    B['monitors'] = ('clock monitors', ['capture_local and early_clk buffered to pins uio_out[4], uio_out[5].'],
                     flatten([top[n] for n in ('monitor_capture_a', 'monitor_capture_b', 'monitor_early_a', 'monitor_early_b')]),
                     ['capture_local', 'early_clk'], ['uio_out[4]', 'uio_out[5]'], [])
    # controller flow boxes, every cell opened up (port nets = nets shared with other boxes or pins)
    use = {}
    for i in BM.CTRL:
        for n in i['conns'].values():
            use.setdefault(n, set()).add(i['box'])
    outpins = {'Z', 'ZN', 'Q'}
    for box, nm in [('Late observers', 'ctrl_late_observers'), ('Compare', 'ctrl_compare'),
                    ('Hold results + readout', 'ctrl_hold_status'), ('Sequencer', 'ctrl_sequencer'),
                    ('Counters K and N', 'ctrl_counters')]:
        mem = [i for i in BM.CTRL if i['box'] == box]
        cells = [(i['name'].strip('_'), i['cell'].replace(BM.LIB, ''),
                  {p: BM.CTRL_MAP.get(n, n) for p, n in i['conns'].items()}) for i in mem]
        drv = {BM.CTRL_MAP.get(n, n) for i in mem for p, n in i['conns'].items() if p in outpins}
        nets = {BM.CTRL_MAP.get(n, n) for i in mem for n in i['conns'].values()} - {'VDPWR', 'VGND'}
        ext = {n for n in nets if len(use.get(n, use.get(next((k for k, v in BM.CTRL_MAP.items() if v == n), n), set()))) > 1
               or n in BM.CTRL_MAP.values() or n in ('clk', 'rst_n')}
        ins = sorted(n for n in ext if n not in drv); outs = sorted(n for n in ext if n in drv)
        B[nm] = (f'{nm}: controller flow box "{box}" at transistor level ({len(mem)} cells)',
                 ['Synthesized from meta_controller.v; every cell opened up. Stage labels are the cell instance names.'],
                 flatten(cells), ins, outs, [])
    return B

def build(out, only=None):
    out = Path(out) / 'flat'
    out.mkdir(parents=True, exist_ok=True)
    made = []
    for nm, (title, note, devs, ins, outs, labs) in blocks().items():
        if only and nm not in only:
            continue
        sc, n = scene(title, note, devs, ins, outs, labs)
        (out / f'{nm}.sch').write_text(sc.sch())
        made.append((nm, n))
    return made

if __name__ == '__main__':
    for nm, n in build(sys.argv[1] if len(sys.argv) > 1 else str(XG.CHIP / 'rounds' / 'round2' / 'kit')):
        print(f'{nm:18s} {n:3d} transistors')

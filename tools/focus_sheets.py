#!/usr/bin/env python3
"""Focused schematics for the explanation: small transistor-level sheets of the key parts with the important or
changed transistors boxed, and gate-level sheets (cells as boxes, joined by real wires) for the big picture.

Writes schematics_focus/*.sch (copied into the kit's focus/ folder by kit2_gen.py). Every sheet is checked
against the master netlist by tools/check_focus.py.
"""
import re, sys
from collections import OrderedDict, defaultdict
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import build_master as BM
import xschem_gen as XG
import wired_cells as WC
import flat_blocks as FB

CHIP = XG.CHIP
OUT = CHIP / 'schematics_focus'
KIT = CHIP / 'rounds' / 'round2' / 'kit'        # symbols are read from the generated kit
HL = 7                                          # Xschem layer used for the highlight boxes and their captions

# ------------------------------------------------------------------ transistor-level sheets with boxes
def tsheet(name, title, note, devs, ins, outs, labels, boxes):
    """boxes: [(caption, predicate(device) -> bool)]"""
    sc, n = FB.scene(title, note, devs, ins, outs, labels)
    pos = [(it[2], it[3], it[6]) for it in sc.items if it[0] == 'inst']
    names = {}
    for it in sc.items:
        if it[0] == 'inst':
            m = re.search(r'name=(\S+)', it[6]); names[m.group(1)] = (it[2], it[3])
    byname = {}
    for d in devs:
        mname = d['name'] if d['name'].upper().startswith('M') else 'M' + d['name']
        byname[mname] = d
    for k, (cap, pred) in enumerate(boxes):
        pts = [names[m] for m, d in byname.items() if pred(d) and m in names]
        if not pts:
            raise RuntimeError(f'{name}: box "{cap}" selects nothing')
        x1 = min(x for x, y in pts) - 60; x2 = max(x for x, y in pts) + 75
        y1 = min(y for x, y in pts) - 60; y2 = max(y for x, y in pts) + 60
        for a, b, c, d_ in ((x1, y1, x2, y1), (x2, y1, x2, y2), (x2, y2, x1, y2), (x1, y2, x1, y1)):
            sc.items.append(('raw', f'L {HL} {a} {b} {c} {d_} {{dash=4}}'))
        sc.items.append(('raw', f'T {{{cap}}} {x1} {y1 - 30 - 0 * k} 0 0 0.3 0.3 {{layer={HL}}}'))
    (OUT / f'{name}.sch').write_text(sc.sch())
    return n

def cells_of(sub, names):
    return [c for c in FB.dut_cells(sub) if c[0] in names]

def pref(cells, p):
    """Prefix every net that is not a supply so that several copies can share one sheet."""
    return [(f'{p}{inst}', cell, {k: (v if v in ('VDPWR', 'VGND') else f'{p}{v}') for k, v in conns.items()})
            for inst, cell, conns in cells]

def cellis(*insts):
    return lambda d: d.get('cell') in insts

def devname(*suffixes):
    return lambda d: any(d['name'].endswith('_' + s.lstrip('_')) or d['name'] == s for s in suffixes)

def transistor_sheets():
    made = OrderedDict()
    ml = ['u_mfw', 'u_mkp']
    eq = ('While the clock holds (g1 = g2 = 1) each NAND acts as an inverter: forward u_mfw drives mq from mqb, '
          'keeper u_mkp drives mqb from mq.')
    law = '1/tau = sqrt(g_f g_k / (C_mq C_mqb)): tau falls when the added drive outweighs the capacitance it adds.'
    made['F01_master_latch_baseline'] = tsheet(
        'F01_master_latch_baseline', 'F01 master latch of DUT2 (baseline): forward nand2_2, keeper nand2_1',
        [eq, law], FB.flatten(cells_of('meta_dut_baseline', ml)), ['g1', 'g2'], ['mq', 'mqb'], [],
        [('forward stage u_mfw (nand2_2): g_f, drives mq', cellis('u_mfw')),
         ('keeper stage u_mkp (nand2_1): g_k, drives mqb', cellis('u_mkp'))])
    made['F02_master_latch_keeper'] = tsheet(
        'F02_master_latch_keeper', 'F02 master latch of DUT3: keeper strengthened (nand2_1 -> nand2_2)',
        [eq, 'CHANGE from DUT2: the keeper u_mkp has two copies of each transistor in parallel, so g_k doubles '
         '(and so do its capacitances). Simulated tau: 88.9 ps -> 80.5 ps.'],
        FB.flatten(cells_of('meta_dut_keeper', ml)), ['g1', 'g2'], ['mq', 'mqb'], [],
        [('forward stage u_mfw (nand2_2), unchanged', cellis('u_mfw')),
         ('CHANGED: keeper u_mkp now nand2_2 (2x)', cellis('u_mkp'))])
    made['F03_master_latch_forward'] = tsheet(
        'F03_master_latch_forward', 'F03 master latch of DUT4: forward strengthened (nand2_2 -> nand2_4)',
        [eq, 'CHANGE from DUT2: the forward u_mfw has four copies of each transistor in parallel. '
         'Simulated tau: 88.9 ps -> 102.3 ps (the added capacitance outweighs the added drive).'],
        FB.flatten(cells_of('meta_dut_forward', ml)), ['g1', 'g2'], ['mq', 'mqb'], [],
        [('CHANGED: forward u_mfw now nand2_4 (4x)', cellis('u_mfw')),
         ('keeper stage u_mkp (nand2_1), unchanged', cellis('u_mkp'))])
    trio = (pref(cells_of('meta_dut_baseline', ml), 'base_') + pref(cells_of('meta_dut_keeper', ml), 'keep_') +
            pref(cells_of('meta_dut_forward', ml), 'fwd_'))
    devs = FB.flatten(trio)
    ranks = ['base_u_mfw', 'base_u_mkp', 'keep_u_mfw', 'keep_u_mkp', 'fwd_u_mfw', 'fwd_u_mkp']
    devs = [dict(d, rank=ranks.index(d['cell'])) for d in devs]
    made['F04_master_latch_comparison'] = tsheet(
        'F04_master_latch_comparison', 'F04 the three NAND master latches side by side (left to right: DUT2, DUT3, DUT4)',
        [eq, 'Only the boxed stages differ. tau: 88.9 ps (baseline), 80.5 ps (keeper x2), 102.3 ps (forward x4).'],
        devs, [f'{p}{n}' for p in ('base_', 'keep_', 'fwd_') for n in ('g1', 'g2')],
        [f'{p}{n}' for p in ('base_', 'keep_', 'fwd_') for n in ('mq', 'mqb')], [],
        [('DUT2 baseline', lambda d: d['cell'].startswith('base_')),
         ('DUT3: keeper doubled', cellis('keep_u_mkp')),
         ('DUT4: forward quadrupled', cellis('fwd_u_mfw'))])
    made['F05_master_door'] = tsheet(
        'F05_master_door', 'F05 clock inverter and master door of the NAND flip-flops (same in DUT2-4)',
        ['clk low -> clkn high: the door passes d (g1 = NOT d, g2 = d). clk high -> clkn low: g1 = g2 = 1, the door '
         'closes and the master latch is left to resolve on its own.'],
        FB.flatten(cells_of('meta_dut_baseline', ['u_cki', 'u_mg1', 'u_mg2'])), ['d', 'clk'], ['g1', 'g2'], ['clkn'],
        [('clock inverter u_cki: makes clkn', cellis('u_cki')),
         ('master door u_mg1, u_mg2', cellis('u_mg1', 'u_mg2'))])
    made['F06_slave'] = tsheet(
        'F06_slave', 'F06 slave door and slave latch of the NAND flip-flops (same in DUT2-4)',
        ['clk high: the slave door copies mq into the slave latch, which drives q. clk low: the slave holds q while '
         'the master takes the next d.'],
        FB.flatten(cells_of('meta_dut_baseline', ['u_sg1', 'u_sg2', 'u_sfw', 'u_skp'])), ['mq', 'clk'], ['q'],
        ['s1', 's2', 'sqb'],
        [('slave door u_sg1, u_sg2', cellis('u_sg1', 'u_sg2')), ('slave latch u_sfw, u_skp', cellis('u_sfw', 'u_skp'))])
    dff = FB.flatten([('dut1', 'dffq_1', {'D': 'D', 'CLK': 'CLK', 'Q': 'Q'})])
    made['F07_library_flipflop'] = tsheet(
        'F07_library_flipflop', 'F07 library flip-flop dffq_1 (DUT1, and the early observer): the paper\'s "regular library FF"',
        ['Master: three-state inverter in, inverter, three-state inverter fed back (this loop goes metastable). '
         'A transmission gate passes it to the slave; an inverter drives Q.'],
        dff, ['D', 'CLK'], ['Q'], [],
        [('clock inverters', devname('tn3', 'tp3', 'tn4', 'tp4')),
         ('master input (three-state)', devname('tn5', 'tn8', 'tp12', 'tp11')),
         ('master loop: inverter + feedback', devname('tn0', 'tp0', 'tn6', 'tn7', 'tp6', 'tp5')),
         ('transmission gate to slave', devname('tn9', 'tp7')),
         ('slave latch', devname('tn10', 'tp8', 'tn11', 'tn12', 'tp9', 'tp10')),
         ('output inverter', devname('tn1', 'tp1'))])
    cs = [{**m, **{t: ({'control': 'ua_0'}.get(m[t], m[t])) for t in 'dgsb'}} for m in BM.DELAY_DEVICES]
    made['F08_current_starved_stage'] = tsheet(
        'F08_current_starved_stage', 'F08 current-starved stage of the delay line: MP, MN, MC and the timing capacitor MCT',
        ['launch rises -> MN turns on -> slow discharges through MN and MC. MC\'s gate voltage ua[0] limits that current, '
         'so ua[0] sets how fast slow falls (the delay d). MCT is the charge that has to be removed.'],
        FB.flatten([], cs), ['launch', 'ua_0'], ['slow'], ['foot'],
        [('MP: fast pull-up', cellis('MP')), ('starved pull-down: MN in series with MC', cellis('MN', 'MC')),
         ('MCT: timing capacitor (gate on slow)', cellis('MCT'))])
    dl = FB.blocks()['delay_line']
    made['F09_delay_line'] = tsheet(
        'F09_delay_line', 'F09 the whole delay line: capture_local -> early_clk', dl[1], dl[2], dl[3], dl[4], dl[5],
        [('isolation buffer iso0, iso1', cellis('iso0', 'iso1')),
         ('current-starved stage', cellis('MP', 'MN', 'MC', 'MCT')),
         ('restorers XR0, XR1, XR2', cellis('XR0', 'XR1', 'XR2'))])
    sel = FB.blocks()['selector']
    made['F10_selector'] = tsheet(
        'F10_selector', 'F10 selector mux4_1: picks one flip-flop output', sel[1], sel[2], sel[3], sel[4], sel[5],
        [('select inverters', devname('MN1', 'MP1', 'MN2', 'MP5')),
         ('first level: three-state stages (S0)', devname('MN3', 'MN4', 'MN5', 'MN6', 'MN7', 'MN8', 'MN9', 'MN10',
                                                           'MP2', 'MP3', 'MP4', 'MP6', 'MP7', 'MP8', 'MP9', 'MP10')),
         ('second level: transmission gates (S1)', devname('MN11', 'MN12', 'MP11', 'MP12')),
         ('output inverter', devname('instance_22', 'instance_1'))])
    made['F11_controller_register'] = tsheet(
        'F11_controller_register', 'F11 dffrnq_1: every controller register (34 of them) is this flip-flop with reset',
        ['Same structure as F07; RN = 0 forces the master and the slave so that Q = 0 whatever the clock does.'],
        FB.flatten([('reg', 'dffrnq_1', {'D': 'D', 'RN': 'RN', 'CLK': 'CLK', 'Q': 'Q'})]), ['D', 'RN', 'CLK'], ['Q'], [],
        [('reset path (gates on RN)', devname('tn9', 'tn5', 'tp12', 'tp5')),
         ('clock inverters', devname('tn10', 'tp8', 'tn13', 'tp11'))])
    return made

# ------------------------------------------------------------------ gate-level sheets
def sym_geom(sympath):
    txt = Path(sympath).read_text()
    pins = {}
    for line in txt.splitlines():
        if line.startswith('B 5'):
            t = line.split(); x1, y1, x2, y2 = map(float, t[2:6])
            pins[line.split('name=')[1].split()[0].rstrip('}')] = (int((x1 + x2) / 2), int((y1 + y2) / 2))
    xs, ys = [], []
    for line in txt.splitlines():
        if line.startswith('L 4'):
            t = line.split(); xs += [float(t[2]), float(t[4])]; ys += [float(t[3]), float(t[5])]
    pxs = [p[0] for p in pins.values()]
    body = (int(min(xs)) + 20 if min(xs) <= min(pxs) else int(min(xs)), int(min(ys)),
            int(max(xs)) - 20 if max(xs) >= max(pxs) else int(max(xs)), int(max(ys)))
    return pins, body

def gsheet(name, title, note, insts, ins, outs, columns, col_text=()):
    """insts: [(inst, symkind, ref, conns)] symkind 'cell' | 'block'; columns: {inst: column}."""
    syms, place = [], {}
    colh = defaultdict(int)
    for inst, kind, ref, conns in insts:
        sp = KIT / ('cells_tx' if kind == 'cell' else 'blocks') / f'{ref}.sym'
        pins, (bx1, by1, bx2, by2) = sym_geom(sp)
        c = columns[inst]
        x = 300 + 380 * c
        y = colh[c] - by1 + 40
        colh[c] = y + by2 + 120
        place[inst] = (x, y, sp, pins)
        syms.append({'x1': x + bx1, 'y1': y + by1, 'x2': x + bx2, 'y2': y + by2,
                     'pins': {p: (x + px, y + py) for p, (px, py) in pins.items()},
                     'conns': {p: XG.san(conns[p]) for p in pins}})
    R = WC.wired_symbols(syms, [XG.san(n) for n in ins], [XG.san(n) for n in outs])
    sc = XG.Scene(name)
    sc.text(title, 0, -200, 0.45)
    for k, line in enumerate(note):
        sc.text(line, 0, -160 + 28 * k, 0.26)
    for c, t in col_text:
        sc.text(t, 300 + 380 * c - 60, -60, 0.3)
    for inst, kind, ref, conns in insts:
        x, y, sp, pins = place[inst]
        sc.inst(str(sp).replace(str(KIT), XG.ROOT), x, y, f'name=x{inst.strip("_")}', ('box', kind, ref, [], [], 30, inst))
        sc.text(inst, x - 30, y + min(py for px, py in pins.values()) - 45, 0.22)
    for x1, y1, x2, y2, net in R['wires']:
        sc.wire(x1, y1, x2, y2, net)
    for kind, x, y, n in R['ports']:
        sc.pin(kind, x, y, n)
    (OUT / f'{name}.sch').write_text(sc.sch())
    return len(insts)

DUT_COLS = {'u_cki': 0, 'u_mg1': 1, 'u_mg2': 1, 'u_mfw': 2, 'u_mkp': 2, 'u_sg1': 3, 'u_sg2': 3, 'u_sfw': 4, 'u_skp': 4}
DUT_TEXT = [(0, 'clock inverter'), (1, 'master door'), (2, 'master latch'), (3, 'slave door'), (4, 'slave latch')]

def gate_sheets():
    made = OrderedDict()
    for code, sub, what in [('G01', 'meta_dut_baseline', 'DUT2 baseline: forward nand2_2, keeper nand2_1'),
                            ('G02', 'meta_dut_keeper', 'DUT3: keeper strengthened to nand2_2'),
                            ('G03', 'meta_dut_forward', 'DUT4: forward strengthened to nand2_4')]:
        insts = [(n, 'cell', c, conns) for n, c, conns in FB.dut_cells(sub)]
        made[f'{code}_{sub}_gates'] = gsheet(f'{code}_{sub}_gates', f'{code} {what} (gate level, wired)',
                                             ['Each box is one standard cell; press e on it to see its transistors.'],
                                             insts, ['d', 'clk'], ['q'], DUT_COLS, DUT_TEXT)
    top = {i['name']: i for _, i in BM.TOP}
    def cell(n):
        i = top[n]; return (n, 'cell', i['cell'].replace(BM.LIB, ''), dict(i['conns']))
    fe = [cell('data0'), cell('data1'), cell('cap0'), cell('cap1'), cell('u_dut1')]
    for _box, name, sub, nets in BM.TOP_SUB:
        if sub.startswith('meta_dut'):
            fe.append((name, 'block', sub, dict(zip(['d', 'clk', 'q'], nets))))
    fe += [cell('select_dut'), cell('iso0'), cell('iso1'),
           ('delay', 'block', 'delay_line', {'launch': 'capture_iso', 'control': 'ua[0]', 'sample_clk': 'early_clk'}),
           cell('early_observer'), cell('monitor_capture_a'), cell('monitor_capture_b'), cell('monitor_early_a'),
           cell('monitor_early_b')]
    cols = {'data0': 0, 'cap0': 0, 'data1': 1, 'cap1': 1, 'u_dut1': 2, 'u_dut2': 2, 'u_dut3': 2, 'u_dut4': 2,
            'select_dut': 3, 'iso0': 2, 'iso1': 3, 'delay': 4, 'early_observer': 5, 'monitor_capture_a': 5,
            'monitor_capture_b': 6, 'monitor_early_a': 5, 'monitor_early_b': 6}
    made['G04_front_end'] = gsheet(
        'G04_front_end', 'G04 front end (gate level, wired): data in, capture edge, four flip-flops, selector, delay line, early sample',
        ['capture (from the controller) clocks all four flip-flops; the selector passes one output; the delay line makes '
         'early_clk a time d later; the early observer samples the selected output then. Monitors copy both clocks to pins.'],
        fe, ['ui_in[6]', 'capture', 'ui_in[3]', 'uio_in[6]', 'ua[0]'], ['selected_q', 'early_q', 'uio_out[4]', 'uio_out[5]'],
        cols, [(0, 'input buffers'), (2, 'flip-flops under test'), (3, 'selector / isolation'), (4, 'delay line'),
               (5, 'early observer, monitors')])
    return made

if __name__ == '__main__':
    OUT.mkdir(exist_ok=True)
    for k, v in {**transistor_sheets(), **gate_sheets()}.items():
        print(f'{k:36s} {v}')

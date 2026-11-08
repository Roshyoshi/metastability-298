#!/usr/bin/env python3
"""v3 presentation sheets (see pretty.py). Writes schematics_focus/F*.sch + .hl and sym/."""
import sys
from collections import OrderedDict, defaultdict
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import build_master as BM
import xschem_gen as XG
import flat_blocks as FB
import pretty as PR
import pretty_gates as PG
from focus_sheets import cells_of, pref, cellis, devname

OUT = XG.CHIP / 'schematics_focus'
RED, GREEN, GREY = 7, 4, 3

def shortnames(devs, tags=None, lib=False):
    """lib=True: keep the library's own device names (tp8, tn14); else P1, N1 per cell, prefixed by a tag."""
    by = defaultdict(list)
    for d in devs:
        by[d['cell']].append(d)
    for cell, ds in by.items():
        tag = (tags or {}).get(cell, '')
        if lib:
            for d in ds:
                d['show'] = tag + ('MPout' if d['name'].endswith('instance_1') else 'MNout' if d['name'].endswith('instance_22')
                                    else d['name'].split('_')[-1])
            continue
        for kind in 'pn':
            k = 0
            for d in sorted([d for d in ds if d['model'][0] == kind], key=lambda d: d['name']):
                k += 1
                d['show'] = f'{tag}{kind.upper()}{k}'
    return devs

def strip(devs, pre):
    """Drop the instance prefix from internal net names (reg.cki -> cki) on one-cell sheets."""
    for d in devs:
        for t in 'dgsb':
            if d[t].startswith(pre):
                d[t] = d[t][len(pre):]
    return devs

def sheets(only=None):
    made = OrderedDict()
    def mk(name, *a, **kw):
        if only and name not in only:
            return
        made[name] = PR.tsheet(OUT / f'{name}.sch', *a, **kw)
    ml = ['u_mfw', 'u_mkp']
    eq = ('With g1 = g2 = 1 (clock high, door closed) each NAND is an inverter: forward u_mfw drives mq from mqb, '
          'keeper u_mkp drives mqb from mq.')
    law = '1/tau = sqrt(g_f g_k / (C_mq C_mqb)): tau falls when the added drive outweighs the capacitance it adds.'
    nm = 'Names: fw = forward u_mfw, kp = keeper u_mkp; P/N = PMOS/NMOS. Two (or four) transistors side by side = copies in parallel.'
    tags = {'u_mfw': 'fw_', 'u_mkp': 'kp_'}
    latch_col = [('mq', 'green', 'mq: master node driven by the forward gate'),
                 ('mqb', 'salmon', 'mqb: master node driven by the keeper gate')]
    fwd = lambda t: ('forward u_mfw (' + t + '): g_f', cellis('u_mfw'))
    kp = lambda t: ('keeper u_mkp (' + t + '): g_k', cellis('u_mkp'))
    mk('F01_master_latch_baseline', 'F01  master latch of DUT2 (baseline): forward nand2_2, keeper nand2_1', [eq, law, nm],
       shortnames(FB.flatten(cells_of('meta_dut_baseline', ml)), tags), ['g1', 'g2'], ['mq', 'mqb'],
       [fwd('nand2_2') + (GREY,), kp('nand2_1') + (GREY,)], colours=latch_col)
    mk('F02_master_latch_keeper', 'F02  master latch of DUT3: keeper strengthened (nand2_1 -> nand2_2)',
       [eq, 'CHANGE from DUT2: the keeper u_mkp has two copies of each transistor in parallel, so g_k doubles '
        '(and so do its capacitances). Simulated tau: 88.9 ps -> 80.5 ps.', nm],
       shortnames(FB.flatten(cells_of('meta_dut_keeper', ml)), tags), ['g1', 'g2'], ['mq', 'mqb'],
       [fwd('nand2_2, unchanged') + (GREY,), ('CHANGED: keeper u_mkp now nand2_2 (2 copies)', cellis('u_mkp'), RED)],
       colours=latch_col)
    mk('F03_master_latch_forward', 'F03  master latch of DUT4: forward strengthened (nand2_2 -> nand2_4)',
       [eq, 'CHANGE from DUT2: the forward u_mfw has four copies of each transistor in parallel (twice the baseline). '
        'Simulated tau: 88.9 ps -> 102.3 ps (the added capacitance outweighs the added drive).', nm],
       shortnames(FB.flatten(cells_of('meta_dut_forward', ml)), tags), ['g1', 'g2'], ['mq', 'mqb'],
       [('CHANGED: forward u_mfw now nand2_4 (4 copies)', cellis('u_mfw'), RED), kp('nand2_1, unchanged') + (GREY,)],
       colours=latch_col)
    trio = (pref(cells_of('meta_dut_baseline', ml), 'base_') + pref(cells_of('meta_dut_keeper', ml), 'keep_') +
            pref(cells_of('meta_dut_forward', ml), 'fwd_'))
    devs = FB.flatten(trio)
    ranks = ['base_u_mfw', 'base_u_mkp', 'keep_u_mfw', 'keep_u_mkp', 'fwd_u_mfw', 'fwd_u_mkp']
    devs = [dict(d, rank=ranks.index(d['cell'])) for d in devs]
    t3 = {'base_u_mfw': '2f_', 'base_u_mkp': '2k_', 'keep_u_mfw': '3f_', 'keep_u_mkp': '3k_', 'fwd_u_mfw': '4f_', 'fwd_u_mkp': '4k_'}
    mk('F04_master_latch_comparison', 'F04  the three NAND master latches side by side: DUT2 baseline, DUT3 keeper x2, DUT4 forward x2',
       [eq, 'Only the red-bracketed gates differ. tau: 88.9 ps (DUT2), 80.5 ps (DUT3), 102.3 ps (DUT4).',
        'Names: 2/3/4 = DUT2/3/4, f = forward u_mfw, k = keeper u_mkp; P/N = PMOS/NMOS. The gates g1, g2 come from the master door (F05); F01-F03 show them as inputs.'],
       shortnames(devs, t3), [], [],
       [('DUT2 forward (nand2_2)', cellis('base_u_mfw'), GREY), ('DUT2 keeper (nand2_1)', cellis('base_u_mkp'), GREY),
        ('DUT3 forward (nand2_2)', cellis('keep_u_mfw'), GREY), ('DUT3 keeper: nand2_2', cellis('keep_u_mkp'), RED),
        ('DUT4 forward: nand2_4', cellis('fwd_u_mfw'), RED), ('DUT4 keeper (nand2_1)', cellis('fwd_u_mkp'), GREY)],
       colours=[(('base_mq', 'keep_mq', 'fwd_mq'), 'green', 'mq of each latch'),
                (('base_mqb', 'keep_mqb', 'fwd_mqb'), 'salmon', 'mqb of each latch')])
    clkc = [('clk', 'orange', 'clk: clock'), ('clkn', 'yellow', 'clkn: inverted clock')]
    mk('F05_master_door', 'F05  clock inverter and master door of the NAND flip-flops (same in DUT2, DUT3, DUT4)',
       ['clk low -> clkn high: the door is open, g1 = NOT d and g2 = d, so the master latch follows d.',
        'clk high -> clkn low: g1 = g2 = 1, the door closes and the master latch (F01-F04) is left to resolve on its own.'],
       shortnames(FB.flatten(cells_of('meta_dut_baseline', ['u_cki', 'u_mg1', 'u_mg2'])),
                  {'u_cki': 'ck_', 'u_mg1': 'g1_', 'u_mg2': 'g2_'}), ['d', 'clk'], ['g1', 'g2'],
       [('clock inverter u_cki', cellis('u_cki'), GREY), ('door gate u_mg1: g1 = NAND(d, clkn)', cellis('u_mg1'), GREY),
        ('door gate u_mg2: g2 = NAND(g1, clkn)', cellis('u_mg2'), GREY)], colours=clkc)
    mk('F06_slave', 'F06  slave door and slave latch of the NAND flip-flops (same in DUT2, DUT3, DUT4)',
       ['clk high: the slave door passes mq (s1 = NOT mq, s2 = mq) and the slave latch copies it to q.',
        'clk low: s1 = s2 = 1, the slave latch holds q while the master takes the next d.'],
       shortnames(FB.flatten(cells_of('meta_dut_baseline', ['u_sg1', 'u_sg2', 'u_sfw', 'u_skp'])),
                  {'u_sg1': 's1_', 'u_sg2': 's2_', 'u_sfw': 'sf_', 'u_skp': 'sk_'}), ['mq', 'clk'], ['q'],
       [('slave door u_sg1', cellis('u_sg1'), GREY), ('slave door u_sg2', cellis('u_sg2'), GREY),
        ('slave latch u_sfw', cellis('u_sfw'), GREY), ('slave latch u_skp', cellis('u_skp'), GREY)],
       colours=[('clk', 'orange', 'clk: clock'), ('mq', 'green', 'mq: from the master latch')])
    mk('F07_library_flipflop', 'F07  library flip-flop dffq_1 (DUT1, and the early observer): the paper\'s "regular library FF"',
       ['Master: a clocked inverter takes D into net4; inverter net4 -> net0 and a clocked inverter back into net4 close the loop',
        '(this loop is what goes metastable). On the clock edge the pass gate tn9/tp7 hands net0 to the slave (net2 -> net3); Q = NOT net3.'],
       strip(shortnames(FB.flatten([('dut1', 'dffq_1', {'D': 'D', 'CLK': 'CLK', 'Q': 'Q'})]), lib=True), 'dut1.'),
       ['D', 'CLK'], ['Q'],
       [('clock inverters', devname('tn3', 'tp3', 'tn4', 'tp4'), GREY),
        ('master: clocked input + clocked feedback', devname('tn5', 'tn8', 'tp12', 'tp11', 'tn6', 'tn7', 'tp6', 'tp5'), GREY),
        ('master inverter, pass gate, slave feedback', devname('tn0', 'tp0', 'tn9', 'tp7', 'tn11', 'tn12', 'tp9', 'tp10'), GREY),
        ('slave inverter', devname('tn10', 'tp8'), GREY), ('output', devname('tn1', 'tp1'), GREY)],
       colours=[(('CLK', 'cki'), 'orange', 'clock'), ('ncki', 'yellow', 'inverted clock'),
                ('net4', 'green', 'master loop node'), ('net0', 'salmon', 'master loop node (complement)')])
    cs = [{**m, **{t: ({'control': 'ua_0'}.get(m[t], m[t])) for t in 'dgsb'}} for m in BM.DELAY_DEVICES]
    mk('F08_current_starved_stage', 'F08  current-starved stage of the delay line: MP, MN, MC and the timing capacitor MCT',
       ['launch rises -> MN turns on -> slow discharges through MN and MC. The gate voltage ua[0] on MC limits that current,',
        'so ua[0] sets how fast slow falls, i.e. the delay d. MCT (gate on slow) is the charge that has to be removed.'],
       [dict(d, show=d['name']) for d in FB.flatten([], cs)], ['launch', 'ua_0'], ['slow'],
       [('MP: fast pull-up', cellis('MP'), GREY), ('starved pull-down MN + MC', cellis('MN', 'MC'), GREY),
        ('MCT: timing capacitor', cellis('MCT'), GREY)],
       colours=[('ua_0', 'magenta', 'ua[0]: analog control voltage'), ('slow', 'green', 'slow: the ramp that sets d')])
    dl = FB.blocks()['delay_line']
    ddev = [dict(d, rank=FB.ORDER.index(d['cell'])) for d in dl[2]]
    dtag = {'iso0': 'i0_', 'iso1': 'i1_', 'XR0': 'r0_', 'XR1': 'r1_', 'XR2': 'r2_'}
    ddev = shortnames([d for d in ddev if d['cell'] in dtag], dtag) + [dict(d, show=d['name']) for d in ddev if d['cell'] not in dtag]
    mk('F09_delay_line', 'F09  the whole delay line: capture_local -> early_clk',
       ['iso0, iso1 buffer the capture edge into launch. MP/MN/MC/MCT: the current-starved stage of F08 (ua[0] sets how fast slow falls).',
        'XR0-XR2 square the slow ramp back into a sharp edge: early_clk, which clocks the early observer a time d after capture.'],
       ddev, dl[3], dl[4],
       [('isolation buffer iso0, iso1', cellis('iso0', 'iso1'), GREY), ('current-starved stage', cellis('MP', 'MN', 'MC'), GREY),
        ('MCT', cellis('MCT'), GREY), ('restoring inverters XR0, XR1, XR2', cellis('XR0', 'XR1', 'XR2'), GREY)],
       colours=[('capture_local', 'orange', 'capture edge in'), ('ua_0', 'magenta', 'ua[0]: control voltage'),
                ('slow', 'green', 'slow ramp'), ('early_clk', 'yellow', 'early_clk out')])
    sel = FB.blocks()['selector']
    mk('F10_selector', 'F10  selector mux4_1: passes one of the four flip-flop outputs q[0..3] to selected_q',
       ['cfg[0] (S0) picks one input of each pair with clocked inverters; cfg[1] (S1) picks the pair with two transmission gates',
        '(the floating transistors in the middle); the output inverter drives selected_q.'],
       strip(shortnames(sel[2], lib=True), 'select_dut.'), sel[3], sel[4],
       [('select inverters', devname('MN1', 'MP1', 'MN2', 'MP5'), GREY),
        ('S0 level: clocked inverters; S1 level: transmission gates', lambda d: 'MN' in d['name'] or 'MP' in d['name'], GREY),
        ('output inverter', devname('instance_22', 'instance_1'), GREY)],
       colours=[(('cfg[0]', 'sel1_n'), 'yellow', 'S0 and its inverse'), (('cfg[1]', 'sel2_n'), 'magenta', 'S1 and its inverse')])
    mk('F11_controller_register', 'F11  dffrnq_1: the flip-flop used for every controller register (34 of them)',
       ['Same plan as F07 with a NAND in each loop: RN = 0 forces both NANDs to output 1, so net4 = 1 and Q = 0 whatever the clock does.',
        'Master loop: net1 -> inverter -> net2 -> NAND(net2, RN) -> net1. Slave: NAND(net8, RN) -> net4 -> Q = NOT net4.'],
       strip(shortnames(FB.flatten([('reg', 'dffrnq_1', {'D': 'D', 'RN': 'RN', 'CLK': 'CLK', 'Q': 'Q'})]), lib=True), 'reg.'),
       ['D', 'RN', 'CLK'], ['Q'],
       [('clock inverters', devname('tn10', 'tp8', 'tn13', 'tp11'), GREY),
        ('master: clocked input + NAND(net2, RN)', devname('tn11', 'tn15', 'tp9', 'tp15', 'tn14', 'tn8', 'tn9', 'tp7', 'tp6', 'tp12'), GREY),
        ('slave NAND(net8, RN)', devname('tn4', 'tn5', 'tp4', 'tp5'), GREY),
        ('master inverter, pass gate, slave feedback', devname('tn18', 'tp18', 'tn0', 'tp2', 'tn1', 'tn12', 'tp3', 'tp10'), GREY),
        ('output', devname('tn3', 'tp1'), GREY)],
       colours=[(('CLK', 'cki'), 'orange', 'clock'), ('ncki', 'yellow', 'inverted clock'), ('RN', 'magenta', 'reset (active low)'),
                ('net1', 'green', 'master loop node'), ('net2', 'salmon', 'master loop node (complement)')])

    def mg(name, *a, **kw):
        if only and name not in only:
            return
        made[name] = PG.gsheet(OUT / f'{name}.sch', *a, **kw)
    cols = {'u_cki': 0, 'u_mg1': 1, 'u_mg2': 1, 'u_mfw': 2, 'u_mkp': 2, 'u_sg1': 3, 'u_sg2': 3, 'u_sfw': 4, 'u_skp': 4}
    gcol = [('clk', 'orange', 'clk'), ('clkn', 'yellow', 'clkn: inverted clock'),
            ('mq', 'green', 'mq: master node'), ('mqb', 'salmon', 'mqb: master node (complement)')]
    gnote = ['clk low: the master door passes d into the master latch (mq). clk high: the door shuts, the master latch holds or resolves,',
             'and the slave door copies mq to the slave latch, which drives q. A late clock edge can leave mq/mqb between 0 and 1 (metastable).']
    for code, sub, what, chg in [('G01', 'meta_dut_baseline', 'DUT2 baseline NAND flip-flop: forward nand2_2, keeper nand2_1', ()),
                                 ('G02', 'meta_dut_keeper', 'DUT3 NAND flip-flop: keeper strengthened to nand2_2', ('u_mkp',)),
                                 ('G03', 'meta_dut_forward', 'DUT4 NAND flip-flop: forward strengthened to nand2_4', ('u_mfw',))]:
        insts = [(n, 'cell', c, conns) for n, c, conns in FB.dut_cells(sub)]
        caps = [(0, 'clock inverter', GREY), (1, 'master door (F05)', GREY),
                (2, 'master latch (F01-F04)' + ('  CHANGED' if chg else ''), RED if chg else GREY),
                (3, 'slave door (F06)', GREY), (4, 'slave latch (F06)', GREY)]
        mg(f'{code}_{sub}_gates', f'{code}  {what} (gate level)', gnote, insts, ['d', 'clk'], ['q'], cols, caps,
           colours=gcol, changed=chg)
    top = {i['name']: i for _, i in BM.TOP}
    def cell(n):
        i = top[n]; return (n, 'cell', i['cell'].replace(BM.LIB, ''), dict(i['conns']))
    fe = [cell('data0'), cell('data1'), cell('cap0'), cell('cap1'), cell('u_dut1')]
    for _box, nm_, sub, nets in BM.TOP_SUB:
        if sub.startswith('meta_dut'):
            fe.append((nm_, 'block', sub, dict(zip(['d', 'clk', 'q'], nets))))
    fe += [cell('select_dut'), cell('iso0'), cell('iso1'),
           ('delay', 'block', 'delay_line', {'launch': 'capture_iso', 'control': 'ua[0]', 'sample_clk': 'early_clk'}),
           cell('early_observer'), cell('monitor_capture_a'), cell('monitor_capture_b'), cell('monitor_early_a'),
           cell('monitor_early_b')]
    fcols = {'data0': 0, 'cap0': 0, 'data1': 1, 'cap1': 1, 'u_dut1': 2, 'u_dut2': 2, 'u_dut3': 2, 'u_dut4': 2,
             'select_dut': 3, 'iso0': 4, 'iso1': 4, 'delay': 5, 'early_observer': 6, 'monitor_capture_a': 6,
             'monitor_capture_b': 7, 'monitor_early_a': 6, 'monitor_early_b': 7}
    order = ['data0', 'cap0', 'data1', 'cap1', 'u_dut1', 'u_dut2', 'u_dut3', 'u_dut4', 'select_dut', 'iso0', 'iso1', 'delay',
             'early_observer', 'monitor_capture_a', 'monitor_early_a', 'monitor_capture_b', 'monitor_early_b']
    fe.sort(key=lambda t: order.index(t[0]))
    mg('G04_front_end', 'G04  front end (gate level): data in, capture edge, four flip-flops, selector, delay line, early sample',
       ['capture (from the controller) clocks all four flip-flops at once; cfg[1:0] picks which one the selector passes on (selected_q).',
        'The same edge, delayed by d (set by ua[0]) in the delay line, becomes early_clk: the early observer samples selected_q then.',
        'The controller (not drawn) samples selected_q again 50 ns and 100 ns later and compares. Monitors copy both clocks to pins.'],
       fe, ['ui_in[6]', 'capture', 'cfg[0]', 'cfg[1]', 'ua[0]'], ['selected_q', 'early_q', 'uio_out[4]', 'uio_out[5]'], fcols,
       [(0, 'input buffers', GREY), (2, 'flip-flops under test: DUT1-DUT4', GREY), (3, 'selector', GREY),
        (4, 'isolation', GREY), (5, 'delay line (F08, F09)', GREY), (6, 'early observer, monitors', GREY)],
       colours=[(('capture', 'capture_local'), 'orange', 'capture edge'), ('early_clk', 'yellow', 'early_clk: capture delayed by d'),
                ('ua[0]', 'magenta', 'ua[0]: delay control'), ('selected_q', 'green', 'selected_q: output of the chosen flip-flop')])
    return made

if __name__ == '__main__':
    PR.write_symbols(OUT)
    for k, v in sheets(sys.argv[1:] or None).items():
        print(k, v)

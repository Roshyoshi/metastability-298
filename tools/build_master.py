#!/usr/bin/env python3
"""Build the master netlist and inventory for the metastability characterizer.

Single source of truth for every diagram, schematic and layout:
  * the GF180 standard-cell CDL netlists in pdk_cells/cdl/
  * the controller netlist netlist/controller_synth.v: src/gf180/compact_control.v as a flat list of
    cells, written by tools/controller_netlist.py
  * the front end, described below exactly as in rtl/meta_top.v and rtl/meta_duts.v
    (including the isolation buffer iso0/iso1)

Outputs (netlist/):
  chip.cdl            hierarchical CDL netlist of the whole tile (LVS reference)
  inventory.csv       every cell instance: flow box, block, instance, cell, transistors
  transistors.csv     every transistor, flattened: path, type, W, L, D, G, S, B
  flowbox_summary.csv transistor and cell counts per flow box
"""
import csv, re, sys
from collections import Counter, defaultdict, OrderedDict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CDL_DIR = ROOT / 'pdk_cells' / 'cdl'
OUT = ROOT / 'netlist'
LIB = 'gf180mcu_fd_sc_mcu7t5v0__'

# ------------------------------------------------------------------ standard cells
def _num(v):
    v = v.strip().lower()
    mult = {'u': 1e-6, 'n': 1e-9, 'p': 1e-12, 'f': 1e-15, 'm': 1e-3}
    if v and v[-1] in mult:
        return float(v[:-1]) * mult[v[-1]]
    return float(v)

def parse_cdl(path):
    text = path.read_text().replace('\n+', ' ')
    cells = {}
    cur = None
    for line in text.splitlines():
        s = line.strip()
        if not s or s.startswith('*'):
            continue
        tok = s.split()
        if tok[0].upper() == '.SUBCKT':
            cur = {'name': tok[1], 'pins': tok[2:], 'devices': []}
        elif tok[0].upper() == '.ENDS':
            cells[cur['name']] = cur
            cur = None
        elif cur is not None and tok[0][0] in 'Mm':
            d, g, s_, b, model = tok[1:6]
            prm = {k.upper(): _num(v) for k, v in (t.split('=') for t in tok[6:] if '=' in t)}
            cur['devices'].append({'name': tok[0], 'd': d, 'g': g, 's': s_, 'b': b, 'model': model,
                                   'W': prm.get('W'), 'L': prm.get('L'), 'm': prm.get('M', 1.0)})
        elif cur is not None and tok[0][0] in 'Dd':
            # diode: name anode cathode model area perimeter (5 V library), or with area= / pj= (3.3 V library)
            kv = {k.lower(): v for k, v in (t.split('=') for t in tok[4:] if '=' in t)}
            area = kv['area'] if 'area' in kv else tok[4]
            pj = kv['pj'] if 'pj' in kv else tok[5]
            cur.setdefault('diodes', []).append({'name': tok[0], 'a': tok[1], 'c': tok[2], 'model': tok[3],
                                                 'area': _num(area), 'pj': _num(pj)})
    for c in cells.values():
        c.setdefault('diodes', [])
    return cells

CELLS = {}
for p in sorted(CDL_DIR.glob('*.cdl')):
    CELLS.update(parse_cdl(p))

def ntran(cell):
    return sum(int(d['m']) for d in CELLS[cell]['devices'])

# Supply pins of every mcu7t5v0 cell: VDD VNW -> VDPWR, VPW VSS -> VGND
SUPPLY = {'VDD': 'VDPWR', 'VNW': 'VDPWR', 'VPW': 'VGND', 'VSS': 'VGND'}

# ------------------------------------------------------------------ controller (Yosys)
def parse_yosys(path):
    txt = path.read_text()
    inst = []
    for m in re.finditer(r'(' + LIB + r'\w+)\s+(\S+)\s*\((.*?)\);', txt, re.S):
        cell, name, body = m.groups()
        conns = OrderedDict()
        for pm in re.finditer(r'\.(\w+)\(([^)]*)\)', body):
            net = pm.group(2).strip()
            net = {"1'h1": 'VDPWR', "1'h0": 'VGND'}.get(net, net)
            conns[pm.group(1)] = net
        inst.append({'cell': cell, 'name': name.strip('\\'), 'conns': conns})
    return inst

CTRL = parse_yosys(OUT / 'controller_synth.v')
# A gate must not connect straight to the supply rail, so a tie-high cell drives any input the netlist
# ties to logic 1, as the digital flow would insert. compact_control has none.
_tied = [(i, p) for i in CTRL for p, n in i['conns'].items() if n == 'VDPWR']
if _tied:
    CTRL.append({'cell': LIB + 'tieh', 'name': 'tie_hi', 'conns': OrderedDict([('Z', 'tie_hi_z')])})
    for i, p in _tied:
        i['conns'][p] = 'tie_hi_z'

# Controller instance -> block. The eight blocks are the eight parts of the design note at the top of
# src/gf180/compact_control.v, in the same order. Each entry: block, flow box, title, instance pattern.
CTRL_BLOCKS = [
    ('trial_clock', 'Sequencer', 'Trial clock: a (= capture) and b step 00, 01, 11, 10 on clk; a_n = NOT a',
     r'^(a_ff|a_inv|b_ff)$'),
    ('start', 'Sequencer', 'Start: request = ena AND start, then start_meta and run, both clocked by a_n rising',
     r'^(request_and|start_meta_ff|run_ff)$'),
    ('readings', 'Late observers + compare',
     'Later readings: l1 on b falling (50 ns), l2 on a_n rising (100 ns); event_bit = early XOR l2, bad_bit = l1 XOR l2',
     r'^(l1_ff|l2_ff|event_xor|bad_xor)$'),
    ('count_pulse', 'Sequencer',
     'Count pulse: allow_count takes run AND NOT n_16 on b falling; tick_n = NOT (b AND allow_count)',
     r'^(finished_inv|want_and|allow_ff|tick_nand)$'),
    ('trial_counter', 'Counter N',
     'Trial counter n: each bit clocked by the bit below, except n_1 by n_n_0; n_16 rises on count 65,535',
     r'^n\d+_(ff|inv)$'),
    ('event_counter', 'Counter K',
     'Event counter k: bit 0 takes k_0 XOR event_bit on each count; each later bit is clocked by the bit below',
     r'^(k0_xor|k\d+_(ff|inv))$'),
    ('status', 'Status', 'Status: fault takes fault OR bad_bit on each count; done takes n_16 on b falling; busy = run AND NOT done',
     r'^(fault_or|fault_ff|done_ff|done_inv|busy_and)$'),
    ('readout', 'Readout', 'Readout: uo_out = k[7:0] when byte_sel (ui_in_0) is 0, k[15:8] when it is 1',
     r'^byte\d+_mux$'),
]

def ctrl_block(inst):
    for blk, box, title, pat in CTRL_BLOCKS:
        if re.match(pat, inst):
            return blk, box
    raise ValueError('controller instance in no block: ' + inst)

OUTPUT_PINS = {'Q', 'Z', 'ZN'}
def outputs(i):
    return [n for p, n in i['conns'].items() if p in OUTPUT_PINS]
def inputs(i):
    return [n for p, n in i['conns'].items() if p not in OUTPUT_PINS]

flops = [i for i in CTRL if 'dff' in i['cell']]
comb = [i for i in CTRL if 'dff' not in i['cell']]
for i in CTRL:
    i['block'], i['box'] = ctrl_block(i['name'])
shared = []

# ------------------------------------------------------------------ front end (rtl/meta_top.v, meta_duts.v)
def X(name, cell, **pins):
    return {'name': name, 'cell': LIB + cell, 'conns': OrderedDict(pins)}

def nand_dut(fw, kp):
    return [
        X('u_cki', 'inv_1', I='clk', ZN='clkn'),
        X('u_mg1', 'nand2_1', A1='d', A2='clkn', ZN='g1'),
        X('u_mg2', 'nand2_1', A1='g1', A2='clkn', ZN='g2'),
        X('u_mfw', fw, A1='mqb', A2='g1', ZN='mq'),
        X('u_mkp', kp, A1='mq', A2='g2', ZN='mqb'),
        X('u_sg1', 'nand2_1', A1='mq', A2='clk', ZN='s1'),
        X('u_sg2', 'nand2_1', A1='s1', A2='clk', ZN='s2'),
        X('u_sfw', 'nand2_1', A1='sqb', A2='s1', ZN='q'),
        X('u_skp', 'nand2_1', A1='q', A2='s2', ZN='sqb'),
    ]

DUT_SUBCKTS = OrderedDict([
    ('meta_dut_baseline', nand_dut('nand2_2', 'nand2_1')),
    ('meta_dut_keeper', nand_dut('nand2_2', 'nand2_2')),
    ('meta_dut_forward', nand_dut('nand2_4', 'nand2_1')),
])

# Custom delay line (rtl blackbox meta_delay_analog); devices as simulated.
DELAY_DEVICES = [
    {'name': 'MP', 'd': 'slow', 'g': 'launch', 's': 'VDPWR', 'b': 'VDPWR', 'model': 'pfet_05v0', 'W': 1.22e-6, 'L': 0.5e-6, 'm': 1},
    {'name': 'MN', 'd': 'slow', 'g': 'launch', 's': 'foot', 'b': 'VGND', 'model': 'nfet_05v0', 'W': 0.82e-6, 'L': 0.6e-6, 'm': 1},
    {'name': 'MC', 'd': 'foot', 'g': 'control', 's': 'VGND', 'b': 'VGND', 'model': 'nfet_05v0', 'W': 0.36e-6, 'L': 0.6e-6, 'm': 1},
    # Timing capacitor (2 fF in the pre-layout simulations), built as an NMOS gate capacitor: gate on node slow,
    # drain, source and body on VGND. W x L = 0.82 x 1.0 um gives about 2.1 fF while slow is above threshold
    # (Cox = 2.27 fF/um2 for the 15.2 nm 5 V oxide, plus overlap and fringe). It lies under the cell's V5_XTOR
    # marker like every transistor of the 7-track library, so Magic extracts it as nfet_05v0 whatever its gate
    # length (open_pdks builds e8daeda7, which the Tiny Tapeout precheck uses, and 5740c4a8). The PDK on ecetesla0
    # in November 2026 named it nfet_06v0 instead; both names wrap the same model card with the same parameters.
    {'name': 'MCT', 'd': 'VGND', 'g': 'slow', 's': 'VGND', 'b': 'VGND', 'model': 'nfet_05v0', 'W': 0.82e-6, 'L': 1.0e-6, 'm': 1},
]
DELAY_CELLS = [
    X('XR0', 'inv_1', I='slow', ZN='r0'),
    X('XR1', 'inv_2', I='r0', ZN='r1'),
    X('XR2', 'inv_2', I='r1', ZN='sample_clk'),
]

# Top-level instances: (flow box, instance, kind, connections)
TOP = [
    ('Ring oscillator + divider (off chip): data input buffers', X('data0', 'inv_2', I='ui_in[6]', ZN='data_b')),
    ('Ring oscillator + divider (off chip): data input buffers', X('data1', 'inv_2', I='data_b', ZN='data_local')),
    ('Capture edge', X('cap0', 'inv_2', I='capture', ZN='capture_b')),
    ('Capture edge', X('cap1', 'inv_2', I='capture_b', ZN='capture_local')),
    ('Flip-flops under test', X('u_dut1', 'dffq_1', D='data_local', CLK='capture_local', Q='q[0]')),
    # the selection bits come straight from the pins: compact_control does not latch them
    ('Selector', X('select_dut', 'mux4_1', I0='q[0]', I1='q[1]', I2='q[2]', I3='q[3]', S0='ui_in[3]', S1='uio_in[6]', Z='selected_q')),
    ('Adjustable delay', X('iso0', 'inv_1', I='capture_local', ZN='capture_iso_b')),
    ('Adjustable delay', X('iso1', 'inv_2', I='capture_iso_b', ZN='capture_iso')),
    # ua[0] reaches the delay line's control gate over about 170 um of metal and has no driver on the tile;
    # the library's antenna cell (two reverse-biased diodes) protects that gate during fabrication
    ('Adjustable delay', X('ant_ctrl', 'antenna', I='ua[0]')),
    ('Early observer', X('early_observer', 'dffq_1', D='selected_q', CLK='early_clk', Q='early_q')),
    ('Hold results + readout', X('monitor_capture_a', 'inv_1', I='capture_local', ZN='capmon_n')),
    ('Hold results + readout', X('monitor_capture_b', 'inv_2', I='capmon_n', ZN='uio_out[4]')),
    ('Hold results + readout', X('monitor_early_a', 'inv_1', I='early_clk', ZN='earlymon_n')),
    ('Hold results + readout', X('monitor_early_b', 'inv_2', I='earlymon_n', ZN='uio_out[5]')),
]
# Pin drivers for rtl/meta_top.v's constant outputs:  assign uio_oe = ena ? 8'b00111110 : 8'b0;
# assign uio_out = {2'b00, ..., 1'b0}.  Every output pin gets its own driver cell (a tie-low cell for a constant 0,
# a buffer from ena for uio_oe[5:1]) so that no two tile pins are shorted together by metal: each pin is then a
# distinct net, which keeps LVS port matching exact.
PIN_DRIVERS = [X(f'oe_buf{k}', 'buf_1', I='ena', Z=f'uio_oe[{k}]') for k in range(1, 6)] + \
              [X(f'tielo_{p.replace("[", "").replace("]", "")}', 'tiel', ZN=p)
               for p in ('uio_oe[0]', 'uio_oe[6]', 'uio_oe[7]', 'uio_out[0]', 'uio_out[6]', 'uio_out[7]')]
TOP += [('Hold results + readout', i) for i in PIN_DRIVERS]
TOP_SUB = [
    ('Flip-flops under test', 'u_dut2', 'meta_dut_baseline', ['data_local', 'capture_local', 'q[1]']),
    ('Flip-flops under test', 'u_dut3', 'meta_dut_keeper', ['data_local', 'capture_local', 'q[2]']),
    ('Flip-flops under test', 'u_dut4', 'meta_dut_forward', ['data_local', 'capture_local', 'q[3]']),
    ('Adjustable delay', 'delay', 'meta_delay_analog', ['capture_iso', 'ua[0]', 'early_clk']),
]
# ------------------------------------------------------------------ flip-flop bank (revision of 25 Nov 2026)
# A second set of flip-flops under test with its own capture copy, data input, selector and early observer.
# The early observer of the bank is clocked from a pin (ui_in[5]) by the bench, not by the on-chip delay line.
# Two 2:1 multiplexers (join_q, join_e), selected by ui_in[7], give the controller either the existing
# selected output and early sample (ui_in[7] = 0: the tile as before) or those of the bank (ui_in[7] = 1).
#   bank_n1  N1  NAND master-slave flip-flop of 3.3 V cells (gf180mcu_as_sc_mcu7t3v3), forward and keeper nand2_4
#   bank_n2  N2  jamb-latch flip-flop of 3.3 V transistors (j3a); only when BANK_N2 is True
#   bank_n3  N3  copy of DUT3 (meta_dut_keeper), the same circuit through the new path
# Bank selection {ui_in[2], ui_in[1]}: 00 N1, 01 N2, 10 N3, 11 constant 0 (a control: no events possible).
LIB3 = 'gf180mcu_as_sc_mcu7t3v3__'
BANK_N2 = True

def X3(name, cell, **pins):
    return {'name': name, 'cell': LIB3 + cell, 'conns': OrderedDict(pins)}

def nand3_dut():
    """N1: the block n3ffb: NAND master-slave flip-flop of 3.3 V library cells,
    forward and keeper gates nand2_4, the rest nand2_2 / inv_2. Pins of the 3.3 V cells: A, B -> Y."""
    return [
        X3('u_cki', 'inv_2', A='clk', Y='clkn'),
        X3('u_mg1', 'nand2_2', A='clkn', B='d', Y='g1'),
        X3('u_mg2', 'nand2_2', A='clkn', B='g1', Y='g2'),
        X3('u_mfw', 'nand2_4', A='g1', B='mqb', Y='mq'),
        X3('u_mkp', 'nand2_4', A='g2', B='mq', Y='mqb'),
        X3('u_sg1', 'nand2_2', A='clk', B='mq', Y='s1'),
        X3('u_sg2', 'nand2_2', A='clk', B='s1', Y='s2'),
        X3('u_sfw', 'nand2_2', A='s1', B='sqb', Y='q'),
        X3('u_skp', 'nand2_2', A='s2', B='q', Y='sqb'),
    ]

BANK_SUBCKTS = OrderedDict([('meta_dut_n3ffb', nand3_dut())])
# N2: jamb-latch flip-flop j3a of 3.3 V transistors (L = 0.28 um), device for device as olib.build_jamb writes it for
# the sizing 4/2/2/4 with the minimum slave (the reference netlist of the design study,
# that the drawn block meta_j3a matched uniquely). Fields: name, drain, gate, source, bulk, model, W (um).
J3A_DEVICES = [
    ('ckin_0', 'ckb', 'clk', 'VGND', 'VGND', 'nfet_03v3', 1.0),
    ('ckip_0', 'ckb', 'clk', 'VDPWR', 'VDPWR', 'pfet_03v3', 1.38),
    ('din_0', 'db', 'd', 'VGND', 'VGND', 'nfet_03v3', 1.0),
    ('dip_0', 'db', 'd', 'VDPWR', 'VDPWR', 'pfet_03v3', 1.38),
    ('mn1_0', 'x', 'y', 'VGND', 'VGND', 'nfet_03v3', 1.0),
    ('mn1_1', 'x', 'y', 'VGND', 'VGND', 'nfet_03v3', 1.0),
    ('mn1_2', 'x', 'y', 'VGND', 'VGND', 'nfet_03v3', 1.0),
    ('mn1_3', 'x', 'y', 'VGND', 'VGND', 'nfet_03v3', 1.0),
    ('mp1_0', 'x', 'y', 'VDPWR', 'VDPWR', 'pfet_03v3', 1.0),
    ('mp1_1', 'x', 'y', 'VDPWR', 'VDPWR', 'pfet_03v3', 1.0),
    ('mn2_0', 'y', 'x', 'VGND', 'VGND', 'nfet_03v3', 1.0),
    ('mn2_1', 'y', 'x', 'VGND', 'VGND', 'nfet_03v3', 1.0),
    ('mn2_2', 'y', 'x', 'VGND', 'VGND', 'nfet_03v3', 1.0),
    ('mn2_3', 'y', 'x', 'VGND', 'VGND', 'nfet_03v3', 1.0),
    ('mp2_0', 'y', 'x', 'VDPWR', 'VDPWR', 'pfet_03v3', 1.0),
    ('mp2_1', 'y', 'x', 'VDPWR', 'VDPWR', 'pfet_03v3', 1.0),
    ('mwx_0', 'x', 'ckb', 'ax', 'VGND', 'nfet_03v3', 2.0),
    ('mdx_0', 'ax', 'db', 'VGND', 'VGND', 'nfet_03v3', 4.0),
    ('mwy_0', 'y', 'ckb', 'ay', 'VGND', 'nfet_03v3', 2.0),
    ('mdy_0', 'ay', 'd', 'VGND', 'VGND', 'nfet_03v3', 4.0),
    ('sn1_0', 's', 'sb', 'VGND', 'VGND', 'nfet_03v3', 0.5),
    ('sp1_0', 's', 'sb', 'VDPWR', 'VDPWR', 'pfet_03v3', 0.3),
    ('sn2_0', 'sb', 's', 'VGND', 'VGND', 'nfet_03v3', 0.5),
    ('sp2_0', 'sb', 's', 'VDPWR', 'VDPWR', 'pfet_03v3', 0.3),
    ('swa_0', 'sb', 'clk', 'c1', 'VGND', 'nfet_03v3', 0.3),
    ('sda_0', 'c1', 'x', 'VGND', 'VGND', 'nfet_03v3', 0.3),
    ('swb_0', 's', 'clk', 'c2', 'VGND', 'nfet_03v3', 0.3),
    ('sdb_0', 'c2', 'y', 'VGND', 'VGND', 'nfet_03v3', 0.3),
    ('qon_0', 'q', 'sb', 'VGND', 'VGND', 'nfet_03v3', 1.0),
    ('qop_0', 'q', 'sb', 'VDPWR', 'VDPWR', 'pfet_03v3', 1.38),
    ('qdn_0', 'qn', 's', 'VGND', 'VGND', 'nfet_03v3', 1.0),
    ('qdp_0', 'qn', 's', 'VDPWR', 'VDPWR', 'pfet_03v3', 1.38),
]
BANK_DEVICE_SUBCKTS = OrderedDict([('meta_dut_j3a', [{'name': n, 'd': d, 'g': g, 's': s_, 'b': b, 'model': m, 'W': w * 1e-6,
                                                      'L': 0.28e-6, 'm': 1} for n, d, g, s_, b, m, w in J3A_DEVICES])])
BANK_ZERO = 'bank_zero'          # the tie-low net on the selector inputs without a flip-flop
BANK = [
    ('Bank: trial clock copy', X('bank_a_ff', 'dffq_1', D='bank_b', CLK='clk', Q='bank_a')),
    ('Bank: trial clock copy', X('bank_a_inv', 'inv_1', I='bank_a', ZN='bank_a_n')),
    ('Bank: trial clock copy', X('bank_b_ff', 'dffrnq_1', D='bank_a_n', RN='rst_n', CLK='clk', Q='bank_b')),
    ('Bank: capture edge', X('bank_cap0', 'inv_2', I='bank_a', ZN='bank_cap_b')),
    ('Bank: capture edge', X('bank_cap1', 'inv_2', I='bank_cap_b', ZN='bank_cap')),
    ('Bank: data input', X('bank_data0', 'inv_2', I='uio_in[0]', ZN='bank_data_b')),
    ('Bank: data input', X('bank_data1', 'inv_2', I='bank_data_b', ZN='bank_data')),
    ('Bank: selector', X('bank_select', 'mux4_1', I0='bank_q[0]', I1='bank_q[1]' if BANK_N2 else BANK_ZERO,
                         I2='bank_q[2]', I3=BANK_ZERO, S0='ui_in[1]', S1='ui_in[2]', Z='bank_selected_q')),
    ('Bank: selector', X('bank_tie', 'tiel', ZN=BANK_ZERO)),
    ('Bank: early observer', X('bank_obs0', 'inv_1', I='ui_in[5]', ZN='bank_obs_b')),
    ('Bank: early observer', X('bank_obs1', 'inv_2', I='bank_obs_b', ZN='bank_obs_clk')),
    ('Bank: early observer', X('bank_observer', 'dffq_1', D='bank_selected_q', CLK='bank_obs_clk', Q='bank_early_q')),
    ('Bank: join', X('join_q', 'mux2_1', I0='selected_q', I1='bank_selected_q', S='ui_in[7]', Z='ctrl_q')),
    ('Bank: join', X('join_e', 'mux2_1', I0='early_q', I1='bank_early_q', S='ui_in[7]', Z='ctrl_early')),
]
BANK_SUB = [
    ('Bank: flip-flops under test', 'bank_n1', 'meta_dut_n3ffb', ['bank_data', 'bank_cap', 'bank_q[0]']),
] + ([('Bank: flip-flops under test', 'bank_n2', 'meta_dut_j3a', ['bank_data', 'bank_cap', 'bank_q[1]'])] if BANK_N2 else []) + [
    ('Bank: flip-flops under test', 'bank_n3', 'meta_dut_keeper', ['bank_data', 'bank_cap', 'bank_q[2]']),
]
# The layout of the existing part of the tile is generated exactly as before the bank: its router sees the two
# controller inputs on the nets they had (selected_q, early_q). tools/bank_layout.py then splits each of these
# two nets where its Metal4 column leaves channel 1, so that the controller side becomes the join output.
SPLICE = {'ctrl_q': 'selected_q', 'ctrl_early': 'early_q'}

CTRL_NAME = 'compact_control'
CTRL_PORTS = ['clk20', 'rst_n', 'ena', 'start', 'q_selected', 'early_e', 'byte_sel', 'capture', 'busy', 'done', 'fault'] + \
             [f'result_byte[{k}]' for k in range(8)]
# controller port -> net of the tile
CTRL_MAP = {'clk20': 'clk', 'rst_n': 'rst_n', 'ena': 'ena', 'start': 'ui_in[4]', 'q_selected': 'ctrl_q',
            'early_e': 'ctrl_early', 'byte_sel': 'ui_in[0]', 'capture': 'capture', 'busy': 'uio_out[1]',
            'done': 'uio_out[2]', 'fault': 'uio_out[3]'}
CTRL_MAP.update({f'result_byte[{k}]': f'uo_out[{k}]' for k in range(8)})

TOP_PORTS = ['VDPWR', 'VGND'] + [f'ui_in[{k}]' for k in range(8)] + [f'uo_out[{k}]' for k in range(8)] + \
            [f'uio_in[{k}]' for k in range(8)] + [f'uio_out[{k}]' for k in range(8)] + \
            [f'uio_oe[{k}]' for k in range(8)] + [f'ua[{k}]' for k in range(8)] + ['ena', 'clk', 'rst_n']
TOP_NAME = 'tt_um_metastability_characterizer'

# ------------------------------------------------------------------ writers
def cell_line(inst, rename=lambda n: n):
    cell = CELLS[inst['cell']]
    nets = []
    for p in cell['pins']:
        if p in SUPPLY:
            nets.append(SUPPLY[p])
        else:
            nets.append(rename(inst['conns'][p]))
    return 'X' + inst['name'] + ' ' + ' '.join(nets) + ' ' + inst['cell']

def dev_line(d, prefix='M'):
    return f"{prefix}{d['name']} {d['d']} {d['g']} {d['s']} {d['b']} {d['model']} W={d['W']:.3g} L={d['L']:.3g}"

def write_cdl():
    used = sorted({i['cell'] for i in CTRL} | {i['cell'] for _, i in TOP} | {i['cell'] for _, i in BANK} |
                  {i['cell'] for s in DUT_SUBCKTS.values() for i in s} | {i['cell'] for i in DELAY_CELLS} |
                  {i['cell'] for s in BANK_SUBCKTS.values() for i in s})
    L = ['* Master netlist: metastability characterizer, GF180MCU (gf180mcu_fd_sc_mcu7t5v0, operated at 3.3 V;',
         '* the bank flip-flop N1 uses gf180mcu_as_sc_mcu7t3v3)',
         '* Generated by tools/build_master.py. Do not edit by hand.',
         '* Standard cells: ' + ', '.join(c.replace(LIB, '') for c in used if c.startswith(LIB)),
         '* 3.3 V cells: ' + ', '.join(c.replace(LIB3, '') for c in used if c.startswith(LIB3)), '']
    for c in used:
        L.append(f'.include ../pdk_cells/cdl/{c}.cdl')
    L.append('')
    for name, insts in list(DUT_SUBCKTS.items()) + list(BANK_SUBCKTS.items()):
        L.append(f'.SUBCKT {name} d clk q VDPWR VGND')
        L += [cell_line(i) for i in insts]
        L += ['.ENDS', '']
    for name, devs in BANK_DEVICE_SUBCKTS.items():
        L.append(f'.SUBCKT {name} d clk q VDPWR VGND')
        L += [dev_line(d) for d in devs]
        L += ['.ENDS', '']
    L.append('.SUBCKT meta_delay_analog launch control sample_clk VDPWR VGND')
    L.append('* MP, MN, MC: current-starved inverter. MCT: timing capacitor (NMOS gate capacitor on node slow).')
    L += [dev_line(d) for d in DELAY_DEVICES]
    L += [cell_line(i) for i in DELAY_CELLS]
    L += ['.ENDS', '']
    L.append(f'.SUBCKT {CTRL_NAME} ' + ' '.join(CTRL_PORTS) + ' VDPWR VGND')
    L += [cell_line(i) for i in CTRL]
    L += ['.ENDS', '']
    L.append(f'.SUBCKT {TOP_NAME} ' + ' '.join(TOP_PORTS))
    L.append('Xcontroller ' + ' '.join(CTRL_MAP[p] for p in CTRL_PORTS) + f' VDPWR VGND {CTRL_NAME}')
    for _, i in TOP:
        L.append(cell_line(i))
    for _, name, sub, nets in TOP_SUB:
        L.append(f'X{name} ' + ' '.join(nets) + f' VDPWR VGND {sub}')
    L.append('* Constant outputs: tie-low cells (tielo_*) and ena buffers (oe_buf*), one driver per pin')
    L.append('* Flip-flop bank: trial clock copy, capture and data drivers, selector, early observer, joins')
    for _, i in BANK:
        L.append(cell_line(i))
    for _, name, sub, nets in BANK_SUB:
        L.append(f'X{name} ' + ' '.join(nets) + f' VDPWR VGND {sub}')
    L += ['.ENDS', '']
    (OUT / 'chip.cdl').write_text('\n'.join(L))

def write_inventory():
    rows, trans = [], []
    def add(box, block, path, cell):
        rows.append({'flow_box': box, 'block': block, 'instance': path, 'cell': cell.replace(LIB, '').replace(LIB3, '3v3:'),
                     'transistors': ntran(cell)})
        for d in CELLS[cell]['devices']:
            trans.append({'flow_box': box, 'path': f'{path}/{d["name"]}', 'cell': cell.replace(LIB, '').replace(LIB3, '3v3:'),
                          'type': 'PMOS' if d['model'].startswith('p') else 'NMOS', 'model': d['model'],
                          'W_um': round(d['W'] * 1e6, 3), 'L_um': round(d['L'] * 1e6, 3),
                          'drain': d['d'], 'gate': d['g'], 'source': d['s'], 'bulk': d['b']})
    for box, i in TOP:
        add(box.split(':')[0] if ':' in box else box, 'top', i['name'], i['cell'])
    for box, name, sub, _ in TOP_SUB:
        if sub.startswith('meta_dut'):
            for i in DUT_SUBCKTS[sub]:
                add(box, sub, f'{name}/{i["name"]}', i['cell'])
        else:
            for d in DELAY_DEVICES:
                rows.append({'flow_box': box, 'block': sub, 'instance': f'{name}/{d["name"]}', 'cell': d['model'] + ' (custom)', 'transistors': 1})
                trans.append({'flow_box': box, 'path': f'{name}/{d["name"]}', 'cell': 'custom',
                              'type': 'PMOS' if d['model'].startswith('p') else 'NMOS', 'model': d['model'],
                              'W_um': round(d['W'] * 1e6, 3), 'L_um': round(d['L'] * 1e6, 3),
                              'drain': d['d'], 'gate': d['g'], 'source': d['s'], 'bulk': d['b']})
            for i in DELAY_CELLS:
                add(box, sub, f'{name}/{i["name"]}', i['cell'])
    for i in CTRL:
        add(i['box'], f'{CTRL_NAME}/{i["block"]}', f'controller/{i["name"]}', i['cell'])
    for box, i in BANK:
        add(box, 'bank', i['name'], i['cell'])
    for box, name, sub, _ in BANK_SUB:
        if sub in BANK_DEVICE_SUBCKTS:
            for d in BANK_DEVICE_SUBCKTS[sub]:
                rows.append({'flow_box': box, 'block': sub, 'instance': f'{name}/{d["name"]}', 'cell': d['model'] + ' (custom)', 'transistors': 1})
                trans.append({'flow_box': box, 'path': f'{name}/{d["name"]}', 'cell': 'custom',
                              'type': 'PMOS' if d['model'].startswith('p') else 'NMOS', 'model': d['model'],
                              'W_um': round(d['W'] * 1e6, 3), 'L_um': round(d['L'] * 1e6, 3),
                              'drain': d['d'], 'gate': d['g'], 'source': d['s'], 'bulk': d['b']})
            continue
        for i in (BANK_SUBCKTS.get(sub) or DUT_SUBCKTS[sub]):
            add(box, sub, f'{name}/{i["name"]}', i['cell'])
    for r in rows:
        r['flow_box'] = r['flow_box'].replace('Ring oscillator + divider (off chip)', 'Data input (ring oscillator off chip)')
    for t in trans:
        t['flow_box'] = t['flow_box'].replace('Ring oscillator + divider (off chip)', 'Data input (ring oscillator off chip)')
    diodes = []
    for box, i in TOP:
        for dd in CELLS[i['cell']]['diodes']:
            nets = {'VPW': 'VGND', 'VSS': 'VGND', 'VDD': 'VDPWR', 'VNW': 'VDPWR'}
            conn = lambda n: nets.get(n, i['conns'].get(n, n))
            diodes.append({'flow_box': box, 'path': f'{i["name"]}/{dd["name"]}', 'cell': i['cell'].replace(LIB, ''),
                           'model': dd['model'], 'anode': conn(dd['a']), 'cathode': conn(dd['c']),
                           'area_um2': round(dd['area'] * 1e12, 4), 'perimeter_um': round(dd['pj'] * 1e6, 3)})
    with open(OUT / 'diodes.csv', 'w', newline='') as fh:
        w = csv.DictWriter(fh, fieldnames=list(diodes[0])); w.writeheader(); w.writerows(diodes)
    with open(OUT / 'inventory.csv', 'w', newline='') as fh:
        w = csv.DictWriter(fh, fieldnames=list(rows[0])); w.writeheader(); w.writerows(rows)
    with open(OUT / 'transistors.csv', 'w', newline='') as fh:
        w = csv.DictWriter(fh, fieldnames=list(trans[0])); w.writeheader(); w.writerows(trans)
    summ = OrderedDict()
    for r in rows:
        s = summ.setdefault(r['flow_box'], {'cells': 0, 'transistors': 0, 'types': Counter()})
        s['cells'] += 1; s['transistors'] += r['transistors']; s['types'][r['cell']] += 1
    with open(OUT / 'flowbox_summary.csv', 'w', newline='') as fh:
        w = csv.writer(fh); w.writerow(['flow_box', 'cell_instances', 'transistors', 'cell_types'])
        for k, s in summ.items():
            w.writerow([k, s['cells'], s['transistors'], '; '.join(f'{c} x{n}' for c, n in sorted(s['types'].items()))])
    return rows, trans, summ

if __name__ == '__main__':
    write_cdl()
    rows, trans, summ = write_inventory()
    print(f'{len(rows)} instances, {len(trans)} transistors')
    for k, s in summ.items():
        print(f'  {k:42s} {s["cells"]:4d} instances {s["transistors"]:5d} transistors')

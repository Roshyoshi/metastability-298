#!/usr/bin/env python3
"""Generate the Xschem hierarchy of the whole chip, from the master netlist data.

Levels (press `e` on a symbol in Xschem to descend, Ctrl+e to go back up):
  chip.sch                  -> flow-box blocks
  blocks/<block>.sch        -> standard cells of that block
  cells_tx/<cell>.sch       -> every MOSFET of that cell, with W/L, ad/as/pd/ps

Device parameters come from pdk_cells/sim/cells_jx.spice (the same values used for all
reported simulations), so a simulation of these schematics must reproduce those results.

All paths are written with the placeholder @@ROOT@@; run.sh replaces it with the folder
the kit was unzipped into on ecetesla0.

Also writes preview PNGs (matplotlib) of the cell and block schematics into previews/.
"""
import re, sys, json
from collections import defaultdict, OrderedDict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import build_master as BM

CHIP = Path(__file__).resolve().parent.parent
ROOT = '@@ROOT@@'
PDK = '/usr/local/share/pdk/gf180mcuD'
PDKSYM = PDK + '/libs.tech/xschem/symbols'
HEAD = 'v {xschem version=3.4.4 file_version=1.2}\nG {}\nK {}\nV {}\nS {}\nE {}\n'
LIB = BM.LIB

GLOBAL = {'VDPWR': 'VDD', 'VGND': '0'}
WIRED = True     # transistor-level cells drawn with wires (tools/wired_cells.py)

def san(n):
    """Xschem-safe net name: q[0] -> q_0 (brackets would be read as buses)."""
    return n.replace('[', '_').replace(']', '')

# ------------------------------------------------------------------ simulation device parameters
def parse_sim_cells(path):
    txt = path.read_text().replace('\n+', ' ')
    out, cur = {}, None
    for line in txt.splitlines():
        t = line.split()
        if not t or t[0].startswith('*'):
            continue
        if t[0].upper() == '.SUBCKT':
            cur = {'pins': t[2:], 'dev': []}
            out[t[1].replace(LIB, '')] = cur
        elif t[0].upper() == '.ENDS':
            cur = None
        elif cur is not None and t[0][0] in 'Xx':
            prm = {k.lower(): v for k, v in (x.split('=') for x in t[6:] if '=' in x)}
            prm = {k: (f'{BM._num(v):.6g}' if k in ('w', 'l') else v) for k, v in prm.items()}   # 0.82U -> 8.2e-07
            cur['dev'].append({'name': t[0][1:] if t[0][0] in 'Xx' else t[0], 'd': t[1], 'g': t[2], 's': t[3], 'b': t[4],
                               'model': t[5], **prm})
    return out

SIM = parse_sim_cells(CHIP / 'pdk_cells' / 'sim' / 'cells_jx.spice')
# antenna cell: two diodes, no transistors (gf180mcu_fd_sc_mcu7t5v0__antenna.cdl)
SIM['antenna'] = {'pins': ['I', 'VDD', 'VNW', 'VPW', 'VSS'], 'dev': [],
                  'diodes': [{'name': 'D0', 'a': 'VPW', 'c': 'I', 'model': 'diode_nd2ps_06v0', 'area': '0.2052p', 'pj': '1.86u',
                              'what': 'N+ diffusion in the p-substrate'},
                             {'name': 'D1', 'a': 'I', 'c': 'VNW', 'model': 'diode_pd2nw_06v0', 'area': '0.2052p', 'pj': '1.86u',
                              'what': 'P+ diffusion in the n-well'}]}

FUNC = {
    'inv': 'ZN = NOT I', 'nand2': 'ZN = NOT (A1 AND A2)', 'nand3': 'ZN = NOT (A1 AND A2 AND A3)',
    'nand4': 'ZN = NOT (A1 AND A2 AND A3 AND A4)', 'nor2': 'ZN = NOT (A1 OR A2)', 'nor3': 'ZN = NOT (A1 OR A2 OR A3)',
    'nor4': 'ZN = NOT (A1 OR A2 OR A3 OR A4)', 'and2': 'Z = A1 AND A2', 'and3': 'Z = A1 AND A2 AND A3',
    'and4': 'Z = A1 AND A2 AND A3 AND A4', 'or2': 'Z = A1 OR A2', 'aoi21': 'ZN = NOT ((A1 AND A2) OR B)',
    'aoi22': 'ZN = NOT ((A1 AND A2) OR (B1 AND B2))', 'oai21': 'ZN = NOT ((A1 OR A2) AND B)',
    'oai22': 'ZN = NOT ((A1 OR A2) AND (B1 OR B2))', 'xor2': 'Z = A1 XOR A2', 'xnor2': 'ZN = NOT (A1 XOR A2)',
    'mux2': 'Z = I1 if S else I0', 'mux4': 'Z = I0..I3 selected by S1 S0',
    'dffq': 'Q takes D on the rising CLK edge', 'tieh': 'Z = 1 (tie-high cell)',
    'antenna': 'two reverse-biased diodes on I (protect the gate on I while the chip is fabricated)',
    'tiel': 'ZN = 0 (tie-low cell)', 'buf': 'Z = I (buffer)', 'dffrnq': 'Q takes D on the rising CLK edge; RN = 0 clears Q',
}
def family(cell):
    return re.sub(r'_\d+$', '', cell)

OUTS = {'Z', 'ZN', 'Q'}

# ------------------------------------------------------------------ scene (shared by .sch writer and preview)
class Scene:
    def __init__(self, title):
        self.title = title
        self.items = []      # ('inst', sym, x, y, rot, flip, attrs, kind) | ('lab', x, y, flip, net) | ('text', s, x, y, size) | ('pin', kind, x, y, net)
        self.k = 0
    def text(self, s, x, y, size=0.3):
        self.items.append(('text', s, x, y, size))
    def lab(self, x, y, net, right):
        self.k += 1
        self.items.append(('lab', x, y, 1 if right else 0, net, f'l{self.k}'))
    def pin(self, kind, x, y, net):
        self.k += 1
        self.items.append(('pin', kind, x, y, net, f'p{self.k}'))
    def inst(self, sym, x, y, attrs, kind, rot=0, flip=0):
        self.items.append(('inst', sym, x, y, rot, flip, attrs, kind))
    def wire(self, x1, y1, x2, y2, net):
        self.items.append(('wire', x1, y1, x2, y2, net))
    def sch(self):
        L = []
        for it in self.items:
            if it[0] == 'text':
                _, s, x, y, size = it
                L.append(f'T {{{s}}} {x} {y} 0 0 {size} {size} {{}}')
            elif it[0] == 'lab':
                _, x, y, flip, net, nm = it
                L.append(f'C {{devices/lab_pin.sym}} {x} {y} 0 {flip} {{name={nm} lab={net}}}')
            elif it[0] == 'raw':
                L.append(it[1])
            elif it[0] == 'wire':
                _, x1, y1, x2, y2, net = it
                L.append(f'N {x1} {y1} {x2} {y2} {{lab={net}}}')
            elif it[0] == 'supply':
                _, sym, x, y, net, nm = it
                L.append(f'C {{{sym}}} {x} {y} 0 0 {{name={nm} lab={net}}}')
            elif it[0] == 'pin':
                _, kind, x, y, net, nm = it
                L.append(f'C {{devices/{kind}.sym}} {x} {y} 0 0 {{name={nm} lab={net}}}')
            else:
                _, sym, x, y, rot, flip, attrs, kind = it
                L.append(f'C {{{sym}}} {x} {y} {rot} {flip} {{{attrs}}}')
        return HEAD + '\n'.join(L) + '\n'

# MOSFET symbol pins (gf180 PDK nfet_06v0/pfet_06v0 symbols, as used in the Task 2 kit)
MOSPIN = {'nfet': {'d': (20, -30), 'g': (-20, 0), 's': (20, 30), 'b': (20, 0)},
          'pfet': {'s': (20, -30), 'g': (-20, 0), 'd': (20, 30), 'b': (20, 0)}}

def mos(sc, d, x, y, nets):
    kind = 'pfet' if d['model'].startswith('p') else 'nfet'
    W = float(d['w']) * 1e6; L = float(d['l']) * 1e6
    mname = d['name'] if d['name'].upper().startswith('M') else 'M' + d['name']
    attrs = (f'name={mname} L={round(L, 4):g}u W={round(W, 4):g}u nf=1 m=1 ad={d["ad"]} as={d["as"]} pd={d["pd"]} ps={d["ps"]} '
             f'nrd=0 nrs=0 sa=0 sb=0 sd=0 model={d["model"]} spiceprefix=X')
    sc.inst(f'{PDKSYM}/{kind}_06v0.sym', x, y, attrs, ('mos', kind, mname, W, L))
    for t, (dx, dy) in MOSPIN[kind].items():
        sc.lab(x + dx, y + dy, nets[t], right=dx > 0)

def box_pins(ins, outs):
    n = max(len(ins), len(outs)); h = 20 * n + 20; top = -h // 2
    pos = {}
    for i, p in enumerate(ins):
        pos[p] = (-50, top + 20 + 20 * i)
    for i, p in enumerate(outs):
        pos[p] = (50, top + 20 + 20 * i)
    return pos, h, top

def write_box_sym(path, name, ins, outs, title, sub=True):
    pos, h, top = box_pins(ins, outs)
    w = 30 if max([len(p) for p in ins + outs] + [1]) < 6 else 60
    K = 'type=subcircuit\nformat="@name @pinlist @symname"\ntemplate="name=x1"\n'
    L = ['v {xschem version=3.4.4 file_version=1.2}', 'G {}', 'K {' + K + '}', 'V {}', 'S {}', 'E {}',
         f'L 4 -{w} {top} {w} {top} {{}}', f'L 4 -{w} {top+h} {w} {top+h} {{}}',
         f'L 4 -{w} {top} -{w} {top+h} {{}}', f'L 4 {w} {top} {w} {top+h} {{}}']
    for p in ins:
        x, y = pos[p]
        L += [f'L 4 -{w+20} {y} -{w} {y} {{}}', f'B 5 -{w+22.5} {y-2.5} -{w+17.5} {y+2.5} {{name={p} dir=in}}',
              f'T {{{p}}} -{w-3} {y-6} 0 0 0.15 0.15 {{}}']
    for p in outs:
        x, y = pos[p]
        L += [f'L 4 {w} {y} {w+20} {y} {{}}', f'B 5 {w+17.5} {y-2.5} {w+22.5} {y+2.5} {{name={p} dir=out}}',
              f'T {{{p}}} {w-3} {y-6} 0 1 0.15 0.15 {{}}']
    L += [f'T {{{title}}} -{w-2} {top-16} 0 0 0.2 0.2 {{}}', f'T {{@name}} -{w-2} {top+h+4} 0 0 0.15 0.15 {{}}']
    Path(path).write_text('\n'.join(L) + '\n')
    return {p: (pos[p][0] + (-(w - 30) if pos[p][0] < 0 else (w - 30)), pos[p][1]) for p in ins + outs}, h, w

# ------------------------------------------------------------------ level 4: transistor-level cells
def cell_pins(cell):
    pins = [p for p in SIM[cell]['pins'] if p not in ('VDD', 'VNW', 'VPW', 'VSS')]
    return [p for p in pins if p not in OUTS], [p for p in pins if p in OUTS]

def diode_scene(cell):
    sc = Scene(cell)
    sc.text(f'{cell}: {FUNC[family(cell)]}   (gf180mcu_fd_sc_mcu7t5v0 {cell}: 2 diodes, no transistors)', 0, -190, 0.4)
    sc.text('Both diodes are reverse biased for 0 <= V(I) <= VDD. Plasma charge collected by long metal on I during', 0, -160, 0.25)
    sc.text('fabrication leaks to the substrate / n-well through them instead of stressing the gate oxide.', 0, -135, 0.25)
    supply = {'VDD': 'VDD', 'VNW': 'VDD', 'VPW': '0', 'VSS': '0'}
    for k, d in enumerate(SIM[cell]['diodes']):
        x, y = 100 + 300 * k, 0
        sc.inst('devices/diode.sym', x, y, f'name={d["name"]} model={d["model"]} area="{d["area"]} pj={d["pj"]}"', ('diode', d['model']))
        sc.lab(x, y - 30, supply.get(d['a'], d['a']), right=False)
        sc.lab(x, y + 30, supply.get(d['c'], d['c']), right=False)
        sc.text(f'{d["name"]}: {d["what"]}, {d["area"]} m2', x + 20, y + 50, 0.2)
    sc.text('ports', -40, 120, 0.25)
    sc.pin('ipin', 0, 150, 'I')
    return sc

def mos_attrs(d):
    W = float(d['w']) * 1e6; L = float(d['l']) * 1e6
    mname = d['name'] if d['name'].upper().startswith('M') else 'M' + d['name']
    return (f'name={mname} L={round(L, 4):g}u W={round(W, 4):g}u nf=1 m=1 ad={d["ad"]} as={d["as"]} pd={d["pd"]} ps={d["ps"]} '
            f'nrd=0 nrs=0 sa=0 sb=0 sd=0 model={d["model"]} spiceprefix=X'), mname, W, L

def wired_scene(cell):
    import wired_cells as WC
    dev = SIM[cell]['dev']
    ins, outs = cell_pins(cell)
    R = WC.wired_cell(dev, ins, outs, None)
    sc = Scene(cell)
    fam = family(cell)
    sc.text(f'{cell}: {FUNC.get(fam, "")}   ({len(dev)} transistors, gf180mcu_fd_sc_mcu7t5v0 {cell}; '
            f'nfet_05v0 / pfet_05v0, W and L in um)', 0, -140, 0.4)
    sc.text('PMOS hang from VDD at the top, NMOS stand on ground at the bottom; stages run left to right in signal order. '
            'Crossing wires are not connected; a join has a dot.', 0, -110, 0.25)
    for kind, x, y, d in R['inst']:
        attrs, mname, W, L = mos_attrs(d)
        sc.inst(f'{PDKSYM}/{kind}_06v0.sym', x, y, attrs, ('mos', kind, mname, W, L))
    for (x1, y1), (x2, y2), sup in R['supplies']:
        sc.wire(x1, y1, x2, y2, sup)
        sym = 'devices/vdd.sym' if sup == 'VDD' else 'devices/gnd.sym'
        sc.k += 1
        sc.items.append(('supply', sym, x2, y2, sup, f's{sc.k}'))
    for x1, y1, x2, y2, net in R['wires']:
        sc.wire(x1, y1, x2, y2, net)
    for kind, x, y, n in R['ports']:
        sc.pin(kind, x, y, n)
    return sc

def cell_scene(cell):
    if SIM[cell].get('diodes'):
        return diode_scene(cell)
    if WIRED:
        return wired_scene(cell)
    dev = SIM[cell]['dev']
    ins, outs = cell_pins(cell)
    supply = {'VDD': 'VDD', 'VNW': 'VDD', 'VPW': '0', 'VSS': '0'}
    fam = family(cell)
    sc = Scene(cell)
    sc.text(f'{cell}: {FUNC.get(fam, "")}   ({len(dev)} transistors; gf180mcu_fd_sc_mcu7t5v0 {cell}, '
            f'nfet_05v0 / pfet_05v0)', 0, -190, 0.4)
    sc.text('Each transistor is labelled with its drain, gate, source and bulk nets; equal labels are connected.', 0, -160, 0.25)
    # columns: one per gate net, in the order the gates appear; PMOS above, NMOS below
    cols = OrderedDict()
    for d in dev:
        cols.setdefault(d['g'], {'p': [], 'n': []})['p' if d['model'].startswith('p') else 'n'].append(d)
    sc.text('pull-up network (PMOS, bulk on VDD)', -40, -130, 0.22)
    sc.text('pull-down network (NMOS, bulk on 0)', -40, 50, 0.22)
    x = 0
    for g, grp in cols.items():
        for i, d in enumerate(grp['p']):
            mos(sc, d, x, -60 - 110 * i, {k: supply.get(d[k], d[k]) for k in 'dgsb'})
        for i, d in enumerate(grp['n']):
            mos(sc, d, x, 110 + 110 * i, {k: supply.get(d[k], d[k]) for k in 'dgsb'})
        x += 200
    # ports, as pins below the transistors
    y0 = 110 + 110 * max(len(c['n']) for c in cols.values()) + 60
    sc.text('ports', -40, y0 - 30, 0.25)
    for i, p in enumerate(ins):
        sc.pin('ipin', 0 + 140 * i, y0, p)
    for i, p in enumerate(outs):
        sc.pin('opin', 140 * (len(ins) + i) + 60, y0, p)
    return sc

# ------------------------------------------------------------------ block data from the master netlist
def master_blocks():
    """Return OrderedDict block -> dict(title, insts=[(name, kind, ref, conns)], box) using build_master data."""
    blocks = OrderedDict()
    def add(block, title, box):
        blocks.setdefault(block, {'title': title, 'box': box, 'insts': []})
    cellref = lambda c: c.replace(LIB, '')
    add('data_input', 'Data input buffers (ring oscillator moved off chip)', 'Data input')
    add('capture_drivers', 'Capture-edge drivers', 'Capture edge')
    add('duts', 'Four flip-flops under test', 'Flip-flops under test')
    add('selector', 'Selector (one of four flip-flop outputs)', 'Selector')
    add('delay', 'Adjustable delay: isolation buffer + current-starved delay line', 'Adjustable delay')
    add('early_observer', 'Early observer (sample at delay d)', 'Early observer')
    add('monitors', 'Clock monitor buffers to uio_out[4], uio_out[5]', 'Hold results + readout')
    add('pin_drivers', 'Constant outputs: ena buffers for uio_oe[5:1], tie-low cells for the unused outputs', 'Hold results + readout')
    for box, i in BM.TOP:
        blk = {'data0': 'data_input', 'data1': 'data_input', 'cap0': 'capture_drivers', 'cap1': 'capture_drivers',
               'u_dut1': 'duts', 'select_dut': 'selector', 'iso0': 'delay', 'iso1': 'delay', 'ant_ctrl': 'delay',
               'early_observer': 'early_observer'}.get(i['name'], 'pin_drivers' if i in BM.PIN_DRIVERS else 'monitors')
        blocks[blk]['insts'].append((i['name'], 'cell', cellref(i['cell']), dict(i['conns'])))
    for box, name, sub, nets in BM.TOP_SUB:
        if sub.startswith('meta_dut'):
            blocks['duts']['insts'].append((name, 'block', sub, dict(zip(['d', 'clk', 'q'], nets))))
        else:
            blocks['delay']['insts'].append((name, 'block', 'delay_line', dict(zip(['launch', 'control', 'sample_clk'], nets))))
    # DUT sub-blocks and the delay line itself
    for sub, insts in BM.DUT_SUBCKTS.items():
        add(sub, {'meta_dut_baseline': 'NAND flip-flop, baseline (forward nand2_2, keeper nand2_1)',
                  'meta_dut_keeper': 'NAND flip-flop, strengthened keeper (keeper nand2_2)',
                  'meta_dut_forward': 'NAND flip-flop, strengthened forward (forward nand2_4)'}[sub], 'Flip-flops under test')
        for i in insts:
            blocks[sub]['insts'].append((i['name'], 'cell', cellref(i['cell']), dict(i['conns'])))
    add('delay_line', 'Current-starved delay line: MP, MN, MC, timing capacitor MCT (NMOS gate capacitor, about 2 fF), '
                      'three restoring inverters', 'Adjustable delay')
    for d in BM.DELAY_DEVICES:
        blocks['delay_line']['insts'].append((d['name'], 'mos', d, {'d': d['d'], 'g': d['g'], 's': d['s'], 'b': d['b']}))
    for i in BM.DELAY_CELLS:
        blocks['delay_line']['insts'].append((i['name'], 'cell', cellref(i['cell']), dict(i['conns'])))
    # controller flow boxes
    ctrl_names = OrderedDict([('Sequencer', 'sequencer'), ('Late observers', 'late_observers'), ('Compare', 'compare'),
                              ('Counters K and N', 'counters'), ('Hold results + readout', 'hold_status')])
    titles = {'sequencer': 'Sequencer: state register, START/reset synchronizers, shared state decode',
              'late_observers': 'Late observers: late1 (50 ns) and late2 (100 ns) samples',
              'compare': 'Compare: event = early XOR late2, fault = late1 XOR late2',
              'counters': 'Counters: events K (uo_out) and trials N, 8 bits each',
              'hold_status': 'Hold and readout status: busy, done, fault flags'}
    for box, blk in ctrl_names.items():
        add(blk, titles[blk], box)
    for i in BM.CTRL:
        conns = {p: BM.CTRL_MAP.get(n, n) for p, n in i['conns'].items()}
        blocks[ctrl_names[i['box']]]['insts'].append((i['name'], 'cell', cellref(i['cell']), conns))
    return blocks

def pin_dirs(cellkind, ref):
    if cellkind == 'cell':
        ins, outs = cell_pins(ref)
        return ins, outs
    if cellkind == 'block':
        return {'meta_dut_baseline': (['d', 'clk'], ['q']), 'meta_dut_keeper': (['d', 'clk'], ['q']),
                'meta_dut_forward': (['d', 'clk'], ['q']), 'delay_line': (['launch', 'control'], ['sample_clk'])}[ref]
    return [], []

def block_ports(blocks, name, context_nets):
    """Ports of a block: nets used inside it that are also used outside it (or are chip pins)."""
    inside_drv, inside_use = set(), set()
    for iname, kind, ref, conns in blocks[name]['insts']:
        ins, outs = pin_dirs(kind, ref)
        for p, n in conns.items():
            if kind == 'mos':
                inside_use.add(n)
            elif p in outs:
                inside_drv.add(n)
            else:
                inside_use.add(n)
    nets = inside_drv | inside_use
    ext = {n for n in nets if n in context_nets[name]}
    ins = sorted(n for n in ext if n not in inside_drv)
    outs = sorted(n for n in ext if n in inside_drv)
    return ins, outs

# ------------------------------------------------------------------ level 2/3: block schematics
def levelize(insts):
    drv = {}
    for iname, kind, ref, conns in insts:
        ins, outs = pin_dirs(kind, ref)
        for p in outs:
            drv[conns[p]] = iname
    lvl = {}
    by = {i[0]: i for i in insts}
    def L(n, stack=()):
        if n in lvl:
            return lvl[n]
        iname, kind, ref, conns = by[n]
        if kind == 'cell' and 'dff' in ref:
            lvl[n] = 0  # flops start a column of their own (their D side is placed by the layout of feedback)
            return 0
        if n in stack:
            return 0
        ins, outs = pin_dirs(kind, ref)
        best = 0
        for p in ins:
            src = drv.get(conns.get(p))
            if src and src != n:
                best = max(best, L(src, stack + (n,)) + 1)
        lvl[n] = best
        return best
    for i in insts:
        L(i[0])
    # put flops after the logic that feeds them
    maxl = max(lvl.values()) if lvl else 0
    for iname, kind, ref, conns in insts:
        if kind == 'cell' and 'dff' in ref:
            lvl[iname] = maxl + 1
    return lvl

# Hand placement where the arrangement itself explains the circuit (x, y of each instance)
DUT_PLACE = {'u_cki': (200, 330), 'u_mg1': (330, 60), 'u_mg2': (330, 210), 'u_mfw': (560, 60), 'u_mkp': (560, 210),
             'u_sg1': (790, 60), 'u_sg2': (790, 210), 'u_sfw': (1020, 60), 'u_skp': (1020, 210)}
PLACE = {
    'meta_dut_baseline': DUT_PLACE, 'meta_dut_keeper': DUT_PLACE, 'meta_dut_forward': DUT_PLACE,
    'delay_line': {'MP': (240, 60), 'MN': (240, 190), 'MC': (240, 320), 'MCT': (420, 250),
                   'XR0': (580, 150), 'XR1': (740, 150), 'XR2': (900, 150)},
    'delay': {'iso0': (240, 0), 'iso1': (440, 0), 'delay': (700, 0), 'ant_ctrl': (700, 160)},
    'duts': {'u_dut1': (300, 0), 'u_dut2': (300, 130), 'u_dut3': (300, 260), 'u_dut4': (300, 390)},
    'data_input': {'data0': (240, 0), 'data1': (440, 0)},
    'capture_drivers': {'cap0': (240, 0), 'cap1': (440, 0)},
    'monitors': {'monitor_capture_a': (240, 0), 'monitor_capture_b': (440, 0),
                 'monitor_early_a': (240, 130), 'monitor_early_b': (440, 130)},
    'selector': {'select_dut': (300, 0)}, 'early_observer': {'early_observer': (300, 0)},
}
COLUMN_TEXT = {
    'meta_dut_baseline': [(270, -20, 'master door'), (500, -20, 'master latch (measured)'), (730, -20, 'slave door'), (960, -20, 'slave latch')],
}
for k in ('meta_dut_keeper', 'meta_dut_forward'):
    COLUMN_TEXT[k] = COLUMN_TEXT['meta_dut_baseline']
# Pre-layout wiring estimate on the master nodes (as in every reported simulation). Not part of
# chip.cdl: after layout, extraction supplies the real wiring capacitance.
WIRING = {'meta_dut_baseline': True, 'meta_dut_keeper': True, 'meta_dut_forward': True}

def block_scene(name, blk, ins, outs, symref):
    sc = Scene(name)
    sc.text(f'{name}: {blk["title"]}   (flow box: {blk["box"]})', 0, -170, 0.4)
    sc.text('Press e on a cell to see its transistors; Ctrl+e returns here.', 0, -140, 0.25)
    insts = blk['insts']
    place = PLACE.get(name)
    if place is None:
        lvl = levelize([i for i in insts if i[1] in ('cell', 'block')])
        cols = defaultdict(list)
        for i in insts:
            if i[1] in ('cell', 'block'):
                cols[lvl[i[0]]].append(i)
        place = {}
        for c in sorted(cols):
            y = 0
            for iname, kind, ref, conns in cols[c]:
                pins_i, pins_o = pin_dirs(kind, ref)
                pos, h, top = box_pins(pins_i, pins_o)
                place[iname] = (200 + 260 * c, y - top)
                y += h + 70
    for t in COLUMN_TEXT.get(name, []):
        sc.text(t[2], t[0], t[1], 0.25)
    xmax = 0
    for iname, kind, ref, conns in insts:
        x, y = place[iname]
        xmax = max(xmax, x)
        if kind in ('cell', 'block'):
            pins_i, pins_o = pin_dirs(kind, ref)
            pos, h, top = box_pins(pins_i, pins_o)
            wsym = 30 if max([len(p) for p in pins_i + pins_o] + [1]) < 6 else 60
            sc.inst(symref(kind, ref), x, y, f'name=x{iname.strip("_")}', ('box', kind, ref, pins_i, pins_o, wsym, iname))
            for p in pins_i + pins_o:
                px, py = pos[p]
                px = px - (wsym - 30) if px < 0 else px + (wsym - 30)
                sc.lab(x + px, y + py, GLOBAL.get(conns[p], san(conns[p])), right=px > 0)
        elif kind == 'mos':
            nets = {k: GLOBAL.get(v, san(v)) for k, v in conns.items()}
            d = {'name': iname, 'model': ref['model'], 'w': ref['W'], 'l': ref['L'],
                 'ad': f'{ref["W"] * 0.5e-6:.3g}', 'as': f'{ref["W"] * 0.5e-6:.3g}',
                 'pd': f'{2 * (ref["W"] + 0.5e-6):.3g}', 'ps': f'{2 * (ref["W"] + 0.5e-6):.3g}'}
            mos(sc, d, x, y, nets)
        elif kind == 'cap':
            nets = {k: GLOBAL.get(v, san(v)) for k, v in conns.items()}
            sc.inst('devices/capa.sym', x, y, f'name={iname} value={ref} m=1', ('cap', ref))
            sc.lab(x, y - 30, nets['p'], right=False)
            sc.lab(x, y + 30, nets['m'], right=False)
    if WIRING.get(name):
        sc.text('pre-layout wiring estimate (removed for LVS; extraction replaces it)', 500, 330, 0.22)
        for k, (cn, a, b, v) in enumerate([('Cmq', 'mq', '0', '0.25f'), ('Cmqb', 'mqb', '0', '0.25f'), ('Cmut', 'mq', 'mqb', '0.05f')]):
            xc = 540 + 110 * k
            sc.inst('devices/capa.sym', xc, 420, f'name={cn} value={v} m=1', ('cap', v))
            sc.lab(xc, 390, a, right=False); sc.lab(xc, 450, b, right=False)
    yp = 0
    for p in ins:
        sc.pin('ipin', 60, yp, san(p)); yp += 40
    yp = 0
    for p in outs:
        sc.pin('opin', xmax + 260, yp, san(p)); yp += 40
    return sc

# ------------------------------------------------------------------ writers
HIER = OrderedDict([
    ('chip', ['data_input', 'capture_drivers', 'delay', 'duts', 'selector', 'early_observer', 'controller', 'monitors', 'pin_drivers']),
    ('controller', ['sequencer', 'late_observers', 'compare', 'counters', 'hold_status']),
])
SUB_OF = {'meta_dut_baseline': 'duts', 'meta_dut_keeper': 'duts', 'meta_dut_forward': 'duts', 'delay_line': 'delay'}
COMPOSITE_TITLE = {
    'chip': 'tt_um_metastability_characterizer: the whole tile (GF180, 1x2 analog template)',
    'controller': 'Controller (Roshan\'s meta_controller.v after synthesis, 159 cells), split into its flow boxes',
}

def composite_scene(name, children, ports, toplevel_pins=None):
    sc = Scene(name)
    sc.text(f'{name}: {COMPOSITE_TITLE[name]}', 0, -200, 0.45)
    sc.text('Press e on a block to open it; Ctrl+e returns here. Blocks connect through equal net labels.', 0, -165, 0.25)
    x, y, colh = 260, 0, 0
    ncol = 3
    for k, ch in enumerate(children):
        ins, outs = ports[ch]
        pos, h, top = box_pins([san(p) for p in ins], [san(p) for p in outs])
        names = [san(p) for p in ins + outs]
        w = 30 if max([len(p) for p in names] + [1]) < 6 else 60
        cx = 260 + (k % ncol) * 520
        if k % ncol == 0 and k:
            y += colh + 120; colh = 0
        cy = y - top
        sc.inst(f'{ROOT}/blocks/{ch}.sym', cx, cy, f'name=x{ch}', ('box', 'block', ch, [san(p) for p in ins], [san(p) for p in outs], w, ch))
        for p in ins + outs:
            px, py = pos[san(p)]
            px = px - (w - 30) if px < 0 else px + (w - 30)
            sc.lab(cx + px, cy + py, san(p), right=px > 0)
        colh = max(colh, h)
    if toplevel_pins:
        ins, outs = toplevel_pins
        yp = y + colh + 200
        sc.text('Tile pins (Tiny Tapeout template names; brackets written as _n)', 0, yp - 40, 0.3)
        for i, p in enumerate(ins):
            sc.pin('ipin', 60 + 180 * (i % 8), yp + 40 * (i // 8), san(p))
        yo = yp + 40 * (len(ins) // 8 + 2)
        for i, p in enumerate(outs):
            sc.pin('opin', 60 + 180 * (i % 8), yo + 40 * (i // 8), san(p))
    return sc

def compute_ports(blocks):
    leaf = [b for b in blocks if b not in SUB_OF]
    use = defaultdict(set)
    drv = defaultdict(set)
    for b in leaf:
        for iname, kind, ref, conns in blocks[b]['insts']:
            ins, outs = pin_dirs(kind, ref)
            for p, n in conns.items():
                use[n].add(b)
                if p in outs:
                    drv[n].add(b)
    chip_pins = set(BM.TOP_PORTS)
    member = {}
    for comp, ch in HIER.items():
        for c in ch:
            member[c] = comp
    def group(b, level):
        # the ancestor of leaf b that is a child of composite `level` (or None)
        cur = b
        while cur in member:
            if member[cur] == level:
                return cur
            cur = member[cur]
        return None
    for g in GLOBAL:
        use.pop(g, None); drv.pop(g, None)
    ports = {}
    for b in leaf:
        nets = {n for n in use if b in use[n]}
        ext = {n for n in nets if (use[n] - {b}) or n in chip_pins}
        ports[b] = (sorted(n for n in ext if b not in drv[n]), sorted(n for n in ext if b in drv[n]))
    for b in SUB_OF:
        ports[b] = pin_dirs('block', b)
    # composites below the chip: controller
    for comp in ['controller']:
        kids = set(HIER[comp])
        nets = {n for n in use if use[n] & kids}
        ext = {n for n in nets if (use[n] - kids) or n in chip_pins}
        dr = {n for n in ext if drv[n] & kids}
        ports[comp] = (sorted(ext - dr), sorted(dr))
    used_pins = sorted(chip_pins & set(use))
    pin_in = [p for p in used_pins if not drv[p]]
    pin_out = [p for p in used_pins if drv[p]]
    ports['chip'] = (pin_in, pin_out)
    return ports

def build(out):
    out = Path(out)
    for d in ('cells_tx', 'blocks', 'benches', 'previews'):
        (out / d).mkdir(parents=True, exist_ok=True)
    blocks = master_blocks()
    used = sorted({i[2] for b in blocks.values() for i in b['insts'] if i[1] == 'cell'})
    scenes = {}
    for c in used:
        ins, outs = cell_pins(c)
        write_box_sym(out / 'cells_tx' / f'{c}.sym', c, ins, outs, c)
        sc = cell_scene(c); scenes[('cell', c)] = sc
        (out / 'cells_tx' / f'{c}.sch').write_text(sc.sch())
    ports = compute_ports(blocks)
    def ref(kind, r):
        return f'{ROOT}/cells_tx/{r}.sym' if kind == 'cell' else f'{ROOT}/blocks/{r}.sym'
    for b, blk in blocks.items():
        ins, outs = ports[b]
        write_box_sym(out / 'blocks' / f'{b}.sym', b, [san(p) for p in ins], [san(p) for p in outs], b)
        sc = block_scene(b, blk, ins, outs, ref); scenes[('block', b)] = sc
        (out / 'blocks' / f'{b}.sch').write_text(sc.sch())
    ins, outs = ports['controller']
    write_box_sym(out / 'blocks' / 'controller.sym', 'controller', [san(p) for p in ins], [san(p) for p in outs], 'controller')
    sc = composite_scene('controller', HIER['controller'], ports); scenes[('block', 'controller')] = sc
    (out / 'blocks' / 'controller.sch').write_text(sc.sch())
    pin_in, pin_out = ports['chip']
    write_box_sym(out / 'chip.sym', 'chip', [san(p) for p in pin_in], [san(p) for p in pin_out], 'tt_um_metastability_characterizer')
    sc = composite_scene('chip', HIER['chip'], ports, (pin_in, pin_out)); scenes[('top', 'chip')] = sc
    (out / 'chip.sch').write_text(sc.sch())
    return blocks, ports, scenes, used

if __name__ == '__main__':
    out = sys.argv[1] if len(sys.argv) > 1 else str(CHIP / 'rounds' / 'round1' / 'kit')
    blocks, ports, scenes, used = build(out)
    for b, (i, o) in ports.items():
        n = len(blocks[b]['insts']) if b in blocks else len(HIER.get(b, []))
        print(f'{b:20s} in={len(i):2d} out={len(o):2d}  insts={n}')
        if b in ('chip', 'controller', 'capture_drivers', 'early_observer', 'hold_status'):
            print('     in :', ' '.join(i)); print('     out:', ' '.join(o))

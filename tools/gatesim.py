#!/usr/bin/env python3
"""Two independent models of the controller, compared cycle by cycle.

  rtl_model   : a direct transcription of rtl/meta_controller.v (Roshan's Verilog)
  gate_model  : the synthesized netlist netlist/controller_synth.v, evaluated cell by cell
                with the Boolean function of each GF180 cell

If both agree for many random input sequences, the synthesized netlist implements the RTL,
and the expected values for the transistor-level controller bench can be read from either.
"""
import random, sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import build_master as BM

IDLE, ARM, LAUNCH, LATE1, LATE2, DECIDE, COUNT, RECOVER = range(8)

class RTL:
    def __init__(self, trials=255):
        self.T = trials
        self.reset()
    def reset(self):
        self.rr = [0, 0]; self.ss = [0, 0]; self.sp = 0
        self.state = IDLE; self.capture = 0; self.cfg = 0; self.events = 0; self.trials = 0
        self.busy = self.done = self.fault = 0; self.late1 = self.late2 = self.ev = self.rf = 0
    def clock(self, rst_n, ena, start, cfg_i, dut_q, early):
        if not rst_n:
            self.reset(); return
        o = dict(self.__dict__)  # old values (non-blocking semantics)
        rr, ss, sp = list(o['rr']), list(o['ss']), o['sp']
        self.rr = [1, rr[0]]; self.ss = [start, ss[0]]; self.sp = ss[1]
        if not rr[1] or not ena:
            self.state = IDLE; self.capture = 0; self.cfg = 0; self.events = 0; self.trials = 0
            self.busy = self.done = self.fault = 0; self.late1 = self.late2 = self.ev = self.rf = 0
            return
        st = o['state']
        if st == IDLE:
            if ss[1] and not sp:
                self.cfg = cfg_i; self.events = 0; self.trials = 0; self.busy = 1; self.done = 0; self.fault = 0
                self.capture = 0; self.state = ARM
        elif st == ARM:
            if not ss[1]:
                self.state = LAUNCH
        elif st == LAUNCH:
            self.capture = 1; self.state = LATE1
        elif st == LATE1:
            self.late1 = dut_q; self.state = LATE2
        elif st == LATE2:
            self.late2 = dut_q; self.state = DECIDE
        elif st == DECIDE:
            self.ev = early ^ o['late2']; self.rf = o['late1'] ^ o['late2']; self.state = COUNT
        elif st == COUNT:
            self.capture = 0
            if o['rf']:
                self.fault = 1; self.busy = 0; self.done = 1; self.state = IDLE
            else:
                self.events = (o['events'] + o['ev']) & 255
                self.trials = (o['trials'] + 1) & 255
                if o['trials'] == self.T - 1:
                    self.busy = 0; self.done = 1; self.state = IDLE
                else:
                    self.state = RECOVER
        elif st == RECOVER:
            self.state = LAUNCH
    def outputs(self):
        return {'capture_o': self.capture, 'events_o': self.events, 'trials_o': self.trials, 'busy_o': self.busy,
                'done_o': self.done, 'fault_o': self.fault, 'config_o': self.cfg, 'state': self.state}

FUNCS = {
    'inv': lambda p: 1 - p['I'],
    'nand2': lambda p: 1 - (p['A1'] & p['A2']),
    'nand3': lambda p: 1 - (p['A1'] & p['A2'] & p['A3']),
    'nand4': lambda p: 1 - (p['A1'] & p['A2'] & p['A3'] & p['A4']),
    'nor2': lambda p: 1 - (p['A1'] | p['A2']),
    'nor3': lambda p: 1 - (p['A1'] | p['A2'] | p['A3']),
    'nor4': lambda p: 1 - (p['A1'] | p['A2'] | p['A3'] | p['A4']),
    'and2': lambda p: p['A1'] & p['A2'],
    'and3': lambda p: p['A1'] & p['A2'] & p['A3'],
    'and4': lambda p: p['A1'] & p['A2'] & p['A3'] & p['A4'],
    'or2': lambda p: p['A1'] | p['A2'],
    'aoi21': lambda p: 1 - ((p['A1'] & p['A2']) | p['B']),
    'aoi22': lambda p: 1 - ((p['A1'] & p['A2']) | (p['B1'] & p['B2'])),
    'oai21': lambda p: 1 - ((p['A1'] | p['A2']) & p['B']),
    'oai22': lambda p: 1 - ((p['A1'] | p['A2']) & (p['B1'] | p['B2'])),
    'xor2': lambda p: p['A1'] ^ p['A2'],
    'xnor2': lambda p: 1 - (p['A1'] ^ p['A2']),
    'mux2': lambda p: p['I1'] if p['S'] else p['I0'],
    'tieh': lambda p: 1,
}

class Gates:
    def __init__(self):
        self.cells = [dict(c) for c in BM.CTRL]
        for c in self.cells:
            c['fam'] = c['cell'].replace(BM.LIB, '').rsplit('_', 1)[0]
        self.flops = [c for c in self.cells if c['fam'] == 'dffrnq']
        self.comb = [c for c in self.cells if c['fam'] != 'dffrnq']
        self.q = {c['name']: 0 for c in self.flops}
        # topological order of the combinational cells, computed once
        known = {'VDPWR', 'VGND', 'clk', 'rst_n', 'enable_i', 'start_i', 'config_i[0]', 'config_i[1]', 'dut_q_i', 'early_sample_i'}
        known |= {f['conns']['Q'] for f in self.flops}
        order, pending = [], list(self.comb)
        while pending:
            nxt = []
            for c in pending:
                ins = [n for p, n in c['conns'].items() if p not in ('Z', 'ZN')]
                if all(n in known for n in ins):
                    order.append(c); known.add(c['conns']['Z' if 'Z' in c['conns'] else 'ZN'])
                else:
                    nxt.append(c)
            assert len(nxt) < len(pending), 'combinational loop'
            pending = nxt
        self.order = order
    def evaluate(self, inputs):
        v = {'VDPWR': 1, 'VGND': 0}
        v.update(inputs)
        for f in self.flops:
            v[f['conns']['Q']] = self.q[f['name']]
        for c in self.order:
            ins = {p: v[n] for p, n in c['conns'].items() if p not in ('Z', 'ZN')}
            v[c['conns']['Z' if 'Z' in c['conns'] else 'ZN']] = FUNCS[c['fam']](ins)
        return v
    def clock(self, inputs):
        v = self.evaluate(inputs)
        if not inputs['rst_n']:
            self.q = {k: 0 for k in self.q}
            return
        self.q = {f['name']: v[f['conns']['D']] for f in self.flops}
    def outputs(self, inputs):
        v = self.evaluate(inputs)
        bus = lambda n, w: sum(v[f'{n}[{k}]'] << k for k in range(w))
        st = sum(v[f'state[{k}]'] << k for k in range(3))
        return {'capture_o': v['capture_o'], 'events_o': bus('events_o', 8), 'trials_o': bus('trials_o', 8),
                'busy_o': v['busy_o'], 'done_o': v['done_o'], 'fault_o': v['fault_o'], 'config_o': bus('config_o', 2), 'state': st}

def gate_inputs(rst_n, ena, start, cfg, dq, early):
    return {'rst_n': rst_n, 'enable_i': ena, 'start_i': start, 'config_i[0]': cfg & 1, 'config_i[1]': cfg >> 1,
            'dut_q_i': dq, 'early_sample_i': early, 'clk': 0}

def compare_random(n_seq=12, n_cyc=1500, seed=1):
    rng = random.Random(seed)
    worst = None
    for s in range(n_seq):
        R, G = RTL(), Gates()
        for cyc in range(n_cyc):
            rst = 0 if cyc < 2 else (0 if rng.random() < 0.002 else 1)
            ena = 1 if rng.random() > 0.01 else 0
            start = 1 if (cyc % 400) in range(5, 15) else 0
            if rng.random() < 0.02:
                start = 1 - start
            cfg, dq, ea = rng.randrange(4), rng.randrange(2), rng.randrange(2)
            gi = gate_inputs(rst, ena, start, cfg, dq, ea)
            a = R.outputs(); b = G.outputs(gi)
            if a != b:
                return f'MISMATCH seq {s} cycle {cyc}: rtl {a} gate {b}'
            R.clock(rst, ena, start, cfg, dq, ea); G.clock(gi)
    return f'agree: {n_seq} random sequences x {n_cyc} cycles, all outputs equal every cycle'

def bench_expectation(t_end_ns=2500.0, period=50.0, first_edge=25.0, rst_release=60.0, start_on=210.0, start_off=510.0,
                      dut_q=1, early=0, cfg=1):
    """Expected controller outputs for the transistor-level bench (rising edges at 25 + 50k ns)."""
    R = RTL()
    log = []
    t = first_edge
    while t <= t_end_ns:
        rst = 1 if t > rst_release else 0
        start = 1 if start_on < t < start_off else 0
        R.clock(rst, 1, start, cfg, dut_q, early)
        o = R.outputs(); log.append((t, o))
        t += period
    return log

if __name__ == '__main__':
    print(compare_random())
    log = bench_expectation()
    caps = [t for (t, o), (t0, o0) in zip(log[1:], log[:-1]) if o['capture_o'] and not o0['capture_o']]
    print('capture rising after the clock edges at (ns):', caps)
    t, o = log[-1]
    print(f'at the last edge {t} ns: events={o["events_o"]} trials={o["trials_o"]} busy={o["busy_o"]} done={o["done_o"]} '
          f'fault={o["fault_o"]} cfg={o["config_o"]}')

def compare_full_block(seed=7, n_cyc=1700):
    """One complete 255-trial block with settled late samples, so the terminal count is exercised."""
    rng = random.Random(seed)
    R, G = RTL(), Gates()
    for cyc in range(n_cyc):
        rst = 0 if cyc < 2 else 1
        start = 1 if 5 <= cyc < 12 else 0
        ea = rng.randrange(2)
        gi = gate_inputs(rst, 1, start, 2, 1, ea)
        a, b = R.outputs(), G.outputs(gi)
        if a != b:
            return f'MISMATCH full block cycle {cyc}: rtl {a} gate {b}'
        R.clock(rst, 1, start, 2, 1, ea); G.clock(gi)
    o = R.outputs()
    return f'full block agrees for {n_cyc} cycles; final events={o["events_o"]} trials={o["trials_o"]} done={o["done_o"]} busy={o["busy_o"]}'

if __name__ == '__main__':
    print(compare_full_block())

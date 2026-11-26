#!/usr/bin/env python3
"""Edge times of the bank path from a whole-tile bench's saved waveforms (tb_chip_<tag>.dat of make_tb_chip.py).
usage: bank_edges.py <dat> <vdd> [t0_ns=370] [t1_ns=400]
Prints, for the trial whose capture edge follows the clk edge at 374.5 ns, the time of the first crossing of vdd/2 in
the window for clk, capture_local, bank_cap, bank_obs_clk, early_clk and bank_selected_q, relative to the clk edge."""
import sys
dat, vdd = sys.argv[1], float(sys.argv[2])
t0 = float(sys.argv[3]) * 1e-9 if len(sys.argv) > 3 else 370e-9
t1 = float(sys.argv[4]) * 1e-9 if len(sys.argv) > 4 else 400e-9
names = ['clk', 'uio_out_4', 'uio_out_5', 'uio_out_1'] + [f'uo_out_{i}' for i in range(8)] + \
        ['capture_local', 'early_clk', 'selected_q', 'bank_selected_q', 'bank_obs_clk', 'bank_early_q', 'bank_cap']
want = ['clk', 'capture_local', 'bank_cap', 'bank_obs_clk', 'early_clk', 'bank_selected_q', 'bank_early_q']
idx = {n: names.index(n) for n in want}
prev, cross = None, {}
th = vdd / 2
for line in open(dat):
    f = line.split()
    t = float(f[0])
    if t < t0: prev = f; continue
    if t > t1: break
    if prev is not None:
        tp = float(prev[0])
        for n, i in idx.items():
            if n in cross: continue
            a, b = float(prev[2 * i + 1]), float(f[2 * i + 1])
            if (a - th) * (b - th) < 0:
                cross[n] = (tp + (th - a) / (b - a) * (t - tp), 'rise' if b > a else 'fall')
    prev = f
ref = cross['clk'][0]
for n in want:
    if n in cross: print(f'{n:16s} {cross[n][1]:4s} {1e12 * (cross[n][0] - ref):9.1f} ps after the clk pin edge')
    else: print(f'{n:16s} no crossing in the window')

# Simulations of the revised layout added on 26 Nov 2026

Layout: commit e449093, GDS SHA-1 `4b6e7df96942da64c25916530b39da4a2fdb39d1`. These runs complete the list that
`README_analog.md` gave as "not repeated for the revised layout". The audit of the supply, of latch-up and of
coupling is in `README.md` of this folder.

## 1. Tools and method

| Item | Version |
| --- | --- |
| Extraction | Magic 8.3.573 and Magic 8.3.703, `ext2spice` with coupling capacitance, hierarchical; PDK `gf180mcuD` (wafer-space/gf180mcu, commit ac7d869) |
| Checks on both extractions | Magic DRC 0 errors; Netgen 1.5.133 against `layout/chip_lvs.spice`: "Circuits match uniquely", 208 devices, 209 nets (`checks/`) |
| Simulator | ngspice 42, models `sm141064.ngspice`, one thread |
| Bench | the cut-out of `verification/bank/tools/cutout_bank.py`, written again as `tools/sim/cutout.py`: front end and bank from the extracted netlist with every wire capacitance, the controller replaced by sources at its boundary |

The scripts are those of the second check (`verification/independent/`) and of the bank revision, written again for
this folder (`tools/sim/`). Three earlier results were reproduced first, with the 8.3.573 extraction at the typical
corner: *d* at `ua[0]` = 1.0, 1.3 and 3.3 V (4539.76, 2687.54, 1401.69 ps: equal to the recorded values); the floors
of DUT2 at 25 C (1692.6 and 2255.0 ps: equal); and the time constants of the six NAND and jamb latches (within
0.1 % of `verification/bank/sim/tau.txt`, which uses a bench written separately).

## 2. The two extractions

Wire capacitance at the top level of the extracted netlist, each capacitor counted once:

| Extraction | Capacitors | Signal net to `VGND` | Signal net to `VDPWR` | Between signal nets | Sum | Between `VDPWR` and `VGND` |
| --- | --- | --- | --- | --- | --- | --- |
| Magic 8.3.573 | 9,910 | 0.130 pF | 0.789 pF | 1.251 pF | 2.170 pF | 0.085 pF |
| Magic 8.3.703 | 9,281 | 0.164 pF | 0.097 pF | 0.733 pF | 0.994 pF | -0.147 pF |

The two versions differ by a factor of 2.2 in the wire capacitance they report for the same layout. The negative
value between the supplies with 8.3.703 is a correction term of the hierarchical extraction; it has no effect on
the benches, in which both supplies are ideal sources. Which version is nearer the silicon is not established
(`README_analog.md`, "The version of Magic").

## 3. Delay of the early sample against `ua[0]`

*d* from the capture edge at the flip-flops (`capture_local`) to the clock of the early observer (`early_clk`), both
at half the supply; data input low; ps.

| `ua[0]` (V) | 8.3.573, typical, 3.3 V, 27 C | 8.3.573, ss, 3.0 V, 125 C | 8.3.573, ff, 3.6 V, -40 C | 8.3.703, typical, 3.3 V, 27 C |
| --- | --- | --- | --- | --- |
| 0.90 | 6175.1 | 11354.3 | 3318.8 |  |
| 0.95 | 5223.0 | 9506.3 | 2894.4 |  |
| 1.00 | 4539.8 | 8203.7 | 2574.5 | 4193.5 |
| 1.05 | 4029.0 | 7247.2 | 2325.6 |  |
| 1.10 | 3634.6 | 6520.6 | 2127.1 | 3361.5 |
| 1.15 | 3322.1 | 5953.5 | 1965.4 |  |
| 1.20 | 3069.2 | 5499.7 | 1831.6 | 2842.0 |
| 1.30 | 2687.5 | 4823.3 | 1623.7 | 2491.2 |
| 1.40 | 2415.6 | 4347.5 | 1470.8 | 2241.4 |
| 1.50 | 2213.9 | 3997.5 | 1354.4 | 2056.1 |
| 1.60 | 2059.6 | 3732.5 | 1263.6 |  |
| 1.80 | 1842.6 | 3367.0 | 1132.5 | 1715.2 |
| 2.00 | 1700.7 | 3137.6 | 1044.3 |  |
| 2.40 | 1535.9 | 2887.2 | 937.3 | 1434.2 |
| 3.00 | 1428.4 | 2728.9 | 860.6 | 1336.1 |
| 3.30 | 1401.7 |  |  | 1311.8 |
| 3.60 |  |  | 828.3 |  |

The delay between the monitor pins `uio_out[4]` and `uio_out[5]` is shorter than *d* by: typical, 3.3 V, 27 C (8.3.573): 74 ps at 1 V, 120 ps at 1.8 V, 121 ps at 3 V; ss, 3.0 V, 125 C (8.3.573): 167 ps at 1 V, 253 ps at 1.8 V, 255 ps at 3 V; ff, 3.6 V, -40 C (8.3.573): 40 ps at 1 V, 67 ps at 1.8 V, 67 ps at 3 V; typical, 3.3 V, 27 C (8.3.703): 70 ps at 1 V, 114 ps at 1.8 V, 111 ps at 3 V.

With 8.3.703 *d* is 6.9 to 8.3 % shorter than with 8.3.573 at the typical corner.

Sensitivity of *d* to `ua[0]` at the typical corner (8.3.573): 19.0 ps per mV between 0.90 and 0.95 V, 10.2 between 1.00 and 1.05 V, 5.1 between 1.15 and 1.20 V, 2.02 between 1.4 and 1.5 V.

## 4. Time constants of the master latches

Growth method on the cut-out: the latch is balanced and released with a small imbalance, and the time between two
fixed levels of the difference of its nodes gives tau. Two values per entry: released towards either side. ps.

| Flip-flop | 8.3.573, typical, 3.3 V, 27 C | 8.3.573, ss, 3.0 V, 125 C | 8.3.573, ff, 3.6 V, -40 C | 8.3.703, typical, 3.3 V, 27 C | 8.3.703, ss, 3.0 V, 125 C | 8.3.703, ff, 3.6 V, -40 C |
| --- | --- | --- | --- | --- | --- | --- |
| DUT2 | 142.55, 142.51 | 270.98, 270.90 | 86.33, 86.30 | 136.06, 136.01 | 258.75, 258.66 | 82.37, 82.34 |
| DUT3 | 119.22, 119.22 | 226.68, 226.66 | 72.22, 72.22 | 113.80, 113.80 | 216.46, 216.45 | 68.92, 68.92 |
| DUT4 | 169.16, 169.17 | 320.92, 320.91 | 102.50, 102.50 | 163.13, 163.13 | 309.62, 309.61 | 98.82, 98.82 |
| N3 | 119.32, 119.31 | 226.77, 226.77 | 72.28, 72.28 | 113.84, 113.83 | 216.45, 216.45 | 68.94, 68.94 |
| N1 | 41.46, 41.46 | 65.57, 65.58 | 29.28, 29.28 | 39.16, 39.16 | 62.06, 62.07 | 27.59, 27.59 |
| N2 | 29.57, 29.57 | 48.10, 48.10 | 20.29, 20.29 | 28.28, 28.28 | 46.09, 46.09 | 19.37, 19.37 |

| Ratio | 8.3.573, typical, 3.3 V, 27 C | 8.3.573, ss, 3.0 V, 125 C | 8.3.573, ff, 3.6 V, -40 C | 8.3.703, typical, 3.3 V, 27 C | 8.3.703, ss, 3.0 V, 125 C | 8.3.703, ff, 3.6 V, -40 C |
| --- | --- | --- | --- | --- | --- | --- |
| DUT3 / DUT2 | 0.8363 | 0.8365 | 0.8366 | 0.8364 | 0.8366 | 0.8366 |
| DUT4 / DUT2 | 1.1867 | 1.1843 | 1.1873 | 1.1990 | 1.1966 | 1.1997 |
| N3 / DUT3 | 1.0008 | 1.0004 | 1.0008 | 1.0003 | 0.9999 | 1.0003 |
| N1 / DUT2 | 0.2909 | 0.2420 | 0.3392 | 0.2878 | 0.2399 | 0.3350 |
| N2 / DUT2 | 0.2074 | 0.1775 | 0.2350 | 0.2079 | 0.1781 | 0.2352 |
| N2 / N1 | 0.7131 | 0.7336 | 0.6928 | 0.7223 | 0.7427 | 0.7020 |

With 8.3.573 tau is 3.6 to 6.1 % longer than with 8.3.703. The ratio of DUT3 to DUT2 is the same with both to
0.0003; that of DUT4 to DUT2 differs by 0.012. N3, the copy of DUT3 in the bank, is within 0.1 % of DUT3.

Against the supply voltage (typical corner, 27 C, 8.3.573), tau at 3.25, 3.30 and 3.35 V: N2 29.88, 29.57, 29.25 ps; N1 41.87, 41.46, 41.07 ps; DUT2 144.74, 142.55, 140.47 ps.

## 5. Floors in continuous operation

Bench of the second check (Section 7): three trials 10 ns apart (15 ns at the slow corner), the data toggled 2 ns
before each capture edge, the third trial examined; `ua[0]` is bisected until the early sample catches the new
value; the floor is *d* of that trial. Below the floor every trial in which the output changed is counted.

| Condition (8.3.573) | Flip-flop | Data | Floor (ps) | `ua[0]` at the floor (V) | New value at the selector output, after the capture edge (ps) |
| --- | --- | --- | --- | --- | --- |
| typical, 3.3 V, 25 C | DUT2 | rising | 1692.6 | 2.011 | 1676.4 |
| typical, 3.3 V, 25 C | DUT2 | falling | 2255.1 | 1.472 | 1939.0 |
| ff, 3.6 V, -40 C | DUT1 | rising | 1352.3 | 1.507 | 1355.8 |
| ff, 3.6 V, -40 C | DUT1 | falling | 1559.9 | 1.337 | 1399.7 |
| ff, 3.6 V, -40 C | DUT2 | rising | 973.4 | 2.243 | 976.8 |
| ff, 3.6 V, -40 C | DUT2 | falling | 1276.7 | 1.582 | 1117.8 |
| ss, 3.0 V, 125 C | DUT1 | rising | 4659.7 | 1.336 | 4588.1 |
| ss, 3.0 V, 125 C | DUT1 | falling | 5467.6 | 1.204 | 4775.4 |
| ss, 3.0 V, 125 C | DUT2 | rising | 3374.7 | 1.804 | 3303.1 |
| ss, 3.0 V, 125 C | DUT2 | falling | 4554.2 | 1.352 | 3866.2 |

The two typical rows reproduce the values of `verification/bank/sim/floors.txt` (1692.6 and 2255.0 ps). The floor follows the arrival of the new value at the selector output: by -3 to 72 ps for rising data and by 159 to 692 ps for falling data over the conditions computed. The early observer needs its setup time after the arrival, and more of it for a falling input. The floors of the other flip-flops at the typical corner are in `verification/bank/sim/floors.txt`.

**The bank.** The same bench with the bank's own path: the capture edge is applied at the output of the bank's trial
flip-flop, and the early observer is clocked from the pin `ui_in[5]`. *t* is the time from the capture edge at the
flip-flops (`bank_cap`) to the clock of the bank's early observer; it plays the part of *d*. *x* is the time of the
edge at the pin after the start of the capture edge at the trial flip-flop's output.

| Condition (8.3.573) | Flip-flop | Data | Floor *t* (ps) | *x* at the floor (ps) | New value at the bank selector output, after the capture edge (ps) |
| --- | --- | --- | --- | --- | --- |
| typical, 3.3 V, 27 C | N1 | falling | 1807.1 | 2123.2 | 1392.4 |
| typical, 3.3 V, 27 C | N1 | rising | 1243.5 | 1565.1 | 1183.9 |
| typical, 3.3 V, 27 C | N2 | falling | 3008.6 | 3324.7 | 2591.7 |
| typical, 3.3 V, 27 C | N2 | rising | 1985.2 | 2306.8 | 1925.0 |
| typical, 3.3 V, 27 C | N3 | falling | 2472.7 | 2788.9 | 2050.2 |
| typical, 3.3 V, 27 C | N3 | rising | 1767.6 | 2089.2 | 1707.3 |

## 6. The whole tile with wire resistance

**Verdict.** Wire resistance adds at most 1.3 ps on any net of the measurement path (capture edge, data, selected
output) and at most 70 ps on the controller's widest net, `run`, which nothing reads for 150 ns. These are bounds
from the extracted resistor networks. The simulation of the netlist with resistance is not used for delays,
because that netlist is inconsistent in its capacitance.

**What was run.** The tile was flattened in Magic 8.3.573 and extracted with resistance (`extresist`, tolerance
10; `sim/rc_extract.tcl`): 15,621 resistors on 943 of 1,071 nets, the supply nets included, 7,720 capacitors and
1,986 transistors. The same flat extraction was also written without resistance (11,419 capacitors). Both
netlists were simulated with the whole-tile bench (`sim/rc_tb.spice`; 20 MHz clock, `ua[0]` = 1.8 V, DUT2, data
toggled once per trial).

| Quantity | Hierarchical extraction (all other results) | Flat, without resistance | Flat, with resistance |
| --- | --- | --- | --- |
| First rising edge of `uio_out[4]` | 178.537 ns | 178.419 ns | 178.382 ns |
| Delay between the monitor pins | 1723.2 ps | 1639 ps | 1748.1 ps |
| Capture edge to the output of DUT2, falling | 801 ps | 778 ps | 809 ps |
| Capture edge to the selected output, falling | 1948 ps | 1886 ps | 1609 ps |
| Capture edge to the output of DUT1, rising and falling | | 1259, 1232 ps | 987, 847 ps |
| Early sample of a trial with falling data | old value: an event | old value: an event | new value: no event |
| `busy` rises | 686.98 ns | | 685.78 ns |

With resistance, the library flip-flop DUT1 and the selector are 0.3 to 0.4 ns faster than in the same extraction
without resistance. Resistance cannot shorten a delay, so the netlist that `ext2spice` writes with `extresist`
carries less capacitance inside those cells than the netlist without. Its delays are therefore discarded, and so
is its count of 0 events, which follows from the early arrival of the selected output. What it does show is the
logic: reset, start, `busy` and the two clock edges of every trial are those of the other netlists.

**The bound.** The resistor network of each net comes from the drawn wires and the sheet resistance, and is not
affected by the fault above. `tools/sim/rc_bound.py` takes, for each of the 506 nets that have a network and a
gate, the largest resistance between a driving terminal and a gate, and multiplies it by the whole capacitance of
the net in the flat extraction. The product is an upper bound of the delay the resistance adds.

| Net | Gates | Largest resistance | Capacitance | Bound |
| --- | --- | --- | --- | --- |
| `run` (controller) | 144 | 300 ohm | 232.7 fF | 69.7 ps |
| `rst_n` | 20 | 354 ohm | 67.2 fF | 23.8 ps |
| `ui_in[1]`, `ui_in[3]` (static selections) | 6 | 607 ohm | 25 fF | 15.5 ps |
| clock of N2 inside the jamb latch | 22 | 83 ohm | 28.0 fF | 2.3 ps |
| `capture_local` | 24 | 31 ohm | 39.9 fF | 1.25 ps |
| `data_local` | 8 | 38 ohm | 21.9 fF | 0.83 ps |
| output of DUT2 to the selector | 4 | 36 ohm | 11.6 fF | 0.41 ps |
| selected output | 4 | 39 ohm | 10.1 fF | 0.39 ps |
| `ua[0]` | 1 | 20 ohm | 17.1 fF | 0.35 ps |

15 nets have a bound above 1 ps and 4 above 5 ps (`sim/rc_bound.txt`). The statement of `README_analog.md`,
"some 10 ps on the longest net", was an estimate for `run`; the bound here is 70 ps, and the conclusion is the
same, because `run` is static when it is read.

**Supply rails.** The netlist with resistance includes the supply nets. With the tile's own capacitance present,
the largest excursions between 700 and 1190 ns are 13.4 mV (supply at N1), 3.9 mV (supply at N2), 1.2 mV (ground at
N2) and 0.4 mV (ground at the delay stage) (`sim/rc_rail_voltages.json`). They lie below the values of the
resistive model in `README.md`, Section 4, which has no capacitance; they come from the netlist whose capacitance
is in doubt and are given for comparison only.

**Flat against hierarchical extraction.** Without resistance, the flat extraction of the same GDS by the same
Magic gives delays 3 to 5 % shorter than the hierarchical one (monitor delay 1639 against 1723 ps; selected output
1886 against 1948 ps; DUT2 778 against 801 ps). Together with the difference between the two versions of Magic
(Section 4) this puts the uncertainty of every extracted delay and time constant at about 5 %. The time constants
and floors were not computed on the flat extraction.

## 7. Predicted count against the delay

**Method.** Count model of the second check (`verification/independent/README.md`, Section 8), written again as
`tools/sim/count_model.py`. `tools/sim/tchar.py` finds, on the cut-out, the critical time of the data edge by
bisection (to 1e-17 s) and then simulates captures with the data edge 1.5 ns to 1.5e-16 s ahead of it, two per
decade. For each capture the last crossing of half the supply by the selected output is recorded. The early
observer samples at t_ord + (*d* - d_F) after the capture edge, where t_ord is that crossing in an ordinary
capture and d_F the floor; a capture is counted when its output crosses later than the sample. The window w(*d*)
is the range of data times that are counted, summed over rising and falling data, and K = 65,535 f w per block
for a data frequency f.

**DUT2, typical corner (captures at 27 C, floors of 25 C, Magic 8.3.573).**

| *d* (ns) | above the falling-data floor (ns) | w (s) | events per block per MHz of data frequency | local time constant (ps) |
| --- | --- | --- | --- | --- |
| 2.30 | 0.05 | 4.07e-10 | 26.7 | 67.5 |
| 2.50 | 0.25 | 2.02e-10 | 13.2 | 285.5 |
| 2.70 | 0.45 | 1.12e-10 | 7.34 | 394.1 |
| 2.90 | 0.65 | 6.75e-11 | 4.42 | 394.5 |
| 3.10 | 0.85 | 3.11e-11 | 2.04 | 144.2 |
| 3.30 | 1.05 | 7.13e-12 | 0.467 | 127.8 |
| 3.50 | 1.25 | 1.5e-12 | 0.098 | 129.2 |
| 3.70 | 1.45 | 3.23e-13 | 0.0212 | 131.6 |
| 3.90 | 1.65 | 7.11e-14 | 0.00466 | 132.6 |
| 4.10 | 1.85 | 1.6e-14 | 0.00105 | 134.1 |
| 4.30 | 2.05 | 3.59e-15 | 0.000235 | 135.6 |
| 4.50 | 2.25 | 8.26e-16 | 5.41e-05 | 136.2 |
| 4.70 | 2.45 | 1.91e-16 | 1.25e-05 | 133.4 |
| 4.90 | 2.65 | 4.28e-17 | 2.81e-06 | 134.9 |
| 5.10 | 2.85 | 9.72e-18 | 6.37e-07 | 134.9 |
| 5.30 | 3.05 | 2.21e-18 | 1.45e-07 | 134.9 |

- The straight part of ln K begins at *d* = 3.21 ns, 0.95 ns above the falling-data floor (2.255 ns), at `ua[0]`
  near 1.17 V. In the layout before the bank it began at 3.4 ns, 1.0 ns above the floor of 2.379 ns.
- The counted time constant is 129.4 ps over 3.21 to 3.81 ns and 135.3 ps over 4.21 to 5.21 ns: 0.908 and 0.949 of
  the latch's 142.55 ps. Before the bank: 129.9 and 136.7 ps (0.912 and 0.959).
- Above the floor the events are late falls of the output; rising data contribute less than 0.5 % of the window.
- No capture on the side where the new value is not taken crosses half the supply, so that side adds nothing.

**The capture edge moves with the state of the master latch.** In these runs the capture edge at the flip-flop
(`capture_local`) comes 24.8 ps later (falling data) or 42.1 ps earlier (rising data) in a near-critical capture
than in an ordinary one, because the flip-flops load the capture path differently while their master latches are
still moving. The copy of the edge that feeds the delay line moves with it (by 33 of 38 ps in the case examined,
`sim/tcdiag_edges.txt`). The model therefore counts every time from the capture edge at the flip-flop of its own capture.
Counted on the time axis of the simulation instead, the falling-data window is 20 % larger, which is 24 ps in *d*;
the slopes do not change. This is the same effect as the dependence of *d* on the data in `README.md`, Section 7.

**N2, typical corner (27 C, Magic 8.3.573).** The delay *t* is that of the bank: from the capture edge at the flip-flops to the clock of the bank's early observer, in an ordinary capture. The bank's early clock comes from a pin and does not move with the capture edge, so here every time is counted from the capture edge of the ordinary capture.

| *t* (ns) | above the higher floor (ns) | w (s) | events per block per MHz of data frequency | local time constant (ps) |
| --- | --- | --- | --- | --- |
| 3.10 | 0.09 | 7.29e-13 | 0.0478 | 9.6 |

- The straight part begins at *t* = 3.16 ns, 0.15 ns above the higher floor.
- Counted time constant: 11.70 ps over 3.16 to 3.76 ns (0.396 of the latch's 29.57 ps); 11.70 ps over 4.16 to 5.16 ns (0.396 of the latch's 29.57 ps).
- Tail of the last crossing: 15.49 ps (rising data), 11.70 ps (falling data).
- Captures on the side where the new value is not taken that cross half the supply: 0 (rising), 0 (falling).

**The count of N2 does not give its latch's time constant.** In the table above the count falls with a local
time constant of 7 to 16 ps, where the latch has 29.57 ps. The cause is the capture edge of the bank, not the
latch:

- The bank's capture edge reaches the flip-flops (`bank_cap`) with a rise time of 1.05 ns from 10 to 90 % at the
  typical corner (0.64 ns at ff 3.6 V -40 C; `sim/clock_edge_rise_times.txt`). One `inv_2` of the 5 V library drives
  the clock inputs of N1, N2 and N3.
- The latch itself behaves as expected. The difference between two captures on opposite sides of the critical
  time grows with 29.6 ps from about 200 ps after the middle of the edge, and reaches 1 V about 440 ps after it
  (`sim/n2_growth.txt`).
- The slave of N2 is opened by the same edge, through two transistors 0.3 um wide whose gates are on `bank_cap`.
  While the edge is still rising, the slave cannot yet follow the latch. The output of N2 therefore appears about
  1 ns after the middle of the edge in an ordinary capture, and only 114 ps later than that in a capture whose
  latch needed 440 ps: most of the latch's lateness is hidden.
- With a fast capture edge the lateness returns. The same captures were repeated with a 50 ps ramp forced on
  `bank_cap` (`FASTCAP=1` in `tools/sim/tchar.py`): the last crossing of the output then moves by 31 to 34 ps
  for each factor of sqrt(10) in the distance of the data edge from the critical time, which is a time constant of
  29.0 and 28.8 ps (falling and rising data), 0.98 and 0.97 of the latch's. As built it moves by 8 to 19 ps.

N1 was examined in the same way (as built; falling data and rising data): its last crossing moves by 39 to 46 ps per factor of sqrt(10), a local time constant of 34 to 40 ps where its latch has 41.5 ps, so it is affected much less.

Consequence: on the layout of e449093 the slope of ln K against the delay of the early clock would give about
7 to 14 ps for N2, not 29.6 ps. N3, with the 119 ps of DUT3, resolves long after the edge has ended and is not
expected to be affected in this way (the count model of DUT2, which has the same kind of capture edge, gives 0.91 to 0.95 of the
latch's time constant). The remedy is a stronger driver for `bank_cap`. In the netlist of the cut-out, with the first of the two inverters that drive
`bank_cap` made twice and the second five times as strong, the edge rises in 262 ps instead of 1043 ps; with three
and nine times, in 174 ps (`sim/driver_sweep.json`). A stronger driver is a change of the layout and is not part of
the layout described here.

## 8. Not done

- Floors at the corners: DUT3 at ff 3.6 V -40 C, DUT4 at ff 3.6 V -40 C, DUT3 at ss 3.0 V 125 C, DUT4 at ss 3.0 V 125 C.
- Predicted count against the delay: DUT1, DUT3, DUT4, N1, N3. Their captures (`tools/sim/tchar.py`) take about 45 minutes each for each data direction.
- Time constants and floors on the flat extraction (Section 6).
- The floors and the count model with Magic 8.3.703.
- The sign-off run of `verification/layout/` (`layout/run_layout.sh`, `layout/run_postlayout.sh`), which still describes 06823df; any run on ecetesla0.
- Mismatch (Monte Carlo) on the extracted tile; the supply outside the tile; the substrate.

## 9. Files

| File | Contents |
| --- | --- |
| `sim/dly_*.json`, `sim/tau_*.json`, `sim/floor*_*.json`, `sim/tchar_*.json`, `sim/count_*.json` | the results behind every table above |
| `sim/rc_*` | extraction scripts, bench and result lines of the runs with wire resistance; the edges of the two flat netlists; the bound per net; the rail voltages |
| `sim/tcdiag_edges.txt` | the two captures that show the capture edge moving with the state of the master latch |
| `checks/` | Magic DRC and Netgen LVS on both extractions |
| `tools/sim/cutout.py`, `simlib.py` | the cut-out and the bench library |
| `tools/sim/dly.py`, `tau.py`, `floor.py`, `floors_job.py`, `floor_bank.py`, `tchar.py`, `count_model.py` | one script per quantity; the usage line is at the top of each |
| `tools/sim/runq.sh`, `collect.py`, `make_sim_md.py` | the job queue and the scripts that write the tables of this document |

To repeat: extract the GDS with Magic (`layout/magic_checks.tcl`), run `tools/sim/cutout.py` on the extracted netlist,
then the script of the quantity wanted. Every script skips results that already exist.

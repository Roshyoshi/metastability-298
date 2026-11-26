# The bank's capture driver: layout of 26 Nov 2026

This folder holds the logs behind the section "The bank's capture driver" of `README_analog.md`. The layout described
here is the GDS whose SHA-1 is in `layout/gds.sha1`. It differs from the layout of commit e449093 (25 Nov 2026;
`verification/bank/`, `verification/physical/`) in two cells. Tools: Magic 8.3.573 and 8.3.703, Netgen 1.5.133,
KLayout 0.28.16, ngspice 42, PDK `gf180mcuD`. No chip has been measured. Paths inside the scripts are those of the
machine on which they ran.

## 1. Reason

The count model was run for N2 on the layout of 25 Nov (commit e449093). It showed that a slope measured on N2 would
not have been the time constant of its latch. The bank's capture edge, the net `bank_cap`, was driven by two `inv_2`
in series and rose in 1.05 ns from 10 to 90 % at the typical corner. The slave of N2 is opened by that edge through
two transistors 0.3 um wide, and while the edge is still rising the slave cannot follow the latch. Most of the
lateness of the latch therefore did not reach the output: in a capture 1.5e-16 s from the critical time the output
came 118 ps (rising data) and 182 ps (falling data) later than in an ordinary capture, where the same captures with a
50 ps edge forced on `bank_cap` give 491 and 498 ps. In terms of steps, the last crossing of the output moved by 7.5
to 15.7 ps (falling data) and 8.1 to 18.9 ps (rising data) for each factor of sqrt(10) in the distance of the data
edge from the critical time, where the latch's 29.6 ps correspond to 34 ps. N1, DUT1 to DUT4 and N3 were not affected
in this way (`verification/physical/SIMULATIONS.md`, Section 7).

The check that found this was the count model, not a rule check or a functional simulation. DRC, LVS and the
whole-tile runs of e449093 all passed, and rightly: the layout obeyed the rules, was the circuit of the netlist, and
counted 4 events in 4 trials with an early clock and 0 in 4 with a late one. None of these asks how the count falls
between the two. The control for the diagnosis was a 50 ps ramp forced on `bank_cap` itself in the same bench: the
steps of N2 returned to 31.8 to 33.8 ps (falling data) and 30.9 to 33.8 ps (rising data).

## 2. The change

In `tools/build_master.py`, list `BANK`, the cell `bank_cap0` is now `inv_4` and `bank_cap1` is `inv_12` (sheet
`xschem/blocks/bank_capture_drivers.sch`). Instance names, nets and the row are the same. The tile has 2,002
transistors and 2 diodes, 24 more than before, in the same 180 library cells and two custom blocks. Row B2, which
holds the trial clock copy, the data drivers and the capture drivers, is longer to the left: its transistors span x =
240.98 to 307.98 um, before 255.54 to 308.01 um, and the generator routed the bank's nets again. Above y = 199 um,
where DUT1 to DUT4, the delay line, the controller and the pin drivers are, the GDS is identical to that of e449093 on
every layer (`verification/bank_driver/layout/xor_against_e449093.txt`). The LEF is unchanged.

`inv_4` and `inv_12` draw their input pin as two Metal1 pieces, each on contacts to the one polysilicon shape that
forms all their gates; the library's LEF lists both pieces in one port. The router reaches one piece.
`tools/drc_lite.py` used to count every Metal1 piece of a pin as a terminal of its own and reported the other piece as
an open; it now reads the cell's GDS, follows Metal1, contacts and polysilicon, and counts such a pin as one terminal
only if they join the pieces (reported under `pins_joined_inside_cell` in `layout/drc_lite_report.json`). The
polysilicon strap between the pieces is 0.96 um wide and about two squares long, 15 ohm at 7.3 ohm per square, which
with half of the gate capacitance of `inv_12` is a time constant of about 0.3 ps. Netgen compares the extracted
layout, in which all fingers share one gate net, with the netlist: the circuits match.

## 3. Checks of the new GDS

Logs in `layout/`.

| Check | Tool | Result | Log |
| --- | --- | --- | --- |
| DRC | Magic 8.3.573 and Magic 8.3.703, PDK `gf180mcuD` | 0 errors in both | `drc_magic_8.3.573.txt`, `drc_magic_8.3.703.txt` |
| DRC, main rule deck of the PDK | KLayout 0.28.16, flat, on a private copy of the deck patched for this KLayout version | 0 violations | `klayout_main_deck.txt` |
| LVS against `layout/chip_lvs.spice` | Netgen 1.5.133 on the extractions of both Magic versions | "Circuits match uniquely": 208 devices, 209 nets at the top level | `lvs_report_magic8.3.573_netgen1.5.133.txt`, `lvs_report_magic8.3.703_netgen1.5.133.txt` |
| Antenna | Magic 8.3.573 | 0 | `antenna_magic_8.3.573.txt` |
| The generator's own checks | `tools/drc_lite.py` | no rule violation, short or open; two pins joined inside their cell; worst antenna ratio 188 of 400 | `layout/drc_lite_report.json` |
| Schematics against the netlist | `tools/sch_check.py`, `tools/check_focus.py` | SAME CIRCUIT (2,002 transistors, 2 diodes); ALL SAME | `sch_check.txt`, `check_focus.txt` |
| File checks of the Tiny Tapeout precheck | `tools/precheck_lite.py` | ALL PASS | `precheck_lite.txt` |
| Tiny Tapeout precheck, offline | tt-support-tools 21568ef, `precheck.py` | the nine steps that can run here pass: pin labels, zero area, KLayout checks, pins, boundary, power pins, layers, cell names, analog pins. The rule-deck step and the antenna step do not run their rules with the PDK installed here, and the Verilog step lacks its tool; the `gds` workflow on GitHub runs all twelve | `tt_precheck_offline.md` |
| Unchanged part of the tile | KLayout XOR against the GDS of e449093 | 0 polygons above y = 199 um on every layer | `xor_against_e449093.txt` |
| Latch-up distances, taps | `verification/physical/tools/lu_check.py`, `tap_rows.py` | largest distance 14.39 um against 15 um, in N2, as before; 445 substrate and 445 well taps | `lu_check.txt`, `tap_rows.txt` |
| No gate undriven | `verification/physical/tools/gate_check.py` | 506 nets reach a gate; none without a source, drain, diode or pin | `gate_check.txt` |
| `layout/mag/`, the copy for Magic | written by `layout/gds2mag.tcl` with Magic 8.3.703, then loaded and checked | 0 DRC errors; circuits match uniquely | `mag_copy_check.txt` |

The netlist that was simulated was extracted from an earlier run of the generators on the same sources. Compared with
the extraction of the committed GDS it has the same devices and the same 7,302 capacitors (2607.26 fF); the two differ
in the order of two ports of one subcircuit and in capacitors of value 0
(`layout/extraction_compared_with_simulated_netlist.txt`, `tools/pexcmp.py`).

## 4. Simulations on the new extraction (Magic 8.3.573)

| Quantity (extracted with Magic 8.3.573; typical corner, 3.3 V, 27 C unless stated) | Layout of 25 Nov (e449093) | Layout of 26 Nov |
| --- | --- | --- |
| `bank_cap` in the whole extracted tile: rise time 10 to 90 %, bank not selected and selected | 1047 ps, 1056 ps | 290 ps, 291 ps |
| The same at ff 3.6 V -40 C and at ss 3.0 V 125 C | 636 ps; not recorded | 174 ps; 544 ps |
| On the cut-out, edge made by the bank's own divider: rise of `bank_a` (input of the driver); rise and fall of `bank_cap`; delay from `bank_a` to `bank_cap` | 641 ps; 1046 and 552 ps; 681 ps | 877 ps; 289 and 209 ps; 442 ps |
| Clock pin to `bank_cap` at the flip-flops (typical; ff; ss) | 1.92 ns; 1.14 ns; 3.66 ns | 1.77 ns; 1.05 ns; 3.40 ns |
| N2: step of the last output crossing per factor of sqrt(10), falling data (34.0 ps corresponds to the latch's tau) | 7.5 to 15.7 ps | 28.6 to 33.4 ps (28.8 to 33.2 ps with a 50 ps ramp at the input of the driver) |
| N2: step of the last output crossing per factor of sqrt(10), rising data (34.0 ps corresponds to the latch's tau) | 8.1 to 18.9 ps | 28.0 to 33.4 ps (28.3 to 34.0 ps with a 50 ps ramp at the input of the driver) |
| N2 at ss 3.0 V 125 C, falling data, edge of the divider at that corner: step per factor of sqrt(10) (55.4 ps corresponds to the latch's tau of 48.1 ps) | not simulated | 45.1 to 53.9 ps |
| N2: output later in a capture 1.5e-16 s from the critical time than in an ordinary capture, rising and falling data | 118, 182 ps (491, 498 ps with a 50 ps edge forced on `bank_cap`) | 428, 436 ps |
| N2: time constant of the predicted count (count model) | 7 to 14 ps | 28.7 ps, 0.97 of the latch's 29.57 ps |
| N1: step per factor of sqrt(10), falling and rising data (47.7 ps corresponds to the latch's tau) | 38.8 to 43.9; 45.2 to 45.5 ps | 39.1 to 43.8; 45.1 to 47.3 ps |
| Latch tau of N1, N2, N3 (typical) | 41.46, 29.57, 119.32 ps | 41.46, 29.57, 119.32 ps |
| Latch tau of DUT2, DUT3, DUT4, N1 and N2 at typical, ss 3.0 V 125 C and ff 3.6 V -40 C |  | equal to 0.001 ps in all fifteen cases; N3 within 0.013 ps |
| *d* at `ua[0]` = 1.0, 1.3, 1.8 and 3.3 V | 4539.76, 2687.54, 1842.56, 1401.69 ps | equal to 0.01 ps |
| Floor of DUT2, rising and falling data (25 C) | 1692.6, 2254.9 ps | 1692.3, 2254.6 ps |
| Bank, N1: floor, from `bank_cap` to the early observer's clock, rising and falling data | 1243.4, 1806.9 ps | 1207.1, 1789.7 ps |
| Bank, N2: floor, from `bank_cap` to the early observer's clock, rising and falling data | 1985.0, 3008.4 ps | 1648.7, 2659.3 ps |
| Bank, N3: floor, from `bank_cap` to the early observer's clock, rising and falling data | 1767.4, 2472.5 ps | 1678.6, 2385.8 ps |

Methods. The whole-tile numbers are from the bench of `layout/make_tb_chip.py` with a current probe on every cell
(`tools/tile_run.sh`, `tools/edges_raw.py`). The cut-out is the front end and the bank taken from the extraction, with
the controller replaced by sources (`verification/physical/tools/sim/cutout.py`). In it the capture edge is applied at
`bank_a`, the output of the divider's flip-flop and the input of the driver. Three forms of that edge were used: a 50
ps ramp; the waveform that the divider's own flip-flop produces when the divider is clocked (`tools/realdiv.py`,
recorded in `sim/bank_a_edge_typical.json`); and, for the control on the old layout, a 50 ps ramp forced on `bank_cap`
itself. With the recorded waveform the cut-out reproduces the edge of the whole tile: 289.0 ps against 289.5 ps, and
1772.2 ps against 1772.9 ps from the clock. The captures are those of `tools/tchar.py`, which is the bench of
`verification/physical/tools/sim/tchar.py` with the option `CAPWAVE` for the recorded waveform: the critical data time
is found by bisection to 1e-17 s, and captures are then taken at 15 distances from it, from 1.5 ns down to 1.5e-16 s
(`sim/lateness.txt`). The run at the slow corner uses the waveform recorded at that corner
(`sim/bank_a_edge_ss.json`): there the divider gives `bank_cap` a rise time of 546 ps on the cut-out and 544 ps in the
whole tile.

With the capture edge made by the bank's own divider, the last crossing of N2's output moves by 28.0 to 33.4 ps per
factor of sqrt(10) for distances of 1.5e-12 to 1.5e-15 s, which is a local time constant of 24.4 to 29.0 ps, 0.82 to
0.98 of the latch's 29.57 ps; the count model gives 28.7 ps, 0.97 of it. The step still grows slowly as the distance
shrinks, so the local time constant depends a little on where it is taken; the count model takes this into account
(`sim/count_n2_*.txt`).

The whole extracted tile was simulated again (`layout/make_tb_chip.py`): with `ui_in[7]` low and the data of DUT2
toggled once per trial at `ua[0]` = 1.8 V, 2 of 4 counted trials are events; with the bank selected and an early clock
on `ui_in[5]` 0.2 ns after the clock edge, 4 of 4 for N1, 4 of 4 for N2, 4 of 4 for N3; for N2 4 of 4 at ff 3.6 V -40
C and 4 of 4 at ss 3.0 V 125 C; with the early clock 6 ns after the clock edge, 0 of 4 for N2. `busy` is high and
`done` and `fault` are low at the end of every run.

## 5. Supply current and voltage drop

The model and the limits are those of `verification/physical/README.md`, Sections 3 to 5, with the rails and taps of
the new GDS (`layout/tap_rows.txt`; all rails 0.60 um wide as before).

| Run | Average and peak supply current, 25 Nov | 26 Nov | Largest instantaneous drop at a cell (two cases of the feed), 25 Nov | 26 Nov | Largest current against an electromigration limit, 26 Nov |
| --- | --- | --- | --- | --- | --- |
| bank not selected, typical | 45.85 uA, 1.65 mA | 46.69 uA, 1.95 mA | 9.4 to 17.4 mV | 11.5 to 24.2 mV | 2.7 % |
| bank selected (N2), typical | 52.32 uA, 2.84 mA | 52.85 uA, 2.63 mA | 21.7 to 33.8 mV | 21.1 to 32.6 mV | 2.6 % |
| bank selected, both data inputs toggled, ff 3.6 V -40 C | 61.79 uA, 4.91 mA | 62.36 uA, 4.48 mA | 34.7 to 55.4 mV | 34.0 to 53.0 mV | 3.2 % |

In every run the cell with the largest instantaneous drop is N2, as before. With the bank not selected the drop is
larger than before because the bank's divider and capture driver run in every trial whether the bank is selected or
not, and the edge is now faster. At the delay line the mean rise of the ground rail during the delay interval is 0.79
to 0.96 mV as before (`tile/delay_line_supply_*.txt`). The static drop is at most 0.35 mV. The decision of the audit
stands: no guard ring, decoupling cell or additional tap.

## 6. Not repeated

The Tiny Tapeout precheck with the PDK's KLayout decks in deep mode and its antenna deck, which the `gds` workflow on
GitHub runs on the pushed commit; the count model of DUT2 and the other numbers of
`verification/physical/SIMULATIONS.md` for DUT1 to DUT4, whose cells and wiring above y = 199 um are identical (*d*,
the time constants and the floors of DUT2 were repeated, see the table); extraction with Magic 8.3.703 beyond DRC and
LVS; captures of N2 at the fast corner and of N1 at the corners; wire resistance; any run on ecetesla0.

## 7. Files

| Folder | Files |
| --- | --- |
| `layout/` | `antenna_magic_8.3.573.txt`, `check_focus.txt`, `drc_magic_8.3.573.txt`, `drc_magic_8.3.703.txt`, `extraction_compared_with_simulated_netlist.txt`, `gate_check.txt`, `gds.sha1`, `klayout_main_deck.txt`, `lu_check.txt`, `lvs_report_magic8.3.573_netgen1.5.133.txt`, `lvs_report_magic8.3.703_netgen1.5.133.txt`, `mag_copy_check.txt`, `precheck_lite.txt`, `sch_check.txt`, `tap_rows.txt`, `tt_precheck_offline.md`, `xor_against_e449093.txt` |
| `sim/` | `bank_a_edge_ss.json`, `bank_a_edge_typical.json`, `capture_edge_from_the_divider_26nov.json`, `capture_edge_from_the_divider_26nov_ss.json`, `capture_edge_from_the_divider_e449093.json`, `captures_divider_edge_ss_3.0_125.0_n2fall.json`, `captures_divider_edge_typical_3.3_27.0_n1fall.json`, `captures_divider_edge_typical_3.3_27.0_n1rise.json`, `captures_divider_edge_typical_3.3_27.0_n2fall.json`, `captures_divider_edge_typical_3.3_27.0_n2rise.json`, `captures_ramp_typical_3.3_27.0_n2fall.json`, `captures_ramp_typical_3.3_27.0_n2rise.json`, `captures_trial_inverters_1.5_times_as_strong_n2fall.json`, `count_n2_divider_edge.json`, `count_n2_divider_edge.txt`, `count_n2_ramp.json`, `count_n2_ramp.txt`, `delay_typical.json`, `driver_sweep_netlist_level.json`, `floor_rev2_typical_3.3_25.0_d2fall.json`, `floor_rev2_typical_3.3_25.0_d2rise.json`, `floorbank_rev2_typical_3.3_27.0_n1fall.json`, `floorbank_rev2_typical_3.3_27.0_n1rise.json`, `floorbank_rev2_typical_3.3_27.0_n2fall.json`, `floorbank_rev2_typical_3.3_27.0_n2rise.json`, `floorbank_rev2_typical_3.3_27.0_n3fall.json`, `floorbank_rev2_typical_3.3_27.0_n3rise.json`, `lateness.txt`, `tau_magic8.3.573.json` |
| `tile/` | `b1_early.edges.txt`, `b1_early.results.txt`, `b2_early.edges.txt`, `b2_early.results.txt`, `b2_early_ff.edges.txt`, `b2_early_ff.results.txt`, `b2_early_ss.edges.txt`, `b2_early_ss.results.txt`, `b2_late.edges.txt`, `b2_late.results.txt`, `b3_early.edges.txt`, `b3_early.results.txt`, `core.edges.txt`, `core.results.txt`, `delay_line_supply_b2_straps.txt`, `delay_line_supply_core_end.txt`, `delay_line_supply_core_straps.txt`, `delay_line_supply_ff_straps.txt`, `supply_b2.txt`, `supply_core.txt`, `supply_ff.txt`, `supply_summary.json` |
| `tools/` | `ant.tcl`, `checks.sh`, `edges_raw.py`, `kdrc.sh`, `lateness.py`, `magcopy_check.tcl`, `pexcmp.py`, `realdiv.py`, `rev2_data.py`, `rev2_docs.py`, `tchar.py`, `tile_run.sh` |

# Ways the tile could fail, and what covers each (26 Nov 2026)

Layout: the layout of 26 Nov 2026, GDS SHA-1 `b4e58624e51f5181f5d6e8b6fd023a27071e351e`. It is the layout of commit e449093 (GDS SHA-1 `4b6e7df96942da64c25916530b39da4a2fdb39d1`) with a stronger driver for the bank's capture edge (`verification/bank_driver/README.md`); above y = 199 um, where DUT1 to DUT4, the delay line and the controller are, the two are identical. Checks named below without a layout were repeated on the layout of 26 Nov. Of the simulations of the identical part, *d*, the time constants and the floors of DUT2 were repeated and agree to 0.01 ps, 0.001 ps and 0.4 ps; the others were not repeated. Each entry ends in one of three
states: **excluded** by a named check, **bounded** by a named number, or **open**. "Open" means that no check or
number of this repository covers it; the last column says what would.

Sources: `README_analog.md`; `verification/layout/`, `verification/independent/`, `verification/bank/`,
`verification/physical/` (audit `README.md`, simulations `SIMULATIONS.md`); the `gds` workflow run 45730953549 on GitHub for commit e449093; `verification/bank_driver/` for the layout of 26 Nov.

## 1. Fabrication rules

| # | Failure | State | Covered by |
| --- | --- | --- | --- |
| 1.1 | A shape violates a width, spacing, enclosure or area rule | excluded | Magic DRC 8.3.573 and 8.3.703: 0 errors. KLayout GF180MCU main deck, flat: 0 violations. In the GitHub precheck the deck runs in deep mode on the pushed commit (e449093: 0 violations) |
| 1.2 | Antenna: a wire collects charge onto a gate during etching | excluded | Magic antenna check: 0. The KLayout antenna deck runs in the GitHub precheck on the pushed commit (e449093: 0) |
| 1.3 | Wrong layers, cell names, pin shapes or boundary for Tiny Tapeout | excluded | `tools/precheck_lite.py`: ALL PASS. The Tiny Tapeout precheck on GitHub runs on the pushed commit (e449093: passed) |
| 1.4 | 3.3 V and 5 V transistors share a well, or a well rule of the dual-voltage option is broken | excluded | KLayout deck: 0. Run alone with conservative settings, the well rules report NW.2b_MV six times, once inside each instance of the library cell `dffq_1`, as they do for the bare library cell (`verification/bank/layout/`) |
| 1.5 | A latch-up rule is broken (not in the KLayout deck) | bounded | largest distance from a diffusion to its tap 14.39 um; limit 15 um (`physical/data/lu_check.txt`) |
| 1.6 | Metal density outside the foundry's range | open | the decks are run without the density rules, as in the Tiny Tapeout precheck; density is a matter of the assembled chip |
| 1.7 | The 3.3 V library cells of N1 (`gf180mcu_as_sc_mcu7t3v3`) misbehave on silicon; the library is not silicon-proven | open | DRC, LVS and extraction of N1 are clean. A fault in N1 is confined to bank input 00: with `ui[7]` low the controller reads DUT1 to DUT4 through the joins. Only the chip decides |

## 2. Connectivity

| # | Failure | State | Covered by |
| --- | --- | --- | --- |
| 2.1 | The layout is not the netlist: a missing, extra or wrongly sized device, an open or a short | excluded | Netgen LVS: "Circuits match uniquely", 208 devices, 209 nets (Magic 8.3.573 and 8.3.703 extractions) |
| 2.2 | The netlist is not the schematic | excluded | `tools/sch_check.py`: SAME CIRCUIT, 2,002 transistors and 2 diodes; `tools/check_focus.py`: ALL SAME |
| 2.3 | The controller's cells are not the Verilog | excluded | `tools/check_controller_netlist.py`, `tools/check_controller_flats.py`; the controller is unchanged since 06823df |
| 2.4 | A transistor gate is left floating | excluded | `physical/tools/gate_check.py`: of 506 gate nets, 0 without a source, drain, diode or tile pin |
| 2.5 | A cell is not connected to both supply rails | excluded | LVS (supply nets compared); `physical/data/rail_geom.txt`: all 622 placed instances lie on one `VDPWR` and one `VGND` rail |
| 2.6 | A tile pin is connected to the wrong net, or the pin list differs between GDS, LEF, Verilog and `info.yaml` | excluded | precheck pin checks; the whole-tile benches drive the extracted netlist by pin name |
| 2.7 | The bank disturbed the part verified before | bounded | XOR against 06823df above y = 199 um: 16 polygons on three layers, the splice and the pin columns; tau of DUT2 to DUT4 equal to 0.001 ps |

## 3. Function

| # | Failure | State | Covered by |
| --- | --- | --- | --- |
| 3.1 | The trial sequence, the counter or the read-out is wrong | bounded | whole extracted tile, transistor level: first trials of a block at the typical corner (events 2 of 4 at `ua[0]` = 1.8 V, as the floors predict) and with the bank at ss 3.0 V 125 C and ff 3.6 V -40 C (4 of 4). A whole block of 65,535 trials is covered by the logic simulation of the Verilog only |
| 3.2 | The bank's trial counter is out of step with the controller's | excluded | whole-tile runs with N1, N2 and N3: 4 events in 4 trials with the early clock 0.2 ns after the clock edge, 0 with it 6 ns after (N2) |
| 3.3 | The selector or a join passes the wrong flip-flop | bounded | each of N1, N2, N3 and DUT2 selected in a whole-tile run; DUT1 to DUT4 each selected on the cut-out, with four different floors |
| 3.4 | The counter has not settled when it is sampled | bounded | last count settled 18 to 60 ns after `b` rises, of 100 ns, at four corners (06823df; the controller and its rows are unchanged) |
| 3.5 | A coupled glitch clocks the early observer | bounded | largest excursion of the early clock from a neighbour 0.35 V (data input, 0.1 ns edge) and 0.32 V (capture edge), of 3.3 V (`physical/data/coupling.txt`) |
| 3.6 | The early observer itself stays undecided | bounded | its sample is read by the controller 100 ns later; with a time constant of the order of 0.1 to 0.2 ns the chance is below e^-500 |
| 3.7 | ngspice finds no operating point of the tile with N1 without a 1e12 ohm shunt on every node | bounded | a property of the simulator's start, not of the circuit: no gate floats (2.4); the quiescent current found is 5 nA |

## 4. Timing

| # | Failure | State | Covered by |
| --- | --- | --- | --- |
| 4.1 | The delay line cannot reach the delays the measurement needs | bounded | *d* from 1.40 ns (`ua[0]` = 3.3 V) to 6.18 ns (0.9 V) at the typical corner; 0.86 to 3.32 ns at ff 3.6 V -40 C and 2.73 to 11.35 ns at ss 3.0 V 125 C over `ua[0]` = 3.0 to 0.9 V. The fit of DUT2 needs *d* above about 3.3 ns |
| 4.2 | The floors lie elsewhere at other corners | bounded | at ff 3.6 V -40 C: DUT1 1.35 ns rising (1.51 V) and 1.56 ns falling (1.34 V); DUT2 0.97 ns rising (2.24 V) and 1.28 ns falling (1.58 V); at ss 3.0 V 125 C: DUT1 4.66 ns rising (1.34 V) and 5.47 ns falling (1.20 V); DUT2 3.37 ns rising (1.80 V) and 4.55 ns falling (1.35 V) (`physical/SIMULATIONS.md`, Section 5). Not computed: DUT3 at ff 3.6 V -40 C, DUT4 at ff 3.6 V -40 C, DUT3 at ss 3.0 V 125 C, DUT4 at ss 3.0 V 125 C |
| 4.3 | Wire resistance, absent from the extraction used elsewhere, changes the delays | bounded | at most 1.3 ps on the nets of the measurement path and 70 ps on `run`, from the extracted resistor networks (`physical/SIMULATIONS.md`, Section 6). The simulation of Magic's netlist with resistance is not used: its capacitance is inconsistent |
| 4.4 | The monitor pins do not report *d* | bounded | the pin delay is 0.07 to 0.12 ns shorter than *d* (typical); a tau fitted against it is 0.9 to 1.7 % long; ratios are not affected |
| 4.5 | *d* depends on the data | bounded | 0.5 % longer with the data high at the capture edge (8.6 ps at 1.8 V, 22.4 ps at 1.0 V); below 0.1 % on a fitted tau |
| 4.6 | The bank's early clock arrives with unknown delay and jitter | bounded for the delay, open for the jitter | only differences of the delay enter the fit. Jitter that does not depend on the delay setting multiplies K by a constant; its size depends on the bench source and on the pad path, which are not modelled |
| 4.7 | The controller samples the selected output too early | bounded | late samples at 50 and 100 ns; the new value arrives within 3 ns at the typical corner (`README_analog.md`, "After layout") |

## 5. Electrical

| # | Failure | State | Covered by |
| --- | --- | --- | --- |
| 5.1 | A supply wire carries more current than electromigration allows | bounded | largest average current 3.2 % of the limit at 125 C (10 uA in a 0.60 um rail, 6 uA in a via, 29 uA in a 2.00 um stripe) |
| 5.2 | The supply voltage at a cell is too low on average | bounded | static drop at most 0.35 mV |
| 5.3 | The supply at a cell dips when the tile switches | bounded | 12 to 53 mV for an instant, at N2 (resistive model, no capacitance); tau moves by 0.02 to 0.03 % per mV |
| 5.4 | The supply disturbance moves *d* | bounded | ground at the delay stage rises 0.8 to 1.0 mV on average during the delay interval (straps feed), about 3 mV (end feed): 3 to 20 ps on *d* at `ua[0]` = 1.0 V, the same in every trial; 1 to 2 ps between data high and low |
| 5.5 | The supply outside the tile (power switch, straps, pads, bond wires, board) drops or rings | open | the switch alone is 1.3 to 1.6 ohm by its transistor model (2 to 8 mV at the current peaks). Inductance and the rest are unknown. The bench measurement of the monitor delay contains whatever is common to all trials |
| 5.6 | Latch-up | bounded | tap distances (1.5); no diffusion on a pad; 445 substrate and 445 well taps; LU.7 ratio 15.5 % against 3 % |
| 5.7 | Electrostatic discharge on `ua[0]` reaches the gate of the delay line's control transistor | open | the tile has an antenna diode on the net and no clamp of its own; protection is that of Tiny Tapeout's pad and analog switch |
| 5.8 | The 3.3 V transistors of N1 and N2 see more than their rated voltage | bounded | every signal in the tile swings between `VGND` and `VDPWR`, which comes from Tiny Tapeout's 3.3 V switch (`uses_vapwr` is false in `info.yaml`); simulated to 3.6 V. `ua[0]` reaches only a 5 V transistor and a diode |
| 5.9 | Noise through the common substrate moves the delay line's control transistor | open | the extraction treats the substrate as one ideal node. The row of the delay line has a substrate tap every 23.5 um |
| 5.10 | The tile heats itself | bounded | 46 to 62 uA at 3.3 to 3.6 V: 0.15 to 0.22 mW |

## 6. Measurement

| # | Failure | State | Covered by |
| --- | --- | --- | --- |
| 6.1 | K is not exponential in *d* where it is fitted | bounded | count model of DUT2 on the revised layout: straight from *d* = 3.21 ns (0.95 ns above the falling-data floor), counted time constant 0.91 to 0.95 of the latch's tau (`physical/SIMULATIONS.md`, Section 7); N2 computed there as well. The other flip-flops are not computed |
| 6.2 | False events below the floor are taken for metastability | bounded | floors: `docs/info.md` (typical) and 4.2; the bench finds them with data toggled once per trial |
| 6.3 | The data edges are not random relative to the capture edge | open | a requirement on the bench source (`docs/info.md`, "External hardware"): its frequency must not be a simple fraction of the trial rate |
| 6.4 | Noise on `ua[0]` blurs *d* | bounded | *d* moves 5 to 19 ps per mV between 1.2 and 0.9 V; the voltage must be held to about 1 mV |
| 6.5 | The extraction is wrong | bounded | Magic 8.3.573 and 8.3.703 differ by 3.7 to 5.9 % in tau; the ratios between the NAND flip-flops by less than 1.1 % |
| 6.6 | Too few events for a fit | bounded | K is proportional to the data frequency and to the number of blocks; 100 events give about 10 % on a point (`docs/info.md`) |
| 6.7 | The bank's delay steps are not what the bench source claims | open | N3 against DUT3 on the same chip compares the bank's path with the delay line; the two are expected to agree (119.3 against 119.2 ps simulated) |
| 6.8 | The time constant on silicon differs from the model's | open | this is what the chip measures. The prediction that is tested is the order and the ratios: DUT3 below DUT2 below DUT4 |
| 6.9 | The bank's capture edge is too slow for its fast flip-flops | bounded | found on 26 Nov on the layout of e449093: `bank_cap` rose in 1.05 ns and the slave of N2, which that edge opens, hid the latch's lateness (local time constant of the count 7 to 14 ps where the latch has 29.6 ps). Removed the same day by a stronger driver: `bank_cap` now rises in 290 ps, and N2's last crossing moves with 24.4 to 29.0 ps; count model 28.7 ps, 0.97 of the latch's (`bank_driver/README.md`). Count model at the typical corner; at the slow corner captures with falling data give 39.2 to 46.8 ps where the latch has 48.1 ps |

## 7. Process, supply and temperature

| # | Failure | State | Covered by |
| --- | --- | --- | --- |
| 7.1 | tau outside the range the instrument can measure | bounded | DUT2 86 to 271 ps, DUT3 72 to 227 ps, DUT4 103 to 321 ps, N1 29 to 66 ps, N2 20 to 48 ps, N3 72 to 227 ps between ff 3.6 V -40 C and ss 3.0 V 125 C |
| 7.2 | The ratios, which are the claim, change with the corner | bounded | DUT3 to DUT2 0.836 to 0.837 and DUT4 to DUT2 1.184 to 1.200 over three corners and two extractions |
| 7.3 | The controller fails at a corner | bounded | margins at four corners for 06823df (`README_analog.md`); whole tile with the bank at ss and ff |
| 7.4 | Random mismatch between transistors | open | no Monte Carlo run on the extracted tile. Mismatch inside a latch moves its balance point, not its rate of growth to first order; the measurement does not use the balance point |
| 7.5 | Ageing, or a supply outside 3.0 to 3.6 V | open | not examined |

## Summary

Excluded or bounded: every entry except 1.6, 1.7, 5.5, 5.7, 5.9, 6.3, 6.7, 6.8, 7.4 and 7.5, and the jitter part of 4.6. Entry 6.9 was open for the layout of e449093, which is the revision submitted to Tiny Tapeout until the layout of 26 Nov is pushed and submitted. Of the open entries, 6.3 and 6.7 are
requirements on the bench; 5.5, 5.9 and 7.4 are limits of the model; 1.6, 1.7 and 5.7 depend on Tiny Tapeout or on
the silicon; 6.8 is the purpose of the chip.

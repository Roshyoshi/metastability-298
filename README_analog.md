# Metastability characterizer: schematics, layout and checks (GF180, analog 1x2 tile)

**Tiny Tapeout verification record.** What is submitted is `gds/`, `lef/`, `src/project.v`, `info.yaml` and
`docs/info.md`. This file, `tools/`, `layout/` and `verification/` show how that layout was generated and checked.

This folder adds the transistor-level design, the tile layout and the sign-off results. Everything in
`xschem/` and the two netlists in `layout/` are generated from one master netlist: the controller
(`src/gf180/compact_control.v`, 93 cells), plus the four flip-flops under test, the selector, the delay
line and the pin drivers.

**The controller was replaced on 11 November 2026 and the tile was laid out again on 17 November 2026.**
The schematics, the netlists, the layout and the logs in `verification/` all hold `compact_control`.

| Folder | What it holds |
|---|---|
| `xschem/` | Xschem hierarchy: `chip.sch` → `blocks/` → `cells_tx/` (every standard cell drawn with its transistors). `blocks/controller.sch` holds the controller as eight blocks, in the order of the design note in `compact_control.v`: `trial_clock`, `start`, `readings`, `count_pulse`, `trial_counter`, `event_counter`, `status`, `readout`. `focus/` holds the 15 presentation sheets (G01–G04 gate level, F01–F11 transistor level); `flat/` holds each block opened to transistors. `benches/` holds the simulation benches, and `run_benches.sh` runs them. |
| `docs/schematics/` | SVG exports of the 15 presentation sheets (from Xschem, exported again on 17 Nov 2026). |
| `gds/`, `lef/` | The tile as Tiny Tapeout takes it, in the folders of its analog template: `tt_um_metastability_characterizer.gds` and its abstract `tt_um_metastability_characterizer.lef`. The black box with the port list is `src/project.v`. |
| `layout/` | The same layout as Magic files in `mag/`, pictures of it in `renders/`, the LVS reference netlist and the pre-layout simulation netlist (`chip_lvs.spice`, `chip_sim.spice`), and the scripts that run the checks (`run_layout.sh`, `run_postlayout.sh`, `magic_checks.tcl`, `make_tb_chip.py`, `make_tb_tau.py`). |
| `verification/layout/` | Logs of the checks on this layout, 17 Nov 2026: KLayout GF180 rule deck (0 items), KLayout antenna (0 items), Magic DRC (0), Netgen LVS ("Circuits match uniquely"), the Tiny Tapeout precheck (12 of 12 checks), the whole-tile simulation before and after layout, and the post-layout tables. See "The layout and its checks". |
| `verification/sims/` | The 7 bench netlists, their ngspice logs, and `results.txt` (e.g. tau 88.9 ps baseline, 80.5 ps keeper x2, 102.3 ps forward x2), with `expected.json`. Run of 17 Nov 2026 by `xschem/run_benches.sh`: see "Running the benches". |
| `netlist/` | `controller_synth.v`: the controller as a flat cell list, written from the Verilog by `tools/controller_netlist.py`. `chip.cdl`: the master netlist of the whole tile, written by `tools/build_master.py`. |
| `tools/` | The Python generators that produced the netlist, schematics, layout and checks. They run from this repository; see "Regenerating" below. `kit2_gen.py`, which packed the earlier kits for ecetesla0, still points at the original build folder. |
| `host/` | The measurement programs, not yet run on hardware: `metachar_host.py` (MicroPython for the demo board: blocks, bring-up checks, toggle scan, survey), `fit_tau.py` (Poisson fit of ln K against *d*, with a self-test on synthetic counts) and `test_host_mock.py` (the host program against a software model of the board and tile). See `host/README.md`. |
| `verification/independent/` | A second check of this layout, 22 and 23 Nov 2026, made separately from `verification/layout/`: with the tool versions of ecetesla0 (Magic 8.3.573, Netgen 1.5.314) and with Magic 8.3.703. DRC, LVS, the extracted capacitance of both versions of Magic, tau, the delay line at three corners, the floors, the predicted count against *d* for DUT2, and predictions stated before silicon, with the data files they come from. See `verification/independent/README.md`. |
| `verification/bank/` | Checks and simulations of the revised layout with the bank, 25 Nov 2026: Magic DRC, KLayout decks, Netgen LVS, the comparison with the layout before the bank, tau, floors and the whole-tile runs. See "Bank of faster flip-flops". |
| `verification/physical/` | Physical-design audit of the revised layout, 26 Nov 2026 (`README.md`: supply current, voltage drop, current density, latch-up distances, coupling) and the simulations added the same day (`SIMULATIONS.md`: both extractions, three corners, floors, wire resistance, predicted count). See "Physical design" and "Testing". |
| `verification/FAILURE_SPACE.md` | The ways the tile could fail, each with the check that excludes it, the number that bounds it, or the statement that it is open. |
| `verification/bank_driver/` | The change of 26 Nov 2026 to the driver of the bank's capture edge: reason, checks of the new GDS, simulations repeated on its extraction. |

## Using the schematics
On ecetesla0: `cd xschem && bash setup.sh` once (it writes this folder's path into the `.sch`/`.sym` files),
then `bash view.sh F04` opens a sheet full screen with its net colours, and `bash export_svg.sh` writes SVGs.

On Windows, or anywhere without bash: `python xschem/setup.py <pdk_dir>` does the same, and also points the
sheets at your copy of the PDK (`<pdk_dir>` is the folder that holds `libs.tech/`). The sheets need the
PDK's Xschem symbols (`libs.tech/xschem/symbols/nfet_06v0.sym`, `pfet_06v0.sym`) and, for simulation, its
ngspice models (`libs.tech/ngspice/`).

Both write the machine's own paths into the sheets git tracks, and that must not be committed. In a checkout
you commit from, write a copy instead and open the sheets there (`build/` is ignored by git):

    python3 xschem/setup.py --to build/xschem <pdk_dir>
    bash build/xschem/view.sh F04

`docs/schematics/` holds the 15 focus sheets as `bash build/xschem/export_svg.sh` writes them. That script
needs a display; where there is none, run it under `xvfb-run`. (With Xschem's own no-display option, `-x`,
the caption at the bottom of a sheet can fall outside the picture.)

## Running the benches
    bash xschem/run_benches.sh                # 5 min; RECORD=1 also copies the netlists and logs to verification/sims

It writes such a copy into its results folder, netlists the seven benches in `xschem/benches/` from it with
Xschem, and runs them in ngspice. It needs xschem and ngspice, with `PDK_ROOT` set to the folder that holds
`gf180mcuD`. Expected values are on each sheet and in `benches/expected.json`.

Run of 17 Nov 2026, with the open_pdks build e8daeda7: `tb_inv_balance`, `tb_selector`, `tb_duts`, `tb_tau`,
`tb_delay` and `tb_frontend` give the values of 7 Nov 2026 on ecetesla0 to every printed digit, with the
timing capacitor now named `nfet_05v0` (see "Still open"). `tb_controller` gives the values in the next section.

## Checking the controller schematic against the Verilog
Open `xschem/blocks/controller.sch` in Xschem and press Netlist, then:

    python3 tools/check_controller_netlist.py <netlist folder>/controller.spice

It opens both the Xschem netlist and `compact_control.v` down to single transistors and compares them:
93 cells, 1,388 transistors, every net. It needs `pdk_cells/` (below).

The eight flat sheets `xschem/flat/ctrl_<block>.sch` (one controller block each, every transistor on one
page) have their own check: netlist them into one folder, then `python3 tools/check_controller_flats.py
<netlist folder>`.

`xschem/benches/tb_controller.sch` runs the controller at transistor level through reset, START and the
first eight counted trials (2.5 us). A whole block is 65,535 trials, 13.1 ms, which is too long for a
transistor-level run. Expected values are on the sheet and in `benches/expected.json`.

First run of that bench, 11 Nov 2026 (ngspice, typical corner, 3.3 V, 27 C, schematic only: no wiring
capacitance; upstream GF180 model files, not the open_pdks build):

| Measured | Value |
|---|---|
| events counted after 8 trials; busy, done, fault | 8; 3.3 V, 0 V, 0 V |
| first capture edge | 175.2 ns |
| first count at `uo_out[0]` | 926.9 ns |
| `allow_count` settles after `b` falls | 0.85 ns; `tick_n` stays at 3.23 V, no pulse |
| `b` rising to `tick_n` falling | 0.17 ns |
| count pulse width | 99.8 ns |
| one counter stage (clock pin to output) | 0.6 ns falling, 0.9 ns rising |
| 17 stages in a row, worst case | about 15 ns of the 100 ns before `b` falls |
| `run` edge, 10 % to 90 % (it drives 37 pins) | 3.3 ns |

Repeated on 17 Nov 2026 with the open_pdks build e8daeda7 (`verification/sims/tb_controller.log`): 8 events,
busy high, done and fault low, first capture at 175.2 ns and first count at 926.9 ns, as above. The bench
prints those; the other rows were read from its waveforms. The whole-tile bench measures them on the
schematic netlist with the same PDK build and gives the same values (the schematic columns of the controller
table in `verification/layout/results_postlayout.md`).

The same measurements on the whole tile, on the extracted layout and at the slow and fast corners, are under
"After layout" below.

## Regenerating
    git clone --depth 1 https://github.com/google/globalfoundries-pdk-libs-gf180mcu_fd_sc_mcu7t5v0 <lib>
    python3 tools/pdk_cells.py <lib>          # pdk_cells/: the library's cell netlists (not committed)
    python3 tools/controller_netlist.py       # netlist/controller_synth.v from the Verilog (needs yosys)
    python3 tools/build_master.py             # netlist/chip.cdl
    python3 tools/chip_netlists.py            # layout/chip_lvs.spice, layout/chip_sim.spice
    python3 tools/xschem_gen.py <out>         # cells_tx/, blocks/, chip.sch
With these inputs the generator reproduces every sheet that does not involve the controller byte for byte.

Two checks read the sheets back and compare them with `netlist/chip.cdl`, down to single transistors:

    python3 tools/sch_check.py xschem         # the whole hierarchy from chip.sch: SAME CIRCUIT
    python3 tools/check_focus.py              # the 15 focus sheets: ALL SAME

The layout generators read three things kept outside the repository:

    export GF180_SC_CELLS=<lib>/cells         # the same checkout as above: its cell LEF and GDS files
    export TT_ANALOG_DEF=<tt-support-tools>/tech/gf180mcuD/def/analog/tt_analog_1x2.def
    export GF180_MAGIC_TECH=$PDK_ROOT/gf180mcuD/libs.tech/magic/gf180mcuD.tech
    python3 tools/chip_gds.py                 # gds/*.gds, lef/*.lef, layout/layout_plan.json
    python3 tools/drc_lite.py                 # layout/drc_lite_report.json: the generator's own rule, short, open and antenna checks
    python3 tools/precheck_lite.py            # the Tiny Tapeout precheck's file checks
    python3 tools/render_layout.py            # layout/renders/*.png (needs matplotlib)

The GDS writer stamps the time into the file, so a regenerated GDS differs in those bytes and in nothing else.

## The layout and its checks
The tile is generated, not drawn. `tools/layout_gen.py` places the 149 cells in 14 rows: the front end with
the delay line, one row for each NAND flip-flop, nine controller rows, and the pin drivers under the pins.
`tools/route_gen.py` routes them in the channels between the rows: Metal2 up from each pin, Metal3 along
the channel, Metal4 between channels and to the tile pins (175 nets, 11.6 mm of wire, 95 Metal3 tracks,
45 Metal4 columns between channels). `tools/chip_gds.py` writes the GDS, the LEF and `layout_plan.json`. The
cells take x = 150 to 316 um and y = 199 to 324 um of the 346.64 x 325.36 um tile; the rest is empty.

![The whole tile: pins along the top edge, the pin drivers and nine controller rows under them, the three NAND flip-flops, and the front-end row with the delay line](layout/renders/tile.png)

`layout/renders/` has this picture and four close-ups with the cells named, drawn by `tools/render_layout.py`:
the front-end row (`frontend_row.png`), the delay line with the four transistors of its current-starved
stage marked (`delay_line.png`), the baseline NAND flip-flop (`dut_row.png`) and the start of the first
controller row (`controller_row.png`).

To open it in Magic or in KLayout:

    magic -rcfile $PDK_ROOT/gf180mcuD/libs.tech/magic/gf180mcuD.magicrc layout/mag/tt_um_metastability_characterizer.mag
    klayout gds/tt_um_metastability_characterizer.gds -l $PDK_ROOT/gf180mcuD/libs.tech/klayout/tech/gf180mcu.lyp

`layout/klayout_shots.py` saves the KLayout views of the same regions as pictures (the command is at the top
of that file). `layout/mag/` is a copy of the GDS, written by `layout/gds2mag.tcl` (the command is at the top of that file).
Loaded from those files the tile has no Magic DRC errors and matches the netlist as well. The GDS is the
layout that is checked and submitted: if the tile is edited in Magic and written back to GDS, run every
check again on that GDS.

    RECORD=1 bash layout/run_layout.sh        # 20 min: rule decks, Magic DRC, extraction, LVS, simulation before and after layout
    RECORD=1 bash layout/run_postlayout.sh    # an hour: corners, d, arrival, events and tau on the extracted netlist

Both need klayout, magic, netgen and ngspice, with `PDK_ROOT` set to the folder that holds `gf180mcuD`. They
write to `build/layout/`, and `RECORD=1` copies the logs to `verification/layout/`.

Run of 17 Nov 2026: WSL Ubuntu 24.04, Magic 8.3.703, Netgen 1.5.325, KLayout 0.30.12, ngspice 42, and the
open_pdks build e8daeda7, which is the build the Tiny Tapeout precheck installs.

| Check | Result | In `verification/layout/` |
|---|---|---|
| KLayout GF180 rule deck, all rules but density | 0 violations | `drc_klayout.log`, `klayout_drc_main.lyrdb` |
| KLayout antenna deck | 0 violations | `drc_antenna.log`, `klayout_antenna.lyrdb` |
| Magic DRC, full style | 0 errors | `drc_magic.txt` |
| Netgen LVS against `layout/chip_lvs.spice` | Circuits match uniquely | `lvs_report.txt`, `lvs.log` |
| Tiny Tapeout precheck, tt-support-tools 8f7b506 | 12 of 12 checks pass | `tt_precheck.md` |
| Whole tile before and after layout: reset, START, four count pulses | busy high, done and fault low, no events, in both | `tb_chip_pre.log`, `tb_chip_post.log` |
| The generator's own checks | no rule violation, short or open; worst antenna ratio 188 of 400 | `layout/drc_lite_report.json` |

The precheck was run on this machine, on `gds/` and `lef/` as they are here. The LEF marks the analog pins
`USE SIGNAL`, as Tiny Tapeout requires. The run on GitHub is still to come (see "Still open").

### After layout
Magic extracts the capacitance of every wire, to the substrate and to the wires beside it: 0.87 pF on the
signal nets with Magic 8.3.703, the version of this run. Wire resistance is not extracted. At the PDK's
0.09 ohm per square and 4.5 ohm per via it comes to about 100 ohm across the longest net, `run` (0.9 mm of
wire, 119 fF), which is worth some 10 ps, and to 1 or 2 ps on the capture and early-sample clocks.

`verification/layout/results_postlayout.md` has every table: *d* against `ua[0]`, the arrival of each
flip-flop's new value, tau, and the controller at four corners. At the typical corner, 3.3 V, 27 C:

| | Schematic | Layout (Magic 8.3.703) |
|---|---|---|
| *d*, capture edge to early-sample clock, `ua[0]` = 1.8 V | 1.10 ns | 1.72 ns |
| *d* over `ua[0]` = 3.3 V to 1.0 V | 0.80 to 2.93 ns | 1.31 to 4.19 ns |
| new value at the early observer, DUT1 | 1.25 ns | 2.26 ns rising, 2.37 ns falling |
| new value at the early observer, DUT2 to DUT4 | 0.96 to 0.97 ns rising, 1.15 to 1.17 ns falling | 1.69 to 1.82 ns rising, 1.94 to 2.13 ns falling |
| tau: DUT2, DUT3, DUT4 | 88.8, 80.6, 102.0 ps | 136.1, 113.8, 163.1 ps |
| wiring on each latch node `mq`, `mqb` | 0.25 fF, an estimate | 2.4 to 2.7 fF |
| `run` edge, 10 % to 90 % | 3.3 ns | 9.5 ns |
| one counter stage, output rising | 0.87 ns | 1.77 ns |
| last count settled after `b` rises | 15 ns | 31 ns |

What the layout changes:

- **tau is 41 to 60 % longer.** Every net, however short, goes up to a Metal3 track in a channel, so each
  latch node carries about 2.5 fF of wire where the schematic assumed 0.25 fF. The order of the three NAND
  flip-flops is the same and they are further apart: keeper doubled is 0.84 of the baseline (schematic
  0.91), forward gate doubled 1.20 (schematic 1.15).
- **The measurement window moves to lower `ua[0]`.** *d* is longer at every setting, and the flip-flop's
  new value takes longer still to reach the early observer. An early sample taken before it arrives reads
  the old value, and every trial in which the data changed then counts: with `ua[0]` = 3.3 V, 4 events in
  4 counted trials, on the schematic and on the layout. The sample also needs the early observer's setup
  time after the arrival. At the typical corner 0.54 ns was enough (`ua[0]` = 1.3 V, DUT2, no events). At
  slow 3.0 V 125 C 0.62 ns was not: of the eight counted trials, the four in which the value fell were
  events, and the four in which it rose, 1.19 ns ahead of the sample, were not. At `ua[0]` = 1.1 V there,
  2.2 ns ahead, none was. In continuous operation the lowest usable *d*, the floor, is set by falling data:
  the second check (`verification/independent/README.md`, Section 7; Magic 8.3.573, typical corner,
  25 C) puts it at 2.38 ns for DUT2 (`ua[0]` = 1.41 V), 2.59 ns for DUT3 (1.33 V), 2.53 ns for DUT4
  (1.35 V) and 2.87 ns for DUT1 (1.24 V), and the straight part of ln K for DUT2 begins near 3.4 ns
  (`ua[0]` near 1.14 V, Section 8). So after layout every measurement setting lies below the voltage of the
  falling-data floor, 1.24 to 1.41 V depending on the flip-flop, and the fit of DUT2 uses `ua[0]` below
  about 1.14 V. These values are those of the layout of 06823df; with the bank the floors are 0.09 to 0.14 ns
  lower (falling data: 2.25 ns for DUT2 at 1.47 V, 2.45 ns for DUT3 at 1.38 V, 2.39 ns for DUT4 at 1.41 V,
  2.73 ns for DUT1 at 1.28 V; see "Bank of faster flip-flops"). `docs/info.md` has the post-layout tables.
- **The monitor pins read less than *d*.** The delay from `uio_out[4]` to `uio_out[5]` is 0.07 to 0.12 ns
  shorter than *d* at the typical corner (0.05 ns on the schematic), and 0.05 to 0.22 ns over the corners.
- **The controller keeps its margins at all four corners**, typical, slow 3.0 V at -40 C and 125 C, and fast
  3.6 V at -40 C. For the four points the design note in `compact_control.v` leaves to SPICE:
  - The last count settles 18 to 60 ns after `b` rises, of the 100 ns before `done` and `allow_count`
    sample it.
  - `allow_count` rises 0.9 to 3.0 ns after `b` falls, and `tick_n` stays within 50 mV of the supply until
    the first count.
  - `run` is the slowest wire, 5.9 to 17.3 ns from 10 % to 90 %. Nothing reads it for 150 ns after it
    changes, and the flip-flops it releases get their first clock 250 ns after, so it needs no buffer.
  - Counter switching is over before the next capture, 50 ns after `b` rises, except at slow 3.0 V 125 C
    for the longest ripples: with every stage at its slower edge, one that reaches `n[14]` or further takes
    53 to 60 ns there. That is 3 of the 65,535 counted trials in a block (after counts 16,383, 32,767 and
    49,151).

  In every run busy is high, done and fault are low, and the count pulse is 99.3 to 99.9 ns wide.

**The version of Magic.** Every post-layout number above comes from the extraction by Magic 8.3.703. The
second check (`verification/independent/README.md`, Sections 3, 5 and 6) also extracted the same layout with
Magic 8.3.573, the version on ecetesla0: it places more capacitance from the wires to `VGND` (475 fF
against 140 fF over the tile; 1.22 pF on the signal nets in all), so tau is 142.6, 119.2 and 169.2 ps for
DUT2, DUT3 and DUT4 and *d* is 6.5 to 8.3 % longer. With 8.3.703 and its own benches it obtains 135.9, 113.8
and 163.0 ps. The ratios of tau to DUT2 stay at 0.836 to 0.838 (DUT3) and 1.182 to 1.199 (DUT4) over both
extractions and every condition examined. Which version is nearer the silicon has not been established.

`layout/make_tb_chip.py` finds the nets it measures from the cells around them, so the same bench runs on
both netlists. `layout/make_tb_tau.py` measures tau the way `xschem/benches/tb_tau.sch` does; on the
schematic with the sheets' wiring estimates it gives 88.8, 80.6 and 102.0 ps where that bench gave 88.9,
80.5 and 102.3 ps. On the extracted netlist it takes the nine cells of each flip-flop with every wiring
capacitor on their nets, and ties the far end of a capacitor to another net to ground.

## Bank of faster flip-flops (added 25 November 2026)

The revision of 25 Nov 2026 adds a second set of flip-flops under test, the bank, below the existing rows of the
tile. `docs/info.md` describes its pins and how to measure with it. Everything in the bank comes from the same
generators as the rest of the tile, extended for it; the logs of the checks and simulations named here are in
`verification/bank/`.

**Circuit** (`tools/build_master.py`, lists `BANK`, `BANK_SUB`, `J3A_DEVICES`; sheets `xschem/blocks/bank*.sch`,
`meta_dut_n3ffb.sch`, `meta_dut_j3a.sch`, `joins.sch`).

| Block | Contents |
| --- | --- |
| Trial clock copy | `dffq_1`, `dffrnq_1` and `inv_1`: a divider by four of the 20 MHz clock, reset with the controller, so the bank's capture edge follows the same clock edge as the controller's |
| Capture edge | `inv_4` and `inv_12` in series (two `inv_2` until 26 Nov 2026; see "The bank's capture driver" below) |
| Data input | two `inv_2`; the data comes from `uio_in[0]` |
| N1 `meta_dut_n3ffb` | NAND master-slave flip-flop of nine cells of `gf180mcu_as_sc_mcu7t3v3` (3.3 V transistors, L = 0.28 um): forward and keeper gates `nand2_4`, the others `nand2_2` and `inv_2` |
| N2 `meta_dut_j3a` | jamb-latch flip-flop of 32 drawn 3.3 V transistors (L = 0.28 um): a cross-coupled pair written through two NMOS stacks, a slave of minimum size and an output inverter |
| N3 | a third instance of `meta_dut_keeper`, the circuit of DUT3 |
| Selector | `mux4_1` on `{ui_in[2], ui_in[1]}`: N1, N2, N3, a tie-low cell |
| Early observer | `dffq_1` clocked from `ui_in[5]` through `inv_1` and `inv_2` |
| Joins | two `mux2_1` on `ui_in[7]`: the controller's inputs `q_selected` and `early_e` take either the existing selected output and early sample or the bank's |

The tile now has 2,002 transistors and 2 diodes (1,978 until the capture driver was changed on 26 Nov). The controller (`src/gf180/compact_control.v`) and its synthesized
netlist are unchanged.

**Layout** (`tools/bank_blocks.py`, `tools/j3a_gen.py`, `tools/bank_layout.py`, called from `tools/chip_gds.py`).
The existing rows, channels and routing are generated exactly as for commit 06823df, and the bank is then added
in four rows between y = 168.5 um and 194.8 um, below the lowest existing row (y of 199 um and above): one row of
3.3 V cells with N2 and N1, and three rows of the 5 V library with N3, the trial clock copy, the drivers, the
selector, the observer and the joins. The two joins are a splice of the existing routing: the Metal4 columns
that carried the selected output and the early sample to the controller are cut where they leave channel 1 (two
Via3 removed), and columns below channel 1 take the two nets to the joins and bring the join outputs back. Before
the bank was added, the generators were shown to reproduce the GDS of 06823df (KLayout XOR: 0 polygons on all 21
layers). With the bank, the region of the existing tile (y above 199 um) differs from 06823df by 16 polygons on
three layers: 2 Via3 removed, and 2 Via3, 1 Metal3 and 11 Metal4 added. These are the splice and the Metal4
columns that bring `clk`, `rst_n` and the five new inputs down from the pins at the top edge; the columns run
clear of the rows of DUT1 to DUT4. Every other layer is identical there (`verification/bank/layout/xor_region.txt`).

The 3.3 V cells of N1 and the tap cell of N2 come from the library `gf180mcu_as_sc_mcu7t3v3` of Avalon
Semiconductors (https://github.com/AvalonSemiconductors/gf180mcu_as_sc_mcu7t3v3, commit d954799, Apache License
2.0). To regenerate the layout, set `GF180_AS_CELLS` to the folder `pdk/libs.ref/gf180mcu_as_sc_mcu7t3v3/mag` of
a checkout, next to the inputs listed under "Regenerating". DRC and LVS of the GDS need only the PDK:
`layout/chip_lvs.spice` contains the three 3.3 V cells as subcircuits.

**Checks of the layout of 25 Nov** (commit e449093, GDS SHA-1 `4b6e7df96942da64c25916530b39da4a2fdb39d1`). The checks of the present layout are listed under "The bank's capture driver" below.

| Check | Tool | Result |
| --- | --- | --- |
| DRC | Magic 8.3.573, PDK `gf180mcuD` | 0 errors |
| DRC, main rule deck | KLayout 0.28.16, flat | 621 rules run, 0 violations |
| DRC, well rules run alone with conservative settings | KLayout 0.28.16 | 6 reports of NW.2b_MV, one inside each instance of the library cell `dffq_1`; the layout of 06823df gives 4 of the same and the bare library cell 1 |
| LVS against `layout/chip_lvs.spice` | Netgen 1.5.314 on the Magic 8.3.573 extraction | "Circuits match uniquely": 208 devices, 209 nets at the top level; also with `MCT` renamed `nfet_06v0` on both sides, as ecetesla0 extracts it |
| Antenna | Magic 8.3.573 | 0 |
| Schematics against the netlist | `tools/sch_check.py`, `tools/check_focus.py` | SAME CIRCUIT (1,978 transistors, 2 diodes); ALL SAME |
| Tiny Tapeout precheck, offline | tt-support-tools `precheck.py` | 10 of 12 steps pass; the two steps that run the PDK's KLayout decks in deep mode and its antenna deck need a newer KLayout than is installed here, and are confirmed by the `gds` workflow on GitHub after the push |

**Simulation of the extracted layout** (Magic 8.3.573, ngspice, methods of `verification/independent/`).

| Quantity | 06823df | Revised layout |
| --- | --- | --- |
| Latch τ of DUT2, DUT3, DUT4, typical | 142.554, 119.249, 169.090 ps | 142.554, 119.249, 169.090 ps |
| The same at ss 3.0 V 125 C, ss 3.0 V −40 C and ff 3.6 V −40 C | | equal to 0.001 ps in all nine cases |
| Wiring capacitance on the latch nodes of DUT2, DUT3, DUT4 | | equal to 0.00001 fF |
| *d* at `ua[0]` = 1.0, 1.3, 3.3 V | 4537.86, 2685.74, 1399.95 ps | 4539.76, 2687.54, 1401.69 ps |
| Wire capacitance of `selected_q` | 10.64 fF | 7.05 fF, and 8.20 fF on the new net from the join to the controller |
| Floor of DUT2, rising and falling data (25 C) | 1787.4, 2379.5 ps | 1692.6, 2255.0 ps |
| Floors of DUT3 | 1930.3, 2586.4 ps | 1827.6, 2451.8 ps |
| Floors of DUT4 | 1874.3, 2525.7 ps | 1772.3, 2391.5 ps |
| Floors of DUT1 | 2455.1, 2873.1 ps | 2347.1, 2734.2 ps |
| Latch τ of N1, N2, N3, typical | | 41.469, 29.577, 119.423 ps |
| The same at ss 3.0 V 125 C | | 65.578, 48.110, 226.973 ps |
| The same at ff 3.6 V −40 C | | 29.293, 20.301, 72.331 ps |

The floors are lower because the selected output now drives a shorter net. The whole extracted tile was simulated
with `layout/make_tb_chip.py` (option `--bank`): with `ui_in[7]` low and the data of DUT2 toggled once per trial at
`ua[0]` = 1.8 V, 2 of 4 counted trials are events, the falling ones, as the floors predict for *d* = 1.84 ns; with
the bank enabled and its data toggled once per trial, an early clock on `ui_in[5]` 0.2 ns after the clock edge
gives 4 events in 4 trials for N1, N2 and N3 at the typical corner and for N2 at ss 3.0 V 125 C and ff 3.6 V
−40 C, and one 6 ns after it gives 0 for N2. `busy` is high and `fault` is low at the end of every run; `done` is
still low, because the 1.6 us simulated are a small part of one block. The bench adds
1e12 ohm from every node to ground (ngspice `rshunt`), without which ngspice does not find the operating point of
the tile with N1 in it.

**Added on 26 Nov 2026** (`verification/physical/SIMULATIONS.md`; scripts in `verification/physical/tools/sim/`). The
revised layout was extracted again with Magic 8.3.573 and with Magic 8.3.703. Both extractions have 0 DRC errors
and match `layout/chip_lvs.spice` in Netgen (208 devices, 209 nets).

| Quantity (typical corner unless stated) | Magic 8.3.573 | Magic 8.3.703 |
| --- | --- | --- |
| tau of DUT2, DUT3, DUT4 | 142.55, 119.22, 169.16 ps | 136.06, 113.80, 163.13 ps |
| tau of N1, N2, N3 | 41.46, 29.57, 119.32 ps | 39.16, 28.28, 113.84 ps |
| DUT3 / DUT2 and DUT4 / DUT2, over typical, ss 3.0 V 125 C and ff 3.6 V -40 C | 0.836 to 0.837; 1.184 to 1.187 | 0.836 to 0.837; 1.197 to 1.200 |
| *d* at `ua[0]` = 1.0, 1.8, 3.0 V | 4539.8, 1842.6, 1428.4 ps | 4193.5, 1715.2, 1336.1 ps |
| *d* at `ua[0]` = 1.0 and 3.0 V, ss 3.0 V 125 C | 8203.7, 2728.9 ps | |
| *d* at `ua[0]` = 1.0 and 3.0 V, ff 3.6 V -40 C | 2574.5, 860.6 ps | |

Floors in continuous operation at the corners (8.3.573; in brackets `ua[0]` at the floor), at ff 3.6 V -40 C: DUT1 1.35 ns rising (1.51 V) and 1.56 ns falling (1.34 V); DUT2 0.97 ns rising (2.24 V) and 1.28 ns falling (1.58 V); at ss 3.0 V 125 C: DUT1 4.66 ns rising (1.34 V) and 5.47 ns falling (1.20 V); DUT2 3.37 ns rising (1.80 V) and 4.55 ns falling (1.35 V). At the typical corner they are 1.69 and 2.25 ns for DUT2 and 2.35 and 2.73 ns for DUT1. For the bank, the floor is the delay from the bank's capture edge at the flip-flops to the clock of its early observer (typical corner; these are the values of the layout of 25 Nov, and those of the present layout are in the table of the next section): N1 1.24 ns rising and 1.81 ns falling; N2 1.99 ns rising and 3.01 ns falling; N3 1.77 ns rising and 2.47 ns falling.

The predicted count of DUT2 was computed again (8.3.573): the straight part of ln K begins at *d* = 3.21 ns,
0.95 ns above the falling-data floor (`ua[0]` near 1.17 V), with a counted time constant of 129.4 ps over 3.21 to
3.81 ns and 135.3 ps over 4.21 to 5.21 ns, 0.91 and 0.95 of the latch's tau. For N2 the same model shows a limit of the bank as built: its count falls with a local time constant of 7 to 14 ps, not with the latch's 29.6 ps, because the bank's capture edge has a rise time of 1.05 ns and hides most of the latch's lateness; with a fast edge forced on `bank_cap` the same captures give 29.0 and 28.8 ps (falling and rising data). These numbers for N2 describe the layout of 25 Nov; the driver of that edge was strengthened on 26 Nov (next section).

Wire resistance was extracted with Magic's `extresist` on the flattened tile. From the resistor networks, it adds
at most 1.3 ps on the nets of the measurement path and at most 70 ps on `run`. The netlist written with resistance
is not used for delays: in it the library flip-flop and the selector are 0.3 to 0.4 ns faster than in the same
flat extraction without resistance, which resistance cannot cause. Without resistance, the flat extraction gives
delays 3 to 5 % shorter than the hierarchical extraction used everywhere else.

**Not repeated for the revised layout:** the sign-off run of `verification/layout/`, which describes 06823df, and
any run on ecetesla0. Not computed: floors at the corners: DUT3 at ff 3.6 V -40 C, DUT4 at ff 3.6 V -40 C, DUT3 at ss 3.0 V 125 C, DUT4 at ss 3.0 V 125 C; predicted count against the delay: DUT1, DUT3, DUT4, N1, N3; time constants and floors on the flat extraction (Section 6) (`verification/physical/SIMULATIONS.md`, Section 8).

### The bank's capture driver (changed on 26 November 2026)

**Why.** The count model was run for N2 on the layout of 25 Nov (commit e449093). It showed that a slope measured on
N2 would not have been the time constant of its latch. The bank's capture edge, the net `bank_cap`, was driven by two
`inv_2` in series and rose in 1.05 ns from 10 to 90 % at the typical corner. The slave of N2 is opened by that edge
through two transistors 0.3 um wide, and while the edge is still rising the slave cannot follow the latch. Most of the
lateness of the latch therefore did not reach the output: in a capture 1.5e-16 s from the critical time the output
came 118 ps (rising data) and 182 ps (falling data) later than in an ordinary capture, where the same captures with a
50 ps edge forced on `bank_cap` give 491 and 498 ps. In terms of steps, the last crossing of the output moved by 7.5
to 15.7 ps (falling data) and 8.1 to 18.9 ps (rising data) for each factor of sqrt(10) in the distance of the data
edge from the critical time, where the latch's 29.6 ps correspond to 34 ps. N1, DUT1 to DUT4 and N3 were not affected
in this way (`verification/physical/SIMULATIONS.md`, Section 7).

**What changed.** In `tools/build_master.py`, list `BANK`, the cell `bank_cap0` is now `inv_4` and `bank_cap1` is
`inv_12` (sheet `xschem/blocks/bank_capture_drivers.sch`). Instance names, nets and the row are the same. The tile has
2,002 transistors and 2 diodes, 24 more than before, in the same 180 library cells and two custom blocks. Row B2,
which holds the trial clock copy, the data drivers and the capture drivers, is longer to the left: its transistors
span x = 240.98 to 307.98 um, before 255.54 to 308.01 um, and the generator routed the bank's nets again. Above y =
199 um, where DUT1 to DUT4, the delay line, the controller and the pin drivers are, the GDS is identical to that of
e449093 on every layer (`verification/bank_driver/layout/xor_against_e449093.txt`). The LEF is unchanged.

`inv_4` and `inv_12` draw their input pin as two Metal1 pieces, each on contacts to the one polysilicon shape that
forms all their gates; the library's LEF lists both pieces in one port. The router reaches one piece.
`tools/drc_lite.py` used to count every Metal1 piece of a pin as a terminal of its own and reported the other piece as
an open; it now reads the cell's GDS, follows Metal1, contacts and polysilicon, and counts such a pin as one terminal
only if they join the pieces (reported under `pins_joined_inside_cell` in `layout/drc_lite_report.json`). The
polysilicon strap between the pieces is 0.96 um wide and about two squares long, 15 ohm at 7.3 ohm per square, which
with half of the gate capacitance of `inv_12` is a time constant of about 0.3 ps. Netgen compares the extracted
layout, in which all fingers share one gate net, with the netlist: the circuits match.

**Result.** The edge now rises in 290 ps in the whole tile. With the capture edge made by the bank's own divider, the
last crossing of N2's output moves by 28.0 to 33.4 ps per factor of sqrt(10) for distances of 1.5e-12 to 1.5e-15 s,
which is a local time constant of 24.4 to 29.0 ps, 0.82 to 0.98 of the latch's 29.57 ps; the count model gives 28.7
ps, 0.97 of it. Everything that does not involve the bank's capture edge is as before.

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

The driver is not the fastest that the library allows. The flip-flop of the divider drives `bank_a` with a rise time
of 877 ps (641 ps before), because its output stage is of unit strength and now drives `inv_4`; a 50 ps ramp at the
same point gives 265 ps on `bank_cap` instead of 289 ps. A trial with both inverters one and a half times as strong
again, in the netlist of the cut-out with a 50 ps ramp at the input, gave 174 ps on `bank_cap` and moved the steps of
N2 by 1.9 ps (`verification/bank_driver/sim/lateness.txt`), so the layout was not changed further.

The whole extracted tile was simulated again (`layout/make_tb_chip.py`): with `ui_in[7]` low and the data of DUT2
toggled once per trial at `ua[0]` = 1.8 V, 2 of 4 counted trials are events; with the bank selected and an early clock
on `ui_in[5]` 0.2 ns after the clock edge, 4 of 4 for N1, 4 of 4 for N2, 4 of 4 for N3; for N2 4 of 4 at ff 3.6 V -40
C and 4 of 4 at ss 3.0 V 125 C; with the early clock 6 ns after the clock edge, 0 of 4 for N2. `busy` is high and
`done` and `fault` are low at the end of every run.

With the stronger driver the tile draws 46.7 uA on average while counting (before, 45.9 uA), 52.9 uA with the bank
selected (52.3 uA) and 62.4 uA at ff 3.6 V -40 C with both data inputs toggled (61.8 uA); the peaks are 1.95, 2.63 and
4.48 mA (1.65, 2.84 and 4.91 mA). The static drop at a cell is at most 0.35 mV, and the largest instantaneous drop is
12 to 53 mV, at N2 as before (before, 9 to 55 mV). The largest average current is 3.2 % of an electromigration limit.

**Checks of the present layout** (GDS SHA-1 `b4e58624e51f5181f5d6e8b6fd023a27071e351e`; logs in
`verification/bank_driver/layout/`).

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

**Not repeated on the present layout:** the Tiny Tapeout precheck with the PDK's KLayout decks in deep mode and its
antenna deck, which the `gds` workflow on GitHub runs on the pushed commit; the count model of DUT2 and the other
numbers of `verification/physical/SIMULATIONS.md` for DUT1 to DUT4, whose cells and wiring above y = 199 um are
identical (*d*, the time constants and the floors of DUT2 were repeated, see the table); extraction with Magic 8.3.703
beyond DRC and LVS; captures of N2 at the fast corner and of N1 at the corners; wire resistance; any run on ecetesla0.
`verification/bank_driver/README.md` lists every file.

## Physical design

This section states, for each physical effect that a layout has to account for, what the effect is and what this
tile does about it. The numbers come from the audit of 26 Nov 2026 in `verification/physical/README.md`, made on the layout of commit e449093; where the change of the bank's capture driver on the same day moved a number, the number of the present layout is given (`verification/bank_driver/README.md`, Section 5). References: A. Hastings, *The Art of Analog Layout*, 2nd ed., 2006 (cited as
Hastings); B. Razavi, *Design of Analog CMOS Integrated Circuits*, 2nd ed., 2017, Chapter 19 "Layout and
Packaging" (Razavi); the GF180MCU design manual (the manual).

**Substrate and wells.** In this process every NMOS transistor sits directly in the p-type substrate, which is
common to the whole chip, and every PMOS transistor sits in an n-well. The substrate must be tied to the lowest
potential and each well to the highest, through taps, so that no source or drain junction becomes forward
biased; a current that flows through the substrate raises its potential locally, which shifts transistor
thresholds and can forward-bias a junction (Hastings, Sections 4.4.1 and 4.4.3). *This tile:* no deep n-well and
no isolated p-well; 445 substrate taps on `VGND` and 445 well taps on `VDPWR`, in tap cells along every row,
with at most 28.8 um between neighbouring taps of a row.

**Latch-up.** A PMOS source in a well, the well, the substrate and an NMOS source form a parasitic pnpn
structure between the supplies. It switches on if injected current raises the voltage across the well or the
substrate resistance by about 0.6 V, and then holds itself on (Hastings, Sections 4.4.2 and 11.1.2; Razavi,
Chapter 19). The rules LU.1 to LU.4 of the manual limit the distance from any diffusion to a tap of its own well
or of the substrate, which limits that resistance. *This tile:* the largest distance is 14.39 um against 15 um,
inside the jamb latch N2; everywhere else it is at most 12.41 um. The PDK's KLayout rule deck does not contain
these rules, so `verification/physical/tools/lu_check.py` measures them on the GDS.

**Guard rings.** A ring of taps around a device collects carriers that a forward-biased junction injects, or
holds the substrate around a sensitive device at a quiet potential (Hastings, Section 13.2). The manual requires
them around diffusion that is connected directly to a pad (rules IO.1 and IO.3), where the voltage can go above
the supply or below ground.
*This tile:* none is drawn. No diffusion connects to a pad: all digital pins pass through the Tiny Tapeout
multiplexer and `ua[0]` passes through the Tiny Tapeout analog switch, then to one transistor gate and an antenna
diode. All cells are on one supply pair, and the measurement compares counts taken in the same state of the
tile.

**Supply distribution and voltage drop.** The supply current flows through the resistance of the supply wires,
so a cell far from the supply connection sees less than the full supply; the drop moves the delay of every gate
(Hastings, Section 14.3; Razavi, Chapter 19). *This tile:* three `VDPWR` and three `VGND` stripes on Metal4,
2.00 um wide, cross the rows; each row has two Metal1 rails 0.60 um wide; two via stacks join a rail to each
stripe it crosses. Simulated on the extracted layout, the tile draws 47 uA on average while counting (53 uA with the bank selected, 62 uA at the fast corner at 3.6 V), with peaks of 1.9 to 4.5 mA at the capture edge. The static drop at any cell is at most 0.35 mV. The largest instantaneous drop is 12 to 53 mV, at N2, at the far end
of the row that holds N1 and N2 and reaches only one stripe. At the delay line the ground rail rises by 0.8 to
1.0 mV on average during the delay interval if the tile is fed by the Tiny Tapeout straps.

**Electromigration.** A sustained current density moves metal atoms and eventually opens the wire; the lifetime
falls as the square of the current density and exponentially with temperature (J. R. Black, *IEEE Trans.
Electron Devices*, vol. 16, pp. 338-347, 1969; Hastings, Sections 4.1.2 and 14.3.3). The manual allows 0.67 mA
per um of wire width and 0.18 mA per via at 125 C. *This tile:* the largest average current is 10 uA in a rail (limit 402 uA), 6 uA in a via (180 uA) and 30 uA in a stripe (1340 uA): at most 3.2 % of a limit.

**Decoupling.** A capacitor between the supplies close to a cell supplies its switching current locally, so the
current does not have to come through the wire resistance and inductance. *This tile:* none is added. The tile
has 4.1 pF between its supplies from its own transistors and wires. The drops above do not threaten function
or lifetime; the one that is not small, at N2, is the same in every trial.

**Coupling between wires.** A switching wire injects charge into its neighbours through the capacitance between
them; the remedies are distance, a shield, or a low impedance on the victim (Hastings, Section 14.3.2; Razavi,
Chapter 19). *This tile:* the router places wires by channel and does not separate noisy from sensitive ones.
The extraction contains every coupling capacitance, so the simulations contain the effect. Three results: the
data input couples 0.35 V onto the early clock for an edge of 0.1 ns at the pin, which the clocked flip-flop
does not follow; the capture edge couples at most 0.32 V onto it; and *d* is about 0.5 % longer in trials in
which the data is high at the capture edge than in those in which it is low (22 ps at `ua[0]` = 1.0 V), partly
because wires that switch during the delay interval inject charge into the slow node of the delay line. The last
changes a fitted tau by less than 0.1 %.

**Matching.** Two devices drawn alike differ at random and systematically; matched devices are drawn with the
same size, orientation and surroundings, close together (Hastings, Sections 12.3 and 12.4; Razavi, Chapter 19).
*This tile:* nothing is measured as a difference between two devices. Mismatch inside a latch moves the data
time at which it balances, not the rate at which it leaves balance, and the data edges arrive at random times.
The three NAND flip-flops are built from the same nine cells in the same arrangement, in three adjacent rows,
and are routed alike, so that their wiring differs as little as the router allows (2.4 to 2.7 fF on each latch
node). N3 repeats DUT3 at another place with other wiring: simulated tau 119.32 against 119.22 ps.

**Antenna effect.** During plasma etching a wire collects charge. If it connects only to a transistor gate at
that stage of fabrication, the charge can damage the gate oxide; the rules limit the ratio of wire area to gate
area, and the remedies are a short hop to a higher metal near the gate or a diode to the substrate (Hastings,
Section 4.1.4). *This tile:* 0 violations in Magic's antenna check and in the PDK's KLayout antenna deck; the
generator's own estimate gives a worst ratio of 188 against a limit of 400. `ua[0]`, the one net that leaves the
tile towards an analog pad, has a diode cell.

**What was decided.** The audit changed nothing in the supply network, the taps or the wells; the reasons are in `verification/physical/README.md`, Section 1. The simulations of the same day led to one change of the layout, the driver of the bank's capture edge ("The bank's capture driver" above).

## Testing

Every statement about the tile rests on a named check. This section lists the checks, what each one shows and
what it cannot show, and then the order of work at the bench. `verification/FAILURE_SPACE.md` goes through the ways
the tile could fail and names the check or the number that covers each.

| Claim | Check | What it shows | What it cannot show |
| --- | --- | --- | --- |
| The layout obeys the foundry's rules | Magic DRC (8.3.573 and 8.3.703): 0 errors; KLayout GF180MCU main deck, flat: 0 violations; Magic antenna check: 0. The `gds` workflow on GitHub runs the KLayout deck in deep mode and the antenna deck on every push (for e449093, run 45730953549: 0 violations each) | every shape meets the width, spacing, enclosure, area and antenna rules of the deck | anything electrical; rules that are not in the deck (latch-up, current density) |
| The layout is the circuit of the netlist | Netgen on the Magic extraction against `layout/chip_lvs.spice`: "Circuits match uniquely", 208 devices, 209 nets | same devices, sizes and connections | that the netlist is the intended circuit; wire capacitance and resistance |
| The netlist is the circuit of the schematics and of the Verilog | `tools/sch_check.py`, `tools/check_focus.py`, `tools/check_controller_netlist.py` | the drawn schematics and the controller's Verilog give the same transistors and nets as `netlist/chip.cdl` | that the design is right |
| No gate is left undriven | `verification/physical/tools/gate_check.py` on the extracted netlist | each of the 506 nets that reach a gate also reaches a source, a drain or a diode, or is a pin of the tile | the logic level it is driven to |
| The tile functions | transistor simulation of the whole extracted tile (`layout/make_tb_chip.py`): reset, start, capture, early sample, count, at the typical corner, and with the bank at the slow and fast corners | the blocks work together for the first trials of a block | a whole block of 65,535 trials (13.1 ms); every input sequence |
| The timing is known | cut-out of the extraction: *d* against `ua[0]`, floors and arrival times, at three corners; wire resistance bounded from the extracted resistor networks | the delays of this netlist with these models | the delays of the silicon; they move by a factor of three between corners, hence the monitor pins |
| The time constants are known | growth of the balanced latch on the cut-out, with two extractions and two separately written benches | tau of each master latch to 0.1 % for a given extraction; the extractions differ by about 5 % | which extraction is nearer the silicon; the model near the balance point |
| The tile is electrically sound | `verification/physical/`: supply current per cell, resistive drop, current density, latch-up distances, coupling | margins against the manual's limits | the supply outside the tile; substrate noise; trigger current of latch-up |
| The count measures tau | count model on clocked captures of the cut-out (`verification/independent/`, Section 8; `verification/physical/SIMULATIONS.md`) | where ln K is straight and what slope it has in simulation | the result on silicon |
| The tile is accepted by Tiny Tapeout | precheck in the `gds` workflow on the pushed commit. For e449093 it passed, and Tiny Tapeout merged the revision into the shuttle on 26 Nov (pull request 65); the layout of 26 Nov is submitted in the same way after its push | file formats, pins, layers, rule decks | that the pull request is merged before the shuttle closes |

**The method behind the timing and tau numbers.** The whole tile takes many minutes per trial to simulate, so the
benches run on a cut-out: the front end and the bank taken from the extracted netlist with every wire capacitance,
and the controller replaced by sources at the nets where it meets them (`verification/bank/tools/cutout_bank.py`).
The cut-out gives the same *d* as the recorded runs to 0.01 ps. The time constant is measured by releasing the
balanced master latch with a small imbalance and timing the growth of the difference between its nodes; released
to either side the values agree to 0.05 ps for DUT2.

**What simulation leaves to the bench.** The models, the extracted capacitance and the ideal supply are
assumptions. The order of work at the bench is therefore from checks that need no model to the measurement:

1. Supply current. Measure the current of the tile in reset with the clock running and while it counts. Simulated:
   20 uA and 47 uA at the typical corner (53 uA with the bank selected). A current many times larger points to a
   fault before any count is read.
2. Counts that need no model. With the data input held constant every block gives K = 0. With the data toggled
   once per trial far from the capture edge, `ua[0]` = 2.5 V gives K = 65,535 and `ua[0]` = 1.0 V gives K = 0
   (`docs/info.md`).
3. The floors. Stepping `ua[0]` down, K falls to about half and then to 0 at the voltages listed in
   `docs/info.md`. Their order among the four flip-flops is a test of the selector and of the arrival times.
4. The delay. Measure the delay between `uio[4]` and `uio[5]` on an oscilloscope at each setting, separately for
   trials with the data high and low (they differ by about 0.5 % of *d*; `verification/physical/README.md`,
   Section 7).
5. The measurement. With an asynchronous square wave on the data input, sum K over many blocks at each setting
   in the straight part and fit ln K against *d*.
6. The bank. Repeat 2 with the bank selected (input 11 gives K = 0; an early clock 0.2 ns after the clock edge
   gives 65,535 and one 6 ns after it gives 0), then step the early clock and fit. N3 against DUT3 from the same
   chip tests the two measurement paths against each other.

## Still open
- **LVS on ecetesla0.** The delay line's timing capacitor `MCT` is `nfet_05v0` in the netlist since
  17 Nov 2026. That is what Magic extracts with the open_pdks builds e8daeda7 and 5740c4a8, because the
  device lies under the cell's 5 V marker. With the PDK on ecetesla0 on 7 Nov 2026 Magic called it
  `nfet_06v0`, and the netlist said so until now. Both names are the same model card with the same
  parameters, so no simulation changes. If the checks are run on ecetesla0 before its PDK is updated, LVS
  will report that one device. A copy of the netlist with that one name changed is expected to match:
  Netgen 1.5.314 reported "Circuits match uniquely" against an extraction in which `MCT` was renamed to stand
  for that of ecetesla0, for 06823df and for the revised layout
  (`verification/bank/layout/lvs_report_mct_as_nfet_06v0.txt`). The command is in
  `verification/independent/README.md`, Section 2; it has not been run on ecetesla0 itself.
- **Tiny Tapeout.** The precheck on GitHub passed for commit e449093 (`gds` workflow run 45730953549: KLayout
  rule deck 0 violations, antenna 0). The commit was submitted on 25 Nov 2026 as a new revision of project 6616,
  which opened pull request 65 on `TinyTapeout/tinytapeout-gf-26c`. Tiny Tapeout merged it on 26 Nov 2026 at 09:23 UTC: since then the shuttle's record of the project, `projects/tt_um_metastability_characterizer/commit_id.json`, names commit e449093 (before, 22956c2, the layout with the old controller). The layout of 26 Nov takes the same steps after its push: the `gds` workflow must pass on the pushed commit, the commit is then submitted in the Tiny Tapeout app as a new revision of project 6616, and Tiny Tapeout merges it. Until then the chip that would be made is e449093; it differs from the present layout only in the driver of the bank's capture edge.
- **Wiring on the latch nodes.** If tau nearer the schematic's is wanted, `mq` and `mqb` of each NAND
  flip-flop need a direct connection between neighbouring cells instead of a channel track. The router has
  no such case.
- **Wire resistance** is bounded from the extracted resistor networks, not simulated: the netlist that Magic
  writes with `extresist` could not be used for delays (`verification/physical/SIMULATIONS.md`, Section 6).
- **The extraction.** The two versions of Magic differ by 4 to 6 % in tau, and the flat and the hierarchical
  extraction of one version by 3 to 5 % in delay. tau and the floors were not computed on the flat extraction.
- **The supply outside the tile, the substrate and mismatch** are not modelled; `verification/FAILURE_SPACE.md`
  lists these and the other open entries.
- **N2 on the present layout.** The count model of N2 was computed at the typical corner only. The capture edge and
  the latch slow down together: the edge rises in 174, 290 and 544 ps at the fast, the typical and the slow corner,
  where the latch of N2 has 20.3, 29.6 and 48.1 ps. Captures at the slow corner, with falling data, give a step of
  45.1 to 53.9 ps where 55.4 ps is ideal; rising data and the fast corner were not simulated.

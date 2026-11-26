# A second check of the layout (22 and 23 November 2026)

This folder records a check of the layout in this repository that was made independently of the one in
`verification/layout/`: on a separate installation, with the versions of Magic and Netgen that the course server
ecetesla0 has, with the version of Magic of `verification/layout/` as well, and with benches that were written
separately. It covers the layout of commit
06823df (`gds/tt_um_metastability_characterizer.gds`, SHA-1 3ce9c707…): the tile with the controller
`compact_control`.

Every number below comes from the layout tools or from circuit simulation. No chip exists, and nothing here is a
measurement.

**Terms.** DUT1 to DUT4 are the four flip-flops under test: DUT1 is the library flip-flop `dffq_1`; DUT2 is the
flip-flop built of NAND gates, the baseline; DUT3 is the same with the keeper gate of its master latch doubled; DUT4
is the same with the forward gate doubled. `mq` and `mqb` are the two nodes of a master latch, and τ is the time
constant with which the difference between them grows when the latch is released near balance. *d* is the delay of
the early sample, from the clock edge at the flip-flops under test (net `capture_local`) to the clock edge of the
early observer (net `early_clk`); the voltage on `ua[0]` sets it. A trial is an event when the early sample of the
selected flip-flop's output differs from the value that output settles to, and K is the number of events in a block
of 65,535 trials (`docs/info.md`). "The record" is `verification/layout/results_postlayout.md`, the post-layout
tables of the run of 17 November 2026 (Magic 8.3.703, Netgen 1.5.325, ngspice 42).

**Files.** Each table names the files of `data/` that hold its numbers. `data/MANIFEST.md` lists every file with
its origin, and `data/numbers.json` holds the numbers from which the text and the tables were written. The scripts of the check (the
mapping of nets, the cut-out, the benches and the calculation of the window) are kept outside the repository,
because they depend on the workspace in which they ran: the paths of the PDK and of the intermediate files. Each
section states its method so that the numbers can be reproduced with other tools.

## Summary

1. **Rules and connectivity.** Magic reports no design-rule error, with version 8.3.573 and with version 8.3.703.
   Netgen 1.5.314 finds that the layout extracted by Magic 8.3.573 and `layout/chip_lvs.spice` match uniquely
   (152 devices, 160 nets). Section 2 gives a command with which LVS is expected to pass on ecetesla0 as well; it
   was tested here on an extraction renamed to stand for that of ecetesla0, not on ecetesla0 itself.
2. **The record's time constants are confirmed.** With the extraction by Magic 8.3.703 and a different method,
   this check obtains 135.9, 113.8 and 163.0 ps for DUT2, DUT3 and DUT4 at the typical corner, against 136.1, 113.8
   and 163.1 ps in the record; at the record's three other conditions the largest difference is 0.2 ps
   (Section 5).
3. **The extraction depends on the version of Magic.** Magic 8.3.573, the version of ecetesla0, extracts the same
   layout with 475 fF from signal wires to `VGND`, where 8.3.703 extracts 140 fF; the capacitance between
   signal wires agrees within 3.1 % (Section 3). With 8.3.573 the time constants are 142.6, 119.2 and 169.2 ps,
   3.8 to 4.9 % longer, and the delay *d* is 6.5 to 8.3 % longer than the record's. Which
   version is nearer the silicon has not been established.
4. **The ratios do not depend on it.** Over both extractions, both methods, the record and every condition
   examined, DUT3/DUT2 lies between 0.836 and 0.838 and DUT4/DUT2 between 1.182 and 1.199.
5. **Where the increase over the schematic comes from.** For DUT2, the transistors of the nine cells alone give
   86.0 ps; the capacitors that the extraction places inside the standard cells raise this to 110.1 ps; the
   wiring between the cells raises it to 142.6 ps (8.3.573). About 24 ps of the increase therefore lie inside
   the library cells and cannot be removed by shorter wires.
6. **Floors.** In continuous operation the lower limit of *d* for a measurement is 2.38 ns for DUT2 and up to
   2.87 ns for DUT1 (8.3.573, typical corner; Section 7).
7. **Predicted count for DUT2.** Above its floor of 2.379 ns the count first falls slowly; the straight part of
   ln K against *d* begins near 3.4 ns (`ua[0]` near 1.14 V). Its slope is 130 ps over 3.4 to 4.0 ns and
   137 ps over 4.4 to 5.4 ns, 0.91 to 0.96 of the latch's 142.6 ps, and the events are late falls of the
   output. At 3.5 ns the model gives 0.33 events per block for each MHz of data frequency, at 4.0 ns 0.0072
   (Section 8).
8. **Not computed.** On the cut-out, the time constant of DUT4 at the fast condition and of all three NAND
   flip-flops at the slow condition at −40 °C (the flip-flops alone were computed there); everything on a cut-out
   of the 8.3.703 extraction; the clocked characterisation (captures) and the predicted count for DUT1, DUT3 and
   DUT4; the floors at the slow and fast conditions. Section 10 gives the full list.

## 1. Tools

| Tool | Version | Why this version |
|---|---|---|
| Magic | 8.3.573 | the version on ecetesla0 |
| Magic | 8.3.703 | the version of `verification/layout/` |
| Netgen | 1.5.314 | the version on ecetesla0 |
| ngspice | 42 | as in `verification/layout/` |
| GF180MCU technology files | open_pdks 1.0.594, commit e8daeda7, built from source | the build that the Tiny Tapeout precheck installs, as in `verification/layout/` |
| Device models | `sm141064.ngspice` of the same build, with the junction capacitance of every transistor (its drain and source areas and perimeters are in the netlists) | |

Both versions of Magic were built from their release tags and read the same technology file.

## 2. Rules and connectivity

| Check | Result |
|---|---|
| Magic DRC, style `drc(full)`, with 8.3.573 and with 8.3.703 | 0 errors with both |
| Netgen 1.5.314: extraction by Magic 8.3.573 against `layout/chip_lvs.spice` | "Circuits match uniquely", with 152 devices and 160 nets at the top level. The devices are the 148 standard cells and the four transistors of the delay stage, which Netgen compares flattened. The tile has 149 instances and 1,668 transistors |
| Extraction with capacitance to the substrate and between nets | 8,931 capacitors with 8.3.573 and 8,767 with 8.3.703 in the whole extracted netlist; 8,051 and 7,889 of them are wiring between the cells, the other 880 and 878 lie in the definitions of the cells |

Sources: `data/checks/drc_magic_8.3.573.txt`, `data/checks/drc_magic_8.3.703.txt`,
`data/checks/lvs_report_magic8.3.573_netgen1.5.314.txt`, `data/cap_wiring.json`. LVS was run on the extraction by
8.3.573 only; for 8.3.703 see the record's `lvs_report.txt`.

**LVS on ecetesla0.** `README_analog.md` ("Still open") expects that LVS on ecetesla0 reports one device, the
delay line's timing capacitor `MCT`, because the PDK there extracts it as `nfet_06v0` where the netlist now says
`nfet_05v0`. A copy of the reference netlist with that one name changed resolves it:

    mkdir -p build
    sed 's/^\(XMMCT .*\) nfet_05v0 /\1 nfet_06v0 /' layout/chip_lvs.spice > build/chip_lvs_ecetesla0.spice
    netgen -batch lvs "<extracted>.spice tt_um_metastability_characterizer" \
        "build/chip_lvs_ecetesla0.spice tt_um_metastability_characterizer" \
        $PDK_ROOT/gf180mcuD/libs.tech/netgen/gf180mcuD_setup.tcl lvs_report.txt

This was tried here on an extracted netlist in which `MCT` had been renamed in the same way, to stand for what
ecetesla0 extracts. Against the renamed copy Netgen reports "Circuits match uniquely", with the same 152
devices and 160 nets. Against the netlist as it is, the result is "Top level cell failed pin matching". An `equate classes` line
for the two device names in Netgen's setup file was tried in place of the renamed copy and does not work: the
result is again "Top level cell failed pin matching". `build/` is ignored by git, so the tracked netlist stays as it is. The command has not
been run on ecetesla0 itself.

Sources: `data/checks/lvs_ecetesla0_renamed_copy.log`, `data/checks/lvs_ecetesla0_netlist_as_is.log`,
`data/checks/lvs_ecetesla0_equate_classes.log`.

## 3. The extracted capacitance depends on the version of Magic

The two versions extract the same layout differently. The capacitance between signal nets agrees within
3.1 %, and so does the capacitance from signal nets to `VDPWR`; the capacitance from signal nets to `VGND`
does not:

| Capacitors at the top level | 8.3.573: number | sum | 8.3.703: number | sum |
|---|---|---|---|---|
| between two signal nets | 6,858 | 667.5 fF | 6,890 | 646.8 fF |
| from a signal net to `VGND` | 635 | 474.8 fF | 433 | 140.1 fF |
| from a signal net to `VDPWR` | 557 | 82.3 fF | 565 | 83.9 fF |
| between `VDPWR` and `VGND` | 1 | 675.6 fF | 1 | −135.5 fF |
| all | 8,051 | | 7,889 | |
| inside the cell definitions | 880 | | 878 | |

The capacitor between the two supplies has no effect on a simulation with an ideal supply. On the nets that set
the results of this project (wiring capacitance at the top level; the cells' own parasitics are inside the cell
definitions and are not included):

| Net | 8.3.573: total | of it to `VGND` | 8.3.703: total | of it to `VGND` |
|---|---|---|---|---|
| DUT2 latch node `mq` | 3.35 fF | 0.74 fF | 2.58 fF | 0.03 fF |
| DUT2 latch node `mqb` | 3.13 fF | 0.71 fF | 2.45 fF | 0.08 fF |
| DUT3 `mq` | 3.43 fF | 1.04 fF | 2.45 fF | 0.09 fF |
| DUT3 `mqb` | 3.13 fF | 0.68 fF | 2.41 fF | 0.03 fF |
| DUT4 `mq` | 3.49 fF | 0.81 fF | 2.70 fF | 0.06 fF |
| DUT4 `mqb` | 3.70 fF | 1.28 fF | 2.50 fF | 0.11 fF |
| delay stage, timing node `slow` | 1.17 fF | 0.86 fF | 0.41 fF | 0.10 fF |
| delay line `r0` | 2.73 fF | 1.05 fF | 1.97 fF | 0.32 fF |
| delay line `r1` | 2.96 fF | 0.86 fF | 2.17 fF | 0.15 fF |
| `capture_local` (clock of the flip-flops under test) | 32.28 fF | 6.86 fF | 27.52 fF | 2.80 fF |
| `early_clk` | 21.39 fF | 1.99 fF | 19.92 fF | 1.25 fF |
| `selected_q` | 10.64 fF | 3.96 fF | 9.67 fF | 3.12 fF |

Of these totals, the capacitance between the two latch nodes of one flip-flop, which counts twice in the time
constant:

| Between `mq` and `mqb` | 8.3.573 | 8.3.703 |
|---|---|---|
| DUT2 | 0.78 fF | 0.77 fF |
| DUT3 | 0.70 fF | 0.69 fF |
| DUT4 | 1.17 fF | 1.14 fF |

On the six latch nodes 8.3.703 gives 22 to 32 % less wiring capacitance than 8.3.573, and on the
timing node `slow` of the delay stage 65 % less; almost all of the difference is capacitance to `VGND`.

Source of the three tables: `data/cap_wiring.json`, computed from the two extracted netlists.

The difference was looked for on small test layouts, extracted with both versions and the same technology file:

| Test layout | 8.3.573 | 8.3.703 |
|---|---|---|
| Two parallel Metal2 wires, 100 µm long, 0.28 µm wide, 0.28 µm apart: capacitance between them | 8.818 fF | 8.214 fF |
| The same wires: each to the substrate | 3.947 fF | 3.947 fF |
| Five such wires side by side with a Metal3 wire crossing them: between neighbours | 8.818 fF | 8.214 fF |
| The same layout: every other capacitor | identical | identical |
| A Metal3 wire above a Metal1 plate; a Metal2 wire over substrate with a tap, and over an n-well tied to `VDPWR` | identical | identical |

Sources: `data/capcheck/` (the four Magic scripts and the eight extracted netlists).

For the parallel wires 8.3.703 gives what the technology file prescribes, 46.736 / (0.28 + 0.289) aF per µm of
length, 8.214 fF for 100 µm (`defaultsidewall allm2 metal2 46.736 0.289`); 8.3.573 gives 7 % more. None of
these flat test layouts reproduces the much larger difference to `VGND` that the tile shows, so its origin was
not found. A test layout with a hierarchy of cells, the feature that these layouts lack, was started and did not
finish; it is not reported. Which version is nearer the silicon has not been established here. Results are
therefore given for both versions wherever both were computed, and Section 9 carries the difference as an
uncertainty.

## 4. The front-end cut-out

The time constants, delays, floors and captures of Sections 5 to 8 were simulated on a cut-out of the extracted
tile: the 56 cells that `layout/chip_lvs.spice` places outside the controller (the flip-flops under test, the
selector, the delay line, the early observer, the data inverters and the monitor drivers, with their buffers, tie
cells and the antenna diode) and the five controller cells that touch their nets (the capture
flip-flop and its inverter, the two late-sample flip-flops and the gate that compares the samples). Every
extracted capacitor between two kept nets is kept, and every capacitor from a kept net to the rest of the tile is
connected to `VGND`; the cut-out holds 3,322 capacitors. The nets of the extraction were identified with those
of `layout/chip_lvs.spice` by iterative refinement of the two netlists as graphs, the principle of Netgen's
partitioning; 159 nets matched uniquely and none ambiguously. The capture edge is applied as a ramp of 50 ps on
the net `capture`, the output of the capture flip-flop; the buffers that carry it to the flip-flops under test are
the extracted ones. The supply is ideal and the wires have no resistance.

The cut-out is that of the extraction by Magic 8.3.573. With the extraction by 8.3.703 only the time constants
were computed, on each flip-flop alone (Section 5).

## 5. Time constants of the three NAND master latches

**Method on the cut-out (bisection).** The two nodes of the closed master latch, `mq` and `mqb`, start at the
balance voltage of its NAND gates (1.442 V at the typical corner) plus and minus half of a differential offset. The
offset at which the latch is exactly undecided is found by bisection from ±20 mV in 34 steps. The resolution time,
at which `mq` crosses 2.5 V, is then recorded for seven offsets from 1 mV down to 1 µV beyond it, two per decade,
and τ is the least-squares slope of the resolution time against the natural logarithm of the offset. The three
slopes between neighbouring offsets from 30 µV to 1 µV differ from the fitted τ by at most 0.04 ps, and by
0.30 ps for DUT4 at the slow condition. The largest residual of any fit is 1.0 ps; it occurs at the
typical corner at the offsets of 0.1 to 1 mV, where the crossing time is read from waveforms stored every 1 ps.

**Method on a flip-flop alone (growth).** The nine extracted cells of one flip-flop, with the wiring capacitance
that the extraction of the tile places on its two latch nodes (each node's capacitance to all other nets as a
capacitor to ground, and the capacitance between the two nodes) and 1.0 fF to ground on each of its six other
internal nets. The two nodes start at the balance voltage plus and minus 10 µV, and τ is the time in which their
difference grows from 0.632 mV to 20 mV, divided by ln 31.6.

Both differ from `layout/make_tb_tau.py`, which produced the record: there each flip-flop is simulated twice
with every wiring capacitor that touches one of its nets, a current pulse tips one copy 100 times further from
balance than the other, and the two cross 0.75 of the supply a time τ ln 100 apart. The three therefore serve
as checks of one another. Where both methods of
this check were applied to the same extraction, they agree within 0.4 ps (0.12 %).

Typical corner, 3.3 V, 27 °C; time constants in ps:

| Netlist, extraction and method | DUT2, baseline | DUT3, keeper doubled | DUT4, forward gate doubled | DUT3 / DUT2 | DUT4 / DUT2 |
|---|---|---|---|---|---|
| Cut-out of the extracted tile, Magic 8.3.573, bisection of the starting offset (this check) | 142.6 | 119.2 | 169.2 | 0.836 | 1.187 |
| One flip-flop alone with the extracted wiring of its latch nodes, Magic 8.3.573, growth of the difference (this check) | 142.6 | 119.2 | 169.1 | 0.837 | 1.186 |
| The same with the extraction by Magic 8.3.703 (this check) | 135.9 | 113.8 | 163.0 | 0.837 | 1.199 |
| The record: Magic 8.3.703, `layout/make_tb_tau.py` | 136.1 | 113.8 | 163.1 | 0.836 | 1.198 |
| Before layout: the library's transistor netlists of the nine cells, no wiring (this check) | 86.0 | 78.6 | 99.9 | 0.914 | 1.162 |
| Before layout, the record: schematic with 0.25 fF on each latch node and 0.05 fF between them | 88.8 | 80.6 | 102.0 | 0.908 | 1.149 |

Sources: `data/tau_cutout/sep_xu_dut*_typical_3.3_27.0.json`, `data/tau_alone/xcheck_conditions.json`,
`data/tau_alone/xcheck_typical.json` (with the wiring values used), `data/tau_alone/nand_sweep_5v.json` (column
`cdl`), and the record.

Where the increase comes from (one flip-flop alone, growth method, typical corner; ps):

| Netlist of one flip-flop | DUT2 | DUT3 | DUT4 |
|---|---|---|---|
| Transistors of the nine cells only | 86.0 | 78.6 | 99.9 |
| With the capacitors that the extraction places inside the standard cells, 8.3.573 / 8.3.703 | 110.1 / 109.4 | 97.1 / 96.4 | 140.1 / 139.9 |
| With the wiring between the cells as well, 8.3.573 / 8.3.703 | 142.6 / 135.9 | 119.2 / 113.8 | 169.1 / 163.0 |

Sources: `data/tau_alone/nand_sweep_5v.json` (`cdl`, `cells_x`, `cells_y`), `data/tau_alone/xcheck_typical.json`.

For DUT2 the capacitors inside the cells add 24 ps and the wiring adds 32 ps with 8.3.573; with 8.3.703
the two parts are 23 and 27 ps.

The four conditions of the record (ps):

| Condition | Netlist and method | DUT2 | DUT3 | DUT4 | DUT3 / DUT2 | DUT4 / DUT2 |
|---|---|---|---|---|---|---|
| typical, 3.3 V, 27 °C | cut-out, 8.3.573, bisection | 142.6 | 119.2 | 169.2 | 0.836 | 1.187 |
| | flip-flop alone, 8.3.573, growth | 142.6 | 119.2 | 169.1 | 0.837 | 1.186 |
| | flip-flop alone, 8.3.703, growth | 135.9 | 113.8 | 163.0 | 0.837 | 1.199 |
| | the record (8.3.703) | 136.1 | 113.8 | 163.1 | 0.836 | 1.198 |
| slow (ss), 3.0 V, −40 °C | cut-out, 8.3.573, bisection | not computed | not computed | not computed | – | – |
| | flip-flop alone, 8.3.573, growth | 184.3 | 154.3 | 217.8 | 0.837 | 1.182 |
| | flip-flop alone, 8.3.703, growth | 175.8 | 147.2 | 210.0 | 0.838 | 1.195 |
| | the record (8.3.703) | 175.9 | 147.3 | 210.2 | 0.837 | 1.195 |
| slow (ss), 3.0 V, 125 °C | cut-out, 8.3.573, bisection | 271.0 | 226.7 | 320.9 | 0.837 | 1.184 |
| | flip-flop alone, 8.3.573, growth | 270.8 | 226.6 | 320.5 | 0.837 | 1.184 |
| | flip-flop alone, 8.3.703, growth | 258.4 | 216.3 | 309.0 | 0.837 | 1.196 |
| | the record (8.3.703) | 258.3 | 216.3 | 309.0 | 0.837 | 1.196 |
| fast (ff), 3.6 V, −40 °C | cut-out, 8.3.573, bisection | 86.3 | 72.2 | not computed | 0.837 | – |
| | flip-flop alone, 8.3.573, growth | 86.3 | 72.2 | 102.4 | 0.837 | 1.187 |
| | flip-flop alone, 8.3.703, growth | 82.3 | 68.9 | 98.7 | 0.837 | 1.199 |
| | the record (8.3.703) | 82.4 | 68.9 | 98.8 | 0.836 | 1.199 |

Sources: `data/tau_cutout/` (eight files), `data/tau_alone/xcheck_conditions.json`, and the record.

On the cut-out, DUT4 at the fast condition and all three flip-flops at the slow condition at −40 °C were not
computed; the flip-flops alone give 102.4 ps for the first and 184.3, 154.3 and 217.8 ps for the others.
Between the slow condition at 125 °C and the fast condition the time constants differ by a factor of 3.13
to 3.14.

## 6. Delay of the early sample

*d* is the delay from `capture_local` to `early_clk`, both at half the supply. *M* is the delay between the two
monitor pins `uio[4]` and `uio[5]`, each loaded with 0.2 pF; it is what an oscilloscope can measure on a chip.
Cut-out of the extracted tile, Magic 8.3.573, DUT2 selected; delays in ns. The record's *d* is that of its
layout column (8.3.703, typical corner).

| `ua[0]` | typical, 3.3 V, 27 °C: *d* | *M* | *d* − *M* | the record's *d* (8.3.703) | *d* / record | slow (ss), 3.0 V, 125 °C: *d* | *M* | fast (ff), 3.6 V, −40 °C: *d* | *M* |
|---|---|---|---|---|---|---|---|---|---|
| 0.90 V | – | – | – | – | – | 11.351 | 11.193 | 3.318 | 3.282 |
| 0.95 V | – | – | – | – | – | 9.503 | 9.341 | 2.893 | 2.856 |
| 1.00 V | 4.538 | 4.464 | 0.074 | 4.19 | 1.083 | 8.200 | 8.032 | 2.573 | 2.534 |
| 1.05 V | – | – | – | – | – | 7.244 | 7.067 | 2.325 | 2.282 |
| 1.10 V | 3.633 | 3.550 | 0.083 | 3.36 | 1.081 | 6.517 | 6.332 | 2.126 | 2.081 |
| 1.15 V | – | – | – | – | – | 5.950 | 5.755 | 1.964 | 1.917 |
| 1.20 V | 3.067 | 2.976 | 0.092 | 2.84 | 1.080 | 5.496 | 5.293 | 1.830 | 1.780 |
| 1.30 V | 2.686 | 2.586 | 0.100 | 2.49 | 1.079 | 4.820 | 4.603 | 1.623 | 1.568 |
| 1.40 V | 2.414 | 2.308 | 0.106 | 2.24 | 1.078 | 4.344 | 4.116 | 1.470 | 1.411 |
| 1.50 V | 2.212 | 2.101 | 0.111 | 2.06 | 1.074 | 3.994 | 3.758 | 1.353 | 1.292 |
| 1.60 V | – | – | – | – | – | 3.729 | 3.486 | 1.263 | 1.199 |
| 1.80 V | 1.841 | 1.721 | 0.120 | 1.72 | 1.070 | 3.364 | 3.110 | 1.131 | 1.065 |
| 2.00 V | – | – | – | – | – | 3.134 | 2.875 | 1.043 | 0.974 |
| 2.40 V | 1.534 | 1.411 | 0.123 | 1.44 | 1.065 | 2.884 | 2.625 | 0.936 | 0.868 |
| 3.00 V | 1.427 | 1.306 | 0.121 | 1.34 | 1.065 | 2.726 | 2.470 | 0.860 | 0.793 |
| 3.30 V | 1.400 | 1.280 | 0.120 | 1.31 | 1.069 | – | – | – | – |
| 3.60 V | – | – | – | – | – | – | – | 0.827 | 0.761 |

Sources: `data/delay/dly_post_typical_3.3_27.0.json`, `data/delay/dly_post_ss_3.0_125.0.json`,
`data/delay/dly_post_ff_3.6_-40.0.json`, and the record. The delay curve was not computed on a cut-out of the
8.3.703 extraction.

With 8.3.573 *d* is 6.5 to 8.3 % longer than in the record, which agrees in direction with the smaller
capacitance that 8.3.703 extracts on the timing node (Section 3). At the typical corner *d* changes by 9.1, 5.7, 3.8, 2.7, 2.0 ps
per mV of `ua[0]` in the five steps of 0.1 V from 1.0 to 1.5 V. The buffers take 0.674 ns from `capture` to
`capture_local` at the typical corner, 1.224 ns at the slow and 0.422 ns at the fast condition.

*d* − *M* is not constant: it grows from 0.074 ns at 1.0 V to 0.123 ns at 2.4 V. Between 1.0 and 1.1 V the pin
delay *M* changes 0.9 % more than *d*, between 1.0 and 1.2 V 1.2 % more and between 1.0 and 1.5 V 1.6 %
more, so a time constant fitted against the pin delay comes out long by that amount. A ratio of two time
constants fitted over the same settings is not affected.

## 7. Floors in continuous operation

The floor of a flip-flop is the delay *d* below which an ordinary change of its output is not yet caught by the
early sample, so that every trial in which the output changes is counted as an event. Method: three trials, 10 ns
apart in the bench (200 ns on the chip), with the data changed about 2 ns before each capture, so that every capture changes the output and the
early observer still holds the previous value, as it does when trials follow one another on a chip. The third
trial is examined. The control voltage is bisected in 15 steps until the early sample catches the new value; the
floor is the delay *d* of that trial at that voltage. The bisection brackets each floor within 0.3 ps.

Cut-out of the extracted tile, Magic 8.3.573; typical corner, 3.3 V, 25 °C (the other sections use 27 °C):

| Flip-flop | Rising data: floor *d* | at `ua[0]` | Falling data: floor *d* | at `ua[0]` | Lower limit of *d* for a measurement (the larger floor) | The record: new value at the early observer, rising / falling (8.3.703) |
|---|---|---|---|---|---|---|
| DUT1, library `dffq_1` | 2.455 ns | 1.383 V | 2.873 ns | 1.243 V | 2.87 ns | 2.26 / 2.37 ns |
| DUT2, NAND, baseline | 1.787 ns | 1.865 V | 2.379 ns | 1.410 V | 2.38 ns | 1.69 / 1.94 ns |
| DUT3, NAND, keeper doubled | 1.930 ns | 1.706 V | 2.586 ns | 1.329 V | 2.59 ns | 1.82 / 2.13 ns |
| DUT4, NAND, forward gate doubled | 1.874 ns | 1.763 V | 2.526 ns | 1.351 V | 2.53 ns | 1.77 / 2.07 ns |

Sources: `data/floor/` (eight files), and the record.

The last column is a different quantity and a different extraction: the time at which the new value reaches the
early observer after a single capture. The floor exceeds it by the time before its clock at which the observer
needs its data, which is longer for falling data when the observer holds a one, and by the effect of the
extraction. The floors at the slow and fast conditions were not computed.

## 8. Predicted count against delay, DUT2

**Method.** For one direction of the data, the time of the data edge was bisected until the capture stood on the
boundary between its two outcomes (the critical time, to 1e-19 s). The data edge was then placed at 19 distances
δ from 1.5 ns down to 1.5e-18 s on either side of it, two per decade, and the waveform of the selected output was
kept. For a delay *d* the early observer is taken to sample that output at `t_ord + (d − floor)`, where `t_ord`
is the time at which an ordinary transition of the same direction crosses half the supply; by the definition of
the floor such a transition is then just caught at *d* = floor. A capture is an event when the selected output at
that instant is on the other side of half the supply than its final value. The window *w(d)* is the width of the
range of data times that are counted, summed over both directions of the data. With a square wave of frequency
*f* on `ui[6]` that is unrelated to the clock, the fraction of trials that are events is *p = f · w*, and
K = 65,535 · *p* per block of 13.1 ms. Between two stored captures the window is interpolated on a
logarithmic scale.

**The captures.** The critical data times of DUT2 are 3.853892 ns for rising and 3.747956 ns for falling data, on the
time axis of the bench, in which the capture edge starts at 4 ns. Where the new value is taken, the selected
output makes its transition late, and the later, the nearer the data edge lies to the critical time. Where the
old value is kept, the selected output does not cross half the supply after the capture edge in any stored
capture, for either direction of the data, so those captures are not counted. The slope of the time of the last
crossing against ln δ is the time constant that the instrument sees; between captures a decade of δ apart:

| Distance δ of the data edge before the critical time | Falling data: slope | Rising data: slope |
|---|---|---|
| 1.5 × 10^−11 s to 1.5 × 10^−12 s | 128.6 ps | 110.8 ps |
| 1.5 × 10^−12 s to 1.5 × 10^−13 s | 131.0 ps | 131.2 ps |
| 1.5 × 10^−13 s to 1.5 × 10^−14 s | 133.3 ps | 140.9 ps |
| 1.5 × 10^−14 s to 1.5 × 10^−15 s | 134.5 ps | 141.6 ps |
| 1.5 × 10^−15 s to 1.5 × 10^−16 s | 136.9 ps | 144.2 ps |
| 1.5 × 10^−16 s to 1.5 × 10^−17 s | 136.6 ps | 142.3 ps |
| 1.5 × 10^−17 s to 1.5 × 10^−18 s | 138.3 ps | 142.2 ps |

Source: `data/window/tlast_dut2.json`, computed from the stored waveforms;
`data/window/tchar_post_typical_3.3_27.0_d2rise.json` and `…_d2fall.json` hold the critical times.

For rising data the slope is 141 to 144 ps for δ below 1.5 × 10^−13 s: the time constant of the latch, 142.6 ps,
within the scatter of the crossing times. For falling data it rises from 129 to 138 ps over the table and
has not reached the latch's time constant at the closest capture. A straight line through the nine captures from
1.5 × 10^−17 to 1.5 × 10^−13 s gives 142.5 ps for rising data (largest residual 5.4 ps) and 135.4 ps for
falling data (largest residual 4.0 ps).

**The window.** Typical corner, cut-out of the extraction by Magic 8.3.573:

| *d* | `ua[0]` for this *d* (typical corner) | Window *w* | Events per block for each MHz of data frequency | Blocks, and time, for 100 events at 1 MHz | Local slope of ln *w* |
|---|---|---|---|---|---|
| 2.5 ns | 1.37 V | 319.4 ps | 20.9 | 5; 63 ms | 287 ps |
| 2.6 ns | 1.33 V | 225.6 ps | 14.8 | 7; 89 ms | 288 ps |
| 2.8 ns | 1.27 V | 122.7 ps | 8.04 | 12; 163 ms | 411 ps |
| 3.0 ns | 1.22 V | 75.4 ps | 4.94 | 20; 265 ms | 411 ps |
| 3.2 ns | 1.17 V | 44.5 ps | 2.92 | 34; 449 ms | 199 ps |
| 3.4 ns | 1.14 V | 11.0 ps | 0.72 | 139; 2 s | 130 ps |
| 3.5 ns | 1.12 V | 5.1 ps | 0.33 | 301; 4 s | 129 ps |
| 3.6 ns | 1.10 V | 2.3 ps | 0.15 | 656; 9 s | 128 ps |
| 3.8 ns | 1.08 V | 497.8 fs | 0.0326 | 3,066; 40 s | 131 ps |
| 4.0 ns | 1.05 V | 109.2 fs | 0.0072 | 13,977; 3 min | 133 ps |
| 4.2 ns | 1.03 V | 24.3 fs | 0.0016 | 62,742; 14 min | 134 ps |
| 4.4 ns | 1.01 V | 5.5 fs | 3.6 × 10^−4 | 279,862; 61 min | 134 ps |
| 4.5 ns | 1.00 V | 2.6 fs | 1.7 × 10^−4 | 586,855; 2 h | 135 ps |

Sources: `data/window/window_dut2.json` (window on a grid of 10 ps; the table interpolates it),
`data/delay/dly_post_typical_3.3_27.0.json` (`ua[0]` by interpolation of 1/*d* between the simulated voltages,
tested on the slow curve to 1 mV).

Above the falling-data floor of 2.379 ns the window first falls slowly: a straight line through ln *w* from 2.4
to 3.2 ns has a slope of 358 ps. These are captures of falling data that arrived 0.05 to 0.5 ns before the
critical time and whose output is merely slow. The straight part begins near 3.4 ns, about 1.0 ns above the
floor. Straight lines through ln *w* give 130 ps over 3.4 to 4.0 ns, 132 ps over 3.4 to 4.4 ns, 133 ps
over 3.6 to 4.6 ns, 135 ps over 4.0 to 5.0 ns and 137 ps over 4.4 to 5.4 ns: 0.91 to 0.96 of the
latch's 142.6 ps, rising with *d* as the table of slopes above leads one to expect. Above 3.4 ns rising data
contribute less than 10^−3 of the window, so the events are late falls of the output. Delays above 4.54 ns need
`ua[0]` below 1.0 V, where the delay curve was not simulated at the typical corner.

**Limits of this model.** The early observer is represented by a sampling instant and a threshold of half the
supply; its own aperture and its own metastability are not modelled. The floors were computed at 25 °C and the
captures at 27 °C. Only DUT2 was characterised, on one extraction and at one corner: the runs for DUT3 were
started and cancelled, and those for DUT1 and DUT4 were not started.

**For orientation only.** A clocked characterisation of each NAND flip-flop alone was made in a separate study
on 22 November: the nine extracted cells (8.3.573) with the wiring of DUT2 on the latch nodes of all three
(2.45 fF per node, 0.78 fF between them), the output of the flip-flop observed without the selector, and a
straight line through seven captures from 10^−12 to 10^−15 s. For falling data it gave output slopes of 133.4,
110.6 and 153.3 ps for DUT2, DUT3 and DUT4, ratios 0.829 and 1.149, against latch time constants of 142.6,
119.5 and 164.0 ps in the same netlists, ratios 0.838 and 1.150. Over that range of δ the cut-out gives 131
to 135 ps for DUT2 (table of slopes above), so the two agree for the one flip-flop that both cover. The values
for DUT3 and DUT4 are not results on the extracted tile.
Sources: `data/tau_alone/clocked_dut2_n5_f2k1_ch_typical.json`, `…dut3_n5_f2k2_ch…`, `…dut4_n5_f4k1_ch…`.

## 9. Predictions registered before silicon

The statements below are fixed here before a chip exists, so that a measurement can be held against them. Each
rests on the section named.

1. **Order.** At every condition examined and with both extractions, DUT3 has the shortest and DUT4 the longest
   time constant of the three NAND flip-flops (Section 5).
2. **Ratios of the latch time constants.** DUT3/DUT2 = 0.836 to 0.838; DUT4/DUT2 = 1.182 to 1.199
   (Section 5). The ratio of the counted slopes was not computed on the extracted tile; the flip-flops alone
   give 0.829 and 1.149 for falling data (Section 8).
3. **Latch time constants at the typical corner.** DUT2 135.9 to 142.6 ps, DUT3 113.8 to 119.2 ps, DUT4 163.0 to
   169.2 ps; the lower value of each pair belongs to the extraction by Magic 8.3.703, the higher to 8.3.573. At
   the slow condition at 125 °C (8.3.573): 271.0, 226.7 and 320.9 ps; at the fast condition: 86.3, 72.2 and
   102.4 ps, the last from the flip-flop alone (Section 5).
4. **What the count shows.** The slope of ln K against *d* is that of the selected output. For DUT2 with the
   8.3.573 extraction it is 130 ps over 3.4 to 4.0 ns and 137 ps over 4.4 to 5.4 ns, 0.91 to 0.96 of
   the latch's time constant, and the events are late falls of the output (Section 8).
5. **Where the straight part begins.** For DUT2, about 1.0 ns above the falling-data floor: near 3.4 ns with the
   8.3.573 extraction, `ua[0]` near 1.14 V at the typical corner. Between the floor and that delay a fit returns
   slopes of several hundred picoseconds (Section 8).
6. **Toggle test.** With the data changed once per trial far from the capture edge, K falls from 65,535 to about
   half where *d* passes the rising-data floor and to 0 where it passes the falling-data floor. With the 8.3.573
   extraction at the typical corner these are at `ua[0]` = DUT1: 1.38 V and 1.24 V; DUT2: 1.87 V and 1.41 V; DUT3: 1.71 V and 1.33 V; DUT4: 1.76 V and 1.35 V (Section 7).
7. **Delay.** *d* against `ua[0]` as in Section 6 with the 8.3.573 extraction; 6.5 to 8.3 % shorter if the
   silicon follows the 8.3.703 extraction of the record.

A ratio of the slopes of DUT3 and DUT2 of one or more, or a slope of DUT4 below that of DUT2, measured over the
straight part of the count and over the same range of *d* for both, outside the uncertainty of the measurement,
contradicts statements 1 and 2.

Not included in any of these numbers: mismatch between transistors, the resistance of the wires, the supply
network of the chip, thermal noise, and the accuracy of the public device models for 5 V transistors used at
3.3 V.

## 10. What this check does not contain

- On the cut-out of the 8.3.573 extraction: the time constant of DUT4 at the fast condition (3.6 V, −40 °C) and of
  all three flip-flops at the slow condition at −40 °C. The flip-flops alone were computed at these conditions
  (Section 5).
- A cut-out of the 8.3.703 extraction: time constants, delay curve, floors and captures were not computed on it.
  The time constants with that extraction are those of the flip-flops alone.
- The clocked characterisation and the predicted count for DUT1, DUT3 and DUT4. The runs for DUT3 were started
  and cancelled before they finished; their partial files were not used.
- The floors at the slow and fast conditions, and the clocked characterisation of the cut-out before layout.
- LVS on the extraction by Magic 8.3.703, and any run on ecetesla0 itself.
- The origin of the difference between the two versions of Magic in the capacitance to `VGND`; the test layout
  with a hierarchy of cells did not finish.
- The KLayout rule decks, the antenna check and the Tiny Tapeout precheck: see `verification/layout/` (run of
  17 November 2026) and the `gds` workflow on GitHub, whose result on this layout was not verified here.
- The controller at transistor level and the whole-tile benches: see the record.
- Wire resistance, the supply network, thermal noise and mismatch.

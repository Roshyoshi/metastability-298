# Files of the independent check

Each file is a copy, unchanged, of a result file of the workspace in which the check ran, or was computed from such files
by the script that wrote `README.md`. Paths in the second column are those of that workspace.

| File | Origin | Content |
|---|---|---|
| `cap_wiring.json` (5,185 bytes) | `computed by build_final.py from layout/results_mine and results_m703 (extracted netlists with capacitance, net maps)` | wiring capacitance at the top level of the two extractions, per net and by class (fF) |
| `capcheck/multi.tcl` (558 bytes) | `/home/claude/capcheck/multi.tcl` | Magic script of a test layout |
| `capcheck/multi_8.3.573.spice` (368 bytes) | `/home/claude/capcheck/opt/multi.spice` | its extraction with Magic 8.3.573 |
| `capcheck/multi_8.3.703.spice` (368 bytes) | `/home/claude/capcheck/opt703/multi.spice` | its extraction with Magic 8.3.703 |
| `capcheck/shield.tcl` (638 bytes) | `/home/claude/capcheck/shield.tcl` | Magic script of a test layout |
| `capcheck/shield_8.3.573.spice` (171 bytes) | `/home/claude/capcheck/opt/shield.spice` | its extraction with Magic 8.3.573 |
| `capcheck/shield_8.3.703.spice` (171 bytes) | `/home/claude/capcheck/opt703/shield.spice` | its extraction with Magic 8.3.703 |
| `capcheck/tap.tcl` (980 bytes) | `/home/claude/capcheck/tap.tcl` | Magic script of a test layout |
| `capcheck/tap_8.3.573.spice` (173 bytes) | `/home/claude/capcheck/opt/tap.spice` | its extraction with Magic 8.3.573 |
| `capcheck/tap_8.3.703.spice` (173 bytes) | `/home/claude/capcheck/opt703/tap.spice` | its extraction with Magic 8.3.703 |
| `capcheck/twowire.tcl` (584 bytes) | `/home/claude/capcheck/twowire.tcl` | Magic script of a test layout |
| `capcheck/twowire_8.3.573.spice` (172 bytes) | `/home/claude/capcheck/opt/twowire.spice` | its extraction with Magic 8.3.573 |
| `capcheck/twowire_8.3.703.spice` (172 bytes) | `/home/claude/capcheck/opt703/twowire.spice` | its extraction with Magic 8.3.703 |
| `checks/drc_magic_8.3.573.txt` (9 bytes) | `/home/claude/r4/layout/results_mine/drc_magic.txt` | Magic 8.3.573: count of DRC errors, style drc(full) |
| `checks/drc_magic_8.3.703.txt` (9 bytes) | `/home/claude/r4/layout/results_m703/drc_magic.txt` | Magic 8.3.703: count of DRC errors, style drc(full) |
| `checks/lvs_ecetesla0_equate_classes.log` (22,383 bytes) | `/home/claude/r4/lvs_equate/log_equate.txt` | Netgen log: the same extraction against the netlist as it is, with an equate classes line in the setup file |
| `checks/lvs_ecetesla0_netlist_as_is.log` (19,502 bytes) | `/home/claude/r4/lvs_equate/log_plain.txt` | Netgen log: extraction with MCT named nfet_06v0 against the netlist as it is |
| `checks/lvs_ecetesla0_renamed_copy.log` (20,204 bytes) | `/home/claude/r4/lvs_equate/log_sed.txt` | Netgen log: the same extraction against the copy of the netlist with MCT renamed |
| `checks/lvs_magic8.3.573_netgen1.5.314.log` (18,851 bytes) | `/home/claude/r4/layout/results_mine/lvs.log` | Netgen log of the same run |
| `checks/lvs_report_magic8.3.573_netgen1.5.314.txt` (43,423 bytes) | `/home/claude/r4/layout/results_mine/lvs_report.txt` | Netgen report: extraction by Magic 8.3.573 against layout/chip_lvs.spice |
| `delay/dly_post_ff_3.6_-40.0.json` (1,007 bytes) | `/home/claude/r4/pexsim/dly/dly_post_ff_3.6_-40.0.json` | cut-out of the extracted tile (Magic 8.3.573): d, monitor delay and capture to capture_local against ua[0] (ps) |
| `delay/dly_post_ss_3.0_125.0.json` (956 bytes) | `/home/claude/r4/pexsim/dly/dly_post_ss_3.0_125.0.json` | cut-out of the extracted tile (Magic 8.3.573): d, monitor delay and capture to capture_local against ua[0] (ps) |
| `delay/dly_post_typical_3.3_27.0.json` (698 bytes) | `/home/claude/r4/pexsim/dly/dly_post_typical_3.3_27.0.json` | cut-out of the extracted tile (Magic 8.3.573): d, monitor delay and capture to capture_local against ua[0] (ps) |
| `floor/floor_post_typical_3.3_25.0_d1fall.json` (1,093 bytes) | `/home/claude/r4/pexsim/floor/floor_post_typical_3.3_25.0_d1fall.json` | cut-out of the extracted tile (Magic 8.3.573): floor in continuous operation, bracket of the bisection |
| `floor/floor_post_typical_3.3_25.0_d1rise.json` (1,056 bytes) | `/home/claude/r4/pexsim/floor/floor_post_typical_3.3_25.0_d1rise.json` | cut-out of the extracted tile (Magic 8.3.573): floor in continuous operation, bracket of the bisection |
| `floor/floor_post_typical_3.3_25.0_d2fall.json` (1,062 bytes) | `/home/claude/r4/pexsim/floor/floor_post_typical_3.3_25.0_d2fall.json` | cut-out of the extracted tile (Magic 8.3.573): floor in continuous operation, bracket of the bisection |
| `floor/floor_post_typical_3.3_25.0_d2rise.json` (1,067 bytes) | `/home/claude/r4/pexsim/floor/floor_post_typical_3.3_25.0_d2rise.json` | cut-out of the extracted tile (Magic 8.3.573): floor in continuous operation, bracket of the bisection |
| `floor/floor_post_typical_3.3_25.0_d3fall.json` (1,076 bytes) | `/home/claude/r4/pexsim/floor/floor_post_typical_3.3_25.0_d3fall.json` | cut-out of the extracted tile (Magic 8.3.573): floor in continuous operation, bracket of the bisection |
| `floor/floor_post_typical_3.3_25.0_d3rise.json` (1,072 bytes) | `/home/claude/r4/pexsim/floor/floor_post_typical_3.3_25.0_d3rise.json` | cut-out of the extracted tile (Magic 8.3.573): floor in continuous operation, bracket of the bisection |
| `floor/floor_post_typical_3.3_25.0_d4fall.json` (1,063 bytes) | `/home/claude/r4/pexsim/floor/floor_post_typical_3.3_25.0_d4fall.json` | cut-out of the extracted tile (Magic 8.3.573): floor in continuous operation, bracket of the bisection |
| `floor/floor_post_typical_3.3_25.0_d4rise.json` (1,058 bytes) | `/home/claude/r4/pexsim/floor/floor_post_typical_3.3_25.0_d4rise.json` | cut-out of the extracted tile (Magic 8.3.573): floor in continuous operation, bracket of the bisection |
| `numbers.json` (18,341 bytes) | `computed by build_final.py from the files of this folder` | every number that appears in the text of README.md |
| `tau_alone/clocked_dut2_n5_f2k1_ch_typical.json` (4,310 bytes) | `/home/claude/r5/w/clk/dut2_n5_f2k1_ch_typical.json` | one flip-flop alone with the wiring of DUT2 (2.45 fF per latch node, 0.78 fF between): clocked characterisation |
| `tau_alone/clocked_dut3_n5_f2k2_ch_typical.json` (4,143 bytes) | `/home/claude/r5/w/clk/dut3_n5_f2k2_ch_typical.json` | one flip-flop alone with the wiring of DUT2 (2.45 fF per latch node, 0.78 fF between): clocked characterisation |
| `tau_alone/clocked_dut4_n5_f4k1_ch_typical.json` (4,251 bytes) | `/home/claude/r5/w/clk/dut4_n5_f4k1_ch_typical.json` | one flip-flop alone with the wiring of DUT2 (2.45 fF per latch node, 0.78 fF between): clocked characterisation |
| `tau_alone/nand_sweep_5v.json` (1,791 bytes) | `/home/claude/r5/w/nand/nand.json (rows of the 5 V library)` | NAND flip-flop alone for seven pairs of drive strengths: transistors only (cdl), extracted cells (cells_x: 8.3.573, cells_y: 8.3.703), with wiring assumptions |
| `tau_alone/xcheck_conditions.json` (6,387 bytes) | `/home/claude/r4/final_ind/xcheck_corners.json` | one flip-flop alone with its extracted latch-node wiring, both extractions, four conditions: tau by the growth method |
| `tau_alone/xcheck_typical.json` (937 bytes) | `/home/claude/r5/w/xcheck/xcheck.json` | the same at the typical corner, with the wiring values used (fF) and tau of the extracted cells without wiring |
| `tau_cutout/sep_xu_dut2_ff_3.6_-40.0.json` (687 bytes) | `/home/claude/r4/pexsim/tau/sep_ff/sep_xu_dut2_ff_3.6_-40.0.json` | cut-out of the extracted tile (Magic 8.3.573): tau by bisection of the starting offset |
| `tau_cutout/sep_xu_dut2_ss_3.0_125.0.json` (690 bytes) | `/home/claude/r4/pexsim/tau/sep_ss/sep_xu_dut2_ss_3.0_125.0.json` | cut-out of the extracted tile (Magic 8.3.573): tau by bisection of the starting offset |
| `tau_cutout/sep_xu_dut2_typical_3.3_27.0.json` (693 bytes) | `/home/claude/r4/pexsim/tau/sep/sep_xu_dut2_typical_3.3_27.0.json` | cut-out of the extracted tile (Magic 8.3.573): tau by bisection of the starting offset |
| `tau_cutout/sep_xu_dut3_ff_3.6_-40.0.json` (694 bytes) | `/home/claude/r4/pexsim/tau/sep_ff/sep_xu_dut3_ff_3.6_-40.0.json` | cut-out of the extracted tile (Magic 8.3.573): tau by bisection of the starting offset |
| `tau_cutout/sep_xu_dut3_ss_3.0_125.0.json` (690 bytes) | `/home/claude/r4/pexsim/tau/sep_ss/sep_xu_dut3_ss_3.0_125.0.json` | cut-out of the extracted tile (Magic 8.3.573): tau by bisection of the starting offset |
| `tau_cutout/sep_xu_dut3_typical_3.3_27.0.json` (692 bytes) | `/home/claude/r4/pexsim/tau/sep/sep_xu_dut3_typical_3.3_27.0.json` | cut-out of the extracted tile (Magic 8.3.573): tau by bisection of the starting offset |
| `tau_cutout/sep_xu_dut4_ss_3.0_125.0.json` (686 bytes) | `/home/claude/r4/pexsim/tau/sep_ss/sep_xu_dut4_ss_3.0_125.0.json` | cut-out of the extracted tile (Magic 8.3.573): tau by bisection of the starting offset |
| `tau_cutout/sep_xu_dut4_typical_3.3_27.0.json` (689 bytes) | `/home/claude/r4/pexsim/tau/sep/sep_xu_dut4_typical_3.3_27.0.json` | cut-out of the extracted tile (Magic 8.3.573): tau by bisection of the starting offset |
| `window/tchar_post_typical_3.3_27.0_d2fall.json` (8,320 bytes) | `/home/claude/r4/pexsim/tchar/post_typ_d2fall/tchar_post_typical_3.3_27.0_d2fall.json` | DUT2 in the cut-out (Magic 8.3.573): critical data time and the stored captures on either side of it |
| `window/tchar_post_typical_3.3_27.0_d2rise.json` (8,020 bytes) | `/home/claude/r4/pexsim/tchar/post_typ_d2rise/tchar_post_typical_3.3_27.0_d2rise.json` | DUT2 in the cut-out (Magic 8.3.573): critical data time and the stored captures on either side of it |
| `window/tlast_dut2.json` (8,699 bytes) | `computed by build_final.py from pexsim/tchar/post_typ_d2rise and post_typ_d2fall (stored waveforms)` | DUT2: last crossing of half the supply at the selected output against the distance of the data edge from the critical time; slopes per decade |
| `window/window_dut2.json` (49,232 bytes) | `/home/claude/r4/final_ind/win/window_dut2_rerun.json` | DUT2: predicted window and event probability against d (window2.py), data frequency 1 MHz |

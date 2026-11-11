# Metastability characterizer: schematics, layout and checks (GF180, analog 1x2 tile)

This folder adds the transistor-level design, the tile layout and the sign-off results. Everything in
`xschem/` and the two netlists in `layout/` are generated from one master netlist: the controller
(`src/gf180/compact_control.v`, 93 cells), plus the four flip-flops under test, the selector, the delay
line and the pin drivers.

**The controller was replaced on 11 November 2026.** The schematics and netlists now hold
`compact_control`. The layout (`layout/*.gds`, `*.lef`) and every log under `verification/` were made
with the earlier `meta_controller` and have not been redone: see "Still open".

| Folder | What it holds |
|---|---|
| `xschem/` | Xschem hierarchy: `chip.sch` → `blocks/` → `cells_tx/` (every standard cell drawn with its transistors). `blocks/controller.sch` holds the controller as eight blocks, in the order of the design note in `compact_control.v`: `trial_clock`, `start`, `readings`, `count_pulse`, `trial_counter`, `event_counter`, `status`, `readout`. `focus/` holds the 15 presentation sheets (G01–G04 gate level, F01–F11 transistor level); `flat/` holds each block opened to transistors. `benches/` holds the simulation benches. |
| `docs/schematics/` | SVG exports of the 15 presentation sheets (from Xschem). |
| `layout/` | `tt_um_metastability_characterizer.gds / .lef / .v` (**old controller**), the LVS reference netlist and the pre-layout simulation netlist (`chip_lvs.spice`, `chip_sim.spice`, both with the new controller), and the scripts that run the checks (`run_layout.sh`, `magic_checks.tcl`, `make_tb_chip.py`). |
| `verification/layout/` | Sign-off logs from ecetesla0, Nov 7 2026, **for the old controller's layout**: KLayout GF180 DRC (clean, 0 items), KLayout antenna (0 items), Magic DRC (0), Netgen LVS ("Circuits match uniquely"), pre/post-layout whole-tile simulation. |
| `verification/sims/` | The 8 bench netlists, their ngspice logs, and `results.txt` (e.g. tau 88.9 ps baseline, 80.5 ps keeper x2, 102.3 ps forward x2), with `expected.json`. The front-end results stand. `tb_controller` there is the old controller; `tb_frontend` and `tb_selector` named the selection wires `cfg_0`, `cfg_1`, which are now the pins `ui_in_3`, `uio_in_6`. |
| `netlist/` | `controller_synth.v`: the controller as a flat cell list, written from the Verilog by `tools/controller_netlist.py`. `chip.cdl`: the master netlist of the whole tile, written by `tools/build_master.py`. |
| `tools/` | The Python generators that produced the netlist, schematics, layout and checks. The schematic and netlist generators run from this repository; see "Regenerating" below. The layout generators still point at the original build folder. |

## Using the schematics
On ecetesla0: `cd xschem && bash setup.sh` once (it writes this folder's path into the `.sch`/`.sym` files),
then `bash view.sh F04` opens a sheet full screen with its net colours, and `bash export_svg.sh` writes SVGs.

On Windows, or anywhere without bash: `python xschem/setup.py <pdk_dir>` does the same, and also points the
sheets at your copy of the PDK (`<pdk_dir>` is the folder that holds `libs.tech/`). The sheets need the
PDK's Xschem symbols (`libs.tech/xschem/symbols/nfet_06v0.sym`, `pfet_06v0.sym`) and, for simulation, its
ngspice models (`libs.tech/ngspice/`).

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
capacitance; upstream GF180 model files, not the open_pdks build, so repeat it with your PDK):

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

## Regenerating
    git clone --depth 1 https://github.com/google/globalfoundries-pdk-libs-gf180mcu_fd_sc_mcu7t5v0 <lib>
    python3 tools/pdk_cells.py <lib>          # pdk_cells/: the library's cell netlists (not committed)
    python3 tools/controller_netlist.py       # netlist/controller_synth.v from the Verilog (needs yosys)
    python3 tools/build_master.py             # netlist/chip.cdl
    python3 tools/xschem_gen.py <out>         # cells_tx/, blocks/, chip.sch
With these inputs the generator reproduces every sheet that does not involve the controller byte for byte.

## Still open
- **Layout for the new controller.** `layout/*.gds` and `*.lef` still contain `meta_controller`. LVS against
  the new `chip_lvs.spice` will fail until the tile is laid out again, and the DRC, antenna, LVS and
  post-layout logs in `verification/layout/` describe the old layout.
- **Controller timing in SPICE.** The design note in `compact_control.v` lists what logic simulation cannot
  show: the last count settling through 17 flip-flops, `b` reaching `tick_nand` before `allow_count`,
  `run` resetting 35 flip-flops, and quiet before capture. Only the first eight trials have a bench: the
  table above is from typical transistors without wiring; the slow corner at 3.0 V (cold and hot), the
  fast corner at 3.6 V and the extracted layout are not done. `run` is the slowest wire and the first candidate for a buffer.
- **Pictures.** `docs/schematics/F10`, `F11` and `G04` had their text updated by hand to match the
  regenerated sheets; re-export them with `export_svg.sh` when convenient.
- PEX with wiring capacitance: the extraction script is fixed; the rerun is pending.
- `info.yaml` / `docs/info.md`: tile size must be 1x2 (analog), `top_module: tt_um_metastability_characterizer`,
  analog pin ua[0]. When this is merged, `layout/*.gds` and `*.lef` move to the template's `gds/` and `lef/` folders.

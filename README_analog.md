# Metastability characterizer: schematics, layout and checks (GF180, analog 1x2 tile)

This folder adds the transistor-level design, the tile layout and the sign-off results. It does not change
the controller RTL. Everything here was generated from one master netlist (the controller synthesized from
`meta_controller.v`, plus the four flip-flops under test, the selector, the delay line and the pin drivers).

| Folder | What it holds |
|---|---|
| `xschem/` | Xschem hierarchy: `chip.sch` → `blocks/` → `cells_tx/` (every standard cell drawn with its transistors). `focus/` holds the 15 presentation sheets (G01–G04 gate level, F01–F11 transistor level); `flat/` holds each block opened to transistors. `benches/` holds the 8 simulation benches. |
| `docs/schematics/` | SVG exports of the 15 presentation sheets (from Xschem). |
| `layout/` | `tt_um_metastability_characterizer.gds / .lef / .v`, the LVS reference netlist and the pre-layout simulation netlist (`chip_lvs.spice`, `chip_sim.spice`), and the scripts that run the checks (`run_layout.sh`, `magic_checks.tcl`, `make_tb_chip.py`). |
| `verification/layout/` | Sign-off logs from ecetesla0, Nov 7 2026: KLayout GF180 DRC (clean, 0 items), KLayout antenna (0 items), Magic DRC (0), Netgen LVS ("Circuits match uniquely"), pre/post-layout whole-tile simulation. |
| `verification/sims/` | The 8 bench netlists, their ngspice logs, and `results.txt` (e.g. tau 88.9 ps baseline, 80.5 ps keeper x2, 102.3 ps forward x2), with `expected.json`. |
| `tools/` | The Python generators that produced the netlist, schematics, layout and checks (reference; paths inside point at the original build folder). |

## Using the schematics
On ecetesla0: `cd xschem && bash setup.sh` once (it writes this folder's path into the `.sch`/`.sym` files),
then `bash view.sh F04` opens a sheet full screen with its net colours, and `bash export_svg.sh` writes SVGs.

## Still open
- PEX with wiring capacitance: the extraction script is fixed; the rerun is pending.
- `info.yaml` / `docs/info.md`: tile size must be 1x2 (analog), `top_module: tt_um_metastability_characterizer`,
  analog pin ua[0]. When this is merged, `layout/*.gds` and `*.lef` move to the template's `gds/` and `lef/` folders.

# Metastability characterizer — Tiny Tapeout GF 26c, analog 1x2 tile

Measures flip-flop metastability resolution on GF180 silicon across four flip-flop designs, and a bank with two faster designs and a second copy of one of the four. Pinout and usage: [docs/info.md](docs/info.md). Schematics, layout and checks: [README_analog.md](README_analog.md).

| Folder | Contents |
|---|---|
| `gds/`, `lef/`, `src/project.v` | Tile layout, abstract, and black-box Verilog submitted to Tiny Tapeout |
| `xschem/` | Schematic hierarchy: `chip.sch` → `blocks/` → `cells_tx/` (each standard cell at transistor level); `focus/` presentation sheets; `flat/` blocks opened to transistors; `benches/` simulation benches |
| `docs/schematics/` | SVG exports of the presentation sheets |
| `layout/` | LVS reference and simulation netlists, and the scripts that run DRC, LVS, extraction and the simulations (`run_layout.sh`, `run_postlayout.sh`) |
| `tools/`, `netlist/`, `README_analog.md` | TT verification: the Python generators for the netlist, schematics and layout, and how the layout was checked |
| `verification/` | Sign-off logs (Nov 17 2026): KLayout DRC and antenna clean, Magic DRC clean, Netgen LVS match, pre/post-layout tile simulation, block simulations. `verification/independent/`: a second check of that layout (Nov 22 and 23 2026) with two versions of Magic. `verification/bank/`: the checks and simulations of the revised layout with the bank (Nov 25 2026) |
| `host/` | Measurement programs for the demo board and the fit of tau (not yet run on hardware) |

Schematics on ecetesla0: `cd xschem && bash setup.sh` once, then `bash view.sh F04` to open a sheet.

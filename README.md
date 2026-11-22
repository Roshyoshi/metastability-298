# Metastability characterizer — Tiny Tapeout GF 26c, analog 1x2 tile

Measures flip-flop metastability resolution on GF180 silicon across four flip-flop designs. Pinout and usage: [docs/info.md](docs/info.md). Design: [docs/design_doc.tex](docs/design_doc.tex).

| Folder | Contents |
|---|---|
| `gds/`, `lef/`, `src/project.v` | Tile layout, abstract, and black-box Verilog submitted to Tiny Tapeout |
| `xschem/` | Schematic hierarchy: `chip.sch` → `blocks/` → `cells_tx/` (each standard cell at transistor level); `focus/` presentation sheets; `flat/` blocks opened to transistors; `benches/` simulation benches |
| `docs/schematics/` | SVG exports of the presentation sheets |
| `layout/` | LVS reference and simulation netlists, and the DRC/LVS/PEX/simulation scripts run on ecetesla0 |
| `tools/`, `netlist/`, `README_analog.md` | TT verification: the Python generators for the netlist, schematics and layout, and how the layout was checked |
| `verification/` | Sign-off logs (Nov 17 2026): KLayout DRC and antenna clean, Magic DRC clean, Netgen LVS match, pre/post-layout tile simulation, block simulations |

Schematics on ecetesla0: `cd xschem && bash setup.sh` once, then `bash view.sh F04` to open a sheet.

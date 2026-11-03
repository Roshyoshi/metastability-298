# GF180 models and reproducibility

The development flake supplies tools. GF180 device models, standard-cell
libraries, and physical implementation tools are separate dependencies.

The [design document](design_doc.tex), under "Reproducibility and handoff",
records the reference environment:

| Item | Reference |
| --- | --- |
| PDK variant | `gf180mcuD` |
| Standard cells | `gf180mcu_fd_sc_mcu7t5v0` |
| Device model file | `sm141064.ngspice` |
| Simulator | ngspice 42 |
| Model compatibility | `set ngbehavior=hs` |
| Conditions | TT/SS/FF at 3.3 V; TT at 3.0/3.6 V; 27 °C |

The document contains abbreviated PDK and script hashes. Recover the full
revisions and original scripts before claiming reproduction of its results.
The current flake provides ngspice 45; new measurements must record that
version and be compared with the reference results.

Use `PDK_ROOT` for the installation directory containing `gf180mcuD`, following
the Tiny Tapeout GF180 template convention. Keep downloaded PDK contents
outside the repository. Record exact model paths, revisions, corners, supplies,
solver settings, and loads with retained results.

The shuttle core supply remains an open item in the design document. Confirm
it before selecting final characterization conditions. The standard-cell
library name alone does not settle the chip's operating voltage.

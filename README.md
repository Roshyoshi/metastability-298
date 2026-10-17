# GF180 metastability experiment

The instrument compares four flip-flops using a shared early/late observation
path. Its first implementation task is the ring oscillator and divided data
source. The [design document](docs/design_doc.tex) contains the circuit plan and
reported SPICE results.

Current implementation: Tiny Tapeout interface scaffold with tied-off outputs.
The oscillator, measurement circuit, and physical constraints are pending.

## Development

```sh
nix develop
make check
```

The shell provides Icarus Verilog, Verilator, Yosys, ngspice, and GNU Make.
`make check` compiles and lints the current top, runs generic RTL synthesis,
and executes the interface harness. The harness supplies a 20 MHz clock and
reset, then finishes; it does not check instrument behavior yet.

`make sim` writes `build/rtl/tb.vcd`. `make synth` writes its netlist and report
under `build/synth/`. These are tooling checks, not GF180 physical signoff.
Set `BUILD_DIR` to put generated files elsewhere.

Once a SPICE deck exists, run it with `make spice DECK=path/to/deck.cir`.
The log goes under `build/spice/`; paths inside the deck are resolved from the
repository root. GF180 simulations also need the separately installed
[PDK](docs/pdk.md).

## Source layout

| Path | Responsibility |
| --- | --- |
| `src/project.v` | Tiny Tapeout boundary and pin mapping |
| `src/` | Instrument integration, stimulus control, sequencer, counters |
| `src/gf180/` | Explicit standard-cell circuits |
| `test/tb.v` | Top-level clock/reset and waveform harness |
| `test/rtl/` | Digital block and protocol tests |
| `test/models/` | Simulation-only oscillator and delay models |
| `test/gate/` | Mapped and post-layout netlist checks |
| `spice/ring_osc/` | Oscillator characterization |
| `spice/duts/` | Flip-flop metastability characterization |
| `spice/delay_line/` | Delay-tap characterization |
| `constraints/` | Timing, cell preservation, and placement |
| `docs/` | Design source, figures, PDK setup, submission documentation |
| `results/` | Retained measurements and run provenance |
| `build/` | Disposable generated output; ignored by version control |

Planned RTL files are `instrument.v`, `stimulus.v`, `sequencer.v`, and
`counters.v` under `src/`, and `ring_osc.v`, `meta_duts.v`, `delay_line.v`, and
`observers.v` under `src/gf180/`. Add each as its block is implemented.
Keep the ASIC source list in `info.yaml` aligned with `RTL_SOURCES` in the
Makefile. Simulation models belong only in simulation source lists.

## Ring oscillator first

Start with the [oscillator characterization plan](spice/ring_osc/README.md).
The design document's baseline is a 31-stage ring followed by divide-by-four.
The physical ring belongs in `src/gf180/ring_osc.v`; its divider and external
source selection belong in `src/stimulus.v`.

RTL models will exercise control and integration. Oscillation frequency,
startup, and loading must be evaluated using the physical circuit models.
The existing SPICE scripts and figures referenced by the design document
have not been imported into this repository.

# GF180 metastability experiment

The instrument compares four flip-flops using a shared early/late observation
path. Its first implementation task is the ring oscillator and divided data
source. The [design document](docs/design_doc.tex) contains the circuit plan and
reported SPICE results.

Current implementation: Tiny Tapeout interface scaffold with tied-off outputs,
a standalone gated ring oscillator, and the measurement controller
(`src/gf180/compact_control.v`): 93 GF180 cells that run a block of 65,535
trials and count events in 16 bits. The controller passes its logic tests but
is not connected to the top level yet. Integration, the measurement circuit,
transistor-level checks, and physical constraints are pending.

## Development

```sh
nix develop
make check
```

The shell provides Icarus Verilog, Verilator, Yosys, ngspice, and GNU Make.
`make check` compiles and lints the current top, runs generic RTL synthesis,
executes the interface harness, and runs `make check-ring`. The harness supplies
a 20 MHz clock and reset, then finishes; it does not check instrument behavior
yet. The ring check tests enable, disable, restart, and loop period with
artificial cell delays, and checks that synthesis retains the selected cells.
`make check-control` runs the controller's tests in `test/rtl/tb_compact_control.v`
at block lengths of 15, 255 and 65,535 trials (about 45 seconds), and checks
that the controller contains exactly the cells listed in
`test/rtl/compact_control_cells.ys`, before and after synthesis. Its cell
models also use 1 ns delays, so it checks wiring and edge order, not timing.

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
| `src/gf180/` | Explicit standard-cell circuits: ring oscillator, measurement controller |
| `test/tb.v` | Top-level clock/reset and waveform harness |
| `test/rtl/` | Digital block and protocol tests |
| `test/models/` | Simulation-only models of the GF180 cells and delays |
| `test/gate/` | Mapped and post-layout netlist checks |
| `spice/ring_osc/` | Oscillator characterization |
| `spice/duts/` | Flip-flop metastability characterization |
| `spice/delay_line/` | Delay-tap characterization |
| `constraints/` | Timing, cell preservation, and placement |
| `docs/` | Design source, figures, PDK setup, submission documentation |
| `results/` | Retained measurements and run provenance |
| `build/` | Disposable generated output; ignored by version control |

Planned RTL files are `instrument.v`, `stimulus.v`, `sequencer.v`, and
`counters.v` under `src/`, and `meta_duts.v`, `delay_line.v`, and
`observers.v` under `src/gf180/`. Add each as its block is implemented.
Keep the ASIC source list in `info.yaml` aligned with `RTL_SOURCES` in the
Makefile. Simulation models belong only in simulation source lists.

## Ring oscillator first

Start with the [oscillator characterization plan](spice/ring_osc/README.md).
The design document's baseline is a 31-stage ring followed by divide-by-four.
The physical ring is in [`src/gf180/ring_osc.v`](src/gf180/ring_osc.v). It uses
one enable NAND and 30 inverters, with a buffer outside the feedback loop.
`STAGES` is an elaboration parameter counting the NAND and inverters; it must
be odd and at least three. Hold `en` low until the ring settles before starting.
Disabling settles `clk_out` high. Start/stop can produce short pulses, so the
caller must exclude those transitions from acquisition. The divider and
external source selection belong in the future `src/stimulus.v`.

`make check-ring` writes waveforms and a structural netlist under `build/ring/`.
Its cell models use arbitrary 1 ns delays; the resulting period is not a
prediction of silicon frequency. Synthesis reads those models as black boxes
to check cell preservation without a PDK. The ASIC source list excludes them.

RTL models will exercise control and integration. Oscillation frequency,
startup, and loading must be evaluated using the physical circuit models.
The existing SPICE scripts and figures referenced by the design document
have not been imported into this repository.

# Ring oscillator characterization

The baseline in the [design document](../../docs/design_doc.tex), under
"The test chip (instrument)", is a 31-stage ring followed by divide-by-four.
It reports a 4.51 ns ring period at TT, 3.3 V, and a 3.46–6.25 ns range across
the stated conditions. These are reference results; the original oscillator
netlist and characterization script are absent from this repository.

The circuit implementation is the next design decision. Compare candidates
with the same output loading and model conditions. For each candidate, retain:

- The complete loop, including any enable gate and its inversion.
- Startup and disable behavior, including the state of the divided output.
- Period and duty cycle after startup at each process/voltage condition.
- Loading from the divider and monitor path, with the monitor buffered as
  needed to avoid changing the oscillator under measurement.
- Cell counts and the constraints needed to preserve the loop through the flow.

Put SPICE decks and measurement commands here. Put the chosen structural
Verilog in `src/gf180/ring_osc.v`, and its control/divider/source selection in
`src/stimulus.v`. A timed RTL model belongs in `test/models/` and is only for
digital integration tests.

Run a completed deck from the repository root with
`make spice DECK=spice/ring_osc/ring_osc.cir`. Retain accepted measurements under
`results/` with the model revisions and run conditions.

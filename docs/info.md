## How it works

Development scaffold for a GF180 metastability measurement instrument. The
current RTL exposes the Tiny Tapeout interface, drives output data low, and
configures all bidirectional pins as inputs.

The planned instrument uses a divided ring oscillator or external data to
stimulate four flip-flops. A shared delay line and early/late observers detect
disagreements; counters report a held result byte. The planned pinout is in
`info.yaml`, and the circuit details are in [design_doc.tex](design_doc.tex).

## How to test

From the repository root, enter `nix develop` and run `make check`. This checks
the current scaffold and runs a clock/reset harness. `make sim` also produces
`build/rtl/tb.vcd` for inspection. Instrument behavior and physical timing
verification will be added as the blocks are implemented.

## External hardware

The planned interface uses a 20 MHz clock, reset, control inputs, and parallel
result/status outputs. Board-level test procedures are pending implementation.

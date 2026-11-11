# Physical implementation constraints

Add timing, preservation, and placement files here as the physical blocks are
implemented. The build flow must explicitly load them; this directory alone
does not apply constraints.

The design document requires preserving DUT and delay-line instances and nets.
The oscillator also needs its intentional feedback loop and selected cells
preserved. Verify the resulting netlist and layout, including cell sizes,
feedback pin connections, output loading, and any inserted buffers.

`src/gf180/ring_osc.v` requests `keep_hierarchy` on the module and `keep` and
`dont_touch` on its cells and loop nets. `make check-ring` checks cell counts
after generic synthesis with black-box cell declarations. This does not prove
that the physical flow honors the attributes or preserves the loop's timing;
the hardening flow still needs explicit constraints and netlist inspection.

Define the external 20 MHz clock and the implemented generated-clock paths.
Scope timing exceptions to the intended asynchronous paths and loops.
Placement constraints must follow the characterized circuit topology.

The top, `src/project.v`, is the black box of the analog tile, and the layout
in `layout/` was built outside this flow. GF180 libraries, physical
constraints, and hardening here are pending.

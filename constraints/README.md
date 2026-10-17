# Physical implementation constraints

Add timing, preservation, and placement files here as the physical blocks are
implemented. The build flow must explicitly load them; this directory alone
does not apply constraints.

The design document requires preserving DUT and delay-line instances and nets.
The oscillator also needs its intentional feedback loop and selected cells
preserved. Verify the resulting netlist and layout, including cell sizes,
feedback pin connections, output loading, and any inserted buffers.

Define the external 20 MHz clock and the implemented generated-clock paths.
Scope timing exceptions to the intended asynchronous paths and loops.
Placement constraints must follow the characterized circuit topology.

The current `make synth` target performs generic synthesis of the interface
scaffold. GF180 libraries, physical constraints, and hardening are pending.

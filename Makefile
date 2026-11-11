TOP := tt_um_metastability_characterizer
# Keep this list aligned with project.source_files in info.yaml. The top is
# the analog tile's black box, so it is only compiled for its port list.
RTL_SOURCES := src/project.v
CONTROL_SOURCES := src/gf180/compact_control.v
CELL_MODELS := test/models/gf180_cells.v
# Block lengths the controller tests run at: 2^width - 1 trials each.
# A waveform file is written only for the first, shortest one.
CONTROL_WIDTHS ?= 4 8 16
BUILD_DIR ?= build

.DEFAULT_GOAL := help
.PHONY: help check check-ring check-control compile spice

help:
	@printf '%s\n' \
	  'make check                 Compile the top, then run check-ring and check-control' \
	  'make check-ring            Check ring control and preserved cell counts' \
	  'make check-control         Test the measurement controller and count its cells' \
	  'make spice DECK=path.cir   Run an existing SPICE deck in batch mode'

check: compile check-ring check-control

check-ring:
	@mkdir -p "$(BUILD_DIR)/ring"
	verilator --lint-only --timing -Wall -Wno-DECLFILENAME \
	  --top-module ring_osc --Mdir "$(BUILD_DIR)/ring/lint" \
	  src/gf180/ring_osc.v $(CELL_MODELS)
	@set -e; for stages in 3 31; do \
	  iverilog -g2012 -Wall -s tb_ring_osc -Ptb_ring_osc.STAGES=$$stages \
	    -o "$(BUILD_DIR)/ring/tb_$$stages.vvp" \
	    src/gf180/ring_osc.v $(CELL_MODELS) test/rtl/tb_ring_osc.v; \
	  vvp "$(BUILD_DIR)/ring/tb_$$stages.vvp" \
	    +vcd="$(BUILD_DIR)/ring/tb_$$stages.vcd"; \
	done
	yosys -Q -q -l "$(BUILD_DIR)/ring/yosys.log" \
	  -p 'read_verilog -lib $(CELL_MODELS); read_verilog src/gf180/ring_osc.v; hierarchy -check -top ring_osc; synth -top ring_osc; check -assert; select -assert-count 1 t:gf180mcu_fd_sc_mcu7t5v0__nand2_1; select -assert-count 30 t:gf180mcu_fd_sc_mcu7t5v0__inv_1; select -assert-count 1 t:gf180mcu_fd_sc_mcu7t5v0__buf_1; write_verilog "$(BUILD_DIR)/ring/ring_osc.v"; write_json "$(BUILD_DIR)/ring/ring_osc.json"'

# The controller's parts list is in test/rtl/compact_control_cells.ys. It is
# counted as written and again after synthesis, which must not add, remove
# or replace any cell.
check-control:
	@mkdir -p "$(BUILD_DIR)/control"
	verilator --lint-only --timing -Wall -Wno-DECLFILENAME \
	  --top-module compact_control --Mdir "$(BUILD_DIR)/control/lint" \
	  $(CONTROL_SOURCES) $(CELL_MODELS)
	@set -e; vcd="+vcd=$(BUILD_DIR)/control/tb.vcd"; \
	for width in $(CONTROL_WIDTHS); do \
	  iverilog -g2012 -Wall -s tb_compact_control \
	    -Ptb_compact_control.WIDTH=$$width \
	    -o "$(BUILD_DIR)/control/tb_$$width.vvp" \
	    $(CONTROL_SOURCES) $(CELL_MODELS) test/rtl/tb_compact_control.v; \
	  vvp "$(BUILD_DIR)/control/tb_$$width.vvp" $$vcd; \
	  vcd=""; \
	done
	yosys -Q -q -l "$(BUILD_DIR)/control/yosys.log" \
	  -p 'read_verilog -lib $(CELL_MODELS); read_verilog $(CONTROL_SOURCES); hierarchy -check -top compact_control; script test/rtl/compact_control_cells.ys; synth -top compact_control; check -assert; script test/rtl/compact_control_cells.ys; write_verilog "$(BUILD_DIR)/control/compact_control.v"'

compile:
	iverilog -g2012 -Wall -s $(TOP) -t null $(RTL_SOURCES)

spice:
	@test -n "$(DECK)" || { \
	  printf '%s\n' 'Specify an existing deck: make spice DECK=path.cir' >&2; \
	  exit 2; \
	}
	@mkdir -p "$(BUILD_DIR)/spice"
	ngspice -b -o "$(BUILD_DIR)/spice/$(notdir $(basename $(DECK))).log" \
	  "$(DECK)"

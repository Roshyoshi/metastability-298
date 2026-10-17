TOP := tt_um_metastability
# Keep this list aligned with project.source_files in info.yaml.
RTL_SOURCES := src/project.v src/gf180/ring_osc.v
RING_MODELS := test/models/gf180_ring_cells.v
BUILD_DIR ?= build

.DEFAULT_GOAL := help
.PHONY: help check check-ring compile lint sim synth spice

help:
	@printf '%s\n' \
	  'make check                 Check RTL, the interface harness, and the ring' \
	  'make check-ring            Check ring control and preserved cell counts' \
	  'make sim                   Run the interface harness and write a VCD' \
	  'make synth                 Generate a generic RTL netlist and report' \
	  'make spice DECK=path.cir   Run an existing SPICE deck in batch mode'

check: compile lint synth sim check-ring

check-ring:
	@mkdir -p "$(BUILD_DIR)/ring"
	verilator --lint-only --timing -Wall -Wno-DECLFILENAME \
	  --top-module ring_osc --Mdir "$(BUILD_DIR)/ring/lint" \
	  src/gf180/ring_osc.v $(RING_MODELS)
	@set -e; for stages in 3 31; do \
	  iverilog -g2012 -Wall -s tb_ring_osc -Ptb_ring_osc.STAGES=$$stages \
	    -o "$(BUILD_DIR)/ring/tb_$$stages.vvp" \
	    src/gf180/ring_osc.v $(RING_MODELS) test/rtl/tb_ring_osc.v; \
	  vvp "$(BUILD_DIR)/ring/tb_$$stages.vvp" \
	    +vcd="$(BUILD_DIR)/ring/tb_$$stages.vcd"; \
	done
	yosys -Q -q -l "$(BUILD_DIR)/ring/yosys.log" \
	  -p 'read_verilog -lib $(RING_MODELS); read_verilog src/gf180/ring_osc.v; hierarchy -check -top ring_osc; synth -top ring_osc; check -assert; select -assert-count 1 t:gf180mcu_fd_sc_mcu7t5v0__nand2_1; select -assert-count 30 t:gf180mcu_fd_sc_mcu7t5v0__inv_1; select -assert-count 1 t:gf180mcu_fd_sc_mcu7t5v0__buf_1; write_verilog "$(BUILD_DIR)/ring/ring_osc.v"; write_json "$(BUILD_DIR)/ring/ring_osc.json"'

compile:
	iverilog -g2012 -Wall -s $(TOP) -t null $(RTL_SOURCES)

lint:
	@mkdir -p "$(BUILD_DIR)/lint"
	verilator --lint-only -Wall -Wno-DECLFILENAME --top-module $(TOP) \
	  --Mdir "$(BUILD_DIR)/lint" $(RTL_SOURCES)

sim:
	@mkdir -p "$(BUILD_DIR)/rtl"
	iverilog -g2012 -s tb -o "$(BUILD_DIR)/rtl/tb.vvp" \
	  $(RTL_SOURCES) test/tb.v
	vvp "$(BUILD_DIR)/rtl/tb.vvp" +vcd="$(BUILD_DIR)/rtl/tb.vcd"

synth:
	@mkdir -p "$(BUILD_DIR)/synth"
	yosys -q -l "$(BUILD_DIR)/synth/yosys.log" \
	  -p 'read_verilog $(RTL_SOURCES); synth -top $(TOP); check -assert; write_verilog "$(BUILD_DIR)/synth/$(TOP).v"; write_json "$(BUILD_DIR)/synth/$(TOP).json"'

spice:
	@test -n "$(DECK)" || { \
	  printf '%s\n' 'Specify an existing deck: make spice DECK=path.cir' >&2; \
	  exit 2; \
	}
	@mkdir -p "$(BUILD_DIR)/spice"
	ngspice -b -o "$(BUILD_DIR)/spice/$(notdir $(basename $(DECK))).log" \
	  "$(DECK)"

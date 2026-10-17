TOP := tt_um_metastability
# Keep this list aligned with project.source_files in info.yaml.
RTL_SOURCES := src/project.v
BUILD_DIR ?= build

.DEFAULT_GOAL := help
.PHONY: help check compile lint sim synth spice

help:
	@printf '%s\n' \
	  'make check                 Compile, lint, synthesize, and run the harness' \
	  'make sim                   Run the interface harness and write a VCD' \
	  'make synth                 Generate a generic RTL netlist and report' \
	  'make spice DECK=path.cir   Run an existing SPICE deck in batch mode'

check: compile lint synth sim

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

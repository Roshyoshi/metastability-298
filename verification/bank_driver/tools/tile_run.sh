#!/bin/bash
# Whole-tile run with a current probe on every cell: bench of layout/make_tb_chip.py, probes of isup_gen.py.
# usage: tile_run.sh <extracted netlist> <out dir> <tag> <0|1: both data inputs toggled> <options of make_tb_chip.py ...>
PEX=$(realpath "$1"); OUT=$(realpath -m "$2"); TAG=$3; BOTH=$4; shift 4
W=/home/claude/work; mkdir -p "$OUT"
python3 $W/repo/layout/make_tb_chip.py "$PEX" "$OUT/base_$TAG.spice" /usr/local/share/pdk/gf180mcuD post_$TAG --threads 1 "$@" || exit 1
if [ "$BOTH" = 1 ]; then X=--both-data; else X=; fi
python3 $W/scripts/isup_gen.py "$PEX" "$OUT/base_$TAG.spice" "$OUT" isup_$TAG $X || exit 1
cd "$OUT" && ngspice -b isup_$TAG.spice > isup_$TAG.log 2>&1
tr '\r' '\n' < isup_$TAG.log | grep -a "^RESULT" > isup_$TAG.results.txt
grep -c . isup_$TAG.results.txt

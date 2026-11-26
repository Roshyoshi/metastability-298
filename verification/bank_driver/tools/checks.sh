#!/bin/bash
# Magic DRC, extraction (LVS and parasitic) and Netgen LVS of a GDS against a reference netlist.
# usage: checks.sh <gds> <reference lvs netlist> <results folder> [magic binary]
set -e
GDS=$(realpath "$1"); REF=$(realpath "$2"); OUT=$(realpath -m "$3"); MAGIC=${4:-/usr/local/bin/magic}
export PDK_ROOT=/usr/local/share/pdk PDK=gf180mcuD
mkdir -p "$OUT"; cd "$OUT"
TOP=tt_um_metastability_characterizer
$MAGIC -dnull -noconsole -rcfile $PDK_ROOT/gf180mcuD/libs.tech/magic/gf180mcuD.magicrc /home/claude/work/repo/layout/magic_checks.tcl "$GDS" $TOP "$OUT" > magic.log 2>&1 < /dev/null
netgen -batch lvs "${TOP}_lvs.spice $TOP" "$REF $TOP" $PDK_ROOT/gf180mcuD/libs.tech/netgen/gf180mcuD_setup.tcl lvs_report.txt > lvs.log 2>&1 < /dev/null || true
grep -h "COUNT\|Total DRC" drc_magic.txt magic.log 2>/dev/null | sort | uniq -c | head -3
grep -h "Number of devices: 2[0-9][0-9]\|Final result\|Number of nets: 2" lvs_report.txt | sort | uniq -c

#!/bin/bash
# Characterizes the tile on the netlist Magic extracted from the layout, next to the same runs on the
# schematic netlist. Run layout/run_layout.sh first: it writes the extracted netlist. About an hour
# with 32 processor threads.
#
#   corners   the controller's timing over eight count pulses with ui_in[6] toggling and ua[0] = 1.3 V:
#             typical 3.3 V 27 C, slow 3.0 V at -40 C and at 125 C, fast 3.6 V at -40 C
#   delay     d against ua[0], 1.0 V to 3.3 V
#   arrival   when each flip-flop's new value reaches the early observer
#   events    ua[0] = 3.3 V, the shortest d: the early reading is the old value, so every trial counts;
#             and slow 3.0 V 125 C with ua[0] = 1.1 V, where d is long enough and no trial may count
#   tau       the regeneration time constant of the three NAND flip-flops, at the four corners
#
# usage: bash layout/run_postlayout.sh [results folder]      (default: build/layout, as run_layout.sh)
#        JOBS=4 THREADS=8   simulations at a time, and processor threads for each
#        RESUME=1           keep the runs that already have results and do the rest
#        RECORD=1           also copies results_postlayout.txt and .md to verification/layout
exec < /dev/null
L="$(cd "$(dirname "$0")" && pwd)"
R="${1:-$L/../build/layout}"; R="$(cd "$R" && pwd)" || exit 1
TOP=tt_um_metastability_characterizer
PDKDIR="${PDK_ROOT:-/usr/local/share/pdk}/${PDK:-gf180mcuD}"
PEX="$R/${TOP}_pex.spice"
[ -f "$PEX" ] || { echo "no $PEX: run layout/run_layout.sh first" >&2; exit 1; }
JOBS=${JOBS:-4}; THREADS=${THREADS:-8}
P="$R/post"; [ "${RESUME:-0}" = 1 ] || rm -rf "$P"; mkdir -p "$P"

simulate() {   # simulate <tag> <generator> <pre|post> <its options>: one bench, when a job slot is free
  local tag=$1 gen=$2 net="$L/chip_sim.spice"; [ "$3" = post ] && net="$PEX"; shift 3
  grep -q "^RESULT" "$P/tb_$tag.log" 2>/dev/null && return
  while [ "$(jobs -rp | wc -l)" -ge "$JOBS" ]; do wait -n; done
  ( cd "$P" && python3 "$L/$gen" "$net" "tb_$tag.spice" "$PDKDIR" "$tag" "$@" > "tb_$tag.gen" 2>&1 &&
      timeout 14400 ngspice -b "tb_$tag.spice" < /dev/null > "tb_$tag.log" 2>&1
    echo "$(date +%T) $tag exit $?" >> "$P/done.txt" ) &
}
bench() { local tag=$1 w=$2; shift 2; simulate "$tag" make_tb_chip.py "$w" --threads "$THREADS" "$@"; }

echo "== $(date)  extracted netlist: $PEX"
CORNERS="tt_3v3_27c:typical:3.3:27 ss_3v0_m40c:ss:3.0:-40 ss_3v0_125c:ss:3.0:125 ff_3v6_m40c:ff:3.6:-40"
for w in post pre; do          # the long runs first
  for c in $CORNERS; do
    IFS=: read -r name corner vdd temp <<< "$c"
    bench ${w}_$name $w --counts 8 --data toggle --ua0 1.3 --corner $corner --vdd $vdd --temp $temp
  done
done
for w in post pre; do
  for v in 1.0 1.1 1.2 1.3 1.4 1.5 1.8 2.4 3.0 3.3; do
    bench ${w}_ua0_${v/./v} $w --counts 0 --data toggle --ua0 $v
  done
  for k in 1 3 4; do           # flip-flop 2 is the one the delay runs use
    bench ${w}_dut$k $w --counts 0 --data toggle --dut $k
  done
  bench ${w}_events_3v3 $w --counts 4 --data toggle --ua0 3.3
  bench ${w}_events_1v1_ss_3v0_125c $w --counts 4 --data toggle --ua0 1.1 --corner ss --vdd 3.0 --temp 125
done
for c in $CORNERS; do          # the schematic with its wiring estimates, as xschem/benches/tb_tau
  IFS=: read -r name corner vdd temp <<< "$c"
  simulate tau_post_$name make_tb_tau.py post --corner $corner --vdd $vdd --temp $temp
  simulate tau_pre_$name make_tb_tau.py pre --corner $corner --vdd $vdd --temp $temp --estimates
done
wait
cat "$P/done.txt"
grep -h "^RESULT" "$P"/tb_*.log | sort -k2,2 -s > "$R/results_postlayout.txt"
python3 "$L/postlayout_tables.py" "$R/results_postlayout.txt" > "$R/results_postlayout.md"
cat "$R/results_postlayout.md"

if [ "${RECORD:-0}" = 1 ]; then
  cp "$R/results_postlayout.txt" "$R/results_postlayout.md" "$L/../verification/layout/"
  echo; echo "Recorded in $(cd "$L/../verification/layout" && pwd)"
fi
echo; echo "Done. Benches and logs: $P"

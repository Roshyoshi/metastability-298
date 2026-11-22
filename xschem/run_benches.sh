#!/bin/bash
# Netlists the seven benches in benches/ with Xschem and runs them in ngspice. About 5 minutes.
#
# usage: bash xschem/run_benches.sh [results folder]         (default: build/sims)
#        RECORD=1 bash xschem/run_benches.sh                 also copies the netlists, logs and results to verification/sims
#
# Needs xschem, ngspice and python3, and PDK_ROOT set to the folder that holds gf180mcuD (on ecetesla0 that
# is /usr/local/share/pdk, which is also what is used without PDK_ROOT). The benches are netlisted from a
# copy of this folder that setup.py writes into the results folder, so the sheets git tracks keep their
# placeholders. What each bench should give is on its sheet and in benches/expected.json.
exec < /dev/null          # no tool may wait for keyboard input
K="$(cd "$(dirname "$0")" && pwd)"
R="${1:-$K/../build/sims}"; mkdir -p "$R"; R="$(cd "$R" && pwd)"
PDKDIR="${PDK_ROOT:-/usr/local/share/pdk}/${PDK:-gf180mcuD}"
BENCHES="tb_inv_balance tb_selector tb_duts tb_tau tb_delay tb_frontend tb_controller"

LOG="$R/run_log.txt"
{
  echo "== $(date)  PDK directory: $PDKDIR"
  for t in xschem ngspice python3; do printf "%-8s " $t; command -v $t || echo "not found"; done
  xschem -v 2>&1 | head -1
  ngspice --version 2>&1 | grep -m1 ngspice-
  cat "$PDKDIR/SOURCES" 2>/dev/null
} > "$LOG" 2>&1
cat "$LOG"

echo; echo "== 1. A copy of the sheets with this machine's paths, then one netlist for each bench"
rm -rf "$R/kit"
python3 "$K/setup.py" --to "$R/kit" "$PDKDIR" 2>&1 | tee -a "$LOG"
# Where the course keeps an xschemrc, Xschem is started there so that it reads it.
if [ -d "$HOME/ece298a/xschem" ]; then cd "$HOME/ece298a/xschem"; else cd "$R/kit"; fi
for tb in $BENCHES; do
  rm -f "$R/$tb.spice" "$R/$tb.log"
  timeout 300 xschem -x -r -q -n -s -o "$R" "$R/kit/benches/$tb.sch" > "$R/$tb.xschem" 2>&1
  if [ -s "$R/$tb.spice" ]; then echo "netlisted $tb"; else echo "== $tb was not netlisted: see $R/$tb.xschem"; fi
done 2>&1 | tee -a "$LOG"

echo; echo "== 2. ngspice, all benches at once"
cd "$R"
for tb in $BENCHES; do
  [ -s "$tb.spice" ] || continue
  ( t0=$(date +%s)
    timeout 5400 ngspice -b "$tb.spice" < /dev/null > "$tb.log" 2>&1
    echo "== $tb exit $? after $(( $(date +%s) - t0 )) s" >> "$LOG" ) &
done
wait
grep "exit" "$LOG"
for tb in $BENCHES; do
  [ -f "$tb.log" ] && grep "^RESULT" "$tb.log" | sed "s/^RESULT/RESULT $tb/"
done > results.txt
echo; cat results.txt

if [ "${RECORD:-0}" = 1 ]; then
  V="$K/../verification/sims"; mkdir -p "$V"
  # Recorded with ~ for the home folder, and the logs without ngspice's progress lines.
  for tb in $BENCHES; do
    for f in "$tb.spice" "$tb.log"; do
      [ -f "$f" ] && tr '\r' '\n' < "$f" | grep -v '^ *Reference value' | sed "s#$HOME#~#g" > "$V/$f"
    done
  done
  sed "s#$HOME#~#g" "$LOG" > "$V/run_log.txt"
  cp results.txt "$V/results.txt"
  cp "$K/benches/expected.json" "$V/expected.json"
  echo; echo "Recorded in $(cd "$V" && pwd)"
fi
echo; echo "Done. Netlists and logs: $R"

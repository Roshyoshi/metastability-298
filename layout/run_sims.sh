#!/bin/bash
# Run on ecetesla0 after setup.sh. 10 to 40 minutes. Produces results_round2_sims.tar.gz
exec < /dev/null          # no tool may wait for keyboard input
KIT="$(cd "$(dirname "$0")" && pwd)"
OUT="$KIT/sim"; mkdir -p "$OUT"; LOG="$OUT/run_log.txt"
{
  echo "== tool check $(date)"
  for t in xschem ngspice magic netgen klayout python3; do printf "%-8s " $t; command -v $t || echo "not found"; done
  ngspice --version 2>&1 | head -2
  echo "PDK_ROOT=$PDK_ROOT PDK=$PDK"
} > "$LOG" 2>&1
if [ -d "$HOME/ece298a/xschem" ]; then cd "$HOME/ece298a/xschem"; else cd "$KIT"; fi
echo "Netlisting the benches with Xschem ..."
xschem --script "$KIT/netlist.tcl" >> "$LOG" 2>&1
cd "$OUT"
for tb in tb_inv_balance tb_selector tb_duts tb_tau tb_delay tb_frontend tb_controller; do
  if [ -f "$tb.spice" ]; then
    echo "Simulating $tb ($(date +%T)) ..."
    echo "== $tb start $(date +%T)" >> "$LOG"
    timeout 5400 ngspice -b "$tb.spice" < /dev/null > "$tb.log" 2>&1
    echo "== $tb end $(date +%T) exit $?" >> "$LOG"
  else
    echo "== $tb was not netlisted" | tee -a "$LOG"
  fi
done
grep -h "^RESULT" *.log > results.txt 2>/dev/null
cd "$KIT" && tar czf results_round2_sims.tar.gz sim
echo; echo "Results:"; cat "$OUT/results.txt"
echo; echo "Done. Bring back: $KIT/results_round2_sims.tar.gz"

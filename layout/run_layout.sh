#!/bin/bash
# Run on ecetesla0. Checks the layout the way the Tiny Tapeout precheck and the course flow do.
# 20 to 60 minutes. Produces results_round2_layout.tar.gz
exec < /dev/null          # no tool may wait for keyboard input
KIT="$(cd "$(dirname "$0")/.." && pwd)"
L="$KIT/layout"; R="$L/results"; mkdir -p "$R"; cd "$L"
TOP=tt_um_metastability_characterizer
PDKDIR="${PDK_ROOT:-/usr/local/share/pdk}/${PDK:-gf180mcuD}"
[ -d "$PDKDIR" ] || PDKDIR=/usr/local/share/pdk/gf180mcuD
[ -d "$PDKDIR" ] || PDKDIR=$(ls -d /usr/local/share/pdk/gf180mcu* /usr/share/pdk/gf180mcu* $HOME/pdk/gf180mcu* 2>/dev/null | head -1)

LOG="$R/run_log.txt"
{
  echo "== $(date)  PDK directory: $PDKDIR"
  for t in klayout magic netgen ngspice python3; do printf "%-8s " $t; command -v $t || echo "not found"; done
  klayout -v 2>&1 | head -1; magic --version 2>&1 | head -1; netgen -batch quit 2>&1 | head -2
  ls "$PDKDIR/libs.tech" 2>&1
} > "$LOG" 2>&1
cat "$LOG"

echo; echo "== 1. KLayout: GF180 rule deck (no density), then 2. antenna"
DECK=$(ls "$PDKDIR"/libs.tech/klayout/tech/drc/gf180mcu.drc "$PDKDIR"/libs.tech/klayout/drc/gf180mcu.drc 2>/dev/null | head -1)
RUNDRC=$(ls "$PDKDIR"/libs.tech/klayout/drc/run_drc.py 2>/dev/null | head -1)
mkdir -p "$R/klayout_drc" "$R/klayout_antenna"
if [ -n "$DECK" ] && command -v klayout >/dev/null; then
  timeout 3600 klayout -b -r "$DECK" -rd input="$KIT/gds/$TOP.gds" -rd topcell=$TOP -rd variant=gf180mcuD -rd run_mode=deep       -rd threads=1 -rd decks="all,-density,-antenna" -rd report="$R/klayout_drc/drc.lyrdb" > "$R/drc_klayout.log" 2>&1
  timeout 3600 klayout -b -r "$DECK" -rd input="$KIT/gds/$TOP.gds" -rd topcell=$TOP -rd variant=gf180mcuD -rd run_mode=deep       -rd threads=1 -rd decks=antenna -rd report="$R/klayout_antenna/antenna.lyrdb" > "$R/drc_antenna.log" 2>&1
elif [ -n "$RUNDRC" ]; then
  python3 "$RUNDRC" --help > "$R/run_drc_help.txt" 2>&1
  for opts in "--variant=D --run_dir=$R/klayout_drc" "--variant=D"; do
    ( cd "$R/klayout_drc" && timeout 3600 python3 "$RUNDRC" --path="$KIT/gds/$TOP.gds" $opts --topcell=$TOP --run_mode=deep --thr=4 ) > "$R/drc_klayout.log" 2>&1 && break
  done
  for opts in "--variant=D --run_dir=$R/klayout_antenna" "--variant=D"; do
    ( cd "$R/klayout_antenna" && timeout 3600 python3 "$RUNDRC" --path="$KIT/gds/$TOP.gds" $opts --topcell=$TOP --run_mode=deep --thr=4 --antenna_only ) > "$R/drc_antenna.log" 2>&1 && break
  done
else
  echo "   no KLayout deck or run_drc.py under $PDKDIR/libs.tech/klayout" | tee -a "$LOG"
fi
echo "   rule deck: $(grep -h -E 'Clean|Violated|violations|rror' "$R/drc_klayout.log" 2>/dev/null | tail -3)"
echo "   antenna  : $(grep -h -E 'Clean|Violated|violations|rror' "$R/drc_antenna.log" 2>/dev/null | tail -3)"
echo "   violation items: $(cat $(find "$R/klayout_drc" "$R/klayout_antenna" -name '*.lyrdb' 2>/dev/null) /dev/null | grep -c '<item>')"

RC=$(ls "$PDKDIR"/libs.tech/magic/*.magicrc 2>/dev/null | head -1)
echo; echo "== 3. Magic DRC (full style), extraction for LVS and parasitic extraction (rc file: $RC)"
if [ -n "$RC" ] && command -v magic >/dev/null; then
  timeout 3600 magic -dnull -noconsole -rcfile "$RC" "$L/magic_checks.tcl" "$KIT/gds/$TOP.gds" $TOP "$R" > "$R/magic.log" 2>&1
  echo "   exit $? ; $(grep 'COUNT' "$R/drc_magic.txt" 2>/dev/null)"
  ls -la "$R"/*.spice 2>/dev/null
else
  echo "   Magic or its rc file not found" | tee -a "$LOG"
fi

SETUP=$(ls "$PDKDIR"/libs.tech/netgen/*setup*.tcl 2>/dev/null | head -1)
echo; echo "== 4. LVS: layout (Magic extraction) against the master netlist (setup: $SETUP)"
if [ -f "$R/${TOP}_lvs.spice" ] && command -v netgen >/dev/null; then
  timeout 3600 netgen -batch lvs "$R/${TOP}_lvs.spice $TOP" "$L/chip_lvs.spice $TOP" "$SETUP" "$R/lvs_report.txt" > "$R/lvs.log" 2>&1
  echo "   exit $?"
  grep -E "Circuits match|Netlists match|Netlists do not match|Top level cell failed|Cell pin lists" "$R/lvs_report.txt" | tail -5
else
  echo "   no extracted netlist or no netgen" | tee -a "$LOG"
fi

echo; echo "== 5. Pre- and post-layout simulation of the whole tile (1.6 us: reset, START, three trials)"
if command -v ngspice >/dev/null && command -v python3 >/dev/null; then
  python3 "$L/make_tb_chip.py" "$L/chip_sim.spice" "$R/tb_chip_pre.spice" "$PDKDIR" pre
  ( cd "$R" && timeout 7200 ngspice -b tb_chip_pre.spice < /dev/null > tb_chip_pre.log 2>&1 )
  if [ -f "$R/${TOP}_pex.spice" ]; then
    python3 "$L/make_tb_chip.py" "$R/${TOP}_pex.spice" "$R/tb_chip_post.spice" "$PDKDIR" post
    ( cd "$R" && timeout 7200 ngspice -b tb_chip_post.spice < /dev/null > tb_chip_post.log 2>&1 )
  fi
  grep -h "^RESULT" "$R"/tb_chip_*.log
fi

cd "$KIT" && tar czf results_round2_layout.tar.gz layout/results
echo; echo "Done. Bring back: $KIT/results_round2_layout.tar.gz"

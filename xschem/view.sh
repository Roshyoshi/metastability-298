#!/bin/bash
# Opens a sheet in Xschem, full screen, with its colours:   bash view.sh F04     (or G01, F11, ...)
KIT="$(cd "$(dirname "$0")" && pwd)"
f=$(ls "$KIT"/focus/"$1"*.sch 2>/dev/null | head -1)
[ -z "$f" ] && f=$(ls "$KIT"/"$1" 2>/dev/null | head -1)
if [ -z "$f" ]; then echo "No sheet matching $1. Sheets:"; ls "$KIT/focus" | grep '.sch$'; exit 1; fi
if [ -d "$HOME/ece298a/xschem" ]; then cd "$HOME/ece298a/xschem"; fi
echo "Opening $f"
SHEET="$f" xschem --script "$KIT/view_one.tcl" > /dev/null 2>&1 &

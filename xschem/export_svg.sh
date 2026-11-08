#!/bin/bash
# Pictures of the sheets:   bash export_svg.sh          the 15 focus sheets (G01-G04, F01-F11)
#                           bash export_svg.sh all      every schematic in files.txt
# One Xschem per sheet (90 s limit each). SVG is written on the server, so nothing large crosses the VPN.
# If rsvg-convert exists here, a PNG (3000 px wide) is made from each SVG as well. Re-running skips finished sheets.
KIT="$(cd "$(dirname "$0")" && pwd)"
mkdir -p "$KIT/svg"
if [ "$1" = "all" ]; then LIST=$(cat "$KIT/files.txt"); else LIST=$(grep '^focus/' "$KIT/files.txt"); fi
if [ -d "$HOME/ece298a/xschem" ]; then cd "$HOME/ece298a/xschem"; else cd "$KIT"; fi
PNG=$(command -v rsvg-convert)
n=0; ok=0; bad=""
total=$(echo "$LIST" | wc -l)
for f in $LIST; do
  n=$((n+1))
  name=$(basename "$f" .sch)
  out="$KIT/svg/$name.svg"
  if [ ! -s "$out" ]; then
    t0=$(date +%s)
    SHEET="$KIT/$f" OUT="$out" timeout -k 5 90 xschem --script "$KIT/export_one.tcl" > "$KIT/svg/.log" 2>&1 < /dev/null
    t=$(( $(date +%s) - t0 ))
  else t=0; fi
  if [ -s "$out" ]; then
    ok=$((ok+1))
    [ -n "$PNG" ] && [ ! -s "$KIT/svg/$name.png" ] && rsvg-convert -w 3000 -b black -o "$KIT/svg/$name.png" "$out" 2>/dev/null
    echo "[$n/$total] OK  ${t} s  $name"
  else bad="$bad $f"; echo "[$n/$total] FAILED  ${t} s  $name   ($(tail -1 "$KIT/svg/.log"))"; fi
done
echo "Pictures made: $ok of $total   (PNG copies: $([ -n "$PNG" ] && echo yes || echo 'no, rsvg-convert not found'))"
[ -n "$bad" ] && echo "Failed:$bad"

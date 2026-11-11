#!/usr/bin/env python3
"""Round-2 kit for ecetesla0: schematics (regenerated, 1,956 transistors + 2 diodes), simulation benches, and
the layout with everything needed to check it there (DRC, antenna, extraction, LVS, post-layout simulation).

Output: rounds/round2/kit/  and  rounds/round2/round2_kit.zip
"""
import re, sys, json, shutil, zipfile
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import build_master as BM
import xschem_gen as XG
import benches_gen as BG

CHIP = Path(__file__).resolve().parent.parent
KIT = CHIP / 'rounds' / 'round2' / 'kit'
TOP = BM.TOP_NAME
SUP = {'VDD': 'VDPWR', 'VNW': 'VDPWR', 'VPW': 'VGND', 'VSS': 'VGND'}

def strip_comments(text):
    return '\n'.join(l for l in text.splitlines() if l.strip() and not l.lstrip().startswith('*'))

def lvs_reference():
    """chip.cdl with every .include inlined: one file for netgen."""
    out = ['* LVS reference for ' + TOP + ' (generated from netlist/chip.cdl; standard cells inlined from the PDK CDL)']
    for line in (CHIP / 'netlist' / 'chip.cdl').read_text().splitlines():
        m = re.match(r'\.include (\S+)', line)
        if m:
            out.append(strip_comments((CHIP / 'netlist' / m.group(1)).read_text()))
        else:
            out.append(line)
    return '\n'.join(out) + '\n'

def sim_netlist():
    """Pre-layout simulation netlist of the whole tile: chip.cdl with PDK-simulation cell subcircuits
    (cells_jx.spice, which carry junction areas) and the custom devices written as X instances."""
    cdl = (CHIP / 'netlist' / 'chip.cdl').read_text()
    used = sorted(set(re.findall(r'^\.include \.\./pdk_cells/cdl/(\S+)\.cdl', cdl, re.M)))
    sim = (CHIP / 'pdk_cells' / 'sim' / 'cells_jx.spice').read_text().replace('\n+', ' ')
    cells = {}
    for m in re.finditer(r'^\.SUBCKT (\S+).*?^\.ENDS', sim, re.S | re.M):
        cells[m.group(1)] = m.group(0)
    out = ['* Pre-layout simulation netlist of ' + TOP + ' (generated; PDK cell subcircuits with junction geometry)']
    out += [cells[c] for c in used]
    for line in cdl.splitlines():
        if line.startswith('.include') or line.startswith('*'):
            continue
        m = re.match(r'(M\S+) (\S+) (\S+) (\S+) (\S+) (\S+) W=(\S+) L=(\S+)', line)
        if m:
            name, d, g, s, b, model, W, L = m.groups()
            W, L = float(W), float(L)
            ext = 0.5e-6
            out.append(f'X{name} {d} {g} {s} {b} {model} w={W:.4g} l={L:.4g} ad={W * ext:.4g} as={W * ext:.4g} '
                       f'pd={2 * (W + ext):.4g} ps={2 * (W + ext):.4g}')
        else:
            out.append(line)
    return '\n'.join(out) + '\n'

README = """Round 2: the layout, plus regenerated schematics and benches.

What changed since round 1 (all of it is in these files):
  * the delay line's 2 fF timing capacitor is now a real device, MCT: an NMOS gate capacitor (W/L = 0.82/1.0 um,
    gate on node slow, drain/source/body on ground), about 2.1 fF while slow is above threshold
  * an antenna-diode cell (ant_ctrl) on ua[0]: without it the 170 um of metal from the ua[0] pad to the MC gate
    breaks the GF180 antenna rule (ratio 784 > 400); with it the ratio is 27
  * every constant output now has its own driver cell (tie-low cells, and buffers from ena for uio_oe[5:1])
    instead of metal ties, so no two tile pins are shorted together
  * the controller's tie-high cell (round 1 kit predates it)
  Totals: 219 cell instances, 1,956 transistors, 2 diodes.

Folders
  chip.sch, blocks/, cells_tx/   the Xschem hierarchy (press e to go into a symbol, Ctrl+e to come back up)
                                 cells_tx/<cell>.sch: every transistor of the cell, drawn with wires
                                 (PMOS from VDD at the top, NMOS to ground at the bottom)
  benches/                       8 simulation benches; expected values on each bench and in expected.json
  layout/                        the layout and everything to check it:
     tt_um_metastability_characterizer.gds / .lef / .v    the tile as Tiny Tapeout wants it
     chip_lvs.spice              reference netlist for LVS (the master netlist, cells inlined)
     chip_sim.spice              pre-layout netlist of the whole tile, for the pre/post-layout comparison
     *.tcl, *.sh, *.py           the check scripts used by run_layout.sh

Steps (ssh -Y to ecetesla0, unzip into ~/ece298a/round2, cd there)
  1. bash setup.sh            once: writes this folder's path into the schematics
  2. bash export_svg.sh       pictures of every schematic in Xschem's colours, into svg/ (one Xschem per sheet)
  3. bash run_sims.sh         the 8 benches (10 to 40 minutes); makes results_round2_sims.tar.gz
  4. bash run_layout.sh       DRC (KLayout deck of the precheck, then Magic), antenna, extraction, LVS,
                              post-layout simulation; makes results_round2_layout.tar.gz (20 to 60 minutes)
  5. bash layout_shots.sh     pictures of the layout in KLayout (needs the X window of ssh -Y)
Bring back the two .tar.gz files (and the shots/ folders if you want them in the report).
"""

SETUP = """#!/bin/bash
# Run once on ecetesla0, inside this folder: bash setup.sh
KIT="$(cd "$(dirname "$0")" && pwd)"
grep -rl '@@ROOT@@' "$KIT" --include='*.sch' --include='*.sym' | xargs -r sed -i "s#@@ROOT@@#$KIT#g"
echo "Kit ready at $KIT ($(wc -l < "$KIT/files.txt") schematics)"
"""

BENCHES = ['tb_inv_balance', 'tb_selector', 'tb_duts', 'tb_tau', 'tb_delay', 'tb_frontend', 'tb_controller']

RUN_SIMS = """#!/bin/bash
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
for tb in BENCHLIST; do
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
"""

NETLIST_TCL = """# Netlists every bench in benches/ into sim/ (started by run_sims.sh)
set root [file dirname [file normalize [info script]]]
file mkdir $root/sim
foreach tb {BENCHLIST} {
  if {[catch {xschem load $root/benches/$tb.sch} e]} { puts "FAIL load $tb : $e"; continue }
  catch {set_netlist_dir 1 $root/sim}
  set ::netlist_dir $root/sim
  if {[catch {xschem netlist} e]} { puts "FAIL netlist $tb : $e"; continue }
  set found ""
  foreach d [list $root/sim $::netlist_dir $::env(HOME)/.xschem/simulations [pwd]/simulation [pwd]/simulations [pwd]] {
    if {[file exists $d/$tb.spice]} { set found $d/$tb.spice; break }
  }
  if {$found eq ""} { puts "NOT FOUND $tb (netlist_dir=$::netlist_dir)"; continue }
  if {$found ne "$root/sim/$tb.spice"} { file copy -force $found $root/sim/$tb.spice }
  puts "OK   netlist $tb <- $found"
}
exit
"""

EXPORT_TCL = """# Opens every schematic listed in files.txt and saves it as a PNG in Xschem's colours (started by export_png.sh)
set root [file dirname [file normalize [info script]]]
file mkdir $root/shots
set fh [open $root/files.txt r]
set files [split [string trim [read $fh]] "\\n"]
close $fh
set n 0
foreach f $files {
  incr n
  set name [string map {/ _ .sch {}} $f]
  set out $root/shots/[format %02d $n]_$name.png
  if {[catch {xschem load $root/$f} err]} { puts "FAIL load $f : $err"; continue }
  catch {xschem zoom_full}
  if {[string match flat/ctrl_* $f]} { set w 9000; set h 2000 } elseif {[string match flat/* $f]} { set w 5000; set h 1800 } elseif {[string match focus/* $f]} { set w 3600; set h 2000 } else { set w 2400; set h 1400 }
  if {[catch {xschem print png $out $w $h} err]} {
    if {[catch {xschem print png $out} err2]} { puts "FAIL png $f : $err2" } else { puts "OK   $out" }
  } else { puts "OK   $out" }
}
puts "DONE $n schematics"
exit
"""

EXPORT_ONE_TCL = """# Saves ONE schematic as an SVG (vector: sharp at any zoom), with its net colours. Started by export_svg.sh.
set sheet $env(SHEET)
set out $env(OUT)
if {[catch {xschem load $sheet} err]} { puts "FAIL load $sheet : $err"; exit }
source [file dirname [info script]]/colours.tcl
apply_colours $sheet
catch {xschem zoom_full}
if {[catch {xschem print svg $out} err]} { puts "FAIL svg $sheet : $err" } else { puts "OK" }
exit
"""

COLOURS_TCL = """# Net colours of a sheet: the .hl file next to it lists 'net colour-index' (Xschem highlight colours).
proc apply_colours {sheet} {
  set hl [file rootname $sheet].hl
  if {![file exists $hl]} { return }
  set fh [open $hl r]
  foreach line [split [read $fh] "\\n"] {
    if {[llength $line] == 2} {
      catch {xschem set hilight_color [lindex $line 1]}
      catch {xschem hilight_netname [lindex $line 0]}
    }
  }
  close $fh
  catch {xschem redraw}
}
"""

VIEW_ONE_TCL = """# Opens one sheet full screen with its net colours (started by view.sh).
set sheet $env(SHEET)
xschem load $sheet
source [file dirname [info script]]/colours.tcl
apply_colours $sheet
catch {wm attributes . -zoomed 1}
update
after 300 {xschem zoom_full}
"""

VIEW_SH = """#!/bin/bash
# Opens a sheet in Xschem, full screen, with its colours:   bash view.sh F04     (or G01, F11, ...)
KIT="$(cd "$(dirname "$0")" && pwd)"
f=$(ls "$KIT"/focus/"$1"*.sch 2>/dev/null | head -1)
[ -z "$f" ] && f=$(ls "$KIT"/"$1" 2>/dev/null | head -1)
if [ -z "$f" ]; then echo "No sheet matching $1. Sheets:"; ls "$KIT/focus" | grep '.sch$'; exit 1; fi
if [ -d "$HOME/ece298a/xschem" ]; then cd "$HOME/ece298a/xschem"; fi
echo "Opening $f"
SHEET="$f" xschem --script "$KIT/view_one.tcl" > /dev/null 2>&1 &
"""

EXPORT_SVG_SH = """#!/bin/bash
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
"""

EXPORT_SH = (CHIP / 'rounds' / 'round1' / 'kit' / 'export_png.sh').read_text()

# ------------------------------------------------------------------ layout checks
FIND_PDK = """PDKDIR="${PDK_ROOT:-/usr/local/share/pdk}/${PDK:-gf180mcuD}"
[ -d "$PDKDIR" ] || PDKDIR=/usr/local/share/pdk/gf180mcuD
[ -d "$PDKDIR" ] || PDKDIR=$(ls -d /usr/local/share/pdk/gf180mcu* /usr/share/pdk/gf180mcu* $HOME/pdk/gf180mcu* 2>/dev/null | head -1)
"""

RUN_LAYOUT = """#!/bin/bash
# Run on ecetesla0. Checks the layout the way the Tiny Tapeout precheck and the course flow do.
# 20 to 60 minutes. Produces results_round2_layout.tar.gz
exec < /dev/null          # no tool may wait for keyboard input
KIT="$(cd "$(dirname "$0")" && pwd)"
L="$KIT/layout"; R="$L/results"; mkdir -p "$R"; cd "$L"
TOP=TOPNAME
FINDPDK
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
  timeout 3600 klayout -b -r "$DECK" -rd input="$L/$TOP.gds" -rd topcell=$TOP -rd variant=gf180mcuD -rd run_mode=deep \
      -rd threads=1 -rd decks="all,-density,-antenna" -rd report="$R/klayout_drc/drc.lyrdb" > "$R/drc_klayout.log" 2>&1
  timeout 3600 klayout -b -r "$DECK" -rd input="$L/$TOP.gds" -rd topcell=$TOP -rd variant=gf180mcuD -rd run_mode=deep \
      -rd threads=1 -rd decks=antenna -rd report="$R/klayout_antenna/antenna.lyrdb" > "$R/drc_antenna.log" 2>&1
elif [ -n "$RUNDRC" ]; then
  python3 "$RUNDRC" --help > "$R/run_drc_help.txt" 2>&1
  for opts in "--variant=D --run_dir=$R/klayout_drc" "--variant=D"; do
    ( cd "$R/klayout_drc" && timeout 3600 python3 "$RUNDRC" --path="$L/$TOP.gds" $opts --topcell=$TOP --run_mode=deep --thr=4 ) > "$R/drc_klayout.log" 2>&1 && break
  done
  for opts in "--variant=D --run_dir=$R/klayout_antenna" "--variant=D"; do
    ( cd "$R/klayout_antenna" && timeout 3600 python3 "$RUNDRC" --path="$L/$TOP.gds" $opts --topcell=$TOP --run_mode=deep --thr=4 --antenna_only ) > "$R/drc_antenna.log" 2>&1 && break
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
  timeout 3600 magic -dnull -noconsole -rcfile "$RC" "$L/magic_checks.tcl" "$L/$TOP.gds" $TOP "$R" > "$R/magic.log" 2>&1
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

echo; echo "== 5. Pre- and post-layout simulation of the whole tile (1.6 us: reset, START, the first four counted trials)"
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
"""

MAGIC_TCL = """# Magic, batch: DRC (full style), LVS extraction, parasitic extraction.
# Arguments: <gds> <top cell> <results folder>   (started by run_layout.sh)
set gdsfile [lindex $argv end-2]
set top [lindex $argv end-1]
set out [lindex $argv end]
gds maskhints yes
gds readonly true
gds read $gdsfile
load $top
select top cell
expand
# ---- DRC
drc euclidean on
drc style drc(full)
drc check
set res [drc listall why]
set oscale [cif scale out]
set f [open $out/drc_magic.txt w]
set count 0
foreach {why boxes} $res {
  puts $f $why
  foreach b $boxes {
    puts $f [format "   %.3f %.3f %.3f %.3f" [expr {$oscale*[lindex $b 0]}] [expr {$oscale*[lindex $b 1]}] [expr {$oscale*[lindex $b 2]}] [expr {$oscale*[lindex $b 3]}]]
    incr count
  }
}
puts $f "COUNT: $count"
close $f
puts "Magic DRC: $count error boxes"
# ---- extraction for LVS (devices and connectivity only)
cd $out
extract do local
extract no capacitance
extract no coupling
extract no resistance
extract no adjust
extract unique
extract all
ext2spice lvs
ext2spice -o ${top}_lvs.spice
# ---- parasitic extraction (wire capacitance to substrate and between nets), in its own folder so that
# the capacitance-free .ext files of the LVS extraction are not reused
file mkdir $out/pex
cd $out/pex
extract do capacitance
extract do coupling
extract do adjust
extract all
ext2spice hierarchy on
ext2spice format ngspice
ext2spice scale off
ext2spice cthresh 0
ext2spice rthresh 0
ext2spice -o $out/${top}_pex.spice
puts "extraction done"
quit -noprompt
"""

MAKE_TB = '''#!/usr/bin/env python3
"""Write a whole-tile transient bench around a netlist whose top subcircuit is the tile.
usage: make_tb_chip.py <netlist> <bench out> <pdk dir> <pre|post>
Stimulus: 20 MHz clock, reset held across two rising clock edges and released at 100 ns, START (ui_in[4]) raised at
300 ns and held (compact_control takes START as a level), selection = 1 (DUT2, baseline NAND),
data (ui_in[6]) held high, ua[0] = 1.8 V. Measures the delay between the two clock monitors (uio_out[4] =
capture edge, uio_out[5] = early-sample clock), which is the delay line's d plus equal buffer delays."""
import re, sys
net, out, pdk, tag = sys.argv[1:5]
TOP = "TOPNAME"
txt = open(net).read().replace("\\n+", " ")
m = re.search(r"^\\.subckt\\s+" + re.escape(TOP) + r"\\s+(.*)$", txt, re.M | re.I)
ports = m.group(1).split()
ports = [p for p in ports if "=" not in p]
def node(p):
    return p.replace("[", "_").replace("]", "")
drive = {"VDPWR": None, "VGND": None}
L = [f"* whole-tile bench ({tag}-layout), generated by make_tb_chip.py",
     f".include {pdk}/libs.tech/ngspice/design.ngspice",
     f".lib {pdk}/libs.tech/ngspice/sm141064.ngspice typical",
     f".lib {pdk}/libs.tech/ngspice/sm141064.ngspice diode_typical",
     ".param sw_stat_global=0 sw_stat_mismatch=0",
     f".include {net}",
     "VDD vdpwr 0 3.3",
     "VCLK clk 0 PULSE(0 3.3 24.5n 0.1n 0.1n 24.9n 50n)",
     "VRST rst_n 0 PWL(0 0 100n 0 100.1n 3.3)",
     "VENA ena 0 3.3",
     "VSTART ui_in_4 0 PWL(0 0 300n 0 300.1n 3.3)",
     "VCFG0 ui_in_3 0 3.3", "VCFG1 uio_in_6 0 0", "VDATA ui_in_6 0 3.3", "VBIAS ua_0 0 1.8"]
inputs = {"clk", "rst_n", "ena", "ui_in_4", "ui_in_3", "uio_in_6", "ui_in_6", "ua_0"}
nodes = []
for p in ports:
    n = node(p)
    if p == "VDPWR": nodes.append("vdpwr")
    elif p == "VGND" or p.upper() in ("VSUBS", "VSUB", "SUB", "GND"): nodes.append("0")
    elif n.startswith("ua") and n != "ua_0":
        nodes.append(n); L.append(f"R{n} {n} 0 1G")
    else:
        nodes.append(n)
        if n.startswith(("ui_in", "uio_in")) and n not in inputs:
            L.append(f"V{n} {n} 0 0")
        if n.startswith(("uo_out", "uio_out", "uio_oe")):
            L.append(f"C{n} {n} 0 0.2p")
L.append("XDUT " + " ".join(nodes) + " " + TOP)
bits = " ".join(f"v(uo_out_{k})" for k in range(8))
L += [".control", "set filetype=ascii", "tran 10p 1.6u",
      "meas tran first_cap when v(uio_out_4)=1.65 rise=1"]
for k in (1, 2, 3):
    L.append(f"meas tran d{k} trig v(uio_out_4) val=1.65 rise={k} targ v(uio_out_5) val=1.65 rise={k}")
L += ["let fc=first_cap*1e9", f"echo RESULT {tag} first_capture_ns $&fc"]
for k in (1, 2, 3):
    L += [f"let dd=d{k}*1e12", f"echo RESULT {tag} monitor_delay_ps_trial{k} $&dd"]
L += ["meas tran busy find v(uio_out_1) at=1.59u", f"echo RESULT {tag} busy_V $&busy"]
L += [f"meas tran ev{k} find v(uo_out_{k}) at=1.59u" for k in range(8)]
L += ["let ev=(ev0 gt 1.65)+2*(ev1 gt 1.65)+4*(ev2 gt 1.65)+8*(ev3 gt 1.65)+16*(ev4 gt 1.65)+32*(ev5 gt 1.65)+64*(ev6 gt 1.65)+128*(ev7 gt 1.65)",
      f"echo RESULT {tag} events $&ev",
      f"wrdata tb_chip_{tag}.dat v(clk) v(uio_out_4) v(uio_out_5) v(uio_out_1) {bits}", ".endc", ".end"]
open(out, "w").write("\\n".join(L) + "\\n")
print("wrote", out, "with", len(ports), "tile ports")
'''

SHOTS_SH = """#!/bin/bash
# Pictures of the layout in KLayout (run in ssh -Y). Writes layout/shots/*.png
KIT="$(cd "$(dirname "$0")" && pwd)"; L="$KIT/layout"; mkdir -p "$L/shots"
FINDPDK
LYP=$(ls "$PDKDIR"/libs.tech/klayout/tech/*.lyp 2>/dev/null | head -1)
klayout -z -nc -rx -rd gds="$L/TOPNAME.gds" -rd lyp="$LYP" -rd out="$L/shots" -r "$L/klayout_shots.py" 2>&1 | tail -5
ls "$L/shots"
echo "If no PNGs appeared: open KLayout (klayout $L/TOPNAME.gds -l $LYP), zoom to a region, File > Screenshot."
"""

KLAYOUT_SHOTS = '''# KLayout batch: whole tile plus close-ups, in the PDK's layer colours on KLayout's dark background.
import pya, os
gds, lyp, out = gds, lyp, out
view = pya.LayoutView()
view.load_layout(gds, True)
if lyp:
    view.load_layer_props(lyp)
view.set_config("background-color", "#000000")
view.max_hier()
VIEWS = VIEWLIST
for name, (x1, y1, x2, y2) in VIEWS.items():
    view.zoom_box(pya.DBox(x1, y1, x2, y2))
    w = 2400; h = int(w * (y2 - y1) / (x2 - x1)) or 600
    view.save_image(os.path.join(out, name + ".png"), w, max(400, min(h, 2400)))
print("saved", len(VIEWS), "pictures")
'''

def views():
    import chip_gds as CG, layout_gen as LG
    P = CG.build()
    rows = {name: r for r, (name, cells) in enumerate(P['rows'])}
    v = {'tile': (0, 0, LG.TILE_W, LG.TILE_H)}
    for name in ('F1', 'u_dut2', 'C1', 'P1'):
        r = rows[name]; yb = P['yrow'][r]
        xs = [x for x, c, i in P['placed'][r] if i is not None]
        v['row_' + name] = (min(xs) - 2, yb - 4, min(max(xs) + 6, min(xs) + 60), yb + 8)
    r = rows['F1']; yb = P['yrow'][r]
    k = next(k for k, (x, c, i) in enumerate(P['placed'][r]) if c == 'meta_dly_cs')
    xd = P['placed'][r][k][0]
    v['delay_line'] = (xd - 2, yb - 1.5, xd + 16, yb + 5.5)
    return v

def main():
    if KIT.exists():
        shutil.rmtree(KIT)
    KIT.mkdir(parents=True)
    XG.build(KIT)
    BG.build(KIT)
    # flat transistor-level block schematics (tools/flat_blocks.py; routed once, cached in schematics_flat/)
    flat_src = CHIP / 'schematics_flat'
    (KIT / 'flat').mkdir()
    for f in sorted(flat_src.glob('*.sch')):
        shutil.copy(f, KIT / 'flat' / f.name)
    flat_order = ['dut1_library', 'dut2_baseline', 'dut3_keeper', 'dut4_forward', 'data_and_capture', 'selector',
                  'delay_line', 'early_observer', 'monitors'] + ['ctrl_' + b[0] for b in BM.CTRL_BLOCKS]
    (KIT / 'focus').mkdir()
    focus = sorted((CHIP / 'schematics_focus').glob('*.sch'))
    for f in focus:
        shutil.copy(f, KIT / 'focus' / f.name)
        if f.with_suffix('.hl').exists():
            shutil.copy(f.with_suffix('.hl'), KIT / 'focus' / f.with_suffix('.hl').name)
    shutil.copytree(CHIP / 'schematics_focus' / 'sym', KIT / 'sym')
    # pictures: focused sheets first (G = gate level, F = transistor level), then the flat blocks, then every cell
    files = [f'focus/{f.name}' for f in sorted(focus, key=lambda f: (f.name[0] != 'G', f.name))] + \
            [f'flat/{n}.sch' for n in flat_order if (KIT / 'flat' / f'{n}.sch').exists()] + \
            sorted(f'cells_tx/{p.name}' for p in (KIT / 'cells_tx').glob('*.sch'))
    (KIT / 'files.txt').write_text('\n'.join(files) + '\n')
    bl = ' '.join(BENCHES)
    for name, text in [('README.txt', README), ('setup.sh', SETUP), ('run_sims.sh', RUN_SIMS.replace('BENCHLIST', bl)),
                       ('netlist.tcl', NETLIST_TCL.replace('BENCHLIST', bl)), ('export.tcl', EXPORT_TCL),
                       ('export_png.sh', EXPORT_SH), ('export_one.tcl', EXPORT_ONE_TCL), ('export_svg.sh', EXPORT_SVG_SH), ('colours.tcl', COLOURS_TCL), ('view_one.tcl', VIEW_ONE_TCL), ('view.sh', VIEW_SH),
                       ('run_layout.sh', RUN_LAYOUT.replace('TOPNAME', TOP).replace('FINDPDK', FIND_PDK)),
                       ('layout_shots.sh', SHOTS_SH.replace('TOPNAME', TOP).replace('FINDPDK', FIND_PDK))]:
        (KIT / name).write_text(text)
    L = KIT / 'layout'; L.mkdir()
    for ext in ('gds', 'lef', 'v'):
        shutil.copy(CHIP / 'layout' / f'{TOP}.{ext}', L)
    (L / 'chip_lvs.spice').write_text(sim_netlist().replace('Pre-layout simulation netlist', 'LVS reference netlist'))
    (L / 'chip_sim.spice').write_text(sim_netlist())
    (L / 'magic_checks.tcl').write_text(MAGIC_TCL)
    (L / 'make_tb_chip.py').write_text(MAKE_TB.replace('TOPNAME', TOP))
    (L / 'klayout_shots.py').write_text(KLAYOUT_SHOTS.replace('VIEWLIST', json.dumps(views(), indent=1)))
    shutil.copy(CHIP / 'layout' / 'layout_plan.json', L)
    shutil.copy(CHIP / 'layout' / 'drc_lite_report.json', L)
    z = CHIP / 'rounds' / 'round2' / 'round2_kit.zip'
    with zipfile.ZipFile(z, 'w', zipfile.ZIP_DEFLATED) as zf:
        for p in sorted(KIT.rglob('*')):
            if p.is_file():
                zi = zipfile.ZipInfo.from_file(p, 'round2/' + str(p.relative_to(KIT)))
                if p.suffix in ('.sh', '.py'):
                    zi.external_attr = 0o755 << 16
                zf.writestr(zi, p.read_bytes(), zipfile.ZIP_DEFLATED)
    print(z, z.stat().st_size // 1024, 'kB,', len(files), 'schematics')

if __name__ == '__main__':
    main()

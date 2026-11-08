# Saves ONE schematic as an SVG (vector: sharp at any zoom), with its net colours. Started by export_svg.sh.
set sheet $env(SHEET)
set out $env(OUT)
if {[catch {xschem load $sheet} err]} { puts "FAIL load $sheet : $err"; exit }
source [file dirname [info script]]/colours.tcl
apply_colours $sheet
catch {xschem zoom_full}
if {[catch {xschem print svg $out} err]} { puts "FAIL svg $sheet : $err" } else { puts "OK" }
exit

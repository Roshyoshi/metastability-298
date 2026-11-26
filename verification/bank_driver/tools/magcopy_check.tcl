# Magic, batch: load the tile from the .mag copy (layout/mag), run DRC (full style), extract for LVS.
# Arguments: <folder with the .mag files> <top cell> <results folder>
set magdir [file normalize [lindex $argv end-2]]
set top [lindex $argv end-1]
set out [file normalize [lindex $argv end]]
path search +$magdir
cd $magdir
load $top
select top cell
expand
drc euclidean on
drc style drc(full)
drc check
set res [drc listall why]
set count 0
foreach {why boxes} $res { puts "DRC: $why ([llength $boxes])"; incr count [llength $boxes] }
puts "MAGCOPY DRC COUNT: $count"
file mkdir $out
cd $out
extract path $out
extract do local
extract no capacitance
extract no coupling
extract no resistance
extract no adjust
extract unique
extract all
ext2spice lvs
ext2spice -o ${top}_lvs.spice
puts "extraction done"
quit -noprompt

# Magic antenna check. Arguments: <gds> <top cell> <results folder>
set gdsfile [lindex $argv end-2]
set top [lindex $argv end-1]
set out [lindex $argv end]
gds maskhints yes
gds readonly true
gds read $gdsfile
load $top
select top cell
expand
cd $out
extract do local
extract no capacitance
extract no coupling
extract no resistance
extract no adjust
extract unique
extract all
feedback clear
antennacheck debug
antennacheck
puts "ANTENNA FEEDBACK COUNT: [feedback count]"
quit -noprompt

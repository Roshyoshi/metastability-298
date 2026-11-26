set gdsfile [lindex $argv end-1]
set top [lindex $argv end]
gds maskhints yes
gds readonly true
gds read $gdsfile
load $top
select top cell
flatten ${top}_flat
load ${top}_flat
select top cell
extract do local
extract do capacitance
extract do coupling
extract do adjust
extract all
ext2sim labels on
ext2sim
extresist tolerance 10
extresist all
ext2spice hierarchy off
ext2spice format ngspice
ext2spice scale off
ext2spice cthresh 0
ext2spice rthresh 0
ext2spice extresist on
ext2spice -o ${top}_rc.spice
puts "rc extraction done"
quit -noprompt

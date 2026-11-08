# Magic, batch: DRC (full style), LVS extraction, parasitic extraction.
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

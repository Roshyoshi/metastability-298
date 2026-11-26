snap internal
cellname rename (UNNAMED) multi
proc um {x} { return [expr {int(round($x * 200))}] }
# Five parallel Metal2 wires (W1..W5), 100 um long, 0.28 wide, 0.28 apart
for {set i 0} {$i < 5} {incr i} {
  box values 0 [um [expr {0.56*$i}]] [um 100] [um [expr {0.56*$i+0.28}]]
  paint metal2
  label W[expr {$i+1}] c metal2
}
# A Metal3 wire crossing over all five, 2 um wide, at x = 50 um
box values [um 49] [um -5] [um 51] [um 8]
paint metal3
label X c metal3
save multi
extract all
ext2spice cthresh 0
ext2spice format ngspice
ext2spice
quit -noprompt

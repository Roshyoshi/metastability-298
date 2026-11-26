snap internal
cellname rename (UNNAMED) twowire
box values 0 0 0 0
proc um {x} { return [expr {int(round($x * 200))}] }
# Two parallel Metal2 wires, 100 um long, 0.28 um wide, 0.28 um apart, over bare substrate
box values 0 0 [um 100] [um 0.28]
paint metal2
label A c metal2
box values 0 [um 0.56] [um 100] [um 0.84]
paint metal2
label B c metal2
# A third, isolated wire 20 um away for the area/fringe-only reference
box values 0 [um 20] [um 100] [um 20.28]
paint metal2
label C c metal2
save twowire
extract all
ext2spice cthresh 0
ext2spice format ngspice
ext2spice
quit -noprompt

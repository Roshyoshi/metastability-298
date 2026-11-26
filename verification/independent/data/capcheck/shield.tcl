snap internal
cellname rename (UNNAMED) shield
proc um {x} { return [expr {int(round($x * 200))}] }
# Metal3 wire T (100 um x 0.28 um) above a Metal1 plate P (100 um x 4 um), centred
box values 0 [um 1.86] [um 100] [um 2.14]
paint metal3
label T c metal3
box values 0 0 [um 100] [um 4]
paint metal1
label P c metal1
# The same Metal3 wire alone, 30 um away: reference
box values 0 [um 31.86] [um 100] [um 32.14]
paint metal3
label R c metal3
# A Metal2 wire 0.6 um from a Metal1 wire of another net, 0.3 um wide, running alongside (no overlap)
save shield
extract all
ext2spice cthresh 0
ext2spice format ngspice
ext2spice
quit -noprompt

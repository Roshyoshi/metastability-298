snap internal
cellname rename (UNNAMED) tap
proc um {x} { return [expr {int(round($x * 200))}] }
# Substrate tap tied to VGND: mvpsubdiff with contact and Metal1, labeled VGND
box values 0 0 [um 2] [um 2]
paint mvpsubdiff
box values [um 0.5] [um 0.5] [um 1.5] [um 1.5]
paint mvpsubdiffcont
box values 0 0 [um 2] [um 2]
paint metal1
label VGND c metal1
# Metal2 wire W over plain substrate, 100 um long
box values [um 10] [um 10] [um 110] [um 10.28]
paint metal2
label W c metal2
# Metal2 wire N over an nwell tied to VDPWR through an nwell tap
box values [um 10] [um 30] [um 110] [um 34]
paint nwell
box values [um 10] [um 30] [um 12] [um 32]
paint mvnsubdiff
box values [um 10.5] [um 30.5] [um 11.5] [um 31.5]
paint mvnsubdiffcont
box values [um 10] [um 30] [um 12] [um 32]
paint metal1
label VDPWR c metal1
box values [um 10] [um 31.86] [um 110] [um 32.14]
paint metal2
label N c metal2
save tap
extract all
ext2spice cthresh 0
ext2spice format ngspice
ext2spice
quit -noprompt

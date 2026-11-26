ext2spice hierarchy off
ext2spice format ngspice
ext2spice scale off
ext2spice cthresh 0
ext2spice extresist off
ext2spice -o tt_um_metastability_characterizer_flat_nor.spice tt_um_metastability_characterizer_flat
puts "flat netlist without resistance written"
quit -noprompt

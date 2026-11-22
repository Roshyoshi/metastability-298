# Magic, batch: writes the tile and every cell under it as .mag files, so that the layout opens in Magic.
#   magic -dnull -noconsole -rcfile <PDK>/libs.tech/magic/gf180mcuD.magicrc layout/gds2mag.tcl \
#         gds/tt_um_metastability_characterizer.gds tt_um_metastability_characterizer layout/mag
# The GDS stays the layout that is checked and submitted; the .mag files are a copy of it. If the layout
# is edited in Magic and written back to GDS, every check has to be run again on that GDS.
set gdsfile [file normalize [lindex $argv end-2]]
set top [lindex $argv end-1]
set out [file normalize [lindex $argv end]]
gds maskhints yes
gds read $gdsfile
load $top
file mkdir $out
cd $out
foreach f [glob -nocomplain *.mag] { file delete $f }
writeall force
puts "wrote [llength [glob *.mag]] .mag files to $out"
quit -noprompt

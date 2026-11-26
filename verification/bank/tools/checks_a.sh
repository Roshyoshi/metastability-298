#!/bin/bash
# Magic 8.3.573 DRC + extraction, Netgen LVS (as is and with the course-server MCT rename), Magic antenna check.
# usage: checks_a.sh <dir with v.gds>     (outputs in that dir)
D=$(readlink -f $1); cd $D
S=/home/claude/r8/bank/s3
$S/run_magic.sh v.gds m573 > m573.out 2>&1; cat m573.out
$S/run_lvs.sh m573/tt_um_metastability_characterizer_lvs.spice /home/claude/r8/bank/repo/layout/chip_lvs.spice lvs_report.txt
# course server (ecetesla0, older PDK): the timing capacitor MCT is extracted as nfet_06v0 and the reference is renamed
sed 's/^\(XMMCT .*\) nfet_05v0 /\1 nfet_06v0 /' /home/claude/r8/bank/repo/layout/chip_lvs.spice > ref_ecetesla0.spice
python3 - m573/tt_um_metastability_characterizer_lvs.spice ext_ecetesla0.spice << 'PY'
import sys, re
t = open(sys.argv[1]).read()
# the MCT device of meta_dly_cs: nfet_05v0 with l=1u (the only 1 um NMOS of the tile) becomes nfet_06v0
out, n = re.subn(r'^(X\S+ \S+ \S+ \S+ \S+) nfet_05v0 (.*l=1u.*)$', r'\1 nfet_06v0 \2', t, flags=re.M)
open(sys.argv[2], 'w').write(out); print('renamed devices with l=1u in the extraction:', n)
PY
$S/run_lvs.sh ext_ecetesla0.spice ref_ecetesla0.spice lvs_report_ecetesla0.txt
mkdir -p ant; /home/claude/eda/opt/bin/magic -dnull -noconsole -rcfile /usr/local/share/pdk/gf180mcuD/libs.tech/magic/gf180mcuD.magicrc $S/ant/ant.tcl $D/v.gds tt_um_metastability_characterizer $D/ant > ant/magic_ant.log 2>&1 < /dev/null
echo "Magic antenna: $(grep 'ANTENNA FEEDBACK COUNT' ant/magic_ant.log)"

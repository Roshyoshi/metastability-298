#!/bin/bash
# KLayout main deck (private copy, flat), conservative well deck, offline Tiny Tapeout precheck.
# usage: checks_b.sh <dir with v.gds>
D=$(readlink -f $1); mkdir -p $D/kl; cd $D/kl
cp ../v.gds k_all.gds; /home/claude/r5/layout/kdrc2.sh k_all.gds tt_um_metastability_characterizer > k_all.out 2>&1; echo "KLayout main: $(cat k_all.out)"
cp ../v.gds k_wells.gds; DECKS=dnwell,lvpwell,nat,nwell,ldnmos,ldpmos /home/claude/r5/layout/kdrc_cons.sh k_wells.gds tt_um_metastability_characterizer > k_wells.out 2>&1; echo "KLayout wells (conservative): $(cat k_wells.out)"
/home/claude/r8/bank/tools/run_precheck.sh /home/claude/r8/bank/repo $D/pre > $D/pre.out 2>&1; grep -c "✅" $D/pre/results.md | sed 's/^/precheck passes: /'

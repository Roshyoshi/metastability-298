#!/bin/bash
# PDK KLayout rule deck, flat mode (KLayout 0.28.16), main rules and antenna rules. usage: kdrc.sh <gds> <out dir>
GDS=$(realpath "$1"); OUT=$(realpath -m "$2"); mkdir -p "$OUT/main" "$OUT/antenna"
D=/home/claude/work/build/kdeck; T=tt_um_metastability_characterizer
cd "$OUT"
python3 $D/run_drc.py --path="$GDS" --variant=D --topcell=$T --run_dir="$OUT/main" --run_mode=flat --mp=1 --thr=1 > main.log 2>&1; echo "main exit $?" >> main.log
python3 $D/run_drc.py --path="$GDS" --variant=D --topcell=$T --run_dir="$OUT/antenna" --run_mode=flat --mp=1 --thr=1 --antenna_only > antenna.log 2>&1; echo "antenna exit $?" >> antenna.log
tail -3 main.log; tail -3 antenna.log

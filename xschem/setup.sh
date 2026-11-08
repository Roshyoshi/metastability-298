#!/bin/bash
# Run once on ecetesla0, inside this folder: bash setup.sh
KIT="$(cd "$(dirname "$0")" && pwd)"
grep -rl '@@ROOT@@' "$KIT" --include='*.sch' --include='*.sym' | xargs -r sed -i "s#@@ROOT@@#$KIT#g"
echo "Kit ready at $KIT ($(wc -l < "$KIT/files.txt") schematics)"

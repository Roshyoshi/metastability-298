#!/usr/bin/env python3
"""The job of setup.sh for machines without bash, such as Windows:   python setup.py [pdk_dir]

Writes this folder's path into every .sch and .sym file in place of @@ROOT@@. Give pdk_dir (the folder
that holds libs.tech/) to also replace the PDK location the sheets were written for,
/usr/local/share/pdk/gf180mcuD. Run it once, on a fresh checkout, and do not commit the result.
"""
import sys
from pathlib import Path

KIT = Path(__file__).resolve().parent
WRITTEN_FOR = '/usr/local/share/pdk/gf180mcuD'

def main():
    root = KIT.as_posix()
    pdk = Path(sys.argv[1]).resolve().as_posix() if len(sys.argv) > 1 else None
    changed = 0
    for f in sorted(KIT.rglob('*')):
        if f.suffix not in ('.sch', '.sym'):
            continue
        text = f.read_text()
        new = text.replace('@@ROOT@@', root)
        if pdk:
            new = new.replace(WRITTEN_FOR, pdk)
        if new != text:
            f.write_text(new)
            changed += 1
    sheets = len((KIT / 'files.txt').read_text().split())
    print(f'Kit ready at {root} ({sheets} schematics, {changed} files updated)')
    if pdk:
        print(f'PDK paths now point at {pdk}')

if __name__ == '__main__':
    main()

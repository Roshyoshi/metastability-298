#!/usr/bin/env python3
"""The job of setup.sh for machines without bash, such as Windows:   python setup.py [pdk_dir]

Writes this folder's path into every .sch and .sym file in place of @@ROOT@@. Give pdk_dir (the folder
that holds libs.tech/) to also replace the PDK location the sheets were written for,
/usr/local/share/pdk/gf180mcuD. Line endings are written as plain LF whatever git checked out. Run it
once, on a fresh checkout, and do not commit the result.

In a git checkout, write a copy instead, so that the sheets git tracks keep their placeholders:

    python setup.py --to ../build/xschem [pdk_dir]

The copy is this whole folder with its own path written in. Open the sheets there: bash <copy>/view.sh F04.
"""
import shutil
import sys
from pathlib import Path

KIT = Path(__file__).resolve().parent
WRITTEN_FOR = '/usr/local/share/pdk/gf180mcuD'

def main():
    args = sys.argv[1:]
    kit = KIT
    if args and args[0] == '--to':
        if len(args) < 2:
            sys.exit('usage: setup.py --to <folder> [pdk_dir]')
        kit = Path(args[1]).resolve()
        if kit == KIT or KIT in kit.parents:
            sys.exit(f'{kit} is inside {KIT}: give a folder outside it')
        shutil.copytree(KIT, kit, dirs_exist_ok=True, ignore=shutil.ignore_patterns('svg', '__pycache__'))
        args = args[2:]
    root = kit.as_posix()
    pdk = Path(args[0]).resolve().as_posix() if args else None
    changed = 0
    for f in sorted(kit.rglob('*')):
        if f.suffix not in ('.sch', '.sym'):
            continue
        text = f.read_bytes()
        new = text.replace(b'\r\n', b'\n').replace(b'@@ROOT@@', root.encode())
        if pdk:
            new = new.replace(WRITTEN_FOR.encode(), pdk.encode())
        if new != text:
            f.write_bytes(new)
            changed += 1
    sheets = len((kit / 'files.txt').read_text().split())
    print(f'Kit ready at {root} ({sheets} schematics, {changed} files updated)')
    if pdk:
        print(f'PDK paths now point at {pdk}')

if __name__ == '__main__':
    main()

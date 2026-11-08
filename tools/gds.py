#!/usr/bin/env python3
"""Minimal GDSII reader/writer (pure Python, no dependencies).

Supports what standard-cell libraries and our generated layout use: BOUNDARY, PATH, SREF, AREF, TEXT,
BOX (read only), STRANS/MAG/ANGLE. Coordinates are kept in database units (integers); the library's
UNITS record gives the size of one database unit in metres (GF180 cells: 1 nm, user unit 1 um).
"""
import math, struct, time
from pathlib import Path

REC = {0x00: 'HEADER', 0x01: 'BGNLIB', 0x02: 'LIBNAME', 0x03: 'UNITS', 0x04: 'ENDLIB', 0x05: 'BGNSTR',
       0x06: 'STRNAME', 0x07: 'ENDSTR', 0x08: 'BOUNDARY', 0x09: 'PATH', 0x0A: 'SREF', 0x0B: 'AREF',
       0x0C: 'TEXT', 0x0D: 'LAYER', 0x0E: 'DATATYPE', 0x0F: 'WIDTH', 0x10: 'XY', 0x11: 'ENDEL',
       0x12: 'SNAME', 0x13: 'COLROW', 0x15: 'NODE', 0x16: 'TEXTTYPE', 0x17: 'PRESENTATION', 0x19: 'STRING',
       0x1A: 'STRANS', 0x1B: 'MAG', 0x1C: 'ANGLE', 0x21: 'PATHTYPE', 0x2A: 'NODETYPE', 0x2B: 'PROPATTR',
       0x2C: 'PROPVALUE', 0x2D: 'BOX', 0x2E: 'BOXTYPE', 0x30: 'BGNEXTN', 0x31: 'ENDEXTN'}
CODE = {v: k for k, v in REC.items()}

def _real8_dec(b):
    if b == b'\x00' * 8:
        return 0.0
    sign = -1 if b[0] & 0x80 else 1
    exp = (b[0] & 0x7F) - 64
    mant = int.from_bytes(b[1:], 'big') / float(1 << 56)
    return sign * mant * (16.0 ** exp)

def _real8_enc(x):
    if x == 0:
        return b'\x00' * 8
    sign = 0x80 if x < 0 else 0
    x = abs(x)
    exp = 0
    while x >= 1:
        x /= 16.0; exp += 1
    while x < 1 / 16.0:
        x *= 16.0; exp -= 1
    mant = int(round(x * (1 << 56)))
    if mant >= (1 << 56):
        mant >>= 4; exp += 1
    return bytes([sign | (exp + 64)]) + mant.to_bytes(7, 'big')

class Cell:
    def __init__(self, name):
        self.name = name
        self.polys = []    # (layer, datatype, [(x, y), ...])  closed polygon, last point not repeated
        self.paths = []    # (layer, datatype, width, pathtype, [(x, y), ...])
        self.refs = []     # dict(sname, x, y, mirror, angle, mag)
        self.texts = []    # (layer, texttype, x, y, string, mag)
    def rect(self, layer, dt, x1, y1, x2, y2):
        x1, x2 = sorted((int(round(x1)), int(round(x2)))); y1, y2 = sorted((int(round(y1)), int(round(y2))))
        if x2 > x1 and y2 > y1:
            self.polys.append((layer, dt, [(x1, y1), (x2, y1), (x2, y2), (x1, y2)]))
    def ref(self, sname, x, y, mirror=False, angle=0):
        self.refs.append({'sname': sname, 'x': int(round(x)), 'y': int(round(y)), 'mirror': mirror, 'angle': angle, 'mag': 1.0})
    def text(self, layer, tt, x, y, s, mag=0.1):
        self.texts.append((layer, tt, int(round(x)), int(round(y)), s, mag))

class Library:
    def __init__(self, name='LIB', dbu_m=1e-9, user_unit=1e-3):
        self.name = name; self.dbu_m = dbu_m; self.user_unit = user_unit
        self.cells = {}
    def add(self, cell):
        self.cells[cell.name] = cell
        return cell

def read(path):
    data = Path(path).read_bytes()
    lib = Library()
    pos = 0
    cur = None; el = None
    while pos < len(data):
        n, rt, dt = struct.unpack('>HBB', data[pos:pos + 4])
        body = data[pos + 4:pos + n]
        pos += n
        rec = REC.get(rt, rt)
        if n == 0:
            break
        if rec == 'LIBNAME':
            lib.name = body.rstrip(b'\x00').decode()
        elif rec == 'UNITS':
            lib.user_unit = _real8_dec(body[:8]); lib.dbu_m = _real8_dec(body[8:16])
        elif rec == 'BGNSTR':
            cur = None
        elif rec == 'STRNAME':
            cur = lib.add(Cell(body.rstrip(b'\x00').decode()))
        elif rec in ('BOUNDARY', 'PATH', 'SREF', 'AREF', 'TEXT', 'BOX', 'NODE'):
            el = {'kind': rec, 'mirror': False, 'angle': 0.0, 'mag': 1.0, 'width': 0, 'pathtype': 0}
        elif rec in ('LAYER',):
            el['layer'] = struct.unpack('>h', body)[0]
        elif rec in ('DATATYPE', 'TEXTTYPE', 'BOXTYPE', 'NODETYPE'):
            el['dt'] = struct.unpack('>h', body)[0]
        elif rec == 'WIDTH':
            el['width'] = struct.unpack('>i', body)[0]
        elif rec == 'PATHTYPE':
            el['pathtype'] = struct.unpack('>h', body)[0]
        elif rec == 'XY':
            vals = struct.unpack('>%di' % (len(body) // 4), body)
            el['xy'] = list(zip(vals[0::2], vals[1::2]))
        elif rec == 'SNAME':
            el['sname'] = body.rstrip(b'\x00').decode()
        elif rec == 'COLROW':
            el['colrow'] = struct.unpack('>hh', body)
        elif rec == 'STRANS':
            el['mirror'] = bool(body[0] & 0x80)
        elif rec == 'MAG':
            el['mag'] = _real8_dec(body)
        elif rec == 'ANGLE':
            el['angle'] = _real8_dec(body)
        elif rec == 'STRING':
            el['string'] = body.rstrip(b'\x00').decode(errors='replace')
        elif rec == 'ENDEL':
            k = el['kind']
            if k == 'BOUNDARY' or k == 'BOX':
                pts = el['xy'][:-1] if el['xy'][0] == el['xy'][-1] else el['xy']
                cur.polys.append((el['layer'], el.get('dt', 0), pts))
            elif k == 'PATH':
                cur.paths.append((el['layer'], el.get('dt', 0), el['width'], el['pathtype'], el['xy']))
            elif k == 'SREF':
                x, y = el['xy'][0]
                cur.refs.append({'sname': el['sname'], 'x': x, 'y': y, 'mirror': el['mirror'], 'angle': el['angle'], 'mag': el['mag']})
            elif k == 'AREF':
                (x0, y0), (xc, yc), (xr, yr) = el['xy']
                cols, rows = el['colrow']
                for i in range(cols):
                    for j in range(rows):
                        x = x0 + (xc - x0) * i // cols + (xr - x0) * j // rows
                        y = y0 + (yc - y0) * i // cols + (yr - y0) * j // rows
                        cur.refs.append({'sname': el['sname'], 'x': x, 'y': y, 'mirror': el['mirror'], 'angle': el['angle'], 'mag': el['mag']})
            elif k == 'TEXT':
                x, y = el['xy'][0]
                cur.texts.append((el['layer'], el.get('dt', 0), x, y, el.get('string', ''), el['mag']))
            el = None
    return lib

def _rec(rt, dt, payload=b''):
    n = 4 + len(payload)
    return struct.pack('>HBB', n, CODE[rt], dt) + payload

def _str(s):
    b = s.encode()
    if len(b) % 2:
        b += b'\x00'
    return b

def write(lib, path):
    t = time.localtime()[:6]
    stamp = struct.pack('>12h', *(t + t))
    out = [_rec('HEADER', 2, struct.pack('>h', 600)), _rec('BGNLIB', 2, stamp), _rec('LIBNAME', 6, _str(lib.name)),
           _rec('UNITS', 5, _real8_enc(lib.user_unit) + _real8_enc(lib.dbu_m))]
    for cell in lib.cells.values():
        out += [_rec('BGNSTR', 2, stamp), _rec('STRNAME', 6, _str(cell.name))]
        for layer, dt, pts in cell.polys:
            p = list(pts) + [pts[0]]
            out += [_rec('BOUNDARY', 0), _rec('LAYER', 2, struct.pack('>h', layer)), _rec('DATATYPE', 2, struct.pack('>h', dt)),
                    _rec('XY', 3, struct.pack('>%di' % (2 * len(p)), *[c for xy in p for c in xy])), _rec('ENDEL', 0)]
        for layer, dt, w, pt, pts in cell.paths:
            out += [_rec('PATH', 0), _rec('LAYER', 2, struct.pack('>h', layer)), _rec('DATATYPE', 2, struct.pack('>h', dt)),
                    _rec('PATHTYPE', 2, struct.pack('>h', pt)), _rec('WIDTH', 3, struct.pack('>i', w)),
                    _rec('XY', 3, struct.pack('>%di' % (2 * len(pts)), *[c for xy in pts for c in xy])), _rec('ENDEL', 0)]
        for r in cell.refs:
            out += [_rec('SREF', 0), _rec('SNAME', 6, _str(r['sname']))]
            if r['mirror'] or r['angle'] or r.get('mag', 1.0) != 1.0:
                out.append(_rec('STRANS', 1, struct.pack('>H', 0x8000 if r['mirror'] else 0)))
                if r['angle']:
                    out.append(_rec('ANGLE', 5, _real8_enc(float(r['angle']))))
            out += [_rec('XY', 3, struct.pack('>2i', r['x'], r['y'])), _rec('ENDEL', 0)]
        for layer, tt, x, y, s, mag in cell.texts:
            out += [_rec('TEXT', 0), _rec('LAYER', 2, struct.pack('>h', layer)), _rec('TEXTTYPE', 2, struct.pack('>h', tt)),
                    _rec('STRANS', 1, struct.pack('>H', 0)), _rec('MAG', 5, _real8_enc(mag)),
                    _rec('XY', 3, struct.pack('>2i', x, y)), _rec('STRING', 6, _str(s)), _rec('ENDEL', 0)]
        out.append(_rec('ENDSTR', 0))
    out.append(_rec('ENDLIB', 0))
    Path(path).write_bytes(b''.join(out))

def transform(pts, ref):
    """Apply an SREF transform (mirror about x first, then rotate, then translate)."""
    a = math.radians(ref['angle'])
    ca, sa = round(math.cos(a)), round(math.sin(a))
    res = []
    for x, y in pts:
        if ref['mirror']:
            y = -y
        x2, y2 = x * ca - y * sa, x * sa + y * ca
        res.append((x2 + ref['x'], y2 + ref['y']))
    return res

def flatten(lib, top, layers=None):
    """All polygons of `top` in top coordinates: list of (layer, dt, pts). Paths are converted to rectangles
    when they are Manhattan two-point segments (enough for standard cells)."""
    out = []
    def walk(name, chain):
        c = lib.cells[name]
        for layer, dt, pts in c.polys:
            if layers is None or (layer, dt) in layers:
                p = pts
                for r in reversed(chain):
                    p = transform(p, r)
                out.append((layer, dt, p))
        for layer, dt, w, pt, pts in c.paths:
            if layers is not None and (layer, dt) not in layers:
                continue
            for (x1, y1), (x2, y2) in zip(pts[:-1], pts[1:]):
                h = w // 2; ext = h if pt == 2 else 0
                if y1 == y2:
                    rect = [(min(x1, x2) - ext, y1 - h), (max(x1, x2) + ext, y1 - h), (max(x1, x2) + ext, y1 + h), (min(x1, x2) - ext, y1 + h)]
                else:
                    rect = [(x1 - h, min(y1, y2) - ext), (x1 + h, min(y1, y2) - ext), (x1 + h, max(y1, y2) + ext), (x1 - h, max(y1, y2) + ext)]
                p = rect
                for r in reversed(chain):
                    p = transform(p, r)
                out.append((layer, dt, p))
        for r in c.refs:
            if r['sname'] in lib.cells:
                walk(r['sname'], chain + [r])
    walk(top, [])
    return out

def bbox(pts):
    xs = [p[0] for p in pts]; ys = [p[1] for p in pts]
    return min(xs), min(ys), max(xs), max(ys)

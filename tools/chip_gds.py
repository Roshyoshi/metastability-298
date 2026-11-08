#!/usr/bin/env python3
"""Turn the placement and routing plan into GDS, then check it.

Outputs layout/:
  tt_um_metastability_characterizer.gds   full tile (cells included)
  layout_plan.json                         rows, channels, tracks (for the document and the run scripts)
"""
import sys, json, math
from collections import defaultdict
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import layout_gen as LG
import route_gen as RG
import gds
from layout_gen import L, R, EXT, HW, HV, EPS, ROWH, nm

TOP = 'tt_um_metastability_characterizer'
OUT = LG.CHIP / 'layout'
TOP_Y = 323.6           # top of the top channel (template pins start at 324.36)
STRIPE_Y0 = 5.0         # power stripes start here (TT analog spec: y <= 10)
STRIPE_Y1 = 320.36      # and end here (spec: y >= 315.36), lower where a pin drop sits over a stripe
PAD = 0.22              # half size of the Metal2/Metal3 landing pads in the rail Via stacks (0.44 x 0.44)

class Shapes:
    """Rectangles per layer with the net each one belongs to (um)."""
    def __init__(self):
        self.r = defaultdict(list)     # layer -> [(x1, y1, x2, y2, net)]
    def add(self, layer, x1, y1, x2, y2, net):
        x1, x2 = sorted((x1, x2)); y1, y2 = sorted((y1, y2))
        self.r[layer].append((round(x1, 4), round(y1, 4), round(x2, 4), round(y2, 4), net))
    def via(self, vlayer, x, y, net):
        self.add(vlayer, x - HV, y - HV, x + HV, y + HV, net)

def build():
    P = RG.route()
    nrows = P['nrows']
    ch = P['chans']
    # vertical layout: channel heights from their track counts
    heights = {c: 2 * RG.TRACK0 + RG.PITCH * (ch[c]['ntr'] - 1) for c in ch}
    total = sum(heights.values()) + nrows * ROWH
    y = TOP_Y - total
    ych, yrow = {}, {}
    for c in range(nrows + 1):
        ych[c] = y; y += heights[c]
        if c < nrows:
            yrow[c] = y; y += ROWH
    def track_y(c, net):
        lvl = ch[c]['level'][net]
        k = ch[c]['ntr'] - 1 - lvl
        return round(ych[c] + RG.TRACK0 + RG.PITCH * k, 4)
    S = Shapes()
    # ---- escapes, Via1, Via2 (the terminal's sub-net for split nets)
    def subnet(c, net, side):
        if net in ch[c]['level']:
            return net
        return net + ('#B' if side == 'B' else '#T')
    for (iname, pin), (r, x, yrel, d, net) in P['access'].items():
        c = r + 1 if d == 'up' else r
        if net not in P['term'][c] and net + '#T' not in ch[c]['level']:
            continue                                   # single-pin net: nothing to connect
        side = 'B' if d == 'up' else 'T'
        sn = subnet(c, net, side)
        yv = yrow[r] + yrel
        ty = track_y(c, sn)
        S.via('V1', x, yv, net)
        if d == 'up':
            S.add('M2', x - HW, yv - EXT, x + HW, ty + EXT, net)
        else:
            S.add('M2', x - HW, ty - EXT, x + HW, yv + EXT, net)
        S.via('V2', x, ty, net)
    # ---- trunks and Via3
    for c, chd in ch.items():
        for sn, terms in chd['nets'].items():
            net = sn.split('#')[0]
            ty = track_y(c, sn)
            xa, xb = RG.trunk_x([x for x, s, i in terms])
            S.add('M3', xa, ty - HW, xb, ty + HW, net)
            for x, s, info in terms:
                if s == 'F':
                    S.via('V3', x, ty, net)
    # ---- Metal4: feedthrough columns, jumpers, pins
    for net, (x, lo, hi) in P['ft'].items():
        ys = [track_y(c, sn) for c in range(lo, hi + 1) for sn in ch[c]['level'] if sn.split('#')[0] == net
              and any(t[1] == 'F' and t[2][0] == 'ft' and abs(t[0] - x) < EPS for t in ch[c]['nets'][sn])]
        S.add('M4', x - HW, min(ys) - EXT, x + HW, max(ys) + EXT, net)
    for c, xj, a, b in P['jumpers']:
        ya, yb = track_y(c, a), track_y(c, b)
        S.add('M4', xj - HW, min(ya, yb) - EXT, xj + HW, max(ya, yb) + EXT, a.split('#')[0])
    pins_drawn = []
    for pin, net in P['chip_pin_nets'].items():
        x1, y1, x2, y2, d = P['tp'][pin]
        xc = (x1 + x2) / 2
        if pin == 'ua[0]':
            ty = track_y(0, net)
            S.add('M4', xc - 0.3, y2 - 0.1, xc + 0.3, ty + EXT, net)
        else:
            ty = track_y(nrows, net if net in ch[nrows]['level'] else net + '#T')
            S.add('M4', x1, ty - EXT, x2, y1 + 0.1, net)
        S.add('M4', x1, y1, x2, y2, net)
        pins_drawn.append((pin, net, (x1, y1, x2, y2)))
    # every template pin is drawn (the precheck compares the pin set with the template); unused ones are open
    for pin, (x1, y1, x2, y2, d) in P['tp'].items():
        if pin not in P['chip_pin_nets']:
            S.add('M4', x1, y1, x2, y2, pin)
            pins_drawn.append((pin, pin, (x1, y1, x2, y2)))
    # ---- power stripes and rail Via stacks
    # stripes run from y = 5 to y = 320.36 (the TT analog spec asks for y <= 10 and y >= 315.36); where a used
    # pin's Metal4 drop sits over a stripe, that stripe stops 0.28 um below the drop (the router puts such a
    # net on a high track of the top channel, so the stop is still above 315.36)
    stripe_top = {}
    for xa, xb, net in LG.STRIPES:
        top = STRIPE_Y1
        for pin, pnet in P['chip_pin_nets'].items():
            x1, y1, x2, y2, d = P['tp'][pin]
            if pin != 'ua[0]' and x2 > xa - 0.28 and x1 < xb + 0.28:
                ty = track_y(nrows, pnet if pnet in ch[nrows]['level'] else pnet + '#T')
                top = min(top, round(ty - EXT - 0.28, 3))
        assert top >= 315.36, (xa, net, top)
        stripe_top[(xa, xb, net)] = top
        S.add('M4', xa, STRIPE_Y0, xb, top, net)
    y_stripe_top = min(stripe_top.values())
    rails = []
    for r, items in enumerate(P['placed']):
        x0 = items[0][0]; x1 = items[-1][0] + 1.12
        yb = yrow[r]
        rails.append((r, x0, x1, yb))
        for xa, xb, net in LG.STRIPES:
            if xa > x0 + 1 and xb < x1 - 1:
                yr = yb + ROWH if net == 'VDPWR' else yb
                for xs in ((xa + xb) / 2 - 0.5, (xa + xb) / 2 + 0.5):
                    S.via('V1', xs, yr, net)
                    S.add('M2', xs - PAD, yr - PAD, xs + PAD, yr + PAD, net)
                    S.via('V2', xs, yr, net)
                    S.add('M3', xs - PAD, yr - PAD, xs + PAD, yr + PAD, net)
                    S.via('V3', xs, yr, net)
    # ---- delay line: Metal1 strap from the stage output (slow) to the first restorer input
    for r, items in enumerate(P['placed']):
        for k, (x, cell, inst) in enumerate(items):
            if cell == 'meta_dly_cs':
                xr0 = items[k + 1][0]
                S.add('M1', x + 2.945, yrow[r] + 1.55, xr0 + 0.71 + 0.1, yrow[r] + 1.85, inst['conns']['slow'])
    P.update(ych=ych, yrow=yrow, heights=heights, shapes=S, pins_drawn=pins_drawn, rails=rails, y_stripe_top=y_stripe_top, stripe_top=stripe_top)
    return P

def write(P):
    OUT.mkdir(exist_ok=True)
    lib = gds.Library('metastability', dbu_m=1e-9, user_unit=1e-3)
    used = sorted({c for items in P['placed'] for x, c, i in items})
    for c in used:
        if c == 'meta_dly_cs':
            lib.add(LG.build_dly_cell())
            continue
        src = gds.read(LG.LP.cell_dir(c) / f'{LG.LIB}{c}.gds')
        for name, cell in src.cells.items():
            lib.add(cell)
    top = lib.add(gds.Cell(TOP))
    for r, items in enumerate(P['placed']):
        for x, c, inst in items:
            top.ref(c if c == 'meta_dly_cs' else LG.LIB + c, nm(x), nm(P['yrow'][r]))
    for layer, rects in P['shapes'].r.items():
        for x1, y1, x2, y2, net in rects:
            top.rect(*L[layer], nm(x1), nm(y1), nm(x2), nm(y2))
    top.rect(*L['PRBND'], 0, 0, nm(LG.TILE_W), nm(LG.TILE_H))
    # pins: the GF180 precheck wants each LEF port covered by a Metal4_Label (46/10) polygon, plus the text label
    for pin, net, (x1, y1, x2, y2) in P['pins_drawn']:
        top.rect(*L['M4L'], nm(x1), nm(y1), nm(x2), nm(y2))
        top.text(*L['M4L'], nm((x1 + x2) / 2), nm((y1 + y2) / 2), pin, 0.25)
    for (xa, xb, net), yt in P['stripe_top'].items():
        top.rect(*L['M4L'], nm(xa), nm(STRIPE_Y0), nm(xb), nm(yt))
        top.text(*L['M4L'], nm((xa + xb) / 2), nm(60.0), net, 0.5)
    path = OUT / f'{TOP}.gds'
    gds.write(lib, path)
    write_lef(P)
    write_verilog(P)
    plan = {'rows': [{'name': P['rows'][r][0], 'y': P['yrow'][r], 'x0': P['placed'][r][0][0], 'x1': P['placed'][r][-1][0] + 1.12,
                      'cells': [(x, c, i['name'] if i else None) for x, c, i in P['placed'][r]]} for r in range(P['nrows'])],
            'channels': {c: {'y': P['ych'][c], 'h': P['heights'][c], 'tracks': P['chans'][c]['ntr'], 'nets': len(P['chans'][c]['nets'])} for c in P['chans']},
            'feedthroughs': len(P['ft']), 'jumpers': len(P['jumpers']), 'stripes': LG.STRIPES}
    (OUT / 'layout_plan.json').write_text(json.dumps(plan, indent=1))
    return path

def write_lef(P):
    """Abstract for the Tiny Tapeout flow: template pins (exact template rectangles), power stripes as
    VDPWR/VGND ports, the routed area as obstruction on Metal1-Metal4."""
    f = lambda v: f'{v:.3f}'.rstrip('0').rstrip('.') if '.' in f'{v:.3f}' else f'{v}'
    L_ = ['VERSION 5.7 ;', 'BUSBITCHARS "[]" ;', 'DIVIDERCHAR "/" ;', '', f'MACRO {TOP}',
          '  CLASS BLOCK ;', f'  FOREIGN {TOP} ;', '  ORIGIN 0.000 0.000 ;', f'  SIZE {LG.TILE_W:.3f} BY {LG.TILE_H:.3f} ;']
    for pin, net, (x1, y1, x2, y2) in sorted(P['pins_drawn']):
        d = P['tp'][pin][4]
        use = 'ANALOG' if pin.startswith('ua[') else 'SIGNAL'
        L_ += [f'  PIN {pin}', f'    DIRECTION {d} ;', f'    USE {use} ;', '    PORT', '      LAYER Metal4 ;',
               f'        RECT {x1:.3f} {y1:.3f} {x2:.3f} {y2:.3f} ;', '    END', f'  END {pin}']
    for net, use in (('VDPWR', 'POWER'), ('VGND', 'GROUND')):
        L_ += [f'  PIN {net}', '    DIRECTION INOUT ;', f'    USE {use} ;', '    PORT', '      LAYER Metal4 ;']
        for (xa, xb, n), yt in P['stripe_top'].items():
            if n == net:
                L_.append(f'        RECT {xa:.3f} {STRIPE_Y0:.3f} {xb:.3f} {yt:.3f} ;')
        L_ += ['    END', f'  END {net}']
    y0 = round(P['ych'][0], 3)
    L_ += ['  OBS']
    for lay in ('Metal1', 'Metal2', 'Metal3'):
        L_ += [f'    LAYER {lay} ;', f'      RECT {LG.X_LEFT - 1:.3f} {y0:.3f} {LG.TILE_W - 1:.3f} {TOP_Y:.3f} ;']
    L_ += ['  END', f'END {TOP}', '', 'END LIBRARY', '']
    (OUT / f'{TOP}.lef').write_text('\n'.join(L_))

def write_verilog(P):
    """Black-box module with the template ports and the power pins (the precheck looks for VDPWR/VGND)."""
    v = f"""// Black box of the analog tile; the layout is {TOP}.gds
`default_nettype none
module {TOP} (
    input  wire       VGND,
    input  wire       VDPWR,
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    inout  wire [7:0] ua,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);
endmodule
"""
    (OUT / f'{TOP}.v').write_text(v)

if __name__ == '__main__':
    P = build()
    p = write(P)
    S = P['shapes']
    print(p, {k: len(v) for k, v in S.r.items()})
    print('core y range', round(P['ych'][0], 2), '..', TOP_Y)

#!/usr/bin/env python3
"""Pictures of the generated layout (dark background, layer colours close to KLayout's defaults).

layout/renders/
  tile.png            whole 1x2 tile: rows, channels, stripes, pins
  frontend_row.png    row F1: monitors, data buffers, DUT1, selector, early observer, capture drivers, delay line
  delay_line.png      the delay line at transistor level: MC, MN, MP, MCT, restorers, antenna cell
  dut_row.png         row u_dut2: one NAND flip-flop (9 cells)
  controller_row.png  a stretch of controller row C1
"""
import sys
from collections import defaultdict
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.collections import PolyCollection
import chip_gds as CG
import layout_gen as LG
import gds

OUT = LG.CHIP / 'layout' / 'renders'
BG = '#101418'
STYLE = [  # (layer, datatype, face, alpha, edge)
    ((21, 0), '#2e7d32', 0.10, '#4caf50'),    # Nwell
    ((22, 0), '#43a047', 0.55, '#66bb6a'),    # COMP (diffusion)
    ((30, 0), '#e53935', 0.65, '#ff5252'),    # Poly
    ((33, 0), '#fafafa', 0.95, None),         # Contact
    ((34, 0), '#1e88e5', 0.45, '#64b5f6'),    # Metal1
    ((35, 0), '#80deea', 0.95, None),         # Via1
    ((36, 0), '#d81b60', 0.45, '#f06292'),    # Metal2
    ((38, 0), '#fff176', 0.95, None),         # Via2
    ((42, 0), '#fb8c00', 0.45, '#ffb74d'),    # Metal3
    ((40, 0), '#ffffff', 0.95, None),         # Via3
    ((46, 0), '#26c6da', 0.25, '#80deea'),    # Metal4
]
NAMES = {(21, 0): 'n-well', (22, 0): 'diffusion (COMP)', (30, 0): 'poly (gates)', (33, 0): 'contact', (34, 0): 'Metal1',
         (35, 0): 'Via1', (36, 0): 'Metal2', (38, 0): 'Via2', (42, 0): 'Metal3', (40, 0): 'Via3', (46, 0): 'Metal4'}

def load():
    P = CG.build()
    lib = gds.Library('r')
    for c in sorted({c for items in P['placed'] for x, c, i in items}):
        if c == 'meta_dly_cs':
            lib.add(LG.build_dly_cell())
        else:
            for n, cell in gds.read(LG.LP.cell_dir(c) / f'{LG.LIB}{c}.gds').cells.items():
                lib.add(cell)
    cellpolys = {}
    def polys_of(name):
        if name not in cellpolys:
            cellpolys[name] = [(l, d, [(x / 1000, y / 1000) for x, y in p]) for l, d, p in gds.flatten(lib, name)]
        return cellpolys[name]
    return P, polys_of

def draw(P, polys_of, window, path, title, labels=(), layers=None, figw=14, notes=(), cell_names=True, legend=True):
    x0, y0, x1, y1 = window
    by = defaultdict(list)
    for r, items in enumerate(P['placed']):
        yb = P['yrow'][r]
        if yb > y1 or yb + LG.ROWH < y0:
            continue
        for x, c, inst in items:
            w = LG.lef(c)['w']
            if x > x1 or x + w < x0:
                continue
            name = c if c == 'meta_dly_cs' else LG.LIB + c
            for l, d, pts in polys_of(name):
                by[(l, d)].append([(px + x, py + yb) for px, py in pts])
    for layer, rects in P['shapes'].r.items():
        ld = LG.L[layer]
        for a, b, c, e, net in rects:
            if c < x0 or a > x1 or e < y0 or b > y1:
                continue
            by[ld].append([(a, b), (c, b), (c, e), (a, e)])
    for pin, net, (a, b, c, e) in P['pins_drawn']:
        by[(46, 0)].append([(a, b), (c, b), (c, e), (a, e)])
    h = figw * (y1 - y0) / (x1 - x0)
    fig, ax = plt.subplots(figsize=(figw, max(3.0, h + 1.2)), dpi=150)
    fig.patch.set_facecolor(BG); ax.set_facecolor(BG)
    shown = []
    for ld, face, alpha, edge in STYLE:
        if layers and ld not in layers:
            continue
        ps = by.get(ld, [])
        if not ps:
            continue
        ax.add_collection(PolyCollection(ps, facecolors=face, alpha=alpha, edgecolors=edge or face, linewidths=0.3))
        shown.append(ld)
    if cell_names:
        for r, items in enumerate(P['placed']):
            yb = P['yrow'][r]
            if yb > y1 or yb + LG.ROWH < y0:
                continue
            for x, c, inst in items:
                w = LG.lef(c)['w']
                if x > x1 or x + w < x0 or inst is None:
                    continue
                ax.add_patch(plt.Rectangle((x, yb), w, LG.ROWH, fill=False, ec='#b0bec5', lw=0.5, ls='--'))
                if cell_names == 'full':
                    labeled = [i_ for x_, c_, i_ in items if i_ is not None]
                    stag = 2.0 if (w < 2.6 and labeled.index(inst) % 2) else 0.0      # a narrow cell's label goes a line pair up
                    nm_ = inst['name'].split('/')[-1].replace('monitor_', 'mon_')
                    ax.text(x + w / 2, yb + LG.ROWH + 0.45 + stag, nm_ + '\n' + c, color='#eceff1',
                            fontsize=6.5, ha='center', va='bottom',
                            bbox=dict(boxstyle='round,pad=0.12', fc='#000000', ec='none', alpha=0.7))
    for (x, y, s, kw) in labels:
        ax.annotate(s, (x, y), color=kw.get('color', '#ffffff'), fontsize=kw.get('size', 8), ha=kw.get('ha', 'center'),
                    va=kw.get('va', 'center'), xytext=kw.get('xytext'), textcoords='data',
                    arrowprops=dict(arrowstyle='-', color='#ffffff', lw=0.6) if kw.get('xytext') else None,
                    bbox=dict(boxstyle='round,pad=0.15', fc='#000000', ec='none', alpha=0.55) if kw.get('box', True) else None)
    ax.set_xlim(x0, x1); ax.set_ylim(y0, y1); ax.set_aspect('equal')
    ax.tick_params(colors='#90a4ae', labelsize=7)
    for s_ in ax.spines.values():
        s_.set_color('#455a64')
    ax.set_xlabel('x (um)', color='#90a4ae', fontsize=8); ax.set_ylabel('y (um)', color='#90a4ae', fontsize=8)
    ax.set_title(title, color='#eceff1', fontsize=10, loc='left')
    # The notes and the legend go in a strip along the bottom, measured in inches so that they clear the
    # x axis label whatever the height of the figure.
    figh = fig.get_figheight()
    strip = 0.08 + 0.18 * len(notes)
    if legend:
        handles = [plt.Rectangle((0, 0), 1, 1, fc=f, alpha=min(1, a + 0.3), ec=e or f) for ld, f, a, e in STYLE if ld in shown]
        fig.legend(handles, [NAMES[ld] for ld in shown], loc='lower center', bbox_to_anchor=(0.5, strip / figh),
                   ncol=len(shown), fontsize=7, frameon=False, labelcolor='#cfd8dc')
        strip += 0.28
    for k, n in enumerate(notes):
        fig.text(0.01, (0.08 + 0.18 * k) / figh, n, color='#90a4ae', fontsize=7)
    fig.tight_layout(rect=(0, strip / figh, 1, 1))
    fig.savefig(path, facecolor=BG)
    plt.close(fig)

def main():
    OUT.mkdir(parents=True, exist_ok=True)
    P, polys_of = load()
    rows = {name: r for r, (name, cells) in enumerate(P['rows'])}
    # ---- whole tile
    labels = []
    for r, (name, cells) in enumerate(P['rows']):
        yb = P['yrow'][r]
        what = {'F1': 'F1  front end + delay line', 'u_dut2': 'DUT2 baseline NAND flip-flop', 'u_dut3': 'DUT3 keeper x2',
                'u_dut4': 'DUT4 forward x2', 'P1': 'P1  pin drivers'}.get(name, f'{name}  controller')
        labels.append((P['placed'][r][0][0] - 1.5, yb + 1.96, what, {'ha': 'right', 'size': 6.5, 'box': False, 'color': '#cfd8dc'}))
    labels += [(327.32, 8, 'ua[0]\n(delay control)', {'size': 7}), (190, 327.0, 'digital pins (Metal4, top edge)', {'size': 7, 'box': False}),
               (156, 2.5, 'VDPWR / VGND stripes (Metal4)', {'size': 7, 'ha': 'left'})]
    draw(P, polys_of, (-2, -2, LG.TILE_W + 2, LG.TILE_H + 4), OUT / 'tile.png',
         'tt_um_metastability_characterizer: the whole 1x2 tile (346.64 x 325.36 um, GF180MCU)', labels,
         layers={(34, 0), (36, 0), (42, 0), (46, 0), (22, 0), (30, 0)}, figw=12, cell_names=False,
         notes=['Rows of standard cells (3.92 um tall) with routing channels between them: Metal2 escapes, Metal3 trunks, '
                'Metal4 columns and the power stripes.'])
    # ---- front-end row
    r = rows['F1']; yb = P['yrow'][r]
    xs = [x for x, c, i in P['placed'][r] if i is not None]
    draw(P, polys_of, (min(xs) - 2, yb - 3, max(xs) + 8, yb + LG.ROWH + 5.5), OUT / 'frontend_row.png',
         'Row F1: clock monitors, data buffers, DUT1 (library flip-flop), selector, early observer, capture drivers, delay line',
         figw=18, cell_names='full')
    # ---- delay line close-up
    items = P['placed'][r]
    k = next(k for k, (x, c, i) in enumerate(items) if c == 'meta_dly_cs')
    xd = items[k][0]
    xa = items[k - 1][0] if items[k - 1][1] == 'antenna' else xd
    xe = items[k + 3][0] + LG.lef(items[k + 3][1])['w']
    lab = [(xd + 1.26, yb + 0.52, 'MC\nstarving NMOS\n0.36/0.6', {'xytext': (xd + 0.9, yb - 1.6), 'size': 7}),
           (xd + 2.6, yb + 0.75, 'MN\n0.82/0.6', {'xytext': (xd + 2.6, yb - 1.6), 'size': 7}),
           (xd + 2.55, yb + 2.97, 'MP\n1.22/0.5', {'xytext': (xd + 2.55, yb + LG.ROWH + 1.6), 'size': 7}),
           (xd + 4.98, yb + 0.75, 'MCT timing capacitor\nNMOS gate, 0.82/1.0', {'xytext': (xd + 5.0, yb - 1.6), 'size': 7}),
           (xd + 3.11, yb + 1.95, 'slow', {'size': 7, 'xytext': (xd + 3.9, yb + LG.ROWH + 1.6)}),
           (xd + 1.26, yb + 1.53, 'control\n(ua[0])', {'size': 7, 'xytext': (xd + 0.6, yb + LG.ROWH + 1.6)}),
           (xd + 2.55, yb + 1.7, 'launch', {'size': 7, 'xytext': (xd + 1.9, yb + LG.ROWH + 1.0)})]
    if xa != xd:
        lab.append((xa + 0.3, yb + 1.8, 'antenna\ndiodes', {'size': 7, 'xytext': (xa - 0.6, yb - 1.6)}))
    lab += [(items[k + 1][0] + 1.1, yb + 1.96, 'XR0', {'size': 7, 'box': True}),
            (items[k + 2][0] + 1.4, yb + 1.96, 'XR1', {'size': 7}), (items[k + 3][0] + 1.4, yb + 1.96, 'XR2', {'size': 7})]
    draw(P, polys_of, (xa - 1.5, yb - 2.6, xe + 1, yb + LG.ROWH + 2.6), OUT / 'delay_line.png',
         'Delay line at transistor level: current-starved stage (custom cell meta_dly_cs) + three restoring inverters',
         lab, layers={(21, 0), (22, 0), (30, 0), (33, 0), (34, 0), (35, 0), (36, 0)}, figw=14, cell_names=True,
         notes=['Green = diffusion, red = poly; a transistor is where poly crosses diffusion (W = diffusion height, '
                'L = poly width). White squares = contacts.'])
    # ---- one DUT row
    r = rows['u_dut2']; yb = P['yrow'][r]
    xs = [x for x, c, i in P['placed'][r] if i is not None]
    xe = max(x + LG.lef(c)['w'] for x, c, i in P['placed'][r] if i is not None)
    draw(P, polys_of, (min(xs) - 1, yb - 2.5, xe + 1, yb + LG.ROWH + 3.2), OUT / 'dut_row.png',
         'Row u_dut2: the baseline NAND flip-flop (clock inverter, master door, master latch, slave door, slave latch)',
         layers={(21, 0), (22, 0), (30, 0), (33, 0), (34, 0), (35, 0), (36, 0)}, figw=16, cell_names='full')
    # ---- controller stretch
    r = rows['C1']; yb = P['yrow'][r]
    xs = [x for x, c, i in P['placed'][r] if i is not None]
    draw(P, polys_of, (min(xs) - 1, yb - 3, min(xs) + 40, yb + LG.ROWH + 3.5), OUT / 'controller_row.png',
         'Controller row C1 (first 40 um): cells of compact_control, with Metal2 up to the Metal3 tracks in the channels',
         layers={(22, 0), (30, 0), (33, 0), (34, 0), (35, 0), (36, 0), (38, 0), (42, 0)}, figw=16, cell_names='full')
    print(sorted(p.name for p in OUT.glob('*.png')))

if __name__ == '__main__':
    main()

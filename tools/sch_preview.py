#!/usr/bin/env python3
"""Render a Scene (from xschem_gen) to PNG/PDF with matplotlib, in black and white.

This is a preview of what Xschem will draw from the same .sch file: same placement,
same symbols, same labels. The authoritative pictures are the Xschem exports/screenshots.
"""
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle, Polygon, Circle

K = '#000000'
GREY = '#555555'

def _mos(ax, x, y, kind, name, W, L):
    lw = 1.1
    # gate lead and plate
    ax.plot([x - 20, x - 9], [y, y], color=K, lw=lw)
    if kind == 'pfet':
        ax.add_patch(Circle((x - 11, y), 2.2, fill=False, ec=K, lw=lw))
        ax.plot([x - 20, x - 13.5], [y, y], color=K, lw=lw)
    ax.plot([x - 8, x - 8], [y - 14, y + 14], color=K, lw=lw)
    ax.plot([x - 3, x - 3], [y - 18, y + 18], color=K, lw=2.0)
    # drain/source leads to the pin points (x+20, y-30) and (x+20, y+30)
    ax.plot([x - 3, x + 20, x + 20], [y - 14, y - 14, y - 30], color=K, lw=lw)
    ax.plot([x - 3, x + 20, x + 20], [y + 14, y + 14, y + 30], color=K, lw=lw)
    # bulk
    ax.plot([x - 3, x + 20], [y, y], color=K, lw=0.8)
    if kind == 'nfet':
        ax.add_patch(Polygon([[x + 1, y], [x + 7, y - 3.5], [x + 7, y + 3.5]], closed=True, color=K))
    else:
        ax.add_patch(Polygon([[x + 13, y], [x + 7, y - 3.5], [x + 7, y + 3.5]], closed=True, color=K))
    ax.text(x - 22, y - 26, name, fontsize=5.6, ha='right', va='center', color=K)
    ax.text(x - 22, y + 26, f'{W:.3g}/{L:.3g}', fontsize=5.0, ha='right', va='center', color=GREY)

def _box(ax, x, y, ins, outs, w, title, iname):
    n = max(len(ins), len(outs)); h = 20 * n + 20; top = -h // 2
    ax.add_patch(Rectangle((x - w, y + top), 2 * w, h, fill=False, ec=K, lw=1.1))
    for i, p in enumerate(ins):
        yy = y + top + 20 + 20 * i
        ax.plot([x - w - 20, x - w], [yy, yy], color=K, lw=1.0)
        ax.text(x - w + 3, yy, p, fontsize=5.0, ha='left', va='center', color=K)
    for i, p in enumerate(outs):
        yy = y + top + 20 + 20 * i
        ax.plot([x + w, x + w + 20], [yy, yy], color=K, lw=1.0)
        ax.text(x + w - 3, yy, p, fontsize=5.0, ha='right', va='center', color=K)
    ax.text(x - w, y + top - 6, title, fontsize=6.2, ha='left', va='bottom', color=K, fontweight='bold')
    ax.text(x - w, y + top + h + 6, iname, fontsize=5.0, ha='left', va='top', color=GREY)

def render(scene, path, scale=0.012, maxw=26, maxh=40):
    xs, ys = [], []
    for it in scene.items:
        if it[0] in ('lab', 'pin'):
            xs.append(it[1] if it[0] == 'lab' else it[2]); ys.append(it[2] if it[0] == 'lab' else it[3])
        elif it[0] == 'inst':
            xs.append(it[2]); ys.append(it[3])
        elif it[0] == 'text':
            xs.append(it[2]); ys.append(it[3])
    x0, x1 = min(xs) - 140, max(xs) + 160
    y0, y1 = min(ys) - 60, max(ys) + 80
    wid = min(maxw, max(6, (x1 - x0) * scale)); hei = min(maxh, max(3, (y1 - y0) * scale))
    fig, ax = plt.subplots(figsize=(wid, hei))
    ax.set_xlim(x0, x1); ax.set_ylim(y1, y0); ax.set_aspect('equal'); ax.axis('off')
    for it in scene.items:
        if it[0] == 'text':
            _, s, x, y, size = it
            ax.text(x, y, s, fontsize=4 + 14 * size, ha='left', va='bottom', color=K,
                    fontweight='bold' if size >= 0.35 else 'normal')
        elif it[0] == 'lab':
            _, x, y, flip, net, nm = it
            ax.plot([x], [y], marker='s', ms=1.6, color=K)
            ax.text(x + (4 if flip else -4), y - 2, net, fontsize=5.2, ha='left' if flip else 'right', va='bottom', color=K)
        elif it[0] == 'pin':
            _, kind, x, y, net, nm = it
            if kind == 'ipin':
                ax.add_patch(Polygon([[x - 26, y - 5], [x - 8, y - 5], [x, y], [x - 8, y + 5], [x - 26, y + 5]], closed=True, fill=False, ec=K, lw=0.9))
                ax.text(x - 30, y, net, fontsize=5.6, ha='right', va='center', color=K)
            else:
                ax.add_patch(Polygon([[x, y - 5], [x + 18, y - 5], [x + 26, y], [x + 18, y + 5], [x, y + 5]], closed=True, fill=False, ec=K, lw=0.9))
                ax.text(x + 30, y, net, fontsize=5.6, ha='left', va='center', color=K)
        elif it[0] == 'inst':
            _, sym, x, y, rot, flip, attrs, kind = it
            if kind[0] == 'mos':
                _mos(ax, x, y, kind[1], kind[2], kind[3], kind[4])
            elif kind[0] == 'box':
                _, k, ref, ins, outs, w, iname = kind
                _box(ax, x, y, ins, outs, w, ref, 'x' + str(iname).strip('_'))
            elif kind[0] == 'cap':
                ax.plot([x, x], [y - 30, y - 4], color=K, lw=1); ax.plot([x, x], [y + 4, y + 30], color=K, lw=1)
                ax.plot([x - 12, x + 12], [y - 4, y - 4], color=K, lw=1.6); ax.plot([x - 12, x + 12], [y + 4, y + 4], color=K, lw=1.6)
                ax.text(x + 16, y, kind[1] + 'F', fontsize=5.5, va='center', color=K)
    fig.savefig(path, dpi=200, bbox_inches='tight', facecolor='white')
    plt.close(fig)

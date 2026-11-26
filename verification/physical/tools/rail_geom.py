"""Rails and cell placements for the supply model.
usage: rail_geom.py <gds> <top .ext from Magic> <supply_geom.json> <out json>
For every Metal1 rail polygon of VDPWR and VGND: the width of the bare rail (smallest height of Metal1 in a vertical
cut through the polygon, taken every 0.28 um), the via stacks on it. For every instance of the top cell: its
bounding box (from the GDS cell and the transform in the .ext file) and the rail of each supply it sits on."""
import sys, json, re, klayout.db as kdb
gds, ext, geom, out = sys.argv[1:5]
ly = kdb.Layout(); ly.read(gds); top = ly.top_cell(); dbu = ly.dbu
G = json.load(open(geom))
def poly(p): return kdb.Polygon([kdb.Point(round(x / dbu), round(y / dbu)) for x, y in p["hull"]])
rails = {}
for net in ("VDPWR", "VGND"):
    rails[net] = []
    for p in sorted(G[net]["M1"], key=lambda p: p["bbox"][1]):
        pg = kdb.Region(poly(p)); x0, y0, x1, y1 = p["bbox"]
        hs = []; x = x0 + 0.14
        while x < x1 - 0.14:
            cut = pg & kdb.Region(kdb.DBox(x - 0.005, y0 - 1, x + 0.005, y1 + 1).to_itype(dbu))
            h = sorted((c.bbox().bottom * dbu, c.bbox().top * dbu) for c in cut.each())
            hs.append((round(sum(b - a for a, b in h), 3), x, h))
            x += 0.28
        wmin = min(hs)
        # the strip common to every cut: the rail itself
        lo = max(min(a for a, b in h) for _, _, h in hs if h); hi = None
        ys = [h for _, _, h in hs if len(h) == 1 and abs((h[0][1] - h[0][0]) - wmin[0]) < 1e-6]
        strip = ys[0][0] if ys else None
        stacks = sorted(set(round((v[0] + v[2]) / 2, 3) for v in G[net]["V1"] if y0 - 0.01 <= (v[1] + v[3]) / 2 <= y1 + 0.01))
        rails[net].append({"bbox": p["bbox"], "w_min": wmin[0], "at_x": round(wmin[1], 2), "strip_y": strip,
                           "stack_x": stacks, "via_y": sorted(set(round((v[1] + v[3]) / 2, 3) for v in G[net]["V1"] if y0 - 0.01 <= (v[1] + v[3]) / 2 <= y1 + 0.01))})
        print(net, "rail y", [round(v, 3) for v in (y0, y1)], "x", x0, x1, "bare width", wmin[0], "strip", strip, "stacks at x", stacks)
# instances
sc = 0.005
inst = {}
for line in open(ext):
    if line.startswith("use "):
        t = line.split(); cell, name = t[1], t[2]; a, b, c, d, e, f = map(float, t[3:9])
        kc = ly.cell(cell); bb = kc.dbbox()
        # boundary layer 0/0 if the cell has it
        r = kdb.Region(kc.begin_shapes_rec(ly.layer(0, 0)))
        if r.count(): bb = r.bbox().to_dtype(dbu)
        xs = [a * x + b * y + c * sc for x in (bb.left, bb.right) for y in (bb.bottom, bb.top)]
        ys = [d * x + e * y + f * sc for x in (bb.left, bb.right) for y in (bb.bottom, bb.top)]
        inst[name] = {"cell": cell, "bbox": [min(xs), min(ys), max(xs), max(ys)]}
for name, i in inst.items():
    x0, y0, x1, y1 = i["bbox"]
    for net in ("VDPWR", "VGND"):
        best = [(k, r) for k, r in enumerate(rails[net]) if r["strip_y"] and y0 - 0.5 <= (r["strip_y"][0] + r["strip_y"][1]) / 2 <= y1 + 0.5
                and r["bbox"][0] - 0.01 <= (x0 + x1) / 2 <= r["bbox"][2] + 0.01]
        i[net] = best[0][0] if len(best) == 1 else [k for k, _ in best]
json.dump({"rails": rails, "inst": inst}, open(out, "w"), indent=1)
bad = {n: i for n, i in inst.items() if not isinstance(i["VDPWR"], int) or not isinstance(i["VGND"], int)}
print(len(inst), "instances;", len(bad), "without a unique rail pair:", list(bad.items())[:5])

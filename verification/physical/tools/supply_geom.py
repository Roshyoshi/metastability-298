"""Supply nets of the tile, from the GDS: which Metal1..Metal4 shapes and vias belong to VDPWR and to VGND
(connectivity through Via1..Via3), and their dimensions. usage: supply_geom.py <gds> <out json>"""
import sys, json, klayout.db as kdb
ly = kdb.Layout(); ly.read(sys.argv[1]); top = ly.top_cell(); dbu = ly.dbu
def reg(l, d=0):
    r = kdb.Region(top.begin_shapes_rec(ly.layer(l, d))); r.merge(); return r
M = {1: reg(34), 2: reg(36), 3: reg(42), 4: reg(46)}
V = {1: reg(35), 2: reg(38), 3: reg(40)}
stripes = {"VDPWR": [154.28, 231.0, 309.4], "VGND": [157.32, 234.04, 312.44]}
res = {}
for net, xs in stripes.items():
    seed = kdb.Region()
    for x in xs:
        probe = kdb.Region(kdb.DBox(x + 0.9, 100, x + 1.1, 101).to_itype(dbu))
        seed += M[4].interacting(probe)
    assert seed.count() == 3, (net, seed.count())
    cur = {1: kdb.Region(), 2: kdb.Region(), 3: kdb.Region(), 4: seed}
    vias = {1: kdb.Region(), 2: kdb.Region(), 3: kdb.Region()}
    changed = True
    while changed:
        changed = False
        for k in (3, 2, 1):
            for a, b in ((k + 1, k), (k, k + 1)):
                v = V[k].interacting(cur[a])
                nb = M[b].interacting(v)
                if (nb - cur[b]).count() or (v - vias[k]).count():
                    if (nb - cur[b]).area() > 0 or (v - vias[k]).area() > 0:
                        changed = True
                    cur[b] = (cur[b] + nb).merged(); vias[k] = (vias[k] + v).merged()
    out = {}
    for k in (4, 3, 2, 1):
        polys = []
        for p in cur[k].each():
            b = p.bbox()
            polys.append({"bbox": [b.left * dbu, b.bottom * dbu, b.right * dbu, b.top * dbu], "area": p.area() * dbu * dbu,
                          "pts": p.num_points(), "hull": [[q.x * dbu, q.y * dbu] for q in p.each_point_hull()]})
        out[f"M{k}"] = polys
    for k in (3, 2, 1):
        out[f"V{k}"] = [[v.bbox().left * dbu, v.bbox().bottom * dbu, v.bbox().right * dbu, v.bbox().top * dbu] for v in vias[k].each()]
    res[net] = out
    print(net, {k: (len(v)) for k, v in out.items()}, "areas um2", {k: round(sum(p["area"] for p in v), 1) for k, v in out.items() if k[0] == "M"})
short = (kdb.Region([kdb.Polygon([kdb.Point(int(x/dbu), int(y/dbu)) for x, y in p["hull"]]) for p in res["VDPWR"]["M1"]]) &
         kdb.Region([kdb.Polygon([kdb.Point(int(x/dbu), int(y/dbu)) for x, y in p["hull"]]) for p in res["VGND"]["M1"]]))
print("overlap of the two nets on Metal1 (must be 0):", short.area())
json.dump(res, open(sys.argv[2], "w"))

"""Latch-up rules LU.3 and LU.4 of the GF180MCU design manual (section 14.3.1), measured on a GDS, and guideline LU.7.
usage: lu_check.py <gds> [<out json>]
No DNWELL exists in the tile, so LU.1 and LU.2 (inside DNWELL) have nothing to check; the script reports the
DNWELL area to show it. LU.5 concerns native transistors (layer NAT); the script reports the NAT area likewise.
  NCOMP = COMP and Nplus, PCOMP = COMP and Pplus.
  LU.3: every point on the boundary of NCOMP outside NWELL within the limit of a substrate tap (PCOMP outside NWELL).
  LU.4: every point on the boundary of PCOMP inside NWELL within the limit of an n-well tap (NCOMP inside the SAME
        n-well polygon).
The distance is Euclidean, from boundary points taken every 0.05 um and at every vertex to the nearest point of
the nearest tap polygon. The limit is 15 um, the strictest case of the rule (all MV cases; LV with y < 1.0 um).
y, the smallest spacing of NWELL to NCOMP outside NWELL, is reported because it selects the LV case."""
import sys, json, numpy as np, klayout.db as kdb
gds = sys.argv[1]
ly = kdb.Layout(); ly.read(gds); top = ly.top_cell(); dbu = ly.dbu
def reg(l, d=0):
    r = kdb.Region(top.begin_shapes_rec(ly.layer(l, d))); r.merge(); return r
comp, nwell, nplus, pplus, poly, cont, dualgate = reg(22), reg(21), reg(32), reg(31), reg(30), reg(33), reg(55)
dnwell, nat = reg(12), reg(5)
ncomp, pcomp = comp & nplus, comp & pplus
n_out, ptap = ncomp - nwell, pcomp - nwell
p_in, ntap = pcomp & nwell, ncomp & nwell
um2 = dbu * dbu
print(f"DNWELL area {dnwell.area()*um2:.1f} um2; NAT area {nat.area()*um2:.1f} um2")
print(f"substrate taps: {ptap.count()} polygons, {ptap.area()*um2:.1f} um2; n-well taps: {ntap.count()} polygons, {ntap.area()*um2:.1f} um2")
print(f"NCOMP outside NWELL: {n_out.count()} polygons; PCOMP inside NWELL: {p_in.count()} polygons; n-well polygons: {nwell.count()}")

def edges_of(region):
    E = []
    for p in region.each():
        for e in p.each_edge():
            E.append((e.p1.x, e.p1.y, e.p2.x, e.p2.y))
    return np.array(E, float) * dbu
def samples(poly, step=0.05):
    P = []
    for e in poly.each_edge():
        x1, y1, x2, y2 = e.p1.x * dbu, e.p1.y * dbu, e.p2.x * dbu, e.p2.y * dbu
        n = max(1, int(np.hypot(x2 - x1, y2 - y1) / step))
        t = np.linspace(0, 1, n + 1)
        P.append(np.c_[x1 + t * (x2 - x1), y1 + t * (y2 - y1)])
    return np.vstack(P)
def dist(P, E):
    """distance of each point to the nearest of the segments E (taps are solid, a point inside one would be 0;
    transistor diffusion never overlaps a tap)"""
    out = np.empty(len(P))
    for i in range(0, len(P), 2000):
        p = P[i:i + 2000, None, :]
        a, b = E[None, :, 0:2], E[None, :, 2:4]
        ab = b - a; t = np.clip(((p - a) * ab).sum(-1) / np.maximum((ab * ab).sum(-1), 1e-18), 0, 1)
        out[i:i + 2000] = np.sqrt((((a + t[..., None] * ab) - p) ** 2).sum(-1)).min(1)
    return out
res = {}
# LU.3
E = edges_of(ptap); worst = (0, None); per = []
for p in n_out.each():
    S = samples(p); d = dist(S, E); k = d.argmax(); per.append((d[k], S[k, 0], S[k, 1], p.bbox().center().y * dbu))
    if d[k] > worst[0]: worst = (d[k], (S[k, 0], S[k, 1]))
per.sort(reverse=True)
res["LU.3"] = {"max_um": round(float(worst[0]), 3), "at": [round(float(v), 3) for v in worst[1]], "polygons": len(per),
               "over_12um": sum(1 for q in per if q[0] > 12), "over_15um": sum(1 for q in per if q[0] > 15)}
print("LU.3 (NCOMP outside NWELL to substrate tap): max %.3f um at (%.2f, %.2f); polygons over 12 um: %d; over 15 um: %d" %
      (worst[0], worst[1][0], worst[1][1], res["LU.3"]["over_12um"], res["LU.3"]["over_15um"]))
print("   five largest:", [(round(float(a), 2), round(float(x), 1), round(float(y), 1)) for a, x, y, _ in per[:5]])
rows3 = {}
for d, x, y, yc in per: rows3[round(yc / 3.92)] = max(rows3.get(round(yc / 3.92), 0), d)
# LU.4, per n-well polygon
worst = (0, None); per = []; orphan = 0
for w in nwell.each():
    wr = kdb.Region(w); taps = ntap & wr; dev = p_in & wr
    if dev.count() == 0: continue
    if taps.count() == 0:
        orphan += dev.count(); continue
    E = edges_of(taps)
    for p in dev.each():
        S = samples(p); d = dist(S, E); k = d.argmax(); per.append((d[k], S[k, 0], S[k, 1]))
        if d[k] > worst[0]: worst = (d[k], (S[k, 0], S[k, 1]))
per.sort(reverse=True)
res["LU.4"] = {"max_um": round(float(worst[0]), 3), "at": [round(float(v), 3) for v in worst[1]], "polygons": len(per),
               "pcomp_in_a_well_without_tap": orphan, "over_12um": sum(1 for q in per if q[0] > 12), "over_15um": sum(1 for q in per if q[0] > 15)}
print("LU.4 (PCOMP inside NWELL to tap of the same n-well): max %.3f um at (%.2f, %.2f); polygons over 12 um: %d; over 15 um: %d; PCOMP in a well without any tap: %d" %
      (worst[0], worst[1][0], worst[1][1], res["LU.4"]["over_12um"], res["LU.4"]["over_15um"], orphan))
print("   five largest:", [(round(float(a), 2), round(float(x), 1), round(float(y), 1)) for a, x, y in per[:5]])
# y: smallest NWELL to NCOMP-outside-NWELL spacing, all, and for the part outside Dualgate (LV)
def min_space(a, b, limit=3.0):
    pairs = a.separation_check(b, int(limit / dbu), False, kdb.Metrics.Euclidian, None, None, None)
    return min((e.distance() * dbu for e in pairs.each()), default=None)
y_all = min_space(nwell, n_out); y_lv = min_space(nwell, n_out - dualgate)
res["y_um"] = {"all": y_all, "outside_Dualgate_LV": y_lv}
print("y (NWELL to NCOMP outside NWELL): min", y_all, "um; in the LV part (outside Dualgate):", y_lv, "um")
# LU.7 guideline: contact area on taps against channel area
gate = (poly & comp).area() * um2; tc = (cont & (ptap + ntap)).area() * um2
res["LU.7"] = {"tap_contact_area_um2": round(tc, 2), "channel_area_um2": round(gate, 2), "ratio_percent": round(100 * tc / gate, 2)}
print(f"LU.7 guideline: contact area on taps {tc:.2f} um2 / channel area {gate:.2f} um2 = {100*tc/gate:.1f} % (guideline: more than 3 %)")
res["taps"] = {"substrate": ptap.count(), "nwell": ntap.count(), "substrate_area_um2": round(ptap.area() * um2, 1), "nwell_area_um2": round(ntap.area() * um2, 1)}
if len(sys.argv) > 2: json.dump(res, open(sys.argv[2], "w"), indent=1)

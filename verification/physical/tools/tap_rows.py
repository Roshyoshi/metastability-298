"""Tap spacing per cell row, measured on the GDS. usage: tap_rows.py <gds> <layout_plan.json> [<out json>]
For each row of the layout plan: the number of substrate taps (PCOMP outside NWELL) and n-well taps (NCOMP inside
NWELL) whose centre lies in the row, the largest gap between the edges of neighbouring taps along the row, and the
largest distance from a row end (first or last transistor diffusion) to the nearest tap edge."""
import sys, json, klayout.db as kdb
ly = kdb.Layout(); ly.read(sys.argv[1]); top = ly.top_cell(); dbu = ly.dbu
def reg(l, d=0):
    r = kdb.Region(top.begin_shapes_rec(ly.layer(l, d))); r.merge(); return r
comp, nwell, nplus, pplus, poly = reg(22), reg(21), reg(32), reg(31), reg(30)
ptap, ntap = (comp & pplus) - nwell, (comp & nplus) & nwell
tr = comp.interacting(poly)          # transistor diffusion
plan = json.load(open(sys.argv[2])); rows = [(r["name"], r["y"]) for r in plan["bank"]["rows"]] + [(r["name"], r["y"]) for r in plan["rows"]]
out = []
print(f"{'row':8s} {'y (um)':>8s} {'sub taps':>9s} {'max gap':>8s} {'well taps':>9s} {'max gap':>8s} {'transistor x range':>22s}")
for name, y in rows:
    box = kdb.Region(kdb.DBox(0, y, 400, y + 3.92).to_itype(dbu))
    def taps(t):
        return sorted((p.bbox().left * dbu, p.bbox().right * dbu) for p in t.each() if y <= p.bbox().center().y * dbu <= y + 3.92)
    tx = [(p.bbox().left * dbu, p.bbox().right * dbu) for p in (tr & box).each()]
    x0, x1 = min(a for a, b in tx), max(b for a, b in tx)
    rec = {"row": name, "y": y, "x": [x0, x1]}
    for key, t in (("substrate", ptap), ("nwell", ntap)):
        T = taps(t); gaps = [b[0] - a[1] for a, b in zip(T[:-1], T[1:])]
        ends = [max(0.0, T[0][0] - x0), max(0.0, x1 - T[-1][1])]
        rec[key] = {"n": len(T), "max_gap": round(max(gaps), 3) if gaps else None, "end": [round(e, 3) for e in ends]}
    out.append(rec)
    print(f"{name:8s} {y:8.2f} {rec['substrate']['n']:9d} {rec['substrate']['max_gap']!s:>8s} {rec['nwell']['n']:9d} {rec['nwell']['max_gap']!s:>8s}   {x0:8.2f} to {x1:8.2f}   ends {rec['substrate']['end']}")
if len(sys.argv) > 3: json.dump(out, open(sys.argv[3], "w"), indent=1)

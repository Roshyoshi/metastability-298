# KLayout batch: XOR of two GDS files per layer inside and outside a y threshold; lists the XOR shapes above it.
#   klayout -b -r kxor_region.py -rd a=A.gds -rd b=B.gds -rd ycut=199.0
import pya
la, lb = pya.Layout(), pya.Layout()
la.read(a); lb.read(b)
ta, tb = la.top_cell(), lb.top_cell()
yc = float(ycut)
dbu = la.dbu
box_hi = pya.Box(-10**9, int(yc / dbu), 10**9, 10**9)
box_lo = pya.Box(-10**9, -10**9, 10**9, int(yc / dbu))
names = {(46,0):'Metal4', (42,0):'Metal3', (40,0):'Via3', (38,0):'Via2', (36,0):'Metal2', (35,0):'Via1', (34,0):'Metal1'}
layers = {}
for li in la.layer_indexes():
    info = la.get_info(li); layers[(info.layer, info.datatype)] = [li, None]
for li in lb.layer_indexes():
    info = lb.get_info(li); layers.setdefault((info.layer, info.datatype), [None, None])[1] = li
tot_hi = 0
for (l, d), (ia, ib) in sorted(layers.items()):
    ra = pya.Region(ta.begin_shapes_rec(ia)) if ia is not None else pya.Region()
    rb = pya.Region(tb.begin_shapes_rec(ib)) if ib is not None else pya.Region()
    ra.merge(); rb.merge()
    xa_hi = (ra & pya.Region(box_hi)) ^ (rb & pya.Region(box_hi))
    xa_lo = (ra & pya.Region(box_lo)) ^ (rb & pya.Region(box_lo))
    only_a = (ra - rb) & pya.Region(box_hi)
    only_b = (rb - ra) & pya.Region(box_hi)
    tot_hi += xa_hi.count()
    if xa_hi.count() or xa_lo.count():
        print(f'layer {l}/{d} {names.get((l,d),"")}: above y={yc}: XOR {xa_hi.count()} polygons ({xa_hi.area()*dbu*dbu:.3f} um2); below: XOR {xa_lo.count()} polygons')
        for tag, reg in (('only in A (removed)', only_a), ('only in B (added)', only_b)):
            for poly in reg.each():
                bb = poly.bbox()
                print(f'    {tag}: x {bb.left*dbu:.3f}..{bb.right*dbu:.3f}  y {bb.bottom*dbu:.3f}..{bb.top*dbu:.3f}')
print('TOTAL XOR polygons above the cut:', tot_hi)

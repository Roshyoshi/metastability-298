# KLayout batch: the whole tile plus close-ups, in the PDK's layer colours on KLayout's dark background.
#   klayout -z -nc -rx -rd gds=gds/tt_um_metastability_characterizer.gds \
#           -rd lyp=$PDK_ROOT/gf180mcuD/libs.tech/klayout/tech/gf180mcu.lyp -rd out=build/shots -r layout/klayout_shots.py
# The close-ups are taken from layout_plan.json, so they follow the layout. tools/render_layout.py draws
# the same views with the cells and transistors named: those are the pictures in layout/renders.
import json, os
import pya
gds, lyp, out = gds, lyp, out       # set on the command line with -rd
plan = json.load(open(os.path.join(os.path.dirname(os.path.abspath(gds)), "..", "layout", "layout_plan.json")))
view = pya.LayoutView()
view.load_layout(gds, True)
if lyp:
    view.load_layer_props(lyp)
view.set_config("background-color", "#000000")
view.set_config("text-visible", "false")
for lp in view.each_layer():        # the tile boundary is one hatched rectangle over everything
    if (lp.source_layer, lp.source_datatype) == (0, 0):
        lp.visible = False
view.max_hier()

tile = view.active_cellview().cell.dbbox()
VIEWS = {"tile": [tile.left, tile.bottom, tile.right, tile.top]}
rows = {r["name"]: r for r in plan["rows"]}
for name in ("F1", "u_dut2", "C1", "P1"):
    y = rows[name]["y"]
    xs = [x for x, cell, inst in rows[name]["cells"] if inst]
    VIEWS["row_" + name] = [min(xs) - 2, y - 4, min(max(xs) + 6, min(xs) + 60), y + 8]
xd = next(x for x, cell, inst in rows["F1"]["cells"] if cell == "meta_dly_cs")
VIEWS["delay_line"] = [xd - 2, rows["F1"]["y"] - 1.5, xd + 16, rows["F1"]["y"] + 5.5]

os.makedirs(out, exist_ok=True)
for name, (x1, y1, x2, y2) in VIEWS.items():
    view.zoom_box(pya.DBox(x1, y1, x2, y2))
    w = 2400; h = int(w * (y2 - y1) / (x2 - x1)) or 600
    view.save_image(os.path.join(out, name + ".png"), w, max(400, min(h, 2400)))
print("saved", len(VIEWS), "pictures in", out)

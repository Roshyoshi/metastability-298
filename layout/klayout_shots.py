# KLayout batch: whole tile plus close-ups, in the PDK's layer colours on KLayout's dark background.
import pya, os
gds, lyp, out = gds, lyp, out
view = pya.LayoutView()
view.load_layout(gds, True)
if lyp:
    view.load_layer_props(lyp)
view.set_config("background-color", "#000000")
view.max_hier()
VIEWS = {
 "tile": [
  0,
  0,
  346.64,
  325.36
 ],
 "row_F1": [
  188.4,
  137.60000000000002,
  250.4,
  149.60000000000002
 ],
 "row_u_dut2": [
  278.56,
  148.24,
  311.76,
  160.24
 ],
 "row_C1": [
  172.72,
  171.19999999999996,
  234.72,
  183.19999999999996
 ],
 "row_P1": [
  149.2,
  304.48,
  193.04,
  316.48
 ],
 "delay_line": [
  284.72,
  140.10000000000002,
  302.72,
  147.10000000000002
 ]
}
for name, (x1, y1, x2, y2) in VIEWS.items():
    view.zoom_box(pya.DBox(x1, y1, x2, y2))
    w = 2400; h = int(w * (y2 - y1) / (x2 - x1)) or 600
    view.save_image(os.path.join(out, name + ".png"), w, max(400, min(h, 2400)))
print("saved", len(VIEWS), "pictures")

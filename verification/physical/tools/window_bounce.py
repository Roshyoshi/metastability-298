"""Supply disturbance at chosen cells during the delay interval of each trial (capture_local rising to early_clk
rising). usage: window_bounce.py <tag>.raw <probes.json> <rail_geom.json> <netmap.json> <feed> [cell names ...]
Per trial: the mean and the largest rise of the VGND rail and drop of the VDPWR rail at each cell (resistive model,
all cell currents at each instant)."""
import sys, json, os, numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from rawread import read_raw
from irnet import network, FEEDS
raw, probes, geom, nmap, feed = sys.argv[1:6]
names, D = read_raw(raw); t = D[:, 0]; col = {n: i for i, n in enumerate(names)}
P = json.load(open(probes)); G = json.load(open(geom)); place = json.load(open(nmap))["place"]; inv = {v: k for k, v in place.items()}
inst = [n for n in P if n in G["inst"]]
Ip = np.array([D[:, col[f"i({P[n]['ip']})"]] for n in inst]); Ig = np.array([D[:, col[f"i({P[n]['ig']})"]] for n in inst])
Zg = network(G, inst, "VGND", FEEDS[feed])["Z"]; Zp = network(G, inst, "VDPWR", FEEDS[feed])["Z"]
cl, ec = D[:, col["v(p_capture_local)"]], D[:, col["v(p_early_clk)"]]
vth = float(os.environ.get("VDD", "3.3")) / 2
def rises(v):
    k = np.where((v[:-1] < vth) & (v[1:] >= vth))[0]
    return t[k] + (vth - v[k]) / (v[k + 1] - v[k]) * (t[k + 1] - t[k])
rc, re_ = rises(cl), rises(ec)
cells = sys.argv[6:] or ["delay/MCS", "delay/XR0", "early_observer", "u_dut2/u_mfw", "u_dut1", "bank_n2", "bank_n1"]
print("feed:", feed, "; capture_local rises at (ns):", np.round(rc * 1e9, 2))
out = {}
for c in cells:
    i = inst.index(inv[c]); vg = Zg[i] @ Ig; vp = Zp[i] @ Ip
    rows = []
    for a in rc:
        b = re_[re_ > a]
        if not len(b) or b[0] - a > 20e-9: continue
        m = (t >= a) & (t <= b[0])
        rows.append((a * 1e9, (b[0] - a) * 1e12, np.trapezoid(vg[m], t[m]) / (b[0] - a) * 1e3, vg[m].max() * 1e3, np.trapezoid(vp[m], t[m]) / (b[0] - a) * 1e3, vp[m].max() * 1e3))
    rows = np.array(rows); out[c] = rows.tolist()
    print(f"{c:16s} VGND rise, mean over the delay interval, per trial (mV): {np.round(rows[:,2],4)}; largest {rows[:,3].max():.3f} | VDPWR drop, mean (mV): {np.round(rows[:,4],4)}; largest {rows[:,5].max():.3f}")
print("delay d per trial (ps):", np.round(rows[:, 1], 2))

"""Resistive model of the tile's supply network (see ir_em.py for the description)."""
import numpy as np
import scipy.sparse as sp, scipy.sparse.linalg as spl

STRIPE_X = {"VDPWR": [155.28, 232.0, 310.4], "VGND": [158.32, 235.04, 313.44]}
STRAP_Y = {"VDPWR": 7.0, "VGND": 6.0}
YM, PITCH = 162.68, 41.16
FEEDS = {"straps": {"VDPWR": [(YM + k * PITCH - 9.875, YM + k * PITCH + 9.875) for k in (-1, 0, 1)],
                    "VGND": [(YM + (k + 0.5) * PITCH - 4.375, YM + (k + 0.5) * PITCH + 4.375) for k in range(-4, 4)]},
         "end": {"VDPWR": [(5.0, 5.0)], "VGND": [(5.0, 5.0)]}}

def network(G, inst, net, feed, rs=0.090, rvia=4.5):
    """nodes, conductance list, fixed nodes; returns solver giving node voltages (drop, positive) for injected currents"""
    rails = G["rails"][net]; nodes = {}; edges = []; fixed = set()
    def nid(key):
        return nodes.setdefault(key, len(nodes))
    cellnode = {}; meta = {"rail_seg": [], "stack": [], "stripe_seg": []}
    stripe_y = {s: set() for s in range(3)}
    for r, rail in enumerate(rails):
        y = sum(rail["strip_y"]) / 2
        xs = set(rail["stack_x"])
        for n in inst:
            if G["inst"][n][net] == r:
                b = G["inst"][n]["bbox"]; xc = round((b[0] + b[2]) / 2, 3); xs.add(xc); cellnode[n] = ("r", r, xc)
        xs = sorted(xs)
        for a, b in zip(xs[:-1], xs[1:]):
            R = rs * (b - a) / rail["w_min"]
            edges.append((nid(("r", r, a)), nid(("r", r, b)), R)); meta["rail_seg"].append((len(edges) - 1, r, a, b, rail["w_min"]))
        for sx in rail["stack_x"]:
            s = int(np.argmin([abs(sx - x) for x in STRIPE_X[net]]))
            assert abs(sx - STRIPE_X[net][s]) < 1.1, (net, r, sx)
            stripe_y[s].add(round(y, 3))
            edges.append((nid(("r", r, sx)), nid(("s", s, round(y, 3))), 3 * rvia)); meta["stack"].append((len(edges) - 1, r, sx))
    for s in range(3):
        ys = set(stripe_y[s]) | {STRAP_Y[net]}
        for a, b in feed[net]:
            ys |= {a, b}
        ys = sorted(ys)
        for a, b in zip(ys[:-1], ys[1:]):
            inside = any(lo <= a and b <= hi for lo, hi in feed[net])
            R = 1e-6 if inside else rs * (b - a) / 2.0
            edges.append((nid(("s", s, a)), nid(("s", s, b)), R)); meta["stripe_seg"].append((len(edges) - 1, s, a, b))
        for lo, hi in feed[net]:
            fixed.add(nid(("s", s, lo)))
    # Metal3 strap joining the three stripes
    for s in (0, 1):
        R = rs * (STRIPE_X[net][s + 1] - STRIPE_X[net][s]) / 0.56 + 2 * rvia / 2      # two Via3 at each end
        edges.append((nid(("s", s, STRAP_Y[net])), nid(("s", s + 1, STRAP_Y[net])), R))
    N = len(nodes); rows, cols, vals = [], [], []
    for a, b, R in edges:
        g = 1.0 / R
        rows += [a, b, a, b]; cols += [a, b, b, a]; vals += [g, g, -g, -g]
    Gm = sp.csr_matrix((vals, (rows, cols)), shape=(N, N)).tolil()
    free = np.array([i for i in range(N) if i not in fixed])
    Gff = sp.csc_matrix(Gm.tocsr()[free][:, free])
    lu = spl.splu(Gff)
    pos = {n: i for i, n in enumerate(free)}
    # Z: rows = cells (their rail node), columns = cells
    idx = [pos[nodes[cellnode[n]]] for n in inst]
    rhs = np.zeros((len(free), len(inst)))
    for j, i in enumerate(idx): rhs[i, j] = 1.0
    V = lu.solve(rhs)                         # node voltages for unit current at each cell
    Z = V[idx, :]
    return {"Z": Z, "V": V, "edges": edges, "meta": meta, "pos": pos, "nodes": nodes, "free": free}

#!/usr/bin/env python3
"""Map every net of the master netlist (schematic) onto the extracted layout netlist.
(Copy of /home/claude/r3/tools/pexmap.py for the bank revision: the two 3.3 V flip-flop blocks are leaves
meta_n3ffb and meta_j3a with pins d, clk, q on both sides.)

Both netlists are reduced to leaf cells (library cells, plus the custom delay stage as one leaf) and
nets; nets are then matched by iterative refinement of colours (the same principle as Netgen's
partitioning), seeded with the names of the tile's pins. The result is a dictionary from the
hierarchical schematic name (e.g. 'xu_dut2/mq') to the layout net name.

usage: pexmap.py <master netlist chip_lvs.spice> <extracted netlist (pex or lvs)> <out.json>
"""
import json, re, sys, hashlib
from collections import defaultdict

TOP = "tt_um_metastability_characterizer"
SIGPINS = {"A1","A2","A3","A4","B","B1","B2","C","ZN","Z","I","I0","I1","I2","I3","S","S0","S1",
           "D","CLK","CLKN","E","EN","TE","SE","SI","Q","QN","RN","SETN","launch","control","slow","d","clk","q"}
BLOCKS = {"meta_dut_n3ffb": "meta_n3ffb", "meta_dut_j3a": "meta_j3a"}
SUPPLY = {"VDD": "VDPWR", "VSS": "VGND"}

def read(path):
    txt = open(path).read()
    txt = re.sub(r"\n\+", " ", txt)
    subs, cur = {}, None
    for line in txt.splitlines():
        s = line.strip()
        if not s or s[0] == "*":
            continue
        t = s.split()
        k = t[0].lower()
        if k == ".subckt":
            cur = t[1]; subs[cur] = {"pins": [p for p in t[2:] if "=" not in p], "inst": []}
        elif k == ".ends":
            cur = None
        elif cur is not None and t[0][0] in "Xx":
            args = [a for a in t[1:] if "=" not in a]
            subs[cur]["inst"].append((t[0], args[-1], args[:-1]))
    return subs

def flatten_schematic(subs):
    """Leaves: library cells (pins by name) and the delay stage as one leaf 'meta_dly_cs'."""
    leaves = []          # (name, type, {pin: net})
    def walk(cell, prefix, conn):
        for name, typ, args in subs[cell]["inst"]:
            loc = lambda n: conn.get(n, prefix + n)
            if typ.startswith("gf180mcu_fd_sc"):
                pins = subs[typ]["pins"]
                leaves.append((prefix + name.lower(), typ, {p: loc(a) for p, a in zip(pins, args)}))
            elif typ in BLOCKS:
                pins = subs[typ]["pins"]
                c2 = {p: loc(a) for p, a in zip(pins, args)}
                leaves.append((prefix + name.lower(), BLOCKS[typ], {"d": c2["d"], "clk": c2["clk"], "q": c2["q"],
                               "VDD": c2["VDPWR"], "VSS": c2["VGND"]}))
            elif typ == "meta_delay_analog":
                pins = subs[typ]["pins"]
                c2 = {p: loc(a) for p, a in zip(pins, args)}
                pre = prefix + name.lower() + "/"
                inner = {n: c2.get(n, pre + n) for n in ("launch", "control", "slow", "VDPWR", "VGND")}
                leaves.append((pre + "cs", "meta_dly_cs", {"launch": inner["launch"], "control": inner["control"],
                               "slow": inner["slow"], "VDD": inner["VDPWR"], "VSS": inner["VGND"]}))
                # the three restoring inverters
                for n2, t2, a2 in subs[typ]["inst"]:
                    if t2.startswith("gf180mcu_fd_sc"):
                        p2 = subs[t2]["pins"]
                        leaves.append((pre + n2.lower(), t2, {p: c2.get(a, pre + a) for p, a in zip(p2, a2)}))
            elif typ in subs:
                pins = subs[typ]["pins"]
                walk(typ, prefix + name.lower() + "/", {p: loc(a) for p, a in zip(pins, args)})
    top = subs[TOP]
    walk(TOP, "", {p: p for p in top["pins"]})
    return leaves

def flatten_layout(subs):
    leaves = []
    for name, typ, args in subs[TOP]["inst"]:
        pins = subs[typ]["pins"]
        leaves.append((name, typ, dict(zip(pins, args))))
    return leaves

def norm(leaves):
    out = []
    for name, typ, conn in leaves:
        c = {}
        for p, n in conn.items():
            if p in SIGPINS:
                c[p] = n
            elif p in SUPPLY:
                c[p] = SUPPLY[p] if n in ("VDPWR", "VGND", "VDD", "VSS") else n
        out.append((name, typ, c))
    return out

def h(*parts):
    return hashlib.sha1(repr(parts).encode()).hexdigest()[:16]

def refine(leaves, ports):
    nets = defaultdict(list)
    for i, (name, typ, conn) in enumerate(leaves):
        for p, n in conn.items():
            nets[n].append((i, p))
    ncol = {n: (n if n in ports else "net") for n in nets}
    icol = [typ for _, typ, _ in leaves]
    for it in range(200):
        icol2 = [h(leaves[i][1], tuple(sorted((p, ncol[n]) for p, n in leaves[i][2].items()))) for i in range(len(leaves))]
        ncol2 = {n: (n if n in ports else h(ncol[n], tuple(sorted((icol2[i], p) for i, p in nets[n])))) for n in nets}
        if it >= 8 and len(set(ncol2.values())) == len(set(ncol.values())) and len(set(icol2)) == len(set(icol)):
            icol, ncol = icol2, ncol2
            break
        icol, ncol = icol2, ncol2
    return ncol, icol, it

def main():
    sch_path, lay_path, out = sys.argv[1:4]
    S, L = read(sch_path), read(lay_path)
    ports = set(p for p in S[TOP]["pins"]) & set(L[TOP]["pins"])
    ls, ll = norm(flatten_schematic(S)), norm(flatten_layout(L))
    # drop layout leaves that carry no signal pins (fill, endcap, tap cells)
    ll = [x for x in ll if any(p in SIGPINS for p in x[2])]
    ls = [x for x in ls if any(p in SIGPINS for p in x[2])]
    # rename the layout custom cell type to the schematic leaf type
    ll = [(n, ("meta_dly_cs" if t.startswith("meta_dly_cs") else t), c) for n, t, c in ll]
    # refine both graphs together so that colours are comparable
    tag = lambda x, s: [(s + n, t, {p: (v if v in ports or v in ("VDPWR","VGND") else s + v) for p, v in c.items()}) for n, t, c in x]
    both = tag(ls, "S:") + tag(ll, "L:")
    ncol, icol, it = refine(both, ports | {"VDPWR", "VGND"})
    bycol = defaultdict(lambda: {"S": [], "L": []})
    for n, c in ncol.items():
        side = "S" if n.startswith("S:") else ("L" if n.startswith("L:") else None)
        if side:
            bycol[c][side].append(n[2:])
        else:
            bycol[c]["S"].append(n); bycol[c]["L"].append(n)
    mapping, ambiguous = {}, []
    for c, d in bycol.items():
        if len(d["S"]) == 1 and len(d["L"]) == 1:
            mapping[d["S"][0]] = d["L"][0]
        elif d["S"] or d["L"]:
            ambiguous.append(d)
    unmatched = [d for d in ambiguous if len(d["S"]) != len(d["L"])]
    json.dump({"map": mapping, "ambiguous": ambiguous, "iterations": it}, open(out, "w"), indent=1)
    # instance correspondence, and a consistency check of every connection under the net map
    idx = {}
    for n, t, c in ll:
        idx.setdefault((t, tuple(sorted(c.items()))), []).append(n)
    inst, bad = {}, 0
    for n, t, c in ls:
        key = (t, tuple(sorted((p, mapping.get(v, v)) for p, v in c.items())))
        hit = idx.get(key, [])
        if len(hit) != 1:
            bad += 1
        else:
            inst[n] = hit[0]
    json.dump(inst, open(out.replace(".json", "") + "_inst.json", "w"), indent=1)
    print(f"cells checked: {len(ls)}; cells whose connections do not match exactly one layout cell: {bad}")
    print(f"leaves: schematic {len(ls)}, layout {len(ll)}; refinement iterations {it}")
    print(f"nets mapped uniquely: {len(mapping)}; ambiguous classes: {len(ambiguous)}; classes with unequal counts: {len(unmatched)}")
    for d in unmatched[:10]:
        print("  UNEQUAL", d["S"][:4], d["L"][:4])
    for d in ambiguous[:6]:
        print("  ambiguous:", d["S"][:4], "<->", d["L"][:4])

if __name__ == "__main__":
    main()

"""Tools for the hierarchical netlist that Magic extracts from the tile.

  read_pex(path)                 subcircuits, top-level instances and capacitors
  placement(ext, plan)           extracted instance name -> name in the master netlist, matched by position
  netmap(pex, lvs, place)        master-netlist net name -> extracted net name (through the pins of matched cells)
  flatten(pex, insts, ports)     the chosen top-level instances as a flat netlist with every capacitor inside them and
                                 every top-level capacitor on their nets; a capacitor to a net outside goes to ground
"""
import re, json

TOP = "tt_um_metastability_characterizer"
SUP = {"VDPWR": "vdd", "VGND": "0", "VSUBS": "0", "VDD": "vdd", "VSS": "0", "0": "0"}


def capval(v):
    m = re.match(r"^([-+0-9.eE]+)([a-zA-Z]*)$", v)
    x = float(m.group(1)); s = m.group(2).lower()
    return x * {"": 1.0, "f": 1e-15, "p": 1e-12, "a": 1e-18, "n": 1e-9, "u": 1e-6}[s]


def read_pex(path):
    txt = open(path).read().replace("\n+", " ")
    subs, pins, cur = {}, {}, None
    for line in txt.splitlines():
        t = line.split()
        if not t:
            continue
        if t[0].lower() == ".subckt":
            cur = t[1]; pins[cur] = [p for p in t[2:] if "=" not in p]; subs[cur] = []
        elif t[0].lower() == ".ends":
            cur = None
        elif cur:
            subs[cur].append(line)
    top = {"inst": [], "caps": [], "dev": []}
    for line in subs[TOP]:
        t = line.split()
        if t[0][0] in "xX":
            a = [p for p in t[1:] if "=" not in p]
            if a[-1] in subs:
                top["inst"].append((t[0][1:], a[-1], a[:-1]))
            else:
                top["dev"].append(line)
        elif t[0][0] in "cC":
            top["caps"].append((t[0], t[1], t[2], t[3]))
    return {"subckts": subs, "pins": pins, "top": top}


def placement(ext_path, plan_path):
    """{extracted instance: master-netlist instance}; fill, tap and end cells are left out."""
    plan = json.load(open(plan_path))
    want = {}                                   # (x, row y) -> (cell kind, name)
    for r in plan["rows"] + plan["bank"]["rows"]:
        for x, kind, name in r["cells"]:
            if name:
                want[(round(x, 2), round(r["y"], 2))] = (kind, name)
    out, sc = {}, 0.005
    for line in open(ext_path):
        if not line.startswith("use "):
            continue
        t = line.split(); cell, inst = t[1], t[2]; a, b, c, d, e, f = map(float, t[3:9])
        x = round(c * sc, 2); y = f * sc
        yrow = round(y if e > 0 else y - 3.92, 2)          # a flipped cell has its origin at the top of the row
        if a < 0:
            raise ValueError("mirrored in x: " + inst)
        k = want.get((x, yrow))
        if k is None:                                      # the origin of a cell is not always its left edge
            near = [(abs(xx - x), kk) for (xx, yy), kk in want.items() if yy == yrow and abs(xx - x) < 0.6]
            k = min(near)[1] if near else None
        if k:
            kind, name = k
            assert kind in cell or (kind, cell) in (("meta_j3a", "meta_j3a"), ("meta_n3ffb", "meta_n3ffb")), (kind, cell)
            out[inst] = name
    names = list(out.values())
    assert len(names) == len(set(names)), "two extracted cells matched one name"
    missing = set(n for _, n in want.values()) - set(names)
    assert not missing, sorted(missing)[:5]
    return out


def read_cdl(path):
    """master netlist (layout/chip_lvs.spice): {subckt: (pins, [(inst, nets, cell or None, raw line)])}"""
    txt = open(path).read().replace("\n+", " ")
    subs, cur = {}, None
    for line in txt.splitlines():
        t = line.split()
        if not t or t[0].startswith("*"):
            continue
        if t[0].upper() == ".SUBCKT":
            cur = t[1]; subs[cur] = ([p for p in t[2:] if "=" not in p], [])
        elif t[0].upper() == ".ENDS":
            cur = None
        elif cur and t[0][0] in "xX":
            a = [p for p in t[1:] if "=" not in p]
            subs[cur][1].append((t[0][1:], a[:-1], a[-1], line))
        elif cur and t[0][0] in "mMdD":
            subs[cur][1].append((t[0], t[1:], None, line))
    return subs


def master_cells(cdl, leaf):
    """every cell of the master netlist whose subcircuit name is in `leaf` or that is a leaf library cell:
    {hierarchical instance name: (cell, {pin: net name at the top, hierarchical})}"""
    out = {}

    def walk(sub, prefix, bind):
        pins, body = cdl[sub]
        for inst, nets, cell, _ in body:
            if cell is None:
                continue
            g = [bind.get(n, n if n in ("VDPWR", "VGND") else prefix + n) for n in nets]
            name = prefix + inst
            if cell in leaf or cell not in cdl or cell.startswith("gf180mcu_"):
                cp = cdl[cell][0] if cell in cdl else None
                out[name] = (cell, dict(zip(cp, g)) if cp else g)
            else:
                walk(cell, name + "/", dict(zip(cdl[cell][0], g)))
    walk(TOP, "", {})
    return out


def netmap(pex, cdl, place, blocks=("meta_dut_n3ffb", "meta_dut_j3a")):
    """{master net: extracted net}. Library cells are matched pin by pin (pin names agree between the library
    netlist and Magic's extraction); the two bank blocks through their pins d, clk, q."""
    mc = master_cells(cdl, set(blocks))
    einst = {i: (cell, nets) for i, cell, nets in pex["top"]["inst"]}
    m, clash = {}, []
    for ei, name in place.items():
        if ei not in einst:
            continue                                      # a cell without devices is not in the netlist
        cell, nets = einst[ei]; epins = dict(zip(pex["pins"][cell], nets))
        cands = [name, name.replace("delay/MCS", "delay")]
        mn = next((c for c in cands if c in mc), None)
        if mn is None:
            continue
        mcell, mp = mc[mn]
        if not isinstance(mp, dict):
            continue
        for pin, net in mp.items():
            ep = epins.get(pin) or epins.get(pin.lower()) or epins.get(pin.upper())
            if ep is None or pin in ("VDD", "VSS", "VNW", "VPW", "VDPWR", "VGND"):
                continue
            if net in m and m[net] != ep:
                clash.append((net, m[net], ep))
            m[net] = ep
    assert not clash, clash[:5]
    return m, mc


def flatten(pex, insts, keep=None, extra_ports=()):
    """Flat netlist lines for the top-level instances `insts` (extracted names).
    Top-level nets keep their name, sanitised and prefixed n_; a net inside a cell is <instance>_<net>.
    Returns (lines, {top net: flat node}) for the nets that touch the kept instances."""
    san = lambda n: re.sub(r"[^A-Za-z0-9_]", "_", n)
    subs, pins = pex["subckts"], pex["pins"]
    lines, tn = [], {}

    def topnode(n):
        if n in SUP:
            return SUP[n]
        tn.setdefault(n, "n_" + san(n))
        return tn[n]

    def walk(cname, pmap, prefix):
        for line in subs[cname]:
            t = line.split()
            if t[0][0] in "xX":
                a = [x for x in t[1:] if "=" not in x]; par = [x for x in t[1:] if "=" in x]
                if a[-1] in subs:
                    walk(a[-1], {p: node(x, pmap, prefix) for p, x in zip(pins[a[-1]], a[:-1])}, prefix + san(t[0]) + "_")
                else:
                    lines.append(" ".join([f"X{prefix}{san(t[0][1:])}"] + [node(x, pmap, prefix) for x in a[:-1]] + [a[-1]] + par))
            elif t[0][0] in "cC":
                x, y = node(t[1], pmap, prefix), node(t[2], pmap, prefix)
                if x != y:
                    lines.append(f"C{prefix}{san(t[0][1:])} {x} {y} {t[3]}")

    def node(n, pmap, prefix):
        if n in pmap:
            return pmap[n]
        if n in SUP:
            return SUP[n]
        return prefix + san(n)

    want = set(insts)
    for inst, cell, nets in pex["top"]["inst"]:
        if inst in want:
            walk(cell, {p: topnode(a) for p, a in zip(pins[cell], nets)}, "x" + san(inst) + "_")
            want.discard(inst)
    assert not want, sorted(want)[:5]
    for p in extra_ports:
        topnode(p)
    ncap = 0
    for name, a, b, v in pex["top"]["caps"]:
        ina, inb = a in tn, b in tn
        if not (ina or inb):
            continue
        x = tn[a] if ina else "0"; y = tn[b] if inb else "0"
        if a in SUP: x = SUP[a]
        if b in SUP: y = SUP[b]
        if x == y:
            continue
        lines.append(f"Ctop_{san(name)} {x} {y} {v}"); ncap += 1
    return lines, tn, ncap

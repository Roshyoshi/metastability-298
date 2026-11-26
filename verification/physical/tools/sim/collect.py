#!/usr/bin/env python3
"""Collect the stage-3 results into markdown tables (printed) and copy the result files into the repository tree.
usage: collect.py <work dir> [<repo sim dir>]"""
import sys, os, json, glob, shutil
W = sys.argv[1]; OUT = sys.argv[2] if len(sys.argv) > 2 else None
J = lambda p: json.load(open(p)) if os.path.exists(p) else None
COND = [("typical", 3.3, 27.0, "typical, 3.3 V, 27 C"), ("ss", 3.0, 125.0, "ss, 3.0 V, 125 C"), ("ff", 3.6, -40.0, "ff, 3.6 V, -40 C")]

print("### Delay of the early sample against `ua[0]` (ps)\n")
curves = {}
for ext in ("573", "703"):
    for c, v, t, lab in COND:
        d = J(f"{W}/sim/dly/dly_post{ext}_{c}_{v}_{t}.json")
        if d: curves[(ext, c)] = {float(k): p for k, p in d["points"].items() if p.get("d_ps")}
vs = sorted({v for c in curves.values() for v in c})
keys = list(curves)
print("| `ua[0]` (V) | " + " | ".join(f"8.3.{e}, {dict((c, l) for c, _, _, l in COND)[c]}" for e, c in keys) + " |")
print("| --- |" + " --- |" * len(keys))
for v in vs:
    print(f"| {v:.2f} | " + " | ".join((f"{curves[k][v]['d_ps']:.1f}" if v in curves[k] else "") for k in keys) + " |")
print("\nPin delay M (`uio_out[4]` to `uio_out[5]`) minus *d*, ps: " + "; ".join(
    f"8.3.{e} {c}: " + ", ".join(f"{curves[(e, c)][v]['M_ps'] - curves[(e, c)][v]['d_ps']:.1f} at {v:g} V" for v in (1.0, 1.8, 3.0) if v in curves[(e, c)]) for e, c in keys))

print("\n### Time constants of the master latches (ps), growth on the cut-out, released to either side\n")
print("| Flip-flop | " + " | ".join(f"8.3.{e}, {l}" for e in ("573", "703") for _, _, _, l in COND) + " |")
print("| --- |" + " --- |" * 6)
T = {e: J(f"{W}/sim/tau/tau_{e}.json") or {} for e in ("573", "703")}
def tau(e, c, v, t, ff):
    a, b = T[e].get(f"{c}_{v}_{t}|{ff}|p"), T[e].get(f"{c}_{v}_{t}|{ff}|m")
    return f"{a['tau_ps']:.2f}, {b['tau_ps']:.2f}" if a and b else ""
for ff, lab in (("dut2", "DUT2"), ("dut3", "DUT3"), ("dut4", "DUT4"), ("n3", "N3"), ("n1", "N1"), ("n2", "N2")):
    print(f"| {lab} | " + " | ".join(tau(e, c, v, t, ff) for e in ("573", "703") for c, v, t, _ in COND) + " |")
def tv(e, c, v, t, ff):
    a = T[e].get(f"{c}_{v}_{t}|{ff}|p"); return a["tau_ps"] if a else None
print("\n| Ratio | " + " | ".join(f"8.3.{e}, {l}" for e in ("573", "703") for _, _, _, l in COND) + " |")
print("| --- |" + " --- |" * 6)
for num, den, lab in (("dut3", "dut2", "DUT3 / DUT2"), ("dut4", "dut2", "DUT4 / DUT2"), ("n3", "dut3", "N3 / DUT3"), ("n2", "n1", "N2 / N1")):
    cells = []
    for e in ("573", "703"):
        for c, v, t, _ in COND:
            a, b = tv(e, c, v, t, num), tv(e, c, v, t, den); cells.append(f"{a / b:.4f}" if a and b else "")
    print(f"| {lab} | " + " | ".join(cells) + " |")

print("\n### Floors in continuous operation (Magic 8.3.573)\n")
print("| Condition | Flip-flop | Data | Floor *d* (ps) | `ua[0]` at the floor (V) | New value at the selector output after the capture edge (ps) | Runs |")
print("| --- | --- | --- | --- | --- | --- | --- |")
for f in sorted(glob.glob(f"{W}/sim/floor/floor_post573_*.json")):
    r = json.load(open(f))
    print(f"| {r['corner']}, {r['vdd']} V, {r['temp']:g} C | DUT{r['dut']} | {'rising' if r['pol'] == 'rise' else 'falling'} | {r['d_floor_ps'][0]:.1f} to {r['d_floor_ps'][1]:.1f}"
          f" | {min(r['V_floor']):.4f} to {max(r['V_floor']):.4f} | {r['arrival_selected_q_ps']:.1f} | {r.get('simulations', '')} |")
fb = sorted(glob.glob(f"{W}/sim/floor/floorbank_post573_*.json"))
if fb:
    print("\n### Floors of the bank (Magic 8.3.573): delay t from the bank's capture edge at the flip-flops to the clock of its early observer\n")
    r0 = json.load(open(fb[0])); print("<!-- keys:", list(r0.keys()), "-->")
    for f in fb:
        r = json.load(open(f)); print("| " + " | ".join(str(r.get(k)) if not isinstance(r.get(k), float) else f"{r[k]:.6g}" for k in r if k not in ("body", "history", "tag")) + " |")
if OUT:
    os.makedirs(OUT, exist_ok=True)
    for pat in ("sim/dly/dly_post*.json", "sim/dly/dly_sens*.json", "sim/tau/tau_*.json", "sim/floor/floor*_post573_*.json", "sim/tchar/tchar_*.json"):
        for f in glob.glob(f"{W}/{pat}"):
            d = json.load(open(f))
            if isinstance(d, dict) and "body" in d: d["body"] = os.path.basename(d["body"])
            json.dump(d, open(f"{OUT}/{os.path.basename(f)}", "w"), indent=1)

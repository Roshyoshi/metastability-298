"""Common parts of the cut-out benches (deck header, sources of the tile pins, running ngspice)."""
import os, re, subprocess, json
PDK = "/usr/local/share/pdk/gf180mcuD/libs.tech/ngspice"

def header(title, body, corner, vdd, temp):
    dlib = "diode_" + corner if corner in ("typical", "ss", "ff") else "diode_typical"
    return [f"* {title}", f".include {PDK}/design.ngspice", f".lib {PDK}/sm141064.ngspice {corner}",
            f".lib {PDK}/sm141064.ngspice {dlib}", ".param sw_stat_global=0 sw_stat_mismatch=0", f".temp {temp}",
            f".include {os.path.abspath(body)}", f"VDD VDPWR 0 {vdd}", "VGND VGND 0 0"]

def pins(vdd, dut=2, data=None, ua0=None, bank=None, clk="0", capture=None, extra=()):
    """Sources on the ports of the cut-out. dut 1..4 selects with {uio_in[6], ui_in[3]}; bank None holds every bank
    pin low (ui_in[7] = 0: the controller side reads the existing selector); bank = dict(sel=0..3, data=..., obs=...)."""
    c0, c1 = (dut - 1) & 1, ((dut - 1) >> 1) & 1
    L = [f"VENA ena 0 {vdd}", f"VCFG0 ui_in[3] 0 {vdd if c0 else 0}", f"VCFG1 uio_in[6] 0 {vdd if c1 else 0}",
         f"VCLK clk 0 {clk}", "VCAPD cap_d 0 0", f"VRSTN rst_n 0 {vdd}", "CL4 uio_out[4] 0 0.2p", "CL5 uio_out[5] 0 0.2p"]
    if data is not None: L.append(f"VDATA ui_in[6] 0 {data}")
    if ua0 is not None: L.append(f"VCTRL ua[0] 0 {ua0}")
    if capture is not None: L.append(f"VFORCE capture 0 {capture}")
    if bank is None:
        L += ["VB7 ui_in[7] 0 0", "VB1 ui_in[1] 0 0", "VB2 ui_in[2] 0 0", "VB5 ui_in[5] 0 0", "VBD uio_in[0] 0 0"]
    else:
        s = bank["sel"]
        L += [f"VB7 ui_in[7] 0 {vdd}", f"VB1 ui_in[1] 0 {vdd if s & 1 else 0}", f"VB2 ui_in[2] 0 {vdd if s & 2 else 0}",
              f"VB5 ui_in[5] 0 {bank.get('obs', 0)}", f"VBD uio_in[0] 0 {bank.get('data', 0)}"]
    return L + list(extra)

def run(deck_path, lines, cwd=None, keep=False, nice=10):
    deck_path = os.path.abspath(deck_path)
    open(deck_path, "w").write("\n".join(lines) + "\n")
    out = subprocess.run(["nice", "-n", str(nice), "ngspice", "-b", deck_path], capture_output=True, text=True,
                         cwd=cwd or os.path.dirname(deck_path)).stdout
    res = {}
    for m in re.finditer(r"^RESULT (\w+) (\S+)", out, re.M):
        try: res[m.group(1)] = float(m.group(2))
        except ValueError: res[m.group(1)] = None
    if not res or keep:
        open(deck_path.replace(".spice", ".log"), "w").write(out)
    return res, out

def jload(p, default=None):
    return json.load(open(p)) if os.path.exists(p) else (default if default is not None else {})

def jsave(p, obj):
    tmp = p + ".tmp"; json.dump(obj, open(tmp, "w"), indent=1); os.replace(tmp, p)

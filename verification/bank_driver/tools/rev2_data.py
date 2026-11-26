#!/usr/bin/env python3
"""Numbers of the layout of 26 Nov 2026 (stronger capture driver of the bank), gathered from the result files of
this workspace, with the corresponding numbers of the layout of e449093. Used by rev2_docs.py.
Run as a script to print everything that is missing."""
import os, json, glob, math, subprocess, sys
W = "/home/claude/work"; R = f"{W}/repo"; S = f"{W}/sim"; B = f"{W}/build"; P = f"{B}/rev2_phys"
sys.path.insert(0, f"{W}/scripts")
from lateness import lateness

K = math.log(math.sqrt(10))
def J(p): return json.load(open(p)) if os.path.exists(p) else None
def results(path):
    if not os.path.exists(path): return None
    d = {}
    for l in open(path, errors="replace"):
        t = l.split()
        if len(t) >= 4 and t[0] == "RESULT":
            try: d[t[2]] = float(t[3])
            except ValueError: d[t[2]] = None
    return d
TAGS = {"core": 3.3, "b1_early": 3.3, "b2_early": 3.3, "b3_early": 3.3, "b2_late": 3.3, "b2_early_ff": 3.6, "b2_early_ss": 3.0}

def ir_summary(d):
    """the numbers of ir_em.py that the documents quote"""
    f4 = [(f, r) for f in ("straps", "end") for r in ("VDPWR", "VGND")]
    return {"avg_uA": round(d["total"]["VDPWR"]["avg_uA"], 2), "peak_mA": round(d["total"]["VDPWR"]["peak_uA"] / 1000, 3),
            "static_mV_max": round(max(d[f][r]["worst_static"]["mV"] for f, r in f4), 3),
            "peak_mV_straps": [round(d["straps"][r]["worst_peak"]["mV"], 2) for r in ("VDPWR", "VGND")],
            "peak_mV_end": [round(d["end"][r]["worst_peak"]["mV"], 2) for r in ("VDPWR", "VGND")],
            "peak_cell": sorted({d[f][r]["worst_peak"]["cell"] for f, r in f4}),
            "em_max": round(max(max(d[f][r]["em_ratio_125C"].values()) for f, r in f4), 4),
            "rail_uA": round(max(d[f][r]["rail_max_avg_uA"] for f, r in f4), 1), "via_uA": round(max(d[f][r]["stack_max_avg_uA"] for f, r in f4), 1),
            "stripe_uA": round(max(d[f][r]["stripe_seg_max_avg_uA"] for f, r in f4), 1)}

def gather():
    V = {"missing": []}
    miss = V["missing"].append
    # ---- whole-tile runs
    V["tile"], V["edges"], V["tile_old"], V["edges_old"] = {}, {}, {}, {}
    for tag, vdd in TAGS.items():
        r = results(f"{S}/rev2/tile/isup_{tag}.results.txt")
        raw = f"{S}/rev2/tile/isup_{tag}.raw"
        if r is None or "events" not in r: miss(f"whole tile {tag}"); continue
        V["tile"][tag] = r
        ej = f"{P}/edges_{tag}.json"
        if not os.path.exists(ej) or os.path.getmtime(ej) < os.path.getmtime(raw):
            out = subprocess.run(["python3", f"{W}/scripts/edges_raw.py", raw, str(vdd), "774.5", "25", ej], capture_output=True, text=True).stdout
            open(f"{P}/edges_{tag}.txt", "w").write(out)
        V["edges"][tag] = J(ej)
        V["tile_old"][tag] = results(f"{R}/verification/bank/tile/post_{tag}.results.txt")
    # edges of the layout of e449093, from the stored whole-tile runs of this workspace (bank on, typical and ff)
    for tag, raw, vdd in (("b2_early", f"{S}/isup/isup_b2.raw", 3.3), ("b2_early_ff", f"{S}/isup/isup_ff.raw", 3.6), ("core", f"{S}/isup/isup_core.raw", 3.3)):
        ej = f"{P}/edges_old_{tag}.json"
        if not os.path.exists(ej) and os.path.exists(raw):
            subprocess.run(["python3", f"{W}/scripts/edges_raw.py", raw, str(vdd), "774.5", "25", ej], capture_output=True, text=True)
        V["edges_old"][tag] = J(ej)
    # ---- supply current and drops
    V["ir"], V["ir_old"] = {}, J(f"{R}/verification/physical/data/physical_summary.json")
    for key, tag, vdd in (("core", "core", 3.3), ("b2", "b2_early", 3.3), ("ff", "b2_early_ff", 3.6)):
        raw = f"{S}/rev2/tile/isup_{tag}.raw"; oj = f"{P}/irem_{key}.json"
        if not os.path.exists(raw) or tag not in V["tile"]: miss(f"supply {key}"); continue
        if not os.path.exists(oj) or os.path.getmtime(oj) < os.path.getmtime(raw):
            out = subprocess.run(["python3", f"{W}/scripts/ir_em.py", raw, f"{S}/rev2/tile/isup_{tag}_probes.json", f"{P}/rail_geom.json", oj, "--vdd", str(vdd)], capture_output=True, text=True).stdout
            open(f"{P}/irem_{key}.txt", "w").write(out)
        V["ir"][key] = J(oj)
    # ---- floors
    V["fb"], V["fb_old"] = {}, {}
    for ff in ("n1", "n2", "n3"):
        for pol in ("rise", "fall"):
            a = J(f"{S}/rev2/floor/floorbank_rev2_typical_3.3_27.0_{ff}{pol}.json"); o = J(f"{S}/floor/floorbank_post573_typical_3.3_27.0_{ff}{pol}.json")
            if a is None: miss(f"bank floor {ff} {pol}")
            else: V["fb"][ff + pol] = a
            V["fb_old"][ff + pol] = o
    V["fd2"] = {}
    for pol in ("rise", "fall"):
        a = J(f"{S}/rev2/floor/floor_rev2_typical_3.3_25.0_d2{pol}.json"); o = J(f"{S}/floor/floor_post573_typical_3.3_25.0_d2{pol}.json")
        mid = lambda x: sum(x["d_floor_ps"]) / 2 if isinstance(x["d_floor_ps"], list) else x["d_floor_ps"]
        if a: V["fd2"][pol] = {"new": mid(a), "old": mid(o), "V_new": a["V_floor"], "V_old": o["V_floor"], "arrival_new": a["arrival_selected_q_ps"], "arrival_old": o["arrival_selected_q_ps"]}
        else: miss(f"floor of DUT2 {pol}")
    # ---- tau, delay
    V["tau"], V["tau_old"] = J(f"{S}/rev2/tau_573.json"), J(f"{S}/tau/tau_573.json")
    V["dly"], V["dly_old"] = J(f"{S}/rev2/dly/dly_rev2_typical_3.3_27.0.json"), J(f"{S}/dly/dly_post573_typical_3.3_27.0.json")
    # ---- captures: as built (e449093), ideal ramp on bank_a (rev2t), recorded waveform of the divider (rev2w)
    V["lat"] = {}
    for key, pat in (("old", f"{S}/tchar/tchar_post573_typical_3.3_27.0_%s.json"), ("ramp", f"{S}/tchar_rev2t/tchar_rev2t_typical_3.3_27.0_%s.json"),
                     ("wave", f"{S}/tchar_rev2w/tchar_rev2w_typical_3.3_27.0_%s.json"), ("fast", f"{S}/tchar_fast/tchar_post573fast_typical_3.3_27.0_%s.json"),
                     ("x9x3", f"{S}/tchar_9x3/tchar_post573drv9x3_typical_3.3_27.0_%s.json"), ("wave_ss", f"{S}/tchar_rev2w/tchar_rev2w_ss_3.0_125.0_%s.json")):
        V["lat"][key] = {}
        for x in ("n2fall", "n2rise", "n1fall", "n1rise"):
            p = pat % x
            if os.path.exists(p):
                L = lateness(p); lc = L["last_crossing_ps"]
                V["lat"][key][x] = dict(L, path=p, total_ps=lc[-1][1] - lc[0][1])       # later at 1.5e-16 s than in the ordinary capture
            elif key == "wave": miss(f"captures with the divider's edge, {x}")
    # count model of N2 with the captures made with the divider's edge (floors as found with the ramp)
    wr, wf = (V["lat"]["wave"].get("n2rise"), V["lat"]["wave"].get("n2fall"))
    cj = f"{S}/rev2/count/count_n2_rev2w.json"
    if wr and wf and "n2rise" in V["fb"] and "n2fall" in V["fb"] and (not os.path.exists(cj) or os.path.getmtime(cj) < max(os.path.getmtime(wr["path"]), os.path.getmtime(wf["path"]))):
        fl = lambda a: sum(a["t_floor_ps"]) / 2
        out = subprocess.run(["python3", f"{W}/scripts/count_model.py", "N2 on the layout of 26 Nov, capture edge of the bank's own divider, typical, 3.3 V, 27 C, Magic 8.3.573; the delay is that of the early clock after the bank capture edge",
                              wr["path"], wf["path"], f"{fl(V['fb']['n2rise']):.2f}", f"{fl(V['fb']['n2fall']):.2f}", f"{V['tau']['typical_3.3_27.0|n2|p']['tau_ps']:.3f}", cj],
                             capture_output=True, text=True, env=dict(os.environ, ABS="1")).stdout
        open(cj.replace(".json", ".txt"), "w").write(out)
    V["count"] = {k: J(f"{S}/rev2/count/count_n2_{k}.json") for k in ("rev2", "rev2w")}
    V["count_old"] = J(f"{S}/count/count_n2.json")
    return V

if __name__ == "__main__":
    V = gather()
    print("missing:", V["missing"])
    for tag, r in V["tile"].items():
        e = V["edges"][tag]["edges_ps"]; rt = V["edges"][tag]["rise_10_90_ps"]
        print(f"{tag:12s} events {r.get('events')}  busy {r.get('busy_V'):.2f} done {r.get('done_V'):.1e} fault {r.get('fault_V'):.1e}  bank_q falling/rising {r.get('bank_q_arrives_falling_ps')} / {r.get('bank_q_arrives_rising_ps')}  clk->bank_cap {e.get('bank_cap')}  rise {rt.get('bank_cap')}  clk->capture_local {e.get('capture_local')}  ui5->obs {e.get('bank_obs_clk')}")
    for k, d in V["ir"].items():
        s_ = ir_summary(d)
        print(k, s_)
    for k, a in V["fb"].items():
        o = V["fb_old"][k]
        print(f"floor {k}: t {sum(a['t_floor_ps'])/2:.1f} (was {sum(o['t_floor_ps'])/2:.1f})  arrival {a['arrival_bank_selected_q_ps']:.1f} (was {o['arrival_bank_selected_q_ps']:.1f})")
    for pol, a in V["fd2"].items(): print("DUT2 floor", pol, a)
    for key, d in V["lat"].items():
        for x, L in d.items():
            print(f"captures {key:5s} {x}: steps {L['steps_ps'][0]:.1f} to {L['steps_ps'][1]:.1f} ps (local {L['steps_ps'][0]/K:.1f} to {L['steps_ps'][1]/K:.1f}), tail {L['tail_ps']:.2f}")

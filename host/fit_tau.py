#!/usr/bin/env python3
"""Fit the slope of ln p against the delay d of the early sample (CPython, on the computer).

p is the fraction of trials that are events. Wherever d is well past the floor (the delay below
which the flip-flop's ordinary new value has not reached the early observer), p falls as
exp(-d / tau), so the slope of ln p against d gives tau.

Input:
  survey.csv       V, dut, events, trials, ... as written by metachar_host.save_csv
  calibration.csv  V, d_ps: the delay at each control voltage, from the oscilloscope on the two
                   monitor pins. The monitor delay M is shorter than d by 75 to 125 ps in the
                   post-layout simulation, and the difference grows with V; either add the simulated
                   d - M to the measured M or carry its slope as a systematic error (about 1 %).

Method: Poisson maximum likelihood. Each count is Poisson with mean trials * exp(a - d / s); the
fit maximises the likelihood over a and s, so settings with few or no events are used correctly.
The standard error comes from the curvature of the likelihood; when the deviance per degree of
freedom is above about 2, the points scatter more than counting allows (the range reaches into the
shoulder above the floor, or the delay drifted), and the error printed with "scaled" is the honest
one.

Fit only the straight part: begin some 300 ps above the floor (the local slopes printed for each
pair of settings must agree within their errors) and end where the counts become too few.

usage:
  fit_tau.py survey.csv calibration.csv --dmin 2900 --dmax 4600      (delays in ps)
  fit_tau.py --selftest
"""
import argparse, csv, math
import numpy as np


def load(survey, calib, source="async"):
    cal = np.array([[float(r["V"]), float(r["d_ps"])] for r in csv.DictReader(open(calib))])
    cal = cal[np.argsort(cal[:, 0])]
    data = {}
    for r in csv.DictReader(open(survey)):
        if r.get("source", "async") != source:
            continue
        v = float(r["V"]); d = float(np.interp(v, cal[:, 0], cal[:, 1]))
        data.setdefault(int(r["dut"]), []).append((d, int(r["events"]), int(r["trials"])))
    return {k: sorted(v) for k, v in data.items()}


def fit(points, dmin=-math.inf, dmax=math.inf):
    """Poisson maximum-likelihood fit of events = trials * exp(a + b (d - d0)), s = -1 / b.
    Returns s (ps), its standard error, the deviance per degree of freedom and the local slopes."""
    pts = [(d, e, n) for d, e, n in points if dmin <= d <= dmax and n > 0]
    if len(pts) < 3 or sum(1 for p in pts if p[1] > 0) < 2:
        raise ValueError("need at least three settings, two of them with events, in the range")
    d = np.array([p[0] for p in pts], float)
    e = np.array([p[1] for p in pts], float)
    n = np.array([p[2] for p in pts], float)
    d0 = float(np.mean(d))
    X = np.vstack([np.ones_like(d), d - d0]).T
    # start: weighted least squares on the settings with events
    m = e > 0
    w = e[m]; y = np.log(e[m] / n[m]); Xm = X[m]
    beta = np.linalg.solve(Xm.T @ (w[:, None] * Xm), Xm.T @ (w * y))
    for _ in range(100):                              # Newton-Raphson on the log-likelihood
        mu = n * np.exp(X @ beta)
        grad = X.T @ (e - mu)
        info = X.T @ (mu[:, None] * X)
        step = np.linalg.solve(info, grad)
        beta = beta + step
        if np.max(np.abs(step)) < 1e-12:
            break
    mu = n * np.exp(X @ beta)
    cov = np.linalg.inv(X.T @ (mu[:, None] * X))
    with np.errstate(divide="ignore", invalid="ignore"):
        dev = 2 * np.sum(np.where(e > 0, e * np.log(e / mu), 0.0) - (e - mu))
    dof = len(pts) - 2
    b = beta[1]
    s = -1.0 / b
    ds = math.sqrt(cov[1, 1]) / b ** 2
    disp = dev / dof if dof > 0 else float("nan")
    local = []
    for i in range(len(d) - 1):
        if e[i] > 0 and e[i + 1] > 0 and e[i] / n[i] != e[i + 1] / n[i + 1]:
            local.append(-(d[i + 1] - d[i]) / (math.log(e[i + 1] / n[i + 1]) - math.log(e[i] / n[i])))
    return {"slope_ps": s, "err_ps": ds, "err_scaled_ps": ds * math.sqrt(max(1.0, disp)),
            "deviance_dof": disp, "n_points": len(pts), "local_slopes_ps": local,
            "ln_p_at_d0": beta[0], "d0_ps": d0}


def ratio(f1, f2, key="err_ps"):
    r = f1["slope_ps"] / f2["slope_ps"]
    return r, r * math.hypot(f1[key] / f1["slope_ps"], f2[key] / f2["slope_ps"])


def simulate(rng, s, d_values, p0, d_ref, target_events=300, max_trials=65_535 * 300_000):
    """Counts from a straight tail p = p0 exp(-(d - d_ref) / s), each setting run in whole blocks
    of 65,535 trials until about target_events are expected (the way survey() runs)."""
    pts = []
    for d in d_values:
        p = p0 * math.exp(-(d - d_ref) / s)
        blocks = max(1, min(max_trials // 65_535, int(math.ceil(target_events / (p * 65_535)))))
        trials = blocks * 65_535
        pts.append((float(d), int(rng.poisson(p * trials)), trials))
    return pts


def selftest(seed=1, repeats=400):
    """Synthetic counts (clearly not measurements) from straight tails with the post-layout time
    constants, then the fit. Checks that the fit is unbiased and that its error bars cover the
    truth about 68 % of the time."""
    rng = np.random.default_rng(seed)
    truth = {2: 142.6, 3: 119.2, 4: 169.2}
    d_values = np.arange(3000.0, 4601.0, 200.0)
    for dut, s in truth.items():
        f = fit(simulate(rng, s, d_values, 1e-2, 3000.0))
        print(f"dut{dut}: true {s:.1f} ps, fitted {f['slope_ps']:.2f} +/- {f['err_ps']:.2f} ps, "
              f"deviance/dof {f['deviance_dof']:.2f}")
    pulls, rs = [], []
    for _ in range(repeats):
        f2 = fit(simulate(rng, truth[2], d_values, 1e-2, 3000.0))
        f3 = fit(simulate(rng, truth[3], d_values, 1e-2, 3000.0))
        pulls.append((f2["slope_ps"] - truth[2]) / f2["err_ps"])
        r, dr = ratio(f3, f2)
        rs.append((r - truth[3] / truth[2]) / dr)
    pulls, rs = np.array(pulls), np.array(rs)
    print(f"{repeats} repeats: slope pull mean {pulls.mean():+.3f}, sd {pulls.std():.3f}; "
          f"ratio pull mean {rs.mean():+.3f}, sd {rs.std():.3f}; "
          f"covered within 1 sigma {np.mean(np.abs(pulls) < 1):.2f}")
    assert abs(pulls.mean()) < 0.2 and 0.85 < pulls.std() < 1.15
    assert abs(rs.mean()) < 0.2 and 0.85 < rs.std() < 1.15
    print("selftest passed")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("survey", nargs="?"); ap.add_argument("calibration", nargs="?")
    ap.add_argument("--dmin", type=float, default=-math.inf); ap.add_argument("--dmax", type=float, default=math.inf)
    ap.add_argument("--selftest", action="store_true")
    a = ap.parse_args()
    if a.selftest:
        selftest(); return
    data = load(a.survey, a.calibration)
    fits = {}
    for dut in sorted(data):
        try:
            fits[dut] = fit(data[dut], a.dmin, a.dmax)
        except ValueError as ex:
            print(f"dut{dut}: {ex}"); continue
        f = fits[dut]
        print(f"dut{dut}: slope {f['slope_ps']:.1f} +/- {f['err_ps']:.1f} ps (scaled {f['err_scaled_ps']:.1f}) "
              f"over {f['n_points']} settings, deviance/dof {f['deviance_dof']:.2f}")
        print("   local slopes (ps): " + ", ".join(f"{x:.0f}" for x in f["local_slopes_ps"]))
        if f["deviance_dof"] > 2:
            print("   WARNING: the points scatter more than counting allows; the range may reach into "
                  "the shoulder, or the delay drifted")
    for num in (3, 4, 1):
        if 2 in fits and num in fits:
            print("DUT%d/DUT2 = %.3f +/- %.3f" % ((num,) + ratio(fits[num], fits[2], "err_scaled_ps")))


if __name__ == "__main__":
    main()

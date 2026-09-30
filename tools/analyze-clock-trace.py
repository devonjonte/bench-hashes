#!/usr/bin/env python3
"""The clock each sample ran at, in a bench-hashes --trace-clocks CSV.

Each sample carries its wall time and the thread's cycles, instructions,
and time on P-cores and E-cores (Apple; zeros where the platform counts
none). The script reports where the samples ran (P-cores, E-cores, split),
the distribution of their frequency (cycles over time), each cell's
fastest and slowest sample beside the frequency it ran at, and windows of
consecutive samples more than 5% off the median frequency: a boost or a
throttle, the variable no clock sees.

Usage: analyze-clock-trace.py TRACE.csv
"""

import csv
import sys
from collections import defaultdict


def report_frequency(rows, cell_wall_median):
    """The clock frequency each sample ran at, from per-perf-level cycles
    and time, and how it relates to the sample's wall time."""
    on_e = [r for r in rows if r["e_time"] > r["p_time"]]
    mixed = [r for r in rows if r["e_time"] and r["p_time"] and r["e_time"] <= r["p_time"]]
    print(f"\nCore placement: {len(rows) - len(on_e) - len(mixed)} samples wholly on P-cores, "
          f"{len(mixed)} split P/E (mostly P), {len(on_e)} mostly or wholly on E-cores")

    freqs = []
    for r in rows:
        cyc = r["p_cycles"] + r["e_cycles"]
        t = r["p_time"] + r["e_time"]
        r["ghz"] = cyc / t if t else 0.0          # cycles per ns = GHz
        r["ipc"] = (r["p_instr"] + r["e_instr"]) / cyc if cyc else 0.0
        if r["ghz"]:
            freqs.append(r["ghz"])
    if not freqs:
        return
    freqs.sort()
    n = len(freqs)
    print(f"Clock frequency over the run (cycles ÷ CPU time): min {freqs[0]:.3f} GHz, "
          f"p5 {freqs[n // 20]:.3f}, median {freqs[n // 2]:.3f}, p95 {freqs[n - 1 - n // 20]:.3f}, max {freqs[-1]:.3f}")
    med = freqs[n // 2]
    fast = [r for r in rows if r["ghz"] > med * 1.05]
    slow = [r for r in rows if r["ghz"] and r["ghz"] < med * 0.95]
    print(f"  {len(fast)} samples ran >5% above the median frequency, {len(slow)} ran >5% below")

    # Does frequency explain the wall-time extremes? For each cell's fastest
    # and slowest sample, show its frequency next to the cell median.
    print("\nPer-cell wall extremes with the frequency they ran at (cell median frequency in brackets):")
    cells = {}
    for r in rows:
        cells.setdefault((r["contender"], r["size"]), []).append(r)
    print(f"  {'contender':<12} {'size':>8}  {'fastest wall/med':>16} {'@GHz':>6}   {'slowest wall/med':>16} {'@GHz':>6}   [cell GHz]")
    for (c, sz), rs in sorted(cells.items(), key=lambda kv: (kv[0][1], kv[0][0])):
        rs_f = sorted(r["ghz"] for r in rs if r["ghz"])
        cell_ghz = rs_f[len(rs_f) // 2] if rs_f else 0
        med_w = cell_wall_median[(c, sz)]
        fmin = min(rs, key=lambda r: r["wall"])
        fmax = max(rs, key=lambda r: r["wall"])
        if fmin["wall"] / med_w < 0.95 or fmax["wall"] / med_w > 1.08:
            print(f"  {c:<12} {sz:>8}  {fmin['wall'] / med_w:16.3f} {fmin['ghz']:6.2f}   "
                  f"{fmax['wall'] / med_w:16.3f} {fmax['ghz']:6.2f}   [{cell_ghz:.2f}]")

    # Consecutive windows of off-median frequency: the shape of a boost or throttle.
    off = [r for r in rows if r["ghz"] and abs(r["ghz"] / med - 1) > 0.05]
    if off:
        windows = []
        cur = [off[0]]
        for a, b in zip(off, off[1:]):
            if b["round"] == a["round"] and b["position"] == a["position"] + 1:
                cur.append(b)
            else:
                windows.append(cur)
                cur = [b]
        windows.append(cur)
        multi = [w for w in windows if len(w) >= 2]
        print(f"\nWindows of ≥2 consecutive samples at a frequency >5% off the median: {len(multi)}")
        for w in multi[:8]:
            g = [r["ghz"] for r in w]
            print(f"  round {w[0]['round']}, positions {w[0]['position']}–{w[-1]['position']}, {len(w)} samples, "
                  f"{sum(r['wall'] for r in w) / 1e6:.1f} ms: {min(g):.2f}–{max(g):.2f} GHz "
                  f"({'boost' if g[0] > med else 'throttle'}); contenders {', '.join(sorted(set(r['contender'] for r in w)))}; "
                  f"sizes {min(r['size'] for r in w)}–{max(r['size'] for r in w)} B")
        if len(multi) > 8:
            print(f"  … and {len(multi) - 8} more")
    print()


def main():
    if len(sys.argv) != 2:
        print(__doc__)
        sys.exit(2)
    path = sys.argv[1]
    rows = []
    after_idle = 0
    with open(path) as handle:
        for row in csv.DictReader(handle):
            # Preparation has its own rows and clocks; keep it apart from
            # the hashing intervals this analysis describes.
            if row.get("scenario", "").startswith("preparation"):
                continue
            # After-idle bursts (traces from September 27, 2026) are not rounds.
            if row.get("scenario") == "after idle":
                after_idle += 1
                continue
            rows.append({
                "round": int(row["round"]),
                "position": int(row["position"]),
                "contender": row["contender"],
                "size": int(row["size_bytes"]),
                "wall": int(row["wall_ns"]),
                "p_cycles": int(row["p_cycles"]),
                "p_time": int(row["p_time_ns"]),
                "e_cycles": int(row["e_cycles"]),
                "e_time": int(row["e_time_ns"]),
                "p_instr": int(row["p_instructions"]),
                "e_instr": int(row["e_instructions"]),
            })
    rows.sort(key=lambda r: (r["round"], r["position"]))
    print(f"{len(rows)} samples from {path}" + (f" (and {after_idle} after-idle bursts, left out)" if after_idle else ""))
    if not any(r["p_cycles"] or r["e_cycles"] for r in rows):
        print("No cycle counts: this platform gives none.")
        return
    cell_wall = defaultdict(list)
    for r in rows:
        cell_wall[(r["contender"], r["size"])].append(r["wall"])
    report_frequency(rows, {k: sorted(v)[len(v) // 2] for k, v in cell_wall.items()})


if __name__ == "__main__":
    main()

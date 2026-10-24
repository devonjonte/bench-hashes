#!/usr/bin/env python3
"""Where the shared lent 64 B window (thread stack +3472..+3520) ranked in
each repeat's scan, and what the rescans read."""
import pathlib
import statistics
import sys

sys.path.insert(0, "/home/agent/BLAKE3-offset-check/tools")
import offset_check as oc

CELL = ("shared", "Messages one after another, buffers lent (ns/B)", "64 B")
for keep in sorted(pathlib.Path(".").glob("repeat-*")):
    stages = {}
    for stage in ("scan", "rescan1", "rescan2"):
        stages[stage] = {d.name: oc.parse_report(next(d.glob("benchmark-results/*/bench-hashes.result.txt")).read_text()).get(CELL)
                         for d in (keep / stage).iterdir()}
    scan = {k: v for k, v in stages["scan"].items() if v}
    median = statistics.median(scan.values())
    ranked = sorted(scan, key=scan.get, reverse=True)
    window = [n for n in scan if n.startswith("thread-stack+") and 3472 <= int(n.split("+")[1]) <= 3520]
    ranks = sorted(ranked.index(n) + 1 for n in window)
    top3 = ranked[:3]
    print(f"{keep.name}: median {median:.3f}; window ranks {ranks}; top 3 {', '.join(f'{n} {scan[n]:.3f}' for n in top3)}")
    for n in top3:
        reads = [stages[s].get(n) for s in ("scan", "rescan1", "rescan2")]
        print(f"   {n}: " + ", ".join(f"{r:.3f}" if r else "-" for r in reads))

#!/usr/bin/env python3
"""perf stat of one bench cell, old and new alternating; medians per event and the cell's ns/B.
usage: stat.py PAIRS OLD_EXE NEW_EXE"""
import subprocess, sys, statistics, os, shutil, glob, re
pairs, old, new = int(sys.argv[1]), sys.argv[2], sys.argv[3]
EV = ["cpu_core/cycles/", "cpu_core/instructions/", "cpu_core/mem_load_l3_hit_retired.xsnp_fwd/",
      "cpu_core/mem_load_l3_hit_retired.xsnp_no_fwd/", "cpu_core/ocr.demand_rfo.l3_hit.snoop_hitm/",
      "cpu_core/machine_clears.memory_ordering/", "cpu_core/L1-dcache-load-misses/", "cpu_atom/cycles/"]
ARGS = ["--contenders", "blake3-servil-mt", "--points", "continuous 64 B", "--rounds", "96"]
res = {"old": [], "new": []}
for i in range(pairs):
    for side, exe in ((("old", old), ("new", new)) if i % 2 == 0 else (("new", new), ("old", old))):
        d = f"/home/agent/tmp/wc-{side}"; shutil.rmtree(d, ignore_errors=True); os.makedirs(d)
        p = subprocess.run(["perf", "stat", "-x", ";", "-e", ",".join(EV), "--", exe] + ARGS, cwd=d, capture_output=True, text=True)
        row = {}
        for l in p.stderr.split("\n"):
            f = l.split(";")
            if len(f) > 3 and f[0].strip().isdigit(): row[f[2]] = int(f[0])
        t = glob.glob(d + "/benchmark-results/*/bench-hashes.result.txt")
        txt = open(t[0]).read() if t else ""
        m = re.search(r"^\s*64 B\s+([0-9.]+)", txt, re.M)
        row["ns/B"] = float(m.group(1)) if m else float("nan")
        res[side].append(row)
keys = EV + ["ns/B"]
print(f"{'event':52} {'old':>16} {'new':>16}  new/old")
for k in keys:
    o = statistics.median(r.get(k, 0) for r in res["old"]); n = statistics.median(r.get(k, 0) for r in res["new"])
    print(f"{k:52} {o:16,.3f} {n:16,.3f}  x{(n / o if o else float('nan')):.3f}")

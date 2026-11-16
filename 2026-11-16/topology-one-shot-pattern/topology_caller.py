#!/usr/bin/env python3
"""Diagnostic for BLAKE3 #401: the calling thread's own counters in the kept runs of the
topology change (new) against its parent (old). Per cell: wall time, and the caller's
cycles and instructions (the multithreaded cells record the caller's counters only).
Medians of each run's samples, then over runs. A reading aid; the verdicts are the check's."""
from pathlib import Path
import statistics, sys

def cells(path):
    out = {}
    for line in Path(path).read_text().splitlines():
        if line.startswith("#") or line.startswith("contender\t"):
            continue
        f = line.split("\t")
        if ":" not in f[9]:
            continue
        samples = [[int(x) for x in s.split(":")[:3]] for s in f[9].split(",") if s]
        out["|".join(f[:4])] = [statistics.median(s[i] for s in samples) for i in range(3)]
    return out

def side(folder, which):
    runs = [cells(p) for p in sorted(Path(folder).glob(f"run-*-{which}.tsv"))]
    return {k: [statistics.median(r[k][i] for r in runs) for i in range(3)] for k in runs[0] if all(k in r for r in runs)}

folder, wanted = sys.argv[1], sys.argv[2:]
old, new = side(folder, "old"), side(folder, "new")
print("| cell | wall, old → new | caller's cycles | caller's instructions | caller's cycles per wall ns, old → new |\n|---|---:|---:|---:|---:|")
for k in old:
    if k in new and any(w in k for w in wanted):
        o, n = old[k], new[k]
        print(f"| `{k}` | {o[0]/1e3:.0f} → {n[0]/1e3:.0f} μs ×{n[0]/o[0]:.3f} | ×{n[1]/o[1]:.3f} | {o[2]/1e6:.2f}M → {n[2]/1e6:.2f}M ×{n[2]/o[2]:.3f} | {o[1]/o[0]:.2f} → {n[1]/n[0]:.2f} |")

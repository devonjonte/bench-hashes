#!/usr/bin/env python3
"""Read smt-probe-237's runs.txt: per arm, each process's messages a second (sorted), the median,
the spread, and the CPU time of threads that last ran on CPU 24 (the caller's sibling)."""
import re, statistics as st, sys
arms = {}
for line in open(sys.argv[1]):
    p = line.split()
    rate = float(p[2])
    sib = sum(float(m) for m in re.findall(r"blake3-worker-\d+@24:(\d+)ms", line))
    workers = [float(m) for m in re.findall(r"blake3-worker-\d+@\d+:(\d+)ms", line)]
    arms.setdefault(p[0], []).append((rate, sib, len(workers), sum(workers)))
for arm, runs in arms.items():
    rates = sorted(r[0] for r in runs)
    med = st.median(rates)
    print(f"{arm:8} n={len(runs)} median {med:.0f} min {rates[0]:.0f} max {rates[-1]:.0f} spread {100 * (rates[-1] - rates[0]) / med:.1f}%  workers {runs[0][2]}  worker CPU ms/process median {st.median(r[3] for r in runs):.0f}  processes with a worker last on CPU 24: {sum(1 for r in runs if r[1] > 0)} (its CPU ms median {st.median([r[1] for r in runs if r[1] > 0] or [0]):.0f})")
    print("   ", " ".join(f"{r:.0f}" for r in rates))
w, wo = st.median(r[0] for r in arms["with"]), st.median(r[0] for r in arms["without"])
print(f"with / without medians: {w / wo:.3f}")

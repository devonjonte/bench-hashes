#!/usr/bin/env python3
"""Every cell's new/old ratio (geometric mean of its pairs) from a kept
regress directory, sorted: python3 all_cell_ratios.py DIR [FILTER]. A
diagnostic reading of the samples; regress itself is the judge."""
import importlib.util, pathlib, statistics, sys
spec = importlib.util.spec_from_file_location("cr", "/home/agent/bench-hashes-validation/cell_ratios.py")
src = open("/home/agent/bench-hashes-validation/cell_ratios.py").read().split("\nroot = ")[0]
ns = {}; exec(src, ns); means = ns["means"]
root = pathlib.Path(sys.argv[1]); filt = sys.argv[2] if len(sys.argv) > 2 else ""
old = [means(p) for p in sorted(root.glob("run-*-old.tsv"))]
new = [means(p) for p in sorted(root.glob("run-*-new.tsv"))]
cells = sorted(set(old[0]) & set(new[0]))
rows = []
for c in cells:
    if filt not in c: continue
    r = [n[c] / o[c] for o, n in zip(old, new) if c in o and c in n]
    g = statistics.geometric_mean(r) - 1
    rows.append((g, c, sum(x > 1 for x in r), len(r)))
for g, c, slower, n in sorted(rows):
    print(f"{g:+7.1%}  slower in {slower}/{n}  {c}")

#!/usr/bin/env python3
"""Per use case: the median over its cells of the first stage's ratio, the share of cells above +1%, and a sign test (exploration)."""
import sys, math, statistics as st
from collections import defaultdict
from runs import pairs
ps = pairs(sys.argv[1])
by = defaultdict(list)
for key in ps[0][0]:
    if not all(key in o and key in n for o, n in ps): continue
    rs = [math.log(n[key][0] / o[key][0]) for o, n in ps]
    by[key.split('|')[2]].append((st.mean(rs), st.stdev(rs)))
print(f"{'use case':28s} cells  median    quartiles        cells>+1%  cells<-1%   median pair SD")
for u, v in sorted(by.items()):
    m = sorted(x[0] for x in v); q = lambda f: 100 * (math.exp(m[min(len(m) - 1, int(f * len(m)))]) - 1)
    print(f"{u:28s} {len(v):4d}  {q(0.5):+5.1f}%   {q(0.25):+5.1f}% .. {q(0.75):+5.1f}%   {sum(x > 0.01 for x in m):4d}       {sum(x < -0.01 for x in m):4d}       {100*st.median(x[1] for x in v):4.1f}%")

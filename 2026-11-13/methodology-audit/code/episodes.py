#!/usr/bin/env python3
"""Per kept directory: how often a sample exceeds 1.8x (and 3x) its cell's median within its run, by use case (exploration)."""
import sys, os, re, statistics as st
from collections import defaultdict
d = sys.argv[1]
tot = defaultdict(lambda: [0, 0, 0, 0])  # samples, >1.8x, >3x, cells with any >1.8x
for p in sorted(os.listdir(d)):
    if not re.match(r'run-\d+-(old|new)\.tsv', p): continue
    for line in open(os.path.join(d, p)):
        if line.startswith('#') or line.startswith('contender'): continue
        f = line.rstrip('\n').split('\t')
        v = [int(s.split('/')[0]) / int(s.split('/')[1]) for s in f[5].split(',')]
        if len(v) < 6: continue
        m = st.median(v); a = sum(x > 1.8 * m for x in v); b = sum(x > 3 * m for x in v)
        t = tot[f[2]]; t[0] += len(v); t[1] += a; t[2] += b; t[3] += (a > 0)
print(f"{'use case':28s} samples  >1.8x median   >3x")
for u, (n, a, b, c) in sorted(tot.items()):
    print(f"{u:28s} {n:7d}  {100*a/n:5.2f}%        {100*b/n:5.2f}%")

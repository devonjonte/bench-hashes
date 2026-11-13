#!/usr/bin/env python3
"""Where a machine counts them: each cell's wall ratio beside its cycles and instructions ratios over the pairs (exploration)."""
import sys, os, re, math, statistics as st
def read(path):
    cells = {}
    for line in open(path):
        if line.startswith('#') or line.startswith('contender'): continue
        f = line.rstrip('\n').split('\t')
        if len(f) < 10 or f[9] in ('-', ''): continue
        ns = units = cyc = ins = ptime = 0
        for s, c in zip(f[5].split(','), f[9].split(',')):
            a, b = s.split('/'); ns += int(a); units += int(b)
            v = [int(x) for x in c.split(':')]
            ptime += v[0] + v[5]; cyc += v[1] + v[6]; ins += v[2] + v[7]
        if cyc: cells['|'.join(f[:4])] = (ns / units, cyc / units, ins / units, cyc / max(ptime, 1))
    return cells
d = sys.argv[1]; pat = sys.argv[2]
runs = sorted(p for p in os.listdir(d) if re.match(r'run-\d+-(old|new)\.tsv', p))
olds = [read(os.path.join(d, p)) for p in runs if p.endswith('-old.tsv')]; news = [read(os.path.join(d, p)) for p in runs if p.endswith('-new.tsv')]
for key in olds[0]:
    if not re.search(pat, key) or not all(key in r for r in olds + news): continue
    g = lambda i: 100 * (math.exp(st.mean(math.log(n[key][i] / o[key][i]) for o, n in zip(olds, news))) - 1)
    print(f"{key:56s} wall {g(0):+6.1f}%  cycles {g(1):+6.1f}%  instructions {g(2):+6.2f}%   clock GHz old {st.mean(o[key][3] for o in olds):.2f} new {st.mean(n[key][3] for n in news):.2f}")

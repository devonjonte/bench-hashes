#!/usr/bin/env python3
"""E2: one summary per arm of the NUMA experiment (exploration): each cell's level, its pairs' spread, its slow samples."""
import sys, os, re, math, statistics as st
from runs import pairs
from pred import timeline
root = sys.argv[1]
arms = [a for a in ['normal', 'policy-node0', 'policy', 'node0'] if os.path.isdir(f'{root}/kept-{a}')]
table = {}
for a in arms:
    d = f'{root}/kept-{a}'; ps = pairs(d)
    for key in ps[0][0]:
        if not all(key in o and key in n for o, n in ps): continue
        rs = [math.log(n[key][0] / o[key][0]) for o, n in ps]
        allv = [x for o, n in ps for x in (o[key][1] + n[key][1])]
        med = st.median(allv)
        table.setdefault(key, {})[a] = (st.mean([o[key][0] for o, n in ps] + [n[key][0] for o, n in ps]), 100 * (math.exp(st.mean(rs)) - 1), 100 * st.stdev(rs), 100 * sum(x > 1.8 * med for x in allv) / len(allv), med)
print('cell' + ' ' * 44 + ''.join(f"| {a:^38s} " for a in arms))
print(' ' * 48 + ''.join("|  mean   median  new/old  pairSD  >1.8x " for a in arms))
for key, row in table.items():
    print(f"{key.replace('blake3-servil-st|solo|',''):48s}" + ''.join((f"| {row[a][0]:6.3f} {row[a][4]:7.3f}  {row[a][1]:+6.1f}% {row[a][2]:5.1f}% {row[a][3]:5.1f}% " if a in row else '|' + ' ' * 39) for a in arms))
for a in arms:
    d = f'{root}/kept-{a}'
    for p in sorted(os.listdir(d))[:3]:
        if not p.startswith('run-'): continue
        ev = [e for e in timeline(f'{d}/{p}') if e[1] == 'blake3-servil-st|solo|InterleavedTurn|256']
        cpu = next((re.match(r'# measuring thread: pinned to CPU (\d+)', l).group(1) for l in open(f'{d}/{p}') if l.startswith('# measuring thread: pinned')), '?')
        print(f"{a:13s} {p[:11]} cpu {cpu:>3}: " + ' '.join(f"{e[2]/1000:.0f}" for e in ev))

#!/usr/bin/env python3
"""Read a group-484-probe folder: for each cell, the medians of the eight
runs' ns per group at each commit, and the ratio new/old over the eight
pairs (geometric mean, least, greatest, and how many pairs read slower)."""
import math, statistics, sys
d = sys.argv[1]
data = {}
for pair in range(1, 9):
    for v in ('old', 'new'):
        for line in open(f'{d}/pair-{pair}-{v}.tsv').read().strip().split('\n'):
            name, median, _fastest = line.split('\t')
            data.setdefault(name, {}).setdefault(v, []).append(float(median))
print('| Group | old, ns | new, ns | new / old | pairs: least to greatest | pairs slower |')
print('|---|---|---|---|---|---|')
for name, vv in data.items():
    ratios = [n / o for n, o in zip(vv['new'], vv['old'])]
    g = math.exp(sum(map(math.log, ratios)) / len(ratios))
    count, length = name.split('x')
    print(f'| {count} x {length} B | {statistics.median(vv["old"]):.1f} | {statistics.median(vv["new"]):.1f} | {g:.3f} | {min(ratios):.3f} to {max(ratios):.3f} | {sum(r > 1 for r in ratios)} of 8 |')

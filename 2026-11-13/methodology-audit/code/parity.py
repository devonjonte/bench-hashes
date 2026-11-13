#!/usr/bin/env python3
"""Pair ratios of a kept check directory by the CPU each pair was pinned to (exploration; verdicts stay the Rust tools')."""
import sys, os, re, math, statistics as st
from runs import read
def pinned(path):
    for line in open(path):
        m = re.match(r'# measuring thread: pinned to CPU (\d+)', line)
        if m: return int(m.group(1))
        if not line.startswith('#'): break
    return None
d = sys.argv[1]; pat = sys.argv[2] if len(sys.argv) > 2 else ''
runs = sorted(p for p in os.listdir(d) if re.match(r'run-\d+-(old|new)\.tsv', p))
olds = [os.path.join(d, p) for p in runs if p.endswith('-old.tsv')]; news = [os.path.join(d, p) for p in runs if p.endswith('-new.tsv')]
P = [(pinned(o), pinned(n), read(o), read(n)) for o, n in zip(olds, news)]
assert all(a == b for a, b, _, _ in P), 'a pair shares its CPU'
print('pairs', len(P), 'CPUs used:', sorted(set(a for a, *_ in P)))
for key in P[0][2]:
    if pat and not re.search(pat, key): continue
    rows = [(c, math.log(n[key][0] / o[key][0]), o[key][0], n[key][0]) for c, _, o, n in P if key in o and key in n]
    def summ(rs):
        v = [r[1] for r in rs]
        return f"n {len(v):2d} mean {100*(math.exp(st.mean(v))-1):+6.1f}% sd {100*st.stdev(v):5.1f}% se {100*st.stdev(v)/math.sqrt(len(v)):4.1f}%  old {st.mean(r[2] for r in rs):.3f} new {st.mean(r[3] for r in rs):.3f} ns/unit" if len(v) > 1 else f"n {len(v)}"
    print(key); print('   all  ', summ(rows)); print('   even ', summ([r for r in rows if r[0] % 2 == 0])); print('   odd  ', summ([r for r in rows if r[0] % 2 == 1]))
    by = {}
    for r in rows: by.setdefault(r[0], []).append(r)
    print('   by CPU: ' + '  '.join(f"{c}:{100*(math.exp(st.mean(x[1] for x in rs))-1):+.0f}%/sd{100*(st.stdev([x[1] for x in rs]) if len(rs)>1 else 0):.0f}/old{st.mean(x[2] for x in rs):.2f}" for c, rs in sorted(by.items())))

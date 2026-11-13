#!/usr/bin/env python3
"""Exploration plumbing for the methodology audit: a kept check directory's run means per cell and per-pair ratios.
Verdicts stay the Rust tools' (`bench-hashes compare`); this prints what they do not: each pair's ratio."""
import sys, math, os, re, statistics as st
def read(path):
    cells = {}
    for line in open(path):
        if line.startswith('#') or line.startswith('contender'): continue
        f = line.rstrip('\n').split('\t')
        if len(f) < 6: continue
        key = '|'.join(f[:4])
        ns = units = 0
        vals = []
        for s in f[5].split(','):
            a, b = s.split('/')
            ns += int(a); units += int(b); vals.append(int(a) / int(b))
        cells[key] = (ns / units, vals)
    return cells
def pairs(d):
    runs = sorted(p for p in os.listdir(d) if re.match(r'run-\d+-(old|new)\.tsv', p))
    olds = [os.path.join(d, p) for p in runs if p.endswith('-old.tsv')]
    news = [os.path.join(d, p) for p in runs if p.endswith('-new.tsv')]
    assert len(olds) == len(news)
    # run-001-old, 002-new, 003-new, 004-old ...: the i-th old with the i-th new
    return [(read(o), read(n)) for o, n in zip(olds, news)]
if __name__ == '__main__':
    d = sys.argv[1]; pat = sys.argv[2] if len(sys.argv) > 2 else ''
    ps = pairs(d)
    for key in ps[0][0]:
        if pat and not re.search(pat, key): continue
        if not all(key in o and key in n for o, n in ps): continue
        rs = [math.log(n[key][0] / o[key][0]) for o, n in ps]
        m = st.mean(rs); sd = st.stdev(rs) if len(rs) > 1 else 0
        print(f"{key:58s} mean {100*(math.exp(m)-1):+6.1f}%  sd {100*sd:5.1f}  pairs " + ' '.join(f"{100*(math.exp(r)-1):+.1f}" for r in rs[:8]) + f"   old runs ns/unit " + ' '.join(f"{o[key][0]:.3g}" for o, n in ps[:4]) + " | new " + ' '.join(f"{n[key][0]:.3g}" for o, n in ps[:4]))

#!/usr/bin/env python3
"""For one cell of a run: each sample's time beside the cells sampled just before it (exploration)."""
import sys, re, statistics as st
def timeline(path):
    ev = []
    for line in open(path):
        if line.startswith('#') or line.startswith('contender'): continue
        f = line.rstrip('\n').split('\t')
        key = '|'.join(f[:4]); samples = f[5].split(','); starts = f[6].split(',')
        if len(starts) != len(samples): continue
        for s, t in zip(samples, starts):
            a, b = s.split('/'); ev.append((float(t), key, int(a), int(b)))
    ev.sort(key=lambda e: e[0])
    return ev
if __name__ == '__main__':
    path, target = sys.argv[1], sys.argv[2]
    ev = timeline(path)
    for i, (t, key, ns, units) in enumerate(ev):
        if key != target: continue
        prev = [e for e in ev[max(0, i - 3):i]]
        print(f"{t:10.0f} ms  {ns:8d} ns   after: " + '  <-  '.join(f"{p[1].split('|',1)[1]} ({t-p[0]:.0f} ms before, {p[2]} ns)" for p in reversed(prev)))

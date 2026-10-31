"""Exploratory reader (the bench's mean: total ns over total units, every
sample; k-th old paired with k-th new, as regress zips them)."""
import glob, math, re, sys
from collections import defaultdict
def means(path):
    out = {}
    for line in open(path):
        if line.startswith('#') or line.startswith('contender'):
            continue
        f = line.rstrip('\n').split('\t')
        if len(f) < 6 or '/' not in f[5]:
            continue
        ns = units = 0
        for s in f[5].split(','):
            a, b = s.split('/'); ns += int(a); units += int(b)
        out['|'.join(f[:4])] = ns / units
    return out
def pairs(d):
    old = sorted(glob.glob(d + '/run-*-old.tsv')); new = sorted(glob.glob(d + '/run-*-new.tsv'))
    return [(means(o), means(n)) for o, n in zip(old, new)]
def logratios(dirs):
    lr = defaultdict(list)
    for d in dirs:
        for o, n in pairs(d):
            for k in o:
                if k in n:
                    lr[k].append(math.log(n[k] / o[k]))
    return lr
def family(k):
    c, s, u, p = k.split('|'); return f'{c.split("-")[-1]} {s} {u}'
def t_sf2(t, df):
    """Two-sided p of Student's t, by numeric integration of the density."""
    t = abs(t); c = math.exp(math.lgamma((df+1)/2) - math.lgamma(df/2)) / math.sqrt(df*math.pi)
    f = lambda x: c * (1 + x*x/df) ** (-(df+1)/2)
    # integrate t..inf by substitution x = t + u/(1-u)
    N = 4000; s = 0.0
    for i in range(N):
        u = (i + 0.5) / N; x = t + u/(1-u); s += f(x) / (1-u)**2
    return 2 * s / N
def t_crit(p, df):
    lo, hi = 0.0, 1e4
    for _ in range(200):
        mid = (lo+hi)/2
        if t_sf2(mid, df) > p: lo = mid
        else: hi = mid
    return (lo+hi)/2

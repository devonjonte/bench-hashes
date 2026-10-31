"""Samples whose core ran few of their cycles (exploratory).

A sample is "stopped" when its thread's clock (cycles over time on core,
both from the samples file's core counts) falls below half its cell-run's
median clock: the core spent that time on something else (kernel time
on this thread's behalf, or an interrupt). Reads every run's samples and
compares cell-run spreads with stopped samples kept (the bench's rule) and
left out (what retaking them would give)."""
import glob, math, statistics, sys
from collections import defaultdict
def rows(path):
    for line in open(path):
        f = line.rstrip('\n').split('\t')
        if len(f) < 10 or '/' not in f[5] or line.startswith('contender') or f[9] == '-':
            continue
        s = [tuple(map(int, x.split('/'))) for x in f[5].split(',')]
        c = [tuple(map(int, x.split(':'))) for x in f[9].split(',')]
        if len(s) != len(c): continue
        yield '|'.join(f[:4]), s, c
def stopped_flags(c):
    mhz = [(pc + ec) / (pt + et) if pt + et else 0 for pt, pc, et, ec in c]
    med = statistics.median(mhz)
    return [m < 0.5 * med for m in mhz]

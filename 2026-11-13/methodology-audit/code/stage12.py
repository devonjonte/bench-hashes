#!/usr/bin/env python3
"""Suspect cells: the first stage's run means (every cell in the run) beside the second stage's (the suspects alone). Exploration."""
import sys, math, statistics as st
from runs import pairs
d = sys.argv[1]
p1 = pairs(d); p2 = pairs(d + '/second')
for key in p2[0][0]:
    if not all(key in o and key in n for o, n in p1): continue
    o1 = st.mean(o[key][0] for o, n in p1); n1 = st.mean(n[key][0] for o, n in p1)
    o2 = st.mean(o[key][0] for o, n in p2); n2 = st.mean(n[key][0] for o, n in p2)
    r1 = st.mean(math.log(n[key][0]/o[key][0]) for o, n in p1); r2 = st.mean(math.log(n[key][0]/o[key][0]) for o, n in p2)
    print(f"{key:52s} old: all-cells run {o1:8.3f}, suspects-only run {o2:8.3f} ({100*(o2/o1-1):+5.1f}%)   new/old: {100*(math.exp(r1)-1):+6.1f}% (4 pairs) vs {100*(math.exp(r2)-1):+6.1f}% (64 pairs)")

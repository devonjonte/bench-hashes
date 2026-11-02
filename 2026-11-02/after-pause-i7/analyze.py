"""after-pause protocol, i7: per cell and pause, the first call after the pause against steady,
the idle state the pause entered (cpuidle usage deltas, state index), the core's hardware C6
residency share of the pause, and the detectable change (two runs of 100 a side, 5%, 80% power:
2.8 * sd * sqrt(2/100) / mean)."""
import sys, statistics as st
from collections import defaultdict
names = ["POLL", "C1E", "C6", "C8", "C10"]
for f in sys.argv[1:]:
    rows = [l.rstrip("\n").split("\t") for l in open(f) if not l.startswith("#")]
    first = defaultdict(list); steady = defaultdict(list); states = defaultdict(lambda: defaultdict(int)); c6share = defaultdict(list)
    for cell, pause, fst, stdy, du, c1, c6, tsc, *_c7 in rows:
        k = (cell, int(pause)); first[k].append(int(fst))
        if stdy != "-": steady[cell].append(int(stdy))
        d = [int(x) for x in du.split(",")]
        for i, x in enumerate(d):
            if x: states[k][names[i]] += x
        c6share[k].append(int(c6) / int(tsc) if int(tsc) else 0)
    print(f"== {f}")
    print("cell     pause_us  n   first_med  p10    p90    steady  x  det%   c6share  states entered")
    for cell in ["st16x64", "st1k", "off1k", "mt1m"]:
        s = st.median(steady[cell])
        for pause in [20, 200, 1000, 5000]:
            v = sorted(first[(cell, pause)]); n = len(v)
            med = v[n // 2]; p10 = v[n // 10]; p90 = v[9 * n // 10]
            det = 2.8 * st.pstdev(v) * (2 / 100) ** 0.5 / st.mean(v) * 100
            sh = st.median(c6share[(cell, pause)])
            ent = " ".join(f"{k}:{c}" for k, c in sorted(states[(cell, pause)].items(), key=lambda kv: names.index(kv[0])))
            print(f"{cell:8} {pause:7}  {n:3} {med:9} {p10:6} {p90:6} {int(s):7} {med / s:5.1f} {det:5.1f} {sh:7.2f}  {ent}")

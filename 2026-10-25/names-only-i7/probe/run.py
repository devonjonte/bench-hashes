"""Per-call front-end counts after a 1 ms pause, old against new: each
cell at N=3000 and N=500 calls, the difference over 2500 the per-call
cost (startup cancels). Pinned to P core 4, old and new alternating."""
import subprocess, statistics, sys
EV = ["instructions", "cycles", "icache_data.stalls", "frontend_retired.l1i_miss", "frontend_retired.itlb_miss", "idq.dsb_uops", "idq.mite_uops"]
def run(side, cell, n):
    exe = f"{side}/target/release/cold-probe-{side}"
    out = subprocess.run(["taskset", "-c", "4", "perf", "stat", "-x,", "-e", ",".join(f"cpu_core/{e}/u" for e in EV), exe, cell, str(n), f"/home/agent/tmp/t-{side}-{cell}-{n}.txt"], capture_output=True, text=True).stderr
    d = {}
    for line in out.splitlines():
        f = line.split(",")
        if len(f) > 3 and f[0].replace(".", "").isdigit():
            d[f[2].split("/")[1]] = float(f[0])
    times = [int(x) for x in open(f"/home/agent/tmp/t-{side}-{cell}-{n}.txt").read().split()]
    return d, times
for cell in sys.argv[1:]:
    rows = {}
    for rep in range(3):
        for side in ("old", "new"):
            big, times = run(side, cell, 3000)
            small, _ = run(side, cell, 500)
            per = {e: (big[e] - small[e]) / 2500 for e in EV if e in big and e in small}
            rows.setdefault(side, []).append((per, times))
    print(f"== {cell}")
    for side in ("old", "new"):
        pers = [p for p, _ in rows[side]]
        med = {e: statistics.median(p[e] for p in pers) for e in pers[0]}
        alltimes = sorted(t for _, ts in rows[side] for t in ts)
        q = lambda f: alltimes[int(len(alltimes) * f)]
        print(f"  {side}: ns p25 {q(.25)} p50 {q(.5)} p75 {q(.75)} p90 {q(.9)} | per call: " + " ".join(f"{e.split('.')[-1]} {v:.0f}" for e, v in med.items()))

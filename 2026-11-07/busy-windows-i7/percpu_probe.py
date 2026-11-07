import time, sys
def read():
    out = {}
    for line in open('/proc/stat'):
        if line.startswith('cpu') and line[3].isdigit():
            f = line.split()
            v = list(map(int, f[1:9]))
            busy = v[0]+v[1]+v[2]+v[5]+v[6]+v[7]
            out[int(f[0][3:])] = (busy, sum(v))
    return out
dur = float(sys.argv[1]); step = 0.1
hz = 100.0
prev = read(); t0 = time.monotonic(); rows = []
while time.monotonic() - t0 < dur:
    time.sleep(step)
    cur = read(); t = time.monotonic() - t0
    rows.append((t, {c: (cur[c][0]-prev[c][0])/hz/step for c in cur}))
    prev = cur
# 1-second windows
import collections
win = collections.defaultdict(lambda: collections.defaultdict(float))
for t, d in rows:
    for c, b in d.items():
        win[int(t)][c] += b*step
busy_windows = []
for w in sorted(win):
    tot = sum(win[w].values())
    if tot > 1.0:
        top = sorted(win[w].items(), key=lambda x: -x[1])[:4]
        busy_windows.append((w, tot, top))
print(f"{len(win)} one-second windows, {len(busy_windows)} over 1.0 CPU")
for w, tot, top in busy_windows:
    print(f"  {w:4d} s: {tot:.2f} CPUs; " + ", ".join(f"cpu{c} {v:.2f}" for c, v in top))
# per-CPU share of all busy time
tot = collections.defaultdict(float)
for w in win:
    for c, v in win[w].items(): tot[c] += v
print("busy CPU-seconds by CPU:", ", ".join(f"cpu{c} {v:.1f}" for c, v in sorted(tot.items(), key=lambda x: -x[1])[:8]))

"""The stall samples of a run's after-pause cells: how far each lies above its cell's median, and whether
their start times share a period (a 60 Hz tick would put them 16.667 ms apart, so their phases cluster).
Samples format v8+ (start ms per sample)."""
import sys, statistics, math, collections
path = sys.argv[1]
stalls = []  # (start_ms, ratio to median, cell)
total = 0
for line in open(path):
    if line.startswith('#') or line.startswith('contender'):
        continue
    f = line.rstrip('\n').split('\t')
    if f[1] != 'solo' or 'Idle' not in f[2]:
        continue
    vals = [int(x.split('/')[0]) / int(x.split('/')[1]) for x in f[5].split(',')]
    starts = [int(x) for x in f[6].split(',')]
    med = statistics.median(vals)
    for v, s in zip(vals, starts):
        total += 1
        if v > 3 * med:
            stalls.append((s, v / med, f"{f[0]} {f[2]} {f[3]}"))
print(f"{len(stalls)} stall samples (>3x their cell's median) of {total} after-pause samples")
# Phase test for candidate periods: Rayleigh statistic on start mod period.
for period_ms in [16.6667, 10.0, 20.0, 33.3333, 100.0, 250.0, 1000.0, 4.0]:
    ph = [2 * math.pi * (s % period_ms) / period_ms for s, _, _ in stalls]
    n = len(ph)
    r = math.hypot(sum(math.cos(p) for p in ph), sum(math.sin(p) for p in ph)) / max(n, 1)
    z = n * r * r
    print(f"period {period_ms:9.4f} ms: mean resultant length {r:.3f}, Rayleigh z {z:.1f} (z > 3 is p < 0.05)")
# Gaps between successive stalls, in ms, the smallest first.
ss = sorted(s for s, _, _ in stalls)
gaps = [b - a for a, b in zip(ss, ss[1:]) if b > a]
gaps.sort()
print("gaps between stalls (ms), the 15 smallest:", gaps[:15])
print("stall ratios: median x%.1f, max x%.1f" % (statistics.median(r for _, r, _ in stalls), max(r for _, r, _ in stalls)))
by_cell = collections.Counter(c.split()[1] for _, _, c in stalls)
print("by use case:", dict(by_cell))

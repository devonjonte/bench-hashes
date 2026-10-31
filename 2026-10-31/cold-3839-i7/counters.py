"""Code-fetch counters per round of the cold probe (3839 B, 64 MiB evicted),
whole process minus an otherwise identical run with no hash call, P core 2:
the hash call's L2 code reads that miss, its iTLB-miss retirements, and its
DSB misses. 5 processes a build, alternating; medians per round."""
import subprocess, statistics, sys
EV = 'cpu_core/l2_rqsts.code_rd_miss/u,cpu_core/frontend_retired.itlb_miss/u,cpu_core/icache_data.stalls/u,cpu_core/instructions/u,cpu_core/cycles/u'
ROUNDS = 400
EXE = dict(a.split('=', 1) for a in sys.argv[1:])
def counts(exe, rounds):
    err = subprocess.run(['taskset', '-c', '2', 'perf', 'stat', '-x,', '-e', EV, '--', exe, '3839', str(rounds), '64'], capture_output=True, text=True).stderr
    vals = []
    for l in err.splitlines():
        f = l.split(',')
        if len(f) > 2 and ('cpu_core' in l):
            vals.append(float(f[0]) if f[0].replace('.', '').isdigit() else float('nan'))
    return vals
rows = {n: [] for n in EXE}
for p in range(5):
    for n in (list(EXE) if p % 2 == 0 else list(EXE)[::-1]):
        a, b = counts(EXE[n], ROUNDS), counts(EXE[n], ROUNDS // 4)
        rows[n].append([(x - y) / (ROUNDS - ROUNDS // 4) for x, y in zip(a, b)])
names = ['L2 code-read misses', 'iTLB-miss retirements', 'icache stall cycles', 'instructions', 'cycles']
print('per round (the hash call plus the eviction pass and the input write)')
print(f'{"build":14}' + ''.join(f'{n:>24}' for n in names))
for n, v in rows.items():
    print(f'{n:14}' + ''.join(f'{statistics.median(r[i] for r in v):24.1f}' for i in range(len(names))))

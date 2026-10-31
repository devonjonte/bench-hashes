"""Cold one-message calls (cold_probe.rs), pinned to P core 2: PROCS
processes per build alternating, each ROUNDS calls after reading EVICT MiB;
per process the median call's cycles; then the median over processes, and
each build's share of processes in the slow state above the pooled median."""
import subprocess, statistics, sys
LEN, ROUNDS, EVICT, PROCS = (int(x) for x in sys.argv[1:5])
EXE = dict(arg.split('=', 1) for arg in sys.argv[5:])
names = list(EXE)
per = {n: [] for n in names}
for p in range(PROCS):
    for n in (names if p % 2 == 0 else names[::-1]):
        out = subprocess.run(['taskset', '-c', '2', EXE[n], str(LEN), str(ROUNDS), str(EVICT)], capture_output=True, text=True, check=True).stdout.split()
        per[n].append(statistics.median(int(x) for x in out[5:]))
base = statistics.median(per[names[0]])
for n in names:
    m = statistics.median(per[n])
    print(f'{n:10} median of {PROCS} process medians: {m:8.0f} cycles  x{m / base:.3f}  (processes {min(per[n]):.0f}..{max(per[n]):.0f})')

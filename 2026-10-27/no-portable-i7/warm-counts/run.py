"""Per call, warm, pinned to P core 2: user-space instructions and cycles of
each small call, 2,000,000 calls a process, old and new alternating (ABBA),
7 rounds. Old: johnservil/BLAKE3 2907ea5d; new: devonjonte candidate/devon-no-portable."""
import subprocess, statistics, sys
EXE = {'old': '/home/agent/BLAKE3-rel08/target-probe/release/examples/small_probe',
       'new': '/home/agent/BLAKE3-np/target-probe/release/examples/small_probe'}
CALLS = 2_000_000
rows = {}
for kind in ['many1', 'st128', 'st512', 'mt128']:
    for r in range(7):
        for side in (['old', 'new'] if r % 2 == 0 else ['new', 'old']):
            out = subprocess.run(['taskset', '-c', '2', 'perf', 'stat', '-x,', '-e', 'cpu_core/instructions/u,cpu_core/cycles/u', '--', EXE[side], kind, str(CALLS)],
                                 capture_output=True, text=True).stderr
            vals = [int(l.split(',')[0]) for l in out.splitlines() if l and l.split(',')[0].isdigit()]
            ins, cyc = vals[0] / CALLS, vals[1] / CALLS
            rows.setdefault((kind, side), []).append((ins, cyc))
            print(kind, side, r, f'{ins:.1f}', f'{cyc:.1f}', flush=True)
print('\nkind  side  instructions/call (median)  cycles/call (median, min..max)')
for (kind, side), v in sorted(rows.items()):
    c = [x[1] for x in v]
    print(f'{kind:6} {side:4} {statistics.median(x[0] for x in v):8.1f}  {statistics.median(c):8.1f}  ({min(c):.1f}..{max(c):.1f})')

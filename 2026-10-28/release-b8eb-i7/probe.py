"""Warm hash_many calls over COUNT 64-byte messages, the length passed at
run time (argv), as the bench does; P core 2, user-space instructions and
cycles per call, 7 rounds rotating three builds: 83d59db2 (the old API),
b52735e9 (Batch, methods #[inline]) and b8ebc5a7 (hash_many inline(always),
the count computed when asked)."""
import subprocess, statistics
R = '/home/agent/BLAKE3-review08'
EXE = {'83d59db2': f'{R}/target-probe-83d59db22f6d606d96a5e38223d411123e8cbd18/release/examples/probe',
       'b52735e9': f'{R}/target-probe-b52735e9c49d48f9db48da57f364d692bc84258d/release/examples/probe',
       'b8ebc5a7': f'{R}/target-probe-b8ebc5a74a06d8d6bb4aa65465e882fc904b4e97/release/examples/probe'}
names = list(EXE)
rows = {}
COUNTS = [1, 2, 3, 4, 6, 12, 64]
for count in COUNTS:
    calls = 4_000_000 // count
    for r in range(7):
        for side in names[r % 3:] + names[:r % 3]:
            err = subprocess.run(['taskset', '-c', '2', 'perf', 'stat', '-x,', '-e', 'cpu_core/instructions/u,cpu_core/cycles/u', '--', EXE[side], str(count), str(calls), '64'], capture_output=True, text=True).stderr
            v = [int(l.split(',')[0]) for l in err.splitlines() if l and l.split(',')[0].isdigit()]
            rows.setdefault((count, side), []).append((v[0] / calls, v[1] / calls))
med = lambda v, k: statistics.median(x[k] for x in v)
print('count  instructions/call: 83d59db2  b52735e9  b8ebc5a7   cycles/call: 83d59db2  b52735e9 (x)  b8ebc5a7 (x)')
for c in COUNTS:
    o, a, b = (rows[(c, s)] for s in names)
    print(f'{c:5}  {med(o,0):9.1f} {med(a,0):9.1f} {med(b,0):9.1f}      {med(o,1):8.1f}  {med(a,1):8.1f} (x{med(a,1)/med(o,1):.3f})  {med(b,1):8.1f} (x{med(b,1)/med(o,1):.3f})')

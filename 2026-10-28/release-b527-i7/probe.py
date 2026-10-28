"""Warm hash_many calls over COUNT 64-byte messages, P core 2, user-space
instructions and cycles per call, 7 rounds alternating. old: 83d59db2
(hash_many(mode, &[Block], 64, out)); new: b52735e9 (hash_many(mode,
&Batch::from_blocks(blocks, 64), out), the Batch built every call)."""
import subprocess, statistics
EXE = {'old': '/home/agent/BLAKE3-review08/target-probe/release/examples/probe', 'new': '/home/agent/BLAKE3-fixes/target-probe/release/examples/probe'}
rows = {}
for count in [1, 2, 3, 4, 6, 12, 16, 64]:
    calls = 4_000_000 // count
    for r in range(7):
        for side in (['old', 'new'] if r % 2 == 0 else ['new', 'old']):
            err = subprocess.run(['taskset', '-c', '2', 'perf', 'stat', '-x,', '-e', 'cpu_core/instructions/u,cpu_core/cycles/u', '--', EXE[side], str(count), str(calls)], capture_output=True, text=True).stderr
            v = [int(l.split(',')[0]) for l in err.splitlines() if l and l.split(',')[0].isdigit()]
            rows.setdefault((count, side), []).append((v[0] / calls, v[1] / calls))
print('count  instr/call old -> new   cycles/call old -> new   new/old')
for count in [1, 2, 3, 4, 6, 12, 16, 64]:
    o, n = rows[(count, 'old')], rows[(count, 'new')]
    med = lambda v, k: statistics.median(x[k] for x in v)
    print(f'{count:5}  {med(o,0):8.1f} -> {med(n,0):8.1f}   {med(o,1):8.1f} -> {med(n,1):8.1f}   x{med(n,1)/med(o,1):.3f}')

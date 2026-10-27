"""Warm calls of hash_many over COUNT messages of LEN bytes on P core 2,
user-space instructions and cycles per call, 5 rounds rotating the three
builds. keep: candidate/devon-no-portable 8769d4b3 (arm 3: three left
over take a fourth, spare lane); delete: arm 3 deleted (three left over
hashed one at a time); whole: x86 always passes every lane to the
platform's hash_many."""
import subprocess, statistics
EXE = {'keep': '/home/agent/BLAKE3-np/target-probe/release/examples/arm3_probe',
       'delete': '/home/agent/BLAKE3-arm3/target-probe/release/examples/arm3_probe',
       'whole': '/home/agent/BLAKE3-arm3b/target-probe/release/examples/arm3_probe'}
rows = {}
for count in [3, 7, 19, 4, 8]:
    for length in [128, 256, 1024]:
        calls = 2_000_000 * 256 // (length * count) or 1
        for r in range(5):
            order = list(EXE)[r % 3:] + list(EXE)[:r % 3]
            for side in order:
                err = subprocess.run(['taskset', '-c', '2', 'perf', 'stat', '-x,', '-e', 'cpu_core/instructions/u,cpu_core/cycles/u', '--',
                                      EXE[side], str(count), str(length), str(calls)], capture_output=True, text=True).stderr
                v = [int(l.split(',')[0]) for l in err.splitlines() if l and l.split(',')[0].isdigit()]
                rows.setdefault((count, length, side), []).append((v[0] / calls, v[1] / calls))
print('count  len  build    instructions/call  cycles/call (median)  x keep')
for count in [3, 7, 19, 4, 8]:
    for length in [128, 256, 1024]:
        keep = statistics.median(c for _, c in rows[(count, length, 'keep')])
        for side in EXE:
            v = rows[(count, length, side)]
            cyc = statistics.median(c for _, c in v)
            print(f'{count:5} {length:4}  {side:7} {statistics.median(i for i, _ in v):12.0f}  {cyc:12.0f}  x{cyc / keep:.3f}')

"""Warm hash_many calls over COUNT messages of LEN bytes, pinned to P core 2:
user-space instructions and cycles per message, 7 rounds alternating old and
new. old: 0.8's version commit 83d59db2 (+ a docs commit); new: the padding
checked in every build (exp/devon-padding-checked 48ed9ae6, #205)."""
import subprocess, statistics
EXE = {'old': '/home/agent/BLAKE3-review08/target-probe/release/examples/pad_probe',
       'new': '/home/agent/BLAKE3-pad/target-probe/release/examples/pad_probe'}
CASES = [(1, 100), (16, 100), (1024, 100), (1024, 33), (1024, 1), (1024, 200), (256, 1000), (64, 2000), (1024, 64), (16, 1023)]
rows = {}
for count, length in CASES:
    calls = max(1, 40_000_000 // (count * max(length, 64)))
    for r in range(7):
        for side in (['old', 'new'] if r % 2 == 0 else ['new', 'old']):
            err = subprocess.run(['taskset', '-c', '2', 'perf', 'stat', '-x,', '-e', 'cpu_core/instructions/u,cpu_core/cycles/u', '--',
                                  EXE[side], str(count), str(length), str(calls)], capture_output=True, text=True).stderr
            v = [int(l.split(',')[0]) for l in err.splitlines() if l and l.split(',')[0].isdigit()]
            rows.setdefault((count, length, side), []).append((v[0] / calls / count, v[1] / calls / count))
print('count   len   instr/msg old -> new     cycles/msg old -> new (median, 7 runs)   new/old')
for count, length in CASES:
    o, n = rows[(count, length, 'old')], rows[(count, length, 'new')]
    io, inn = statistics.median(x for x, _ in o), statistics.median(x for x, _ in n)
    co, cn = statistics.median(c for _, c in o), statistics.median(c for _, c in n)
    print(f'{count:5} {length:5}   {io:9.1f} -> {inn:9.1f}   {co:9.1f} -> {cn:9.1f}  (spread {min(c for _,c in n):.0f}-{max(c for _,c in n):.0f})   x{cn/co:.3f}')

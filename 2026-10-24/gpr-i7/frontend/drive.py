#!/usr/bin/env python3
"""The grid: variants x lengths x {warm, cold}, plus baselines, on CPU 2,
perf counting each run; three rounds, the variants' order rotating. Raw
lines to grid.tsv: round, variant, mode, len, calls, call_ns, counters..."""
import subprocess, itertools
B = "/home/agent/bench-hashes-validation/gpr-icache"
EV = ["cycles", "instructions", "icache_data.stalls", "frontend_retired.l1i_miss", "idq.dsb_uops", "idq.mite_uops"]
VARIANTS = ["simd", "gpr", "sled"]
WARM, COLD = 2_000_000, 3000
def run(v, mode, length, calls):
    cmd = ["taskset", "-c", "2", "perf", "stat", "-x,", "-e", ",".join(f"cpu_core/{e}/" for e in EV),
           f"{B}/{v}/target/release/gpr-icache", mode, str(length), str(calls)]
    p = subprocess.run(cmd, capture_output=True, text=True, check=True)
    out = p.stdout.strip().split("\t")
    counts = {}
    for line in p.stderr.splitlines():
        f = line.split(",")
        if len(f) > 2 and f[2].startswith("cpu_core/"):
            counts[f[2][9:-1]] = int(f[0])
    return int(out[3]), [counts[e] for e in EV]
with open(f"{B}/grid.tsv", "w") as t:
    t.write("round\tvariant\tmode\tlen\tcalls\tcall_ns\t" + "\t".join(EV) + "\n")
    for r in range(3):
        order = VARIANTS[r:] + VARIANTS[:r]
        for v in order:
            jobs = [("warm", 0, 0), ("gap", 0, COLD)] + [(m, n, WARM if m == "warm" else COLD) for n in (64, 256, 1024) for m in ("warm", "cold")]
            for mode, length, calls in jobs:
                ns, c = run(v, mode, length, calls)
                t.write(f"{r}\t{v}\t{mode}\t{length}\t{calls}\t{ns}\t" + "\t".join(map(str, c)) + "\n")
                t.flush()
print("grid: done")

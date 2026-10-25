"""Relink each probe in random function orders, as bench-hashes check
relinks its sides (nm's text symbols shuffled per seed, lld's
--symbol-ordering-file), then time each layout's calls after a pause."""
import subprocess, random, os, shutil, statistics, sys
LLD = "/home/agent/BLAKE3-rel08/target/check/lld"
SEEDS = range(8)
def layouts(side):
    exe = f"{side}/target/release/cold-probe-{side}"
    syms = sorted({l.split()[2] for l in subprocess.run(["nm", exe], capture_output=True, text=True).stdout.splitlines()
                   if len(l.split()) == 3 and l.split()[1] in "tT"})
    out = []
    for seed in SEEDS:
        s = list(syms); random.Random(seed).shuffle(s)
        order = os.path.abspath(f"{side}/order-{seed}.txt"); open(order, "w").write("\n".join(s) + "\n")
        flags = ["-Clink-arg=-fuse-ld=lld", f"-Clink-arg=-B{LLD}", f"-Clink-arg=-Wl,--symbol-ordering-file={order}", "-Clink-arg=-Wl,--no-warn-symbol-ordering"]
        subprocess.run(["cargo", "rustc", "--release", "--quiet", "--"] + flags, cwd=side, check=True)
        kept = f"{side}/probe-{seed}"; shutil.copy(exe, kept); out.append(kept)
    return out
exes = {side: layouts(side) for side in ("old", "new")}
cell, n = sys.argv[1], 3000
res = {"old": [], "new": []}
for seed in SEEDS:
    for side in ("old", "new"):
        t = f"/home/agent/tmp/r-{side}-{seed}.txt"
        subprocess.run(["taskset", "-c", "4", exes[side][seed], cell, str(n), t], check=True)
        v = sorted(int(x) for x in open(t).read().split())
        res[side].append((seed, statistics.mean(v), v[len(v) // 2], v[int(len(v) * .75)]))
        print(side, seed, "mean %.0f median %d p75 %d" % res[side][-1][1:], flush=True)
for side in res:
    ms = [r[1] for r in res[side]]; md = [r[2] for r in res[side]]
    print(f"{side}: mean of means {statistics.mean(ms):.0f}, median of medians {statistics.median(md):.0f}, means sorted", " ".join(f"{m:.0f}" for m in sorted(ms)))

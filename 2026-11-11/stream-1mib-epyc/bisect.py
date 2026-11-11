#!/usr/bin/env python3
"""BLAKE3 #368 on the x86-avx2 machine: which commit between 27717b3f (level) and 2037118c made the
shared stream of 1 MiB messages slower. The library's API moved through these commits, so each commit
is measured by a bench of its own days, as the OLD side of a check whose new side is the pin under the
0.21 tag's bench: `check --new 2037118c --against COMMIT --old-bench BENCH --points "continuous 1 MiB"
--layouts 16`. A commit is LEVEL (as 27717b3f is) when the pin reads slower than it by 15% or more
shared one cache, or 10% or more shared two caches (the ends read +34.7% and +20.0%); otherwise it is
already SLOWER."""
import subprocess, re, os, time
H = os.path.expanduser("~"); O = H + "/runs/bisect-368"; M = H + "/work/BLAKE3"; PIN = "2037118ca1da85710aef55d7f13b3abd9095b485"
BENCHES = [(4, "415e7df3"), (8, "f24b6f4d"), (33, "a3e8ffa3"), (34, "1a7db178"), (38, "b6f41018"), (106, "148827f3"), (131, "301afa6a"), (149, "9647c998")]
commits = open(O + "/commits.txt").read().split()
def log(m):
    with open(O + "/log.txt", "a") as f: f.write(time.strftime("%H:%M ", time.gmtime()) + m + "\n")
def step(c):
    at = int(subprocess.run(["git", "-C", M, "rev-list", "--count", "--first-parent", f"27717b3f..{c}"], capture_output=True, text=True).stdout) - 1
    before = [b for i, b in BENCHES if i <= at][::-1]; after = [b for i, b in BENCHES if i > at]
    order = before[:1] + after[:1] + before[1:2] + ["3363bee8"]
    for bench in order:
        tag = f"{c[:8]}-by-{bench}"
        r = subprocess.run([H + "/work/bench-021tag/target/release/bench-hashes", "check", "--fork", M, "--new", PIN, "--against", c,
                            "--old-bench", bench, "--points", "continuous 1 MiB", "--layouts", "16", "--when-quiet", "--keep", f"{O}/kept-{tag}"],
                           capture_output=True, text=True, cwd=H + "/work/bench-021tag")
        open(f"{O}/step-{tag}.stdout.txt", "w").write(r.stdout); open(f"{O}/step-{tag}.stderr.txt", "w").write(r.stderr)
        if r.returncode not in (0, 1): continue
        got = dict(re.findall(r"SLOWER blake3-servil-mt\|(shared-\S+?)\|ContinuousMessages\|1 MiB: \+([0-9.]+)%", r.stdout))
        one, two = float(got.get("shared-one-cache", 0)), float(got.get("shared-two-caches", 0))
        return (not (one >= 15 or two >= 10)), f"bench {bench}: the pin against it: one cache +{one}%, two caches +{two}% (0 = not reported slower)"
    return None, f"no bench of {order} gave a verdict"
lo, hi = -1, len(commits) - 1; skipped = set()
log(f"{len(commits)} commits touch the stream's path")
while True:
    cands = [i for i in range(lo + 1, hi) if i not in skipped]
    if not cands: break
    mid = cands[len(cands) // 2]; c = commits[mid]
    slower, note = step(c)
    subj = subprocess.run(["git", "-C", M, "log", "--format=%s", "-1", c], capture_output=True, text=True).stdout.strip()[:70]
    log(f"index {mid} of {lo}..{hi} {c[:8]} ({subj}): {'no verdict' if slower is None else 'SLOWER already' if slower else 'level'}; {note}")
    if slower is None: skipped.add(mid)
    elif slower: hi = mid
    else: lo = mid
log(f"DONE: first slower {commits[hi][:8]}; last level {(commits[lo] if lo >= 0 else '27717b3f')[:8]}; skipped {sorted(commits[i][:8] for i in skipped)}")

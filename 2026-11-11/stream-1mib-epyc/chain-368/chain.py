#!/usr/bin/env python3
"""BLAKE3 #368, after the segments named db3cab99..85bf73a6 (the first pipeline's landing: +16.4% one cache,
+14.8% two caches, +8.3% alone, one bench, 64 pairs).
1. Does the first pipeline's removal give it back? candidate/pipeline-removed (b6377425) against its base
   0a23cb70, under bench 4fcff35f (the stream's calls, no pipeline contender), 64 pairs.
2. Which commit of the segment: a bisect of its commits that touch the pool or the stream, each against
   db3cab99 under bench f24b6f4d, 64 pairs. A commit is SLOWER when two of the three cells are reported so."""
import subprocess, re, os, time
H = os.path.expanduser("~"); O = H + "/runs/chain-368"; M = H + "/work/BLAKE3"; W = H + "/work"
os.makedirs(O, exist_ok=True)
def log(m):
    with open(O + "/log.txt", "a") as f: f.write(time.strftime("%H:%M ", time.gmtime()) + m + "\n")
def bench(b):
    d = f"{W}/bench-{b}"
    if not os.path.isdir(d): subprocess.run(["git", "-C", W + "/bench-hashes", "worktree", "add", "-q", "--detach", d, b], check=True)
    subprocess.run(["cargo", "build", "--release"], cwd=d, capture_output=True)
    return d
def check(b, old, new, tag):
    d = bench(b)
    r = subprocess.run([d + "/target/release/bench-hashes", "check", "--fork", M, "--new", new, "--against", old, "--points", "continuous 1 MiB",
                        "--layouts", "64", "--when-quiet", "--keep", f"{O}/kept-{tag}"], capture_output=True, text=True, cwd=d)
    open(f"{O}/{tag}.stdout.txt", "w").write(r.stdout); open(f"{O}/{tag}.stderr.txt", "w").write(r.stderr)
    if r.returncode not in (0, 1): return None
    return re.findall(r"(SLOWER|faster) blake3-servil-mt\|(\S+?)\|ContinuousMessages\|1 MiB: ([+-][0-9.]+)% \(the pairs' geometric mean; (\d+) pairs", r.stdout)
say = lambda cells: "no verdict" if cells is None else ("; ".join(f"{s} {w} {p}% ({n} pairs)" for w, s, p, n in cells) or "no cell reported slower or faster")
subprocess.run(["git", "-C", M, "fetch", "-q", "origin"])
log("1. the removal: b6377425 against 0a23cb70 under bench 4fcff35f: " + say(check("4fcff35f", "0a23cb70", "b6377425", "removal")))
commits = open(O + "/commits.txt").read().split()
lo, hi = -1, len(commits) - 1; skipped = set()
while True:
    cands = [i for i in range(lo + 1, hi) if i not in skipped]
    if not cands: break
    mid = cands[len(cands) // 2]; c = commits[mid]
    cells = check("f24b6f4d", "db3cab99", c, f"bisect-{c[:8]}")
    subj = subprocess.run(["git", "-C", M, "log", "--format=%s", "-1", c], capture_output=True, text=True).stdout.strip()[:60]
    slower = None if cells is None else sum(1 for w, _, _, _ in cells if w == "SLOWER") >= 2
    log(f"2. index {mid} of {lo}..{hi} {c[:8]} ({subj}): {'no verdict' if slower is None else 'SLOWER' if slower else 'level'}: {say(cells)}")
    if slower is None: skipped.add(mid)
    elif slower: hi = mid
    else: lo = mid
log(f"DONE: first slower {commits[hi][:8]}; last level {(commits[lo] if lo >= 0 else 'db3cab99')[:8]}; skipped {sorted(commits[i][:8] for i in skipped)}")

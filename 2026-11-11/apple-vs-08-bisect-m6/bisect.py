#!/usr/bin/env python3
"""Bisect BLAKE3 #364 on the Apple M6 through the Mac exchange: each step queues a check of a commit
against 0.8 (one bench, 828e8500, on both sides) on three of the slowed cells, waits for its verdict,
and halves the range. Writes its progress to log.txt beside it. Light: git and sleep."""
import json, subprocess, time, os, glob
HERE = os.path.dirname(os.path.abspath(__file__))
B3, EX = "/home/agent/BLAKE3-m3", "/home/agent/mac-runner"
GOOD, BAD = "b5b988d8", "27717b3f"
BENCH = subprocess.run(["git", "-C", "/home/agent/bench-0194", "rev-parse", "828e8500"], capture_output=True, text=True).stdout.strip()
def sh(*a, cwd=None): return subprocess.run(a, cwd=cwd, capture_output=True, text=True).stdout.strip()
def log(m):
    with open(os.path.join(HERE, "log.txt"), "a") as f: f.write(time.strftime("%H:%M ", time.gmtime()) + m + "\n")
full = lambda c: sh("git", "-C", B3, "rev-parse", c)
commits = sh("git", "-C", B3, "rev-list", "--first-parent", "--reverse", f"{GOOD}..{BAD}").split()
# Third pass (07:55 UTC). The signature of #364 is a cell slower by 60% or more (job 3043). Job 3048
# (index 57, b6b2e12f) ran its whole first stage and read one cell +7.9% over four pairs: that is not
# the signature, so index 57 is LEVEL; the second pass, which took the job's "regression" status as
# the answer, searched the wrong half. From here a step is SLOWER only with a cell at +30% or more,
# LEVEL when its check finished without one, and tried again when the machine was too busy to judge.
import re
def touches_code(c):
    files = sh("git", "-C", B3, "diff", "--name-only", c + "^", c).split("\n")
    return any((f.startswith(("src/", "c/")) and f != "src/test.rs") or f in ("build.rs", "Cargo.toml") for f in files)
CODE = [i for i, c in enumerate(commits) if i > 57 and touches_code(c)]
lo, hi = 57, len(commits) - 1
skipped = set(); tries = {}
log(f"third pass: index 57 is level (no cell at +30%); {len(CODE)} commits after it change the library's code")
while True:
    cands = [i for i in CODE if lo < i < hi and i not in skipped]
    if not cands: break
    mid = cands[len(cands) // 2]
    c = commits[mid]
    sh("git", "pull", "-q", cwd=EX)
    n = max(int(f.split("-")[0]) for f in os.listdir(os.path.join(EX, "jobs")) if f.split("-")[0].isdigit()) + 1
    name = f"{n}-bisect364-{c[:8]}"
    job = {"type": "check", "old_commit": full(GOOD), "new_commit": c, "bench_commit": BENCH, "points": "4,8,7935 B", "time_limit_seconds": 2400}
    open(os.path.join(EX, "jobs", name + ".json"), "w").write(json.dumps(job) + "\n")
    sh("git", "add", "jobs", cwd=EX); sh("git", "commit", "-qm", f"{name}: bisecting BLAKE3 #364 on the M6 (Devon)", cwd=EX)
    for _ in range(5):
        if subprocess.run(["git", "push", "-q", "origin", "HEAD:main"], cwd=EX, capture_output=True).returncode == 0: break
        sh("git", "pull", "-q", "--rebase", cwd=EX)
    log(f"queued {name} (index {mid} of {lo}..{hi}): {sh('git', '-C', B3, 'log', '--format=%s', '-1', c)[:80]}")
    status = None
    for _ in range(120):                 # an hour at most
        time.sleep(30); sh("git", "pull", "-q", cwd=EX)
        v = glob.glob(os.path.join(EX, "results", name + "*", "verdict.json"))
        if v:
            status = json.load(open(v[0])).get("status"); break
    worst = None
    if status in ("regression", "no regression"):
        text = open(glob.glob(os.path.join(EX, "results", name + "*", "runner.log"))[0]).read()
        pcts = [(float(p), cell) for cell, p in re.findall(r"SLOWER (\S+?\|[^:]+): \+([0-9.]+)%", text)]
        worst = max(pcts) if pcts else (0.0, "none")
    log(f"  {name}: {status}; worst slower cell: {worst}")
    if worst is None:
        if status == "error": skipped.add(mid)
        else:
            tries[mid] = tries.get(mid, 0) + 1
            if tries[mid] >= 8: skipped.add(mid)
            time.sleep(600)              # the machine was busy: again later
    elif worst[0] >= 30: hi = mid
    else: lo = mid
first_bad = commits[hi]
log(f"DONE: first slower commit {first_bad[:8]}: {sh('git', '-C', B3, 'log', '--format=%an %cd %s', '--date=short', '-1', first_bad)}")
log(f"  last level commit: {(commits[lo] if lo >= 0 else full(GOOD))[:8]}; skipped: {sorted(commits[i][:8] for i in skipped)}")

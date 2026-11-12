#!/usr/bin/env python3
"""On the EPYC 9275F: today's bench (cb9dc384) reads the single-threaded one-message cells after other work
(2304 B to 32 KiB) 12 to 21% slower than the 0.21 tag's bench, with ONE library (2037118c) on both sides.
Which bench commit? Each step: today's bench as the new side, bench commit X as the old side
(check --old-bench X), the library 2037118c on both. Today slower than X: the change is after X.
Then: does the candidate of bench #191 (every cell a function of its own, 57dd6b8d) read level with the tag's?"""
import subprocess, re, os, time
H = os.path.expanduser("~"); O = H + "/runs/bench-bisect"; M = H + "/work/BLAKE3"; PIN = "2037118ca1da85710aef55d7f13b3abd9095b485"
POINTS = "2304 B,3 KiB,4 KiB,8 KiB,16 KiB"
COMMITS = """4bef90cc3cee09cba820916481aab346ac04051a 4fcff35f29676c54ca4d297869f45d0422997c51 437427e216dc40437f23d6800c4256c443208ce3
0873022cc3acf6743460956ad4c53da96c301cad a55e5149f302cf64bcac3b15c600114862217db9 195b10e6cba173ba9c4688decabb699ff4704ec8
59f30457e12c1efb229012d2c471cd5b9f3d8bfc 224590ad13033cdd57796d7a61f1dcbabc645190 39032e94d0038778ee1819a8d44b15e84381c975
3b5f20b1ed38551b8ea3376b9be2eee88fc419df 02292b0633da758db9a9ecef0e7fd403b6627f8b 5d87983e292e645ec6d7bf3e53026f31f00c5c03
a4c76fee88e570b2bc4f684fe1864d53a314e665 e7db3919544e889c401fc9ffb8217807d5b32f7b 774a6b63d5b3b6781754d4e1f65c89e44ba2273b""".split()
def log(m):
    with open(O + "/log.txt", "a") as f: f.write(time.strftime("%H:%M ", time.gmtime()) + m + "\n")
def check(bench_dir, old_bench, tag):
    r = subprocess.run([bench_dir + "/target/release/bench-hashes", "check", "--fork", M, "--new", PIN, "--against", PIN, "--old-bench", old_bench,
                        "--contenders", "blake3-servil-st", "--points", POINTS, "--when-quiet", "--keep", f"{O}/kept-{tag}"],
                       capture_output=True, text=True, cwd=bench_dir)
    open(f"{O}/{tag}.stdout.txt", "w").write(r.stdout); open(f"{O}/{tag}.stderr.txt", "w").write(r.stderr)
    if r.returncode not in (0, 1): return None, f"exit {r.returncode}"
    cells = re.findall(r"(SLOWER|faster) blake3-servil-st\|solo\|OneMessage\|([^:]+): ([+-][0-9.]+)%", r.stdout)
    slower = [c for c in cells if c[0] == "SLOWER"]
    return len(slower) >= 3, "; ".join(f"{w} {p} {x}%" for w, p, x in cells) or "no cell slower or faster"
today = H + "/work/bench-hashes"
assert subprocess.run(["git", "-C", today, "rev-parse", "HEAD"], capture_output=True, text=True).stdout.strip().startswith("cb9dc384")
lo, hi = -1, len(COMMITS)          # COMMITS[lo]: today is slower than it (lo = -1: the tag); COMMITS[hi]: level with today (hi = len: today)
while hi - lo > 1:
    mid = (lo + hi) // 2; x = COMMITS[mid]
    slower, note = check(today, x, f"x-{x[:8]}")
    subj = subprocess.run(["git", "-C", today, "log", "--format=%s", "-1", x], capture_output=True, text=True).stdout.strip()[:60]
    log(f"today against {x[:8]} ({subj}): {'no verdict' if slower is None else 'today SLOWER' if slower else 'level'}: {note}")
    if slower is None: break
    if slower: lo = mid
    else: hi = mid
first = COMMITS[hi] if hi < len(COMMITS) else "cb9dc384 (today's)"
log(f"DONE: the first bench commit that reads these cells slower: {first[:8]}; the last that reads them as the tag does: {(COMMITS[lo] if lo >= 0 else '9434d50e (the tag)')[:8]}")
# The candidate of #191 against the tag's bench.
cand = H + "/work/bench-own-code"
subprocess.run(["git", "-C", today, "fetch", "-q", "devon", "candidate/devon-cell-own-code"], check=True)
want = "57dd6b8d46f08825d0a0134642f1637345ea548f"
assert subprocess.run(["git", "-C", today, "rev-parse", "FETCH_HEAD"], capture_output=True, text=True).stdout.strip() == want
subprocess.run(["git", "-C", cand, "checkout", "-q", "--detach", want], check=True)
subprocess.run(["cargo", "build", "--release"], cwd=cand, capture_output=True)
slower, note = check(cand, "9434d50e", "own-code-vs-tag")
log(f"#191's candidate (57dd6b8d) against the tag's bench: {'no verdict' if slower is None else 'SLOWER' if slower else 'level'}: {note}")

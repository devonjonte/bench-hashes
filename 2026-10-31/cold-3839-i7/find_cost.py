"""Bisect the cold 3839 B one-message cost (BLAKE3 #119) on the release line's
first-parent commits between GOOD and BAD: each step builds the midpoint's
probe (build.sh) and runs it beside GOOD's and BAD's (12 processes each,
alternating, P core 2); the midpoint is slow when its median is nearer BAD's.
A commit that does not build is skipped toward the newer side."""
import subprocess, statistics, sys
D = '/home/agent/bench-hashes-validation/cold-3839-i7'
W = '/home/agent/BLAKE3-review08'
GOOD, BAD = sys.argv[1], sys.argv[2]
line = subprocess.run(['git', '-C', W, 'rev-list', '--first-parent', '--reverse', f'{GOOD}..{BAD}'], capture_output=True, text=True, check=True).stdout.split()
build = lambda c: subprocess.run([f'{D}/build.sh', c], capture_output=True, text=True)
def run(exes, procs=12):
    per = {n: [] for n in exes}
    for p in range(procs):
        for n in (list(exes) if p % 2 == 0 else list(exes)[::-1]):
            out = subprocess.run(['taskset', '-c', '2', exes[n], '3839', '200', '64'], capture_output=True, text=True, check=True).stdout.split()
            per[n].append(statistics.median(int(x) for x in out[5:]))
    return {n: statistics.median(v) for n, v in per.items()}
good_exe, bad_exe = build(GOOD).stdout.strip(), build(BAD).stdout.strip()
lo, hi = -1, len(line) - 1   # line[lo] fast (GOOD when -1), line[hi] slow
while hi - lo > 1:
    mid = (lo + hi) // 2
    b = build(line[mid])
    while b.returncode != 0 and mid < hi - 1:
        print(f'  {line[mid][:10]} does not build; next', flush=True)
        mid += 1
        b = build(line[mid])
    if b.returncode != 0:
        break
    m = run({'good': good_exe, 'mid': b.stdout.strip(), 'bad': bad_exe})
    slow = abs(m['mid'] - m['bad']) < abs(m['mid'] - m['good'])
    subj = subprocess.run(['git', '-C', W, 'log', '-1', '--format=%s', line[mid]], capture_output=True, text=True).stdout.strip()
    print(f'{line[mid][:10]} ({mid + 1}/{len(line)}): good {m["good"]:.0f} mid {m["mid"]:.0f} bad {m["bad"]:.0f} -> {"SLOW" if slow else "fast"}  {subj[:80]}', flush=True)
    if slow:
        hi = mid
    else:
        lo = mid
print(f'first slow: {line[hi]} {subprocess.run(["git", "-C", W, "log", "-1", "--format=%s", line[hi]], capture_output=True, text=True).stdout.strip()}')
print(f'last fast: {line[lo] if lo >= 0 else GOOD}')

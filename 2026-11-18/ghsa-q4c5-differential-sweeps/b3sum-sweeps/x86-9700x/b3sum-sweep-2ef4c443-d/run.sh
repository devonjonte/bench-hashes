#!/bin/sh
# Declared before running (November 18, 2026, UTC). Question: does b3sum at the 0.10.0 candidate (2ef4c443),
# or the published b3sum 0.9.0, print a digest that differs from official b3sum 1.8.7's for any file length
# of a dense set (every length to 4200 bytes; around each KiB to 600 KiB, each 64 KiB to 24 MiB, each 16 KiB
# from 4 to 8 MiB, and close around each multiple of the 2 MiB direct-read piece), warm and cold, with
# --num-threads 1 and --no-mmap, and for 150 runs of many files of assorted lengths? The programs are the
# ones the b3sum suite built on this machine. A correctness test, no timing. It passes when the last line
# reads "0 wrong"; any other count is a finding to report privately.
set -u
O=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
if [ "${BOUNDED_SWEEP:-}" != yes ]; then
  export BOUNDED_SWEEP=yes
  status=0
  timeout --kill-after=30s 5400s sh "$0" || status=$?
  printf 'B3SUM_SWEEP_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
BINS="$HOME/b3sum-contenders-evolution"
S="$HOME/work/b3sum-sweep-scratch"
for b in b3sum-official-1.8.7-L0 b3sum-2ef4c44-L0 b3sum-bf2da8b-L0; do test -x "$BINS/$b" || { echo "missing $b"; exit 3; }; done
{ uname -srm; nproc; df -T "$HOME/work" | tail -1; "$BINS/b3sum-2ef4c44-L0" --version; "$BINS/b3sum-bf2da8b-L0" --version; "$BINS/b3sum-official-1.8.7-L0" --version; } > "$O/machine.txt" 2>&1
cat > "$O/b3sum_sweep.py" <<'PY'
#!/usr/bin/env python3
"""b3sum's digests against official b3sum's over a dense set of file lengths, warm and cold, and for runs of
many files. Process plumbing only: every digest is a program's own output line.

    b3sum_sweep.py SCRATCH_DIR OFFICIAL NAME=PROGRAM...

One file is truncated down through the lengths (its bytes stay the big file's first bytes). At each length:
official's digest (the reference, file warm), then each program warm; for 256 KiB and more also with
--num-threads 1 and with --no-mmap; for 1 MiB and more also cold (the file's pages dropped first, checked
with mincore through the program's own behaviour only: the drop is fsync + POSIX_FADV_DONTNEED), plain and
with --num-threads 1. Then runs of many files of assorted lengths in one call, warm and cold.
A digest that differs, or a program that exits nonzero, counts as wrong, and the first few are named."""
import os, random, subprocess, sys
scratch, official, programs = sys.argv[1], sys.argv[2], [a.split('=', 1) for a in sys.argv[3:]]
os.makedirs(scratch, exist_ok=True)
KIB, MIB = 1024, 1 << 20
BIG = 24 * MIB + 8192
rng = random.Random(402)
data = rng.randbytes(BIG)

def lengths():
    out = set(range(0, 4201))
    out |= {k * KIB + d for k in range(4, 601) for d in (-1, 0, 1)}
    out |= {k * 64 * KIB + d for k in range(9, 385) for d in (-1, 0, 1)}
    out |= {k * 16 * KIB + d for k in range(256, 526) for d in (-1, 0, 1)}
    near = (-4097, -4096, -4095, -1025, -1024, -1023, -65, -64, -63, -1, 0, 1, 63, 64, 65, 1023, 1024, 1025, 4095, 4096, 4097)
    out |= {m * 2 * MIB + d for m in range(1, 13) for d in near}
    if os.environ.get('B3SUM_SWEEP_SMOKE'):
        out = {0, 1, 4095, 300 * KIB, MIB + 1, 4 * MIB + 4097}
    return sorted((l for l in out if 0 <= l <= BIG), reverse=True)

def run(program, flags, paths):
    r = subprocess.run([program, *flags, *paths], capture_output=True, text=True)
    if r.returncode != 0:
        return None
    return [line.split()[0] for line in r.stdout.splitlines()]

import ctypes
libc = ctypes.CDLL(None, use_errno=True)
libc.mmap.restype = ctypes.c_void_p
libc.mmap.argtypes = [ctypes.c_void_p, ctypes.c_size_t, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_long]
libc.mincore.argtypes = [ctypes.c_void_p, ctypes.c_size_t, ctypes.c_void_p]
libc.munmap.argtypes = [ctypes.c_void_p, ctypes.c_size_t]
by_kind = {}
drops = {'made': 0, 'first try left a page': 0, 'left a page': 0, 'left the first page': 0, 'left a tenth or more': 0}

def resident(fd, length):
    """(pages of the file in the cache, whether the first is) by mincore."""
    at = libc.mmap(None, length, 1, 1, fd, 0)  # PROT_READ, MAP_SHARED
    assert at not in (None, ctypes.c_void_p(-1).value), 'mmap'
    vec = (ctypes.c_ubyte * ((length + 4095) // 4096))()
    assert libc.mincore(at, length, vec) == 0, 'mincore'
    libc.munmap(at, length)
    return sum(b & 1 for b in vec), bool(vec[0] & 1)

def drop(path):
    """Drop the file's pages (up to three tries), and count what stayed."""
    fd = os.open(path, os.O_RDONLY)
    try:
        length = os.fstat(fd).st_size
        drops['made'] += 1
        for attempt in range(3):
            os.fsync(fd)
            os.posix_fadvise(fd, 0, 0, os.POSIX_FADV_DONTNEED)
            pages, first = resident(fd, length) if length else (0, False)
            if attempt == 0 and pages:
                drops['first try left a page'] += 1
            if not pages:
                break
        drops['left a page'] += pages > 0
        drops['left the first page'] += first
        drops['left a tenth or more'] += pages * 4096 * 10 >= length > 0
        kind = ('one' if os.path.basename(path) == 'one' else 'many') + ', ' + next(name for limit, name in ((4096, 'under 4 KiB'), (65536, 'under 64 KiB'), (1 << 20, 'under 1 MiB'), (4 << 20, 'under 4 MiB'), (1 << 62, '4 MiB and more')) if length < limit)
        c = by_kind.setdefault(kind, [0, 0]); c[0] += 1; c[1] += pages > 0
    finally:
        os.close(fd)

found = {}
def see(name, what, right, where):
    c = found.setdefault((name, what), [0, 0, []])
    c[0] += 1
    if not right:
        c[1] += 1
        if len(c[2]) < 6:
            c[2].append(where)

path = os.path.join(scratch, 'one')
with open(path, 'wb') as f:
    f.write(data)
for length in lengths():
    os.truncate(path, length)
    want = run(official, [], [path])
    assert want is not None and len(want) == 1, ('official b3sum failed', length)
    for name, program in programs:
        see(name, 'one file, warm', run(program, [], [path]) == want, length)
        if length >= 256 * KIB:
            see(name, 'one file, warm, --num-threads 1', run(program, ['--num-threads', '1'], [path]) == want, length)
            see(name, 'one file, warm, --no-mmap', run(program, ['--no-mmap'], [path]) == want, length)
        if length >= MIB:
            drop(path)
            see(name, 'one file, cold', run(program, [], [path]) == want, length)
            drop(path)
            see(name, 'one file, cold, --num-threads 1', run(program, ['--num-threads', '1'], [path]) == want, length)
os.remove(path)

# Runs of many files in one call: lengths drawn from every kind, a few of them large.
kinds = [lambda: rng.randrange(0, 200), lambda: rng.randrange(0, 70 * KIB), lambda: 16 * KIB * rng.randrange(0, 8) + rng.choice((0, 1, 16 * KIB - 1)),
         lambda: rng.randrange(256 * KIB, 2 * MIB), lambda: 2 * MIB * rng.randrange(1, 5) + rng.choice((-4096, -1, 0, 1, 4096, 4097)), lambda: rng.randrange(4 * MIB, 12 * MIB)]
weights = [4, 6, 4, 2, 1, 1]
many = os.path.join(scratch, 'many'); os.makedirs(many, exist_ok=True)
for trial in range(3 if os.environ.get('B3SUM_SWEEP_SMOKE') else 150):
    count = rng.choice((2, 3, 5, 17, 40, 100))
    paths = []
    for i in range(count):
        n = min(BIG, rng.choices(kinds, weights)[0]())
        start = rng.randrange(0, BIG - n + 1)
        p = os.path.join(many, f'f{i:03}')
        with open(p, 'wb') as f:
            f.write(data[start:start + n])
        paths.append(p)
    want = run(official, [], paths)
    assert want is not None and len(want) == count, ('official b3sum failed', trial)
    for name, program in programs:
        see(name, 'many files, warm', run(program, [], paths) == want, f'trial {trial}, {count} files')
        for p in paths:
            drop(p)
        see(name, 'many files, cold', run(program, [], paths) == want, f'trial {trial}, {count} files')
        for p in paths:
            drop(p)
        see(name, 'many files, cold, --num-threads 1', run(program, ['--num-threads', '1'], paths) == want, f'trial {trial}, {count} files')
    for p in paths:
        os.remove(p)
total = wrong = 0
for (name, what), (n, bad, first) in sorted(found.items()):
    total += n; wrong += bad
    print(f'{name}: {what}: {n} runs, {bad} wrong' + (f' (first: {first})' if bad else ''))
print('drops before cold runs: ' + ', '.join(f'{k} {v}' for k, v in drops.items()))
print('drops by file (made, left a page): ' + '; '.join(f'{k}: {a}, {b}' for k, (a, b) in sorted(by_kind.items())))
print(f'in all: {total} runs, {wrong} wrong')
sys.exit(1 if wrong else 0)
PY
start=$(date +%s)
python3 "$O/b3sum_sweep.py" "$S" "$BINS/b3sum-official-1.8.7-L0" "b3sum-0.10.0=$BINS/b3sum-2ef4c44-L0" "b3sum-0.9.0=$BINS/b3sum-bf2da8b-L0" > "$O/sweep.txt" 2> "$O/sweep.stderr.txt"
s=$?
rm -rf "$S"
tail -3 "$O/sweep.txt"
printf 'exit %s, %s s\n' "$s" "$(( $(date +%s) - start ))"
exit "$s"

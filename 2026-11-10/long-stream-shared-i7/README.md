# The stream's long messages, two programs at once, on the i7-12700K (November 10, 2026)

**Question.** bench-hashes 0.21's rehearsal read two cells of
BLAKE3-Servil's pin slower than 0.8: the multithreaded stream of 4 MiB
and 16 MiB messages while a second program does the same on the same
cache (`shared-one-cache`). Whose is it, the library's or the bench's,
and which change?

**Verdict.** The library's, from one commit: **06f6e26d** (November 4),
"stream: an 8 MiB ring of their own for messages of 4 MiB or more".
Against its parent, with one bench on both sides, 16 pairs
(`d.stdout.txt`, `d1-compare.md`, samples in `kept-d1/`):

| multithreaded stream cell | parent, ns/B | 06f6e26d, ns/B | | pairs faster |
|---|---|---|---|---|
| 4 MiB, shared one cache | 0.0514 | 0.0781 | **+52.0% slower** | 0 of 16 |
| 16 MiB, shared one cache | 0.0628 | 0.0815 | **+29.8% slower** | 0 of 16 |
| 16 MiB, solo | 0.0488 | 0.0503 | **+3.2% slower** | 3 of 16 |
| 4 MiB, solo | 0.0463 | 0.0443 | **4.2% faster** | 15 of 16 |
| 1 MiB, solo and shared | | | level | |

The commit's own message measured its ring size on an M4 Max and chose
8 MiB over 64 MiB because the larger ring cost the Mac's shared cell 19%.
No x86 machine checked it. The i7's cores share one 25 MiB cache.

## How it was found, step by step

| step | sides | result |
|---|---|---|
| rehearsal 5's release check (`../release-021-rehearsal-5-i7/check.stdout.txt`) | the pin 5663b129 with bench 7c1645d4, against 0.8 with bench 3363bee8, every cell | shared 4 MiB +33.1%, 16 MiB +29.9%, 4 pairs each, every pair slower |
| `a` | the pin against `next` before November 10's landings (a4095ba6), bench 7c1645d4 on both | level, 8 pairs: the day's landings are clear. Both sides read 0.071 at shared 4 MiB |
| `b` | 85bf73a6 against db3cab99 (the November 7 pipeline commits), bench a9a57a09 on both | level; both sides already at 0.072 |
| `c`, part 1 | 27717b3f (the last commit with 0.8's API) against 0.8, bench 3363bee8 on both | shared 4 MiB +40.3%, 16 MiB +31.2%: the library's |
| `c`, part 2 | 06f6e26d against its parent e4ef6f07, bench 3363bee8 on both | shared 4 MiB +41.8%, 16 MiB +31.2%: this commit |
| `d`, part 1 | the same, 16 pairs | the table above |

The saved full runs from this machine agree: shared 4 MiB read 0.050 to
0.056 ns/B through November 3 (library 0.8) and 0.077 to 0.090 on
November 9 and 10.

## Why the whole-map check of November 7 passed it

`../../2026-11-07/fullgate-tip-vs-08-i7/` compared a library with this
commit against 0.8 over every cell and read "no cell slower". Replayed
today (`e`: the same commits, the same benches, `--cells all`), it reads
"no cell slower" again, while its samples (`kept-e/`) hold the cell at
0.0507 → 0.0701, x1.38, every pair slower. With three points named
(`d`, part 2, `kept-d2/`) the same sides read "REGRESSION: 2 cells
slower".

The cause is the rule's second stage. Judged among every cell of the map
at four pairs, the cell fell just short of the first stage's bar, so it
depended on the second stage. That stage takes eight suspects, the cells
whose instruction counts moved first; 17 level cells had moved counts,
all single-threaded and solo, and they took all eight places. A release
check spans a large diff, so this is where it happens. The bench's issue
for it is linked from bench-hashes #163.

## The check's repair, tried on this case (bench-hashes #166)

The repair gives the second stage's eight places to moved counts and
slower cells in turn. Two trials, both judged by the November 7 bench
with the repair ported onto it (devonjonte/bench-hashes
`scratch/devon-166-replay`, 3ee8b5cc; the library of this case builds with
that bench alone):

- **`e-suspects-replayed.txt`: run `e`'s own samples, replayed.** Of 476
  cells none is slower in the first stage; 16 level cells have moved
  counts and 21 are slower beyond the margin, the two regressed cells
  first and second among them by evidence. The old order names the eight
  single-threaded solo cells that run `e` named. In turn, both regressed
  cells take a place (second and fourth of eight), and shared 64 MiB a
  third.
- **`f`: the whole-map check run again.** It reads "REGRESSION: 2 cells
  slower", in its first stage: the two cells cleared the first stage's
  bar this time (+36.3% and +35.0%, four pairs), as they did in rehearsal
  5 and did not on November 7 or in run `e`. So `f` shows the first
  stage's verdict on these cells is marginal at four pairs among this
  many cells; it does not exercise the repair.

**Machine.** i7-12700K, Linux 7.0.0-42 (booted November 3), mains power,
governor `powersave`; every check waited for a quiet machine and ran
alone.

# Why unchanged code reads faster or slower, and how to stop it

i7-12700K (Linux 7.0, P cores 0-15, E cores 16-19), bench-hashes main
e977b499, default contenders, October 15, 2026. Evidence:
`/home/agent/bench-hashes-validation/delta48/` (Devon's machine).

## What we saw

servil 55c1804 against candidate/devon-ring 270dcea, 5 alternating pairs,
`compare`'s paired verdict: SHA-256, identical code in both binaries,
read faster in 17 of its 360 cells (x0.86-0.96) and slower in none; 43
verdicts over all 700 cells.

## Controls

| comparison (5 pairs, 700 cells) | code | verdicts |
|---|---|---|
| the same binary against itself (A/A) | identical | 15 (13 faster, 2 slower) |
| A/A with address randomization off (`setarch -R`) | identical | 20 (9 faster, 11 slower) |
| one source linked twice, lld `--shuffle-sections` seeds 1 and 2 | identical | 27 (17 faster, 10 slower) |
| servil 55c1804 against ours | different | 43 (33 faster, 10 slower) |

## Causes, each measured

1. **Cold calls vary in cycles, not in clock or core kind.** With the
   thread's P and E counts on Linux (clocks, `linux_counts`, new) and
   `--trace-clocks`, the after-gap cells' samples spread p90/p10 1.25-1.67
   in wall time; the clock (cycles per wall ns) 1.03-1.12; cycles 1.27-1.67;
   samples touching an E core 0-1.7%. A call after the gap takes more or
   fewer cycles as the caches, TLBs and predictors hold more or less of
   it. A run's 12 skewed samples leave its mean uncertain by several
   percent.
2. **Each run's address layout (ASLR) moves many cold cells together.**
   With ASLR on, a run's ManyMessages cells sat as a group 2-3% from the
   others' medians (three of ten runs: +2.1, +2.4, -2.9%); its run means
   varied 1.49 times what its samples predict. With ASLR off: within 1%,
   1.07 times; and the A/A verdicts' direction balanced (13:2 -> 9:11).
   The virtual addresses of the gap program's code and the hash's decide
   how they collide in address-indexed structures, fixed within a run.
3. **Each binary's link layout shifts its cold cells.** ASLR moves code
   by whole pages, so offsets within a binary never average out: two
   builds of one source differ (27 verdicts), as two builds of different
   sources do.
4. **700 tests at a per-cell rate of 2-3%** give 15-20 verdicts with no
   change at all; the sign test with 5 pairs cannot reach a stricter rate.

## A fix, tested on the same data

- **A fresh layout for every pair, on both sides** (`tools/fresh-layouts.sh`): each run's binary
  relinked with its own `--shuffle-sections` seed (18 s a relink), ASLR
  left on. Layout becomes noise the test measures, not a bias between two
  builds.
- **One test per cell over the pairs, and the false discovery rate
  controlled over all cells**: a paired t-test on log(new/old) of the run
  means, Benjamini-Hochberg at q = 0.05; a minimum effect (the regression
  check's 3%) for a verdict.
- **Ten pairs.**

Results: the three unchanged-code comparisons above, 5 pairs each: **0
discoveries** (raw p < 0.05: 29, 31, 39 of 700). servil 55c1804 against
ours, 10 pairs, fresh layouts: 12 discoveries, 11 BLAKE3 cells matching
the code's changes (OneMessage 3839 B x0.86-0.88, ContinuousMessages 1 KiB
x0.83-0.89, Collection Nix files solo x0.90; Interleaved 256 open
x1.11-1.13 and Collection shared x1.11-1.13 slower) and SHA-256 (ring) 64
MiB ContinuousMessages x1.007, which the 3% minimum removes.

Open: the t-test and its p-values use floating point (the statistics
need it). `compare` takes the rule here; `regress` keeps its sign test
until Zooko and John decide (its points, pairs and margin are frozen).

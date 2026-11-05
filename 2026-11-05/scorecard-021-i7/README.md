# Scorecard for 0.21 (i7-12700K, November 5, 2026)

One line per release, so "are the tools better than at the last release" has
a standing answer (Zooko, November 5). Bench candidate/devon-raw-clock at
cc3fdb00 (PR #128); BLAKE3-Servil 0.8 b5b988d8 as the base; the machine idle.

**(a) Detection: `check` on an A/A and three plants** (the A/A over every
cell; each plant over the cells it reaches; 4 pairs, then 8 suspects on 64).

| run | verdict | caught by | time |
|---|---|---|---|
| A/A (0.8 against itself) | no cell slower, both stages: **0 false** | | 40 min |
| #119's cold code (f108640d) | **REGRESSION: 2 cells** (3839 B +5.0%, 7935 B +4.9%) | second stage, suspects by instructions | 45 min |
| 450-tick spin (BLAKE3-p1) | **REGRESSION: 28 cells** (64 B lent +292%) | first stage | 11 min |
| 450-tick cold spin (BLAKE3-plant) | **REGRESSION: 8 cells** (64 B lent shared +34%) | first stage | 22 min |

At 0.20 (November 1-4): the A/A had one false positive in the release check;
#119 was caught 1 of 4 times. **4 of 4 now, 0 false.**

**(b) The suite and the mutants.** `cargo nextest run --release`: 0.6 s
(13.7 s at 0.20); the machine profile 12 s apart. Mutants of the judge's
functions: 208 of 208 caught (never run before 0.21); of `clocks`' five
files: 479 of 536 viable (2026-11-04/clocks-mutants).

**(c) The library: servil's tip (06f6e26d) against 0.8 on the overview's
six cells**, 8 pairs through `regress` (c.stdout.txt, c-runs/): every cell
level; the largest moves 64 B x0.95 (both contenders) and st 1024-message
batch x1.025. The library is where 0.8 left it, on this machine.

Second-stage kept pairs are in each plant's `second/`; the first stage's
runs (426 cells x 8 runs, 100 MB) stay in bench-hashes-validation/aa-021-i7.

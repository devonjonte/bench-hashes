# How often does `bench-hashes check` find a real slowdown? (i7-12700K, October 31)

**Question.** BLAKE3-servil 0.8 shipped a real slowdown: #119's cold
one-message cost, +3% to +11% in the cells hashing 3839 B and 7935 B
(st and mt, after other work and after idle). BLAKE3 PR #210 fixes it
(f108640d). So `check --against f108640d` on `servil` (70ddb676) is a check
with a known answer, slower. How often does `check` give it, and how often
does it call identical code slower?

**Commits.** Bench: johnservil/bench-hashes main b2324e98 with the changes
named below (bench PR, branch `candidate/devon-check-links`). Fork: servil
70ddb676; its fix f108640d; for the ranking runs, both with the clocks
commit 2702a999 / 4733e511 (BLAKE3 branch `candidate/devon-evidence-rank`,
which adds `Judgment::rank` and changes no hash code).

**Results** (`regress: ` lines of each `*.stdout.txt`):

| check | known slowdown caught | identical code, no cell slower |
|---|---|---|
| as released: 4 pairs, suspects by ratio, 16-pair second stage (`known-*`, `aa-*`) | 1 of 2 | 4 of 4 |
| suspects by evidence, 16 pairs (`rank-known-*`, `rank-aa-*`) | 0 of 3 | 3 of 3 |
| suspects by evidence, second stage 64 pairs from its 16 links (`e2e-rank-known-*`) | 1 of 3 | |
| suspects by ratio, 64-pair second stage (`reuse-check-*`) | 1 of 3 | 3 of 3 |
| **8 pairs (4 links a side, each run twice), suspects by evidence, 64-pair second stage** (`both-*`) | **3 of 3** | **3 of 3** |
| the 8 slowed cells alone, 64 pairs from 16 links (`reuse-known*`, `reuse-aa*`, `regress` direct) | 3 of 3 | 3 of 3 |

**Why the released check misses it** (the exploratory readers in `tools/`):
- Judged among 420 cells at 4 pairs, a lone cell must roughly double to
  read slower; the second stage carries detection.
- At 4 pairs the second stage's 8 suspects held a slowed cell in 6 checks
  of 11; at 8 pairs, ranked by evidence (p-value), in 52 of 55
  resamplings of those checks (by ratio 42 of 55).
- At 16 pairs, the second stage judged the slowed cells it picked level;
  at 64 pairs, it found them.
- Reusing a link is cheap and costs little: seven A/A checks ran the same
  links a side, and their cells' ratios correlated 0.03 check to check.

**Also found, unresolved.** About 1 sample in 1000 loses 25-400 us to the
environment (`stall-probe/`): stops of up to 0.4 ms come on a 60 Hz beat,
on one core at a time, from a task outside the sandbox's pid namespace;
the counters show the thread on core with few cycles. Under the mean of
every sample, one moves a cold cell's run by up to 7x. Leaving them out
narrowed the worst cells (27.7% to 13.1%) but did not decide #119 alone.

**Planted delays** (`plant450-*`, `plantmt-*`, `plantcold-*`): 450 TSC
ticks before each call: the repeated-call cells caught at +16% to +290%;
the cold one-call cells (+5% to +20%) never judged slower.

**Dropped:** a bootstrap simulation (`tools/simulate.py`) gave false alarms
the real checks never did (resampling 20 pairs from 17 repeats outliers).

**Commands.** `study.sh`, `plant*.sh`, `known.sh`, `rank*.sh`, `e2e*.sh`,
`reuse*.sh`, `both.sh`, each run through `run-bounded.py`.

**Posted:** bench-hashes PR and BLAKE3 PR (links in their texts).

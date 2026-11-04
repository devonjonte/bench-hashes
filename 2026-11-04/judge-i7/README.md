# Which quantity detects what: wall time, cycles, instructions (i7-12700K; bench-hashes #127)

**Question** (Zooko, November 4). `check` judges wall time. Would the
thread's cycles or instructions retired, kept per sample since v9, catch
a planted slowdown wall misses, and would they flag an unchanged library?

**Method.** bench-hashes `candidate/devon-raw-clock` (samples v9: the raw
clock, instructions beside cycles), `check --cells all --keep` on four
comparisons (`run.sh`), then `compare --judge-by wall|cycles|instructions`
on each run's kept pairs (`judge.sh`): the first stage's 4-5 pairs over
every cell, and the second stage's 64 pairs over its suspects where one
ran. The judge is the one rule (a paired t-test on log ratios, a 5% false
discovery rate over all cells, then a 3% margin) for every quantity.

| comparison | wall | cycles | instructions |
|---|---|---|---|
| A/A (b5b988d8 against itself; the second stage lost its verdict to other load on the host) | 0 slower, 0 faster of 370 | 0 / 0 | 0 / 0 |
| **known119**: 0.8 (its cold 3-4 KiB code, BLAKE3 #119) against its fix f108640d | **0 slower** (first and second stage; the 3839 B cells never reached the suspect list) | 0 slower | 0 slower by the 3% margin, **but 3839 B reads x1.012 in every pair, 0 of 5 faster, st and mt, awake and after a pause** (6.344 to 6.420 instructions a byte) |
| spin450: 450 TSC ticks before every `hash_multithreaded` (a spin) | 15 slower (LentMessages 128 B x2.49) | 15 slower | **1 slower** (128 B x1.029: a spin is time, few instructions) |
| cold450: the spin before cold calls alone | 6 slower | 5 slower | 1 slower |
| hash3 (3% in hash(), October) | the bench no longer builds against its API | | |

**What it says.**
1. **Instructions are deterministic** (x1.000 on the A/A in every cell;
   the same count in every pair), so a consistent 1.2% is a real change
   of the code's work, and #119's cold code shows exactly so. The rule's
   3% margin, sized for wall noise, hides it: an instructions judge needs
   its own margin (a few tenths of a percent) and would have caught #119
   at the first stage, where wall missed it twice (0.19 and now).
2. **Instructions cannot see waiting**: the planted spin costs x2.5 of
   wall time and x1.03 of instructions. Cycles see it as wall does.
3. **Cycles on cold cells are as noisy as wall** (3839 B: x1.076, 1 of 5
   pairs faster, both quantities): the cold cost is cache state, which
   both measure; what cycles remove is the clock's frequency (the Xeon's
   x2.4 after a pause at level cycles, Sam's #127 table).
4. **Wall missed #119 because the suspect list is ranked by evidence**
   (p-value): with 5 noisy pairs over 370 cells, a real 8-11% at two
   cells ranks below noisier cells, and the second stage never sees it.

**A proposal for Zooko and John:** keep wall as the gate; add an
instructions judge with its own margin (0.5%) for the solo cells as a
second verdict, "more instructions: the code does more work" (a review
question, since an optimization may spend instructions to save cycles),
and let a cell that instructions flag join the second stage's suspects.
That is the one change this data supports; cycles as a judge it does
not.

**Posted.** bench-hashes #127.

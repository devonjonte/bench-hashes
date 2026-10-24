# Line gate, October 24 2026 (i7-12700K): the pool's survivors read

**Question.** Does removing Task::run's unreachable batch branch (devonjonte/BLAKE3
bfb476c, on 90677bb) slow any cell?

**Command.** `bench-hashes check --against servil` (90677bb), two stages
(bench-hashes f4a8f4eb), under run-bounded.

**Verdict.** 7 cells execute a changed line (servil mt's continuous
cells); no cell slower in the first stage, one suspect (shared
ContinuousMessages 16 MiB), no cell slower on 16 fresh pairs.

Also here: `timeout_tests.py`, which lists the tests the clock stopped
for each timed-out mutant in a kept check.py run (the evidence behind
90677bb's time-out reasons), and `cell_ratios.py`.

**Posted.** johnservil/BLAKE3 #140.

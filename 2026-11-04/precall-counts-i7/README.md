# The counter reads between a pause and its call (i7-12700K, November 4, 2026)

Question: a `Counts::read()` sits between a cell's pause and its timed call.
Does its cost reach the call?

Three builds of bench-hashes `candidate/devon-raw-clock`, each 3 runs of
`--contenders blake3-servil-st --points "brief idle 64 B,idle 64 B,brief idle 1 KiB,idle 1 KiB,brief idle 16,idle 16"`:
`counts` (6f02a1db, reads by the `read` system call), `nocounts` (the same
with `Counts::read` returning None), `rdpmc` (the next commit, reads in user space).

Median of each run's medians, as a ratio to `nocounts`:

| cell | nocounts ns/unit | syscall | rdpmc |
|---|---|---|---|
| brief idle 64 B | 1.09 | 1.132 | 1.013 |
| brief idle 1 KiB | 0.72 | 1.023 | 0.999 |
| brief idle 16 | 14.44 | 1.046 | 1.006 |
| idle 64 B (5 ms) | 19.22 | 0.877 | 0.957 |
| idle 1 KiB | 1.83 | 0.964 | 1.119 |
| idle 16 | 117.27 | 1.007 | 1.058 |

Verdict: the system calls disturb the brief cells by 2-13% and warm the core
after the long pause (the 64 B call 12% faster); rdpmc brings the brief cells
within 1.3% of no reads. The 5 ms cells vary between runs (the third rdpmc run
met shallow states: 34.84, 0.98, 4.75), the bimodality #117's controlled block
addresses; they say nothing about the reads at three runs.

Posted: bench-hashes #127. Data: run-*/benchmark-results (samples v9).

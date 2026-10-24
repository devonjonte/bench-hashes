# Solo ManyMessages per process on the i7-12700K (bench-hashes #69)

**Question** (Sam Shackleton, EPYC 9255): solo ManyMessages lands in one
of two states a process, about 1.6x apart, and the slow one needs a
second allowed CPU in the measuring thread's CCD. Does the i7, one L3
for all cores, show two states?

**Build.** The `diag-align64` bench of `2026-10-24/placement-i7`
(johnservil/bench-hashes f4f347c1 + Sam's allocator options; servil
b94e2fac), so #65's windows are absent, as in Sam's runs.

**Command.** `sweep.py` under run-bounded: servil st, `--points 64,256
--for-regression-check --rounds 24`, 32 processes per placement: unpinned,
`taskset -c 0`, `0,2`, `0,1` (one P core's two threads), `0,16` (a P and
an E core), `16`. Columns: placement, messages, min, median, max,
max/min, then every process's mean (ns/message).

**Verdict.** No second state. Under every placement at most 3 of 32
processes are above 1.15x the median, and those at about 1.2x (64
messages: medians 29.3-30.4 on P cores, 65.2 on an E core; 256: 20.8-21.2,
41.4). The EPYC's slow state (up to 15 of 32 at 1.55x and more) does not
appear on this Intel.

**Posted.** johnservil/bench-hashes #69.

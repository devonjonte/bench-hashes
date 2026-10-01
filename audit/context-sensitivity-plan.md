# Selected-workload context sensitivity: fixed before execution

The exact-artifact nulls leave causality open. This follow-up varies selected
neighboring workloads while holding the executable, affinity and roster fixed.
It tests context sensitivity; selecting different points also changes input
allocation size, cache layout and calibration history, so it does not isolate
one immediate predecessor's aftereffect.

- Reuse exact null executable6d032dc2ffe48c3027a8fc9cc9ed41ad1e2cbbdc5b098d8dbbee9ab3677860ae.
- Affinity0-15, roster sha256,blake3-servil-st,blake3-servil-mt.
- A: continuous1 KiB, continuous batch16, continuous batch4096.
- B: those same points plus lent1 MiB and lent pieces64 MiB.
-120 explicit rounds, completing the two/six-order participant designs and
  extending the narrow process long enough for load coverage.
- Sequence A1/B1/B2/A2/B3/A3/A4/B4, two opposite-order blocks. Each process
  has a120-second process-group deadline; retain failures/busy/missing-load.
- Existing clocks trace, exact accounting and report checks. Shared reader
  and speed rules; compare the common points with repeats beside them.

A repeatable change identifies a selected-context dependence under these
conditions. It does not identify compiler, allocator, scheduling, power or
cache causality. A null result bounds only these contexts on this machine.
Keep all cells and directions, including SHA-256 and disagreeing blocks.
Frozen production calls remain intact; optimization remains paused.

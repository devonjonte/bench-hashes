# The 0.8 integration against `servil`, i7-12700K: 5 cells slower, all after a pause

**Question:** does the integration of 0.8's candidates, with pair.rs, the
kernel names and every shape proved, slow any cell on x86 against
`servil`, with the workload held (inputs in blocks on both sides)?

**Commits:** new, devonjonte/BLAKE3 `candidate/devon-release-0.8` 425ce09
(John's `candidate/release-0.8` 3610022, with pair.rs back, #164's names
on this tree, and #166), the bench at d21cdf36; old, johnservil/BLAKE3
`servil` c75daeb, with the bench at 5be5f236 (inputs in blocks, the old API).

**Command:** `bench-hashes check --against c75daeb --old-bench 5be5f236
--cells all --keep kept` under run-bounded.py, October 25, 12:16 UTC.

**Verdict:** "REGRESSION: 5 cells slower", each after a pause, with noisy
pairs (16 fresh pairs each, a few negative):

| cell | geometric mean |
|---|---|
| servil mt IdleManyMessages 3 | +16.4% |
| servil mt IdleManyMessages 24 | +12.1% |
| servil st IdleManyMessages 2 | +11.9% |
| servil mt IdleManyMessages 16 | +11.5% |
| servil mt IdleOneMessage 1536 B | +11.0% |

Measured alone, #90 with pair.rs (`../x86gen-pair-i7`) and #157
(`../157-i7`) showed none of these, so the cost comes from another part of
the integration or from the parts together; code met cold after a pause
is the likely kind. The next step bisects (#141's chunk-root kernel
first).

**Posted:** BLAKE3 #125.

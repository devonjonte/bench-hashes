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

**Split by speed state** (the samples are bimodal), from the second stage:
at 16 messages the fast state's share falls (45% to 36%); at 2, 3 and
1536 B the slow state's median rises 13% to 16%.

**The repeat (`repeat/`, the same commits, 13:07 UTC)** judges one other
cell, mt IdleOneMessage 8 KiB, +15.9%, and none of the five. Both runs'
first stages read the same cells: mt 1536 B after a pause x1.199 and
x1.198, mt 8 KiB x1.167 and x1.151, st batches of 2 x1.178 and x1.120, st
batches of 3 x1.123 and x1.111. Across all 106 after-a-pause cells each
run's median is level (x1.009, x1.003). Single messages of 1.5 to 8 KiB
and small batches after a pause cost 7% to 20% more; which one the second
stage confirms varies.

**Posted:** BLAKE3 #125.

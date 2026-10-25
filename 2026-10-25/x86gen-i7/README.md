# x86-64's generated partial-chunk kernels (#90) against `servil`, i7-12700K: 5 cells slower, at 1536 B and 2 KiB

**Question:** Zooko wants every inner loop in assembly for 0.8 (#90). John's
`candidate/x86-generated`, rebased onto his `servil`, replaces the Rust
intrinsics with generated, proved assembly and deletes `pair.rs`. Does it
slow any cell on the i7?

**Commits:** new, devonjonte/BLAKE3 `candidate/devon-x86-generated`
265c959 (John's five WIP commits on c75daeb, conflicts settled as posted on
#90); old, johnservil/BLAKE3 `servil` c75daeb. The bench nested in both:
devonjonte/bench-hashes f4a8f4eb. Neither side has #152's private symbols;
both bind the same kernel names.

**Command:** `bench-hashes check --against c75daeb --cells all --keep kept`
from the bench inside ~/BLAKE3-x86gen, under run-bounded.py (5400 s),
October 25, 05:14 UTC.

**Verdict:** "regress: REGRESSION: 5 cells slower", each in every one or
nearly every one of 16 fresh pairs:

| cell | geometric mean of 16 pairs |
|---|---|
| servil st OneMessage 1536 B | +57.7% |
| servil st IdleOneMessage 1536 B | +61.6% |
| servil mt OneMessage 1536 B | +57.6% |
| servil mt IdleOneMessage 1536 B | +56.5% |
| servil mt OneMessage 2 KiB | +10.6% |

1536 B is a whole chunk and half of one: the path `pair.rs` took (its two
first blocks side by side through the AVX2 batch kernel), which the
shortcut A/B of October 24 measured at +22% to +29% when switched off
(`2026-10-24/shortcuts`). The branch deletes `pair.rs` with the intrinsics.

**Posted:** BLAKE3 #90.

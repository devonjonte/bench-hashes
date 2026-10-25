# #90's generated kernels with `pair.rs` back, against `servil`, i7-12700K: no cell slower

**Question:** the generated partial-chunk kernels without `pair.rs` made
1536 B 57% slower (`../x86gen-i7`). `pair.rs` is glue over the AVX2 and
AVX-512 assembly batch kernels, so with it back every inner loop is still
assembly. Does that recover the cells, and is anything else slower?

**Commits:** new, devonjonte/BLAKE3 `exp/devon-x86gen-pair` ba4efe7
(`candidate/devon-x86-generated` 265c959 plus `pair.rs` ahead of the spare
lane, as `servil` has it); old, johnservil/BLAKE3 `servil` c75daeb. The
bench nested in both: devonjonte/bench-hashes f4a8f4eb.

**Command:** `bench-hashes check --against c75daeb --cells all --keep kept`
under run-bounded.py, October 25, 05:43 UTC.

**Verdict:** "regress: no cell slower" in both stages. Four cells stayed
suspects below the bar; the second stage's figures (`second-compare.txt`,
17 pairs):

| cell | new / old | pairs faster |
|---|---|---|
| servil mt OneMessage 3839 B | 1.161 | 3 of 17 |
| servil st OneMessage 3839 B | 1.075 | 4 of 17 |
| servil st IdleOneMessage 2 KiB | 1.133 | 4 of 17 |
| servil mt IdleOneMessage 2 KiB | 1.055 | 6 of 17 |
| servil mt ManyMessages 3 | 1.063 | 5 of 17 |

3839 B is three whole chunks and a partial one: the spare-lane pass, the
generated kernel where the intrinsics were. These are below what the check
judges, and they stay visible here and on #90.

**Posted:** BLAKE3 #90.

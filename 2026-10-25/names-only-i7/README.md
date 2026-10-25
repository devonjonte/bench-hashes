# The kernel names alone (#164) against `servil`, i7-12700K: servil's own batch kernels, measured for the first time beside official's

**Question:** the 0.8 integration's after-a-pause cells read 7–20% slower
(`../release-08-i7`), while a probe that links servil alone shows the
calls level, in the normal link order and in 8 random ones (`probe/`). Is
the difference the bench binary's other crate, official BLAKE3?

**Commits:** new, devonjonte/BLAKE3 `candidate/devon-kernel-names-john`
bfbda19 (#164: John's `servil` with #152 and every assembly symbol
`blake3_servil_*`); old, `servil` c75daeb. The bench at 5be5f236 on both
sides, so the private names are the only difference.

**Command:** `bench-hashes check --against c75daeb --cells all --keep kept`
under run-bounded.py, October 25, 15:14 UTC.

**Verdict:** "no cell slower" in both stages, but the first stage reads
the small batches slower, warm and after a pause, with 0 or 1 of 4 pairs
faster (`stage1-compare.txt`): servil st ManyMessages 2 x1.102, 3 x1.091;
mt 2 x1.075, 3 x1.099, 16 x1.098; after a pause st 16 x1.192, mt 2 x1.173,
mt 3 x1.163. Single messages after a pause are level (mt 1536 B x0.979,
8 KiB x0.996). The median of the 106 after-a-pause cells is x1.029.

**Reading:** before #152 the bench binary held one copy of each kernel
name both crates export, and the linker kept official's, so the old
side's servil ran official's AVX2 and AVX-512 batch kernels (#151), whose
loads read past an input. The rename gives servil its own kernels, the
ones that keep every load within the input. Those cost a few percent on
small batches (more after a pause), and every servil program that doesn't
link official already ran them. The probe, which links servil alone,
agrees: its batch of two is level. So most of the batch cells' "slowdown"
is the old baseline's error, which the fix removes.

**Posted:** BLAKE3 #125.

# The batch calls not inlined, against the candidate as it is, i7-12700K

**Question (BLAKE3 #125):** do single-thread LentBatches 64-1024 read
+2-3.5% at the candidate because `performance::hash_many` (`#[inline]`)
is now compiled into the bench's closure?

**Commits:** new, devonjonte/BLAKE3 `exp/devon-inline-never` 828d90f
(f1db8cd with `performance::hash_many` and `hash_many_multithreaded`
`#[inline(never)]`, measurement only); old, johnservil/BLAKE3
`candidate/release-0.8` f1db8cd. Bench d21cdf36 on both sides.

**Command:** `check --against f1db8cd --cells all --pairs 8 --keep
samples` under run-bounded.py, October 26, 00:33 UTC.
`stage1-all-cells.txt` is `compare` over the first stage.

**Verdict:** inlining is not the cause, and it pays. LentBatches reads
level not inlined (16: x1.005, 64: x0.996, 256: x1.013, 1024: x0.996).
Not inlined, small batches are slower: st solo ManyMessages 2, 4, 16 read
x1.16, x1.16, x1.14 in the first stage (0-1 of 8 pairs faster), and the
second stage (16 pairs) judged 4 cells SLOWER (ManyMessages 2 +9.8%, 6
+7.3%, 16 +5.7%; IdleManyMessages 16 +17.6%). The `#[inline]` stays.

**Posted:** BLAKE3 #125.

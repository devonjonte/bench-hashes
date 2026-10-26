# The little-endian word conversions as 4-byte chunks, i7-12700K: gate and every cell

**Question:** `platform.rs`'s three word conversions were unrolled by
hand (44 lines, 86 mutants, 3 rows of equivalent ones in each list).
Written as `as_chunks::<4>()` with `array::from_fn` (7 lines, 6
mutants), does every suite pass, and is any cell slower? They sit under
pair.rs, the batch paths, the modes' keys and the portable kernel.

**Commits:** new, devonjonte/BLAKE3 `candidate/devon-le-words`; old,
johnservil/BLAKE3 `candidate/release-0.8` 93316ac. Bench d21cdf36.

**Command:** `run.sh` (the gate, then `check --against
origin/candidate/release-0.8 --cells all --pairs 8`) under run-bounded.py,
October 26, from 03:38 UTC.

**Verdict:** GATE PASSED; **no cell slower** in both stages. First stage
(`stage1-compare.txt`, 396 cells): median x1.002, 16 above +5% and 5 below
-5%, within the same-code controls' spread (`../../2026-10-25/aa-idle-i7`).

**Posted:** the BLAKE3 PR.

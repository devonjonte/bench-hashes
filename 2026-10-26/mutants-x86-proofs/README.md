# The proofs' planted-error controls, x86 stages, on Python 3.14, i7-12700K

**Question:** after John's 7e816f9 (three calls in `tools/verify/mutants.py`
that #171 left with the Windows argument), does every x86 control reject
its mutant? And why couldn't `mutants.py` run here?

**Commit:** devonjonte/BLAKE3 `candidate/devon-old-bench` 664087a
(John's `candidate/release-0.8` 93316ac plus #172, which touches no proof
tool).

**Command:** `run.sh` runs `run.py`, `mutants.py`'s `main()` x86 loops
unchanged (the Arm stage needs AArch64 binutils), under run-bounded.py
and `ulimit -v 6291456`.

**Verdict:**
- With Python 3.14's default start method (forkserver), the run stops at
  once: the jobs are closures, which can't be pickled. `mutants.py` has
  the same loops, so it fails the same way on any Linux with Python 3.14.
- With `multiprocessing.get_context("fork")`: both positive controls are
  proved, and every mutant is rejected (6 assembled AVX2, 4 memory, 4
  chunk-root): "x86 stages: 0 failures" (`run.stdout.txt`).

The fix for `mutants.py` itself: BLAKE3 PR "mutants.py forks its workers
by name".

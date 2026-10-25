# The x86-64 proofs under the kernels' new names, with pair.rs's shape, i7-12700K: all proved

**Question:** after #164 renamed every assembly symbol `blake3_servil_*`
(the proof tools look kernels up by name) and #166 added pair.rs's shape
to the cases (#163), do the x86-64 proofs still prove?

**Commit:** devonjonte/BLAKE3 `candidate/devon-xof-proved` 8cc53dd (the
line's `servil` with #164's rename, AVX-512 XOF 32 blocks per call, and
the new cases), the same tools as #166.

**Tools:** Z3 5.3.1 (z3-solver's PyPI wheel, unzipped; PYTHONPATH), clang,
llvm-ml and lld-link as `tools/verify/x86.py` finds them. Two workers at a
time: the 16-input AVX-512 cases take gigabytes each, and 6 or 16 at once
reached this machine's memory floor (15 GiB).

**Commands and verdicts:**
- `prove_pair.py`: pair.rs's shape, two inputs at consecutive counters,
  1 to 15 blocks, AVX2 and AVX-512, both conventions: **60 of 60 proved**
  (`pair.stdout.txt`).
- `representative6.py` (prove_x86.py's representative cases with 2
  workers in place of 16): **214 of 214 proved** (`representative.stdout.txt`).
- `ulimit -v 6291456; prove_x86_loop.py --workers 2`: **102 of 102
  all-count cases proved** (`loop.stdout.txt`), 06:41 to about 07:55 UTC.

- `full2.py` (prove_x86.py's full finite matrix, `cases()`, the 472
  cases plus the 52 new, with 2 workers): **524 of 524 proved**
  (`full.stdout.txt`), 07:11 to about 08:00 UTC.

Not run here: the Arm proofs (prove_hybrid, prove_sme2), which need an
AArch64 CPU for their cross-checks.

**Posted:** BLAKE3 #164, #166, #163.

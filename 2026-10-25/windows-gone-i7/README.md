# Windows removed (#169): the gate and the x86-64 proofs, i7-12700K

**Question:** with Windows removed (the build stops on Windows; the
proof tools prove the System V convention alone), do every suite and
every x86-64 proof still pass?

**Commit:** devonjonte/BLAKE3 `candidate/devon-windows-gone` 078daf1, on
John's `candidate/release-0.8` f1db8cd. The gate ran on its working tree
just before that commit; the commit added only `cargo fmt`'s trailing-comma
cleanup in b3sum's CLI tests (whose 29 tests then passed again) and
`prove_x86.py --workers`.

**Commands:** `gate.sh` (fmt, nextest three ways, doc tests, the C API,
b3sum both ways, clocks, Shuttle, cargo doc with warnings as errors,
the mutation tool's tests, the proof helpers' tests, qa_coverage and
check-builds, which now checks the Windows stop with Linux as its
control) and `proofs.sh` (`prove_x86.py --workers 2`, `prove_x86_loop.py
--workers 2` under `ulimit -v 6291456`, `cross_check_x86.py`), each under
run-bounded.py. Z3 5.3.1, clang and ld.lld as `tools/verify/x86.py` finds
them.

**Verdict:**
- the gate: **GATE PASSED** (`gate.stdout.txt`);
- the full finite x86 matrix: **342 of 342 proved** (23:02 to 23:14 UTC);
  the 155 representative cases are among them (`test_helpers.py` checks it);
- every input count: **51 of 51 proved** (23:14 to 23:27);
- the model against this CPU: 155 vector forms (39 memory forms), 200
  random states each, 14 alignment fault controls, all agree; 153
  AVX-512 forms skipped (no AVX-512 here).

Not run here: the Arm proofs, whose tools need AArch64 binutils.

**Posted:** BLAKE3 #169 and the PR.

# The full x86 mutation check on John's 8c34ead with #182, i7-12700K: passes

**Question (John, #125):** after the word conversions (909092c) and the
wide kernels' merge, does x86's list need anything beyond #182's rows?

**Commit:** devonjonte/BLAKE3 `candidate/devon-wide-rows` 1a95b9f
(johnservil/BLAKE3 `candidate/release-0.8` 8c34ead with #182).

**Command:** `run.sh` (`python3 tools/mutants/check.py`) under
run-bounded.py, October 26, 09:10-09:50 UTC.

**Verdict:** "652 survive, each known and explained"; "37 time out, each
known". Nothing beyond #182 moved. The 15 MACHINES DIFFER lines are
check.py's report of mutants x86 and AArch64 judge differently: the pool's
wakes, and SME2's turn and prefetch code (compiled out here).

**Posted:** BLAKE3 #182, #125.

# The full mutation check with Windows removed (#171), i7-12700K: passes

**Question:** does `tools/mutants/check.py` still pass once #171 removes
Windows (clocks' `process_cpu_ns` now returns u64, b3sum loses its
Windows paths)?

**Commit:** devonjonte/BLAKE3 `candidate/devon-windows-gone` 078daf1
(John's `candidate/release-0.8` f1db8cd with #171).

**Command:** `run.sh` (`python3 tools/mutants/check.py`) under
run-bounded.py, October 26, 01:31 to 02:05 UTC.

**Verdict:** "649 survive, each known and explained" and "37 time out,
each known": the check passes, with the same counts as 612e845
(`../../2026-10-25/mutants-rel08-i7`).

**Posted:** BLAKE3 #171.

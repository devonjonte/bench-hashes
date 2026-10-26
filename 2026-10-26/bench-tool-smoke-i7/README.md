# tools/mutants/bench.py's first run, start to finish, i7-12700K

**Question:** does the tool (BLAKE3 PR "tools/mutants/bench.py") run end
to end on x86-64 Linux, and does it give the verdicts the prototype gave?

**Commit:** devonjonte/BLAKE3 `candidate/devon-bench-mutants` (its
working tree before the commit; the commit added only `largest()`, the
three cells shown), on johnservil/BLAKE3 8c34ead; bench d21cdf36; caught
places from the x86 full run at 1a95b9f (`../mutants-8c34-i7`).

**Command:** `run.sh` (`bench.py --re` for two rows) under
run-bounded.py, October 26, about 11:35-11:55 UTC.

**Verdict:** both as before: `Pool::wake_for` → () **slower** (54 cells,
up to +758%); `hash_four_at_a_time` arm 3 **no cell runs it**.

**Posted:** the BLAKE3 PR.

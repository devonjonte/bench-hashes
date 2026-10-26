# The pool wakes through Park::wake_one alone, i7-12700K: gate, mutation check, speed check

**Question:** removing `any_parked` (a check `wake_one` repeats) and
`Pool`'s two forwarding wrappers deletes three functions and their
mutants. Does every suite still pass, do the mutation lists hold, and is
any cell slower?

**Commits:** new, devonjonte/BLAKE3 `candidate/devon-wake-one` 00b8e8b;
old, its parent `candidate/devon-list-check` a85db96 (John's
`candidate/release-0.8` 93316ac with the list-row check). Bench d21cdf36.

**Commands,** each under run-bounded.py, October 26:
- `gate.sh`: fmt, nextest three ways, doc tests, the C API, b3sum, clocks,
  Shuttle, cargo doc, the mutation tool's and proof helpers' tests,
  check-builds. **GATE PASSED.**
- `mutants.sh`: `check.py --since candidate/devon-list-check`, a whole run
  (the change alters test code): **644 survive, each known and explained;
  34 time out, each known** (from 649 and 37).
- `check.sh`: `bench-hashes check --against candidate/devon-list-check
  --pairs 8` over the 62 cells that execute a changed line: **no cell
  slower** in both stages (second stage: 5 suspects, 16 pairs).
  `stage1-compare.txt`: the first stage's 94 cells (62 cells and their
  shared twins), median x1.000, one above +5%, none below -5%.

**Not yet:** the EPYC and the Mac, which a pool change faces before it
lands.

**Posted:** the BLAKE3 PR.

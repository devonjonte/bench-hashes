# Devon's line: the mutation-test landing (October 23, 2026)

devonjonte/BLAKE3 `servil` from `9963ce09` to `0b2c4a7`-ish (see the
line): reach.py, hangs.txt folded into the time-outs list, six time-outs
made failures, one new test, lists.

- `gate3-mutants.*`: `check.py --write` on HEAD `9963ce09` with the skip
  list gone, every former hang run: 659 survivors (9 names new, 51
  former hangs: 15 caught, 8 survive, 34 time out), 70 time-outs.
- `gate4-suites.*`: the suites on `22396e14`: 101 and 100 nextest, 22
  doc, 3 vectors, 4 C API, every build.
- `gate4-mutants.*`: the check on `22396e14`: exit 1, six NO LONGER TIMES
  OUT (the waits made failures are caught), one NEW SURVIVOR
  (spin_for_work's inverted sense, alternating with a time-out).
- `gate5-mutants.*`: the check on the corrected lists: exit 0, 659
  survive each explained, 63 time out each listed.
- `replay-select-1/2.stdout.txt`, `replay-select.stdout.txt`: reach.py's
  selection replayed over 24 servil commits, three versions of the rule;
  `select-map.stdout.txt`: the first map, 100 tests under coverage.

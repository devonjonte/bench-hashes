# Devon's line: the mutation-test landing (October 23, 2026)

devonjonte/BLAKE3 `servil` from `9963ce09` to `a112b48`: John's servil `8e968d5` plus the
landings there: reach.py, hangs.txt folded into the time-outs list, six time-outs
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

`replay-select-4-final.stdout.txt`: the rule as landed (cfg on a function
selects the function's tests), over the same 24 commits: 8 ran nothing,
5 ran one or two tests, 1 ran 84, 10 ran everything (5 for a manifest or
nextest-config change, 5 for a `use`, an attribute on a module, or code
inserted outside any function: the cases a compiled fingerprint would
narrow). `replay-select.sh` is the replay.

`replay-select-5-names.stdout.txt`: with names (a changed use/const/type selects the tests that ran a line naming it): the same 10 everything, since the two `use` cases are a glob (`use super::*`) and a file not compiled on x86; the latter is skipped as of 38a65b1+1.

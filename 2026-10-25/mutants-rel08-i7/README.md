# The full mutation check on the 0.8 integration, i7-12700K: every survivor known and explained

**Question:** does `tools/mutants/check.py` pass on the release integration
(devonjonte/BLAKE3 `candidate/devon-release-0.8`), and which rows does it
need?

**Runs**, each `python3 tools/mutants/check.py` under run-bounded.py, at
the integration's head as it stood:
1. `check` (ee4c0d7, wakes-8): 24 new survivors, 2 rows caught, 1 time-out
   gone. Reasons written (e211fa0).
2. `check2` (e211fa0): the time-outs match; spare_lane's three comparisons
   at one place more than listed.
3. `check3` (e2c7095, FANOUT 8): 8 park.rs rows now caught by the fan-out
   tests; two new survivors, both test gaps (a pay_owed that misreports its
   wakes, and wake_for's early return), closed in 612e845 by a test that
   counts every wake and by simpler code.
4. `check4` (612e845): **"649 survive, each known and explained"** and
   **"37 time out, each known"**: the check passes.

**Posted:** BLAKE3 #119, #125.

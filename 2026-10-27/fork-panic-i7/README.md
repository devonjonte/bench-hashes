# A forked child's multithreaded calls panic, i7-12700K: gate, mutants, speed

**Commits:** devonjonte/BLAKE3 `candidate/devon-fork-panic` 2eaad1c2, on
`candidate/devon-prerelease-fixes` fb2cbdaa (BLAKE3 #190), on
johnservil/BLAKE3 e7c5ef48.

**Commands** (run-bounded.py, October 26-27):
- `run.sh`: every suite (128 library tests, `tests/forked_child.rs`
  included), check-builds, Shuttle, cargo doc -D warnings; then
  `check.py --since candidate/devon-prerelease-fixes`: no failure; **no new
  survivor** (8 mutants).
- The test's control, by hand: without the change, the child's
  `hash_multithreaded` returns, and the test fails (exit 3).
- `check.sh`: `bench-hashes check --against candidate/devon-prerelease-fixes
  --pairs 8`, the 152 cells that load the pool: **no cell slower**, both
  stages.

**Posted:** the BLAKE3 PR.

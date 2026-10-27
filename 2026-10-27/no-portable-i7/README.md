# 0.8 without the portable Rust, i7-12700K: suites, mutants, speed

**Question:** does BLAKE3 #195 (the portable Rust, `reference_impl/` and
Miri deleted, the tests on fixed values from official BLAKE3 1.8.7) keep
the tests' strength, and is any cell slower on a CPU without AVX-512?

**Commits:** old johnservil/BLAKE3 `candidate/release-0.8` 2907ea5d; new
devonjonte/BLAKE3 `candidate/devon-no-portable` ec8b55ed..a31dbf73 (#195).
Bench: devonjonte/bench-hashes `exp/bench-018-names` 4cac4c94, which is
#87's fixes (7f275a1f) merged with johnservil `candidate/names` 3f9edd13
(the fork's 0.8 names), nested in the fork's checkout.

**Commands** (all under run-bounded.py, one job at a time, October 27):
- `suites/suite.sh`: every suite (library with serde and zeroize, doc
  tests, no `std`, release, test_vectors, C API, b3sum), all pass;
  `suites/regen-check.stdout.txt`: `BLAKE3_GOLDEN=1`, all 22 fixed values
  agree with official BLAKE3.
- `mutants/`: `tools/mutants/check.py --since origin/candidate/release-0.8`
  at 356e4ead (the whole run, since test helpers changed): **exit 0**, 638
  survive, each known and explained, 32 time out, each known.
- `check/`: `bench-hashes check --against 2907ea5d --cells all` at ec8b55ed.
  It found no cell slower (4 pairs over every cell, then 16 fresh pairs
  for 8 suspects).
- `ab-24/` (`stage3.sh`): the second stage's points again, 24 pairs, A/B;
  `aa-24/`: the same points, old layouts against old layouts (A/A).
- `warm-counts/`: `small_probe.rs`, 2,000,000 warm calls a process on P
  core 2, old and new alternating, 7 processes each (`run.py`).
- `check-inline-never/` (`stage4.sh`): the check again with
  `#[inline(never)]` on `pair::hash_many_blocks`, then 24 pairs over
  batches of 1, 3 and 16 messages (`ab-24-inline-never/`).

**Verdict:** the tests keep their strength (the mutation check passes),
and with a31dbf73's `#[inline(never)]` no cell is slower.
- Read whole, the 16-pair second stage leaned slower on four cells. At 24
  pairs, the one-shot 128 B and 512 B cells read level (x1.005, x1.020),
  inside the A/A spread for those cells (x0.954 to x1.032).
- Batches of one and three 64 B messages, after other work, read
  x1.050 to x1.122 slower at 24 pairs, outside the A/A spread for those
  cells (x0.966 to x0.994).
- Warm, old and new run the same instructions (695 against 700 for one
  message) and the same cycles (within 0.1%) per call.
- The cause: with `Platform::hash_many`'s portable arm gone, the optimizer
  inlined `pair::hash_many_blocks` (its symbol is gone from the new
  build). Kept out of line, the same cells read x0.948 to x1.014, and the
  check over every cell finds none slower.

| batch of 64 B messages | inlined | `inline(never)` | A/A |
|---|---|---|---|
| mt, 1 message | x1.122 | x1.014 | x0.994 |
| mt, 3 messages | x1.097 | x0.948 | x0.991 |
| st, 1 message | x1.050 | x0.993 | x0.966 |
| st, 3 messages | x1.005 | x0.998 | x0.966 |

**Posted:** BLAKE3 #195.

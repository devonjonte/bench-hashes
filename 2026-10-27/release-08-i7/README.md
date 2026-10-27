# The i7-12700K's release runs for BLAKE3 servil 0.8

**Commits** (John's post on BLAKE3 #125, October 27, 17:36): library
johnservil/BLAKE3 `0.8.0+f7ce4e4e7bd41bd14e9e55d35279af4c6ad6d3ab` at
934dee8902889186e3da9b62edf43699dd1c6305 (`candidate/release-0.8`);
bench-hashes `0.18.0+85e695290346024702b6ffc662949748077249a2` at
67bae864751ae766f170be94ac38a9b3723fc181 (`candidate/bench-0.18`),
nested in the fork's checkout. Both checkouts clean.

**Commands** (run-bounded.py, one job at a time, nothing else running;
October 27, 18:03-20:09 UTC):
- `release.sh`: the x86 suites (`suites.*`); the release check, `check
  --against bfbda192 --old-bench 5be5f236 --cells all` (`release-check/`);
  the same-library check, `check --against 934dee89 --old-bench 3f9edd13
  --cells all` (`same-library/`); the full run; the b3sum run (four
  layouts each, `b3sum-contenders.txt`); the x86 mutation run
  (`mutants.*`).
- **The full run in `release.sh` measured the pin, not 934dee89**
  (`run1-full-measured-the-pin/`, kept as evidence). Its `--config 'patch
  ...path=".."'` went unused: bench 0.18 pins blake3-servil 0.3.0 (49b43b1d),
  and Cargo uses a patch only for a semver-compatible version, so it built
  the pin and wrote `[[patch.unused]]` to the lock without stopping. The
  checks and the b3sum run were unaffected (their binaries carry 0.8.0+f7ce).
- `results/`: the full run again, built by `bench-hashes build-against ..`
  (its report names blake3-servil 0.8.0+f7ce4e4e at 934dee89), from a
  scratch directory; the b3sum results beside it, and the map redrawn from
  both (`bench-hashes map`; map-check.js passes on 27 charts).
- `confirm.sh`: the release check again for its builds (`release-check-2/`),
  then 24 pairs of its suspect cells, A/B and both A/A controls
  (`confirm-ab/`, `confirm-aa-old/`, `confirm-aa-new/`).

- `full-0.18.1/`: **the full run for the release table** (October 27,
  22:30 UTC, quiet), with bench 0.18.1 (2c9633ae: #93 and #94 merged, so
  BLAKE3 official is measured in both its forms), built by `build-against
  ..`; the b3sum results beside it, and the map drawn by 0.18.1. It
  replaces `results/` for the CHANGELOG.

**Verdicts:**
- Suites: every one passes (library 130, no std 35, default features off
  128, release 127, doc tests, test vectors 3, C API 8, b3sum 29,
  check-builds). Mutation run: **639 survive, each known and explained;
  31 time out, each known.**
- Same-library check: **no cell slower**, in either stage, read whole
  too. So bench 0.18 adds no slower cell on the i7.
- Release check: `regress` judged no cell slower in either stage. Read
  whole, its second stage leaned three cells slower; at 24 pairs two hold:

| cell | A/B, 24 pairs | A/A old | A/A new |
|---|---|---|---|
| mt IdleOneMessage 3839 B, after a pause | **x1.084, slower** (6 of 24 faster) | x1.003 | x1.013 |
| st OneMessage 4 KiB, after other work | **x1.071, slower** (3 of 24 faster) | x0.961 | x0.954 |
| mt shared ContinuousMessages 256 KiB | x0.977, level | x1.003 | x1.007 |
| st IdleOneMessage 1536 B, after a pause | x1.046, level | x0.989 | x1.046 |

  Both are one message of 3-4 KiB, which stays on the caller's thread in
  either contender: the cold 3-4 KiB cost open on BLAKE3 #119 since the
  October 26 release step (`../../2026-10-26/release-e7c5-i7`), the
  library's, cause unlocated.

**Posted:** BLAKE3 #125.

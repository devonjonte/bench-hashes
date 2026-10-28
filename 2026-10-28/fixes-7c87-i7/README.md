# The x86 items for 0.8's fixes of #204 and #205, i7-12700K

**Commits:** johnservil/BLAKE3 `candidate/fixes-204-205` 7c87dd6f (on the
version commit 83d59db2); bench 0.18.2 fbfa9876 nested, old side 0.18.1
2c9633ae (the old fill API).

**Commands** (run-bounded.py, October 28, 13:44-14:50 UTC):
`suites.sh` (every suite, check-builds, rustfmt); John's check, `check
--against 83d59db2 --old-bench 2c9633ae --cells all` (`check/`); then
`confirm.sh` (24 pairs) and `confirm2.sh` (32 pairs, both A/A controls).

**Verdicts:**
- Suites: all pass (library 133, no std 35, release 131, C API 8,
  b3sum 29, doc tests, vectors, check-builds, rustfmt).
- Check: no cell slower in either stage. Read whole, the first stage leaned
  single-threaded one-message cells +5-15% (4 pairs; a path neither fix
  touches): at 24 pairs those after other work read x0.93-1.00, level.
  IdleOneMessage 512 B read x1.088 at 24 pairs (A/A x1.031); again at 32
  pairs x0.958, both A/A controls level. No cost found.

**Posted:** BLAKE3 #125.

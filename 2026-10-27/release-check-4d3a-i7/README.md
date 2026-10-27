# 0.8's release check on the i7-12700K, at #195 with John's Arm test fix

**Commits:** new johnservil/BLAKE3 `candidate/no-portable-arm` 4d3a9124
(#195 at 4fa4d555 plus John's test fix, test code only); old
`candidate/base-0.8` bfbda192 with bench 5be5f236 (`--old-bench`).
Bench: #87's fixes + johnservil `candidate/names` + Sam's #90 (each side
reads sizes of its own), local merge 7ceb4e45, nested in the fork.

**Commands** (run-bounded.py, October 27, 17:12-17:50 UTC): John's
release check from #125, `check --against candidate/base-0.8 --old-bench
5be5f236 --cells all` (`check/`). It stopped after the first stage (4
pairs) with 2 cells slower. `confirm.sh` then ran 24 pairs of those cells
on the check's own builds, A/B (`confirm-ab/`), with old-vs-old and
new-vs-new controls (`confirm-aa-old/`, `confirm-aa-new/`). Then Sam's
option (a) from #125 (`same-library/`, 17:46-17:55): `check --against
4d3a9124 --old-bench 3f9edd13 --cells all`, the same library on both
sides, the old side on bench 0.18 without #87 (johnservil
`candidate/names`). An earlier attempt stopped at a user interrupt; it
is not kept.

**Verdict:** one cell slower, the cost already open on BLAKE3 #119.
- mt ManyMessages 32 (after other work): +18.3% in the first stage, but
  x0.975 at 24 pairs, level (the controls x1.030, x0.969).
- st OneMessage 4 KiB (after other work): +15.4% in the first stage,
  **x1.054 at 24 pairs, slower (new faster in 5 of 24 pairs)**, and the
  controls x0.979 and x1.000.
- It is the library's: with the same library on both sides, the bench
  change reads that cell x0.963 (new faster in 4 of 4 pairs), and that
  check finds no cell slower in either stage.
- That is the cold 3-4 KiB one-thread cost the i7 found at e7c5ef48
  (`../../2026-10-26/release-e7c5-i7`: 3839 B +6.8% against bfbda19,
  level against 612e845), still unlocated.

**Posted:** BLAKE3 #125.

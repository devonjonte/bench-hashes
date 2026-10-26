# The i7's release runs at e7c5ef48 (0.8's frozen scope)

**Commits:** johnservil/BLAKE3 `candidate/release-0.8` e7c5ef48, bench
d21cdf36; old side bfbda19 with bench 5be5f236 (`--old-bench`).

**Commands** (`run.sh`, run-bounded.py, October 26, 14:11-15:16 UTC):
`check --against bfbda19 --old-bench 5be5f236 --cells all`, then
`tools/mutants/check.py`. `confirm/`: the slow cell and its neighbours on
the check's own relinked builds (20 pairs), with old-vs-old and
new-vs-new controls (10 pairs each).

**Verdicts:**
- Mutation run: **647 survive, each known and explained; 34 time out,
  each known.**
- Check: first stage no cell slower; second stage judged st solo
  IdleOneMessage 3839 B **+27.8%** (16 pairs).
- Confirmation (`confirm/`, read whole, as `compare` prints): at 20 pairs
  that cell is +6.8%. After a pause, 3 KiB to 4 KiB read +5.5% to +7.8%, while
  same code reads x0.90 to x1.09 there: within the controls' spread. After
  other work, 3839 B reads +6.8% (15 of 22 pairs), and the controls read
  x0.975 and x1.000.
- Warm per call (perf, P core 2): e7c5ef48 runs fewer instructions than
  bfbda19 at 3839 B (23,853 against 29,263), with level cycles (7,472
  against 7,544); 3 KiB and 4 KiB level. So any cost is in a cold call's
  code, not in the work.

**Reading:** not the +28% the second stage read; a possible +7% at 3-4 KiB
on one thread, cold, its cause unlocated. Next: `../check-612-e7c5`,
e7c5ef48 against 612e845 (which read level against bfbda19 on October 25).

**Posted:** BLAKE3 #125.

# bench-hashes 0.18's fixes together, i7-12700K

**Question:** do bench #84 (128 B and 512 B streams and lent calls; the
map's CPU and energy lines), #85 (check measures deletions) and #86 (a
batch of 4 KiB messages) work together, on John's release bench line?

**Commit:** devonjonte/bench-hashes `candidate/devon-bench-018-fixes`
7f275a1f (#86, which carries #84, merged with #85, on johnservil
`candidate/clocks-linux-only` 400ecbd0).

**Checks,** October 26, about 19:50-20:40 UTC:
- `cargo fmt --check`; 48 tests pass.
- `bench-hashes --all --quick`, a complete run: every new cell measured
  (ManyLongMessages 24 cells; the 128 B and 512 B points 24); the map's
  check (`tools/graph-check/map.js`) passes, 17 charts.
- End to end, with this bench in the release fork (johnservil/BLAKE3
  8c34ead): a mutant deleting `Task::run_members`' 128 B arm. check
  selects exactly `continuous 128 B` and judges it **slower, +6.9%**
  (`run7.stdout.txt`; yesterday +7.7%).

**Posted:** the combined bench PR.

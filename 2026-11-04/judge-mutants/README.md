# Mutation tests over the judge (i7-12700K, November 4, 2026)

Question (Zooko's plan, item 3): which judging rules do the tests pin?
`cargo mutants --test-tool nextest` over `clocks/src/summary.rs` (the verdict
rule: t-test, Benjamini-Hochberg, ranking) and the bench's judging functions
in `src/main.rs` (cell_means, instructions_moved, judge_once, the idle
control, the effective-states line, the sizes context, cell_wants_sample).

- round1/: bench 48821904. summary.rs 261 mutants: 5 missed, 255 "caught",
  of which 9 were caught by a load-sensitive test failing beside (the
  rdpmc agreement test under 3 parallel mutants). main.rs 127 mutants: 14
  missed.
- summary/, judge/: bench ffacdf73 with the agreement test fixed and the
  main.rs tests added: summary.rs 9 missed (the 9 false catches, now
  honest), main.rs 114 caught, 9 unviable.
- summary2/: bench 00dcb255, the judge's functions in summary.rs alone:
  208 mutants, 207 caught, 1 unviable.

Verdict: every mutant of the judge's functions is caught; 19 survivors
became 14 tests and 4 deletions of inert code (commit 00dcb255).

# l3-flush-i7

The i7's after-5 ms cost sample by sample with the v10 cache counts (bench
48821904): deep samples miss about 180 lines a 64 B call, shallow ones 0-2,
at the same clock. Posted on bench-hashes #117.

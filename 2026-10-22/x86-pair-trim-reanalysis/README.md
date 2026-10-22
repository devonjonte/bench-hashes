# Two-input AVX2 records under the declared trim: reanalysis plan

## Question and scope

How do the five published pair-repair comparisons change when their raw
samples pass through the declared `ceil(n/100)` selection, instead of the
original Mean wrapper's plain mean?

This is an exploratory reanalysis of existing observations, with its plan
committed before running the comparisons. It supplies neither new hardware
measurements nor fresh reliability acceptance. The proposed benchmark
repair still awaits the frozen-benchmark decision and a new release.
Original samples and original verdicts remain unchanged.

## Inputs and tool

Use all 144 samples in [the pair-repair record](../x86-pair-repair/), as
published at data `534084f4`; their later data history preserves the same
files. Keep the original pair assignment, sorted by each side's run number.
Use all 28 cells together, the paired log-ratio test, 5% FDR and 3% margin.
Keep wall time unscaled and existing load qualifications. Calling-thread
cycle evidence stays in the original raw records; no speed-state
reassignment or new cycle verdict is part of this statistic-only question.

| Directory | Question | Pairs |
| --- | --- | --- |
| pair-critical-runs | version 1 vs pre-rewrite baseline | 8 |
| pair-v2-critical-runs | version 2 vs baseline | 16 |
| pair-v3-critical-runs | version 3 vs baseline | 16 |
| pair-v3-aa-runs | version 3 vs itself | 16 |
| pair-v3-parent-runs | version 3 vs generated parent | 16 |

The comparator is the release-mode CLI built from benchmark
`3926a57d0c5fe3190be734ab6ad54a00b5b3db40`, with git-pinned clocks
`99d34d94db14eac01a9c652e0a4858055502b08f`. Its executable's SHA-256 is
`f5e7098d00276d37dafd7b410000574079ccdfcb1b3882db1524b88b0c0d1f73`.
The code is on [the mean-repair branch](https://github.com/devonjonte/bench-hashes/tree/candidate/devon-mean-trim)
and [consumer PR](https://github.com/johnservil/bench-hashes/pull/60).
The later docs-only commit leaves this comparator's code unchanged.

Run the existing Rust CLI for each directory, with a 90-second complete
process-group deadline:

```sh
bench-hashes compare OLD_FILES_IN_RUN_ORDER... -- NEW_FILES_IN_RUN_ORDER...
```

The shell/Python launcher only enumerates filenames and retains output.
Rust owns sample parsing, selection, load qualification and judgments.

## Outputs to retain and interpretation

Keep every comparison's stdout, stderr and exit, including failures. Report
all new slower/faster counts and the version-3 target cells, its remaining
7935-byte parent cost, and its same-code control. Keep original and revised
ratios explicitly distinguished. Every pair and cell stays in the question.

A level verdict continues to mean insufficient evidence beyond the margin.
The archived same-code control is a post-hoc diagnostic for the new rule.
Fresh predeclared controls on the repaired executable remain required for
reliance; this reanalysis carries no GO decision.

# Two-input AVX2 records under the declared trim

## Question and scope

How do the five published pair-repair comparisons change when their raw
samples pass through the declared `ceil(n/100)` selection, instead of the
original Mean wrapper's plain mean?

**Version 3 remains a partial repair.** It improves the eight target cells
about 30–35% against the generated parent. Against the pre-rewrite baseline,
the corrected rule detects four slower cells. Its same-code control stays
level everywhere.

This exploratory reanalysis uses existing observations. Its [plan](https://github.com/devonjonte/bench-hashes/blob/1b5bfb1672f70c8ff1ca63565cad0787b7624193/2026-10-22/x86-pair-trim-reanalysis/README.md)
was committed before running the comparisons. Fresh hardware measurements
and reliability acceptance retain their own scope. The proposed benchmark
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

## Results

All five comparisons completed with exit status **0**. Their stdout and
stderr are retained here. Every pair and all 28 cells stay in each question.

| Comparison | Plain mean: slower / faster | Declared trim: slower / faster |
| --- | --- | --- |
| version 1 vs baseline | 1 / 0 | 2 / 2 |
| version 2 vs baseline | 9 / 1 | 13 / 3 |
| version 3 vs baseline | 0 / 0 | **4 / 2** |
| version 3 vs itself | 0 / 0 | **0 / 0** |
| version 3 vs generated parent | 1 / 8 | **3 / 8** |

Version 3's four detected baseline costs, all after other work:

| Cell | Ratio | Cost |
| --- | --- | --- |
| single-threaded 2047 B | 1.053 | +5.3% |
| single-threaded 2304 B | 1.051 | +5.1% |
| single-threaded 3839 B | 1.037 | +3.7% |
| multithreaded 3839 B | 1.055 | +5.5% |

The two faster baseline cells are 7935 B after work, single-threaded x0.931
and multithreaded x0.934. Across the eight 1536/2047-byte cells, baseline
ratios are x1.021–x1.086; the single-threaded 2047-byte finding above is the
one detected slower. After a pause, single-threaded 4470 B remains level at
x1.095. Level continues to mean insufficient evidence beyond the margin.

Against the generated parent, all eight target cells remain faster
(x0.651–x0.696). Three cells after a pause are slower: single-threaded
4470 B x1.062 and 7935 B x1.056, multithreaded 2304 B x1.071.

The archived same-code control stays level in every cell. This is a
post-hoc diagnostic for the new rule. Fresh predeclared controls on the
repaired executable remain required for reliance. This reanalysis carries
no GO decision or broad no-regression claim.

Posted at [the generated-assembly discussion](https://github.com/johnservil/BLAKE3/issues/90#issuecomment-6340692380).

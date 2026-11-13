# Apple M6 b3sum publication follow-up, November 13, 2026

**Question:** can a fresh full b3sum run fill the missing Apple M6 cells in
bench-hashes 0.21.0+84236bf0f0c832f6619b8f99ce7bc878c7800ef0?

**Finding:** job 3095 completed all 15 rounds on mains power with low-power
mode off at both ends. Shared clocks still classified the run as **busy**:
other programs averaged 0.26 CPUs, reached 1.37 CPUs in the busiest window,
and exceeded the load limit in 1 of 486 windows (452.1–453.1 s).
The job's successful exit establishes completion. A quiet-machine speed
comparison remains unavailable.

This folder publishes the complete numeric evidence and its source-matched
views, with that qualification. [The publication follow-up](publication/README.md)
now includes this qualified snapshot on the release map and overview, with each
run's load warning visible. [Tracker](https://github.com/servil-software-factory/bench-hashes/issues/201).
Further repetitions solely to obtain a quiet flag have little value. The
workstation's background load remains part of this record. The initial derived
views below and original evidence stay preserved alongside the publication.

## Evidence and reproduction

- Bench: [`9434d50e50de4b93dc962ccbf52346db5442358e`](https://github.com/servil-software-factory/bench-hashes/commit/9434d50e50de4b93dc962ccbf52346db5442358e), clean.
- Library: [`2037118ca1da85710aef55d7f13b3abd9095b485`](https://github.com/servil-software-factory/BLAKE3/commit/2037118ca1da85710aef55d7f13b3abd9095b485), clean.
- [Submitted job](job-3095/job.json), [completion/power record](job-3095/verdict.json),
  [runner log](job-3095/runner.log), [report](job-3095/benchmark-results/AppleM6.darwin27/b3sum.result.txt),
  [samples and load windows](job-3095/benchmark-results/AppleM6.darwin27/b3sum.samples.tsv).
- [Source-matched map](job-3095/benchmark-results/AppleM6.darwin27/bench-hashes.map.html)
  and [overview](job-3095/index.html). These are a busy snapshot. Their arithmetic
  summaries describe this run; their ratios carry the same load qualification.
- [Original release evidence](../../2026-11-12/release-021-apple-m6): job 3077
  remains preserved (15/490 busy windows). The published library run, job 3076,
  has its separate 1/362-window qualification.

The runner built the benchmark with `build-against` on those exact commits,
then ran `bench-hashes b3sum --files FILES` with official BLAKE3, BLAKE3-Servil,
each's one-thread form, and the OS's SHA-256/SHA-1/MD5 commands. `runner.log`
records the complete command. Every cold run read from storage by the counts.
Per-core-kind child cycle counts are present; this record makes no energy claim.

The public copies replace the runner's home-directory prefix with
`<runner-home>`. Every measured row, count, load window, command argument and
source pin is otherwise unchanged. Original exchange files remain locally
preserved. The two manifests cover the public copies; binaries stay off this branch.

Read and regenerate these historical samples with bench `9434d50e` and library
`2037118c`. Current readers have a different contract. The renderer's provenance
was checked as `bench 9434d50e50de clean; servil 2037118ca1da clean`:

```sh
BENCH map job-3095/benchmark-results/AppleM6.darwin27
BENCH overview job-3095/index.html job-3095/benchmark-results
```

— Devon Jonte

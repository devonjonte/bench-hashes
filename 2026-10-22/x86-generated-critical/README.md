# Generated x86 partial kernels: critical input sizes

Does John's generated SSE4.1/AVX2 partial-chunk pass preserve speed inside
1089–2047 B, and does the earlier 4470 B slowdown repeat with fresh layouts?

**Regression found: ten of 28 cells are slower.** Eight cells at 1536 B
and 2047 B are 45–65% slower. Every accepted pair is slower in all eight.
The 7935 B calls after other work improve. The release candidate needs a
repair before this comparison can pass.

## Code and command

- Base BLAKE3: `c40892d2b426bf3c169fbe7bac3ab8ed0bcfd36b`.
- Generated BLAKE3: `7e508243248ea42eac7e9511f3f851e4062ad271`.
- Check snapshot: `f281f3abfb94cf402430e4edd396afa8f9e3e207`.
  Its tree and the generated commit's tree are both
  `5980acb9090690e16f8a8fe4ed8ea3dfb31be28a`.
- Research benchmark:
  [`b1cbfcf5d05fed87d19dc849d6ff32ebb4346b12`](https://github.com/devonjonte/bench-hashes/commit/b1cbfcf5d05fed87d19dc849d6ff32ebb4346b12),
  based on John’s `d90f2b49`. This separate branch adds 1536 B and 2047 B,
  and restricts `check --cells all` to seven sizes on servil st/mt, after
  other work and after a pause. Its FROZEN.md declares the probe's scope.
  All 30 benchmark tests pass. The published benchmark stays unchanged.
- Intel i7-12700K, Linux 7.0.0-38-generic, Rust 1.98.1, GCC 15.2.0.
  The machine uses AVX2. All proof and SDE jobs had finished before timing.

From the research benchmark checkout inside the generated BLAKE3 checkout:

```sh
cargo run --release -- check \
  --against c40892d2b426bf3c169fbe7bac3ab8ed0bcfd36b \
  --cells all --pairs 8 --keep /path/to/runs
```

The run used an 850-second process-group deadline. The normal check builds
and relinks eight layouts per side, calibrates sample sizes, alternates
pair order, supervises load, and judges all 28 cells together.
`generated-critical-check.*.txt` retain the output and build/run log.

## Results

| size | st after work | st after pause | mt after work | mt after pause |
|---|---:|---:|---:|---:|
| 1536 B | +45.4% slower | +64.5% slower | +52.5% slower | +60.1% slower |
| 2047 B | +50.0% slower | +55.6% slower | +47.9% slower | +58.3% slower |
| 2304 B | +1.2%, level | +12.1% slower | −1.6%, level | +4.2%, level |
| 3839 B | +1.9%, level | +0.8%, level | +1.5%, level | +7.9% slower |
| 4470 B | +1.4%, level | +10.6%, level | −1.6%, level | +11.8%, level |
| 7935 B | −15.2% faster | +3.9%, level | −10.1% faster | +3.4%, level |

The 1 KiB controls receive level verdicts. Here “level” means the comparison
rule found no change beyond its margin. In particular, the 4470 B calls
after a pause still have raw ratios above 10%; their speed remains worth
investigating. The result supplies no equivalence claim.

## Samples, load and provenance

`runs/` preserves all twenty attempt files and the shared `sizes.tsv`.
Pairs 4 and 7 each repeated after a busy window. The accepted old file
numbers are **1, 4, 5, 10, 11, 14, 17, 20**; their corresponding new numbers
are **2, 3, 6, 9, 12, 13, 18, 19**. `compare.txt` is the Rust reader's
comparison of those eight accepted pairs.

The samples retain wall times and calling-thread P/E counts. After-gap
cells record no process CPU-time or energy measurements. Counts are
available here; these results report the prescribed wall-time comparison.

An audit found a provenance defect in `check::layouts`: the relinking
command drops `BENCH_HASHES_CHECKOUT`, so the build script discovers the
containing BLAKE3 worktree. Consequently the samples' **benchmark** source
and git fields name BLAKE3. The BLAKE3 contender source fields identify the
correct old/new commits. The benchmark source is the research commit
above. Preserve these original headers; the defect requires a producer fix.

The original exploratory run remains at `2026-10-21/x86-generated-check`.
It used one layout per side and measured 2048 B, outside the critical
range. This run supplies the missing fresh-layout measurements.

Posted on [BLAKE3: generated x86 kernels](https://github.com/johnservil/BLAKE3/issues/90#issuecomment-6332239654).

# Benchmark harness audit — October 1, 2026

Devon Jonte reviewed bench-hashes `80cd052` on an Intel i7-12700K,
x86_64 Linux, with Rust 1.98.1. This is a maintainer's record of confirmed
harness defects and remaining measurement concerns. The fixes preserve
`FROZEN.md`'s entry points, input axes, and call patterns.

The code-only review branch is submitted as
[draft upstream PR #2](https://github.com/johnservil/bench-hashes/pull/2),
targeting `candidate/benchmark-plan`. Results remain on the published
audit branch, separate from the code-only PR.

## Confirmed defects addressed here

1. **Allocation in warmed queue-batch samples.** Pairing the input and
   output buffers with `collect`, then unzipping them, allocated three
   descriptor vectors on every call. A thread-local paired-buffer cache
   keeps those allocations outside subsequent intervals. The regression
   test observes three allocations before the fix and zero afterward.
2. **Repeated output initialization.** A smaller batch truncated the kept
   digest vector. Returning to a large batch zeroed its tail inside timed
   synchronous producer paths. The cache retains its initialized length;
   each API and consumer receives only the current batch's prefix.
3. **Stale graphs and guides.** A sparse run replaced the samples and
   report while leaving an earlier run's SVG and HTML. Such a run now
   removes both older visualizations.
4. **False guide summary.** Winning at intermediate sizes and losing at
   the final size produced "slower at every size". The guide now reports
   the crossover; equal displayed medians are also distinguished from
   strictly slower results.
5. **Guide rounding.** The guide rounded an already approximated Q64.64
   median, while the report retained the measured rational midpoint.
   Both now use the exact displayed median. The rational anchor
   `2135/400` displays as `5.338` in both.
6. **Incomplete report validation.** Removing the entire shared section
   still passed the checker. Validation now requires every sampled cell
   exactly once. A standalone checkout can locate the pinned fork's
   shared rules with `--rules`; it uses the same samples reader.
7. **Shared load timestamps.** Each shared copy now records its own start
   before its timed interval. Previously both copied the solo start,
   which could precede them by a long hash and cross load windows. The TSV
   format stays v4; regression anchors give solo and both shared copies
   distinct starts crossing window boundaries.
8. **Guide API fidelity and test coverage.** Multithreaded incremental
   calls after a gap use `update`, while nonstop calls use
   `update_multithreaded`. Pattern toggles now stay with the actual call.
   Queue pieces show their own measurements without the hash-proxy label.
   Downward-triangle marks match the Rust payload. A single-point tie is
   labelled matched. Browser tests drive the available chips on both
   quick and full runs, including the one-point pieces axis.
9. **Order aliasing and absent participants.** All contenders at a point
   now sample the same visits. Default sample counts round twelve up to
   complete Williams cycles; long hashes participate in every visit.
   Designs include only contenders taking part in that use case, rather
   than filtering a larger design afterward. Exhaustive deterministic
   tests cover every roster prefix, use case, quick/full round count and
   point offset, checking realized positions and predecessor counts.
   This removes the long-cell budget and accepts longer runs in exchange
   for a balanced design; frozen calls and workloads are unchanged.

Regression tests cover these changes. A differential test also checks the
official crate's hidden batch wrapper against separate plain `hash`
calls, including SIMD groups and remainders. This tests the benchmark's
flags, input slicing, output order, and observation of all digests.

## Reviewed upstream dependency fix

The lock now pins the fork at `7270b21`, matching upstream bench-hashes'
`755cad7`. This follows source review and an independent failed-before /
passed-after reproduction: the upstream burst test hangs on `802b6a5`
(before the queue fix), and completes after it. The workers now consider
queued tasks even before the delivery thread's pool hold is registered.
The preceding `802b6a5` also restores the ordinary serial hashing path
when all available CPUs already have callers.

On this x86 machine, the fixed source passed 77 library tests, 15 planned
API tests and its allocation-free queue test, in default and `no_sme2`
builds. One-shot vector tests also passed with affinity restricted to one
CPU. The source tested was `3d02b04`, whose library code matches
`7270b21`; its additional regression test exercises bursts after pauses.

**Remaining single-CPU queue issue:** with the same fixed test executable,
`bursts_of_large_batches_after_pauses_complete` passes with normal
affinity and hangs with `taskset -c 0`. The handler-resubmission test also
hangs with that restriction. This is an additional execution-capacity
case, rather than evidence that the multi-CPU lost-wakeup fix should be
reverted. [The reproducible report](audit/single-cpu-queue.md) documents
it. GitHub reports upstream issues disabled; an authenticated issue
submission returned HTTP 410, so no upstream issue was created.

Additional bounded baseline checks at `3d02b04`: the `pure` library/API/
allocation suites pass (77 / 15 / 1 tests), 22 doctests pass, and both
published-vector tests pass. Plain `cargo test --release --features pure`
fails while compiling the existing `examples/host_lab.rs`, which imports
private `lanes::probe`; targeted `--lib --tests` and `--doc` checks avoid
that example. This is a build/test-entry-point defect to review separately;
the contender source remains unchanged.

Upstream records an unresolved Mac cold-cell slowdown on these commits.
This audit provides x86 correctness evidence; it makes no Mac performance
or regression-free claim.

## Measurement concerns still open

- **Correlated shared samples:** the two simultaneous copies can be
  correlated, while the bootstrap resamples individual observations.
  Duplicating six synthetic observations narrows the interval without
  adding independent rounds. A clustered-bootstrap design belongs in the
  shared clocks rules, with its two-speed handling reviewed together.
- **Consistency-check interpretation:** per-byte speed need not be
  monotonic across hash block, SIMD, tree or thread-wake boundaries.
  Shared core-only work can compete for SMT and memory bandwidth.
  Findings from those checks need explanation rather than automatic
  attribution to a contender bug.
- **Kernel labels:** queue and incremental multithreaded APIs inherit
  one-shot labels that may omit their actual helper-thread behavior.
- **Provenance cache:** incidental untracked-file changes can leave a
  previously embedded dirty fingerprint cached until the build script
  runs again.

## Build artifact behind the initial SHA-256 anomaly

Controlled builds of the same `80cd052` source and pinned contenders gave
these solo lent-buffer SHA-256 times:

| Build | 64 B (ns/B) | 1 MiB (ns/B) |
| --- | ---: | ---: |
| Generic target | 0.964 | 0.454 |
| `target-cpu=native` | 100.539 | 48.919 |
| Native, AVX and AVX2 disabled | 0.912 | 0.448 |

Ring remained near 1.1 and 0.45 ns/B. Native incremental SHA-256 was also
fast. Disassembly contains VEX instructions interleaved with legacy
SHA-NI, consistent with an AVX/SSE transition problem. The precise
compiler/inlining cause remains open. These observations support
retaining upstream's generic build, and treating the original native
SHA-256 measurements as executable-specific evidence rather than typical
SHA-256 performance.

## Validation scope

Final clean-source `ba4a327` runs, under external process-group deadlines:

- Quick: 56.6 s, quiet (0.13 CPUs average / 0.16 maximum window), all
  720 cells verified, SVG checks and all 48 guide routes pass.
- Full, eight contenders: 278.7 s, quiet (0.13 / 0.21 CPUs), all
  1,296 cells verified, SVG checks and all 48 guide routes pass.
- 23 Rust tests, 4 Python checker tests, synthetic browser summary tests
  pass; all nine guide examples compile. Fresh desktop SVG and guide
  renders were inspected. No Mac tests were performed.

The [published full record](benchmark-results/12thGenIntelRCoreTMi712700K.linux70034generic.devon-audit/README.md)
contains the five original artifacts, reproducible commands, validation
scope, and remaining limitations. It is a diagnostic baseline rather
than an optimization comparison. Source code in John's BLAKE3 checkout
remains unchanged; the benchmark assurance gate is still open.

The clean `391ab30` quick run completed in 55.6 s on a quiet machine:
all 720 report cells match the raw samples, and SVG interaction checks
pass. It exposed the browser test's assumption that every pattern had
measurements even in quick runs; the corrected test passes with both
quick and full historical payloads in the revised template (48 decision
routes and 21 endings each). Rust tests and all nine examples compile.

For optimization A/Bs, use an explicit `--rounds` count that is a multiple
of each measured use case's participating Williams order count. This
samples every selected cell in every round. Defaults now complete each
use case's design as well. The earlier `53297ff` full eight-contender,
24-round run predates the per-use-case design fix; its report, SVG and
all 48 guide routes pass, but it remains diagnostic historical evidence.
It completed in 419.5 s, quiet (0.12 CPUs average, 0.19 maximum window),
and all 1,296 cells agree with the samples. Shared
confidence intervals remain descriptive pending a clustered-bootstrap
review. Compare speeds and shares through the shared rules; require
quiet runs and same-build repeats before judging a gain. The guide's
summary explicitly describes faster-speed medians, rather than a
statistically significant or repeatable winner.

These checks establish bounded evidence for the stated workloads. The
open concerns above prevent a claim that the tool is free of bugs or
accurate for every caller's workload.

Linux cycle counts are unavailable through the pinned clocks crate.
Wall measurements and their uncertainty remain as measured; cycle trace
zeros are placeholders, and this audit makes no clock-state classification.

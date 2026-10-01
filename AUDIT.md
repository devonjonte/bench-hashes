# Benchmark harness audit — October 1, 2026

Devon Jonte reviewed bench-hashes `80cd052` on an Intel i7-12700K,
x86_64 Linux, with Rust 1.98.1. This is a maintainer's record of confirmed
harness defects and remaining measurement concerns. The fixes preserve
`FROZEN.md`'s entry points, input axes, and call patterns.

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
reverted. An upstream issue should document it.

Upstream records an unresolved Mac cold-cell slowdown on these commits.
This audit provides x86 correctness evidence; it makes no Mac performance
or regression-free claim.

## Measurement concerns still open

- **Order aliasing:** when short cells take every visit and long cells
  take every second visit, the latter see only two of four Williams
  positions in the default design. A diagnostic test records that
  imbalance; the scheduling policy remains unchanged.
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
- **Load attribution:** shared samples currently inherit their solo
  interval's start timestamp. Long solo calls can cross a load-window
  boundary before the shared calls start.
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

Linux cycle counts are unavailable through the pinned clocks crate.
Wall measurements and their uncertainty remain as measured; cycle trace
zeros are placeholders, and this audit makes no clock-state classification.

# Produced leaves through the shared sampler

## Question and result

Can produced leaves reuse `clocks::measure` while retaining whole-job wall
time, solo process CPU cost and the existing samples format?

**Functional checks pass: 33 clocks tests (2 probes skipped) and 33 benchmark
tests.** Hash calls, producer bytes, digest/checksum work, 5 ms sizing and
three samples per cell per round stay unchanged. The shared calibration
also guarantees at least one completed call for tiny budgets.

[Process CPU batches](https://github.com/johnservil/BLAKE3/pull/132), source
`8f7ee7eb1be7731de4c427d63bb4aa84d19ba5b6`, adds `Batch.cpu_ns`. After-gap
batches leave it absent. This branch includes the shared exact-mean helper.

[Leaf sampler consumer](https://github.com/johnservil/bench-hashes/pull/61),
source `20557b2ec970b170505176b58a53ce8997474558`, uses Batch directly and
removes its private sample tuple and sizing/wall/CPU loop. Solo rows retain
whole-process CPU time; shared rows suppress it. Available caller counts
use the existing v6 field. Energy stays absent.

The leaf report also had its own plain mean. It now uses the shared Mean
selection; CPU cost stays all raw CPU time over all raw work, as compare
does. Fixed fixtures independently anchor 4 messages per recorded batch,
1000 ns/message retained wall mean, 1500 ns/message raw CPU mean, core
fields, and shared/unavailable CPU absence. The existing digest test covers
all four variants at 1, 7, 1000 and 65536 leaves.

These are separately proposed instrument changes. They stay outside the
0.17.0 validation snapshot. The small-budget trim limitation remains open;
this record supplies neither a speed verdict nor a reliance promotion.

## Reproduce

From each named checkout, respectively:

```sh
cargo nextest run --release --manifest-path clocks/Cargo.toml
cargo nextest run --release
```

Original test logs accompany this page. The benchmark uses the exact git
clocks pin with no local Cargo patch. Its source FROZEN records Zooko's
October 22 authorization to proceed with consolidation.

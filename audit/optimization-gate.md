# Workload-specific optimization gate

Devon Jonte, October 1, 2026. This gate covers the audited benchmark at
`ba4a327` plus the API-label correction on this branch, on the Intel
i7-12700K/Linux host. It permits controlled optimization experiments;
performance claims require the additional repeat controls below.

## Workloads admitted

Solo one-message, lent-message, lent-batch, owned-message/owned-batch
queue and 64 MiB incremental-piece comparisons preserve FROZEN's API,
producer and digest-observation paths. Source review of `hash_batch`,
`hash_in_memory`, `hash_stream`, `hash_lent`, `queue_messages`,
`queue_batches` and their retained storage confirms that each iteration's
result reaches the consumer, including the final drain of queued work.
The benchmark intentionally measures producer copies and return channels
where the frozen workload asks for them. Calibration initializes storage;
warmed allocation regression tests cover batch descriptors and output tails.
Correctness of the contender's cryptographic outputs belongs to its tests.

Realized Williams schedules pass exhaustive participant/point/round tests.
Clean quick and full runs finish under external deadlines on a quiet host;
all 720/1,296 report cells match the shared samples reader and speed rules.
SVG and 48 guide routes pass. Commands and artifacts are linked from
[AUDIT.md](../AUDIT.md). These checks are sufficient to begin investigating
these stated workloads, with the limits below retained.

## Required comparison evidence

- Same instrument and generic compiler flags on both sides; record fork,
  benchmark and clocks sources separately. Rebuild cached provenance.
- Alternate old/new/new/old, preserve raw samples, load windows and traces,
  and compare old/old and new/new beside old/new through shared speed rules.
- Judge speeds and their shares separately. A gain smaller than same-build
  variability stays unresolved; confirm promising changes in another block.
- Every run uses external process-group supervision. A busy run supplies
  diagnostics only, with its speed verdict withheld.
- Test changed cryptographic paths against published vectors and the
  independent reference across modes, boundaries, alignments and concurrency.

## Limitations kept visible

Shared samples occur in paired simultaneous rounds. Current independent-copy
bootstrap intervals may overstate precision: exclude those bands from
inferential verdicts. Shared results remain descriptive speed/share and
regression diagnostics. Consistency checks are hypotheses about performance,
not mathematical hashing invariants or proofs of contender defects.

The queue and incremental MT APIs lack kernel-report entry points. Their
labels now name the measured API with kernel schedule explicitly unreported.
The historical full artifacts retain their original labels. The build-script
cache can miss incidental untracked-file changes; clean and rebuild the
benchmark package before recording publication provenance.

Small after-gap calls include instruction-cache and machine-state effects;
this controlled gap is a stated workload, with typical-user generality open.
Linux clocks here provide no thread cycle counts: trace zeros are placeholders.
No frequency classification, energy efficiency, Mac, ARM64/SME2 validation,
universal accuracy or regression-free claim follows from this gate.

Multi-block batches at lengths outside the frozen 64-byte axis require a
separate clocks-based probe; their gains must be reported as that workload.

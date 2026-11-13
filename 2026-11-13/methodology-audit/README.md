# Measurement audit: workload context, NUMA policy, and omitted callers

November 13, 2026. Question: can bench-hashes guide library changes toward
measurements that improve while users' costs stay the same or worsen?

## Verdict and next move

The audit found consequential **context sensitivity** and a **missing short
incremental workload**. It supports further controlled work; it leaves the
production measurement rule unchanged.

- **NUMA policy changes the two-socket measurements.** An explicit memory
  policy nearly stopped the system-wide NUMA sampling-fault counters during
  these jobs and reduced recurring slow episodes. Restricting CPUs alone
  left those episodes visible. The policy also changes memory placement;
  this experiment establishes an effect of the policy, with automatic
  balancing strongly implicated, rather than isolating every mechanism.
- **A selected-cell rerun asks a different question from a full run.** Even
  with the explicit policy, absolute cell costs differ between those two
  contexts. A level selected-cell result cannot erase a full-run slowdown.
- **Unchanged reference contenders move across benchmark versions.** Their
  source identity alone does not isolate a library change from harness,
  compiler, layout, and surrounding-workload effects.
- **Short incremental lifetimes deserve coverage.** A small exploratory
  probe exposed a large cost hidden by the existing long-message workloads.
  Its results motivate a proper cell; they are preliminary measurements.

Next: Devon will test a remedy under a fixed workload context, with unchanged
code and a known slowdown. Both contexts and the default memory policy remain
part of the evidence. A policy that removes a useful real-world cost from the
benchmark would need an explicit scope decision.

## E2: memory policy and CPU confinement

`x86-avx2/numa-ab` is the EPYC 7443 pair;
`x86-icelake-2/numa-ab` is the Xeon 6330 pair. Each delivered `run.sh` gives the
exact commands. Four arms ran in this order: normal; explicit policy and
node-0 CPUs; explicit policy; node-0 CPUs. A full-cell check followed with
both policy and CPU confinement. The policy is per process, `MPOL_BIND` to
all allowed memory nodes, inherited by its children. No system-wide NUMA
setting changed. All four arms successfully set the requested policy where
applicable.

The ordinary named-cell arms used four first-stage pairs. Existing `check`
selected extra cells for its second stage where indicated in the logs; those
64 pairs belong to that stage alone. All kept sample files report quiet
load. Cycle and instruction counts were unavailable.

System-wide `numa_hint_faults` increases, taken from each job's stdout:

| machine | normal | policy + node 0 | policy | node 0 |
|---|---:|---:|---:|---:|
| EPYC 7443 pair | 7,298,397 | 8 | 2 | 3,320,379 |
| Xeon 6330 pair | 10,463,864 | 0 | 2 | 1,413,410 |

These intervals include builds and different numbers of second-stage runs.
They establish suppression, rather than comparable per-second fault rates
or counts of faults inside hashing calls. The arms ran sequentially, rather
than in a counterbalanced policy experiment.

A turn across 256 messages after other work, first-stage geometric means of
run means in **ns/byte**, as printed by the Rust reader:

| machine / context | old | new | new/old | verdict |
|---|---:|---:|---:|---|
| EPYC normal, named cells | 0.804 | 0.793 | 0.986 | level |
| EPYC policy, named cells | 0.691 | 0.680 | 0.984 | level |
| EPYC policy + node 0, named cells | 0.688 | 0.671 | 0.974 | level |
| EPYC node 0, named cells | 0.831 | 0.804 | 0.967 | level |
| EPYC policy + node 0, full cells | 0.493 | 0.474 | 0.961 | level |
| Xeon normal, named cells | 1.019 | 0.994 | 0.975 | level |
| Xeon policy, named cells | 0.908 | 0.899 | 0.990 | level |
| Xeon policy + node 0, named cells | 0.873 | 0.874 | 1.001 | level |
| Xeon node 0, named cells | 0.989 | 0.972 | 0.984 | level |
| Xeon policy + node 0, full cells | 0.744 | 0.728 | 0.978 | level |

Each row compares library versions within its context. The sequential rows
are descriptive evidence of context sensitivity, rather than independently
randomized policy comparisons. In particular, four-pair level verdicts give
limited evidence about small effects.

Other slower readings remain: the full check's second stage found four on
the EPYC and three on the Xeon. See `all-policy-node0.stdout.txt` and
`kept-all-policy-node0/second/replayed-compare.md`. Suppressing the episodes
did not make every result level.

## E1: reference contenders across benchmarks

`x86-epyc-{9255,9275f}/xbench-ref` compares old bench
`3363bee8ff5ee757cd23bd24b61db5790edcba94` / library
`b5b988d8982bea9490c38c79ec4b8c5c2428270c` against the probe bench
`e310174178ac6b5721c6c4b597af12e88c8fb427` / library
`bf2da8b957f5e0c80babb57952de3e53f95c921a`. The probe adds official BLAKE3
and ring to `check`'s eligible contenders. It is experimental code.

Each host ran 24 initial pairs. The EPYC 9275F's second stage ran 64 pairs
on its selected cells. In that stage Servil's cold 4, 16, and 32 KiB calls
read 3.1–3.3% slower. Initial reference cold readings were mostly much
smaller. This is consistent with a library contribution, but the references
exercise different code: they cannot subtract Servil-specific harness or
compiler effects.

For warm 64-byte calls, unchanged official BLAKE3 read about 19% faster
across benches, and ring about 4–6% faster. Those readings demonstrate a
cross-benchmark effect even with unchanged contender source. They provide
no general correction factor for the changed library.

## E3 and E4: exploratory coverage probes

`align-probe` on four hosts uses code
`973cf428c20a54b63edda2a9dc0d4e39abacd859`.
`hasher-probe` on Ryzen 9700X uses
`900d8c9279a001cf74dbd4b389581d61e2eacc44`.
Both pin library `bf2da8b957f5e0c80babb57952de3e53f95c921a`.
Source copies are in `code/`; delivered commands and outputs are in each
host's directory.

The alignment probe's warm-call differences were small: Servil was roughly
1.5–3% slower at nonzero offsets for larger inputs on Zen 5, around 1–1.5%
on the Xeon for most large points, and near level on the EPYC 7443 pair.
Official BLAKE3 also showed the small Xeon effect. This does not support a
large universal alignment defect or an immediate expanded alignment matrix.

The short-lifetime probe measured Servil `Hasher::new` + one `update` +
`finalize`, beside each contender's one-shot call. At 64 bytes on Ryzen
9700X it read approximately 226 ns versus Servil's 46 ns one-shot and
official BLAKE3's 52 ns incremental call. Bench coverage is tracked in
[short incremental lifetime cells](https://github.com/servil-software-factory/bench-hashes/issues/209),
and library investigation in
[short Hasher cost](https://github.com/servil-software-factory/BLAKE3/issues/387).

**Probe limitations:** these two probes used `clocks::measure` but retained
only rounded summaries, discarded individual batches and counter fields,
and repeated one executable rather than fresh link layouts. They cannot
be replayed through the standard samples reader. Their summaries and source
are preserved as preliminary evidence, and subsequent measurements should
use the existing sample format and comparison tools. Claims about a copying
cause remain hypotheses. Quiet-load summaries alone do not repair these
limitations.

## Candidate withdrawn

An early candidate, `caf74ddd25cbefff4221d2b769e2c0c5eec11c4b`, would have
rerun first-stage slower cells in the selected second-stage workload and
made that stage's verdict decisive. Review rejected this: changing the
context can hide a real slowdown. Also, similar cycle counts with different
wall time do not make the wall-time cost irrelevant or establish its cause.
The candidate's claims that all six earlier flags were measurement artifacts
exceeded the evidence.

`706ddf399a007698284a5e59838d00c753121998` reverted it on the candidate branch. Its tree matches the
pre-candidate tree; no production rule changed. The restored code passed
180 nextest tests and formatting. The experimental commit stays in history
for accountability.

## Reproduction and provenance

E2 uses bench `97c0fbcbedb8fe8f8395115647684dfde75d67a3`, with the same old
bench and old/new library pair as E1. All measurements ran under the hosts'
common lock; this archive was made from local delivered files. No timings
ran on the interactive i7 during this audit.

Each `replayed-compare.md` was generated with the restored Rust reader,
`bench-hashes compare --markdown OLD... -- NEW...`, ordering the old files
and new files separately by run number. `code/archive.py` gives the exact
plumbing. Twenty comparison tables replay successfully; raw samples and
original verdict logs remain beside them. The Python explorations in
`code/` are historical diagnostics, not the statistical verdict implementation.

The job wrappers can return success after a child failure, so completion
alone carries no verdict. Read each recorded child exit and its report.
The retained scripts are the commands that actually ran, including this
limitation.

Earlier evidence: [release 0.22](../release-022/) and the November 12 gates
on this data branch. Sam lifted the separate maintenance-overlap hold for
the published release bundles in
[her release-timeline review](https://github.com/servil-software-factory/bench-hashes/issues/205#issuecomment-6865083164).
That clearance concerns the release bundles. These later audit jobs retain
their own timestamps and load observations.

SHA-256 and BLAKE3 manifests cover every file except the manifests themselves.
Public follow-up is on the linked workload issues and
[the methodology audit tracker](https://github.com/servil-software-factory/bench-hashes/issues/210).
[Pipeline integration](https://github.com/servil-software-factory/bench-hashes/issues/169)
remains the next implementation task.

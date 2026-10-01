# One executable, sixteen processes: null-control findings

Predeclared in [the protocol](../../null-controls-plan.md). All sixteen runs
use SHA-256 **6d032dc2ffe48c3027a8fc9cc9ed41ad1e2cbbdc5b098d8dbbee9ab3677860ae**:
old/new are labels for the same executable. Fork hashing source 8825450,
clocks unchanged from 8825450. Instrument commit 547e82e is the docs-only
protocol successor of fd6291d; measurement source matches ee3b85a. Generic
Rust 1.98.1 on the i7-12700K, Linux. Build/run manifests are retained.

Each block is old-1/new-1/new-2/old-2, 24 explicit rounds, nine points and
three contenders. Default affinity has two blocks; P-only 0-15 and one P CPU
0 each have one. All runs finish successfully under the 120-second deadline
and read quiet: other programs occupy 0.17-0.21 CPUs on average, max window
0.20-0.28 CPUs. All **36 report cells** per run and exact trace/sample
accounting pass; each has **9 complete balanced points** and **576 sampled
dispatches** (preparation rows are separate). All traces retain empty Linux
cycle fields, and no cycle/frequency or energy verdict is supplied.

## Performance changes occur without an executable change

Selected new-label/old-label fast time ratios from the shared rules:

| Workload, blake3-servil-mt solo | Default block 1 | P-only block |
| --- | ---: | ---: |
| Owned batches of 4096 | 1.081 | 1.141 |
| Lent 1 MiB | 0.989 | 1.038 |

P-only batch4096 also has slow ratio **1.218**, with slow share 271 -> 167
permille. In that block old/old fast is 0.987 and new/new 0.957. Thus even
plausibly reassuring repeats beside one ABBA comparison do not establish
that a label-assigned code change caused its difference.

Small after-idle cells move much more: default block 1 servil st 64 B has
fast/slow ratios 1.407/1.397; its new/new fast ratio is 2.647. Default block
2 servil mt 64 B reads a fast ratio 0.451. Restricting affinity to one P CPU
still leaves substantial small after-gap variability (SHA-256 64 B after
other work fast ratio 1.249, slow 1.448).

The four blocks have **6 / 3 / 6 / 3** pooled speed ratios crossing the
predeclared numeric margins. `crossings.json` retains every such cell,
including newly observed slow populations and their shares; comparison
files retain all other cells and repeats. These counts are **descriptive
margin crossings**, not the gate's decisions or a universal false-positive
rate. The production gate uses a 5th percentile for its fast test, pooled
speed medians for its slow test where both sides split, and adaptive
confirmation/narrowing. Its slow after-gap shifts are shown but not judged.
That distinct decision procedure still needs direct validation.

Several SHA-256 nonstop cells and single-threaded bulk cells stay near level.
Those successes stay beside the failures. They do not certify every workload.

## Grouping affects the meaning of a speed label

compare-runs concatenates the two old processes and the two new processes
before applying the shared split rule. Separate processes can have different
splits. For default block 1 idle servil st 64 B, the pooled old fast median
is 2.8391 ns/B while its individual old fast medians are 3.8797 and 3.2778.
The pooled split selected a different subset of the original observations.
That is the rule applied as written, not an arithmetic discrepancy. A
"fast" label alone does not identify a common physical state across processes
or artifact sides; the grouping/estimand needs review with John.

## What remains open

The controls demonstrate real observed variability and failed code attribution
from these pooled comparisons. They do not identify a scheduler, allocator,
clock, layout, calibration or carryover cause, and do not dismiss a user's
slowdown. One affinity restriction cannot control all of those states.

Next: actual-work positive controls and fixed harness anchors; empirical
neighbor/order variation; the gate's full confirmation policy; shared-group
intervals and serial dependence. The optimization stays draft, with evidence
provisional. John is asked to review these observations and their scope in
[issue #4](https://github.com/johnservil/bench-hashes/issues/4).

## Reproduce and artifacts

Build once against 8825450 with the exact pinned compiler/lock and current
instrument source, record its hash, and reuse that executable in every run.
`run-nulls.py` records the local execution recipe (its `/home/agent` paths
identify the original environment). Every run retains raw samples, its full
report, clocks.csv, accounting JSON and report-check output. Compare four
samples with compare-runs.py using the fork's shared rules. Use external
process-group supervision. Rebuilt artifacts can differ in layout: the
critical null condition is equality within each repeat block's executable,
not a claim of bit-reproducible builds across environments.

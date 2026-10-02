# Controllable causes found; full 3% reliability remains open

The bounded study ran on October 2, 2026, starting at16:35UTC. Experiments
finished by17:53UTC; the final audits followed. It retained **384fresh process
attempts** and audited64earlier quiet-null processes. The original two-hour
limit is18:35UTC. We conclude with two supported, scoped mechanisms and an
explicitly unresolved cause for the remaining process variation.

The [study plan](../../cause-study-plan.md) and stage-specific plans precede
collection. The original Rust reader, shared clocks and Work mean own timing
and accounting. Test-only Rust readers check chronology and execution receipts.
All original attempts, qualifications and failed builds stay preserved.

## 1. First-use initialization distorts queue calibration

Calibration times the first producer/library batch. That batch can initialize
pool, delivery and return-channel state. Its repeat check applies when
`iterations == 1`; continuous queues begin with thousands of calls, so their
initialization cost can set an undersized steady-state batch.

A controlled intervention uses **one artifact** with explicit cold/primed
modes, adding one untimed existing `run_batch` before unchanged calibration.
It predicts and produces a larger call budget. In64quiet isolated processes,
with exact trace/raw accounting:

| Context | Original mean-sample range | Primed mean-sample range |
|---|---:|---:|
| Default20CPUs |86–113µs |461–947µs |
| Four separateP cores |129–251µs |595–877µs |

The intended target is1ms. Priming improves correspondence to that target,
with residual calibration variation visible. The initial128-process diagnostic
had many queue runs shorter than a load-observation window; those records
remain descriptive. The new16384-sample duration scope was declared before
collection and preserves those earlier outcomes.

### The same mechanism changes the mixed benchmark

Three subsequent fixed-budget checks retain the original14points/24rounds,
one unchanged artifact, explicit priming modes and all192process records.

- **Default original versus primed:** all SHA controls within tolerance.
  Queued64 B estimated mean cost falls34.38%solo and32.76%shared, with model
  intervals[−37.92,−30.85]% and[−39.09,−26.43]%. Other queue cells also change.
  Eight solo intervals remain inconclusive, so wholeexit2.
- **Default primed versus identical primed:** two SHA controls are inconclusive;
  subject estimates remain descriptive. Queued64 B interval is[−3.19,+5.69]%
  solo, narrower than the earlier[−8.01,+10.33]% but still crossing3%.
- **Four separateP cores, original versus primed:** two SHA controls are
  inconclusive. Descriptive queued64 B estimates fall20.87%solo/25.17%shared.
  The1MiB target intervals are much tighter in this condition.

Actual original mixed queued64 B samples are154–199µs in the default effect
check, versus701–1105µs primed. The call budget moves from2048–2109 to
13309–19188. Thus a specific initialization/calibration mechanism changes the
represented stream duration and observed cost. This is an **instrument finding**;
hashing code and cryptographic outputs keep their source identity.

Longer batches also change execution conditions. Isolated primed means are
about7%higher than original atdefault and4%higher atP4. Those adverse costs
stay visible. The controlled budget finding earns its scope; broad regression
clearance still requires further validation.

## 2. Core kind and physical topology control costs

128fresh isolated processes reuse the existing input, producer, calibration
and timing adapters. At the same four-logical-CPU pool capacity, eight quiet
multithreaded1MiB processes average~0.0849ns/B on four separateP cores and
~0.116ns/B on twoSMTcores:about37%more time. E-core-only is~0.173ns/B.
Default20CPU runs average~0.0697ns/B, with their own pool capacity. Long-series
within-condition repeat ranges are about1–2.3%, steadier than the mixed null.

Single-threaded BLAKE3 is~0.208ns/B onP and~0.476ns/B onE. SHA-2561MiB is
~0.444–0.448ns/B across these conditions. Core kind therefore has a substantial,
algorithm-specific effect, and affinity supplies a reproducible control.

Retained caller PMUs support that mechanism for serial bulk variability:
BLAKE3 instructions/byte remain within~0.0023%, while the E-core instruction
share accounts for98.34% of the64-run solo timing variation in a descriptive
linear fit. The controlled core-kind cost supports the interpretation; the
fit itself adds association evidence rather than an automatic causal verdict.

The host reportsi7-12700K. CPUIDleaf1A verifiesCPU0type0x40(Core/P) andCPU16
0x20(Atom/E); LinuxPMUmasks0–15/16–19 and SMTsiblings agree. Raw /proc snapshots
record scheduled CPU time, user/kernel ticks, switches and faults. Kernel
schedstats is disabled; ready-to-run interpretation remains unavailable.
Observeron/off controls preserve metadata/context effects.

## What this effort leaves unresolved

First-visit exclusion leaves the earlier target intervals as wide or wider:
soloqueue64 B[−8.01,+10.33]% becomes[−8.89,+10.36]%, andsoloMT1MiB
[−6.48,+10.28]% becomes[−6.62,+10.71]%. Those visits explain little of that
cohort's target uncertainty.

For soloMT1MiB, caller instructions/byte vary0.376–0.607 and account for97.15%
of observed timing variation in a descriptive fit. The pool's `run_job` lets
the caller and workers claim pieces through an atomic cursor, so variable
caller work is a concrete source lead. The historical traces observe caller
work, while precise per-worker assignments remain unobserved. This study
establishes the relationship; it leaves the exact scheduling/placement cause
of those assignment differences unresolved.

Caller P/E work share explains little of queued64 B variability. The primed
mixed null still has wide subject/control intervals. Consequently this
bounded effort **establishes no complete controllable cause for all remaining
mixed-run variation**, and supplies no broad3%detector readiness claim.
We stop further experiments under the declared budget, preserve what was
learned, and leave any next intervention to a fresh decision/plan.

## Evidence and reproduction

`raw-cause-study.tar.gz` contains all384fresh requests/raw samples/traces,
metadata snapshots, mode receipts, process exits and gate reports. It includes
exact diagnostic modules, source maps and the mandatory0/1experiment patch.
`receipt.json` records archive/artifact/file SHA-256 hashes and every manifest.
The mode switch belongs to this isolated causal control. A production
initialization rule would have one behavior, with any redundant handling
reviewed coherently under a new version.

`audit/` contains Rust-produced chronology, caller counters, topology and
per-thread receipts, calibration budgets, mixed intervals and descriptive
core/work-proxy fits. All audits pass. Original source-matched records keep
their own tools and interpretations. Local binaries/build logs remain at
`/home/agent/bench-hashes-validation/cause-study/`; public manifests identify
those artifacts exactly. Original general-reliance acceptance remains open.

Mean-summary publication and its512-process pilot are separate. Upstream
review offers remain[bench-hashes#5](https://github.com/johnservil/bench-hashes/pull/5)
and[BLAKE3#9](https://github.com/johnservil/BLAKE3/pull/9); this diagnosis adds
scope and residual evidence for their owner assessment.

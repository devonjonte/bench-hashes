# Reliability assessment: workload-specific effect resolution

For maintainers deciding which optimization claims bench-hashes can support.
This is a proposed assessment, with a diagnostic baseline. The user decides
when the evidence is sufficient; John’s item-by-item review remains pending.
Optimization, promotion and broad batch expansion remain paused.

## The question to answer

Can the instrument distinguish a specified effect, at a specified workload,
from changes it produces with identical code? Specify the API/input, producer,
gap, completion boundary, solo/shared scenario, affinity/topology, selected
neighbors, build contract, speed estimand and smallest effect of interest.
A result applies to that tuple. Generalizing across tuples requires controls.

Use an **effect-resolution profile**, with these separate entries:

1. **Accounting/provenance prerequisites:** fixed digest anchors, submitted and
   completed work, raw ns/units, complete cells, realized scheduling, artifact
   SHA-256 and actual clocks source. Exact invariants allow zero discrepancies.
   Trace agreement covers recorded work; internal work/calibration require
   separate observation. A failed prerequisite leaves the comparison open.
2. **Null envelope D:** the largest symmetric multiplicative deviation between
   independent processes of the exact same artifact, within each declared
   context: `D = max(max(r, 1/r) - 1)`. Compute each available speed separately
   through shared speeds, retain shares and split mismatches. Report `D/m`,
   the fraction of the intended decision margin consumed by observed variation.
   This is a descriptive stress envelope, with no confidence-bound interpretation.
3. **Gate operating characteristics:** run the complete adaptive gate on exact-
   artifact nulls and known extra-completed-work controls. Report false solo
   holds / all scheduled null checks, shared flags separately, detections /
   scheduled positive checks, and no-verdict/timeouts separately. Also report
   conditional rates among checks that supplied verdicts. Unknown observations
   stay visible; an instrument that routinely abstains has low usable coverage.
4. **Context sensitivity C:** vary neighbors/order/calibration/buffer history
   while retaining the artifact. Use the same symmetric deviation, per speed.
   Retain broad and narrow stages separately. A narrow pass addresses its own
   context; it does not bound costs in the initial context.
5. **Uncertainty coverage:** the fraction of predeclared synthetic trials whose
   shared-rule interval contains the known estimand, across one/two-speed,
   correlated-copy and serial-dependence models. Specify grouping and selected
   speed identity before treating an interval as inferential evidence.

A single aggregate score could conceal a failure in the intended workload.
D and C describe observed sensitivity; gate rates describe decisions. Neither
report/sample agreement nor a passing gate supplies calibrated uncertainty.

## Decision proposal for review

Before a campaign, declare an effect E and an acceptable false-hold risk.
A reasonable conservative starting proposal is to seek observed D and C below
half E, calibrated intervals at their stated level, at least 90% detection of
an E-sized positive control, and an upper false-hold bound below 5% per whole
check. These are proposed targets, not accepted project policy or a sufficiency
verdict. Review practical tolerances by workload with John and the user.

Independent checks with zero false holds require at least 59 checks to put a
one-sided exact 95% binomial upper bound below 5%; below 1% requires 299.
These counts follow `P(zero failures) = (1-p)^N`. Process dependence, selecting
favorable runs, reusing calibration data, or multiple workload claims require
additional design. A two-check pilot cannot establish a low error rate.
Retain every attempted check and recheck after instrument/gate changes.
An effect twice as large validates sensitivity to that large effect; it says
little about detecting a 3% change. Separate design/calibration and validation
sets to keep the acceptance threshold from fitting the observed results.

## Current diagnostic profile

- **Accounting:** seven historical traces pass recorded accounting and within-
  point Williams balance; independent adapter/delivery anchors pass. Internal
  calibration and all direct one-message timing paths remain open.
- **D:** [resolution.json](results/exact-artifact-nulls/resolution.json),
  recomputed from all six process pairs in each of four retained ABBA blocks,
  has 36 cells; 18 fast-speed envelopes exceed the gate's numeric margin.
  These are neither gate flags nor population error estimates. Solo servil MT
  envelopes: batch16 **24.23%**, batch4096 **19.40%**, owned1KiB **34.76%**,
  lent1MiB **20.24%**, pieces64MiB **4.57%**. They span declared affinity
  blocks, taking the maximum within a block, rather than comparing different
  affinities directly. Split mismatches constrain the physical interpretation.
- **Actual gate:** [four checks](results/live-gate/README.md) preserve every
  adaptive process. Original: one pass and **one confirmed solo hold on an
  identical executable**; each has ten processes without load windows.
  Patched: two no-verdict outcomes due to missing windows. This demonstrates
  a policy gap and its guard; the pilot supplies no stable false-hold rate.
- **C:** retained context controls show batch16 B/A about **7–9% solo** and
  **10–14% shared**; calibration, allocation, neighbors and duration co-vary.
  Deterministic actual-gate controls reproduce broad-only cost dismissal on
  narrow confirmation. No immediate-predecessor cause is inferred.
- **Intervals:** flattened shared-copy coverage is about **79–85%** in the
  retained nominal95% one-speed synthetic model; grouping reaches about
  **92–94%**, still below nominal in those trials. Model/estimand agreement
  and serial/two-speed coverage remain pending.
- **Diagnostics/labels:** topology-controlled correct SHA-256 calls refute a
  universal core-only shared/solo inequality. API labels and consistency
  premise revisions await review. Load windows observe OS-visible load, with
  Linux thread cycles unavailable; quiet windows alone cannot bound all state.

**Present assessment:** the evidence supports selected large-effect direct
caller controls and exact recorded-accounting claims. It currently leaves
small-effect optimization decisions unresolved in several queue/MT workloads,
and shared confidence bands remain outside acceptance arguments. This is a
scoped evidence assessment, with maintainer review pending.

## Reproduce D

From this branch, using the fork's shared rules (reader PR #3 or its descendant):

```sh
PYTHONDONTWRITEBYTECODE=1 python3 tools/assess-null-resolution.py audit/results/exact-artifact-nulls --rules /path/to/BLAKE3/tools/speeds.py
```

The optional `--artifact PATH` verifies the retained executable against its
manifest. Exact fractions stay in the JSON; rounding is for presentation only.
The historical records remain unchanged. The metric introduces no timer,
load classifier, bootstrap, speed splitter or samples parser.

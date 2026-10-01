# Positive-work control follow-up: load coverage

The predeclared eight 32-batch runs completed and matched fixed digests/work
counts. Their two/one fast ratios were 1.990-2.003, all one speed. However,
**all eight reported `not measured on this platform` for load**. The probe
finishes below clocks::load's half-window minimum (0.5 s), so windows() returns
an empty list on this supported Linux platform. describe([]) uses the same
phrase as an unsupported platform. The raw runs stay retained; their speed
response is conditional on unmeasured external load, rather than accepted
quiet-machine evidence.

A follow-up is predeclared for the explicit reason of load coverage: the same
factor order, CPUs, payloads, algorithms, tolerances and deadlines, with
**128 batches** per cell. The diagnostic CLI takes the batch count explicitly;
there is no fallback that guesses what it should be. Source/work accounting
stays otherwise the same. Retain both stages, including any follow-up load
failure. This extends runtime to collect a load window rather than selecting
a favorable performance ratio.

The original commit message says 25 tests; the recorded full suite contains
**24** (22 baseline plus two new anchors). The test log is authoritative.

This also opens T7 questions for review: empty windows can mean insufficient
runtime as well as unavailable counters; and tools treating `busy == false`
as permission to give a comparison can proceed when load was unmeasured.
Describe those states separately, with shared-rule changes reviewed and all
readers/callers updated together. The full benchmark null runs were long
enough and quiet; this limitation applies to the short positive caller here.

# Near-margin diagnostic plan (predeclared)

Purpose: decide whether the current actual gate merits a full fresh acceptance
campaign at its existing 3% solo margin. This pilot supplies evidence toward
the [reliance procedure](reliability-assessment.md); it supplies no GO verdict.

## Frozen control and scope

Use fork hashing6afda66, shared clocks/reader/gate3a240a0, benchmark build
base663b035 and the committed v2 `examples/work_control.rs` source. Record
compiler/build flags, source and artifact hashes before execution. The same
executable serves every side. Hardware: this Intel i7-12700K, native x86 Linux,
inherited default affinity,128 measurement batches; no waits or load padding.
All measurements use `clocks`; parsing and statistics use the shared fork tools.

Each timing invocation processes a block of100 logical requests. It completes
100+k independently observed hashes, with k=0/3/6/100, through the same loop and
plain hashing function. SHA-256 stays at k=0. BLAKE3 input lengths64/2048/102400
stay fixed. Every digest is observed; independent fixed preflight anchors and
per-cell completion counts include calibration. Samples retain unreduced
nanoseconds / logical requests. New CLI is `SUBJECT_EXTRA_PER100 BATCHES
CONTROL_EXTRA_PER100`; accounting contract2 refuses old factor records.
Historical controls use source/tools at3d448f8.

The known work increase k% is **not assumed to equal a k% latency increase**.
Calibration below uses separate process data to establish that timing effect.
This caller models hot serial requests in blocks; queued/shared/incremental
production workloads remain separate validation requirements.

## Separate calibration (no tuning)

1. One null ABBA block and one100%-extra ABBA block.
2. Four ABBA blocks each at3 and6 extra hashes per100 requests, interleaved
   by block: 3,6,3,6,3,6,3,6. Total40 processes including the two anchors.
3. Analyse each old/new adjacent pair with the actual gate's `parse` and
   `ratios_of`; describe fast/slow medians and shares through shared speeds.
   Publish every pair and each size, plus the median of the eight pair ratios
   per level. No new timing, percentile or speed classification implementation.
4. Eligible calibration requires exact accounting, quiet fully recorded-start
   coverage in every used process, and median q5 latency effect within
   [2.7%,3.3%] for level3 and [5.4%,6.6%] for level6 at every size. These are
   +/-10% tolerances fixed before data. Failures retain the entire dataset;
   no choice of extra counts, affinity or delays follows from these results.
   Load-window observation retains its documented v4 full-interval limitation.

## Held-out actual-gate pilot

After calibration, run four whole null comparisons, one100%-extra comparison,
then eight whole comparisons per level in order3,6 repeated eight times.
Build/process plumbing calls the declared caller; **actual parse/pairs/judge/
compare**, fixed context, thresholds, early stop and confirmation all execute.
Capture each judgment (including controls) through a recording wrapper around
the original function. No judgment logic changes.

Also run one short null control (8 batches) and one external-busy null control
(two untimed supervised PyPy workers), preserving expected exit2 and data.
Each whole comparison has a120-second process-group deadline. Timeout is a miss.

Per size/level, a correct pilot detection requires an initial flag and its
confirmation, quiet/covered load, stable control and exit1. An early null verdict,
unconfirmed flag, exit2 or timeout counts as a miss. Report per-cell and whole
comparison results; a hold at one size cannot certify the others. Null changes
(faster or slower) are failures, including flags that allow exit0.

The pilot's predeclared readiness target is8/8 detections per size/level, zero
false changes in the four nulls, the expected100% detection, and both expected
abstentions. Missing calibration eligibility blocks a sensitivity claim even if
a later gate holds. Continue the held-out pilot as a diagnostic record in that
case; do not reinterpret it as acceptance. A failed target keeps3% NO-GO and
identifies the next design review. Passing only permits preparation of the full
30+30 positive/66-null campaign and remaining blocker closure.

At3%, the injected effect is near the gate's strict >3% trigger. Requiring every
initial and confirmation pair beyond that trigger may have poor boundary power.
This is an explicit hypothesis to test, not a reason to alter the threshold or
relax the acceptance procedure after seeing outcomes.

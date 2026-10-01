# Positive work response, with failed load coverage retained

This diagnostic complements [the exact-artifact nulls](../exact-artifact-nulls/README.md).
One/two hashes per logical request use the same executable per stage, with
factor order 1/2/2/1 on CPU0 and CPU16. Every digest is observed and checked
against fixed independent preflight anchors. All clocks, load readings and
sample summaries use the shared implementations. Manifest hashes identify
both stage artifacts; SHA-256 sha2 and servil st hash 64/2048/102400 bytes.
The pinned fork/clocks source is 7270b21; this caller uses single-threaded
one-shot APIs and avoids its known one-CPU queue bug.

## Accounted work and timing response

All sixteen callers pass exact checks: per-batch completed hashes = calls *
factor; total completions including calibration = (batches + 1) * calls *
factor. Raw time/logical-call pairs match the trace exactly. Sample denominators
count logical requests, so the factor-two work remains visible.

The predeclared 32-batch stage produces time ratios 1.990-2.003, one speed,
but **all eight load readings are unmeasured**. It finishes below clocks'
0.5-second minimum window and says `not measured on this platform` even on
this supported Linux machine. This is a failed load-coverage control; its
response is conditional on unmeasured load and remains in the record.

The explicitly predeclared follow-up extends each cell to128 batches for a
load observation. All eight runs then report quiet (0.18-0.24 other CPUs,
one window each), and factor-two ratios are **1.995-2.009**, all one speed,
inside the predeclared tolerances. Each stage retains its raw samples,
clocks, completions and comparisons, including same-factor repeat controls.
This supports the selected direct caller's proportional work response,
with this compiler, machine and workload. It does not validate queues,
production after-gap timing, calibration under different workloads,
bootstrap coverage, or the full regression decision procedure.

## Independent harness anchors

The production benchmark stays unchanged. Two test-only checks use plaintext
byte i = i %251 and committed anchors at64/2048/102400 bytes. BLAKE3 values
copy the published vectors' first32 bytes; SHA-256/SHA3-256/SHA-1 values were
explicitly generated with Python hashlib / OpenSSL3.0.13. SHA-1DC's anchors
cover benign data, not collision detection assurance. Expected values remain
fixed; tests never regenerate them.

Every available contender's output-observing adapter is checked for messages,
lent/owned buffers and incremental pieces, including crossing64 KiB. Batch
counts1/4/17 exercise single/full/tail groups; one and beyond-in-flight
iterations exercise delivery and count accounting. Repeated message anchors
are supplemented by the existing distinct-message order differential test.
The full suite passes **24 tests** (the prior commit message's25 was corrected
in the follow-up). These tests exercise hash_batch adapters; the synchronous
preselected one_message_call's timing path has separate dispatch tests and
still needs direct timing corroboration.

## New load-policy finding

An empty window list can mean insufficient duration as well as unsupported
counters. Furthermore, perf_regress only records busy runs; missing windows
can occur in its short narrowed/confirmation runs and still permit a verdict.
The compare-runs helper also proceeds on missing load observations. This
source-verified policy gap is reported in
[BLAKE3 issue #4](https://github.com/johnservil/BLAKE3/issues/4), with maintainer
review pending. No claim is made that busy load caused a historical verdict.

Next: shared-rule load/reader policy review, adaptive gate controls, empirical
carryover and clustered/serial uncertainty. Optimization remains draft.

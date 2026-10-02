# Current Rust fast-median diagnostic — predeclared October 2, 2026

Decision remains **NO-GO**; hashing optimization stays paused. This is a
source-specific calibration/pilot, separate from finite acceptance and the
historical q5 studies. No detector, statistic, margin, workload or clock change.

## Frozen implementation and scope

- Detector/readers: bench-hashes candidate 67f5300. The actual Rust `regress`
  and `compare` executables, copied and SHA-256 recorded before collection.
- Hashing/current clocks: BLAKE3 f82d46c (d31a46c plus independently reproduced
  busy-tail preservation). PR #8 remains awaiting assessment; native Mac untested.
- Known-work caller: exact v2 `examples/work_control.rs` from bench evidence
  446e8cf, rebuilt with these clocks/hashing and sha2 0.11.0. Independent fixed
  anchors and internal exact completion assertions remain. Every 100 logical
  requests perform 100+k observed hashes, in the same loop; k is extra work,
  rather than an exactly known latency effect. Sizes: 64/2048/102400 bytes.
- Default CPU affinity, existing governor. Linux supplies no thread-cycle
  counts; wall times stay unscaled. All outcomes and calibration retained.
- Python collects process outputs and Rust comparison text only. It decodes
  no samples and implements no speed statistic or detector. Accounting checks
  may read the separate trace and completion CSVs (counts, not speed estimates).
- Wrapper receives all production `regress` arguments and retains them. The
  probe supplies six solo direct-caller cells (SHA-256 and servil st at three
  sizes), rather than pretending to exercise the requested fourteen production
  points, servil mt or shared margins. Two additional identical-artifact live
  benchmark checks exercise all fourteen production points. Claims distinguish
  these scopes.

## Separate calibration (40 processes)

Run ten ABBA blocks, in fixed order: k=0,100,3,6,3,6,3,6,3,6.
Each new side uses k; each old uses 0; control extra always 0; 128 batches.
Rust `compare` pools each block's old files against its new files; also compares
old1/old2 and new1/new2. For each k=3/6 and size, the median of the four Rust
reported fast ratios (integer permille, middle two averaged explicitly) must
fall within ±10% of the nominal work shift: 1027..1033 and 1054..1066.
All qualifying blocks must report quiet load. Anchors k=0/100 are descriptive
checks. No level selection, retuning, measurement replacement or retries.
A failed calibration marks that level unqualified; its pilot still runs and
is reported descriptively. Rounded comparison output limits effect precision.

## Held-out pilot (23 fresh detector checks)

Fixed order: four nulls k=0; one k=100; eight repetitions alternating k=3,6;
one short null (8 batches); one busy null (128 batches, two external CPU workers).
All regular checks: 128 batches, SHA-256 control extra=0. Same executable on
both sides; wrappers only select CLI k and preserve outputs. Actual Rust gate
performs ABBA pairs, early stopping, control abstention and confirmation.
Short/busy checks must abstain (exit2); retain failures without rescue.
Two further production fourteen-point checks run identical artifact vs itself.

Report, per level and size: confirmed subject cells, faster calls, misses,
abstentions, pair comparisons and number of initial/confirmation processes.
Whole-check exit1 is never counted as detection of every size. Pilot readiness
requires four quiet nulls free of subject calls, the 2x anchor holding all sizes,
both negative controls abstaining, and 8/8 confirmations per qualifying near-
margin level and size. This is a diagnostic criterion, not acceptance clearance.
Production checks report false calls/abstentions separately; two checks cannot
establish low false-decision probability.

## Supervision and evidence

Each calibration process has a 120-second process-group deadline; each detector
check has 120 seconds (production 180). Whole campaign externally bounded at
1200 seconds. On timeout TERM/KILL the entire group; busy workers are started
in that same group and cleaned in finally. Child raw samples, trace, completion
counts, logs and request manifests are copied before wrapper returns, while
Rust's temporary output still exists. Archive source snapshots, build logs,
Cargo.lock, exact artifact hashes, comparison outputs and every failed attempt.
No concurrent benchmark, no sleeps/padding, no favorable-run retries. Any source
change requires a separate declaration and fresh measurements. Independent
operator assessment and finite acceptance remain outstanding.

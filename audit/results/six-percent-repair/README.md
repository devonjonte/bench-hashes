# Reliability repair: two useful failed experiments

**NO-GO remains.** We tested two inexpensive hypotheses before spending time
on the agreed acceptance campaign. Neither supplies an accepted fix. Hashing
optimization remains paused; the written reliance requirements stay unchanged.

## 1. Affinity isolation (plan c856175)

Forty fresh ABBA processes use the unchanged current work caller/detector,
interleaving default affinity and CPU0. Most CPU0 effects stabilize near6%,
but one bulk same-code repeat moves+6.9%, producing+13.1% instead of+6%.
Default bulk repeats reach+9.7%, with block effects-1.1..+12.3%. Both fail the
predeclared repeat/effect stability criteria. Affinity alone is insufficient.
No sole placement/frequency cause is claimed. All raw data and Rust comparison
text are preserved in `affinity-calibration/`.

## 2. One mean score over eight fixed pairs (plan f462ae3)

Source **1d9509c**, explicit experimental branch `candidate/devon-six-percent-repair`.
Hashing/clocks remainf82d46c; reader/statistics remain shared Rust. Instead of
requiring every pair to cross the margin, use one arithmetic mean of eight
pair fast-speed ratios. Keep3/10% margins, control/load abstention and full
fourteen-point context. All eight pairs run, with no separate confirmation.
The code is smaller; unchanged-code checks expose its reliability cost.

| Fresh control | Result |
|---|---|
| Eight caller nulls | Five exit0 without subject calls; three control abstentions |
| Eight k6 caller positives |64/2048 B6/8;102400 B5/8; two control abstentions and one bulk miss |
| Four k12 caller positives |All three sizes4/4; sanity level, not exact12% calibration |
| Two k3 diagnostics |One control abstention; one hold at all sizes; exact-above3% effect unestablished |
| Short/busy negatives |Both abstain2 |
| Two production self-checks |**Both falsely hold identical artifacts**, with additional faster/shared calls |

Candidate production check25 falsely holds MT owned64 B (+8.0%) and owned64KiB
(+4.2%), and calls a shared64B improvement. Check26 falsely holds MT owned64B
(+4.1%) and lent1MiB (+7.0%), and calls shared64B regression and ownedbatch4096
improvement. The pooled descriptive fast comparisons for MT owned64B are
0.989/0.992, illustrating how per-run ratios and state selection can disagree
with pooled comparisons. These are counterexamples, rather than a proposal
to substitute pooled medians without validation. Treat the candidate as FAILED,
not as a base for an expensive acceptance campaign.

The production self-checks make the cost concrete: always taking eight pairs
runs32 production processes vs12 in the earlier self-check pilot and creates
false calls. Larger aggregation requires stronger state/measurement premises;
its demonstrated benefit falls short of its costs here.

## Calibration provenance clue

The bulk caller's100-hash blocks last about2ms, the calibration target itself.
Its independently calibrated old/new processes consequently use one or two
blocks per sample. k6 often selects one block while old selects two, and even
same-code processes sometimes differ. The resulting context change is part of
the measured process, rather than a known fixed latency intervention. Current
records establish the difference in work per sample; they do not establish that
it caused all timing shifts.

The promising next diagnostic uses identical fixed logical work per sample
on both sides, with shared clocks timing and explicit warm-up/completion counts.
It targets this confound before changing the decision rule again. This is a new
experiment requiring its own declaration and fresh calibration. Earlier failures
remain valid observations of their original source/procedure, with the latency
intervention's stability explicitly qualified.

## Evidence and supervision

- Forty affinity processes +384 direct-caller candidate processes +32 production
  candidate processes = **456 preserved process records**.
- 424 direct-caller processes,2544 cells,314112 measured batches pass exact
  trace/count receipts, including completion/calibration assertions in the
  producer. All sample decoding and pair speeds are computed by Rust.
- 25 candidate Rust unit tests pass, including integer aggregation/margin anchors.
  Unit correctness does not clear the failed empirical detector.
- Each process/check used bounded process-group supervision, including busy
  workers in the supervised child group and finallycleanup.
- An interactive interruption removed the original outer campaign supervisor
  while its collector continued. Per-check supervisors remained active. An
  additional bounded watcher restored a campaign deadline and was prepared to
  terminate all observed descendant groups; campaign completed before that limit.
  The interruption and restored-deadline records are preserved. No worker remains.
- Source/artifact identities are in `aggregate-source-manifest.json`; all original
  binaries/builds remain in `/home/agent/bench-hashes-validation/trust-audit/six-percent-repair/`.
- A separate availability check finds that Linux hardware cycles/instructions
  are accessible through perf, including core PMUs. Shared clocks currently does
  not expose them. CPU settings are readable but not writable by this account;
  no governor/frequency setting was changed. Availability alone supplies no
  timing/core-state explanation, and no external-counter measurements are counted
  as hash performance evidence.

Summarize Rust text/receipts with `tools/analyze-six-percent-repair.py`. Plans:
[six-percent-repair-plan](../../six-percent-repair-plan.md) and
[six-percent-aggregate-plan](../../six-percent-aggregate-plan.md). Acceptance,
independent operator reproduction and maintainer assessment remain outstanding.

# Matched fixed-work calibration: context controlled, instability remains

**NO-GO remains; hashing optimization stays paused.** We removed one concrete
measurement confound and tested it before changing the detector again. Both
configurations fail the declared calibration criteria, so the conditional
held-out pilot stays unstarted. This saves a campaign on an unstable intervention.

## The small change

[Plan](../../fixed-work-calibration-plan.md) and
[schedule](../../fixed-work-calibration-schedule.json) were committed before
collection (15128c3, resolved dependencies58ec9ab). The original current Rust
all-pairs detector remains benchmarkb9dfa12. Hashing is unchanged. Shared clocks
**4e4d413** adds26 lines: an explicit-call batch function reuses the existing
batch timing body; calibrated `measure` delegates to it. There is one timing,
load and counter implementation. The failed mean-pair experiment stays separate.

Caller v3 uses the same100 logical requests/100+k observed hashes, fixed digest
anchors, and fixed logical work per sample on both sides:500 blocks at64 B,
30 at2048 B,2 at102400 B. One explicit untimed warm-up batch matches sample work.
Fixed counts were declared before measurement, replacing the previous independent
one/two-block choices at the2ms bulk calibration boundary. No sleeps, padding,
threshold changes, sample-reader twins, retries or work-selection tuning.

## Fresh separate calibration:56 processes

Fourteen ABBA blocks: default/CPU0 nulls, then three repetitions of6/12-extra
blocks in each configuration. Rust `compare` supplies every effect and
same-code repeat ratio. Every process reports observed quiet load.

| Configuration | Result |
|---|---|
| Default0–19 |Fails effect/repeat criteria;14 deviations across the declared comparisons |
| CPU0 |Fails effect/repeat criteria;6 deviations, including the unchanged SHA256 control |

CPU0 small subject effects stay near6/12%. However, two CPU0 near6% bulk blocks
report **−0.7%** rather than near6%; their old-old repeats move **+6.9/+6.8%**.
Default bulk old-old repeats move−7.1%,+7.1%,+7.6%;6-extra block effects include
+0.6% and−1.1%. CPU0 also has an unchanged SHA25664 B null effect−5.7% and an
old-old repeat+7.5%. `calibration-decision.json` lists all bounds, comparisons
and failures, including successes alongside failures.

Every logical work count now matches across sides, so differing one/two-block
calibration choices are **insufficient to explain all instability**. Fixed work
improves provenance; it does not supply a general6% reliability fix. The next
investigation needs evidence about cycles, core placement/state and input
alignment, rather than another ad hoc score or a larger acceptance campaign.
Perf availability checks in the preceding repair record show hardware counters
are accessible here; the shared clocks backend currently exposes none on Linux.

## Exact evidence and verification

- 56 processes,336 cells,**43008 measured batches**, with identical declared
  logical work per size and exact completion counts including explicit warm-up.
- Production Rust `read_samples` checks all43008 raw ns/units pairs against the
  separate trace. A second test rejects doubled ns and work while preserving
  the normalized ratio. Together with the original benchmark suite,
  **26 Rust tests pass** (24 original +2 retained-record audits).
- Shared clocks:19 tests pass,1 reading-cost test ignored;3 new fixed-call
  contract tests check exact call count and invalid zero batches/calls.
- Six collector/count contracts pass. Python reads separate count/trace receipts
  and Rust text only. Sample decoding/statistics remain shared Rust.
- The required bounded standard perf check passed before code commit, stopping
  after two pairs/all14 points. Both sides use the changed shared instrument;
  this establishes operational compliance, not instrument-overhead calibration.
- All calibration processes had120-second group deadlines and the campaign a
  separate1800-second deadline. No timeout, retry, worker or process remains.
- Original binaries, isolated audit source and build logs remain in
  `/home/agent/bench-hashes-validation/trust-audit/fixed-work-calibration/`.
  Public source/artifact hashes are in `source-manifest.json`; all records,
  audits and failed criteria are retained here.

## Decision

Both configurations fail before the held-out gate stage. The calibration guard
works as declared: no detection or readiness claim comes from unstarted tests.
The written finite acceptance criteria, independent reproduction and itemized
review continue to apply. We keep the small reusable timing API as an experimental
measurement aid, with no native-Mac validation or promotion claim.

Rebuild `audit/fixed-work-control/` against the declared shared-clock source;
collect with `tools/run-affinity-work-calibration.py` and the committed schedule;
summarize using `tools/analyze-fixed-work-calibration.py RECORD_ROOT`.

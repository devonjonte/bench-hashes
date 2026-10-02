# Linux counter diagnostic: better evidence, with reliance still provisional

**NO-GO remains; hashing optimization stays paused.** The useful improvement
is that this Intel Linux host can now record thread cycles and instructions
through the same shared clock implementation as wall time. The detector and
its thresholds remain unchanged. This is an experimental instrument, separate
from the newly frozen upstream benchmark0.10.0.

## Source and predeclaration

Plan48384a3 and final32-process schedule0152141 preceded collection. Benchmark
b9dfa12 supplies the original Rust reader, two-speed statistics and all-pairs
regression rule. Fork **e54b6f2** adds an optional Linux hybrid-PMU backend to
shared clocks; hashing is unchanged. Caller accountingv4 uses the same fixed
500/30/2 logical-work blocks and one warm-up batch asv3, with counter availability
and input-address-mod64 provenance recorded. Raw wall ns/units remain unscaled.

The backend uses caller-thread `cpu_core` and `cpu_atom` perf groups, each
containing user-space cycles/instructions and PMU running time. Pinned groups
are not multiplex-scaled. Running time includes kernel execution while scheduled;
its user-cycle rate approximates MHz on long batches, with read overhead stated.
Permissions or unsupported PMUs can yield unavailable counters. PMU classification
comes from the kernel, rather than inferred clock-rate labels.

## Verification

- Shared clocks:20 tests pass;3 diagnostic/cost tests ignored in the default run.
- Explicit live tests under CPU0 and CPU16 each pass and assert that the other
  kind's counters remain zero. CPU0 reports P counts; CPU16 reports E counts.
- Eight1000-read batches take470835..512859 wall ns: about0.47..0.51microseconds
  per counter read, measured through shared clocks. Two reads per hash sample
  remain outside its wall interval. Their effect on workload state still matters.
- The required bounded standard perf check passes before code commit after four
  pairs/all14 points. Both sides use the new instrument; this establishes
  operational compliance rather than old-instrument overhead or reliability.
- The current benchmark's24 tests, two raw-retention audits and one counter-trace
  audit all pass: **27 Rust tests**. All24576 wall ns/work pairs match the trace;
  doubled ns and units with unchanged normalized ratio are rejected. Every row
  has positive total cycles/instructions/running time; CPU0 rows keep E inactive.
  Counter summaries use shared Rust normalization/speeds, never a Python twin.

## Fresh diagnostic cohort

Thirty-two processes/eightABBA blocks: defaultnull,CPU0null, then three interleaved
near6% blocks per configuration. All192 cells/24576 batches pass count and raw
retention checks. Processes are independently group-bounded; all attempts remain.

CPU0 bulk block effects are **+6.0,+6.1,+6.0%**. CPU0 small effects are also
near6% (64 B+5.6/+5.7/+6.4%;2048 B+6.0% in allthree). Default bulk effects are
+5.3/+5.1/+5.7%, alongside about2% same-code shifts. These are fresh diagnostics,
not a frozen acceptance campaign or proof of eight-pair detection.

For the bulk caller, recorded instruction costs rise from264879.905 to280772.585
per logical request (about6%); cycle costs rise from about92.5k to98.1k on CPU0.
CPU0's reported approximate user rate stays near4894–4895MHz. Default processes
include rates near4895 and4990MHz. All bulk input pointers have offset16mod64.
`reader-counter-tests.stdout.txt` preserves every cell's wall/cycle/instruction
speeds, rate groups and kind share alongside the raw records.

The earlier~7% instability does not recur in these bulk comparisons. The added
counters and metadata change measurement context, and earlier records lacked
these observables. We therefore retain historical causes as open; this cohort
cannot prove what caused past shifts. No clock-based rescaling or new state
filter was used, and no held-out gate pilot has been run on this source yet.

## Scope and next steps

This native64-bit Intel hybrid host is the tested scope. The experimental
backend still needs portability/safety review, including x32 ABI gating and
cache ownership after fork without exec; our tested harness starts fresh exec
children. Darwin backend behavior is unchanged but native Mac remains untested.
Keep it experimental rather than presenting generic Linux support as validated.

The promising next step is a separately declared CPU0 calibration/held-out pilot
on this fixed-work instrument, including a calibrated12% level and matched
production/streaming API scope. Plain `hash` controls alone do not clear the
planned `hash_many` optimization. Finite acceptance and independent reproduction
remain unstarted. Counter evidence informs the repair; it does not supply GO.

John's October2 update freezes the entire upstream benchmark at0.10.0. Adopting
measurement, load, rule or presentation changes requires Zooko's recorded decision
and a new release. These experimental forks and evidence preserve source identity
and do not silently change the frozen benchmark. PR8's busy-tail safeguard remains
unmerged. Coordinate review before proposing adoption; keep the written reliance
agreement and our optimization pause intact.

Local originals/binaries/builds:
`/home/agent/bench-hashes-validation/trust-audit/linux-counter-diagnostic/`.
Exact identities are in `source-manifest.json`; the reader/counter audits are
post-collection test-only extensions and do not alter the measured artifact.

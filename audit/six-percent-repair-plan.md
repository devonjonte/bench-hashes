# Six-percent reliability repair — exploratory stage 1

User asks us to fix reliability and follow `reliability-assessment.md` while
away. **NO-GO remains**, hashing optimization stays paused. Its finite counts,
zero false decisions, repeat/context bounds, exact accounting and independent
review requirements remain unchanged. A diagnostic success is not GO.

## First isolate measurement instability, before changing the detector

Historical current-source bulk controls vary by about 8%, with k6 block effects
-3.2..+6.0%. The all-eight-pairs conjunction compounds this instability. Merely
averaging four pairs would still miss historical check21 (initial mean +1.7%).
This observation selects a hypothesis, rather than supplies acceptance evidence.
We first ask whether constraining this single-threaded direct caller to one
CPU stabilizes the observed work intervention. No cause is presumed; affinity
also changes available capacity, topology, frequency and context. No frequency/
P-E attribution is inferred from absent Linux cycle counters.

Freeze the SAME retained work-control/bench-hashes artifacts from the current
pilot (source identities/hashes unchanged), sharing Rust readers/statistics.
No timing, hashing, statistic, splitter, threshold or gate change in stage1.
Two configurations: original default0-19 affinity and explicit `taskset -c 0`
on the direct-caller process ONLY. This stage makes no claim about queued,
multithreaded, shared or full-benchmark sensitivity and changes no frozen APIs.

Fresh40 processes in ten fixed ABBA blocks:
- block1 default null; block2 CPU0 null;
- blocks3..10 k6, alternating default/CPU0, four blocks each configuration.
Each process128 batches; old sidek0, new sidek6; SHA256 extra0 throughout.
Run all blocks without replacement, retuning, padding or retries. Compare
old/new pooled by block and each old1/old2, new1/new2 through actual Rust compare.
Keep all raw/trace/completion outputs; exact accounting assertions unchanged.

Diagnostic stability targets, per size/configuration: every k6 block's fast
ratio1054..1066 inclusive; every same-code repeat ratio986..1014 inclusive
(the earlier E=3% repeat target requires strictly below1.5% deviation). Null
old/new ratios also986..1014. Report failures and every ratio individually;
do not rescue with only a median or average. The CPU0 result describes that
configuration only. A passing CPU0 result motivates new matched direct-caller
and production calibration, not a default-affinity reliability claim.

Each process externally supervised for120 seconds as an entire process group;
campaign1200 seconds. No concurrent measurement. Preserve source/artifact
identity, plan commit, exact commands and failures. Python collection reads
no samples; Rust compare supplies all reported speed ratios. Metadata lines
may be inspected verbatim; counts/trace checks are exact work checks.

## Later stages require separate declaration

Select the simplest supported repair only after stage1. Options remain explicit
measurement-configuration control, more representative fast-state measurement,
or aggregate pair evidence with validated false-alarm behavior. No option is
accepted by historical replay alone. Any detector/statistic/configuration change
gets fresh calibrated positives and nulls before the agreed frozen acceptance
campaign. The user specifically requests6% sensitivity; a scoped E=6% proposal
would still require fresh30/30 positives at6/12%,66 nulls (33exact artifact,
33identical-source rebuild), at least60 valid null verdicts/zero false calls,
12ABBA blocks/three sessions below3% deviations, matched callers, independent
review/reproduction. E=3% retains3/6% positives and1.5% repeat bounds. All other
requirements in the written agreement continue to apply.

# Repeated executable layouts: bounded assumption assessment

November 14, 2026. Owner: Devon. Related work:
[measurement-context audit](https://github.com/servil-software-factory/bench-hashes/issues/210).

## Decision

**Keep the production statistical rule unchanged for now.** Reused layouts
can make repeated observations correlated. This assessment establishes the
risk and finds it in stored and fresh measurements, but it does not establish
a calibrated replacement procedure or an empirical false-call rate.

The immediate, well-supported repair is clearer reporting: the current
second stage uses 16 linked layouts per side four times, while its expanded
argument list makes `regress` announce “64 new builds against 64 old”. That
count is wrong. Matching source labels also cannot by themselves establish
an unchanged-code experiment when build or run settings differ. The reporting
candidate corrects those facts without changing measurements or decisions.

The assessment stopped after one fresh null and one known-change experiment.
No original verdict has been replaced by the counterfactual labels below.

## Why inspect this assumption?

`check`'s second stage runs 16 layout pairs four times in turn and judges
64 process-pair ratios. A layout is where functions sit in a linked program.
Repeating that program keeps its layout. The earlier decision to reuse it
was supported by low measured correlation in an i7 study; that evidence
has a workload and platform scope.

The recent Pipeline extra-work pilot **did detect a shared slowdown in its
first stage**. Individual solo cells labelled level do not mean the complete
check missed that change. A replacement must be assessed as a complete
procedure, with detection, false decisions and cost considered together.

## Synthetic stress test: a condition, not an observed error rate

`layout_repeat_control.rs` calls the existing `clocks::summary` rule on fixed
integer inputs. Each independent layout pair contains a fast and slow copy
of identical code; a fair coin assigns the sides. Thus both sides have the
same population of costs. Repeats copy that pair's observation exactly.
There is one noisy null cell, with any other family members exactly level.

All sign assignments are counted with exact binomial weights. No machine
is timed. Fixed anchors check an unchanged control, a known 6% increase,
and a case where copying observations changes the judgment despite adding
no independent layout information.

For the 11/10 cost ratio in a family of eight cells:

| design | false classifications in this constructed null |
|---|---:|
| 16 independent layout pairs, one run each | 0.4181% |
| the same 16 pairs, each copied four times | 21.0114% |
| 64 independent layout pairs | 0.8147% |

These figures describe this deliberately dependent, discrete model. The
t-test's approximation is itself imperfect for its discrete distribution.
They are neither the current tool's measured error rate nor a calibration
of its full two-stage procedure. The complete exact counts and both noise
ratios are in `analysis/layout-repeat-control.stdout.txt`.

## Offline assessment of existing records

The producer-matched reader inspected every complete 16-by-4 second stage
under the two predeclared data questions: release-022 and the November 13
methodology audit. Fifteen stages, 82 cell rows, zero exclusions. Original
samples remain in the data commit named by `INPUT-DATA-COMMIT.txt`; both
input manifests bind all 1,920 accepted files without duplicating them.

For each cell, the diagnostic groups accepted pair index modulo 16, matching
`check::each_run`. It reports estimated within-group correlation and compares
the original rule with a counterfactual using geometric means within each
layout pair. The overall geometric ratio is retained. Grouped uncertainty
is a diagnostic, not an accepted replacement verdict.

Twenty-four rows have estimated group correlation at least 0.3; eighteen
have a grouped standard-error estimate at least 1.5 times the original.
Nine labels change in the counterfactual. For example, Ryzen 9700X cold
16 KiB has estimated correlation 0.716 and an uncertainty ratio of 1.806.
The original +3.2% slower label becomes level under grouping.

These datasets cross library or benchmark versions, so those changes cannot
be called false positives. Groups share order and can share core placement.
The diagnostic does not distinguish those causes from linked layout effects.
Fixed algebraic anchors validate the covariance calculation; constant
inputs have undefined correlation and print NA.

## Fresh controls

Producer benchmark `2c8676842feab053fa7855d4cb3393bdea26ed4a`, EPYC 9275F,
Servil st alone. Eight fixed points: after-work 64 B, 4/16/32 KiB; lent
64 B/1 KiB; and lent-incremental 64 B/1 KiB. Both jobs used the same scope,
default memory policy and the host lock, with a 45-minute bound each.

Each job first built 16 distinct layout pairs and ran a survey. It then ran
those same 16 pairs four times in turn. The survey selected nothing and is
not pooled with the repeated phase. All 320 measured process runs report quiet load;
the largest reported background window is 0.02 CPUs. Cycle, instruction and
energy counts were unavailable. Scripts, layout-path/source manifests,
accepted samples and original verdicts are preserved in `fresh-null/` and
`fresh-finalize/`. Executable hashes were not captured; the source pins,
paths, seed schedule and commands are preserved.

### Unchanged code

Library `f62bc6ac0bc1c86861659d61ffbf4e9546bc8aec` on both sides. The original
64-pair rule and the grouped counterfactual both label all eight cells level.
Cold-cell estimated group correlations are 0.225–0.361; their grouped
uncertainty estimates are 1.30–1.46 times larger. This fresh null produced
no false flag. One null experiment cannot calibrate a population rate.

### Known finalize change

Library `c5d8331c7c3c89ac4890693f0c096336291d2639` to
`0932d4a610e2dcc96e16af424f8d75d12cd4b360` through one benchmark. Both
analyses detect the sustained incremental improvements: about 28.3% at
64 B and 5.0% at 1 KiB.

The repeated phase also reports **cold one-shot 16 KiB +3.5% slower** under
the current rule, with pair ratios from -10.2% to +21.3%. Its estimated
group correlation is 0.607. Grouping raises the uncertainty estimate by
1.704 times and changes the label to level, while retaining +3.5%.
The initial 16-pair survey read about +3.0%, level. This remains a cost to
review with John, not a regression erased by a different analysis.

## Scope of the conclusion

The results justify keeping dependence visible and questioning universal
independence claims. They do not yet demonstrate that a statistical redesign
improves the whole tool's decisions at an acceptable cost. Grouping can also
bundle controlled order or core effects, so its interpretation needs care.

No further control campaign was launched to seek a preferred label. The
productive immediate change is factual run/layout reporting; a larger rule
change requires its own predeclared acceptance evidence. The fresh adverse
reading and all historical labels remain available for their owners' review.

## Reproduction

Experimental source is retained by tags in Devon's bench-hashes fork:

- `audit/2026-11-14/repeat-record-reader` →
  `aef48a1dcab7e582eeb0e5a42dd0c949d863f467`, based on release producer
  `97c0fbcbedb8fe8f8395115647684dfde75d67a3`.
- `audit/2026-11-14/repeat-fresh-reader` →
  `06b4453824d22ae8ffd617159ee4f32750a34aff`, based on producer
  `2c8676842feab053fa7855d4cb3393bdea26ed4a`; it also contains the synthetic
  example first run at `186cea4b37807488f10d81651c62aa9823585c80`.

`code/` holds patches, original plans and commands. The examples and
`layout-audit` diagnostic are experiment-only. They reuse the Rust sample
reader and comparison rule; the log-ratio helper gained visibility only.
Floating point is used for the continuous covariance/log calculations,
with diagnostic rounding confined to presentation.

The input manifests are checked from the data repository root. The local
SHA-256 and BLAKE3 manifests cover this folder, excluding themselves. Raw
samples and failures are preserved, with no executable binaries.

# Paired-copy bootstrap coverage: fixed synthetic boundary case

Predeclared in [the protocol](../../paired-ci-plan.md), implemented by
examples/paired_ci_control.rs. It calls the shared clocks bootstrap directly,
with no second bootstrap, timing or samples-reader implementation. Four
sets of4000 synthetic trials use integer values1..99 (known median50),
SplitMix64 seed0xd3a0c1a020261001 and exactly duplicated copies per visit.
Manifest and unrounded counts/width sums are retained.

| Independent visits | Grouped intervals containing50 | Flattened-copy intervals containing50 |
| --- | ---: | ---: |
| 6 | 3691/4000 | 3159/4000 |
| 12 | 3754/4000 | 3282/4000 |
| 24 | 3728/4000 | 3316/4000 |
| 48 | 3760/4000 | 3393/4000 |

Flattening the correlated copies yields narrower intervals and less coverage
in every predeclared condition. This quantifies the already acknowledged
shared-copy issue for a simple one-speed model. The grouped control uses one
value per visit, which is suitable here because both copies are identical.
It is not a proposed general implementation for mixed-speed pairs.

The grouped control itself contains the truth less often than nominal95%
in these finite synthetic trials. Grouping alone therefore should not be
called a fully calibrated95% guarantee; assess finite-sample coverage and
bootstrap discretization separately. These observations do not establish
coverage for real hardware workloads or a universal confidence level.

A general remedy must preserve visit identity while sorting/splitting;
serial dependence across visits and uncertainty from selecting a speed split
remain separate. Resamples can also lack a rare speed. Agree the estimand,
identity of comparable speeds and treatment of such resamples before code.
John's review is requested through bench-hashes issue#4. Existing bands stay
excluded from acceptance arguments; frozen workloads remain unchanged.

# Deterministic controls of the actual regression-gate decisions

`before.json` exercises BLAKE3 reader branch08d9dc3; `after.json` exercises
the candidate load guard. Each records the gate source SHA-256, every process
request, stdout/stderr and exit. Builds and process execution are replaced;
actual parse/pairs/judge/compare and shared speeds execute unchanged.
These are decision-contract checks, separate from runtime rate calibration.

| Control | Original exit | Guard exit |
|---|---:|---:|
| quiet null | 0 | 0 |
| quiet solo +20% continuous | 1 | 1 |
| quiet shared +20% continuous | 0, reported | 0, reported |
| control moves | 2 | 2 |
| busy | 2 | 2 |
| missing load initially | 0 | 2 |
| missing load in confirmation | 1 | 2 |
| broad-context-only solo cost | 0 | 0 |
| after-gap slow speed alone +50% | 0 | 0 |

The context control keeps a neighbor open with a consistent improvement during
four initial pairs. The target is20% slower whenever that neighbor is selected.
Confirmation selects the target alone, its cost disappears, and the original
gate dismisses the initial cost after one confirmation pair. This is source-
verified behavior with a deterministic reproduction, not a measured claim
about a specific carryover mechanism. The gate docstring's claim that narrowing
“decides exactly as measuring every point in every pair” needs a premise:
changing the selected workload must leave each retained cell's estimand fixed.
The runtime context-sensitivity evidence challenges that premise.

After-gap slow shifts are reported without judgment by explicit policy. That
policy remains unchanged, as do margins, frozen workloads and speed rules.

```sh
PYTHONDONTWRITEBYTECODE=1 python3 tools/audit-regression-gate.py --gate /path/to/BLAKE3/tools/perf_regress.py
```

The load guard addresses unknown observation with exit2. Timing policy for
obtaining sufficiently long narrowed processes remains a separate design
question. Waiting outside a measurement would observe a different load period;
it would also change the process history, so this patch adds no padding/retry.

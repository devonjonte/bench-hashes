# Near-margin sensitivity: readiness target failed

**NO-GO remains.** This predeclared diagnostic supplies an actionable resolution
limit; it is separate from the acceptance campaign. Plan:
[`audit/near-margin-plan.md`](../../near-margin-plan.md), committed before
measurement as **e0559ca**. Hashing6afda66, clocks/reader/actual gate3a240a0,
benchmark build base663b035, native Intel i7-12700K Linux, default affinity.

## Controlled work and separate calibration

The existing direct caller now observes100+k hashes per block of100 logical
requests through one loop and the plain hash function. k=0/3/6/100; SHA-256 stays
at0. Every digest is observed. Fixed independent preflight anchors and
completion counts include calibration; ns/logical-requests retain their raw
numerators/denominators. New accounting contract2 and its checker travel together;
old factor controls use their recorded source/tools at3d448f8.

Forty separate calibration processes (null/2x anchors and four interleaved ABBA
blocks per near-margin level) passed work accounting, quiet load and complete
**recorded-start** coverage. Timing effects met the plan's fixed +/-10% tolerance:

| Input | 3 extra hashes/100: median q5 shift | 6 extra hashes/100: median q5 shift |
|---|---:|---:|
| 64 B | 2.964% | 5.982% |
| 2048 B | 2.991% | 6.009% |
| 102400 B | 2.982% | 6.014% |

These are measured calibration estimates. Known extra hashing work does not
establish an exact latency effect. The ~3% estimates lie slightly below the
strict3% trigger; the result cannot be described as failure to detect an exactly
known3.000% latency shift. It does establish failure of the predeclared near3%
readiness target and shows why resolving changes at the trigger boundary needs
separate validation. No extra counts or thresholds were tuned after calibration.

## Held-out actual gate

The caller replaces builds/process plumbing only; actual parse/pairs/judge/
compare, fixed context, strict margins, early stop and confirmation execute.
Judgment recording wraps the original function and all subject judgments replay
identically through the original gate. Each comparison has a120-second
whole-process-group deadline; every outcome is retained.

| Control | Correct confirmations / attempts |
|---|---:|
| Four whole nulls | 4/4 exit0; zero subject faster/slower flags |
| 2x work | Three sizes confirmed, exit1 |
| ~3%, 64 B | 0/8 |
| ~3%, 2048 B | 0/8 |
| ~3%, 102400 B | 0/8 |
| ~6%, 64 B | 8/8 |
| ~6%, 2048 B | 8/8 |
| ~6%, 102400 B | **4/8** |
| Short null (8 batches) | exit2 |
| Externally busy null (two PyPy workers) | exit2 |

All eight6% whole comparisons exit1, because at least one smaller size holds.
**Counting those exits as8/8 success at every size would conceal four bulk
misses.** Per-cell confirmation is essential. Two3% comparisons initially flag
a size and then fail confirmation; all eight ultimately return0.

Regular pilot processes have quiet load and zero uncovered recorded starts.
Busy/short controls remain failed observations; they were preserved and neither
padded nor retried. The v4 limitation remains: recorded-start coverage cannot
certify full timed-interval coverage.

### What the bulk misses show

At6%, every missed102400 B cell has one pair below the3% trigger. In four cases
that pair's q5 shift is approximately **-1.41%, -1.19%, -1.40%, -1.45%**; the
other pairs mostly show the calibrated6% effect (occasionally8–16%). The actual
gate requires every initial and every confirmation pair beyond the trigger, so
one such pair removes the finding. All submitted/completed work checks pass;
load is quiet and the control earns no changed-code flag.

This establishes a decision-path sensitivity failure under these conditions.
It leaves scheduler, frequency, layout and state-selection causes open; Linux
supplies no thread-cycle/core-kind evidence here. We claim no specific cause,
and preserve both the measured deviations and the resulting missed findings.

## Evidence and reproducibility

- **250 processes**:40 calibration +210 across23 held-out whole comparisons.
- All **1500 cells /190,560 batches** pass exact raw ns/work and actual completed
  hashing counts including calibration, with failed busy/short controls included.
- Sixteen bench Python tests pass, explicitly executing all four test scripts
  (4 report,2 metric,4 trace,6 work-accounting). The generic unittest discovery
  command skipped hyphenated filenames and ran zero tests; its log is retained
  as a command-control failure, rather than counted as a passing suite.
  Work-accounting controls include raw
  corruption with unchanged ratio, changed calibration, wrong declared effect,
  wrong accounting version and duplicate trace.
- `summary.json` retains every exact rational pair ratio, recorded judgment,
  per-process coverage/accounting result and per-size detection count.
- Source snapshots, build logs, executable/source hashes and all raw caller
  outputs/counters remain available. Executable and build trees stay locally in
  `/home/agent/bench-hashes-validation/trust-audit/near-margin/`.

Recompute with the matching current checker and shared gate:

```sh
pypy3 tools/analyze-near-margin.py --gate /path/to/coverage-fork/tools/perf_regress.py --calibration audit/results/near-margin/calibration-data --pilot audit/results/near-margin/pilot-data
```

## Next decision

The3% readiness target fails. A blanket6% scope also fails at102400 B. Small
hot direct callers at6% are promising candidates for a **new predeclared narrow
scope**, subject to full interval/provenance closure, broader control coverage,
independent review and fresh acceptance counts. This pilot grants no GO and
cannot be retroactively relabeled as an acceptance campaign.

Before adding detector complexity, review the benefit/cost of the current
all-pairs rule and its promised effect resolution with John. Retain the existing
thresholds and data. Any replacement rule or narrower scope needs its own frozen
plan and fresh null/positive/context controls; retrospective reclassification of
these records is diagnostic only.

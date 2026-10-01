# Fixed-context comparison: current-source controls

This is a diagnostic pilot toward the [go/no-go procedure](../../reliability-assessment.md),
not its acceptance campaign. Production hashing, clocks, frozen calls/axes,
speed splitting, margins and quantile judgments remain unchanged.

## Candidate and deterministic tests

The candidate follows fork **6afda66**, including John's removal of the pooled
slow-speed verdict and after-gap points. It incorporates the raw reader and
missing-process-load guard pending in PRs3/5. Its one comparison mechanism
keeps the same selected points in every pair and confirmation, while stopping
when no cell can still flag a change. It replaces adaptive point narrowing;
it introduces no second statistic, padding, sleeps or favorable-result retries.

Six actual-code contract tests replace only builds/process execution. The
upstream version fails four (preserved in `context-before.stderr.txt`):

- A target cost present only beside an unchanged neighbor disappears when the
  neighbor is dropped between initial pairs; upstream passes, fixed context holds.
- A neighbor kept open initially is dropped in confirmation; upstream passes,
  fixed-context confirmation still sees and holds the target's cost.
- Unknown initial/confirmation load supplies a verdict upstream; the guard abstains.

Null and busy controls retain their decisions. The final fork suite has **17
passing reader/gate/context tests**, including recorded-start coverage; the
shared speed rule's **13 vectors agree**. The deterministic costs are fixtures,
not measured hashes. The following runtime controls provide separate evidence.

## Four live benchmark null checks

`plan.json` predeclares adaptive/fixed/fixed/adaptive, default affinity,
24 rounds, the current14 nonstop points, and180s process-group deadlines.
Both labels use the exact same new executable, bench **663b035** / hashing
**6afda66**, clocks from the candidate tree unchanged from6afda66. The binary
hash and gate hashes are in the manifests; exact gate sources are retained.
PyPy3.9 /7.3.15 runs all drivers/checks.

| Check | Gate exit | Processes | Processes without windows | Selected context |
|---|---:|---:|---:|---|
| adaptive1 | 0 | 4 | 0 |14 then8 points |
| fixed1 | 0 | 8 | 0 |14 points throughout |
| fixed2 | 0 | 8 | 0 |14 points throughout |
| adaptive2 | 0 | 12 | 8 |14→6→2→1; narrow confirmation dismisses an initial flag |

All32 reports pass the shared checker. Every fixed process has68 sampled cells
and four quiet load windows. Fixed checks take about36s versus16s/12s for the
adaptive checks: preserving context spends measurement time. This pilot shows
no fixed-context false flag in two checks; it cannot establish a low error rate.
It contains no independent rebuild control or new benchmark clock trace.

## Real observed-work gate controls

The existing direct caller now takes exactly
`work_control SUBJECT_FACTOR BATCHES CONTROL_FACTOR`. Historical two-argument
stages remain tied to their old source commits. This stage keeps SHA-256 at
one observed hash per request and changes only the BLAKE3 subject to one/two.
The caller preflights fixed independent anchors, black-boxes every digest,
counts completed hashes including calibration, and measures through clocks.
Inputs remain byte i=i%251 at64/2048/102400 bytes;128 batches of2ms per cell.

`work-plan.json` predeclares one null and one doubled-work check,120s group
supervision each. The driver substitutes this explicitly named
`PositiveWorkControl` caller for benchmark process execution; it executes the
actual parse/pairs/judge/compare with a fixed three-size context. No frozen
queue or producer path is simulated, and no near-margin sensitivity is claimed.

- Null: **exit0**, two processes.
- Doubled BLAKE3 work, unchanged control: **exit1**, all three solo cells held
  through four initial and four confirmation pairs (16 processes).
- Median q5 ratios:64 B **1.994 then1.992**,2048 B **2.002 then2.000**,
  102400 B **2.000 then1.999**. Shared-rule speed summaries remain in stdout.
- All18 processes have quiet windows; all108 cells /13,824 batches pass exact
  raw ns/work and completion checks. Four checker tests include deliberately
  changed calibration counts and ratio-preserving raw-accounting corruption.

This extends the earlier2x caller control through the actual decision path.
It validates neither3% sensitivity nor queued/shared behavior.

## Important remaining load-coverage blocker

**Some load observation is not complete sample coverage.** The shared reader's
new diagnostic counts recorded starts outside all recorded windows. Fixed1
has **1,781/19,584** such starts, fixed2 **1,392/19,584**; the work null has
**364/1,536**, work positive **3,067/12,288**. `summary.json` preserves each
process's counts and points. All displayed windows can be quiet while these
samples have no corresponding observation. Millisecond starts also do not
certify coverage of an entire timed interval.

The candidate guard rejects processes with zero windows; it does **not** yet
reject every uncovered sample. The shared clocks final-window minimum can
leave a short final tail uncovered. Complete coverage/insufficient-duration
semantics require a shared-rule remedy and review; simply closing arbitrarily
short windows would weaken the OS-counter resolution premise. We claim the
focused context/empty-window improvement, not that the load blocker is closed.
**Reliance remains NO-GO.** All prior failed controls and source-scoped results
remain available; this pilot does not replace them.

## Reproduce

Use a fresh output directory and external whole-process-group supervision.
The manifests record source/artifact identities; new builds receive new hashes.

```sh
PYTHONDONTWRITEBYTECODE=1 pypy3 /path/to/run-bounded.py 180 /scratch/null-log pypy3 tools/run-gate-null.py --gate /path/to/BLAKE3/tools/perf_regress.py --exe /path/to/bench-hashes --output /scratch/null-data
PYTHONDONTWRITEBYTECODE=1 pypy3 /path/to/run-bounded.py 120 /scratch/work-log pypy3 tools/run-gate-work-control.py --gate /path/to/BLAKE3/tools/perf_regress.py --exe /path/to/work_control --new-factor 2 --output /scratch/work-data
PYTHONDONTWRITEBYTECODE=1 pypy3 tools/check-work-control.py /scratch/work-data/run-01 --reader /path/to/BLAKE3/tools/samples.py
```

The current-caller binary was built in a scratch copy of bench663b035 with
this branch's diagnostic example/fixture, patched to fork6afda66 and its clocks.
Its example source hash is in `work-plan.json`; it is a separate diagnostic,
not the frozen benchmark artifact. Local originals and build/test logs remain
under `/home/agent/bench-hashes-validation/trust-audit/fixed-context/`.

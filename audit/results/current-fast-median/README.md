# Current Rust fast-median detector: fresh x86 calibration and pilot

**NO-GO remains; hashing optimization stays paused.** The current detector
confirms all selected small-caller near-6% comparisons in this pilot.
Its bulk response misses six of eight comparisons, and near-3% readiness
remains unsupported. These are diagnostic counts, separate from acceptance.

## Source and scope

Plan [current-fast-median-plan.md](../../current-fast-median-plan.md) and
collector were committed as **7ea5a13 before measurements**. Separate calibration
and held-out pilot use actual Rust `regress` and `compare` from benchmark
**67f5300**, rebuilt against current hashing/clocks **f82d46c**. This includes
the independently tested busy-tail safeguard in BLAKE3 PR #8. John had posted
no newer reply/review at the authenticated 00:59:53 UTC check; upstream
candidates remained bench67f5300/forkd31a46c. PR #8 remains pending.

At the final 01:23 UTC refresh, John had advanced bench to **b9dfa12** (lock pin
only) and fork candidate/servil to **b132f8c** (documentation only since d31a46c).
The detector/hashing/clocks implementation therefore remains source-identical
to the measured upstream code, plus our declared local busy-tail safeguard.
His new notes report VM8/8 and Mac7/7 identical-code checks without holds;
planted~9.5% short-cell changes held5/5 VM and3/3 Mac; planted~3.8–4.6% held3/4
Mac while VM0/5 abstained on a moving control. These are maintainer-reported,
selected-cell controls; they complement this pilot without supplying independent
bulk or full-production sensitivity. `upstream-postpilot.diff` preserves them.
Promotion supplies no GO decision for our scope.

The exact v2 known-work caller is rebuilt with current clocks, sha2 0.11.0 and
current hashing. Each 100 logical requests performs 100+k observed hashes
through the same loop, at 64/2048/102400 bytes. Fixed independent digest anchors
run outside timing. Extra work is known; its latency effect is estimated.
Python only collects, checks separate count/trace CSVs and summarizes Rust
comparison/verdict text. Rust alone decodes samples and computes speed rules.

Executable wrappers retain every raw output before `regress` deletes its
process directory. Direct-caller controls supply six solo cells, rather than
the fourteen requested production points; they cover servil st and SHA-256,
without claiming shared/servil mt coverage. Two additional identical-artifact
production checks exercise all fourteen production points. Default affinity
0–19; Linux thread cycles unavailable; measured wall times stay unscaled.

`source-manifest.json` identifies the artifacts and source snapshots. Local
originals, binaries and builds remain at
`/home/agent/bench-hashes-validation/trust-audit/current-fast-median/`.
Public records preserve all 266 processes, including failures and abstentions.

## Separate 40-process calibration

Ten fixed ABBA blocks: null, 2x, then four interleaved 3/6-extra blocks. Each
process has 128 batches per cell. Rust `compare` pools each block's old/new
samples; separate old-old and new-new comparisons expose repetition effects.
All 40 processes report quiet observed load. The predeclared median of the
four reported fast ratios per level has the following estimated timing shifts:

| Extra hashes/100 | 64 B | 2048 B | 102400 B |
|---|---:|---:|---:|
| 3 | +3.80% (fails calibration) | +3.00% (qualifies) | −3.05% (fails calibration) |
| 6 | +6.05% (qualifies) | +5.95% (qualifies) | +5.95% (qualifies) |

Qualification follows the committed ±10% tolerance on the *median*. Individual
blocks are substantially less stable: bulk at 3 extra ranges −4.1% to +8.3%;
at 6 extra −3.2% to +6.0%. The median criterion does not establish a stable
exact latency intervention. No failed block was replaced or selected away.
The strict gate compares rounded integer-permille ratios: a reported 1.030
is at its boundary and does not establish an exactly known above-margin effect.

## Held-out actual Rust detector: 23 direct-caller checks

| Control | Whole checks | Confirmed 64 B | Confirmed 2048 B | Confirmed 102400 B |
|---|---:|---:|---:|---:|
| Null | 4 | 0 | 0 | 0 |
| 2x work | 1 | 1 | 1 | 1 |
| 3 extra/100 | 8 | 0 | 0 | 0 |
| 6 extra/100 | 8 | 8 | 8 | 2 |

All four nulls exit0 without subject faster/slower calls. All eight 6-extra
whole checks exit1; this conceals six bulk misses if counted as per-size
success. Near-3% whole checks exit0; one ran a confirmation that removed its
initial findings. None gives a held per-size verdict. Unqualified 3-extra
sizes remain descriptive. No speed threshold or confirmation rule changed.

The bulk 6-extra misses (checks7,9,15,17,19,21) have below-trigger pair ratios:
respectively 0.985, 1.005/0.984/1.003/0.987, 0.985, 0.985, 0.984/0.987,
and 0.985/0.982. The other small cells keep confirmations running through
eight pairs, making these missing bulk responses visible. The two held bulk
cases have larger shifts than calibration: check11 +14.0% then +14.0%;
check13 +6.3% then +13.5%. Scheduler/frequency/layout/speed selection causes
remain open; unavailable Linux cycles prevent a core/state attribution.
All pair ratios, pooled speed shares and exact gate stdout/stderr are retained.

Short null (8 batches) abstains exit2 after six unmeasured-load processes.
Busy null (two external CPU workers) abstains exit2 after two processes reporting
about 2.13 other CPUs. Every regular direct-caller process is observed quiet.
No retries, padding, sleeps, affinity changes or post-result rescue.

## Two production fourteen-point self-checks

Checks24/25 use the exact same benchmark artifact on both sides. Both exit0,
stop after three pairs/six processes, and report no held/shared/faster calls.
All twelve production processes report quiet load; all point requests and
benchmark reports/checks/samples are retained. These two checks test operational
behavior; they cannot establish an acceptably low false-decision probability
or sensitivity across production workloads.

## Exact accounting and verification

- 254 direct-caller processes (40 calibration +214 pilot), 1,524 cells,
  **190,752 measured batches**, with actual completion counts including the
  separate calibration batch checked exactly. Together with twelve production
  processes, 266 process records are preserved.
- Original current benchmark suite: **24 Rust tests pass**, including shared
  samples/readback/report and regression-point tests.
- A test-only extension to an isolated copy of the exact benchmark calls its
  production `read_samples`, then checks every retained raw `ns` and `units`
  against the trace: **190,752 exact matches** across all254 processes. A second
  test rejects doubled ns and units even though the normalized ratio is kept.
  Both tests pass; `retained_work_tests.rs` and logs are retained. This extension
  was built after collection and never changes the measured detector artifact.
- Six collector/analyzer contract tests pass (counts, calibration completion,
  duplicate batches, units, corruption and Rust-output decoding).
- Load metadata counts:258 quiet,2 busy,6 unmeasured. All sample decoding and
  pair comparisons use Rust. Metadata inspection uses the original load lines.
- Every calibration process and detector check has a whole-process-group
  deadline; the campaigns also have 1200-second external deadlines. Busy workers
  are in the supervised group and cleaned in finally. No process remains.
- The first test-only raw audit build failed because the benchmark requires its
  patched fork to enclose it. The corrected isolated worktree at f82d46c meets
  that contract and passes the same two tests on the same retained records.
  Both build logs are retained; no measurement was repeated.

## Additional shared-consumer finding

`short-compare.stdout.txt` demonstrates that current Rust `compare` prints
speed comparisons from the unmeasured-load short files, without qualifying
them as descriptive/unobserved. It warns for `busy` only; `regress` correctly
abstains on these same files. This is a reproduced presentation gap, separate
from the frozen detector results. No fix has been included in these measurements.

## Decision and next work

Blanket near-6% and near-3% pilot readiness fail. The small-caller near-6%
response motivates a separately declared narrow assessment, while production
sensitivity and the bulk intervention's stability still need fresh controls.
Independent reproduction/reviewer assessment and finite acceptance remain
outstanding. Historical q5 counts remain scoped to their own sources; these
new counts describe the current fast-median rule. John is asked to assess the
strict all-pairs mechanism's measured benefit/cost and the per-size scope before
new statistical machinery or expensive acceptance campaigns.

Reproduce collection with `tools/run-current-rust-controls.py`; rebuild the
caller from `audit/rust-work-control/` with paths adjusted to the declared fork
checkout. Summarize retained Rust outputs using
`pypy3 tools/analyze-current-rust-controls.py RECORD_ROOT`.

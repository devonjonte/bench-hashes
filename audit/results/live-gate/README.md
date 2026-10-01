# Actual adaptive gate: exact-artifact null pilot

All four checks use executable SHA-256
`6d032dc2ffe48c3027a8fc9cc9ed41ad1e2cbbdc5b098d8dbbee9ab3677860ae`
on both sides (bench547e82e / hashing8825450 / shared clocks unchanged from
8825450). Inherited default affinity on i7-12700K/Linux; no thread-cycle
counts are available here. The original gate is08d9dc3's tool. The patch
changes the missing-load guard and retains the original statistics.

The diagnostic driver replaces builds with the selected artifact and keeps
temporary directories. The gate's original run/parse/pairs/judge/compare execute
unchanged, using its35 frozen points and24 rounds. Every narrowed and
confirmation process remains. Original stderr/stdout suppression inside run
is unchanged; load/provenance and consistency records remain in each samples/
report/checks file. Each process's report passes the shared-rule checker.
These runs have no clock trace and establish no new trace-accounting verdict.

| Check | Exit | Processes | Without load windows | Outcome |
|---|---:|---:|---:|---|
| original1 | 0 | 16 | 10 | initial costs dismissed in confirmation |
| original2 | 1 | 16 | 10 | confirmed solo hold on the identical artifact |
| patched1 | 2 | 8 | 4 | no verdict: missing load initially |
| patched2 | 2 | 10 | 2 | no verdict: missing load in confirmation |

The plan records the sequential order,180s process-group deadline per check,
and the first check's status as an exploratory pilot preceding the remaining
three-run declaration. All attempts are retained; none is rerun to improve its
outcome. Local original files/logs remain under
`/home/agent/bench-hashes-validation/trust-audit/live-gate/`.

## Held cell and scope

Original2 holds `blake3-servil-mt|solo|ContinuousMessages|64 B`.
The output shows **+3.2% then -2.8%** median5th-percentile ratios. Neither
stage's5th-percentile ratios all exceed the margin: the pooled slow-speed
rule supplies both flags (**+12.0% initially, +52.9% in confirmation**).
`summary.json` separates stages, pair ratios, shared speed summaries and
slow-rule direction. The subsets called slow change between stages; physical
state identity is unestablished. The combined output
reports fast about1.03, slow about1.20; combining stages hides their contexts.
The gate reports the generic5th-percentile explanation even for a slow-rule
hold; explanation fidelity needs a focused follow-up.

This is an actual identical-artifact held verdict, rather than merely crossing
a numeric margin. Ten processes lacked load windows; a quiet label on the
longer processes supplies no observation for the short ones. Thus the result
shows a false code-attribution/decision risk with missing-load policy as one
contributor left uncontrolled, not a calibrated false-positive rate on fully
observed quiet checks. Neither artifact drift nor a source optimization can
explain the difference. Process/history/topology causes remain open.

The guard prevents a verdict when any process lacks a window. Its abstentions
show that the current narrowing frequently lacks usable coverage. It leaves
pooled slow-speed behavior, state identity, carryover, power and unseen host
state unresolved. The patch adds no retries, sleeps, point expansion or timing
changes to manufacture a verdict.

## Reproduce under bounded supervision

Use the retained artifact, or build a clean equivalent and explicitly record
its distinct hash. The script requires external process-group supervision.
The command below uses the local supervisor; other machines use an equivalent
supervisor with whole-process-group termination.

```sh
PYTHONDONTWRITEBYTECODE=1 python3 /path/to/run-bounded.py 180 /scratch/gate-log python3 tools/run-gate-null.py --gate /path/to/BLAKE3/tools/perf_regress.py --exe /path/to/bench-hashes --output /scratch/new-gate-evidence
```

The output directory must be new. Driver/gate execution controls no clocks;
the benchmark uses its embedded clocks for all measurements and load windows.
Hardware and runtime variation make the exact verdict non-deterministic.

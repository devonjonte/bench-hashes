# Exact-artifact null controls: protocol fixed before execution

T6 of the measurement-trust ledger. Hypothesis: changes reported between
repeat processes of one exact executable characterize attribution failures
and state sensitivity at the instrument's decision margins. The code cannot
explain a label-assigned old/new difference when both labels run that same
artifact. This does not make the user's observed variability unimportant.

## Fixed choices

- Instrument: this branch at fd6291d (measurement source matches ee3b85a).
- Hashing baseline: fork 8825450, before Devon's batching optimization.
- Clocks: explicitly patched from BLAKE3-trust/clocks, matching 8825450.
- Generic release build, one retained executable, SHA-256 in the manifest.
- Contenders: sha256, blake3-servil-st, blake3-servil-mt.
- Points: `64 B,4 KiB,idle 64 B,idle 4 KiB,continuous 1 KiB,continuous batch 16,continuous batch 4096,lent 1 MiB,lent pieces 64 MiB`.
- Explicit 24 rounds: complete participant designs for this roster.
- Trace all samples with existing --trace-clocks. Keep full raw/report/trace.
- Blocks: default affinity twice, P-only CPUs 0-15 once, one P CPU 0 once.
  Each block is old-1/new-1/new-2/old-2; labels select the same executable.
  Sixteen processes total. Affinity is applied before process/pool startup.
- 120-second process-group deadline per run; timeout or busy verdict is
  retained and invalidates that block's performance interpretation.

Use shared samples/speed rules and compare-runs.py, plus exact trace accounting.
Summarize each speed and share separately. Record ratios crossing the current
3% solo / 20% after-gap / 10% shared diagnostic margins. A crossing is a
null-control finding, not a confirmed production gate verdict: the gate's
adaptive confirmation policy needs its own test. Predeclared aggregate labels
and all individual repeats remain visible. Do not rerun a bad block until a
favorable one appears; any follow-up gets its own reason and record.

These runs test one workload set and one machine. Sixteen processes do not
establish a universal false-positive rate or cause. This stage supplies
controls for the audit, not a new optimization verdict. Direct actual-work
controls and neighbor/order sensitivity follow separately. Frozen workloads
and the published historical evidence remain intact.

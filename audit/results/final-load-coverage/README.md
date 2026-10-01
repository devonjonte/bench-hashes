# Final-load coverage controls (diagnostic; NO-GO remains)

Source-specific follow-up to [fixed-context pilots](../fixed-context/README.md).
Hashing remains fork **6afda66**, benchmark **663b035**, fixed-context gate
**8bb36d4**. Shared-load/reader/consumer candidate is **3a240a0** on
`devonjonte/BLAKE3:candidate/devon-final-load-coverage`.

## Changes and limits

A short final tail now extends the last sufficiently long **quiet** load window
from its original OS-counter baseline. No wait, padding, smaller standalone
window, different counter subtraction or busy threshold is introduced. An
existing busy window is not averaged away. A process below half a second of
observation still has no window; the description now correctly says insufficient
duration or unavailable counters, rather than asserting an unsupported platform.

The shared reader's `sample_starts_observed` requires a window and membership
of **every recorded millisecond start**. The actual gate abstains on missing
windows or uncovered starts in either initial or confirmation stages. AB, losses
and benchmark comparison consumers likewise withhold speed evidence. **This is
not certification of complete timed intervals:** v4 lacks their exact endpoints,
and millisecond rounding can conservatively reject a covered boundary start.

### A failed design control retained, not concealed

The first prototype kept extending the same old window on repeated snapshots.
A deterministic fixture with snapshots every 0.1 s hid a half-second, two-CPU
busy burst in that widening average. `frequent-before.*` retains exit **101**.
`prototype-source/load.rs` includes that failing test; `measured-load.rs` is the
exact earlier measured source, hash-verified against `prototype/plan.json`.

The corrected implementation **seals a window after one extension**, consuming
its original baseline. Later observations start a new interval once it reaches
the unchanged minimum duration. It passes the burst control without erasing
earlier busy findings. `sealed/` is a separate predeclared, rebuilt follow-up;
its results must not be attributed to the earlier prototype.

## Actual gate results

All runs use inherited default affinity and bounded whole-process groups.
No failed control was retried with delays or padded to acquire a window.

| Cohort | Control | Exit | Processes | Starts outside windows | Other observations |
|---|---|---:|---:|---:|---|
| Prototype | Same executable, null 1 | 0 | 4 | 0 | All windows quiet |
| Prototype | Same executable, null 2 | 0 | 4 | 0 | All windows quiet |
| Prototype | Direct caller, null | 0 | 2 | 0 | All windows quiet |
| Prototype | Twice completed BLAKE3 work | 1 | 16 | 0 | Three sizes held through confirmation |
| Prototype | Short direct caller | 2 | 2 | 384 | Both processes windowless |
| Prototype | Two external CPU workers | 2 | 2 | 371 | Both processes retain busy findings |
| Sealed | Same executable, null 1 | 0 | 6 | 0 | All windows quiet |
| Sealed | Same executable, null 2 | 0 | 8 | 0 | All windows quiet |
| Sealed | Direct caller, null | 0 | 2 | 0 | All windows quiet |
| Sealed | Twice completed BLAKE3 work | 1 | 16 | 0 | Three sizes held through confirmation |
| Sealed | Short direct caller | 2 | 2 | 384 | Both processes windowless |
| Sealed | Two external CPU workers | 2 | 2 | 368 | Both processes retain busy findings |

The external workers are untimed PyPy CPU loops, supervised in the parent's
process group and terminated in `finally`. The caller's **shared clocks** supply
all load measurements and classifications; the controller invents no timer or
load classifier. Busy tails can remain uncovered intentionally because averaging
must not erase the prior busy finding; either reason precludes a speed verdict.

A replay of historical `fixed-context/fixed-1` through the stronger actual gate
returns **2**, versus its original 0: quiet but incomplete windows no longer earn
a verdict. Replay substitutes retained files only for builds/process execution;
it is not a fresh measurement or reinterpretation of the historical source.

## Evidence and checks

- All **66 processes** retained here: 22 benchmark samples/reports and 44 direct
  caller samples, traces, completions and logs. These are **12 diagnostic
  comparisons across two instruments**, not 66 acceptance null comparisons.
- All **22 reports** recompute through the shared rules/reader. All **264 direct
  cells / 31,488 batches** pass unreduced raw ns/work and completed-work checks,
  including calibration and failed short/busy controls.
- **21 clocks tests passed, 1 reading-cost test ignored**; nine added counter
  fixtures cover duration, original baseline, new tail load, dilution rejection,
  earlier findings, repeated snapshots, burst detection, separate long tails
  and unchanged tick duration. **19 Python gate/reader tests** and **13 shared
  speed vectors** pass.
- Final bounded standard diagnostic perf check returns 0 after its initial flag
  is not confirmed. Both sides use the current instrument; this is operational
  compliance, **not** instrument-overhead or reliability validation. Logs retained.
- The first report-check invocation supplied a directory instead of required
  `speeds.py`; its command error is preserved as `validation-command-error.*`.
  Corrected validation reads the identical records, without new measurements.
- `build-provenance.json`, both `plan.json` files, manifests and source snapshots
  distinguish actual instrument, artifacts, hashing source and gate policy.
  Executables, complete generated graphs and build trees remain locally under
  `/home/agent/bench-hashes-validation/trust-audit/final-load-coverage/`.

Recheck a public benchmark record with:

```sh
pypy3 tools/check-report.py --rules /path/to/coverage-fork/tools/speeds.py \
  audit/results/final-load-coverage/sealed/null-1/run-01
pypy3 tools/check-work-control.py --reader /path/to/coverage-fork/tools/samples.py \
  audit/results/final-load-coverage/sealed/work-positive/run-01
pypy3 tools/replay-fixed-gate-record.py --gate /path/to/coverage-fork/tools/perf_regress.py \
  --record audit/results/fixed-context/fixed-1
```

**NO-GO remains.** Full interval coverage, independently calibrated near-margin
positive controls, uncertainty/consistency/label/provenance closure, independent
review/reproduction and the fresh finite acceptance campaign remain outstanding.
The 2x direct-caller result does not establish 3% sensitivity or queued/shared
work accounting. No hashing optimization or broad batch expansion follows from
these diagnostic passes.

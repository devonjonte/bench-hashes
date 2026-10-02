# Current Rust gate: busy-tail safeguard

Baseline fork candidate **d31a46c**, benchmark candidate **67f5300**. John's
T1–T8 response and Rust fast-median regression redesign are recorded in
[the review ledger](../../measurement-trust.md). Historical fifth-percentile
sensitivity results retain their original source scope.

## Reproduced load defect

The final-tail implementation introduced in3a29cb8 replaces the last window
with its original baseline through the final reading, including when the old
window is already busy. A quiet tail can therefore erase a busy finding from
the windows returned to callers and from the final load description.

Fixed OS-counter fixtures exercise the actual production `between` and final
join transition:

- At0 s: cumulative other busy ticks0; at1 s:110 ticks (1.10 CPUs busy).
- At1.4 s: still110 ticks; the last0.4 s carries no additional other work.
- The old1-second window is busy; its replacement averages **785 milli-CPUs**
  over1.4 s, so the final description becomes quiet.
- The same counter shape for Linux steal time erases the hypervisor finding.

The two regression tests fail before the safeguard (exit101, logs and exact
patch retained). Tests inject counter readings, not synthetic timing outcomes.
The real `windows()` join body was extracted unchanged for this deterministic
control; the fixtures supply neither their own counter rule nor threshold.

## Focused correction

Candidate **f82d46c**, `devonjonte/BLAKE3:candidate/devon-current-validation`,
keeps an already-busy last window intact. A busy run already supplies no speed
verdict, so its short tail needs no weaker counter interval. Quiet windows still
extend once; a new busy tail still changes a quiet window to busy. Existing
minimum durations, counters, thresholds, hashing and statistics are unchanged.

- Four focused fixtures cover other-load preservation, steal preservation,
  quiet extension and newly busy tails.
- **16 clocks tests passed,1 reading-cost test ignored**.
- **24 current benchmark Rust tests passed**, including samples-to-report
  readback, current regression-point names, API labels, scheduling and digest
  observation. These run against the current instrument in the same scratch
  build, without importing historical Python readers.
- The bounded standard check through **the actual new Rust `regress` command**
  returns0 after two initial pairs across all14 points. Both sides use current
  clocks, so this is operational regression-check compliance, not instrument-
  overhead or reliability calibration. Logs retain build/source names.

All source-versioned evidence remains under
`/home/agent/bench-hashes-validation/trust-audit/current-rust-gate/` and beside
this README. Separate worktrees preserve the earlier pilots and candidates.

## Reliability status

**NO-GO remains.** The new fast-median detector still requires independent
null/positive/context calibration. The earlier Python q5 experiment does not
certify this detector. Native Mac validation, full interval coverage and the
fresh finite acceptance campaign remain outside this safeguard's evidence.

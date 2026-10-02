# Shared Linux counters: diagnostic stage, before further detector changes

**NO-GO remains.** Stage3 fixed-work calibration failed in both default and
CPU0 configurations, so its conditional gate pilot stayed unstarted. We now
seek an explanation for recurring~7% same-code shifts, with one shared counter
backend rather than further detector or statistics machinery.

## Instrument and safety

Isolated fork branch based on shared-clock helper4e4d413; hashing unchanged.
Optional Linux x86 backend opens two calling-thread perf groups using kernel
hybrid PMUs `cpu_core`/`cpu_atom`. Each group records cycles/instructions and
PMU running time; pinned groups have no multiplex scaling. Descriptors close
on thread exit and across exec. Unsupported PMUs/permissions return unavailable
counts. Darwin backend stays unchanged. Count reads remain outside timed wall
intervals, as before. Linux counts exclude kernel/hypervisor cycles/instructions;
running time includes kernel execution while scheduled. Their ratio estimates
MHz on long batches, with read overhead stated, not an exact short-call clock.
Wall time remains unscaled and remains the decision quantity.

Validate attribute layout/grouping with pure unit tests. Run one explicit live
clock-counter test under CPU0 and CPU16, separately, with shared clocks timing
four2ms busy-work batches. Require positive cycles/instructions/time and correct
PMU kind for declared affinity. Unsupported/failed cases remain in logs, with
source identity; fix implementation defects separately and preserve failed tests.
Measure read cost through shared clocks only. Required bounded standard perf
check before code commit; it compares current instrument on both sides and
is operational compliance, not an overhead/reliability proof. Native Mac untested.

## Fresh diagnostic caller/control cohort

After validated backend commit/build, rebuild same v3 fixed-work caller against
it, recording actual counter availability and input address mod64 in separate
accounting metadata. This is caller accounting contractv4. Same byte pattern,
CLI,100+k loop,fixed500/30/2 blocks and128batches/onewarm batch. No input alignment
forcing, new state filters, sleeps, padding, timers or sample parsers. Current
Rust all-pairs detector/reader/speed splitter unchanged. v4 sample schema still
contains wall ns/units; cycles stay separate labelled trace counters.

Fresh32 processes/eightABBA blocks: defaultnull,CPU0null, then three repetitions
of k6default,k6CPU0. Every attempt retained; same-code repeats and block effects
computed by original Rust compare. Exact logical/completed work checks stay.
This cohort diagnoses state/frequency/alignment: it is not the gate acceptance
campaign. Report every wall/cycle/instruction/running-time record and alignment,
without claiming causal attribution from correlation alone. If counters are
unavailable, record that outcome and stop before more expensive measurements.

Counters and warm-up change the measurement context: treat this as a new source
and fresh evidence. A state explanation must lead to a separately declared
repair and matched acceptance controls; it cannot retroactively rescue earlier
failures. Existing agreement (null/detection/repeat/accounting/review requirements)
continues to govern reliance and the optimization prerequisite.

Each clock test/build/calprocess group bounded120s (build180); standardcheck240;
whole diagnostic campaign1800. No concurrent measurement or favorable retries.
Preserve before/after failed source, tests, artifacts, raw outputs and decisions.

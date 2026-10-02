# Selected alternate: same-capacity CPU topology and per-thread receipts

Stage1 checks all64quiet-null processes through production Rust reader/means.
Removing the first visit leaves target intervals as wide or wider: soloqueue64B
[−8.01,+10.33]% becomes[−8.89,+10.36]%;soloMT1MiB[−6.48,+10.28]% becomes
[−6.62,+10.71]%. Those costs persist beyond startup in this cohort. Caller PMU
receipts show soloqueue64B on P cores; caller P/E migration alone therefore
falls short of explaining that target. Worker/delivery placement stays open.
Every receipt independently matches trace ns/work to the raw reader.

The declared alternate now uses an isolated diagnostic built from the existing
benchmark adapters and calibration, shared clocks and Work means. Hashing stays
pinned0cdbb94. Each fresh process measures one API: queue64 B, lent mt1MiB,
lent st1MiB, SHA2561MiB. The producer/digest adapter is the original implementation;
input generation stays outside scheduling. Preflight checks a published64 B
anchor and official/reference agreement.2048samples of the calibrated~1ms
batch supply long-series observations, with actual load qualification retained.
The single-cell/long-series context differs from the original mixed benchmark
and is explicitly diagnostic. A supported finding receives a mixed-context
confirmation within the time budget.

Conditions: separateP cores0/2/4/6;SMTsiblings0/1/2/3;E cores16–19. Each has
four available logical CPUs and therefore the same pool capacity. Physical
cores/core kind differ deliberately. Eight fresh processes per API/condition,
interleaved by repetition. Defaultfull20CPU context is a reference with its
separately reported pool capacity. Eight repeats per target/default; observer
controls add4unobserved runs per target atdefault/separateP.128processes total.
No artificial thread-budget API or copied producer is introduced.

Metadata snapshots before/after the entire series record raw /proc task
schedstat/stat/status/comm/affinity and kernel schedstats availability. Shared
clocks still supplies all sample times and caller PMUs. /proc values describe
execution conditions and provide no alternative speed computation. Scheduled
CPU time, kernel/user ticks, context-switch counts and faults can locate work;
ready-to-run counters receive qualification when the kernel disables schedstats.
Observer on/off controls preserve any first-batch/context perturbation.

Rust consumes raw times/work with the existing reader and means. Thread metadata
is reported alongside each run, keeping counter scope distinct from hashing
speed. A causal conclusion requires a reproducible topology effect and receipts
consistent with the changed execution mechanism; an association alone stays an
association. Perprocessdeadline120s,campaigndeadline1800s. No favorable retries.
Allattempts finish or stop at the outer18:35UTC two-hour deadline; the final
report states which explanation the evidence supports, or the bounded failure
to establish a controllable cause.

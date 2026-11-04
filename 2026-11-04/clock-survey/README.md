# clock_survey on the i7-12700K (Linux 7.0.0-42, clocksource tsc)

`cargo run --release -p clocks --example clock_survey 20` from bench-hashes
`candidate/devon-raw-clock` (aa603256), three runs: pinned to CPU 2 (a
P core), to CPU 16 (an E core), and unpinned (the scheduler chose an E
core). Each measures every clock the machine offers: read cost, smallest
step, slew against CLOCK_MONOTONIC_RAW over 20 s, and dispersion timing
a fixed 4 us call back to back and after a 1 ms sleep, beside the
thread's cycles and instructions (clocks::Counts, perf_event_open).

| claim | P core, CPU 2 |
|---|---|
| raw and slewed clocks cost alike | MONOTONIC 11.5 ns, MONOTONIC_RAW 11.7, REALTIME 11.6, Instant 13.6; steps 9-12 ns |
| the CPU counter is cheapest and finest | rdtscp 8.2 ns, step 7 ns |
| the slewed clocks drift at the daemon's rate | MONOTONIC, REALTIME, Instant: +5.7 ppm over 20 s; MONOTONIC's offset from the raw counter 597 ms since boot (8.4 h) |
| MONOTONIC_RAW and rdtscp are raw | -0.0 ppm |
| thread CPU time is a system call | 134 ns a read (288 on the E core); after a 1 ms pause its readings disperse most (p90/p10 1.17) |
| after a pause, cycles disperse like wall time, instructions not at all | wall clocks 1.02-1.03, cycles 1.024, instructions 1.000 (and 1.000 back to back); a counts read is 437 ns (791 on the E core) |

So: the raw clock costs nothing over the slewed one and removes a live
5.7 ppm drift (and a daemon's say); the CPU's counter would save 3 ns a
read at the price of its own calibration; thread CPU time is the wrong
instrument for short calls; instructions are deterministic and blind to
a pause's cost, cycles see it as wall time does.

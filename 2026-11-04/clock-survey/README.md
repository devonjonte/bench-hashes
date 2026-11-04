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

## Second pass: perf's counters, rdpmc, a 5 ms pause, P and E cores

`i7-cpu2-pcore.txt` (P core) and `i7-cpu16-ecore.txt` (E core), the
probe extended (bench `candidate/devon-raw-clock`, second commit): perf's
cycles, instructions, ref-cycles and task-clock, each by the `read`
system call and by `rdpmc` through the event's mmap page; a 5 ms pause
beside the 1 ms one; the core's clock (cycles over thread time) after
each pause.

| | P core (CPU 2) | E core (CPU 16) |
|---|---|---|
| a wall-clock read | 11-13 ns | 18-21 ns |
| a perf read by `read()` | 183 ns (one counter), 437 (Counts, two PMUs) | 336-342, 796 |
| **a perf read by `rdpmc`** | **10 ns** | **11 ns** |
| the fixed call: wall / cycles / instructions | 4188 ns / 20634 / 28719 | 8174 ns / 31068 / 28719 |
| the core's clock: back to back, after 1 ms, after 5 ms | 4504 MHz, 3890 (p10 3197), 3280 | 3486, 3373, 3370 |
| wall after 5 ms, p90/p10 (median shift) | 1.026-1.044 (+2.8%) | 1.009-1.015 (+1.4%) |
| user cycles by rdpmc after 5 ms, p90/p10 (median shift) | 1.005 (+0.4%) | 1.003 (+1.0%) |
| instructions after any pause | 1.000, 28719 every time | 1.000, 28719 |
| thread CPU time / task-clock after 1 ms | 1.178 / 1.108 | 1.109 / 1.070 |

So: instructions are the same count on both kinds of core and after any
pause; the P core's after-pause wall cost is its clock falling (the
cycles stay); the E core's clock barely moves, so wall and cycles agree
there; rdpmc makes a cycle count as cheap as a clock read; thread CPU
time and perf's task-clock are the worst-dispersed instruments after a
pause. Where a counter is read by the kernel's read(), the cost is 20-40
times a clock read.

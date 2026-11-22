# Many open messages fed in pieces: the Hashers' turn call beside the Pipeline (November 22, 2026)

**Question** (Zooko). A program hashes many messages at once, their pieces arriving interleaved, as a server takes uploads. If the incremental `Hasher` is not fast enough, does moving to `throughput::Pipeline` gain? bench-hashes measures this arrival pattern only through the Hashers (its turn cells).

**Verdict.** Yes, on both machines measured. For short messages the Pipeline takes about a thirteenth of the wall time and under a third of the CPU time. For long messages it takes about a third of the wall time for 1.2 to 1.4 times the CPU time. `update_each_multithreaded` gains nothing over `update_each` on either workload.

Medians of 31 rounds, two runs a machine, ns per byte: wall time (process CPU time).

**Short: 1,024 open messages of 1 KiB, in 256-byte pieces** (the bench's `1024 x 1 KiB` turn point)

| Machine | `update_each` | `update_each_multithreaded` | Pipeline |
|---|---|---|---|
| Ryzen 7 9700X, 16 CPUs | 0.944, 0.940 (0.94) | 0.944, 0.940 (0.94) | 0.070, 0.072 (0.26) |
| EPYC 9255, 48 CPUs | 1.178, 1.174 (1.18) | 1.178, 1.173 (1.18) | 0.099, 0.088 (0.34, 0.32) |

**Long: 64 open messages of 1 MiB, in 16 KiB pieces**

| Machine | `update_each` | `update_each_multithreaded` | Pipeline |
|---|---|---|---|
| Ryzen 7 9700X, 16 CPUs | 0.117, 0.117 (0.12) | 0.127, 0.128 (0.13) | 0.042, 0.043 (0.14) |
| EPYC 9255, 48 CPUs | 0.135, 0.135 (0.135) | 0.157, 0.153 (0.155) | 0.044, 0.044 (0.20, 0.18) |

**A second run: the Pipeline's caller that knows no lengths.** The Pipeline arm above knows its messages are short and gathers each before giving it whole. A caller that does not know lengths holds a Room per open message whatever its length, arrivals landing in it (`pipe-rooms`, commit `99d44b41`, folders `second/`). Medians of 31 rounds, two runs, ns per byte wall (CPU):

| Workload, machine | `update_each` | Pipeline, gathered | Pipeline, a Room a message |
|---|---|---|---|
| short, 9700X | 0.942, 0.946 (0.94) | 0.070, 0.069 (0.27) | 0.092, 0.091 (0.31) |
| short, EPYC 9255 | 1.185, 1.182 (1.18) | 0.089, 0.087 (0.35) | 0.110, 0.112 (0.42) |
| long, 9700X | 0.116, 0.116 (0.116) | 0.042, 0.042 (0.14) | 0.043, 0.043 (0.14) |
| long, EPYC 9255 | 0.134, 0.134 (0.134) | 0.043, 0.045 (0.20, 0.17) | 0.044, 0.045 (0.20, 0.17) |

A Room a message costs short messages 26% to 31% more wall time than gathering them into shared Rooms, and still takes a tenth of `update_each`'s time. For long messages the two are the same caller.

**What each arm does.** Every arm pays one copy per arriving piece, the read from the network. The Hasher arms read a turn's pieces into a receive buffer and make one call a turn, then `finalize_each`. A Pipeline takes a message in whole 64 KiB Rooms except its last commit. So for the short workload its caller gathers each message in a buffer of its own and copies it into a Room when the last piece is in (a second copy, counted). For the long workload each open message holds a Room, arrivals land in it, and it is committed when full: 64 open messages hold 4 MiB of Rooms.

**Scope.** A probe: one program (`turn_pipeline_probe.rs`, here), its own timer, arms in rotating order within each round, digests checked against the one-call hash. Two x86-64 machines, each alone under its lock. No Apple measurement: the Mac queue's `example` jobs take listed examples only. The Pipeline's digests arrive later as events, and its speed comes from the pool's threads, so a program beside other busy programs gets less.

**Commits.** BLAKE3-Servil 0.10.0 `2fd4ff6f643ef04f98f7a2e5f8ca0f096298827a` plus the example alone: `devonjonte/BLAKE3` `4cf12d7761da1590be176b584e03ab50ee7c568e`, and `99d44b41d52de0a8a2f9f87d13a309fd1094e570` for the second run (branch `experiment/devon-turn-pipeline-probe`, never to land). The source here is the second run's.

**Command.** Each machine's `run.sh`: build `--release --example turn_pipeline_probe` in `threads/`, run it with 31 rounds, twice.

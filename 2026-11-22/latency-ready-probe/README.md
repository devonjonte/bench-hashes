# What helpers kept awake would give a caller who cares for latency (November 22, 2026)

**Question** (Zooko). Take a caller who cares how long one hash takes more than how many hashes get through, and who will rewrite code and pay for speed. BLAKE3-Servil offers the `convenience` calls (tuned for a hash now and then) and the `throughput` calls (tuned for call after call). Is one of them already about as good as the library can do for this caller, or would a latency API beside them give major gains?

**Verdict.** Major gains exist, and they come from one mechanism: threads kept awake between calls. On six machines, with pool workers polling in place of parking and messages split from 32 KiB:

- **A message of 256 KiB takes 0.39 to 0.71 of today's best time back to back, and 0.20 to 0.71 after 5 ms asleep.** At 1 MiB the share is 0.43 to 0.91, at 4 MiB 0.50 to 1.00.
- **At 64 KiB the two Macs, the Xeon and the Zen 3 EPYC gain (0.57 to 0.82 back to back; 0.18 to 0.63 after 5 ms asleep); back to back the two Zen 5 machines do not** (1.01, 1.03).
- **On both Macs one helper kept awake keeps the calling thread itself fast after a rest**: a call on one thread after 5 ms asleep takes 0.23 to 0.31 of its time up to 64 KiB, the thread's clock reading about 4 GHz in place of 1.3 (M6) and 3.2 in place of 0.9 (M4). The Zen 3 EPYC shows 0.57 and the Ryzen 9700X 0.70 (with three awake); the EPYC 9255 shows none and the Xeon next to none.
- The 99th percentile fell with the median in every cell of the last table below.
- **A second finding, with nothing kept awake:** on the x86 machines a split from 256 KiB already gains with the workers asleep as they ship (the last section).

The price is unmeasured here: each helper kept awake is a core that spins. The tail under other programs' load is unmeasured too.

**Decision** (Zooko, the same evening, with the follow-up probes below before him). The library's API gets no notion of helpers kept awake: the gain did not seem worth a new concept to him. This verdict stands as a measurement of the option he declined. What a caller gets with nothing kept running is the subject of the follow-up probes below, which also correct one reading of the tables here.

## The probe

- **Library:** BLAKE3-Servil `next` at `5f8aaaa650bf9ec57320c850290f713c5a35b437` with one commit on it, `de1a3f00ce2b899a784a7260aff1879143f37d45` (branch `probe/latency-ready` of `servil-software-factory/BLAKE3`, never to land). The commit adds three knobs set at run time: how many pool workers poll for work in place of parking; the length from which `throughput::hash_multithreaded` goes to the pool (512 KiB as shipped); and, on the wide AVX-512 kernel, the bytes a participant (128 KiB as shipped). With workers kept awake a job is cut for them and its caller alone and wakes nobody.
- **Program:** `examples/host_lab.rs`, run as `host_lab latency 500`. It times with the servil projects' `clocks` crate (a copy of bench-hashes `7f2a0b21`'s): the raw wall clock, the calling thread's cycle counts, and the windows of other programs' load.
- **Settings:** "ships" (the library as shipped); "asleep" (the split at 32 KiB, 32 KiB a participant, workers parked as shipped); and the split at 32 KiB with 1, 3, 7 and all workers kept awake.
- **Cells:** a gap (none; other work, the bench's: about 1 MiB of other code and a walk of 128 MiB; 20 μs asleep; 5 ms asleep), a call (`convenience::hash` on the calling thread; `throughput::hash_multithreaded`), and a length (1 KiB to 4 MiB on one thread, 64 KiB to 4 MiB over the pool).
- **A visit** is the bench's sample after a gap: the same call first, untimed; the gap; the message copied into place, timed; the call, timed alone. Every round visits every cell of every setting once, settings and cells shuffled. 500 rounds.
- **Machines.** x86 through `bench-submit` (`job-x86.sh`), the process confined to the CPUs of CPU 0's last-level cache so that the pool has one place: the Ryzen 7 9700X (all 8 cores, 16 CPUs), the EPYC 9255 (6 cores, 12 CPUs), one Xeon Gold 6330 (28 cores, 56 CPUs), the EPYC 7443P (6 cores, 12 CPUs). The Apple M6 (12 CPUs) and M4 (10 CPUs) through the Mac runner's `example` job (`job.json`).
- **Load.** No window of other programs' load read busy on any machine. One settle of 3,000 on the M4 did not complete within its 200 ms.
- **Limits.** One build and one run a machine. Settings alternate every few hundred milliseconds, so what helpers held awake for minutes do to the chip's heat and clock is outside this probe, as is their energy. The Macs' "3 awake" and "1 awake" settings cut a job for few threads, and a helper on a slower core then holds a large piece (256 KiB with 3 awake is slower than with 1 on the M6): a design would cut for that.

## Results

Every time is a median over the cell's 500 visits, in microseconds, of the message's write and the call together (the bench's definition of a call after a gap). "Today" is the faster of the two calls as the library ships.

**One message back to back: today's best call, then with helpers kept awake (how many), and the share of today's time.**

| Machine | 64 KiB | 256 KiB | 1 MiB | 4 MiB |
|---|---|---|---|---|
| Apple M6 | 13.7 → 8.29 (all), ×0.61 | 44.7 → 17.2 (all), ×0.39 | 73.2 → 51.5 (all), ×0.70 | 233.2 → 206.2 (all), ×0.88 |
| Apple M4 | 15.2 → 10.1 (all), ×0.67 | 49.5 → 24.0 (all), ×0.49 | 88.5 → 72.3 (all), ×0.82 | 286.8 → 274.1 (7), ×0.96 |
| Ryzen 9700X | 4.23 → 4.29 (3), ×1.01 | 16.3 → 11.1 (7), ×0.68 | 46.9 → 35.2 (7), ×0.75 | 161.0 → 128.0 (7), ×0.80 |
| EPYC 9255 | 5.20 → 5.34 (3), ×1.03 | 19.8 → 14.1 (3), ×0.71 | 47.8 → 42.6 (3), ×0.89 | 165.0 → 153.4 (3), ×0.93 |
| Xeon Gold 6330 | 19.4 → 16.0 (1), ×0.82 | 77.2 → 42.5 (7), ×0.55 | 161.5 → 146.2 (all), ×0.91 | 523.4 → 523.6 (all), ×1.00 |
| EPYC 7443P | 14.1 → 8.02 (all), ×0.57 | 57.8 → 24.7 (all), ×0.43 | 100.7 → 89.5 (3), ×0.89 | 328.6 → 311.9 (3), ×0.95 |

**One message after other work: today's best call, then with helpers kept awake (how many), and the share of today's time.**

| Machine | 64 KiB | 256 KiB | 1 MiB | 4 MiB |
|---|---|---|---|---|
| Apple M6 | 13.8 → 9.29 (all), ×0.67 | 46.1 → 18.7 (all), ×0.41 | 103.7 → 54.7 (all), ×0.53 | 270.1 → 219.4 (all), ×0.81 |
| Apple M4 | 17.0 → 12.6 (all), ×0.74 | 52.7 → 30.2 (all), ×0.57 | 127.9 → 78.6 (all), ×0.61 | 352.1 → 300.1 (7), ×0.85 |
| Ryzen 9700X | 6.20 → 5.42 (3), ×0.87 | 20.4 → 13.9 (7), ×0.68 | 49.1 → 39.5 (7), ×0.80 | 166.6 → 135.6 (7), ×0.81 |
| EPYC 9255 | 7.15 → 6.43 (3), ×0.90 | 24.3 → 15.9 (all), ×0.65 | 50.4 → 45.2 (3), ×0.90 | 168.2 → 156.7 (3), ×0.93 |
| Xeon Gold 6330 | 68.9 → 46.1 (1), ×0.67 | 121.0 → 75.2 (7), ×0.62 | 254.4 → 204.0 (all), ×0.80 | 687.9 → 647.8 (all), ×0.94 |
| EPYC 7443P | 16.4 → 9.82 (all), ×0.60 | 63.4 → 27.6 (all), ×0.44 | 112.2 → 99.0 (7), ×0.88 | 371.6 → 337.1 (3), ×0.91 |

**One message after 5 ms asleep: today's best call, then with helpers kept awake (how many), and the share of today's time.**

| Machine | 64 KiB | 256 KiB | 1 MiB | 4 MiB |
|---|---|---|---|---|
| Apple M6 | 38.5 → 8.71 (all), ×0.23 | 79.7 → 17.2 (all), ×0.22 | 127.6 → 54.4 (all), ×0.43 | 310.6 → 209.2 (all), ×0.67 |
| Apple M4 | 57.1 → 10.2 (3), ×0.18 | 98.8 → 24.9 (all), ×0.25 | 167.0 → 73.0 (all), ×0.44 | 411.0 → 277.0 (7), ×0.67 |
| Ryzen 9700X | 6.21 → 4.46 (3), ×0.72 | 23.9 → 11.8 (all), ×0.49 | 53.6 → 36.6 (3), ×0.68 | 182.1 → 133.8 (7), ×0.73 |
| EPYC 9255 | 5.39 → 5.47 (3), ×1.01 | 20.2 → 14.3 (3), ×0.71 | 48.3 → 43.2 (3), ×0.89 | 165.1 → 153.3 (3), ×0.93 |
| Xeon Gold 6330 | 69.1 → 43.7 (1), ×0.63 | 123.7 → 64.1 (7), ×0.52 | 220.9 → 181.2 (all), ×0.82 | 616.5 → 609.8 (all), ×0.99 |
| EPYC 7443P | 31.3 → 8.42 (all), ×0.27 | 127.4 → 25.5 (all), ×0.20 | 190.1 → 93.9 (7), ×0.49 | 649.2 → 326.3 (7), ×0.50 |

**One message on the calling thread (`convenience::hash`) after 5 ms asleep: as it ships, with one helper kept awake, with three; and the calling thread's clock in GHz, as it ships and with three awake.**

| Machine | 1 KiB | 16 KiB | 64 KiB | 1 MiB | clock |
|---|---|---|---|---|---|
| Apple M6 | 2.50 → 0.75 → 0.75 (×0.30) | 12.0 → 3.67 → 3.25 (×0.27) | 38.5 → 11.7 → 12.3 (×0.32) | 197.7 → 147.7 → 147.9 (×0.75) | 1.3 → 4.0 |
| Apple M4 | 3.87 → 0.92 → 0.92 (×0.24) | 19.5 → 4.50 → 4.54 (×0.23) | 57.1 → 14.5 → 14.7 (×0.26) | 221.9 → 165.8 → 166.2 (×0.75) | 0.9 → 3.2 |
| Ryzen 9700X | 1.58 → 1.65 → 1.10 (×0.70) | 2.40 → 2.42 → 1.68 (×0.70) | 6.21 → 6.37 → 4.39 (×0.71) | 104.5 → 105.1 → 73.2 (×0.70) | 3.8 → 5.0 |
| EPYC 9255 | 1.38 → 1.38 → 1.38 (×1.00) | 2.07 → 2.07 → 2.07 (×1.00) | 5.39 → 5.40 → 5.40 (×1.00) | 90.1 → 90.2 → 90.3 (×1.00) | 4.3 → 4.3 |
| Xeon Gold 6330 | 2.04 → 1.93 → 1.91 (×0.94) | 21.5 → 20.8 → 20.8 (×0.97) | 69.1 → 70.2 → 71.2 (×1.03) | 373.0 → 370.4 → 370.8 (×0.99) | 1.9 → 2.0 |
| EPYC 7443P | 2.33 → 1.34 → 1.34 (×0.58) | 8.39 → 4.80 → 4.81 (×0.57) | 31.3 → 18.0 → 18.0 (×0.57) | 529.6 → 301.4 → 300.8 (×0.57) | 1.9 → 3.3 |

**256 KiB over the pool, the median and [the 99th percentile]: as it ships, then under the best setting above.**

| Machine | back to back | after other work | after 5 ms asleep |
|---|---|---|---|
| Apple M6 | 44.7 [76.2] → 17.2 [38.2] | 46.2 [86.7] → 18.7 [45.3] | 79.8 [98.7] → 17.2 [27.4] |
| Apple M4 | 49.5 [62.6] → 24.0 [35.5] | 52.7 [71.4] → 30.2 [52.4] | 98.8 [138.9] → 24.9 [41.6] |
| Ryzen 9700X | 16.3 [28.1] → 11.1 [14.6] | 20.5 [23.3] → 13.9 [17.7] | 23.9 [28.5] → 11.8 [12.5] |
| EPYC 9255 | 19.8 [21.5] → 14.1 [15.7] | 24.3 [26.7] → 15.9 [18.2] | 20.2 [22.0] → 14.3 [15.7] |
| Xeon Gold 6330 | 77.3 [87.3] → 42.5 [63.0] | 121.5 [156.6] → 75.2 [93.1] | 124.1 [166.7] → 64.1 [82.5] |
| EPYC 7443P | 57.8 [156.4] → 24.7 [29.3] | 63.4 [86.1] → 27.6 [33.0] | 127.5 [167.6] → 25.5 [31.0] |

## Reading

- **Two effects add up.** Helpers that are awake take their pieces at once, where a parked worker arrives tens of microseconds later; so a split pays from a shorter message. And threads that stay busy keep the chip's clock up: on the Macs, the Ryzen and the Zen 3 EPYC the calling thread itself runs faster after a rest when a helper is awake. The second effect needs no pool: any busy thread of the program would do it.
- **The split with workers asleep** (the "asleep" setting: the split at 32 KiB, the workers parked as they ship; the write counted; today's best time taken as 1). At 256 KiB it takes 0.51 to 0.62 on the Zen 3 EPYC, 0.66 to 0.76 on the Xeon, 0.80 to 0.88 on the EPYC 9255 and 0.81 to 1.07 on the Ryzen 9700X. On the Macs it takes 0.81 to 0.86 back to back and 1.04 to 1.42 after other work or 5 ms asleep. At 64 KiB it loses back to back on every machine (1.05 to 1.71). At 1 MiB it changes nothing. So the shipped 512 KiB suits the Macs it was chosen on, and the x86 machines would gain today from a split at 256 KiB: a question for `bench-hashes check` on the bench's own 256 KiB cells.
- **The write matters.** After a split call the next write into the same buffer is slower (Ryzen 9700X, 256 KiB: 2.0 μs to about 5.6). The tables count it.
- **The Xeon's cold call is its own cost.** One thread at 16 KiB takes 4.8 μs back to back and 20 to 21 after other work or 5 ms asleep, with helpers awake or not: the calling core's own start with the wide vectors, which helpers on other cores cannot warm.
- **More helpers are not always better.** With every worker awake, calls on one thread ran 5% to 8% slower back to back on the four x86 machines, where a worker then shares the caller's core (two CPUs a core); and on the Xeon 7 awake beat 55 at 64 KiB and 256 KiB.

## The follow-up probes: what a caller gets with nothing kept running

**Question** (Zooko, after the verdict above). If the caller will not keep helper threads running, what else is there (prefetching, smaller code, anything), and how much could it realistically give?

**Decisions** (Zooko, with these results before him). No notion of keep-awake enters the API. No call that warns of a hash to come either: a program that could give the warning could as well start the hash. One kind of early notice stays: a caller may learn that bytes will come (a connection opens) and make its `Hasher` then, before any bytes; whatever that is to do must fit the calls the library has. The `early` probe measures the most it could do.

**Verdict.**

- **A caller who learns early that bytes will come can act on it with the calls as they are: hash a few KiB of anything at that moment.** When the notice interrupts other work, that one call takes the first real hash of 1 KiB to 64 KiB to 0.72 to 0.92 of its time on the Macs and the Ryzen 9700X, with the bytes arriving 50 μs to 5 ms later and the thread idle in between. On the Xeon it takes 16 KiB and 64 KiB to 0.27 to 0.34 of their time when the bytes follow within 200 μs, and gives nothing from a millisecond on: the 512-bit unit has stopped again. After a rest in which nothing else ran it gives nothing on the Macs and the Ryzen (0.97 to 1.03): there a rested call's cost is the thread's clock, and the clock does not keep. Workers woken at that moment, to park again, leave 1 MiB over the pool between 0.89 and 1.06 of its time.
- **On x86 a split from 256 KiB gains after a rest with the workers asleep as they ship.** After 5 ms asleep, 256 KiB split among workers the call itself wakes takes 0.51 (EPYC 7443P), 0.66 (Xeon), 0.81 (Ryzen 9700X) and 0.88 (EPYC 9255) of today's time (the first probe's "asleep" setting). Back to back the Ryzen loses (1.07) and the other three gain (0.54 to 0.86). With three workers woken as the bytes are written, a few microseconds before the call, the shares are 0.48, 0.66, 0.68 and 0.68 (`warn`, "0 us"); kept awake, 0.24, 0.58, 0.53 and 0.68.
- **On the Macs nothing replaces a busy thread.** A rested thread hashes 1 KiB in 4.7 μs (M6) where a thread beside a long-busy helper takes 0.9. No QoS class on the calling thread changes that, the real-time policy does not, and a spinner on an efficiency core does not. Helpers woken up to 5 ms ahead left it at 4.0 to 4.8 on a machine that had mostly rested, and brought it to 0.8 where helpers had been spinning for much of the last second (the runs with longer leads). I read that as the fast cluster's clock following the last few hundred milliseconds. The run that would test the reading (`warn VISITS rested`, on the branch) was not made: it measures helpers kept spinning, the option declined.
- **Narrower kernels for a now-and-then call give little.** On the Xeon the 256-bit kernels pay a start as the 512-bit ones do, and only the 128-bit ones pay none: the best kernel by length takes 0.67 of today's time at 4 KiB, 0.90 at 16 KiB, 0.79 at 64 KiB. On the three AMD machines the widest kernels win cold too.
- **The kernels' code is worth fetching on x86 too.** In a program whose other cores never run the hash, a 16 KiB call after other work takes 4.6 μs against 1.5 back to back on the Ryzen 9700X (4.0 against 1.8 on the EPYC 9255). x86's now-and-then path fetches no code ahead today, where NEON's does. On the Ryzen, `early` puts what running the kernels ahead recovers at 0.4 to 0.6 μs of a 16 KiB call in a program whose pool hashes too; how much a fetch at the call recovers is unmeasured.
- **The price of keeping awake**, by macOS's own estimate for the process: about 2.5 W for one helper on the M6 and 2.9 W on the M4, 5.5 W for three. The x86 measurement hosts do not let a process read the package's energy.

**What this leaves for the library** (its design is John's; [BLAKE3 #490](https://github.com/servil-software-factory/BLAKE3/issues/490) hands it to him): a split from 256 KiB on x86; a fetch of the kernels' code on x86's now-and-then path; SSE4.1 for a cold call of about 4 KiB on the Xeon; and whether a `Hasher` should fetch its kernels when it is made.

**The probes.** Five more modes of `examples/host_lab.rs`, at later commits of `probe/latency-ready` (`40dc766d`, `6fe6b68f`, `b18c10ff`, `83806270`, `b4b9a431`):

- `rest VISITS`: `convenience::hash` after 200 μs, 1 ms, 5 ms and 20 ms asleep, with the thread as launched; in QoS class default, user-initiated, user-interactive; under the real-time policy (no period, 200 μs of computation within 400 μs; the system took it every time); with one pool worker kept awake; with a spinning thread of the program's own in the background QoS class. 300 visits a cell. On Linux the QoS and real-time rows repeat "as launched".
- `cold VISITS`: one message on the calling thread, back to back, after other work and after 5 ms asleep, through `convenience::hash` and through the one-thread tree on each kernel family the CPU has. 400 visits. Its "back to back" is the third call in a row, which at 4 KiB on the Xeon is still inside the wide unit's start.
- `warn VISITS [long [HELPERS]]`: after 5 ms in which everything rests, three workers are woken (or HELPERS) and kept polling, the caller waits out a lead, and the call is timed, beside the call with no warning and the call with the workers kept awake. In this mode "kept awake" means awake since the visit began, about 5 ms before the call. 400 visits (60 with the long leads).
- `price SECONDS`: the process's CPU time and energy over 10 s holds with 0, 1, 3, 7 and all workers awake, there and back, 5 s of rest before each.
- `early VISITS`: after 5 ms asleep or other work comes the hello, then a lead in which nothing runs (50 μs, 200 μs, 1 ms, 5 ms), then the write and the call, timed: one thread at 1 KiB, 16 KiB and 64 KiB, the pool at 1 MiB, the split as shipped. At the hello one of: nothing, as the library ships; the kernels the call will run, run once on the calling thread over other bytes (as many as the call's, up to 64 KiB), which bounds what making a hasher early could do; that and three workers woken, who find nothing and park again. 300 visits. On the Ryzen 9700X and the Xeon among the x86 machines.

No window of other programs' load read busy in any of these runs.

**The calling thread after 5 ms asleep (`rest`): `convenience::hash` of 1 KiB and of 64 KiB, the write and the call.**

| Machine | as launched | QoS user-interactive | real-time policy | a background spinner | one worker awake |
|---|---|---|---|---|---|
| Apple M6 | 4.67, 49.7 | 4.71, 49.7 | 4.71, 49.7 | 4.58, 49.6 | 0.88, 13.0 |
| Apple M4 | 5.33, 49.5 | 5.38, 49.5 | 4.62, 49.3 | 4.42, 46.1 | 1.08, 17.4 |
| Ryzen 9700X | 1.57, 6.20 | - | - | 1.61, 6.38 | 1.56, 6.32 |
| EPYC 7443P | 2.27, 31.2 | - | - | 1.31, 17.9 | 1.31, 17.9 |

**A now-and-then call on narrower kernels (`cold`): the call alone on one thread, back to back → after other work.**

Xeon Gold 6330:

| Length | widest (AVX-512) | AVX2 | SSE4.1 |
|---|---|---|---|
| 4 KiB | 6.77 → 7.97 | 2.86 → 11.8 | 3.88 → 5.46 |
| 16 KiB | 4.30 → 18.8 | 7.53 → 30.7 | 15.0 → 17.1 |
| 64 KiB | 16.1 → 62.4 | 29.6 → 49.3 | 59.2 → 61.5 |
| 256 KiB | 63.1 → 95.7 | 117.1 → 123.6 | 237.6 → 238.1 |

Ryzen 9700X:

| Length | widest (AVX-512) | AVX2 | SSE4.1 |
|---|---|---|---|
| 4 KiB | 1.21 → 1.84 | 1.42 → 2.23 | 1.59 → 3.25 |
| 16 KiB | 1.45 → 4.57 | 3.23 → 5.38 | 6.08 → 7.95 |
| 64 KiB | 3.74 → 6.91 | 12.6 → 14.6 | 24.1 → 26.1 |
| 256 KiB | 14.1 → 17.5 | 48.3 → 50.6 | 96.0 → 98.0 |

EPYC 9255:

| Length | widest (AVX-512) | AVX2 | SSE4.1 |
|---|---|---|---|
| 4 KiB | 1.47 → 1.83 | 1.77 → 2.42 | 2.00 → 3.30 |
| 16 KiB | 1.83 → 4.07 | 4.01 → 6.06 | 7.68 → 9.17 |
| 64 KiB | 4.70 → 6.52 | 15.4 → 17.5 | 30.4 → 32.1 |
| 256 KiB | 17.8 → 19.8 | 61.0 → 63.3 | 121.3 → 123.2 |

EPYC 7443P:

| Length | widest (AVX2) | SSE4.1 |
|---|---|---|
| 4 KiB | 1.29 → 1.86 | 1.69 → 2.57 |
| 16 KiB | 3.47 → 4.55 | 6.43 → 7.52 |
| 64 KiB | 13.2 → 14.4 | 25.4 → 26.6 |
| 256 KiB | 53.5 → 54.6 | 101.9 → 102.7 |

**Helpers woken by a warning (`warn`), after 5 ms in which everything rests: 256 KiB over the pool (split from 32 KiB, three helpers), then 1 KiB on the calling thread; the write and the call.**

| Machine | no warning | warned 0 us | warned 50 us | warned 200 us | warned 1 ms | warned 5 ms | kept awake |
|---|---|---|---|---|---|---|---|
| Apple M6 | 182.1, 4.75 | 146.0, 4.79 | 145.5, 4.71 | 145.6, 4.71 | 145.9, 4.71 | 126.8, 4.04 | 105.7, 3.88 |
| Apple M4 | 170.2, 5.38 | 149.8, 5.50 | 148.0, 4.46 | 148.1, 4.46 | 147.8, 4.46 | 150.2, 4.46 | 126.8, 4.38 |
| Ryzen 9700X | 23.7, 1.57 | 16.2, 1.58 | 16.2, 1.57 | 16.1, 1.57 | 13.0, 1.09 | 14.6, 1.44 | 12.6, 1.09 |
| EPYC 9255 | 21.1, 1.37 | 14.3, 1.38 | 14.3, 1.37 | 14.3, 1.37 | 14.4, 1.38 | 14.3, 1.38 | 14.3, 1.38 |
| Xeon Gold 6330 | 152.3, 3.99 | 100.9, 4.00 | 90.3, 1.57 | 90.5, 1.57 | 88.9, 1.58 | 98.4, 1.57 | 87.7, 1.57 |
| EPYC 7443P | 128.2, 2.33 | 61.4, 2.34 | 62.6, 2.35 | 62.2, 2.35 | 68.8, 2.73 | 32.1, 1.34 | 31.1, 1.33 |

**The Macs with longer leads, one helper woken: 1 KiB on the calling thread, then 64 KiB; the write and the call.**

| Machine | no warning | warned 5 ms | warned 20 ms | warned 50 ms | warned 100 ms | warned 200 ms | warned 500 ms |
|---|---|---|---|---|---|---|---|
| Apple M6 | 2.46, 38.7 | 0.83, 11.8 | 0.79, 11.8 | 0.79, 11.8 | 0.79, 11.8 | 0.75, 11.8 | 0.75, 11.8 |
| Apple M4 | 3.83, 56.6 | 0.83, 14.5 | 0.83, 14.5 | 0.79, 14.5 | 0.79, 14.5 | 0.79, 14.5 | 0.79, 14.5 |

**The Macs with longer leads, three helpers woken: 1 KiB on the calling thread, then 64 KiB; the write and the call.**

| Machine | no warning | warned 5 ms | warned 20 ms | warned 50 ms | warned 100 ms | warned 200 ms | warned 500 ms |
|---|---|---|---|---|---|---|---|
| Apple M6 | 2.46, 38.7 | 0.79, 11.4 | 0.79, 11.5 | 0.79, 11.4 | 0.79, 11.5 | 0.79, 11.5 | 0.79, 11.5 |
| Apple M4 | 3.83, 56.6 | 0.88, 14.5 | 0.88, 14.5 | 0.92, 14.5 | 0.92, 14.5 | 0.92, 14.5 | 0.92, 14.5 |

**What helpers kept awake cost while no call comes (`price`, 10 s holds, there and back): watts by macOS's own estimate for the process.**

| Machine | 1 awake | 3 awake | 7 awake | all awake |
|---|---|---|---|---|
| Apple M6 | 2.4 to 2.5 | 5.5 to 5.7 | 10.3 to 10.5 | 11.3 to 11.4 |
| Apple M4 | 2.8 to 2.9 | 5.4 to 5.5 | 8.2 to 8.3 | 8.8 to 8.8 |

**A hasher made early with nothing kept running (`early`): one thread, the write and the call. With nothing done at the hello → with the kernels run there once over other bytes (share). The bytes come 200 μs or 5 ms after the hello.**

| Machine | Message | after other work, 200 μs | after other work, 5 ms | after 5 ms asleep, 200 μs | after 5 ms asleep, 5 ms |
|---|---|---|---|---|---|
| Apple M6 | 1 KiB | 4.54 → 3.71 (0.82) | 6.42 → 5.58 (0.87) | 4.00 → 4.00 (1.00) | 4.79 → 4.79 (1.00) |
| Apple M6 | 16 KiB | 14.4 → 10.5 (0.73) | 20.6 → 16.9 (0.82) | 13.2 → 13.2 (0.99) | 16.3 → 16.2 (0.99) |
| Apple M6 | 64 KiB | 39.2 → 32.8 (0.84) | 46.0 → 41.6 (0.90) | 42.6 → 42.2 (0.99) | 49.8 → 49.8 (1.00) |
| Apple M4 | 1 KiB | 4.04 → 3.25 (0.80) | 6.88 → 6.13 (0.89) | 3.21 → 3.25 (1.01) | 5.58 → 5.54 (0.99) |
| Apple M4 | 16 KiB | 15.3 → 11.4 (0.74) | 25.3 → 19.8 (0.78) | 12.7 → 12.7 (1.00) | 19.1 → 18.7 (0.98) |
| Apple M4 | 64 KiB | 39.8 → 32.6 (0.82) | 57.2 → 50.6 (0.88) | 33.5 → 34.6 (1.03) | 50.3 → 49.9 (0.99) |
| Ryzen 9700X | 1 KiB | 1.30 → 1.17 (0.90) | 1.80 → 1.66 (0.92) | 1.57 → 1.57 (1.00) | 1.57 → 1.57 (1.00) |
| Ryzen 9700X | 16 KiB | 2.63 → 2.23 (0.85) | 3.50 → 2.91 (0.83) | 2.40 → 2.41 (1.00) | 2.40 → 2.41 (1.00) |
| Ryzen 9700X | 64 KiB | 6.40 → 5.64 (0.88) | 8.50 → 7.70 (0.91) | 6.16 → 6.17 (1.00) | 6.17 → 6.17 (1.00) |
| Xeon Gold 6330 | 1 KiB | 2.11 → 1.89 (0.90) | 2.16 → 2.06 (0.95) | 1.68 → 1.66 (0.99) | 3.94 → 3.93 (1.00) |
| Xeon Gold 6330 | 16 KiB | 21.0 → 6.43 (0.31) | 22.1 → 21.4 (0.97) | 19.0 → 5.22 (0.27) | 24.9 → 24.2 (0.97) |
| Xeon Gold 6330 | 64 KiB | 70.8 → 23.9 (0.34) | 69.8 → 68.8 (0.99) | 68.0 → 19.5 (0.29) | 56.6 → 56.7 (1.00) |

**The same over every lead (50 μs, 200 μs, 1 ms, 5 ms): the share of the time with nothing done at the hello, lowest to highest. One thread at 1 KiB, 16 KiB and 64 KiB with the kernels run at the hello; then 1 MiB over the pool with the kernels run and three workers woken there.**

| Machine | after other work, bytes within 200 μs | after other work, bytes after 1 ms or 5 ms | after 5 ms asleep, within 200 μs | after 5 ms asleep, after 1 ms or 5 ms | 1 MiB over the pool, workers woken |
|---|---|---|---|---|---|
| Apple M6 | 0.73 to 0.89 | 0.81 to 0.91 | 0.99 to 1.00 | 0.98 to 1.00 | 0.98 to 1.01 |
| Apple M4 | 0.72 to 0.82 | 0.78 to 0.90 | 0.98 to 1.03 | 0.97 to 0.99 | 0.91 to 1.06 |
| Ryzen 9700X | 0.82 to 0.90 | 0.83 to 0.92 | 1.00 to 1.00 | 1.00 to 1.01 | 0.90 to 1.00 |
| Xeon Gold 6330 | 0.31 to 0.90 | 0.95 to 1.01 | 0.27 to 1.01 | 0.97 to 1.00 | 0.89 to 1.02 |

**Reading the first probe again.** Its one-thread times "after other work" came from a program whose workers had run the same kernels moments before, so the kernels' code was in other cores' caches: the Ryzen's 16 KiB call read 2.05 μs there and 4.58 in `cold`, a program with one hashing thread. That is my reading of the difference, untested. It makes today's cold one-thread call slower than the first tables show, and so their shares for "after other work" a little high. The same holds for `early`, whose pool hashes too.

## Files

`job-x86.sh` (the first probe's x86 job as submitted; `job-x86-rest.sh`, `job-x86-cold.sh`, `job-x86-warn.sh` and `job-x86-early.sh` the follow-ups'), `read-latency.py FILE [--p99] [--mean] [--write]` (one machine's cells), `table.py NAME=FILE ...` (the first probe's tables), `followups.py` (the follow-ups' tables; run it in this folder). Each follow-up has its own folder under its machine (`rest`, `cold`, `warn`, `early` on x86; `1-rest` to `7-early` on the Macs) with the same files as the first probe's. For each x86 machine: `report.txt` (the program's own table), `host_lab.latency.tsv` (every sample: the call's and the write's nanoseconds, and the thread's counts), `provenance.txt`. For each Mac: `job.json`, `verdict.json`, `runner.log` (with the program's table), `host_lab.latency.tsv`.

**Posted:** reported to Zooko directly on November 22, 2026, as the probes came in; the leads for the library are in [BLAKE3 #490](https://github.com/servil-software-factory/BLAKE3/issues/490).

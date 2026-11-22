# What helpers kept awake would give a caller who cares for latency (November 22, 2026)

**Question** (Zooko). Take a caller who cares how long one hash takes more than how many hashes get through, and who will rewrite code and pay for speed. BLAKE3-Servil offers the `convenience` calls (tuned for a hash now and then) and the `throughput` calls (tuned for call after call). Is one of them already about as good as the library can do for this caller, or would a latency API beside them give major gains?

**Verdict.** Major gains exist, and they come from one mechanism: threads kept awake between calls. On six machines, with pool workers polling in place of parking and messages split from 32 KiB:

- **A message of 256 KiB takes 0.39 to 0.71 of today's best time back to back, and 0.20 to 0.71 after 5 ms asleep.** At 1 MiB the share is 0.43 to 0.91, at 4 MiB 0.50 to 1.00.
- **At 64 KiB the two Macs, the Xeon and the Zen 3 EPYC gain (0.57 to 0.82 back to back; 0.18 to 0.63 after 5 ms asleep); back to back the two Zen 5 machines do not** (1.01, 1.03).
- **On both Macs one helper kept awake keeps the calling thread itself fast after a rest**: a call on one thread after 5 ms asleep takes 0.23 to 0.31 of its time up to 64 KiB, the thread's clock reading about 4 GHz in place of 1.3 (M6) and 3.2 in place of 0.9 (M4). The Zen 3 EPYC shows 0.57 and the Ryzen 9700X 0.70 (with three awake); the EPYC 9255 shows none and the Xeon next to none.
- The 99th percentile fell with the median in every cell of the last table below.
- **A second finding, with nothing kept awake:** on the x86 machines a split from 256 KiB already gains with the workers asleep as they ship (the last section).

The price is unmeasured here: each helper kept awake is a core that spins. The tail under other programs' load is unmeasured too.

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

## Files

`job-x86.sh` (the x86 job as submitted), `read-latency.py FILE [--p99] [--mean] [--write]` (one machine's cells), `table.py NAME=FILE ...` (the tables above). For each x86 machine: `report.txt` (the program's own table), `host_lab.latency.tsv` (every sample: the call's and the write's nanoseconds, and the thread's counts), `provenance.txt`. For each Mac: `job.json`, `verdict.json`, `runner.log` (with the program's table), `host_lab.latency.tsv`.

**Posted:** reported to Zooko directly on November 22, 2026.

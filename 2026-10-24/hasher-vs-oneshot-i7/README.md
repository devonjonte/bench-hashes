# Hasher::update_multithreaded against hash_multithreaded, i7-12700K

**Question** (Zooko, October 24): b3sum hashes a large file through
`Hasher::update_multithreaded`, which feeds the pool one subtree at a
time, where `hash_multithreaded` cuts the whole input in one pool job.
Does b3sum's path leave speed behind the one-shot's?

**Code:** blake3-servil at devonjonte/BLAKE3 `servil` 5e5742a, `initialize_multithreaded(None)`
(20 threads: 8 P cores with two threads each, 4 E cores). `main.rs` here:
`Hasher::new().update_multithreaded(x).finalize()` against
`hash_multithreaded(x)`, in alternating pairs (AB, BA, ...), 20 pairs an
input; a sample is the wall time of 16 calls (64 MiB) or 2 calls (1 GiB).
Inputs: 64 MiB and 1 GiB in memory, written before timing; a cached 1 GiB
file (random bytes) mapped fresh for each call, as b3sum maps each file.
Machine idle (load 0.3 before), Linux 7.0. Wall time only: a diagnostic
outside bench-hashes, so no cycle counts or load readings; raw samples in
`run1.stdout.txt` and `run2.stdout.txt` (the same command twice).

**Command:** `hasher-vs-oneshot FILE 20`, bounded by run-bounded.py.

| input | run | Hasher GB/s | one-shot GB/s | Hasher/one-shot per pair, median [range] | pairs Hasher slower |
|---|---|---|---|---|---|
| 64 MiB | 1 | 46.40 | 45.05 | 1.002 [0.753..1.218] | 10/20 |
| 64 MiB | 2 | 47.55 | 47.86 | 1.008 [0.884..1.157] | 11/20 |
| 1 GiB | 1 | 43.46 | 43.15 | 0.991 [0.951..1.036] | 7/20 |
| 1 GiB | 2 | 42.82 | 42.71 | 0.996 [0.961..1.053] | 9/20 |
| 1 GiB mapped | 1 | 37.54 | 37.51 | 1.003 [0.961..1.031] | 11/20 |
| 1 GiB mapped | 2 | 37.23 | 37.36 | 1.002 [0.969..1.051] | 11/20 |

(GB/s: total bytes over total time.)

**512 KiB to 16 MiB** (`hasher-vs-oneshot FILE 20 mid`, in memory, the
FILE unused; a sample 1024, 512, 128 or 32 calls; `mid1`, `mid2`):

| input | run | Hasher GB/s | one-shot GB/s | Hasher/one-shot per pair, median [range] | pairs Hasher slower |
|---|---|---|---|---|---|
| 512 KiB | 1 | 29.23 | 29.21 | 0.999 [0.957..1.043] | 9/20 |
| 512 KiB | 2 | 29.49 | 29.54 | 1.002 [0.953..1.073] | 10/20 |
| 1 MiB | 1 | 37.30 | 37.49 | 1.006 [0.983..1.054] | 13/20 |
| 1 MiB | 2 | 36.35 | 37.10 | 1.013 [0.981..1.083] | 17/20 |
| 4 MiB | 1 | 40.75 | 40.96 | 1.003 [0.880..1.158] | 11/20 |
| 4 MiB | 2 | 41.79 | 42.40 | 1.000 [0.942..1.110] | 10/20 |
| 16 MiB | 1 | 51.17 | 51.18 | 1.002 [0.917..1.111] | 10/20 |
| 16 MiB | 2 | 51.36 | 51.27 | 0.998 [0.947..1.047] | 9/20 |

**Verdict, this machine only:** level from 512 KiB to 1 GiB, in memory
and mapped, except 1 MiB, where the Hasher is about 1% slower (0.6% and
1.3% by median, slower in 13 and 17 pairs of 20: about 0.3 us of a 28 us
call, the Hasher's own setup and finish, a guess unmeasured). Not
measured: the EPYC 9255, the M4 Max.

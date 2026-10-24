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

**Verdict, this machine only:** level at 64 MiB and 1 GiB, in memory and
mapped. Not measured: 512 KiB to 16 MiB, the EPYC 9255, the M4 Max.

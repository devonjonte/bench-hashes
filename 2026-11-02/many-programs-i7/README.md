# N programs at once, each a servil mt stream (i7-12700K, 20 CPUs, November 2)

**Question** (Zooko, bench-hashes #116): more than two programs sharing
the machine, up to one a core and beyond: supported, or a trap? Each
program (`many_programs.rs`, servil at 0.8) streams messages of one size
through `performance::stream` for 4 s and prints its GB/s; N start at
once; `run.sh`. Each process's pool is 20 workers, so N=20 is 400 threads
and N=80 1600.

| 64 KiB messages | N=1 | 2 | 4 | 10 | 20 | 40 | 80 |
|---|---|---|---|---|---|---|---|
| the machine's sum, GB/s | 26.0 | 40.6 | 38.4 | 37.2 | 28.0 | 22.7 | 21.3 |
| the luckiest over the unluckiest program | 1.00 | 1.00 | 1.09 | 2.17 | 2.59 | 5.21 | 8.35 |

1 KiB messages: the sum 15.6, 29.0, 35.4, 32.7, 23.2, 18.8, 16.8; the
spread 1.00 to 3.84.

- **Throughput degrades gracefully:** the sum holds to 10 programs,
  then falls to 70-80% of the peak at 20-80 (oversubscription's cost,
  about 45%); no collapse, no hang.
- **Fairness degrades badly past 4 programs:** by Linux's scheduling of
  hundreds of threads, since the pool is a process's own. At one program
  a core (N=20) the median program gets 1.4 GB/s where a fair share is
  1.9; at 80, an 8x spread.
- One program a core works and keeps most of the machine's throughput;
  a program wanting a predictable share should size its pool smaller
  (`initialize_multithreaded(Some(n))`). A point for the fork's docs.

**Posted:** bench-hashes #116.

# b3sum on a Ryzen 7 9700X: BLAKE3-Servil 0.9.1 and the 0.10.0 candidate

**Question:** how long does `b3sum` take, from its start to its exit, for BLAKE3-Servil 0.9.1, 0.8.0, the 0.10.0 release candidate, and official `b3sum` 1.8.7, on the same files in the same rounds?

**Measured** November 20, 2026, on an AMD Ryzen 7 9700X (8 cores, 16 CPUs, Linux 7.0, files on ext4), on a quiet machine: 15 rounds, each program once on each input in each round. Benchmark: bench-hashes 0.23.0 (`cade30fdb716`).

**The 0.10.0 column is the release candidate** `d3ed18d19a49a6c8506f175cf316fc36aad77ba6`. The final 0.10.0 will be stamped on a later commit that changes documents and release tools and no compiled code. 0.9.1 is `2c60420c2bccbf6073e35e668691d98520f9b096`.

Each cell is the mean wall time of a run. The words in parentheses compare with 0.9.1; "same" means the rounds do not tell the two apart.

## From disk (files evicted from the page cache before each run)

| Workload | BLAKE3-Servil 0.9.1 | BLAKE3-Servil 0.8.0 | BLAKE3-Servil 0.10.0 candidate | Official b3sum 1.8.7 |
|---|---:|---:|---:|---:|
| 4 KiB | 463 μs | 461 μs (same) | 479 μs (same) | 876 μs (1.9× slower) |
| 64 KiB | 519 μs | 498 μs (same) | 535 μs (same) | 769 μs (49% slower) |
| 1 MiB | 1.03 ms | 1.01 ms (same) | 1.02 ms (same) | 1.28 ms (23% slower) |
| 16 MiB | 4.14 ms | 4.30 ms (same) | 3.55 ms (**15% faster**) | 4.76 ms (15% slower) |
| 256 MiB | 55.4 ms | 55.0 ms (same) | 32.9 ms (**1.7× faster**) | 55.9 ms (same) |
| 1 GiB | 217 ms | 217 ms (same) | 116 ms (**1.9× faster**) | 220 ms (same) |
| 1000 x 16 KiB | 6.68 ms | 6.29 ms (**6% faster**) | 3.57 ms (**1.9× faster**) | 102 ms (15.1× slower) |
| 1000 x 16 KiB, a process each | 279 ms | 274 ms (same) | 283 ms (same) | 549 ms (2.0× slower) |
| mixed tree, 1000 files, 74 MiB | 20.4 ms | 20.6 ms (same) | 13.7 ms (**33% faster**) | 174 ms (8.5× slower) |
| 16 x 64 MiB | 177 ms | 178 ms (same) | 123 ms (**31% faster**) | 232 ms (31% slower) |

## In memory (files in the page cache)

| Workload | BLAKE3-Servil 0.9.1 | BLAKE3-Servil 0.8.0 | BLAKE3-Servil 0.10.0 candidate | Official b3sum 1.8.7 |
|---|---:|---:|---:|---:|
| 4 KiB | 376 μs | 353 μs (same) | 372 μs (same) | 769 μs (2.1× slower) |
| 64 KiB | 288 μs | 283 μs (same) | 301 μs (same) | 566 μs (2.0× slower) |
| 1 MiB | 399 μs | 379 μs (**5% faster**) | 366 μs (**8% faster**) | 567 μs (42% slower) |
| 16 MiB | 611 μs | 596 μs (same) | 625 μs (same) | 844 μs (37% slower) |
| 256 MiB | 6.67 ms | 6.73 ms (same) | 6.78 ms (same) | 8.64 ms (29% slower) |
| 1 GiB | 27.9 ms | 30.3 ms (same) | 30.3 ms (same) | 33.7 ms (22% slower) |
| 1000 x 16 KiB | 1.75 ms | 1.67 ms (same) | 1.61 ms (same) | 5.91 ms (3.4× slower) |
| 1000 x 16 KiB, a process each | 168 ms | 160 ms (**5% faster**) | 169 ms (same) | 439 ms (2.6× slower) |
| mixed tree, 1000 files, 74 MiB | 3.89 ms | 3.49 ms (**10% faster**) | 3.77 ms (same) | 10.1 ms (2.6× slower) |
| 16 x 64 MiB | 31.0 ms | 32.8 ms (same) | 30.4 ms (same) | 30.8 ms (same) |

## Files here

- `b3sum-full.stdout.txt`: the benchmark's own report, with CPUs busy and peak memory.
- `b3sum.samples.tsv`: every sample.
- `run.sh`, `contenders.txt`, `versions.txt`: the command, the programs, the commits.

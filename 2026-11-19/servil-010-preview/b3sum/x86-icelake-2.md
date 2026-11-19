# b3sum on 2× Xeon Gold 6330 (b) (all 10 workloads)

Host `x86-icelake-2` (Intel(R) Xeon(R) Gold 6330 CPU @ 2.00GHz, 112 CPUs, linux7.0.0-43-generic); files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.00 CPUs busy on average, 0.03 in the busiest window. Runs: 15 rounds, each contender once on each input in each.

## In memory (page cache)

*Wall time per run; parenthesized comparison is against BLAKE3-Servil 0.9.0.*

| Workload | BLAKE3-Servil 0.9.0 | BLAKE3-Servil 0.8.0 | BLAKE3-Servil 0.10.0 | Official b3sum 1.8.7 |
|---|---:|---:|---:|---:|
| 4 KiB | 821 μs | 777 μs (same) | 800 μs (same) | 3.36 ms (4.1× slower) |
| 64 KiB | 792 μs | 749 μs (**5% faster**) | 788 μs (same) | 3.11 ms (3.9× slower) |
| 1 MiB | 1.18 ms | 1.12 ms (same) | 1.29 ms (same) | 3.31 ms (2.8× slower) |
| 16 MiB | 1.91 ms | 1.92 ms (same) | 1.95 ms (same) | 3.95 ms (2.1× slower) |
| 256 MiB | 6.37 ms | 6.29 ms (same) | 6.16 ms (same) | 11.9 ms (1.9× slower) |
| 1 GiB | 18.2 ms | 18.6 ms (same) | 18.3 ms (same) | 37.6 ms (2.0× slower) |
| 1000 x 16 KiB | 5.33 ms | 5.04 ms (**5% faster**) | 4.02 ms (**25% faster**) | 20.2 ms (3.8× slower) |
| 1000 x 16 KiB, a process each | 593 ms | 564 ms (**5% faster**) | 592 ms (same) | 2.89 s (4.9× slower) |
| mixed tree, 1000 files, 74 MiB | 6.92 ms | 6.73 ms (same) | 6.13 ms (**11% faster**) | 36.7 ms (5.3× slower) |
| 16 x 64 MiB | 21.3 ms | 21.0 ms (same) | 18.3 ms (**14% faster**) | 45.1 ms (2.1× slower) |

## From disk (evicted before each run)

*Wall time per run; parenthesized comparison is against BLAKE3-Servil 0.9.0.*

| Workload | BLAKE3-Servil 0.9.0 | BLAKE3-Servil 0.8.0 | BLAKE3-Servil 0.10.0 | Official b3sum 1.8.7 |
|---|---:|---:|---:|---:|
| 4 KiB | 908 μs | 868 μs (same) | 883 μs (same) | 3.50 ms (3.9× slower) |
| 64 KiB | 954 μs | 891 μs (**6% faster**) | 944 μs (same) | 3.27 ms (3.4× slower) |
| 1 MiB | 1.62 ms | 1.60 ms (same) | 1.64 ms (same) | 3.68 ms (2.3× slower) |
| 16 MiB | 4.96 ms | 4.88 ms (same) | 5.95 ms (20% slower) | 7.58 ms (1.5× slower) |
| 256 MiB | 53.6 ms | 53.5 ms (same) | 45.9 ms (**14% faster**) | 56.5 ms (5% slower) |
| 1 GiB | 206 ms | 206 ms (same) | 173 ms (**16% faster**) | 210 ms (same) |
| 1000 x 16 KiB | 7.46 ms | 7.35 ms (same) | 7.10 ms (**5% faster**) | 107 ms (14× slower) |
| 1000 x 16 KiB, a process each | 734 ms | 700 ms (**5% faster**) | 730 ms (same) | 3.00 s (4.1× slower) |
| mixed tree, 1000 files, 74 MiB | 17.9 ms | 17.7 ms (same) | 19.1 ms (7% slower) | 130 ms (7.3× slower) |
| 16 x 64 MiB | 206 ms | 206 ms (same) | 179 ms (**13% faster**) | 230 ms (12% slower) |

---

# Quick suite on 2× Xeon Gold 6330 (b) (5 rounds, includes 100 x 16 KiB)

Host `x86-icelake-2` (Intel(R) Xeon(R) Gold 6330 CPU @ 2.00GHz, 112 CPUs, linux7.0.0-43-generic); files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.00 CPUs busy on average, 0.01 in the busiest window. Runs: 5 rounds, each contender once on each input in each (--quick: a check, not a record).

## In memory (page cache)

*Wall time per run; parenthesized comparison is against BLAKE3-Servil 0.9.0.*

| Workload | BLAKE3-Servil 0.9.0 | BLAKE3-Servil 0.8.0 | BLAKE3-Servil 0.10.0 | Official b3sum 1.8.7 |
|---|---:|---:|---:|---:|
| 4 KiB | 808 μs | 764 μs (same) | 789 μs (same) | 3.28 ms (4.1× slower) |
| 1 MiB | 1.18 ms | 1.12 ms (same) | 1.23 ms (same) | 3.48 ms (3.0× slower) |
| 16 MiB | 2.03 ms | 1.88 ms (same) | 2.02 ms (same) | 3.95 ms (2.0× slower) |
| 100 x 16 KiB | 1.63 ms | 1.50 ms (**8% faster**) | 1.75 ms (7% slower) | 4.72 ms (2.9× slower) |
| 100 x 16 KiB, a process each | 63.1 ms | 60.2 ms (same) | 63.1 ms (same) | 291 ms (4.6× slower) |
| mixed tree, 100 files, 5 MiB | 2.02 ms | 1.97 ms (same) | 2.10 ms (same) | 6.23 ms (3.1× slower) |
| 4 x 16 MiB | 3.57 ms | 3.74 ms (same) | 3.10 ms (same) | 6.94 ms (1.9× slower) |

## From disk (evicted before each run)

*Wall time per run; parenthesized comparison is against BLAKE3-Servil 0.9.0.*

| Workload | BLAKE3-Servil 0.9.0 | BLAKE3-Servil 0.8.0 | BLAKE3-Servil 0.10.0 | Official b3sum 1.8.7 |
|---|---:|---:|---:|---:|
| 4 KiB | 890 μs | 829 μs (same) | 847 μs (same) | 3.27 ms (3.7× slower) |
| 1 MiB | 1.61 ms | 1.64 ms (same) | 1.63 ms (same) | 3.66 ms (2.3× slower) |
| 16 MiB | 4.80 ms | 4.84 ms (same) | 5.78 ms (21% slower) | 7.42 ms (1.5× slower) |
| 100 x 16 KiB | 1.93 ms | 1.83 ms (same) | 2.36 ms (23% slower) | 14.0 ms (7.2× slower) |
| 100 x 16 KiB, a process each | 76.9 ms | 73.2 ms (same) | 76.7 ms (same) | 304 ms (4.0× slower) |
| mixed tree, 100 files, 5 MiB | 3.37 ms | 3.21 ms (same) | 4.51 ms (33% slower) | 16.7 ms (5.0× slower) |
| 4 x 16 MiB | 16.0 ms | 16.0 ms (same) | 14.1 ms (**12% faster**) | 21.4 ms (34% slower) |

# b3sum on 2× Xeon Gold 6330 (a) (all 10 workloads)

Host `x86-icelake` (Intel(R) Xeon(R) Gold 6330 CPU @ 2.00GHz, 112 CPUs, linux7.0.0-43-generic); files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.00 CPUs busy on average, 0.03 in the busiest window. Runs: 15 rounds, each contender once on each input in each.

## In memory (page cache)

*Wall time per run; parenthesized comparison is against BLAKE3-Servil 0.9.0.*

| Workload | BLAKE3-Servil 0.9.0 | BLAKE3-Servil 0.8.0 | BLAKE3-Servil 0.10.0 | Official b3sum 1.8.7 |
|---|---:|---:|---:|---:|
| 4 KiB | 861 μs | 813 μs (same) | 808 μs (same) | 3.40 ms (4.0× slower) |
| 64 KiB | 792 μs | 765 μs (**3% faster**) | 812 μs (same) | 3.13 ms (4.0× slower) |
| 1 MiB | 1.19 ms | 1.15 ms (same) | 1.25 ms (same) | 3.32 ms (2.8× slower) |
| 16 MiB | 1.96 ms | 1.94 ms (same) | 2.06 ms (same) | 4.00 ms (2.0× slower) |
| 256 MiB | 6.20 ms | 6.29 ms (same) | 6.35 ms (same) | 12.0 ms (1.9× slower) |
| 1 GiB | 18.5 ms | 18.6 ms (same) | 18.4 ms (same) | 38.5 ms (2.0× slower) |
| 1000 x 16 KiB | 5.45 ms | 5.16 ms (**5% faster**) | 3.97 ms (**27% faster**) | 20.4 ms (3.7× slower) |
| 1000 x 16 KiB, a process each | 596 ms | 568 ms (**5% faster**) | 596 ms (same) | 2.91 s (4.9× slower) |
| mixed tree, 1000 files, 74 MiB | 7.19 ms | 6.64 ms (**7% faster**) | 6.21 ms (**13% faster**) | 37.1 ms (5.2× slower) |
| 16 x 64 MiB | 21.5 ms | 21.6 ms (same) | 18.4 ms (**14% faster**) | 45.8 ms (2.1× slower) |

## From disk (evicted before each run)

*Wall time per run; parenthesized comparison is against BLAKE3-Servil 0.9.0.*

| Workload | BLAKE3-Servil 0.9.0 | BLAKE3-Servil 0.8.0 | BLAKE3-Servil 0.10.0 | Official b3sum 1.8.7 |
|---|---:|---:|---:|---:|
| 4 KiB | 920 μs | 883 μs (same) | 866 μs (same) | 3.59 ms (3.9× slower) |
| 64 KiB | 927 μs | 908 μs (same) | 929 μs (same) | 3.27 ms (3.5× slower) |
| 1 MiB | 1.73 ms | 1.70 ms (same) | 1.74 ms (same) | 3.64 ms (2.1× slower) |
| 16 MiB | 4.48 ms | 4.46 ms (same) | 5.59 ms (25% slower) | 7.29 ms (1.6× slower) |
| 256 MiB | 47.6 ms | 48.0 ms (same) | 35.2 ms (**26% faster**) | 51.6 ms (9% slower) |
| 1 GiB | 183 ms | 183 ms (same) | 124 ms (**32% faster**) | 188 ms (same) |
| 1000 x 16 KiB | 7.21 ms | 6.93 ms (**4% faster**) | 6.79 ms (**6% faster**) | 64.5 ms (8.9× slower) |
| 1000 x 16 KiB, a process each | 652 ms | 621 ms (**5% faster**) | 650 ms (same) | 2.95 s (4.5× slower) |
| mixed tree, 1000 files, 74 MiB | 16.3 ms | 15.8 ms (same) | 18.3 ms (12% slower) | 124 ms (7.6× slower) |
| 16 x 64 MiB | 186 ms | 186 ms (same) | 142 ms (**24% faster**) | 211 ms (14% slower) |

---

# Quick suite on 2× Xeon Gold 6330 (a) (5 rounds, includes 100 x 16 KiB)

Host `x86-icelake` (Intel(R) Xeon(R) Gold 6330 CPU @ 2.00GHz, 112 CPUs, linux7.0.0-43-generic); files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.00 CPUs busy on average, 0.00 in the busiest window. Runs: 5 rounds, each contender once on each input in each (--quick: a check, not a record).

## In memory (page cache)

*Wall time per run; parenthesized comparison is against BLAKE3-Servil 0.9.0.*

| Workload | BLAKE3-Servil 0.9.0 | BLAKE3-Servil 0.8.0 | BLAKE3-Servil 0.10.0 | Official b3sum 1.8.7 |
|---|---:|---:|---:|---:|
| 4 KiB | 844 μs | 802 μs (same) | 791 μs (same) | 3.29 ms (3.9× slower) |
| 1 MiB | 1.18 ms | 1.19 ms (same) | 1.09 ms (**7% faster**) | 3.34 ms (2.8× slower) |
| 16 MiB | 2.07 ms | 1.96 ms (same) | 2.02 ms (same) | 3.99 ms (1.9× slower) |
| 100 x 16 KiB | 1.62 ms | 1.54 ms (**5% faster**) | 1.77 ms (same) | 4.76 ms (2.9× slower) |
| 100 x 16 KiB, a process each | 63.4 ms | 60.1 ms (same) | 63.7 ms (same) | 292 ms (4.6× slower) |
| mixed tree, 100 files, 5 MiB | 2.13 ms | 2.02 ms (same) | 2.41 ms (same) | 6.16 ms (2.9× slower) |
| 4 x 16 MiB | 3.74 ms | 4.07 ms (same) | 2.93 ms (same) | 6.77 ms (1.8× slower) |

## From disk (evicted before each run)

*Wall time per run; parenthesized comparison is against BLAKE3-Servil 0.9.0.*

| Workload | BLAKE3-Servil 0.9.0 | BLAKE3-Servil 0.8.0 | BLAKE3-Servil 0.10.0 | Official b3sum 1.8.7 |
|---|---:|---:|---:|---:|
| 4 KiB | 906 μs | 825 μs (same) | 810 μs (same) | 3.27 ms (3.6× slower) |
| 1 MiB | 1.69 ms | 1.65 ms (same) | 1.71 ms (same) | 3.63 ms (2.1× slower) |
| 16 MiB | 4.45 ms | 4.51 ms (same) | 5.36 ms (20% slower) | 7.17 ms (1.6× slower) |
| 100 x 16 KiB | 1.88 ms | 1.85 ms (same) | 2.38 ms (26% slower) | 9.37 ms (5.0× slower) |
| 100 x 16 KiB, a process each | 69.0 ms | 65.0 ms (same) | 68.4 ms (same) | 297 ms (4.3× slower) |
| mixed tree, 100 files, 5 MiB | 3.61 ms | 3.33 ms (same) | 4.31 ms (same) | 13.8 ms (3.8× slower) |
| 4 x 16 MiB | 13.6 ms | 13.6 ms (same) | 12.2 ms (**10% faster**) | 19.5 ms (44% slower) |

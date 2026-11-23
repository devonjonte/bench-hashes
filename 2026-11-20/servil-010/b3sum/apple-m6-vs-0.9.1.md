# b3sum 0.9.1 → 0.10.0 on Apple M6 (job 20261123T070928Z-devon-b3sum-0100-vs-091-m6)

Host `apple-m6` (Apple M6, 12 CPUs, darwin27); files on apfs (on /System/Volumes/Data). Load: quiet: other programs kept 0.22 CPUs busy on average, 0.54 in the busiest window. Runs: 15 rounds, each contender once on each input in each.

## In memory (page cache)

*Wall time per run; parenthesized comparison is against BLAKE3-Servil 0.9.1.*

| Workload | BLAKE3-Servil 0.9.1 | BLAKE3-Servil 0.10.0 | Official b3sum 1.8.7 |
|---|---:|---:|---:|
| 4 KiB | 1.33 ms | 1.31 ms (same) | 1.31 ms (same) |
| 64 KiB | 1.17 ms | 1.17 ms (same) | 1.21 ms (3% slower) |
| 1 MiB | 1.34 ms | 1.31 ms (same) | 1.21 ms (**10% faster**) |
| 16 MiB | 2.06 ms | 2.07 ms (same) | 2.04 ms (same) |
| 256 MiB | 13.9 ms | 13.4 ms (same) | 15.6 ms (13% slower) |
| 1 GiB | 48.1 ms | 48.4 ms (same) | 57.9 ms (20% slower) |
| 1000 x 16 KiB | 6.68 ms | 5.55 ms (**17% faster**) | 41.5 ms (6.2× slower) |
| 1000 x 16 KiB, a process each | 1.06 s | 1.04 s (same) | 1.07 s (same) |
| mixed tree, 1000 files, 74 MiB | 8.33 ms | 7.47 ms (**10% faster**) | 35.9 ms (4.3× slower) |
| 16 x 64 MiB | 51.1 ms | 51.0 ms (same) | 59.4 ms (16% slower) |

## From disk (evicted before each run)

*Wall time per run; parenthesized comparison is against BLAKE3-Servil 0.9.1.*

| Workload | BLAKE3-Servil 0.9.1 | BLAKE3-Servil 0.10.0 | Official b3sum 1.8.7 |
|---|---:|---:|---:|
| 4 KiB | 2.04 ms | 2.03 ms (same) | 1.94 ms (same) |
| 64 KiB | 1.33 ms | 1.31 ms (same) | 1.39 ms (5% slower) |
| 1 MiB | 1.83 ms | 1.78 ms (same) | 2.11 ms (15% slower) |
| 16 MiB | 6.75 ms | 6.75 ms (same) | 10.3 ms (1.5× slower) |
| 256 MiB | 79.8 ms | 79.8 ms (same) | 169 ms (2.1× slower) |
| 1 GiB | 313 ms | 313 ms (same) | 645 ms (2.1× slower) |
| 1000 x 16 KiB | 15.8 ms | 14.4 ms (**9% faster**) | 88.2 ms (5.6× slower) |
| 1000 x 16 KiB, a process each | 1.12 s | 1.11 s (same) | 1.14 s (same) |
| mixed tree, 1000 files, 74 MiB | 33.4 ms | 32.6 ms (same) | 161 ms (4.8× slower) |
| 16 x 64 MiB | 385 ms | 368 ms (same) | 662 ms (1.7× slower) |

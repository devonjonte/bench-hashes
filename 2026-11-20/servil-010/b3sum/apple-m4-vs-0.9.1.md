# b3sum 0.9.1 → 0.10.0 on Apple M4 (job 20261123T070928Z-devon-b3sum-0100-vs-091-m4)

Host `apple-m4` (Apple M4, 10 CPUs, darwin27); files on apfs (on /System/Volumes/Data). Load: quiet: other programs kept 0.21 CPUs busy on average, 0.55 in the busiest window. Runs: 15 rounds, each contender once on each input in each.

## In memory (page cache)

*Wall time per run; parenthesized comparison is against BLAKE3-Servil 0.9.1.*

| Workload | BLAKE3-Servil 0.9.1 | BLAKE3-Servil 0.10.0 | Official b3sum 1.8.7 |
|---|---:|---:|---:|
| 4 KiB | 1.85 ms | 1.86 ms (same) | 1.76 ms (same) |
| 64 KiB | 1.66 ms | 1.65 ms (same) | 1.62 ms (same) |
| 1 MiB | 1.89 ms | 1.83 ms (same) | 1.65 ms (**13% faster**) |
| 16 MiB | 2.91 ms | 2.89 ms (same) | 2.89 ms (same) |
| 256 MiB | 18.1 ms | 18.1 ms (same) | 21.7 ms (20% slower) |
| 1 GiB | 64.1 ms | 64.2 ms (same) | 79.5 ms (24% slower) |
| 1000 x 16 KiB | 8.96 ms | 7.34 ms (**18% faster**) | 50.3 ms (5.6× slower) |
| 1000 x 16 KiB, a process each | 1.39 s | 1.38 s (same) | 1.36 s (same) |
| mixed tree, 1000 files, 74 MiB | 10.7 ms | 9.54 ms (**11% faster**) | 45.2 ms (4.2× slower) |
| 16 x 64 MiB | 69.0 ms | 67.4 ms (same) | 80.7 ms (17% slower) |

## From disk (evicted before each run)

*Wall time per run; parenthesized comparison is against BLAKE3-Servil 0.9.1.*

| Workload | BLAKE3-Servil 0.9.1 | BLAKE3-Servil 0.10.0 | Official b3sum 1.8.7 |
|---|---:|---:|---:|
| 4 KiB | 2.16 ms | 2.15 ms (same) | 2.06 ms (same) |
| 64 KiB | 1.77 ms | 1.77 ms (same) | 2.25 ms (27% slower) |
| 1 MiB | 2.38 ms | 2.32 ms (same) | 2.96 ms (25% slower) |
| 16 MiB | 9.85 ms | 9.82 ms (same) | 15.6 ms (1.6× slower) |
| 256 MiB | 118 ms | 118 ms (same) | 210 ms (1.8× slower) |
| 1 GiB | 463 ms | 463 ms (same) | 851 ms (1.8× slower) |
| 1000 x 16 KiB | 22.1 ms | 23.1 ms (same) | 96.3 ms (4.4× slower) |
| 1000 x 16 KiB, a process each | 1.45 s | 1.43 s (same) | 1.41 s (same) |
| mixed tree, 1000 files, 74 MiB | 52.3 ms | 51.7 ms (same) | 204 ms (3.9× slower) |
| 16 x 64 MiB | 504 ms | 504 ms (same) | 812 ms (1.6× slower) |

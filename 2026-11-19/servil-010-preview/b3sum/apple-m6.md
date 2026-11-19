# b3sum on Apple M6 (job 3385)

Host `apple-m6` (Apple M6, 12 CPUs, darwin27); files on apfs (on /System/Volumes/Data). Load: quiet: other programs kept 0.17 CPUs busy on average, 0.99 in the busiest window. Runs: 15 rounds, each contender once on each input in each.

## In memory (page cache)

*Wall time per run; parenthesized comparison is against Official b3sum 1.8.7.*

| Workload | Official b3sum 1.8.7 | BLAKE3-Servil 0.10.0 | Official b3sum (1 thread) | BLAKE3-Servil 0.10.0 (1 thread) | sha256sum | sha1sum | md5sum |
|---|---:|---:|---:|---:|---:|---:|---:|
| 4 KiB | 1.25 ms | 1.21 ms (same) | 1.09 ms (**12% faster**) | 1.23 ms (same) | 846 μs (**32% faster**) | 842 μs (**32% faster**) | 859 μs (**31% faster**) |
| 64 KiB | 1.16 ms | 1.12 ms (**4% faster**) | 1.03 ms (**11% faster**) | 1.12 ms (**4% faster**) | 798 μs (**31% faster**) | 800 μs (**31% faster**) | 849 μs (**27% faster**) |
| 1 MiB | 1.18 ms | 1.25 ms (6% slower) | 1.40 ms (18% slower) | 1.26 ms (6% slower) | 1.15 ms (same) | 1.17 ms (same) | 1.95 ms (1.6× slower) |
| 16 MiB | 2.05 ms | 2.07 ms (same) | 7.65 ms (3.7× slower) | 4.17 ms (2.0× slower) | 7.14 ms (3.5× slower) | 7.31 ms (3.6× slower) | 20.2 ms (9.8× slower) |
| 256 MiB | 15.7 ms | 13.4 ms (**15% faster**) | 111 ms (7.1× slower) | 54.8 ms (3.5× slower) | 105 ms (6.7× slower) | 107 ms (6.8× slower) | 309 ms (20× slower) |
| 1 GiB | 58.0 ms | 47.5 ms (**18% faster**) | 436 ms (7.5× slower) | 215 ms (3.7× slower) | 415 ms (7.2× slower) | 426 ms (7.3× slower) | 1.23 s (21× slower) |
| 1000 x 16 KiB | 41.1 ms | 5.47 ms (**7.5× faster**) | 17.0 ms (**2.4× faster**) | 12.7 ms (**3.2× faster**) | 14.8 ms (**2.8× faster**) | 15.1 ms (**2.7× faster**) | 27.6 ms (**33% faster**) |
| 1000 x 16 KiB, a process each | 1.08 s | 1.05 s (same) | 961 ms (**11% faster**) | 1.05 s (same) | 738 ms (**32% faster**) | 740 ms (**31% faster**) | 750 ms (**31% faster**) |
| mixed tree, 1000 files, 74 MiB | 35.3 ms | 7.38 ms (**4.8× faster**) | 41.8 ms (19% slower) | 24.8 ms (**30% faster**) | 38.6 ms (9% slower) | 39.5 ms (12% slower) | 97.7 ms (2.8× slower) |
| 16 x 64 MiB | 59.3 ms | 50.9 ms (**14% faster**) | 437 ms (7.4× slower) | 215 ms (3.6× slower) | 413 ms (7.0× slower) | 424 ms (7.1× slower) | 1.23 s (21× slower) |

## From disk (evicted before each run)

*Wall time per run; parenthesized comparison is against Official b3sum 1.8.7.*

| Workload | Official b3sum 1.8.7 | BLAKE3-Servil 0.10.0 | Official b3sum (1 thread) | BLAKE3-Servil 0.10.0 (1 thread) | sha256sum | sha1sum | md5sum |
|---|---:|---:|---:|---:|---:|---:|---:|
| 4 KiB | 1.68 ms | 1.56 ms (same) | 1.43 ms (same) | 1.58 ms (same) | 1.21 ms (same) | 1.20 ms (same) | 1.22 ms (same) |
| 64 KiB | 1.40 ms | 1.30 ms (**7% faster**) | 1.43 ms (same) | 1.30 ms (**7% faster**) | 1.19 ms (**15% faster**) | 1.19 ms (**15% faster**) | 1.30 ms (**7% faster**) |
| 1 MiB | 2.34 ms | 1.81 ms (**23% faster**) | 3.10 ms (33% slower) | 1.80 ms (**23% faster**) | 2.37 ms (same) | 2.38 ms (same) | 3.12 ms (34% slower) |
| 16 MiB | 9.87 ms | 5.85 ms (**1.7× faster**) | 16.9 ms (1.7× slower) | 7.05 ms (**27% faster**) | 9.07 ms (same) | 9.28 ms (same) | 21.5 ms (2.2× slower) |
| 256 MiB | 156 ms | 79.0 ms (**2.0× faster**) | 183 ms (17% slower) | 80.0 ms (**1.9× faster**) | 112 ms (**28% faster**) | 114 ms (**27% faster**) | 314 ms (2.0× slower) |
| 1 GiB | 627 ms | 312 ms (**2.0× faster**) | 626 ms (same) | 312 ms (**2.0× faster**) | 437 ms (**30% faster**) | 447 ms (**29% faster**) | 1.25 s (2.0× slower) |
| 1000 x 16 KiB | 106 ms | 18.8 ms (**5.9× faster**) | 69.0 ms (**1.7× faster**) | 68.2 ms (**1.8× faster**) | 63.9 ms (**1.9× faster**) | 63.9 ms (**1.9× faster**) | 78.7 ms (**29% faster**) |
| 1000 x 16 KiB, a process each | 1.16 s | 1.11 s (**4% faster**) | 1.03 s (**11% faster**) | 1.11 s (**4% faster**) | 806 ms (**31% faster**) | 808 ms (**30% faster**) | 826 ms (**29% faster**) |
| mixed tree, 1000 files, 74 MiB | 161 ms | 33.2 ms (**4.9× faster**) | 207 ms (28% slower) | 102 ms (**1.6× faster**) | 168 ms (4% slower) | 169 ms (5% slower) | 227 ms (41% slower) |
| 16 x 64 MiB | 624 ms | 347 ms (**1.8× faster**) | 615 ms (same) | 337 ms (**1.9× faster**) | 457 ms (**27% faster**) | 468 ms (**25% faster**) | 1.26 s (2.0× slower) |

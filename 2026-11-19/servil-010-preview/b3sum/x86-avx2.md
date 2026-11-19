# b3sum on 2× EPYC 7443 (all 10 workloads)

Host `x86-avx2` (AMD EPYC 7443 24-Core Processor, 96 CPUs, linux7.0.0-42-generic); files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.00 CPUs busy on average, 0.11 in the busiest window. Runs: 15 rounds, each contender once on each input in each.

## In memory (page cache)

*Wall time per run; parenthesized comparison is against BLAKE3-Servil 0.9.0.*

| Workload | BLAKE3-Servil 0.9.0 | BLAKE3-Servil 0.8.0 | BLAKE3-Servil 0.10.0 | Official b3sum 1.8.7 |
|---|---:|---:|---:|---:|
| 4 KiB | 1.02 ms | 1.00 ms (same) | 1.02 ms (same) | 4.08 ms (4.1× slower) |
| 64 KiB | 876 μs | 831 μs (same) | 849 μs (same) | 3.75 ms (4.3× slower) |
| 1 MiB | 1.31 ms | 1.32 ms (same) | 1.16 ms (**12% faster**) | 3.88 ms (3.0× slower) |
| 16 MiB | 2.18 ms | 2.11 ms (same) | 2.22 ms (same) | 4.62 ms (2.1× slower) |
| 256 MiB | 6.48 ms | 6.56 ms (same) | 6.65 ms (same) | 13.4 ms (2.0× slower) |
| 1 GiB | 18.1 ms | 17.9 ms (same) | 18.3 ms (same) | 43.2 ms (2.4× slower) |
| 1000 x 16 KiB | 5.01 ms | 4.94 ms (same) | 4.57 ms (**9% faster**) | 34.8 ms (7.0× slower) |
| 1000 x 16 KiB, a process each | 604 ms | 582 ms (**4% faster**) | 641 ms (6% slower) | 3.06 s (5.1× slower) |
| mixed tree, 1000 files, 74 MiB | 7.25 ms | 6.94 ms (same) | 7.29 ms (same) | 48.3 ms (6.7× slower) |
| 16 x 64 MiB | 22.0 ms | 21.3 ms (same) | 18.1 ms (**18% faster**) | 53.6 ms (2.4× slower) |

## From disk (evicted before each run)

*Wall time per run; parenthesized comparison is against BLAKE3-Servil 0.9.0.*

| Workload | BLAKE3-Servil 0.9.0 | BLAKE3-Servil 0.8.0 | BLAKE3-Servil 0.10.0 | Official b3sum 1.8.7 |
|---|---:|---:|---:|---:|
| 4 KiB | 995 μs | 1.01 ms (same) | 1.07 ms (same) | 4.05 ms (4.1× slower) |
| 64 KiB | 1.11 ms | 1.09 ms (same) | 1.20 ms (same) | 3.83 ms (3.5× slower) |
| 1 MiB | 2.88 ms | 2.88 ms (same) | 3.05 ms (same) | 4.54 ms (1.6× slower) |
| 16 MiB | 6.01 ms | 5.76 ms (same) | 6.74 ms (12% slower) | 8.99 ms (50% slower) |
| 256 MiB | 60.8 ms | 61.1 ms (same) | 38.8 ms (**1.6× faster**) | 64.5 ms (6% slower) |
| 1 GiB | 232 ms | 232 ms (same) | 131 ms (**1.8× faster**) | 237 ms (same) |
| 1000 x 16 KiB | 9.80 ms | 9.62 ms (same) | 9.64 ms (same) | 219 ms (22× slower) |
| 1000 x 16 KiB, a process each | 807 ms | 784 ms (same) | 847 ms (5% slower) | 3.27 s (4.0× slower) |
| mixed tree, 1000 files, 74 MiB | 22.8 ms | 22.9 ms (same) | 20.4 ms (**10% faster**) | 213 ms (9.3× slower) |
| 16 x 64 MiB | 230 ms | 230 ms (same) | 164 ms (**29% faster**) | 276 ms (20% slower) |

---

# Quick suite on 2× EPYC 7443 (5 rounds, includes 100 x 16 KiB)

Host `x86-avx2` (AMD EPYC 7443 24-Core Processor, 96 CPUs, linux7.0.0-42-generic); files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.01 CPUs busy on average, 0.04 in the busiest window. Runs: 5 rounds, each contender once on each input in each (--quick: a check, not a record).

## In memory (page cache)

*Wall time per run; parenthesized comparison is against BLAKE3-Servil 0.9.0.*

| Workload | BLAKE3-Servil 0.9.0 | BLAKE3-Servil 0.8.0 | BLAKE3-Servil 0.10.0 | Official b3sum 1.8.7 |
|---|---:|---:|---:|---:|
| 4 KiB | 768 μs | 687 μs (same) | 791 μs (same) | 3.29 ms (4.3× slower) |
| 1 MiB | 1.19 ms | 1.15 ms (same) | 1.07 ms (same) | 3.62 ms (3.0× slower) |
| 16 MiB | 2.00 ms | 1.96 ms (same) | 2.13 ms (same) | 4.87 ms (2.4× slower) |
| 100 x 16 KiB | 1.69 ms | 1.50 ms (**11% faster**) | 1.88 ms (11% slower) | 6.78 ms (4.0× slower) |
| 100 x 16 KiB, a process each | 61.1 ms | 58.7 ms (**4% faster**) | 65.0 ms (6% slower) | 309 ms (5.1× slower) |
| mixed tree, 100 files, 5 MiB | 2.32 ms | 2.05 ms (same) | 2.25 ms (same) | 8.37 ms (3.6× slower) |
| 4 x 16 MiB | 3.94 ms | 3.84 ms (same) | 2.87 ms (**27% faster**) | 7.88 ms (2.0× slower) |

## From disk (evicted before each run)

*Wall time per run; parenthesized comparison is against BLAKE3-Servil 0.9.0.*

| Workload | BLAKE3-Servil 0.9.0 | BLAKE3-Servil 0.8.0 | BLAKE3-Servil 0.10.0 | Official b3sum 1.8.7 |
|---|---:|---:|---:|---:|
| 4 KiB | 822 μs | 773 μs (same) | 843 μs (same) | 3.20 ms (3.9× slower) |
| 1 MiB | 2.75 ms | 2.63 ms (same) | 2.93 ms (same) | 4.58 ms (1.7× slower) |
| 16 MiB | 5.62 ms | 5.76 ms (same) | 6.75 ms (20% slower) | 8.48 ms (1.5× slower) |
| 100 x 16 KiB | 2.30 ms | 2.21 ms (same) | 2.68 ms (17% slower) | 24.9 ms (11× slower) |
| 100 x 16 KiB, a process each | 81.2 ms | 79.1 ms (same) | 84.9 ms (4% slower) | 332 ms (4.1× slower) |
| mixed tree, 100 files, 5 MiB | 4.86 ms | 4.88 ms (same) | 4.83 ms (same) | 24.5 ms (5.0× slower) |
| 4 x 16 MiB | 21.9 ms | 22.8 ms (same) | 13.1 ms (**1.7× faster**) | 31.1 ms (42% slower) |

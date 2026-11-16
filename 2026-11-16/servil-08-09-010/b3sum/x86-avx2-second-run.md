# The second run of b3sum 0.8.0, 0.9.0 and the 0.10 candidate: AMD EPYC 7443 24-Core Processor, 96 CPUs, linux7.0.0-42-generic

Host `x86-avx2`; files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.00 CPUs busy on average, 0.09 in the busiest window. Runs: 15 rounds, each contender once on each input in each.

Each cell: mean time per run from the process's start to its exit, then the time ratio against `b3sum-0.9.0` (the geometric mean of the rounds' ratios; below 1 is faster). The words slower and faster appear where the rounds' pairs agree; an unmarked ratio is insufficient evidence of a difference. Copied from `b3sum.stdout.txt` in this host's `evolution-010-b3sum-again` evidence folder.

## Files in the page cache (warm: read moments before)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10-candidate | official |
|---|---:|---:|---:|---:|
| 4 KiB | 1.06 ms | 1.01 ms ×0.951 | 1.04 ms ×0.967 | 7.90 ms ×7.427 slower |
| 64 KiB | 902 μs | 990 μs ×1.092 | 959 μs ×1.067 | 7.68 ms ×8.566 slower |
| 1 MiB | 1.54 ms | 1.67 ms ×1.074 | 1.43 ms ×0.911 | 8.18 ms ×5.329 slower |
| 16 MiB | 4.45 ms | 4.17 ms ×0.939 faster | 4.35 ms ×0.979 | 11.1 ms ×2.530 slower |
| 256 MiB | 10.3 ms | 10.3 ms ×0.989 | 9.87 ms ×0.957 | 23.2 ms ×2.279 slower |
| 1 GiB | 19.7 ms | 20.7 ms ×1.056 | 19.1 ms ×0.985 | 56.4 ms ×2.870 slower |
| 1000 x 16 KiB | 6.38 ms | 6.58 ms ×1.022 | 5.39 ms ×0.855 faster | 62.1 ms ×9.804 slower |
| 1000 x 16 KiB, a process each | 638 ms | 614 ms ×0.963 faster | 647 ms ×1.013 | 7.34 s ×11.515 slower |
| mixed tree, 1000 files, 74 MiB | 9.69 ms | 8.67 ms ×0.897 faster | 9.67 ms ×0.998 | 98.2 ms ×10.106 slower |
| 16 x 64 MiB | 33.1 ms | 34.7 ms ×0.989 | 20.9 ms ×0.652 faster | 94.5 ms ×2.992 slower |

## Files read from storage (cold: evicted from the page cache before each run)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10-candidate | official |
|---|---:|---:|---:|---:|
| 4 KiB | 1.13 ms | 1.08 ms ×0.957 | 1.04 ms ×0.935 | 7.11 ms ×6.444 slower |
| 64 KiB | 1.08 ms | 1.11 ms ×1.024 | 1.14 ms ×1.051 | 6.90 ms ×6.420 slower |
| 1 MiB | 3.51 ms | 3.80 ms ×1.078 | 3.80 ms ×1.075 | 9.35 ms ×2.644 slower |
| 16 MiB | 10.7 ms | 10.7 ms ×0.999 | 8.62 ms ×0.807 faster | 18.8 ms ×1.751 slower |
| 256 MiB | 66.6 ms | 66.9 ms ×1.005 | 41.3 ms ×0.618 faster | 76.3 ms ×1.145 slower |
| 1 GiB | 247 ms | 248 ms ×1.002 | 133 ms ×0.536 faster | 261 ms ×1.054 slower |
| 1000 x 16 KiB | 10.3 ms | 9.97 ms ×0.965 | 10.9 ms ×1.051 slower | 232 ms ×22.430 slower |
| 1000 x 16 KiB, a process each | 840 ms | 821 ms ×0.977 | 850 ms ×1.012 | 7.55 s ×8.985 slower |
| mixed tree, 1000 files, 74 MiB | 25.3 ms | 25.5 ms ×1.010 | 25.6 ms ×1.009 | 273 ms ×10.838 slower |
| 16 x 64 MiB | 269 ms | 268 ms ×0.999 | 173 ms ×0.641 faster | 378 ms ×1.407 slower |

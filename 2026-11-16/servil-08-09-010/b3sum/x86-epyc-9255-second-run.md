# The second run of b3sum 0.8.0, 0.9.0 and the 0.10 candidate: AMD EPYC 9255 24-Core Processor, 48 CPUs, linux7.0.0-43-generic

Host `x86-epyc-9255`; files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.00 CPUs busy on average, 0.06 in the busiest window. Runs: 15 rounds, each contender once on each input in each.

Each cell: mean time per run from the process's start to its exit, then the time ratio against `b3sum-0.9.0` (the geometric mean of the rounds' ratios; below 1 is faster). The words slower and faster appear where the rounds' pairs agree; an unmarked ratio is insufficient evidence of a difference. Copied from `b3sum.stdout.txt` in this host's `evolution-010-b3sum-again` evidence folder.

## Files in the page cache (warm: read moments before)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10-candidate | official |
|---|---:|---:|---:|---:|
| 4 KiB | 471 μs | 485 μs ×1.027 | 494 μs ×1.046 | 2.01 ms ×4.313 slower |
| 64 KiB | 449 μs | 432 μs ×0.962 | 440 μs ×0.975 | 1.91 ms ×4.295 slower |
| 1 MiB | 714 μs | 691 μs ×0.968 | 588 μs ×0.825 faster | 2.01 ms ×2.830 slower |
| 16 MiB | 1.31 ms | 1.24 ms ×0.951 | 1.41 ms ×1.054 | 2.58 ms ×1.978 slower |
| 256 MiB | 3.19 ms | 3.05 ms ×0.957 | 3.21 ms ×1.004 | 7.06 ms ×2.155 slower |
| 1 GiB | 7.74 ms | 7.81 ms ×1.007 | 7.78 ms ×1.006 | 19.5 ms ×2.448 slower |
| 1000 x 16 KiB | 3.02 ms | 2.85 ms ×0.944 | 2.57 ms ×0.852 faster | 9.92 ms ×3.286 slower |
| 1000 x 16 KiB, a process each | 243 ms | 233 ms ×0.957 faster | 242 ms ×0.997 | 1.59 s ×6.520 slower |
| mixed tree, 1000 files, 74 MiB | 4.01 ms | 3.58 ms ×0.900 faster | 3.54 ms ×0.885 faster | 23.3 ms ×5.856 slower |
| 16 x 64 MiB | 10.9 ms | 10.7 ms ×0.968 | 7.63 ms ×0.698 faster | 27.8 ms ×2.475 slower |

## Files read from storage (cold: evicted from the page cache before each run)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10-candidate | official |
|---|---:|---:|---:|---:|
| 4 KiB | 604 μs | 608 μs ×1.016 | 616 μs ×1.027 | 2.37 ms ×3.881 slower |
| 64 KiB | 556 μs | 525 μs ×0.945 | 582 μs ×1.040 | 1.98 ms ×3.575 slower |
| 1 MiB | 1.09 ms | 990 μs ×0.915 | 1.12 ms ×1.022 | 2.45 ms ×2.257 slower |
| 16 MiB | 4.44 ms | 4.42 ms ×0.997 | 2.89 ms ×0.651 faster | 6.27 ms ×1.410 slower |
| 256 MiB | 30.7 ms | 30.2 ms ×0.981 | 22.5 ms ×0.734 faster | 32.4 ms ×1.054 slower |
| 1 GiB | 110 ms | 110 ms ×1.000 | 84.5 ms ×0.769 faster | 111 ms ×1.008 |
| 1000 x 16 KiB | 4.44 ms | 4.68 ms ×1.051 | 4.10 ms ×0.928 faster | 86.0 ms ×19.447 slower |
| 1000 x 16 KiB, a process each | 333 ms | 322 ms ×0.964 faster | 333 ms ×0.999 | 1.66 s ×4.985 slower |
| mixed tree, 1000 files, 74 MiB | 12.3 ms | 12.3 ms ×0.998 | 9.97 ms ×0.813 faster | 97.8 ms ×7.943 slower |
| 16 x 64 MiB | 114 ms | 115 ms ×1.007 | 87.1 ms ×0.765 faster | 168 ms ×1.479 slower |

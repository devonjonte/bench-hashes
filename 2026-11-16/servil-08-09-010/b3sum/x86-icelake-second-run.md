# The second run of b3sum 0.8.0, 0.9.0 and the 0.10 candidate: Intel(R) Xeon(R) Gold 6330 CPU @ 2.00GHz, 112 CPUs, linux7.0.0-43-generic

Host `x86-icelake`; files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.00 CPUs busy on average, 0.08 in the busiest window. Runs: 15 rounds, each contender once on each input in each.

Each cell: mean time per run from the process's start to its exit, then the time ratio against `b3sum-0.9.0` (the geometric mean of the rounds' ratios; below 1 is faster). The words slower and faster appear where the rounds' pairs agree; an unmarked ratio is insufficient evidence of a difference. Copied from `b3sum.stdout.txt` in this host's `evolution-010-b3sum-again` evidence folder.

## Files in the page cache (warm: read moments before)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10-candidate | official |
|---|---:|---:|---:|---:|
| 4 KiB | 868 μs | 823 μs ×0.948 | 859 μs ×0.992 | 6.45 ms ×7.472 slower |
| 64 KiB | 806 μs | 772 μs ×0.957 faster | 821 μs ×1.019 | 6.11 ms ×7.582 slower |
| 1 MiB | 1.22 ms | 1.16 ms ×0.948 faster | 1.21 ms ×0.979 | 6.64 ms ×5.431 slower |
| 16 MiB | 2.71 ms | 2.62 ms ×0.971 | 2.69 ms ×0.996 | 7.81 ms ×2.907 slower |
| 256 MiB | 6.88 ms | 6.91 ms ×1.000 | 6.90 ms ×1.003 | 17.4 ms ×2.528 slower |
| 1 GiB | 18.2 ms | 18.0 ms ×0.990 | 18.5 ms ×1.018 | 46.8 ms ×2.585 slower |
| 1000 x 16 KiB | 5.69 ms | 5.48 ms ×0.963 | 4.55 ms ×0.800 faster | 24.1 ms ×4.234 slower |
| 1000 x 16 KiB, a process each | 600 ms | 571 ms ×0.950 faster | 613 ms ×1.021 | 5.84 s ×9.718 slower |
| mixed tree, 1000 files, 74 MiB | 7.82 ms | 7.70 ms ×0.986 | 6.93 ms ×0.886 faster | 58.6 ms ×7.510 slower |
| 16 x 64 MiB | 24.6 ms | 24.9 ms ×1.010 | 17.3 ms ×0.700 faster | 64.5 ms ×2.611 slower |

## Files read from storage (cold: evicted from the page cache before each run)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10-candidate | official |
|---|---:|---:|---:|---:|
| 4 KiB | 926 μs | 906 μs ×0.976 | 943 μs ×1.015 | 6.45 ms ×7.007 slower |
| 64 KiB | 985 μs | 929 μs ×0.945 | 998 μs ×1.010 | 6.21 ms ×6.329 slower |
| 1 MiB | 1.98 ms | 1.88 ms ×0.952 | 1.90 ms ×0.963 | 6.93 ms ×3.511 slower |
| 16 MiB | 7.38 ms | 7.32 ms ×0.992 | 5.99 ms ×0.810 faster | 13.6 ms ×1.838 slower |
| 256 MiB | 52.4 ms | 52.2 ms ×0.996 | 35.9 ms ×0.684 faster | 61.6 ms ×1.174 slower |
| 1 GiB | 196 ms | 195 ms ×0.994 | 125 ms ×0.639 faster | 202 ms ×1.031 slower |
| 1000 x 16 KiB | 7.09 ms | 6.87 ms ×0.969 faster | 7.07 ms ×0.996 | 68.7 ms ×9.682 slower |
| 1000 x 16 KiB, a process each | 654 ms | 623 ms ×0.952 faster | 667 ms ×1.020 | 5.89 s ×9.001 slower |
| mixed tree, 1000 files, 74 MiB | 18.9 ms | 18.9 ms ×0.999 | 19.3 ms ×1.021 | 146 ms ×7.708 slower |
| 16 x 64 MiB | 203 ms | 203 ms ×1.001 | 144 ms ×0.710 faster | 300 ms ×1.475 slower |

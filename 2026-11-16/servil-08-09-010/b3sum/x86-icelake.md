# b3sum 0.8.0, 0.9.0 and the 0.10 candidate: Intel(R) Xeon(R) Gold 6330 CPU @ 2.00GHz, 112 CPUs, linux7.0.0-43-generic

Host `x86-icelake`; files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.00 CPUs busy on average, 0.09 in the busiest window. Runs: 15 rounds, each contender once on each input in each.

Each cell: mean time per run from the process's start to its exit, then the time ratio against `b3sum-0.9.0` (the geometric mean of the rounds' ratios; below 1 is faster). The words slower and faster appear where the rounds' pairs agree; an unmarked ratio is insufficient evidence of a difference. Copied from `b3sum.stdout.txt` in this host's evidence folder.

## Files in the page cache (warm: read moments before)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10-candidate | official |
|---|---:|---:|---:|---:|
| 4 KiB | 866 μs | 818 μs ×0.947 | 857 μs ×0.991 | 6.39 ms ×7.421 slower |
| 64 KiB | 797 μs | 763 μs ×0.957 faster | 809 μs ×1.015 | 6.10 ms ×7.653 slower |
| 1 MiB | 1.21 ms | 1.19 ms ×0.979 | 1.24 ms ×1.002 | 6.60 ms ×5.444 slower |
| 16 MiB | 2.76 ms | 2.57 ms ×0.935 faster | 2.70 ms ×0.982 | 7.69 ms ×2.811 slower |
| 256 MiB | 6.98 ms | 6.96 ms ×0.995 | 6.98 ms ×1.000 | 17.2 ms ×2.450 slower |
| 1 GiB | 19.2 ms | 19.6 ms ×1.014 | 19.2 ms ×1.001 | 48.6 ms ×2.543 slower |
| 1000 x 16 KiB | 5.61 ms | 5.42 ms ×0.965 | 4.57 ms ×0.814 faster | 23.9 ms ×4.259 slower |
| 1000 x 16 KiB, a process each | 601 ms | 571 ms ×0.950 faster | 614 ms ×1.022 | 5.84 s ×9.725 slower |
| mixed tree, 1000 files, 74 MiB | 7.71 ms | 7.60 ms ×0.989 | 6.93 ms ×0.900 faster | 58.6 ms ×7.620 slower |
| 16 x 64 MiB | 25.0 ms | 25.2 ms ×1.005 | 18.0 ms ×0.714 faster | 64.2 ms ×2.558 slower |

## Files read from storage (cold: evicted from the page cache before each run)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10-candidate | official |
|---|---:|---:|---:|---:|
| 4 KiB | 936 μs | 903 μs ×0.961 | 924 μs ×0.985 | 6.45 ms ×6.922 slower |
| 64 KiB | 976 μs | 912 μs ×0.933 | 985 μs ×1.004 | 6.33 ms ×6.509 slower |
| 1 MiB | 1.93 ms | 1.89 ms ×0.977 | 1.94 ms ×1.005 | 6.87 ms ×3.570 slower |
| 16 MiB | 7.43 ms | 7.33 ms ×0.987 | 5.78 ms ×0.778 faster | 13.6 ms ×1.827 slower |
| 256 MiB | 52.5 ms | 52.2 ms ×0.994 | 35.8 ms ×0.681 faster | 62.5 ms ×1.190 slower |
| 1 GiB | 195 ms | 195 ms ×0.998 | 124 ms ×0.637 faster | 202 ms ×1.037 slower |
| 1000 x 16 KiB | 7.15 ms | 6.85 ms ×0.958 faster | 7.14 ms ×0.999 | 68.0 ms ×9.526 slower |
| 1000 x 16 KiB, a process each | 655 ms | 624 ms ×0.952 faster | 668 ms ×1.020 | 5.89 s ×8.996 slower |
| mixed tree, 1000 files, 74 MiB | 19.0 ms | 19.0 ms ×1.004 | 19.4 ms ×1.023 | 145 ms ×7.670 slower |
| 16 x 64 MiB | 179 ms | 178 ms ×0.994 | 126 ms ×0.702 faster | 305 ms ×1.704 slower |

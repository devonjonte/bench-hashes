# b3sum 0.8.0, 0.9.0 and the 0.10 candidate: Intel(R) Xeon(R) Gold 6330 CPU @ 2.00GHz, 112 CPUs, linux7.0.0-43-generic

Host `x86-icelake`; files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.00 CPUs busy on average, 0.07 in the busiest window. Runs: 15 rounds, each contender once on each input in each.

Each cell: mean time per run from the process's start to its exit, then the time ratio against `b3sum-0.9.0` (the geometric mean of the rounds' ratios; below 1 is faster). The words slower and faster appear where the rounds' pairs agree; an unmarked ratio is insufficient evidence of a difference. Copied from `b3sum.stdout.txt` in this host's evidence folder.

## Files in the page cache (warm: read moments before)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10.0 | official |
|---|---:|---:|---:|---:|
| 4 KiB | 858 μs | 818 μs ×0.951 | 895 μs ×1.042 | 6.48 ms ×7.586 slower |
| 64 KiB | 799 μs | 780 μs ×0.976 | 834 μs ×1.044 slower | 6.08 ms ×7.616 slower |
| 1 MiB | 1.22 ms | 1.21 ms ×0.990 | 1.19 ms ×0.970 | 6.63 ms ×5.446 slower |
| 16 MiB | 2.76 ms | 2.59 ms ×0.943 faster | 2.71 ms ×0.989 | 7.81 ms ×2.861 slower |
| 256 MiB | 6.97 ms | 6.91 ms ×0.988 | 6.93 ms ×0.995 | 17.4 ms ×2.495 slower |
| 1 GiB | 18.5 ms | 18.3 ms ×0.991 | 18.6 ms ×1.004 | 49.4 ms ×2.676 slower |
| 1000 x 16 KiB | 5.84 ms | 5.45 ms ×0.945 | 4.62 ms ×0.799 faster | 24.1 ms ×4.175 slower |
| 1000 x 16 KiB, a process each | 601 ms | 570 ms ×0.949 faster | 625 ms ×1.039 slower | 5.84 s ×9.726 slower |
| mixed tree, 1000 files, 74 MiB | 7.93 ms | 7.54 ms ×0.952 faster | 6.92 ms ×0.873 faster | 58.3 ms ×7.357 slower |
| 16 x 64 MiB | 24.9 ms | 24.8 ms ×0.997 | 17.6 ms ×0.700 faster | 65.6 ms ×2.622 slower |

## Files read from storage (cold: evicted from the page cache before each run)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10.0 | official |
|---|---:|---:|---:|---:|
| 4 KiB | 925 μs | 893 μs ×0.968 | 957 μs ×1.032 | 6.37 ms ×6.932 slower |
| 64 KiB | 932 μs | 929 μs ×0.993 | 990 μs ×1.058 | 6.18 ms ×6.648 slower |
| 1 MiB | 1.85 ms | 1.86 ms ×1.005 | 1.95 ms ×1.050 slower | 6.83 ms ×3.694 slower |
| 16 MiB | 7.45 ms | 7.21 ms ×0.968 faster | 5.87 ms ×0.788 faster | 13.6 ms ×1.823 slower |
| 256 MiB | 52.4 ms | 51.6 ms ×0.984 | 35.5 ms ×0.677 faster | 62.1 ms ×1.183 slower |
| 1 GiB | 195 ms | 194 ms ×0.995 | 125 ms ×0.640 faster | 202 ms ×1.037 slower |
| 1000 x 16 KiB | 7.09 ms | 6.91 ms ×0.974 | 7.05 ms ×0.994 | 68.5 ms ×9.656 slower |
| 1000 x 16 KiB, a process each | 655 ms | 623 ms ×0.951 faster | 679 ms ×1.036 slower | 5.89 s ×9.000 slower |
| mixed tree, 1000 files, 74 MiB | 18.8 ms | 18.9 ms ×1.005 | 19.2 ms ×1.024 | 146 ms ×7.786 slower |
| 16 x 64 MiB | 204 ms | 203 ms ×0.997 | 144 ms ×0.708 faster | 299 ms ×1.468 slower |


---

# Quick suite (5 rounds, includes `100 x 16 KiB`): Intel(R) Xeon(R) Gold 6330 CPU @ 2.00GHz, 112 CPUs, linux7.0.0-43-generic

Host `x86-icelake`; files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.00 CPUs busy on average, 0.03 in the busiest window. Runs: 5 rounds, each contender once on each input in each (--quick: a check, not a record).

Each cell: mean time per run from the process's start to its exit, then the time ratio against `b3sum-0.9.0` (the geometric mean of the rounds' ratios; below 1 is faster). The words slower and faster appear where the rounds' pairs agree; an unmarked ratio is insufficient evidence of a difference. Copied from `b3sum.stdout.txt` in this host's evidence folder.

## Files in the page cache (warm: read moments before)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10.0 | official |
|---|---:|---:|---:|---:|
| 4 KiB | 847 μs | 814 μs ×0.961 | 854 μs ×1.006 | 6.19 ms ×7.312 slower |
| 1 MiB | 1.26 ms | 1.24 ms ×0.984 | 1.13 ms ×0.904 faster | 6.65 ms ×5.295 slower |
| 16 MiB | 2.67 ms | 2.64 ms ×0.990 | 2.76 ms ×1.033 | 7.75 ms ×2.915 slower |
| 100 x 16 KiB | 1.68 ms | 1.61 ms ×0.955 | 1.80 ms ×1.073 slower | 7.73 ms ×4.601 slower |
| 100 x 16 KiB, a process each | 64.0 ms | 60.9 ms ×0.951 | 66.8 ms ×1.043 | 588 ms ×9.184 slower |
| mixed tree, 100 files, 5 MiB | 2.40 ms | 2.18 ms ×0.907 | 2.31 ms ×0.964 | 11.2 ms ×4.701 slower |
| 4 x 16 MiB | 5.38 ms | 5.19 ms ×0.967 | 3.02 ms ×0.570 faster | 12.3 ms ×2.296 slower |

## Files read from storage (cold: evicted from the page cache before each run)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10.0 | official |
|---|---:|---:|---:|---:|
| 4 KiB | 887 μs | 833 μs ×0.940 | 887 μs ×1.001 | 6.27 ms ×7.090 slower |
| 1 MiB | 1.97 ms | 1.84 ms ×0.932 | 1.87 ms ×0.950 | 6.92 ms ×3.510 slower |
| 16 MiB | 7.43 ms | 7.43 ms ×1.000 | 5.87 ms ×0.789 faster | 13.4 ms ×1.802 slower |
| 100 x 16 KiB | 2.02 ms | 1.87 ms ×0.927 | 2.63 ms ×1.302 slower | 11.4 ms ×5.650 slower |
| 100 x 16 KiB, a process each | 69.0 ms | 65.7 ms ×0.951 | 71.7 ms ×1.038 slower | 594 ms ×8.598 slower |
| mixed tree, 100 files, 5 MiB | 3.91 ms | 3.76 ms ×0.966 | 4.37 ms ×1.117 | 17.5 ms ×4.516 slower |
| 4 x 16 MiB | 18.7 ms | 18.7 ms ×1.003 | 12.8 ms ×0.683 faster | 36.9 ms ×1.974 slower |

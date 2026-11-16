# b3sum 0.8.0, 0.9.0 and the 0.10 candidate: Intel(R) Xeon(R) Gold 6330 CPU @ 2.00GHz, 112 CPUs, linux7.0.0-43-generic

Host `x86-icelake-2`; files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.00 CPUs busy on average, 0.05 in the busiest window. Runs: 15 rounds, each contender once on each input in each.

Each cell: mean time per run from the process's start to its exit, then the time ratio against `b3sum-0.9.0` (the geometric mean of the rounds' ratios; below 1 is faster). The words slower and faster appear where the rounds' pairs agree; an unmarked ratio is insufficient evidence of a difference. Copied from `b3sum.stdout.txt` in this host's evidence folder.

## Files in the page cache (warm: read moments before)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10-candidate | official |
|---|---:|---:|---:|---:|
| 4 KiB | 859 μs | 815 μs ×0.951 | 860 μs ×1.002 | 6.43 ms ×7.528 slower |
| 64 KiB | 800 μs | 769 μs ×0.961 faster | 820 μs ×1.024 | 6.04 ms ×7.550 slower |
| 1 MiB | 1.22 ms | 1.18 ms ×0.966 | 1.19 ms ×0.966 | 6.58 ms ×5.385 slower |
| 16 MiB | 2.71 ms | 2.56 ms ×0.947 faster | 2.66 ms ×0.985 | 7.70 ms ×2.865 slower |
| 256 MiB | 6.87 ms | 6.88 ms ×0.998 | 6.91 ms ×1.007 | 17.0 ms ×2.480 slower |
| 1 GiB | 19.0 ms | 18.6 ms ×0.975 | 19.0 ms ×0.998 | 46.5 ms ×2.464 slower |
| 1000 x 16 KiB | 5.62 ms | 5.39 ms ×0.958 faster | 4.54 ms ×0.808 faster | 24.0 ms ×4.260 slower |
| 1000 x 16 KiB, a process each | 600 ms | 570 ms ×0.950 faster | 612 ms ×1.020 | 5.81 s ×9.691 slower |
| mixed tree, 1000 files, 74 MiB | 7.96 ms | 7.35 ms ×0.925 faster | 6.87 ms ×0.865 faster | 58.1 ms ×7.316 slower |
| 16 x 64 MiB | 23.8 ms | 23.6 ms ×0.994 | 17.8 ms ×0.740 faster | 63.3 ms ×2.648 slower |

## Files read from storage (cold: evicted from the page cache before each run)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10-candidate | official |
|---|---:|---:|---:|---:|
| 4 KiB | 941 μs | 913 μs ×0.972 | 953 μs ×1.012 | 6.69 ms ×7.098 slower |
| 64 KiB | 950 μs | 918 μs ×0.966 | 1.01 ms ×1.058 | 6.20 ms ×6.542 slower |
| 1 MiB | 1.80 ms | 1.74 ms ×0.971 | 1.85 ms ×1.028 | 6.68 ms ×3.723 slower |
| 16 MiB | 7.26 ms | 7.13 ms ×0.982 | 6.09 ms ×0.839 faster | 13.1 ms ×1.798 slower |
| 256 MiB | 57.2 ms | 56.8 ms ×0.993 | 46.4 ms ×0.811 faster | 64.9 ms ×1.135 slower |
| 1 GiB | 213 ms | 213 ms ×0.999 | 173 ms ×0.811 faster | 222 ms ×1.041 slower |
| 1000 x 16 KiB | 7.36 ms | 7.15 ms ×0.971 | 7.16 ms ×0.972 | 110 ms ×14.981 slower |
| 1000 x 16 KiB, a process each | 738 ms | 704 ms ×0.954 faster | 751 ms ×1.018 | 5.93 s ×8.043 slower |
| mixed tree, 1000 files, 74 MiB | 19.7 ms | 19.8 ms ×1.005 | 20.1 ms ×1.018 | 149 ms ×7.562 slower |
| 16 x 64 MiB | 222 ms | 222 ms ×1.000 | 180 ms ×0.810 faster | 281 ms ×1.265 slower |

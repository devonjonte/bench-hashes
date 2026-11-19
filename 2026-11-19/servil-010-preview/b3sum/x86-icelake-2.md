# b3sum on 2× Xeon Gold 6330 (b) (0.9.0, 0.8.0, 0.10.0, and official 1.8.7): Intel(R) Xeon(R) Gold 6330 CPU @ 2.00GHz, 112 CPUs, linux7.0.0-43-generic

Host `x86-icelake-2`; files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.00 CPUs busy on average, 0.03 in the busiest window. Runs: 15 rounds, each contender once on each input in each.

Each cell: mean time per run from the process's start to its exit, then the time ratio against `b3sum-0.9.0` (the geometric mean of the rounds' ratios; below 1 is faster). The words slower and faster appear where the rounds' pairs agree; an unmarked ratio is insufficient evidence of a difference. Copied from `b3sum.stdout.txt` in this host's evidence folder.

## Files in the page cache (warm: read moments before)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10.0 | official |
|---|---:|---:|---:|---:|
| 4 KiB | 821 μs | 777 μs ×0.947 | 800 μs ×0.975 | 3.36 ms ×4.103 slower |
| 64 KiB | 792 μs | 749 μs ×0.946 faster | 788 μs ×0.995 | 3.11 ms ×3.936 slower |
| 1 MiB | 1.18 ms | 1.12 ms ×0.953 | 1.29 ms ×1.070 | 3.31 ms ×2.816 slower |
| 16 MiB | 1.91 ms | 1.92 ms ×1.004 | 1.95 ms ×1.021 | 3.95 ms ×2.071 slower |
| 256 MiB | 6.37 ms | 6.29 ms ×0.990 | 6.16 ms ×0.970 | 11.9 ms ×1.854 slower |
| 1 GiB | 18.2 ms | 18.6 ms ×1.020 | 18.3 ms ×1.005 | 37.6 ms ×2.041 slower |
| 1000 x 16 KiB | 5.33 ms | 5.04 ms ×0.946 faster | 4.02 ms ×0.754 faster | 20.2 ms ×3.801 slower |
| 1000 x 16 KiB, a process each | 593 ms | 564 ms ×0.951 faster | 592 ms ×0.998 | 2.89 s ×4.878 slower |
| mixed tree, 1000 files, 74 MiB | 6.92 ms | 6.73 ms ×0.972 | 6.13 ms ×0.886 faster | 36.7 ms ×5.309 slower |
| 16 x 64 MiB | 21.3 ms | 21.0 ms ×0.985 | 18.3 ms ×0.862 faster | 45.1 ms ×2.106 slower |

## Files read from storage (cold: evicted from the page cache before each run)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10.0 | official |
|---|---:|---:|---:|---:|
| 4 KiB | 908 μs | 868 μs ×0.955 | 883 μs ×0.972 | 3.50 ms ×3.863 slower |
| 64 KiB | 954 μs | 891 μs ×0.935 faster | 944 μs ×0.990 | 3.27 ms ×3.435 slower |
| 1 MiB | 1.62 ms | 1.60 ms ×0.985 | 1.64 ms ×1.013 | 3.68 ms ×2.264 slower |
| 16 MiB | 4.96 ms | 4.88 ms ×0.984 | 5.95 ms ×1.200 slower | 7.58 ms ×1.530 slower |
| 256 MiB | 53.6 ms | 53.5 ms ×0.998 | 45.9 ms ×0.857 faster | 56.5 ms ×1.055 slower |
| 1 GiB | 206 ms | 206 ms ×0.998 | 173 ms ×0.839 faster | 210 ms ×1.018 |
| 1000 x 16 KiB | 7.46 ms | 7.35 ms ×0.986 | 7.10 ms ×0.952 faster | 107 ms ×14.341 slower |
| 1000 x 16 KiB, a process each | 734 ms | 700 ms ×0.953 faster | 730 ms ×0.994 | 3.00 s ×4.089 slower |
| mixed tree, 1000 files, 74 MiB | 17.9 ms | 17.7 ms ×0.990 | 19.1 ms ×1.066 slower | 130 ms ×7.268 slower |
| 16 x 64 MiB | 206 ms | 206 ms ×1.002 | 179 ms ×0.869 faster | 230 ms ×1.116 slower |


---

# Quick suite (5 rounds, includes `100 x 16 KiB`): Intel(R) Xeon(R) Gold 6330 CPU @ 2.00GHz, 112 CPUs, linux7.0.0-43-generic

Host `x86-icelake-2`; files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.00 CPUs busy on average, 0.01 in the busiest window. Runs: 5 rounds, each contender once on each input in each (--quick: a check, not a record).

Each cell: mean time per run from the process's start to its exit, then the time ratio against `b3sum-0.9.0` (the geometric mean of the rounds' ratios; below 1 is faster). The words slower and faster appear where the rounds' pairs agree; an unmarked ratio is insufficient evidence of a difference. Copied from `b3sum.stdout.txt` in this host's evidence folder.

## Files in the page cache (warm: read moments before)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10.0 | official |
|---|---:|---:|---:|---:|
| 4 KiB | 808 μs | 764 μs ×0.944 | 789 μs ×0.977 | 3.28 ms ×4.064 slower |
| 1 MiB | 1.18 ms | 1.12 ms ×0.953 | 1.23 ms ×1.032 | 3.48 ms ×2.953 slower |
| 16 MiB | 2.03 ms | 1.88 ms ×0.930 | 2.02 ms ×1.000 | 3.95 ms ×1.955 slower |
| 100 x 16 KiB | 1.63 ms | 1.50 ms ×0.921 faster | 1.75 ms ×1.071 slower | 4.72 ms ×2.893 slower |
| 100 x 16 KiB, a process each | 63.1 ms | 60.2 ms ×0.953 | 63.1 ms ×0.999 | 291 ms ×4.613 slower |
| mixed tree, 100 files, 5 MiB | 2.02 ms | 1.97 ms ×0.972 | 2.10 ms ×1.039 | 6.23 ms ×3.089 slower |
| 4 x 16 MiB | 3.57 ms | 3.74 ms ×1.041 | 3.10 ms ×0.866 | 6.94 ms ×1.933 slower |

## Files read from storage (cold: evicted from the page cache before each run)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10.0 | official |
|---|---:|---:|---:|---:|
| 4 KiB | 890 μs | 829 μs ×0.932 | 847 μs ×0.952 | 3.27 ms ×3.685 slower |
| 1 MiB | 1.61 ms | 1.64 ms ×1.017 | 1.63 ms ×1.011 | 3.66 ms ×2.273 slower |
| 16 MiB | 4.80 ms | 4.84 ms ×1.010 | 5.78 ms ×1.206 slower | 7.42 ms ×1.547 slower |
| 100 x 16 KiB | 1.93 ms | 1.83 ms ×0.947 | 2.36 ms ×1.226 slower | 14.0 ms ×7.243 slower |
| 100 x 16 KiB, a process each | 76.9 ms | 73.2 ms ×0.952 | 76.7 ms ×0.998 | 304 ms ×3.952 slower |
| mixed tree, 100 files, 5 MiB | 3.37 ms | 3.21 ms ×0.951 | 4.51 ms ×1.330 slower | 16.7 ms ×4.954 slower |
| 4 x 16 MiB | 16.0 ms | 16.0 ms ×1.001 | 14.1 ms ×0.884 faster | 21.4 ms ×1.340 slower |

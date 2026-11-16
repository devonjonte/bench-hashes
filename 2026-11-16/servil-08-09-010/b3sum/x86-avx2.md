# b3sum 0.8.0, 0.9.0 and the 0.10 candidate: AMD EPYC 7443 24-Core Processor, 96 CPUs, linux7.0.0-42-generic

Host `x86-avx2`; files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.00 CPUs busy on average, 0.09 in the busiest window. Runs: 15 rounds, each contender once on each input in each.

Each cell: mean time per run from the process's start to its exit, then the time ratio against `b3sum-0.9.0` (the geometric mean of the rounds' ratios; below 1 is faster). The words slower and faster appear where the rounds' pairs agree; an unmarked ratio is insufficient evidence of a difference. Copied from `b3sum.stdout.txt` in this host's evidence folder.

## Files in the page cache (warm: read moments before)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10.0 | official |
|---|---:|---:|---:|---:|
| 4 KiB | 1.09 ms | 1.05 ms ×0.970 | 961 μs ×0.880 faster | 8.41 ms ×7.544 slower |
| 64 KiB | 974 μs | 904 μs ×0.938 | 930 μs ×0.964 | 7.63 ms ×7.954 slower |
| 1 MiB | 1.68 ms | 1.65 ms ×0.997 | 1.31 ms ×0.786 faster | 8.54 ms ×5.181 slower |
| 16 MiB | 4.83 ms | 4.66 ms ×0.962 | 4.99 ms ×1.037 | 12.2 ms ×2.549 slower |
| 256 MiB | 10.7 ms | 9.90 ms ×0.947 | 10.1 ms ×0.962 | 23.7 ms ×2.289 slower |
| 1 GiB | 20.3 ms | 20.5 ms ×1.015 | 19.3 ms ×0.956 | 56.8 ms ×2.801 slower |
| 1000 x 16 KiB | 6.33 ms | 6.19 ms ×0.966 | 5.45 ms ×0.864 faster | 57.4 ms ×9.098 slower |
| 1000 x 16 KiB, a process each | 642 ms | 619 ms ×0.965 faster | 634 ms ×0.988 | 7.35 s ×11.455 slower |
| mixed tree, 1000 files, 74 MiB | 9.30 ms | 8.91 ms ×0.958 | 9.50 ms ×1.020 | 90.0 ms ×9.678 slower |
| 16 x 64 MiB | 41.9 ms | 34.0 ms ×0.823 | 21.0 ms ×0.558 faster | 96.8 ms ×2.600 slower |

## Files read from storage (cold: evicted from the page cache before each run)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10.0 | official |
|---|---:|---:|---:|---:|
| 4 KiB | 1.14 ms | 1.10 ms ×0.965 | 1.08 ms ×0.949 | 7.24 ms ×6.414 slower |
| 64 KiB | 1.14 ms | 1.14 ms ×0.990 | 1.18 ms ×1.027 | 7.00 ms ×6.144 slower |
| 1 MiB | 3.68 ms | 3.66 ms ×0.992 | 4.17 ms ×1.122 | 9.01 ms ×2.442 slower |
| 16 MiB | 10.6 ms | 10.7 ms ×1.002 | 8.56 ms ×0.806 faster | 19.1 ms ×1.793 slower |
| 256 MiB | 66.1 ms | 66.7 ms ×1.009 | 40.8 ms ×0.617 faster | 76.4 ms ×1.157 slower |
| 1 GiB | 249 ms | 248 ms ×0.996 | 132 ms ×0.532 faster | 261 ms ×1.051 slower |
| 1000 x 16 KiB | 10.2 ms | 9.85 ms ×0.965 | 10.8 ms ×1.060 slower | 230 ms ×22.519 slower |
| 1000 x 16 KiB, a process each | 848 ms | 828 ms ×0.977 | 842 ms ×0.993 | 7.55 s ×8.909 slower |
| mixed tree, 1000 files, 74 MiB | 25.2 ms | 25.2 ms ×0.999 | 25.0 ms ×0.989 | 275 ms ×10.939 slower |
| 16 x 64 MiB | 269 ms | 269 ms ×1.000 | 169 ms ×0.630 faster | 385 ms ×1.431 slower |


---

# Quick suite (5 rounds, includes `100 x 16 KiB`): AMD EPYC 7443 24-Core Processor, 96 CPUs, linux7.0.0-42-generic

Host `x86-avx2`; files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.00 CPUs busy on average, 0.00 in the busiest window. Runs: 5 rounds, each contender once on each input in each (--quick: a check, not a record).

Each cell: mean time per run from the process's start to its exit, then the time ratio against `b3sum-0.9.0` (the geometric mean of the rounds' ratios; below 1 is faster). The words slower and faster appear where the rounds' pairs agree; an unmarked ratio is insufficient evidence of a difference. Copied from `b3sum.stdout.txt` in this host's evidence folder.

## Files in the page cache (warm: read moments before)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10.0 | official |
|---|---:|---:|---:|---:|
| 4 KiB | 1.02 ms | 975 μs ×0.930 | 859 μs ×0.882 | 7.06 ms ×7.218 slower |
| 1 MiB | 1.43 ms | 1.44 ms ×0.991 | 1.30 ms ×0.909 | 7.64 ms ×5.342 slower |
| 16 MiB | 3.76 ms | 4.09 ms ×1.087 | 4.36 ms ×1.150 | 11.2 ms ×3.038 slower |
| 100 x 16 KiB | 2.09 ms | 1.93 ms ×0.922 | 2.18 ms ×1.049 | 13.4 ms ×6.414 slower |
| 100 x 16 KiB, a process each | 65.1 ms | 63.1 ms ×0.969 | 66.0 ms ×1.013 | 731 ms ×11.221 slower |
| mixed tree, 100 files, 5 MiB | 3.28 ms | 2.89 ms ×0.885 | 3.17 ms ×0.976 | 20.6 ms ×6.350 slower |
| 4 x 16 MiB | 6.83 ms | 6.41 ms ×0.935 | 5.15 ms ×0.752 | 16.4 ms ×2.422 slower |

## Files read from storage (cold: evicted from the page cache before each run)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10.0 | official |
|---|---:|---:|---:|---:|
| 4 KiB | 1.15 ms | 862 μs ×0.785 | 1.03 ms ×0.925 | 6.67 ms ×6.149 slower |
| 1 MiB | 4.18 ms | 3.19 ms ×0.766 | 3.43 ms ×0.824 faster | 9.36 ms ×2.243 slower |
| 16 MiB | 9.90 ms | 9.85 ms ×0.984 | 8.59 ms ×0.872 | 18.3 ms ×1.837 slower |
| 100 x 16 KiB | 2.73 ms | 2.63 ms ×0.969 | 3.03 ms ×1.119 | 29.2 ms ×10.777 slower |
| 100 x 16 KiB, a process each | 85.0 ms | 83.2 ms ×0.979 | 87.2 ms ×1.026 | 750 ms ×8.821 slower |
| mixed tree, 100 files, 5 MiB | 6.44 ms | 5.87 ms ×0.914 | 5.94 ms ×0.923 | 33.7 ms ×5.256 slower |
| 4 x 16 MiB | 28.0 ms | 26.6 ms ×0.955 | 15.8 ms ×0.567 faster | 49.5 ms ×1.755 slower |

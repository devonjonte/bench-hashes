# b3sum on 2× Xeon Gold 6330 (a) (0.9.0, 0.8.0, 0.10.0, and official 1.8.7): Intel(R) Xeon(R) Gold 6330 CPU @ 2.00GHz, 112 CPUs, linux7.0.0-43-generic

Host `x86-icelake`; files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.00 CPUs busy on average, 0.03 in the busiest window. Runs: 15 rounds, each contender once on each input in each.

Each cell: mean time per run from the process's start to its exit, then the time ratio against `b3sum-0.9.0` (the geometric mean of the rounds' ratios; below 1 is faster). The words slower and faster appear where the rounds' pairs agree; an unmarked ratio is insufficient evidence of a difference. Copied from `b3sum.stdout.txt` in this host's evidence folder.

## Files in the page cache (warm: read moments before)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10.0 | official |
|---|---:|---:|---:|---:|
| 4 KiB | 861 μs | 813 μs ×0.944 | 808 μs ×0.938 | 3.40 ms ×3.959 slower |
| 64 KiB | 792 μs | 765 μs ×0.966 faster | 812 μs ×1.025 | 3.13 ms ×3.955 slower |
| 1 MiB | 1.19 ms | 1.15 ms ×0.967 | 1.25 ms ×1.034 | 3.32 ms ×2.806 slower |
| 16 MiB | 1.96 ms | 1.94 ms ×0.989 | 2.06 ms ×1.049 | 4.00 ms ×2.042 slower |
| 256 MiB | 6.20 ms | 6.29 ms ×1.014 | 6.35 ms ×1.024 | 12.0 ms ×1.907 slower |
| 1 GiB | 18.5 ms | 18.6 ms ×1.007 | 18.4 ms ×0.994 | 38.5 ms ×2.044 slower |
| 1000 x 16 KiB | 5.45 ms | 5.16 ms ×0.947 faster | 3.97 ms ×0.729 faster | 20.4 ms ×3.749 slower |
| 1000 x 16 KiB, a process each | 596 ms | 568 ms ×0.952 faster | 596 ms ×0.998 | 2.91 s ×4.879 slower |
| mixed tree, 1000 files, 74 MiB | 7.19 ms | 6.64 ms ×0.927 faster | 6.21 ms ×0.866 faster | 37.1 ms ×5.177 slower |
| 16 x 64 MiB | 21.5 ms | 21.6 ms ×1.000 | 18.4 ms ×0.856 faster | 45.8 ms ×2.110 slower |

## Files read from storage (cold: evicted from the page cache before each run)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10.0 | official |
|---|---:|---:|---:|---:|
| 4 KiB | 920 μs | 883 μs ×0.960 | 866 μs ×0.943 | 3.59 ms ×3.906 slower |
| 64 KiB | 927 μs | 908 μs ×0.976 | 929 μs ×0.999 | 3.27 ms ×3.540 slower |
| 1 MiB | 1.73 ms | 1.70 ms ×0.980 | 1.74 ms ×1.006 | 3.64 ms ×2.101 slower |
| 16 MiB | 4.48 ms | 4.46 ms ×0.997 | 5.59 ms ×1.249 slower | 7.29 ms ×1.629 slower |
| 256 MiB | 47.6 ms | 48.0 ms ×1.009 | 35.2 ms ×0.740 faster | 51.6 ms ×1.086 slower |
| 1 GiB | 183 ms | 183 ms ×1.001 | 124 ms ×0.675 faster | 188 ms ×1.029 |
| 1000 x 16 KiB | 7.21 ms | 6.93 ms ×0.961 faster | 6.79 ms ×0.943 faster | 64.5 ms ×8.944 slower |
| 1000 x 16 KiB, a process each | 652 ms | 621 ms ×0.952 faster | 650 ms ×0.996 | 2.95 s ×4.526 slower |
| mixed tree, 1000 files, 74 MiB | 16.3 ms | 15.8 ms ×0.970 | 18.3 ms ×1.120 slower | 124 ms ×7.605 slower |
| 16 x 64 MiB | 186 ms | 186 ms ×0.998 | 142 ms ×0.762 faster | 211 ms ×1.136 slower |


---

# Quick suite (5 rounds, includes `100 x 16 KiB`): Intel(R) Xeon(R) Gold 6330 CPU @ 2.00GHz, 112 CPUs, linux7.0.0-43-generic

Host `x86-icelake`; files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.00 CPUs busy on average, 0.00 in the busiest window. Runs: 5 rounds, each contender once on each input in each (--quick: a check, not a record).

Each cell: mean time per run from the process's start to its exit, then the time ratio against `b3sum-0.9.0` (the geometric mean of the rounds' ratios; below 1 is faster). The words slower and faster appear where the rounds' pairs agree; an unmarked ratio is insufficient evidence of a difference. Copied from `b3sum.stdout.txt` in this host's evidence folder.

## Files in the page cache (warm: read moments before)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10.0 | official |
|---|---:|---:|---:|---:|
| 4 KiB | 844 μs | 802 μs ×0.950 | 791 μs ×0.937 | 3.29 ms ×3.904 slower |
| 1 MiB | 1.18 ms | 1.19 ms ×1.012 | 1.09 ms ×0.930 faster | 3.34 ms ×2.838 slower |
| 16 MiB | 2.07 ms | 1.96 ms ×0.948 | 2.02 ms ×0.980 | 3.99 ms ×1.934 slower |
| 100 x 16 KiB | 1.62 ms | 1.54 ms ×0.953 faster | 1.77 ms ×1.091 | 4.76 ms ×2.939 slower |
| 100 x 16 KiB, a process each | 63.4 ms | 60.1 ms ×0.948 | 63.7 ms ×1.004 | 292 ms ×4.604 slower |
| mixed tree, 100 files, 5 MiB | 2.13 ms | 2.02 ms ×0.950 | 2.41 ms ×1.122 | 6.16 ms ×2.896 slower |
| 4 x 16 MiB | 3.74 ms | 4.07 ms ×1.078 | 2.93 ms ×0.786 | 6.77 ms ×1.814 slower |

## Files read from storage (cold: evicted from the page cache before each run)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10.0 | official |
|---|---:|---:|---:|---:|
| 4 KiB | 906 μs | 825 μs ×0.910 | 810 μs ×0.894 | 3.27 ms ×3.629 slower |
| 1 MiB | 1.69 ms | 1.65 ms ×0.980 | 1.71 ms ×1.014 | 3.63 ms ×2.149 slower |
| 16 MiB | 4.45 ms | 4.51 ms ×1.013 | 5.36 ms ×1.203 slower | 7.17 ms ×1.611 slower |
| 100 x 16 KiB | 1.88 ms | 1.85 ms ×0.983 | 2.38 ms ×1.265 slower | 9.37 ms ×4.973 slower |
| 100 x 16 KiB, a process each | 69.0 ms | 65.0 ms ×0.942 | 68.4 ms ×0.992 | 297 ms ×4.314 slower |
| mixed tree, 100 files, 5 MiB | 3.61 ms | 3.33 ms ×0.923 | 4.31 ms ×1.187 | 13.8 ms ×3.812 slower |
| 4 x 16 MiB | 13.6 ms | 13.6 ms ×1.005 | 12.2 ms ×0.903 faster | 19.5 ms ×1.436 slower |

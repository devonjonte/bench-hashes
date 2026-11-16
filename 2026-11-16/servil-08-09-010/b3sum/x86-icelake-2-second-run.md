# The second run of b3sum 0.8.0, 0.9.0 and the 0.10 candidate: Intel(R) Xeon(R) Gold 6330 CPU @ 2.00GHz, 112 CPUs, linux7.0.0-43-generic

Host `x86-icelake-2`; files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.00 CPUs busy on average, 0.05 in the busiest window. Runs: 15 rounds, each contender once on each input in each.

Each cell: mean time per run from the process's start to its exit, then the time ratio against `b3sum-0.9.0` (the geometric mean of the rounds' ratios; below 1 is faster). The words slower and faster appear where the rounds' pairs agree; an unmarked ratio is insufficient evidence of a difference. Copied from `b3sum.stdout.txt` in this host's `evolution-010-b3sum-again` evidence folder.

## Files in the page cache (warm: read moments before)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10-candidate | official |
|---|---:|---:|---:|---:|
| 4 KiB | 854 μs | 810 μs ×0.947 | 858 μs ×1.004 | 6.45 ms ×7.577 slower |
| 64 KiB | 798 μs | 767 μs ×0.961 faster | 816 μs ×1.023 | 6.03 ms ×7.554 slower |
| 1 MiB | 1.22 ms | 1.22 ms ×0.998 | 1.18 ms ×0.961 | 6.64 ms ×5.455 slower |
| 16 MiB | 2.69 ms | 2.58 ms ×0.962 faster | 2.66 ms ×0.991 | 7.86 ms ×2.946 slower |
| 256 MiB | 6.77 ms | 6.73 ms ×0.989 | 6.71 ms ×0.989 | 17.3 ms ×2.555 slower |
| 1 GiB | 18.4 ms | 18.2 ms ×0.990 | 18.8 ms ×1.013 | 45.6 ms ×2.504 slower |
| 1000 x 16 KiB | 5.66 ms | 5.40 ms ×0.955 faster | 4.49 ms ×0.794 faster | 23.9 ms ×4.218 slower |
| 1000 x 16 KiB, a process each | 599 ms | 570 ms ×0.951 faster | 613 ms ×1.023 | 5.83 s ×9.725 slower |
| mixed tree, 1000 files, 74 MiB | 7.90 ms | 7.40 ms ×0.940 faster | 6.78 ms ×0.861 faster | 58.4 ms ×7.422 slower |
| 16 x 64 MiB | 24.0 ms | 24.0 ms ×0.998 | 17.3 ms ×0.716 faster | 63.9 ms ×2.654 slower |

## Files read from storage (cold: evicted from the page cache before each run)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10-candidate | official |
|---|---:|---:|---:|---:|
| 4 KiB | 943 μs | 925 μs ×0.982 | 953 μs ×1.010 | 6.43 ms ×6.854 slower |
| 64 KiB | 964 μs | 926 μs ×0.961 faster | 984 μs ×1.020 | 6.20 ms ×6.437 slower |
| 1 MiB | 1.86 ms | 1.77 ms ×0.954 | 1.84 ms ×0.989 | 6.79 ms ×3.663 slower |
| 16 MiB | 7.24 ms | 7.07 ms ×0.977 | 6.03 ms ×0.832 faster | 13.2 ms ×1.826 slower |
| 256 MiB | 57.1 ms | 57.0 ms ×0.998 | 46.3 ms ×0.810 faster | 64.9 ms ×1.135 slower |
| 1 GiB | 213 ms | 213 ms ×1.000 | 173 ms ×0.815 faster | 222 ms ×1.044 slower |
| 1000 x 16 KiB | 7.33 ms | 7.20 ms ×0.982 | 7.11 ms ×0.969 faster | 111 ms ×15.133 slower |
| 1000 x 16 KiB, a process each | 737 ms | 705 ms ×0.955 faster | 751 ms ×1.018 | 5.95 s ×8.064 slower |
| mixed tree, 1000 files, 74 MiB | 19.8 ms | 19.6 ms ×0.986 | 20.4 ms ×1.030 | 148 ms ×7.461 slower |
| 16 x 64 MiB | 223 ms | 223 ms ×1.000 | 180 ms ×0.807 faster | 282 ms ×1.266 slower |

# b3sum 0.8.0, 0.9.0 and the 0.10 candidate: AMD EPYC 7443 24-Core Processor, 96 CPUs, linux7.0.0-42-generic

Host `x86-avx2`; files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.00 CPUs busy on average, 0.13 in the busiest window. Runs: 15 rounds, each contender once on each input in each.

Each cell: mean time per run from the process's start to its exit, then the time ratio against `b3sum-0.9.0` (the geometric mean of the rounds' ratios; below 1 is faster). The words slower and faster appear where the rounds' pairs agree; an unmarked ratio is insufficient evidence of a difference. Copied from `b3sum.stdout.txt` in this host's evidence folder.

## Files in the page cache (warm: read moments before)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10-candidate | official |
|---|---:|---:|---:|---:|
| 4 KiB | 1.08 ms | 1.10 ms ×1.017 | 1.11 ms ×1.013 | 7.81 ms ×7.257 slower |
| 64 KiB | 974 μs | 972 μs ×0.999 | 972 μs ×1.003 | 7.56 ms ×7.901 slower |
| 1 MiB | 1.63 ms | 1.61 ms ×0.986 | 1.34 ms ×0.814 faster | 8.38 ms ×5.142 slower |
| 16 MiB | 4.29 ms | 4.14 ms ×0.962 | 4.72 ms ×1.096 | 10.8 ms ×2.534 slower |
| 256 MiB | 10.3 ms | 10.7 ms ×1.034 | 10.2 ms ×1.000 | 23.3 ms ×2.311 slower |
| 1 GiB | 20.4 ms | 21.4 ms ×1.059 | 19.7 ms ×0.980 | 56.1 ms ×2.774 slower |
| 1000 x 16 KiB | 6.21 ms | 6.39 ms ×1.016 | 5.48 ms ×0.890 faster | 59.4 ms ×9.630 slower |
| 1000 x 16 KiB, a process each | 633 ms | 610 ms ×0.963 faster | 638 ms ×1.007 | 7.35 s ×11.616 slower |
| mixed tree, 1000 files, 74 MiB | 10.0 ms | 8.78 ms ×0.887 faster | 9.83 ms ×0.984 | 97.4 ms ×9.748 slower |
| 16 x 64 MiB | 43.0 ms | 33.9 ms ×0.790 | 21.2 ms ×0.535 faster | 90.8 ms ×2.311 slower |

## Files read from storage (cold: evicted from the page cache before each run)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10-candidate | official |
|---|---:|---:|---:|---:|
| 4 KiB | 1.02 ms | 1.00 ms ×0.987 | 1.04 ms ×1.029 | 7.10 ms ×7.062 slower |
| 64 KiB | 1.10 ms | 1.18 ms ×1.067 | 1.17 ms ×1.068 | 6.83 ms ×6.235 slower |
| 1 MiB | 3.79 ms | 3.61 ms ×0.954 | 4.06 ms ×1.069 | 9.21 ms ×2.441 slower |
| 16 MiB | 10.3 ms | 10.6 ms ×1.029 | 8.88 ms ×0.867 faster | 18.4 ms ×1.785 slower |
| 256 MiB | 66.0 ms | 65.9 ms ×0.999 | 40.3 ms ×0.611 faster | 76.8 ms ×1.163 slower |
| 1 GiB | 247 ms | 247 ms ×1.001 | 133 ms ×0.538 faster | 260 ms ×1.056 slower |
| 1000 x 16 KiB | 10.4 ms | 10.1 ms ×0.969 | 10.9 ms ×1.048 slower | 233 ms ×22.345 slower |
| 1000 x 16 KiB, a process each | 844 ms | 820 ms ×0.973 | 857 ms ×1.016 | 7.55 s ×8.950 slower |
| mixed tree, 1000 files, 74 MiB | 25.6 ms | 25.7 ms ×1.002 | 25.6 ms ×0.998 | 273 ms ×10.671 slower |
| 16 x 64 MiB | 268 ms | 266 ms ×0.992 | 167 ms ×0.624 faster | 380 ms ×1.414 slower |

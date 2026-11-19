# b3sum on 2× EPYC 7443 (0.9.0, 0.8.0, 0.10.0, and official 1.8.7): AMD EPYC 7443 24-Core Processor, 96 CPUs, linux7.0.0-42-generic

Host `x86-avx2`; files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.00 CPUs busy on average, 0.11 in the busiest window. Runs: 15 rounds, each contender once on each input in each.

Each cell: mean time per run from the process's start to its exit, then the time ratio against `b3sum-0.9.0` (the geometric mean of the rounds' ratios; below 1 is faster). The words slower and faster appear where the rounds' pairs agree; an unmarked ratio is insufficient evidence of a difference. Copied from `b3sum.stdout.txt` in this host's evidence folder.

## Files in the page cache (warm: read moments before)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10.0 | official |
|---|---:|---:|---:|---:|
| 4 KiB | 1.02 ms | 1.00 ms ×0.980 | 1.02 ms ×1.012 | 4.08 ms ×4.081 slower |
| 64 KiB | 876 μs | 831 μs ×0.945 | 849 μs ×0.968 | 3.75 ms ×4.292 slower |
| 1 MiB | 1.31 ms | 1.32 ms ×1.007 | 1.16 ms ×0.884 faster | 3.88 ms ×2.967 slower |
| 16 MiB | 2.18 ms | 2.11 ms ×0.967 | 2.22 ms ×1.012 | 4.62 ms ×2.122 slower |
| 256 MiB | 6.48 ms | 6.56 ms ×1.013 | 6.65 ms ×1.026 | 13.4 ms ×2.039 slower |
| 1 GiB | 18.1 ms | 17.9 ms ×0.988 | 18.3 ms ×1.012 | 43.2 ms ×2.360 slower |
| 1000 x 16 KiB | 5.01 ms | 4.94 ms ×0.985 | 4.57 ms ×0.914 faster | 34.8 ms ×6.954 slower |
| 1000 x 16 KiB, a process each | 604 ms | 582 ms ×0.964 faster | 641 ms ×1.061 slower | 3.06 s ×5.077 slower |
| mixed tree, 1000 files, 74 MiB | 7.25 ms | 6.94 ms ×0.960 | 7.29 ms ×1.008 | 48.3 ms ×6.675 slower |
| 16 x 64 MiB | 22.0 ms | 21.3 ms ×0.971 | 18.1 ms ×0.823 faster | 53.6 ms ×2.436 slower |

## Files read from storage (cold: evicted from the page cache before each run)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10.0 | official |
|---|---:|---:|---:|---:|
| 4 KiB | 995 μs | 1.01 ms ×1.021 | 1.07 ms ×1.083 | 4.05 ms ×4.131 slower |
| 64 KiB | 1.11 ms | 1.09 ms ×0.980 | 1.20 ms ×1.087 | 3.83 ms ×3.485 slower |
| 1 MiB | 2.88 ms | 2.88 ms ×1.000 | 3.05 ms ×1.057 | 4.54 ms ×1.573 slower |
| 16 MiB | 6.01 ms | 5.76 ms ×0.959 | 6.74 ms ×1.121 slower | 8.99 ms ×1.496 slower |
| 256 MiB | 60.8 ms | 61.1 ms ×1.006 | 38.8 ms ×0.638 faster | 64.5 ms ×1.061 slower |
| 1 GiB | 232 ms | 232 ms ×0.999 | 131 ms ×0.565 faster | 237 ms ×1.022 |
| 1000 x 16 KiB | 9.80 ms | 9.62 ms ×0.981 | 9.64 ms ×0.983 | 219 ms ×22.341 slower |
| 1000 x 16 KiB, a process each | 807 ms | 784 ms ×0.971 | 847 ms ×1.049 slower | 3.27 s ×4.049 slower |
| mixed tree, 1000 files, 74 MiB | 22.8 ms | 22.9 ms ×1.005 | 20.4 ms ×0.896 faster | 213 ms ×9.348 slower |
| 16 x 64 MiB | 230 ms | 230 ms ×1.001 | 164 ms ×0.714 faster | 276 ms ×1.200 slower |


---

# Quick suite (5 rounds, includes `100 x 16 KiB`): AMD EPYC 7443 24-Core Processor, 96 CPUs, linux7.0.0-42-generic

Host `x86-avx2`; files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.01 CPUs busy on average, 0.04 in the busiest window. Runs: 5 rounds, each contender once on each input in each (--quick: a check, not a record).

Each cell: mean time per run from the process's start to its exit, then the time ratio against `b3sum-0.9.0` (the geometric mean of the rounds' ratios; below 1 is faster). The words slower and faster appear where the rounds' pairs agree; an unmarked ratio is insufficient evidence of a difference. Copied from `b3sum.stdout.txt` in this host's evidence folder.

## Files in the page cache (warm: read moments before)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10.0 | official |
|---|---:|---:|---:|---:|
| 4 KiB | 768 μs | 687 μs ×0.898 | 791 μs ×1.034 | 3.29 ms ×4.294 slower |
| 1 MiB | 1.19 ms | 1.15 ms ×0.967 | 1.07 ms ×0.893 | 3.62 ms ×3.040 slower |
| 16 MiB | 2.00 ms | 1.96 ms ×0.979 | 2.13 ms ×1.061 | 4.87 ms ×2.418 slower |
| 100 x 16 KiB | 1.69 ms | 1.50 ms ×0.888 faster | 1.88 ms ×1.110 slower | 6.78 ms ×4.008 slower |
| 100 x 16 KiB, a process each | 61.1 ms | 58.7 ms ×0.961 faster | 65.0 ms ×1.065 slower | 309 ms ×5.064 slower |
| mixed tree, 100 files, 5 MiB | 2.32 ms | 2.05 ms ×0.887 | 2.25 ms ×0.974 | 8.37 ms ×3.620 slower |
| 4 x 16 MiB | 3.94 ms | 3.84 ms ×0.970 | 2.87 ms ×0.734 faster | 7.88 ms ×2.004 slower |

## Files read from storage (cold: evicted from the page cache before each run)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10.0 | official |
|---|---:|---:|---:|---:|
| 4 KiB | 822 μs | 773 μs ×0.939 | 843 μs ×1.027 | 3.20 ms ×3.894 slower |
| 1 MiB | 2.75 ms | 2.63 ms ×0.961 | 2.93 ms ×1.063 | 4.58 ms ×1.665 slower |
| 16 MiB | 5.62 ms | 5.76 ms ×1.023 | 6.75 ms ×1.198 slower | 8.48 ms ×1.507 slower |
| 100 x 16 KiB | 2.30 ms | 2.21 ms ×0.962 | 2.68 ms ×1.165 slower | 24.9 ms ×10.877 slower |
| 100 x 16 KiB, a process each | 81.2 ms | 79.1 ms ×0.974 | 84.9 ms ×1.045 slower | 332 ms ×4.087 slower |
| mixed tree, 100 files, 5 MiB | 4.86 ms | 4.88 ms ×1.005 | 4.83 ms ×0.994 | 24.5 ms ×5.035 slower |
| 4 x 16 MiB | 21.9 ms | 22.8 ms ×1.041 | 13.1 ms ×0.601 faster | 31.1 ms ×1.423 slower |

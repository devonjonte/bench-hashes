# The second run of b3sum 0.8.0, 0.9.0 and the 0.10 candidate: AMD Ryzen 7 9700X 8-Core Processor, 16 CPUs, linux7.0.0-43-generic

Host `x86-9700x`; files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.00 CPUs busy on average, 0.04 in the busiest window. Runs: 15 rounds, each contender once on each input in each.

Each cell: mean time per run from the process's start to its exit, then the time ratio against `b3sum-0.9.0` (the geometric mean of the rounds' ratios; below 1 is faster). The words slower and faster appear where the rounds' pairs agree; an unmarked ratio is insufficient evidence of a difference. Copied from `b3sum.stdout.txt` in this host's `evolution-010-b3sum-again` evidence folder.

## Files in the page cache (warm: read moments before)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10-candidate | official |
|---|---:|---:|---:|---:|
| 4 KiB | 364 μs | 355 μs ×0.975 | 373 μs ×1.030 | 767 μs ×2.135 slower |
| 64 KiB | 293 μs | 279 μs ×0.952 | 288 μs ×0.985 | 578 μs ×1.979 slower |
| 1 MiB | 389 μs | 377 μs ×0.970 | 378 μs ×0.974 | 567 μs ×1.462 slower |
| 16 MiB | 606 μs | 611 μs ×1.008 | 637 μs ×1.049 | 860 μs ×1.411 slower |
| 256 MiB | 6.79 ms | 6.76 ms ×0.996 | 6.96 ms ×1.021 | 8.64 ms ×1.269 slower |
| 1 GiB | 29.9 ms | 26.7 ms ×0.900 | 28.9 ms ×0.967 | 34.3 ms ×1.161 slower |
| 1000 x 16 KiB | 1.83 ms | 1.65 ms ×0.903 faster | 1.60 ms ×0.861 | 6.01 ms ×3.298 slower |
| 1000 x 16 KiB, a process each | 169 ms | 161 ms ×0.952 faster | 168 ms ×0.994 | 440 ms ×2.607 slower |
| mixed tree, 1000 files, 74 MiB | 3.85 ms | 3.56 ms ×0.927 | 3.91 ms ×1.012 | 10.1 ms ×2.631 slower |
| 16 x 64 MiB | 31.7 ms | 29.7 ms ×0.936 | 29.4 ms ×0.925 | 31.4 ms ×1.000 |

## Files read from storage (cold: evicted from the page cache before each run)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10-candidate | official |
|---|---:|---:|---:|---:|
| 4 KiB | 467 μs | 457 μs ×0.982 | 486 μs ×1.044 | 873 μs ×1.889 slower |
| 64 KiB | 529 μs | 502 μs ×0.948 faster | 512 μs ×0.969 | 792 μs ×1.501 slower |
| 1 MiB | 1.04 ms | 1.03 ms ×0.991 | 1.05 ms ×1.010 | 1.20 ms ×1.148 slower |
| 16 MiB | 4.28 ms | 4.26 ms ×0.993 | 3.60 ms ×0.840 faster | 4.85 ms ×1.132 slower |
| 256 MiB | 54.9 ms | 55.2 ms ×1.005 | 32.9 ms ×0.599 faster | 56.1 ms ×1.022 |
| 1 GiB | 218 ms | 217 ms ×0.997 | 116 ms ×0.532 faster | 220 ms ×1.012 |
| 1000 x 16 KiB | 6.35 ms | 6.50 ms ×1.022 | 3.67 ms ×0.579 faster | 91.7 ms ×14.336 slower |
| 1000 x 16 KiB, a process each | 277 ms | 267 ms ×0.967 faster | 279 ms ×1.008 | 543 ms ×1.963 slower |
| mixed tree, 1000 files, 74 MiB | 20.2 ms | 19.3 ms ×0.956 | 13.5 ms ×0.670 faster | 165 ms ×8.156 slower |
| 16 x 64 MiB | 179 ms | 178 ms ×0.993 | 123 ms ×0.686 faster | 232 ms ×1.298 slower |

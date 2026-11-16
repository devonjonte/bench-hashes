# The second run of b3sum 0.8.0, 0.9.0 and the 0.10 candidate: AMD EPYC 9275F 24-Core Processor, 48 CPUs, linux7.0.0-43-generic

Host `x86-epyc-9275f`; files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.00 CPUs busy on average, 0.03 in the busiest window. Runs: 15 rounds, each contender once on each input in each.

Each cell: mean time per run from the process's start to its exit, then the time ratio against `b3sum-0.9.0` (the geometric mean of the rounds' ratios; below 1 is faster). The words slower and faster appear where the rounds' pairs agree; an unmarked ratio is insufficient evidence of a difference. Copied from `b3sum.stdout.txt` in this host's `evolution-010-b3sum-again` evidence folder.

## Files in the page cache (warm: read moments before)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10-candidate | official |
|---|---:|---:|---:|---:|
| 4 KiB | 509 μs | 479 μs ×0.938 | 506 μs ×0.997 | 2.11 ms ×4.173 slower |
| 64 KiB | 430 μs | 389 μs ×0.891 | 467 μs ×1.092 | 1.98 ms ×4.653 slower |
| 1 MiB | 745 μs | 771 μs ×1.042 | 583 μs ×0.784 faster | 2.12 ms ×2.882 slower |
| 16 MiB | 1.35 ms | 1.28 ms ×0.954 | 1.37 ms ×1.021 | 2.69 ms ×2.003 slower |
| 256 MiB | 3.33 ms | 3.18 ms ×0.967 | 3.09 ms ×0.943 | 7.65 ms ×2.289 slower |
| 1 GiB | 7.78 ms | 7.26 ms ×0.940 | 7.63 ms ×0.985 | 22.0 ms ×2.736 slower |
| 1000 x 16 KiB | 3.10 ms | 3.26 ms ×1.017 | 2.65 ms ×0.857 faster | 9.55 ms ×3.081 slower |
| 1000 x 16 KiB, a process each | 231 ms | 222 ms ×0.962 faster | 231 ms ×1.000 | 1.64 s ×7.080 slower |
| mixed tree, 1000 files, 74 MiB | 3.68 ms | 3.65 ms ×0.993 | 3.54 ms ×0.965 | 25.8 ms ×7.045 slower |
| 16 x 64 MiB | 10.2 ms | 10.1 ms ×0.991 | 6.84 ms ×0.674 faster | 30.6 ms ×2.936 slower |

## Files read from storage (cold: evicted from the page cache before each run)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10-candidate | official |
|---|---:|---:|---:|---:|
| 4 KiB | 571 μs | 572 μs ×1.002 | 590 μs ×1.037 | 2.15 ms ×3.782 slower |
| 64 KiB | 624 μs | 630 μs ×1.013 | 646 μs ×1.038 | 2.14 ms ×3.468 slower |
| 1 MiB | 1.64 ms | 1.68 ms ×1.021 | 1.63 ms ×0.988 | 2.68 ms ×1.633 slower |
| 16 MiB | 4.68 ms | 4.51 ms ×0.966 | 3.87 ms ×0.829 faster | 6.37 ms ×1.365 slower |
| 256 MiB | 46.6 ms | 46.3 ms ×0.994 | 30.9 ms ×0.662 faster | 47.9 ms ×1.028 |
| 1 GiB | 175 ms | 175 ms ×0.999 | 117 ms ×0.665 faster | 178 ms ×1.018 |
| 1000 x 16 KiB | 4.98 ms | 4.89 ms ×0.981 | 4.48 ms ×0.900 faster | 77.7 ms ×14.593 slower |
| 1000 x 16 KiB, a process each | 312 ms | 303 ms ×0.971 | 317 ms ×1.014 | 1.71 s ×5.507 slower |
| mixed tree, 1000 files, 74 MiB | 17.2 ms | 17.3 ms ×1.003 | 13.9 ms ×0.808 faster | 151 ms ×8.775 slower |
| 16 x 64 MiB | 177 ms | 178 ms ×1.003 | 123 ms ×0.693 faster | 212 ms ×1.196 slower |

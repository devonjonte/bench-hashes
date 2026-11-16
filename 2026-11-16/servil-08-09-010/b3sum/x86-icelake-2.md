# b3sum 0.8.0, 0.9.0 and the 0.10 candidate: Intel(R) Xeon(R) Gold 6330 CPU @ 2.00GHz, 112 CPUs, linux7.0.0-43-generic

Host `x86-icelake-2`; files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.00 CPUs busy on average, 0.28 in the busiest window. Runs: 15 rounds, each contender once on each input in each.

Each cell: mean time per run from the process's start to its exit, then the time ratio against `b3sum-0.9.0` (the geometric mean of the rounds' ratios; below 1 is faster). The words slower and faster appear where the rounds' pairs agree; an unmarked ratio is insufficient evidence of a difference. Copied from `b3sum.stdout.txt` in this host's evidence folder.

## Files in the page cache (warm: read moments before)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10.0 | official |
|---|---:|---:|---:|---:|
| 4 KiB | 875 μs | 827 μs ×0.947 | 880 μs ×1.008 | 6.45 ms ×7.417 slower |
| 64 KiB | 804 μs | 768 μs ×0.956 faster | 831 μs ×1.034 slower | 6.06 ms ×7.545 slower |
| 1 MiB | 1.24 ms | 1.16 ms ×0.936 faster | 1.18 ms ×0.940 | 6.65 ms ×5.360 slower |
| 16 MiB | 2.73 ms | 2.60 ms ×0.957 | 2.69 ms ×0.984 | 7.76 ms ×2.863 slower |
| 256 MiB | 6.82 ms | 6.99 ms ×1.017 | 6.87 ms ×1.007 | 17.6 ms ×2.576 slower |
| 1 GiB | 18.4 ms | 18.3 ms ×0.996 | 18.3 ms ×0.996 | 47.1 ms ×2.578 slower |
| 1000 x 16 KiB | 5.60 ms | 5.36 ms ×0.957 faster | 4.56 ms ×0.814 faster | 24.2 ms ×4.316 slower |
| 1000 x 16 KiB, a process each | 599 ms | 571 ms ×0.953 faster | 624 ms ×1.041 slower | 5.83 s ×9.729 slower |
| mixed tree, 1000 files, 74 MiB | 7.67 ms | 7.53 ms ×0.982 | 6.86 ms ×0.895 faster | 58.6 ms ×7.649 slower |
| 16 x 64 MiB | 24.2 ms | 23.8 ms ×0.985 | 17.6 ms ×0.724 faster | 65.9 ms ×2.718 slower |

## Files read from storage (cold: evicted from the page cache before each run)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10.0 | official |
|---|---:|---:|---:|---:|
| 4 KiB | 984 μs | 931 μs ×0.946 | 962 μs ×0.976 | 6.54 ms ×6.663 slower |
| 64 KiB | 958 μs | 925 μs ×0.966 | 1.01 ms ×1.055 slower | 6.21 ms ×6.487 slower |
| 1 MiB | 1.88 ms | 1.84 ms ×0.980 | 1.88 ms ×1.002 | 6.91 ms ×3.690 slower |
| 16 MiB | 7.25 ms | 7.15 ms ×0.986 | 6.12 ms ×0.843 faster | 13.3 ms ×1.833 slower |
| 256 MiB | 57.2 ms | 56.9 ms ×0.995 | 46.6 ms ×0.814 faster | 64.9 ms ×1.135 slower |
| 1 GiB | 214 ms | 213 ms ×0.998 | 172 ms ×0.807 faster | 223 ms ×1.043 slower |
| 1000 x 16 KiB | 7.40 ms | 7.23 ms ×0.977 | 7.07 ms ×0.955 faster | 111 ms ×14.936 slower |
| 1000 x 16 KiB, a process each | 739 ms | 704 ms ×0.954 faster | 764 ms ×1.034 slower | 5.94 s ×8.048 slower |
| mixed tree, 1000 files, 74 MiB | 20.1 ms | 19.7 ms ×0.979 | 20.2 ms ×1.006 | 148 ms ×7.383 slower |
| 16 x 64 MiB | 224 ms | 222 ms ×0.995 | 180 ms ×0.805 faster | 284 ms ×1.270 slower |


---

# Quick suite (5 rounds, includes `100 x 16 KiB`): Intel(R) Xeon(R) Gold 6330 CPU @ 2.00GHz, 112 CPUs, linux7.0.0-43-generic

Host `x86-icelake-2`; files on ext4 (/dev/md0 on /). Load: quiet: other programs kept 0.00 CPUs busy on average, 0.00 in the busiest window. Runs: 5 rounds, each contender once on each input in each (--quick: a check, not a record).

Each cell: mean time per run from the process's start to its exit, then the time ratio against `b3sum-0.9.0` (the geometric mean of the rounds' ratios; below 1 is faster). The words slower and faster appear where the rounds' pairs agree; an unmarked ratio is insufficient evidence of a difference. Copied from `b3sum.stdout.txt` in this host's evidence folder.

## Files in the page cache (warm: read moments before)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10.0 | official |
|---|---:|---:|---:|---:|
| 4 KiB | 835 μs | 800 μs ×0.959 | 850 μs ×1.020 | 6.14 ms ×7.375 slower |
| 1 MiB | 1.24 ms | 1.21 ms ×0.974 | 1.14 ms ×0.922 faster | 6.62 ms ×5.342 slower |
| 16 MiB | 2.78 ms | 2.63 ms ×0.944 faster | 2.74 ms ×0.981 | 7.87 ms ×2.837 slower |
| 100 x 16 KiB | 1.73 ms | 1.60 ms ×0.927 faster | 1.83 ms ×1.061 slower | 7.68 ms ×4.452 slower |
| 100 x 16 KiB, a process each | 64.4 ms | 60.8 ms ×0.944 | 67.0 ms ×1.040 slower | 585 ms ×9.079 slower |
| mixed tree, 100 files, 5 MiB | 2.45 ms | 2.38 ms ×0.959 | 2.35 ms ×0.961 | 11.0 ms ×4.492 slower |
| 4 x 16 MiB | 5.35 ms | 5.26 ms ×0.990 | 3.03 ms ×0.574 faster | 12.1 ms ×2.277 slower |

## Files read from storage (cold: evicted from the page cache before each run)

| input | b3sum-0.9.0 | b3sum-0.8.0 | b3sum-0.10.0 | official |
|---|---:|---:|---:|---:|
| 4 KiB | 914 μs | 852 μs ×0.933 | 901 μs ×0.986 | 6.31 ms ×6.899 slower |
| 1 MiB | 1.79 ms | 1.79 ms ×0.993 | 1.82 ms ×1.013 | 6.92 ms ×3.858 slower |
| 16 MiB | 7.19 ms | 7.23 ms ×1.005 | 6.02 ms ×0.838 faster | 13.0 ms ×1.801 slower |
| 100 x 16 KiB | 1.96 ms | 1.88 ms ×0.959 | 2.53 ms ×1.288 slower | 17.0 ms ×8.670 slower |
| 100 x 16 KiB, a process each | 77.8 ms | 74.2 ms ×0.954 | 80.4 ms ×1.033 slower | 596 ms ×7.656 slower |
| mixed tree, 100 files, 5 MiB | 3.92 ms | 3.76 ms ×0.957 | 4.24 ms ×1.081 | 19.3 ms ×4.923 slower |
| 4 x 16 MiB | 23.5 ms | 22.6 ms ×0.962 | 15.9 ms ×0.678 faster | 37.4 ms ×1.598 slower |

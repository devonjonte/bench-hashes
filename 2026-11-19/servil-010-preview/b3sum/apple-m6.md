# b3sum on Apple M6 (job 3385)

```
bench-hashes b3sum: how long b3sum takes to hash files, from its start to its exit

machine:   Apple M6, 12 CPUs, darwin27
files on:  apfs (on /System/Volumes/Data)
load:      quiet: other programs kept 0.17 CPUs busy on average, 0.99 in the busiest window
runs:      15 rounds, each contender once on each input in each

contenders:
  official       /Users/benchrunner/b3sum-contenders/b3sum-official-1.8.7    (b3sum 1.8.7, blake3 deb8249fc8d3d735)
  official-1-thread /Users/benchrunner/b3sum-contenders/b3sum-official-1.8.7 --num-threads 1   (b3sum 1.8.7, blake3 deb8249fc8d3d735)
  b3sum          /Users/benchrunner/b3sum-contenders/b3sum-2ef4c44    (b3sums 0.10.0+95fb588ab8e1cfa12426077b9606c82c3e22b15b, blake3 66f2fb25ec5871ab)
  b3sum-1-thread /Users/benchrunner/b3sum-contenders/b3sum-2ef4c44 --num-threads 1   (b3sums 0.10.0+95fb588ab8e1cfa12426077b9606c82c3e22b15b, blake3 66f2fb25ec5871ab)
  sha256sum      /sbin/sha256sum    (sha256sum (Darwin) 1.0, blake3 824686913f878509)
  sha1sum        /sbin/sha1sum    (sha1sum (Darwin) 1.0, blake3 824686913f878509)
  md5sum         /sbin/md5sum    (md5sum (Darwin) 1.0, blake3 28d4ce417bb63a06)

Files in the page cache (warm: read moments before)
mean time per run, lower is better; xN: against official, the ratio judged (the geometric mean of the rounds' ratios), marked slower or faster where the rounds' pairs say so (every cell judged at once, beyond 3%)
input                            official             official-1-thread                  b3sum                              b3sum-1-thread                     sha256sum                          sha1sum                            md5sum
4 KiB                            1.25 ms              1.09 ms x0.876 faster              1.21 ms x0.974                     1.23 ms x0.982                     846 μs x0.677 faster               842 μs x0.675 faster               859 μs x0.688 faster
64 KiB                           1.16 ms              1.03 ms x0.887 faster              1.12 ms x0.963 faster              1.12 ms x0.962 faster              798 μs x0.688 faster               800 μs x0.689 faster               849 μs x0.731 faster
1 MiB                            1.18 ms 0.885 GB/s   1.40 ms 0.750 GB/s x1.180 slower   1.25 ms 0.836 GB/s x1.058 slower   1.26 ms 0.835 GB/s x1.060 slower   1.15 ms 0.911 GB/s x0.971          1.17 ms 0.899 GB/s x0.984          1.95 ms 0.537 GB/s x1.648 slower
16 MiB                           2.05 ms 8.19 GB/s    7.65 ms 2.19 GB/s x3.736 slower    2.07 ms 8.09 GB/s x1.012           4.17 ms 4.02 GB/s x2.038 slower    7.14 ms 2.35 GB/s x3.484 slower    7.31 ms 2.29 GB/s x3.569 slower    20.2 ms 0.832 GB/s x9.844 slower
256 MiB                          15.7 ms 17.1 GB/s    111 ms 2.41 GB/s x7.086 slower     13.4 ms 20.0 GB/s x0.854 faster    54.8 ms 4.90 GB/s x3.484 slower    105 ms 2.57 GB/s x6.655 slower     107 ms 2.50 GB/s x6.826 slower     309 ms 0.869 GB/s x19.653 slower
1 GiB                            58.0 ms 18.5 GB/s    436 ms 2.46 GB/s x7.522 slower     47.5 ms 22.6 GB/s x0.819 faster    215 ms 4.99 GB/s x3.708 slower     415 ms 2.58 GB/s x7.161 slower     426 ms 2.52 GB/s x7.345 slower     1.23 s 0.871 GB/s x21.238 slower
1000 x 16 KiB                    41.1 ms 0.399 GB/s   17.0 ms 0.965 GB/s x0.413 faster   5.47 ms 2.99 GB/s x0.133 faster    12.7 ms 1.29 GB/s x0.308 faster    14.8 ms 1.11 GB/s x0.360 faster    15.1 ms 1.09 GB/s x0.367 faster    27.6 ms 0.594 GB/s x0.671 faster
1000 x 16 KiB, a process each    1.08 s 0.0152 GB/s   961 ms 0.0171 GB/s x0.891 faster   1.05 s 0.0156 GB/s x0.971          1.05 s 0.0156 GB/s x0.971          738 ms 0.0222 GB/s x0.684 faster   740 ms 0.0221 GB/s x0.686 faster   750 ms 0.0218 GB/s x0.695 faster
mixed tree, 1000 files, 74 MiB   35.3 ms 2.20 GB/s    41.8 ms 1.86 GB/s x1.185 slower    7.38 ms 10.5 GB/s x0.209 faster    24.8 ms 3.13 GB/s x0.704 faster    38.6 ms 2.01 GB/s x1.094 slower    39.5 ms 1.97 GB/s x1.120 slower    97.7 ms 0.796 GB/s x2.769 slower
16 x 64 MiB                      59.3 ms 18.1 GB/s    437 ms 2.46 GB/s x7.358 slower     50.9 ms 21.1 GB/s x0.857 faster    215 ms 5.00 GB/s x3.617 slower     413 ms 2.60 GB/s x6.965 slower     424 ms 2.53 GB/s x7.144 slower     1.23 s 0.873 GB/s x20.731 slower

CPUs busy (CPU time over wall time) and peak memory, medians
input                            official               official-1-thread     b3sum                  b3sum-1-thread        sha256sum          sha1sum            md5sum
4 KiB                            1.11 CPUs, 3 MiB       0.77 CPUs, 3 MiB      0.80 CPUs, 3 MiB       0.80 CPUs, 3 MiB      0.70 CPUs, 2 MiB   0.70 CPUs, 2 MiB   0.70 CPUs, 2 MiB
64 KiB                           1.32 CPUs, 3 MiB       0.77 CPUs, 3 MiB      0.79 CPUs, 3 MiB       0.80 CPUs, 3 MiB      0.71 CPUs, 2 MiB   0.71 CPUs, 2 MiB   0.73 CPUs, 2 MiB
1 MiB                            1.88 CPUs, 4 MiB       0.83 CPUs, 4 MiB      0.82 CPUs, 4 MiB       0.82 CPUs, 4 MiB      0.80 CPUs, 2 MiB   0.80 CPUs, 2 MiB   0.88 CPUs, 2 MiB
16 MiB                           5.61 CPUs, 19 MiB      0.97 CPUs, 19 MiB     4.56 CPUs, 20 MiB      0.94 CPUs, 19 MiB     0.96 CPUs, 2 MiB   0.97 CPUs, 2 MiB   0.99 CPUs, 2 MiB
256 MiB                          10.37 CPUs, 259 MiB    1.00 CPUs, 259 MiB    9.85 CPUs, 260 MiB     0.98 CPUs, 259 MiB    1.00 CPUs, 2 MiB   1.00 CPUs, 2 MiB   1.00 CPUs, 2 MiB
1 GiB                            10.95 CPUs, 1027 MiB   1.00 CPUs, 1027 MiB   10.61 CPUs, 1028 MiB   0.98 CPUs, 1027 MiB   1.00 CPUs, 2 MiB   1.00 CPUs, 2 MiB   1.00 CPUs, 2 MiB
1000 x 16 KiB                    7.75 CPUs, 3 MiB       0.98 CPUs, 3 MiB      8.84 CPUs, 5 MiB       0.97 CPUs, 4 MiB      0.98 CPUs, 2 MiB   0.98 CPUs, 2 MiB   0.99 CPUs, 2 MiB
1000 x 16 KiB, a process each    1.21 CPUs, 3 MiB       0.76 CPUs, 3 MiB      0.78 CPUs, 3 MiB       0.78 CPUs, 3 MiB      0.69 CPUs, 2 MiB   0.69 CPUs, 2 MiB   0.69 CPUs, 2 MiB
mixed tree, 1000 files, 74 MiB   7.27 CPUs, 20 MiB      0.99 CPUs, 19 MiB     9.17 CPUs, 54 MiB      0.98 CPUs, 51 MiB     0.99 CPUs, 2 MiB   0.99 CPUs, 2 MiB   1.00 CPUs, 2 MiB
16 x 64 MiB                      10.81 CPUs, 124 MiB    1.00 CPUs, 67 MiB     10.26 CPUs, 1029 MiB   0.99 CPUs, 1027 MiB   1.00 CPUs, 2 MiB   1.00 CPUs, 2 MiB   1.00 CPUs, 2 MiB

Files read from storage (cold: evicted from the page cache before each run)
mean time per run, lower is better; xN: against official, the ratio judged (the geometric mean of the rounds' ratios), marked slower or faster where the rounds' pairs say so (every cell judged at once, beyond 3%)
input                            official             official-1-thread                  b3sum                              b3sum-1-thread                     sha256sum                          sha1sum                            md5sum
4 KiB                            1.68 ms              1.43 ms x0.872                     1.56 ms x0.959                     1.58 ms x0.968                     1.21 ms x0.719                     1.20 ms x0.710                     1.22 ms x0.726
64 KiB                           1.40 ms              1.43 ms x1.022                     1.30 ms x0.931 faster              1.30 ms x0.929 faster              1.19 ms x0.850 faster              1.19 ms x0.851 faster              1.30 ms x0.930 faster
1 MiB                            2.34 ms 0.449 GB/s   3.10 ms 0.338 GB/s x1.327 slower   1.81 ms 0.580 GB/s x0.774 faster   1.80 ms 0.581 GB/s x0.773 faster   2.37 ms 0.442 GB/s x1.016          2.38 ms 0.441 GB/s x1.018          3.12 ms 0.336 GB/s x1.336 slower
16 MiB                           9.87 ms 1.70 GB/s    16.9 ms 0.994 GB/s x1.741 slower   5.85 ms 2.87 GB/s x0.599 faster    7.05 ms 2.38 GB/s x0.726 faster    9.07 ms 1.85 GB/s x0.936           9.28 ms 1.81 GB/s x0.957           21.5 ms 0.781 GB/s x2.217 slower
256 MiB                          156 ms 1.72 GB/s     183 ms 1.47 GB/s x1.172 slower     79.0 ms 3.40 GB/s x0.506 faster    80.0 ms 3.36 GB/s x0.513 faster    112 ms 2.40 GB/s x0.716 faster     114 ms 2.35 GB/s x0.731 faster     314 ms 0.856 GB/s x2.012 slower
1 GiB                            627 ms 1.71 GB/s     626 ms 1.71 GB/s x0.997            312 ms 3.45 GB/s x0.497 faster     312 ms 3.44 GB/s x0.498 faster     437 ms 2.45 GB/s x0.698 faster     447 ms 2.40 GB/s x0.714 faster     1.25 s 0.862 GB/s x1.989 slower
1000 x 16 KiB                    106 ms 0.154 GB/s    69.0 ms 0.238 GB/s x0.574 faster   18.8 ms 0.872 GB/s x0.169 faster   68.2 ms 0.240 GB/s x0.557 faster   63.9 ms 0.256 GB/s x0.536 faster   63.9 ms 0.256 GB/s x0.539 faster   78.7 ms 0.208 GB/s x0.706 faster
1000 x 16 KiB, a process each    1.16 s 0.0141 GB/s   1.03 s 0.0159 GB/s x0.888 faster   1.11 s 0.0147 GB/s x0.960 faster   1.11 s 0.0147 GB/s x0.961 faster   806 ms 0.0203 GB/s x0.695 faster   808 ms 0.0203 GB/s x0.697 faster   826 ms 0.0198 GB/s x0.713 faster
mixed tree, 1000 files, 74 MiB   161 ms 0.481 GB/s    207 ms 0.376 GB/s x1.282 slower    33.2 ms 2.34 GB/s x0.205 faster    102 ms 0.759 GB/s x0.633 faster    168 ms 0.464 GB/s x1.038 slower    169 ms 0.460 GB/s x1.046 slower    227 ms 0.342 GB/s x1.406 slower
16 x 64 MiB                      624 ms 1.72 GB/s     615 ms 1.75 GB/s x0.986            347 ms 3.10 GB/s x0.556 faster     337 ms 3.19 GB/s x0.540 faster     457 ms 2.35 GB/s x0.733 faster     468 ms 2.30 GB/s x0.750 faster     1.26 s 0.849 GB/s x2.027 slower

CPUs busy (CPU time over wall time) and peak memory, medians
input                            official              official-1-thread     b3sum                b3sum-1-thread     sha256sum          sha1sum            md5sum
4 KiB                            1.36 CPUs, 3 MiB      0.69 CPUs, 3 MiB      0.73 CPUs, 3 MiB     0.72 CPUs, 3 MiB   0.61 CPUs, 2 MiB   0.61 CPUs, 2 MiB   0.61 CPUs, 2 MiB
64 KiB                           1.59 CPUs, 3 MiB      0.57 CPUs, 3 MiB      0.68 CPUs, 3 MiB     0.68 CPUs, 3 MiB   0.49 CPUs, 2 MiB   0.49 CPUs, 2 MiB   0.49 CPUs, 2 MiB
1 MiB                            1.52 CPUs, 4 MiB      0.41 CPUs, 4 MiB      0.60 CPUs, 4 MiB     0.60 CPUs, 4 MiB   0.41 CPUs, 2 MiB   0.42 CPUs, 2 MiB   0.57 CPUs, 2 MiB
16 MiB                           1.68 CPUs, 19 MiB     0.52 CPUs, 19 MiB     1.55 CPUs, 12 MiB    0.57 CPUs, 7 MiB   0.80 CPUs, 2 MiB   0.81 CPUs, 2 MiB   0.93 CPUs, 2 MiB
256 MiB                          1.07 CPUs, 259 MiB    0.71 CPUs, 259 MiB    1.64 CPUs, 12 MiB    0.64 CPUs, 7 MiB   0.98 CPUs, 2 MiB   0.98 CPUs, 2 MiB   1.00 CPUs, 2 MiB
1 GiB                            1.06 CPUs, 1027 MiB   0.85 CPUs, 1027 MiB   1.60 CPUs, 12 MiB    0.64 CPUs, 7 MiB   1.00 CPUs, 2 MiB   1.00 CPUs, 2 MiB   1.00 CPUs, 2 MiB
1000 x 16 KiB                    4.76 CPUs, 3 MiB      0.45 CPUs, 3 MiB      2.28 CPUs, 5 MiB     0.39 CPUs, 4 MiB   0.41 CPUs, 2 MiB   0.41 CPUs, 2 MiB   0.52 CPUs, 2 MiB
1000 x 16 KiB, a process each    1.38 CPUs, 3 MiB      0.71 CPUs, 3 MiB      0.75 CPUs, 3 MiB     0.75 CPUs, 3 MiB   0.64 CPUs, 2 MiB   0.65 CPUs, 2 MiB   0.65 CPUs, 2 MiB
mixed tree, 1000 files, 74 MiB   2.12 CPUs, 20 MiB     0.26 CPUs, 19 MiB     1.59 CPUs, 36 MiB    0.29 CPUs, 8 MiB   0.29 CPUs, 2 MiB   0.29 CPUs, 2 MiB   0.48 CPUs, 2 MiB
16 x 64 MiB                      1.13 CPUs, 67 MiB     0.85 CPUs, 67 MiB     1.52 CPUs, 102 MiB   0.59 CPUs, 7 MiB   0.95 CPUs, 2 MiB   0.95 CPUs, 2 MiB   0.98 CPUs, 2 MiB

Every cold run read its files from storage (by the counts).

```

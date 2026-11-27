# Nightly drift check: e1966b498bc7 -> 87a0ab4b9f3c

- Host: fast-feedback-icelake-147
- Experiment: `bench=3f119a507807078649d8700112994fce24666868|base=e1966b498bc769db3d51451a4ddc8188a19ed593|target=87a0ab4b9f3cebfa30a791993573bfb4b128ae4e|cells=all|layouts=default`
- bench-hashes: `3f119a507807078649d8700112994fce24666868`
- BLAKE3-Servil base: `e1966b498bc769db3d51451a4ddc8188a19ed593`
- BLAKE3-Servil target: `87a0ab4b9f3cebfa30a791993573bfb4b128ae4e`
- Scope: `--cells all` (layouts: default)
- Deciding stage: stage 2 (kept-drift/second)
- Verdict: **no regression** (exit `0`)

## Stage 2 (deciding, kept-drift/second)

compare: old side: bench 3f119a507807 clean; servil e1966b498bc7 clean
compare: new side: bench 3f119a507807 clean; servil 87a0ab4b9f3c clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.629 | 0.631 | x1.002 | level | 31 of 64 | - | - | x1.000 | x1.000 | x0.899 |
| blake3-servil-st / solo / IncrementalMessage / 1 KiB | 3.301 | 3.138 | x0.951 | level | 40 of 64 | - | - | x0.959 | x1.000 | x0.990 |
| blake3-servil-mt / solo / IdleOneMessage / 2304 B | 6.643 | 6.733 | x1.014 | level | 27 of 64 | - | - | x1.001 | x1.000 | - |
| blake3-servil-mt / solo / IncrementalMessage / 64 B | 18.875 | 18.396 | x0.975 | level | 39 of 64 | - | - | x0.987 | x1.000 | x0.972 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 12.740 | 12.920 | x1.014 | level | 20 of 64 | x1.072 | - | x1.004 | x0.945 | x2.727 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 4 KiB | 0.248 | 0.249 | x1.003 | level | 22 of 64 | x0.934 | - | x1.004 | x0.946 | x3.156 |
| blake3-servil-mt / solo / ContinuousLentMessages / 64 B | 1.032 | 1.007 | x0.975 | level | 48 of 64 | x0.943 | - | x0.976 | x0.974 | x1.239 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 17.990 | 17.637 | x0.980 | level | 52 of 64 | - | - | x0.975 | x0.943 | x3.264 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 4 KiB | 0.279 | 0.274 | x0.982 | level | 45 of 64 | - | - | x0.982 | x0.946 | x18.457 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 64 B | 1.084 | 1.065 | x0.982 | level | 42 of 64 | - | - | x0.982 | x0.974 | x1.059 |

## Stage 1 (initial screen, kept-drift)

compare: old side: bench 3f119a507807 clean; servil e1966b498bc7 clean
compare: new side: bench 3f119a507807 clean; servil 87a0ab4b9f3c clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 18.384 | 16.747 | x0.911 | level | 4 of 4 | - | - | x0.935 | x1.001 | x0.907 |
| blake3-servil-st / solo / OneMessage / 128 B | 10.538 | 9.542 | x0.906 | level | 4 of 4 | - | - | x0.928 | x1.000 | x0.921 |
| blake3-servil-st / solo / OneMessage / 256 B | 6.294 | 5.660 | x0.899 | level | 4 of 4 | - | - | x0.922 | x1.000 | x0.937 |
| blake3-servil-st / solo / OneMessage / 512 B | 3.705 | 3.383 | x0.913 | level | 4 of 4 | - | - | x0.928 | x1.000 | x0.921 |
| blake3-servil-st / solo / OneMessage / 1 KiB | 2.582 | 2.452 | x0.950 | level | 4 of 4 | - | - | x0.955 | x1.000 | x0.925 |
| blake3-servil-st / solo / OneMessage / 1536 B | 4.610 | 4.397 | x0.954 | level | 3 of 4 | - | - | x0.958 | x0.997 | x1.033 |
| blake3-servil-st / solo / OneMessage / 2 KiB | 4.164 | 4.130 | x0.992 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.998 |
| blake3-servil-st / solo / OneMessage / 2304 B | 4.394 | 4.469 | x1.017 | level | 3 of 4 | - | - | x1.006 | x1.000 | x1.018 |
| blake3-servil-st / solo / OneMessage / 3 KiB | 3.085 | 3.084 | x1.000 | level | 2 of 4 | - | - | x0.994 | x1.000 | x1.094 |
| blake3-servil-st / solo / OneMessage / 3839 B | 2.722 | 2.671 | x0.981 | level | 4 of 4 | - | - | x0.982 | x1.000 | x1.007 |
| blake3-servil-st / solo / OneMessage / 4 KiB | 2.299 | 2.293 | x0.997 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.037 |
| blake3-servil-st / solo / OneMessage / 4470 B | 2.551 | 2.552 | x1.000 | level | 2 of 4 | - | - | x1.011 | x1.000 | x1.001 |
| blake3-servil-st / solo / OneMessage / 7935 B | 2.001 | 2.022 | x1.011 | level | 0 of 4 | - | - | x1.009 | x1.000 | x0.998 |
| blake3-servil-st / solo / OneMessage / 8 KiB | 1.815 | 1.819 | x1.002 | level | 2 of 4 | - | - | x1.006 | x1.000 | x1.003 |
| blake3-servil-st / solo / OneMessage / 16 KiB | 1.326 | 1.327 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.982 |
| blake3-servil-st / solo / OneMessage / 32 KiB | 1.230 | 1.233 | x1.002 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.962 |
| blake3-servil-st / solo / OneMessage / 64 KiB | 1.054 | 1.052 | x0.999 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.964 |
| blake3-servil-st / solo / OneMessage / 128 KiB | 0.669 | 0.669 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.995 |
| blake3-servil-st / solo / OneMessage / 256 KiB | 0.484 | 0.482 | x0.994 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.981 |
| blake3-servil-st / solo / OneMessage / 512 KiB | 0.422 | 0.421 | x0.998 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.985 |
| blake3-servil-st / solo / OneMessage / 1 MiB | 0.393 | 0.392 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.001 |
| blake3-servil-st / solo / OneMessage / 2 MiB | 0.384 | 0.385 | x1.004 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.010 |
| blake3-servil-st / solo / OneMessage / 3 MiB | 0.380 | 0.381 | x1.004 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.004 |
| blake3-servil-st / solo / OneMessage / 4 MiB | 0.378 | 0.378 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.992 |
| blake3-servil-st / solo / OneMessage / 8 MiB | 0.380 | 0.381 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.007 |
| blake3-servil-st / solo / OneMessage / 32 MiB | 0.355 | 0.356 | x1.004 | level | 0 of 4 | - | - | x1.002 | x1.000 | x0.997 |
| blake3-servil-st / solo / OneMessage / 64 MiB | 0.355 | 0.355 | x1.000 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.999 |
| blake3-servil-st / solo / OneMessage / 128 MiB | 0.355 | 0.355 | x1.001 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.998 |
| blake3-servil-st / solo / ManyMessages / 1 | 1057.138 | 987.463 | x0.934 | level | 3 of 4 | - | - | x0.952 | x1.001 | x0.979 |
| blake3-servil-st / solo / ManyMessages / 2 | 819.419 | 800.932 | x0.977 | level | 2 of 4 | - | - | x0.987 | x0.998 | x0.985 |
| blake3-servil-st / solo / ManyMessages / 3 | 659.870 | 653.793 | x0.991 | level | 2 of 4 | - | - | x0.993 | x0.998 | x0.933 |
| blake3-servil-st / solo / ManyMessages / 4 | 407.465 | 388.946 | x0.955 | level | 3 of 4 | - | - | x0.961 | x0.998 | x0.900 |
| blake3-servil-st / solo / ManyMessages / 6 | 362.270 | 344.265 | x0.950 | level | 3 of 4 | - | - | x0.951 | x0.998 | x0.902 |
| blake3-servil-st / solo / ManyMessages / 8 | 255.245 | 243.364 | x0.953 | level | 3 of 4 | - | - | x0.959 | x0.998 | x0.903 |
| blake3-servil-st / solo / ManyMessages / 12 | 212.610 | 200.734 | x0.944 | level | 4 of 4 | - | - | x0.953 | x0.998 | x0.893 |
| blake3-servil-st / solo / ManyMessages / 16 | 155.909 | 149.106 | x0.956 | level | 3 of 4 | - | - | x0.978 | x0.999 | x0.925 |
| blake3-servil-st / solo / ManyMessages / 24 | 136.596 | 136.459 | x0.999 | level | 1 of 4 | - | - | x0.997 | x0.999 | x0.935 |
| blake3-servil-st / solo / ManyMessages / 32 | 109.640 | 109.540 | x0.999 | level | 2 of 4 | - | - | x1.001 | x0.999 | x0.947 |
| blake3-servil-st / solo / ManyMessages / 48 | 97.671 | 97.194 | x0.995 | level | 3 of 4 | - | - | x0.990 | x0.999 | x0.959 |
| blake3-servil-st / solo / ManyMessages / 64 | 92.269 | 91.926 | x0.996 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.953 |
| blake3-servil-st / solo / ManyMessages / 128 | 84.255 | 83.783 | x0.994 | level | 4 of 4 | - | - | x0.993 | x1.000 | x0.986 |
| blake3-servil-st / solo / ManyMessages / 256 | 79.913 | 79.505 | x0.995 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.927 |
| blake3-servil-st / solo / ManyMessages / 512 | 77.557 | 77.612 | x1.001 | level | 1 of 4 | - | - | x0.999 | x1.000 | x0.950 |
| blake3-servil-st / solo / ManyMessages / 1024 | 66.344 | 66.103 | x0.996 | level | 2 of 4 | - | - | x0.995 | x1.000 | x0.957 |
| blake3-servil-st / solo / ManyMessages / 2048 | 42.626 | 42.322 | x0.993 | level | 3 of 4 | - | - | x0.990 | x1.000 | x0.984 |
| blake3-servil-st / solo / ManyMessages / 4096 | 30.849 | 31.006 | x1.005 | level | 0 of 4 | - | - | x1.003 | x1.000 | x0.983 |
| blake3-servil-st / solo / ManyMessages / 8192 | 27.062 | 27.114 | x1.002 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.972 |
| blake3-servil-st / solo / ManyMessages / 16384 | 25.338 | 25.181 | x0.994 | level | 4 of 4 | - | - | x0.995 | x1.000 | x0.951 |
| blake3-servil-st / solo / ManyMessages / 32768 | 24.661 | 24.663 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.994 |
| blake3-servil-st / solo / ManyMessages / 65536 | 24.494 | 24.546 | x1.002 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.009 |
| blake3-servil-st / solo / ManyMessages / 131072 | 24.767 | 24.780 | x1.001 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.001 |
| blake3-servil-st / solo / ManyMessages / 262144 | 25.417 | 25.411 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.994 |
| blake3-servil-st / solo / ManyLongMessages / 4 | 8170.888 | 8173.747 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.971 |
| blake3-servil-st / solo / ManyLongMessages / 16 | 4962.225 | 4916.839 | x0.991 | level | 4 of 4 | - | - | x0.995 | x1.000 | x0.991 |
| blake3-servil-st / solo / ManyLongMessages / 64 | 1972.845 | 1971.779 | x0.999 | level | 1 of 4 | - | - | x0.999 | x1.000 | x0.975 |
| blake3-servil-st / solo / ManyLongMessages / 256 | 1610.655 | 1610.660 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.979 |
| blake3-servil-st / solo / IdleOneMessage / 64 B | 9.331 | 8.563 | x0.918 | level | 2 of 4 | - | - | x0.992 | x1.001 | x0.863 |
| blake3-servil-st / solo / IdleOneMessage / 128 B | 6.087 | 6.333 | x1.040 | level | 1 of 4 | - | - | x1.001 | x1.001 | x0.575 |
| blake3-servil-st / solo / IdleOneMessage / 256 B | 4.612 | 4.713 | x1.022 | level | 1 of 4 | - | - | x0.998 | x1.000 | x0.435 |
| blake3-servil-st / solo / IdleOneMessage / 512 B | 4.119 | 4.093 | x0.994 | level | 2 of 4 | - | - | x0.994 | x1.000 | x0.542 |
| blake3-servil-st / solo / IdleOneMessage / 1 KiB | 3.703 | 3.686 | x0.995 | level | 2 of 4 | - | - | x0.997 | x1.000 | x2.130 |
| blake3-servil-st / solo / IdleOneMessage / 1536 B | 7.830 | 7.856 | x1.003 | level | 2 of 4 | - | - | x1.029 | x0.997 | x0.626 |
| blake3-servil-st / solo / IdleOneMessage / 2 KiB | 6.547 | 6.597 | x1.008 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.410 |
| blake3-servil-st / solo / IdleOneMessage / 2304 B | 6.675 | 6.650 | x0.996 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.972 |
| blake3-servil-st / solo / IdleOneMessage / 3 KiB | 4.653 | 4.624 | x0.994 | level | 2 of 4 | - | - | x0.999 | x1.000 | x2.017 |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 3.868 | 3.902 | x1.009 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.207 |
| blake3-servil-st / solo / IdleOneMessage / 4 KiB | 3.426 | 3.395 | x0.991 | level | 3 of 4 | - | - | x1.002 | x1.000 | x2.920 |
| blake3-servil-st / solo / IdleOneMessage / 4470 B | 3.698 | 3.750 | x1.014 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.583 |
| blake3-servil-st / solo / IdleOneMessage / 7935 B | 2.549 | 2.478 | x0.972 | level | 3 of 4 | - | - | x1.001 | x1.000 | x1.294 |
| blake3-servil-st / solo / IdleOneMessage / 8 KiB | 2.383 | 2.434 | x1.022 | level | 1 of 4 | - | - | x0.999 | x1.000 | x1.063 |
| blake3-servil-st / solo / IdleOneMessage / 16 KiB | 1.546 | 1.571 | x1.016 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.086 |
| blake3-servil-st / solo / IdleOneMessage / 32 KiB | 1.322 | 1.321 | x1.000 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.647 |
| blake3-servil-st / solo / IdleOneMessage / 64 KiB | 0.864 | 0.866 | x1.002 | level | 2 of 4 | - | - | x0.985 | x1.000 | x0.565 |
| blake3-servil-st / solo / IdleOneMessage / 128 KiB | 0.671 | 0.679 | x1.012 | level | 0 of 4 | - | - | x1.019 | x1.000 | x0.729 |
| blake3-servil-st / solo / IdleOneMessage / 256 KiB | 0.483 | 0.481 | x0.996 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.236 |
| blake3-servil-st / solo / IdleOneMessage / 512 KiB | 0.367 | 0.367 | x0.999 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.950 |
| blake3-servil-st / solo / IdleOneMessage / 1 MiB | 0.361 | 0.358 | x0.993 | level | 3 of 4 | - | - | x0.993 | x1.000 | x0.936 |
| blake3-servil-st / solo / IdleOneMessage / 2 MiB | 0.351 | 0.350 | x0.999 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.018 |
| blake3-servil-st / solo / IdleOneMessage / 3 MiB | 0.345 | 0.344 | x0.998 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.986 |
| blake3-servil-st / solo / IdleOneMessage / 4 MiB | 0.341 | 0.341 | x1.001 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.027 |
| blake3-servil-st / solo / IdleOneMessage / 8 MiB | 0.339 | 0.339 | x1.001 | level | 0 of 4 | - | - | x1.001 | x1.000 | x1.001 |
| blake3-servil-st / solo / IdleOneMessage / 32 MiB | 0.346 | 0.347 | x1.002 | level | 0 of 4 | - | - | x1.002 | x1.000 | x1.004 |
| blake3-servil-st / solo / IdleOneMessage / 64 MiB | 0.351 | 0.352 | x1.003 | level | 0 of 4 | - | - | x1.002 | x1.000 | x1.000 |
| blake3-servil-st / solo / IdleOneMessage / 128 MiB | 0.353 | 0.354 | x1.001 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.998 |
| blake3-servil-st / solo / IdleManyMessages / 1 | 647.684 | 647.589 | x1.000 | level | 3 of 4 | - | - | x0.994 | x1.001 | x0.996 |
| blake3-servil-st / solo / IdleManyMessages / 2 | 756.771 | 774.591 | x1.024 | level | 2 of 4 | - | - | x1.004 | x0.998 | x1.330 |
| blake3-servil-st / solo / IdleManyMessages / 3 | 769.673 | 792.763 | x1.030 | level | 1 of 4 | - | - | x1.007 | x0.999 | x1.597 |
| blake3-servil-st / solo / IdleManyMessages / 4 | 413.416 | 393.409 | x0.952 | level | 3 of 4 | - | - | x1.002 | x0.998 | x0.615 |
| blake3-servil-st / solo / IdleManyMessages / 6 | 437.778 | 421.493 | x0.963 | level | 3 of 4 | - | - | x1.004 | x0.999 | x1.175 |
| blake3-servil-st / solo / IdleManyMessages / 8 | 295.331 | 282.379 | x0.956 | level | 2 of 4 | - | - | x1.033 | x0.999 | x1.027 |
| blake3-servil-st / solo / IdleManyMessages / 12 | 286.901 | 277.555 | x0.967 | level | 2 of 4 | - | - | x0.994 | x1.000 | x0.798 |
| blake3-servil-st / solo / IdleManyMessages / 16 | 203.543 | 195.459 | x0.960 | level | 3 of 4 | - | - | x1.000 | x0.999 | x1.306 |
| blake3-servil-st / solo / IdleManyMessages / 24 | 217.941 | 223.500 | x1.026 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.031 |
| blake3-servil-st / solo / IdleManyMessages / 32 | 178.865 | 182.129 | x1.018 | level | 1 of 4 | - | - | x1.001 | x0.999 | x1.226 |
| blake3-servil-st / solo / IdleManyMessages / 48 | 177.105 | 173.712 | x0.981 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.725 |
| blake3-servil-st / solo / IdleManyMessages / 64 | 164.863 | 161.704 | x0.981 | level | 3 of 4 | - | - | x1.004 | x1.000 | x0.988 |
| blake3-servil-st / solo / IdleManyMessages / 128 | 121.125 | 118.748 | x0.980 | level | 3 of 4 | - | - | x1.004 | x1.000 | x1.318 |
| blake3-servil-st / solo / IdleManyMessages / 256 | 96.846 | 95.728 | x0.988 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.788 |
| blake3-servil-st / solo / IdleManyMessages / 512 | 83.536 | 83.764 | x1.003 | level | 1 of 4 | - | - | x0.993 | x1.000 | x0.968 |
| blake3-servil-st / solo / IdleManyMessages / 1024 | 54.145 | 54.890 | x1.014 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.684 |
| blake3-servil-st / solo / IdleManyMessages / 2048 | 42.497 | 42.754 | x1.006 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.223 |
| blake3-servil-st / solo / IdleManyMessages / 4096 | 30.969 | 31.438 | x1.015 | level | 0 of 4 | - | - | x1.010 | x1.000 | x0.628 |
| blake3-servil-st / solo / IdleManyMessages / 8192 | 24.084 | 24.108 | x1.001 | level | 2 of 4 | - | - | x0.994 | x1.000 | x0.971 |
| blake3-servil-st / solo / IdleManyMessages / 16384 | 23.775 | 23.691 | x0.996 | level | 4 of 4 | - | - | x1.000 | x1.000 | x1.008 |
| blake3-servil-st / solo / IdleManyMessages / 32768 | 22.710 | 22.687 | x0.999 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.021 |
| blake3-servil-st / solo / IdleManyMessages / 65536 | 22.305 | 22.302 | x1.000 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.010 |
| blake3-servil-st / solo / IdleManyMessages / 131072 | 22.194 | 22.162 | x0.999 | level | 4 of 4 | - | - | x0.999 | x1.000 | x0.988 |
| blake3-servil-st / solo / IdleManyMessages / 262144 | 22.489 | 22.413 | x0.997 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.004 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 B | 3.154 | 3.093 | x0.981 | level | 4 of 4 | - | - | x0.994 | x1.002 | x0.738 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 B | 2.403 | 2.347 | x0.977 | level | 2 of 4 | - | - | x0.995 | x1.002 | x0.226 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 B | 1.748 | 1.761 | x1.007 | level | 2 of 4 | - | - | x1.005 | x1.001 | x0.511 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 B | 1.601 | 1.606 | x1.003 | level | 1 of 4 | - | - | x1.006 | x1.001 | x0.996 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 KiB | 1.519 | 1.504 | x0.990 | level | 2 of 4 | - | - | x0.999 | x1.000 | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 1536 B | 1.209 | 1.238 | x1.024 | level | 1 of 4 | - | - | x1.019 | x0.997 | x1.848 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 KiB | 0.920 | 0.861 | x0.937 | level | 3 of 4 | - | - | x0.948 | x1.000 | x0.262 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2304 B | 0.996 | 0.998 | x1.002 | level | 2 of 4 | - | - | x1.003 | x1.001 | x2.000 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.718 | 0.774 | x1.078 | level | 1 of 4 | - | - | x1.065 | x1.000 | x1.350 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3839 B | 0.582 | 0.582 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.001 | x1.147 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 KiB | 0.480 | 0.487 | x1.014 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.368 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4470 B | 0.594 | 0.604 | x1.018 | level | 2 of 4 | - | - | x0.996 | x1.000 | x3.683 |
| blake3-servil-st / solo / BriefIdleOneMessage / 7935 B | 0.441 | 0.442 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.514 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 KiB | 0.394 | 0.394 | x0.999 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.957 |
| blake3-servil-st / solo / BriefIdleOneMessage / 16 KiB | 0.296 | 0.296 | x1.002 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.523 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 KiB | 0.293 | 0.294 | x1.005 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.852 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 KiB | 0.286 | 0.286 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.109 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 KiB | 0.283 | 0.283 | x1.000 | level | 1 of 4 | - | - | x0.998 | x1.000 | x0.626 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 KiB | 0.281 | 0.280 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.541 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 KiB | 0.286 | 0.286 | x0.998 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.959 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 MiB | 0.327 | 0.325 | x0.993 | level | 4 of 4 | - | - | x0.999 | x1.000 | x0.963 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 MiB | 0.335 | 0.335 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.019 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 MiB | 0.334 | 0.334 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.034 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 MiB | 0.334 | 0.334 | x0.999 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.025 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 MiB | 0.362 | 0.362 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.012 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 MiB | 0.347 | 0.348 | x1.004 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.996 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 MiB | 0.351 | 0.352 | x1.002 | level | 0 of 4 | - | - | x1.002 | x1.000 | x0.999 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 MiB | 0.353 | 0.354 | x1.001 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.998 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1 | 233.581 | 239.700 | x1.026 | level | 2 of 4 | - | - | x1.010 | x1.000 | x1.135 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2 | 214.234 | 222.367 | x1.038 | level | 1 of 4 | - | - | x1.015 | x0.997 | x1.111 |
| blake3-servil-st / solo / BriefIdleManyMessages / 3 | 125.750 | 129.794 | x1.032 | level | 1 of 4 | - | - | x1.014 | x0.998 | x1.994 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4 | 68.138 | 70.639 | x1.037 | level | 1 of 4 | - | - | x1.014 | x0.998 | x1.352 |
| blake3-servil-st / solo / BriefIdleManyMessages / 6 | 61.424 | 62.665 | x1.020 | level | 0 of 4 | - | - | x1.014 | x0.998 | x0.853 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8 | 43.235 | 43.284 | x1.001 | level | 3 of 4 | - | - | x1.004 | x0.998 | x0.641 |
| blake3-servil-st / solo / BriefIdleManyMessages / 12 | 37.140 | 38.339 | x1.032 | level | 1 of 4 | - | - | x1.011 | x0.999 | x0.263 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16 | 26.124 | 26.398 | x1.011 | level | 1 of 4 | - | - | x1.004 | x0.998 | x0.402 |
| blake3-servil-st / solo / BriefIdleManyMessages / 24 | 26.789 | 27.093 | x1.011 | level | 1 of 4 | - | - | x1.006 | x0.999 | x1.042 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32 | 21.796 | 21.965 | x1.008 | level | 2 of 4 | - | - | x1.004 | x0.999 | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 48 | 19.946 | 19.772 | x0.991 | level | 3 of 4 | - | - | x1.000 | x0.999 | x0.891 |
| blake3-servil-st / solo / BriefIdleManyMessages / 64 | 19.225 | 19.125 | x0.995 | level | 3 of 4 | - | - | x1.003 | x0.999 | x1.092 |
| blake3-servil-st / solo / BriefIdleManyMessages / 128 | 17.916 | 17.861 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.858 |
| blake3-servil-st / solo / BriefIdleManyMessages / 256 | 18.313 | 18.248 | x0.996 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.896 |
| blake3-servil-st / solo / BriefIdleManyMessages / 512 | 18.345 | 18.536 | x1.010 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.940 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1024 | 18.078 | 18.131 | x1.003 | level | 1 of 4 | - | - | x0.999 | x1.000 | x0.898 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2048 | 18.034 | 18.029 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.910 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4096 | 17.948 | 17.986 | x1.002 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.976 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8192 | 19.285 | 19.264 | x0.999 | level | 4 of 4 | - | - | x1.000 | x1.000 | x0.977 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16384 | 21.727 | 21.692 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.979 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32768 | 21.810 | 21.789 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.021 |
| blake3-servil-st / solo / BriefIdleManyMessages / 65536 | 21.974 | 21.960 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.008 |
| blake3-servil-st / solo / BriefIdleManyMessages / 131072 | 23.650 | 23.613 | x0.998 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.989 |
| blake3-servil-st / solo / BriefIdleManyMessages / 262144 | 22.443 | 22.446 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.000 |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 1.497 | 1.504 | x1.005 | level | 0 of 4 | x1.005 | - | x1.005 | x1.000 | x0.365 |
| blake3-servil-st / solo / ContinuousMessages / 128 B | 1.436 | 1.440 | x1.002 | level | 0 of 4 | x1.002 | - | x1.003 | x1.000 | x0.537 |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 1.408 | 1.413 | x1.004 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | - |
| blake3-servil-st / solo / ContinuousMessages / 512 B | 1.403 | 1.402 | x1.000 | level | 2 of 4 | x0.999 | - | x0.998 | x1.000 | x0.743 |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 1.397 | 1.400 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.000 | x0.905 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.435 | 0.439 | x1.009 | level | 1 of 4 | x1.009 | - | x1.010 | x1.000 | - |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.271 | 0.272 | x1.003 | level | 1 of 4 | x1.003 | - | x1.003 | x1.000 | x0.716 |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.281 | 0.281 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x0.572 |
| blake3-servil-st / solo / ContinuousMessages / 256 KiB | 0.299 | 0.299 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.872 |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.298 | 0.299 | x1.004 | level | 1 of 4 | x1.003 | - | x1.003 | x1.000 | x1.552 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.304 | 0.304 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.834 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.304 | 0.304 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x1.150 |
| blake3-servil-st / solo / ContinuousMessages / 64 MiB | 0.320 | 0.320 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x1.004 |
| blake3-servil-st / solo / ContinuousBatches / 16 | 20.867 | 20.590 | x0.987 | level | 4 of 4 | x0.987 | - | x0.987 | x0.998 | x1.852 |
| blake3-servil-st / solo / ContinuousBatches / 64 | 17.956 | 18.074 | x1.007 | level | 1 of 4 | x1.007 | - | x1.007 | x0.999 | - |
| blake3-servil-st / solo / ContinuousBatches / 256 | 17.745 | 17.827 | x1.005 | level | 1 of 4 | x1.004 | - | x1.003 | x0.999 | - |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 19.246 | 19.454 | x1.011 | level | 1 of 4 | x1.011 | - | x1.011 | x1.000 | - |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 18.984 | 19.421 | x1.023 | level | 0 of 4 | x1.023 | - | x1.023 | x1.000 | - |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 22.575 | 22.649 | x1.003 | level | 1 of 4 | x1.003 | - | x1.002 | x1.000 | - |
| blake3-servil-st / solo / ContinuousBatches / 65536 | 23.021 | 23.036 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | x0.734 |
| blake3-servil-st / solo / LentMessages / 64 B | 1.497 | 1.504 | x1.005 | level | 0 of 4 | x1.005 | - | x1.005 | x1.000 | x0.365 |
| blake3-servil-st / solo / LentMessages / 128 B | 1.436 | 1.440 | x1.002 | level | 0 of 4 | x1.002 | - | x1.003 | x1.000 | x0.537 |
| blake3-servil-st / solo / LentMessages / 256 B | 1.408 | 1.413 | x1.004 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | - |
| blake3-servil-st / solo / LentMessages / 512 B | 1.403 | 1.402 | x1.000 | level | 2 of 4 | x0.999 | - | x0.998 | x1.000 | x0.743 |
| blake3-servil-st / solo / LentMessages / 1 KiB | 1.397 | 1.400 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.000 | x0.905 |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.435 | 0.439 | x1.009 | level | 1 of 4 | x1.009 | - | x1.010 | x1.000 | - |
| blake3-servil-st / solo / LentMessages / 16 KiB | 0.271 | 0.272 | x1.003 | level | 1 of 4 | x1.003 | - | x1.003 | x1.000 | x0.716 |
| blake3-servil-st / solo / LentMessages / 64 KiB | 0.281 | 0.281 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x0.572 |
| blake3-servil-st / solo / LentMessages / 256 KiB | 0.277 | 0.277 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x1.538 |
| blake3-servil-st / solo / LentMessages / 1 MiB | 0.316 | 0.315 | x0.999 | level | 3 of 4 | x0.999 | - | x1.000 | x1.000 | x1.102 |
| blake3-servil-st / solo / LentMessages / 4 MiB | 0.330 | 0.329 | x0.997 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x0.775 |
| blake3-servil-st / solo / LentMessages / 16 MiB | 0.343 | 0.342 | x0.998 | level | 3 of 4 | x0.996 | - | x0.996 | x1.000 | x0.906 |
| blake3-servil-st / solo / LentMessages / 64 MiB | 0.352 | 0.351 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x1.001 |
| blake3-servil-st / solo / Interleaved / 256 | 0.394 | 0.391 | x0.992 | level | 4 of 4 | x0.992 | - | x0.992 | x0.998 | x0.813 |
| blake3-servil-st / solo / Collection / git objects | 0.272 | 0.272 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x0.999 | x1.029 |
| blake3-servil-st / solo / Collection / Nix files | 0.263 | 0.263 | x1.000 | level | 2 of 4 | x1.000 | - | x0.999 | x0.999 | x1.092 |
| blake3-servil-st / solo / LentBatches / 16 | 20.867 | 20.590 | x0.987 | level | 4 of 4 | x0.987 | - | x0.987 | x0.998 | x1.852 |
| blake3-servil-st / solo / LentBatches / 64 | 17.956 | 18.074 | x1.007 | level | 1 of 4 | x1.007 | - | x1.007 | x0.999 | - |
| blake3-servil-st / solo / LentBatches / 256 | 17.745 | 17.827 | x1.005 | level | 1 of 4 | x1.004 | - | x1.003 | x0.999 | - |
| blake3-servil-st / solo / LentBatches / 1024 | 19.246 | 19.454 | x1.011 | level | 1 of 4 | x1.011 | - | x1.011 | x1.000 | - |
| blake3-servil-st / solo / LentBatches / 4096 | 18.984 | 19.421 | x1.023 | level | 0 of 4 | x1.023 | - | x1.023 | x1.000 | - |
| blake3-servil-st / solo / LentBatches / 16384 | 22.575 | 22.649 | x1.003 | level | 1 of 4 | x1.003 | - | x1.002 | x1.000 | - |
| blake3-servil-st / solo / LentBatches / 65536 | 23.021 | 23.036 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | x0.734 |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.350 | 0.350 | x1.000 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x0.994 |
| blake3-servil-st / solo / ContinuousCollection / Nix files | 0.359 | 0.359 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x1.034 |
| blake3-servil-st / solo / MerkleTree / 1024 | 0.350 | 0.349 | x0.998 | level | 4 of 4 | x0.998 | - | x0.998 | x1.001 | x1.172 |
| blake3-servil-st / solo / MerkleTree / 4096 | 0.402 | 0.398 | x0.990 | level | 3 of 4 | x0.989 | - | x0.989 | x1.001 | x0.754 |
| blake3-servil-st / solo / MerkleTree / 16384 | 0.412 | 0.411 | x0.999 | level | 3 of 4 | x0.998 | - | x0.998 | x1.001 | x0.952 |
| blake3-servil-st / solo / MerkleTree / 65536 | 0.440 | 0.441 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.001 | x1.022 |
| blake3-servil-st / solo / MerkleTree / 262144 | 0.468 | 0.468 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.001 | x0.984 |
| blake3-servil-st / solo / MerkleTree / 65536 x 32 B | 1.051 | 1.048 | x0.998 | level | 4 of 4 | x0.998 | - | x0.998 | x1.000 | x1.823 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 32 B | 1.089 | 1.084 | x0.995 | level | 4 of 4 | x0.995 | - | x0.995 | x1.000 | x0.993 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 16 B | 2.116 | 2.105 | x0.995 | level | 3 of 4 | x0.995 | - | x0.995 | x1.000 | x0.990 |
| blake3-servil-st / solo / MerkleTree / 65536 x 48 B | 0.742 | 0.741 | x0.999 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x0.715 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 48 B | 0.777 | 0.773 | x0.995 | level | 4 of 4 | x0.995 | - | x0.995 | x1.000 | x1.011 |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.751 | 0.755 | x1.005 | level | 1 of 4 | - | - | x1.003 | x1.002 | x1.008 |
| blake3-servil-st / solo / InterleavedTurn / 1024 x 1 KiB | 0.848 | 0.863 | x1.017 | level | 2 of 4 | - | - | x1.017 | x1.000 | x1.055 |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.672 | 0.667 | x0.993 | level | 2 of 4 | - | - | x1.000 | x1.001 | x0.996 |
| blake3-servil-st / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.797 | 0.800 | x1.003 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.009 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.520 | 0.529 | x1.019 | level | 1 of 4 | - | - | x1.018 | x1.004 | x0.997 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.721 | 0.723 | x1.003 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.002 |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.318 | 0.317 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x1.000 | x0.612 |
| blake3-servil-st / solo / ReceivingMessage / 2 μs | 0.320 | 0.319 | x0.997 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x0.482 |
| blake3-servil-st / solo / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 3 of 4 | x0.998 | - | x0.997 | x1.000 | x0.639 |
| blake3-servil-st / solo / IncrementalMessage / 64 B | 18.169 | 18.154 | x0.999 | level | 2 of 4 | - | - | x0.992 | x1.000 | x0.960 |
| blake3-servil-st / solo / IncrementalMessage / 1 KiB | 3.164 | 3.489 | x1.103 | level | 0 of 4 | - | - | x1.088 | x1.000 | x0.937 |
| blake3-servil-st / solo / IncrementalMessage / 4 KiB | 2.466 | 2.463 | x0.999 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.967 |
| blake3-servil-st / solo / LentIncrementalMessage / 64 B | 1.681 | 1.703 | x1.013 | level | 1 of 4 | x1.011 | - | x1.011 | x1.000 | x0.809 |
| blake3-servil-st / solo / LentIncrementalMessage / 1 KiB | 1.437 | 1.436 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x0.922 |
| blake3-servil-st / solo / LentIncrementalMessage / 4 KiB | 0.456 | 0.456 | x1.001 | level | 2 of 4 | x1.002 | - | x1.001 | x1.000 | x1.028 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 1.462 | 1.454 | x0.994 | level | 3 of 4 | x0.995 | - | x0.994 | x1.000 | x0.929 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 4 KiB | 0.438 | 0.435 | x0.992 | level | 4 of 4 | x0.992 | - | x0.991 | x1.000 | x0.848 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 1 MiB | 0.296 | 0.283 | x0.956 | level | 4 of 4 | x0.957 | - | x0.957 | x1.000 | x1.289 |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 1.382 | 1.413 | x1.023 | level | 0 of 4 | x1.023 | - | x1.022 | x1.000 | x0.657 |
| blake3-servil-st / solo / ContinuousLentMessages / 4 KiB | 0.425 | 0.426 | x1.004 | level | 2 of 4 | x1.004 | - | x1.005 | x1.000 | x0.714 |
| blake3-servil-st / solo / ContinuousLentMessages / 1 MiB | 0.242 | 0.242 | x1.002 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x0.626 |
| blake3-servil-mt / solo / OneMessage / 64 B | 19.518 | 17.758 | x0.910 | level | 4 of 4 | - | - | x0.936 | x1.000 | x0.932 |
| blake3-servil-mt / solo / OneMessage / 128 B | 11.038 | 10.398 | x0.942 | level | 3 of 4 | - | - | x0.946 | x1.001 | x0.954 |
| blake3-servil-mt / solo / OneMessage / 256 B | 6.120 | 5.590 | x0.913 | level | 4 of 4 | - | - | x0.929 | x1.000 | x0.932 |
| blake3-servil-mt / solo / OneMessage / 512 B | 3.818 | 3.515 | x0.921 | level | 4 of 4 | - | - | x0.936 | x1.000 | x0.953 |
| blake3-servil-mt / solo / OneMessage / 1 KiB | 2.633 | 2.574 | x0.978 | level | 3 of 4 | - | - | x0.978 | x1.000 | x0.996 |
| blake3-servil-mt / solo / OneMessage / 1536 B | 4.935 | 4.725 | x0.957 | level | 3 of 4 | - | - | x0.963 | x0.997 | x1.008 |
| blake3-servil-mt / solo / OneMessage / 2 KiB | 4.178 | 4.166 | x0.997 | level | 3 of 4 | - | - | x1.002 | x1.000 | x1.023 |
| blake3-servil-mt / solo / OneMessage / 2304 B | 4.490 | 4.462 | x0.994 | level | 3 of 4 | - | - | x0.990 | x1.000 | x1.015 |
| blake3-servil-mt / solo / OneMessage / 3 KiB | 3.101 | 3.139 | x1.012 | level | 1 of 4 | - | - | x1.010 | x1.000 | x1.100 |
| blake3-servil-mt / solo / OneMessage / 3839 B | 2.723 | 2.726 | x1.001 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.000 |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 2.339 | 2.321 | x0.992 | level | 3 of 4 | - | - | x0.990 | x1.000 | x1.018 |
| blake3-servil-mt / solo / OneMessage / 4470 B | 2.554 | 2.539 | x0.994 | level | 3 of 4 | - | - | x0.995 | x1.000 | x1.003 |
| blake3-servil-mt / solo / OneMessage / 7935 B | 2.031 | 2.030 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.000 |
| blake3-servil-mt / solo / OneMessage / 8 KiB | 1.844 | 1.844 | x1.000 | level | 3 of 4 | - | - | x1.001 | x1.000 | x1.023 |
| blake3-servil-mt / solo / OneMessage / 16 KiB | 1.327 | 1.329 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.984 |
| blake3-servil-mt / solo / OneMessage / 32 KiB | 1.237 | 1.235 | x0.998 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.962 |
| blake3-servil-mt / solo / OneMessage / 64 KiB | 1.061 | 1.047 | x0.987 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.999 |
| blake3-servil-mt / solo / OneMessage / 128 KiB | 0.670 | 0.668 | x0.998 | level | 2 of 4 | - | - | x0.995 | x1.000 | x0.962 |
| blake3-servil-mt / solo / OneMessage / 256 KiB | 0.483 | 0.483 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.984 |
| blake3-servil-mt / solo / OneMessage / 512 KiB | 0.438 | 0.436 | x0.996 | level | 2 of 4 | - | - | x0.994 | x0.926 | x0.999 |
| blake3-servil-mt / solo / OneMessage / 1 MiB | 0.343 | 0.335 | x0.979 | level | 4 of 4 | - | - | x0.978 | x0.816 | x0.981 |
| blake3-servil-mt / solo / OneMessage / 2 MiB | 0.247 | 0.245 | x0.992 | level | 3 of 4 | - | - | x0.983 | x0.855 | x0.966 |
| blake3-servil-mt / solo / OneMessage / 3 MiB | 0.213 | 0.212 | x0.998 | level | 3 of 4 | - | - | x0.997 | x0.897 | x0.982 |
| blake3-servil-mt / solo / OneMessage / 4 MiB | 0.196 | 0.195 | x0.993 | level | 3 of 4 | - | - | x0.991 | x0.900 | x0.983 |
| blake3-servil-mt / solo / OneMessage / 8 MiB | 0.167 | 0.166 | x0.996 | level | 2 of 4 | - | - | x0.998 | x0.955 | x1.003 |
| blake3-servil-mt / solo / OneMessage / 32 MiB | 0.113 | 0.112 | x0.999 | level | 3 of 4 | - | - | x0.999 | x0.992 | x0.997 |
| blake3-servil-mt / solo / OneMessage / 64 MiB | 0.107 | 0.107 | x1.000 | level | 3 of 4 | - | - | x1.000 | x0.993 | x0.999 |
| blake3-servil-mt / solo / OneMessage / 128 MiB | 0.105 | 0.105 | x1.001 | level | 2 of 4 | - | - | x0.999 | x0.998 | x1.000 |
| blake3-servil-mt / solo / ManyMessages / 1 | 1071.315 | 1040.172 | x0.971 | level | 2 of 4 | - | - | x0.977 | x1.001 | x0.955 |
| blake3-servil-mt / solo / ManyMessages / 2 | 835.399 | 816.823 | x0.978 | level | 2 of 4 | - | - | x0.988 | x0.998 | x0.987 |
| blake3-servil-mt / solo / ManyMessages / 3 | 675.271 | 659.708 | x0.977 | level | 3 of 4 | - | - | x0.968 | x0.998 | x0.942 |
| blake3-servil-mt / solo / ManyMessages / 4 | 415.964 | 406.290 | x0.977 | level | 2 of 4 | - | - | x0.972 | x0.998 | x0.920 |
| blake3-servil-mt / solo / ManyMessages / 6 | 362.581 | 346.829 | x0.957 | level | 3 of 4 | - | - | x0.958 | x0.998 | x0.938 |
| blake3-servil-mt / solo / ManyMessages / 8 | 258.014 | 245.672 | x0.952 | level | 3 of 4 | - | - | x0.964 | x0.999 | x0.897 |
| blake3-servil-mt / solo / ManyMessages / 12 | 204.816 | 205.340 | x1.003 | level | 2 of 4 | - | - | x1.000 | x0.999 | x0.899 |
| blake3-servil-mt / solo / ManyMessages / 16 | 154.294 | 151.606 | x0.983 | level | 2 of 4 | - | - | x0.982 | x0.998 | x0.926 |
| blake3-servil-mt / solo / ManyMessages / 24 | 139.983 | 136.170 | x0.973 | level | 4 of 4 | - | - | x0.987 | x0.999 | x0.922 |
| blake3-servil-mt / solo / ManyMessages / 32 | 110.918 | 112.516 | x1.014 | level | 1 of 4 | - | - | x1.002 | x0.999 | x0.938 |
| blake3-servil-mt / solo / ManyMessages / 48 | 98.359 | 97.402 | x0.990 | level | 2 of 4 | - | - | x0.998 | x0.999 | x0.947 |
| blake3-servil-mt / solo / ManyMessages / 64 | 93.004 | 92.566 | x0.995 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.958 |
| blake3-servil-mt / solo / ManyMessages / 128 | 83.912 | 84.534 | x1.007 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.944 |
| blake3-servil-mt / solo / ManyMessages / 256 | 79.460 | 79.880 | x1.005 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.935 |
| blake3-servil-mt / solo / ManyMessages / 512 | 77.507 | 77.373 | x0.998 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.945 |
| blake3-servil-mt / solo / ManyMessages / 1024 | 65.545 | 66.332 | x1.012 | level | 0 of 4 | - | - | x1.015 | x1.000 | x0.962 |
| blake3-servil-mt / solo / ManyMessages / 2048 | 42.310 | 42.700 | x1.009 | level | 0 of 4 | - | - | x1.002 | x1.000 | x0.975 |
| blake3-servil-mt / solo / ManyMessages / 4096 | 31.067 | 30.949 | x0.996 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.969 |
| blake3-servil-mt / solo / ManyMessages / 8192 | 25.893 | 24.330 | x0.940 | level | 4 of 4 | - | - | x0.933 | x0.713 | x0.986 |
| blake3-servil-mt / solo / ManyMessages / 16384 | 19.466 | 19.464 | x1.000 | level | 3 of 4 | - | - | x0.998 | x0.921 | x0.987 |
| blake3-servil-mt / solo / ManyMessages / 32768 | 15.084 | 15.092 | x1.001 | level | 2 of 4 | - | - | x1.001 | x0.924 | x0.989 |
| blake3-servil-mt / solo / ManyMessages / 65536 | 12.183 | 12.122 | x0.995 | level | 2 of 4 | - | - | x0.996 | x0.933 | x0.993 |
| blake3-servil-mt / solo / ManyMessages / 131072 | 10.681 | 10.682 | x1.000 | level | 2 of 4 | - | - | x0.999 | x0.960 | x0.999 |
| blake3-servil-mt / solo / ManyMessages / 262144 | 9.998 | 9.976 | x0.998 | level | 3 of 4 | - | - | x0.999 | x0.972 | x0.997 |
| blake3-servil-mt / solo / ManyLongMessages / 4 | 8210.621 | 8232.738 | x1.003 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.976 |
| blake3-servil-mt / solo / ManyLongMessages / 16 | 4963.415 | 4936.047 | x0.994 | level | 3 of 4 | - | - | x0.992 | x1.000 | x0.982 |
| blake3-servil-mt / solo / ManyLongMessages / 64 | 1972.637 | 1973.296 | x1.000 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.980 |
| blake3-servil-mt / solo / ManyLongMessages / 256 | 1443.496 | 1399.219 | x0.969 | level | 3 of 4 | - | - | x0.967 | x0.865 | x0.985 |
| blake3-servil-mt / solo / IdleOneMessage / 64 B | 8.673 | 8.005 | x0.923 | level | 3 of 4 | - | - | x1.001 | x1.001 | x1.189 |
| blake3-servil-mt / solo / IdleOneMessage / 128 B | 6.315 | 6.411 | x1.015 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.311 |
| blake3-servil-mt / solo / IdleOneMessage / 256 B | 4.746 | 4.740 | x0.999 | level | 2 of 4 | - | - | x1.007 | x1.000 | x0.503 |
| blake3-servil-mt / solo / IdleOneMessage / 512 B | 4.077 | 4.069 | x0.998 | level | 2 of 4 | - | - | x0.995 | x1.000 | x0.694 |
| blake3-servil-mt / solo / IdleOneMessage / 1 KiB | 3.766 | 3.737 | x0.992 | level | 3 of 4 | - | - | x0.996 | x1.000 | - |
| blake3-servil-mt / solo / IdleOneMessage / 1536 B | 7.758 | 7.670 | x0.989 | level | 3 of 4 | - | - | x1.051 | x0.997 | x1.147 |
| blake3-servil-mt / solo / IdleOneMessage / 2 KiB | 6.558 | 6.338 | x0.966 | level | 4 of 4 | - | - | x0.998 | x1.000 | x0.725 |
| blake3-servil-mt / solo / IdleOneMessage / 2304 B | 6.513 | 6.893 | x1.058 | level | 0 of 4 | - | - | x0.999 | x1.000 | x1.079 |
| blake3-servil-mt / solo / IdleOneMessage / 3 KiB | 4.570 | 4.656 | x1.019 | level | 1 of 4 | - | - | x0.993 | x1.000 | x2.419 |
| blake3-servil-mt / solo / IdleOneMessage / 3839 B | 3.739 | 3.742 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.189 |
| blake3-servil-mt / solo / IdleOneMessage / 4 KiB | 3.532 | 3.377 | x0.956 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.075 |
| blake3-servil-mt / solo / IdleOneMessage / 4470 B | 3.674 | 3.760 | x1.023 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.913 |
| blake3-servil-mt / solo / IdleOneMessage / 7935 B | 2.520 | 2.573 | x1.021 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.030 |
| blake3-servil-mt / solo / IdleOneMessage / 8 KiB | 2.343 | 2.400 | x1.024 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.611 |
| blake3-servil-mt / solo / IdleOneMessage / 16 KiB | 1.583 | 1.587 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.215 |
| blake3-servil-mt / solo / IdleOneMessage / 32 KiB | 1.321 | 1.321 | x1.000 | level | 3 of 4 | - | - | x1.003 | x1.000 | x0.874 |
| blake3-servil-mt / solo / IdleOneMessage / 64 KiB | 0.835 | 0.820 | x0.982 | level | 2 of 4 | - | - | x0.994 | x1.000 | x1.053 |
| blake3-servil-mt / solo / IdleOneMessage / 128 KiB | 0.686 | 0.685 | x0.999 | level | 2 of 4 | - | - | x1.004 | x1.000 | x0.384 |
| blake3-servil-mt / solo / IdleOneMessage / 256 KiB | 0.485 | 0.488 | x1.007 | level | 1 of 4 | - | - | x1.006 | x1.000 | x0.664 |
| blake3-servil-mt / solo / IdleOneMessage / 512 KiB | 0.257 | 0.262 | x1.018 | level | 1 of 4 | - | - | x1.014 | x0.876 | x1.163 |
| blake3-servil-mt / solo / IdleOneMessage / 1 MiB | 0.222 | 0.220 | x0.991 | level | 3 of 4 | - | - | x0.985 | x0.972 | x0.885 |
| blake3-servil-mt / solo / IdleOneMessage / 2 MiB | 0.172 | 0.173 | x1.007 | level | 2 of 4 | - | - | x1.009 | x1.061 | x0.945 |
| blake3-servil-mt / solo / IdleOneMessage / 3 MiB | 0.156 | 0.157 | x1.008 | level | 2 of 4 | - | - | x1.008 | x1.070 | x1.077 |
| blake3-servil-mt / solo / IdleOneMessage / 4 MiB | 0.145 | 0.148 | x1.021 | level | 0 of 4 | - | - | x1.023 | x1.151 | x0.934 |
| blake3-servil-mt / solo / IdleOneMessage / 8 MiB | 0.131 | 0.131 | x0.999 | level | 4 of 4 | - | - | x0.999 | x1.002 | x0.967 |
| blake3-servil-mt / solo / IdleOneMessage / 32 MiB | 0.110 | 0.110 | x0.998 | level | 2 of 4 | - | - | x0.997 | x0.995 | x0.996 |
| blake3-servil-mt / solo / IdleOneMessage / 64 MiB | 0.104 | 0.104 | x0.999 | level | 4 of 4 | - | - | x1.000 | x0.994 | x1.044 |
| blake3-servil-mt / solo / IdleOneMessage / 128 MiB | 0.104 | 0.104 | x1.000 | level | 2 of 4 | - | - | x0.999 | x0.997 | x1.000 |
| blake3-servil-mt / solo / IdleManyMessages / 1 | 687.054 | 668.008 | x0.972 | level | 2 of 4 | - | - | x0.993 | x1.000 | x0.983 |
| blake3-servil-mt / solo / IdleManyMessages / 2 | 797.432 | 777.768 | x0.975 | level | 2 of 4 | - | - | x1.007 | x0.999 | x1.444 |
| blake3-servil-mt / solo / IdleManyMessages / 3 | 781.076 | 779.581 | x0.998 | level | 1 of 4 | - | - | x1.002 | x0.999 | x0.911 |
| blake3-servil-mt / solo / IdleManyMessages / 4 | 382.740 | 395.125 | x1.032 | level | 1 of 4 | - | - | x1.006 | x0.999 | x1.466 |
| blake3-servil-mt / solo / IdleManyMessages / 6 | 457.343 | 449.406 | x0.983 | level | 2 of 4 | - | - | x0.990 | x0.999 | - |
| blake3-servil-mt / solo / IdleManyMessages / 8 | 295.605 | 306.051 | x1.035 | level | 1 of 4 | - | - | x1.004 | x0.999 | x0.775 |
| blake3-servil-mt / solo / IdleManyMessages / 12 | 287.581 | 292.529 | x1.017 | level | 2 of 4 | - | - | x0.995 | x0.999 | x2.398 |
| blake3-servil-mt / solo / IdleManyMessages / 16 | 201.987 | 196.307 | x0.972 | level | 3 of 4 | - | - | x0.998 | x0.999 | x1.626 |
| blake3-servil-mt / solo / IdleManyMessages / 24 | 214.026 | 223.810 | x1.046 | level | 1 of 4 | - | - | x1.008 | x1.000 | x1.432 |
| blake3-servil-mt / solo / IdleManyMessages / 32 | 186.374 | 183.391 | x0.984 | level | 2 of 4 | - | - | x0.996 | x0.999 | x0.900 |
| blake3-servil-mt / solo / IdleManyMessages / 48 | 177.702 | 173.811 | x0.978 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.269 |
| blake3-servil-mt / solo / IdleManyMessages / 64 | 165.323 | 162.415 | x0.982 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.496 |
| blake3-servil-mt / solo / IdleManyMessages / 128 | 118.731 | 119.182 | x1.004 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.140 |
| blake3-servil-mt / solo / IdleManyMessages / 256 | 95.083 | 95.355 | x1.003 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.895 |
| blake3-servil-mt / solo / IdleManyMessages / 512 | 83.573 | 85.697 | x1.025 | level | 1 of 4 | - | - | x0.994 | x1.000 | x1.368 |
| blake3-servil-mt / solo / IdleManyMessages / 1024 | 53.853 | 54.044 | x1.004 | level | 1 of 4 | - | - | x0.980 | x1.000 | x1.051 |
| blake3-servil-mt / solo / IdleManyMessages / 2048 | 42.235 | 42.723 | x1.012 | level | 3 of 4 | - | - | x1.018 | x1.000 | x0.850 |
| blake3-servil-mt / solo / IdleManyMessages / 4096 | 30.825 | 31.232 | x1.013 | level | 1 of 4 | - | - | x1.008 | x1.000 | x0.633 |
| blake3-servil-mt / solo / IdleManyMessages / 8192 | 13.383 | 13.640 | x1.019 | level | 1 of 4 | - | - | x1.007 | x0.992 | x1.043 |
| blake3-servil-mt / solo / IdleManyMessages / 16384 | 11.658 | 11.740 | x1.007 | level | 1 of 4 | - | - | x1.008 | x1.028 | x0.978 |
| blake3-servil-mt / solo / IdleManyMessages / 32768 | 10.785 | 10.696 | x0.992 | level | 2 of 4 | - | - | x0.988 | x1.084 | x0.976 |
| blake3-servil-mt / solo / IdleManyMessages / 65536 | 9.330 | 9.379 | x1.005 | level | 0 of 4 | - | - | x1.007 | x1.125 | x1.004 |
| blake3-servil-mt / solo / IdleManyMessages / 131072 | 8.496 | 8.484 | x0.999 | level | 2 of 4 | - | - | x1.000 | x0.997 | x1.011 |
| blake3-servil-mt / solo / IdleManyMessages / 262144 | 7.921 | 7.907 | x0.998 | level | 3 of 4 | - | - | x0.998 | x0.999 | x1.016 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 B | 3.230 | 3.159 | x0.978 | level | 3 of 4 | - | - | x0.993 | x1.002 | x0.784 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 B | 2.371 | 2.425 | x1.023 | level | 3 of 4 | - | - | x1.007 | x1.002 | x1.190 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 B | 1.772 | 1.792 | x1.011 | level | 0 of 4 | - | - | x1.006 | x1.001 | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 B | 1.631 | 1.634 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.001 | x0.725 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 KiB | 1.523 | 1.505 | x0.988 | level | 4 of 4 | - | - | x0.997 | x1.000 | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1536 B | 1.223 | 1.227 | x1.003 | level | 3 of 4 | - | - | x1.003 | x0.997 | x4.221 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 KiB | 0.904 | 0.889 | x0.983 | level | 3 of 4 | - | - | x0.986 | x1.001 | x0.380 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2304 B | 1.019 | 1.039 | x1.019 | level | 1 of 4 | - | - | x1.008 | x1.001 | x1.973 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 KiB | 0.791 | 0.792 | x1.000 | level | 2 of 4 | - | - | x1.005 | x1.000 | x1.089 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3839 B | 0.586 | 0.592 | x1.010 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.823 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 KiB | 0.484 | 0.481 | x0.994 | level | 4 of 4 | - | - | x0.994 | x1.000 | x1.408 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4470 B | 0.597 | 0.590 | x0.988 | level | 4 of 4 | - | - | x0.990 | x1.001 | x2.340 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 7935 B | 0.448 | 0.442 | x0.986 | level | 3 of 4 | - | - | x0.993 | x1.000 | x2.184 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 KiB | 0.396 | 0.393 | x0.992 | level | 4 of 4 | - | - | x0.993 | x1.000 | x1.231 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 16 KiB | 0.296 | 0.295 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.806 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 KiB | 0.295 | 0.294 | x0.998 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.411 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 KiB | 0.286 | 0.285 | x0.996 | level | 2 of 4 | - | - | x1.000 | x1.000 | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 KiB | 0.283 | 0.283 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.384 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 KiB | 0.281 | 0.280 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.853 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 KiB | 0.137 | 0.141 | x1.026 | level | 3 of 4 | - | - | x1.027 | x0.986 | x1.165 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 MiB | 0.153 | 0.155 | x1.015 | level | 2 of 4 | - | - | x0.994 | x0.956 | x0.797 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 MiB | 0.136 | 0.135 | x0.994 | level | 3 of 4 | - | - | x0.998 | x0.994 | x0.948 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 MiB | 0.122 | 0.121 | x0.996 | level | 2 of 4 | - | - | x1.001 | x1.001 | x1.149 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 MiB | 0.119 | 0.119 | x0.997 | level | 4 of 4 | - | - | x0.999 | x1.001 | x0.994 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 MiB | 0.132 | 0.132 | x0.998 | level | 2 of 4 | - | - | x0.999 | x0.993 | x0.942 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 MiB | 0.109 | 0.109 | x0.999 | level | 4 of 4 | - | - | x0.998 | x0.997 | x1.017 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 MiB | 0.107 | 0.107 | x1.002 | level | 2 of 4 | - | - | x1.002 | x0.998 | x1.060 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 MiB | 0.104 | 0.104 | x1.002 | level | 2 of 4 | - | - | x1.000 | x0.997 | x1.001 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1 | 235.756 | 243.905 | x1.035 | level | 1 of 4 | - | - | x1.007 | x1.000 | x0.993 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2 | 206.481 | 213.053 | x1.032 | level | 2 of 4 | - | - | x1.010 | x0.997 | x1.067 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 3 | 128.792 | 132.012 | x1.025 | level | 2 of 4 | - | - | x1.016 | x0.998 | x0.746 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4 | 69.673 | 69.765 | x1.001 | level | 2 of 4 | - | - | x0.996 | x0.998 | x1.546 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 6 | 60.660 | 62.454 | x1.030 | level | 0 of 4 | - | - | x1.012 | x0.998 | x0.998 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8 | 42.453 | 42.760 | x1.007 | level | 2 of 4 | - | - | x1.001 | x0.998 | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 12 | 37.477 | 37.583 | x1.003 | level | 2 of 4 | - | - | x1.001 | x0.999 | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16 | 26.550 | 26.491 | x0.998 | level | 2 of 4 | - | - | x0.998 | x0.999 | x0.660 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 24 | 27.442 | 27.196 | x0.991 | level | 3 of 4 | - | - | x1.000 | x0.999 | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32 | 22.032 | 21.980 | x0.998 | level | 3 of 4 | - | - | x0.997 | x0.999 | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 48 | 19.806 | 19.834 | x1.001 | level | 2 of 4 | - | - | x1.002 | x0.999 | x1.175 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 64 | 19.103 | 19.563 | x1.024 | level | 1 of 4 | - | - | x1.001 | x0.999 | x0.977 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 128 | 17.942 | 18.121 | x1.010 | level | 1 of 4 | - | - | x0.999 | x1.000 | x1.150 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 256 | 18.248 | 18.384 | x1.007 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.904 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 512 | 18.338 | 18.314 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.834 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1024 | 18.193 | 18.025 | x0.991 | level | 4 of 4 | - | - | x0.996 | x1.000 | x0.898 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2048 | 17.998 | 18.036 | x1.002 | level | 1 of 4 | - | - | x0.999 | x1.000 | x1.024 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4096 | 18.018 | 17.998 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.176 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8192 | 10.646 | 10.717 | x1.007 | level | 0 of 4 | - | - | x1.004 | x0.972 | x1.046 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16384 | 9.540 | 9.458 | x0.991 | level | 4 of 4 | - | - | x0.991 | x0.967 | x0.978 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32768 | 8.473 | 8.467 | x0.999 | level | 2 of 4 | - | - | x1.001 | x1.007 | x0.989 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 65536 | 8.062 | 8.035 | x0.997 | level | 2 of 4 | - | - | x0.998 | x1.004 | x0.991 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 131072 | 8.525 | 8.533 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.008 | x1.000 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 262144 | 7.950 | 7.944 | x0.999 | level | 3 of 4 | - | - | x0.999 | x0.970 | x0.994 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 1.131 | 1.132 | x1.001 | level | 2 of 4 | x0.972 | - | x1.001 | x0.977 | x0.897 |
| blake3-servil-mt / solo / ContinuousMessages / 128 B | 0.552 | 0.554 | x1.004 | level | 1 of 4 | x0.973 | - | x1.004 | x0.977 | x1.549 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.298 | 0.296 | x0.995 | level | 2 of 4 | x0.968 | - | x0.995 | x0.978 | x0.924 |
| blake3-servil-mt / solo / ContinuousMessages / 512 B | 0.197 | 0.196 | x0.996 | level | 3 of 4 | x0.959 | - | x0.996 | x0.980 | x1.426 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.145 | 0.149 | x1.030 | level | 0 of 4 | x0.934 | - | x1.037 | x0.985 | x1.662 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0996 | 0.0954 | x0.958 | level | 4 of 4 | x1.020 | - | x0.959 | x0.974 | x0.976 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0923 | 0.0948 | x1.026 | level | 1 of 4 | x0.966 | - | x1.027 | x0.966 | x0.910 |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.0753 | 0.0760 | x1.009 | level | 1 of 4 | x0.990 | - | x1.009 | x1.027 | x1.048 |
| blake3-servil-mt / solo / ContinuousMessages / 256 KiB | 0.0743 | 0.0751 | x1.012 | level | 1 of 4 | x0.992 | - | x1.011 | x1.012 | x1.040 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0856 | 0.0857 | x1.001 | level | 1 of 4 | x0.998 | - | x1.001 | x1.026 | x1.129 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.102 | 0.0989 | x0.974 | level | 4 of 4 | x1.048 | - | x0.973 | x0.942 | x1.137 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0982 | 0.0977 | x0.995 | level | 3 of 4 | x1.020 | - | x0.996 | x1.006 | x0.937 |
| blake3-servil-mt / solo / ContinuousMessages / 64 MiB | 0.110 | 0.110 | x1.004 | level | 2 of 4 | x1.000 | - | x1.001 | x1.008 | x1.007 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 14.878 | 14.570 | x0.979 | level | 4 of 4 | x1.018 | - | x0.980 | x0.978 | x1.195 |
| blake3-servil-mt / solo / ContinuousBatches / 64 | 9.538 | 9.451 | x0.991 | level | 4 of 4 | x0.995 | - | x0.992 | x0.985 | x1.031 |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 7.472 | 7.410 | x0.992 | level | 4 of 4 | x0.992 | - | x0.991 | x0.990 | x2.743 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 6.895 | 6.973 | x1.011 | level | 1 of 4 | x1.018 | - | x1.011 | x1.032 | x0.979 |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 7.034 | 7.049 | x1.002 | level | 3 of 4 | x0.996 | - | x1.003 | x0.917 | x1.235 |
| blake3-servil-mt / solo / ContinuousBatches / 16384 | 9.192 | 9.306 | x1.012 | level | 2 of 4 | x1.027 | - | x1.012 | x1.218 | x2.614 |
| blake3-servil-mt / solo / ContinuousBatches / 65536 | 9.035 | 9.077 | x1.005 | level | 2 of 4 | x1.004 | - | x1.005 | x0.997 | x0.984 |
| blake3-servil-mt / solo / LentMessages / 64 B | 1.513 | 1.521 | x1.006 | level | 0 of 4 | x1.006 | - | x1.006 | x1.000 | - |
| blake3-servil-mt / solo / LentMessages / 128 B | 1.449 | 1.454 | x1.003 | level | 1 of 4 | x1.003 | - | x1.003 | x1.000 | - |
| blake3-servil-mt / solo / LentMessages / 256 B | 1.417 | 1.415 | x0.998 | level | 2 of 4 | x0.998 | - | x0.998 | x1.000 | - |
| blake3-servil-mt / solo / LentMessages / 512 B | 1.408 | 1.408 | x1.000 | level | 3 of 4 | x1.000 | - | x0.999 | x1.000 | x0.625 |
| blake3-servil-mt / solo / LentMessages / 1 KiB | 1.399 | 1.401 | x1.002 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x2.030 |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.436 | 0.439 | x1.006 | level | 0 of 4 | x1.006 | - | x1.006 | x1.000 | x0.630 |
| blake3-servil-mt / solo / LentMessages / 16 KiB | 0.271 | 0.271 | x1.001 | level | 1 of 4 | x1.002 | - | x1.002 | x1.000 | x1.455 |
| blake3-servil-mt / solo / LentMessages / 64 KiB | 0.280 | 0.280 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | - |
| blake3-servil-mt / solo / LentMessages / 256 KiB | 0.277 | 0.277 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x0.447 |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.132 | 0.133 | x1.007 | level | 1 of 4 | x1.016 | - | x1.006 | x1.007 | x1.326 |
| blake3-servil-mt / solo / LentMessages / 4 MiB | 0.117 | 0.117 | x0.997 | level | 3 of 4 | x0.991 | - | x0.997 | x0.990 | x1.098 |
| blake3-servil-mt / solo / LentMessages / 16 MiB | 0.117 | 0.116 | x0.996 | level | 2 of 4 | x1.001 | - | x0.996 | x1.006 | x0.934 |
| blake3-servil-mt / solo / LentMessages / 64 MiB | 0.111 | 0.110 | x0.991 | level | 4 of 4 | x1.001 | - | x0.992 | x1.001 | x1.001 |
| blake3-servil-mt / solo / Interleaved / 256 | 0.394 | 0.391 | x0.992 | level | 4 of 4 | x0.992 | - | x0.992 | x0.997 | x0.631 |
| blake3-servil-mt / solo / Collection / git objects | 0.0162 | 0.0162 | x1.003 | level | 1 of 4 | x1.001 | - | x1.002 | x0.995 | x0.950 |
| blake3-servil-mt / solo / Collection / Nix files | 0.0248 | 0.0244 | x0.985 | level | 2 of 4 | x0.989 | - | x0.988 | x0.992 | x0.853 |
| blake3-servil-mt / solo / LentBatches / 16 | 20.958 | 20.609 | x0.983 | level | 4 of 4 | x0.983 | - | x0.983 | x0.998 | x0.992 |
| blake3-servil-mt / solo / LentBatches / 64 | 17.971 | 18.085 | x1.006 | level | 1 of 4 | x1.007 | - | x1.007 | x0.999 | - |
| blake3-servil-mt / solo / LentBatches / 256 | 17.756 | 17.816 | x1.003 | level | 1 of 4 | x1.003 | - | x1.003 | x0.999 | - |
| blake3-servil-mt / solo / LentBatches / 1024 | 19.218 | 19.507 | x1.015 | level | 1 of 4 | x1.012 | - | x1.012 | x1.000 | - |
| blake3-servil-mt / solo / LentBatches / 4096 | 18.967 | 19.404 | x1.023 | level | 0 of 4 | x1.022 | - | x1.022 | x1.000 | - |
| blake3-servil-mt / solo / LentBatches / 16384 | 11.310 | 11.425 | x1.010 | level | 2 of 4 | x0.991 | - | x1.013 | x1.003 | x0.067 |
| blake3-servil-mt / solo / LentBatches / 65536 | 10.370 | 10.077 | x0.972 | level | 2 of 4 | x0.870 | - | x0.973 | x0.926 | x0.536 |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.111 | 0.109 | x0.989 | level | 4 of 4 | x0.980 | - | x0.990 | x0.984 | x1.003 |
| blake3-servil-mt / solo / ContinuousCollection / Nix files | 0.110 | 0.107 | x0.981 | level | 4 of 4 | x0.999 | - | x0.986 | x0.988 | x1.013 |
| blake3-servil-mt / solo / MerkleTree / 1024 | 0.350 | 0.349 | x0.996 | level | 4 of 4 | x0.997 | - | x0.998 | x1.001 | x0.422 |
| blake3-servil-mt / solo / MerkleTree / 4096 | 0.230 | 0.229 | x0.992 | level | 3 of 4 | x0.987 | - | x0.993 | x1.005 | x1.185 |
| blake3-servil-mt / solo / MerkleTree / 16384 | 0.193 | 0.191 | x0.988 | level | 2 of 4 | x0.990 | - | x0.987 | x0.991 | x0.729 |
| blake3-servil-mt / solo / MerkleTree / 65536 | 0.166 | 0.167 | x1.003 | level | 2 of 4 | x0.995 | - | x1.003 | x1.004 | x0.989 |
| blake3-servil-mt / solo / MerkleTree / 262144 | 0.146 | 0.146 | x1.003 | level | 2 of 4 | x0.994 | - | x1.004 | x1.001 | x0.990 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 32 B | 0.258 | 0.260 | x1.005 | level | 1 of 4 | x1.014 | - | x1.006 | x1.008 | x0.732 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 32 B | 0.150 | 0.150 | x0.998 | level | 2 of 4 | x0.999 | - | x0.998 | x0.996 | x0.996 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 16 B | 0.276 | 0.274 | x0.995 | level | 3 of 4 | x1.000 | - | x0.996 | x1.003 | x0.991 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 48 B | 0.210 | 0.211 | x1.004 | level | 1 of 4 | x1.013 | - | x1.002 | x0.999 | x0.856 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 48 B | 0.139 | 0.138 | x0.997 | level | 3 of 4 | x1.001 | - | x0.998 | x1.000 | x1.004 |
| blake3-servil-mt / solo / InterleavedTurn / 256 | 1.002 | 1.010 | x1.007 | level | 2 of 4 | - | - | x1.000 | x0.999 | x0.995 |
| blake3-servil-mt / solo / InterleavedTurn / 1024 x 1 KiB | 0.674 | 0.678 | x1.005 | level | 2 of 4 | - | - | x1.005 | x0.995 | x1.003 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 256 | 0.665 | 0.666 | x1.001 | level | 2 of 4 | - | - | x0.994 | x0.965 | x1.004 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.641 | 0.648 | x1.011 | level | 2 of 4 | - | - | x1.013 | x0.993 | x0.987 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 256 | 0.669 | 0.667 | x0.997 | level | 3 of 4 | - | - | x0.988 | x0.933 | x1.005 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.607 | 0.612 | x1.008 | level | 3 of 4 | - | - | x1.009 | x0.993 | x1.000 |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.105 | 0.103 | x0.988 | level | 2 of 4 | x0.989 | - | x0.988 | x1.016 | x0.627 |
| blake3-servil-mt / solo / ReceivingMessage / 2 μs | 0.106 | 0.105 | x0.992 | level | 2 of 4 | x0.993 | - | x0.991 | x1.000 | x0.673 |
| blake3-servil-mt / solo / ReceivingMessage / 20 μs | 0.918 | 0.918 | x1.000 | level | 2 of 4 | x0.992 | - | x0.977 | x1.004 | x0.778 |
| blake3-servil-mt / solo / IncrementalMessage / 64 B | 18.657 | 20.113 | x1.078 | level | 0 of 4 | - | - | x1.030 | x1.001 | x1.003 |
| blake3-servil-mt / solo / IncrementalMessage / 1 KiB | 3.381 | 3.199 | x0.946 | level | 3 of 4 | - | - | x0.960 | x1.000 | x0.924 |
| blake3-servil-mt / solo / IncrementalMessage / 4 KiB | 2.447 | 2.460 | x1.005 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.942 |
| blake3-servil-mt / solo / LentIncrementalMessage / 64 B | 1.853 | 1.853 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.266 |
| blake3-servil-mt / solo / LentIncrementalMessage / 1 KiB | 1.437 | 1.435 | x0.999 | level | 4 of 4 | x0.999 | - | x0.999 | x1.000 | x1.127 |
| blake3-servil-mt / solo / LentIncrementalMessage / 4 KiB | 0.455 | 0.456 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | x0.587 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 12.711 | 13.696 | x1.078 | level | 0 of 4 | x1.325 | - | x1.061 | x0.946 | x11.484 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 4 KiB | 0.241 | 0.257 | x1.064 | level | 0 of 4 | x1.054 | - | x1.068 | x0.945 | x3.459 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 1 MiB | 0.0849 | 0.0853 | x1.005 | level | 2 of 4 | x1.002 | - | x1.005 | x1.005 | x0.999 |
| blake3-servil-mt / solo / ContinuousLentMessages / 64 B | 1.000 | 1.185 | x1.185 | level | 2 of 4 | x0.920 | - | x1.178 | x0.974 | x0.964 |
| blake3-servil-mt / solo / ContinuousLentMessages / 4 KiB | 0.0527 | 0.0501 | x0.951 | level | 4 of 4 | x0.988 | - | x0.949 | x0.968 | x1.218 |
| blake3-servil-mt / solo / ContinuousLentMessages / 1 MiB | 0.00878 | 0.00875 | x0.997 | level | 2 of 4 | x0.994 | - | x0.998 | x1.000 | x1.049 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 1.115 | 1.110 | x0.996 | level | 3 of 4 | - | - | x0.996 | x0.977 | x0.971 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 128 B | 0.549 | 0.547 | x0.995 | level | 3 of 4 | - | - | x0.995 | x0.977 | x1.191 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.301 | 0.302 | x1.003 | level | 2 of 4 | - | - | x1.000 | x0.978 | x1.058 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 512 B | 0.209 | 0.211 | x1.009 | level | 2 of 4 | - | - | x1.010 | x0.980 | x1.043 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.160 | 0.159 | x0.991 | level | 2 of 4 | - | - | x0.991 | x0.985 | x1.252 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.106 | 0.104 | x0.980 | level | 3 of 4 | - | - | x0.980 | x0.974 | x1.010 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.109 | 0.108 | x0.995 | level | 2 of 4 | - | - | x0.995 | x0.966 | x0.978 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.0809 | 0.0806 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.021 | x1.028 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 KiB | 0.0802 | 0.0804 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.013 | x1.030 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0872 | 0.0891 | x1.021 | level | 1 of 4 | - | - | x1.021 | x1.011 | x0.996 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.103 | 0.103 | x0.997 | level | 3 of 4 | - | - | x0.996 | x0.999 | x1.030 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.103 | 0.103 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.008 | x0.982 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 MiB | 0.127 | 0.126 | x0.993 | level | 2 of 4 | - | - | x0.994 | x1.007 | x1.006 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 15.208 | 15.190 | x0.999 | level | 2 of 4 | - | - | x0.999 | x0.978 | x1.054 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 64 | 9.825 | 9.684 | x0.986 | level | 4 of 4 | - | - | x0.986 | x0.983 | x0.985 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 256 | 7.733 | 7.631 | x0.987 | level | 4 of 4 | - | - | x0.990 | x1.008 | x0.556 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 7.126 | 7.027 | x0.986 | level | 4 of 4 | - | - | x0.987 | x1.068 | x0.773 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 4096 | 7.476 | 7.326 | x0.980 | level | 3 of 4 | - | - | x0.980 | x0.909 | x0.563 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16384 | 9.655 | 9.561 | x0.990 | level | 3 of 4 | - | - | x0.990 | x0.970 | x0.953 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 65536 | 9.272 | 9.203 | x0.993 | level | 3 of 4 | - | - | x0.993 | x1.004 | x0.613 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 1.514 | 1.515 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.694 |
| blake3-servil-mt / shared-one-cache / LentMessages / 128 B | 1.447 | 1.459 | x1.008 | level | 0 of 4 | - | - | x1.008 | x1.000 | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 B | 1.434 | 1.412 | x0.985 | level | 4 of 4 | - | - | x0.985 | x1.000 | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 512 B | 1.417 | 1.408 | x0.994 | level | 4 of 4 | - | - | x0.998 | x1.000 | x1.192 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 KiB | 1.398 | 1.401 | x1.002 | level | 0 of 4 | - | - | x1.002 | x1.000 | x1.395 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.441 | 0.435 | x0.986 | level | 4 of 4 | - | - | x0.986 | x1.000 | x1.206 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 KiB | 0.272 | 0.271 | x0.997 | level | 4 of 4 | - | - | x0.997 | x1.000 | x0.991 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 KiB | 0.281 | 0.280 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.969 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 KiB | 0.279 | 0.277 | x0.994 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.512 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 MiB | 0.151 | 0.150 | x0.994 | level | 2 of 4 | - | - | x1.004 | x1.042 | x0.819 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 MiB | 0.125 | 0.125 | x1.002 | level | 2 of 4 | - | - | x1.003 | x1.035 | x1.462 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 MiB | 0.133 | 0.137 | x1.030 | level | 1 of 4 | - | - | x1.030 | x0.988 | x0.951 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 MiB | 0.125 | 0.125 | x1.000 | level | 3 of 4 | - | - | x1.001 | x0.998 | x1.005 |
| blake3-servil-mt / shared-one-cache / Interleaved / 256 | 0.384 | 0.384 | x0.998 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.992 |
| blake3-servil-mt / shared-one-cache / Collection / git objects | 0.0268 | 0.0271 | x1.010 | level | 1 of 4 | - | - | x1.012 | x1.007 | x1.019 |
| blake3-servil-mt / shared-one-cache / Collection / Nix files | 0.0322 | 0.0327 | x1.017 | level | 1 of 4 | - | - | x1.008 | x1.002 | x0.982 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16 | 20.534 | 20.790 | x1.012 | level | 0 of 4 | - | - | x1.013 | x0.998 | x0.295 |
| blake3-servil-mt / shared-one-cache / LentBatches / 64 | 17.971 | 18.106 | x1.007 | level | 1 of 4 | - | - | x1.005 | x1.000 | - |
| blake3-servil-mt / shared-one-cache / LentBatches / 256 | 17.765 | 17.665 | x0.994 | level | 4 of 4 | - | - | x0.994 | x1.000 | x1.295 |
| blake3-servil-mt / shared-one-cache / LentBatches / 1024 | 19.318 | 19.147 | x0.991 | level | 4 of 4 | - | - | x0.991 | x1.000 | - |
| blake3-servil-mt / shared-one-cache / LentBatches / 4096 | 19.297 | 19.092 | x0.989 | level | 4 of 4 | - | - | x0.989 | x1.000 | - |
| blake3-servil-mt / shared-one-cache / LentBatches / 16384 | 12.822 | 12.746 | x0.994 | level | 3 of 4 | - | - | x0.995 | x0.992 | x1.200 |
| blake3-servil-mt / shared-one-cache / LentBatches / 65536 | 10.617 | 10.496 | x0.989 | level | 4 of 4 | - | - | x0.987 | x0.943 | x0.655 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.125 | 0.124 | x0.995 | level | 3 of 4 | - | - | x0.995 | x0.985 | x0.984 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / Nix files | 0.123 | 0.122 | x0.994 | level | 3 of 4 | - | - | x0.993 | x0.989 | x1.003 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1024 | 0.350 | 0.350 | x1.000 | level | 3 of 4 | - | - | x0.999 | x1.001 | x3.483 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 4096 | 0.251 | 0.252 | x1.002 | level | 0 of 4 | - | - | x1.001 | x0.995 | x1.445 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 16384 | 0.203 | 0.202 | x0.999 | level | 2 of 4 | - | - | x0.999 | x0.995 | x1.541 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 | 0.192 | 0.192 | x0.996 | level | 4 of 4 | - | - | x0.997 | x0.993 | x0.979 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 262144 | 0.176 | 0.175 | x0.995 | level | 3 of 4 | - | - | x0.996 | x0.988 | x1.011 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 32 B | 0.287 | 0.288 | x1.003 | level | 1 of 4 | - | - | x1.006 | x1.014 | x0.849 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 32 B | 0.232 | 0.230 | x0.995 | level | 3 of 4 | - | - | x0.997 | x0.990 | x0.996 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 16 B | 0.423 | 0.422 | x0.997 | level | 1 of 4 | - | - | x1.001 | x0.990 | x1.002 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 48 B | 0.232 | 0.232 | x1.000 | level | 2 of 4 | - | - | x1.005 | x1.035 | x1.353 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 48 B | 0.195 | 0.195 | x0.999 | level | 3 of 4 | - | - | x0.996 | x1.010 | x0.991 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.108 | 0.108 | x1.001 | level | 1 of 4 | - | - | x1.001 | x0.996 | x0.977 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 2 μs | 0.109 | 0.109 | x1.001 | level | 1 of 4 | - | - | x1.004 | x1.008 | x0.978 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 20 μs | 0.918 | 0.918 | x1.000 | level | 3 of 4 | - | - | x0.966 | x1.000 | x0.972 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 64 B | 1.863 | 1.870 | x1.004 | level | 0 of 4 | - | - | x1.004 | x1.000 | x0.586 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 1 KiB | 1.437 | 1.439 | x1.002 | level | 0 of 4 | - | - | x1.002 | x1.000 | x1.089 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 4 KiB | 0.454 | 0.455 | x1.004 | level | 0 of 4 | - | - | x1.003 | x1.000 | x0.663 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 18.357 | 18.091 | x0.986 | level | 2 of 4 | - | - | x0.967 | x0.944 | x13.168 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 4 KiB | 0.293 | 0.299 | x1.018 | level | 2 of 4 | - | - | x1.019 | x0.946 | x16.400 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 1 MiB | 0.0860 | 0.0869 | x1.010 | level | 1 of 4 | - | - | x1.010 | x1.016 | x1.069 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 64 B | 1.013 | 1.003 | x0.990 | level | 2 of 4 | - | - | x0.990 | x0.974 | x1.028 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 4 KiB | 0.0658 | 0.0628 | x0.954 | level | 4 of 4 | - | - | x0.952 | x0.967 | x1.191 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 1 MiB | 0.0211 | 0.0173 | x0.821 | level | 3 of 4 | - | - | x0.890 | x0.891 | x1.251 |

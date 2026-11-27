# Nightly drift check: e1966b498bc7 -> 17ccf2c8f5bb

- Host: bench-zen3
- Experiment: `bench=3f119a507807078649d8700112994fce24666868|base=e1966b498bc769db3d51451a4ddc8188a19ed593|target=17ccf2c8f5bb689ec552be1c976b54311da0c29f|cells=all|layouts=default`
- bench-hashes: `3f119a507807078649d8700112994fce24666868`
- BLAKE3-Servil base: `e1966b498bc769db3d51451a4ddc8188a19ed593`
- BLAKE3-Servil target: `17ccf2c8f5bb689ec552be1c976b54311da0c29f`
- Scope: `--cells all` (layouts: default)
- Deciding stage: stage 2 (kept-drift/second)
- Verdict: **no regression** (exit `0`)

## Stage 2 (deciding, kept-drift/second)

compare: old side: bench 3f119a507807 clean; servil e1966b498bc7 clean
compare: new side: bench 3f119a507807 clean; servil 17ccf2c8f5bb clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / ManyMessages / 1 | 432.896 | 419.503 | x0.969 | level | 35 of 64 | - | - | x0.966 | x1.007 | x0.997 |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.897 | 0.940 | x1.048 | level | 0 of 64 | x1.048 | - | x1.048 | x1.011 | x0.968 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 0.872 | 0.893 | x1.024 | level | 0 of 64 | x1.024 | - | x1.024 | x1.011 | x0.999 |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 0.839 | 0.839 | x1.000 | level | 55 of 64 | x0.999 | - | x0.999 | x1.012 | x1.078 |
| blake3-servil-mt / solo / ContinuousMessages / 256 KiB | 0.0454 | 0.0456 | x1.004 | level | 30 of 64 | x0.991 | - | x1.002 | x1.010 | x0.998 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 6.069 | 5.995 | x0.988 | level | 37 of 64 | x0.954 | - | x0.987 | x0.986 | x1.024 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 KiB | 0.0749 | 0.0755 | x1.008 | level | 22 of 64 | - | - | x1.010 | x1.011 | x0.995 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 15.903 | 14.465 | x0.910 | faster | 56 of 64 | - | - | x0.895 | x0.985 | x0.950 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 256 KiB | 0.0904 | 0.0921 | x1.019 | level | 22 of 64 | - | - | x1.006 | x1.010 | x0.947 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 64 B | 17.968 | 16.595 | x0.924 | faster | 58 of 64 | - | - | x0.929 | x0.989 | x0.949 |

## Stage 1 (initial screen, kept-drift)

compare: old side: bench 3f119a507807 clean; servil e1966b498bc7 clean
compare: new side: bench 3f119a507807 clean; servil 17ccf2c8f5bb clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 7.508 | 7.299 | x0.972 | level | 3 of 4 | - | - | x0.959 | x1.006 | x0.915 |
| blake3-servil-st / solo / OneMessage / 128 B | 4.373 | 4.200 | x0.960 | level | 3 of 4 | - | - | x0.969 | x1.005 | x0.930 |
| blake3-servil-st / solo / OneMessage / 256 B | 2.629 | 2.660 | x1.012 | level | 2 of 4 | - | - | x0.994 | x1.003 | x0.942 |
| blake3-servil-st / solo / OneMessage / 512 B | 1.843 | 1.849 | x1.003 | level | 1 of 4 | - | - | x0.995 | x1.002 | x0.953 |
| blake3-servil-st / solo / OneMessage / 1 KiB | 1.392 | 1.398 | x1.004 | level | 2 of 4 | - | - | x0.971 | x1.002 | x0.967 |
| blake3-servil-st / solo / OneMessage / 1536 B | 1.450 | 1.413 | x0.975 | level | 3 of 4 | - | - | x0.993 | x0.997 | x0.927 |
| blake3-servil-st / solo / OneMessage / 2 KiB | 0.942 | 0.940 | x0.999 | level | 2 of 4 | - | - | x0.977 | x1.000 | x0.954 |
| blake3-servil-st / solo / OneMessage / 2304 B | 1.081 | 1.051 | x0.972 | level | 3 of 4 | - | - | x0.966 | x1.001 | x0.961 |
| blake3-servil-st / solo / OneMessage / 3 KiB | 0.850 | 0.832 | x0.979 | level | 1 of 4 | - | - | x1.011 | x1.000 | x0.973 |
| blake3-servil-st / solo / OneMessage / 3839 B | 0.930 | 0.972 | x1.046 | level | 1 of 4 | - | - | x1.014 | x1.001 | x0.996 |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.595 | 0.601 | x1.010 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.959 |
| blake3-servil-st / solo / OneMessage / 4470 B | 0.665 | 0.663 | x0.997 | level | 2 of 4 | - | - | x0.986 | x1.001 | x0.970 |
| blake3-servil-st / solo / OneMessage / 7935 B | 0.527 | 0.560 | x1.063 | level | 0 of 4 | - | - | x1.032 | x1.000 | x1.015 |
| blake3-servil-st / solo / OneMessage / 8 KiB | 0.448 | 0.432 | x0.962 | level | 4 of 4 | - | - | x0.974 | x1.000 | x0.967 |
| blake3-servil-st / solo / OneMessage / 16 KiB | 0.374 | 0.378 | x1.011 | level | 1 of 4 | - | - | x1.006 | x1.000 | x0.980 |
| blake3-servil-st / solo / OneMessage / 32 KiB | 0.331 | 0.332 | x1.003 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.023 |
| blake3-servil-st / solo / OneMessage / 64 KiB | 0.315 | 0.311 | x0.987 | level | 2 of 4 | - | - | x0.991 | x1.000 | x0.964 |
| blake3-servil-st / solo / OneMessage / 128 KiB | 0.302 | 0.301 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.957 |
| blake3-servil-st / solo / OneMessage / 256 KiB | 0.293 | 0.294 | x1.004 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.966 |
| blake3-servil-st / solo / OneMessage / 512 KiB | 0.286 | 0.287 | x1.006 | level | 1 of 4 | - | - | x1.004 | x1.000 | x0.997 |
| blake3-servil-st / solo / OneMessage / 1 MiB | 0.287 | 0.286 | x0.996 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.016 |
| blake3-servil-st / solo / OneMessage / 2 MiB | 0.298 | 0.297 | x0.997 | level | 4 of 4 | - | - | x0.996 | x1.000 | x1.011 |
| blake3-servil-st / solo / OneMessage / 3 MiB | 0.306 | 0.303 | x0.988 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.018 |
| blake3-servil-st / solo / OneMessage / 4 MiB | 0.297 | 0.296 | x0.998 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.000 |
| blake3-servil-st / solo / OneMessage / 8 MiB | 0.312 | 0.311 | x0.997 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.011 |
| blake3-servil-st / solo / OneMessage / 32 MiB | 0.304 | 0.300 | x0.988 | level | 4 of 4 | - | - | x0.988 | x1.000 | x0.983 |
| blake3-servil-st / solo / OneMessage / 64 MiB | 0.305 | 0.301 | x0.987 | level | 4 of 4 | - | - | x0.988 | x1.000 | x0.994 |
| blake3-servil-st / solo / OneMessage / 128 MiB | 0.303 | 0.298 | x0.984 | level | 4 of 4 | - | - | x0.984 | x1.000 | x0.980 |
| blake3-servil-st / solo / ManyMessages / 1 | 460.806 | 444.468 | x0.965 | level | 3 of 4 | - | - | x0.981 | x1.014 | x0.946 |
| blake3-servil-st / solo / ManyMessages / 2 | 259.397 | 283.130 | x1.091 | level | 0 of 4 | - | - | x1.067 | x1.002 | x0.952 |
| blake3-servil-st / solo / ManyMessages / 3 | 192.577 | 207.581 | x1.078 | level | 1 of 4 | - | - | x1.051 | x1.001 | x0.960 |
| blake3-servil-st / solo / ManyMessages / 4 | 148.592 | 158.311 | x1.065 | level | 1 of 4 | - | - | x1.051 | x1.002 | x0.965 |
| blake3-servil-st / solo / ManyMessages / 6 | 122.026 | 126.357 | x1.035 | level | 1 of 4 | - | - | x1.013 | x1.001 | x0.962 |
| blake3-servil-st / solo / ManyMessages / 8 | 101.836 | 108.801 | x1.068 | level | 1 of 4 | - | - | x1.058 | x1.002 | x0.982 |
| blake3-servil-st / solo / ManyMessages / 12 | 77.339 | 86.636 | x1.120 | level | 1 of 4 | - | - | x1.054 | x1.001 | x0.988 |
| blake3-servil-st / solo / ManyMessages / 16 | 59.901 | 64.492 | x1.077 | level | 2 of 4 | - | - | x1.034 | x1.000 | x0.974 |
| blake3-servil-st / solo / ManyMessages / 24 | 43.877 | 46.642 | x1.063 | level | 1 of 4 | - | - | x1.048 | x1.001 | x0.977 |
| blake3-servil-st / solo / ManyMessages / 32 | 40.023 | 38.380 | x0.959 | level | 2 of 4 | - | - | x1.028 | x1.001 | x0.978 |
| blake3-servil-st / solo / ManyMessages / 48 | 29.815 | 31.630 | x1.061 | level | 0 of 4 | - | - | x1.029 | x1.000 | x0.971 |
| blake3-servil-st / solo / ManyMessages / 64 | 26.493 | 27.285 | x1.030 | level | 1 of 4 | - | - | x1.018 | x1.000 | x0.979 |
| blake3-servil-st / solo / ManyMessages / 128 | 29.706 | 24.531 | x0.826 | level | 2 of 4 | - | - | x1.018 | x1.000 | x0.982 |
| blake3-servil-st / solo / ManyMessages / 256 | 20.590 | 20.716 | x1.006 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.964 |
| blake3-servil-st / solo / ManyMessages / 512 | 18.935 | 19.418 | x1.025 | level | 0 of 4 | - | - | x1.007 | x1.000 | x0.996 |
| blake3-servil-st / solo / ManyMessages / 1024 | 18.434 | 18.622 | x1.010 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.956 |
| blake3-servil-st / solo / ManyMessages / 2048 | 18.209 | 18.208 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.018 |
| blake3-servil-st / solo / ManyMessages / 4096 | 17.916 | 17.916 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.001 |
| blake3-servil-st / solo / ManyMessages / 8192 | 17.197 | 17.308 | x1.006 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.015 |
| blake3-servil-st / solo / ManyMessages / 16384 | 17.159 | 17.112 | x0.997 | level | 3 of 4 | - | - | x1.001 | x1.000 | x1.027 |
| blake3-servil-st / solo / ManyMessages / 32768 | 17.479 | 17.415 | x0.996 | level | 3 of 4 | - | - | x0.994 | x1.000 | x1.010 |
| blake3-servil-st / solo / ManyMessages / 65536 | 17.520 | 17.739 | x1.013 | level | 1 of 4 | - | - | x1.012 | x1.000 | x1.034 |
| blake3-servil-st / solo / ManyMessages / 131072 | 18.031 | 18.212 | x1.010 | level | 1 of 4 | - | - | x1.010 | x1.000 | x1.028 |
| blake3-servil-st / solo / ManyMessages / 262144 | 18.463 | 18.507 | x1.002 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.013 |
| blake3-servil-st / solo / ManyLongMessages / 4 | 1776.743 | 1777.895 | x1.001 | level | 2 of 4 | - | - | x1.004 | x1.001 | x0.953 |
| blake3-servil-st / solo / ManyLongMessages / 16 | 1244.737 | 1216.026 | x0.977 | level | 3 of 4 | - | - | x0.987 | x0.998 | x0.932 |
| blake3-servil-st / solo / ManyLongMessages / 64 | 1170.248 | 1165.237 | x0.996 | level | 2 of 4 | - | - | x1.000 | x0.998 | x0.955 |
| blake3-servil-st / solo / ManyLongMessages / 256 | 1131.670 | 1137.474 | x1.005 | level | 1 of 4 | - | - | x1.002 | x0.998 | x1.002 |
| blake3-servil-st / solo / IdleOneMessage / 64 B | 5.378 | 5.558 | x1.033 | level | 0 of 4 | - | - | x1.017 | x1.006 | x0.806 |
| blake3-servil-st / solo / IdleOneMessage / 128 B | 3.918 | 3.763 | x0.960 | level | 3 of 4 | - | - | x1.008 | x1.006 | x0.839 |
| blake3-servil-st / solo / IdleOneMessage / 256 B | 2.840 | 2.854 | x1.005 | level | 2 of 4 | - | - | x1.003 | x1.004 | x0.809 |
| blake3-servil-st / solo / IdleOneMessage / 512 B | 2.395 | 2.463 | x1.028 | level | 0 of 4 | - | - | x1.003 | x1.002 | x0.912 |
| blake3-servil-st / solo / IdleOneMessage / 1 KiB | 2.218 | 2.166 | x0.976 | level | 2 of 4 | - | - | x0.997 | x1.001 | x0.937 |
| blake3-servil-st / solo / IdleOneMessage / 1536 B | 1.758 | 1.760 | x1.001 | level | 3 of 4 | - | - | x0.994 | x0.998 | x1.010 |
| blake3-servil-st / solo / IdleOneMessage / 2 KiB | 1.210 | 1.219 | x1.008 | level | 2 of 4 | - | - | x1.009 | x1.000 | x1.327 |
| blake3-servil-st / solo / IdleOneMessage / 2304 B | 1.416 | 1.452 | x1.026 | level | 3 of 4 | - | - | x0.995 | x1.001 | x0.770 |
| blake3-servil-st / solo / IdleOneMessage / 3 KiB | 1.048 | 1.041 | x0.993 | level | 3 of 4 | - | - | x1.019 | x1.000 | x0.937 |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 1.077 | 1.048 | x0.973 | level | 3 of 4 | - | - | x1.016 | x1.000 | x1.120 |
| blake3-servil-st / solo / IdleOneMessage / 4 KiB | 0.790 | 0.766 | x0.969 | level | 3 of 4 | - | - | x0.986 | x1.000 | x0.653 |
| blake3-servil-st / solo / IdleOneMessage / 4470 B | 0.938 | 0.911 | x0.971 | level | 3 of 4 | - | - | x1.008 | x1.000 | x0.959 |
| blake3-servil-st / solo / IdleOneMessage / 7935 B | 0.587 | 0.643 | x1.095 | level | 0 of 4 | - | - | x1.027 | x1.000 | x1.046 |
| blake3-servil-st / solo / IdleOneMessage / 8 KiB | 0.538 | 0.531 | x0.987 | level | 2 of 4 | - | - | x0.985 | x1.000 | x0.674 |
| blake3-servil-st / solo / IdleOneMessage / 16 KiB | 0.495 | 0.514 | x1.039 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.014 |
| blake3-servil-st / solo / IdleOneMessage / 32 KiB | 0.477 | 0.478 | x1.002 | level | 1 of 4 | - | - | x0.998 | x1.000 | x1.096 |
| blake3-servil-st / solo / IdleOneMessage / 64 KiB | 0.485 | 0.475 | x0.980 | level | 3 of 4 | - | - | x0.994 | x1.000 | x1.259 |
| blake3-servil-st / solo / IdleOneMessage / 128 KiB | 0.465 | 0.483 | x1.039 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.005 |
| blake3-servil-st / solo / IdleOneMessage / 256 KiB | 0.465 | 0.480 | x1.033 | level | 0 of 4 | - | - | x0.996 | x1.000 | x1.036 |
| blake3-servil-st / solo / IdleOneMessage / 512 KiB | 0.480 | 0.491 | x1.023 | level | 1 of 4 | - | - | x0.994 | x1.000 | x1.006 |
| blake3-servil-st / solo / IdleOneMessage / 1 MiB | 0.484 | 0.488 | x1.008 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.022 |
| blake3-servil-st / solo / IdleOneMessage / 2 MiB | 0.505 | 0.478 | x0.946 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.041 |
| blake3-servil-st / solo / IdleOneMessage / 3 MiB | 0.461 | 0.463 | x1.005 | level | 1 of 4 | - | - | x0.995 | x1.000 | x1.028 |
| blake3-servil-st / solo / IdleOneMessage / 4 MiB | 0.426 | 0.417 | x0.980 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.007 |
| blake3-servil-st / solo / IdleOneMessage / 8 MiB | 0.335 | 0.331 | x0.990 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.015 |
| blake3-servil-st / solo / IdleOneMessage / 32 MiB | 0.300 | 0.299 | x0.996 | level | 3 of 4 | - | - | x0.986 | x1.000 | x0.987 |
| blake3-servil-st / solo / IdleOneMessage / 64 MiB | 0.303 | 0.300 | x0.988 | level | 4 of 4 | - | - | x0.989 | x1.000 | x0.976 |
| blake3-servil-st / solo / IdleOneMessage / 128 MiB | 0.304 | 0.299 | x0.984 | level | 4 of 4 | - | - | x0.985 | x1.000 | x0.974 |
| blake3-servil-st / solo / IdleManyMessages / 1 | 386.960 | 416.599 | x1.077 | level | 1 of 4 | - | - | x1.009 | x1.009 | x0.839 |
| blake3-servil-st / solo / IdleManyMessages / 2 | 197.708 | 199.153 | x1.007 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.734 |
| blake3-servil-st / solo / IdleManyMessages / 3 | 166.654 | 168.321 | x1.010 | level | 2 of 4 | - | - | x0.999 | x1.001 | x0.622 |
| blake3-servil-st / solo / IdleManyMessages / 4 | 110.148 | 107.953 | x0.980 | level | 1 of 4 | - | - | x1.000 | x1.001 | x0.706 |
| blake3-servil-st / solo / IdleManyMessages / 6 | 94.205 | 96.000 | x1.019 | level | 1 of 4 | - | - | x1.008 | x1.000 | x0.913 |
| blake3-servil-st / solo / IdleManyMessages / 8 | 67.681 | 66.964 | x0.989 | level | 2 of 4 | - | - | x0.985 | x1.000 | x0.736 |
| blake3-servil-st / solo / IdleManyMessages / 12 | 60.900 | 60.130 | x0.987 | level | 3 of 4 | - | - | x0.982 | x1.001 | x0.712 |
| blake3-servil-st / solo / IdleManyMessages / 16 | 55.456 | 50.627 | x0.913 | level | 3 of 4 | - | - | x0.963 | x1.001 | x0.629 |
| blake3-servil-st / solo / IdleManyMessages / 24 | 44.546 | 44.871 | x1.007 | level | 1 of 4 | - | - | x0.996 | x1.001 | x0.848 |
| blake3-servil-st / solo / IdleManyMessages / 32 | 43.957 | 39.406 | x0.896 | level | 4 of 4 | - | - | x0.977 | x1.000 | x0.495 |
| blake3-servil-st / solo / IdleManyMessages / 48 | 36.205 | 37.655 | x1.040 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.633 |
| blake3-servil-st / solo / IdleManyMessages / 64 | 35.116 | 35.376 | x1.007 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.637 |
| blake3-servil-st / solo / IdleManyMessages / 128 | 31.087 | 31.370 | x1.009 | level | 2 of 4 | - | - | x1.004 | x1.000 | x0.738 |
| blake3-servil-st / solo / IdleManyMessages / 256 | 29.670 | 30.689 | x1.034 | level | 2 of 4 | - | - | x1.005 | x1.000 | x1.127 |
| blake3-servil-st / solo / IdleManyMessages / 512 | 28.432 | 30.092 | x1.058 | level | 0 of 4 | - | - | x1.006 | x1.000 | x0.934 |
| blake3-servil-st / solo / IdleManyMessages / 1024 | 28.279 | 29.368 | x1.039 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.064 |
| blake3-servil-st / solo / IdleManyMessages / 2048 | 29.373 | 29.310 | x0.998 | level | 1 of 4 | - | - | x0.999 | x1.000 | x1.045 |
| blake3-servil-st / solo / IdleManyMessages / 4096 | 29.282 | 29.535 | x1.009 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.066 |
| blake3-servil-st / solo / IdleManyMessages / 8192 | 29.336 | 30.644 | x1.045 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.004 |
| blake3-servil-st / solo / IdleManyMessages / 16384 | 30.547 | 30.247 | x0.990 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.022 |
| blake3-servil-st / solo / IdleManyMessages / 32768 | 31.200 | 31.403 | x1.007 | level | 1 of 4 | - | - | x0.998 | x1.000 | x0.991 |
| blake3-servil-st / solo / IdleManyMessages / 65536 | 26.531 | 26.784 | x1.010 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.014 |
| blake3-servil-st / solo / IdleManyMessages / 131072 | 20.984 | 20.719 | x0.987 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.996 |
| blake3-servil-st / solo / IdleManyMessages / 262144 | 18.162 | 18.128 | x0.998 | level | 3 of 4 | - | - | x1.003 | x1.000 | x1.006 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 B | 2.442 | 2.518 | x1.031 | level | 0 of 4 | - | - | x1.005 | x1.005 | x0.803 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 B | 1.703 | 1.741 | x1.023 | level | 1 of 4 | - | - | x1.003 | x1.007 | x0.815 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 B | 1.309 | 1.327 | x1.014 | level | 0 of 4 | - | - | x1.008 | x1.004 | x0.597 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 B | 1.128 | 1.139 | x1.009 | level | 0 of 4 | - | - | x1.007 | x1.003 | x0.996 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 KiB | 1.051 | 1.036 | x0.986 | level | 1 of 4 | - | - | x1.003 | x1.001 | x1.194 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1536 B | 0.811 | 0.805 | x0.992 | level | 1 of 4 | - | - | x1.003 | x0.998 | x1.068 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 KiB | 0.570 | 0.585 | x1.027 | level | 0 of 4 | - | - | x1.009 | x1.001 | x1.392 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2304 B | 0.652 | 0.671 | x1.029 | level | 1 of 4 | - | - | x1.005 | x1.002 | x0.868 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.475 | 0.478 | x1.006 | level | 1 of 4 | - | - | x1.006 | x1.000 | x1.139 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3839 B | 0.500 | 0.499 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.744 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 KiB | 0.354 | 0.356 | x1.006 | level | 1 of 4 | - | - | x1.003 | x1.000 | x0.965 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4470 B | 0.426 | 0.428 | x1.005 | level | 1 of 4 | - | - | x1.004 | x1.001 | x0.929 |
| blake3-servil-st / solo / BriefIdleOneMessage / 7935 B | 0.270 | 0.271 | x1.003 | level | 3 of 4 | - | - | x1.002 | x1.000 | x0.871 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 KiB | 0.248 | 0.248 | x1.000 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.628 |
| blake3-servil-st / solo / BriefIdleOneMessage / 16 KiB | 0.230 | 0.235 | x1.020 | level | 0 of 4 | - | - | x1.003 | x1.000 | x1.491 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 KiB | 0.225 | 0.223 | x0.992 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.060 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 KiB | 0.220 | 0.220 | x1.001 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.304 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 KiB | 0.221 | 0.218 | x0.986 | level | 3 of 4 | - | - | x0.990 | x1.000 | x0.878 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 KiB | 0.225 | 0.224 | x0.997 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.954 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 KiB | 0.232 | 0.232 | x0.999 | level | 1 of 4 | - | - | x0.996 | x1.000 | x1.009 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 MiB | 0.235 | 0.235 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.025 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 MiB | 0.238 | 0.237 | x0.995 | level | 4 of 4 | - | - | x0.996 | x1.000 | x1.019 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 MiB | 0.239 | 0.237 | x0.994 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.023 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 MiB | 0.239 | 0.238 | x0.995 | level | 4 of 4 | - | - | x0.996 | x1.000 | x1.043 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 MiB | 0.246 | 0.245 | x0.996 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.020 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 MiB | 0.296 | 0.292 | x0.988 | level | 4 of 4 | - | - | x0.988 | x1.000 | x0.986 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 MiB | 0.298 | 0.295 | x0.988 | level | 4 of 4 | - | - | x0.988 | x1.000 | x0.987 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 MiB | 0.303 | 0.298 | x0.983 | level | 3 of 4 | - | - | x0.983 | x1.000 | x0.978 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1 | 182.465 | 172.647 | x0.946 | level | 1 of 4 | - | - | x0.988 | x1.009 | x0.684 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2 | 87.573 | 92.556 | x1.057 | level | 1 of 4 | - | - | x1.002 | x1.001 | x0.776 |
| blake3-servil-st / solo / BriefIdleManyMessages / 3 | 78.351 | 77.250 | x0.986 | level | 1 of 4 | - | - | x0.999 | x1.000 | x0.524 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4 | 48.719 | 48.759 | x1.001 | level | 1 of 4 | - | - | x1.004 | x0.999 | x0.745 |
| blake3-servil-st / solo / BriefIdleManyMessages / 6 | 42.503 | 42.781 | x1.007 | level | 1 of 4 | - | - | x1.001 | x1.001 | x0.904 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8 | 31.072 | 30.402 | x0.978 | level | 1 of 4 | - | - | x0.983 | x1.001 | x1.072 |
| blake3-servil-st / solo / BriefIdleManyMessages / 12 | 27.777 | 27.159 | x0.978 | level | 2 of 4 | - | - | x0.982 | x1.001 | x1.272 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16 | 24.158 | 23.347 | x0.966 | level | 3 of 4 | - | - | x0.980 | x1.001 | x0.943 |
| blake3-servil-st / solo / BriefIdleManyMessages / 24 | 20.391 | 20.278 | x0.995 | level | 1 of 4 | - | - | x0.994 | x1.000 | x1.016 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32 | 18.930 | 18.568 | x0.981 | level | 3 of 4 | - | - | x0.991 | x1.000 | x0.815 |
| blake3-servil-st / solo / BriefIdleManyMessages / 48 | 17.544 | 16.799 | x0.958 | level | 3 of 4 | - | - | x0.992 | x1.000 | x0.681 |
| blake3-servil-st / solo / BriefIdleManyMessages / 64 | 16.013 | 16.054 | x1.003 | level | 1 of 4 | - | - | x0.997 | x1.000 | x0.733 |
| blake3-servil-st / solo / BriefIdleManyMessages / 128 | 14.581 | 14.613 | x1.002 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.228 |
| blake3-servil-st / solo / BriefIdleManyMessages / 256 | 14.092 | 14.179 | x1.006 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.153 |
| blake3-servil-st / solo / BriefIdleManyMessages / 512 | 13.580 | 13.736 | x1.011 | level | 0 of 4 | - | - | x1.010 | x1.000 | x1.067 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1024 | 13.460 | 13.673 | x1.016 | level | 1 of 4 | - | - | x1.015 | x1.000 | x1.105 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2048 | 13.803 | 13.629 | x0.987 | level | 3 of 4 | - | - | x0.993 | x1.000 | x1.020 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4096 | 14.114 | 14.230 | x1.008 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.026 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8192 | 14.489 | 14.483 | x1.000 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.027 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16384 | 14.631 | 14.607 | x0.998 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.033 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32768 | 15.039 | 14.814 | x0.985 | level | 2 of 4 | - | - | x0.985 | x1.000 | x0.963 |
| blake3-servil-st / solo / BriefIdleManyMessages / 65536 | 15.108 | 15.105 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.008 |
| blake3-servil-st / solo / BriefIdleManyMessages / 131072 | 15.086 | 15.175 | x1.006 | level | 2 of 4 | - | - | x1.005 | x1.000 | x0.975 |
| blake3-servil-st / solo / BriefIdleManyMessages / 262144 | 15.812 | 15.845 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.003 |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.885 | 0.936 | x1.057 | level | 0 of 4 | x1.057 | - | x1.057 | x1.011 | x1.268 |
| blake3-servil-st / solo / ContinuousMessages / 128 B | 0.905 | 0.921 | x1.018 | level | 0 of 4 | x1.018 | - | x1.017 | x1.006 | x1.872 |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 0.928 | 0.921 | x0.993 | level | 1 of 4 | x0.993 | - | x0.993 | x1.003 | x1.045 |
| blake3-servil-st / solo / ContinuousMessages / 512 B | 0.932 | 0.933 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.002 | x0.629 |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 0.925 | 0.926 | x1.001 | level | 2 of 4 | x1.002 | - | x1.001 | x1.001 | x0.628 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.316 | 0.316 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x1.344 |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.216 | 0.215 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x1.000 | x1.832 |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.216 | 0.215 | x0.994 | level | 3 of 4 | x0.994 | - | x0.995 | x1.000 | x0.694 |
| blake3-servil-st / solo / ContinuousMessages / 256 KiB | 0.218 | 0.217 | x0.995 | level | 2 of 4 | x0.995 | - | x0.994 | x1.000 | x1.272 |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.219 | 0.219 | x0.996 | level | 3 of 4 | x0.996 | - | x0.996 | x1.000 | x0.994 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.219 | 0.217 | x0.995 | level | 4 of 4 | x0.995 | - | x0.994 | x1.000 | x1.285 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.221 | 0.220 | x0.993 | level | 3 of 4 | x0.993 | - | x0.993 | x1.000 | x0.987 |
| blake3-servil-st / solo / ContinuousMessages / 64 MiB | 0.256 | 0.254 | x0.991 | level | 3 of 4 | x0.991 | - | x0.991 | x1.000 | x0.932 |
| blake3-servil-st / solo / ContinuousBatches / 16 | 16.472 | 16.965 | x1.030 | level | 2 of 4 | x1.030 | - | x1.030 | x0.999 | x0.962 |
| blake3-servil-st / solo / ContinuousBatches / 64 | 13.827 | 13.860 | x1.002 | level | 1 of 4 | x1.002 | - | x1.003 | x1.000 | x0.633 |
| blake3-servil-st / solo / ContinuousBatches / 256 | 13.672 | 13.780 | x1.008 | level | 2 of 4 | x1.008 | - | x1.009 | x1.000 | x1.168 |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 13.870 | 13.884 | x1.001 | level | 1 of 4 | x1.001 | - | x1.002 | x1.000 | x0.981 |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 14.456 | 14.576 | x1.008 | level | 2 of 4 | x1.009 | - | x1.009 | x1.000 | x1.086 |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 14.883 | 14.957 | x1.005 | level | 2 of 4 | x1.005 | - | x1.005 | x1.000 | x0.931 |
| blake3-servil-st / solo / ContinuousBatches / 65536 | 14.999 | 15.169 | x1.011 | level | 1 of 4 | x1.011 | - | x1.011 | x1.000 | x0.918 |
| blake3-servil-st / solo / LentMessages / 64 B | 0.885 | 0.936 | x1.057 | level | 0 of 4 | x1.057 | - | x1.057 | x1.011 | x1.268 |
| blake3-servil-st / solo / LentMessages / 128 B | 0.905 | 0.921 | x1.018 | level | 0 of 4 | x1.018 | - | x1.017 | x1.006 | x1.872 |
| blake3-servil-st / solo / LentMessages / 256 B | 0.928 | 0.921 | x0.993 | level | 1 of 4 | x0.993 | - | x0.993 | x1.003 | x1.045 |
| blake3-servil-st / solo / LentMessages / 512 B | 0.932 | 0.933 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.002 | x0.629 |
| blake3-servil-st / solo / LentMessages / 1 KiB | 0.925 | 0.926 | x1.001 | level | 2 of 4 | x1.002 | - | x1.001 | x1.001 | x0.628 |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.316 | 0.316 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x1.344 |
| blake3-servil-st / solo / LentMessages / 16 KiB | 0.216 | 0.215 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x1.000 | x1.832 |
| blake3-servil-st / solo / LentMessages / 64 KiB | 0.216 | 0.215 | x0.994 | level | 3 of 4 | x0.994 | - | x0.995 | x1.000 | x0.694 |
| blake3-servil-st / solo / LentMessages / 256 KiB | 0.220 | 0.220 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | x0.882 |
| blake3-servil-st / solo / LentMessages / 1 MiB | 0.229 | 0.229 | x0.998 | level | 2 of 4 | x0.998 | - | x0.999 | x1.000 | x1.077 |
| blake3-servil-st / solo / LentMessages / 4 MiB | 0.232 | 0.232 | x0.999 | level | 2 of 4 | x0.999 | - | x0.997 | x1.000 | x0.954 |
| blake3-servil-st / solo / LentMessages / 16 MiB | 0.258 | 0.259 | x1.004 | level | 3 of 4 | x1.004 | - | x1.005 | x1.000 | x0.984 |
| blake3-servil-st / solo / LentMessages / 64 MiB | 0.303 | 0.297 | x0.982 | level | 3 of 4 | x0.982 | - | x0.981 | x1.000 | x0.993 |
| blake3-servil-st / solo / Interleaved / 256 | 0.260 | 0.259 | x0.996 | level | 2 of 4 | x0.996 | - | x0.995 | x0.996 | x0.999 |
| blake3-servil-st / solo / Collection / git objects | 0.249 | 0.247 | x0.991 | level | 3 of 4 | x0.991 | - | x0.991 | x1.000 | x0.982 |
| blake3-servil-st / solo / Collection / Nix files | 0.233 | 0.233 | x0.997 | level | 3 of 4 | x0.997 | - | x0.996 | x1.000 | x0.972 |
| blake3-servil-st / solo / LentBatches / 16 | 16.472 | 16.965 | x1.030 | level | 2 of 4 | x1.030 | - | x1.030 | x0.999 | x0.962 |
| blake3-servil-st / solo / LentBatches / 64 | 13.827 | 13.860 | x1.002 | level | 1 of 4 | x1.002 | - | x1.003 | x1.000 | x0.633 |
| blake3-servil-st / solo / LentBatches / 256 | 13.672 | 13.780 | x1.008 | level | 2 of 4 | x1.008 | - | x1.009 | x1.000 | x1.168 |
| blake3-servil-st / solo / LentBatches / 1024 | 13.870 | 13.884 | x1.001 | level | 1 of 4 | x1.001 | - | x1.002 | x1.000 | x0.981 |
| blake3-servil-st / solo / LentBatches / 4096 | 14.456 | 14.576 | x1.008 | level | 2 of 4 | x1.009 | - | x1.009 | x1.000 | x1.086 |
| blake3-servil-st / solo / LentBatches / 16384 | 14.883 | 14.957 | x1.005 | level | 2 of 4 | x1.005 | - | x1.005 | x1.000 | x0.931 |
| blake3-servil-st / solo / LentBatches / 65536 | 14.999 | 15.169 | x1.011 | level | 1 of 4 | x1.011 | - | x1.011 | x1.000 | x0.918 |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.270 | 0.270 | x1.000 | level | 2 of 4 | x1.000 | - | x1.001 | x1.000 | x1.012 |
| blake3-servil-st / solo / ContinuousCollection / Nix files | 0.275 | 0.274 | x0.994 | level | 3 of 4 | x0.994 | - | x0.994 | x1.000 | x0.874 |
| blake3-servil-st / solo / MerkleTree / 1024 | 0.263 | 0.263 | x1.003 | level | 2 of 4 | x1.002 | - | x0.998 | x1.000 | x1.046 |
| blake3-servil-st / solo / MerkleTree / 4096 | 0.270 | 0.271 | x1.003 | level | 1 of 4 | x1.004 | - | x1.003 | x1.000 | x0.860 |
| blake3-servil-st / solo / MerkleTree / 16384 | 0.273 | 0.272 | x0.996 | level | 2 of 4 | x0.996 | - | x0.997 | x1.000 | x0.908 |
| blake3-servil-st / solo / MerkleTree / 65536 | 0.304 | 0.305 | x1.001 | level | 3 of 4 | x1.001 | - | x1.002 | x1.000 | x0.986 |
| blake3-servil-st / solo / MerkleTree / 262144 | 0.549 | 0.545 | x0.992 | level | 3 of 4 | x0.992 | - | x0.992 | x1.000 | x0.992 |
| blake3-servil-st / solo / MerkleTree / 65536 x 32 B | 0.837 | 0.833 | x0.995 | level | 3 of 4 | x0.995 | - | x0.996 | x1.000 | x0.952 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 32 B | 1.098 | 1.097 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x1.002 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 16 B | 1.673 | 1.673 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.970 |
| blake3-servil-st / solo / MerkleTree / 65536 x 48 B | 0.572 | 0.570 | x0.997 | level | 3 of 4 | x0.997 | - | x0.998 | x1.000 | x1.044 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 48 B | 0.839 | 0.837 | x0.998 | level | 2 of 4 | x0.998 | - | x0.999 | x1.000 | x0.982 |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.494 | 0.502 | x1.016 | level | 2 of 4 | - | - | x1.011 | x0.988 | x0.997 |
| blake3-servil-st / solo / InterleavedTurn / 1024 x 1 KiB | 0.531 | 0.532 | x1.002 | level | 2 of 4 | - | - | x1.003 | x0.998 | x1.000 |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.718 | 0.699 | x0.974 | level | 3 of 4 | - | - | x1.028 | x1.007 | x1.016 |
| blake3-servil-st / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.843 | 0.868 | x1.029 | level | 2 of 4 | - | - | x0.996 | x0.998 | x1.004 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.395 | 0.407 | x1.029 | level | 0 of 4 | - | - | x1.020 | x1.006 | x0.995 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.448 | 0.434 | x0.970 | level | 3 of 4 | - | - | x0.970 | x0.998 | x1.005 |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.228 | 0.228 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x1.016 |
| blake3-servil-st / solo / ReceivingMessage / 2 μs | 0.230 | 0.230 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.172 |
| blake3-servil-st / solo / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 3 of 4 | x1.004 | - | x1.007 | x1.000 | x1.045 |
| blake3-servil-st / solo / IncrementalMessage / 64 B | 7.735 | 7.308 | x0.945 | level | 3 of 4 | - | - | x0.967 | x1.007 | x0.964 |
| blake3-servil-st / solo / IncrementalMessage / 1 KiB | 1.516 | 1.560 | x1.029 | level | 1 of 4 | - | - | x1.026 | x1.001 | x0.984 |
| blake3-servil-st / solo / IncrementalMessage / 4 KiB | 0.717 | 0.695 | x0.969 | level | 3 of 4 | - | - | x0.967 | x1.000 | x1.000 |
| blake3-servil-st / solo / LentIncrementalMessage / 64 B | 1.168 | 1.165 | x0.998 | level | 3 of 4 | x0.997 | - | x0.999 | x1.005 | x1.476 |
| blake3-servil-st / solo / LentIncrementalMessage / 1 KiB | 0.952 | 0.953 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.001 | x0.779 |
| blake3-servil-st / solo / LentIncrementalMessage / 4 KiB | 0.328 | 0.329 | x1.002 | level | 0 of 4 | x1.002 | - | x1.001 | x1.000 | x1.102 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 0.878 | 0.892 | x1.016 | level | 0 of 4 | x1.017 | - | x1.021 | x1.011 | x1.515 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 4 KiB | 0.316 | 0.316 | x0.999 | level | 2 of 4 | x1.000 | - | x0.999 | x1.000 | x1.111 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 1 MiB | 0.220 | 0.218 | x0.994 | level | 3 of 4 | x0.994 | - | x0.994 | x1.000 | x0.974 |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 0.840 | 0.831 | x0.989 | level | 4 of 4 | x0.989 | - | x0.990 | x1.012 | x0.951 |
| blake3-servil-st / solo / ContinuousLentMessages / 4 KiB | 0.306 | 0.307 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.000 | x1.270 |
| blake3-servil-st / solo / ContinuousLentMessages / 1 MiB | 0.203 | 0.202 | x0.996 | level | 2 of 4 | x0.997 | - | x0.996 | x1.000 | x1.089 |
| blake3-servil-mt / solo / OneMessage / 64 B | 7.856 | 7.418 | x0.944 | level | 4 of 4 | - | - | x0.951 | x1.008 | x0.904 |
| blake3-servil-mt / solo / OneMessage / 128 B | 4.614 | 4.458 | x0.966 | level | 3 of 4 | - | - | x0.958 | x1.004 | x0.911 |
| blake3-servil-mt / solo / OneMessage / 256 B | 2.833 | 2.727 | x0.962 | level | 3 of 4 | - | - | x0.976 | x1.004 | x0.938 |
| blake3-servil-mt / solo / OneMessage / 512 B | 1.909 | 1.903 | x0.997 | level | 2 of 4 | - | - | x0.985 | x1.003 | x0.941 |
| blake3-servil-mt / solo / OneMessage / 1 KiB | 1.431 | 1.403 | x0.981 | level | 3 of 4 | - | - | x0.976 | x1.001 | x0.976 |
| blake3-servil-mt / solo / OneMessage / 1536 B | 1.405 | 1.361 | x0.969 | level | 4 of 4 | - | - | x0.962 | x0.998 | x0.936 |
| blake3-servil-mt / solo / OneMessage / 2 KiB | 0.946 | 0.937 | x0.991 | level | 3 of 4 | - | - | x0.984 | x1.000 | x0.960 |
| blake3-servil-mt / solo / OneMessage / 2304 B | 1.098 | 1.111 | x1.011 | level | 2 of 4 | - | - | x0.972 | x1.001 | x0.974 |
| blake3-servil-mt / solo / OneMessage / 3 KiB | 0.815 | 0.845 | x1.037 | level | 0 of 4 | - | - | x1.022 | x1.000 | x0.977 |
| blake3-servil-mt / solo / OneMessage / 3839 B | 0.939 | 0.994 | x1.058 | level | 1 of 4 | - | - | x1.012 | x1.000 | x0.976 |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 0.597 | 0.616 | x1.032 | level | 1 of 4 | - | - | x1.014 | x1.000 | x0.977 |
| blake3-servil-mt / solo / OneMessage / 4470 B | 0.672 | 0.684 | x1.017 | level | 0 of 4 | - | - | x1.005 | x1.001 | x0.970 |
| blake3-servil-mt / solo / OneMessage / 7935 B | 0.540 | 0.555 | x1.026 | level | 1 of 4 | - | - | x1.037 | x1.000 | x1.035 |
| blake3-servil-mt / solo / OneMessage / 8 KiB | 0.431 | 0.438 | x1.016 | level | 1 of 4 | - | - | x0.992 | x1.000 | x0.983 |
| blake3-servil-mt / solo / OneMessage / 16 KiB | 0.379 | 0.376 | x0.993 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.957 |
| blake3-servil-mt / solo / OneMessage / 32 KiB | 0.334 | 0.337 | x1.008 | level | 2 of 4 | - | - | x1.010 | x1.000 | x1.019 |
| blake3-servil-mt / solo / OneMessage / 64 KiB | 0.311 | 0.309 | x0.993 | level | 3 of 4 | - | - | x0.991 | x1.000 | x0.973 |
| blake3-servil-mt / solo / OneMessage / 128 KiB | 0.302 | 0.300 | x0.993 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.958 |
| blake3-servil-mt / solo / OneMessage / 256 KiB | 0.294 | 0.290 | x0.989 | level | 4 of 4 | - | - | x0.995 | x1.000 | x0.961 |
| blake3-servil-mt / solo / OneMessage / 512 KiB | 0.186 | 0.191 | x1.029 | level | 1 of 4 | - | - | x1.022 | x0.955 | x1.013 |
| blake3-servil-mt / solo / OneMessage / 1 MiB | 0.152 | 0.149 | x0.978 | level | 2 of 4 | - | - | x0.973 | x0.986 | x1.010 |
| blake3-servil-mt / solo / OneMessage / 2 MiB | 0.160 | 0.160 | x1.001 | level | 2 of 4 | - | - | x1.000 | x0.984 | x1.016 |
| blake3-servil-mt / solo / OneMessage / 3 MiB | 0.156 | 0.154 | x0.983 | level | 3 of 4 | - | - | x0.980 | x0.998 | x1.000 |
| blake3-servil-mt / solo / OneMessage / 4 MiB | 0.122 | 0.122 | x0.996 | level | 2 of 4 | - | - | x0.997 | x0.975 | x1.039 |
| blake3-servil-mt / solo / OneMessage / 8 MiB | 0.152 | 0.151 | x0.995 | level | 3 of 4 | - | - | x0.995 | x1.008 | x1.005 |
| blake3-servil-mt / solo / OneMessage / 32 MiB | 0.0809 | 0.0807 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.002 | x1.007 |
| blake3-servil-mt / solo / OneMessage / 64 MiB | 0.0813 | 0.0809 | x0.995 | level | 3 of 4 | - | - | x0.994 | x0.987 | x1.000 |
| blake3-servil-mt / solo / OneMessage / 128 MiB | 0.0784 | 0.0783 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.003 | x1.007 |
| blake3-servil-mt / solo / ManyMessages / 1 | 468.704 | 447.137 | x0.954 | level | 3 of 4 | - | - | x0.967 | x1.012 | x0.938 |
| blake3-servil-mt / solo / ManyMessages / 2 | 277.543 | 299.090 | x1.078 | level | 1 of 4 | - | - | x1.050 | x0.998 | x0.941 |
| blake3-servil-mt / solo / ManyMessages / 3 | 203.296 | 216.189 | x1.063 | level | 1 of 4 | - | - | x1.054 | x1.001 | x0.958 |
| blake3-servil-mt / solo / ManyMessages / 4 | 155.271 | 168.738 | x1.087 | level | 1 of 4 | - | - | x1.076 | x1.002 | x0.963 |
| blake3-servil-mt / solo / ManyMessages / 6 | 126.567 | 135.634 | x1.072 | level | 1 of 4 | - | - | x1.024 | x1.001 | x0.983 |
| blake3-servil-mt / solo / ManyMessages / 8 | 102.952 | 109.064 | x1.059 | level | 1 of 4 | - | - | x1.052 | x1.002 | x0.977 |
| blake3-servil-mt / solo / ManyMessages / 12 | 80.032 | 82.817 | x1.035 | level | 2 of 4 | - | - | x1.016 | x1.000 | x0.982 |
| blake3-servil-mt / solo / ManyMessages / 16 | 61.557 | 65.587 | x1.065 | level | 0 of 4 | - | - | x1.037 | x1.001 | x0.984 |
| blake3-servil-mt / solo / ManyMessages / 24 | 45.393 | 48.574 | x1.070 | level | 0 of 4 | - | - | x1.052 | x1.001 | x0.981 |
| blake3-servil-mt / solo / ManyMessages / 32 | 38.639 | 39.331 | x1.018 | level | 2 of 4 | - | - | x1.016 | x1.001 | x0.984 |
| blake3-servil-mt / solo / ManyMessages / 48 | 30.363 | 32.010 | x1.054 | level | 2 of 4 | - | - | x1.015 | x1.000 | x0.987 |
| blake3-servil-mt / solo / ManyMessages / 64 | 28.796 | 28.213 | x0.980 | level | 3 of 4 | - | - | x1.015 | x1.000 | x0.960 |
| blake3-servil-mt / solo / ManyMessages / 128 | 23.020 | 23.684 | x1.029 | level | 0 of 4 | - | - | x1.019 | x1.000 | x0.994 |
| blake3-servil-mt / solo / ManyMessages / 256 | 20.529 | 20.902 | x1.018 | level | 1 of 4 | - | - | x1.010 | x1.000 | x0.996 |
| blake3-servil-mt / solo / ManyMessages / 512 | 18.985 | 19.484 | x1.026 | level | 1 of 4 | - | - | x1.021 | x1.000 | x1.003 |
| blake3-servil-mt / solo / ManyMessages / 1024 | 18.704 | 18.712 | x1.000 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.972 |
| blake3-servil-mt / solo / ManyMessages / 2048 | 18.297 | 18.356 | x1.003 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.002 |
| blake3-servil-mt / solo / ManyMessages / 4096 | 17.891 | 17.854 | x0.998 | level | 3 of 4 | - | - | x1.002 | x1.000 | x1.004 |
| blake3-servil-mt / solo / ManyMessages / 8192 | 10.013 | 9.941 | x0.993 | level | 3 of 4 | - | - | x0.983 | x0.972 | x1.007 |
| blake3-servil-mt / solo / ManyMessages / 16384 | 8.596 | 8.604 | x1.001 | level | 2 of 4 | - | - | x0.996 | x0.988 | x1.013 |
| blake3-servil-mt / solo / ManyMessages / 32768 | 9.657 | 8.453 | x0.875 | level | 4 of 4 | - | - | x0.866 | x1.158 | x0.886 |
| blake3-servil-mt / solo / ManyMessages / 65536 | 7.731 | 8.915 | x1.153 | level | 1 of 4 | - | - | x1.163 | x0.751 | x1.352 |
| blake3-servil-mt / solo / ManyMessages / 131072 | 9.829 | 9.969 | x1.014 | level | 1 of 4 | - | - | x1.013 | x0.971 | x1.010 |
| blake3-servil-mt / solo / ManyMessages / 262144 | 10.146 | 10.126 | x0.998 | level | 2 of 4 | - | - | x0.998 | x0.992 | x0.999 |
| blake3-servil-mt / solo / ManyLongMessages / 4 | 1789.949 | 1758.636 | x0.983 | level | 3 of 4 | - | - | x1.001 | x1.001 | x0.981 |
| blake3-servil-mt / solo / ManyLongMessages / 16 | 1229.499 | 1209.602 | x0.984 | level | 3 of 4 | - | - | x0.984 | x0.998 | x0.912 |
| blake3-servil-mt / solo / ManyLongMessages / 64 | 1167.630 | 1172.795 | x1.004 | level | 1 of 4 | - | - | x1.000 | x0.998 | x0.975 |
| blake3-servil-mt / solo / ManyLongMessages / 256 | 621.196 | 606.842 | x0.977 | level | 3 of 4 | - | - | x0.974 | x0.980 | x1.013 |
| blake3-servil-mt / solo / IdleOneMessage / 64 B | 5.417 | 5.536 | x1.022 | level | 1 of 4 | - | - | x1.011 | x1.005 | x0.880 |
| blake3-servil-mt / solo / IdleOneMessage / 128 B | 3.897 | 3.786 | x0.971 | level | 1 of 4 | - | - | x1.003 | x1.006 | x1.010 |
| blake3-servil-mt / solo / IdleOneMessage / 256 B | 2.881 | 2.947 | x1.023 | level | 1 of 4 | - | - | x1.008 | x1.004 | x1.074 |
| blake3-servil-mt / solo / IdleOneMessage / 512 B | 2.384 | 2.394 | x1.004 | level | 1 of 4 | - | - | x1.003 | x1.002 | x0.990 |
| blake3-servil-mt / solo / IdleOneMessage / 1 KiB | 2.217 | 2.277 | x1.027 | level | 1 of 4 | - | - | x0.994 | x1.001 | x1.260 |
| blake3-servil-mt / solo / IdleOneMessage / 1536 B | 1.708 | 1.746 | x1.022 | level | 0 of 4 | - | - | x0.989 | x0.998 | x0.653 |
| blake3-servil-mt / solo / IdleOneMessage / 2 KiB | 1.236 | 1.228 | x0.994 | level | 3 of 4 | - | - | x0.995 | x1.001 | x1.035 |
| blake3-servil-mt / solo / IdleOneMessage / 2304 B | 1.425 | 1.398 | x0.981 | level | 4 of 4 | - | - | x0.996 | x1.001 | x0.885 |
| blake3-servil-mt / solo / IdleOneMessage / 3 KiB | 1.032 | 1.058 | x1.026 | level | 1 of 4 | - | - | x1.014 | x1.000 | x1.052 |
| blake3-servil-mt / solo / IdleOneMessage / 3839 B | 1.125 | 1.160 | x1.031 | level | 1 of 4 | - | - | x0.987 | x1.000 | x1.015 |
| blake3-servil-mt / solo / IdleOneMessage / 4 KiB | 0.747 | 0.765 | x1.023 | level | 1 of 4 | - | - | x0.990 | x1.000 | x0.771 |
| blake3-servil-mt / solo / IdleOneMessage / 4470 B | 0.926 | 0.922 | x0.996 | level | 2 of 4 | - | - | x1.005 | x1.001 | x0.808 |
| blake3-servil-mt / solo / IdleOneMessage / 7935 B | 0.603 | 0.617 | x1.023 | level | 2 of 4 | - | - | x1.006 | x1.000 | x0.817 |
| blake3-servil-mt / solo / IdleOneMessage / 8 KiB | 0.539 | 0.549 | x1.018 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.029 |
| blake3-servil-mt / solo / IdleOneMessage / 16 KiB | 0.491 | 0.502 | x1.022 | level | 1 of 4 | - | - | x1.013 | x1.000 | x1.119 |
| blake3-servil-mt / solo / IdleOneMessage / 32 KiB | 0.484 | 0.497 | x1.026 | level | 1 of 4 | - | - | x1.007 | x1.000 | x1.250 |
| blake3-servil-mt / solo / IdleOneMessage / 64 KiB | 0.460 | 0.471 | x1.024 | level | 0 of 4 | - | - | x0.996 | x1.000 | x1.077 |
| blake3-servil-mt / solo / IdleOneMessage / 128 KiB | 0.477 | 0.468 | x0.981 | level | 3 of 4 | - | - | x1.002 | x1.000 | x1.018 |
| blake3-servil-mt / solo / IdleOneMessage / 256 KiB | 0.479 | 0.484 | x1.010 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.014 |
| blake3-servil-mt / solo / IdleOneMessage / 512 KiB | 0.245 | 0.225 | x0.918 | level | 3 of 4 | - | - | x0.940 | x1.028 | x1.043 |
| blake3-servil-mt / solo / IdleOneMessage / 1 MiB | 0.216 | 0.214 | x0.992 | level | 3 of 4 | - | - | x0.986 | x1.037 | x0.952 |
| blake3-servil-mt / solo / IdleOneMessage / 2 MiB | 0.208 | 0.207 | x0.995 | level | 3 of 4 | - | - | x1.015 | x0.991 | x1.009 |
| blake3-servil-mt / solo / IdleOneMessage / 3 MiB | 0.200 | 0.202 | x1.008 | level | 2 of 4 | - | - | x0.992 | x0.978 | x1.010 |
| blake3-servil-mt / solo / IdleOneMessage / 4 MiB | 0.205 | 0.206 | x1.004 | level | 1 of 4 | - | - | x0.977 | x1.001 | x1.001 |
| blake3-servil-mt / solo / IdleOneMessage / 8 MiB | 0.173 | 0.177 | x1.022 | level | 1 of 4 | - | - | x0.961 | x0.976 | x1.007 |
| blake3-servil-mt / solo / IdleOneMessage / 32 MiB | 0.0741 | 0.0748 | x1.010 | level | 2 of 4 | - | - | x1.008 | x1.022 | x1.002 |
| blake3-servil-mt / solo / IdleOneMessage / 64 MiB | 0.0741 | 0.0744 | x1.004 | level | 2 of 4 | - | - | x1.002 | x1.011 | x1.001 |
| blake3-servil-mt / solo / IdleOneMessage / 128 MiB | 0.0757 | 0.0756 | x0.999 | level | 2 of 4 | - | - | x1.000 | x0.994 | x1.003 |
| blake3-servil-mt / solo / IdleManyMessages / 1 | 392.134 | 394.684 | x1.007 | level | 1 of 4 | - | - | x1.006 | x1.009 | x0.857 |
| blake3-servil-mt / solo / IdleManyMessages / 2 | 207.743 | 198.975 | x0.958 | level | 4 of 4 | - | - | x0.975 | x0.999 | x0.636 |
| blake3-servil-mt / solo / IdleManyMessages / 3 | 175.186 | 174.905 | x0.998 | level | 3 of 4 | - | - | x0.981 | x1.000 | x0.524 |
| blake3-servil-mt / solo / IdleManyMessages / 4 | 111.528 | 113.216 | x1.015 | level | 2 of 4 | - | - | x0.985 | x1.001 | x0.676 |
| blake3-servil-mt / solo / IdleManyMessages / 6 | 96.917 | 95.606 | x0.986 | level | 3 of 4 | - | - | x0.979 | x1.000 | x0.524 |
| blake3-servil-mt / solo / IdleManyMessages / 8 | 71.963 | 67.862 | x0.943 | level | 3 of 4 | - | - | x0.972 | x1.001 | x0.748 |
| blake3-servil-mt / solo / IdleManyMessages / 12 | 65.534 | 58.577 | x0.894 | level | 4 of 4 | - | - | x0.960 | x1.001 | x0.697 |
| blake3-servil-mt / solo / IdleManyMessages / 16 | 53.713 | 51.636 | x0.961 | level | 4 of 4 | - | - | x0.974 | x1.001 | x0.858 |
| blake3-servil-mt / solo / IdleManyMessages / 24 | 45.045 | 44.444 | x0.987 | level | 3 of 4 | - | - | x0.991 | x1.000 | x0.787 |
| blake3-servil-mt / solo / IdleManyMessages / 32 | 43.640 | 41.112 | x0.942 | level | 3 of 4 | - | - | x0.985 | x1.000 | x0.948 |
| blake3-servil-mt / solo / IdleManyMessages / 48 | 35.830 | 37.727 | x1.053 | level | 0 of 4 | - | - | x0.999 | x1.000 | x0.628 |
| blake3-servil-mt / solo / IdleManyMessages / 64 | 34.936 | 35.948 | x1.029 | level | 3 of 4 | - | - | x1.025 | x1.000 | x1.076 |
| blake3-servil-mt / solo / IdleManyMessages / 128 | 30.550 | 31.362 | x1.027 | level | 2 of 4 | - | - | x1.005 | x1.000 | x0.531 |
| blake3-servil-mt / solo / IdleManyMessages / 256 | 30.191 | 30.440 | x1.008 | level | 1 of 4 | - | - | x1.008 | x1.000 | x0.973 |
| blake3-servil-mt / solo / IdleManyMessages / 512 | 29.468 | 30.075 | x1.021 | level | 1 of 4 | - | - | x1.019 | x1.000 | x1.229 |
| blake3-servil-mt / solo / IdleManyMessages / 1024 | 29.140 | 29.478 | x1.012 | level | 2 of 4 | - | - | x1.004 | x1.000 | x1.043 |
| blake3-servil-mt / solo / IdleManyMessages / 2048 | 29.434 | 29.107 | x0.989 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.070 |
| blake3-servil-mt / solo / IdleManyMessages / 4096 | 29.196 | 29.704 | x1.017 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.074 |
| blake3-servil-mt / solo / IdleManyMessages / 8192 | 13.705 | 13.256 | x0.967 | level | 2 of 4 | - | - | x0.981 | x1.006 | x0.994 |
| blake3-servil-mt / solo / IdleManyMessages / 16384 | 11.726 | 11.418 | x0.974 | level | 3 of 4 | - | - | x0.962 | x0.996 | x1.020 |
| blake3-servil-mt / solo / IdleManyMessages / 32768 | 12.749 | 11.235 | x0.881 | level | 3 of 4 | - | - | x0.870 | x1.163 | x0.840 |
| blake3-servil-mt / solo / IdleManyMessages / 65536 | 9.936 | 11.606 | x1.168 | level | 1 of 4 | - | - | x1.148 | x0.809 | x1.393 |
| blake3-servil-mt / solo / IdleManyMessages / 131072 | 11.535 | 10.954 | x0.950 | level | 4 of 4 | - | - | x0.941 | x1.006 | x0.998 |
| blake3-servil-mt / solo / IdleManyMessages / 262144 | 9.284 | 9.210 | x0.992 | level | 3 of 4 | - | - | x0.993 | x0.991 | x1.012 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 B | 2.468 | 2.532 | x1.026 | level | 0 of 4 | - | - | x1.003 | x1.005 | x0.883 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 B | 1.716 | 1.745 | x1.017 | level | 1 of 4 | - | - | x1.000 | x1.007 | x0.656 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 B | 1.315 | 1.333 | x1.013 | level | 0 of 4 | - | - | x1.005 | x1.004 | x0.698 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 B | 1.128 | 1.137 | x1.008 | level | 1 of 4 | - | - | x1.004 | x1.003 | x1.083 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 KiB | 1.032 | 1.034 | x1.001 | level | 3 of 4 | - | - | x1.000 | x1.001 | x0.945 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1536 B | 0.805 | 0.817 | x1.014 | level | 1 of 4 | - | - | x1.004 | x0.998 | x1.350 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 KiB | 0.572 | 0.577 | x1.009 | level | 1 of 4 | - | - | x1.005 | x1.001 | x1.459 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2304 B | 0.655 | 0.660 | x1.007 | level | 1 of 4 | - | - | x1.006 | x1.001 | x0.984 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 KiB | 0.475 | 0.480 | x1.011 | level | 0 of 4 | - | - | x1.006 | x1.000 | x1.254 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3839 B | 0.510 | 0.504 | x0.988 | level | 3 of 4 | - | - | x1.003 | x1.000 | x0.708 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 KiB | 0.355 | 0.357 | x1.006 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.142 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4470 B | 0.431 | 0.431 | x1.002 | level | 2 of 4 | - | - | x1.004 | x1.000 | x1.036 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 7935 B | 0.271 | 0.273 | x1.010 | level | 2 of 4 | - | - | x1.006 | x1.000 | x0.776 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 KiB | 0.248 | 0.247 | x0.998 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.735 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 16 KiB | 0.231 | 0.231 | x1.002 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.083 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 KiB | 0.226 | 0.222 | x0.982 | level | 4 of 4 | - | - | x0.996 | x1.000 | x1.191 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 KiB | 0.220 | 0.218 | x0.991 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.433 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 KiB | 0.219 | 0.220 | x1.002 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.888 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 KiB | 0.226 | 0.225 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.962 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 KiB | 0.131 | 0.134 | x1.016 | level | 2 of 4 | - | - | x1.019 | x1.008 | x1.009 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 MiB | 0.113 | 0.103 | x0.920 | level | 2 of 4 | - | - | x0.922 | x1.024 | x1.000 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 MiB | 0.111 | 0.115 | x1.036 | level | 2 of 4 | - | - | x1.044 | x0.983 | x1.024 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 MiB | 0.108 | 0.111 | x1.034 | level | 2 of 4 | - | - | x1.035 | x0.972 | x1.038 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 MiB | 0.111 | 0.113 | x1.020 | level | 2 of 4 | - | - | x1.023 | x0.965 | x1.033 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 MiB | 0.115 | 0.116 | x1.005 | level | 1 of 4 | - | - | x1.009 | x0.995 | x1.001 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 MiB | 0.0612 | 0.0615 | x1.005 | level | 2 of 4 | - | - | x1.004 | x1.003 | x1.004 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 MiB | 0.0676 | 0.0683 | x1.011 | level | 1 of 4 | - | - | x1.010 | x1.035 | x1.010 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 MiB | 0.0711 | 0.0714 | x1.004 | level | 1 of 4 | - | - | x1.004 | x1.013 | x1.005 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1 | 175.591 | 173.965 | x0.991 | level | 1 of 4 | - | - | x0.987 | x1.009 | x0.749 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2 | 89.583 | 88.765 | x0.991 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.603 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 3 | 77.599 | 77.334 | x0.997 | level | 2 of 4 | - | - | x0.995 | x1.000 | x0.416 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4 | 48.248 | 50.424 | x1.045 | level | 0 of 4 | - | - | x1.005 | x0.999 | x1.190 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 6 | 43.049 | 43.184 | x1.003 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.396 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8 | 31.375 | 30.705 | x0.979 | level | 1 of 4 | - | - | x0.985 | x1.001 | x1.147 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 12 | 27.833 | 27.283 | x0.980 | level | 1 of 4 | - | - | x0.983 | x1.001 | x0.773 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16 | 24.008 | 23.431 | x0.976 | level | 2 of 4 | - | - | x0.980 | x1.001 | x0.868 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 24 | 20.792 | 20.414 | x0.982 | level | 3 of 4 | - | - | x0.992 | x1.000 | x0.860 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32 | 18.718 | 19.407 | x1.037 | level | 1 of 4 | - | - | x0.997 | x1.000 | x1.477 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 48 | 16.937 | 16.846 | x0.995 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.826 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 64 | 16.353 | 15.999 | x0.978 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.959 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 128 | 14.597 | 14.771 | x1.012 | level | 0 of 4 | - | - | x0.999 | x1.000 | x1.014 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 256 | 14.174 | 14.003 | x0.988 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.170 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 512 | 13.737 | 13.874 | x1.010 | level | 1 of 4 | - | - | x1.014 | x1.000 | x1.084 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1024 | 13.655 | 13.631 | x0.998 | level | 3 of 4 | - | - | x1.012 | x1.000 | x1.115 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2048 | 13.696 | 13.614 | x0.994 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.981 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4096 | 14.182 | 14.220 | x1.003 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.065 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8192 | 7.176 | 6.766 | x0.943 | level | 3 of 4 | - | - | x0.940 | x1.001 | x1.007 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16384 | 5.847 | 5.767 | x0.986 | level | 2 of 4 | - | - | x0.992 | x1.014 | x1.016 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32768 | 7.578 | 5.822 | x0.768 | level | 4 of 4 | - | - | x0.763 | x1.130 | x0.823 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 65536 | 5.123 | 6.893 | x1.345 | level | 1 of 4 | - | - | x1.347 | x0.797 | x1.398 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 131072 | 7.545 | 7.563 | x1.002 | level | 2 of 4 | - | - | x1.003 | x0.966 | x1.027 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 262144 | 7.451 | 7.702 | x1.034 | level | 1 of 4 | - | - | x1.034 | x0.965 | x1.057 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.706 | 0.641 | x0.908 | level | 4 of 4 | x0.808 | - | x0.912 | x0.962 | x0.692 |
| blake3-servil-mt / solo / ContinuousMessages / 128 B | 0.350 | 0.333 | x0.952 | level | 4 of 4 | x0.848 | - | x0.955 | x0.963 | x0.770 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.184 | 0.177 | x0.961 | level | 3 of 4 | x0.971 | - | x0.957 | x0.964 | x0.924 |
| blake3-servil-mt / solo / ContinuousMessages / 512 B | 0.110 | 0.110 | x0.996 | level | 1 of 4 | x0.929 | - | x0.996 | x0.969 | x0.812 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.0799 | 0.0722 | x0.903 | level | 4 of 4 | x0.902 | - | x0.902 | x0.974 | x1.163 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0710 | 0.0727 | x1.024 | level | 0 of 4 | x0.951 | - | x1.030 | x0.985 | x0.867 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0554 | 0.0564 | x1.017 | level | 2 of 4 | x1.034 | - | x1.020 | x1.004 | x0.899 |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.0515 | 0.0490 | x0.953 | level | 3 of 4 | x1.020 | - | x0.954 | x1.012 | x1.104 |
| blake3-servil-mt / solo / ContinuousMessages / 256 KiB | 0.0486 | 0.0463 | x0.952 | level | 2 of 4 | x1.015 | - | x0.950 | x1.010 | x1.118 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0458 | 0.0458 | x0.998 | level | 3 of 4 | x0.983 | - | x0.997 | x1.010 | x0.950 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.0451 | 0.0434 | x0.962 | level | 3 of 4 | x0.991 | - | x0.963 | x1.010 | x1.024 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0454 | 0.0436 | x0.961 | level | 2 of 4 | x1.014 | - | x0.960 | x1.011 | x1.058 |
| blake3-servil-mt / solo / ContinuousMessages / 64 MiB | 0.0616 | 0.0614 | x0.997 | level | 3 of 4 | x0.990 | - | x0.997 | x1.010 | x0.984 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 6.123 | 6.099 | x0.996 | level | 2 of 4 | x1.020 | - | x0.994 | x0.969 | x0.996 |
| blake3-servil-mt / solo / ContinuousBatches / 64 | 3.857 | 3.861 | x1.001 | level | 3 of 4 | x1.025 | - | x0.999 | x0.982 | x0.996 |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 3.343 | 3.514 | x1.051 | level | 0 of 4 | x0.947 | - | x1.052 | x0.994 | x0.903 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 3.517 | 3.225 | x0.917 | level | 4 of 4 | x1.012 | - | x0.914 | x0.981 | x1.183 |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 3.999 | 3.877 | x0.970 | level | 3 of 4 | x0.977 | - | x0.966 | x0.993 | x1.138 |
| blake3-servil-mt / solo / ContinuousBatches / 16384 | 4.004 | 4.239 | x1.059 | level | 1 of 4 | x1.050 | - | x1.061 | x0.934 | x0.940 |
| blake3-servil-mt / solo / ContinuousBatches / 65536 | 3.590 | 3.087 | x0.860 | level | 4 of 4 | x0.884 | - | x0.862 | x1.044 | x0.927 |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.951 | 0.986 | x1.037 | level | 0 of 4 | x1.037 | - | x1.036 | x1.010 | x1.274 |
| blake3-servil-mt / solo / LentMessages / 128 B | 0.963 | 0.970 | x1.007 | level | 1 of 4 | x1.007 | - | x1.007 | x1.006 | x1.847 |
| blake3-servil-mt / solo / LentMessages / 256 B | 0.934 | 0.938 | x1.005 | level | 0 of 4 | x1.005 | - | x1.004 | x1.003 | x2.225 |
| blake3-servil-mt / solo / LentMessages / 512 B | 0.930 | 0.935 | x1.006 | level | 0 of 4 | x1.006 | - | x1.005 | x1.002 | x1.283 |
| blake3-servil-mt / solo / LentMessages / 1 KiB | 0.929 | 0.929 | x1.000 | level | 3 of 4 | x0.999 | - | x1.000 | x1.001 | x0.369 |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.317 | 0.317 | x1.003 | level | 1 of 4 | x1.003 | - | x1.002 | x1.000 | x1.257 |
| blake3-servil-mt / solo / LentMessages / 16 KiB | 0.216 | 0.216 | x1.000 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x1.580 |
| blake3-servil-mt / solo / LentMessages / 64 KiB | 0.219 | 0.215 | x0.985 | level | 4 of 4 | x0.986 | - | x0.990 | x1.000 | x0.428 |
| blake3-servil-mt / solo / LentMessages / 256 KiB | 0.220 | 0.220 | x1.001 | level | 2 of 4 | x1.003 | - | x1.003 | x1.000 | x0.939 |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.0784 | 0.0811 | x1.034 | level | 1 of 4 | x1.061 | - | x1.031 | x0.994 | x0.968 |
| blake3-servil-mt / solo / LentMessages / 4 MiB | 0.0652 | 0.0639 | x0.980 | level | 3 of 4 | x0.999 | - | x0.980 | x0.999 | x0.973 |
| blake3-servil-mt / solo / LentMessages / 16 MiB | 0.0911 | 0.0960 | x1.053 | level | 1 of 4 | x1.001 | - | x1.051 | x1.025 | x1.030 |
| blake3-servil-mt / solo / LentMessages / 64 MiB | 0.0815 | 0.0808 | x0.992 | level | 4 of 4 | x0.967 | - | x0.993 | x1.003 | x1.010 |
| blake3-servil-mt / solo / Interleaved / 256 | 0.260 | 0.259 | x0.995 | level | 1 of 4 | x0.995 | - | x0.994 | x0.998 | x1.013 |
| blake3-servil-mt / solo / Collection / git objects | 0.0139 | 0.0139 | x1.000 | level | 3 of 4 | x1.014 | - | x1.004 | x1.006 | x1.021 |
| blake3-servil-mt / solo / Collection / Nix files | 0.0208 | 0.0208 | x1.001 | level | 1 of 4 | x1.052 | - | x0.980 | x0.961 | x0.939 |
| blake3-servil-mt / solo / LentBatches / 16 | 16.297 | 16.921 | x1.038 | level | 1 of 4 | x1.038 | - | x1.038 | x0.999 | x1.017 |
| blake3-servil-mt / solo / LentBatches / 64 | 13.768 | 13.878 | x1.008 | level | 0 of 4 | x1.008 | - | x1.008 | x1.000 | x1.023 |
| blake3-servil-mt / solo / LentBatches / 256 | 13.676 | 13.812 | x1.010 | level | 2 of 4 | x1.011 | - | x1.011 | x1.000 | x1.083 |
| blake3-servil-mt / solo / LentBatches / 1024 | 13.859 | 13.892 | x1.002 | level | 1 of 4 | x1.002 | - | x1.003 | x1.000 | x0.988 |
| blake3-servil-mt / solo / LentBatches / 4096 | 14.433 | 14.616 | x1.013 | level | 1 of 4 | x1.013 | - | x1.012 | x1.000 | x1.081 |
| blake3-servil-mt / solo / LentBatches / 16384 | 5.345 | 5.409 | x1.012 | level | 2 of 4 | x1.032 | - | x1.014 | x1.019 | x0.987 |
| blake3-servil-mt / solo / LentBatches / 65536 | 4.916 | 4.878 | x0.992 | level | 2 of 4 | x0.988 | - | x0.992 | x1.000 | x1.139 |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.0644 | 0.0636 | x0.987 | level | 3 of 4 | x1.000 | - | x0.989 | x1.001 | x1.006 |
| blake3-servil-mt / solo / ContinuousCollection / Nix files | 0.0643 | 0.0639 | x0.994 | level | 3 of 4 | x0.997 | - | x0.993 | x1.000 | x0.958 |
| blake3-servil-mt / solo / MerkleTree / 1024 | 0.262 | 0.262 | x0.998 | level | 2 of 4 | x0.998 | - | x0.998 | x1.000 | x1.006 |
| blake3-servil-mt / solo / MerkleTree / 4096 | 0.131 | 0.130 | x0.992 | level | 3 of 4 | x1.003 | - | x0.994 | x1.000 | x0.978 |
| blake3-servil-mt / solo / MerkleTree / 16384 | 0.139 | 0.145 | x1.047 | level | 1 of 4 | x1.092 | - | x1.045 | x0.996 | x1.190 |
| blake3-servil-mt / solo / MerkleTree / 65536 | 0.149 | 0.152 | x1.016 | level | 0 of 4 | x1.023 | - | x1.017 | x1.000 | x1.029 |
| blake3-servil-mt / solo / MerkleTree / 262144 | 0.345 | 0.346 | x1.002 | level | 1 of 4 | x1.038 | - | x1.001 | x0.994 | x1.013 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 32 B | 0.281 | 0.276 | x0.982 | level | 1 of 4 | x0.914 | - | x0.993 | x1.051 | x0.932 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 32 B | 0.434 | 0.435 | x1.003 | level | 2 of 4 | x1.019 | - | x1.003 | x0.920 | x0.997 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 16 B | 0.347 | 0.338 | x0.974 | level | 3 of 4 | x1.066 | - | x0.972 | x0.905 | x0.986 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 48 B | 0.192 | 0.184 | x0.958 | level | 3 of 4 | x0.864 | - | x0.958 | x1.021 | x0.908 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 48 B | 0.398 | 0.398 | x1.000 | level | 1 of 4 | x1.017 | - | x1.001 | x1.004 | x1.000 |
| blake3-servil-mt / solo / InterleavedTurn / 256 | 0.846 | 0.843 | x0.996 | level | 2 of 4 | - | - | x0.967 | x0.871 | x1.007 |
| blake3-servil-mt / solo / InterleavedTurn / 1024 x 1 KiB | 0.334 | 0.326 | x0.977 | level | 4 of 4 | - | - | x0.976 | x0.978 | x1.015 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 256 | 0.802 | 0.785 | x0.978 | level | 2 of 4 | - | - | x0.930 | x0.877 | x0.985 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.492 | 0.488 | x0.991 | level | 3 of 4 | - | - | x0.979 | x0.975 | x1.016 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 256 | 0.597 | 0.598 | x1.001 | level | 1 of 4 | - | - | x0.954 | x0.813 | x0.965 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.309 | 0.301 | x0.973 | level | 3 of 4 | - | - | x0.977 | x0.982 | x1.000 |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.0474 | 0.0466 | x0.983 | level | 2 of 4 | x0.901 | - | x0.985 | x1.010 | x1.006 |
| blake3-servil-mt / solo / ReceivingMessage / 2 μs | 0.0930 | 0.0930 | x0.999 | level | 3 of 4 | x0.933 | - | x0.934 | x1.009 | x0.996 |
| blake3-servil-mt / solo / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 4 of 4 | x1.084 | - | x1.008 | x0.954 | x0.974 |
| blake3-servil-mt / solo / IncrementalMessage / 64 B | 8.008 | 8.289 | x1.035 | level | 1 of 4 | - | - | x1.021 | x1.003 | x0.994 |
| blake3-servil-mt / solo / IncrementalMessage / 1 KiB | 1.531 | 1.580 | x1.032 | level | 1 of 4 | - | - | x1.003 | x1.002 | x1.003 |
| blake3-servil-mt / solo / IncrementalMessage / 4 KiB | 0.712 | 0.695 | x0.976 | level | 2 of 4 | - | - | x0.976 | x1.000 | x0.996 |
| blake3-servil-mt / solo / LentIncrementalMessage / 64 B | 1.277 | 1.278 | x1.001 | level | 2 of 4 | x1.001 | - | x1.002 | x1.005 | x1.872 |
| blake3-servil-mt / solo / LentIncrementalMessage / 1 KiB | 0.953 | 0.953 | x1.000 | level | 2 of 4 | x1.000 | - | x1.001 | x1.001 | x0.990 |
| blake3-servil-mt / solo / LentIncrementalMessage / 4 KiB | 0.330 | 0.329 | x0.999 | level | 2 of 4 | x1.001 | - | x1.000 | x1.000 | x0.787 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 5.503 | 6.560 | x1.192 | level | 0 of 4 | x1.224 | - | x1.194 | x0.988 | x1.138 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 4 KiB | 0.142 | 0.149 | x1.045 | level | 0 of 4 | x1.078 | - | x1.052 | x0.996 | x0.959 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 1 MiB | 0.0462 | 0.0434 | x0.939 | level | 2 of 4 | x1.000 | - | x0.940 | x1.010 | x1.180 |
| blake3-servil-mt / solo / ContinuousLentMessages / 64 B | 0.619 | 0.568 | x0.919 | level | 4 of 4 | x0.700 | - | x0.923 | x0.955 | x0.711 |
| blake3-servil-mt / solo / ContinuousLentMessages / 4 KiB | 0.0376 | 0.0382 | x1.016 | level | 1 of 4 | x1.062 | - | x1.022 | x0.958 | x0.919 |
| blake3-servil-mt / solo / ContinuousLentMessages / 1 MiB | 0.00873 | 0.00867 | x0.992 | level | 3 of 4 | x1.000 | - | x0.990 | x1.004 | x0.875 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.667 | 0.622 | x0.933 | level | 4 of 4 | - | - | x0.933 | x0.962 | x0.731 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 128 B | 0.341 | 0.339 | x0.995 | level | 2 of 4 | - | - | x0.995 | x0.963 | x0.834 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.185 | 0.189 | x1.022 | level | 2 of 4 | - | - | x1.023 | x0.964 | x1.005 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 512 B | 0.128 | 0.130 | x1.011 | level | 1 of 4 | - | - | x1.012 | x0.969 | x0.837 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.0952 | 0.0990 | x1.040 | level | 0 of 4 | - | - | x1.022 | x0.975 | x1.033 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.115 | 0.118 | x1.028 | level | 1 of 4 | - | - | x1.045 | x0.990 | x1.000 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.0900 | 0.0960 | x1.067 | level | 0 of 4 | - | - | x1.049 | x1.005 | x1.043 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.0766 | 0.0753 | x0.983 | level | 2 of 4 | - | - | x0.986 | x1.006 | x1.006 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 KiB | 0.0737 | 0.0758 | x1.029 | level | 1 of 4 | - | - | x1.030 | x1.007 | x1.020 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0743 | 0.0756 | x1.018 | level | 1 of 4 | - | - | x1.020 | x1.005 | x1.042 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.0780 | 0.0777 | x0.996 | level | 3 of 4 | - | - | x1.022 | x1.015 | x1.037 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.0761 | 0.0777 | x1.021 | level | 1 of 4 | - | - | x1.009 | x1.007 | x1.070 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 MiB | 0.0785 | 0.0795 | x1.014 | level | 1 of 4 | - | - | x1.025 | x1.009 | x0.979 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 7.447 | 7.303 | x0.981 | level | 2 of 4 | - | - | x0.983 | x0.968 | x1.018 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 64 | 5.705 | 5.586 | x0.979 | level | 4 of 4 | - | - | x0.994 | x0.977 | x0.969 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 256 | 5.308 | 5.261 | x0.991 | level | 3 of 4 | - | - | x1.002 | x0.985 | x1.038 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 5.027 | 5.042 | x1.003 | level | 2 of 4 | - | - | x1.007 | x0.981 | x1.053 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 4096 | 5.635 | 5.206 | x0.924 | level | 3 of 4 | - | - | x0.929 | x1.005 | x0.958 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16384 | 4.940 | 4.922 | x0.996 | level | 3 of 4 | - | - | x0.998 | x0.952 | x0.980 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 65536 | 6.621 | 6.043 | x0.913 | level | 3 of 4 | - | - | x0.909 | x1.078 | x0.768 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.948 | 0.980 | x1.034 | level | 0 of 4 | - | - | x1.033 | x1.010 | x1.778 |
| blake3-servil-mt / shared-one-cache / LentMessages / 128 B | 0.952 | 0.965 | x1.014 | level | 0 of 4 | - | - | x1.015 | x1.006 | x2.376 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 B | 0.932 | 0.936 | x1.005 | level | 0 of 4 | - | - | x1.005 | x1.003 | x1.237 |
| blake3-servil-mt / shared-one-cache / LentMessages / 512 B | 0.930 | 0.934 | x1.005 | level | 0 of 4 | - | - | x1.005 | x1.002 | x0.985 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 KiB | 0.926 | 0.928 | x1.002 | level | 0 of 4 | - | - | x1.003 | x1.001 | x0.998 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.318 | 0.316 | x0.993 | level | 4 of 4 | - | - | x0.993 | x1.000 | x0.890 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 KiB | 0.215 | 0.215 | x0.998 | level | 1 of 4 | - | - | x0.998 | x1.000 | x0.938 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 KiB | 0.216 | 0.214 | x0.994 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.738 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 KiB | 0.220 | 0.220 | x1.004 | level | 2 of 4 | - | - | x1.004 | x1.000 | x1.104 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 MiB | 0.0981 | 0.0962 | x0.981 | level | 3 of 4 | - | - | x0.986 | x0.986 | x0.947 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 MiB | 0.0745 | 0.0740 | x0.992 | level | 2 of 4 | - | - | x0.996 | x0.995 | x1.012 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 MiB | 0.136 | 0.138 | x1.018 | level | 2 of 4 | - | - | x1.017 | x1.004 | x1.056 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 MiB | 0.115 | 0.111 | x0.970 | level | 3 of 4 | - | - | x0.976 | x0.895 | x0.984 |
| blake3-servil-mt / shared-one-cache / Interleaved / 256 | 0.271 | 0.266 | x0.981 | level | 3 of 4 | - | - | x0.979 | x0.999 | x1.007 |
| blake3-servil-mt / shared-one-cache / Collection / git objects | 0.0295 | 0.0298 | x1.009 | level | 2 of 4 | - | - | x0.961 | x0.960 | x0.972 |
| blake3-servil-mt / shared-one-cache / Collection / Nix files | 0.0319 | 0.0331 | x1.038 | level | 1 of 4 | - | - | x0.989 | x0.985 | x1.008 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16 | 16.306 | 16.912 | x1.037 | level | 0 of 4 | - | - | x1.044 | x0.999 | x0.960 |
| blake3-servil-mt / shared-one-cache / LentBatches / 64 | 13.716 | 13.844 | x1.009 | level | 1 of 4 | - | - | x1.010 | x1.000 | x1.173 |
| blake3-servil-mt / shared-one-cache / LentBatches / 256 | 13.697 | 13.587 | x0.992 | level | 3 of 4 | - | - | x0.992 | x1.000 | x0.757 |
| blake3-servil-mt / shared-one-cache / LentBatches / 1024 | 13.799 | 13.807 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.103 |
| blake3-servil-mt / shared-one-cache / LentBatches / 4096 | 14.409 | 14.454 | x1.003 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.000 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16384 | 6.599 | 6.167 | x0.935 | level | 4 of 4 | - | - | x0.931 | x0.996 | x1.049 |
| blake3-servil-mt / shared-one-cache / LentBatches / 65536 | 6.754 | 6.815 | x1.009 | level | 2 of 4 | - | - | x1.010 | x1.065 | x1.014 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.0920 | 0.0941 | x1.023 | level | 1 of 4 | - | - | x1.025 | x1.005 | x0.955 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / Nix files | 0.0926 | 0.0935 | x1.010 | level | 2 of 4 | - | - | x1.012 | x1.004 | x0.967 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1024 | 0.262 | 0.263 | x1.004 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.005 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 4096 | 0.148 | 0.147 | x0.991 | level | 1 of 4 | - | - | x0.996 | x0.994 | x1.006 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 16384 | 0.164 | 0.162 | x0.993 | level | 2 of 4 | - | - | x0.993 | x1.000 | x1.137 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 | 0.239 | 0.240 | x1.005 | level | 2 of 4 | - | - | x1.006 | x1.005 | x1.013 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 262144 | 0.356 | 0.351 | x0.987 | level | 3 of 4 | - | - | x0.986 | x1.005 | x0.990 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 32 B | 0.364 | 0.365 | x1.004 | level | 2 of 4 | - | - | x1.008 | x1.023 | x1.014 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 32 B | 0.520 | 0.524 | x1.008 | level | 2 of 4 | - | - | x1.009 | x0.983 | x1.016 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 16 B | 0.578 | 0.564 | x0.974 | level | 3 of 4 | - | - | x0.994 | x0.958 | x0.933 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 48 B | 0.299 | 0.298 | x0.994 | level | 2 of 4 | - | - | x0.995 | x1.001 | x1.005 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 48 B | 0.438 | 0.438 | x1.000 | level | 2 of 4 | - | - | x1.002 | x0.961 | x1.006 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.0769 | 0.0786 | x1.022 | level | 1 of 4 | - | - | x1.029 | x1.003 | x0.994 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 2 μs | 0.0958 | 0.0950 | x0.991 | level | 2 of 4 | - | - | x1.022 | x1.010 | x1.002 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 4 of 4 | - | - | x1.000 | x0.993 | x0.961 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 64 B | 1.271 | 1.270 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.005 | x1.053 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 1 KiB | 0.949 | 0.952 | x1.003 | level | 1 of 4 | - | - | x1.002 | x1.001 | x1.003 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 4 KiB | 0.328 | 0.328 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.001 | x1.109 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 15.844 | 18.428 | x1.163 | level | 0 of 4 | - | - | x1.102 | x0.990 | x0.980 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 4 KiB | 0.261 | 0.266 | x1.020 | level | 3 of 4 | - | - | x1.068 | x1.001 | x1.001 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 1 MiB | 0.0772 | 0.0790 | x1.024 | level | 1 of 4 | - | - | x1.028 | x1.004 | x1.013 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 64 B | 0.587 | 0.566 | x0.964 | level | 3 of 4 | - | - | x0.965 | x0.955 | x0.808 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 4 KiB | 0.0752 | 0.0770 | x1.024 | level | 2 of 4 | - | - | x1.046 | x0.963 | x0.834 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 1 MiB | 0.0161 | 0.0162 | x1.005 | level | 1 of 4 | - | - | x1.091 | x1.106 | x1.093 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 B | 1.243 | 1.026 | x0.825 | level | 4 of 4 | - | - | x0.823 | x0.962 | x0.798 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 128 B | 0.646 | 0.511 | x0.790 | level | 4 of 4 | - | - | x0.786 | x0.963 | x0.854 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 256 B | 0.393 | 0.369 | x0.941 | level | 4 of 4 | - | - | x0.929 | x0.964 | x0.874 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 512 B | 0.215 | 0.184 | x0.855 | level | 4 of 4 | - | - | x0.853 | x0.969 | x0.832 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 KiB | 0.149 | 0.125 | x0.840 | level | 4 of 4 | - | - | x0.839 | x0.974 | x1.002 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 4 KiB | 0.107 | 0.114 | x1.067 | level | 1 of 4 | - | - | x1.074 | x0.987 | x0.877 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 16 KiB | 0.0887 | 0.0940 | x1.060 | level | 1 of 4 | - | - | x1.063 | x1.005 | x0.911 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 KiB | 0.0884 | 0.0947 | x1.071 | level | 1 of 4 | - | - | x1.061 | x1.009 | x0.929 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 256 KiB | 0.0896 | 0.0950 | x1.060 | level | 0 of 4 | - | - | x1.044 | x1.006 | x0.953 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 MiB | 0.0911 | 0.0936 | x1.027 | level | 1 of 4 | - | - | x1.012 | x1.009 | x0.988 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 4 MiB | 0.0912 | 0.0920 | x1.009 | level | 1 of 4 | - | - | x0.995 | x1.012 | x1.008 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 16 MiB | 0.0934 | 0.0933 | x0.998 | level | 2 of 4 | - | - | x0.984 | x1.013 | x1.022 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 MiB | 0.111 | 0.109 | x0.983 | level | 3 of 4 | - | - | x0.976 | x1.011 | x1.043 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 16 | 14.114 | 14.257 | x1.010 | level | 1 of 4 | - | - | x1.003 | x0.969 | x1.004 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 64 | 9.272 | 9.310 | x1.004 | level | 3 of 4 | - | - | x0.991 | x0.983 | x0.955 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 256 | 7.998 | 7.807 | x0.976 | level | 3 of 4 | - | - | x0.966 | x0.994 | x0.942 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 1024 | 7.553 | 7.405 | x0.980 | level | 3 of 4 | - | - | x0.968 | x0.980 | x0.942 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 4096 | 8.196 | 8.591 | x1.048 | level | 0 of 4 | - | - | x1.050 | x0.996 | x0.859 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 16384 | 7.799 | 7.900 | x1.013 | level | 1 of 4 | - | - | x1.014 | x0.969 | x1.008 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 65536 | 6.223 | 6.260 | x1.006 | level | 1 of 4 | - | - | x1.007 | x1.009 | x0.946 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 B | 0.950 | 0.978 | x1.029 | level | 0 of 4 | - | - | x1.029 | x1.010 | x2.451 |
| blake3-servil-mt / shared-two-caches / LentMessages / 128 B | 0.954 | 0.968 | x1.015 | level | 0 of 4 | - | - | x1.014 | x1.006 | x3.138 |
| blake3-servil-mt / shared-two-caches / LentMessages / 256 B | 0.935 | 0.939 | x1.005 | level | 0 of 4 | - | - | x1.004 | x1.003 | x0.681 |
| blake3-servil-mt / shared-two-caches / LentMessages / 512 B | 0.932 | 0.935 | x1.004 | level | 0 of 4 | - | - | x1.004 | x1.002 | x1.142 |
| blake3-servil-mt / shared-two-caches / LentMessages / 1 KiB | 0.926 | 0.928 | x1.002 | level | 0 of 4 | - | - | x1.002 | x1.001 | x1.146 |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 KiB | 0.319 | 0.316 | x0.993 | level | 3 of 4 | - | - | x0.993 | x1.000 | x0.785 |
| blake3-servil-mt / shared-two-caches / LentMessages / 16 KiB | 0.216 | 0.215 | x0.998 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.987 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 KiB | 0.216 | 0.215 | x0.995 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.815 |
| blake3-servil-mt / shared-two-caches / LentMessages / 256 KiB | 0.218 | 0.219 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.047 |
| blake3-servil-mt / shared-two-caches / LentMessages / 1 MiB | 0.107 | 0.107 | x0.999 | level | 2 of 4 | - | - | x1.009 | x1.001 | x0.990 |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 MiB | 0.0851 | 0.0835 | x0.981 | level | 2 of 4 | - | - | x0.985 | x0.996 | x0.996 |
| blake3-servil-mt / shared-two-caches / LentMessages / 16 MiB | 0.0943 | 0.0893 | x0.947 | level | 3 of 4 | - | - | x0.950 | x1.021 | x0.927 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 MiB | 0.0856 | 0.0842 | x0.983 | level | 1 of 4 | - | - | x0.984 | x0.968 | x1.029 |
| blake3-servil-mt / shared-two-caches / Interleaved / 256 | 0.257 | 0.256 | x0.996 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.997 |
| blake3-servil-mt / shared-two-caches / Collection / git objects | 0.0296 | 0.0291 | x0.983 | level | 3 of 4 | - | - | x1.018 | x1.026 | x1.025 |
| blake3-servil-mt / shared-two-caches / Collection / Nix files | 0.0320 | 0.0316 | x0.988 | level | 3 of 4 | - | - | x0.975 | x0.979 | x1.002 |
| blake3-servil-mt / shared-two-caches / LentBatches / 16 | 16.190 | 16.906 | x1.044 | level | 0 of 4 | - | - | x1.044 | x0.999 | x1.006 |
| blake3-servil-mt / shared-two-caches / LentBatches / 64 | 13.729 | 13.875 | x1.011 | level | 0 of 4 | - | - | x1.011 | x1.000 | x1.284 |
| blake3-servil-mt / shared-two-caches / LentBatches / 256 | 13.713 | 13.603 | x0.992 | level | 3 of 4 | - | - | x0.992 | x1.000 | x0.779 |
| blake3-servil-mt / shared-two-caches / LentBatches / 1024 | 13.803 | 13.816 | x1.001 | level | 3 of 4 | - | - | x1.001 | x1.000 | x1.105 |
| blake3-servil-mt / shared-two-caches / LentBatches / 4096 | 14.411 | 14.421 | x1.001 | level | 3 of 4 | - | - | x1.001 | x1.000 | x0.995 |
| blake3-servil-mt / shared-two-caches / LentBatches / 16384 | 7.512 | 7.759 | x1.033 | level | 0 of 4 | - | - | x1.033 | x1.004 | x0.999 |
| blake3-servil-mt / shared-two-caches / LentBatches / 65536 | 6.416 | 5.909 | x0.921 | level | 3 of 4 | - | - | x0.922 | x0.989 | x1.051 |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / git objects | 0.104 | 0.106 | x1.019 | level | 2 of 4 | - | - | x1.023 | x1.002 | x0.935 |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / Nix files | 0.103 | 0.108 | x1.045 | level | 1 of 4 | - | - | x1.045 | x1.001 | x0.883 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1024 | 0.260 | 0.261 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.022 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 4096 | 0.133 | 0.133 | x1.005 | level | 2 of 4 | - | - | x1.007 | x1.002 | x1.012 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 16384 | 0.148 | 0.145 | x0.980 | level | 2 of 4 | - | - | x0.983 | x0.995 | x1.435 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 | 0.178 | 0.179 | x1.003 | level | 1 of 4 | - | - | x1.003 | x1.008 | x0.982 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 262144 | 0.345 | 0.345 | x1.001 | level | 3 of 4 | - | - | x1.002 | x0.936 | x0.990 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 x 32 B | 0.352 | 0.350 | x0.994 | level | 4 of 4 | - | - | x0.997 | x0.995 | x1.015 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 32 B | 0.494 | 0.510 | x1.032 | level | 0 of 4 | - | - | x1.030 | x1.085 | x1.024 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 16 B | 0.519 | 0.520 | x1.001 | level | 2 of 4 | - | - | x1.012 | x1.042 | x0.968 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 x 48 B | 0.282 | 0.282 | x1.000 | level | 2 of 4 | - | - | x1.002 | x0.995 | x0.976 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 48 B | 0.443 | 0.431 | x0.973 | level | 3 of 4 | - | - | x0.979 | x0.955 | x1.001 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / saturated | 0.0912 | 0.0960 | x1.053 | level | 1 of 4 | - | - | x1.043 | x1.017 | x0.997 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / 2 μs | 0.106 | 0.105 | x0.988 | level | 2 of 4 | - | - | x1.073 | x1.004 | x0.920 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 4 of 4 | - | - | x0.700 | x0.957 | x0.828 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 64 B | 1.273 | 1.272 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.005 | x0.966 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 1 KiB | 0.951 | 0.953 | x1.002 | level | 0 of 4 | - | - | x1.002 | x1.001 | x0.946 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 4 KiB | 0.328 | 0.328 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.001 | x1.021 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 64 B | 16.274 | 17.485 | x1.074 | level | 0 of 4 | - | - | x1.100 | x0.995 | x0.965 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 4 KiB | 0.249 | 0.258 | x1.037 | level | 1 of 4 | - | - | x1.018 | x1.009 | x1.012 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 1 MiB | 0.0910 | 0.0909 | x0.999 | level | 2 of 4 | - | - | x0.985 | x1.007 | x1.067 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 64 B | 0.664 | 0.605 | x0.911 | level | 4 of 4 | - | - | x0.911 | x0.955 | x0.911 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 4 KiB | 0.0676 | 0.0710 | x1.051 | level | 1 of 4 | - | - | x1.066 | x0.965 | x0.843 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 1 MiB | 0.0187 | 0.0207 | x1.108 | level | 1 of 4 | - | - | x1.169 | x1.196 | x1.180 |

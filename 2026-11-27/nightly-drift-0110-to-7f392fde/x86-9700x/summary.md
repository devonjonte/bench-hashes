# Nightly drift check: e1966b498bc7 -> 7f392fdebc90

- Host: bench-9700x
- Experiment: `bench=3f119a507807078649d8700112994fce24666868|base=e1966b498bc769db3d51451a4ddc8188a19ed593|target=7f392fdebc90aa362c7115cceb1824df2319102b|cells=all|layouts=default`
- bench-hashes: `3f119a507807078649d8700112994fce24666868`
- BLAKE3-Servil base: `e1966b498bc769db3d51451a4ddc8188a19ed593`
- BLAKE3-Servil target: `7f392fdebc90aa362c7115cceb1824df2319102b`
- Scope: `--cells all` (layouts: default)
- Deciding stage: stage 2 (kept-drift/second)
- Verdict: **no regression** (exit `0`)

## Stage 2 (deciding, kept-drift/second)

compare: old side: bench 3f119a507807 clean; servil e1966b498bc7 clean
compare: new side: bench 3f119a507807 clean; servil 7f392fdebc90 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / ManyMessages / 1 | 521.514 | 518.286 | x0.994 | level | 36 of 64 | - | - | x0.992 | x1.007 | x1.009 |
| blake3-servil-st / solo / ManyMessages / 64 | 19.230 | 19.459 | x1.012 | level | 29 of 64 | - | - | x1.005 | x1.000 | x0.988 |
| blake3-servil-mt / solo / OneMessage / 128 B | 3.652 | 3.552 | x0.973 | level | 35 of 64 | - | - | x0.977 | x0.999 | x1.007 |
| blake3-servil-mt / solo / Collection / git objects | 0.0177 | 0.0177 | x0.998 | level | 36 of 64 | x1.004 | - | x1.002 | x0.999 | x0.997 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 4.539 | 4.573 | x1.008 | level | 23 of 64 | x1.012 | - | x1.005 | x0.943 | x1.074 |
| blake3-servil-mt / solo / ContinuousLentMessages / 4 KiB | 0.0213 | 0.0212 | x0.996 | level | 38 of 64 | x0.993 | - | x0.994 | x0.981 | x0.987 |
| blake3-servil-mt / shared-one-cache / Collection / git objects | 0.0409 | 0.0410 | x1.003 | level | 29 of 64 | - | - | x0.998 | x0.994 | x0.996 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 4.411 | 4.340 | x0.984 | level | 31 of 64 | - | - | x1.009 | x0.943 | x1.089 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 4 KiB | 0.0414 | 0.0413 | x1.000 | level | 33 of 64 | - | - | x0.997 | x0.985 | x0.929 |

## Stage 1 (initial screen, kept-drift)

compare: old side: bench 3f119a507807 clean; servil e1966b498bc7 clean
compare: new side: bench 3f119a507807 clean; servil 7f392fdebc90 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 6.713 | 6.109 | x0.910 | level | 3 of 4 | - | - | x0.953 | x1.004 | x0.982 |
| blake3-servil-st / solo / OneMessage / 128 B | 3.884 | 3.700 | x0.953 | level | 3 of 4 | - | - | x0.986 | x1.009 | x1.015 |
| blake3-servil-st / solo / OneMessage / 256 B | 2.634 | 2.451 | x0.931 | level | 3 of 4 | - | - | x0.978 | x1.005 | x1.029 |
| blake3-servil-st / solo / OneMessage / 512 B | 1.869 | 1.699 | x0.909 | level | 4 of 4 | - | - | x0.949 | x1.004 | x1.027 |
| blake3-servil-st / solo / OneMessage / 1 KiB | 1.485 | 1.449 | x0.976 | level | 3 of 4 | - | - | x0.993 | x1.001 | x1.013 |
| blake3-servil-st / solo / OneMessage / 1536 B | 1.341 | 1.330 | x0.992 | level | 2 of 4 | - | - | x0.993 | x0.995 | x0.987 |
| blake3-servil-st / solo / OneMessage / 2 KiB | 0.829 | 0.823 | x0.993 | level | 2 of 4 | - | - | x1.014 | x0.999 | x0.996 |
| blake3-servil-st / solo / OneMessage / 2304 B | 1.014 | 1.007 | x0.993 | level | 3 of 4 | - | - | x0.996 | x1.001 | x0.976 |
| blake3-servil-st / solo / OneMessage / 3 KiB | 0.706 | 0.720 | x1.020 | level | 2 of 4 | - | - | x1.028 | x1.000 | x0.995 |
| blake3-servil-st / solo / OneMessage / 3839 B | 0.782 | 0.741 | x0.948 | level | 4 of 4 | - | - | x0.959 | x1.000 | x0.963 |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.459 | 0.461 | x1.004 | level | 1 of 4 | - | - | x1.016 | x1.000 | x0.966 |
| blake3-servil-st / solo / OneMessage / 4470 B | 0.585 | 0.587 | x1.003 | level | 2 of 4 | - | - | x1.011 | x1.000 | x0.971 |
| blake3-servil-st / solo / OneMessage / 7935 B | 0.582 | 0.575 | x0.988 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.996 |
| blake3-servil-st / solo / OneMessage / 8 KiB | 0.355 | 0.369 | x1.037 | level | 1 of 4 | - | - | x1.014 | x1.000 | x1.014 |
| blake3-servil-st / solo / OneMessage / 16 KiB | 0.218 | 0.217 | x0.997 | level | 2 of 4 | - | - | x0.991 | x1.000 | x1.032 |
| blake3-servil-st / solo / OneMessage / 32 KiB | 0.193 | 0.183 | x0.946 | level | 3 of 4 | - | - | x0.949 | x0.999 | x1.044 |
| blake3-servil-st / solo / OneMessage / 64 KiB | 0.139 | 0.139 | x1.000 | level | 3 of 4 | - | - | x1.004 | x1.000 | x1.024 |
| blake3-servil-st / solo / OneMessage / 128 KiB | 0.115 | 0.112 | x0.975 | level | 3 of 4 | - | - | x0.976 | x1.000 | x1.047 |
| blake3-servil-st / solo / OneMessage / 256 KiB | 0.102 | 0.1000 | x0.985 | level | 3 of 4 | - | - | x0.986 | x1.000 | x1.102 |
| blake3-servil-st / solo / OneMessage / 512 KiB | 0.0904 | 0.0899 | x0.995 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.082 |
| blake3-servil-st / solo / OneMessage / 1 MiB | 0.0853 | 0.0851 | x0.997 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.042 |
| blake3-servil-st / solo / OneMessage / 2 MiB | 0.0848 | 0.0844 | x0.996 | level | 3 of 4 | - | - | x0.995 | x1.000 | x1.062 |
| blake3-servil-st / solo / OneMessage / 3 MiB | 0.0850 | 0.0847 | x0.996 | level | 2 of 4 | - | - | x0.994 | x1.000 | x1.045 |
| blake3-servil-st / solo / OneMessage / 4 MiB | 0.0851 | 0.0846 | x0.995 | level | 4 of 4 | - | - | x0.994 | x1.000 | x1.043 |
| blake3-servil-st / solo / OneMessage / 8 MiB | 0.0905 | 0.0901 | x0.996 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.021 |
| blake3-servil-st / solo / OneMessage / 32 MiB | 0.130 | 0.129 | x0.996 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.018 |
| blake3-servil-st / solo / OneMessage / 64 MiB | 0.131 | 0.131 | x0.997 | level | 3 of 4 | - | - | x0.994 | x1.000 | x1.007 |
| blake3-servil-st / solo / OneMessage / 128 MiB | 0.131 | 0.130 | x0.994 | level | 3 of 4 | - | - | x0.994 | x1.000 | x1.006 |
| blake3-servil-st / solo / ManyMessages / 1 | 634.249 | 643.442 | x1.014 | level | 2 of 4 | - | - | x1.031 | x1.010 | x0.991 |
| blake3-servil-st / solo / ManyMessages / 2 | 288.315 | 287.976 | x0.999 | level | 2 of 4 | - | - | x1.031 | x1.009 | x0.932 |
| blake3-servil-st / solo / ManyMessages / 3 | 230.025 | 229.560 | x0.998 | level | 3 of 4 | - | - | x1.007 | x0.999 | x0.925 |
| blake3-servil-st / solo / ManyMessages / 4 | 145.718 | 140.975 | x0.967 | level | 1 of 4 | - | - | x0.979 | x0.991 | x0.965 |
| blake3-servil-st / solo / ManyMessages / 6 | 110.879 | 112.640 | x1.016 | level | 1 of 4 | - | - | x1.006 | x0.994 | x0.935 |
| blake3-servil-st / solo / ManyMessages / 8 | 109.391 | 105.083 | x0.961 | level | 3 of 4 | - | - | x0.967 | x0.996 | x0.973 |
| blake3-servil-st / solo / ManyMessages / 12 | 81.270 | 82.118 | x1.010 | level | 2 of 4 | - | - | x1.022 | x1.003 | x0.957 |
| blake3-servil-st / solo / ManyMessages / 16 | 61.126 | 59.258 | x0.969 | level | 2 of 4 | - | - | x0.965 | x1.003 | x0.978 |
| blake3-servil-st / solo / ManyMessages / 24 | 50.706 | 50.521 | x0.996 | level | 1 of 4 | - | - | x0.988 | x0.996 | x0.990 |
| blake3-servil-st / solo / ManyMessages / 32 | 32.985 | 33.022 | x1.001 | level | 1 of 4 | - | - | x0.998 | x0.998 | x0.991 |
| blake3-servil-st / solo / ManyMessages / 48 | 24.124 | 24.365 | x1.010 | level | 1 of 4 | - | - | x1.004 | x0.999 | x0.989 |
| blake3-servil-st / solo / ManyMessages / 64 | 19.020 | 20.283 | x1.066 | level | 1 of 4 | - | - | x1.019 | x1.001 | x1.001 |
| blake3-servil-st / solo / ManyMessages / 128 | 13.625 | 13.785 | x1.012 | level | 2 of 4 | - | - | x1.000 | x1.001 | x1.027 |
| blake3-servil-st / solo / ManyMessages / 256 | 10.774 | 10.327 | x0.959 | level | 4 of 4 | - | - | x0.951 | x1.000 | x1.005 |
| blake3-servil-st / solo / ManyMessages / 512 | 9.105 | 8.800 | x0.966 | level | 3 of 4 | - | - | x0.960 | x0.999 | x1.005 |
| blake3-servil-st / solo / ManyMessages / 1024 | 8.124 | 8.092 | x0.996 | level | 3 of 4 | - | - | x0.994 | x1.000 | x1.005 |
| blake3-servil-st / solo / ManyMessages / 2048 | 7.641 | 7.616 | x0.997 | level | 2 of 4 | - | - | x0.994 | x1.000 | x1.034 |
| blake3-servil-st / solo / ManyMessages / 4096 | 7.468 | 7.445 | x0.997 | level | 3 of 4 | - | - | x0.995 | x1.000 | x1.093 |
| blake3-servil-st / solo / ManyMessages / 8192 | 7.072 | 7.034 | x0.995 | level | 2 of 4 | - | - | x0.993 | x1.000 | x1.036 |
| blake3-servil-st / solo / ManyMessages / 16384 | 6.766 | 6.735 | x0.995 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.990 |
| blake3-servil-st / solo / ManyMessages / 32768 | 6.778 | 6.764 | x0.998 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.046 |
| blake3-servil-st / solo / ManyMessages / 65536 | 6.935 | 6.900 | x0.995 | level | 3 of 4 | - | - | x0.994 | x1.000 | x1.016 |
| blake3-servil-st / solo / ManyMessages / 131072 | 7.233 | 7.191 | x0.994 | level | 4 of 4 | - | - | x0.995 | x1.000 | x1.012 |
| blake3-servil-st / solo / ManyMessages / 262144 | 7.674 | 7.654 | x0.997 | level | 4 of 4 | - | - | x0.997 | x1.000 | x1.005 |
| blake3-servil-st / solo / ManyLongMessages / 4 | 1673.560 | 1678.920 | x1.003 | level | 2 of 4 | - | - | x1.004 | x1.000 | x1.006 |
| blake3-servil-st / solo / ManyLongMessages / 16 | 1373.707 | 641.123 | x0.467 | faster | 4 of 4 | - | - | x0.476 | x0.576 | x1.272 |
| blake3-servil-st / solo / ManyLongMessages / 64 | 497.140 | 494.847 | x0.995 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.846 |
| blake3-servil-st / solo / ManyLongMessages / 256 | 448.111 | 444.872 | x0.993 | level | 3 of 4 | - | - | x0.995 | x0.999 | x0.827 |
| blake3-servil-st / solo / IdleOneMessage / 64 B | 3.480 | 3.454 | x0.993 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.799 |
| blake3-servil-st / solo / IdleOneMessage / 128 B | 2.435 | 2.453 | x1.007 | level | 2 of 4 | - | - | x0.998 | x0.999 | x0.406 |
| blake3-servil-st / solo / IdleOneMessage / 256 B | 1.934 | 1.946 | x1.006 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.897 |
| blake3-servil-st / solo / IdleOneMessage / 512 B | 1.669 | 1.666 | x0.998 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.495 |
| blake3-servil-st / solo / IdleOneMessage / 1 KiB | 1.558 | 1.524 | x0.978 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.290 |
| blake3-servil-st / solo / IdleOneMessage / 1536 B | 1.166 | 1.151 | x0.987 | level | 3 of 4 | - | - | x0.997 | x0.997 | x0.762 |
| blake3-servil-st / solo / IdleOneMessage / 2 KiB | 0.830 | 0.833 | x1.005 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.944 |
| blake3-servil-st / solo / IdleOneMessage / 2304 B | 0.940 | 0.929 | x0.989 | level | 4 of 4 | - | - | x0.995 | x1.000 | x0.664 |
| blake3-servil-st / solo / IdleOneMessage / 3 KiB | 0.595 | 0.601 | x1.010 | level | 1 of 4 | - | - | x0.999 | x1.000 | x0.895 |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 0.493 | 0.479 | x0.971 | level | 4 of 4 | - | - | x0.991 | x1.000 | x0.701 |
| blake3-servil-st / solo / IdleOneMessage / 4 KiB | 0.446 | 0.453 | x1.015 | level | 1 of 4 | - | - | x0.996 | x1.000 | x0.347 |
| blake3-servil-st / solo / IdleOneMessage / 4470 B | 0.540 | 0.550 | x1.019 | level | 2 of 4 | - | - | x0.999 | x1.000 | x2.129 |
| blake3-servil-st / solo / IdleOneMessage / 7935 B | 0.275 | 0.280 | x1.018 | level | 1 of 4 | - | - | x0.998 | x1.000 | x0.917 |
| blake3-servil-st / solo / IdleOneMessage / 8 KiB | 0.253 | 0.260 | x1.028 | level | 0 of 4 | - | - | x0.999 | x1.000 | x1.078 |
| blake3-servil-st / solo / IdleOneMessage / 16 KiB | 0.146 | 0.149 | x1.026 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.765 |
| blake3-servil-st / solo / IdleOneMessage / 32 KiB | 0.0998 | 0.100 | x1.007 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.549 |
| blake3-servil-st / solo / IdleOneMessage / 64 KiB | 0.0892 | 0.0931 | x1.044 | level | 0 of 4 | - | - | x0.992 | x1.000 | x0.485 |
| blake3-servil-st / solo / IdleOneMessage / 128 KiB | 0.0865 | 0.0888 | x1.026 | level | 1 of 4 | - | - | x0.999 | x1.000 | x0.875 |
| blake3-servil-st / solo / IdleOneMessage / 256 KiB | 0.0878 | 0.0871 | x0.991 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.061 |
| blake3-servil-st / solo / IdleOneMessage / 512 KiB | 0.0941 | 0.0966 | x1.026 | level | 0 of 4 | - | - | x1.001 | x1.000 | x0.956 |
| blake3-servil-st / solo / IdleOneMessage / 1 MiB | 0.0978 | 0.0981 | x1.003 | level | 1 of 4 | - | - | x1.010 | x1.000 | x0.984 |
| blake3-servil-st / solo / IdleOneMessage / 2 MiB | 0.0970 | 0.0994 | x1.025 | level | 0 of 4 | - | - | x1.008 | x1.000 | x1.056 |
| blake3-servil-st / solo / IdleOneMessage / 3 MiB | 0.0980 | 0.0998 | x1.019 | level | 1 of 4 | - | - | x1.010 | x1.000 | x1.097 |
| blake3-servil-st / solo / IdleOneMessage / 4 MiB | 0.0981 | 0.0965 | x0.984 | level | 3 of 4 | - | - | x1.009 | x1.000 | x1.102 |
| blake3-servil-st / solo / IdleOneMessage / 8 MiB | 0.0975 | 0.0953 | x0.977 | level | 3 of 4 | - | - | x1.013 | x1.000 | x1.068 |
| blake3-servil-st / solo / IdleOneMessage / 32 MiB | 0.125 | 0.124 | x0.997 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.021 |
| blake3-servil-st / solo / IdleOneMessage / 64 MiB | 0.129 | 0.129 | x0.997 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.011 |
| blake3-servil-st / solo / IdleOneMessage / 128 MiB | 0.130 | 0.130 | x0.998 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.010 |
| blake3-servil-st / solo / IdleManyMessages / 1 | 235.291 | 236.556 | x1.005 | level | 1 of 4 | - | - | x0.997 | x1.000 | x0.947 |
| blake3-servil-st / solo / IdleManyMessages / 2 | 120.498 | 120.331 | x0.999 | level | 3 of 4 | - | - | x0.995 | x0.995 | x0.334 |
| blake3-servil-st / solo / IdleManyMessages / 3 | 103.089 | 103.082 | x1.000 | level | 1 of 4 | - | - | x0.997 | x0.997 | x0.386 |
| blake3-servil-st / solo / IdleManyMessages / 4 | 61.508 | 60.717 | x0.987 | level | 3 of 4 | - | - | x0.999 | x0.995 | x1.423 |
| blake3-servil-st / solo / IdleManyMessages / 6 | 53.150 | 52.808 | x0.994 | level | 2 of 4 | - | - | x0.998 | x0.997 | x1.759 |
| blake3-servil-st / solo / IdleManyMessages / 8 | 33.270 | 31.984 | x0.961 | level | 4 of 4 | - | - | x0.995 | x0.997 | x0.250 |
| blake3-servil-st / solo / IdleManyMessages / 12 | 29.610 | 29.255 | x0.988 | level | 2 of 4 | - | - | x0.997 | x0.999 | x0.378 |
| blake3-servil-st / solo / IdleManyMessages / 16 | 17.372 | 17.102 | x0.984 | level | 3 of 4 | - | - | x0.998 | x0.999 | x2.447 |
| blake3-servil-st / solo / IdleManyMessages / 24 | 16.091 | 15.895 | x0.988 | level | 2 of 4 | - | - | x0.997 | x0.999 | x2.567 |
| blake3-servil-st / solo / IdleManyMessages / 32 | 12.279 | 12.122 | x0.987 | level | 3 of 4 | - | - | x0.997 | x0.999 | x2.362 |
| blake3-servil-st / solo / IdleManyMessages / 48 | 10.623 | 10.616 | x0.999 | level | 3 of 4 | - | - | x0.998 | x0.999 | x3.152 |
| blake3-servil-st / solo / IdleManyMessages / 64 | 10.108 | 9.791 | x0.969 | level | 4 of 4 | - | - | x0.990 | x0.999 | x0.403 |
| blake3-servil-st / solo / IdleManyMessages / 128 | 8.588 | 8.755 | x1.019 | level | 1 of 4 | - | - | x1.000 | x0.999 | x1.775 |
| blake3-servil-st / solo / IdleManyMessages / 256 | 8.088 | 8.174 | x1.011 | level | 1 of 4 | - | - | x0.995 | x0.999 | x1.209 |
| blake3-servil-st / solo / IdleManyMessages / 512 | 7.836 | 7.796 | x0.995 | level | 2 of 4 | - | - | x0.989 | x0.999 | x0.657 |
| blake3-servil-st / solo / IdleManyMessages / 1024 | 7.629 | 7.590 | x0.995 | level | 2 of 4 | - | - | x0.993 | x1.000 | x0.527 |
| blake3-servil-st / solo / IdleManyMessages / 2048 | 7.540 | 7.607 | x1.009 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.851 |
| blake3-servil-st / solo / IdleManyMessages / 4096 | 7.820 | 7.735 | x0.989 | level | 3 of 4 | - | - | x0.993 | x1.000 | x1.050 |
| blake3-servil-st / solo / IdleManyMessages / 8192 | 8.371 | 8.309 | x0.993 | level | 2 of 4 | - | - | x0.992 | x1.000 | x0.941 |
| blake3-servil-st / solo / IdleManyMessages / 16384 | 8.556 | 8.493 | x0.993 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.946 |
| blake3-servil-st / solo / IdleManyMessages / 32768 | 8.676 | 8.641 | x0.996 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.979 |
| blake3-servil-st / solo / IdleManyMessages / 65536 | 8.508 | 8.333 | x0.979 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.978 |
| blake3-servil-st / solo / IdleManyMessages / 131072 | 7.766 | 7.770 | x1.000 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.020 |
| blake3-servil-st / solo / IdleManyMessages / 262144 | 8.213 | 8.266 | x1.006 | level | 2 of 4 | - | - | x1.010 | x1.000 | x1.047 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 B | 2.410 | 2.415 | x1.002 | level | 3 of 4 | - | - | x1.007 | x1.000 | x0.876 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 B | 1.684 | 1.689 | x1.003 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.745 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 B | 1.353 | 1.354 | x1.001 | level | 2 of 4 | - | - | x1.000 | x0.999 | x0.504 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 B | 1.167 | 1.166 | x0.999 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.695 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 KiB | 1.080 | 1.077 | x0.997 | level | 4 of 4 | - | - | x0.999 | x1.000 | x1.151 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1536 B | 0.811 | 0.809 | x0.997 | level | 3 of 4 | - | - | x0.998 | x0.997 | x0.713 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 KiB | 0.586 | 0.583 | x0.995 | level | 4 of 4 | - | - | x0.996 | x1.000 | x0.699 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2304 B | 0.653 | 0.647 | x0.991 | level | 4 of 4 | - | - | x0.992 | x1.000 | x0.661 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.419 | 0.418 | x0.998 | level | 1 of 4 | - | - | x0.997 | x1.000 | x0.498 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3839 B | 0.341 | 0.340 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.741 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 KiB | 0.312 | 0.311 | x0.997 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.551 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4470 B | 0.384 | 0.383 | x0.997 | level | 3 of 4 | - | - | x0.998 | x1.000 | x2.180 |
| blake3-servil-st / solo / BriefIdleOneMessage / 7935 B | 0.193 | 0.192 | x0.993 | level | 4 of 4 | - | - | x0.994 | x1.000 | x0.849 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 KiB | 0.178 | 0.180 | x1.009 | level | 0 of 4 | - | - | x1.007 | x1.000 | x5.205 |
| blake3-servil-st / solo / BriefIdleOneMessage / 16 KiB | 0.100 | 0.100 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.213 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 KiB | 0.0707 | 0.0706 | x0.998 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.895 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 KiB | 0.0654 | 0.0655 | x1.002 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.862 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 KiB | 0.0630 | 0.0628 | x0.997 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.560 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 KiB | 0.0625 | 0.0619 | x0.992 | level | 3 of 4 | - | - | x0.993 | x1.000 | x1.250 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 KiB | 0.0673 | 0.0678 | x1.008 | level | 1 of 4 | - | - | x1.007 | x1.000 | x0.916 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 MiB | 0.0699 | 0.0705 | x1.010 | level | 1 of 4 | - | - | x1.010 | x1.000 | x0.994 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 MiB | 0.0705 | 0.0707 | x1.004 | level | 2 of 4 | - | - | x1.006 | x1.000 | x1.023 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 MiB | 0.0701 | 0.0702 | x1.002 | level | 2 of 4 | - | - | x1.005 | x1.000 | x1.071 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 MiB | 0.0698 | 0.0701 | x1.004 | level | 1 of 4 | - | - | x1.005 | x1.000 | x1.091 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 MiB | 0.0711 | 0.0718 | x1.010 | level | 1 of 4 | - | - | x1.012 | x1.000 | x1.089 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 MiB | 0.127 | 0.127 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.019 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 MiB | 0.131 | 0.130 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.009 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 MiB | 0.130 | 0.130 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.009 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1 | 164.962 | 163.741 | x0.993 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.806 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2 | 83.759 | 83.555 | x0.998 | level | 2 of 4 | - | - | x0.998 | x0.995 | x0.512 |
| blake3-servil-st / solo / BriefIdleManyMessages / 3 | 72.051 | 71.727 | x0.996 | level | 3 of 4 | - | - | x0.997 | x0.997 | x0.962 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4 | 42.267 | 42.041 | x0.995 | level | 2 of 4 | - | - | x0.998 | x0.996 | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 6 | 36.866 | 36.630 | x0.994 | level | 3 of 4 | - | - | x0.997 | x0.997 | x0.589 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8 | 22.581 | 22.586 | x1.000 | level | 2 of 4 | - | - | x1.000 | x0.997 | x0.781 |
| blake3-servil-st / solo / BriefIdleManyMessages / 12 | 20.495 | 20.407 | x0.996 | level | 4 of 4 | - | - | x0.998 | x0.998 | x1.222 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16 | 11.947 | 11.694 | x0.979 | level | 4 of 4 | - | - | x0.987 | x0.997 | x1.688 |
| blake3-servil-st / solo / BriefIdleManyMessages / 24 | 11.080 | 10.855 | x0.980 | level | 4 of 4 | - | - | x0.988 | x0.998 | x0.822 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32 | 8.501 | 8.322 | x0.979 | level | 4 of 4 | - | - | x0.986 | x0.998 | x1.324 |
| blake3-servil-st / solo / BriefIdleManyMessages / 48 | 7.385 | 7.344 | x0.994 | level | 3 of 4 | - | - | x0.990 | x0.999 | x0.849 |
| blake3-servil-st / solo / BriefIdleManyMessages / 64 | 6.790 | 6.716 | x0.989 | level | 2 of 4 | - | - | x0.990 | x0.999 | x0.899 |
| blake3-servil-st / solo / BriefIdleManyMessages / 128 | 5.960 | 5.917 | x0.993 | level | 4 of 4 | - | - | x0.993 | x0.999 | x0.742 |
| blake3-servil-st / solo / BriefIdleManyMessages / 256 | 5.649 | 5.631 | x0.997 | level | 3 of 4 | - | - | x0.996 | x0.999 | x0.615 |
| blake3-servil-st / solo / BriefIdleManyMessages / 512 | 5.457 | 5.425 | x0.994 | level | 4 of 4 | - | - | x0.994 | x0.999 | x0.592 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1024 | 5.374 | 5.351 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.406 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2048 | 5.350 | 5.343 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.897 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4096 | 5.471 | 5.455 | x0.997 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.049 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8192 | 5.881 | 5.851 | x0.995 | level | 3 of 4 | - | - | x0.993 | x1.000 | x0.946 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16384 | 6.052 | 6.015 | x0.994 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.940 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32768 | 6.126 | 6.068 | x0.990 | level | 3 of 4 | - | - | x0.990 | x1.000 | x0.971 |
| blake3-servil-st / solo / BriefIdleManyMessages / 65536 | 6.057 | 6.034 | x0.996 | level | 2 of 4 | - | - | x0.994 | x1.000 | x0.991 |
| blake3-servil-st / solo / BriefIdleManyMessages / 131072 | 6.106 | 6.080 | x0.996 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.003 |
| blake3-servil-st / solo / BriefIdleManyMessages / 262144 | 7.022 | 6.993 | x0.996 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.999 |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.747 | 0.746 | x0.999 | level | 4 of 4 | x0.999 | - | x0.999 | x1.000 | x0.994 |
| blake3-servil-st / solo / ContinuousMessages / 128 B | 0.857 | 0.857 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.573 |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 0.915 | 0.915 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.339 |
| blake3-servil-st / solo / ContinuousMessages / 512 B | 0.944 | 0.943 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x0.736 |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 0.962 | 0.962 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.057 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.284 | 0.284 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x0.881 |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.0910 | 0.0914 | x1.005 | level | 3 of 4 | x1.004 | - | x0.998 | x1.000 | x2.035 |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.0652 | 0.0651 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.897 |
| blake3-servil-st / solo / ContinuousMessages / 256 KiB | 0.0666 | 0.0667 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | x0.810 |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.0675 | 0.0675 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x1.047 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.0686 | 0.0685 | x0.998 | level | 3 of 4 | x0.998 | - | x0.997 | x1.000 | x0.956 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.0689 | 0.0687 | x0.998 | level | 2 of 4 | x0.998 | - | x0.997 | x1.000 | x1.033 |
| blake3-servil-st / solo / ContinuousMessages / 64 MiB | 0.0797 | 0.0796 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x0.990 |
| blake3-servil-st / solo / ContinuousBatches / 16 | 6.044 | 6.104 | x1.010 | level | 0 of 4 | x1.010 | - | x1.010 | x0.997 | x0.890 |
| blake3-servil-st / solo / ContinuousBatches / 64 | 5.307 | 5.320 | x1.002 | level | 2 of 4 | x1.002 | - | x1.003 | x0.999 | x0.948 |
| blake3-servil-st / solo / ContinuousBatches / 256 | 5.273 | 5.300 | x1.005 | level | 2 of 4 | x1.005 | - | x1.005 | x1.000 | x1.138 |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 5.621 | 5.627 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x2.367 |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 5.500 | 5.490 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x1.805 |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 6.137 | 6.125 | x0.998 | level | 2 of 4 | x0.998 | - | x0.998 | x1.000 | x0.942 |
| blake3-servil-st / solo / ContinuousBatches / 65536 | 6.179 | 6.183 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | x1.446 |
| blake3-servil-st / solo / LentMessages / 64 B | 0.747 | 0.746 | x0.999 | level | 4 of 4 | x0.999 | - | x0.999 | x1.000 | x0.994 |
| blake3-servil-st / solo / LentMessages / 128 B | 0.857 | 0.857 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.573 |
| blake3-servil-st / solo / LentMessages / 256 B | 0.915 | 0.915 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.339 |
| blake3-servil-st / solo / LentMessages / 512 B | 0.944 | 0.943 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x0.736 |
| blake3-servil-st / solo / LentMessages / 1 KiB | 0.962 | 0.962 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.057 |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.284 | 0.284 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x0.881 |
| blake3-servil-st / solo / LentMessages / 16 KiB | 0.0910 | 0.0914 | x1.005 | level | 3 of 4 | x1.004 | - | x0.998 | x1.000 | x2.035 |
| blake3-servil-st / solo / LentMessages / 64 KiB | 0.0652 | 0.0651 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.897 |
| blake3-servil-st / solo / LentMessages / 256 KiB | 0.0618 | 0.0614 | x0.994 | level | 4 of 4 | x0.994 | - | x0.993 | x1.000 | x0.708 |
| blake3-servil-st / solo / LentMessages / 1 MiB | 0.0691 | 0.0690 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x1.002 |
| blake3-servil-st / solo / LentMessages / 4 MiB | 0.0697 | 0.0697 | x1.000 | level | 2 of 4 | x1.000 | - | x0.999 | x1.000 | x1.052 |
| blake3-servil-st / solo / LentMessages / 16 MiB | 0.0757 | 0.0758 | x1.002 | level | 2 of 4 | x1.002 | - | x1.001 | x1.000 | x1.037 |
| blake3-servil-st / solo / LentMessages / 64 MiB | 0.131 | 0.132 | x1.005 | level | 2 of 4 | x1.005 | - | x1.005 | x1.000 | x1.023 |
| blake3-servil-st / solo / Interleaved / 256 | 0.110 | 0.109 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x1.000 | x1.002 |
| blake3-servil-st / solo / Collection / git objects | 0.0839 | 0.0847 | x1.009 | level | 1 of 4 | x1.009 | - | x1.009 | x0.999 | x1.036 |
| blake3-servil-st / solo / Collection / Nix files | 0.0737 | 0.0745 | x1.010 | level | 1 of 4 | x1.010 | - | x1.010 | x0.999 | x1.032 |
| blake3-servil-st / solo / LentBatches / 16 | 6.044 | 6.104 | x1.010 | level | 0 of 4 | x1.010 | - | x1.010 | x0.997 | x0.890 |
| blake3-servil-st / solo / LentBatches / 64 | 5.307 | 5.320 | x1.002 | level | 2 of 4 | x1.002 | - | x1.003 | x0.999 | x0.948 |
| blake3-servil-st / solo / LentBatches / 256 | 5.273 | 5.300 | x1.005 | level | 2 of 4 | x1.005 | - | x1.005 | x1.000 | x1.138 |
| blake3-servil-st / solo / LentBatches / 1024 | 5.621 | 5.627 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x2.367 |
| blake3-servil-st / solo / LentBatches / 4096 | 5.500 | 5.490 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x1.805 |
| blake3-servil-st / solo / LentBatches / 16384 | 6.137 | 6.125 | x0.998 | level | 2 of 4 | x0.998 | - | x0.998 | x1.000 | x0.942 |
| blake3-servil-st / solo / LentBatches / 65536 | 6.179 | 6.183 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | x1.446 |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.110 | 0.110 | x0.999 | level | 2 of 4 | x0.999 | - | x0.998 | x1.000 | x0.988 |
| blake3-servil-st / solo / ContinuousCollection / Nix files | 0.117 | 0.118 | x1.005 | level | 0 of 4 | x1.005 | - | x1.005 | x1.000 | x1.045 |
| blake3-servil-st / solo / MerkleTree / 1024 | 0.0998 | 0.0996 | x0.998 | level | 1 of 4 | x0.999 | - | x0.998 | x1.001 | x0.691 |
| blake3-servil-st / solo / MerkleTree / 4096 | 0.107 | 0.107 | x1.002 | level | 0 of 4 | x1.002 | - | x1.002 | x1.001 | x0.958 |
| blake3-servil-st / solo / MerkleTree / 16384 | 0.107 | 0.107 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.001 | x0.946 |
| blake3-servil-st / solo / MerkleTree / 65536 | 0.119 | 0.120 | x1.004 | level | 1 of 4 | x1.004 | - | x1.004 | x1.001 | x1.002 |
| blake3-servil-st / solo / MerkleTree / 262144 | 0.160 | 0.160 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.001 | x0.997 |
| blake3-servil-st / solo / MerkleTree / 65536 x 32 B | 0.308 | 0.307 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x1.077 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 32 B | 0.390 | 0.389 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x1.000 | x0.999 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 16 B | 0.701 | 0.697 | x0.995 | level | 3 of 4 | x0.995 | - | x0.995 | x1.000 | x0.954 |
| blake3-servil-st / solo / MerkleTree / 65536 x 48 B | 0.215 | 0.215 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.991 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 48 B | 0.287 | 0.286 | x0.998 | level | 3 of 4 | x0.998 | - | x0.997 | x1.000 | x1.000 |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.245 | 0.241 | x0.982 | level | 3 of 4 | - | - | x0.983 | x1.000 | x0.934 |
| blake3-servil-st / solo / InterleavedTurn / 1024 x 1 KiB | 0.208 | 0.207 | x0.998 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.030 |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.274 | 0.276 | x1.008 | level | 2 of 4 | - | - | x1.003 | x0.998 | x0.970 |
| blake3-servil-st / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.228 | 0.231 | x1.016 | level | 0 of 4 | - | - | x0.982 | x1.000 | x1.024 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.199 | 0.197 | x0.992 | level | 2 of 4 | - | - | x0.995 | x1.006 | x0.996 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.169 | 0.168 | x0.991 | level | 3 of 4 | - | - | x0.991 | x1.000 | x1.042 |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.0837 | 0.0833 | x0.995 | level | 4 of 4 | x0.996 | - | x0.996 | x1.000 | x1.044 |
| blake3-servil-st / solo / ReceivingMessage / 2 μs | 0.0923 | 0.0922 | x0.999 | level | 2 of 4 | x0.997 | - | x0.997 | x1.000 | x1.000 |
| blake3-servil-st / solo / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 3 of 4 | x0.994 | - | x0.992 | x1.000 | x0.995 |
| blake3-servil-st / solo / IncrementalMessage / 64 B | 7.502 | 6.777 | x0.903 | level | 3 of 4 | - | - | x0.942 | x1.000 | x0.995 |
| blake3-servil-st / solo / IncrementalMessage / 1 KiB | 1.769 | 1.655 | x0.936 | level | 3 of 4 | - | - | x0.947 | x1.001 | x0.986 |
| blake3-servil-st / solo / IncrementalMessage / 4 KiB | 0.551 | 0.543 | x0.986 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.968 |
| blake3-servil-st / solo / LentIncrementalMessage / 64 B | 0.806 | 0.806 | x1.000 | level | 0 of 4 | x1.000 | - | x1.000 | x1.000 | x0.693 |
| blake3-servil-st / solo / LentIncrementalMessage / 1 KiB | 0.988 | 0.988 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x0.673 |
| blake3-servil-st / solo / LentIncrementalMessage / 4 KiB | 0.290 | 0.290 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x1.044 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 0.756 | 0.756 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x0.747 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 4 KiB | 0.285 | 0.285 | x1.000 | level | 2 of 4 | x1.000 | - | x1.001 | x1.000 | x0.561 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 1 MiB | 0.0676 | 0.0674 | x0.998 | level | 2 of 4 | x0.998 | - | x0.998 | x1.000 | x1.060 |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 0.721 | 0.723 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.000 | x0.610 |
| blake3-servil-st / solo / ContinuousLentMessages / 4 KiB | 0.281 | 0.281 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x1.149 |
| blake3-servil-st / solo / ContinuousLentMessages / 1 MiB | 0.0560 | 0.0561 | x1.002 | level | 3 of 4 | x1.002 | - | x1.002 | x1.000 | x0.949 |
| blake3-servil-mt / solo / OneMessage / 64 B | 7.247 | 7.252 | x1.001 | level | 1 of 4 | - | - | x1.013 | x1.001 | x1.060 |
| blake3-servil-mt / solo / OneMessage / 128 B | 4.111 | 4.346 | x1.057 | level | 1 of 4 | - | - | x1.044 | x1.003 | x1.048 |
| blake3-servil-mt / solo / OneMessage / 256 B | 2.791 | 2.747 | x0.984 | level | 2 of 4 | - | - | x1.009 | x1.004 | x1.026 |
| blake3-servil-mt / solo / OneMessage / 512 B | 1.931 | 1.916 | x0.992 | level | 1 of 4 | - | - | x1.024 | x1.005 | x1.057 |
| blake3-servil-mt / solo / OneMessage / 1 KiB | 1.503 | 1.498 | x0.997 | level | 2 of 4 | - | - | x1.004 | x1.001 | x1.055 |
| blake3-servil-mt / solo / OneMessage / 1536 B | 1.360 | 1.344 | x0.989 | level | 1 of 4 | - | - | x1.002 | x0.998 | x0.975 |
| blake3-servil-mt / solo / OneMessage / 2 KiB | 0.839 | 0.877 | x1.046 | level | 1 of 4 | - | - | x1.048 | x1.000 | x1.005 |
| blake3-servil-mt / solo / OneMessage / 2304 B | 1.011 | 1.058 | x1.046 | level | 0 of 4 | - | - | x1.035 | x1.000 | x0.988 |
| blake3-servil-mt / solo / OneMessage / 3 KiB | 0.724 | 0.731 | x1.009 | level | 1 of 4 | - | - | x1.032 | x1.000 | x0.990 |
| blake3-servil-mt / solo / OneMessage / 3839 B | 0.765 | 0.770 | x1.007 | level | 2 of 4 | - | - | x1.016 | x1.000 | x0.986 |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 0.470 | 0.490 | x1.041 | level | 1 of 4 | - | - | x1.045 | x1.001 | x0.982 |
| blake3-servil-mt / solo / OneMessage / 4470 B | 0.586 | 0.605 | x1.033 | level | 1 of 4 | - | - | x1.037 | x1.000 | x0.987 |
| blake3-servil-mt / solo / OneMessage / 7935 B | 0.595 | 0.584 | x0.982 | level | 2 of 4 | - | - | x0.988 | x1.000 | x1.001 |
| blake3-servil-mt / solo / OneMessage / 8 KiB | 0.354 | 0.364 | x1.029 | level | 1 of 4 | - | - | x1.040 | x1.000 | x1.014 |
| blake3-servil-mt / solo / OneMessage / 16 KiB | 0.218 | 0.224 | x1.027 | level | 1 of 4 | - | - | x1.027 | x1.000 | x1.018 |
| blake3-servil-mt / solo / OneMessage / 32 KiB | 0.194 | 0.186 | x0.957 | level | 4 of 4 | - | - | x0.965 | x0.999 | x1.026 |
| blake3-servil-mt / solo / OneMessage / 64 KiB | 0.142 | 0.140 | x0.991 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.012 |
| blake3-servil-mt / solo / OneMessage / 128 KiB | 0.114 | 0.113 | x0.994 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.112 |
| blake3-servil-mt / solo / OneMessage / 256 KiB | 0.102 | 0.100 | x0.985 | level | 4 of 4 | - | - | x0.985 | x1.000 | x1.175 |
| blake3-servil-mt / solo / OneMessage / 512 KiB | 0.0603 | 0.0608 | x1.009 | level | 2 of 4 | - | - | x1.005 | x0.946 | x1.001 |
| blake3-servil-mt / solo / OneMessage / 1 MiB | 0.0493 | 0.0486 | x0.986 | level | 3 of 4 | - | - | x0.985 | x0.994 | x0.997 |
| blake3-servil-mt / solo / OneMessage / 2 MiB | 0.0436 | 0.0431 | x0.988 | level | 3 of 4 | - | - | x0.989 | x1.002 | x0.990 |
| blake3-servil-mt / solo / OneMessage / 3 MiB | 0.0413 | 0.0413 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.006 | x0.999 |
| blake3-servil-mt / solo / OneMessage / 4 MiB | 0.0393 | 0.0392 | x0.998 | level | 1 of 4 | - | - | x0.999 | x1.022 | x0.984 |
| blake3-servil-mt / solo / OneMessage / 8 MiB | 0.0383 | 0.0383 | x0.999 | level | 1 of 4 | - | - | x1.000 | x1.019 | x1.004 |
| blake3-servil-mt / solo / OneMessage / 32 MiB | 0.0748 | 0.0749 | x1.001 | level | 3 of 4 | - | - | x1.000 | x1.002 | x1.000 |
| blake3-servil-mt / solo / OneMessage / 64 MiB | 0.0749 | 0.0747 | x0.998 | level | 3 of 4 | - | - | x0.997 | x0.995 | x0.998 |
| blake3-servil-mt / solo / OneMessage / 128 MiB | 0.0742 | 0.0741 | x0.998 | level | 3 of 4 | - | - | x0.999 | x0.997 | x0.999 |
| blake3-servil-mt / solo / ManyMessages / 1 | 656.726 | 668.736 | x1.018 | level | 2 of 4 | - | - | x0.996 | x1.006 | x0.954 |
| blake3-servil-mt / solo / ManyMessages / 2 | 312.645 | 292.409 | x0.935 | level | 3 of 4 | - | - | x0.958 | x1.003 | x0.917 |
| blake3-servil-mt / solo / ManyMessages / 3 | 233.416 | 240.302 | x1.030 | level | 1 of 4 | - | - | x1.011 | x0.996 | x0.905 |
| blake3-servil-mt / solo / ManyMessages / 4 | 160.923 | 148.719 | x0.924 | level | 3 of 4 | - | - | x0.955 | x0.990 | x0.906 |
| blake3-servil-mt / solo / ManyMessages / 6 | 113.292 | 111.034 | x0.980 | level | 2 of 4 | - | - | x0.982 | x0.992 | x0.900 |
| blake3-servil-mt / solo / ManyMessages / 8 | 110.914 | 108.788 | x0.981 | level | 3 of 4 | - | - | x0.960 | x0.999 | x0.947 |
| blake3-servil-mt / solo / ManyMessages / 12 | 86.142 | 83.180 | x0.966 | level | 3 of 4 | - | - | x0.976 | x1.007 | x0.945 |
| blake3-servil-mt / solo / ManyMessages / 16 | 62.041 | 60.092 | x0.969 | level | 2 of 4 | - | - | x0.981 | x0.997 | x0.967 |
| blake3-servil-mt / solo / ManyMessages / 24 | 52.417 | 49.321 | x0.941 | level | 3 of 4 | - | - | x0.942 | x1.001 | x0.972 |
| blake3-servil-mt / solo / ManyMessages / 32 | 34.535 | 33.485 | x0.970 | level | 2 of 4 | - | - | x0.967 | x1.002 | x0.974 |
| blake3-servil-mt / solo / ManyMessages / 48 | 24.995 | 23.743 | x0.950 | level | 3 of 4 | - | - | x0.967 | x0.999 | x0.973 |
| blake3-servil-mt / solo / ManyMessages / 64 | 19.991 | 19.981 | x1.000 | level | 2 of 4 | - | - | x0.994 | x1.000 | x0.979 |
| blake3-servil-mt / solo / ManyMessages / 128 | 14.053 | 13.517 | x0.962 | level | 3 of 4 | - | - | x0.970 | x1.000 | x1.002 |
| blake3-servil-mt / solo / ManyMessages / 256 | 10.697 | 10.355 | x0.968 | level | 4 of 4 | - | - | x0.965 | x1.000 | x1.016 |
| blake3-servil-mt / solo / ManyMessages / 512 | 9.059 | 8.781 | x0.969 | level | 4 of 4 | - | - | x0.970 | x0.999 | x0.988 |
| blake3-servil-mt / solo / ManyMessages / 1024 | 8.147 | 8.082 | x0.992 | level | 3 of 4 | - | - | x0.988 | x1.000 | x1.010 |
| blake3-servil-mt / solo / ManyMessages / 2048 | 7.664 | 7.609 | x0.993 | level | 2 of 4 | - | - | x0.986 | x1.000 | x1.011 |
| blake3-servil-mt / solo / ManyMessages / 4096 | 7.469 | 7.427 | x0.994 | level | 2 of 4 | - | - | x0.994 | x1.000 | x1.090 |
| blake3-servil-mt / solo / ManyMessages / 8192 | 3.329 | 3.338 | x1.003 | level | 2 of 4 | - | - | x1.003 | x1.005 | x0.982 |
| blake3-servil-mt / solo / ManyMessages / 16384 | 2.802 | 2.763 | x0.986 | level | 3 of 4 | - | - | x0.984 | x0.989 | x0.997 |
| blake3-servil-mt / solo / ManyMessages / 32768 | 2.632 | 2.628 | x0.998 | level | 2 of 4 | - | - | x0.997 | x0.995 | x1.020 |
| blake3-servil-mt / solo / ManyMessages / 65536 | 2.426 | 2.413 | x0.995 | level | 2 of 4 | - | - | x0.994 | x0.996 | x1.016 |
| blake3-servil-mt / solo / ManyMessages / 131072 | 2.460 | 2.453 | x0.997 | level | 2 of 4 | - | - | x0.996 | x1.012 | x1.026 |
| blake3-servil-mt / solo / ManyMessages / 262144 | 2.906 | 2.893 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.008 | x1.019 |
| blake3-servil-mt / solo / ManyLongMessages / 4 | 1702.494 | 1699.466 | x0.998 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.992 |
| blake3-servil-mt / solo / ManyLongMessages / 16 | 1381.039 | 646.752 | x0.468 | faster | 4 of 4 | - | - | x0.472 | x0.577 | x1.247 |
| blake3-servil-mt / solo / ManyLongMessages / 64 | 497.398 | 498.006 | x1.001 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.877 |
| blake3-servil-mt / solo / ManyLongMessages / 256 | 242.651 | 240.267 | x0.990 | level | 2 of 4 | - | - | x0.989 | x1.007 | x0.939 |
| blake3-servil-mt / solo / IdleOneMessage / 64 B | 3.492 | 3.444 | x0.986 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.789 |
| blake3-servil-mt / solo / IdleOneMessage / 128 B | 2.443 | 2.415 | x0.988 | level | 3 of 4 | - | - | x0.996 | x0.999 | x0.621 |
| blake3-servil-mt / solo / IdleOneMessage / 256 B | 1.952 | 1.947 | x0.997 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.209 |
| blake3-servil-mt / solo / IdleOneMessage / 512 B | 1.672 | 1.660 | x0.993 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.924 |
| blake3-servil-mt / solo / IdleOneMessage / 1 KiB | 1.544 | 1.530 | x0.991 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.561 |
| blake3-servil-mt / solo / IdleOneMessage / 1536 B | 1.161 | 1.144 | x0.985 | level | 3 of 4 | - | - | x0.991 | x0.997 | x0.441 |
| blake3-servil-mt / solo / IdleOneMessage / 2 KiB | 0.841 | 0.846 | x1.006 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.594 |
| blake3-servil-mt / solo / IdleOneMessage / 2304 B | 0.943 | 0.931 | x0.987 | level | 3 of 4 | - | - | x0.991 | x1.000 | x0.690 |
| blake3-servil-mt / solo / IdleOneMessage / 3 KiB | 0.596 | 0.596 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.569 |
| blake3-servil-mt / solo / IdleOneMessage / 3839 B | 0.478 | 0.480 | x1.004 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.466 |
| blake3-servil-mt / solo / IdleOneMessage / 4 KiB | 0.437 | 0.443 | x1.014 | level | 1 of 4 | - | - | x0.998 | x1.000 | x0.367 |
| blake3-servil-mt / solo / IdleOneMessage / 4470 B | 0.559 | 0.541 | x0.968 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.087 |
| blake3-servil-mt / solo / IdleOneMessage / 7935 B | 0.281 | 0.277 | x0.985 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.847 |
| blake3-servil-mt / solo / IdleOneMessage / 8 KiB | 0.261 | 0.255 | x0.976 | level | 3 of 4 | - | - | x0.979 | x1.000 | x0.359 |
| blake3-servil-mt / solo / IdleOneMessage / 16 KiB | 0.143 | 0.146 | x1.018 | level | 1 of 4 | - | - | x1.007 | x0.999 | x3.379 |
| blake3-servil-mt / solo / IdleOneMessage / 32 KiB | 0.102 | 0.0986 | x0.964 | level | 4 of 4 | - | - | x0.995 | x1.000 | x0.937 |
| blake3-servil-mt / solo / IdleOneMessage / 64 KiB | 0.0931 | 0.0906 | x0.974 | level | 4 of 4 | - | - | x1.004 | x1.000 | x1.187 |
| blake3-servil-mt / solo / IdleOneMessage / 128 KiB | 0.0883 | 0.0878 | x0.994 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.390 |
| blake3-servil-mt / solo / IdleOneMessage / 256 KiB | 0.0880 | 0.0859 | x0.976 | level | 4 of 4 | - | - | x1.002 | x1.000 | x1.160 |
| blake3-servil-mt / solo / IdleOneMessage / 512 KiB | 0.0595 | 0.0605 | x1.017 | level | 2 of 4 | - | - | x1.021 | x1.001 | x0.960 |
| blake3-servil-mt / solo / IdleOneMessage / 1 MiB | 0.0519 | 0.0522 | x1.006 | level | 1 of 4 | - | - | x0.994 | x0.983 | x0.984 |
| blake3-servil-mt / solo / IdleOneMessage / 2 MiB | 0.0464 | 0.0467 | x1.007 | level | 2 of 4 | - | - | x1.006 | x1.007 | x0.998 |
| blake3-servil-mt / solo / IdleOneMessage / 3 MiB | 0.0439 | 0.0447 | x1.018 | level | 0 of 4 | - | - | x1.008 | x1.000 | x1.011 |
| blake3-servil-mt / solo / IdleOneMessage / 4 MiB | 0.0419 | 0.0422 | x1.006 | level | 1 of 4 | - | - | x1.002 | x0.997 | x1.016 |
| blake3-servil-mt / solo / IdleOneMessage / 8 MiB | 0.0387 | 0.0393 | x1.015 | level | 0 of 4 | - | - | x1.007 | x0.989 | x1.031 |
| blake3-servil-mt / solo / IdleOneMessage / 32 MiB | 0.0695 | 0.0697 | x1.003 | level | 2 of 4 | - | - | x1.006 | x0.998 | x0.999 |
| blake3-servil-mt / solo / IdleOneMessage / 64 MiB | 0.0737 | 0.0737 | x0.999 | level | 1 of 4 | - | - | x1.004 | x0.994 | x0.998 |
| blake3-servil-mt / solo / IdleOneMessage / 128 MiB | 0.0738 | 0.0738 | x0.999 | level | 3 of 4 | - | - | x0.998 | x0.998 | x0.999 |
| blake3-servil-mt / solo / IdleManyMessages / 1 | 235.184 | 233.775 | x0.994 | level | 2 of 4 | - | - | x0.995 | x1.000 | x0.892 |
| blake3-servil-mt / solo / IdleManyMessages / 2 | 120.827 | 119.602 | x0.990 | level | 2 of 4 | - | - | x0.995 | x0.995 | x0.800 |
| blake3-servil-mt / solo / IdleManyMessages / 3 | 103.834 | 104.065 | x1.002 | level | 2 of 4 | - | - | x0.998 | x0.997 | x1.225 |
| blake3-servil-mt / solo / IdleManyMessages / 4 | 62.307 | 61.530 | x0.988 | level | 3 of 4 | - | - | x0.994 | x0.995 | x0.239 |
| blake3-servil-mt / solo / IdleManyMessages / 6 | 53.514 | 52.973 | x0.990 | level | 3 of 4 | - | - | x0.996 | x0.997 | x0.566 |
| blake3-servil-mt / solo / IdleManyMessages / 8 | 32.866 | 32.504 | x0.989 | level | 3 of 4 | - | - | x0.998 | x0.997 | x1.980 |
| blake3-servil-mt / solo / IdleManyMessages / 12 | 30.019 | 29.942 | x0.997 | level | 3 of 4 | - | - | x1.001 | x0.999 | x1.992 |
| blake3-servil-mt / solo / IdleManyMessages / 16 | 17.415 | 17.037 | x0.978 | level | 2 of 4 | - | - | x0.987 | x0.999 | x0.557 |
| blake3-servil-mt / solo / IdleManyMessages / 24 | 16.301 | 15.714 | x0.964 | level | 4 of 4 | - | - | x0.987 | x0.999 | x0.239 |
| blake3-servil-mt / solo / IdleManyMessages / 32 | 12.385 | 12.121 | x0.979 | level | 3 of 4 | - | - | x0.996 | x0.999 | x2.758 |
| blake3-servil-mt / solo / IdleManyMessages / 48 | 10.844 | 10.569 | x0.975 | level | 3 of 4 | - | - | x0.994 | x0.999 | x1.307 |
| blake3-servil-mt / solo / IdleManyMessages / 64 | 9.956 | 9.846 | x0.989 | level | 3 of 4 | - | - | x0.999 | x0.999 | x1.883 |
| blake3-servil-mt / solo / IdleManyMessages / 128 | 8.784 | 8.793 | x1.001 | level | 2 of 4 | - | - | x0.997 | x0.999 | x1.555 |
| blake3-servil-mt / solo / IdleManyMessages / 256 | 8.144 | 8.024 | x0.985 | level | 3 of 4 | - | - | x0.995 | x0.999 | x0.867 |
| blake3-servil-mt / solo / IdleManyMessages / 512 | 7.733 | 7.689 | x0.994 | level | 2 of 4 | - | - | x0.988 | x0.999 | x0.350 |
| blake3-servil-mt / solo / IdleManyMessages / 1024 | 7.496 | 7.496 | x1.000 | level | 2 of 4 | - | - | x0.993 | x1.000 | x0.554 |
| blake3-servil-mt / solo / IdleManyMessages / 2048 | 7.489 | 7.640 | x1.020 | level | 1 of 4 | - | - | x0.996 | x1.000 | x0.880 |
| blake3-servil-mt / solo / IdleManyMessages / 4096 | 7.847 | 7.761 | x0.989 | level | 2 of 4 | - | - | x0.995 | x1.000 | x1.044 |
| blake3-servil-mt / solo / IdleManyMessages / 8192 | 3.349 | 3.342 | x0.998 | level | 2 of 4 | - | - | x1.000 | x0.988 | x0.994 |
| blake3-servil-mt / solo / IdleManyMessages / 16384 | 2.998 | 3.012 | x1.005 | level | 1 of 4 | - | - | x1.012 | x1.003 | x1.000 |
| blake3-servil-mt / solo / IdleManyMessages / 32768 | 3.009 | 3.014 | x1.002 | level | 1 of 4 | - | - | x0.994 | x0.992 | x1.005 |
| blake3-servil-mt / solo / IdleManyMessages / 65536 | 2.556 | 2.576 | x1.008 | level | 2 of 4 | - | - | x1.010 | x1.006 | x1.027 |
| blake3-servil-mt / solo / IdleManyMessages / 131072 | 2.448 | 2.482 | x1.014 | level | 1 of 4 | - | - | x1.005 | x0.993 | x1.037 |
| blake3-servil-mt / solo / IdleManyMessages / 262144 | 3.254 | 3.414 | x1.049 | level | 1 of 4 | - | - | x1.088 | x1.003 | x1.024 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 B | 2.429 | 2.415 | x0.994 | level | 3 of 4 | - | - | x1.000 | x0.999 | x0.825 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 B | 1.699 | 1.688 | x0.994 | level | 4 of 4 | - | - | x0.998 | x0.999 | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 B | 1.359 | 1.356 | x0.997 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.926 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 B | 1.168 | 1.167 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.031 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 KiB | 1.082 | 1.079 | x0.997 | level | 4 of 4 | - | - | x0.999 | x1.000 | x1.145 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1536 B | 0.812 | 0.808 | x0.996 | level | 4 of 4 | - | - | x0.997 | x0.997 | x0.845 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 KiB | 0.587 | 0.585 | x0.996 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.382 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2304 B | 0.656 | 0.666 | x1.015 | level | 3 of 4 | - | - | x0.993 | x1.000 | x1.253 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 KiB | 0.420 | 0.418 | x0.995 | level | 4 of 4 | - | - | x0.997 | x1.000 | x0.300 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3839 B | 0.342 | 0.340 | x0.995 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.745 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 KiB | 0.312 | 0.312 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.599 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4470 B | 0.384 | 0.383 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.197 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 7935 B | 0.194 | 0.192 | x0.991 | level | 4 of 4 | - | - | x0.993 | x1.000 | x0.738 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 KiB | 0.179 | 0.180 | x1.004 | level | 2 of 4 | - | - | x1.005 | x1.000 | x0.764 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 16 KiB | 0.100 | 0.100 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.477 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 KiB | 0.0708 | 0.0705 | x0.995 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.870 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 KiB | 0.0655 | 0.0656 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.212 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 KiB | 0.0630 | 0.0629 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.731 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 KiB | 0.0622 | 0.0621 | x0.999 | level | 2 of 4 | - | - | x0.995 | x1.000 | x1.337 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 KiB | 0.0487 | 0.0489 | x1.002 | level | 2 of 4 | - | - | x1.006 | x0.993 | x0.944 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 MiB | 0.0444 | 0.0440 | x0.992 | level | 3 of 4 | - | - | x0.990 | x0.976 | x0.990 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 MiB | 0.0368 | 0.0366 | x0.995 | level | 2 of 4 | - | - | x0.992 | x0.984 | x0.995 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 MiB | 0.0326 | 0.0326 | x0.999 | level | 3 of 4 | - | - | x1.001 | x1.010 | x0.999 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 MiB | 0.0310 | 0.0311 | x1.001 | level | 2 of 4 | - | - | x1.000 | x0.998 | x1.005 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 MiB | 0.0292 | 0.0298 | x1.019 | level | 0 of 4 | - | - | x1.020 | x0.999 | x1.033 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 MiB | 0.0698 | 0.0701 | x1.004 | level | 2 of 4 | - | - | x1.004 | x0.997 | x0.998 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 MiB | 0.0744 | 0.0743 | x0.999 | level | 2 of 4 | - | - | x0.999 | x0.994 | x0.998 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 MiB | 0.0742 | 0.0741 | x0.999 | level | 2 of 4 | - | - | x0.999 | x0.999 | x0.999 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1 | 165.258 | 164.353 | x0.995 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.953 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2 | 83.839 | 83.319 | x0.994 | level | 3 of 4 | - | - | x0.996 | x0.995 | x0.709 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 3 | 72.627 | 72.061 | x0.992 | level | 4 of 4 | - | - | x0.998 | x0.996 | x0.766 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4 | 42.477 | 42.328 | x0.997 | level | 3 of 4 | - | - | x0.999 | x0.996 | x0.232 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 6 | 36.968 | 36.863 | x0.997 | level | 3 of 4 | - | - | x0.998 | x0.997 | x1.004 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8 | 22.676 | 22.548 | x0.994 | level | 4 of 4 | - | - | x0.999 | x0.997 | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 12 | 20.462 | 20.463 | x1.000 | level | 2 of 4 | - | - | x0.999 | x0.998 | x1.079 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16 | 12.101 | 11.725 | x0.969 | level | 4 of 4 | - | - | x0.983 | x0.997 | x1.628 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 24 | 11.131 | 10.920 | x0.981 | level | 3 of 4 | - | - | x0.987 | x0.998 | x0.375 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32 | 8.536 | 8.354 | x0.979 | level | 4 of 4 | - | - | x0.985 | x0.998 | x0.902 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 48 | 7.410 | 7.283 | x0.983 | level | 4 of 4 | - | - | x0.988 | x0.999 | x0.814 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 64 | 6.799 | 6.711 | x0.987 | level | 3 of 4 | - | - | x0.989 | x0.999 | x0.892 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 128 | 6.000 | 5.926 | x0.988 | level | 4 of 4 | - | - | x0.989 | x0.999 | x0.807 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 256 | 5.651 | 5.633 | x0.997 | level | 3 of 4 | - | - | x0.996 | x0.999 | x0.745 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 512 | 5.463 | 5.429 | x0.994 | level | 4 of 4 | - | - | x0.994 | x0.999 | x0.578 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1024 | 5.370 | 5.344 | x0.995 | level | 4 of 4 | - | - | x0.995 | x1.000 | x0.397 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2048 | 5.342 | 5.323 | x0.996 | level | 4 of 4 | - | - | x0.995 | x1.000 | x0.872 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4096 | 5.416 | 5.415 | x1.000 | level | 1 of 4 | - | - | x0.996 | x1.000 | x1.013 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8192 | 2.792 | 2.785 | x0.998 | level | 2 of 4 | - | - | x1.001 | x1.003 | x0.993 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16384 | 2.438 | 2.409 | x0.988 | level | 3 of 4 | - | - | x0.988 | x0.986 | x0.991 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32768 | 2.241 | 2.222 | x0.991 | level | 4 of 4 | - | - | x0.993 | x1.003 | x0.987 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 65536 | 1.860 | 1.865 | x1.003 | level | 1 of 4 | - | - | x1.004 | x0.998 | x1.009 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 131072 | 1.829 | 1.815 | x0.992 | level | 2 of 4 | - | - | x0.992 | x0.990 | x1.022 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 262144 | 2.316 | 2.324 | x1.004 | level | 2 of 4 | - | - | x1.003 | x1.006 | x1.021 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.364 | 0.357 | x0.981 | level | 3 of 4 | x1.012 | - | x0.980 | x0.972 | x1.066 |
| blake3-servil-mt / solo / ContinuousMessages / 128 B | 0.182 | 0.182 | x1.001 | level | 2 of 4 | x1.004 | - | x1.001 | x0.972 | x0.927 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.0971 | 0.0949 | x0.978 | level | 3 of 4 | x0.969 | - | x0.978 | x0.973 | x1.032 |
| blake3-servil-mt / solo / ContinuousMessages / 512 B | 0.0510 | 0.0522 | x1.024 | level | 1 of 4 | x1.016 | - | x1.024 | x0.973 | x0.957 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.0405 | 0.0399 | x0.983 | level | 4 of 4 | x1.063 | - | x0.973 | x0.980 | x0.988 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0357 | 0.0342 | x0.958 | level | 3 of 4 | x1.026 | - | x0.945 | x0.978 | x0.997 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0300 | 0.0298 | x0.994 | level | 3 of 4 | x0.989 | - | x0.988 | x0.982 | x0.988 |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.0270 | 0.0269 | x0.997 | level | 1 of 4 | x0.990 | - | x0.995 | x1.009 | x0.989 |
| blake3-servil-mt / solo / ContinuousMessages / 256 KiB | 0.0269 | 0.0272 | x1.013 | level | 1 of 4 | x1.024 | - | x1.012 | x1.004 | x0.986 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0244 | 0.0244 | x0.999 | level | 2 of 4 | x1.025 | - | x0.999 | x1.003 | x0.999 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.0251 | 0.0251 | x1.002 | level | 1 of 4 | x1.076 | - | x0.999 | x1.003 | x0.996 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0257 | 0.0256 | x0.997 | level | 3 of 4 | x1.012 | - | x0.996 | x1.003 | x1.011 |
| blake3-servil-mt / solo / ContinuousMessages / 64 MiB | 0.0313 | 0.0313 | x0.997 | level | 3 of 4 | x1.019 | - | x0.995 | x1.003 | x0.995 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 2.901 | 2.837 | x0.978 | level | 4 of 4 | x1.063 | - | x0.974 | x0.971 | x1.005 |
| blake3-servil-mt / solo / ContinuousBatches / 64 | 1.886 | 1.865 | x0.989 | level | 3 of 4 | x1.005 | - | x0.985 | x0.981 | x1.000 |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 2.113 | 2.173 | x1.028 | level | 1 of 4 | x1.030 | - | x1.027 | x0.988 | x1.027 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 1.855 | 1.878 | x1.012 | level | 1 of 4 | x1.039 | - | x1.013 | x1.004 | x1.022 |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 2.036 | 2.068 | x1.016 | level | 1 of 4 | x1.006 | - | x1.000 | x1.001 | x0.962 |
| blake3-servil-mt / solo / ContinuousBatches / 16384 | 2.144 | 2.071 | x0.966 | level | 3 of 4 | x0.984 | - | x0.998 | x1.000 | x1.016 |
| blake3-servil-mt / solo / ContinuousBatches / 65536 | 1.774 | 1.752 | x0.988 | level | 3 of 4 | x0.991 | - | x0.999 | x1.003 | x0.998 |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.746 | 0.747 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x1.037 |
| blake3-servil-mt / solo / LentMessages / 128 B | 0.856 | 0.856 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x0.839 |
| blake3-servil-mt / solo / LentMessages / 256 B | 0.914 | 0.914 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x0.981 |
| blake3-servil-mt / solo / LentMessages / 512 B | 0.945 | 0.945 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.316 |
| blake3-servil-mt / solo / LentMessages / 1 KiB | 0.962 | 0.962 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x1.718 |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.285 | 0.285 | x1.001 | level | 3 of 4 | x1.001 | - | x1.001 | x1.000 | x0.589 |
| blake3-servil-mt / solo / LentMessages / 16 KiB | 0.0911 | 0.0909 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x1.000 | x0.676 |
| blake3-servil-mt / solo / LentMessages / 64 KiB | 0.0652 | 0.0652 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x0.910 |
| blake3-servil-mt / solo / LentMessages / 256 KiB | 0.0618 | 0.0615 | x0.996 | level | 3 of 4 | x0.996 | - | x0.995 | x1.000 | x0.788 |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.0388 | 0.0373 | x0.961 | level | 4 of 4 | x0.977 | - | x1.004 | x0.997 | x0.997 |
| blake3-servil-mt / solo / LentMessages / 4 MiB | 0.0318 | 0.0326 | x1.026 | level | 1 of 4 | x1.022 | - | x0.999 | x1.001 | x1.002 |
| blake3-servil-mt / solo / LentMessages / 16 MiB | 0.0299 | 0.0300 | x1.004 | level | 3 of 4 | x1.015 | - | x0.991 | x1.003 | x0.997 |
| blake3-servil-mt / solo / LentMessages / 64 MiB | 0.0740 | 0.0738 | x0.998 | level | 1 of 4 | x0.999 | - | x0.998 | x1.003 | x0.999 |
| blake3-servil-mt / solo / Interleaved / 256 | 0.109 | 0.109 | x1.000 | level | 2 of 4 | x1.000 | - | x0.999 | x1.000 | x1.004 |
| blake3-servil-mt / solo / Collection / git objects | 0.0174 | 0.0177 | x1.018 | level | 1 of 4 | x1.008 | - | x1.014 | x1.019 | x1.025 |
| blake3-servil-mt / solo / Collection / Nix files | 0.0174 | 0.0173 | x0.993 | level | 3 of 4 | x1.002 | - | x0.999 | x1.001 | x1.016 |
| blake3-servil-mt / solo / LentBatches / 16 | 6.036 | 6.113 | x1.013 | level | 1 of 4 | x1.013 | - | x1.013 | x0.997 | x0.702 |
| blake3-servil-mt / solo / LentBatches / 64 | 5.335 | 5.319 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x0.999 | x0.421 |
| blake3-servil-mt / solo / LentBatches / 256 | 5.283 | 5.298 | x1.003 | level | 2 of 4 | x1.003 | - | x1.003 | x1.000 | x0.767 |
| blake3-servil-mt / solo / LentBatches / 1024 | 5.625 | 5.621 | x0.999 | level | 3 of 4 | x0.999 | - | x1.000 | x1.000 | x2.485 |
| blake3-servil-mt / solo / LentBatches / 4096 | 5.498 | 5.498 | x1.000 | level | 3 of 4 | x1.000 | - | x0.999 | x1.000 | x0.864 |
| blake3-servil-mt / solo / LentBatches / 16384 | 2.638 | 2.603 | x0.987 | level | 3 of 4 | x0.996 | - | x0.996 | x1.000 | x0.989 |
| blake3-servil-mt / solo / LentBatches / 65536 | 2.360 | 2.310 | x0.979 | level | 3 of 4 | x0.982 | - | x1.001 | x0.999 | x0.979 |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.0359 | 0.0351 | x0.976 | level | 3 of 4 | x1.018 | - | x0.977 | x0.992 | x1.007 |
| blake3-servil-mt / solo / ContinuousCollection / Nix files | 0.0341 | 0.0328 | x0.961 | level | 4 of 4 | x1.024 | - | x0.964 | x0.993 | x1.008 |
| blake3-servil-mt / solo / MerkleTree / 1024 | 0.100 | 0.0996 | x0.995 | level | 2 of 4 | x0.996 | - | x0.996 | x1.001 | x0.605 |
| blake3-servil-mt / solo / MerkleTree / 4096 | 0.0570 | 0.0565 | x0.990 | level | 3 of 4 | x0.993 | - | x0.997 | x0.997 | x1.005 |
| blake3-servil-mt / solo / MerkleTree / 16384 | 0.0464 | 0.0463 | x0.998 | level | 2 of 4 | x0.987 | - | x0.996 | x0.992 | x1.080 |
| blake3-servil-mt / solo / MerkleTree / 65536 | 0.0407 | 0.0411 | x1.012 | level | 1 of 4 | x1.006 | - | x1.008 | x1.000 | x1.017 |
| blake3-servil-mt / solo / MerkleTree / 262144 | 0.0902 | 0.0905 | x1.003 | level | 2 of 4 | x0.998 | - | x1.004 | x1.000 | x1.004 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 32 B | 0.0797 | 0.0803 | x1.008 | level | 2 of 4 | x1.005 | - | x1.005 | x0.997 | x1.047 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 32 B | 0.179 | 0.179 | x1.001 | level | 2 of 4 | x1.007 | - | x1.001 | x1.000 | x1.004 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 16 B | 0.271 | 0.271 | x1.001 | level | 1 of 4 | x1.004 | - | x0.998 | x0.995 | x0.812 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 48 B | 0.0609 | 0.0580 | x0.952 | level | 3 of 4 | x0.961 | - | x1.001 | x1.000 | x0.975 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 48 B | 0.148 | 0.148 | x0.996 | level | 2 of 4 | x1.016 | - | x0.997 | x1.002 | x1.006 |
| blake3-servil-mt / solo / InterleavedTurn / 256 | 0.281 | 0.281 | x1.001 | level | 1 of 4 | - | - | x1.001 | x0.983 | x0.919 |
| blake3-servil-mt / solo / InterleavedTurn / 1024 x 1 KiB | 0.158 | 0.143 | x0.905 | level | 3 of 4 | - | - | x0.903 | x0.990 | x1.005 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 256 | 0.243 | 0.247 | x1.016 | level | 3 of 4 | - | - | x1.038 | x1.010 | x0.996 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.208 | 0.192 | x0.922 | level | 3 of 4 | - | - | x0.920 | x0.990 | x1.008 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 256 | 0.205 | 0.201 | x0.982 | level | 2 of 4 | - | - | x1.004 | x0.998 | x0.986 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.151 | 0.138 | x0.917 | level | 2 of 4 | - | - | x0.914 | x0.990 | x1.013 |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.0277 | 0.0279 | x1.006 | level | 1 of 4 | x1.012 | - | x1.002 | x1.003 | x0.986 |
| blake3-servil-mt / solo / ReceivingMessage / 2 μs | 0.0922 | 0.0922 | x1.000 | level | 2 of 4 | x0.978 | - | x1.028 | x1.004 | x1.020 |
| blake3-servil-mt / solo / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 3 of 4 | x0.998 | - | x0.993 | x1.003 | x0.994 |
| blake3-servil-mt / solo / IncrementalMessage / 64 B | 9.026 | 7.945 | x0.880 | level | 3 of 4 | - | - | x0.910 | x1.001 | x0.985 |
| blake3-servil-mt / solo / IncrementalMessage / 1 KiB | 1.780 | 1.688 | x0.948 | level | 3 of 4 | - | - | x0.943 | x0.999 | x0.992 |
| blake3-servil-mt / solo / IncrementalMessage / 4 KiB | 0.561 | 0.565 | x1.006 | level | 2 of 4 | - | - | x1.005 | x1.000 | x0.981 |
| blake3-servil-mt / solo / LentIncrementalMessage / 64 B | 0.779 | 0.779 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.851 |
| blake3-servil-mt / solo / LentIncrementalMessage / 1 KiB | 0.988 | 0.988 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x1.389 |
| blake3-servil-mt / solo / LentIncrementalMessage / 4 KiB | 0.290 | 0.290 | x1.001 | level | 3 of 4 | x1.001 | - | x1.000 | x1.000 | x0.984 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 4.263 | 4.225 | x0.991 | level | 2 of 4 | x1.000 | - | x0.993 | x0.944 | x1.071 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 4 KiB | 0.0598 | 0.0611 | x1.021 | level | 1 of 4 | x1.099 | - | x1.021 | x0.957 | x1.016 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 1 MiB | 0.0247 | 0.0244 | x0.990 | level | 3 of 4 | x1.003 | - | x0.988 | x1.003 | x0.998 |
| blake3-servil-mt / solo / ContinuousLentMessages / 64 B | 0.288 | 0.285 | x0.991 | level | 3 of 4 | x0.954 | - | x0.996 | x0.969 | x1.043 |
| blake3-servil-mt / solo / ContinuousLentMessages / 4 KiB | 0.0209 | 0.0210 | x1.005 | level | 2 of 4 | x0.930 | - | x0.995 | x0.980 | x0.986 |
| blake3-servil-mt / solo / ContinuousLentMessages / 1 MiB | 0.00799 | 0.00804 | x1.006 | level | 2 of 4 | x1.016 | - | x1.004 | x1.001 | x1.036 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.347 | 0.324 | x0.934 | level | 4 of 4 | - | - | x0.931 | x0.972 | x1.027 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 128 B | 0.174 | 0.181 | x1.037 | level | 1 of 4 | - | - | x1.032 | x0.972 | x0.858 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.0980 | 0.0969 | x0.989 | level | 2 of 4 | - | - | x0.989 | x0.973 | x0.966 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 512 B | 0.0609 | 0.0597 | x0.980 | level | 3 of 4 | - | - | x0.990 | x0.973 | x1.030 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.0473 | 0.0482 | x1.019 | level | 0 of 4 | - | - | x1.026 | x0.980 | x1.004 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.0611 | 0.0591 | x0.968 | level | 2 of 4 | - | - | x0.994 | x0.999 | x0.977 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.0369 | 0.0382 | x1.033 | level | 1 of 4 | - | - | x1.028 | x0.987 | x1.005 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.0327 | 0.0332 | x1.015 | level | 0 of 4 | - | - | x1.023 | x1.009 | x1.018 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 KiB | 0.0324 | 0.0327 | x1.010 | level | 1 of 4 | - | - | x1.014 | x1.004 | x1.059 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0324 | 0.0331 | x1.021 | level | 1 of 4 | - | - | x1.030 | x1.003 | x1.002 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.0333 | 0.0336 | x1.008 | level | 2 of 4 | - | - | x1.008 | x1.003 | x0.995 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.0409 | 0.0406 | x0.991 | level | 2 of 4 | - | - | x0.994 | x1.002 | x0.993 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 MiB | 0.0460 | 0.0468 | x1.018 | level | 1 of 4 | - | - | x1.016 | x1.003 | x0.975 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 3.505 | 3.423 | x0.976 | level | 4 of 4 | - | - | x0.962 | x0.971 | x0.981 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 64 | 2.566 | 2.458 | x0.958 | level | 4 of 4 | - | - | x0.946 | x0.982 | x1.041 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 256 | 2.619 | 2.558 | x0.977 | level | 3 of 4 | - | - | x0.966 | x0.989 | x0.976 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 2.351 | 2.380 | x1.012 | level | 1 of 4 | - | - | x1.011 | x1.004 | x0.938 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 4096 | 2.840 | 2.734 | x0.963 | level | 3 of 4 | - | - | x0.987 | x0.983 | x0.980 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16384 | 2.484 | 2.445 | x0.984 | level | 4 of 4 | - | - | x0.999 | x0.997 | x1.004 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 65536 | 2.253 | 2.218 | x0.984 | level | 3 of 4 | - | - | x1.008 | x1.009 | x1.039 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.746 | 0.746 | x1.000 | level | 0 of 4 | - | - | x1.000 | x1.000 | x0.821 |
| blake3-servil-mt / shared-one-cache / LentMessages / 128 B | 0.856 | 0.856 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.888 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 B | 0.914 | 0.914 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.719 |
| blake3-servil-mt / shared-one-cache / LentMessages / 512 B | 0.944 | 0.944 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.785 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 KiB | 0.962 | 0.962 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.060 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.285 | 0.284 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.969 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 KiB | 0.0911 | 0.0909 | x0.997 | level | 4 of 4 | - | - | x0.998 | x1.000 | x1.104 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 KiB | 0.0654 | 0.0654 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.848 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 KiB | 0.0618 | 0.0615 | x0.996 | level | 4 of 4 | - | - | x0.996 | x1.000 | x1.133 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 MiB | 0.0452 | 0.0436 | x0.965 | level | 4 of 4 | - | - | x0.987 | x0.963 | x1.006 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 MiB | 0.0379 | 0.0379 | x1.000 | level | 2 of 4 | - | - | x0.986 | x0.975 | x0.954 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 MiB | 0.0716 | 0.0706 | x0.985 | level | 3 of 4 | - | - | x0.986 | x0.985 | x0.998 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 MiB | 0.130 | 0.131 | x1.002 | level | 1 of 4 | - | - | x0.997 | x1.013 | x1.002 |
| blake3-servil-mt / shared-one-cache / Interleaved / 256 | 0.109 | 0.109 | x1.003 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.010 |
| blake3-servil-mt / shared-one-cache / Collection / git objects | 0.0406 | 0.0428 | x1.054 | level | 2 of 4 | - | - | x0.925 | x0.943 | x0.924 |
| blake3-servil-mt / shared-one-cache / Collection / Nix files | 0.0365 | 0.0373 | x1.023 | level | 0 of 4 | - | - | x0.994 | x0.990 | x0.984 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16 | 6.042 | 6.061 | x1.003 | level | 0 of 4 | - | - | x1.003 | x0.998 | x0.979 |
| blake3-servil-mt / shared-one-cache / LentBatches / 64 | 5.336 | 5.341 | x1.001 | level | 2 of 4 | - | - | x1.000 | x0.999 | x0.755 |
| blake3-servil-mt / shared-one-cache / LentBatches / 256 | 5.266 | 5.263 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.902 |
| blake3-servil-mt / shared-one-cache / LentBatches / 1024 | 5.622 | 5.618 | x0.999 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.022 |
| blake3-servil-mt / shared-one-cache / LentBatches / 4096 | 5.493 | 5.473 | x0.996 | level | 4 of 4 | - | - | x0.996 | x1.000 | x0.801 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16384 | 3.066 | 3.106 | x1.013 | level | 2 of 4 | - | - | x1.007 | x1.013 | x1.002 |
| blake3-servil-mt / shared-one-cache / LentBatches / 65536 | 2.574 | 2.526 | x0.982 | level | 3 of 4 | - | - | x1.011 | x0.999 | x0.980 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.0519 | 0.0503 | x0.968 | level | 3 of 4 | - | - | x0.966 | x0.992 | x1.008 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / Nix files | 0.0516 | 0.0484 | x0.939 | level | 4 of 4 | - | - | x0.933 | x0.993 | x1.027 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1024 | 0.0998 | 0.0997 | x0.998 | level | 2 of 4 | - | - | x0.998 | x1.001 | x0.825 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 4096 | 0.0625 | 0.0625 | x1.000 | level | 3 of 4 | - | - | x0.996 | x0.997 | x1.004 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 16384 | 0.0482 | 0.0495 | x1.025 | level | 1 of 4 | - | - | x1.009 | x1.017 | x1.035 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 | 0.119 | 0.119 | x1.004 | level | 0 of 4 | - | - | x0.999 | x1.015 | x0.992 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 262144 | 0.182 | 0.183 | x1.002 | level | 1 of 4 | - | - | x1.018 | x0.991 | x1.011 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 32 B | 0.0931 | 0.0957 | x1.028 | level | 1 of 4 | - | - | x1.001 | x1.001 | x0.989 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 32 B | 0.337 | 0.344 | x1.018 | level | 1 of 4 | - | - | x1.007 | x1.085 | x1.006 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 16 B | 0.538 | 0.543 | x1.009 | level | 1 of 4 | - | - | x1.003 | x1.027 | x1.003 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 48 B | 0.0672 | 0.0694 | x1.032 | level | 0 of 4 | - | - | x0.990 | x0.992 | x1.029 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 48 B | 0.276 | 0.273 | x0.991 | level | 3 of 4 | - | - | x0.994 | x0.977 | x0.992 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.0435 | 0.0430 | x0.989 | level | 3 of 4 | - | - | x0.993 | x0.996 | x0.998 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 2 μs | 0.0923 | 0.0923 | x0.999 | level | 4 of 4 | - | - | x1.027 | x1.002 | x1.052 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 2 of 4 | - | - | x1.008 | x0.998 | x1.038 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 64 B | 0.780 | 0.780 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.866 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 1 KiB | 0.988 | 0.988 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.936 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 4 KiB | 0.290 | 0.290 | x1.002 | level | 0 of 4 | - | - | x1.001 | x1.000 | x1.182 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 4.143 | 4.389 | x1.059 | level | 1 of 4 | - | - | x0.993 | x0.942 | x1.082 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 4 KiB | 0.0697 | 0.0681 | x0.977 | level | 3 of 4 | - | - | x0.972 | x0.970 | x1.010 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 1 MiB | 0.0330 | 0.0329 | x0.997 | level | 3 of 4 | - | - | x1.000 | x1.003 | x0.993 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 64 B | 0.288 | 0.284 | x0.988 | level | 3 of 4 | - | - | x0.987 | x0.969 | x1.040 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 4 KiB | 0.0362 | 0.0383 | x1.058 | level | 0 of 4 | - | - | x1.064 | x1.034 | x0.966 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 1 MiB | 0.0157 | 0.0148 | x0.945 | level | 2 of 4 | - | - | x1.054 | x1.051 | x1.095 |

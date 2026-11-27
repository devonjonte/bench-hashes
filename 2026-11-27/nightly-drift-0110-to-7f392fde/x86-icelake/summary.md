# Nightly drift check: e1966b498bc7 -> 7f392fdebc90

- Host: fast-feedback-icelake-147
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
| blake3-servil-st / solo / ManyMessages / 3 | 638.547 | 653.274 | x1.023 | level | 27 of 64 | - | - | x1.024 | x0.998 | x1.076 |
| blake3-servil-st / solo / ManyMessages / 4 | 385.434 | 399.158 | x1.036 | level | 23 of 64 | - | - | x1.031 | x0.998 | x1.070 |
| blake3-servil-st / solo / ManyLongMessages / 16 | 4984.369 | 4301.998 | x0.863 | faster | 64 of 64 | - | - | x0.864 | x0.567 | x1.130 |
| blake3-servil-st / solo / IdleOneMessage / 1536 B | 8.109 | 8.118 | x1.001 | level | 30 of 64 | - | - | x1.024 | x0.997 | - |
| blake3-servil-mt / solo / ManyMessages / 2 | 805.127 | 844.728 | x1.049 | level | 17 of 64 | - | - | x1.037 | x0.998 | x1.061 |
| blake3-servil-mt / solo / ManyMessages / 8 | 258.592 | 263.420 | x1.019 | level | 25 of 64 | - | - | x1.018 | x0.999 | x1.009 |
| blake3-servil-mt / solo / IdleOneMessage / 1536 B | 8.064 | 8.267 | x1.025 | level | 25 of 64 | - | - | x1.039 | x0.997 | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 KiB | 0.138 | 0.139 | x1.008 | level | 33 of 64 | - | - | x1.007 | x0.993 | x0.953 |

## Stage 1 (initial screen, kept-drift)

compare: old side: bench 3f119a507807 clean; servil e1966b498bc7 clean
compare: new side: bench 3f119a507807 clean; servil 7f392fdebc90 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 18.024 | 18.362 | x1.019 | level | 2 of 4 | - | - | x1.015 | x1.001 | x1.125 |
| blake3-servil-st / solo / OneMessage / 128 B | 10.452 | 10.582 | x1.012 | level | 1 of 4 | - | - | x1.007 | x1.001 | x1.098 |
| blake3-servil-st / solo / OneMessage / 256 B | 5.832 | 5.952 | x1.021 | level | 1 of 4 | - | - | x1.011 | x1.001 | x1.120 |
| blake3-servil-st / solo / OneMessage / 512 B | 3.710 | 3.768 | x1.015 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.111 |
| blake3-servil-st / solo / OneMessage / 1 KiB | 2.565 | 2.580 | x1.006 | level | 3 of 4 | - | - | x1.005 | x1.000 | x1.103 |
| blake3-servil-st / solo / OneMessage / 1536 B | 4.753 | 4.884 | x1.028 | level | 1 of 4 | - | - | x1.027 | x0.997 | x1.063 |
| blake3-servil-st / solo / OneMessage / 2 KiB | 4.182 | 4.219 | x1.009 | level | 2 of 4 | - | - | x1.005 | x1.000 | x1.067 |
| blake3-servil-st / solo / OneMessage / 2304 B | 4.482 | 4.438 | x0.990 | level | 3 of 4 | - | - | x0.989 | x1.000 | x1.044 |
| blake3-servil-st / solo / OneMessage / 3 KiB | 3.078 | 3.094 | x1.005 | level | 2 of 4 | - | - | x1.006 | x1.000 | x1.050 |
| blake3-servil-st / solo / OneMessage / 3839 B | 2.707 | 2.761 | x1.020 | level | 1 of 4 | - | - | x1.016 | x1.000 | x1.025 |
| blake3-servil-st / solo / OneMessage / 4 KiB | 2.317 | 2.311 | x0.997 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.005 |
| blake3-servil-st / solo / OneMessage / 4470 B | 2.571 | 2.534 | x0.986 | level | 2 of 4 | - | - | x0.983 | x1.000 | x1.007 |
| blake3-servil-st / solo / OneMessage / 7935 B | 2.031 | 2.019 | x0.994 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.967 |
| blake3-servil-st / solo / OneMessage / 8 KiB | 1.828 | 1.836 | x1.004 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.988 |
| blake3-servil-st / solo / OneMessage / 16 KiB | 1.325 | 1.339 | x1.011 | level | 0 of 4 | - | - | x1.001 | x1.000 | x1.027 |
| blake3-servil-st / solo / OneMessage / 32 KiB | 1.241 | 1.241 | x1.000 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.016 |
| blake3-servil-st / solo / OneMessage / 64 KiB | 1.052 | 1.060 | x1.008 | level | 1 of 4 | - | - | x1.008 | x1.000 | x0.999 |
| blake3-servil-st / solo / OneMessage / 128 KiB | 0.665 | 0.673 | x1.013 | level | 1 of 4 | - | - | x1.013 | x1.000 | x0.985 |
| blake3-servil-st / solo / OneMessage / 256 KiB | 0.480 | 0.483 | x1.008 | level | 0 of 4 | - | - | x1.007 | x1.000 | x0.984 |
| blake3-servil-st / solo / OneMessage / 512 KiB | 0.428 | 0.423 | x0.988 | level | 3 of 4 | - | - | x1.003 | x1.000 | x0.996 |
| blake3-servil-st / solo / OneMessage / 1 MiB | 0.394 | 0.394 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.992 |
| blake3-servil-st / solo / OneMessage / 2 MiB | 0.387 | 0.385 | x0.994 | level | 4 of 4 | - | - | x0.998 | x1.000 | x0.987 |
| blake3-servil-st / solo / OneMessage / 3 MiB | 0.381 | 0.381 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.008 |
| blake3-servil-st / solo / OneMessage / 4 MiB | 0.379 | 0.378 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.999 |
| blake3-servil-st / solo / OneMessage / 8 MiB | 0.381 | 0.381 | x1.000 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.990 |
| blake3-servil-st / solo / OneMessage / 32 MiB | 0.355 | 0.355 | x1.000 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.001 |
| blake3-servil-st / solo / OneMessage / 64 MiB | 0.354 | 0.354 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.998 |
| blake3-servil-st / solo / OneMessage / 128 MiB | 0.354 | 0.354 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.999 |
| blake3-servil-st / solo / ManyMessages / 1 | 1071.481 | 1143.980 | x1.068 | level | 1 of 4 | - | - | x1.034 | x1.003 | x1.122 |
| blake3-servil-st / solo / ManyMessages / 2 | 806.963 | 850.128 | x1.053 | level | 1 of 4 | - | - | x1.035 | x0.998 | x1.058 |
| blake3-servil-st / solo / ManyMessages / 3 | 624.382 | 675.881 | x1.082 | level | 0 of 4 | - | - | x1.055 | x0.999 | x1.089 |
| blake3-servil-st / solo / ManyMessages / 4 | 392.854 | 430.382 | x1.096 | level | 1 of 4 | - | - | x1.050 | x0.999 | x1.085 |
| blake3-servil-st / solo / ManyMessages / 6 | 345.667 | 358.029 | x1.036 | level | 1 of 4 | - | - | x1.038 | x0.999 | x1.064 |
| blake3-servil-st / solo / ManyMessages / 8 | 249.880 | 259.417 | x1.038 | level | 1 of 4 | - | - | x1.031 | x1.000 | x1.039 |
| blake3-servil-st / solo / ManyMessages / 12 | 205.498 | 207.156 | x1.008 | level | 1 of 4 | - | - | x1.010 | x1.000 | x1.001 |
| blake3-servil-st / solo / ManyMessages / 16 | 152.750 | 155.534 | x1.018 | level | 1 of 4 | - | - | x1.017 | x0.999 | x1.052 |
| blake3-servil-st / solo / ManyMessages / 24 | 138.791 | 136.844 | x0.986 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.054 |
| blake3-servil-st / solo / ManyMessages / 32 | 112.028 | 112.283 | x1.002 | level | 2 of 4 | - | - | x1.011 | x0.999 | x1.062 |
| blake3-servil-st / solo / ManyMessages / 48 | 98.722 | 98.464 | x0.997 | level | 3 of 4 | - | - | x1.008 | x1.000 | x1.088 |
| blake3-servil-st / solo / ManyMessages / 64 | 91.699 | 93.617 | x1.021 | level | 0 of 4 | - | - | x1.013 | x0.999 | x1.057 |
| blake3-servil-st / solo / ManyMessages / 128 | 83.458 | 84.079 | x1.007 | level | 1 of 4 | - | - | x1.006 | x1.000 | x1.041 |
| blake3-servil-st / solo / ManyMessages / 256 | 79.429 | 80.045 | x1.008 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.025 |
| blake3-servil-st / solo / ManyMessages / 512 | 77.898 | 77.736 | x0.998 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.019 |
| blake3-servil-st / solo / ManyMessages / 1024 | 66.155 | 66.247 | x1.001 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.992 |
| blake3-servil-st / solo / ManyMessages / 2048 | 42.528 | 42.612 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.976 |
| blake3-servil-st / solo / ManyMessages / 4096 | 31.094 | 31.151 | x1.002 | level | 1 of 4 | - | - | x1.003 | x1.000 | x0.989 |
| blake3-servil-st / solo / ManyMessages / 8192 | 27.356 | 27.357 | x1.000 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.996 |
| blake3-servil-st / solo / ManyMessages / 16384 | 25.306 | 25.243 | x0.998 | level | 4 of 4 | - | - | x0.998 | x1.000 | x0.962 |
| blake3-servil-st / solo / ManyMessages / 32768 | 24.866 | 24.749 | x0.995 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.995 |
| blake3-servil-st / solo / ManyMessages / 65536 | 24.636 | 24.587 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.001 |
| blake3-servil-st / solo / ManyMessages / 131072 | 25.027 | 24.823 | x0.992 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.990 |
| blake3-servil-st / solo / ManyMessages / 262144 | 25.510 | 25.344 | x0.993 | level | 4 of 4 | - | - | x0.994 | x1.000 | x1.010 |
| blake3-servil-st / solo / ManyLongMessages / 4 | 8148.029 | 8209.756 | x1.008 | level | 2 of 4 | - | - | x1.006 | x1.000 | x1.117 |
| blake3-servil-st / solo / ManyLongMessages / 16 | 4964.330 | 4273.207 | x0.861 | level | 4 of 4 | - | - | x0.861 | x0.567 | x1.134 |
| blake3-servil-st / solo / ManyLongMessages / 64 | 1973.038 | 1972.347 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.004 | x0.987 |
| blake3-servil-st / solo / ManyLongMessages / 256 | 1614.145 | 1616.100 | x1.001 | level | 1 of 4 | - | - | x0.997 | x1.003 | x0.963 |
| blake3-servil-st / solo / IdleOneMessage / 64 B | 9.515 | 8.720 | x0.916 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.671 |
| blake3-servil-st / solo / IdleOneMessage / 128 B | 6.169 | 6.330 | x1.026 | level | 1 of 4 | - | - | x1.006 | x1.000 | x0.349 |
| blake3-servil-st / solo / IdleOneMessage / 256 B | 4.743 | 4.882 | x1.029 | level | 2 of 4 | - | - | x1.002 | x1.001 | x0.363 |
| blake3-servil-st / solo / IdleOneMessage / 512 B | 4.128 | 4.263 | x1.033 | level | 2 of 4 | - | - | x1.008 | x1.000 | x0.600 |
| blake3-servil-st / solo / IdleOneMessage / 1 KiB | 3.701 | 3.712 | x1.003 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.996 |
| blake3-servil-st / solo / IdleOneMessage / 1536 B | 7.607 | 8.324 | x1.094 | level | 1 of 4 | - | - | x1.109 | x0.997 | x1.442 |
| blake3-servil-st / solo / IdleOneMessage / 2 KiB | 6.340 | 6.615 | x1.043 | level | 1 of 4 | - | - | x0.999 | x1.000 | x0.495 |
| blake3-servil-st / solo / IdleOneMessage / 2304 B | 6.498 | 6.551 | x1.008 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.980 |
| blake3-servil-st / solo / IdleOneMessage / 3 KiB | 4.543 | 4.646 | x1.023 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.507 |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 3.898 | 3.869 | x0.992 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.294 |
| blake3-servil-st / solo / IdleOneMessage / 4 KiB | 3.426 | 3.460 | x1.010 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.276 |
| blake3-servil-st / solo / IdleOneMessage / 4470 B | 3.689 | 3.618 | x0.981 | level | 3 of 4 | - | - | x1.014 | x1.000 | x0.701 |
| blake3-servil-st / solo / IdleOneMessage / 7935 B | 2.551 | 2.456 | x0.963 | level | 4 of 4 | - | - | x1.001 | x1.000 | x0.803 |
| blake3-servil-st / solo / IdleOneMessage / 8 KiB | 2.306 | 2.414 | x1.047 | level | 0 of 4 | - | - | x1.004 | x1.000 | x0.780 |
| blake3-servil-st / solo / IdleOneMessage / 16 KiB | 1.558 | 1.607 | x1.032 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.094 |
| blake3-servil-st / solo / IdleOneMessage / 32 KiB | 1.328 | 1.336 | x1.006 | level | 2 of 4 | - | - | x0.993 | x1.000 | x1.244 |
| blake3-servil-st / solo / IdleOneMessage / 64 KiB | 0.866 | 0.830 | x0.958 | level | 3 of 4 | - | - | x0.972 | x1.000 | x0.988 |
| blake3-servil-st / solo / IdleOneMessage / 128 KiB | 0.665 | 0.677 | x1.019 | level | 2 of 4 | - | - | x1.029 | x1.000 | x0.757 |
| blake3-servil-st / solo / IdleOneMessage / 256 KiB | 0.484 | 0.484 | x0.999 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.947 |
| blake3-servil-st / solo / IdleOneMessage / 512 KiB | 0.369 | 0.368 | x0.997 | level | 2 of 4 | - | - | x0.995 | x1.000 | x1.012 |
| blake3-servil-st / solo / IdleOneMessage / 1 MiB | 0.359 | 0.359 | x1.001 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.030 |
| blake3-servil-st / solo / IdleOneMessage / 2 MiB | 0.350 | 0.350 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.974 |
| blake3-servil-st / solo / IdleOneMessage / 3 MiB | 0.344 | 0.344 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.020 |
| blake3-servil-st / solo / IdleOneMessage / 4 MiB | 0.341 | 0.341 | x1.002 | level | 0 of 4 | - | - | x1.001 | x1.000 | x1.087 |
| blake3-servil-st / solo / IdleOneMessage / 8 MiB | 0.339 | 0.339 | x1.001 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.001 |
| blake3-servil-st / solo / IdleOneMessage / 32 MiB | 0.345 | 0.346 | x1.003 | level | 0 of 4 | - | - | x1.002 | x1.000 | x1.002 |
| blake3-servil-st / solo / IdleOneMessage / 64 MiB | 0.350 | 0.351 | x1.002 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.997 |
| blake3-servil-st / solo / IdleOneMessage / 128 MiB | 0.353 | 0.354 | x1.001 | level | 0 of 4 | - | - | x1.001 | x1.000 | x0.999 |
| blake3-servil-st / solo / IdleManyMessages / 1 | 642.498 | 630.445 | x0.981 | level | 2 of 4 | - | - | x1.011 | x1.002 | x1.326 |
| blake3-servil-st / solo / IdleManyMessages / 2 | 740.807 | 740.540 | x1.000 | level | 2 of 4 | - | - | x0.990 | x0.998 | x1.045 |
| blake3-servil-st / solo / IdleManyMessages / 3 | 755.597 | 773.851 | x1.024 | level | 1 of 4 | - | - | x1.001 | x0.999 | x0.709 |
| blake3-servil-st / solo / IdleManyMessages / 4 | 388.161 | 389.710 | x1.004 | level | 2 of 4 | - | - | x1.004 | x0.999 | x0.781 |
| blake3-servil-st / solo / IdleManyMessages / 6 | 439.874 | 462.221 | x1.051 | level | 1 of 4 | - | - | x1.020 | x0.999 | x1.704 |
| blake3-servil-st / solo / IdleManyMessages / 8 | 304.506 | 293.884 | x0.965 | level | 2 of 4 | - | - | x0.996 | x0.999 | x0.579 |
| blake3-servil-st / solo / IdleManyMessages / 12 | 291.219 | 304.999 | x1.047 | level | 1 of 4 | - | - | x1.009 | x0.999 | x1.033 |
| blake3-servil-st / solo / IdleManyMessages / 16 | 199.253 | 200.219 | x1.005 | level | 2 of 4 | - | - | x1.002 | x0.999 | x1.998 |
| blake3-servil-st / solo / IdleManyMessages / 24 | 220.751 | 219.643 | x0.995 | level | 2 of 4 | - | - | x1.003 | x0.999 | x2.163 |
| blake3-servil-st / solo / IdleManyMessages / 32 | 185.604 | 178.552 | x0.962 | level | 3 of 4 | - | - | x1.003 | x0.999 | x0.798 |
| blake3-servil-st / solo / IdleManyMessages / 48 | 173.359 | 172.177 | x0.993 | level | 2 of 4 | - | - | x0.999 | x0.999 | x0.638 |
| blake3-servil-st / solo / IdleManyMessages / 64 | 166.933 | 165.974 | x0.994 | level | 1 of 4 | - | - | x1.001 | x0.999 | x1.178 |
| blake3-servil-st / solo / IdleManyMessages / 128 | 123.144 | 122.596 | x0.996 | level | 3 of 4 | - | - | x1.005 | x1.000 | x2.332 |
| blake3-servil-st / solo / IdleManyMessages / 256 | 96.766 | 97.567 | x1.008 | level | 1 of 4 | - | - | x1.005 | x1.000 | x1.040 |
| blake3-servil-st / solo / IdleManyMessages / 512 | 84.451 | 84.152 | x0.996 | level | 2 of 4 | - | - | x1.014 | x1.000 | x1.013 |
| blake3-servil-st / solo / IdleManyMessages / 1024 | 52.761 | 54.897 | x1.040 | level | 1 of 4 | - | - | x1.009 | x1.000 | x3.708 |
| blake3-servil-st / solo / IdleManyMessages / 2048 | 42.151 | 42.919 | x1.018 | level | 1 of 4 | - | - | x1.016 | x1.000 | x0.951 |
| blake3-servil-st / solo / IdleManyMessages / 4096 | 30.970 | 31.020 | x1.002 | level | 1 of 4 | - | - | x1.007 | x1.000 | x1.087 |
| blake3-servil-st / solo / IdleManyMessages / 8192 | 24.037 | 24.045 | x1.000 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.983 |
| blake3-servil-st / solo / IdleManyMessages / 16384 | 23.800 | 23.731 | x0.997 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.997 |
| blake3-servil-st / solo / IdleManyMessages / 32768 | 22.745 | 22.664 | x0.996 | level | 4 of 4 | - | - | x0.997 | x1.000 | x0.997 |
| blake3-servil-st / solo / IdleManyMessages / 65536 | 22.305 | 22.256 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.033 |
| blake3-servil-st / solo / IdleManyMessages / 131072 | 22.147 | 22.099 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.004 |
| blake3-servil-st / solo / IdleManyMessages / 262144 | 22.698 | 22.506 | x0.992 | level | 3 of 4 | - | - | x0.992 | x1.000 | x0.932 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 B | 3.224 | 3.234 | x1.003 | level | 2 of 4 | - | - | x0.992 | x0.998 | x0.576 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 B | 2.438 | 2.390 | x0.981 | level | 2 of 4 | - | - | x0.991 | x1.000 | x1.290 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 B | 1.791 | 1.789 | x0.999 | level | 2 of 4 | - | - | x0.992 | x1.001 | x0.487 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 B | 1.620 | 1.607 | x0.992 | level | 2 of 4 | - | - | x0.995 | x1.000 | x1.552 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 KiB | 1.511 | 1.505 | x0.996 | level | 1 of 4 | - | - | x0.997 | x1.000 | x0.940 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1536 B | 1.227 | 1.229 | x1.001 | level | 3 of 4 | - | - | x1.001 | x0.997 | x0.915 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 KiB | 0.906 | 0.869 | x0.960 | level | 3 of 4 | - | - | x0.967 | x1.000 | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 2304 B | 1.016 | 1.047 | x1.031 | level | 2 of 4 | - | - | x1.035 | x1.000 | x2.801 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.758 | 0.804 | x1.060 | level | 1 of 4 | - | - | x1.046 | x1.000 | x0.795 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3839 B | 0.585 | 0.590 | x1.009 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.901 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 KiB | 0.481 | 0.478 | x0.992 | level | 3 of 4 | - | - | x0.993 | x1.000 | x0.621 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4470 B | 0.594 | 0.591 | x0.995 | level | 4 of 4 | - | - | x0.996 | x1.000 | x0.999 |
| blake3-servil-st / solo / BriefIdleOneMessage / 7935 B | 0.446 | 0.441 | x0.987 | level | 2 of 4 | - | - | x0.994 | x1.000 | x1.269 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 KiB | 0.393 | 0.392 | x0.996 | level | 2 of 4 | - | - | x0.995 | x1.000 | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 16 KiB | 0.297 | 0.296 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.632 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 KiB | 0.294 | 0.294 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.736 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 KiB | 0.286 | 0.286 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.623 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 KiB | 0.282 | 0.282 | x1.001 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.329 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 KiB | 0.280 | 0.281 | x1.003 | level | 0 of 4 | - | - | x1.000 | x1.000 | x1.241 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 KiB | 0.287 | 0.287 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.024 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 MiB | 0.326 | 0.326 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.980 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 MiB | 0.335 | 0.335 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.027 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 MiB | 0.334 | 0.335 | x1.001 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.034 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 MiB | 0.335 | 0.334 | x0.998 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.036 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 MiB | 0.362 | 0.362 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.987 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 MiB | 0.346 | 0.347 | x1.002 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.997 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 MiB | 0.351 | 0.351 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.998 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 MiB | 0.353 | 0.353 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.999 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1 | 240.768 | 238.901 | x0.992 | level | 3 of 4 | - | - | x0.997 | x1.003 | x0.810 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2 | 202.486 | 206.518 | x1.020 | level | 2 of 4 | - | - | x1.009 | x0.997 | x0.769 |
| blake3-servil-st / solo / BriefIdleManyMessages / 3 | 129.747 | 134.256 | x1.035 | level | 2 of 4 | - | - | x1.015 | x0.999 | x0.851 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4 | 69.428 | 66.841 | x0.963 | level | 3 of 4 | - | - | x0.980 | x0.998 | x1.131 |
| blake3-servil-st / solo / BriefIdleManyMessages / 6 | 59.887 | 60.076 | x1.003 | level | 2 of 4 | - | - | x0.995 | x0.998 | x1.549 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8 | 41.350 | 41.401 | x1.001 | level | 1 of 4 | - | - | x1.000 | x0.999 | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 12 | 36.783 | 36.893 | x1.003 | level | 2 of 4 | - | - | x0.998 | x0.999 | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 16 | 25.995 | 25.985 | x1.000 | level | 2 of 4 | - | - | x1.001 | x0.998 | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 24 | 27.032 | 26.625 | x0.985 | level | 2 of 4 | - | - | x0.995 | x0.999 | x1.370 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32 | 21.953 | 21.987 | x1.002 | level | 2 of 4 | - | - | x1.002 | x0.999 | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 48 | 19.899 | 19.658 | x0.988 | level | 2 of 4 | - | - | x0.996 | x0.999 | x3.059 |
| blake3-servil-st / solo / BriefIdleManyMessages / 64 | 19.001 | 19.021 | x1.001 | level | 1 of 4 | - | - | x1.000 | x0.999 | x0.805 |
| blake3-servil-st / solo / BriefIdleManyMessages / 128 | 17.819 | 17.899 | x1.005 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.244 |
| blake3-servil-st / solo / BriefIdleManyMessages / 256 | 18.204 | 18.424 | x1.012 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.909 |
| blake3-servil-st / solo / BriefIdleManyMessages / 512 | 18.438 | 18.313 | x0.993 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.083 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1024 | 18.080 | 18.119 | x1.002 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.102 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2048 | 18.002 | 18.039 | x1.002 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.997 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4096 | 17.984 | 17.981 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.853 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8192 | 19.252 | 19.390 | x1.007 | level | 1 of 4 | - | - | x0.999 | x1.000 | x1.051 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16384 | 21.776 | 21.693 | x0.996 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.019 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32768 | 21.840 | 21.753 | x0.996 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.018 |
| blake3-servil-st / solo / BriefIdleManyMessages / 65536 | 21.939 | 21.947 | x1.000 | level | 1 of 4 | - | - | x0.998 | x1.000 | x1.050 |
| blake3-servil-st / solo / BriefIdleManyMessages / 131072 | 23.630 | 23.590 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.008 |
| blake3-servil-st / solo / BriefIdleManyMessages / 262144 | 22.643 | 22.474 | x0.993 | level | 3 of 4 | - | - | x0.993 | x1.000 | x0.947 |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 1.562 | 1.522 | x0.974 | level | 2 of 4 | x0.974 | - | x0.974 | x1.000 | - |
| blake3-servil-st / solo / ContinuousMessages / 128 B | 1.436 | 1.439 | x1.002 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | - |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 1.407 | 1.405 | x0.998 | level | 2 of 4 | x0.998 | - | x0.998 | x1.000 | - |
| blake3-servil-st / solo / ContinuousMessages / 512 B | 1.403 | 1.400 | x0.998 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x1.777 |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 1.397 | 1.396 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.849 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.435 | 0.438 | x1.007 | level | 0 of 4 | x1.007 | - | x1.008 | x1.000 | - |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.271 | 0.271 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.171 |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.281 | 0.281 | x1.000 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.304 |
| blake3-servil-st / solo / ContinuousMessages / 256 KiB | 0.300 | 0.300 | x0.999 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x3.312 |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.299 | 0.298 | x0.997 | level | 4 of 4 | x0.997 | - | x0.998 | x1.000 | x0.780 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.305 | 0.304 | x0.997 | level | 4 of 4 | x0.998 | - | x0.998 | x1.000 | x0.778 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.305 | 0.304 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x1.578 |
| blake3-servil-st / solo / ContinuousMessages / 64 MiB | 0.320 | 0.320 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x1.007 |
| blake3-servil-st / solo / ContinuousBatches / 16 | 20.951 | 20.802 | x0.993 | level | 2 of 4 | x0.993 | - | x0.993 | x0.998 | x1.312 |
| blake3-servil-st / solo / ContinuousBatches / 64 | 17.942 | 18.005 | x1.004 | level | 1 of 4 | x1.003 | - | x1.004 | x0.999 | - |
| blake3-servil-st / solo / ContinuousBatches / 256 | 17.756 | 17.861 | x1.006 | level | 1 of 4 | x1.006 | - | x1.006 | x1.000 | x4.250 |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 19.110 | 19.407 | x1.016 | level | 0 of 4 | x1.016 | - | x1.016 | x0.999 | - |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 19.266 | 19.370 | x1.005 | level | 1 of 4 | x1.006 | - | x1.007 | x1.000 | x2.221 |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 22.510 | 22.538 | x1.001 | level | 3 of 4 | x1.001 | - | x1.001 | x1.000 | x1.820 |
| blake3-servil-st / solo / ContinuousBatches / 65536 | 23.469 | 23.044 | x0.982 | level | 3 of 4 | x0.995 | - | x0.996 | x1.000 | x1.037 |
| blake3-servil-st / solo / LentMessages / 64 B | 1.562 | 1.522 | x0.974 | level | 2 of 4 | x0.974 | - | x0.974 | x1.000 | - |
| blake3-servil-st / solo / LentMessages / 128 B | 1.436 | 1.439 | x1.002 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | - |
| blake3-servil-st / solo / LentMessages / 256 B | 1.407 | 1.405 | x0.998 | level | 2 of 4 | x0.998 | - | x0.998 | x1.000 | - |
| blake3-servil-st / solo / LentMessages / 512 B | 1.403 | 1.400 | x0.998 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x1.777 |
| blake3-servil-st / solo / LentMessages / 1 KiB | 1.397 | 1.396 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.849 |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.435 | 0.438 | x1.007 | level | 0 of 4 | x1.007 | - | x1.008 | x1.000 | - |
| blake3-servil-st / solo / LentMessages / 16 KiB | 0.271 | 0.271 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.171 |
| blake3-servil-st / solo / LentMessages / 64 KiB | 0.281 | 0.281 | x1.000 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.304 |
| blake3-servil-st / solo / LentMessages / 256 KiB | 0.278 | 0.277 | x0.996 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.908 |
| blake3-servil-st / solo / LentMessages / 1 MiB | 0.317 | 0.315 | x0.992 | level | 4 of 4 | x0.992 | - | x0.993 | x1.000 | x2.036 |
| blake3-servil-st / solo / LentMessages / 4 MiB | 0.333 | 0.330 | x0.990 | level | 3 of 4 | x0.993 | - | x0.994 | x1.000 | x1.006 |
| blake3-servil-st / solo / LentMessages / 16 MiB | 0.345 | 0.341 | x0.991 | level | 4 of 4 | x0.991 | - | x0.991 | x1.000 | x0.909 |
| blake3-servil-st / solo / LentMessages / 64 MiB | 0.352 | 0.350 | x0.996 | level | 3 of 4 | x0.996 | - | x0.996 | x1.000 | x1.004 |
| blake3-servil-st / solo / Interleaved / 256 | 0.393 | 0.391 | x0.995 | level | 4 of 4 | x0.995 | - | x0.996 | x1.001 | x0.990 |
| blake3-servil-st / solo / Collection / git objects | 0.273 | 0.272 | x0.996 | level | 4 of 4 | x0.996 | - | x0.997 | x0.999 | x0.951 |
| blake3-servil-st / solo / Collection / Nix files | 0.263 | 0.263 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x0.999 | x0.957 |
| blake3-servil-st / solo / LentBatches / 16 | 20.951 | 20.802 | x0.993 | level | 2 of 4 | x0.993 | - | x0.993 | x0.998 | x1.312 |
| blake3-servil-st / solo / LentBatches / 64 | 17.942 | 18.005 | x1.004 | level | 1 of 4 | x1.003 | - | x1.004 | x0.999 | - |
| blake3-servil-st / solo / LentBatches / 256 | 17.756 | 17.861 | x1.006 | level | 1 of 4 | x1.006 | - | x1.006 | x1.000 | x4.250 |
| blake3-servil-st / solo / LentBatches / 1024 | 19.110 | 19.407 | x1.016 | level | 0 of 4 | x1.016 | - | x1.016 | x0.999 | - |
| blake3-servil-st / solo / LentBatches / 4096 | 19.266 | 19.370 | x1.005 | level | 1 of 4 | x1.006 | - | x1.007 | x1.000 | x2.221 |
| blake3-servil-st / solo / LentBatches / 16384 | 22.510 | 22.538 | x1.001 | level | 3 of 4 | x1.001 | - | x1.001 | x1.000 | x1.820 |
| blake3-servil-st / solo / LentBatches / 65536 | 23.469 | 23.044 | x0.982 | level | 3 of 4 | x0.995 | - | x0.996 | x1.000 | x1.037 |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.352 | 0.350 | x0.996 | level | 3 of 4 | x0.997 | - | x0.997 | x1.000 | x0.963 |
| blake3-servil-st / solo / ContinuousCollection / Nix files | 0.360 | 0.359 | x0.997 | level | 4 of 4 | x0.997 | - | x0.997 | x1.000 | x1.025 |
| blake3-servil-st / solo / MerkleTree / 1024 | 0.350 | 0.349 | x0.999 | level | 3 of 4 | x0.999 | - | x1.000 | x1.001 | x2.250 |
| blake3-servil-st / solo / MerkleTree / 4096 | 0.401 | 0.400 | x0.997 | level | 3 of 4 | x0.998 | - | x0.997 | x1.001 | x1.752 |
| blake3-servil-st / solo / MerkleTree / 16384 | 0.415 | 0.411 | x0.991 | level | 4 of 4 | x0.991 | - | x0.990 | x1.001 | x1.386 |
| blake3-servil-st / solo / MerkleTree / 65536 | 0.443 | 0.440 | x0.992 | level | 4 of 4 | x0.992 | - | x0.992 | x1.001 | x0.990 |
| blake3-servil-st / solo / MerkleTree / 262144 | 0.470 | 0.467 | x0.993 | level | 4 of 4 | x0.993 | - | x0.993 | x1.001 | x0.993 |
| blake3-servil-st / solo / MerkleTree / 65536 x 32 B | 1.052 | 1.050 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x0.589 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 32 B | 1.088 | 1.085 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x1.016 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 16 B | 2.111 | 2.110 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.999 |
| blake3-servil-st / solo / MerkleTree / 65536 x 48 B | 0.744 | 0.742 | x0.996 | level | 3 of 4 | x0.996 | - | x0.997 | x1.000 | x1.025 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 48 B | 0.778 | 0.776 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x1.000 | x1.015 |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.749 | 0.753 | x1.005 | level | 1 of 4 | - | - | x1.005 | x0.999 | x1.007 |
| blake3-servil-st / solo / InterleavedTurn / 1024 x 1 KiB | 0.863 | 0.856 | x0.992 | level | 2 of 4 | - | - | x0.992 | x1.000 | x0.979 |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.656 | 0.670 | x1.021 | level | 0 of 4 | - | - | x0.999 | x0.992 | x0.975 |
| blake3-servil-st / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.797 | 0.802 | x1.005 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.042 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.515 | 0.514 | x0.998 | level | 2 of 4 | - | - | x1.001 | x1.001 | x0.992 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.724 | 0.722 | x0.998 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.959 |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.318 | 0.318 | x0.999 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x1.566 |
| blake3-servil-st / solo / ReceivingMessage / 2 μs | 0.320 | 0.320 | x1.001 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.486 |
| blake3-servil-st / solo / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 4 of 4 | x1.000 | - | x0.999 | x1.000 | x1.025 |
| blake3-servil-st / solo / IncrementalMessage / 64 B | 17.821 | 18.730 | x1.051 | level | 2 of 4 | - | - | x1.028 | x1.001 | x1.215 |
| blake3-servil-st / solo / IncrementalMessage / 1 KiB | 3.436 | 3.424 | x0.996 | level | 3 of 4 | - | - | x0.988 | x1.000 | x1.198 |
| blake3-servil-st / solo / IncrementalMessage / 4 KiB | 2.467 | 2.487 | x1.008 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.057 |
| blake3-servil-st / solo / LentIncrementalMessage / 64 B | 1.702 | 1.723 | x1.012 | level | 2 of 4 | x1.012 | - | x1.012 | x1.000 | x0.518 |
| blake3-servil-st / solo / LentIncrementalMessage / 1 KiB | 1.437 | 1.438 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x0.971 |
| blake3-servil-st / solo / LentIncrementalMessage / 4 KiB | 0.457 | 0.455 | x0.996 | level | 2 of 4 | x0.996 | - | x0.996 | x1.000 | x0.759 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 1.469 | 1.456 | x0.991 | level | 3 of 4 | x0.992 | - | x0.991 | x1.000 | x0.843 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 4 KiB | 0.438 | 0.439 | x1.001 | level | 3 of 4 | x0.998 | - | x0.996 | x1.000 | x0.890 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 1 MiB | 0.297 | 0.282 | x0.951 | level | 4 of 4 | x0.951 | - | x0.951 | x1.000 | x1.042 |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 1.388 | 1.407 | x1.013 | level | 2 of 4 | x1.013 | - | x1.014 | x1.000 | x1.262 |
| blake3-servil-st / solo / ContinuousLentMessages / 4 KiB | 0.425 | 0.423 | x0.996 | level | 4 of 4 | x0.996 | - | x0.996 | x1.000 | x0.522 |
| blake3-servil-st / solo / ContinuousLentMessages / 1 MiB | 0.243 | 0.242 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x0.994 |
| blake3-servil-mt / solo / OneMessage / 64 B | 19.314 | 20.692 | x1.071 | level | 2 of 4 | - | - | x1.037 | x1.000 | x1.125 |
| blake3-servil-mt / solo / OneMessage / 128 B | 11.055 | 11.360 | x1.028 | level | 1 of 4 | - | - | x1.019 | x1.001 | x1.114 |
| blake3-servil-mt / solo / OneMessage / 256 B | 6.094 | 6.438 | x1.056 | level | 1 of 4 | - | - | x1.049 | x1.001 | x1.138 |
| blake3-servil-mt / solo / OneMessage / 512 B | 3.849 | 4.017 | x1.044 | level | 0 of 4 | - | - | x1.023 | x1.000 | x1.139 |
| blake3-servil-mt / solo / OneMessage / 1 KiB | 2.659 | 2.776 | x1.044 | level | 2 of 4 | - | - | x1.017 | x1.000 | x1.090 |
| blake3-servil-mt / solo / OneMessage / 1536 B | 4.707 | 4.921 | x1.046 | level | 1 of 4 | - | - | x1.055 | x0.997 | x1.055 |
| blake3-servil-mt / solo / OneMessage / 2 KiB | 4.284 | 4.328 | x1.010 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.023 |
| blake3-servil-mt / solo / OneMessage / 2304 B | 4.490 | 4.483 | x0.999 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.998 |
| blake3-servil-mt / solo / OneMessage / 3 KiB | 3.122 | 3.137 | x1.005 | level | 2 of 4 | - | - | x1.005 | x1.000 | x1.063 |
| blake3-servil-mt / solo / OneMessage / 3839 B | 2.724 | 2.732 | x1.003 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.030 |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 2.340 | 2.391 | x1.022 | level | 0 of 4 | - | - | x1.002 | x1.000 | x1.005 |
| blake3-servil-mt / solo / OneMessage / 4470 B | 2.560 | 2.497 | x0.975 | level | 2 of 4 | - | - | x0.982 | x1.000 | x0.985 |
| blake3-servil-mt / solo / OneMessage / 7935 B | 2.068 | 2.040 | x0.987 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.984 |
| blake3-servil-mt / solo / OneMessage / 8 KiB | 1.846 | 1.854 | x1.004 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.991 |
| blake3-servil-mt / solo / OneMessage / 16 KiB | 1.339 | 1.336 | x0.998 | level | 3 of 4 | - | - | x1.001 | x1.000 | x1.011 |
| blake3-servil-mt / solo / OneMessage / 32 KiB | 1.239 | 1.241 | x1.002 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.019 |
| blake3-servil-mt / solo / OneMessage / 64 KiB | 1.053 | 1.064 | x1.011 | level | 1 of 4 | - | - | x1.010 | x1.000 | x0.979 |
| blake3-servil-mt / solo / OneMessage / 128 KiB | 0.667 | 0.668 | x1.003 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.996 |
| blake3-servil-mt / solo / OneMessage / 256 KiB | 0.480 | 0.483 | x1.006 | level | 1 of 4 | - | - | x1.006 | x1.000 | x0.990 |
| blake3-servil-mt / solo / OneMessage / 512 KiB | 0.440 | 0.435 | x0.988 | level | 3 of 4 | - | - | x0.985 | x0.941 | x1.015 |
| blake3-servil-mt / solo / OneMessage / 1 MiB | 0.335 | 0.329 | x0.983 | level | 1 of 4 | - | - | x0.979 | x0.856 | x0.983 |
| blake3-servil-mt / solo / OneMessage / 2 MiB | 0.242 | 0.244 | x1.008 | level | 2 of 4 | - | - | x1.007 | x0.957 | x0.986 |
| blake3-servil-mt / solo / OneMessage / 3 MiB | 0.211 | 0.213 | x1.013 | level | 0 of 4 | - | - | x1.007 | x1.045 | x1.002 |
| blake3-servil-mt / solo / OneMessage / 4 MiB | 0.194 | 0.194 | x0.999 | level | 1 of 4 | - | - | x0.998 | x1.017 | x0.998 |
| blake3-servil-mt / solo / OneMessage / 8 MiB | 0.166 | 0.165 | x0.998 | level | 2 of 4 | - | - | x0.999 | x0.983 | x1.001 |
| blake3-servil-mt / solo / OneMessage / 32 MiB | 0.112 | 0.112 | x1.002 | level | 2 of 4 | - | - | x0.999 | x0.995 | x1.002 |
| blake3-servil-mt / solo / OneMessage / 64 MiB | 0.107 | 0.107 | x0.999 | level | 1 of 4 | - | - | x0.999 | x0.995 | x0.999 |
| blake3-servil-mt / solo / OneMessage / 128 MiB | 0.105 | 0.105 | x0.999 | level | 3 of 4 | - | - | x0.999 | x0.996 | x0.999 |
| blake3-servil-mt / solo / ManyMessages / 1 | 1082.283 | 1170.429 | x1.081 | level | 1 of 4 | - | - | x1.055 | x1.002 | x1.188 |
| blake3-servil-mt / solo / ManyMessages / 2 | 799.801 | 863.528 | x1.080 | level | 1 of 4 | - | - | x1.060 | x0.999 | x1.081 |
| blake3-servil-mt / solo / ManyMessages / 3 | 654.129 | 668.028 | x1.021 | level | 1 of 4 | - | - | x1.032 | x0.999 | x1.082 |
| blake3-servil-mt / solo / ManyMessages / 4 | 397.841 | 438.388 | x1.102 | level | 1 of 4 | - | - | x1.072 | x0.999 | x1.077 |
| blake3-servil-mt / solo / ManyMessages / 6 | 343.411 | 356.501 | x1.038 | level | 1 of 4 | - | - | x1.031 | x0.999 | x1.051 |
| blake3-servil-mt / solo / ManyMessages / 8 | 247.490 | 264.997 | x1.071 | level | 1 of 4 | - | - | x1.042 | x0.999 | x1.033 |
| blake3-servil-mt / solo / ManyMessages / 12 | 203.332 | 209.666 | x1.031 | level | 2 of 4 | - | - | x1.024 | x0.999 | x1.014 |
| blake3-servil-mt / solo / ManyMessages / 16 | 152.618 | 156.748 | x1.027 | level | 1 of 4 | - | - | x1.022 | x0.999 | x1.072 |
| blake3-servil-mt / solo / ManyMessages / 24 | 135.969 | 136.502 | x1.004 | level | 1 of 4 | - | - | x1.006 | x1.000 | x1.043 |
| blake3-servil-mt / solo / ManyMessages / 32 | 110.092 | 112.498 | x1.022 | level | 1 of 4 | - | - | x1.018 | x1.000 | x1.058 |
| blake3-servil-mt / solo / ManyMessages / 48 | 97.891 | 98.189 | x1.003 | level | 2 of 4 | - | - | x1.006 | x1.000 | x1.073 |
| blake3-servil-mt / solo / ManyMessages / 64 | 91.987 | 93.068 | x1.012 | level | 1 of 4 | - | - | x1.001 | x0.999 | x1.066 |
| blake3-servil-mt / solo / ManyMessages / 128 | 83.509 | 83.629 | x1.001 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.058 |
| blake3-servil-mt / solo / ManyMessages / 256 | 79.438 | 80.714 | x1.016 | level | 0 of 4 | - | - | x1.007 | x1.000 | x1.056 |
| blake3-servil-mt / solo / ManyMessages / 512 | 77.816 | 77.967 | x1.002 | level | 2 of 4 | - | - | x1.004 | x1.000 | x1.017 |
| blake3-servil-mt / solo / ManyMessages / 1024 | 65.594 | 65.850 | x1.004 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.984 |
| blake3-servil-mt / solo / ManyMessages / 2048 | 42.801 | 42.505 | x0.993 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.969 |
| blake3-servil-mt / solo / ManyMessages / 4096 | 31.146 | 31.291 | x1.005 | level | 1 of 4 | - | - | x1.004 | x1.000 | x0.989 |
| blake3-servil-mt / solo / ManyMessages / 8192 | 26.414 | 24.801 | x0.939 | level | 3 of 4 | - | - | x0.939 | x0.784 | x0.974 |
| blake3-servil-mt / solo / ManyMessages / 16384 | 19.233 | 19.216 | x0.999 | level | 2 of 4 | - | - | x0.998 | x0.980 | x0.989 |
| blake3-servil-mt / solo / ManyMessages / 32768 | 15.003 | 15.000 | x1.000 | level | 2 of 4 | - | - | x0.998 | x0.967 | x0.996 |
| blake3-servil-mt / solo / ManyMessages / 65536 | 12.047 | 12.100 | x1.004 | level | 1 of 4 | - | - | x1.004 | x0.974 | x1.002 |
| blake3-servil-mt / solo / ManyMessages / 131072 | 10.637 | 10.663 | x1.002 | level | 1 of 4 | - | - | x1.002 | x0.979 | x1.003 |
| blake3-servil-mt / solo / ManyMessages / 262144 | 10.005 | 9.965 | x0.996 | level | 3 of 4 | - | - | x0.999 | x0.970 | x1.002 |
| blake3-servil-mt / solo / ManyLongMessages / 4 | 8184.981 | 8253.432 | x1.008 | level | 1 of 4 | - | - | x1.005 | x1.000 | x1.075 |
| blake3-servil-mt / solo / ManyLongMessages / 16 | 4952.959 | 4237.658 | x0.856 | level | 4 of 4 | - | - | x0.857 | x0.567 | x1.121 |
| blake3-servil-mt / solo / ManyLongMessages / 64 | 1969.142 | 1969.858 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.004 | x0.978 |
| blake3-servil-mt / solo / ManyLongMessages / 256 | 1420.751 | 1396.814 | x0.983 | level | 2 of 4 | - | - | x0.979 | x0.906 | x0.994 |
| blake3-servil-mt / solo / IdleOneMessage / 64 B | 8.385 | 8.573 | x1.022 | level | 1 of 4 | - | - | x1.003 | x1.000 | x0.703 |
| blake3-servil-mt / solo / IdleOneMessage / 128 B | 6.269 | 6.679 | x1.065 | level | 1 of 4 | - | - | x1.010 | x1.000 | x0.491 |
| blake3-servil-mt / solo / IdleOneMessage / 256 B | 4.790 | 4.821 | x1.007 | level | 2 of 4 | - | - | x1.002 | x1.001 | x0.206 |
| blake3-servil-mt / solo / IdleOneMessage / 512 B | 4.128 | 4.250 | x1.030 | level | 1 of 4 | - | - | x0.998 | x1.000 | x0.319 |
| blake3-servil-mt / solo / IdleOneMessage / 1 KiB | 3.735 | 3.691 | x0.988 | level | 3 of 4 | - | - | x0.997 | x1.000 | - |
| blake3-servil-mt / solo / IdleOneMessage / 1536 B | 7.759 | 8.297 | x1.069 | level | 1 of 4 | - | - | x1.063 | x0.997 | x1.425 |
| blake3-servil-mt / solo / IdleOneMessage / 2 KiB | 6.527 | 6.576 | x1.007 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.483 |
| blake3-servil-mt / solo / IdleOneMessage / 2304 B | 6.333 | 6.541 | x1.033 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.728 |
| blake3-servil-mt / solo / IdleOneMessage / 3 KiB | 4.607 | 4.573 | x0.993 | level | 3 of 4 | - | - | x1.001 | x1.000 | x0.620 |
| blake3-servil-mt / solo / IdleOneMessage / 3839 B | 3.858 | 3.775 | x0.978 | level | 3 of 4 | - | - | x1.005 | x1.000 | x0.816 |
| blake3-servil-mt / solo / IdleOneMessage / 4 KiB | 3.512 | 3.375 | x0.961 | level | 4 of 4 | - | - | x1.003 | x1.000 | x0.796 |
| blake3-servil-mt / solo / IdleOneMessage / 4470 B | 3.657 | 3.716 | x1.016 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.656 |
| blake3-servil-mt / solo / IdleOneMessage / 7935 B | 2.525 | 2.498 | x0.989 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.711 |
| blake3-servil-mt / solo / IdleOneMessage / 8 KiB | 2.406 | 2.369 | x0.985 | level | 2 of 4 | - | - | x1.004 | x1.000 | x0.643 |
| blake3-servil-mt / solo / IdleOneMessage / 16 KiB | 1.545 | 1.561 | x1.011 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.322 |
| blake3-servil-mt / solo / IdleOneMessage / 32 KiB | 1.307 | 1.351 | x1.033 | level | 0 of 4 | - | - | x0.995 | x1.000 | x0.917 |
| blake3-servil-mt / solo / IdleOneMessage / 64 KiB | 0.869 | 0.839 | x0.965 | level | 2 of 4 | - | - | x0.979 | x1.000 | x0.843 |
| blake3-servil-mt / solo / IdleOneMessage / 128 KiB | 0.668 | 0.670 | x1.002 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.929 |
| blake3-servil-mt / solo / IdleOneMessage / 256 KiB | 0.482 | 0.483 | x1.002 | level | 2 of 4 | - | - | x0.986 | x1.000 | x0.952 |
| blake3-servil-mt / solo / IdleOneMessage / 512 KiB | 0.266 | 0.274 | x1.032 | level | 1 of 4 | - | - | x1.020 | x0.949 | x1.049 |
| blake3-servil-mt / solo / IdleOneMessage / 1 MiB | 0.225 | 0.225 | x0.999 | level | 2 of 4 | - | - | x0.996 | x0.900 | x0.900 |
| blake3-servil-mt / solo / IdleOneMessage / 2 MiB | 0.173 | 0.172 | x0.992 | level | 3 of 4 | - | - | x0.992 | x0.949 | x1.032 |
| blake3-servil-mt / solo / IdleOneMessage / 3 MiB | 0.156 | 0.156 | x0.998 | level | 3 of 4 | - | - | x0.997 | x0.949 | x1.057 |
| blake3-servil-mt / solo / IdleOneMessage / 4 MiB | 0.149 | 0.149 | x1.000 | level | 1 of 4 | - | - | x0.999 | x0.980 | x1.019 |
| blake3-servil-mt / solo / IdleOneMessage / 8 MiB | 0.131 | 0.131 | x1.002 | level | 1 of 4 | - | - | x1.001 | x1.011 | x0.976 |
| blake3-servil-mt / solo / IdleOneMessage / 32 MiB | 0.110 | 0.110 | x0.997 | level | 2 of 4 | - | - | x0.999 | x0.997 | x0.994 |
| blake3-servil-mt / solo / IdleOneMessage / 64 MiB | 0.104 | 0.104 | x1.002 | level | 1 of 4 | - | - | x1.002 | x0.998 | x0.999 |
| blake3-servil-mt / solo / IdleOneMessage / 128 MiB | 0.104 | 0.104 | x0.998 | level | 3 of 4 | - | - | x1.000 | x0.995 | x0.998 |
| blake3-servil-mt / solo / IdleManyMessages / 1 | 727.746 | 691.725 | x0.951 | level | 3 of 4 | - | - | x1.001 | x1.003 | x1.522 |
| blake3-servil-mt / solo / IdleManyMessages / 2 | 769.668 | 762.713 | x0.991 | level | 1 of 4 | - | - | x1.004 | x0.998 | x0.908 |
| blake3-servil-mt / solo / IdleManyMessages / 3 | 785.930 | 825.514 | x1.050 | level | 2 of 4 | - | - | x1.008 | x0.999 | - |
| blake3-servil-mt / solo / IdleManyMessages / 4 | 380.594 | 398.831 | x1.048 | level | 1 of 4 | - | - | x1.000 | x0.998 | x0.905 |
| blake3-servil-mt / solo / IdleManyMessages / 6 | 440.414 | 438.062 | x0.995 | level | 3 of 4 | - | - | x0.999 | x0.999 | x0.850 |
| blake3-servil-mt / solo / IdleManyMessages / 8 | 294.137 | 295.349 | x1.004 | level | 2 of 4 | - | - | x0.992 | x0.998 | x1.188 |
| blake3-servil-mt / solo / IdleManyMessages / 12 | 289.449 | 285.691 | x0.987 | level | 3 of 4 | - | - | x1.007 | x0.999 | x0.587 |
| blake3-servil-mt / solo / IdleManyMessages / 16 | 195.411 | 202.427 | x1.036 | level | 1 of 4 | - | - | x1.001 | x0.999 | x1.658 |
| blake3-servil-mt / solo / IdleManyMessages / 24 | 221.427 | 220.145 | x0.994 | level | 2 of 4 | - | - | x0.998 | x0.999 | x0.880 |
| blake3-servil-mt / solo / IdleManyMessages / 32 | 181.056 | 177.723 | x0.982 | level | 3 of 4 | - | - | x1.002 | x0.999 | x1.713 |
| blake3-servil-mt / solo / IdleManyMessages / 48 | 175.454 | 173.055 | x0.986 | level | 3 of 4 | - | - | x1.002 | x0.999 | x1.698 |
| blake3-servil-mt / solo / IdleManyMessages / 64 | 166.554 | 167.265 | x1.004 | level | 2 of 4 | - | - | x0.999 | x0.999 | x1.087 |
| blake3-servil-mt / solo / IdleManyMessages / 128 | 123.897 | 123.514 | x0.997 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.373 |
| blake3-servil-mt / solo / IdleManyMessages / 256 | 96.880 | 98.733 | x1.019 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.669 |
| blake3-servil-mt / solo / IdleManyMessages / 512 | 82.697 | 82.798 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.751 |
| blake3-servil-mt / solo / IdleManyMessages / 1024 | 53.627 | 53.906 | x1.005 | level | 2 of 4 | - | - | x1.004 | x1.000 | x1.292 |
| blake3-servil-mt / solo / IdleManyMessages / 2048 | 43.046 | 43.580 | x1.012 | level | 2 of 4 | - | - | x1.015 | x1.000 | x0.972 |
| blake3-servil-mt / solo / IdleManyMessages / 4096 | 31.219 | 31.032 | x0.994 | level | 3 of 4 | - | - | x1.001 | x1.000 | x1.189 |
| blake3-servil-mt / solo / IdleManyMessages / 8192 | 13.527 | 13.726 | x1.015 | level | 1 of 4 | - | - | x1.028 | x0.999 | x1.046 |
| blake3-servil-mt / solo / IdleManyMessages / 16384 | 11.605 | 11.802 | x1.017 | level | 1 of 4 | - | - | x1.015 | x1.017 | x0.980 |
| blake3-servil-mt / solo / IdleManyMessages / 32768 | 10.606 | 10.587 | x0.998 | level | 3 of 4 | - | - | x1.004 | x0.934 | x1.009 |
| blake3-servil-mt / solo / IdleManyMessages / 65536 | 9.403 | 9.445 | x1.004 | level | 2 of 4 | - | - | x1.003 | x1.006 | x0.998 |
| blake3-servil-mt / solo / IdleManyMessages / 131072 | 8.498 | 8.509 | x1.001 | level | 1 of 4 | - | - | x1.000 | x0.992 | x1.015 |
| blake3-servil-mt / solo / IdleManyMessages / 262144 | 7.961 | 7.951 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.012 | x0.965 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 B | 3.329 | 3.323 | x0.998 | level | 1 of 4 | - | - | x0.997 | x0.998 | x0.863 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 B | 2.413 | 2.450 | x1.015 | level | 1 of 4 | - | - | x1.005 | x1.000 | x0.787 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 B | 1.813 | 1.825 | x1.007 | level | 1 of 4 | - | - | x0.998 | x1.000 | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 B | 1.643 | 1.639 | x0.997 | level | 1 of 4 | - | - | x0.998 | x1.000 | x0.871 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 KiB | 1.515 | 1.532 | x1.011 | level | 1 of 4 | - | - | x1.009 | x1.000 | x2.564 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1536 B | 1.240 | 1.277 | x1.030 | level | 1 of 4 | - | - | x1.020 | x0.997 | x4.629 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 KiB | 0.902 | 0.890 | x0.987 | level | 4 of 4 | - | - | x0.994 | x1.000 | x1.648 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2304 B | 1.036 | 1.027 | x0.992 | level | 3 of 4 | - | - | x0.993 | x1.000 | x1.222 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 KiB | 0.793 | 0.816 | x1.029 | level | 2 of 4 | - | - | x1.014 | x1.000 | x0.832 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3839 B | 0.587 | 0.586 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.635 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 KiB | 0.483 | 0.489 | x1.014 | level | 1 of 4 | - | - | x1.011 | x1.000 | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4470 B | 0.594 | 0.594 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 7935 B | 0.444 | 0.442 | x0.995 | level | 2 of 4 | - | - | x0.995 | x1.000 | x1.302 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 KiB | 0.394 | 0.392 | x0.995 | level | 2 of 4 | - | - | x0.995 | x1.000 | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 16 KiB | 0.296 | 0.296 | x1.000 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.049 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 KiB | 0.293 | 0.295 | x1.007 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.018 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 KiB | 0.287 | 0.286 | x0.999 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.814 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 KiB | 0.282 | 0.283 | x1.003 | level | 1 of 4 | - | - | x1.000 | x1.000 | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 KiB | 0.281 | 0.280 | x0.998 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.505 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 KiB | 0.140 | 0.150 | x1.070 | level | 1 of 4 | - | - | x1.074 | x1.025 | x1.318 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 MiB | 0.156 | 0.157 | x1.004 | level | 2 of 4 | - | - | x1.007 | x0.973 | x0.757 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 MiB | 0.133 | 0.134 | x1.004 | level | 2 of 4 | - | - | x1.003 | x1.013 | x0.932 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 MiB | 0.122 | 0.122 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.003 | x1.002 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 MiB | 0.119 | 0.120 | x1.003 | level | 0 of 4 | - | - | x1.001 | x0.987 | x0.980 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 MiB | 0.132 | 0.132 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.001 | x0.881 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 MiB | 0.110 | 0.109 | x0.992 | level | 4 of 4 | - | - | x0.993 | x0.996 | x1.006 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 MiB | 0.107 | 0.107 | x1.002 | level | 1 of 4 | - | - | x1.000 | x0.998 | x1.046 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 MiB | 0.104 | 0.104 | x1.000 | level | 2 of 4 | - | - | x1.000 | x0.996 | x0.999 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1 | 234.522 | 241.861 | x1.031 | level | 2 of 4 | - | - | x1.010 | x1.002 | x0.902 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2 | 200.306 | 202.897 | x1.013 | level | 2 of 4 | - | - | x1.005 | x0.997 | x1.040 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 3 | 132.398 | 140.067 | x1.058 | level | 2 of 4 | - | - | x1.029 | x0.999 | x0.866 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4 | 68.878 | 66.051 | x0.959 | level | 3 of 4 | - | - | x0.982 | x0.998 | x0.438 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 6 | 59.783 | 60.145 | x1.006 | level | 2 of 4 | - | - | x1.000 | x0.998 | x1.498 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8 | 41.866 | 41.823 | x0.999 | level | 2 of 4 | - | - | x0.998 | x0.998 | x1.675 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 12 | 36.896 | 37.015 | x1.003 | level | 2 of 4 | - | - | x1.000 | x0.999 | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16 | 26.732 | 26.456 | x0.990 | level | 3 of 4 | - | - | x0.996 | x0.998 | x3.889 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 24 | 27.009 | 26.818 | x0.993 | level | 3 of 4 | - | - | x0.994 | x0.999 | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32 | 22.648 | 21.833 | x0.964 | level | 3 of 4 | - | - | x0.997 | x0.999 | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 48 | 19.777 | 19.744 | x0.998 | level | 2 of 4 | - | - | x0.998 | x0.999 | x1.155 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 64 | 18.939 | 19.082 | x1.008 | level | 1 of 4 | - | - | x1.005 | x0.999 | x1.191 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 128 | 17.828 | 17.930 | x1.006 | level | 2 of 4 | - | - | x1.004 | x1.000 | x1.183 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 256 | 18.208 | 18.330 | x1.007 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.901 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 512 | 18.370 | 18.314 | x0.997 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.908 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1024 | 18.074 | 18.085 | x1.001 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.008 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2048 | 18.024 | 17.988 | x0.998 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.948 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4096 | 18.000 | 17.993 | x1.000 | level | 1 of 4 | - | - | x0.999 | x1.000 | x0.868 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8192 | 11.093 | 10.924 | x0.985 | level | 3 of 4 | - | - | x0.985 | x0.957 | x1.054 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16384 | 9.513 | 9.565 | x1.005 | level | 1 of 4 | - | - | x1.005 | x0.956 | x0.948 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32768 | 8.441 | 8.470 | x1.003 | level | 1 of 4 | - | - | x1.005 | x1.000 | x1.003 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 65536 | 8.050 | 8.029 | x0.997 | level | 3 of 4 | - | - | x0.998 | x0.997 | x1.002 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 131072 | 8.499 | 8.520 | x1.002 | level | 1 of 4 | - | - | x1.003 | x1.001 | x1.009 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 262144 | 8.054 | 7.994 | x0.993 | level | 3 of 4 | - | - | x0.992 | x0.970 | x0.923 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 1.122 | 1.100 | x0.981 | level | 3 of 4 | x0.981 | - | x0.980 | x0.972 | x0.918 |
| blake3-servil-mt / solo / ContinuousMessages / 128 B | 0.547 | 0.550 | x1.005 | level | 3 of 4 | x0.995 | - | x1.005 | x0.973 | x1.431 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.295 | 0.292 | x0.989 | level | 3 of 4 | x1.003 | - | x0.989 | x0.973 | x0.740 |
| blake3-servil-mt / solo / ContinuousMessages / 512 B | 0.197 | 0.192 | x0.977 | level | 4 of 4 | x0.976 | - | x0.976 | x0.976 | x1.584 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.149 | 0.147 | x0.986 | level | 3 of 4 | x0.958 | - | x0.987 | x0.982 | x1.304 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.102 | 0.0967 | x0.950 | level | 4 of 4 | x0.991 | - | x0.951 | x0.971 | x0.715 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0931 | 0.0937 | x1.007 | level | 2 of 4 | x0.992 | - | x1.007 | x0.964 | x0.729 |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.0753 | 0.0757 | x1.005 | level | 1 of 4 | x1.005 | - | x1.006 | x1.028 | x1.574 |
| blake3-servil-mt / solo / ContinuousMessages / 256 KiB | 0.0740 | 0.0744 | x1.006 | level | 1 of 4 | x0.991 | - | x1.007 | x1.010 | x1.114 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0868 | 0.0854 | x0.984 | level | 3 of 4 | x0.994 | - | x0.984 | x1.017 | x0.931 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.102 | 0.101 | x0.987 | level | 3 of 4 | x1.047 | - | x0.988 | x0.997 | x0.991 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0991 | 0.0976 | x0.985 | level | 4 of 4 | x1.020 | - | x0.985 | x0.997 | x1.139 |
| blake3-servil-mt / solo / ContinuousMessages / 64 MiB | 0.110 | 0.109 | x0.991 | level | 4 of 4 | x0.990 | - | x0.991 | x1.006 | x1.006 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 15.260 | 14.930 | x0.978 | level | 4 of 4 | x0.991 | - | x0.978 | x0.976 | x1.289 |
| blake3-servil-mt / solo / ContinuousBatches / 64 | 9.024 | 8.887 | x0.985 | level | 4 of 4 | x1.020 | - | x0.985 | x0.984 | x0.855 |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 7.481 | 7.373 | x0.986 | level | 4 of 4 | x0.989 | - | x0.985 | x0.978 | x1.073 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 6.939 | 6.900 | x0.994 | level | 3 of 4 | x0.987 | - | x0.995 | x1.049 | x0.422 |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 7.075 | 6.986 | x0.987 | level | 4 of 4 | x0.992 | - | x0.988 | x0.701 | x1.701 |
| blake3-servil-mt / solo / ContinuousBatches / 16384 | 9.289 | 9.249 | x0.996 | level | 2 of 4 | x1.012 | - | x0.995 | x1.174 | x1.219 |
| blake3-servil-mt / solo / ContinuousBatches / 65536 | 9.151 | 9.074 | x0.992 | level | 3 of 4 | x1.001 | - | x0.992 | x1.003 | x0.878 |
| blake3-servil-mt / solo / LentMessages / 64 B | 1.542 | 1.519 | x0.985 | level | 2 of 4 | x0.986 | - | x0.986 | x1.000 | - |
| blake3-servil-mt / solo / LentMessages / 128 B | 1.446 | 1.442 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | - |
| blake3-servil-mt / solo / LentMessages / 256 B | 1.417 | 1.410 | x0.995 | level | 2 of 4 | x0.995 | - | x0.995 | x1.000 | - |
| blake3-servil-mt / solo / LentMessages / 512 B | 1.408 | 1.407 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | - |
| blake3-servil-mt / solo / LentMessages / 1 KiB | 1.399 | 1.400 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x6.363 |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.438 | 0.438 | x1.002 | level | 1 of 4 | x1.005 | - | x1.005 | x1.000 | - |
| blake3-servil-mt / solo / LentMessages / 16 KiB | 0.271 | 0.271 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | x0.651 |
| blake3-servil-mt / solo / LentMessages / 64 KiB | 0.280 | 0.280 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | - |
| blake3-servil-mt / solo / LentMessages / 256 KiB | 0.277 | 0.277 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x0.465 |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.133 | 0.132 | x0.994 | level | 2 of 4 | x0.999 | - | x0.994 | x1.056 | x1.876 |
| blake3-servil-mt / solo / LentMessages / 4 MiB | 0.119 | 0.117 | x0.981 | level | 3 of 4 | x1.005 | - | x0.982 | x0.974 | x1.187 |
| blake3-servil-mt / solo / LentMessages / 16 MiB | 0.118 | 0.117 | x0.988 | level | 3 of 4 | x1.015 | - | x0.988 | x1.018 | x1.081 |
| blake3-servil-mt / solo / LentMessages / 64 MiB | 0.112 | 0.110 | x0.989 | level | 3 of 4 | x0.999 | - | x0.989 | x1.000 | x1.001 |
| blake3-servil-mt / solo / Interleaved / 256 | 0.394 | 0.391 | x0.993 | level | 4 of 4 | x0.993 | - | x0.993 | x0.998 | x0.987 |
| blake3-servil-mt / solo / Collection / git objects | 0.0163 | 0.0162 | x0.996 | level | 1 of 4 | x0.999 | - | x0.997 | x1.000 | x1.023 |
| blake3-servil-mt / solo / Collection / Nix files | 0.0244 | 0.0243 | x0.997 | level | 2 of 4 | x1.000 | - | x0.996 | x1.013 | x1.195 |
| blake3-servil-mt / solo / LentBatches / 16 | 21.046 | 20.911 | x0.994 | level | 2 of 4 | x0.994 | - | x0.994 | x0.998 | - |
| blake3-servil-mt / solo / LentBatches / 64 | 17.986 | 18.017 | x1.002 | level | 2 of 4 | x1.002 | - | x1.003 | x0.999 | - |
| blake3-servil-mt / solo / LentBatches / 256 | 17.772 | 17.926 | x1.009 | level | 1 of 4 | x1.006 | - | x1.005 | x1.000 | x0.785 |
| blake3-servil-mt / solo / LentBatches / 1024 | 19.090 | 19.414 | x1.017 | level | 0 of 4 | x1.017 | - | x1.016 | x0.999 | - |
| blake3-servil-mt / solo / LentBatches / 4096 | 19.208 | 19.307 | x1.005 | level | 1 of 4 | x1.005 | - | x1.005 | x1.000 | - |
| blake3-servil-mt / solo / LentBatches / 16384 | 11.326 | 11.265 | x0.995 | level | 2 of 4 | x1.000 | - | x0.995 | x1.008 | x0.030 |
| blake3-servil-mt / solo / LentBatches / 65536 | 10.180 | 10.155 | x0.998 | level | 2 of 4 | x0.986 | - | x0.998 | x1.004 | x0.326 |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.111 | 0.109 | x0.982 | level | 3 of 4 | x0.979 | - | x0.983 | x0.983 | x0.978 |
| blake3-servil-mt / solo / ContinuousCollection / Nix files | 0.110 | 0.107 | x0.975 | level | 4 of 4 | x0.989 | - | x0.978 | x0.987 | x0.995 |
| blake3-servil-mt / solo / MerkleTree / 1024 | 0.350 | 0.350 | x1.001 | level | 2 of 4 | x1.000 | - | x1.000 | x1.001 | x3.601 |
| blake3-servil-mt / solo / MerkleTree / 4096 | 0.231 | 0.230 | x0.996 | level | 4 of 4 | x1.003 | - | x0.997 | x1.009 | x0.630 |
| blake3-servil-mt / solo / MerkleTree / 16384 | 0.203 | 0.191 | x0.942 | level | 4 of 4 | x0.882 | - | x0.943 | x0.933 | x0.791 |
| blake3-servil-mt / solo / MerkleTree / 65536 | 0.168 | 0.166 | x0.988 | level | 4 of 4 | x0.998 | - | x0.990 | x0.996 | x1.012 |
| blake3-servil-mt / solo / MerkleTree / 262144 | 0.148 | 0.146 | x0.991 | level | 3 of 4 | x1.002 | - | x0.991 | x1.001 | x1.010 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 32 B | 0.260 | 0.259 | x0.995 | level | 3 of 4 | x1.013 | - | x0.994 | x0.989 | x0.515 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 32 B | 0.152 | 0.150 | x0.987 | level | 4 of 4 | x1.003 | - | x0.988 | x1.002 | x1.014 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 16 B | 0.277 | 0.276 | x0.996 | level | 4 of 4 | x1.003 | - | x0.995 | x0.999 | x0.994 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 48 B | 0.211 | 0.210 | x0.995 | level | 3 of 4 | x1.016 | - | x0.994 | x0.995 | x0.781 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 48 B | 0.141 | 0.139 | x0.987 | level | 3 of 4 | x1.001 | - | x0.988 | x1.001 | x1.013 |
| blake3-servil-mt / solo / InterleavedTurn / 256 | 0.998 | 1.009 | x1.011 | level | 0 of 4 | - | - | x1.013 | x1.010 | x0.991 |
| blake3-servil-mt / solo / InterleavedTurn / 1024 x 1 KiB | 0.707 | 0.696 | x0.984 | level | 3 of 4 | - | - | x0.980 | x0.988 | x0.994 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 256 | 0.660 | 0.675 | x1.023 | level | 0 of 4 | - | - | x1.026 | x0.990 | x0.991 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.652 | 0.667 | x1.023 | level | 2 of 4 | - | - | x1.022 | x0.988 | x0.990 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 256 | 0.666 | 0.670 | x1.006 | level | 2 of 4 | - | - | x0.999 | x0.954 | x1.003 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.620 | 0.624 | x1.007 | level | 2 of 4 | - | - | x1.006 | x0.990 | x0.983 |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.104 | 0.104 | x0.997 | level | 2 of 4 | x0.985 | - | x0.998 | x1.004 | x1.046 |
| blake3-servil-mt / solo / ReceivingMessage / 2 μs | 0.105 | 0.105 | x1.003 | level | 3 of 4 | x0.973 | - | x1.005 | x0.999 | x0.925 |
| blake3-servil-mt / solo / ReceivingMessage / 20 μs | 0.918 | 0.918 | x1.000 | level | 3 of 4 | x0.994 | - | x0.987 | x1.006 | x1.018 |
| blake3-servil-mt / solo / IncrementalMessage / 64 B | 20.712 | 20.933 | x1.011 | level | 1 of 4 | - | - | x1.009 | x1.000 | x1.171 |
| blake3-servil-mt / solo / IncrementalMessage / 1 KiB | 3.924 | 3.931 | x1.002 | level | 3 of 4 | - | - | x1.011 | x1.000 | x1.165 |
| blake3-servil-mt / solo / IncrementalMessage / 4 KiB | 2.476 | 2.467 | x0.996 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.059 |
| blake3-servil-mt / solo / LentIncrementalMessage / 64 B | 1.855 | 1.869 | x1.008 | level | 2 of 4 | x1.008 | - | x1.008 | x1.000 | - |
| blake3-servil-mt / solo / LentIncrementalMessage / 1 KiB | 1.436 | 1.439 | x1.002 | level | 1 of 4 | x1.002 | - | x1.001 | x1.000 | x0.749 |
| blake3-servil-mt / solo / LentIncrementalMessage / 4 KiB | 0.456 | 0.458 | x1.004 | level | 2 of 4 | x1.004 | - | x1.004 | x1.000 | x1.001 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 13.171 | 13.643 | x1.036 | level | 0 of 4 | x1.225 | - | x1.021 | x0.946 | x11.326 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 4 KiB | 0.254 | 0.253 | x0.994 | level | 2 of 4 | x0.984 | - | x0.997 | x0.946 | x6.920 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 1 MiB | 0.0855 | 0.0848 | x0.993 | level | 2 of 4 | x1.011 | - | x0.992 | x0.996 | x0.836 |
| blake3-servil-mt / solo / ContinuousLentMessages / 64 B | 1.005 | 1.002 | x0.997 | level | 2 of 4 | x0.974 | - | x0.997 | x0.969 | x0.762 |
| blake3-servil-mt / solo / ContinuousLentMessages / 4 KiB | 0.0511 | 0.0499 | x0.977 | level | 4 of 4 | x1.061 | - | x0.976 | x0.964 | x1.186 |
| blake3-servil-mt / solo / ContinuousLentMessages / 1 MiB | 0.00875 | 0.00870 | x0.995 | level | 3 of 4 | x1.000 | - | x0.995 | x1.001 | x0.859 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 1.211 | 1.064 | x0.879 | level | 4 of 4 | - | - | x0.879 | x0.972 | x0.872 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 128 B | 0.625 | 0.555 | x0.888 | level | 4 of 4 | - | - | x0.888 | x0.973 | x0.991 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.374 | 0.309 | x0.825 | level | 4 of 4 | - | - | x0.826 | x0.973 | x0.881 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 512 B | 0.246 | 0.224 | x0.908 | level | 3 of 4 | - | - | x0.909 | x0.976 | x1.060 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.172 | 0.164 | x0.957 | level | 3 of 4 | - | - | x0.960 | x0.980 | x1.071 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.109 | 0.103 | x0.945 | level | 4 of 4 | - | - | x0.949 | x0.971 | x1.034 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.105 | 0.106 | x1.010 | level | 1 of 4 | - | - | x1.011 | x0.964 | x0.975 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.0810 | 0.0810 | x0.999 | level | 1 of 4 | - | - | x0.999 | x1.025 | x1.117 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 KiB | 0.0804 | 0.0801 | x0.996 | level | 2 of 4 | - | - | x0.997 | x1.009 | x0.974 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0905 | 0.0888 | x0.981 | level | 2 of 4 | - | - | x0.981 | x1.024 | x0.942 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.106 | 0.103 | x0.965 | level | 4 of 4 | - | - | x0.966 | x1.009 | x0.987 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.106 | 0.104 | x0.981 | level | 3 of 4 | - | - | x0.983 | x1.013 | x0.964 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 MiB | 0.132 | 0.126 | x0.957 | level | 4 of 4 | - | - | x0.958 | x1.012 | x1.104 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 16.072 | 15.410 | x0.959 | level | 4 of 4 | - | - | x0.964 | x0.976 | x1.077 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 64 | 9.902 | 9.392 | x0.948 | level | 4 of 4 | - | - | x0.949 | x0.982 | x0.994 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 256 | 7.912 | 7.739 | x0.978 | level | 4 of 4 | - | - | x0.979 | x0.984 | x0.575 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 7.396 | 7.214 | x0.975 | level | 3 of 4 | - | - | x0.977 | x1.037 | x0.635 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 4096 | 7.673 | 7.503 | x0.978 | level | 3 of 4 | - | - | x0.984 | x1.083 | x0.889 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16384 | 9.698 | 9.617 | x0.992 | level | 3 of 4 | - | - | x0.992 | x1.010 | x0.732 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 65536 | 9.302 | 9.146 | x0.983 | level | 4 of 4 | - | - | x0.984 | x1.005 | x0.740 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 1.519 | 1.522 | x1.002 | level | 2 of 4 | - | - | x1.001 | x1.000 | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 128 B | 1.444 | 1.444 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 B | 1.432 | 1.415 | x0.988 | level | 4 of 4 | - | - | x0.987 | x1.000 | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 512 B | 1.410 | 1.417 | x1.005 | level | 0 of 4 | - | - | x1.002 | x1.000 | x1.089 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 KiB | 1.398 | 1.398 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.181 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.441 | 0.436 | x0.988 | level | 4 of 4 | - | - | x0.988 | x1.000 | x3.976 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 KiB | 0.272 | 0.271 | x0.998 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.690 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 KiB | 0.280 | 0.280 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.201 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 KiB | 0.277 | 0.277 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.653 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 MiB | 0.151 | 0.152 | x1.002 | level | 2 of 4 | - | - | x1.000 | x1.028 | x1.331 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 MiB | 0.125 | 0.125 | x0.994 | level | 3 of 4 | - | - | x0.995 | x0.973 | x0.897 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 MiB | 0.139 | 0.140 | x1.009 | level | 1 of 4 | - | - | x1.010 | x0.979 | x0.959 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 MiB | 0.124 | 0.125 | x1.003 | level | 1 of 4 | - | - | x1.002 | x1.001 | x1.003 |
| blake3-servil-mt / shared-one-cache / Interleaved / 256 | 0.385 | 0.385 | x1.002 | level | 2 of 4 | - | - | x0.999 | x0.999 | x0.829 |
| blake3-servil-mt / shared-one-cache / Collection / git objects | 0.0266 | 0.0274 | x1.030 | level | 0 of 4 | - | - | x0.988 | x0.992 | x0.992 |
| blake3-servil-mt / shared-one-cache / Collection / Nix files | 0.0331 | 0.0323 | x0.975 | level | 4 of 4 | - | - | x0.984 | x1.012 | x0.988 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16 | 20.672 | 20.910 | x1.012 | level | 0 of 4 | - | - | x1.017 | x0.998 | x0.223 |
| blake3-servil-mt / shared-one-cache / LentBatches / 64 | 18.055 | 18.067 | x1.001 | level | 2 of 4 | - | - | x1.001 | x0.999 | - |
| blake3-servil-mt / shared-one-cache / LentBatches / 256 | 17.749 | 17.625 | x0.993 | level | 4 of 4 | - | - | x0.991 | x1.000 | x0.715 |
| blake3-servil-mt / shared-one-cache / LentBatches / 1024 | 19.331 | 19.177 | x0.992 | level | 4 of 4 | - | - | x0.992 | x1.000 | x3.241 |
| blake3-servil-mt / shared-one-cache / LentBatches / 4096 | 19.281 | 19.078 | x0.989 | level | 4 of 4 | - | - | x0.989 | x1.000 | x0.779 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16384 | 12.777 | 12.604 | x0.986 | level | 4 of 4 | - | - | x0.987 | x1.003 | x0.873 |
| blake3-servil-mt / shared-one-cache / LentBatches / 65536 | 10.632 | 10.524 | x0.990 | level | 4 of 4 | - | - | x0.990 | x0.972 | x0.445 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.128 | 0.125 | x0.974 | level | 4 of 4 | - | - | x0.975 | x0.983 | x1.054 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / Nix files | 0.125 | 0.123 | x0.985 | level | 2 of 4 | - | - | x0.985 | x0.987 | x1.000 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1024 | 0.350 | 0.351 | x1.002 | level | 3 of 4 | - | - | x0.997 | x1.001 | x1.516 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 4096 | 0.252 | 0.250 | x0.991 | level | 4 of 4 | - | - | x0.992 | x0.991 | x1.250 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 16384 | 0.204 | 0.202 | x0.992 | level | 2 of 4 | - | - | x0.994 | x0.991 | x0.686 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 | 0.192 | 0.192 | x0.998 | level | 3 of 4 | - | - | x0.999 | x1.002 | x0.995 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 262144 | 0.176 | 0.175 | x0.996 | level | 2 of 4 | - | - | x0.996 | x0.997 | x1.000 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 32 B | 0.287 | 0.282 | x0.980 | level | 4 of 4 | - | - | x0.985 | x1.017 | x1.243 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 32 B | 0.231 | 0.234 | x1.010 | level | 1 of 4 | - | - | x1.007 | x1.020 | x0.993 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 16 B | 0.422 | 0.424 | x1.005 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.003 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 48 B | 0.231 | 0.227 | x0.979 | level | 4 of 4 | - | - | x0.982 | x1.010 | x0.704 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 48 B | 0.197 | 0.196 | x0.994 | level | 4 of 4 | - | - | x0.994 | x0.999 | x0.992 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.109 | 0.109 | x0.992 | level | 2 of 4 | - | - | x0.992 | x1.004 | x0.985 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 2 μs | 0.111 | 0.110 | x0.991 | level | 3 of 4 | - | - | x0.989 | x1.015 | x0.979 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 20 μs | 0.918 | 0.918 | x1.000 | level | 1 of 4 | - | - | x0.990 | x1.011 | x1.028 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 64 B | 1.852 | 1.860 | x1.004 | level | 2 of 4 | - | - | x1.004 | x1.000 | x0.986 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 1 KiB | 1.436 | 1.438 | x1.001 | level | 0 of 4 | - | - | x1.000 | x1.000 | x1.057 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 4 KiB | 0.454 | 0.455 | x1.003 | level | 0 of 4 | - | - | x1.003 | x1.000 | x0.850 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 18.020 | 17.668 | x0.980 | level | 3 of 4 | - | - | x1.001 | x0.946 | x22.763 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 4 KiB | 0.294 | 0.289 | x0.984 | level | 2 of 4 | - | - | x0.983 | x0.946 | x15.838 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 1 MiB | 0.0905 | 0.0874 | x0.966 | level | 2 of 4 | - | - | x0.970 | x1.030 | x0.893 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 64 B | 1.170 | 0.984 | x0.841 | level | 4 of 4 | - | - | x0.842 | x0.969 | x0.723 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 4 KiB | 0.0652 | 0.0628 | x0.964 | level | 4 of 4 | - | - | x0.964 | x0.964 | x1.638 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 1 MiB | 0.0169 | 0.0173 | x1.025 | level | 2 of 4 | - | - | x1.016 | x1.013 | x1.046 |

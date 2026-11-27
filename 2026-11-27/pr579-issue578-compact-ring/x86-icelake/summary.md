# Nightly drift check: 2557d53c772e -> 7f392fdebc90

- Host: fast-feedback-icelake-147
- Experiment: `bench=3f119a507807078649d8700112994fce24666868|base=2557d53c772edfa2f3eeb28b8c8827919a27d608|target=7f392fdebc90aa362c7115cceb1824df2319102b|cells=all|layouts=default`
- bench-hashes: `3f119a507807078649d8700112994fce24666868`
- BLAKE3-Servil base: `2557d53c772edfa2f3eeb28b8c8827919a27d608`
- BLAKE3-Servil target: `7f392fdebc90aa362c7115cceb1824df2319102b`
- Scope: `--cells all` (layouts: default)
- Deciding stage: stage 2 (kept-drift/second)
- Verdict: **no regression** (exit `0`)

## Stage 2 (deciding, kept-drift/second)

compare: old side: bench 3f119a507807 clean; servil 2557d53c772e clean
compare: new side: bench 3f119a507807 clean; servil 7f392fdebc90 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / BriefIdleManyMessages / 2 | 127.428 | 127.133 | x0.998 | level | 38 of 64 | - | - | x1.002 | x1.000 | - |
| blake3-servil-mt / solo / OneMessage / 64 B | 16.351 | 16.749 | x1.024 | level | 29 of 64 | - | - | x1.020 | x1.000 | x1.088 |
| blake3-servil-mt / solo / OneMessage / 128 B | 9.704 | 9.885 | x1.019 | level | 27 of 64 | - | - | x1.017 | x1.000 | x1.079 |
| blake3-servil-mt / solo / ManyMessages / 1 | 1210.714 | 1222.560 | x1.010 | level | 29 of 64 | - | - | x1.010 | x1.000 | x1.055 |
| blake3-servil-mt / solo / IdleOneMessage / 64 B | 8.443 | 8.504 | x1.007 | level | 27 of 64 | - | - | x1.009 | x1.000 | x1.104 |
| blake3-servil-mt / solo / IdleManyMessages / 1 | 631.562 | 643.759 | x1.019 | level | 28 of 64 | - | - | x1.016 | x1.000 | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8192 | 9.826 | 9.879 | x1.005 | level | 32 of 64 | - | - | x1.002 | x1.014 | x0.957 |
| blake3-servil-mt / solo / ContinuousMessages / 512 B | 0.194 | 0.192 | x0.990 | level | 37 of 64 | x1.018 | - | x0.990 | x0.996 | x0.876 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 512 B | 0.225 | 0.219 | x0.973 | level | 43 of 64 | - | - | x0.973 | x0.996 | x1.013 |

## Stage 1 (initial screen, kept-drift)

compare: old side: bench 3f119a507807 clean; servil 2557d53c772e clean
compare: new side: bench 3f119a507807 clean; servil 7f392fdebc90 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 18.326 | 18.462 | x1.007 | level | 2 of 4 | - | - | x1.008 | x1.002 | x1.030 |
| blake3-servil-st / solo / OneMessage / 128 B | 10.526 | 10.799 | x1.026 | level | 1 of 4 | - | - | x1.016 | x1.000 | x1.014 |
| blake3-servil-st / solo / OneMessage / 256 B | 5.899 | 6.090 | x1.033 | level | 2 of 4 | - | - | x1.023 | x1.000 | x1.028 |
| blake3-servil-st / solo / OneMessage / 512 B | 3.762 | 3.786 | x1.006 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.033 |
| blake3-servil-st / solo / OneMessage / 1 KiB | 2.676 | 2.645 | x0.989 | level | 2 of 4 | - | - | x1.010 | x1.000 | x1.048 |
| blake3-servil-st / solo / OneMessage / 1536 B | 4.998 | 4.960 | x0.992 | level | 2 of 4 | - | - | x0.978 | x1.000 | x0.984 |
| blake3-servil-st / solo / OneMessage / 2 KiB | 4.216 | 4.199 | x0.996 | level | 2 of 4 | - | - | x0.989 | x1.000 | x0.998 |
| blake3-servil-st / solo / OneMessage / 2304 B | 4.456 | 4.458 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.003 |
| blake3-servil-st / solo / OneMessage / 3 KiB | 3.149 | 3.138 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.019 |
| blake3-servil-st / solo / OneMessage / 3839 B | 2.748 | 2.732 | x0.994 | level | 2 of 4 | - | - | x0.994 | x1.000 | x1.034 |
| blake3-servil-st / solo / OneMessage / 4 KiB | 2.402 | 2.305 | x0.960 | level | 4 of 4 | - | - | x0.980 | x1.000 | x1.010 |
| blake3-servil-st / solo / OneMessage / 4470 B | 2.496 | 2.532 | x1.014 | level | 1 of 4 | - | - | x1.010 | x1.000 | x1.021 |
| blake3-servil-st / solo / OneMessage / 7935 B | 2.043 | 2.042 | x1.000 | level | 2 of 4 | - | - | x0.990 | x1.000 | x0.996 |
| blake3-servil-st / solo / OneMessage / 8 KiB | 1.848 | 1.820 | x0.985 | level | 4 of 4 | - | - | x0.987 | x1.000 | x1.003 |
| blake3-servil-st / solo / OneMessage / 16 KiB | 1.336 | 1.334 | x0.999 | level | 2 of 4 | - | - | x0.993 | x1.000 | x1.025 |
| blake3-servil-st / solo / OneMessage / 32 KiB | 1.243 | 1.242 | x0.999 | level | 1 of 4 | - | - | x0.998 | x1.000 | x0.989 |
| blake3-servil-st / solo / OneMessage / 64 KiB | 1.061 | 1.060 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.987 |
| blake3-servil-st / solo / OneMessage / 128 KiB | 0.668 | 0.670 | x1.003 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.005 |
| blake3-servil-st / solo / OneMessage / 256 KiB | 0.486 | 0.484 | x0.997 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.990 |
| blake3-servil-st / solo / OneMessage / 512 KiB | 0.423 | 0.423 | x0.999 | level | 1 of 4 | - | - | x0.999 | x1.000 | x1.000 |
| blake3-servil-st / solo / OneMessage / 1 MiB | 0.394 | 0.398 | x1.010 | level | 1 of 4 | - | - | x1.004 | x1.000 | x0.987 |
| blake3-servil-st / solo / OneMessage / 2 MiB | 0.386 | 0.386 | x0.999 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.012 |
| blake3-servil-st / solo / OneMessage / 3 MiB | 0.383 | 0.382 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.007 |
| blake3-servil-st / solo / OneMessage / 4 MiB | 0.379 | 0.380 | x1.003 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.026 |
| blake3-servil-st / solo / OneMessage / 8 MiB | 0.381 | 0.380 | x0.998 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.976 |
| blake3-servil-st / solo / OneMessage / 32 MiB | 0.355 | 0.355 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.001 |
| blake3-servil-st / solo / OneMessage / 64 MiB | 0.354 | 0.355 | x1.001 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.002 |
| blake3-servil-st / solo / OneMessage / 128 MiB | 0.355 | 0.355 | x1.001 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.000 |
| blake3-servil-st / solo / ManyMessages / 1 | 1072.028 | 1101.150 | x1.027 | level | 1 of 4 | - | - | x1.019 | x1.000 | x1.125 |
| blake3-servil-st / solo / ManyMessages / 2 | 917.516 | 844.494 | x0.920 | level | 4 of 4 | - | - | x0.941 | x0.999 | x1.021 |
| blake3-servil-st / solo / ManyMessages / 3 | 714.517 | 660.320 | x0.924 | level | 3 of 4 | - | - | x0.939 | x1.000 | x1.000 |
| blake3-servil-st / solo / ManyMessages / 4 | 429.762 | 415.616 | x0.967 | level | 3 of 4 | - | - | x0.978 | x1.000 | x0.996 |
| blake3-servil-st / solo / ManyMessages / 6 | 373.444 | 360.618 | x0.966 | level | 4 of 4 | - | - | x0.970 | x1.000 | x1.017 |
| blake3-servil-st / solo / ManyMessages / 8 | 274.075 | 258.473 | x0.943 | level | 4 of 4 | - | - | x0.966 | x1.000 | x1.036 |
| blake3-servil-st / solo / ManyMessages / 12 | 219.996 | 209.727 | x0.953 | level | 3 of 4 | - | - | x0.984 | x1.000 | x1.040 |
| blake3-servil-st / solo / ManyMessages / 16 | 161.708 | 154.010 | x0.952 | level | 4 of 4 | - | - | x0.973 | x0.999 | x1.052 |
| blake3-servil-st / solo / ManyMessages / 24 | 140.791 | 136.891 | x0.972 | level | 4 of 4 | - | - | x0.980 | x1.000 | x1.049 |
| blake3-servil-st / solo / ManyMessages / 32 | 113.414 | 110.623 | x0.975 | level | 4 of 4 | - | - | x0.978 | x1.000 | x1.050 |
| blake3-servil-st / solo / ManyMessages / 48 | 101.328 | 98.060 | x0.968 | level | 4 of 4 | - | - | x0.978 | x1.000 | x1.037 |
| blake3-servil-st / solo / ManyMessages / 64 | 93.145 | 92.173 | x0.990 | level | 2 of 4 | - | - | x0.985 | x1.000 | x1.026 |
| blake3-servil-st / solo / ManyMessages / 128 | 84.656 | 83.431 | x0.986 | level | 3 of 4 | - | - | x0.992 | x1.000 | x1.021 |
| blake3-servil-st / solo / ManyMessages / 256 | 79.992 | 80.233 | x1.003 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.015 |
| blake3-servil-st / solo / ManyMessages / 512 | 77.936 | 77.989 | x1.001 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.982 |
| blake3-servil-st / solo / ManyMessages / 1024 | 65.915 | 64.900 | x0.985 | level | 4 of 4 | - | - | x0.988 | x1.000 | x1.004 |
| blake3-servil-st / solo / ManyMessages / 2048 | 42.371 | 42.569 | x1.005 | level | 0 of 4 | - | - | x1.006 | x1.000 | x1.003 |
| blake3-servil-st / solo / ManyMessages / 4096 | 31.051 | 31.102 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.008 |
| blake3-servil-st / solo / ManyMessages / 8192 | 27.254 | 27.345 | x1.003 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.016 |
| blake3-servil-st / solo / ManyMessages / 16384 | 25.346 | 25.292 | x0.998 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.976 |
| blake3-servil-st / solo / ManyMessages / 32768 | 24.884 | 24.918 | x1.001 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.000 |
| blake3-servil-st / solo / ManyMessages / 65536 | 24.662 | 24.706 | x1.002 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.028 |
| blake3-servil-st / solo / ManyMessages / 131072 | 24.978 | 24.877 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.989 |
| blake3-servil-st / solo / ManyMessages / 262144 | 25.547 | 25.506 | x0.998 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.008 |
| blake3-servil-st / solo / ManyLongMessages / 4 | 8221.041 | 8171.388 | x0.994 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.069 |
| blake3-servil-st / solo / ManyLongMessages / 16 | 4255.925 | 4303.408 | x1.011 | level | 1 of 4 | - | - | x1.009 | x1.000 | x1.019 |
| blake3-servil-st / solo / ManyLongMessages / 64 | 1975.000 | 1964.359 | x0.995 | level | 3 of 4 | - | - | x0.993 | x1.000 | x0.998 |
| blake3-servil-st / solo / ManyLongMessages / 256 | 1607.000 | 1605.531 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.016 |
| blake3-servil-st / solo / IdleOneMessage / 64 B | 8.588 | 8.659 | x1.008 | level | 3 of 4 | - | - | x1.011 | x1.001 | x1.332 |
| blake3-servil-st / solo / IdleOneMessage / 128 B | 6.138 | 6.272 | x1.022 | level | 2 of 4 | - | - | x1.004 | x1.002 | x1.812 |
| blake3-servil-st / solo / IdleOneMessage / 256 B | 4.766 | 4.725 | x0.991 | level | 1 of 4 | - | - | x1.004 | x1.001 | - |
| blake3-servil-st / solo / IdleOneMessage / 512 B | 4.305 | 4.322 | x1.004 | level | 3 of 4 | - | - | x0.998 | x1.001 | x1.244 |
| blake3-servil-st / solo / IdleOneMessage / 1 KiB | 3.704 | 3.600 | x0.972 | level | 4 of 4 | - | - | x1.006 | x1.000 | x0.764 |
| blake3-servil-st / solo / IdleOneMessage / 1536 B | 8.192 | 7.984 | x0.975 | level | 2 of 4 | - | - | x0.973 | x1.000 | x2.525 |
| blake3-servil-st / solo / IdleOneMessage / 2 KiB | 6.586 | 6.395 | x0.971 | level | 3 of 4 | - | - | x1.003 | x1.000 | x0.614 |
| blake3-servil-st / solo / IdleOneMessage / 2304 B | 6.418 | 6.577 | x1.025 | level | 1 of 4 | - | - | x0.997 | x1.000 | x1.050 |
| blake3-servil-st / solo / IdleOneMessage / 3 KiB | 4.505 | 4.599 | x1.021 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.294 |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 3.836 | 3.852 | x1.004 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.875 |
| blake3-servil-st / solo / IdleOneMessage / 4 KiB | 3.449 | 3.430 | x0.994 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.416 |
| blake3-servil-st / solo / IdleOneMessage / 4470 B | 3.795 | 3.652 | x0.962 | level | 4 of 4 | - | - | x1.005 | x1.000 | x0.956 |
| blake3-servil-st / solo / IdleOneMessage / 7935 B | 2.632 | 2.500 | x0.950 | level | 3 of 4 | - | - | x1.005 | x1.000 | x1.768 |
| blake3-servil-st / solo / IdleOneMessage / 8 KiB | 2.372 | 2.372 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.385 |
| blake3-servil-st / solo / IdleOneMessage / 16 KiB | 1.557 | 1.589 | x1.021 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.152 |
| blake3-servil-st / solo / IdleOneMessage / 32 KiB | 1.320 | 1.356 | x1.027 | level | 0 of 4 | - | - | x1.002 | x1.000 | x1.193 |
| blake3-servil-st / solo / IdleOneMessage / 64 KiB | 0.826 | 0.858 | x1.039 | level | 1 of 4 | - | - | x1.021 | x1.000 | x1.514 |
| blake3-servil-st / solo / IdleOneMessage / 128 KiB | 0.674 | 0.686 | x1.019 | level | 1 of 4 | - | - | x1.008 | x1.000 | x1.159 |
| blake3-servil-st / solo / IdleOneMessage / 256 KiB | 0.484 | 0.486 | x1.004 | level | 1 of 4 | - | - | x0.990 | x1.000 | x1.226 |
| blake3-servil-st / solo / IdleOneMessage / 512 KiB | 0.367 | 0.369 | x1.006 | level | 1 of 4 | - | - | x1.005 | x1.000 | x1.427 |
| blake3-servil-st / solo / IdleOneMessage / 1 MiB | 0.361 | 0.360 | x0.998 | level | 1 of 4 | - | - | x0.999 | x1.000 | x1.139 |
| blake3-servil-st / solo / IdleOneMessage / 2 MiB | 0.350 | 0.350 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.092 |
| blake3-servil-st / solo / IdleOneMessage / 3 MiB | 0.343 | 0.344 | x1.003 | level | 0 of 4 | - | - | x1.002 | x1.000 | x1.074 |
| blake3-servil-st / solo / IdleOneMessage / 4 MiB | 0.341 | 0.341 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.062 |
| blake3-servil-st / solo / IdleOneMessage / 8 MiB | 0.339 | 0.339 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.949 |
| blake3-servil-st / solo / IdleOneMessage / 32 MiB | 0.346 | 0.346 | x0.999 | level | 4 of 4 | - | - | x0.999 | x1.000 | x1.007 |
| blake3-servil-st / solo / IdleOneMessage / 64 MiB | 0.351 | 0.351 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.002 |
| blake3-servil-st / solo / IdleOneMessage / 128 MiB | 0.353 | 0.354 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.000 |
| blake3-servil-st / solo / IdleManyMessages / 1 | 643.558 | 660.081 | x1.026 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.138 |
| blake3-servil-st / solo / IdleManyMessages / 2 | 748.287 | 735.115 | x0.982 | level | 2 of 4 | - | - | x1.019 | x1.000 | x0.944 |
| blake3-servil-st / solo / IdleManyMessages / 3 | 766.147 | 796.932 | x1.040 | level | 1 of 4 | - | - | x1.010 | x1.000 | x0.940 |
| blake3-servil-st / solo / IdleManyMessages / 4 | 378.796 | 383.202 | x1.012 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.114 |
| blake3-servil-st / solo / IdleManyMessages / 6 | 432.062 | 439.557 | x1.017 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.041 |
| blake3-servil-st / solo / IdleManyMessages / 8 | 291.634 | 298.827 | x1.025 | level | 1 of 4 | - | - | x1.008 | x1.000 | x1.026 |
| blake3-servil-st / solo / IdleManyMessages / 12 | 298.154 | 289.196 | x0.970 | level | 4 of 4 | - | - | x0.998 | x1.000 | x1.560 |
| blake3-servil-st / solo / IdleManyMessages / 16 | 201.156 | 200.211 | x0.995 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.725 |
| blake3-servil-st / solo / IdleManyMessages / 24 | 220.986 | 217.622 | x0.985 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.916 |
| blake3-servil-st / solo / IdleManyMessages / 32 | 182.511 | 184.423 | x1.010 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.872 |
| blake3-servil-st / solo / IdleManyMessages / 48 | 174.237 | 178.691 | x1.026 | level | 2 of 4 | - | - | x1.006 | x1.000 | x1.438 |
| blake3-servil-st / solo / IdleManyMessages / 64 | 161.325 | 163.308 | x1.012 | level | 2 of 4 | - | - | x0.995 | x1.000 | x0.638 |
| blake3-servil-st / solo / IdleManyMessages / 128 | 120.455 | 123.359 | x1.024 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.700 |
| blake3-servil-st / solo / IdleManyMessages / 256 | 97.038 | 98.368 | x1.014 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.098 |
| blake3-servil-st / solo / IdleManyMessages / 512 | 84.838 | 84.910 | x1.001 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.941 |
| blake3-servil-st / solo / IdleManyMessages / 1024 | 55.808 | 53.905 | x0.966 | level | 3 of 4 | - | - | x0.973 | x1.000 | x0.864 |
| blake3-servil-st / solo / IdleManyMessages / 2048 | 42.315 | 43.420 | x1.026 | level | 0 of 4 | - | - | x1.027 | x1.000 | x1.910 |
| blake3-servil-st / solo / IdleManyMessages / 4096 | 31.064 | 30.894 | x0.995 | level | 2 of 4 | - | - | x0.993 | x1.000 | x1.194 |
| blake3-servil-st / solo / IdleManyMessages / 8192 | 23.703 | 23.903 | x1.008 | level | 0 of 4 | - | - | x1.004 | x1.000 | x1.083 |
| blake3-servil-st / solo / IdleManyMessages / 16384 | 23.727 | 23.657 | x0.997 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.047 |
| blake3-servil-st / solo / IdleManyMessages / 32768 | 22.710 | 22.692 | x0.999 | level | 3 of 4 | - | - | x1.001 | x1.000 | x1.030 |
| blake3-servil-st / solo / IdleManyMessages / 65536 | 22.291 | 22.294 | x1.000 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.001 |
| blake3-servil-st / solo / IdleManyMessages / 131072 | 22.126 | 22.106 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.993 |
| blake3-servil-st / solo / IdleManyMessages / 262144 | 22.726 | 22.563 | x0.993 | level | 3 of 4 | - | - | x0.993 | x1.000 | x0.910 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 B | 3.122 | 3.134 | x1.004 | level | 2 of 4 | - | - | x1.007 | x1.001 | x0.846 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 B | 2.351 | 2.355 | x1.002 | level | 2 of 4 | - | - | x1.001 | x1.003 | x0.783 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 B | 1.757 | 1.790 | x1.019 | level | 2 of 4 | - | - | x1.003 | x1.000 | x2.019 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 B | 1.609 | 1.611 | x1.001 | level | 2 of 4 | - | - | x1.003 | x1.001 | x0.944 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 KiB | 1.507 | 1.528 | x1.014 | level | 1 of 4 | - | - | x1.003 | x1.000 | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 1536 B | 1.255 | 1.243 | x0.990 | level | 2 of 4 | - | - | x0.992 | x1.000 | x0.895 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 KiB | 0.879 | 0.871 | x0.991 | level | 1 of 4 | - | - | x0.998 | x1.000 | x0.797 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2304 B | 1.019 | 1.052 | x1.033 | level | 3 of 4 | - | - | x1.020 | x1.000 | x1.418 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.763 | 0.738 | x0.968 | level | 3 of 4 | - | - | x0.977 | x1.000 | x1.524 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3839 B | 0.584 | 0.586 | x1.004 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.717 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 KiB | 0.479 | 0.483 | x1.008 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.180 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4470 B | 0.594 | 0.595 | x1.002 | level | 3 of 4 | - | - | x1.002 | x1.000 | x1.575 |
| blake3-servil-st / solo / BriefIdleOneMessage / 7935 B | 0.450 | 0.446 | x0.991 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.792 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 KiB | 0.393 | 0.394 | x1.002 | level | 1 of 4 | - | - | x1.002 | x1.000 | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 16 KiB | 0.296 | 0.298 | x1.007 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.677 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 KiB | 0.294 | 0.293 | x0.996 | level | 4 of 4 | - | - | x0.999 | x1.000 | x0.426 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 KiB | 0.286 | 0.285 | x0.997 | level | 4 of 4 | - | - | x0.999 | x1.000 | x1.006 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 KiB | 0.282 | 0.283 | x1.004 | level | 1 of 4 | - | - | x1.001 | x1.000 | x2.297 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 KiB | 0.281 | 0.280 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.972 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 KiB | 0.286 | 0.287 | x1.004 | level | 0 of 4 | - | - | x1.003 | x1.000 | x1.412 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 MiB | 0.326 | 0.326 | x1.000 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.113 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 MiB | 0.335 | 0.335 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.126 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 MiB | 0.334 | 0.334 | x1.000 | level | 3 of 4 | - | - | x1.001 | x1.000 | x1.094 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 MiB | 0.335 | 0.335 | x1.001 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.056 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 MiB | 0.362 | 0.362 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.994 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 MiB | 0.347 | 0.347 | x0.999 | level | 4 of 4 | - | - | x0.999 | x1.000 | x1.002 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 MiB | 0.351 | 0.352 | x1.002 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.002 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 MiB | 0.354 | 0.354 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.000 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1 | 229.285 | 232.170 | x1.013 | level | 1 of 4 | - | - | x1.002 | x0.999 | x0.895 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2 | 234.652 | 249.504 | x1.063 | level | 0 of 4 | - | - | x1.029 | x1.000 | x0.900 |
| blake3-servil-st / solo / BriefIdleManyMessages / 3 | 124.969 | 110.874 | x0.887 | level | 2 of 4 | - | - | x0.940 | x1.001 | x1.110 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4 | 68.641 | 67.210 | x0.979 | level | 3 of 4 | - | - | x0.990 | x1.001 | x0.949 |
| blake3-servil-st / solo / BriefIdleManyMessages / 6 | 60.820 | 60.917 | x1.002 | level | 3 of 4 | - | - | x0.999 | x1.001 | x1.063 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8 | 43.028 | 42.803 | x0.995 | level | 2 of 4 | - | - | x0.996 | x1.000 | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 12 | 37.299 | 37.173 | x0.997 | level | 3 of 4 | - | - | x0.995 | x1.000 | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 16 | 26.761 | 26.618 | x0.995 | level | 3 of 4 | - | - | x0.995 | x1.000 | x2.580 |
| blake3-servil-st / solo / BriefIdleManyMessages / 24 | 27.857 | 27.637 | x0.992 | level | 2 of 4 | - | - | x0.993 | x1.000 | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 32 | 22.042 | 22.044 | x1.000 | level | 2 of 4 | - | - | x0.998 | x1.000 | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 48 | 19.898 | 19.751 | x0.993 | level | 3 of 4 | - | - | x0.993 | x1.000 | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 64 | 19.090 | 18.936 | x0.992 | level | 3 of 4 | - | - | x0.993 | x1.000 | x1.117 |
| blake3-servil-st / solo / BriefIdleManyMessages / 128 | 18.073 | 17.806 | x0.985 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.083 |
| blake3-servil-st / solo / BriefIdleManyMessages / 256 | 18.429 | 18.436 | x1.000 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.845 |
| blake3-servil-st / solo / BriefIdleManyMessages / 512 | 18.290 | 18.325 | x1.002 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.840 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1024 | 18.041 | 18.057 | x1.001 | level | 0 of 4 | - | - | x1.001 | x1.000 | x0.872 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2048 | 17.957 | 18.026 | x1.004 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.975 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4096 | 18.003 | 17.992 | x0.999 | level | 3 of 4 | - | - | x1.001 | x1.000 | x0.947 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8192 | 19.185 | 19.280 | x1.005 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.104 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16384 | 21.684 | 21.739 | x1.003 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.033 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32768 | 21.766 | 21.799 | x1.002 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.027 |
| blake3-servil-st / solo / BriefIdleManyMessages / 65536 | 21.916 | 21.919 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.986 |
| blake3-servil-st / solo / BriefIdleManyMessages / 131072 | 23.581 | 23.619 | x1.002 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.990 |
| blake3-servil-st / solo / BriefIdleManyMessages / 262144 | 22.695 | 22.631 | x0.997 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.936 |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 1.505 | 1.525 | x1.013 | level | 0 of 4 | x1.013 | - | x1.013 | x1.000 | x2.319 |
| blake3-servil-st / solo / ContinuousMessages / 128 B | 1.434 | 1.447 | x1.009 | level | 0 of 4 | x1.008 | - | x1.008 | x1.000 | - |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 1.405 | 1.408 | x1.002 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x2.079 |
| blake3-servil-st / solo / ContinuousMessages / 512 B | 1.400 | 1.410 | x1.007 | level | 0 of 4 | x1.004 | - | x1.003 | x1.000 | x1.566 |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 1.396 | 1.396 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.326 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.438 | 0.441 | x1.005 | level | 1 of 4 | x1.005 | - | x1.005 | x1.000 | x0.650 |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.272 | 0.272 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | - |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.281 | 0.281 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.000 | x0.697 |
| blake3-servil-st / solo / ContinuousMessages / 256 KiB | 0.300 | 0.300 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.855 |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.298 | 0.299 | x1.003 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x1.015 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.304 | 0.304 | x1.000 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x1.257 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.304 | 0.304 | x0.999 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x1.326 |
| blake3-servil-st / solo / ContinuousMessages / 64 MiB | 0.319 | 0.319 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.997 |
| blake3-servil-st / solo / ContinuousBatches / 16 | 20.745 | 20.761 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | x1.002 |
| blake3-servil-st / solo / ContinuousBatches / 64 | 18.063 | 18.045 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | - |
| blake3-servil-st / solo / ContinuousBatches / 256 | 17.734 | 17.716 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x2.217 |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 19.397 | 19.391 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | - |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 19.364 | 19.360 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x1.014 |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 22.581 | 22.515 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x1.000 | - |
| blake3-servil-st / solo / ContinuousBatches / 65536 | 23.115 | 23.037 | x0.997 | level | 2 of 4 | x0.997 | - | x0.997 | x1.000 | x0.349 |
| blake3-servil-st / solo / LentMessages / 64 B | 1.505 | 1.525 | x1.013 | level | 0 of 4 | x1.013 | - | x1.013 | x1.000 | x2.319 |
| blake3-servil-st / solo / LentMessages / 128 B | 1.434 | 1.447 | x1.009 | level | 0 of 4 | x1.008 | - | x1.008 | x1.000 | - |
| blake3-servil-st / solo / LentMessages / 256 B | 1.405 | 1.408 | x1.002 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x2.079 |
| blake3-servil-st / solo / LentMessages / 512 B | 1.400 | 1.410 | x1.007 | level | 0 of 4 | x1.004 | - | x1.003 | x1.000 | x1.566 |
| blake3-servil-st / solo / LentMessages / 1 KiB | 1.396 | 1.396 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.326 |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.438 | 0.441 | x1.005 | level | 1 of 4 | x1.005 | - | x1.005 | x1.000 | x0.650 |
| blake3-servil-st / solo / LentMessages / 16 KiB | 0.272 | 0.272 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | - |
| blake3-servil-st / solo / LentMessages / 64 KiB | 0.281 | 0.281 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.000 | x0.697 |
| blake3-servil-st / solo / LentMessages / 256 KiB | 0.277 | 0.277 | x1.001 | level | 0 of 4 | x1.001 | - | x1.000 | x1.000 | x0.677 |
| blake3-servil-st / solo / LentMessages / 1 MiB | 0.314 | 0.314 | x1.002 | level | 1 of 4 | x1.002 | - | x1.001 | x1.000 | x1.639 |
| blake3-servil-st / solo / LentMessages / 4 MiB | 0.330 | 0.330 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x1.723 |
| blake3-servil-st / solo / LentMessages / 16 MiB | 0.341 | 0.341 | x1.001 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.939 |
| blake3-servil-st / solo / LentMessages / 64 MiB | 0.350 | 0.350 | x1.001 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x1.001 |
| blake3-servil-st / solo / Interleaved / 256 | 0.394 | 0.391 | x0.993 | level | 3 of 4 | x0.993 | - | x0.994 | x0.999 | x1.048 |
| blake3-servil-st / solo / Collection / git objects | 0.272 | 0.272 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x1.010 |
| blake3-servil-st / solo / Collection / Nix files | 0.262 | 0.263 | x1.001 | level | 2 of 4 | x1.001 | - | x1.000 | x1.000 | x1.037 |
| blake3-servil-st / solo / LentBatches / 16 | 20.745 | 20.761 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | x1.002 |
| blake3-servil-st / solo / LentBatches / 64 | 18.063 | 18.045 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | - |
| blake3-servil-st / solo / LentBatches / 256 | 17.734 | 17.716 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x2.217 |
| blake3-servil-st / solo / LentBatches / 1024 | 19.397 | 19.391 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | - |
| blake3-servil-st / solo / LentBatches / 4096 | 19.364 | 19.360 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x1.014 |
| blake3-servil-st / solo / LentBatches / 16384 | 22.581 | 22.515 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x1.000 | - |
| blake3-servil-st / solo / LentBatches / 65536 | 23.115 | 23.037 | x0.997 | level | 2 of 4 | x0.997 | - | x0.997 | x1.000 | x0.349 |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.351 | 0.351 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x0.994 |
| blake3-servil-st / solo / ContinuousCollection / Nix files | 0.359 | 0.359 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x1.042 |
| blake3-servil-st / solo / MerkleTree / 1024 | 0.349 | 0.350 | x1.005 | level | 0 of 4 | x1.004 | - | x1.004 | x1.000 | x0.667 |
| blake3-servil-st / solo / MerkleTree / 4096 | 0.400 | 0.400 | x1.000 | level | 3 of 4 | x0.999 | - | x1.000 | x1.000 | x0.712 |
| blake3-servil-st / solo / MerkleTree / 16384 | 0.412 | 0.410 | x0.996 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.688 |
| blake3-servil-st / solo / MerkleTree / 65536 | 0.440 | 0.437 | x0.995 | level | 3 of 4 | x0.995 | - | x0.995 | x1.000 | x0.966 |
| blake3-servil-st / solo / MerkleTree / 262144 | 0.465 | 0.464 | x0.998 | level | 4 of 4 | x0.997 | - | x0.997 | x1.000 | x0.998 |
| blake3-servil-st / solo / MerkleTree / 65536 x 32 B | 1.050 | 1.048 | x0.998 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.576 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 32 B | 1.088 | 1.082 | x0.994 | level | 4 of 4 | x0.995 | - | x0.995 | x1.000 | x0.992 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 16 B | 2.112 | 2.103 | x0.996 | level | 3 of 4 | x0.996 | - | x0.996 | x1.000 | x0.986 |
| blake3-servil-st / solo / MerkleTree / 65536 x 48 B | 0.742 | 0.740 | x0.997 | level | 4 of 4 | x0.997 | - | x0.997 | x1.000 | x0.925 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 48 B | 0.778 | 0.774 | x0.994 | level | 3 of 4 | x0.994 | - | x0.994 | x1.000 | x0.992 |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.754 | 0.758 | x1.005 | level | 2 of 4 | - | - | x0.999 | x0.995 | x1.003 |
| blake3-servil-st / solo / InterleavedTurn / 1024 x 1 KiB | 0.858 | 0.861 | x1.003 | level | 2 of 4 | - | - | x1.010 | x1.000 | x1.019 |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.666 | 0.657 | x0.986 | level | 3 of 4 | - | - | x0.989 | x0.994 | x1.001 |
| blake3-servil-st / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.802 | 0.804 | x1.003 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.014 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.520 | 0.517 | x0.995 | level | 3 of 4 | - | - | x0.997 | x1.003 | x0.991 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.727 | 0.730 | x1.005 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.023 |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.318 | 0.317 | x0.999 | level | 4 of 4 | x0.999 | - | x0.999 | x1.000 | x0.879 |
| blake3-servil-st / solo / ReceivingMessage / 2 μs | 0.320 | 0.320 | x0.999 | level | 4 of 4 | x0.999 | - | x0.999 | x1.000 | x0.782 |
| blake3-servil-st / solo / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 2 of 4 | x0.997 | - | x0.999 | x1.000 | x0.909 |
| blake3-servil-st / solo / IncrementalMessage / 64 B | 19.329 | 19.032 | x0.985 | level | 2 of 4 | - | - | x0.975 | x1.000 | x0.983 |
| blake3-servil-st / solo / IncrementalMessage / 1 KiB | 3.507 | 3.231 | x0.921 | level | 2 of 4 | - | - | x0.924 | x1.000 | x1.018 |
| blake3-servil-st / solo / IncrementalMessage / 4 KiB | 2.488 | 2.467 | x0.991 | level | 2 of 4 | - | - | x0.992 | x1.000 | x0.994 |
| blake3-servil-st / solo / LentIncrementalMessage / 64 B | 1.684 | 1.693 | x1.005 | level | 0 of 4 | x1.005 | - | x1.006 | x1.000 | x1.046 |
| blake3-servil-st / solo / LentIncrementalMessage / 1 KiB | 1.437 | 1.438 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.110 |
| blake3-servil-st / solo / LentIncrementalMessage / 4 KiB | 0.455 | 0.457 | x1.005 | level | 0 of 4 | x1.005 | - | x1.006 | x1.000 | x1.223 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 1.463 | 1.461 | x0.998 | level | 2 of 4 | x0.998 | - | x0.998 | x1.000 | x0.871 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 4 KiB | 0.434 | 0.435 | x1.002 | level | 0 of 4 | x1.003 | - | x1.003 | x1.000 | x1.005 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 1 MiB | 0.282 | 0.282 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x1.430 |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 1.382 | 1.387 | x1.004 | level | 1 of 4 | x1.004 | - | x1.004 | x1.000 | x0.849 |
| blake3-servil-st / solo / ContinuousLentMessages / 4 KiB | 0.424 | 0.425 | x1.003 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | x1.193 |
| blake3-servil-st / solo / ContinuousLentMessages / 1 MiB | 0.242 | 0.242 | x0.998 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x1.280 |
| blake3-servil-mt / solo / OneMessage / 64 B | 19.602 | 20.860 | x1.064 | level | 0 of 4 | - | - | x1.061 | x1.002 | x1.129 |
| blake3-servil-mt / solo / OneMessage / 128 B | 10.870 | 11.722 | x1.078 | level | 0 of 4 | - | - | x1.055 | x1.001 | x1.098 |
| blake3-servil-mt / solo / OneMessage / 256 B | 6.155 | 6.482 | x1.053 | level | 1 of 4 | - | - | x1.051 | x1.001 | x1.084 |
| blake3-servil-mt / solo / OneMessage / 512 B | 3.856 | 3.979 | x1.032 | level | 1 of 4 | - | - | x1.037 | x1.000 | x1.122 |
| blake3-servil-mt / solo / OneMessage / 1 KiB | 2.629 | 2.747 | x1.045 | level | 0 of 4 | - | - | x1.038 | x1.000 | x1.105 |
| blake3-servil-mt / solo / OneMessage / 1536 B | 4.784 | 4.755 | x0.994 | level | 1 of 4 | - | - | x0.994 | x1.000 | x1.007 |
| blake3-servil-mt / solo / OneMessage / 2 KiB | 4.214 | 4.225 | x1.002 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.047 |
| blake3-servil-mt / solo / OneMessage / 2304 B | 4.422 | 4.475 | x1.012 | level | 1 of 4 | - | - | x1.011 | x1.000 | x1.041 |
| blake3-servil-mt / solo / OneMessage / 3 KiB | 3.153 | 3.180 | x1.008 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.026 |
| blake3-servil-mt / solo / OneMessage / 3839 B | 2.752 | 2.777 | x1.009 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.066 |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 2.354 | 2.346 | x0.997 | level | 2 of 4 | - | - | x0.994 | x1.000 | x1.056 |
| blake3-servil-mt / solo / OneMessage / 4470 B | 2.498 | 2.540 | x1.017 | level | 1 of 4 | - | - | x1.016 | x1.000 | x1.039 |
| blake3-servil-mt / solo / OneMessage / 7935 B | 2.038 | 2.048 | x1.005 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.045 |
| blake3-servil-mt / solo / OneMessage / 8 KiB | 1.850 | 1.849 | x0.999 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.034 |
| blake3-servil-mt / solo / OneMessage / 16 KiB | 1.343 | 1.334 | x0.993 | level | 2 of 4 | - | - | x0.994 | x1.000 | x1.037 |
| blake3-servil-mt / solo / OneMessage / 32 KiB | 1.251 | 1.243 | x0.994 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.011 |
| blake3-servil-mt / solo / OneMessage / 64 KiB | 1.066 | 1.058 | x0.992 | level | 3 of 4 | - | - | x0.990 | x1.000 | x1.003 |
| blake3-servil-mt / solo / OneMessage / 128 KiB | 0.674 | 0.670 | x0.995 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.007 |
| blake3-servil-mt / solo / OneMessage / 256 KiB | 0.485 | 0.487 | x1.004 | level | 1 of 4 | - | - | x1.004 | x1.000 | x0.986 |
| blake3-servil-mt / solo / OneMessage / 512 KiB | 0.446 | 0.430 | x0.965 | level | 2 of 4 | - | - | x0.971 | x0.911 | x0.996 |
| blake3-servil-mt / solo / OneMessage / 1 MiB | 0.332 | 0.329 | x0.992 | level | 2 of 4 | - | - | x0.993 | x0.831 | x1.019 |
| blake3-servil-mt / solo / OneMessage / 2 MiB | 0.242 | 0.248 | x1.026 | level | 2 of 4 | - | - | x0.999 | x0.910 | x0.993 |
| blake3-servil-mt / solo / OneMessage / 3 MiB | 0.210 | 0.211 | x1.004 | level | 2 of 4 | - | - | x1.003 | x1.021 | x1.002 |
| blake3-servil-mt / solo / OneMessage / 4 MiB | 0.192 | 0.193 | x1.005 | level | 2 of 4 | - | - | x1.002 | x0.982 | x1.000 |
| blake3-servil-mt / solo / OneMessage / 8 MiB | 0.165 | 0.165 | x0.997 | level | 3 of 4 | - | - | x0.997 | x0.975 | x0.996 |
| blake3-servil-mt / solo / OneMessage / 32 MiB | 0.112 | 0.112 | x1.000 | level | 2 of 4 | - | - | x1.003 | x0.998 | x1.000 |
| blake3-servil-mt / solo / OneMessage / 64 MiB | 0.107 | 0.107 | x1.004 | level | 2 of 4 | - | - | x1.005 | x0.996 | x1.002 |
| blake3-servil-mt / solo / OneMessage / 128 MiB | 0.105 | 0.105 | x1.004 | level | 2 of 4 | - | - | x1.004 | x0.997 | x0.999 |
| blake3-servil-mt / solo / ManyMessages / 1 | 1130.639 | 1204.204 | x1.065 | level | 1 of 4 | - | - | x1.047 | x1.000 | x1.214 |
| blake3-servil-mt / solo / ManyMessages / 2 | 894.044 | 900.018 | x1.007 | level | 1 of 4 | - | - | x1.002 | x0.999 | x1.070 |
| blake3-servil-mt / solo / ManyMessages / 3 | 689.931 | 681.585 | x0.988 | level | 3 of 4 | - | - | x0.990 | x1.000 | x1.020 |
| blake3-servil-mt / solo / ManyMessages / 4 | 425.774 | 433.108 | x1.017 | level | 2 of 4 | - | - | x1.015 | x0.999 | x1.059 |
| blake3-servil-mt / solo / ManyMessages / 6 | 367.935 | 366.516 | x0.996 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.062 |
| blake3-servil-mt / solo / ManyMessages / 8 | 262.614 | 260.165 | x0.991 | level | 2 of 4 | - | - | x0.995 | x1.000 | x1.031 |
| blake3-servil-mt / solo / ManyMessages / 12 | 213.192 | 208.858 | x0.980 | level | 3 of 4 | - | - | x0.986 | x0.999 | x1.072 |
| blake3-servil-mt / solo / ManyMessages / 16 | 160.974 | 155.496 | x0.966 | level | 4 of 4 | - | - | x0.979 | x1.000 | x1.061 |
| blake3-servil-mt / solo / ManyMessages / 24 | 140.451 | 137.572 | x0.979 | level | 3 of 4 | - | - | x0.988 | x1.000 | x1.056 |
| blake3-servil-mt / solo / ManyMessages / 32 | 112.478 | 113.044 | x1.005 | level | 1 of 4 | - | - | x0.999 | x1.000 | x1.090 |
| blake3-servil-mt / solo / ManyMessages / 48 | 100.105 | 99.203 | x0.991 | level | 3 of 4 | - | - | x0.993 | x1.000 | x1.043 |
| blake3-servil-mt / solo / ManyMessages / 64 | 94.214 | 93.039 | x0.988 | level | 3 of 4 | - | - | x0.994 | x1.000 | x1.070 |
| blake3-servil-mt / solo / ManyMessages / 128 | 83.753 | 83.691 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.022 |
| blake3-servil-mt / solo / ManyMessages / 256 | 80.223 | 79.808 | x0.995 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.036 |
| blake3-servil-mt / solo / ManyMessages / 512 | 78.065 | 77.792 | x0.997 | level | 4 of 4 | - | - | x1.000 | x1.000 | x1.003 |
| blake3-servil-mt / solo / ManyMessages / 1024 | 66.040 | 66.009 | x1.000 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.000 |
| blake3-servil-mt / solo / ManyMessages / 2048 | 42.514 | 42.404 | x0.997 | level | 2 of 4 | - | - | x0.995 | x1.000 | x1.006 |
| blake3-servil-mt / solo / ManyMessages / 4096 | 31.504 | 31.218 | x0.991 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.002 |
| blake3-servil-mt / solo / ManyMessages / 8192 | 25.067 | 24.525 | x0.978 | level | 3 of 4 | - | - | x0.979 | x0.915 | x0.994 |
| blake3-servil-mt / solo / ManyMessages / 16384 | 18.815 | 19.436 | x1.033 | level | 1 of 4 | - | - | x1.033 | x1.033 | x1.010 |
| blake3-servil-mt / solo / ManyMessages / 32768 | 14.835 | 14.870 | x1.002 | level | 2 of 4 | - | - | x1.002 | x0.948 | x0.989 |
| blake3-servil-mt / solo / ManyMessages / 65536 | 12.113 | 12.132 | x1.002 | level | 2 of 4 | - | - | x1.000 | x0.978 | x0.995 |
| blake3-servil-mt / solo / ManyMessages / 131072 | 10.641 | 10.595 | x0.996 | level | 3 of 4 | - | - | x0.995 | x0.971 | x0.985 |
| blake3-servil-mt / solo / ManyMessages / 262144 | 10.003 | 9.968 | x0.996 | level | 2 of 4 | - | - | x0.997 | x0.968 | x0.998 |
| blake3-servil-mt / solo / ManyLongMessages / 4 | 8235.632 | 8242.780 | x1.001 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.090 |
| blake3-servil-mt / solo / ManyLongMessages / 16 | 4261.210 | 4316.221 | x1.013 | level | 1 of 4 | - | - | x1.013 | x1.000 | x1.017 |
| blake3-servil-mt / solo / ManyLongMessages / 64 | 1976.737 | 1984.637 | x1.004 | level | 3 of 4 | - | - | x1.004 | x1.000 | x1.007 |
| blake3-servil-mt / solo / ManyLongMessages / 256 | 1379.154 | 1393.352 | x1.010 | level | 2 of 4 | - | - | x1.011 | x0.976 | x0.992 |
| blake3-servil-mt / solo / IdleOneMessage / 64 B | 7.970 | 8.400 | x1.054 | level | 1 of 4 | - | - | x1.017 | x1.001 | x1.450 |
| blake3-servil-mt / solo / IdleOneMessage / 128 B | 6.261 | 6.732 | x1.075 | level | 1 of 4 | - | - | x1.016 | x1.002 | x3.124 |
| blake3-servil-mt / solo / IdleOneMessage / 256 B | 4.655 | 4.863 | x1.045 | level | 1 of 4 | - | - | x1.011 | x1.001 | x0.826 |
| blake3-servil-mt / solo / IdleOneMessage / 512 B | 4.158 | 4.212 | x1.013 | level | 2 of 4 | - | - | x1.003 | x1.001 | x0.679 |
| blake3-servil-mt / solo / IdleOneMessage / 1 KiB | 3.719 | 3.786 | x1.018 | level | 2 of 4 | - | - | x1.005 | x1.000 | x0.679 |
| blake3-servil-mt / solo / IdleOneMessage / 1536 B | 7.821 | 7.744 | x0.990 | level | 2 of 4 | - | - | x1.048 | x1.000 | x1.571 |
| blake3-servil-mt / solo / IdleOneMessage / 2 KiB | 6.493 | 6.728 | x1.036 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.781 |
| blake3-servil-mt / solo / IdleOneMessage / 2304 B | 6.663 | 6.659 | x0.999 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.624 |
| blake3-servil-mt / solo / IdleOneMessage / 3 KiB | 4.611 | 4.549 | x0.987 | level | 2 of 4 | - | - | x1.008 | x1.000 | x1.288 |
| blake3-servil-mt / solo / IdleOneMessage / 3839 B | 3.794 | 3.963 | x1.045 | level | 0 of 4 | - | - | x1.004 | x1.000 | x0.777 |
| blake3-servil-mt / solo / IdleOneMessage / 4 KiB | 3.433 | 3.426 | x0.998 | level | 1 of 4 | - | - | x1.002 | x1.000 | x2.299 |
| blake3-servil-mt / solo / IdleOneMessage / 4470 B | 3.661 | 3.750 | x1.024 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.515 |
| blake3-servil-mt / solo / IdleOneMessage / 7935 B | 2.596 | 2.572 | x0.991 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.943 |
| blake3-servil-mt / solo / IdleOneMessage / 8 KiB | 2.420 | 2.427 | x1.003 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.888 |
| blake3-servil-mt / solo / IdleOneMessage / 16 KiB | 1.630 | 1.574 | x0.966 | level | 3 of 4 | - | - | x0.995 | x1.000 | x1.313 |
| blake3-servil-mt / solo / IdleOneMessage / 32 KiB | 1.304 | 1.312 | x1.006 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.750 |
| blake3-servil-mt / solo / IdleOneMessage / 64 KiB | 0.843 | 0.837 | x0.993 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.733 |
| blake3-servil-mt / solo / IdleOneMessage / 128 KiB | 0.677 | 0.682 | x1.007 | level | 0 of 4 | - | - | x1.003 | x1.000 | x3.017 |
| blake3-servil-mt / solo / IdleOneMessage / 256 KiB | 0.491 | 0.481 | x0.980 | level | 4 of 4 | - | - | x0.989 | x1.000 | x1.784 |
| blake3-servil-mt / solo / IdleOneMessage / 512 KiB | 0.257 | 0.264 | x1.027 | level | 1 of 4 | - | - | x1.021 | x0.951 | x1.174 |
| blake3-servil-mt / solo / IdleOneMessage / 1 MiB | 0.223 | 0.226 | x1.012 | level | 1 of 4 | - | - | x1.008 | x0.874 | x1.023 |
| blake3-servil-mt / solo / IdleOneMessage / 2 MiB | 0.174 | 0.171 | x0.985 | level | 3 of 4 | - | - | x0.993 | x0.937 | x1.224 |
| blake3-servil-mt / solo / IdleOneMessage / 3 MiB | 0.157 | 0.156 | x0.994 | level | 2 of 4 | - | - | x0.997 | x0.924 | x1.143 |
| blake3-servil-mt / solo / IdleOneMessage / 4 MiB | 0.149 | 0.149 | x1.005 | level | 1 of 4 | - | - | x1.004 | x1.025 | x1.088 |
| blake3-servil-mt / solo / IdleOneMessage / 8 MiB | 0.131 | 0.131 | x0.997 | level | 2 of 4 | - | - | x0.995 | x0.971 | x0.937 |
| blake3-servil-mt / solo / IdleOneMessage / 32 MiB | 0.109 | 0.110 | x1.011 | level | 1 of 4 | - | - | x1.011 | x1.012 | x1.009 |
| blake3-servil-mt / solo / IdleOneMessage / 64 MiB | 0.103 | 0.104 | x1.005 | level | 2 of 4 | - | - | x1.005 | x0.999 | x0.975 |
| blake3-servil-mt / solo / IdleOneMessage / 128 MiB | 0.104 | 0.104 | x1.004 | level | 1 of 4 | - | - | x1.003 | x0.997 | x0.996 |
| blake3-servil-mt / solo / IdleManyMessages / 1 | 639.174 | 679.010 | x1.062 | level | 1 of 4 | - | - | x1.015 | x1.000 | x1.406 |
| blake3-servil-mt / solo / IdleManyMessages / 2 | 741.322 | 762.635 | x1.029 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.172 |
| blake3-servil-mt / solo / IdleManyMessages / 3 | 782.335 | 762.896 | x0.975 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.281 |
| blake3-servil-mt / solo / IdleManyMessages / 4 | 389.094 | 383.060 | x0.984 | level | 3 of 4 | - | - | x0.988 | x1.000 | x0.902 |
| blake3-servil-mt / solo / IdleManyMessages / 6 | 442.401 | 447.007 | x1.010 | level | 1 of 4 | - | - | x1.010 | x1.000 | x0.489 |
| blake3-servil-mt / solo / IdleManyMessages / 8 | 294.247 | 297.714 | x1.012 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.719 |
| blake3-servil-mt / solo / IdleManyMessages / 12 | 283.956 | 285.388 | x1.005 | level | 1 of 4 | - | - | x1.013 | x1.000 | x0.956 |
| blake3-servil-mt / solo / IdleManyMessages / 16 | 190.137 | 199.133 | x1.047 | level | 1 of 4 | - | - | x0.993 | x1.000 | x1.211 |
| blake3-servil-mt / solo / IdleManyMessages / 24 | 224.986 | 220.656 | x0.981 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.572 |
| blake3-servil-mt / solo / IdleManyMessages / 32 | 184.131 | 181.372 | x0.985 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.024 |
| blake3-servil-mt / solo / IdleManyMessages / 48 | 175.666 | 175.571 | x0.999 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.540 |
| blake3-servil-mt / solo / IdleManyMessages / 64 | 159.126 | 162.760 | x1.023 | level | 1 of 4 | - | - | x0.997 | x1.000 | x1.206 |
| blake3-servil-mt / solo / IdleManyMessages / 128 | 124.505 | 120.982 | x0.972 | level | 3 of 4 | - | - | x1.001 | x1.000 | x0.991 |
| blake3-servil-mt / solo / IdleManyMessages / 256 | 95.234 | 98.536 | x1.035 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.660 |
| blake3-servil-mt / solo / IdleManyMessages / 512 | 83.500 | 82.742 | x0.991 | level | 4 of 4 | - | - | x0.990 | x1.000 | x0.317 |
| blake3-servil-mt / solo / IdleManyMessages / 1024 | 53.400 | 54.122 | x1.014 | level | 2 of 4 | - | - | x1.024 | x1.000 | x0.918 |
| blake3-servil-mt / solo / IdleManyMessages / 2048 | 42.424 | 43.341 | x1.022 | level | 0 of 4 | - | - | x1.018 | x1.000 | x0.459 |
| blake3-servil-mt / solo / IdleManyMessages / 4096 | 31.043 | 31.119 | x1.002 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.803 |
| blake3-servil-mt / solo / IdleManyMessages / 8192 | 13.341 | 13.423 | x1.006 | level | 1 of 4 | - | - | x1.008 | x0.982 | x1.087 |
| blake3-servil-mt / solo / IdleManyMessages / 16384 | 11.752 | 11.631 | x0.990 | level | 2 of 4 | - | - | x0.986 | x0.977 | x0.987 |
| blake3-servil-mt / solo / IdleManyMessages / 32768 | 10.540 | 10.550 | x1.001 | level | 2 of 4 | - | - | x0.994 | x0.898 | x1.014 |
| blake3-servil-mt / solo / IdleManyMessages / 65536 | 9.520 | 9.453 | x0.993 | level | 2 of 4 | - | - | x0.994 | x0.910 | x1.041 |
| blake3-servil-mt / solo / IdleManyMessages / 131072 | 8.520 | 8.490 | x0.996 | level | 3 of 4 | - | - | x0.996 | x0.972 | x0.969 |
| blake3-servil-mt / solo / IdleManyMessages / 262144 | 8.002 | 7.977 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.012 | x0.919 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 B | 3.181 | 3.320 | x1.044 | level | 1 of 4 | - | - | x1.016 | x1.002 | x0.895 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 B | 2.376 | 2.409 | x1.014 | level | 2 of 4 | - | - | x1.007 | x1.002 | x1.658 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 B | 1.787 | 1.817 | x1.017 | level | 1 of 4 | - | - | x1.009 | x1.000 | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 B | 1.646 | 1.643 | x0.998 | level | 3 of 4 | - | - | x0.999 | x1.001 | x0.586 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 KiB | 1.510 | 1.513 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.001 | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1536 B | 1.285 | 1.250 | x0.973 | level | 3 of 4 | - | - | x0.978 | x1.000 | x0.698 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 KiB | 0.878 | 0.900 | x1.026 | level | 1 of 4 | - | - | x1.016 | x1.000 | x0.934 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2304 B | 1.007 | 1.002 | x0.995 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.916 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 KiB | 0.846 | 0.840 | x0.992 | level | 3 of 4 | - | - | x0.990 | x1.000 | x2.292 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3839 B | 0.592 | 0.588 | x0.994 | level | 2 of 4 | - | - | x1.004 | x1.000 | x0.690 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 KiB | 0.489 | 0.484 | x0.990 | level | 2 of 4 | - | - | x1.001 | x1.000 | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4470 B | 0.597 | 0.599 | x1.005 | level | 2 of 4 | - | - | x1.004 | x1.000 | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 7935 B | 0.444 | 0.444 | x1.002 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.323 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 KiB | 0.395 | 0.395 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.342 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 16 KiB | 0.297 | 0.299 | x1.005 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.485 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 KiB | 0.293 | 0.294 | x1.003 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.332 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 KiB | 0.285 | 0.286 | x1.003 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.759 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 KiB | 0.283 | 0.282 | x0.998 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.852 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 KiB | 0.281 | 0.280 | x0.997 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.916 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 KiB | 0.139 | 0.146 | x1.048 | level | 2 of 4 | - | - | x1.048 | x0.994 | x2.279 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 MiB | 0.154 | 0.154 | x1.001 | level | 2 of 4 | - | - | x1.002 | x1.010 | x1.065 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 MiB | 0.134 | 0.135 | x1.004 | level | 1 of 4 | - | - | x1.004 | x0.986 | x1.210 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 MiB | 0.121 | 0.121 | x1.001 | level | 2 of 4 | - | - | x1.000 | x0.996 | x1.062 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 MiB | 0.120 | 0.120 | x0.999 | level | 2 of 4 | - | - | x0.999 | x0.988 | x1.005 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 MiB | 0.134 | 0.132 | x0.988 | level | 2 of 4 | - | - | x0.999 | x0.997 | x0.803 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 MiB | 0.109 | 0.109 | x1.003 | level | 1 of 4 | - | - | x1.003 | x0.996 | x1.009 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 MiB | 0.106 | 0.107 | x1.004 | level | 1 of 4 | - | - | x1.004 | x0.998 | x0.972 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 MiB | 0.104 | 0.104 | x1.002 | level | 2 of 4 | - | - | x1.004 | x0.998 | x0.998 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1 | 226.977 | 233.107 | x1.027 | level | 0 of 4 | - | - | x1.006 | x0.999 | x0.746 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2 | 227.362 | 243.887 | x1.073 | level | 0 of 4 | - | - | x1.026 | x1.000 | x1.401 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 3 | 126.544 | 113.112 | x0.894 | level | 2 of 4 | - | - | x0.939 | x1.001 | x0.695 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4 | 66.779 | 67.449 | x1.010 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.858 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 6 | 61.183 | 63.693 | x1.041 | level | 2 of 4 | - | - | x1.008 | x1.001 | x1.837 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8 | 42.947 | 43.434 | x1.011 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.994 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 12 | 37.268 | 37.403 | x1.004 | level | 2 of 4 | - | - | x1.000 | x1.000 | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16 | 26.683 | 26.633 | x0.998 | level | 2 of 4 | - | - | x0.996 | x1.000 | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 24 | 27.419 | 26.869 | x0.980 | level | 3 of 4 | - | - | x0.991 | x1.000 | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32 | 22.058 | 21.634 | x0.981 | level | 2 of 4 | - | - | x0.994 | x1.000 | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 48 | 19.732 | 19.899 | x1.008 | level | 1 of 4 | - | - | x1.004 | x1.000 | x0.908 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 64 | 18.987 | 19.425 | x1.023 | level | 0 of 4 | - | - | x1.002 | x1.000 | x1.455 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 128 | 18.034 | 17.908 | x0.993 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.885 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 256 | 18.241 | 18.320 | x1.004 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.013 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 512 | 18.351 | 18.286 | x0.996 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.791 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1024 | 18.011 | 18.075 | x1.004 | level | 0 of 4 | - | - | x1.002 | x1.000 | x1.011 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2048 | 17.998 | 18.008 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.107 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4096 | 17.958 | 17.988 | x1.002 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.202 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8192 | 12.281 | 12.903 | x1.051 | level | 1 of 4 | - | - | x1.053 | x1.111 | x1.156 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16384 | 9.512 | 9.560 | x1.005 | level | 1 of 4 | - | - | x1.004 | x0.987 | x1.031 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32768 | 8.454 | 8.498 | x1.005 | level | 0 of 4 | - | - | x1.003 | x0.961 | x1.029 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 65536 | 8.052 | 8.065 | x1.002 | level | 1 of 4 | - | - | x0.999 | x0.995 | x0.988 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 131072 | 8.503 | 8.500 | x1.000 | level | 3 of 4 | - | - | x0.999 | x0.996 | x0.975 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 262144 | 8.117 | 8.027 | x0.989 | level | 3 of 4 | - | - | x0.989 | x0.955 | x0.891 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 1.092 | 1.079 | x0.988 | level | 2 of 4 | x0.969 | - | x0.987 | x0.995 | x1.029 |
| blake3-servil-mt / solo / ContinuousMessages / 128 B | 0.537 | 0.531 | x0.990 | level | 2 of 4 | x0.969 | - | x0.989 | x0.995 | x1.055 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.291 | 0.287 | x0.988 | level | 3 of 4 | x0.982 | - | x0.988 | x0.996 | x1.165 |
| blake3-servil-mt / solo / ContinuousMessages / 512 B | 0.192 | 0.212 | x1.107 | level | 1 of 4 | x0.951 | - | x1.108 | x0.996 | x1.135 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.146 | 0.149 | x1.023 | level | 2 of 4 | x0.989 | - | x1.023 | x0.996 | x1.212 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0952 | 0.0953 | x1.001 | level | 3 of 4 | x1.018 | - | x1.000 | x0.996 | x1.323 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0916 | 0.0937 | x1.023 | level | 2 of 4 | x0.985 | - | x1.023 | x0.998 | x1.085 |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.0744 | 0.0754 | x1.013 | level | 0 of 4 | x0.969 | - | x1.012 | x0.992 | x0.719 |
| blake3-servil-mt / solo / ContinuousMessages / 256 KiB | 0.0733 | 0.0736 | x1.004 | level | 1 of 4 | x0.987 | - | x1.005 | x1.003 | x1.186 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0858 | 0.0848 | x0.988 | level | 2 of 4 | x0.956 | - | x0.988 | x1.008 | x1.009 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.100 | 0.100 | x0.999 | level | 3 of 4 | x1.012 | - | x0.998 | x1.009 | x0.952 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0978 | 0.0971 | x0.993 | level | 3 of 4 | x1.023 | - | x0.993 | x0.998 | x1.340 |
| blake3-servil-mt / solo / ContinuousMessages / 64 MiB | 0.109 | 0.108 | x0.993 | level | 4 of 4 | x0.991 | - | x0.992 | x1.008 | x0.994 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 14.924 | 15.024 | x1.007 | level | 1 of 4 | x1.005 | - | x1.007 | x0.997 | x0.988 |
| blake3-servil-mt / solo / ContinuousBatches / 64 | 9.458 | 9.442 | x0.998 | level | 3 of 4 | x1.017 | - | x0.998 | x0.997 | x0.847 |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 7.349 | 7.329 | x0.997 | level | 3 of 4 | x1.000 | - | x0.997 | x1.008 | x1.715 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 6.984 | 6.920 | x0.991 | level | 3 of 4 | x0.998 | - | x0.989 | x0.923 | x1.389 |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 7.013 | 7.037 | x1.003 | level | 2 of 4 | x1.040 | - | x1.007 | x1.146 | x0.230 |
| blake3-servil-mt / solo / ContinuousBatches / 16384 | 9.274 | 9.286 | x1.001 | level | 2 of 4 | x0.997 | - | x1.001 | x1.076 | x0.908 |
| blake3-servil-mt / solo / ContinuousBatches / 65536 | 9.046 | 9.094 | x1.005 | level | 2 of 4 | x1.013 | - | x1.005 | x0.995 | x0.781 |
| blake3-servil-mt / solo / LentMessages / 64 B | 1.520 | 1.531 | x1.007 | level | 2 of 4 | x1.011 | - | x1.012 | x1.000 | - |
| blake3-servil-mt / solo / LentMessages / 128 B | 1.444 | 1.455 | x1.007 | level | 2 of 4 | x1.007 | - | x1.007 | x1.000 | - |
| blake3-servil-mt / solo / LentMessages / 256 B | 1.410 | 1.416 | x1.004 | level | 2 of 4 | x1.004 | - | x1.004 | x1.000 | - |
| blake3-servil-mt / solo / LentMessages / 512 B | 1.408 | 1.414 | x1.004 | level | 0 of 4 | x1.005 | - | x1.005 | x1.000 | x1.477 |
| blake3-servil-mt / solo / LentMessages / 1 KiB | 1.400 | 1.400 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.876 |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.439 | 0.439 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | - |
| blake3-servil-mt / solo / LentMessages / 16 KiB | 0.272 | 0.271 | x0.996 | level | 4 of 4 | x0.996 | - | x0.996 | x1.000 | x1.354 |
| blake3-servil-mt / solo / LentMessages / 64 KiB | 0.280 | 0.281 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | - |
| blake3-servil-mt / solo / LentMessages / 256 KiB | 0.277 | 0.277 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x0.804 |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.133 | 0.133 | x1.005 | level | 1 of 4 | x1.001 | - | x1.005 | x1.100 | x1.270 |
| blake3-servil-mt / solo / LentMessages / 4 MiB | 0.118 | 0.117 | x0.994 | level | 3 of 4 | x1.002 | - | x0.993 | x1.030 | x0.167 |
| blake3-servil-mt / solo / LentMessages / 16 MiB | 0.117 | 0.117 | x1.004 | level | 2 of 4 | x1.003 | - | x1.004 | x1.008 | x1.092 |
| blake3-servil-mt / solo / LentMessages / 64 MiB | 0.111 | 0.111 | x0.999 | level | 3 of 4 | x1.001 | - | x1.001 | x1.001 | x1.001 |
| blake3-servil-mt / solo / Interleaved / 256 | 0.394 | 0.391 | x0.994 | level | 3 of 4 | x0.994 | - | x0.993 | x0.997 | x1.243 |
| blake3-servil-mt / solo / Collection / git objects | 0.0161 | 0.0163 | x1.010 | level | 0 of 4 | x1.002 | - | x1.011 | x1.002 | x1.025 |
| blake3-servil-mt / solo / Collection / Nix files | 0.0249 | 0.0246 | x0.990 | level | 2 of 4 | x0.992 | - | x0.990 | x0.975 | x0.863 |
| blake3-servil-mt / solo / LentBatches / 16 | 20.749 | 20.794 | x1.002 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x1.091 |
| blake3-servil-mt / solo / LentBatches / 64 | 18.070 | 18.024 | x0.997 | level | 3 of 4 | x0.997 | - | x0.998 | x1.000 | x1.240 |
| blake3-servil-mt / solo / LentBatches / 256 | 17.819 | 17.733 | x0.995 | level | 2 of 4 | x0.998 | - | x0.998 | x1.000 | - |
| blake3-servil-mt / solo / LentBatches / 1024 | 19.392 | 19.400 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | - |
| blake3-servil-mt / solo / LentBatches / 4096 | 19.312 | 19.297 | x0.999 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | - |
| blake3-servil-mt / solo / LentBatches / 16384 | 11.170 | 11.263 | x1.008 | level | 1 of 4 | x1.006 | - | x1.009 | x1.013 | x0.310 |
| blake3-servil-mt / solo / LentBatches / 65536 | 10.122 | 10.088 | x0.997 | level | 3 of 4 | x1.013 | - | x0.996 | x1.024 | x1.499 |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.109 | 0.110 | x1.006 | level | 2 of 4 | x0.992 | - | x1.005 | x0.999 | x1.007 |
| blake3-servil-mt / solo / ContinuousCollection / Nix files | 0.109 | 0.108 | x0.999 | level | 2 of 4 | x0.992 | - | x0.998 | x0.999 | x1.023 |
| blake3-servil-mt / solo / MerkleTree / 1024 | 0.349 | 0.350 | x1.004 | level | 0 of 4 | x1.004 | - | x1.004 | x1.000 | x0.878 |
| blake3-servil-mt / solo / MerkleTree / 4096 | 0.230 | 0.229 | x0.997 | level | 2 of 4 | x0.992 | - | x0.998 | x1.002 | x1.133 |
| blake3-servil-mt / solo / MerkleTree / 16384 | 0.191 | 0.189 | x0.993 | level | 3 of 4 | x0.989 | - | x0.992 | x0.998 | x0.857 |
| blake3-servil-mt / solo / MerkleTree / 65536 | 0.166 | 0.165 | x0.996 | level | 4 of 4 | x1.005 | - | x0.996 | x1.008 | x0.928 |
| blake3-servil-mt / solo / MerkleTree / 262144 | 0.145 | 0.144 | x0.996 | level | 4 of 4 | x1.002 | - | x0.996 | x1.002 | x1.002 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 32 B | 0.257 | 0.257 | x0.999 | level | 2 of 4 | x1.006 | - | x1.000 | x0.993 | x1.350 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 32 B | 0.149 | 0.148 | x0.997 | level | 3 of 4 | x1.000 | - | x0.997 | x0.997 | x1.002 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 16 B | 0.275 | 0.274 | x0.998 | level | 2 of 4 | x0.999 | - | x0.998 | x0.997 | x1.009 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 48 B | 0.211 | 0.210 | x0.995 | level | 3 of 4 | x1.002 | - | x0.993 | x0.999 | x1.037 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 48 B | 0.139 | 0.139 | x0.995 | level | 3 of 4 | x1.002 | - | x0.995 | x1.001 | x1.004 |
| blake3-servil-mt / solo / InterleavedTurn / 256 | 1.004 | 0.996 | x0.992 | level | 3 of 4 | - | - | x0.981 | x0.948 | x0.994 |
| blake3-servil-mt / solo / InterleavedTurn / 1024 x 1 KiB | 0.699 | 0.699 | x1.000 | level | 3 of 4 | - | - | x0.988 | x0.994 | x1.006 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 256 | 0.661 | 0.666 | x1.008 | level | 2 of 4 | - | - | x0.992 | x0.968 | x1.032 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.653 | 0.656 | x1.005 | level | 1 of 4 | - | - | x1.008 | x0.997 | x1.006 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 256 | 0.661 | 0.674 | x1.019 | level | 0 of 4 | - | - | x1.012 | x0.982 | x1.023 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.620 | 0.624 | x1.006 | level | 2 of 4 | - | - | x1.005 | x0.997 | x1.008 |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.104 | 0.103 | x0.992 | level | 3 of 4 | x0.997 | - | x0.992 | x1.016 | x1.059 |
| blake3-servil-mt / solo / ReceivingMessage / 2 μs | 0.105 | 0.105 | x0.999 | level | 2 of 4 | x1.009 | - | x0.997 | x1.016 | x1.047 |
| blake3-servil-mt / solo / ReceivingMessage / 20 μs | 0.918 | 0.918 | x1.000 | level | 3 of 4 | x1.008 | - | x0.999 | x1.002 | x1.070 |
| blake3-servil-mt / solo / IncrementalMessage / 64 B | 20.535 | 20.899 | x1.018 | level | 2 of 4 | - | - | x1.004 | x1.000 | x1.043 |
| blake3-servil-mt / solo / IncrementalMessage / 1 KiB | 3.526 | 3.388 | x0.961 | level | 2 of 4 | - | - | x0.972 | x1.000 | x1.087 |
| blake3-servil-mt / solo / IncrementalMessage / 4 KiB | 2.497 | 2.480 | x0.993 | level | 2 of 4 | - | - | x0.993 | x1.000 | x1.000 |
| blake3-servil-mt / solo / LentIncrementalMessage / 64 B | 1.858 | 1.863 | x1.003 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | - |
| blake3-servil-mt / solo / LentIncrementalMessage / 1 KiB | 1.436 | 1.471 | x1.024 | level | 2 of 4 | x1.003 | - | x1.000 | x1.000 | x0.915 |
| blake3-servil-mt / solo / LentIncrementalMessage / 4 KiB | 0.455 | 0.456 | x1.003 | level | 1 of 4 | x1.003 | - | x1.003 | x1.000 | x1.669 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 13.436 | 13.276 | x0.988 | level | 2 of 4 | x0.946 | - | x0.985 | x1.000 | x1.027 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 4 KiB | 0.258 | 0.251 | x0.976 | level | 4 of 4 | x1.010 | - | x0.973 | x1.001 | x1.091 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 1 MiB | 0.0841 | 0.0819 | x0.973 | level | 3 of 4 | x0.998 | - | x0.974 | x1.003 | x0.838 |
| blake3-servil-mt / solo / ContinuousLentMessages / 64 B | 1.003 | 1.000 | x0.997 | level | 3 of 4 | x0.977 | - | x0.997 | x0.995 | x1.050 |
| blake3-servil-mt / solo / ContinuousLentMessages / 4 KiB | 0.0483 | 0.0492 | x1.019 | level | 1 of 4 | x0.914 | - | x1.020 | x0.996 | x1.576 |
| blake3-servil-mt / solo / ContinuousLentMessages / 1 MiB | 0.00870 | 0.00871 | x1.000 | level | 2 of 4 | x0.995 | - | x1.000 | x1.001 | x1.016 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 1.112 | 1.122 | x1.009 | level | 3 of 4 | - | - | x1.008 | x0.995 | x0.862 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 128 B | 0.576 | 0.570 | x0.990 | level | 2 of 4 | - | - | x0.988 | x0.996 | x0.933 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.325 | 0.315 | x0.968 | level | 3 of 4 | - | - | x0.968 | x0.996 | x1.067 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 512 B | 0.248 | 0.222 | x0.896 | level | 3 of 4 | - | - | x0.898 | x0.996 | x1.034 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.176 | 0.170 | x0.964 | level | 4 of 4 | - | - | x0.965 | x0.997 | x1.069 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.104 | 0.104 | x0.999 | level | 2 of 4 | - | - | x0.999 | x0.996 | x0.954 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.104 | 0.102 | x0.978 | level | 2 of 4 | - | - | x0.977 | x0.997 | x1.110 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.0814 | 0.0809 | x0.994 | level | 3 of 4 | - | - | x0.993 | x1.006 | x1.016 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 KiB | 0.0808 | 0.0802 | x0.992 | level | 3 of 4 | - | - | x0.992 | x1.011 | x1.100 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0905 | 0.0884 | x0.977 | level | 3 of 4 | - | - | x0.979 | x1.006 | x0.959 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.106 | 0.105 | x0.993 | level | 2 of 4 | - | - | x0.993 | x0.991 | x0.996 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.105 | 0.106 | x1.005 | level | 2 of 4 | - | - | x1.003 | x1.006 | x1.047 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 MiB | 0.128 | 0.128 | x1.000 | level | 2 of 4 | - | - | x0.999 | x1.003 | x1.009 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 15.469 | 15.612 | x1.009 | level | 1 of 4 | - | - | x1.009 | x0.997 | x0.994 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 64 | 9.946 | 9.881 | x0.993 | level | 2 of 4 | - | - | x0.994 | x0.998 | x0.949 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 256 | 7.830 | 7.757 | x0.991 | level | 3 of 4 | - | - | x0.991 | x0.980 | x1.065 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 7.379 | 7.225 | x0.979 | level | 3 of 4 | - | - | x0.980 | x0.986 | x0.771 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 4096 | 7.613 | 7.602 | x0.999 | level | 3 of 4 | - | - | x0.997 | x0.953 | x1.280 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16384 | 9.687 | 9.690 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.165 | x0.781 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 65536 | 9.195 | 9.259 | x1.007 | level | 1 of 4 | - | - | x1.007 | x1.027 | x0.987 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 1.513 | 1.517 | x1.002 | level | 2 of 4 | - | - | x1.003 | x1.000 | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 128 B | 1.456 | 1.444 | x0.991 | level | 4 of 4 | - | - | x0.991 | x1.000 | x0.842 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 B | 1.413 | 1.415 | x1.001 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.500 |
| blake3-servil-mt / shared-one-cache / LentMessages / 512 B | 1.408 | 1.412 | x1.003 | level | 0 of 4 | - | - | x1.003 | x1.000 | x1.454 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 KiB | 1.399 | 1.398 | x0.999 | level | 4 of 4 | - | - | x0.999 | x1.000 | x0.835 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.435 | 0.436 | x1.002 | level | 1 of 4 | - | - | x1.002 | x1.000 | x2.671 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 KiB | 0.272 | 0.273 | x1.004 | level | 2 of 4 | - | - | x1.004 | x1.000 | x1.388 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 KiB | 0.280 | 0.281 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x2.412 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 KiB | 0.277 | 0.277 | x0.999 | level | 4 of 4 | - | - | x1.000 | x1.000 | x2.830 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 MiB | 0.150 | 0.153 | x1.019 | level | 0 of 4 | - | - | x1.017 | x0.942 | x0.499 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 MiB | 0.125 | 0.125 | x0.998 | level | 2 of 4 | - | - | x1.000 | x0.979 | x1.146 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 MiB | 0.137 | 0.138 | x1.008 | level | 2 of 4 | - | - | x1.009 | x0.984 | x0.999 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 MiB | 0.125 | 0.125 | x0.999 | level | 1 of 4 | - | - | x0.999 | x1.001 | x1.001 |
| blake3-servil-mt / shared-one-cache / Interleaved / 256 | 0.385 | 0.387 | x1.004 | level | 3 of 4 | - | - | x0.999 | x0.999 | x1.189 |
| blake3-servil-mt / shared-one-cache / Collection / git objects | 0.0270 | 0.0276 | x1.023 | level | 1 of 4 | - | - | x0.960 | x0.967 | x0.926 |
| blake3-servil-mt / shared-one-cache / Collection / Nix files | 0.0326 | 0.0330 | x1.014 | level | 0 of 4 | - | - | x1.019 | x1.018 | x1.036 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16 | 21.323 | 20.897 | x0.980 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.917 |
| blake3-servil-mt / shared-one-cache / LentBatches / 64 | 18.016 | 18.023 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.474 |
| blake3-servil-mt / shared-one-cache / LentBatches / 256 | 17.697 | 17.829 | x1.007 | level | 1 of 4 | - | - | x1.007 | x1.000 | x0.867 |
| blake3-servil-mt / shared-one-cache / LentBatches / 1024 | 19.285 | 19.158 | x0.993 | level | 3 of 4 | - | - | x0.993 | x1.000 | x2.139 |
| blake3-servil-mt / shared-one-cache / LentBatches / 4096 | 19.039 | 18.976 | x0.997 | level | 2 of 4 | - | - | x0.994 | x1.000 | x25.580 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16384 | 12.593 | 12.767 | x1.014 | level | 1 of 4 | - | - | x1.011 | x0.937 | x1.461 |
| blake3-servil-mt / shared-one-cache / LentBatches / 65536 | 10.492 | 10.393 | x0.991 | level | 4 of 4 | - | - | x0.990 | x0.979 | x1.216 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.128 | 0.127 | x0.992 | level | 2 of 4 | - | - | x0.992 | x0.998 | x0.943 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / Nix files | 0.126 | 0.124 | x0.987 | level | 2 of 4 | - | - | x0.988 | x0.998 | x0.992 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1024 | 0.350 | 0.349 | x0.998 | level | 4 of 4 | - | - | x0.998 | x1.000 | x0.893 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 4096 | 0.252 | 0.251 | x0.996 | level | 2 of 4 | - | - | x0.996 | x1.009 | x0.881 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 16384 | 0.202 | 0.203 | x1.002 | level | 1 of 4 | - | - | x1.002 | x0.994 | x0.753 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 | 0.192 | 0.192 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.010 | x0.991 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 262144 | 0.175 | 0.176 | x1.006 | level | 1 of 4 | - | - | x1.005 | x1.015 | x1.024 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 32 B | 0.288 | 0.284 | x0.987 | level | 4 of 4 | - | - | x0.988 | x1.012 | x2.464 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 32 B | 0.232 | 0.232 | x0.998 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.998 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 16 B | 0.422 | 0.420 | x0.995 | level | 3 of 4 | - | - | x0.991 | x0.972 | x1.004 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 48 B | 0.231 | 0.228 | x0.988 | level | 3 of 4 | - | - | x0.983 | x0.973 | x1.528 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 48 B | 0.197 | 0.196 | x0.996 | level | 3 of 4 | - | - | x1.002 | x0.993 | x1.005 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.110 | 0.110 | x1.002 | level | 2 of 4 | - | - | x1.001 | x1.004 | x0.982 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 2 μs | 0.112 | 0.112 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.010 | x0.973 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 20 μs | 0.918 | 0.918 | x1.000 | level | 4 of 4 | - | - | x0.995 | x0.995 | x0.962 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 64 B | 1.877 | 1.859 | x0.990 | level | 4 of 4 | - | - | x0.990 | x1.000 | x1.531 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 1 KiB | 1.443 | 1.438 | x0.996 | level | 4 of 4 | - | - | x0.998 | x1.000 | x1.055 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 4 KiB | 0.455 | 0.455 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.975 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 17.728 | 17.532 | x0.989 | level | 2 of 4 | - | - | x1.033 | x0.997 | x1.006 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 4 KiB | 0.296 | 0.293 | x0.990 | level | 3 of 4 | - | - | x0.988 | x1.000 | x1.018 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 1 MiB | 0.0898 | 0.0896 | x0.998 | level | 2 of 4 | - | - | x0.998 | x0.995 | x0.884 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 64 B | 1.042 | 1.081 | x1.038 | level | 1 of 4 | - | - | x1.043 | x0.995 | x1.007 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 4 KiB | 0.0633 | 0.0634 | x1.001 | level | 2 of 4 | - | - | x0.996 | x0.994 | x1.013 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 1 MiB | 0.0176 | 0.0171 | x0.971 | level | 3 of 4 | - | - | x0.982 | x0.987 | x0.677 |

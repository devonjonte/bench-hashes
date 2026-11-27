# Nightly drift check: 2557d53c772e -> 7f392fdebc90

- Host: electric-rhino
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
| blake3-servil-st / solo / OneMessage / 3839 B | 0.878 | 0.893 | x1.017 | level | 22 of 64 | - | - | x1.015 | x1.000 | x1.020 |
| blake3-servil-st / solo / ManyMessages / 3 | 223.257 | 232.223 | x1.040 | level | 28 of 64 | - | - | x1.027 | x0.997 | x1.005 |
| blake3-servil-mt / solo / IdleManyMessages / 131072 | 2.774 | 2.721 | x0.981 | level | 31 of 64 | - | - | x0.981 | x1.006 | x0.972 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 3.608 | 3.643 | x1.010 | level | 26 of 64 | x0.989 | - | x1.010 | x0.997 | x1.013 |
| blake3-servil-mt / solo / ContinuousBatches / 64 | 2.345 | 2.393 | x1.020 | level | 22 of 64 | x1.011 | - | x1.017 | x0.998 | x0.989 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.130 | 0.131 | x1.004 | level | 28 of 64 | - | - | x1.003 | x0.997 | x0.987 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 5.299 | 5.426 | x1.024 | level | 27 of 64 | x1.014 | - | x1.024 | x1.000 | x1.000 |
| blake3-servil-mt / solo / ContinuousLentMessages / 4 KiB | 0.0365 | 0.0361 | x0.988 | level | 44 of 64 | x0.999 | - | x0.988 | x0.992 | x1.015 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 4.212 | 4.215 | x1.001 | level | 30 of 64 | - | - | x1.000 | x0.997 | x0.986 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 64 | 3.053 | 3.135 | x1.027 | level | 10 of 64 | - | - | x1.029 | x0.998 | x0.993 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 18.058 | 18.031 | x0.999 | level | 33 of 64 | - | - | x1.005 | x1.002 | x0.997 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 4 KiB | 0.0819 | 0.0814 | x0.994 | level | 33 of 64 | - | - | x1.000 | x0.996 | x1.011 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 16 | 8.913 | 9.186 | x1.031 | level | 28 of 64 | - | - | x1.030 | x0.997 | x0.995 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 64 | 6.467 | 6.613 | x1.022 | level | 28 of 64 | - | - | x1.022 | x0.998 | x0.992 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 64 B | 18.551 | 18.758 | x1.011 | level | 28 of 64 | - | - | x1.025 | x1.000 | x0.988 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 4 KiB | 0.0675 | 0.0676 | x1.001 | level | 24 of 64 | - | - | x1.001 | x0.993 | x1.012 |

## Stage 1 (initial screen, kept-drift)

compare: old side: bench 3f119a507807 clean; servil 2557d53c772e clean
compare: new side: bench 3f119a507807 clean; servil 7f392fdebc90 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 5.152 | 4.893 | x0.950 | level | 2 of 4 | - | - | x0.962 | x0.998 | x0.940 |
| blake3-servil-st / solo / OneMessage / 128 B | 3.301 | 3.135 | x0.950 | level | 2 of 4 | - | - | x0.950 | x1.000 | x0.966 |
| blake3-servil-st / solo / OneMessage / 256 B | 2.460 | 2.418 | x0.983 | level | 2 of 4 | - | - | x0.977 | x1.004 | x0.942 |
| blake3-servil-st / solo / OneMessage / 512 B | 1.865 | 1.891 | x1.014 | level | 2 of 4 | - | - | x0.992 | x1.003 | x0.958 |
| blake3-servil-st / solo / OneMessage / 1 KiB | 1.626 | 1.615 | x0.993 | level | 4 of 4 | - | - | x0.995 | x1.001 | x0.976 |
| blake3-servil-st / solo / OneMessage / 1536 B | 1.443 | 1.426 | x0.988 | level | 3 of 4 | - | - | x0.993 | x1.001 | x0.962 |
| blake3-servil-st / solo / OneMessage / 2 KiB | 1.012 | 0.994 | x0.982 | level | 2 of 4 | - | - | x0.988 | x1.001 | x0.976 |
| blake3-servil-st / solo / OneMessage / 2304 B | 1.138 | 1.173 | x1.030 | level | 1 of 4 | - | - | x1.034 | x1.002 | x1.001 |
| blake3-servil-st / solo / OneMessage / 3 KiB | 0.810 | 0.813 | x1.003 | level | 3 of 4 | - | - | x1.027 | x1.000 | x0.959 |
| blake3-servil-st / solo / OneMessage / 3839 B | 0.767 | 0.806 | x1.051 | level | 0 of 4 | - | - | x1.065 | x1.001 | x0.993 |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.567 | 0.569 | x1.004 | level | 1 of 4 | - | - | x1.012 | x1.000 | x0.956 |
| blake3-servil-st / solo / OneMessage / 4470 B | 0.668 | 0.690 | x1.033 | level | 1 of 4 | - | - | x1.040 | x1.002 | x0.984 |
| blake3-servil-st / solo / OneMessage / 7935 B | 0.590 | 0.577 | x0.978 | level | 4 of 4 | - | - | x0.991 | x1.001 | x1.000 |
| blake3-servil-st / solo / OneMessage / 8 KiB | 0.433 | 0.430 | x0.994 | level | 2 of 4 | - | - | x0.994 | x1.001 | x1.009 |
| blake3-servil-st / solo / OneMessage / 16 KiB | 0.306 | 0.300 | x0.979 | level | 2 of 4 | - | - | x0.986 | x1.000 | x0.998 |
| blake3-servil-st / solo / OneMessage / 32 KiB | 0.200 | 0.194 | x0.970 | level | 2 of 4 | - | - | x0.980 | x1.000 | x0.984 |
| blake3-servil-st / solo / OneMessage / 64 KiB | 0.150 | 0.149 | x0.990 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.015 |
| blake3-servil-st / solo / OneMessage / 128 KiB | 0.125 | 0.124 | x0.990 | level | 3 of 4 | - | - | x0.994 | x1.000 | x1.030 |
| blake3-servil-st / solo / OneMessage / 256 KiB | 0.113 | 0.113 | x0.998 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.005 |
| blake3-servil-st / solo / OneMessage / 512 KiB | 0.103 | 0.102 | x0.997 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.122 |
| blake3-servil-st / solo / OneMessage / 1 MiB | 0.0979 | 0.0973 | x0.994 | level | 4 of 4 | - | - | x0.996 | x1.000 | x1.009 |
| blake3-servil-st / solo / OneMessage / 2 MiB | 0.0984 | 0.0978 | x0.994 | level | 4 of 4 | - | - | x0.993 | x1.000 | x1.011 |
| blake3-servil-st / solo / OneMessage / 3 MiB | 0.100 | 0.0994 | x0.992 | level | 3 of 4 | - | - | x0.992 | x1.000 | x1.021 |
| blake3-servil-st / solo / OneMessage / 4 MiB | 0.0986 | 0.0984 | x0.998 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.037 |
| blake3-servil-st / solo / OneMessage / 8 MiB | 0.106 | 0.105 | x0.997 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.011 |
| blake3-servil-st / solo / OneMessage / 32 MiB | 0.116 | 0.115 | x0.996 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.028 |
| blake3-servil-st / solo / OneMessage / 64 MiB | 0.116 | 0.115 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.025 |
| blake3-servil-st / solo / OneMessage / 128 MiB | 0.117 | 0.116 | x0.994 | level | 2 of 4 | - | - | x0.994 | x1.000 | x1.011 |
| blake3-servil-st / solo / ManyMessages / 1 | 464.854 | 431.373 | x0.928 | level | 4 of 4 | - | - | x0.939 | x1.009 | x0.988 |
| blake3-servil-st / solo / ManyMessages / 2 | 238.948 | 247.877 | x1.037 | level | 1 of 4 | - | - | x1.024 | x1.004 | x1.048 |
| blake3-servil-st / solo / ManyMessages / 3 | 199.113 | 212.106 | x1.065 | level | 1 of 4 | - | - | x1.056 | x1.005 | x0.999 |
| blake3-servil-st / solo / ManyMessages / 4 | 131.902 | 135.634 | x1.028 | level | 1 of 4 | - | - | x1.031 | x1.013 | x1.007 |
| blake3-servil-st / solo / ManyMessages / 6 | 115.128 | 116.869 | x1.015 | level | 2 of 4 | - | - | x1.019 | x1.005 | x1.001 |
| blake3-servil-st / solo / ManyMessages / 8 | 166.670 | 160.459 | x0.963 | level | 2 of 4 | - | - | x0.974 | x1.003 | x1.001 |
| blake3-servil-st / solo / ManyMessages / 12 | 123.598 | 121.719 | x0.985 | level | 2 of 4 | - | - | x1.002 | x1.009 | x1.009 |
| blake3-servil-st / solo / ManyMessages / 16 | 97.119 | 93.491 | x0.963 | level | 4 of 4 | - | - | x0.979 | x1.005 | x0.986 |
| blake3-servil-st / solo / ManyMessages / 24 | 104.468 | 99.104 | x0.949 | level | 4 of 4 | - | - | x0.965 | x1.004 | x0.995 |
| blake3-servil-st / solo / ManyMessages / 32 | 47.784 | 47.609 | x0.996 | level | 3 of 4 | - | - | x1.000 | x1.004 | x0.998 |
| blake3-servil-st / solo / ManyMessages / 48 | 34.280 | 35.026 | x1.022 | level | 2 of 4 | - | - | x1.027 | x1.003 | x0.986 |
| blake3-servil-st / solo / ManyMessages / 64 | 27.575 | 28.589 | x1.037 | level | 0 of 4 | - | - | x1.039 | x1.006 | x0.998 |
| blake3-servil-st / solo / ManyMessages / 128 | 18.812 | 18.946 | x1.007 | level | 2 of 4 | - | - | x1.011 | x1.001 | x1.003 |
| blake3-servil-st / solo / ManyMessages / 256 | 13.754 | 14.206 | x1.033 | level | 0 of 4 | - | - | x1.032 | x1.000 | x1.024 |
| blake3-servil-st / solo / ManyMessages / 512 | 11.105 | 11.224 | x1.011 | level | 1 of 4 | - | - | x1.006 | x1.000 | x0.989 |
| blake3-servil-st / solo / ManyMessages / 1024 | 9.673 | 9.679 | x1.001 | level | 3 of 4 | - | - | x1.001 | x1.000 | x0.948 |
| blake3-servil-st / solo / ManyMessages / 2048 | 9.061 | 9.004 | x0.994 | level | 1 of 4 | - | - | x0.997 | x1.000 | x0.965 |
| blake3-servil-st / solo / ManyMessages / 4096 | 8.778 | 8.703 | x0.991 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.945 |
| blake3-servil-st / solo / ManyMessages / 8192 | 8.203 | 8.148 | x0.993 | level | 3 of 4 | - | - | x0.993 | x1.000 | x0.962 |
| blake3-servil-st / solo / ManyMessages / 16384 | 7.847 | 7.832 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.963 |
| blake3-servil-st / solo / ManyMessages / 32768 | 7.874 | 7.849 | x0.997 | level | 4 of 4 | - | - | x0.997 | x1.000 | x0.972 |
| blake3-servil-st / solo / ManyMessages / 65536 | 7.966 | 7.943 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.969 |
| blake3-servil-st / solo / ManyMessages / 131072 | 8.331 | 8.339 | x1.001 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.994 |
| blake3-servil-st / solo / ManyMessages / 262144 | 8.754 | 8.754 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.004 |
| blake3-servil-st / solo / ManyLongMessages / 4 | 1836.263 | 1858.686 | x1.012 | level | 2 of 4 | - | - | x1.014 | x1.001 | x0.964 |
| blake3-servil-st / solo / ManyLongMessages / 16 | 683.146 | 679.743 | x0.995 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.981 |
| blake3-servil-st / solo / ManyLongMessages / 64 | 561.773 | 560.447 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.012 |
| blake3-servil-st / solo / ManyLongMessages / 256 | 518.845 | 516.950 | x0.996 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.966 |
| blake3-servil-st / solo / IdleOneMessage / 64 B | 3.013 | 3.102 | x1.030 | level | 1 of 4 | - | - | x1.002 | x0.993 | x0.804 |
| blake3-servil-st / solo / IdleOneMessage / 128 B | 2.096 | 2.167 | x1.034 | level | 0 of 4 | - | - | x1.008 | x0.995 | x0.938 |
| blake3-servil-st / solo / IdleOneMessage / 256 B | 1.772 | 1.767 | x0.997 | level | 2 of 4 | - | - | x1.002 | x0.997 | x0.927 |
| blake3-servil-st / solo / IdleOneMessage / 512 B | 1.638 | 1.619 | x0.988 | level | 3 of 4 | - | - | x1.001 | x0.998 | x0.846 |
| blake3-servil-st / solo / IdleOneMessage / 1 KiB | 1.550 | 1.552 | x1.001 | level | 1 of 4 | - | - | x1.002 | x0.999 | x0.962 |
| blake3-servil-st / solo / IdleOneMessage / 1536 B | 1.202 | 1.198 | x0.996 | level | 2 of 4 | - | - | x0.998 | x0.999 | x1.122 |
| blake3-servil-st / solo / IdleOneMessage / 2 KiB | 0.873 | 0.874 | x1.002 | level | 2 of 4 | - | - | x1.002 | x0.999 | x2.664 |
| blake3-servil-st / solo / IdleOneMessage / 2304 B | 0.980 | 0.963 | x0.983 | level | 4 of 4 | - | - | x1.001 | x0.999 | x2.120 |
| blake3-servil-st / solo / IdleOneMessage / 3 KiB | 0.628 | 0.621 | x0.989 | level | 3 of 4 | - | - | x1.000 | x0.999 | x0.723 |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 0.502 | 0.506 | x1.008 | level | 1 of 4 | - | - | x0.999 | x0.999 | x0.478 |
| blake3-servil-st / solo / IdleOneMessage / 4 KiB | 0.462 | 0.467 | x1.011 | level | 1 of 4 | - | - | x1.002 | x0.999 | x1.111 |
| blake3-servil-st / solo / IdleOneMessage / 4470 B | 0.574 | 0.581 | x1.012 | level | 0 of 4 | - | - | x0.999 | x0.999 | x0.445 |
| blake3-servil-st / solo / IdleOneMessage / 7935 B | 0.292 | 0.291 | x0.996 | level | 3 of 4 | - | - | x0.990 | x1.000 | x0.654 |
| blake3-servil-st / solo / IdleOneMessage / 8 KiB | 0.276 | 0.273 | x0.986 | level | 3 of 4 | - | - | x0.993 | x0.999 | x0.799 |
| blake3-servil-st / solo / IdleOneMessage / 16 KiB | 0.154 | 0.154 | x1.001 | level | 1 of 4 | - | - | x0.999 | x0.999 | x0.675 |
| blake3-servil-st / solo / IdleOneMessage / 32 KiB | 0.108 | 0.108 | x0.998 | level | 1 of 4 | - | - | x1.003 | x0.999 | x0.650 |
| blake3-servil-st / solo / IdleOneMessage / 64 KiB | 0.0989 | 0.100 | x1.016 | level | 0 of 4 | - | - | x0.999 | x1.000 | x0.514 |
| blake3-servil-st / solo / IdleOneMessage / 128 KiB | 0.0946 | 0.0944 | x0.998 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.386 |
| blake3-servil-st / solo / IdleOneMessage / 256 KiB | 0.0934 | 0.0929 | x0.995 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.775 |
| blake3-servil-st / solo / IdleOneMessage / 512 KiB | 0.0980 | 0.0977 | x0.996 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.015 |
| blake3-servil-st / solo / IdleOneMessage / 1 MiB | 0.0956 | 0.0944 | x0.987 | level | 4 of 4 | - | - | x0.996 | x1.000 | x0.959 |
| blake3-servil-st / solo / IdleOneMessage / 2 MiB | 0.0885 | 0.0880 | x0.995 | level | 4 of 4 | - | - | x0.996 | x1.000 | x0.956 |
| blake3-servil-st / solo / IdleOneMessage / 3 MiB | 0.0872 | 0.0872 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.986 |
| blake3-servil-st / solo / IdleOneMessage / 4 MiB | 0.0870 | 0.0870 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.968 |
| blake3-servil-st / solo / IdleOneMessage / 8 MiB | 0.0879 | 0.0879 | x0.999 | level | 1 of 4 | - | - | x0.999 | x1.000 | x0.985 |
| blake3-servil-st / solo / IdleOneMessage / 32 MiB | 0.116 | 0.115 | x0.995 | level | 2 of 4 | - | - | x0.995 | x1.000 | x1.032 |
| blake3-servil-st / solo / IdleOneMessage / 64 MiB | 0.116 | 0.116 | x0.995 | level | 3 of 4 | - | - | x0.995 | x1.000 | x1.010 |
| blake3-servil-st / solo / IdleOneMessage / 128 MiB | 0.116 | 0.116 | x0.994 | level | 3 of 4 | - | - | x0.994 | x1.000 | x1.011 |
| blake3-servil-st / solo / IdleManyMessages / 1 | 202.623 | 205.173 | x1.013 | level | 1 of 4 | - | - | x1.002 | x0.996 | x1.293 |
| blake3-servil-st / solo / IdleManyMessages / 2 | 108.981 | 104.565 | x0.959 | level | 4 of 4 | - | - | x0.985 | x0.996 | x0.476 |
| blake3-servil-st / solo / IdleManyMessages / 3 | 90.936 | 90.010 | x0.990 | level | 2 of 4 | - | - | x0.996 | x0.997 | x1.357 |
| blake3-servil-st / solo / IdleManyMessages / 4 | 54.477 | 53.336 | x0.979 | level | 3 of 4 | - | - | x0.990 | x0.996 | x0.734 |
| blake3-servil-st / solo / IdleManyMessages / 6 | 51.673 | 51.109 | x0.989 | level | 2 of 4 | - | - | x0.994 | x0.997 | x0.630 |
| blake3-servil-st / solo / IdleManyMessages / 8 | 33.719 | 33.758 | x1.001 | level | 1 of 4 | - | - | x0.998 | x0.997 | x1.238 |
| blake3-servil-st / solo / IdleManyMessages / 12 | 31.791 | 31.335 | x0.986 | level | 3 of 4 | - | - | x0.994 | x0.997 | x0.980 |
| blake3-servil-st / solo / IdleManyMessages / 16 | 18.239 | 18.591 | x1.019 | level | 1 of 4 | - | - | x1.014 | x0.997 | x3.286 |
| blake3-servil-st / solo / IdleManyMessages / 24 | 17.774 | 17.213 | x0.968 | level | 3 of 4 | - | - | x0.976 | x0.997 | x0.370 |
| blake3-servil-st / solo / IdleManyMessages / 32 | 12.785 | 13.223 | x1.034 | level | 0 of 4 | - | - | x1.015 | x0.998 | x1.640 |
| blake3-servil-st / solo / IdleManyMessages / 48 | 11.317 | 11.397 | x1.007 | level | 1 of 4 | - | - | x1.004 | x0.999 | x1.030 |
| blake3-servil-st / solo / IdleManyMessages / 64 | 10.506 | 10.552 | x1.004 | level | 1 of 4 | - | - | x1.001 | x0.999 | x0.387 |
| blake3-servil-st / solo / IdleManyMessages / 128 | 9.352 | 9.491 | x1.015 | level | 1 of 4 | - | - | x1.011 | x0.999 | x1.327 |
| blake3-servil-st / solo / IdleManyMessages / 256 | 8.766 | 8.870 | x1.012 | level | 1 of 4 | - | - | x1.011 | x0.999 | x1.405 |
| blake3-servil-st / solo / IdleManyMessages / 512 | 8.438 | 8.343 | x0.989 | level | 3 of 4 | - | - | x0.999 | x0.999 | x0.516 |
| blake3-servil-st / solo / IdleManyMessages / 1024 | 8.200 | 8.082 | x0.986 | level | 3 of 4 | - | - | x0.993 | x1.000 | x0.517 |
| blake3-servil-st / solo / IdleManyMessages / 2048 | 8.024 | 7.970 | x0.993 | level | 3 of 4 | - | - | x0.991 | x1.000 | x0.677 |
| blake3-servil-st / solo / IdleManyMessages / 4096 | 7.936 | 7.965 | x1.004 | level | 2 of 4 | - | - | x0.993 | x1.000 | x0.828 |
| blake3-servil-st / solo / IdleManyMessages / 8192 | 8.138 | 8.139 | x1.000 | level | 2 of 4 | - | - | x0.994 | x1.000 | x0.899 |
| blake3-servil-st / solo / IdleManyMessages / 16384 | 7.839 | 7.864 | x1.003 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.909 |
| blake3-servil-st / solo / IdleManyMessages / 32768 | 7.504 | 7.489 | x0.998 | level | 4 of 4 | - | - | x0.998 | x1.000 | x0.931 |
| blake3-servil-st / solo / IdleManyMessages / 65536 | 7.450 | 7.438 | x0.998 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.942 |
| blake3-servil-st / solo / IdleManyMessages / 131072 | 7.448 | 7.440 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.901 |
| blake3-servil-st / solo / IdleManyMessages / 262144 | 7.995 | 8.014 | x1.002 | level | 3 of 4 | - | - | x1.003 | x1.000 | x1.013 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 B | 3.005 | 3.029 | x1.008 | level | 1 of 4 | - | - | x1.012 | x0.993 | x0.834 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 B | 2.108 | 2.134 | x1.013 | level | 1 of 4 | - | - | x1.006 | x0.995 | x1.410 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 B | 1.685 | 1.699 | x1.009 | level | 1 of 4 | - | - | x1.006 | x0.997 | x0.679 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 B | 1.455 | 1.461 | x1.004 | level | 1 of 4 | - | - | x1.003 | x0.998 | x2.513 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 KiB | 1.347 | 1.350 | x1.002 | level | 1 of 4 | - | - | x1.002 | x0.999 | x1.236 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1536 B | 1.014 | 1.014 | x1.000 | level | 2 of 4 | - | - | x1.000 | x0.999 | x1.712 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 KiB | 0.731 | 0.730 | x0.999 | level | 3 of 4 | - | - | x1.000 | x0.999 | x0.502 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2304 B | 0.812 | 0.812 | x1.000 | level | 2 of 4 | - | - | x1.000 | x0.999 | x2.227 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.523 | 0.524 | x1.001 | level | 1 of 4 | - | - | x1.002 | x0.999 | x2.263 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3839 B | 0.428 | 0.426 | x0.997 | level | 3 of 4 | - | - | x0.998 | x0.999 | x1.023 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 KiB | 0.391 | 0.392 | x1.005 | level | 2 of 4 | - | - | x1.000 | x0.999 | x0.451 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4470 B | 0.482 | 0.482 | x1.000 | level | 3 of 4 | - | - | x1.001 | x0.999 | x1.043 |
| blake3-servil-st / solo / BriefIdleOneMessage / 7935 B | 0.243 | 0.241 | x0.992 | level | 4 of 4 | - | - | x0.995 | x0.999 | x1.675 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 KiB | 0.224 | 0.224 | x0.999 | level | 3 of 4 | - | - | x0.999 | x0.999 | x0.305 |
| blake3-servil-st / solo / BriefIdleOneMessage / 16 KiB | 0.127 | 0.126 | x0.992 | level | 3 of 4 | - | - | x1.000 | x0.999 | x0.693 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 KiB | 0.0886 | 0.0889 | x1.004 | level | 3 of 4 | - | - | x1.001 | x0.999 | x0.743 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 KiB | 0.0812 | 0.0810 | x0.997 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.242 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 KiB | 0.0778 | 0.0776 | x0.998 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.468 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 KiB | 0.0782 | 0.0779 | x0.995 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.398 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 KiB | 0.0839 | 0.0838 | x0.999 | level | 3 of 4 | - | - | x1.001 | x1.000 | x1.003 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 MiB | 0.0872 | 0.0868 | x0.995 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.924 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 MiB | 0.0877 | 0.0872 | x0.994 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.906 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 MiB | 0.0875 | 0.0874 | x0.999 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.917 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 MiB | 0.0874 | 0.0872 | x0.998 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.907 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 MiB | 0.0884 | 0.0878 | x0.993 | level | 4 of 4 | - | - | x0.992 | x1.000 | x0.905 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 MiB | 0.115 | 0.115 | x0.995 | level | 3 of 4 | - | - | x0.995 | x1.000 | x1.024 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 MiB | 0.116 | 0.116 | x0.995 | level | 3 of 4 | - | - | x0.995 | x1.000 | x1.006 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 MiB | 0.117 | 0.116 | x0.994 | level | 3 of 4 | - | - | x0.993 | x1.000 | x1.005 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1 | 204.524 | 204.590 | x1.000 | level | 2 of 4 | - | - | x1.005 | x0.996 | x1.203 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2 | 105.383 | 104.802 | x0.994 | level | 3 of 4 | - | - | x0.998 | x0.995 | x1.008 |
| blake3-servil-st / solo / BriefIdleManyMessages / 3 | 90.849 | 92.064 | x1.013 | level | 1 of 4 | - | - | x1.002 | x0.997 | x1.143 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4 | 53.270 | 53.197 | x0.999 | level | 2 of 4 | - | - | x1.002 | x0.996 | x1.911 |
| blake3-servil-st / solo / BriefIdleManyMessages / 6 | 46.188 | 46.299 | x1.002 | level | 2 of 4 | - | - | x1.003 | x0.997 | x0.753 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8 | 29.188 | 28.505 | x0.977 | level | 3 of 4 | - | - | x0.995 | x0.997 | x0.939 |
| blake3-servil-st / solo / BriefIdleManyMessages / 12 | 25.955 | 25.908 | x0.998 | level | 3 of 4 | - | - | x0.996 | x0.997 | x0.713 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16 | 14.879 | 14.923 | x1.003 | level | 1 of 4 | - | - | x1.004 | x0.997 | x1.226 |
| blake3-servil-st / solo / BriefIdleManyMessages / 24 | 13.972 | 13.748 | x0.984 | level | 3 of 4 | - | - | x0.997 | x0.997 | x1.130 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32 | 10.471 | 10.518 | x1.004 | level | 2 of 4 | - | - | x1.003 | x0.998 | x1.405 |
| blake3-servil-st / solo / BriefIdleManyMessages / 48 | 9.157 | 9.173 | x1.002 | level | 1 of 4 | - | - | x1.001 | x0.999 | x1.820 |
| blake3-servil-st / solo / BriefIdleManyMessages / 64 | 8.424 | 8.445 | x1.002 | level | 1 of 4 | - | - | x1.002 | x0.999 | x2.221 |
| blake3-servil-st / solo / BriefIdleManyMessages / 128 | 7.412 | 7.512 | x1.014 | level | 0 of 4 | - | - | x1.003 | x0.999 | x1.038 |
| blake3-servil-st / solo / BriefIdleManyMessages / 256 | 7.089 | 7.072 | x0.998 | level | 2 of 4 | - | - | x1.003 | x0.999 | x0.959 |
| blake3-servil-st / solo / BriefIdleManyMessages / 512 | 6.795 | 6.805 | x1.002 | level | 2 of 4 | - | - | x1.001 | x0.999 | x0.462 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1024 | 6.663 | 6.670 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.135 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2048 | 6.673 | 6.652 | x0.997 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.813 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4096 | 6.807 | 6.784 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.807 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8192 | 7.263 | 7.234 | x0.996 | level | 2 of 4 | - | - | x0.995 | x1.000 | x0.945 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16384 | 7.444 | 7.413 | x0.996 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.945 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32768 | 7.487 | 7.482 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.972 |
| blake3-servil-st / solo / BriefIdleManyMessages / 65536 | 7.568 | 7.454 | x0.985 | level | 4 of 4 | - | - | x1.000 | x1.000 | x0.965 |
| blake3-servil-st / solo / BriefIdleManyMessages / 131072 | 7.444 | 7.448 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.908 |
| blake3-servil-st / solo / BriefIdleManyMessages / 262144 | 8.001 | 8.002 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.963 |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.940 | 0.941 | x1.002 | level | 0 of 4 | x1.002 | - | x1.001 | x1.000 | x0.804 |
| blake3-servil-st / solo / ContinuousMessages / 128 B | 1.079 | 1.081 | x1.002 | level | 1 of 4 | x1.002 | - | x1.000 | x1.000 | x1.350 |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 1.152 | 1.153 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | x0.790 |
| blake3-servil-st / solo / ContinuousMessages / 512 B | 1.189 | 1.190 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x1.452 |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 1.212 | 1.213 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | x0.814 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.364 | 0.358 | x0.983 | level | 2 of 4 | x0.983 | - | x1.000 | x1.000 | x1.029 |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.114 | 0.114 | x0.999 | level | 3 of 4 | x0.998 | - | x0.997 | x1.000 | x0.776 |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.0797 | 0.0811 | x1.017 | level | 0 of 4 | x1.016 | - | x1.016 | x1.000 | x0.657 |
| blake3-servil-st / solo / ContinuousMessages / 256 KiB | 0.0828 | 0.0826 | x0.998 | level | 3 of 4 | x0.998 | - | x0.997 | x1.000 | x0.594 |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.0843 | 0.0842 | x0.998 | level | 2 of 4 | x0.998 | - | x0.998 | x1.000 | x1.075 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.0857 | 0.0854 | x0.997 | level | 2 of 4 | x0.997 | - | x0.996 | x1.000 | x0.991 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.0858 | 0.0855 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x1.000 | x0.984 |
| blake3-servil-st / solo / ContinuousMessages / 64 MiB | 0.0985 | 0.0974 | x0.988 | level | 4 of 4 | x0.989 | - | x0.993 | x1.000 | x0.975 |
| blake3-servil-st / solo / ContinuousBatches / 16 | 7.534 | 7.584 | x1.007 | level | 1 of 4 | x1.006 | - | x1.005 | x1.000 | x0.627 |
| blake3-servil-st / solo / ContinuousBatches / 64 | 6.657 | 6.635 | x0.997 | level | 2 of 4 | x0.997 | - | x0.995 | x1.000 | x0.936 |
| blake3-servil-st / solo / ContinuousBatches / 256 | 6.572 | 6.604 | x1.005 | level | 1 of 4 | x1.005 | - | x1.004 | x1.000 | x0.939 |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 7.075 | 7.047 | x0.996 | level | 3 of 4 | x0.996 | - | x0.995 | x1.000 | x1.165 |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 6.830 | 6.845 | x1.002 | level | 2 of 4 | x1.002 | - | x1.000 | x1.000 | x0.761 |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 7.634 | 7.659 | x1.003 | level | 1 of 4 | x1.003 | - | x1.003 | x1.000 | x1.078 |
| blake3-servil-st / solo / ContinuousBatches / 65536 | 7.704 | 7.674 | x0.996 | level | 3 of 4 | x0.996 | - | x0.997 | x1.000 | x0.950 |
| blake3-servil-st / solo / LentMessages / 64 B | 0.940 | 0.941 | x1.002 | level | 0 of 4 | x1.002 | - | x1.001 | x1.000 | x0.804 |
| blake3-servil-st / solo / LentMessages / 128 B | 1.079 | 1.081 | x1.002 | level | 1 of 4 | x1.002 | - | x1.000 | x1.000 | x1.350 |
| blake3-servil-st / solo / LentMessages / 256 B | 1.152 | 1.153 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | x0.790 |
| blake3-servil-st / solo / LentMessages / 512 B | 1.189 | 1.190 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x1.452 |
| blake3-servil-st / solo / LentMessages / 1 KiB | 1.212 | 1.213 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | x0.814 |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.364 | 0.358 | x0.983 | level | 2 of 4 | x0.983 | - | x1.000 | x1.000 | x1.029 |
| blake3-servil-st / solo / LentMessages / 16 KiB | 0.114 | 0.114 | x0.999 | level | 3 of 4 | x0.998 | - | x0.997 | x1.000 | x0.776 |
| blake3-servil-st / solo / LentMessages / 64 KiB | 0.0797 | 0.0811 | x1.017 | level | 0 of 4 | x1.016 | - | x1.016 | x1.000 | x0.657 |
| blake3-servil-st / solo / LentMessages / 256 KiB | 0.0762 | 0.0760 | x0.997 | level | 2 of 4 | x0.996 | - | x0.995 | x1.000 | x0.231 |
| blake3-servil-st / solo / LentMessages / 1 MiB | 0.0866 | 0.0862 | x0.995 | level | 2 of 4 | x0.995 | - | x0.995 | x1.000 | x0.929 |
| blake3-servil-st / solo / LentMessages / 4 MiB | 0.0860 | 0.0862 | x1.002 | level | 1 of 4 | x1.003 | - | x1.002 | x1.000 | x1.037 |
| blake3-servil-st / solo / LentMessages / 16 MiB | 0.0919 | 0.0913 | x0.993 | level | 4 of 4 | x0.993 | - | x0.994 | x1.000 | x1.018 |
| blake3-servil-st / solo / LentMessages / 64 MiB | 0.118 | 0.118 | x0.999 | level | 3 of 4 | x0.999 | - | x0.997 | x1.000 | x1.015 |
| blake3-servil-st / solo / Interleaved / 256 | 0.137 | 0.137 | x1.005 | level | 1 of 4 | x1.005 | - | x1.002 | x1.000 | x1.022 |
| blake3-servil-st / solo / Collection / git objects | 0.0983 | 0.0983 | x0.999 | level | 2 of 4 | x1.000 | - | x0.999 | x1.000 | x1.015 |
| blake3-servil-st / solo / Collection / Nix files | 0.0888 | 0.0891 | x1.004 | level | 1 of 4 | x1.004 | - | x1.003 | x1.000 | x1.019 |
| blake3-servil-st / solo / LentBatches / 16 | 7.534 | 7.584 | x1.007 | level | 1 of 4 | x1.006 | - | x1.005 | x1.000 | x0.627 |
| blake3-servil-st / solo / LentBatches / 64 | 6.657 | 6.635 | x0.997 | level | 2 of 4 | x0.997 | - | x0.995 | x1.000 | x0.936 |
| blake3-servil-st / solo / LentBatches / 256 | 6.572 | 6.604 | x1.005 | level | 1 of 4 | x1.005 | - | x1.004 | x1.000 | x0.939 |
| blake3-servil-st / solo / LentBatches / 1024 | 7.075 | 7.047 | x0.996 | level | 3 of 4 | x0.996 | - | x0.995 | x1.000 | x1.165 |
| blake3-servil-st / solo / LentBatches / 4096 | 6.830 | 6.845 | x1.002 | level | 2 of 4 | x1.002 | - | x1.000 | x1.000 | x0.761 |
| blake3-servil-st / solo / LentBatches / 16384 | 7.634 | 7.659 | x1.003 | level | 1 of 4 | x1.003 | - | x1.003 | x1.000 | x1.078 |
| blake3-servil-st / solo / LentBatches / 65536 | 7.704 | 7.674 | x0.996 | level | 3 of 4 | x0.996 | - | x0.997 | x1.000 | x0.950 |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.137 | 0.136 | x0.987 | level | 3 of 4 | x0.990 | - | x0.991 | x1.000 | x0.933 |
| blake3-servil-st / solo / ContinuousCollection / Nix files | 0.146 | 0.146 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x0.980 |
| blake3-servil-st / solo / MerkleTree / 1024 | 0.123 | 0.124 | x1.002 | level | 2 of 4 | x1.002 | - | x1.000 | x1.000 | x1.609 |
| blake3-servil-st / solo / MerkleTree / 4096 | 0.134 | 0.134 | x0.997 | level | 2 of 4 | x0.997 | - | x0.997 | x1.000 | x0.629 |
| blake3-servil-st / solo / MerkleTree / 16384 | 0.133 | 0.133 | x1.000 | level | 1 of 4 | x1.000 | - | x0.999 | x1.000 | x0.938 |
| blake3-servil-st / solo / MerkleTree / 65536 | 0.141 | 0.141 | x1.000 | level | 1 of 4 | x1.000 | - | x0.999 | x1.000 | x0.971 |
| blake3-servil-st / solo / MerkleTree / 262144 | 0.151 | 0.151 | x1.002 | level | 1 of 4 | x1.001 | - | x0.998 | x1.000 | x1.012 |
| blake3-servil-st / solo / MerkleTree / 65536 x 32 B | 0.385 | 0.384 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x1.000 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 32 B | 0.422 | 0.421 | x0.998 | level | 2 of 4 | x0.998 | - | x0.999 | x1.000 | x0.929 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 16 B | 0.807 | 0.810 | x1.003 | level | 1 of 4 | x1.002 | - | x1.000 | x1.000 | x0.966 |
| blake3-servil-st / solo / MerkleTree / 65536 x 48 B | 0.269 | 0.268 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.893 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 48 B | 0.297 | 0.297 | x0.997 | level | 3 of 4 | x0.997 | - | x0.998 | x1.000 | x0.782 |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.244 | 0.247 | x1.012 | level | 2 of 4 | - | - | x1.013 | x1.021 | x1.015 |
| blake3-servil-st / solo / InterleavedTurn / 1024 x 1 KiB | 0.229 | 0.229 | x0.999 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.987 |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.208 | 0.209 | x1.004 | level | 3 of 4 | - | - | x1.003 | x1.001 | x1.021 |
| blake3-servil-st / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.189 | 0.191 | x1.012 | level | 1 of 4 | - | - | x1.011 | x1.000 | x0.975 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.205 | 0.202 | x0.987 | level | 3 of 4 | - | - | x0.989 | x0.985 | x1.027 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.187 | 0.190 | x1.012 | level | 0 of 4 | - | - | x1.011 | x1.000 | x0.974 |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.105 | 0.105 | x0.999 | level | 3 of 4 | x0.998 | - | x0.999 | x1.000 | x1.027 |
| blake3-servil-st / solo / ReceivingMessage / 2 μs | 0.109 | 0.106 | x0.977 | level | 3 of 4 | x0.977 | - | x0.996 | x1.000 | x0.985 |
| blake3-servil-st / solo / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 2 of 4 | x1.001 | - | x1.000 | x1.000 | x0.951 |
| blake3-servil-st / solo / IncrementalMessage / 64 B | 6.242 | 5.661 | x0.907 | level | 4 of 4 | - | - | x0.920 | x1.010 | x1.031 |
| blake3-servil-st / solo / IncrementalMessage / 1 KiB | 1.837 | 1.778 | x0.968 | level | 3 of 4 | - | - | x0.977 | x1.002 | x1.003 |
| blake3-servil-st / solo / IncrementalMessage / 4 KiB | 0.615 | 0.636 | x1.034 | level | 1 of 4 | - | - | x1.023 | x1.001 | x0.973 |
| blake3-servil-st / solo / LentIncrementalMessage / 64 B | 1.016 | 1.045 | x1.029 | level | 1 of 4 | x1.008 | - | x1.007 | x1.000 | x1.111 |
| blake3-servil-st / solo / LentIncrementalMessage / 1 KiB | 1.245 | 1.246 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | x1.321 |
| blake3-servil-st / solo / LentIncrementalMessage / 4 KiB | 0.366 | 0.365 | x0.997 | level | 2 of 4 | x0.997 | - | x1.000 | x1.000 | x1.161 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 0.951 | 0.951 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.996 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 4 KiB | 0.357 | 0.358 | x1.002 | level | 0 of 4 | x1.002 | - | x1.000 | x1.000 | x0.995 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 1 MiB | 0.0801 | 0.0825 | x1.030 | level | 0 of 4 | x1.030 | - | x1.030 | x1.000 | x0.821 |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 0.909 | 0.909 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | x0.781 |
| blake3-servil-st / solo / ContinuousLentMessages / 4 KiB | 0.353 | 0.354 | x1.003 | level | 0 of 4 | x1.002 | - | x1.000 | x1.000 | x0.956 |
| blake3-servil-st / solo / ContinuousLentMessages / 1 MiB | 0.0693 | 0.0691 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x1.000 | x1.084 |
| blake3-servil-mt / solo / OneMessage / 64 B | 5.944 | 5.500 | x0.925 | level | 3 of 4 | - | - | x0.942 | x0.999 | x0.987 |
| blake3-servil-mt / solo / OneMessage / 128 B | 3.679 | 3.365 | x0.915 | level | 4 of 4 | - | - | x0.946 | x1.001 | x0.965 |
| blake3-servil-mt / solo / OneMessage / 256 B | 2.599 | 2.483 | x0.955 | level | 3 of 4 | - | - | x0.961 | x1.006 | x0.951 |
| blake3-servil-mt / solo / OneMessage / 512 B | 1.931 | 1.880 | x0.973 | level | 4 of 4 | - | - | x0.974 | x1.002 | x0.956 |
| blake3-servil-mt / solo / OneMessage / 1 KiB | 1.658 | 1.645 | x0.992 | level | 3 of 4 | - | - | x0.996 | x1.003 | x0.985 |
| blake3-servil-mt / solo / OneMessage / 1536 B | 1.490 | 1.440 | x0.967 | level | 3 of 4 | - | - | x0.973 | x1.001 | x0.974 |
| blake3-servil-mt / solo / OneMessage / 2 KiB | 1.039 | 1.030 | x0.991 | level | 2 of 4 | - | - | x0.995 | x1.002 | x0.981 |
| blake3-servil-mt / solo / OneMessage / 2304 B | 1.181 | 1.200 | x1.016 | level | 2 of 4 | - | - | x1.021 | x1.001 | x0.990 |
| blake3-servil-mt / solo / OneMessage / 3 KiB | 0.801 | 0.809 | x1.010 | level | 3 of 4 | - | - | x1.016 | x1.000 | x0.953 |
| blake3-servil-mt / solo / OneMessage / 3839 B | 0.795 | 0.822 | x1.035 | level | 1 of 4 | - | - | x1.026 | x1.000 | x0.981 |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 0.588 | 0.582 | x0.990 | level | 3 of 4 | - | - | x1.008 | x1.000 | x0.978 |
| blake3-servil-mt / solo / OneMessage / 4470 B | 0.683 | 0.698 | x1.023 | level | 1 of 4 | - | - | x1.036 | x1.002 | x0.982 |
| blake3-servil-mt / solo / OneMessage / 7935 B | 0.589 | 0.582 | x0.988 | level | 4 of 4 | - | - | x1.002 | x1.001 | x1.015 |
| blake3-servil-mt / solo / OneMessage / 8 KiB | 0.446 | 0.431 | x0.965 | level | 3 of 4 | - | - | x0.977 | x1.001 | x1.006 |
| blake3-servil-mt / solo / OneMessage / 16 KiB | 0.309 | 0.305 | x0.988 | level | 3 of 4 | - | - | x0.989 | x1.000 | x1.002 |
| blake3-servil-mt / solo / OneMessage / 32 KiB | 0.204 | 0.195 | x0.959 | level | 3 of 4 | - | - | x0.963 | x1.000 | x0.983 |
| blake3-servil-mt / solo / OneMessage / 64 KiB | 0.152 | 0.151 | x0.992 | level | 2 of 4 | - | - | x0.992 | x1.000 | x1.023 |
| blake3-servil-mt / solo / OneMessage / 128 KiB | 0.126 | 0.125 | x0.989 | level | 4 of 4 | - | - | x0.995 | x1.000 | x1.042 |
| blake3-servil-mt / solo / OneMessage / 256 KiB | 0.113 | 0.113 | x1.000 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.000 |
| blake3-servil-mt / solo / OneMessage / 512 KiB | 0.0674 | 0.0680 | x1.008 | level | 2 of 4 | - | - | x1.008 | x0.974 | x0.965 |
| blake3-servil-mt / solo / OneMessage / 1 MiB | 0.0525 | 0.0520 | x0.991 | level | 3 of 4 | - | - | x0.986 | x0.998 | x1.002 |
| blake3-servil-mt / solo / OneMessage / 2 MiB | 0.0661 | 0.0648 | x0.981 | level | 2 of 4 | - | - | x0.982 | x0.995 | x1.000 |
| blake3-servil-mt / solo / OneMessage / 3 MiB | 0.0712 | 0.0711 | x0.999 | level | 2 of 4 | - | - | x0.998 | x0.987 | x1.002 |
| blake3-servil-mt / solo / OneMessage / 4 MiB | 0.0422 | 0.0425 | x1.007 | level | 2 of 4 | - | - | x1.009 | x1.009 | x0.996 |
| blake3-servil-mt / solo / OneMessage / 8 MiB | 0.0707 | 0.0699 | x0.988 | level | 1 of 4 | - | - | x1.011 | x1.000 | x1.001 |
| blake3-servil-mt / solo / OneMessage / 32 MiB | 0.0364 | 0.0364 | x1.000 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.051 |
| blake3-servil-mt / solo / OneMessage / 64 MiB | 0.0343 | 0.0340 | x0.992 | level | 3 of 4 | - | - | x0.992 | x0.988 | x1.018 |
| blake3-servil-mt / solo / OneMessage / 128 MiB | 0.0354 | 0.0354 | x1.000 | level | 3 of 4 | - | - | x1.001 | x1.000 | x0.998 |
| blake3-servil-mt / solo / ManyMessages / 1 | 497.582 | 484.778 | x0.974 | level | 3 of 4 | - | - | x0.977 | x0.999 | x0.986 |
| blake3-servil-mt / solo / ManyMessages / 2 | 249.091 | 252.298 | x1.013 | level | 2 of 4 | - | - | x1.004 | x1.005 | x0.990 |
| blake3-servil-mt / solo / ManyMessages / 3 | 207.145 | 209.611 | x1.012 | level | 2 of 4 | - | - | x1.002 | x1.003 | x0.990 |
| blake3-servil-mt / solo / ManyMessages / 4 | 136.845 | 143.165 | x1.046 | level | 2 of 4 | - | - | x1.043 | x1.007 | x1.003 |
| blake3-servil-mt / solo / ManyMessages / 6 | 116.531 | 119.683 | x1.027 | level | 2 of 4 | - | - | x1.025 | x1.005 | x0.974 |
| blake3-servil-mt / solo / ManyMessages / 8 | 172.143 | 167.940 | x0.976 | level | 2 of 4 | - | - | x0.989 | x1.005 | x1.000 |
| blake3-servil-mt / solo / ManyMessages / 12 | 126.353 | 129.714 | x1.027 | level | 2 of 4 | - | - | x1.028 | x1.005 | x1.009 |
| blake3-servil-mt / solo / ManyMessages / 16 | 98.042 | 93.827 | x0.957 | level | 3 of 4 | - | - | x0.966 | x1.008 | x0.984 |
| blake3-servil-mt / solo / ManyMessages / 24 | 104.747 | 97.923 | x0.935 | level | 3 of 4 | - | - | x0.966 | x1.003 | x0.994 |
| blake3-servil-mt / solo / ManyMessages / 32 | 50.076 | 49.176 | x0.982 | level | 2 of 4 | - | - | x0.992 | x1.004 | x0.992 |
| blake3-servil-mt / solo / ManyMessages / 48 | 34.340 | 35.575 | x1.036 | level | 1 of 4 | - | - | x1.039 | x1.005 | x0.991 |
| blake3-servil-mt / solo / ManyMessages / 64 | 28.066 | 28.128 | x1.002 | level | 2 of 4 | - | - | x1.008 | x1.002 | x0.984 |
| blake3-servil-mt / solo / ManyMessages / 128 | 19.238 | 18.768 | x0.976 | level | 2 of 4 | - | - | x0.979 | x1.002 | x1.004 |
| blake3-servil-mt / solo / ManyMessages / 256 | 14.132 | 13.841 | x0.979 | level | 3 of 4 | - | - | x0.992 | x1.001 | x1.009 |
| blake3-servil-mt / solo / ManyMessages / 512 | 11.259 | 11.294 | x1.003 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.977 |
| blake3-servil-mt / solo / ManyMessages / 1024 | 9.683 | 9.700 | x1.002 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.977 |
| blake3-servil-mt / solo / ManyMessages / 2048 | 9.111 | 9.001 | x0.988 | level | 4 of 4 | - | - | x0.996 | x1.000 | x0.943 |
| blake3-servil-mt / solo / ManyMessages / 4096 | 8.789 | 8.712 | x0.991 | level | 3 of 4 | - | - | x0.992 | x1.000 | x0.951 |
| blake3-servil-mt / solo / ManyMessages / 8192 | 3.700 | 3.759 | x1.016 | level | 1 of 4 | - | - | x1.025 | x1.035 | x0.993 |
| blake3-servil-mt / solo / ManyMessages / 16384 | 3.075 | 3.115 | x1.013 | level | 2 of 4 | - | - | x1.016 | x1.028 | x0.992 |
| blake3-servil-mt / solo / ManyMessages / 32768 | 2.704 | 2.772 | x1.025 | level | 2 of 4 | - | - | x1.031 | x1.014 | x1.005 |
| blake3-servil-mt / solo / ManyMessages / 65536 | 2.559 | 2.593 | x1.013 | level | 2 of 4 | - | - | x1.015 | x1.003 | x0.994 |
| blake3-servil-mt / solo / ManyMessages / 131072 | 4.468 | 4.484 | x1.004 | level | 2 of 4 | - | - | x1.004 | x0.992 | x0.999 |
| blake3-servil-mt / solo / ManyMessages / 262144 | 4.659 | 4.665 | x1.001 | level | 2 of 4 | - | - | x1.002 | x1.002 | x0.993 |
| blake3-servil-mt / solo / ManyLongMessages / 4 | 1848.853 | 1870.676 | x1.012 | level | 1 of 4 | - | - | x1.017 | x1.000 | x0.966 |
| blake3-servil-mt / solo / ManyLongMessages / 16 | 690.808 | 677.001 | x0.980 | level | 3 of 4 | - | - | x0.983 | x1.000 | x0.976 |
| blake3-servil-mt / solo / ManyLongMessages / 64 | 561.616 | 562.555 | x1.002 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.047 |
| blake3-servil-mt / solo / ManyLongMessages / 256 | 282.701 | 284.059 | x1.005 | level | 2 of 4 | - | - | x1.002 | x1.011 | x1.008 |
| blake3-servil-mt / solo / IdleOneMessage / 64 B | 3.022 | 3.019 | x0.999 | level | 2 of 4 | - | - | x1.000 | x0.990 | x1.006 |
| blake3-servil-mt / solo / IdleOneMessage / 128 B | 2.115 | 2.179 | x1.031 | level | 1 of 4 | - | - | x1.003 | x0.992 | x0.383 |
| blake3-servil-mt / solo / IdleOneMessage / 256 B | 1.764 | 1.756 | x0.996 | level | 3 of 4 | - | - | x1.000 | x0.995 | x1.268 |
| blake3-servil-mt / solo / IdleOneMessage / 512 B | 1.621 | 1.620 | x1.000 | level | 2 of 4 | - | - | x1.000 | x0.997 | x1.360 |
| blake3-servil-mt / solo / IdleOneMessage / 1 KiB | 1.569 | 1.557 | x0.992 | level | 2 of 4 | - | - | x0.999 | x0.998 | x0.955 |
| blake3-servil-mt / solo / IdleOneMessage / 1536 B | 1.198 | 1.190 | x0.993 | level | 2 of 4 | - | - | x0.998 | x0.999 | x1.308 |
| blake3-servil-mt / solo / IdleOneMessage / 2 KiB | 0.878 | 0.875 | x0.996 | level | 3 of 4 | - | - | x1.000 | x0.998 | x2.251 |
| blake3-servil-mt / solo / IdleOneMessage / 2304 B | 0.987 | 0.973 | x0.986 | level | 3 of 4 | - | - | x0.999 | x0.999 | x2.938 |
| blake3-servil-mt / solo / IdleOneMessage / 3 KiB | 0.628 | 0.621 | x0.989 | level | 4 of 4 | - | - | x0.997 | x0.999 | x0.498 |
| blake3-servil-mt / solo / IdleOneMessage / 3839 B | 0.507 | 0.508 | x1.003 | level | 1 of 4 | - | - | x0.997 | x0.999 | x0.506 |
| blake3-servil-mt / solo / IdleOneMessage / 4 KiB | 0.462 | 0.469 | x1.013 | level | 1 of 4 | - | - | x0.998 | x0.999 | x0.710 |
| blake3-servil-mt / solo / IdleOneMessage / 4470 B | 0.570 | 0.580 | x1.017 | level | 0 of 4 | - | - | x1.002 | x0.999 | x0.939 |
| blake3-servil-mt / solo / IdleOneMessage / 7935 B | 0.291 | 0.294 | x1.009 | level | 1 of 4 | - | - | x0.998 | x0.999 | x2.442 |
| blake3-servil-mt / solo / IdleOneMessage / 8 KiB | 0.272 | 0.273 | x1.002 | level | 1 of 4 | - | - | x0.999 | x0.999 | x2.127 |
| blake3-servil-mt / solo / IdleOneMessage / 16 KiB | 0.154 | 0.154 | x1.002 | level | 2 of 4 | - | - | x1.000 | x0.999 | x0.997 |
| blake3-servil-mt / solo / IdleOneMessage / 32 KiB | 0.108 | 0.108 | x0.993 | level | 3 of 4 | - | - | x0.998 | x0.999 | x0.881 |
| blake3-servil-mt / solo / IdleOneMessage / 64 KiB | 0.0991 | 0.0989 | x0.998 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.738 |
| blake3-servil-mt / solo / IdleOneMessage / 128 KiB | 0.0944 | 0.0944 | x1.000 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.793 |
| blake3-servil-mt / solo / IdleOneMessage / 256 KiB | 0.0937 | 0.0925 | x0.988 | level | 3 of 4 | - | - | x0.989 | x1.000 | x0.682 |
| blake3-servil-mt / solo / IdleOneMessage / 512 KiB | 0.0614 | 0.0618 | x1.006 | level | 2 of 4 | - | - | x1.009 | x1.009 | x1.006 |
| blake3-servil-mt / solo / IdleOneMessage / 1 MiB | 0.0570 | 0.0568 | x0.996 | level | 2 of 4 | - | - | x1.002 | x0.999 | x0.992 |
| blake3-servil-mt / solo / IdleOneMessage / 2 MiB | 0.0620 | 0.0589 | x0.949 | level | 3 of 4 | - | - | x0.955 | x1.034 | x0.986 |
| blake3-servil-mt / solo / IdleOneMessage / 3 MiB | 0.0615 | 0.0581 | x0.944 | level | 3 of 4 | - | - | x0.945 | x1.014 | x0.986 |
| blake3-servil-mt / solo / IdleOneMessage / 4 MiB | 0.0522 | 0.0515 | x0.987 | level | 2 of 4 | - | - | x0.988 | x0.991 | x0.980 |
| blake3-servil-mt / solo / IdleOneMessage / 8 MiB | 0.0662 | 0.0667 | x1.007 | level | 1 of 4 | - | - | x1.008 | x0.997 | x0.993 |
| blake3-servil-mt / solo / IdleOneMessage / 32 MiB | 0.0326 | 0.0324 | x0.994 | level | 3 of 4 | - | - | x0.994 | x1.001 | x0.991 |
| blake3-servil-mt / solo / IdleOneMessage / 64 MiB | 0.0341 | 0.0338 | x0.990 | level | 4 of 4 | - | - | x0.990 | x0.990 | x0.952 |
| blake3-servil-mt / solo / IdleOneMessage / 128 MiB | 0.0335 | 0.0336 | x1.003 | level | 3 of 4 | - | - | x1.003 | x1.007 | x0.981 |
| blake3-servil-mt / solo / IdleManyMessages / 1 | 212.278 | 209.153 | x0.985 | level | 2 of 4 | - | - | x1.009 | x0.995 | x1.220 |
| blake3-servil-mt / solo / IdleManyMessages / 2 | 109.129 | 106.549 | x0.976 | level | 3 of 4 | - | - | x0.996 | x0.995 | x0.709 |
| blake3-servil-mt / solo / IdleManyMessages / 3 | 91.230 | 91.034 | x0.998 | level | 2 of 4 | - | - | x0.997 | x0.997 | x1.524 |
| blake3-servil-mt / solo / IdleManyMessages / 4 | 54.438 | 53.844 | x0.989 | level | 2 of 4 | - | - | x0.995 | x0.994 | x2.606 |
| blake3-servil-mt / solo / IdleManyMessages / 6 | 51.176 | 51.367 | x1.004 | level | 2 of 4 | - | - | x0.994 | x0.995 | x0.625 |
| blake3-servil-mt / solo / IdleManyMessages / 8 | 33.744 | 33.452 | x0.991 | level | 3 of 4 | - | - | x0.990 | x0.996 | x0.676 |
| blake3-servil-mt / solo / IdleManyMessages / 12 | 32.219 | 31.705 | x0.984 | level | 3 of 4 | - | - | x1.000 | x0.997 | x1.333 |
| blake3-servil-mt / solo / IdleManyMessages / 16 | 18.388 | 18.958 | x1.031 | level | 0 of 4 | - | - | x1.013 | x0.997 | x2.608 |
| blake3-servil-mt / solo / IdleManyMessages / 24 | 17.256 | 16.977 | x0.984 | level | 3 of 4 | - | - | x0.992 | x0.997 | x0.277 |
| blake3-servil-mt / solo / IdleManyMessages / 32 | 12.910 | 13.102 | x1.015 | level | 1 of 4 | - | - | x1.003 | x0.998 | x1.238 |
| blake3-servil-mt / solo / IdleManyMessages / 48 | 11.434 | 11.473 | x1.003 | level | 1 of 4 | - | - | x1.008 | x0.999 | x1.785 |
| blake3-servil-mt / solo / IdleManyMessages / 64 | 10.630 | 10.593 | x0.997 | level | 2 of 4 | - | - | x1.004 | x0.999 | x0.604 |
| blake3-servil-mt / solo / IdleManyMessages / 128 | 9.331 | 9.432 | x1.011 | level | 1 of 4 | - | - | x1.006 | x0.999 | x1.111 |
| blake3-servil-mt / solo / IdleManyMessages / 256 | 8.802 | 8.796 | x0.999 | level | 3 of 4 | - | - | x1.008 | x0.999 | x1.708 |
| blake3-servil-mt / solo / IdleManyMessages / 512 | 8.463 | 8.378 | x0.990 | level | 2 of 4 | - | - | x0.997 | x0.999 | x0.519 |
| blake3-servil-mt / solo / IdleManyMessages / 1024 | 8.217 | 8.111 | x0.987 | level | 3 of 4 | - | - | x0.991 | x1.000 | x0.409 |
| blake3-servil-mt / solo / IdleManyMessages / 2048 | 8.001 | 7.949 | x0.993 | level | 2 of 4 | - | - | x0.989 | x1.000 | x0.527 |
| blake3-servil-mt / solo / IdleManyMessages / 4096 | 7.895 | 7.946 | x1.007 | level | 1 of 4 | - | - | x0.994 | x1.000 | x0.822 |
| blake3-servil-mt / solo / IdleManyMessages / 8192 | 3.569 | 3.671 | x1.029 | level | 1 of 4 | - | - | x1.027 | x1.025 | x0.998 |
| blake3-servil-mt / solo / IdleManyMessages / 16384 | 3.477 | 3.463 | x0.996 | level | 2 of 4 | - | - | x0.993 | x1.013 | x0.977 |
| blake3-servil-mt / solo / IdleManyMessages / 32768 | 2.810 | 2.795 | x0.994 | level | 2 of 4 | - | - | x0.995 | x1.012 | x0.981 |
| blake3-servil-mt / solo / IdleManyMessages / 65536 | 2.732 | 2.523 | x0.924 | level | 2 of 4 | - | - | x0.925 | x1.040 | x0.946 |
| blake3-servil-mt / solo / IdleManyMessages / 131072 | 3.803 | 4.170 | x1.097 | level | 1 of 4 | - | - | x1.097 | x0.955 | x1.047 |
| blake3-servil-mt / solo / IdleManyMessages / 262144 | 4.188 | 4.210 | x1.005 | level | 2 of 4 | - | - | x1.006 | x1.001 | x0.991 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 B | 3.058 | 2.998 | x0.980 | level | 4 of 4 | - | - | x1.001 | x0.990 | x0.896 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 B | 2.117 | 2.106 | x0.995 | level | 3 of 4 | - | - | x0.998 | x0.992 | x0.719 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 B | 1.689 | 1.692 | x1.002 | level | 2 of 4 | - | - | x1.003 | x0.995 | x1.512 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 B | 1.466 | 1.468 | x1.001 | level | 2 of 4 | - | - | x1.003 | x0.997 | x1.549 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 KiB | 1.357 | 1.350 | x0.995 | level | 3 of 4 | - | - | x1.000 | x0.998 | x1.677 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1536 B | 1.014 | 1.011 | x0.997 | level | 4 of 4 | - | - | x0.998 | x0.999 | x1.070 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 KiB | 0.732 | 0.735 | x1.004 | level | 3 of 4 | - | - | x0.999 | x0.998 | x1.073 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2304 B | 0.813 | 0.813 | x1.000 | level | 2 of 4 | - | - | x1.000 | x0.999 | x1.189 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 KiB | 0.526 | 0.527 | x1.002 | level | 2 of 4 | - | - | x1.001 | x0.999 | x2.942 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3839 B | 0.428 | 0.427 | x0.998 | level | 3 of 4 | - | - | x0.998 | x0.999 | x1.401 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 KiB | 0.394 | 0.391 | x0.993 | level | 3 of 4 | - | - | x0.999 | x0.999 | x0.394 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4470 B | 0.485 | 0.483 | x0.995 | level | 1 of 4 | - | - | x1.001 | x0.999 | x1.201 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 7935 B | 0.243 | 0.241 | x0.991 | level | 3 of 4 | - | - | x0.992 | x1.000 | x0.832 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 KiB | 0.225 | 0.227 | x1.009 | level | 1 of 4 | - | - | x1.000 | x0.999 | x0.665 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 16 KiB | 0.126 | 0.126 | x0.997 | level | 1 of 4 | - | - | x1.001 | x0.999 | x1.015 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 KiB | 0.0881 | 0.0886 | x1.005 | level | 1 of 4 | - | - | x1.000 | x0.999 | x2.084 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 KiB | 0.0813 | 0.0813 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.871 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 KiB | 0.0778 | 0.0776 | x0.998 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.461 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 KiB | 0.0782 | 0.0774 | x0.989 | level | 4 of 4 | - | - | x0.993 | x1.000 | x0.492 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 KiB | 0.0568 | 0.0581 | x1.022 | level | 2 of 4 | - | - | x1.028 | x1.059 | x0.978 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 MiB | 0.0479 | 0.0481 | x1.005 | level | 1 of 4 | - | - | x1.007 | x0.990 | x0.990 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 MiB | 0.0607 | 0.0640 | x1.055 | level | 2 of 4 | - | - | x1.057 | x0.974 | x0.978 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 MiB | 0.0620 | 0.0653 | x1.054 | level | 1 of 4 | - | - | x1.054 | x0.973 | x0.968 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 MiB | 0.0488 | 0.0460 | x0.944 | level | 3 of 4 | - | - | x0.945 | x1.019 | x0.951 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 MiB | 0.0671 | 0.0673 | x1.003 | level | 2 of 4 | - | - | x1.003 | x0.992 | x0.973 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 MiB | 0.0317 | 0.0314 | x0.991 | level | 3 of 4 | - | - | x0.991 | x1.000 | x0.986 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 MiB | 0.0333 | 0.0333 | x0.999 | level | 3 of 4 | - | - | x0.998 | x1.001 | x0.964 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 MiB | 0.0333 | 0.0333 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.977 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1 | 212.800 | 206.420 | x0.970 | level | 3 of 4 | - | - | x1.003 | x0.996 | x0.953 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2 | 105.927 | 105.636 | x0.997 | level | 3 of 4 | - | - | x0.993 | x0.995 | x0.826 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 3 | 93.017 | 92.905 | x0.999 | level | 2 of 4 | - | - | x1.000 | x0.997 | x1.299 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4 | 53.732 | 53.264 | x0.991 | level | 3 of 4 | - | - | x1.000 | x0.994 | x1.827 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 6 | 46.184 | 46.705 | x1.011 | level | 1 of 4 | - | - | x1.002 | x0.995 | x1.337 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8 | 29.210 | 28.515 | x0.976 | level | 4 of 4 | - | - | x0.994 | x0.995 | x1.284 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 12 | 26.091 | 25.818 | x0.990 | level | 4 of 4 | - | - | x0.995 | x0.996 | x1.935 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16 | 14.785 | 14.841 | x1.004 | level | 1 of 4 | - | - | x1.000 | x0.997 | x0.815 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 24 | 13.860 | 13.782 | x0.994 | level | 3 of 4 | - | - | x0.995 | x0.997 | x1.270 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32 | 10.559 | 10.586 | x1.003 | level | 2 of 4 | - | - | x1.002 | x0.998 | x1.894 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 48 | 9.181 | 9.256 | x1.008 | level | 0 of 4 | - | - | x1.003 | x0.999 | x2.161 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 64 | 8.469 | 8.463 | x0.999 | level | 2 of 4 | - | - | x0.999 | x0.999 | x1.587 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 128 | 7.454 | 7.449 | x0.999 | level | 2 of 4 | - | - | x0.999 | x0.999 | x0.775 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 256 | 7.053 | 7.093 | x1.006 | level | 1 of 4 | - | - | x1.003 | x0.999 | x1.045 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 512 | 6.808 | 6.807 | x1.000 | level | 3 of 4 | - | - | x1.000 | x0.999 | x0.594 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1024 | 6.718 | 6.671 | x0.993 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.943 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2048 | 6.649 | 6.624 | x0.996 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.718 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4096 | 6.758 | 6.715 | x0.994 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.762 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8192 | 3.198 | 3.163 | x0.989 | level | 3 of 4 | - | - | x0.970 | x0.957 | x0.991 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16384 | 2.989 | 2.957 | x0.989 | level | 1 of 4 | - | - | x0.985 | x1.006 | x0.975 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32768 | 2.640 | 2.676 | x1.014 | level | 2 of 4 | - | - | x1.014 | x1.004 | x0.992 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 65536 | 2.393 | 2.423 | x1.012 | level | 1 of 4 | - | - | x1.012 | x1.000 | x0.988 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 131072 | 4.023 | 4.188 | x1.041 | level | 2 of 4 | - | - | x1.042 | x0.979 | x1.008 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 262144 | 4.349 | 4.234 | x0.974 | level | 4 of 4 | - | - | x0.998 | x1.005 | x0.978 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.416 | 0.422 | x1.013 | level | 2 of 4 | x1.013 | - | x1.003 | x0.995 | x1.007 |
| blake3-servil-mt / solo / ContinuousMessages / 128 B | 0.246 | 0.216 | x0.879 | level | 4 of 4 | x0.871 | - | x0.913 | x0.995 | x1.266 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.124 | 0.121 | x0.973 | level | 4 of 4 | x0.979 | - | x0.973 | x0.996 | x1.140 |
| blake3-servil-mt / solo / ContinuousMessages / 512 B | 0.0650 | 0.0641 | x0.986 | level | 4 of 4 | x0.980 | - | x0.984 | x0.996 | x1.052 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.0505 | 0.0512 | x1.012 | level | 2 of 4 | x0.992 | - | x1.012 | x0.996 | x0.978 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0450 | 0.0450 | x1.001 | level | 2 of 4 | x0.986 | - | x1.007 | x0.998 | x0.973 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0346 | 0.0364 | x1.052 | level | 1 of 4 | x1.094 | - | x1.054 | x0.999 | x0.987 |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.0337 | 0.0331 | x0.983 | level | 4 of 4 | x0.989 | - | x0.982 | x1.001 | x1.097 |
| blake3-servil-mt / solo / ContinuousMessages / 256 KiB | 0.0346 | 0.0328 | x0.946 | level | 4 of 4 | x0.948 | - | x0.945 | x1.001 | x0.981 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0307 | 0.0297 | x0.968 | level | 2 of 4 | x0.973 | - | x0.981 | x1.001 | x0.999 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.0312 | 0.0316 | x1.014 | level | 0 of 4 | x1.013 | - | x1.002 | x1.001 | x1.003 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0318 | 0.0316 | x0.992 | level | 2 of 4 | x0.951 | - | x0.991 | x1.001 | x0.985 |
| blake3-servil-mt / solo / ContinuousMessages / 64 MiB | 0.0368 | 0.0358 | x0.971 | level | 3 of 4 | x0.990 | - | x0.971 | x1.001 | x1.012 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 3.652 | 3.631 | x0.994 | level | 2 of 4 | x1.004 | - | x0.993 | x0.997 | x1.053 |
| blake3-servil-mt / solo / ContinuousBatches / 64 | 2.372 | 2.374 | x1.001 | level | 2 of 4 | x1.034 | - | x1.000 | x0.998 | x1.010 |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 2.595 | 2.689 | x1.036 | level | 1 of 4 | x1.038 | - | x1.050 | x0.999 | x1.001 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 2.387 | 2.354 | x0.986 | level | 2 of 4 | x0.995 | - | x1.000 | x1.000 | x0.983 |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 2.592 | 2.529 | x0.976 | level | 3 of 4 | x1.007 | - | x0.979 | x1.000 | x0.996 |
| blake3-servil-mt / solo / ContinuousBatches / 16384 | 2.564 | 2.504 | x0.977 | level | 2 of 4 | x0.990 | - | x0.975 | x1.002 | x1.019 |
| blake3-servil-mt / solo / ContinuousBatches / 65536 | 2.933 | 2.786 | x0.950 | level | 4 of 4 | x0.920 | - | x0.950 | x1.012 | x0.972 |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.939 | 0.941 | x1.002 | level | 0 of 4 | x1.002 | - | x1.001 | x1.000 | x1.414 |
| blake3-servil-mt / solo / LentMessages / 128 B | 1.078 | 1.080 | x1.002 | level | 1 of 4 | x1.002 | - | x1.000 | x1.000 | x0.905 |
| blake3-servil-mt / solo / LentMessages / 256 B | 1.152 | 1.152 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.759 |
| blake3-servil-mt / solo / LentMessages / 512 B | 1.189 | 1.189 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.021 |
| blake3-servil-mt / solo / LentMessages / 1 KiB | 1.212 | 1.214 | x1.002 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | x0.745 |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.358 | 0.358 | x1.001 | level | 1 of 4 | x1.001 | - | x0.999 | x1.000 | x0.755 |
| blake3-servil-mt / solo / LentMessages / 16 KiB | 0.114 | 0.114 | x1.002 | level | 1 of 4 | x1.002 | - | x1.001 | x1.000 | x0.542 |
| blake3-servil-mt / solo / LentMessages / 64 KiB | 0.0796 | 0.0811 | x1.018 | level | 0 of 4 | x1.018 | - | x1.016 | x1.000 | x1.143 |
| blake3-servil-mt / solo / LentMessages / 256 KiB | 0.0761 | 0.0757 | x0.995 | level | 3 of 4 | x0.995 | - | x0.994 | x1.000 | x0.097 |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.0443 | 0.0452 | x1.021 | level | 1 of 4 | x1.003 | - | x1.022 | x1.006 | x1.008 |
| blake3-servil-mt / solo / LentMessages / 4 MiB | 0.0390 | 0.0394 | x1.010 | level | 1 of 4 | x1.025 | - | x1.010 | x1.003 | x0.993 |
| blake3-servil-mt / solo / LentMessages / 16 MiB | 0.0340 | 0.0339 | x0.998 | level | 2 of 4 | x0.999 | - | x0.999 | x1.005 | x0.995 |
| blake3-servil-mt / solo / LentMessages / 64 MiB | 0.0339 | 0.0339 | x0.997 | level | 4 of 4 | x0.995 | - | x0.996 | x1.001 | x0.986 |
| blake3-servil-mt / solo / Interleaved / 256 | 0.137 | 0.137 | x1.004 | level | 1 of 4 | x1.004 | - | x1.003 | x1.001 | x1.028 |
| blake3-servil-mt / solo / Collection / git objects | 0.00827 | 0.00827 | x1.000 | level | 2 of 4 | x0.995 | - | x1.003 | x0.997 | x0.994 |
| blake3-servil-mt / solo / Collection / Nix files | 0.0113 | 0.0114 | x1.009 | level | 3 of 4 | x1.006 | - | x1.008 | x1.020 | x1.035 |
| blake3-servil-mt / solo / LentBatches / 16 | 7.556 | 7.583 | x1.004 | level | 0 of 4 | x1.004 | - | x1.003 | x1.000 | x1.871 |
| blake3-servil-mt / solo / LentBatches / 64 | 6.660 | 6.636 | x0.996 | level | 2 of 4 | x0.996 | - | x0.994 | x1.000 | x1.120 |
| blake3-servil-mt / solo / LentBatches / 256 | 6.573 | 6.607 | x1.005 | level | 1 of 4 | x1.005 | - | x1.004 | x1.000 | x0.936 |
| blake3-servil-mt / solo / LentBatches / 1024 | 7.081 | 7.048 | x0.995 | level | 3 of 4 | x0.996 | - | x0.994 | x1.000 | x0.267 |
| blake3-servil-mt / solo / LentBatches / 4096 | 6.831 | 6.836 | x1.001 | level | 2 of 4 | x1.001 | - | x0.999 | x1.000 | x0.515 |
| blake3-servil-mt / solo / LentBatches / 16384 | 3.231 | 3.246 | x1.005 | level | 2 of 4 | x0.959 | - | x1.006 | x1.001 | x1.009 |
| blake3-servil-mt / solo / LentBatches / 65536 | 3.004 | 2.949 | x0.981 | level | 3 of 4 | x0.924 | - | x0.981 | x1.001 | x1.024 |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.0396 | 0.0385 | x0.973 | level | 4 of 4 | x0.984 | - | x0.972 | x0.999 | x1.000 |
| blake3-servil-mt / solo / ContinuousCollection / Nix files | 0.0413 | 0.0394 | x0.953 | level | 2 of 4 | x0.991 | - | x0.952 | x0.999 | x1.049 |
| blake3-servil-mt / solo / MerkleTree / 1024 | 0.124 | 0.124 | x1.002 | level | 1 of 4 | x1.002 | - | x1.001 | x1.000 | x1.564 |
| blake3-servil-mt / solo / MerkleTree / 4096 | 0.0695 | 0.0696 | x1.001 | level | 2 of 4 | x0.983 | - | x1.000 | x0.999 | x1.009 |
| blake3-servil-mt / solo / MerkleTree / 16384 | 0.0730 | 0.0699 | x0.958 | level | 3 of 4 | x0.938 | - | x0.957 | x1.009 | x0.924 |
| blake3-servil-mt / solo / MerkleTree / 65536 | 0.0779 | 0.0797 | x1.023 | level | 2 of 4 | x1.026 | - | x1.023 | x0.979 | x1.046 |
| blake3-servil-mt / solo / MerkleTree / 262144 | 0.0494 | 0.0496 | x1.004 | level | 1 of 4 | x0.997 | - | x1.002 | x1.002 | x0.992 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 32 B | 0.1000 | 0.0924 | x0.924 | level | 2 of 4 | x0.767 | - | x0.926 | x1.047 | x0.942 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 32 B | 0.0618 | 0.0613 | x0.991 | level | 3 of 4 | x0.996 | - | x0.990 | x0.976 | x1.035 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 16 B | 0.136 | 0.139 | x1.027 | level | 1 of 4 | x1.015 | - | x1.027 | x1.051 | x0.986 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 48 B | 0.0685 | 0.0695 | x1.014 | level | 2 of 4 | x1.030 | - | x1.014 | x0.999 | x1.061 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 48 B | 0.0551 | 0.0549 | x0.995 | level | 2 of 4 | x1.014 | - | x0.997 | x0.984 | x0.936 |
| blake3-servil-mt / solo / InterleavedTurn / 256 | 0.298 | 0.293 | x0.983 | level | 3 of 4 | - | - | x0.986 | x0.988 | x1.018 |
| blake3-servil-mt / solo / InterleavedTurn / 1024 x 1 KiB | 0.145 | 0.159 | x1.099 | level | 2 of 4 | - | - | x1.103 | x0.992 | x1.007 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 256 | 0.184 | 0.182 | x0.986 | level | 4 of 4 | - | - | x1.002 | x0.996 | x1.032 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.138 | 0.156 | x1.125 | level | 2 of 4 | - | - | x1.127 | x0.996 | x1.043 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 256 | 0.212 | 0.210 | x0.990 | level | 3 of 4 | - | - | x0.991 | x0.975 | x1.019 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.134 | 0.152 | x1.130 | level | 2 of 4 | - | - | x1.134 | x0.996 | x1.003 |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.0345 | 0.0346 | x1.002 | level | 2 of 4 | x1.004 | - | x1.001 | x1.001 | x1.004 |
| blake3-servil-mt / solo / ReceivingMessage / 2 μs | 0.0921 | 0.0921 | x1.000 | level | 1 of 4 | x0.990 | - | x1.031 | x1.001 | x1.042 |
| blake3-servil-mt / solo / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 0 of 4 | x1.004 | - | x1.045 | x1.001 | x1.035 |
| blake3-servil-mt / solo / IncrementalMessage / 64 B | 6.378 | 6.433 | x1.009 | level | 3 of 4 | - | - | x0.999 | x1.004 | x1.054 |
| blake3-servil-mt / solo / IncrementalMessage / 1 KiB | 1.852 | 1.841 | x0.994 | level | 3 of 4 | - | - | x0.994 | x1.002 | x1.018 |
| blake3-servil-mt / solo / IncrementalMessage / 4 KiB | 0.644 | 0.647 | x1.005 | level | 1 of 4 | - | - | x1.031 | x1.002 | x0.983 |
| blake3-servil-mt / solo / LentIncrementalMessage / 64 B | 0.947 | 0.948 | x1.001 | level | 2 of 4 | x1.001 | - | x1.000 | x1.000 | x1.199 |
| blake3-servil-mt / solo / LentIncrementalMessage / 1 KiB | 1.244 | 1.245 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | x0.973 |
| blake3-servil-mt / solo / LentIncrementalMessage / 4 KiB | 0.364 | 0.365 | x1.001 | level | 0 of 4 | x1.000 | - | x1.000 | x1.000 | x1.222 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 4.735 | 5.767 | x1.218 | level | 0 of 4 | x1.111 | - | x1.220 | x1.001 | x1.024 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 4 KiB | 0.0748 | 0.0796 | x1.064 | level | 1 of 4 | x1.037 | - | x1.064 | x1.000 | x1.001 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 1 MiB | 0.0299 | 0.0301 | x1.007 | level | 0 of 4 | x1.032 | - | x1.004 | x1.001 | x1.004 |
| blake3-servil-mt / solo / ContinuousLentMessages / 64 B | 0.371 | 0.359 | x0.968 | level | 3 of 4 | x1.027 | - | x0.950 | x0.995 | x1.257 |
| blake3-servil-mt / solo / ContinuousLentMessages / 4 KiB | 0.0366 | 0.0359 | x0.979 | level | 2 of 4 | x0.984 | - | x0.976 | x0.998 | x1.028 |
| blake3-servil-mt / solo / ContinuousLentMessages / 1 MiB | 0.00345 | 0.00349 | x1.010 | level | 0 of 4 | x1.037 | - | x1.011 | x1.014 | x1.019 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.411 | 0.408 | x0.993 | level | 3 of 4 | - | - | x0.993 | x0.995 | x0.920 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 128 B | 0.220 | 0.217 | x0.985 | level | 3 of 4 | - | - | x0.984 | x0.995 | x0.997 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.129 | 0.123 | x0.957 | level | 3 of 4 | - | - | x0.956 | x0.996 | x1.013 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 512 B | 0.0781 | 0.0753 | x0.964 | level | 3 of 4 | - | - | x0.970 | x0.996 | x1.029 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.0619 | 0.0615 | x0.995 | level | 2 of 4 | - | - | x0.993 | x0.996 | x0.990 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.0892 | 0.0895 | x1.003 | level | 2 of 4 | - | - | x1.016 | x0.999 | x0.946 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.0471 | 0.0478 | x1.014 | level | 3 of 4 | - | - | x1.051 | x0.986 | x1.016 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.0398 | 0.0396 | x0.995 | level | 3 of 4 | - | - | x0.994 | x1.001 | x0.972 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 KiB | 0.0378 | 0.0377 | x0.996 | level | 2 of 4 | - | - | x0.996 | x1.001 | x1.003 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0387 | 0.0387 | x0.999 | level | 3 of 4 | - | - | x1.001 | x1.000 | x1.013 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.0398 | 0.0403 | x1.012 | level | 1 of 4 | - | - | x1.013 | x1.000 | x0.999 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.0471 | 0.0476 | x1.011 | level | 1 of 4 | - | - | x1.011 | x1.000 | x0.996 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 MiB | 0.0512 | 0.0521 | x1.018 | level | 1 of 4 | - | - | x1.023 | x1.001 | x0.991 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 4.214 | 4.207 | x0.998 | level | 2 of 4 | - | - | x1.003 | x0.996 | x1.005 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 64 | 3.071 | 2.984 | x0.972 | level | 3 of 4 | - | - | x0.969 | x0.997 | x1.039 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 256 | 3.092 | 3.117 | x1.008 | level | 2 of 4 | - | - | x1.012 | x0.999 | x0.967 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 2.919 | 2.887 | x0.989 | level | 3 of 4 | - | - | x0.986 | x0.999 | x0.994 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 4096 | 3.517 | 3.418 | x0.972 | level | 2 of 4 | - | - | x1.026 | x0.998 | x1.023 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16384 | 2.953 | 2.897 | x0.981 | level | 3 of 4 | - | - | x0.983 | x0.997 | x0.994 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 65536 | 3.019 | 3.152 | x1.044 | level | 2 of 4 | - | - | x1.052 | x0.999 | x1.017 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.940 | 0.940 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.844 |
| blake3-servil-mt / shared-one-cache / LentMessages / 128 B | 1.078 | 1.078 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.872 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 B | 1.151 | 1.151 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.816 |
| blake3-servil-mt / shared-one-cache / LentMessages / 512 B | 1.188 | 1.188 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.855 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 KiB | 1.212 | 1.211 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.892 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.358 | 0.358 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.991 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 KiB | 0.114 | 0.114 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.747 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 KiB | 0.0812 | 0.0812 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.103 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 KiB | 0.0759 | 0.0759 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.735 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 MiB | 0.0551 | 0.0557 | x1.010 | level | 1 of 4 | - | - | x1.011 | x0.993 | x1.008 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 MiB | 0.0450 | 0.0447 | x0.993 | level | 3 of 4 | - | - | x0.997 | x1.004 | x0.963 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 MiB | 0.0569 | 0.0579 | x1.018 | level | 0 of 4 | - | - | x1.018 | x1.018 | x0.995 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 MiB | 0.0500 | 0.0510 | x1.019 | level | 0 of 4 | - | - | x1.001 | x1.010 | x1.002 |
| blake3-servil-mt / shared-one-cache / Interleaved / 256 | 0.137 | 0.137 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.989 |
| blake3-servil-mt / shared-one-cache / Collection / git objects | 0.0155 | 0.0159 | x1.024 | level | 1 of 4 | - | - | x1.036 | x1.031 | x1.026 |
| blake3-servil-mt / shared-one-cache / Collection / Nix files | 0.0178 | 0.0182 | x1.022 | level | 2 of 4 | - | - | x1.047 | x1.013 | x1.009 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16 | 7.589 | 7.548 | x0.995 | level | 4 of 4 | - | - | x0.994 | x1.000 | x0.851 |
| blake3-servil-mt / shared-one-cache / LentBatches / 64 | 6.801 | 6.657 | x0.979 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.862 |
| blake3-servil-mt / shared-one-cache / LentBatches / 256 | 6.557 | 6.578 | x1.003 | level | 1 of 4 | - | - | x1.003 | x1.000 | x0.914 |
| blake3-servil-mt / shared-one-cache / LentBatches / 1024 | 7.052 | 7.045 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.858 |
| blake3-servil-mt / shared-one-cache / LentBatches / 4096 | 6.823 | 6.818 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.711 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16384 | 3.817 | 3.723 | x0.975 | level | 3 of 4 | - | - | x0.972 | x0.960 | x1.000 |
| blake3-servil-mt / shared-one-cache / LentBatches / 65536 | 3.364 | 3.329 | x0.989 | level | 1 of 4 | - | - | x1.002 | x1.020 | x0.996 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.0597 | 0.0597 | x1.001 | level | 2 of 4 | - | - | x1.003 | x1.001 | x1.014 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / Nix files | 0.0578 | 0.0581 | x1.007 | level | 2 of 4 | - | - | x1.008 | x0.994 | x1.002 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1024 | 0.125 | 0.124 | x0.996 | level | 4 of 4 | - | - | x0.996 | x1.000 | x0.962 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 4096 | 0.0773 | 0.0773 | x1.000 | level | 1 of 4 | - | - | x1.001 | x1.002 | x1.003 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 16384 | 0.101 | 0.0968 | x0.959 | level | 2 of 4 | - | - | x0.959 | x1.021 | x0.913 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 | 0.124 | 0.124 | x0.995 | level | 2 of 4 | - | - | x0.996 | x0.999 | x1.004 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 262144 | 0.0702 | 0.0695 | x0.989 | level | 3 of 4 | - | - | x0.991 | x0.984 | x0.980 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 32 B | 0.179 | 0.190 | x1.061 | level | 1 of 4 | - | - | x1.063 | x0.906 | x1.120 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 32 B | 0.0819 | 0.0820 | x1.002 | level | 2 of 4 | - | - | x1.003 | x1.014 | x1.006 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 16 B | 0.184 | 0.184 | x1.000 | level | 2 of 4 | - | - | x1.009 | x1.003 | x0.992 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 48 B | 0.125 | 0.112 | x0.900 | level | 2 of 4 | - | - | x0.899 | x1.030 | x0.754 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 48 B | 0.0680 | 0.0681 | x1.001 | level | 2 of 4 | - | - | x0.999 | x1.016 | x1.033 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.0490 | 0.0467 | x0.953 | level | 4 of 4 | - | - | x0.954 | x0.996 | x1.032 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 2 μs | 0.0921 | 0.0921 | x1.000 | level | 1 of 4 | - | - | x0.986 | x1.001 | x1.003 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 2 of 4 | - | - | x1.027 | x0.997 | x1.016 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 64 B | 0.956 | 0.946 | x0.990 | level | 4 of 4 | - | - | x0.990 | x1.000 | x0.897 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 1 KiB | 1.244 | 1.244 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.158 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 4 KiB | 0.365 | 0.365 | x1.001 | level | 0 of 4 | - | - | x1.000 | x1.000 | x1.096 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 17.443 | 18.031 | x1.034 | level | 1 of 4 | - | - | x1.020 | x1.007 | x1.010 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 4 KiB | 0.273 | 0.265 | x0.972 | level | 3 of 4 | - | - | x1.004 | x1.006 | x0.999 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 1 MiB | 0.0392 | 0.0398 | x1.014 | level | 1 of 4 | - | - | x1.012 | x1.001 | x1.003 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 64 B | 0.365 | 0.353 | x0.969 | level | 3 of 4 | - | - | x0.969 | x0.995 | x1.048 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 4 KiB | 0.0747 | 0.0813 | x1.089 | level | 0 of 4 | - | - | x1.075 | x1.003 | x1.031 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 1 MiB | 0.00652 | 0.00699 | x1.073 | level | 1 of 4 | - | - | x0.881 | x0.833 | x0.844 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 B | 0.618 | 0.631 | x1.021 | level | 2 of 4 | - | - | x1.021 | x0.995 | x0.964 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 128 B | 0.355 | 0.358 | x1.009 | level | 2 of 4 | - | - | x1.008 | x0.995 | x0.948 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 256 B | 0.201 | 0.205 | x1.017 | level | 2 of 4 | - | - | x1.016 | x0.996 | x0.986 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 512 B | 0.131 | 0.129 | x0.987 | level | 2 of 4 | - | - | x0.987 | x0.996 | x1.023 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 KiB | 0.0945 | 0.0978 | x1.035 | level | 1 of 4 | - | - | x1.035 | x0.996 | x0.966 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 4 KiB | 0.0814 | 0.0842 | x1.035 | level | 2 of 4 | - | - | x1.064 | x1.001 | x0.989 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 16 KiB | 0.0672 | 0.0667 | x0.992 | level | 3 of 4 | - | - | x0.998 | x0.995 | x1.022 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 KiB | 0.0630 | 0.0617 | x0.980 | level | 2 of 4 | - | - | x0.980 | x1.002 | x0.982 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 256 KiB | 0.0632 | 0.0618 | x0.977 | level | 4 of 4 | - | - | x0.977 | x1.001 | x1.005 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 MiB | 0.0589 | 0.0577 | x0.979 | level | 2 of 4 | - | - | x0.979 | x1.001 | x1.001 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 4 MiB | 0.0567 | 0.0558 | x0.984 | level | 3 of 4 | - | - | x0.984 | x1.000 | x1.005 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 16 MiB | 0.0547 | 0.0562 | x1.027 | level | 1 of 4 | - | - | x1.027 | x1.002 | x0.992 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 MiB | 0.0608 | 0.0614 | x1.009 | level | 2 of 4 | - | - | x1.009 | x1.001 | x0.995 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 16 | 7.881 | 8.366 | x1.062 | level | 0 of 4 | - | - | x1.062 | x0.997 | x1.003 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 64 | 5.652 | 5.947 | x1.052 | level | 0 of 4 | - | - | x1.052 | x0.997 | x0.964 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 256 | 5.719 | 5.748 | x1.005 | level | 1 of 4 | - | - | x1.005 | x0.999 | x0.989 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 1024 | 4.628 | 4.731 | x1.022 | level | 1 of 4 | - | - | x1.022 | x0.999 | x0.985 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 4096 | 5.304 | 5.241 | x0.988 | level | 1 of 4 | - | - | x0.988 | x1.000 | x1.009 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 16384 | 4.382 | 4.391 | x1.002 | level | 2 of 4 | - | - | x1.002 | x0.987 | x1.012 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 65536 | 3.269 | 3.246 | x0.993 | level | 3 of 4 | - | - | x0.993 | x1.012 | x1.000 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 B | 0.940 | 0.940 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.865 |
| blake3-servil-mt / shared-two-caches / LentMessages / 128 B | 1.078 | 1.078 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.980 |
| blake3-servil-mt / shared-two-caches / LentMessages / 256 B | 1.151 | 1.151 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.892 |
| blake3-servil-mt / shared-two-caches / LentMessages / 512 B | 1.188 | 1.188 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.841 |
| blake3-servil-mt / shared-two-caches / LentMessages / 1 KiB | 1.211 | 1.211 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.894 |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 KiB | 0.357 | 0.357 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.082 |
| blake3-servil-mt / shared-two-caches / LentMessages / 16 KiB | 0.114 | 0.114 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.964 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 KiB | 0.0810 | 0.0811 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.063 |
| blake3-servil-mt / shared-two-caches / LentMessages / 256 KiB | 0.0774 | 0.0772 | x0.998 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.723 |
| blake3-servil-mt / shared-two-caches / LentMessages / 1 MiB | 0.0627 | 0.0635 | x1.013 | level | 2 of 4 | - | - | x1.015 | x1.006 | x1.000 |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 MiB | 0.0446 | 0.0426 | x0.955 | level | 4 of 4 | - | - | x0.954 | x0.998 | x1.005 |
| blake3-servil-mt / shared-two-caches / LentMessages / 16 MiB | 0.0400 | 0.0406 | x1.015 | level | 1 of 4 | - | - | x1.014 | x0.996 | x1.001 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 MiB | 0.0373 | 0.0373 | x1.002 | level | 1 of 4 | - | - | x1.002 | x1.002 | x1.014 |
| blake3-servil-mt / shared-two-caches / Interleaved / 256 | 0.137 | 0.137 | x0.999 | level | 3 of 4 | - | - | x0.999 | x0.999 | x0.996 |
| blake3-servil-mt / shared-two-caches / Collection / git objects | 0.0154 | 0.0157 | x1.014 | level | 1 of 4 | - | - | x0.962 | x0.966 | x0.978 |
| blake3-servil-mt / shared-two-caches / Collection / Nix files | 0.0175 | 0.0174 | x0.998 | level | 2 of 4 | - | - | x1.000 | x1.007 | x1.023 |
| blake3-servil-mt / shared-two-caches / LentBatches / 16 | 7.577 | 7.536 | x0.995 | level | 4 of 4 | - | - | x0.995 | x1.000 | x0.814 |
| blake3-servil-mt / shared-two-caches / LentBatches / 64 | 6.641 | 6.644 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.796 |
| blake3-servil-mt / shared-two-caches / LentBatches / 256 | 6.548 | 6.572 | x1.004 | level | 1 of 4 | - | - | x1.004 | x1.000 | x0.887 |
| blake3-servil-mt / shared-two-caches / LentBatches / 1024 | 7.042 | 7.042 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.103 |
| blake3-servil-mt / shared-two-caches / LentBatches / 4096 | 6.953 | 6.954 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.734 |
| blake3-servil-mt / shared-two-caches / LentBatches / 16384 | 4.273 | 4.280 | x1.002 | level | 2 of 4 | - | - | x1.001 | x0.997 | x1.008 |
| blake3-servil-mt / shared-two-caches / LentBatches / 65536 | 3.128 | 3.073 | x0.982 | level | 2 of 4 | - | - | x0.982 | x0.999 | x1.005 |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / git objects | 0.0666 | 0.0670 | x1.006 | level | 2 of 4 | - | - | x1.006 | x1.000 | x0.982 |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / Nix files | 0.0681 | 0.0663 | x0.972 | level | 2 of 4 | - | - | x0.972 | x0.999 | x0.991 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1024 | 0.127 | 0.127 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.989 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 4096 | 0.0740 | 0.0730 | x0.986 | level | 3 of 4 | - | - | x0.984 | x0.998 | x1.010 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 16384 | 0.0844 | 0.0843 | x0.999 | level | 3 of 4 | - | - | x1.000 | x1.013 | x0.948 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 | 0.0843 | 0.0809 | x0.960 | level | 4 of 4 | - | - | x0.960 | x1.015 | x0.935 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 262144 | 0.0607 | 0.0607 | x1.000 | level | 2 of 4 | - | - | x1.000 | x0.999 | x0.987 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 x 32 B | 0.178 | 0.179 | x1.003 | level | 2 of 4 | - | - | x1.005 | x0.989 | x1.000 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 32 B | 0.0802 | 0.0803 | x1.001 | level | 2 of 4 | - | - | x1.001 | x0.993 | x1.033 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 16 B | 0.158 | 0.157 | x0.992 | level | 3 of 4 | - | - | x0.991 | x1.003 | x0.991 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 x 48 B | 0.132 | 0.132 | x0.998 | level | 2 of 4 | - | - | x1.000 | x1.005 | x1.012 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 48 B | 0.0650 | 0.0644 | x0.991 | level | 4 of 4 | - | - | x0.992 | x1.005 | x0.964 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / saturated | 0.0627 | 0.0633 | x1.010 | level | 2 of 4 | - | - | x1.010 | x1.002 | x1.002 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / 2 μs | 0.0922 | 0.0923 | x1.001 | level | 0 of 4 | - | - | x1.006 | x0.994 | x1.002 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 1 of 4 | - | - | x1.074 | x0.995 | x1.032 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 64 B | 0.955 | 0.945 | x0.990 | level | 4 of 4 | - | - | x0.990 | x1.000 | x1.212 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 1 KiB | 1.244 | 1.244 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.191 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 4 KiB | 0.364 | 0.365 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.126 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 64 B | 17.822 | 17.720 | x0.994 | level | 2 of 4 | - | - | x0.968 | x1.004 | x1.008 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 4 KiB | 0.270 | 0.265 | x0.981 | level | 2 of 4 | - | - | x0.989 | x0.996 | x0.986 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 1 MiB | 0.0576 | 0.0590 | x1.024 | level | 0 of 4 | - | - | x1.025 | x1.001 | x0.995 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 64 B | 0.424 | 0.425 | x1.002 | level | 1 of 4 | - | - | x1.002 | x0.995 | x0.973 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 4 KiB | 0.0647 | 0.0643 | x0.994 | level | 3 of 4 | - | - | x1.000 | x0.993 | x1.030 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 1 MiB | 0.00697 | 0.00677 | x0.971 | level | 2 of 4 | - | - | x1.053 | x1.041 | x1.047 |

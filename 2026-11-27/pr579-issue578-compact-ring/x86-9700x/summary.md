# Nightly drift check: 2557d53c772e -> 7f392fdebc90

- Host: bench-9700x
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
| blake3-servil-st / solo / ManyMessages / 3 | 184.784 | 194.967 | x1.055 | level | 28 of 64 | - | - | x1.040 | x0.997 | x1.010 |
| blake3-servil-st / solo / ManyMessages / 6 | 93.464 | 98.657 | x1.056 | level | 24 of 64 | - | - | x1.038 | x0.997 | x1.020 |
| blake3-servil-st / solo / ManyMessages / 48 | 22.942 | 23.416 | x1.021 | level | 31 of 64 | - | - | x1.014 | x0.999 | x1.007 |
| blake3-servil-st / solo / ManyLongMessages / 4 | 1538.625 | 1547.749 | x1.006 | level | 29 of 64 | - | - | x1.005 | x1.000 | x0.991 |
| blake3-servil-mt / solo / ManyMessages / 3 | 195.559 | 207.509 | x1.061 | level | 27 of 64 | - | - | x1.044 | x0.998 | x1.016 |
| blake3-servil-mt / solo / ManyLongMessages / 4 | 1556.304 | 1558.756 | x1.002 | level | 29 of 64 | - | - | x1.000 | x1.000 | x0.993 |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.0381 | 0.0387 | x1.016 | level | 28 of 64 | x1.013 | - | x0.997 | x1.001 | x1.001 |
| blake3-servil-mt / solo / ContinuousLentMessages / 1 MiB | 0.00805 | 0.00806 | x1.001 | level | 30 of 64 | x1.000 | - | x1.001 | x1.004 | x1.029 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 MiB | 0.0445 | 0.0445 | x1.000 | level | 32 of 64 | - | - | x1.001 | x1.001 | x1.004 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 1 MiB | 0.0153 | 0.0152 | x0.995 | level | 33 of 64 | - | - | x0.998 | x0.997 | x0.982 |

## Stage 1 (initial screen, kept-drift)

compare: old side: bench 3f119a507807 clean; servil 2557d53c772e clean
compare: new side: bench 3f119a507807 clean; servil 7f392fdebc90 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 6.361 | 5.699 | x0.896 | level | 4 of 4 | - | - | x0.968 | x1.000 | x0.880 |
| blake3-servil-st / solo / OneMessage / 128 B | 4.137 | 3.570 | x0.863 | level | 4 of 4 | - | - | x0.938 | x0.999 | x0.895 |
| blake3-servil-st / solo / OneMessage / 256 B | 2.650 | 2.408 | x0.909 | level | 4 of 4 | - | - | x0.962 | x0.998 | x0.896 |
| blake3-servil-st / solo / OneMessage / 512 B | 1.877 | 1.763 | x0.940 | level | 3 of 4 | - | - | x0.975 | x1.003 | x0.912 |
| blake3-servil-st / solo / OneMessage / 1 KiB | 1.476 | 1.449 | x0.982 | level | 3 of 4 | - | - | x0.995 | x1.001 | x0.926 |
| blake3-servil-st / solo / OneMessage / 1536 B | 1.358 | 1.295 | x0.954 | level | 2 of 4 | - | - | x0.965 | x0.999 | x1.007 |
| blake3-servil-st / solo / OneMessage / 2 KiB | 0.833 | 0.823 | x0.988 | level | 3 of 4 | - | - | x1.004 | x1.001 | x0.990 |
| blake3-servil-st / solo / OneMessage / 2304 B | 0.994 | 0.997 | x1.003 | level | 1 of 4 | - | - | x0.997 | x0.999 | x1.017 |
| blake3-servil-st / solo / OneMessage / 3 KiB | 0.716 | 0.734 | x1.024 | level | 2 of 4 | - | - | x1.027 | x1.000 | x0.987 |
| blake3-servil-st / solo / OneMessage / 3839 B | 0.753 | 0.750 | x0.997 | level | 2 of 4 | - | - | x1.003 | x0.998 | x1.004 |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.454 | 0.456 | x1.005 | level | 2 of 4 | - | - | x0.999 | x0.998 | x0.996 |
| blake3-servil-st / solo / OneMessage / 4470 B | 0.581 | 0.559 | x0.963 | level | 3 of 4 | - | - | x0.975 | x1.000 | x1.017 |
| blake3-servil-st / solo / OneMessage / 7935 B | 0.583 | 0.579 | x0.993 | level | 2 of 4 | - | - | x0.999 | x0.999 | x0.980 |
| blake3-servil-st / solo / OneMessage / 8 KiB | 0.365 | 0.347 | x0.950 | level | 4 of 4 | - | - | x0.968 | x1.001 | x0.996 |
| blake3-servil-st / solo / OneMessage / 16 KiB | 0.227 | 0.226 | x0.995 | level | 2 of 4 | - | - | x1.004 | x1.000 | x1.020 |
| blake3-servil-st / solo / OneMessage / 32 KiB | 0.186 | 0.188 | x1.009 | level | 2 of 4 | - | - | x1.011 | x1.000 | x1.030 |
| blake3-servil-st / solo / OneMessage / 64 KiB | 0.141 | 0.138 | x0.976 | level | 3 of 4 | - | - | x0.979 | x1.000 | x1.077 |
| blake3-servil-st / solo / OneMessage / 128 KiB | 0.115 | 0.113 | x0.981 | level | 3 of 4 | - | - | x0.987 | x1.000 | x1.055 |
| blake3-servil-st / solo / OneMessage / 256 KiB | 0.102 | 0.102 | x0.995 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.040 |
| blake3-servil-st / solo / OneMessage / 512 KiB | 0.0912 | 0.0908 | x0.995 | level | 3 of 4 | - | - | x0.995 | x1.000 | x1.011 |
| blake3-servil-st / solo / OneMessage / 1 MiB | 0.0856 | 0.0854 | x0.998 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.030 |
| blake3-servil-st / solo / OneMessage / 2 MiB | 0.0844 | 0.0849 | x1.005 | level | 1 of 4 | - | - | x1.006 | x1.000 | x1.061 |
| blake3-servil-st / solo / OneMessage / 3 MiB | 0.0852 | 0.0850 | x0.998 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.016 |
| blake3-servil-st / solo / OneMessage / 4 MiB | 0.0849 | 0.0846 | x0.997 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.018 |
| blake3-servil-st / solo / OneMessage / 8 MiB | 0.0906 | 0.0901 | x0.995 | level | 4 of 4 | - | - | x0.996 | x1.000 | x1.017 |
| blake3-servil-st / solo / OneMessage / 32 MiB | 0.130 | 0.130 | x1.007 | level | 1 of 4 | - | - | x1.007 | x1.000 | x1.006 |
| blake3-servil-st / solo / OneMessage / 64 MiB | 0.130 | 0.131 | x1.007 | level | 0 of 4 | - | - | x1.007 | x1.000 | x1.008 |
| blake3-servil-st / solo / OneMessage / 128 MiB | 0.130 | 0.131 | x1.006 | level | 0 of 4 | - | - | x1.007 | x1.000 | x1.009 |
| blake3-servil-st / solo / ManyMessages / 1 | 635.320 | 633.249 | x0.997 | level | 2 of 4 | - | - | x1.089 | x1.000 | x0.909 |
| blake3-servil-st / solo / ManyMessages / 2 | 271.502 | 280.342 | x1.033 | level | 2 of 4 | - | - | x1.058 | x1.008 | x0.995 |
| blake3-servil-st / solo / ManyMessages / 3 | 204.159 | 218.979 | x1.073 | level | 1 of 4 | - | - | x1.118 | x1.005 | x0.983 |
| blake3-servil-st / solo / ManyMessages / 4 | 135.645 | 134.859 | x0.994 | level | 2 of 4 | - | - | x1.055 | x1.006 | x0.960 |
| blake3-servil-st / solo / ManyMessages / 6 | 97.172 | 106.465 | x1.096 | level | 1 of 4 | - | - | x1.111 | x1.000 | x0.996 |
| blake3-servil-st / solo / ManyMessages / 8 | 101.149 | 100.615 | x0.995 | level | 2 of 4 | - | - | x1.039 | x1.004 | x0.981 |
| blake3-servil-st / solo / ManyMessages / 12 | 78.198 | 80.082 | x1.024 | level | 2 of 4 | - | - | x1.054 | x1.004 | x0.999 |
| blake3-servil-st / solo / ManyMessages / 16 | 57.490 | 60.007 | x1.044 | level | 2 of 4 | - | - | x1.058 | x1.002 | x0.994 |
| blake3-servil-st / solo / ManyMessages / 24 | 51.037 | 53.538 | x1.049 | level | 1 of 4 | - | - | x1.067 | x0.999 | x0.991 |
| blake3-servil-st / solo / ManyMessages / 32 | 32.714 | 33.187 | x1.014 | level | 2 of 4 | - | - | x1.052 | x1.002 | x0.992 |
| blake3-servil-st / solo / ManyMessages / 48 | 22.923 | 24.837 | x1.084 | level | 1 of 4 | - | - | x1.076 | x1.002 | x0.991 |
| blake3-servil-st / solo / ManyMessages / 64 | 18.691 | 20.193 | x1.080 | level | 2 of 4 | - | - | x1.078 | x0.998 | x0.992 |
| blake3-servil-st / solo / ManyMessages / 128 | 13.462 | 13.493 | x1.002 | level | 2 of 4 | - | - | x1.010 | x1.003 | x0.994 |
| blake3-servil-st / solo / ManyMessages / 256 | 10.549 | 10.762 | x1.020 | level | 1 of 4 | - | - | x1.034 | x1.000 | x1.047 |
| blake3-servil-st / solo / ManyMessages / 512 | 9.009 | 8.979 | x0.997 | level | 2 of 4 | - | - | x1.004 | x1.000 | x1.030 |
| blake3-servil-st / solo / ManyMessages / 1024 | 8.152 | 8.096 | x0.993 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.063 |
| blake3-servil-st / solo / ManyMessages / 2048 | 7.775 | 7.602 | x0.978 | level | 4 of 4 | - | - | x0.983 | x1.000 | x1.065 |
| blake3-servil-st / solo / ManyMessages / 4096 | 7.633 | 7.434 | x0.974 | level | 3 of 4 | - | - | x0.976 | x1.000 | x1.087 |
| blake3-servil-st / solo / ManyMessages / 8192 | 7.124 | 7.033 | x0.987 | level | 3 of 4 | - | - | x0.988 | x1.000 | x1.036 |
| blake3-servil-st / solo / ManyMessages / 16384 | 6.775 | 6.751 | x0.996 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.014 |
| blake3-servil-st / solo / ManyMessages / 32768 | 6.788 | 6.797 | x1.001 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.053 |
| blake3-servil-st / solo / ManyMessages / 65536 | 6.944 | 6.944 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.040 |
| blake3-servil-st / solo / ManyMessages / 131072 | 7.223 | 7.223 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.990 |
| blake3-servil-st / solo / ManyMessages / 262144 | 7.679 | 7.688 | x1.001 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.992 |
| blake3-servil-st / solo / ManyLongMessages / 4 | 1635.704 | 1733.309 | x1.060 | level | 0 of 4 | - | - | x1.063 | x1.000 | x1.038 |
| blake3-servil-st / solo / ManyLongMessages / 16 | 638.229 | 668.335 | x1.047 | level | 1 of 4 | - | - | x1.049 | x1.000 | x0.993 |
| blake3-servil-st / solo / ManyLongMessages / 64 | 495.900 | 497.321 | x1.003 | level | 2 of 4 | - | - | x1.011 | x1.000 | x1.035 |
| blake3-servil-st / solo / ManyLongMessages / 256 | 444.030 | 444.411 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.080 |
| blake3-servil-st / solo / IdleOneMessage / 64 B | 3.440 | 3.432 | x0.998 | level | 2 of 4 | - | - | x1.002 | x0.994 | x1.098 |
| blake3-servil-st / solo / IdleOneMessage / 128 B | 2.418 | 2.418 | x1.000 | level | 2 of 4 | - | - | x0.999 | x0.994 | x1.172 |
| blake3-servil-st / solo / IdleOneMessage / 256 B | 1.932 | 1.924 | x0.996 | level | 3 of 4 | - | - | x1.001 | x0.996 | x1.041 |
| blake3-servil-st / solo / IdleOneMessage / 512 B | 1.644 | 1.635 | x0.995 | level | 2 of 4 | - | - | x1.000 | x0.997 | x0.797 |
| blake3-servil-st / solo / IdleOneMessage / 1 KiB | 1.560 | 1.532 | x0.982 | level | 2 of 4 | - | - | x0.999 | x0.999 | x0.854 |
| blake3-servil-st / solo / IdleOneMessage / 1536 B | 1.151 | 1.128 | x0.980 | level | 3 of 4 | - | - | x0.999 | x0.999 | x0.843 |
| blake3-servil-st / solo / IdleOneMessage / 2 KiB | 0.826 | 0.834 | x1.010 | level | 1 of 4 | - | - | x0.999 | x0.999 | x0.981 |
| blake3-servil-st / solo / IdleOneMessage / 2304 B | 0.910 | 0.905 | x0.994 | level | 2 of 4 | - | - | x1.000 | x0.999 | x1.257 |
| blake3-servil-st / solo / IdleOneMessage / 3 KiB | 0.590 | 0.589 | x0.998 | level | 2 of 4 | - | - | x0.999 | x0.999 | x1.654 |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 0.490 | 0.482 | x0.983 | level | 4 of 4 | - | - | x0.997 | x0.999 | x0.835 |
| blake3-servil-st / solo / IdleOneMessage / 4 KiB | 0.441 | 0.446 | x1.013 | level | 1 of 4 | - | - | x1.001 | x0.999 | x0.982 |
| blake3-servil-st / solo / IdleOneMessage / 4470 B | 0.546 | 0.539 | x0.987 | level | 3 of 4 | - | - | x1.002 | x0.999 | x2.034 |
| blake3-servil-st / solo / IdleOneMessage / 7935 B | 0.279 | 0.279 | x0.998 | level | 2 of 4 | - | - | x0.996 | x0.999 | x0.479 |
| blake3-servil-st / solo / IdleOneMessage / 8 KiB | 0.259 | 0.256 | x0.990 | level | 2 of 4 | - | - | x0.994 | x0.999 | x0.427 |
| blake3-servil-st / solo / IdleOneMessage / 16 KiB | 0.144 | 0.146 | x1.018 | level | 1 of 4 | - | - | x1.003 | x1.000 | x0.995 |
| blake3-servil-st / solo / IdleOneMessage / 32 KiB | 0.1000 | 0.0998 | x0.998 | level | 1 of 4 | - | - | x1.004 | x1.000 | x0.919 |
| blake3-servil-st / solo / IdleOneMessage / 64 KiB | 0.0910 | 0.0919 | x1.010 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.311 |
| blake3-servil-st / solo / IdleOneMessage / 128 KiB | 0.0875 | 0.0885 | x1.012 | level | 1 of 4 | - | - | x0.996 | x1.000 | x0.546 |
| blake3-servil-st / solo / IdleOneMessage / 256 KiB | 0.0875 | 0.0855 | x0.977 | level | 4 of 4 | - | - | x0.997 | x1.000 | x0.905 |
| blake3-servil-st / solo / IdleOneMessage / 512 KiB | 0.0961 | 0.0961 | x1.000 | level | 2 of 4 | - | - | x1.004 | x1.000 | x1.082 |
| blake3-servil-st / solo / IdleOneMessage / 1 MiB | 0.0977 | 0.0972 | x0.995 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.000 |
| blake3-servil-st / solo / IdleOneMessage / 2 MiB | 0.0987 | 0.101 | x1.025 | level | 0 of 4 | - | - | x1.002 | x1.000 | x0.979 |
| blake3-servil-st / solo / IdleOneMessage / 3 MiB | 0.0979 | 0.0982 | x1.002 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.955 |
| blake3-servil-st / solo / IdleOneMessage / 4 MiB | 0.0977 | 0.0983 | x1.006 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.962 |
| blake3-servil-st / solo / IdleOneMessage / 8 MiB | 0.0975 | 0.0982 | x1.008 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.968 |
| blake3-servil-st / solo / IdleOneMessage / 32 MiB | 0.125 | 0.125 | x1.004 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.013 |
| blake3-servil-st / solo / IdleOneMessage / 64 MiB | 0.129 | 0.130 | x1.006 | level | 0 of 4 | - | - | x1.008 | x1.000 | x1.011 |
| blake3-servil-st / solo / IdleOneMessage / 128 MiB | 0.129 | 0.130 | x1.006 | level | 1 of 4 | - | - | x1.005 | x1.000 | x1.013 |
| blake3-servil-st / solo / IdleManyMessages / 1 | 237.381 | 237.327 | x1.000 | level | 2 of 4 | - | - | x1.001 | x0.993 | x0.960 |
| blake3-servil-st / solo / IdleManyMessages / 2 | 120.486 | 121.417 | x1.008 | level | 1 of 4 | - | - | x0.994 | x0.994 | x1.108 |
| blake3-servil-st / solo / IdleManyMessages / 3 | 105.001 | 104.234 | x0.993 | level | 3 of 4 | - | - | x0.994 | x0.995 | x1.692 |
| blake3-servil-st / solo / IdleManyMessages / 4 | 61.674 | 61.494 | x0.997 | level | 1 of 4 | - | - | x0.996 | x0.994 | x1.226 |
| blake3-servil-st / solo / IdleManyMessages / 6 | 53.558 | 53.387 | x0.997 | level | 2 of 4 | - | - | x0.998 | x0.995 | x1.124 |
| blake3-servil-st / solo / IdleManyMessages / 8 | 33.571 | 32.408 | x0.965 | level | 4 of 4 | - | - | x0.991 | x0.995 | x0.953 |
| blake3-servil-st / solo / IdleManyMessages / 12 | 30.046 | 29.199 | x0.972 | level | 3 of 4 | - | - | x0.985 | x0.996 | x0.921 |
| blake3-servil-st / solo / IdleManyMessages / 16 | 17.290 | 17.614 | x1.019 | level | 2 of 4 | - | - | x1.001 | x0.995 | x0.806 |
| blake3-servil-st / solo / IdleManyMessages / 24 | 16.303 | 15.980 | x0.980 | level | 2 of 4 | - | - | x0.993 | x0.997 | x1.087 |
| blake3-servil-st / solo / IdleManyMessages / 32 | 12.289 | 12.381 | x1.008 | level | 1 of 4 | - | - | x1.001 | x0.997 | x0.320 |
| blake3-servil-st / solo / IdleManyMessages / 48 | 10.763 | 10.682 | x0.992 | level | 2 of 4 | - | - | x1.002 | x0.998 | x3.800 |
| blake3-servil-st / solo / IdleManyMessages / 64 | 9.905 | 9.969 | x1.006 | level | 1 of 4 | - | - | x1.002 | x0.998 | x0.601 |
| blake3-servil-st / solo / IdleManyMessages / 128 | 8.934 | 8.825 | x0.988 | level | 2 of 4 | - | - | x1.000 | x0.999 | x0.803 |
| blake3-servil-st / solo / IdleManyMessages / 256 | 7.994 | 8.240 | x1.031 | level | 0 of 4 | - | - | x1.003 | x1.000 | x1.031 |
| blake3-servil-st / solo / IdleManyMessages / 512 | 7.555 | 7.880 | x1.043 | level | 0 of 4 | - | - | x1.003 | x1.000 | x0.981 |
| blake3-servil-st / solo / IdleManyMessages / 1024 | 7.553 | 7.546 | x0.999 | level | 2 of 4 | - | - | x1.004 | x1.000 | x0.939 |
| blake3-servil-st / solo / IdleManyMessages / 2048 | 7.501 | 7.604 | x1.014 | level | 0 of 4 | - | - | x0.999 | x1.000 | x1.115 |
| blake3-servil-st / solo / IdleManyMessages / 4096 | 7.873 | 7.692 | x0.977 | level | 4 of 4 | - | - | x0.987 | x1.000 | x1.016 |
| blake3-servil-st / solo / IdleManyMessages / 8192 | 8.239 | 8.318 | x1.010 | level | 1 of 4 | - | - | x0.998 | x1.000 | x0.950 |
| blake3-servil-st / solo / IdleManyMessages / 16384 | 8.453 | 8.595 | x1.017 | level | 0 of 4 | - | - | x0.997 | x1.000 | x0.978 |
| blake3-servil-st / solo / IdleManyMessages / 32768 | 8.733 | 8.540 | x0.978 | level | 3 of 4 | - | - | x1.001 | x1.000 | x0.979 |
| blake3-servil-st / solo / IdleManyMessages / 65536 | 8.505 | 8.525 | x1.002 | level | 2 of 4 | - | - | x1.006 | x1.000 | x0.992 |
| blake3-servil-st / solo / IdleManyMessages / 131072 | 7.698 | 7.684 | x0.998 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.972 |
| blake3-servil-st / solo / IdleManyMessages / 262144 | 8.119 | 8.121 | x1.000 | level | 2 of 4 | - | - | x0.988 | x1.000 | x0.972 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 B | 2.406 | 2.420 | x1.006 | level | 1 of 4 | - | - | x1.002 | x0.993 | x1.099 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 B | 1.687 | 1.688 | x1.001 | level | 1 of 4 | - | - | x0.999 | x0.994 | x0.256 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 B | 1.351 | 1.352 | x1.001 | level | 1 of 4 | - | - | x1.000 | x0.996 | x1.446 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 B | 1.163 | 1.166 | x1.003 | level | 2 of 4 | - | - | x1.001 | x0.997 | x0.966 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 KiB | 1.077 | 1.078 | x1.001 | level | 1 of 4 | - | - | x1.000 | x0.999 | x1.328 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1536 B | 0.810 | 0.809 | x0.999 | level | 2 of 4 | - | - | x0.998 | x0.999 | x0.986 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 KiB | 0.584 | 0.583 | x0.999 | level | 4 of 4 | - | - | x0.998 | x0.999 | x1.113 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2304 B | 0.649 | 0.649 | x0.999 | level | 3 of 4 | - | - | x0.999 | x0.999 | x1.306 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.418 | 0.417 | x0.999 | level | 2 of 4 | - | - | x0.998 | x0.999 | x0.525 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3839 B | 0.341 | 0.340 | x0.996 | level | 3 of 4 | - | - | x0.996 | x0.999 | x1.552 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 KiB | 0.312 | 0.311 | x0.998 | level | 2 of 4 | - | - | x0.999 | x0.999 | x0.577 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4470 B | 0.383 | 0.383 | x1.000 | level | 2 of 4 | - | - | x1.000 | x0.999 | x0.832 |
| blake3-servil-st / solo / BriefIdleOneMessage / 7935 B | 0.196 | 0.192 | x0.982 | level | 3 of 4 | - | - | x0.999 | x0.999 | x1.185 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 KiB | 0.179 | 0.179 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.687 |
| blake3-servil-st / solo / BriefIdleOneMessage / 16 KiB | 0.100 | 0.101 | x1.003 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.381 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 KiB | 0.0704 | 0.0706 | x1.003 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.289 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 KiB | 0.0654 | 0.0668 | x1.021 | level | 1 of 4 | - | - | x1.003 | x1.000 | x0.768 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 KiB | 0.0628 | 0.0631 | x1.005 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.394 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 KiB | 0.0620 | 0.0620 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.481 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 KiB | 0.0673 | 0.0683 | x1.015 | level | 0 of 4 | - | - | x1.009 | x1.000 | x1.119 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 MiB | 0.0700 | 0.0705 | x1.008 | level | 1 of 4 | - | - | x1.007 | x1.000 | x0.962 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 MiB | 0.0706 | 0.0709 | x1.004 | level | 3 of 4 | - | - | x1.005 | x1.000 | x0.958 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 MiB | 0.0705 | 0.0706 | x1.002 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.937 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 MiB | 0.0702 | 0.0701 | x0.998 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.931 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 MiB | 0.0717 | 0.0723 | x1.008 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.919 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 MiB | 0.127 | 0.128 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.012 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 MiB | 0.130 | 0.131 | x1.006 | level | 0 of 4 | - | - | x1.006 | x1.000 | x1.013 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 MiB | 0.130 | 0.131 | x1.005 | level | 1 of 4 | - | - | x1.005 | x1.000 | x1.011 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1 | 165.577 | 164.729 | x0.995 | level | 3 of 4 | - | - | x1.002 | x0.994 | x1.134 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2 | 83.811 | 83.175 | x0.992 | level | 3 of 4 | - | - | x0.994 | x0.994 | x0.442 |
| blake3-servil-st / solo / BriefIdleManyMessages / 3 | 72.244 | 72.172 | x0.999 | level | 3 of 4 | - | - | x0.999 | x0.995 | x1.759 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4 | 42.421 | 42.225 | x0.995 | level | 3 of 4 | - | - | x0.995 | x0.994 | x0.914 |
| blake3-servil-st / solo / BriefIdleManyMessages / 6 | 36.796 | 36.626 | x0.995 | level | 3 of 4 | - | - | x0.995 | x0.995 | x1.051 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8 | 23.155 | 22.590 | x0.976 | level | 3 of 4 | - | - | x0.982 | x0.995 | x1.605 |
| blake3-servil-st / solo / BriefIdleManyMessages / 12 | 20.878 | 20.444 | x0.979 | level | 3 of 4 | - | - | x0.987 | x0.996 | x1.071 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16 | 11.888 | 12.019 | x1.011 | level | 2 of 4 | - | - | x1.004 | x0.995 | x0.999 |
| blake3-servil-st / solo / BriefIdleManyMessages / 24 | 11.179 | 11.139 | x0.996 | level | 2 of 4 | - | - | x0.994 | x0.997 | x0.985 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32 | 8.459 | 8.506 | x1.006 | level | 2 of 4 | - | - | x1.003 | x0.997 | x1.116 |
| blake3-servil-st / solo / BriefIdleManyMessages / 48 | 7.352 | 7.361 | x1.001 | level | 2 of 4 | - | - | x1.001 | x0.998 | x1.059 |
| blake3-servil-st / solo / BriefIdleManyMessages / 64 | 6.763 | 6.787 | x1.004 | level | 2 of 4 | - | - | x1.001 | x0.998 | x0.787 |
| blake3-servil-st / solo / BriefIdleManyMessages / 128 | 5.942 | 5.974 | x1.006 | level | 2 of 4 | - | - | x1.004 | x0.999 | x1.713 |
| blake3-servil-st / solo / BriefIdleManyMessages / 256 | 5.641 | 5.659 | x1.003 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.992 |
| blake3-servil-st / solo / BriefIdleManyMessages / 512 | 5.436 | 5.449 | x1.003 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.521 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1024 | 5.363 | 5.358 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.658 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2048 | 5.375 | 5.375 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.028 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4096 | 5.481 | 5.474 | x0.999 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.004 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8192 | 5.882 | 5.881 | x1.000 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.953 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16384 | 6.013 | 6.058 | x1.008 | level | 0 of 4 | - | - | x1.006 | x1.000 | x0.990 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32768 | 6.103 | 6.084 | x0.997 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.005 |
| blake3-servil-st / solo / BriefIdleManyMessages / 65536 | 6.052 | 6.049 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.987 |
| blake3-servil-st / solo / BriefIdleManyMessages / 131072 | 6.104 | 6.051 | x0.991 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.986 |
| blake3-servil-st / solo / BriefIdleManyMessages / 262144 | 6.995 | 7.000 | x1.001 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.992 |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.746 | 0.746 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.595 |
| blake3-servil-st / solo / ContinuousMessages / 128 B | 0.857 | 0.857 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x2.075 |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 0.914 | 0.915 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x0.718 |
| blake3-servil-st / solo / ContinuousMessages / 512 B | 0.943 | 0.943 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.597 |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 0.962 | 0.962 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.843 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.285 | 0.285 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | x1.067 |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.0907 | 0.0910 | x1.004 | level | 0 of 4 | x1.003 | - | x1.003 | x1.000 | x0.732 |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.0650 | 0.0653 | x1.004 | level | 0 of 4 | x1.004 | - | x1.004 | x1.000 | x1.456 |
| blake3-servil-st / solo / ContinuousMessages / 256 KiB | 0.0667 | 0.0667 | x1.000 | level | 3 of 4 | x1.000 | - | x1.001 | x1.000 | x1.095 |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.0677 | 0.0673 | x0.994 | level | 4 of 4 | x0.994 | - | x0.996 | x1.000 | x0.926 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.0686 | 0.0685 | x1.000 | level | 2 of 4 | x1.000 | - | x1.001 | x1.000 | x1.027 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.0687 | 0.0686 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x1.018 |
| blake3-servil-st / solo / ContinuousMessages / 64 MiB | 0.0795 | 0.0796 | x1.001 | level | 1 of 4 | x1.001 | - | x1.002 | x1.000 | x1.004 |
| blake3-servil-st / solo / ContinuousBatches / 16 | 6.026 | 6.074 | x1.008 | level | 1 of 4 | x1.008 | - | x1.008 | x1.000 | x1.289 |
| blake3-servil-st / solo / ContinuousBatches / 64 | 5.340 | 5.325 | x0.997 | level | 2 of 4 | x0.997 | - | x0.997 | x1.000 | x1.382 |
| blake3-servil-st / solo / ContinuousBatches / 256 | 5.306 | 5.320 | x1.003 | level | 2 of 4 | x1.003 | - | x1.002 | x1.000 | x0.915 |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 5.611 | 5.634 | x1.004 | level | 2 of 4 | x1.004 | - | x1.004 | x1.000 | x0.391 |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 5.489 | 5.493 | x1.001 | level | 3 of 4 | x1.001 | - | x1.000 | x1.000 | x0.602 |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 6.122 | 6.135 | x1.002 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x0.995 |
| blake3-servil-st / solo / ContinuousBatches / 65536 | 6.155 | 6.193 | x1.006 | level | 1 of 4 | x1.006 | - | x1.006 | x1.000 | x1.262 |
| blake3-servil-st / solo / LentMessages / 64 B | 0.746 | 0.746 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.595 |
| blake3-servil-st / solo / LentMessages / 128 B | 0.857 | 0.857 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x2.075 |
| blake3-servil-st / solo / LentMessages / 256 B | 0.914 | 0.915 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x0.718 |
| blake3-servil-st / solo / LentMessages / 512 B | 0.943 | 0.943 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.597 |
| blake3-servil-st / solo / LentMessages / 1 KiB | 0.962 | 0.962 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.843 |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.285 | 0.285 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | x1.067 |
| blake3-servil-st / solo / LentMessages / 16 KiB | 0.0907 | 0.0910 | x1.004 | level | 0 of 4 | x1.003 | - | x1.003 | x1.000 | x0.732 |
| blake3-servil-st / solo / LentMessages / 64 KiB | 0.0650 | 0.0653 | x1.004 | level | 0 of 4 | x1.004 | - | x1.004 | x1.000 | x1.456 |
| blake3-servil-st / solo / LentMessages / 256 KiB | 0.0614 | 0.0615 | x1.000 | level | 2 of 4 | x1.000 | - | x1.001 | x1.000 | x0.977 |
| blake3-servil-st / solo / LentMessages / 1 MiB | 0.0692 | 0.0691 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x1.101 |
| blake3-servil-st / solo / LentMessages / 4 MiB | 0.0693 | 0.0697 | x1.006 | level | 1 of 4 | x1.006 | - | x1.007 | x1.000 | x1.146 |
| blake3-servil-st / solo / LentMessages / 16 MiB | 0.0756 | 0.0758 | x1.002 | level | 3 of 4 | x1.002 | - | x1.002 | x1.000 | x1.038 |
| blake3-servil-st / solo / LentMessages / 64 MiB | 0.131 | 0.132 | x1.014 | level | 1 of 4 | x1.013 | - | x1.014 | x1.000 | x1.010 |
| blake3-servil-st / solo / Interleaved / 256 | 0.109 | 0.109 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.001 | x1.006 |
| blake3-servil-st / solo / Collection / git objects | 0.0843 | 0.0844 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | x1.011 |
| blake3-servil-st / solo / Collection / Nix files | 0.0740 | 0.0741 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | x1.021 |
| blake3-servil-st / solo / LentBatches / 16 | 6.026 | 6.074 | x1.008 | level | 1 of 4 | x1.008 | - | x1.008 | x1.000 | x1.289 |
| blake3-servil-st / solo / LentBatches / 64 | 5.340 | 5.325 | x0.997 | level | 2 of 4 | x0.997 | - | x0.997 | x1.000 | x1.382 |
| blake3-servil-st / solo / LentBatches / 256 | 5.306 | 5.320 | x1.003 | level | 2 of 4 | x1.003 | - | x1.002 | x1.000 | x0.915 |
| blake3-servil-st / solo / LentBatches / 1024 | 5.611 | 5.634 | x1.004 | level | 2 of 4 | x1.004 | - | x1.004 | x1.000 | x0.391 |
| blake3-servil-st / solo / LentBatches / 4096 | 5.489 | 5.493 | x1.001 | level | 3 of 4 | x1.001 | - | x1.000 | x1.000 | x0.602 |
| blake3-servil-st / solo / LentBatches / 16384 | 6.122 | 6.135 | x1.002 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x0.995 |
| blake3-servil-st / solo / LentBatches / 65536 | 6.155 | 6.193 | x1.006 | level | 1 of 4 | x1.006 | - | x1.006 | x1.000 | x1.262 |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.110 | 0.110 | x1.002 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x1.033 |
| blake3-servil-st / solo / ContinuousCollection / Nix files | 0.117 | 0.117 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.022 |
| blake3-servil-st / solo / MerkleTree / 1024 | 0.0995 | 0.0997 | x1.002 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x0.578 |
| blake3-servil-st / solo / MerkleTree / 4096 | 0.107 | 0.107 | x1.001 | level | 2 of 4 | x1.001 | - | x1.002 | x1.000 | x0.996 |
| blake3-servil-st / solo / MerkleTree / 16384 | 0.107 | 0.107 | x0.998 | level | 3 of 4 | x0.998 | - | x0.999 | x1.000 | x1.008 |
| blake3-servil-st / solo / MerkleTree / 65536 | 0.120 | 0.120 | x0.998 | level | 2 of 4 | x0.998 | - | x0.998 | x1.000 | x1.023 |
| blake3-servil-st / solo / MerkleTree / 262144 | 0.160 | 0.160 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x0.997 |
| blake3-servil-st / solo / MerkleTree / 65536 x 32 B | 0.308 | 0.308 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x0.936 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 32 B | 0.390 | 0.388 | x0.996 | level | 3 of 4 | x0.996 | - | x0.996 | x1.000 | x1.010 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 16 B | 0.701 | 0.699 | x0.996 | level | 3 of 4 | x0.996 | - | x0.996 | x1.000 | x1.020 |
| blake3-servil-st / solo / MerkleTree / 65536 x 48 B | 0.215 | 0.215 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x1.236 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 48 B | 0.288 | 0.286 | x0.996 | level | 3 of 4 | x0.996 | - | x0.996 | x1.000 | x0.998 |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.242 | 0.245 | x1.013 | level | 0 of 4 | - | - | x1.010 | x1.005 | x1.089 |
| blake3-servil-st / solo / InterleavedTurn / 1024 x 1 KiB | 0.208 | 0.209 | x1.006 | level | 2 of 4 | - | - | x1.004 | x1.000 | x1.008 |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.262 | 0.273 | x1.040 | level | 1 of 4 | - | - | x1.036 | x0.976 | x1.008 |
| blake3-servil-st / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.235 | 0.233 | x0.994 | level | 3 of 4 | - | - | x1.022 | x1.000 | x0.987 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.191 | 0.193 | x1.009 | level | 1 of 4 | - | - | x1.012 | x1.007 | x1.000 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.170 | 0.171 | x1.008 | level | 1 of 4 | - | - | x1.009 | x1.000 | x1.003 |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.0837 | 0.0840 | x1.004 | level | 1 of 4 | x1.004 | - | x1.004 | x1.000 | x1.031 |
| blake3-servil-st / solo / ReceivingMessage / 2 μs | 0.0923 | 0.0923 | x1.000 | level | 1 of 4 | x1.000 | - | x1.001 | x1.000 | x1.000 |
| blake3-servil-st / solo / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 2 of 4 | x1.000 | - | x1.002 | x1.000 | x0.968 |
| blake3-servil-st / solo / IncrementalMessage / 64 B | 7.726 | 7.689 | x0.995 | level | 1 of 4 | - | - | x0.993 | x0.995 | x0.958 |
| blake3-servil-st / solo / IncrementalMessage / 1 KiB | 1.776 | 1.742 | x0.981 | level | 3 of 4 | - | - | x0.977 | x0.999 | x0.982 |
| blake3-servil-st / solo / IncrementalMessage / 4 KiB | 0.550 | 0.539 | x0.979 | level | 3 of 4 | - | - | x0.989 | x0.999 | x1.032 |
| blake3-servil-st / solo / LentIncrementalMessage / 64 B | 0.807 | 0.806 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x1.079 |
| blake3-servil-st / solo / LentIncrementalMessage / 1 KiB | 0.988 | 0.988 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x1.167 |
| blake3-servil-st / solo / LentIncrementalMessage / 4 KiB | 0.290 | 0.290 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x1.026 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 0.757 | 0.756 | x0.999 | level | 3 of 4 | x0.999 | - | x1.000 | x1.000 | x0.492 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 4 KiB | 0.284 | 0.285 | x1.002 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x1.002 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 1 MiB | 0.0678 | 0.0676 | x0.998 | level | 3 of 4 | x0.998 | - | x0.997 | x1.000 | x0.960 |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 0.723 | 0.722 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x1.892 |
| blake3-servil-st / solo / ContinuousLentMessages / 4 KiB | 0.281 | 0.281 | x1.001 | level | 3 of 4 | x1.001 | - | x1.001 | x1.000 | x0.736 |
| blake3-servil-st / solo / ContinuousLentMessages / 1 MiB | 0.0567 | 0.0561 | x0.990 | level | 3 of 4 | x0.990 | - | x0.990 | x1.000 | x0.811 |
| blake3-servil-mt / solo / OneMessage / 64 B | 7.346 | 6.459 | x0.879 | level | 4 of 4 | - | - | x0.936 | x1.000 | x0.901 |
| blake3-servil-mt / solo / OneMessage / 128 B | 4.501 | 3.948 | x0.877 | level | 4 of 4 | - | - | x0.930 | x0.996 | x0.927 |
| blake3-servil-mt / solo / OneMessage / 256 B | 2.903 | 2.557 | x0.881 | level | 4 of 4 | - | - | x0.931 | x0.994 | x0.916 |
| blake3-servil-mt / solo / OneMessage / 512 B | 1.932 | 1.794 | x0.928 | level | 4 of 4 | - | - | x0.940 | x1.001 | x0.917 |
| blake3-servil-mt / solo / OneMessage / 1 KiB | 1.524 | 1.477 | x0.969 | level | 4 of 4 | - | - | x0.981 | x0.999 | x0.924 |
| blake3-servil-mt / solo / OneMessage / 1536 B | 1.399 | 1.330 | x0.951 | level | 3 of 4 | - | - | x0.957 | x1.001 | x1.007 |
| blake3-servil-mt / solo / OneMessage / 2 KiB | 0.853 | 0.847 | x0.992 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.995 |
| blake3-servil-mt / solo / OneMessage / 2304 B | 0.992 | 1.030 | x1.039 | level | 1 of 4 | - | - | x1.035 | x1.001 | x1.020 |
| blake3-servil-mt / solo / OneMessage / 3 KiB | 0.705 | 0.723 | x1.026 | level | 1 of 4 | - | - | x1.039 | x0.999 | x1.006 |
| blake3-servil-mt / solo / OneMessage / 3839 B | 0.765 | 0.757 | x0.991 | level | 1 of 4 | - | - | x1.000 | x0.999 | x1.016 |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 0.457 | 0.461 | x1.009 | level | 1 of 4 | - | - | x0.989 | x0.999 | x1.005 |
| blake3-servil-mt / solo / OneMessage / 4470 B | 0.591 | 0.573 | x0.969 | level | 3 of 4 | - | - | x0.986 | x0.999 | x1.001 |
| blake3-servil-mt / solo / OneMessage / 7935 B | 0.581 | 0.579 | x0.996 | level | 2 of 4 | - | - | x1.005 | x1.000 | x0.992 |
| blake3-servil-mt / solo / OneMessage / 8 KiB | 0.379 | 0.358 | x0.945 | level | 3 of 4 | - | - | x0.968 | x1.000 | x1.004 |
| blake3-servil-mt / solo / OneMessage / 16 KiB | 0.235 | 0.221 | x0.942 | level | 3 of 4 | - | - | x0.954 | x1.000 | x1.003 |
| blake3-servil-mt / solo / OneMessage / 32 KiB | 0.188 | 0.188 | x0.996 | level | 3 of 4 | - | - | x1.006 | x1.000 | x1.034 |
| blake3-servil-mt / solo / OneMessage / 64 KiB | 0.142 | 0.140 | x0.989 | level | 3 of 4 | - | - | x0.991 | x1.000 | x1.071 |
| blake3-servil-mt / solo / OneMessage / 128 KiB | 0.115 | 0.114 | x0.985 | level | 3 of 4 | - | - | x0.990 | x1.000 | x0.995 |
| blake3-servil-mt / solo / OneMessage / 256 KiB | 0.102 | 0.101 | x0.992 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.069 |
| blake3-servil-mt / solo / OneMessage / 512 KiB | 0.0615 | 0.0616 | x1.001 | level | 2 of 4 | - | - | x1.004 | x0.982 | x1.004 |
| blake3-servil-mt / solo / OneMessage / 1 MiB | 0.0489 | 0.0488 | x0.998 | level | 2 of 4 | - | - | x1.005 | x1.027 | x1.005 |
| blake3-servil-mt / solo / OneMessage / 2 MiB | 0.0429 | 0.0437 | x1.019 | level | 1 of 4 | - | - | x1.024 | x1.019 | x1.001 |
| blake3-servil-mt / solo / OneMessage / 3 MiB | 0.0411 | 0.0417 | x1.013 | level | 1 of 4 | - | - | x1.015 | x1.010 | x0.988 |
| blake3-servil-mt / solo / OneMessage / 4 MiB | 0.0392 | 0.0397 | x1.015 | level | 0 of 4 | - | - | x1.016 | x1.011 | x0.994 |
| blake3-servil-mt / solo / OneMessage / 8 MiB | 0.0384 | 0.0385 | x1.003 | level | 1 of 4 | - | - | x1.004 | x1.003 | x0.996 |
| blake3-servil-mt / solo / OneMessage / 32 MiB | 0.0742 | 0.0752 | x1.014 | level | 2 of 4 | - | - | x1.020 | x1.006 | x1.006 |
| blake3-servil-mt / solo / OneMessage / 64 MiB | 0.0740 | 0.0750 | x1.013 | level | 1 of 4 | - | - | x1.014 | x1.003 | x1.004 |
| blake3-servil-mt / solo / OneMessage / 128 MiB | 0.0739 | 0.0746 | x1.009 | level | 0 of 4 | - | - | x1.011 | x1.000 | x1.002 |
| blake3-servil-mt / solo / ManyMessages / 1 | 622.883 | 605.230 | x0.972 | level | 3 of 4 | - | - | x1.021 | x0.999 | x0.915 |
| blake3-servil-mt / solo / ManyMessages / 2 | 259.761 | 274.454 | x1.057 | level | 2 of 4 | - | - | x1.122 | x1.008 | x0.991 |
| blake3-servil-mt / solo / ManyMessages / 3 | 196.195 | 215.318 | x1.097 | level | 1 of 4 | - | - | x1.119 | x1.005 | x0.982 |
| blake3-servil-mt / solo / ManyMessages / 4 | 138.176 | 140.986 | x1.020 | level | 2 of 4 | - | - | x1.072 | x0.999 | x0.984 |
| blake3-servil-mt / solo / ManyMessages / 6 | 103.126 | 109.292 | x1.060 | level | 1 of 4 | - | - | x1.093 | x1.006 | x0.995 |
| blake3-servil-mt / solo / ManyMessages / 8 | 102.952 | 106.861 | x1.038 | level | 1 of 4 | - | - | x1.059 | x1.001 | x1.000 |
| blake3-servil-mt / solo / ManyMessages / 12 | 79.605 | 79.997 | x1.005 | level | 2 of 4 | - | - | x1.049 | x1.002 | x1.009 |
| blake3-servil-mt / solo / ManyMessages / 16 | 60.552 | 60.722 | x1.003 | level | 2 of 4 | - | - | x1.052 | x1.003 | x1.003 |
| blake3-servil-mt / solo / ManyMessages / 24 | 51.436 | 51.771 | x1.007 | level | 2 of 4 | - | - | x1.041 | x1.003 | x0.996 |
| blake3-servil-mt / solo / ManyMessages / 32 | 32.472 | 33.069 | x1.018 | level | 2 of 4 | - | - | x1.044 | x1.003 | x0.997 |
| blake3-servil-mt / solo / ManyMessages / 48 | 24.369 | 24.692 | x1.013 | level | 2 of 4 | - | - | x1.063 | x0.999 | x1.004 |
| blake3-servil-mt / solo / ManyMessages / 64 | 19.281 | 20.628 | x1.070 | level | 1 of 4 | - | - | x1.073 | x0.997 | x0.997 |
| blake3-servil-mt / solo / ManyMessages / 128 | 13.511 | 13.529 | x1.001 | level | 2 of 4 | - | - | x1.027 | x1.003 | x1.004 |
| blake3-servil-mt / solo / ManyMessages / 256 | 10.608 | 10.722 | x1.011 | level | 2 of 4 | - | - | x1.022 | x0.999 | x1.047 |
| blake3-servil-mt / solo / ManyMessages / 512 | 9.133 | 9.002 | x0.986 | level | 3 of 4 | - | - | x0.991 | x1.000 | x1.012 |
| blake3-servil-mt / solo / ManyMessages / 1024 | 8.162 | 8.082 | x0.990 | level | 3 of 4 | - | - | x0.989 | x1.000 | x1.076 |
| blake3-servil-mt / solo / ManyMessages / 2048 | 7.770 | 7.601 | x0.978 | level | 4 of 4 | - | - | x0.981 | x1.000 | x1.048 |
| blake3-servil-mt / solo / ManyMessages / 4096 | 7.637 | 7.426 | x0.972 | level | 3 of 4 | - | - | x0.975 | x1.000 | x1.074 |
| blake3-servil-mt / solo / ManyMessages / 8192 | 3.347 | 3.376 | x1.009 | level | 2 of 4 | - | - | x1.011 | x0.996 | x0.995 |
| blake3-servil-mt / solo / ManyMessages / 16384 | 2.765 | 2.778 | x1.005 | level | 2 of 4 | - | - | x1.012 | x1.027 | x0.998 |
| blake3-servil-mt / solo / ManyMessages / 32768 | 2.641 | 2.659 | x1.007 | level | 3 of 4 | - | - | x1.006 | x1.001 | x0.971 |
| blake3-servil-mt / solo / ManyMessages / 65536 | 2.425 | 2.426 | x1.000 | level | 2 of 4 | - | - | x1.001 | x0.999 | x0.950 |
| blake3-servil-mt / solo / ManyMessages / 131072 | 2.435 | 2.469 | x1.014 | level | 0 of 4 | - | - | x1.015 | x1.029 | x0.979 |
| blake3-servil-mt / solo / ManyMessages / 262144 | 2.906 | 2.913 | x1.003 | level | 2 of 4 | - | - | x1.003 | x0.999 | x1.014 |
| blake3-servil-mt / solo / ManyLongMessages / 4 | 1660.398 | 1769.616 | x1.066 | level | 0 of 4 | - | - | x1.043 | x1.000 | x1.033 |
| blake3-servil-mt / solo / ManyLongMessages / 16 | 637.988 | 658.276 | x1.032 | level | 1 of 4 | - | - | x1.050 | x1.000 | x0.988 |
| blake3-servil-mt / solo / ManyLongMessages / 64 | 493.734 | 498.783 | x1.010 | level | 1 of 4 | - | - | x1.011 | x1.000 | x1.008 |
| blake3-servil-mt / solo / ManyLongMessages / 256 | 236.384 | 242.004 | x1.024 | level | 0 of 4 | - | - | x1.030 | x1.031 | x1.004 |
| blake3-servil-mt / solo / IdleOneMessage / 64 B | 3.476 | 3.490 | x1.004 | level | 2 of 4 | - | - | x1.000 | x0.994 | x0.888 |
| blake3-servil-mt / solo / IdleOneMessage / 128 B | 2.414 | 2.433 | x1.008 | level | 1 of 4 | - | - | x1.000 | x0.994 | x1.240 |
| blake3-servil-mt / solo / IdleOneMessage / 256 B | 1.938 | 1.930 | x0.996 | level | 2 of 4 | - | - | x1.000 | x0.996 | x1.070 |
| blake3-servil-mt / solo / IdleOneMessage / 512 B | 1.649 | 1.707 | x1.035 | level | 1 of 4 | - | - | x1.000 | x0.997 | x1.586 |
| blake3-servil-mt / solo / IdleOneMessage / 1 KiB | 1.509 | 1.503 | x0.996 | level | 2 of 4 | - | - | x1.000 | x0.999 | x1.292 |
| blake3-servil-mt / solo / IdleOneMessage / 1536 B | 1.144 | 1.124 | x0.982 | level | 3 of 4 | - | - | x0.999 | x0.999 | x0.515 |
| blake3-servil-mt / solo / IdleOneMessage / 2 KiB | 0.820 | 0.830 | x1.011 | level | 1 of 4 | - | - | x0.999 | x0.999 | x0.519 |
| blake3-servil-mt / solo / IdleOneMessage / 2304 B | 0.935 | 0.905 | x0.968 | level | 4 of 4 | - | - | x1.000 | x0.999 | x1.440 |
| blake3-servil-mt / solo / IdleOneMessage / 3 KiB | 0.581 | 0.602 | x1.035 | level | 0 of 4 | - | - | x0.998 | x0.999 | x1.526 |
| blake3-servil-mt / solo / IdleOneMessage / 3839 B | 0.489 | 0.486 | x0.994 | level | 3 of 4 | - | - | x1.003 | x0.999 | x3.573 |
| blake3-servil-mt / solo / IdleOneMessage / 4 KiB | 0.437 | 0.443 | x1.014 | level | 1 of 4 | - | - | x1.005 | x0.999 | x1.303 |
| blake3-servil-mt / solo / IdleOneMessage / 4470 B | 0.538 | 0.553 | x1.027 | level | 1 of 4 | - | - | x1.003 | x0.999 | x4.606 |
| blake3-servil-mt / solo / IdleOneMessage / 7935 B | 0.270 | 0.277 | x1.026 | level | 0 of 4 | - | - | x0.999 | x1.000 | x0.797 |
| blake3-servil-mt / solo / IdleOneMessage / 8 KiB | 0.254 | 0.252 | x0.994 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.800 |
| blake3-servil-mt / solo / IdleOneMessage / 16 KiB | 0.145 | 0.146 | x1.004 | level | 1 of 4 | - | - | x0.996 | x1.000 | x0.407 |
| blake3-servil-mt / solo / IdleOneMessage / 32 KiB | 0.0990 | 0.101 | x1.020 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.948 |
| blake3-servil-mt / solo / IdleOneMessage / 64 KiB | 0.0912 | 0.0917 | x1.005 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.859 |
| blake3-servil-mt / solo / IdleOneMessage / 128 KiB | 0.0876 | 0.0866 | x0.989 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.391 |
| blake3-servil-mt / solo / IdleOneMessage / 256 KiB | 0.0858 | 0.0882 | x1.027 | level | 1 of 4 | - | - | x0.997 | x1.000 | x0.937 |
| blake3-servil-mt / solo / IdleOneMessage / 512 KiB | 0.0619 | 0.0612 | x0.988 | level | 2 of 4 | - | - | x0.979 | x0.989 | x1.018 |
| blake3-servil-mt / solo / IdleOneMessage / 1 MiB | 0.0512 | 0.0516 | x1.007 | level | 2 of 4 | - | - | x1.002 | x1.019 | x1.004 |
| blake3-servil-mt / solo / IdleOneMessage / 2 MiB | 0.0467 | 0.0471 | x1.008 | level | 0 of 4 | - | - | x1.014 | x1.000 | x0.981 |
| blake3-servil-mt / solo / IdleOneMessage / 3 MiB | 0.0441 | 0.0446 | x1.011 | level | 0 of 4 | - | - | x1.004 | x0.995 | x0.976 |
| blake3-servil-mt / solo / IdleOneMessage / 4 MiB | 0.0420 | 0.0422 | x1.005 | level | 1 of 4 | - | - | x1.012 | x1.004 | x0.968 |
| blake3-servil-mt / solo / IdleOneMessage / 8 MiB | 0.0390 | 0.0394 | x1.009 | level | 2 of 4 | - | - | x1.007 | x0.995 | x0.960 |
| blake3-servil-mt / solo / IdleOneMessage / 32 MiB | 0.0689 | 0.0699 | x1.014 | level | 1 of 4 | - | - | x1.029 | x1.002 | x1.001 |
| blake3-servil-mt / solo / IdleOneMessage / 64 MiB | 0.0730 | 0.0739 | x1.012 | level | 0 of 4 | - | - | x1.011 | x0.998 | x1.001 |
| blake3-servil-mt / solo / IdleOneMessage / 128 MiB | 0.0734 | 0.0742 | x1.011 | level | 0 of 4 | - | - | x1.012 | x0.998 | x1.001 |
| blake3-servil-mt / solo / IdleManyMessages / 1 | 238.011 | 236.918 | x0.995 | level | 2 of 4 | - | - | x1.000 | x0.993 | x1.148 |
| blake3-servil-mt / solo / IdleManyMessages / 2 | 123.304 | 121.205 | x0.983 | level | 3 of 4 | - | - | x0.999 | x0.993 | x1.172 |
| blake3-servil-mt / solo / IdleManyMessages / 3 | 107.037 | 104.674 | x0.978 | level | 4 of 4 | - | - | x0.994 | x0.995 | x0.453 |
| blake3-servil-mt / solo / IdleManyMessages / 4 | 62.413 | 61.065 | x0.978 | level | 3 of 4 | - | - | x0.998 | x0.994 | x1.147 |
| blake3-servil-mt / solo / IdleManyMessages / 6 | 53.512 | 53.301 | x0.996 | level | 2 of 4 | - | - | x0.997 | x0.995 | x1.464 |
| blake3-servil-mt / solo / IdleManyMessages / 8 | 33.767 | 32.616 | x0.966 | level | 2 of 4 | - | - | x0.987 | x0.995 | x0.828 |
| blake3-servil-mt / solo / IdleManyMessages / 12 | 30.239 | 30.000 | x0.992 | level | 3 of 4 | - | - | x0.989 | x0.996 | x1.445 |
| blake3-servil-mt / solo / IdleManyMessages / 16 | 17.363 | 17.546 | x1.011 | level | 1 of 4 | - | - | x1.007 | x0.995 | x1.333 |
| blake3-servil-mt / solo / IdleManyMessages / 24 | 16.515 | 16.335 | x0.989 | level | 2 of 4 | - | - | x0.993 | x0.997 | x2.534 |
| blake3-servil-mt / solo / IdleManyMessages / 32 | 12.499 | 12.466 | x0.997 | level | 1 of 4 | - | - | x1.010 | x0.997 | x5.955 |
| blake3-servil-mt / solo / IdleManyMessages / 48 | 10.904 | 10.859 | x0.996 | level | 2 of 4 | - | - | x1.000 | x0.998 | x0.572 |
| blake3-servil-mt / solo / IdleManyMessages / 64 | 9.912 | 9.819 | x0.991 | level | 3 of 4 | - | - | x1.001 | x0.998 | x1.100 |
| blake3-servil-mt / solo / IdleManyMessages / 128 | 8.594 | 8.713 | x1.014 | level | 2 of 4 | - | - | x1.004 | x0.999 | x2.732 |
| blake3-servil-mt / solo / IdleManyMessages / 256 | 8.187 | 7.936 | x0.969 | level | 4 of 4 | - | - | x1.001 | x1.000 | x1.343 |
| blake3-servil-mt / solo / IdleManyMessages / 512 | 7.934 | 7.691 | x0.969 | level | 3 of 4 | - | - | x0.993 | x1.000 | x0.375 |
| blake3-servil-mt / solo / IdleManyMessages / 1024 | 7.672 | 7.534 | x0.982 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.850 |
| blake3-servil-mt / solo / IdleManyMessages / 2048 | 7.639 | 7.565 | x0.990 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.152 |
| blake3-servil-mt / solo / IdleManyMessages / 4096 | 7.755 | 7.698 | x0.993 | level | 1 of 4 | - | - | x0.987 | x1.000 | x0.958 |
| blake3-servil-mt / solo / IdleManyMessages / 8192 | 3.450 | 3.378 | x0.979 | level | 3 of 4 | - | - | x0.990 | x1.009 | x0.969 |
| blake3-servil-mt / solo / IdleManyMessages / 16384 | 3.014 | 2.988 | x0.991 | level | 3 of 4 | - | - | x0.990 | x1.003 | x0.971 |
| blake3-servil-mt / solo / IdleManyMessages / 32768 | 2.963 | 2.985 | x1.008 | level | 2 of 4 | - | - | x0.988 | x0.992 | x0.975 |
| blake3-servil-mt / solo / IdleManyMessages / 65536 | 2.613 | 2.557 | x0.978 | level | 4 of 4 | - | - | x0.994 | x1.011 | x0.964 |
| blake3-servil-mt / solo / IdleManyMessages / 131072 | 2.470 | 2.433 | x0.985 | level | 4 of 4 | - | - | x1.003 | x1.011 | x0.966 |
| blake3-servil-mt / solo / IdleManyMessages / 262144 | 3.269 | 3.198 | x0.978 | level | 3 of 4 | - | - | x0.973 | x1.000 | x0.975 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 B | 2.420 | 2.442 | x1.009 | level | 1 of 4 | - | - | x1.008 | x0.993 | x1.311 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 B | 1.694 | 1.694 | x1.000 | level | 2 of 4 | - | - | x0.998 | x0.994 | x1.075 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 B | 1.352 | 1.357 | x1.004 | level | 1 of 4 | - | - | x1.000 | x0.996 | x1.167 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 B | 1.166 | 1.167 | x1.000 | level | 2 of 4 | - | - | x1.000 | x0.998 | x0.999 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 KiB | 1.079 | 1.080 | x1.001 | level | 1 of 4 | - | - | x1.000 | x0.999 | x0.852 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1536 B | 0.810 | 0.809 | x0.999 | level | 3 of 4 | - | - | x0.998 | x0.999 | x0.553 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 KiB | 0.585 | 0.585 | x0.999 | level | 2 of 4 | - | - | x0.999 | x0.999 | x1.136 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2304 B | 0.650 | 0.651 | x1.001 | level | 1 of 4 | - | - | x1.001 | x0.999 | x1.992 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 KiB | 0.419 | 0.419 | x0.999 | level | 2 of 4 | - | - | x0.999 | x0.999 | x0.728 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3839 B | 0.342 | 0.340 | x0.995 | level | 4 of 4 | - | - | x0.995 | x0.999 | x1.885 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 KiB | 0.312 | 0.312 | x0.998 | level | 4 of 4 | - | - | x0.999 | x0.999 | x1.183 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4470 B | 0.383 | 0.384 | x1.001 | level | 1 of 4 | - | - | x1.001 | x0.999 | x2.379 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 7935 B | 0.193 | 0.192 | x0.997 | level | 3 of 4 | - | - | x0.997 | x0.999 | x0.900 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 KiB | 0.179 | 0.179 | x1.001 | level | 1 of 4 | - | - | x1.001 | x0.999 | x0.491 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 16 KiB | 0.100 | 0.101 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.857 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 KiB | 0.0705 | 0.0707 | x1.003 | level | 1 of 4 | - | - | x1.004 | x1.000 | x0.789 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 KiB | 0.0655 | 0.0655 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.591 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 KiB | 0.0629 | 0.0628 | x0.997 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.475 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 KiB | 0.0621 | 0.0620 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.553 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 KiB | 0.0482 | 0.0491 | x1.019 | level | 1 of 4 | - | - | x1.025 | x1.002 | x1.023 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 MiB | 0.0436 | 0.0440 | x1.008 | level | 1 of 4 | - | - | x1.011 | x1.009 | x1.011 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 MiB | 0.0369 | 0.0371 | x1.005 | level | 1 of 4 | - | - | x1.005 | x0.996 | x0.987 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 MiB | 0.0327 | 0.0326 | x0.997 | level | 3 of 4 | - | - | x1.002 | x1.007 | x0.982 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 MiB | 0.0311 | 0.0313 | x1.005 | level | 1 of 4 | - | - | x1.005 | x0.998 | x0.973 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 MiB | 0.0295 | 0.0297 | x1.008 | level | 2 of 4 | - | - | x1.008 | x1.005 | x0.957 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 MiB | 0.0697 | 0.0702 | x1.007 | level | 2 of 4 | - | - | x1.007 | x1.001 | x1.005 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 MiB | 0.0737 | 0.0745 | x1.011 | level | 0 of 4 | - | - | x1.011 | x0.999 | x1.003 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 MiB | 0.0739 | 0.0745 | x1.008 | level | 0 of 4 | - | - | x1.009 | x0.999 | x1.002 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1 | 168.946 | 165.835 | x0.982 | level | 3 of 4 | - | - | x0.994 | x0.994 | x0.875 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2 | 84.575 | 83.579 | x0.988 | level | 2 of 4 | - | - | x0.990 | x0.994 | x0.386 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 3 | 72.829 | 72.411 | x0.994 | level | 1 of 4 | - | - | x0.993 | x0.995 | x1.201 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4 | 43.102 | 42.640 | x0.989 | level | 3 of 4 | - | - | x0.992 | x0.994 | x2.067 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 6 | 37.416 | 36.792 | x0.983 | level | 4 of 4 | - | - | x0.989 | x0.995 | x0.907 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8 | 23.525 | 22.806 | x0.969 | level | 3 of 4 | - | - | x0.979 | x0.995 | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 12 | 21.057 | 20.561 | x0.976 | level | 2 of 4 | - | - | x0.983 | x0.996 | x1.018 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16 | 12.074 | 12.108 | x1.003 | level | 2 of 4 | - | - | x1.000 | x0.995 | x1.145 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 24 | 11.301 | 11.163 | x0.988 | level | 2 of 4 | - | - | x0.991 | x0.997 | x1.161 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32 | 8.557 | 8.550 | x0.999 | level | 2 of 4 | - | - | x0.998 | x0.997 | x0.746 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 48 | 7.405 | 7.396 | x0.999 | level | 2 of 4 | - | - | x0.998 | x0.998 | x1.463 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 64 | 6.797 | 6.793 | x0.999 | level | 2 of 4 | - | - | x0.999 | x0.998 | x1.023 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 128 | 5.985 | 5.987 | x1.000 | level | 3 of 4 | - | - | x1.000 | x0.999 | x1.504 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 256 | 5.661 | 5.665 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.912 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 512 | 5.446 | 5.441 | x0.999 | level | 1 of 4 | - | - | x0.999 | x1.000 | x0.733 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1024 | 5.357 | 5.355 | x1.000 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.641 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2048 | 5.335 | 5.333 | x1.000 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.110 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4096 | 5.416 | 5.398 | x0.997 | level | 4 of 4 | - | - | x0.996 | x1.000 | x1.049 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8192 | 2.828 | 2.844 | x1.006 | level | 1 of 4 | - | - | x1.001 | x1.015 | x0.986 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16384 | 2.456 | 2.424 | x0.987 | level | 4 of 4 | - | - | x0.991 | x0.987 | x0.991 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32768 | 2.260 | 2.251 | x0.996 | level | 2 of 4 | - | - | x0.997 | x0.985 | x0.983 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 65536 | 1.875 | 1.859 | x0.991 | level | 4 of 4 | - | - | x0.992 | x1.001 | x0.963 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 131072 | 1.846 | 1.837 | x0.995 | level | 2 of 4 | - | - | x0.995 | x0.987 | x0.969 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 262144 | 2.343 | 2.330 | x0.994 | level | 3 of 4 | - | - | x0.996 | x0.992 | x0.990 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.361 | 0.357 | x0.989 | level | 2 of 4 | x0.997 | - | x0.990 | x0.995 | x0.998 |
| blake3-servil-mt / solo / ContinuousMessages / 128 B | 0.185 | 0.180 | x0.974 | level | 4 of 4 | x0.977 | - | x0.972 | x0.995 | x1.017 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.0976 | 0.0958 | x0.982 | level | 4 of 4 | x1.004 | - | x0.988 | x0.995 | x0.988 |
| blake3-servil-mt / solo / ContinuousMessages / 512 B | 0.0504 | 0.0500 | x0.992 | level | 3 of 4 | x0.994 | - | x0.996 | x0.996 | x1.007 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.0397 | 0.0406 | x1.023 | level | 1 of 4 | x0.990 | - | x1.026 | x0.996 | x1.007 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0354 | 0.0348 | x0.984 | level | 3 of 4 | x0.994 | - | x0.977 | x0.997 | x0.997 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0297 | 0.0302 | x1.018 | level | 0 of 4 | x0.994 | - | x1.020 | x0.999 | x1.016 |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.0271 | 0.0282 | x1.041 | level | 1 of 4 | x1.042 | - | x1.044 | x1.001 | x1.028 |
| blake3-servil-mt / solo / ContinuousMessages / 256 KiB | 0.0269 | 0.0263 | x0.979 | level | 3 of 4 | x0.989 | - | x0.981 | x1.001 | x1.029 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0249 | 0.0242 | x0.973 | level | 3 of 4 | x0.956 | - | x0.977 | x1.001 | x0.998 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.0251 | 0.0250 | x0.995 | level | 2 of 4 | x0.954 | - | x0.996 | x1.001 | x0.999 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0255 | 0.0255 | x0.999 | level | 2 of 4 | x0.987 | - | x0.997 | x1.001 | x0.983 |
| blake3-servil-mt / solo / ContinuousMessages / 64 MiB | 0.0312 | 0.0313 | x1.003 | level | 2 of 4 | x1.006 | - | x1.001 | x1.001 | x1.007 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 2.871 | 2.929 | x1.020 | level | 1 of 4 | x0.946 | - | x1.030 | x0.997 | x1.070 |
| blake3-servil-mt / solo / ContinuousBatches / 64 | 1.885 | 1.842 | x0.977 | level | 3 of 4 | x1.042 | - | x0.971 | x0.997 | x1.007 |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 2.167 | 2.168 | x1.000 | level | 1 of 4 | x0.985 | - | x0.999 | x0.999 | x0.988 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 1.859 | 1.872 | x1.007 | level | 2 of 4 | x0.969 | - | x1.008 | x1.000 | x0.977 |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 2.029 | 2.074 | x1.022 | level | 1 of 4 | x1.008 | - | x1.015 | x1.000 | x0.990 |
| blake3-servil-mt / solo / ContinuousBatches / 16384 | 2.090 | 2.135 | x1.021 | level | 1 of 4 | x1.014 | - | x0.996 | x0.999 | x0.997 |
| blake3-servil-mt / solo / ContinuousBatches / 65536 | 1.751 | 1.785 | x1.020 | level | 2 of 4 | x1.022 | - | x0.992 | x1.001 | x1.012 |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.746 | 0.746 | x1.000 | level | 2 of 4 | x1.000 | - | x1.001 | x1.000 | x0.431 |
| blake3-servil-mt / solo / LentMessages / 128 B | 0.856 | 0.856 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.288 |
| blake3-servil-mt / solo / LentMessages / 256 B | 0.914 | 0.914 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x0.442 |
| blake3-servil-mt / solo / LentMessages / 512 B | 0.945 | 0.945 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.569 |
| blake3-servil-mt / solo / LentMessages / 1 KiB | 0.962 | 0.962 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x5.092 |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.285 | 0.285 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x1.481 |
| blake3-servil-mt / solo / LentMessages / 16 KiB | 0.0909 | 0.0911 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.000 | x1.062 |
| blake3-servil-mt / solo / LentMessages / 64 KiB | 0.0651 | 0.0653 | x1.004 | level | 1 of 4 | x1.004 | - | x1.004 | x1.000 | x0.801 |
| blake3-servil-mt / solo / LentMessages / 256 KiB | 0.0614 | 0.0615 | x1.002 | level | 1 of 4 | x1.002 | - | x1.000 | x1.000 | x0.604 |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.0383 | 0.0394 | x1.030 | level | 2 of 4 | x1.020 | - | x1.008 | x1.028 | x1.000 |
| blake3-servil-mt / solo / LentMessages / 4 MiB | 0.0322 | 0.0321 | x0.995 | level | 2 of 4 | x0.986 | - | x1.012 | x1.004 | x0.983 |
| blake3-servil-mt / solo / LentMessages / 16 MiB | 0.0298 | 0.0299 | x1.001 | level | 1 of 4 | x0.993 | - | x1.006 | x0.997 | x1.014 |
| blake3-servil-mt / solo / LentMessages / 64 MiB | 0.0731 | 0.0740 | x1.012 | level | 2 of 4 | x1.002 | - | x1.013 | x0.999 | x1.003 |
| blake3-servil-mt / solo / Interleaved / 256 | 0.109 | 0.109 | x1.003 | level | 1 of 4 | x1.003 | - | x1.003 | x1.001 | x1.010 |
| blake3-servil-mt / solo / Collection / git objects | 0.0178 | 0.0178 | x1.003 | level | 1 of 4 | x1.015 | - | x0.990 | x0.998 | x1.025 |
| blake3-servil-mt / solo / Collection / Nix files | 0.0178 | 0.0176 | x0.991 | level | 3 of 4 | x0.991 | - | x0.999 | x0.990 | x1.004 |
| blake3-servil-mt / solo / LentBatches / 16 | 6.036 | 6.061 | x1.004 | level | 1 of 4 | x1.004 | - | x1.005 | x1.000 | x1.307 |
| blake3-servil-mt / solo / LentBatches / 64 | 5.329 | 5.316 | x0.997 | level | 2 of 4 | x0.997 | - | x0.997 | x1.000 | x1.207 |
| blake3-servil-mt / solo / LentBatches / 256 | 5.308 | 5.321 | x1.002 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x0.631 |
| blake3-servil-mt / solo / LentBatches / 1024 | 5.612 | 5.634 | x1.004 | level | 1 of 4 | x1.004 | - | x1.003 | x1.000 | x1.038 |
| blake3-servil-mt / solo / LentBatches / 4096 | 5.492 | 5.505 | x1.002 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x0.444 |
| blake3-servil-mt / solo / LentBatches / 16384 | 2.615 | 2.680 | x1.025 | level | 1 of 4 | x1.023 | - | x0.994 | x1.002 | x1.009 |
| blake3-servil-mt / solo / LentBatches / 65536 | 2.284 | 2.270 | x0.994 | level | 1 of 4 | x0.994 | - | x1.002 | x1.000 | x0.989 |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.0349 | 0.0354 | x1.015 | level | 0 of 4 | x1.022 | - | x1.015 | x1.000 | x1.006 |
| blake3-servil-mt / solo / ContinuousCollection / Nix files | 0.0331 | 0.0342 | x1.033 | level | 1 of 4 | x1.014 | - | x1.026 | x0.999 | x0.982 |
| blake3-servil-mt / solo / MerkleTree / 1024 | 0.0996 | 0.0997 | x1.001 | level | 2 of 4 | x1.001 | - | x1.002 | x1.000 | x0.434 |
| blake3-servil-mt / solo / MerkleTree / 4096 | 0.0575 | 0.0561 | x0.974 | level | 3 of 4 | x0.984 | - | x1.011 | x1.002 | x0.987 |
| blake3-servil-mt / solo / MerkleTree / 16384 | 0.0464 | 0.0463 | x0.996 | level | 3 of 4 | x1.019 | - | x1.007 | x1.006 | x0.885 |
| blake3-servil-mt / solo / MerkleTree / 65536 | 0.0416 | 0.0416 | x1.000 | level | 3 of 4 | x1.006 | - | x0.993 | x1.005 | x0.975 |
| blake3-servil-mt / solo / MerkleTree / 262144 | 0.0904 | 0.0905 | x1.001 | level | 1 of 4 | x1.001 | - | x1.004 | x1.002 | x0.994 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 32 B | 0.0784 | 0.0802 | x1.023 | level | 2 of 4 | x1.024 | - | x0.995 | x0.998 | x0.989 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 32 B | 0.176 | 0.180 | x1.020 | level | 1 of 4 | x1.026 | - | x1.023 | x1.008 | x1.001 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 16 B | 0.272 | 0.271 | x0.999 | level | 3 of 4 | x1.000 | - | x0.995 | x1.004 | x0.927 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 48 B | 0.0595 | 0.0599 | x1.006 | level | 1 of 4 | x1.009 | - | x0.995 | x1.001 | x0.977 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 48 B | 0.150 | 0.147 | x0.986 | level | 2 of 4 | x1.008 | - | x0.986 | x1.005 | x1.004 |
| blake3-servil-mt / solo / InterleavedTurn / 256 | 0.283 | 0.279 | x0.985 | level | 3 of 4 | - | - | x0.977 | x0.987 | x1.100 |
| blake3-servil-mt / solo / InterleavedTurn / 1024 x 1 KiB | 0.147 | 0.142 | x0.961 | level | 4 of 4 | - | - | x0.961 | x0.996 | x1.013 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 256 | 0.234 | 0.240 | x1.026 | level | 2 of 4 | - | - | x1.027 | x1.015 | x1.008 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.182 | 0.191 | x1.046 | level | 1 of 4 | - | - | x1.084 | x0.996 | x1.053 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 256 | 0.207 | 0.203 | x0.982 | level | 2 of 4 | - | - | x0.964 | x1.011 | x1.031 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.140 | 0.136 | x0.967 | level | 3 of 4 | - | - | x0.966 | x0.996 | x0.970 |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.0277 | 0.0276 | x0.998 | level | 2 of 4 | x0.996 | - | x0.999 | x0.998 | x1.018 |
| blake3-servil-mt / solo / ReceivingMessage / 2 μs | 0.0922 | 0.0922 | x1.000 | level | 3 of 4 | x0.982 | - | x0.984 | x1.001 | x1.035 |
| blake3-servil-mt / solo / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 2 of 4 | x1.001 | - | x1.009 | x1.001 | x1.044 |
| blake3-servil-mt / solo / IncrementalMessage / 64 B | 8.258 | 8.283 | x1.003 | level | 2 of 4 | - | - | x0.971 | x0.998 | x0.999 |
| blake3-servil-mt / solo / IncrementalMessage / 1 KiB | 1.739 | 1.727 | x0.993 | level | 2 of 4 | - | - | x0.989 | x1.000 | x0.992 |
| blake3-servil-mt / solo / IncrementalMessage / 4 KiB | 0.557 | 0.568 | x1.020 | level | 3 of 4 | - | - | x1.022 | x0.997 | x1.021 |
| blake3-servil-mt / solo / LentIncrementalMessage / 64 B | 0.780 | 0.779 | x0.999 | level | 3 of 4 | x0.999 | - | x1.000 | x1.000 | x0.913 |
| blake3-servil-mt / solo / LentIncrementalMessage / 1 KiB | 0.988 | 0.988 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x0.546 |
| blake3-servil-mt / solo / LentIncrementalMessage / 4 KiB | 0.290 | 0.290 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.307 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 4.238 | 4.230 | x0.998 | level | 3 of 4 | x0.999 | - | x1.001 | x1.000 | x0.977 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 4 KiB | 0.0609 | 0.0620 | x1.018 | level | 1 of 4 | x1.032 | - | x1.023 | x1.000 | x0.983 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 1 MiB | 0.0246 | 0.0246 | x1.001 | level | 2 of 4 | x1.035 | - | x0.998 | x1.001 | x1.004 |
| blake3-servil-mt / solo / ContinuousLentMessages / 64 B | 0.289 | 0.287 | x0.992 | level | 3 of 4 | x0.925 | - | x0.991 | x0.995 | x1.000 |
| blake3-servil-mt / solo / ContinuousLentMessages / 4 KiB | 0.0210 | 0.0211 | x1.004 | level | 1 of 4 | x1.050 | - | x0.999 | x0.997 | x0.990 |
| blake3-servil-mt / solo / ContinuousLentMessages / 1 MiB | 0.00798 | 0.00799 | x1.001 | level | 2 of 4 | x0.981 | - | x0.998 | x1.001 | x0.878 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.344 | 0.328 | x0.954 | level | 3 of 4 | - | - | x0.954 | x0.995 | x1.028 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 128 B | 0.174 | 0.174 | x0.997 | level | 2 of 4 | - | - | x0.994 | x0.995 | x0.960 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.0963 | 0.0976 | x1.014 | level | 1 of 4 | - | - | x1.013 | x0.995 | x0.961 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 512 B | 0.0603 | 0.0589 | x0.977 | level | 2 of 4 | - | - | x0.976 | x0.996 | x1.030 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.0494 | 0.0473 | x0.958 | level | 3 of 4 | - | - | x0.953 | x0.996 | x1.014 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.0654 | 0.0589 | x0.900 | level | 3 of 4 | - | - | x1.020 | x1.014 | x1.017 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.0374 | 0.0378 | x1.011 | level | 2 of 4 | - | - | x1.008 | x1.002 | x0.987 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.0330 | 0.0329 | x0.995 | level | 2 of 4 | - | - | x0.987 | x1.001 | x1.047 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 KiB | 0.0324 | 0.0321 | x0.990 | level | 3 of 4 | - | - | x0.983 | x1.001 | x1.007 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0331 | 0.0325 | x0.981 | level | 4 of 4 | - | - | x0.974 | x1.003 | x1.008 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.0334 | 0.0330 | x0.986 | level | 3 of 4 | - | - | x0.995 | x1.001 | x1.010 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.0410 | 0.0402 | x0.981 | level | 3 of 4 | - | - | x0.973 | x1.001 | x0.999 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 MiB | 0.0476 | 0.0470 | x0.987 | level | 3 of 4 | - | - | x0.986 | x1.002 | x1.006 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 3.480 | 3.403 | x0.978 | level | 2 of 4 | - | - | x0.974 | x0.997 | x1.080 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 64 | 2.454 | 2.550 | x1.039 | level | 0 of 4 | - | - | x1.044 | x0.998 | x0.987 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 256 | 2.574 | 2.596 | x1.009 | level | 1 of 4 | - | - | x1.006 | x0.999 | x0.926 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 2.344 | 2.343 | x1.000 | level | 3 of 4 | - | - | x0.997 | x0.999 | x1.025 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 4096 | 2.819 | 2.784 | x0.988 | level | 2 of 4 | - | - | x0.998 | x0.992 | x0.998 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16384 | 2.505 | 2.427 | x0.969 | level | 3 of 4 | - | - | x0.982 | x0.996 | x0.973 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 65536 | 2.268 | 2.219 | x0.978 | level | 3 of 4 | - | - | x0.980 | x0.993 | x0.988 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.747 | 0.747 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.871 |
| blake3-servil-mt / shared-one-cache / LentMessages / 128 B | 0.856 | 0.856 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.338 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 B | 0.914 | 0.914 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.088 |
| blake3-servil-mt / shared-one-cache / LentMessages / 512 B | 0.945 | 0.944 | x0.999 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.943 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 KiB | 0.961 | 0.961 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.923 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.285 | 0.284 | x0.999 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.047 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 KiB | 0.0908 | 0.0908 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.047 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 KiB | 0.0651 | 0.0655 | x1.006 | level | 0 of 4 | - | - | x1.006 | x1.000 | x0.904 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 KiB | 0.0615 | 0.0615 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.982 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 MiB | 0.0435 | 0.0462 | x1.061 | level | 0 of 4 | - | - | x1.011 | x1.008 | x1.002 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 MiB | 0.0371 | 0.0376 | x1.015 | level | 2 of 4 | - | - | x0.989 | x0.974 | x1.050 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 MiB | 0.0713 | 0.0724 | x1.016 | level | 1 of 4 | - | - | x1.022 | x1.024 | x0.998 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 MiB | 0.130 | 0.131 | x1.005 | level | 1 of 4 | - | - | x0.997 | x1.027 | x1.000 |
| blake3-servil-mt / shared-one-cache / Interleaved / 256 | 0.109 | 0.109 | x0.996 | level | 4 of 4 | - | - | x0.997 | x1.000 | x0.993 |
| blake3-servil-mt / shared-one-cache / Collection / git objects | 0.0411 | 0.0410 | x0.999 | level | 2 of 4 | - | - | x0.877 | x0.894 | x0.877 |
| blake3-servil-mt / shared-one-cache / Collection / Nix files | 0.0364 | 0.0369 | x1.013 | level | 1 of 4 | - | - | x1.103 | x1.084 | x1.082 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16 | 6.085 | 6.058 | x0.996 | level | 4 of 4 | - | - | x0.996 | x1.001 | x0.947 |
| blake3-servil-mt / shared-one-cache / LentBatches / 64 | 5.313 | 5.326 | x1.003 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.213 |
| blake3-servil-mt / shared-one-cache / LentBatches / 256 | 5.245 | 5.275 | x1.006 | level | 1 of 4 | - | - | x1.005 | x1.000 | x1.068 |
| blake3-servil-mt / shared-one-cache / LentBatches / 1024 | 5.619 | 5.624 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.955 |
| blake3-servil-mt / shared-one-cache / LentBatches / 4096 | 5.475 | 5.481 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.104 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16384 | 3.158 | 3.047 | x0.965 | level | 3 of 4 | - | - | x1.003 | x1.011 | x0.985 |
| blake3-servil-mt / shared-one-cache / LentBatches / 65536 | 2.655 | 2.469 | x0.930 | level | 4 of 4 | - | - | x0.993 | x1.005 | x0.964 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.0520 | 0.0518 | x0.996 | level | 2 of 4 | - | - | x0.989 | x0.998 | x1.023 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / Nix files | 0.0508 | 0.0503 | x0.990 | level | 2 of 4 | - | - | x0.987 | x0.999 | x1.022 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1024 | 0.0999 | 0.0996 | x0.997 | level | 4 of 4 | - | - | x0.998 | x1.000 | x1.054 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 4096 | 0.0607 | 0.0621 | x1.022 | level | 1 of 4 | - | - | x1.006 | x1.010 | x1.021 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 16384 | 0.0486 | 0.0507 | x1.042 | level | 2 of 4 | - | - | x1.001 | x0.997 | x1.002 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 | 0.120 | 0.120 | x1.001 | level | 2 of 4 | - | - | x1.005 | x1.027 | x1.001 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 262144 | 0.184 | 0.183 | x0.998 | level | 4 of 4 | - | - | x0.997 | x0.998 | x0.997 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 32 B | 0.0962 | 0.0938 | x0.974 | level | 2 of 4 | - | - | x1.005 | x1.002 | x1.038 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 32 B | 0.352 | 0.345 | x0.981 | level | 3 of 4 | - | - | x0.986 | x0.891 | x0.975 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 16 B | 0.544 | 0.545 | x1.003 | level | 1 of 4 | - | - | x1.006 | x0.994 | x0.999 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 48 B | 0.0691 | 0.0664 | x0.960 | level | 3 of 4 | - | - | x1.005 | x1.006 | x0.999 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 48 B | 0.279 | 0.279 | x1.001 | level | 2 of 4 | - | - | x1.008 | x1.005 | x1.000 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.0429 | 0.0432 | x1.009 | level | 2 of 4 | - | - | x1.007 | x1.004 | x1.020 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 2 μs | 0.0923 | 0.0923 | x1.000 | level | 2 of 4 | - | - | x1.002 | x0.996 | x1.028 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 2 of 4 | - | - | x0.967 | x0.994 | x0.960 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 64 B | 0.780 | 0.780 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.911 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 1 KiB | 0.988 | 0.987 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.226 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 4 KiB | 0.290 | 0.290 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.041 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 4.570 | 4.182 | x0.915 | level | 3 of 4 | - | - | x0.993 | x1.002 | x0.989 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 4 KiB | 0.0685 | 0.0705 | x1.030 | level | 2 of 4 | - | - | x0.994 | x0.962 | x1.005 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 1 MiB | 0.0321 | 0.0326 | x1.013 | level | 1 of 4 | - | - | x1.017 | x0.995 | x1.004 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 64 B | 0.286 | 0.281 | x0.985 | level | 3 of 4 | - | - | x0.988 | x0.995 | x0.995 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 4 KiB | 0.0406 | 0.0400 | x0.984 | level | 2 of 4 | - | - | x0.907 | x0.930 | x0.996 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 1 MiB | 0.0145 | 0.0157 | x1.081 | level | 0 of 4 | - | - | x1.078 | x1.077 | x1.157 |

# Nightly drift check: e1966b498bc7 -> 7f392fdebc90

- Host: bench-zen3
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
| blake3-servil-st / solo / ManyMessages / 3 | 175.741 | 177.679 | x1.011 | level | 32 of 64 | - | - | x1.010 | x0.999 | x0.997 |
| blake3-servil-st / solo / IdleOneMessage / 4470 B | 0.919 | 0.934 | x1.016 | level | 26 of 64 | - | - | x1.002 | x1.000 | x1.030 |
| blake3-servil-st / solo / IdleOneMessage / 7935 B | 0.584 | 0.581 | x0.995 | level | 36 of 64 | - | - | x0.997 | x1.000 | x0.979 |
| blake3-servil-st / solo / IdleManyMessages / 1 | 385.673 | 380.637 | x0.987 | level | 34 of 64 | - | - | x0.994 | x1.005 | x0.959 |
| blake3-servil-mt / solo / IdleManyMessages / 8 | 68.492 | 68.972 | x1.007 | level | 32 of 64 | - | - | x0.998 | x1.000 | x0.951 |
| blake3-servil-mt / solo / IdleManyMessages / 32 | 40.909 | 40.378 | x0.987 | level | 31 of 64 | - | - | x0.997 | x1.000 | x0.993 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0732 | 0.0722 | x0.985 | level | 41 of 64 | x0.994 | - | x0.983 | x0.996 | x1.028 |
| blake3-servil-mt / solo / LentMessages / 16 MiB | 0.0782 | 0.0791 | x1.012 | level | 26 of 64 | x1.003 | - | x1.012 | x1.000 | x1.005 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.113 | 0.113 | x0.995 | level | 37 of 64 | - | - | x0.994 | x0.996 | x0.983 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 MiB | 0.139 | 0.139 | x1.004 | level | 32 of 64 | - | - | x0.999 | x1.017 | x1.024 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 4 KiB | 0.118 | 0.120 | x1.019 | level | 26 of 64 | - | - | x1.021 | x0.996 | x0.955 |
| blake3-servil-mt / shared-two-caches / LentMessages / 16 MiB | 0.0866 | 0.0884 | x1.020 | level | 27 of 64 | - | - | x1.020 | x0.997 | x1.047 |

## Stage 1 (initial screen, kept-drift)

compare: old side: bench 3f119a507807 clean; servil e1966b498bc7 clean
compare: new side: bench 3f119a507807 clean; servil 7f392fdebc90 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 7.506 | 7.959 | x1.060 | level | 1 of 4 | - | - | x1.003 | x0.997 | x0.951 |
| blake3-servil-st / solo / OneMessage / 128 B | 4.569 | 4.786 | x1.047 | level | 0 of 4 | - | - | x1.021 | x0.997 | x0.978 |
| blake3-servil-st / solo / OneMessage / 256 B | 2.702 | 2.795 | x1.034 | level | 1 of 4 | - | - | x1.030 | x0.997 | x0.969 |
| blake3-servil-st / solo / OneMessage / 512 B | 1.899 | 1.897 | x0.999 | level | 2 of 4 | - | - | x1.003 | x0.999 | x0.974 |
| blake3-servil-st / solo / OneMessage / 1 KiB | 1.393 | 1.410 | x1.012 | level | 1 of 4 | - | - | x1.022 | x0.999 | x0.965 |
| blake3-servil-st / solo / OneMessage / 1536 B | 1.486 | 1.419 | x0.955 | level | 3 of 4 | - | - | x0.977 | x0.996 | x0.936 |
| blake3-servil-st / solo / OneMessage / 2 KiB | 0.964 | 0.966 | x1.003 | level | 3 of 4 | - | - | x1.010 | x0.999 | x0.971 |
| blake3-servil-st / solo / OneMessage / 2304 B | 1.122 | 1.139 | x1.015 | level | 2 of 4 | - | - | x1.045 | x0.999 | x0.960 |
| blake3-servil-st / solo / OneMessage / 3 KiB | 0.837 | 0.880 | x1.051 | level | 1 of 4 | - | - | x1.060 | x1.000 | x0.982 |
| blake3-servil-st / solo / OneMessage / 3839 B | 0.968 | 1.003 | x1.037 | level | 1 of 4 | - | - | x1.023 | x1.000 | x0.989 |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.617 | 0.638 | x1.035 | level | 1 of 4 | - | - | x1.042 | x0.999 | x0.988 |
| blake3-servil-st / solo / OneMessage / 4470 B | 0.697 | 0.713 | x1.023 | level | 1 of 4 | - | - | x1.029 | x0.999 | x0.977 |
| blake3-servil-st / solo / OneMessage / 7935 B | 0.546 | 0.582 | x1.066 | level | 1 of 4 | - | - | x1.054 | x1.000 | x1.006 |
| blake3-servil-st / solo / OneMessage / 8 KiB | 0.446 | 0.454 | x1.018 | level | 1 of 4 | - | - | x1.024 | x1.000 | x0.987 |
| blake3-servil-st / solo / OneMessage / 16 KiB | 0.379 | 0.384 | x1.015 | level | 1 of 4 | - | - | x1.026 | x1.000 | x0.964 |
| blake3-servil-st / solo / OneMessage / 32 KiB | 0.338 | 0.340 | x1.006 | level | 2 of 4 | - | - | x1.031 | x1.000 | x0.970 |
| blake3-servil-st / solo / OneMessage / 64 KiB | 0.313 | 0.312 | x0.995 | level | 2 of 4 | - | - | x1.011 | x1.000 | x0.962 |
| blake3-servil-st / solo / OneMessage / 128 KiB | 0.300 | 0.303 | x1.010 | level | 2 of 4 | - | - | x1.009 | x1.000 | x0.931 |
| blake3-servil-st / solo / OneMessage / 256 KiB | 0.292 | 0.295 | x1.007 | level | 2 of 4 | - | - | x1.007 | x1.000 | x1.017 |
| blake3-servil-st / solo / OneMessage / 512 KiB | 0.281 | 0.285 | x1.014 | level | 1 of 4 | - | - | x1.016 | x1.000 | x1.005 |
| blake3-servil-st / solo / OneMessage / 1 MiB | 0.281 | 0.285 | x1.015 | level | 1 of 4 | - | - | x1.017 | x1.000 | x1.015 |
| blake3-servil-st / solo / OneMessage / 2 MiB | 0.295 | 0.296 | x1.004 | level | 2 of 4 | - | - | x1.004 | x1.000 | x0.999 |
| blake3-servil-st / solo / OneMessage / 3 MiB | 0.302 | 0.303 | x1.005 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.004 |
| blake3-servil-st / solo / OneMessage / 4 MiB | 0.296 | 0.295 | x0.998 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.994 |
| blake3-servil-st / solo / OneMessage / 8 MiB | 0.312 | 0.308 | x0.988 | level | 3 of 4 | - | - | x0.990 | x1.000 | x0.972 |
| blake3-servil-st / solo / OneMessage / 32 MiB | 0.300 | 0.297 | x0.989 | level | 3 of 4 | - | - | x0.989 | x1.000 | x0.961 |
| blake3-servil-st / solo / OneMessage / 64 MiB | 0.302 | 0.297 | x0.984 | level | 4 of 4 | - | - | x0.984 | x1.000 | x0.967 |
| blake3-servil-st / solo / OneMessage / 128 MiB | 0.298 | 0.294 | x0.987 | level | 4 of 4 | - | - | x0.987 | x1.000 | x0.967 |
| blake3-servil-st / solo / ManyMessages / 1 | 459.845 | 474.190 | x1.031 | level | 3 of 4 | - | - | x1.017 | x1.002 | x1.025 |
| blake3-servil-st / solo / ManyMessages / 2 | 287.026 | 298.363 | x1.039 | level | 1 of 4 | - | - | x1.028 | x0.997 | x1.003 |
| blake3-servil-st / solo / ManyMessages / 3 | 203.415 | 223.952 | x1.101 | level | 0 of 4 | - | - | x1.070 | x1.000 | x0.984 |
| blake3-servil-st / solo / ManyMessages / 4 | 158.208 | 168.038 | x1.062 | level | 2 of 4 | - | - | x1.055 | x0.998 | x1.008 |
| blake3-servil-st / solo / ManyMessages / 6 | 132.971 | 132.853 | x0.999 | level | 2 of 4 | - | - | x1.012 | x0.999 | x1.024 |
| blake3-servil-st / solo / ManyMessages / 8 | 115.100 | 115.019 | x0.999 | level | 2 of 4 | - | - | x1.010 | x0.998 | x1.002 |
| blake3-servil-st / solo / ManyMessages / 12 | 85.650 | 84.947 | x0.992 | level | 2 of 4 | - | - | x1.021 | x1.000 | x1.000 |
| blake3-servil-st / solo / ManyMessages / 16 | 64.554 | 63.594 | x0.985 | level | 2 of 4 | - | - | x1.007 | x0.998 | x1.006 |
| blake3-servil-st / solo / ManyMessages / 24 | 47.415 | 48.914 | x1.032 | level | 1 of 4 | - | - | x1.042 | x0.999 | x1.001 |
| blake3-servil-st / solo / ManyMessages / 32 | 38.692 | 40.031 | x1.035 | level | 2 of 4 | - | - | x1.040 | x0.999 | x1.006 |
| blake3-servil-st / solo / ManyMessages / 48 | 31.674 | 32.401 | x1.023 | level | 0 of 4 | - | - | x1.024 | x0.999 | x1.010 |
| blake3-servil-st / solo / ManyMessages / 64 | 28.369 | 28.519 | x1.005 | level | 2 of 4 | - | - | x1.006 | x0.999 | x1.004 |
| blake3-servil-st / solo / ManyMessages / 128 | 24.122 | 24.857 | x1.030 | level | 1 of 4 | - | - | x0.991 | x1.000 | x1.027 |
| blake3-servil-st / solo / ManyMessages / 256 | 21.107 | 21.197 | x1.004 | level | 2 of 4 | - | - | x1.005 | x1.000 | x0.997 |
| blake3-servil-st / solo / ManyMessages / 512 | 18.959 | 19.197 | x1.013 | level | 1 of 4 | - | - | x1.012 | x1.000 | x0.991 |
| blake3-servil-st / solo / ManyMessages / 1024 | 18.228 | 18.677 | x1.025 | level | 1 of 4 | - | - | x1.022 | x1.000 | x0.994 |
| blake3-servil-st / solo / ManyMessages / 2048 | 18.014 | 18.352 | x1.019 | level | 1 of 4 | - | - | x1.010 | x1.000 | x0.991 |
| blake3-servil-st / solo / ManyMessages / 4096 | 17.652 | 17.908 | x1.015 | level | 0 of 4 | - | - | x1.011 | x1.000 | x1.043 |
| blake3-servil-st / solo / ManyMessages / 8192 | 17.065 | 17.223 | x1.009 | level | 0 of 4 | - | - | x1.011 | x1.000 | x1.044 |
| blake3-servil-st / solo / ManyMessages / 16384 | 17.018 | 17.230 | x1.012 | level | 1 of 4 | - | - | x1.008 | x1.000 | x1.037 |
| blake3-servil-st / solo / ManyMessages / 32768 | 17.515 | 17.414 | x0.994 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.994 |
| blake3-servil-st / solo / ManyMessages / 65536 | 17.508 | 17.474 | x0.998 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.999 |
| blake3-servil-st / solo / ManyMessages / 131072 | 18.070 | 17.942 | x0.993 | level | 2 of 4 | - | - | x0.995 | x1.000 | x0.991 |
| blake3-servil-st / solo / ManyMessages / 262144 | 18.517 | 18.433 | x0.995 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.990 |
| blake3-servil-st / solo / ManyLongMessages / 4 | 1792.258 | 1877.022 | x1.047 | level | 0 of 4 | - | - | x1.017 | x1.000 | x0.989 |
| blake3-servil-st / solo / ManyLongMessages / 16 | 1226.491 | 1237.307 | x1.009 | level | 2 of 4 | - | - | x1.010 | x0.999 | x1.010 |
| blake3-servil-st / solo / ManyLongMessages / 64 | 1165.856 | 1175.565 | x1.008 | level | 2 of 4 | - | - | x1.006 | x0.999 | x0.951 |
| blake3-servil-st / solo / ManyLongMessages / 256 | 1128.153 | 1144.889 | x1.015 | level | 0 of 4 | - | - | x1.010 | x0.999 | x0.985 |
| blake3-servil-st / solo / IdleOneMessage / 64 B | 5.447 | 5.312 | x0.975 | level | 3 of 4 | - | - | x0.995 | x0.999 | x1.460 |
| blake3-servil-st / solo / IdleOneMessage / 128 B | 3.730 | 3.755 | x1.007 | level | 1 of 4 | - | - | x1.004 | x0.999 | x1.656 |
| blake3-servil-st / solo / IdleOneMessage / 256 B | 2.829 | 2.791 | x0.987 | level | 3 of 4 | - | - | x1.000 | x0.999 | x2.117 |
| blake3-servil-st / solo / IdleOneMessage / 512 B | 2.677 | 2.337 | x0.873 | level | 4 of 4 | - | - | x1.001 | x1.000 | x1.998 |
| blake3-servil-st / solo / IdleOneMessage / 1 KiB | 2.196 | 2.151 | x0.980 | level | 3 of 4 | - | - | x1.001 | x0.999 | x1.537 |
| blake3-servil-st / solo / IdleOneMessage / 1536 B | 1.716 | 1.782 | x1.038 | level | 1 of 4 | - | - | x1.001 | x0.997 | x1.467 |
| blake3-servil-st / solo / IdleOneMessage / 2 KiB | 1.240 | 1.214 | x0.979 | level | 3 of 4 | - | - | x1.005 | x0.999 | x1.494 |
| blake3-servil-st / solo / IdleOneMessage / 2304 B | 1.409 | 1.371 | x0.973 | level | 3 of 4 | - | - | x1.003 | x1.000 | x1.625 |
| blake3-servil-st / solo / IdleOneMessage / 3 KiB | 1.018 | 1.053 | x1.035 | level | 2 of 4 | - | - | x1.029 | x1.000 | x1.535 |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 1.079 | 1.079 | x0.999 | level | 2 of 4 | - | - | x1.012 | x1.000 | x1.082 |
| blake3-servil-st / solo / IdleOneMessage / 4 KiB | 0.770 | 0.753 | x0.978 | level | 4 of 4 | - | - | x1.016 | x1.000 | x1.641 |
| blake3-servil-st / solo / IdleOneMessage / 4470 B | 0.902 | 0.950 | x1.053 | level | 0 of 4 | - | - | x1.016 | x1.000 | x1.306 |
| blake3-servil-st / solo / IdleOneMessage / 7935 B | 0.566 | 0.623 | x1.100 | level | 0 of 4 | - | - | x1.039 | x1.000 | x1.046 |
| blake3-servil-st / solo / IdleOneMessage / 8 KiB | 0.537 | 0.546 | x1.016 | level | 2 of 4 | - | - | x1.034 | x1.000 | x1.740 |
| blake3-servil-st / solo / IdleOneMessage / 16 KiB | 0.497 | 0.495 | x0.997 | level | 3 of 4 | - | - | x1.014 | x1.000 | x0.995 |
| blake3-servil-st / solo / IdleOneMessage / 32 KiB | 0.493 | 0.504 | x1.021 | level | 1 of 4 | - | - | x1.033 | x1.000 | x1.302 |
| blake3-servil-st / solo / IdleOneMessage / 64 KiB | 0.480 | 0.468 | x0.975 | level | 3 of 4 | - | - | x1.012 | x1.000 | x1.056 |
| blake3-servil-st / solo / IdleOneMessage / 128 KiB | 0.476 | 0.466 | x0.978 | level | 3 of 4 | - | - | x1.006 | x1.000 | x0.996 |
| blake3-servil-st / solo / IdleOneMessage / 256 KiB | 0.465 | 0.472 | x1.016 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.944 |
| blake3-servil-st / solo / IdleOneMessage / 512 KiB | 0.485 | 0.479 | x0.988 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.036 |
| blake3-servil-st / solo / IdleOneMessage / 1 MiB | 0.492 | 0.499 | x1.013 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.012 |
| blake3-servil-st / solo / IdleOneMessage / 2 MiB | 0.500 | 0.503 | x1.006 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.011 |
| blake3-servil-st / solo / IdleOneMessage / 3 MiB | 0.455 | 0.465 | x1.022 | level | 1 of 4 | - | - | x0.999 | x1.000 | x1.004 |
| blake3-servil-st / solo / IdleOneMessage / 4 MiB | 0.438 | 0.422 | x0.963 | level | 4 of 4 | - | - | x1.000 | x1.000 | x0.998 |
| blake3-servil-st / solo / IdleOneMessage / 8 MiB | 0.334 | 0.329 | x0.985 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.986 |
| blake3-servil-st / solo / IdleOneMessage / 32 MiB | 0.297 | 0.296 | x0.994 | level | 3 of 4 | - | - | x0.988 | x1.000 | x0.970 |
| blake3-servil-st / solo / IdleOneMessage / 64 MiB | 0.300 | 0.296 | x0.985 | level | 3 of 4 | - | - | x0.985 | x1.000 | x0.967 |
| blake3-servil-st / solo / IdleOneMessage / 128 MiB | 0.300 | 0.296 | x0.986 | level | 3 of 4 | - | - | x0.986 | x1.000 | x0.967 |
| blake3-servil-st / solo / IdleManyMessages / 1 | 375.156 | 407.650 | x1.087 | level | 0 of 4 | - | - | x1.033 | x1.001 | x1.330 |
| blake3-servil-st / solo / IdleManyMessages / 2 | 196.249 | 197.813 | x1.008 | level | 2 of 4 | - | - | x1.013 | x0.994 | x1.025 |
| blake3-servil-st / solo / IdleManyMessages / 3 | 176.684 | 174.989 | x0.990 | level | 1 of 4 | - | - | x1.019 | x0.996 | x0.951 |
| blake3-servil-st / solo / IdleManyMessages / 4 | 111.348 | 109.768 | x0.986 | level | 2 of 4 | - | - | x1.016 | x0.996 | x0.720 |
| blake3-servil-st / solo / IdleManyMessages / 6 | 94.635 | 95.956 | x1.014 | level | 2 of 4 | - | - | x1.007 | x0.997 | x0.760 |
| blake3-servil-st / solo / IdleManyMessages / 8 | 67.583 | 69.943 | x1.035 | level | 0 of 4 | - | - | x1.026 | x0.997 | x1.440 |
| blake3-servil-st / solo / IdleManyMessages / 12 | 63.535 | 62.370 | x0.982 | level | 3 of 4 | - | - | x1.017 | x0.997 | x1.198 |
| blake3-servil-st / solo / IdleManyMessages / 16 | 50.707 | 52.538 | x1.036 | level | 0 of 4 | - | - | x1.018 | x0.998 | x1.394 |
| blake3-servil-st / solo / IdleManyMessages / 24 | 44.775 | 45.814 | x1.023 | level | 2 of 4 | - | - | x1.005 | x0.998 | x1.076 |
| blake3-servil-st / solo / IdleManyMessages / 32 | 40.376 | 42.595 | x1.055 | level | 1 of 4 | - | - | x1.020 | x0.999 | x1.537 |
| blake3-servil-st / solo / IdleManyMessages / 48 | 35.896 | 36.187 | x1.008 | level | 2 of 4 | - | - | x1.015 | x1.000 | x1.161 |
| blake3-servil-st / solo / IdleManyMessages / 64 | 36.495 | 34.051 | x0.933 | level | 3 of 4 | - | - | x1.002 | x1.000 | x0.938 |
| blake3-servil-st / solo / IdleManyMessages / 128 | 30.965 | 31.118 | x1.005 | level | 1 of 4 | - | - | x1.006 | x1.000 | x1.069 |
| blake3-servil-st / solo / IdleManyMessages / 256 | 29.340 | 30.454 | x1.038 | level | 1 of 4 | - | - | x1.005 | x1.000 | x0.968 |
| blake3-servil-st / solo / IdleManyMessages / 512 | 29.349 | 28.838 | x0.983 | level | 3 of 4 | - | - | x1.001 | x1.000 | x0.888 |
| blake3-servil-st / solo / IdleManyMessages / 1024 | 29.337 | 29.354 | x1.001 | level | 2 of 4 | - | - | x1.005 | x1.000 | x0.869 |
| blake3-servil-st / solo / IdleManyMessages / 2048 | 29.183 | 28.428 | x0.974 | level | 2 of 4 | - | - | x1.007 | x1.000 | x0.997 |
| blake3-servil-st / solo / IdleManyMessages / 4096 | 30.320 | 28.810 | x0.950 | level | 4 of 4 | - | - | x1.008 | x1.000 | x1.022 |
| blake3-servil-st / solo / IdleManyMessages / 8192 | 29.525 | 29.774 | x1.008 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.009 |
| blake3-servil-st / solo / IdleManyMessages / 16384 | 30.614 | 29.408 | x0.961 | level | 4 of 4 | - | - | x1.000 | x1.000 | x1.022 |
| blake3-servil-st / solo / IdleManyMessages / 32768 | 29.738 | 29.399 | x0.989 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.022 |
| blake3-servil-st / solo / IdleManyMessages / 65536 | 26.062 | 26.571 | x1.020 | level | 0 of 4 | - | - | x0.998 | x1.000 | x0.988 |
| blake3-servil-st / solo / IdleManyMessages / 131072 | 20.866 | 20.994 | x1.006 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.995 |
| blake3-servil-st / solo / IdleManyMessages / 262144 | 18.175 | 18.015 | x0.991 | level | 4 of 4 | - | - | x1.005 | x1.000 | x0.990 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 B | 2.590 | 2.438 | x0.941 | level | 4 of 4 | - | - | x0.997 | x0.999 | x1.044 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 B | 1.715 | 1.702 | x0.993 | level | 2 of 4 | - | - | x0.999 | x0.999 | x1.126 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 B | 1.341 | 1.311 | x0.978 | level | 3 of 4 | - | - | x1.001 | x0.999 | x1.469 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 B | 1.149 | 1.128 | x0.982 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.658 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 KiB | 1.028 | 1.028 | x1.000 | level | 3 of 4 | - | - | x1.002 | x0.999 | x1.027 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1536 B | 0.806 | 0.802 | x0.995 | level | 3 of 4 | - | - | x1.000 | x0.997 | x1.859 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 KiB | 0.572 | 0.573 | x1.002 | level | 1 of 4 | - | - | x1.003 | x0.999 | x0.844 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2304 B | 0.653 | 0.655 | x1.002 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.025 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.481 | 0.483 | x1.004 | level | 2 of 4 | - | - | x1.005 | x1.000 | x1.505 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3839 B | 0.500 | 0.500 | x1.000 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.509 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 KiB | 0.356 | 0.354 | x0.995 | level | 4 of 4 | - | - | x0.999 | x1.000 | x1.671 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4470 B | 0.428 | 0.429 | x1.003 | level | 0 of 4 | - | - | x1.004 | x1.000 | x1.050 |
| blake3-servil-st / solo / BriefIdleOneMessage / 7935 B | 0.270 | 0.270 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.235 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 KiB | 0.252 | 0.249 | x0.990 | level | 2 of 4 | - | - | x1.010 | x1.000 | x1.517 |
| blake3-servil-st / solo / BriefIdleOneMessage / 16 KiB | 0.235 | 0.232 | x0.987 | level | 3 of 4 | - | - | x1.002 | x1.000 | x0.851 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 KiB | 0.223 | 0.231 | x1.035 | level | 1 of 4 | - | - | x1.014 | x1.000 | x1.134 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 KiB | 0.220 | 0.222 | x1.008 | level | 1 of 4 | - | - | x1.005 | x1.000 | x1.039 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 KiB | 0.219 | 0.221 | x1.011 | level | 1 of 4 | - | - | x1.009 | x1.000 | x0.863 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 KiB | 0.224 | 0.226 | x1.008 | level | 1 of 4 | - | - | x1.004 | x1.000 | x0.942 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 KiB | 0.234 | 0.233 | x0.995 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.976 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 MiB | 0.236 | 0.235 | x0.995 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.979 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 MiB | 0.238 | 0.238 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.001 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 MiB | 0.239 | 0.239 | x0.997 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.005 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 MiB | 0.238 | 0.238 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.004 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 MiB | 0.245 | 0.245 | x0.997 | level | 1 of 4 | - | - | x0.996 | x1.000 | x0.978 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 MiB | 0.293 | 0.290 | x0.988 | level | 3 of 4 | - | - | x0.988 | x1.000 | x0.966 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 MiB | 0.295 | 0.290 | x0.985 | level | 3 of 4 | - | - | x0.985 | x1.000 | x0.971 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 MiB | 0.298 | 0.293 | x0.986 | level | 4 of 4 | - | - | x0.986 | x1.000 | x0.968 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1 | 170.346 | 179.912 | x1.056 | level | 1 of 4 | - | - | x1.011 | x1.002 | x1.174 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2 | 88.728 | 97.576 | x1.100 | level | 2 of 4 | - | - | x1.002 | x0.995 | x0.612 |
| blake3-servil-st / solo / BriefIdleManyMessages / 3 | 77.319 | 77.245 | x0.999 | level | 1 of 4 | - | - | x1.004 | x0.996 | x0.331 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4 | 48.266 | 48.473 | x1.004 | level | 1 of 4 | - | - | x1.008 | x0.996 | x0.272 |
| blake3-servil-st / solo / BriefIdleManyMessages / 6 | 42.739 | 42.688 | x0.999 | level | 2 of 4 | - | - | x1.005 | x0.996 | x0.620 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8 | 30.429 | 30.166 | x0.991 | level | 3 of 4 | - | - | x0.998 | x0.996 | x0.709 |
| blake3-servil-st / solo / BriefIdleManyMessages / 12 | 27.230 | 26.994 | x0.991 | level | 4 of 4 | - | - | x1.002 | x0.998 | x0.728 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16 | 23.327 | 23.287 | x0.998 | level | 3 of 4 | - | - | x1.003 | x0.998 | x0.699 |
| blake3-servil-st / solo / BriefIdleManyMessages / 24 | 20.607 | 19.977 | x0.969 | level | 3 of 4 | - | - | x1.000 | x0.999 | x0.613 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32 | 18.692 | 18.683 | x1.000 | level | 3 of 4 | - | - | x0.999 | x0.999 | x0.413 |
| blake3-servil-st / solo / BriefIdleManyMessages / 48 | 17.192 | 16.728 | x0.973 | level | 3 of 4 | - | - | x1.001 | x1.000 | x0.724 |
| blake3-servil-st / solo / BriefIdleManyMessages / 64 | 15.868 | 16.193 | x1.020 | level | 0 of 4 | - | - | x1.003 | x1.000 | x0.689 |
| blake3-servil-st / solo / BriefIdleManyMessages / 128 | 14.531 | 14.540 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.726 |
| blake3-servil-st / solo / BriefIdleManyMessages / 256 | 14.079 | 13.936 | x0.990 | level | 4 of 4 | - | - | x1.001 | x1.000 | x0.880 |
| blake3-servil-st / solo / BriefIdleManyMessages / 512 | 13.726 | 13.601 | x0.991 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.934 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1024 | 13.547 | 13.541 | x1.000 | level | 1 of 4 | - | - | x0.998 | x1.000 | x0.776 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2048 | 13.589 | 13.688 | x1.007 | level | 1 of 4 | - | - | x1.008 | x1.000 | x0.942 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4096 | 14.110 | 14.211 | x1.007 | level | 1 of 4 | - | - | x1.005 | x1.000 | x1.058 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8192 | 14.378 | 14.478 | x1.007 | level | 1 of 4 | - | - | x1.003 | x1.000 | x0.975 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16384 | 14.646 | 14.624 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.974 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32768 | 14.901 | 15.035 | x1.009 | level | 2 of 4 | - | - | x1.010 | x1.000 | x0.986 |
| blake3-servil-st / solo / BriefIdleManyMessages / 65536 | 15.056 | 15.053 | x1.000 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.995 |
| blake3-servil-st / solo / BriefIdleManyMessages / 131072 | 15.059 | 15.054 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.006 |
| blake3-servil-st / solo / BriefIdleManyMessages / 262144 | 15.815 | 15.824 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.994 |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.889 | 0.884 | x0.995 | level | 3 of 4 | x0.995 | - | x0.995 | x1.000 | x0.551 |
| blake3-servil-st / solo / ContinuousMessages / 128 B | 0.907 | 0.913 | x1.006 | level | 3 of 4 | x1.007 | - | x1.007 | x1.000 | x0.324 |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 0.915 | 0.914 | x0.999 | level | 3 of 4 | x0.999 | - | x1.001 | x1.000 | x0.346 |
| blake3-servil-st / solo / ContinuousMessages / 512 B | 0.932 | 0.929 | x0.997 | level | 2 of 4 | x0.997 | - | x0.996 | x1.000 | x0.565 |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 0.924 | 0.924 | x1.000 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.603 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.316 | 0.316 | x0.999 | level | 2 of 4 | x0.999 | - | x1.000 | x1.000 | x0.606 |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.214 | 0.215 | x1.003 | level | 1 of 4 | x1.003 | - | x1.002 | x1.000 | x0.795 |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.216 | 0.216 | x0.998 | level | 2 of 4 | x0.998 | - | x0.999 | x1.000 | x0.923 |
| blake3-servil-st / solo / ContinuousMessages / 256 KiB | 0.218 | 0.218 | x1.000 | level | 1 of 4 | x1.001 | - | x0.999 | x1.000 | x0.894 |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.219 | 0.219 | x0.999 | level | 2 of 4 | x0.999 | - | x1.000 | x1.000 | x0.784 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.219 | 0.219 | x1.001 | level | 1 of 4 | x1.001 | - | x0.998 | x1.000 | x0.996 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.221 | 0.221 | x0.999 | level | 1 of 4 | x0.999 | - | x0.999 | x1.000 | x1.013 |
| blake3-servil-st / solo / ContinuousMessages / 64 MiB | 0.255 | 0.256 | x1.002 | level | 3 of 4 | x1.002 | - | x1.002 | x1.000 | x1.115 |
| blake3-servil-st / solo / ContinuousBatches / 16 | 16.344 | 16.330 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x0.999 | x1.006 |
| blake3-servil-st / solo / ContinuousBatches / 64 | 13.863 | 13.729 | x0.990 | level | 2 of 4 | x0.990 | - | x0.990 | x1.000 | x0.639 |
| blake3-servil-st / solo / ContinuousBatches / 256 | 13.681 | 13.690 | x1.001 | level | 2 of 4 | x1.001 | - | x1.002 | x1.000 | x0.859 |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 13.864 | 13.852 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x1.055 |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 14.497 | 14.561 | x1.004 | level | 1 of 4 | x1.005 | - | x1.004 | x1.000 | x0.940 |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 14.983 | 14.950 | x0.998 | level | 1 of 4 | x0.998 | - | x1.000 | x1.000 | x0.925 |
| blake3-servil-st / solo / ContinuousBatches / 65536 | 14.917 | 15.125 | x1.014 | level | 0 of 4 | x1.014 | - | x1.014 | x1.000 | x0.939 |
| blake3-servil-st / solo / LentMessages / 64 B | 0.889 | 0.884 | x0.995 | level | 3 of 4 | x0.995 | - | x0.995 | x1.000 | x0.551 |
| blake3-servil-st / solo / LentMessages / 128 B | 0.907 | 0.913 | x1.006 | level | 3 of 4 | x1.007 | - | x1.007 | x1.000 | x0.324 |
| blake3-servil-st / solo / LentMessages / 256 B | 0.915 | 0.914 | x0.999 | level | 3 of 4 | x0.999 | - | x1.001 | x1.000 | x0.346 |
| blake3-servil-st / solo / LentMessages / 512 B | 0.932 | 0.929 | x0.997 | level | 2 of 4 | x0.997 | - | x0.996 | x1.000 | x0.565 |
| blake3-servil-st / solo / LentMessages / 1 KiB | 0.924 | 0.924 | x1.000 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.603 |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.316 | 0.316 | x0.999 | level | 2 of 4 | x0.999 | - | x1.000 | x1.000 | x0.606 |
| blake3-servil-st / solo / LentMessages / 16 KiB | 0.214 | 0.215 | x1.003 | level | 1 of 4 | x1.003 | - | x1.002 | x1.000 | x0.795 |
| blake3-servil-st / solo / LentMessages / 64 KiB | 0.216 | 0.216 | x0.998 | level | 2 of 4 | x0.998 | - | x0.999 | x1.000 | x0.923 |
| blake3-servil-st / solo / LentMessages / 256 KiB | 0.219 | 0.220 | x1.003 | level | 1 of 4 | x1.003 | - | x1.002 | x1.000 | x0.872 |
| blake3-servil-st / solo / LentMessages / 1 MiB | 0.230 | 0.231 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.000 | x0.900 |
| blake3-servil-st / solo / LentMessages / 4 MiB | 0.230 | 0.233 | x1.015 | level | 0 of 4 | x1.015 | - | x1.014 | x1.000 | x0.918 |
| blake3-servil-st / solo / LentMessages / 16 MiB | 0.256 | 0.256 | x0.999 | level | 3 of 4 | x0.999 | - | x0.998 | x1.000 | x0.953 |
| blake3-servil-st / solo / LentMessages / 64 MiB | 0.298 | 0.297 | x0.996 | level | 2 of 4 | x0.996 | - | x0.996 | x1.000 | x0.967 |
| blake3-servil-st / solo / Interleaved / 256 | 0.261 | 0.260 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x0.999 | x0.997 |
| blake3-servil-st / solo / Collection / git objects | 0.247 | 0.247 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x0.951 |
| blake3-servil-st / solo / Collection / Nix files | 0.233 | 0.231 | x0.994 | level | 2 of 4 | x0.994 | - | x0.994 | x0.999 | x1.000 |
| blake3-servil-st / solo / LentBatches / 16 | 16.344 | 16.330 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x0.999 | x1.006 |
| blake3-servil-st / solo / LentBatches / 64 | 13.863 | 13.729 | x0.990 | level | 2 of 4 | x0.990 | - | x0.990 | x1.000 | x0.639 |
| blake3-servil-st / solo / LentBatches / 256 | 13.681 | 13.690 | x1.001 | level | 2 of 4 | x1.001 | - | x1.002 | x1.000 | x0.859 |
| blake3-servil-st / solo / LentBatches / 1024 | 13.864 | 13.852 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x1.055 |
| blake3-servil-st / solo / LentBatches / 4096 | 14.497 | 14.561 | x1.004 | level | 1 of 4 | x1.005 | - | x1.004 | x1.000 | x0.940 |
| blake3-servil-st / solo / LentBatches / 16384 | 14.983 | 14.950 | x0.998 | level | 1 of 4 | x0.998 | - | x1.000 | x1.000 | x0.925 |
| blake3-servil-st / solo / LentBatches / 65536 | 14.917 | 15.125 | x1.014 | level | 0 of 4 | x1.014 | - | x1.014 | x1.000 | x0.939 |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.271 | 0.272 | x1.004 | level | 2 of 4 | x1.004 | - | x1.004 | x1.000 | x0.930 |
| blake3-servil-st / solo / ContinuousCollection / Nix files | 0.276 | 0.277 | x1.003 | level | 2 of 4 | x1.003 | - | x1.002 | x1.000 | x0.936 |
| blake3-servil-st / solo / MerkleTree / 1024 | 0.262 | 0.261 | x0.998 | level | 2 of 4 | x0.998 | - | x0.997 | x1.000 | x1.009 |
| blake3-servil-st / solo / MerkleTree / 4096 | 0.270 | 0.271 | x1.002 | level | 2 of 4 | x1.003 | - | x1.003 | x1.000 | x0.893 |
| blake3-servil-st / solo / MerkleTree / 16384 | 0.272 | 0.273 | x1.004 | level | 2 of 4 | x1.004 | - | x1.004 | x1.000 | x1.054 |
| blake3-servil-st / solo / MerkleTree / 65536 | 0.304 | 0.303 | x0.997 | level | 3 of 4 | x0.998 | - | x0.997 | x1.000 | x0.954 |
| blake3-servil-st / solo / MerkleTree / 262144 | 0.549 | 0.546 | x0.995 | level | 2 of 4 | x0.995 | - | x0.995 | x1.000 | x0.984 |
| blake3-servil-st / solo / MerkleTree / 65536 x 32 B | 0.838 | 0.838 | x1.000 | level | 2 of 4 | x1.000 | - | x0.999 | x1.000 | x0.962 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 32 B | 1.100 | 1.097 | x0.997 | level | 2 of 4 | x0.997 | - | x0.998 | x1.000 | x1.017 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 16 B | 1.674 | 1.676 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | x0.984 |
| blake3-servil-st / solo / MerkleTree / 65536 x 48 B | 0.573 | 0.572 | x0.998 | level | 1 of 4 | x0.998 | - | x0.998 | x1.000 | x0.983 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 48 B | 0.838 | 0.838 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x0.996 |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.479 | 0.489 | x1.022 | level | 0 of 4 | - | - | x1.019 | x1.012 | x1.023 |
| blake3-servil-st / solo / InterleavedTurn / 1024 x 1 KiB | 0.523 | 0.532 | x1.018 | level | 1 of 4 | - | - | x1.017 | x1.000 | x0.987 |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.711 | 0.723 | x1.016 | level | 1 of 4 | - | - | x1.013 | x0.998 | x0.978 |
| blake3-servil-st / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.827 | 0.841 | x1.016 | level | 2 of 4 | - | - | x1.010 | x1.000 | x0.993 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.397 | 0.393 | x0.991 | level | 3 of 4 | - | - | x0.998 | x0.986 | x0.984 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.430 | 0.442 | x1.029 | level | 2 of 4 | - | - | x1.028 | x1.000 | x0.990 |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.229 | 0.228 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x1.032 |
| blake3-servil-st / solo / ReceivingMessage / 2 μs | 0.231 | 0.231 | x1.000 | level | 2 of 4 | x1.000 | - | x0.999 | x1.000 | x1.047 |
| blake3-servil-st / solo / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 2 of 4 | x1.008 | - | x1.015 | x1.000 | x1.069 |
| blake3-servil-st / solo / IncrementalMessage / 64 B | 7.627 | 8.260 | x1.083 | level | 1 of 4 | - | - | x1.063 | x1.002 | x1.033 |
| blake3-servil-st / solo / IncrementalMessage / 1 KiB | 1.539 | 1.574 | x1.022 | level | 2 of 4 | - | - | x1.033 | x1.000 | x1.040 |
| blake3-servil-st / solo / IncrementalMessage / 4 KiB | 0.728 | 0.750 | x1.030 | level | 1 of 4 | - | - | x1.035 | x1.000 | x1.010 |
| blake3-servil-st / solo / LentIncrementalMessage / 64 B | 1.168 | 1.162 | x0.995 | level | 3 of 4 | x0.995 | - | x0.996 | x1.000 | x1.218 |
| blake3-servil-st / solo / LentIncrementalMessage / 1 KiB | 0.951 | 0.953 | x1.002 | level | 1 of 4 | x1.002 | - | x1.000 | x1.000 | x1.282 |
| blake3-servil-st / solo / LentIncrementalMessage / 4 KiB | 0.329 | 0.329 | x1.002 | level | 0 of 4 | x1.002 | - | x1.002 | x1.000 | x1.067 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 0.869 | 0.869 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.081 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 4 KiB | 0.316 | 0.316 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | x0.830 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 1 MiB | 0.219 | 0.219 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x0.997 |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 0.841 | 0.839 | x0.998 | level | 3 of 4 | x0.998 | - | x1.000 | x1.000 | x0.704 |
| blake3-servil-st / solo / ContinuousLentMessages / 4 KiB | 0.306 | 0.306 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.942 |
| blake3-servil-st / solo / ContinuousLentMessages / 1 MiB | 0.204 | 0.204 | x1.003 | level | 1 of 4 | x1.002 | - | x1.001 | x1.000 | x1.016 |
| blake3-servil-mt / solo / OneMessage / 64 B | 8.425 | 8.297 | x0.985 | level | 2 of 4 | - | - | x0.985 | x0.998 | x0.997 |
| blake3-servil-mt / solo / OneMessage / 128 B | 4.948 | 5.032 | x1.017 | level | 2 of 4 | - | - | x1.010 | x0.999 | x1.001 |
| blake3-servil-mt / solo / OneMessage / 256 B | 3.050 | 2.971 | x0.974 | level | 2 of 4 | - | - | x1.005 | x0.998 | x0.998 |
| blake3-servil-mt / solo / OneMessage / 512 B | 2.038 | 2.011 | x0.987 | level | 2 of 4 | - | - | x1.010 | x0.998 | x0.993 |
| blake3-servil-mt / solo / OneMessage / 1 KiB | 1.442 | 1.451 | x1.006 | level | 2 of 4 | - | - | x1.016 | x0.999 | x0.983 |
| blake3-servil-mt / solo / OneMessage / 1536 B | 1.461 | 1.495 | x1.023 | level | 2 of 4 | - | - | x1.011 | x0.996 | x0.962 |
| blake3-servil-mt / solo / OneMessage / 2 KiB | 1.017 | 1.002 | x0.985 | level | 2 of 4 | - | - | x1.022 | x0.999 | x0.979 |
| blake3-servil-mt / solo / OneMessage / 2304 B | 1.137 | 1.145 | x1.007 | level | 1 of 4 | - | - | x1.017 | x0.999 | x0.981 |
| blake3-servil-mt / solo / OneMessage / 3 KiB | 0.867 | 0.899 | x1.037 | level | 2 of 4 | - | - | x1.044 | x1.000 | x0.996 |
| blake3-servil-mt / solo / OneMessage / 3839 B | 0.978 | 1.000 | x1.022 | level | 1 of 4 | - | - | x1.029 | x0.999 | x0.979 |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 0.636 | 0.641 | x1.009 | level | 1 of 4 | - | - | x1.013 | x0.999 | x1.008 |
| blake3-servil-mt / solo / OneMessage / 4470 B | 0.716 | 0.748 | x1.044 | level | 2 of 4 | - | - | x1.030 | x0.999 | x0.979 |
| blake3-servil-mt / solo / OneMessage / 7935 B | 0.547 | 0.568 | x1.039 | level | 1 of 4 | - | - | x1.045 | x1.000 | x0.994 |
| blake3-servil-mt / solo / OneMessage / 8 KiB | 0.453 | 0.472 | x1.041 | level | 1 of 4 | - | - | x1.044 | x0.999 | x1.001 |
| blake3-servil-mt / solo / OneMessage / 16 KiB | 0.381 | 0.405 | x1.063 | level | 1 of 4 | - | - | x1.043 | x1.000 | x0.993 |
| blake3-servil-mt / solo / OneMessage / 32 KiB | 0.331 | 0.340 | x1.026 | level | 1 of 4 | - | - | x1.028 | x1.000 | x0.964 |
| blake3-servil-mt / solo / OneMessage / 64 KiB | 0.317 | 0.317 | x1.003 | level | 2 of 4 | - | - | x1.016 | x1.000 | x0.977 |
| blake3-servil-mt / solo / OneMessage / 128 KiB | 0.299 | 0.305 | x1.020 | level | 1 of 4 | - | - | x1.012 | x1.000 | x0.961 |
| blake3-servil-mt / solo / OneMessage / 256 KiB | 0.292 | 0.293 | x1.003 | level | 2 of 4 | - | - | x1.006 | x1.000 | x0.999 |
| blake3-servil-mt / solo / OneMessage / 512 KiB | 0.179 | 0.181 | x1.012 | level | 2 of 4 | - | - | x1.027 | x1.054 | x1.014 |
| blake3-servil-mt / solo / OneMessage / 1 MiB | 0.143 | 0.134 | x0.938 | level | 3 of 4 | - | - | x0.943 | x1.032 | x0.993 |
| blake3-servil-mt / solo / OneMessage / 2 MiB | 0.158 | 0.159 | x1.003 | level | 2 of 4 | - | - | x1.010 | x1.006 | x1.004 |
| blake3-servil-mt / solo / OneMessage / 3 MiB | 0.154 | 0.154 | x0.999 | level | 1 of 4 | - | - | x1.005 | x1.034 | x0.999 |
| blake3-servil-mt / solo / OneMessage / 4 MiB | 0.122 | 0.117 | x0.956 | level | 3 of 4 | - | - | x0.959 | x1.022 | x0.970 |
| blake3-servil-mt / solo / OneMessage / 8 MiB | 0.150 | 0.151 | x1.008 | level | 0 of 4 | - | - | x1.009 | x1.007 | x1.000 |
| blake3-servil-mt / solo / OneMessage / 32 MiB | 0.0806 | 0.0805 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.008 | x1.003 |
| blake3-servil-mt / solo / OneMessage / 64 MiB | 0.0859 | 0.0855 | x0.995 | level | 3 of 4 | - | - | x0.995 | x1.003 | x0.988 |
| blake3-servil-mt / solo / OneMessage / 128 MiB | 0.0762 | 0.0759 | x0.996 | level | 3 of 4 | - | - | x0.999 | x1.007 | x0.985 |
| blake3-servil-mt / solo / ManyMessages / 1 | 488.792 | 488.957 | x1.000 | level | 2 of 4 | - | - | x0.983 | x1.002 | x1.027 |
| blake3-servil-mt / solo / ManyMessages / 2 | 304.831 | 315.874 | x1.036 | level | 1 of 4 | - | - | x1.014 | x0.994 | x1.001 |
| blake3-servil-mt / solo / ManyMessages / 3 | 224.247 | 224.107 | x0.999 | level | 1 of 4 | - | - | x1.007 | x0.997 | x0.983 |
| blake3-servil-mt / solo / ManyMessages / 4 | 165.633 | 177.449 | x1.071 | level | 2 of 4 | - | - | x1.057 | x0.997 | x0.990 |
| blake3-servil-mt / solo / ManyMessages / 6 | 137.252 | 139.042 | x1.013 | level | 3 of 4 | - | - | x1.018 | x0.998 | x1.022 |
| blake3-servil-mt / solo / ManyMessages / 8 | 120.168 | 120.260 | x1.001 | level | 2 of 4 | - | - | x1.003 | x0.999 | x1.003 |
| blake3-servil-mt / solo / ManyMessages / 12 | 89.064 | 90.259 | x1.013 | level | 1 of 4 | - | - | x1.019 | x0.999 | x0.993 |
| blake3-servil-mt / solo / ManyMessages / 16 | 65.734 | 66.644 | x1.014 | level | 1 of 4 | - | - | x1.002 | x0.998 | x0.993 |
| blake3-servil-mt / solo / ManyMessages / 24 | 49.833 | 49.937 | x1.002 | level | 2 of 4 | - | - | x0.988 | x0.999 | x0.984 |
| blake3-servil-mt / solo / ManyMessages / 32 | 39.592 | 40.341 | x1.019 | level | 1 of 4 | - | - | x1.026 | x0.999 | x1.000 |
| blake3-servil-mt / solo / ManyMessages / 48 | 32.744 | 32.700 | x0.999 | level | 2 of 4 | - | - | x1.010 | x0.999 | x0.997 |
| blake3-servil-mt / solo / ManyMessages / 64 | 29.018 | 29.119 | x1.004 | level | 2 of 4 | - | - | x1.000 | x0.999 | x1.006 |
| blake3-servil-mt / solo / ManyMessages / 128 | 24.441 | 24.995 | x1.023 | level | 3 of 4 | - | - | x0.975 | x1.000 | x1.035 |
| blake3-servil-mt / solo / ManyMessages / 256 | 20.857 | 21.309 | x1.022 | level | 1 of 4 | - | - | x1.023 | x1.000 | x1.003 |
| blake3-servil-mt / solo / ManyMessages / 512 | 19.331 | 19.523 | x1.010 | level | 2 of 4 | - | - | x1.022 | x1.000 | x0.959 |
| blake3-servil-mt / solo / ManyMessages / 1024 | 18.219 | 18.690 | x1.026 | level | 1 of 4 | - | - | x1.021 | x1.000 | x1.024 |
| blake3-servil-mt / solo / ManyMessages / 2048 | 18.181 | 18.355 | x1.010 | level | 1 of 4 | - | - | x1.013 | x1.000 | x1.019 |
| blake3-servil-mt / solo / ManyMessages / 4096 | 17.743 | 17.972 | x1.013 | level | 0 of 4 | - | - | x1.011 | x1.000 | x1.035 |
| blake3-servil-mt / solo / ManyMessages / 8192 | 9.885 | 9.617 | x0.973 | level | 3 of 4 | - | - | x0.995 | x0.998 | x1.000 |
| blake3-servil-mt / solo / ManyMessages / 16384 | 9.312 | 8.806 | x0.946 | level | 2 of 4 | - | - | x0.954 | x1.064 | x0.977 |
| blake3-servil-mt / solo / ManyMessages / 32768 | 9.552 | 8.616 | x0.902 | level | 3 of 4 | - | - | x0.900 | x1.123 | x0.916 |
| blake3-servil-mt / solo / ManyMessages / 65536 | 7.606 | 7.363 | x0.968 | level | 3 of 4 | - | - | x0.973 | x1.004 | x0.988 |
| blake3-servil-mt / solo / ManyMessages / 131072 | 9.798 | 9.276 | x0.947 | level | 1 of 4 | - | - | x0.946 | x1.146 | x0.885 |
| blake3-servil-mt / solo / ManyMessages / 262144 | 10.117 | 10.111 | x0.999 | level | 1 of 4 | - | - | x1.000 | x1.023 | x0.994 |
| blake3-servil-mt / solo / ManyLongMessages / 4 | 1824.174 | 1820.229 | x0.998 | level | 2 of 4 | - | - | x1.010 | x1.000 | x0.969 |
| blake3-servil-mt / solo / ManyLongMessages / 16 | 1223.482 | 1249.308 | x1.021 | level | 1 of 4 | - | - | x1.010 | x0.999 | x0.972 |
| blake3-servil-mt / solo / ManyLongMessages / 64 | 1169.954 | 1169.033 | x0.999 | level | 3 of 4 | - | - | x1.004 | x0.999 | x0.972 |
| blake3-servil-mt / solo / ManyLongMessages / 256 | 647.050 | 613.417 | x0.948 | level | 2 of 4 | - | - | x0.955 | x1.050 | x0.990 |
| blake3-servil-mt / solo / IdleOneMessage / 64 B | 5.553 | 5.690 | x1.025 | level | 3 of 4 | - | - | x0.994 | x0.999 | x1.316 |
| blake3-servil-mt / solo / IdleOneMessage / 128 B | 3.843 | 3.815 | x0.993 | level | 2 of 4 | - | - | x1.003 | x0.999 | x1.658 |
| blake3-servil-mt / solo / IdleOneMessage / 256 B | 2.915 | 2.951 | x1.012 | level | 3 of 4 | - | - | x0.999 | x0.999 | x1.844 |
| blake3-servil-mt / solo / IdleOneMessage / 512 B | 2.446 | 2.433 | x0.995 | level | 2 of 4 | - | - | x1.004 | x1.000 | x1.699 |
| blake3-servil-mt / solo / IdleOneMessage / 1 KiB | 2.177 | 2.194 | x1.008 | level | 2 of 4 | - | - | x1.009 | x0.999 | x3.384 |
| blake3-servil-mt / solo / IdleOneMessage / 1536 B | 1.810 | 1.702 | x0.940 | level | 2 of 4 | - | - | x0.992 | x0.997 | x1.333 |
| blake3-servil-mt / solo / IdleOneMessage / 2 KiB | 1.242 | 1.294 | x1.041 | level | 0 of 4 | - | - | x1.004 | x1.000 | x1.527 |
| blake3-servil-mt / solo / IdleOneMessage / 2304 B | 1.424 | 1.643 | x1.154 | level | 2 of 4 | - | - | x1.008 | x1.000 | x1.543 |
| blake3-servil-mt / solo / IdleOneMessage / 3 KiB | 1.028 | 1.061 | x1.032 | level | 1 of 4 | - | - | x1.037 | x1.000 | x1.487 |
| blake3-servil-mt / solo / IdleOneMessage / 3839 B | 1.102 | 1.090 | x0.989 | level | 2 of 4 | - | - | x1.009 | x1.000 | x1.030 |
| blake3-servil-mt / solo / IdleOneMessage / 4 KiB | 0.755 | 0.802 | x1.062 | level | 1 of 4 | - | - | x1.043 | x1.000 | x2.114 |
| blake3-servil-mt / solo / IdleOneMessage / 4470 B | 0.887 | 0.950 | x1.070 | level | 1 of 4 | - | - | x1.022 | x1.000 | x1.117 |
| blake3-servil-mt / solo / IdleOneMessage / 7935 B | 0.607 | 0.625 | x1.030 | level | 0 of 4 | - | - | x1.040 | x1.000 | x1.327 |
| blake3-servil-mt / solo / IdleOneMessage / 8 KiB | 0.533 | 0.530 | x0.993 | level | 2 of 4 | - | - | x1.028 | x1.000 | x1.534 |
| blake3-servil-mt / solo / IdleOneMessage / 16 KiB | 0.488 | 0.517 | x1.061 | level | 0 of 4 | - | - | x1.030 | x1.000 | x1.306 |
| blake3-servil-mt / solo / IdleOneMessage / 32 KiB | 0.461 | 0.479 | x1.038 | level | 1 of 4 | - | - | x1.033 | x1.000 | x1.165 |
| blake3-servil-mt / solo / IdleOneMessage / 64 KiB | 0.470 | 0.482 | x1.026 | level | 1 of 4 | - | - | x1.011 | x1.000 | x1.088 |
| blake3-servil-mt / solo / IdleOneMessage / 128 KiB | 0.465 | 0.471 | x1.013 | level | 1 of 4 | - | - | x1.009 | x1.000 | x1.012 |
| blake3-servil-mt / solo / IdleOneMessage / 256 KiB | 0.469 | 0.465 | x0.992 | level | 2 of 4 | - | - | x1.006 | x1.000 | x0.950 |
| blake3-servil-mt / solo / IdleOneMessage / 512 KiB | 0.240 | 0.216 | x0.900 | level | 3 of 4 | - | - | x0.880 | x0.984 | x0.984 |
| blake3-servil-mt / solo / IdleOneMessage / 1 MiB | 0.198 | 0.203 | x1.027 | level | 2 of 4 | - | - | x0.974 | x1.007 | x0.974 |
| blake3-servil-mt / solo / IdleOneMessage / 2 MiB | 0.208 | 0.209 | x1.006 | level | 2 of 4 | - | - | x0.990 | x1.001 | x1.005 |
| blake3-servil-mt / solo / IdleOneMessage / 3 MiB | 0.199 | 0.196 | x0.983 | level | 4 of 4 | - | - | x1.008 | x1.017 | x0.995 |
| blake3-servil-mt / solo / IdleOneMessage / 4 MiB | 0.202 | 0.199 | x0.983 | level | 3 of 4 | - | - | x0.983 | x0.997 | x0.988 |
| blake3-servil-mt / solo / IdleOneMessage / 8 MiB | 0.168 | 0.172 | x1.019 | level | 1 of 4 | - | - | x0.966 | x1.017 | x0.964 |
| blake3-servil-mt / solo / IdleOneMessage / 32 MiB | 0.0733 | 0.0746 | x1.018 | level | 1 of 4 | - | - | x1.012 | x1.025 | x0.997 |
| blake3-servil-mt / solo / IdleOneMessage / 64 MiB | 0.0741 | 0.0746 | x1.007 | level | 2 of 4 | - | - | x0.996 | x1.006 | x0.987 |
| blake3-servil-mt / solo / IdleOneMessage / 128 MiB | 0.0736 | 0.0736 | x1.000 | level | 2 of 4 | - | - | x0.995 | x0.996 | x0.977 |
| blake3-servil-mt / solo / IdleManyMessages / 1 | 393.067 | 402.850 | x1.025 | level | 1 of 4 | - | - | x1.035 | x1.001 | x1.429 |
| blake3-servil-mt / solo / IdleManyMessages / 2 | 212.274 | 211.486 | x0.996 | level | 2 of 4 | - | - | x1.015 | x0.994 | x0.872 |
| blake3-servil-mt / solo / IdleManyMessages / 3 | 170.894 | 176.442 | x1.032 | level | 0 of 4 | - | - | x1.016 | x0.996 | x0.867 |
| blake3-servil-mt / solo / IdleManyMessages / 4 | 108.931 | 112.906 | x1.036 | level | 0 of 4 | - | - | x1.024 | x0.996 | x0.889 |
| blake3-servil-mt / solo / IdleManyMessages / 6 | 94.637 | 93.239 | x0.985 | level | 3 of 4 | - | - | x1.003 | x0.997 | x0.735 |
| blake3-servil-mt / solo / IdleManyMessages / 8 | 67.303 | 72.671 | x1.080 | level | 0 of 4 | - | - | x1.032 | x0.997 | x1.289 |
| blake3-servil-mt / solo / IdleManyMessages / 12 | 61.330 | 60.636 | x0.989 | level | 3 of 4 | - | - | x1.018 | x0.998 | x0.904 |
| blake3-servil-mt / solo / IdleManyMessages / 16 | 52.063 | 51.706 | x0.993 | level | 3 of 4 | - | - | x1.009 | x0.997 | x0.908 |
| blake3-servil-mt / solo / IdleManyMessages / 24 | 45.018 | 44.233 | x0.983 | level | 3 of 4 | - | - | x0.984 | x0.998 | x0.879 |
| blake3-servil-mt / solo / IdleManyMessages / 32 | 39.497 | 42.549 | x1.077 | level | 0 of 4 | - | - | x1.000 | x0.999 | x0.754 |
| blake3-servil-mt / solo / IdleManyMessages / 48 | 37.151 | 36.517 | x0.983 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.065 |
| blake3-servil-mt / solo / IdleManyMessages / 64 | 34.564 | 34.330 | x0.993 | level | 3 of 4 | - | - | x1.005 | x1.000 | x1.040 |
| blake3-servil-mt / solo / IdleManyMessages / 128 | 32.779 | 31.083 | x0.948 | level | 3 of 4 | - | - | x1.002 | x1.000 | x1.005 |
| blake3-servil-mt / solo / IdleManyMessages / 256 | 29.887 | 30.103 | x1.007 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.786 |
| blake3-servil-mt / solo / IdleManyMessages / 512 | 29.414 | 28.840 | x0.980 | level | 3 of 4 | - | - | x1.005 | x1.000 | x0.893 |
| blake3-servil-mt / solo / IdleManyMessages / 1024 | 29.388 | 28.774 | x0.979 | level | 3 of 4 | - | - | x1.001 | x1.000 | x0.921 |
| blake3-servil-mt / solo / IdleManyMessages / 2048 | 29.192 | 29.179 | x1.000 | level | 2 of 4 | - | - | x1.005 | x1.000 | x1.019 |
| blake3-servil-mt / solo / IdleManyMessages / 4096 | 29.784 | 29.814 | x1.001 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.020 |
| blake3-servil-mt / solo / IdleManyMessages / 8192 | 12.863 | 12.838 | x0.998 | level | 3 of 4 | - | - | x0.972 | x0.992 | x0.995 |
| blake3-servil-mt / solo / IdleManyMessages / 16384 | 12.342 | 11.155 | x0.904 | level | 3 of 4 | - | - | x0.894 | x1.085 | x0.940 |
| blake3-servil-mt / solo / IdleManyMessages / 32768 | 11.979 | 11.754 | x0.981 | level | 3 of 4 | - | - | x0.986 | x1.021 | x0.964 |
| blake3-servil-mt / solo / IdleManyMessages / 65536 | 9.821 | 9.573 | x0.975 | level | 3 of 4 | - | - | x0.964 | x0.991 | x0.987 |
| blake3-servil-mt / solo / IdleManyMessages / 131072 | 11.143 | 10.405 | x0.934 | level | 2 of 4 | - | - | x0.917 | x1.089 | x0.890 |
| blake3-servil-mt / solo / IdleManyMessages / 262144 | 9.344 | 9.406 | x1.007 | level | 1 of 4 | - | - | x1.005 | x0.997 | x1.005 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 B | 2.586 | 2.453 | x0.948 | level | 4 of 4 | - | - | x0.992 | x0.999 | x1.285 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 B | 1.721 | 1.708 | x0.992 | level | 3 of 4 | - | - | x1.000 | x0.999 | x1.416 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 B | 1.323 | 1.344 | x1.016 | level | 2 of 4 | - | - | x1.000 | x0.999 | x1.464 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 B | 1.132 | 1.191 | x1.052 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.598 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 KiB | 1.031 | 1.029 | x0.998 | level | 3 of 4 | - | - | x1.002 | x0.999 | x1.092 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1536 B | 0.806 | 0.804 | x0.998 | level | 3 of 4 | - | - | x1.002 | x0.997 | x1.361 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 KiB | 0.574 | 0.573 | x0.999 | level | 2 of 4 | - | - | x1.002 | x0.999 | x0.933 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2304 B | 0.654 | 0.658 | x1.005 | level | 0 of 4 | - | - | x1.004 | x1.000 | x0.786 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 KiB | 0.481 | 0.479 | x0.996 | level | 1 of 4 | - | - | x1.005 | x1.000 | x1.568 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3839 B | 0.506 | 0.520 | x1.028 | level | 1 of 4 | - | - | x0.999 | x1.000 | x1.233 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 KiB | 0.357 | 0.360 | x1.010 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.073 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4470 B | 0.427 | 0.428 | x1.003 | level | 0 of 4 | - | - | x1.003 | x1.000 | x1.137 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 7935 B | 0.270 | 0.269 | x0.996 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.044 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 KiB | 0.251 | 0.246 | x0.979 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.597 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 16 KiB | 0.231 | 0.231 | x1.002 | level | 2 of 4 | - | - | x1.004 | x1.000 | x1.015 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 KiB | 0.222 | 0.224 | x1.012 | level | 1 of 4 | - | - | x1.012 | x1.000 | x1.045 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 KiB | 0.220 | 0.223 | x1.012 | level | 1 of 4 | - | - | x1.007 | x1.000 | x1.014 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 KiB | 0.220 | 0.220 | x1.003 | level | 2 of 4 | - | - | x1.010 | x1.000 | x0.925 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 KiB | 0.224 | 0.226 | x1.006 | level | 1 of 4 | - | - | x1.003 | x1.000 | x0.928 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 KiB | 0.128 | 0.114 | x0.889 | level | 3 of 4 | - | - | x0.886 | x0.987 | x0.966 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 MiB | 0.113 | 0.101 | x0.894 | level | 3 of 4 | - | - | x0.891 | x1.014 | x0.951 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 MiB | 0.116 | 0.114 | x0.985 | level | 4 of 4 | - | - | x0.990 | x1.004 | x0.998 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 MiB | 0.113 | 0.113 | x0.996 | level | 2 of 4 | - | - | x0.999 | x0.995 | x1.019 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 MiB | 0.115 | 0.107 | x0.928 | level | 3 of 4 | - | - | x0.927 | x1.046 | x0.941 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 MiB | 0.115 | 0.117 | x1.016 | level | 1 of 4 | - | - | x1.017 | x1.009 | x0.995 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 MiB | 0.0609 | 0.0609 | x1.000 | level | 3 of 4 | - | - | x1.001 | x0.986 | x1.001 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 MiB | 0.0680 | 0.0684 | x1.006 | level | 2 of 4 | - | - | x1.006 | x1.013 | x0.988 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 MiB | 0.0682 | 0.0686 | x1.006 | level | 0 of 4 | - | - | x1.006 | x1.004 | x0.980 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1 | 173.333 | 172.001 | x0.992 | level | 3 of 4 | - | - | x1.003 | x1.001 | x1.409 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2 | 89.955 | 89.085 | x0.990 | level | 3 of 4 | - | - | x1.001 | x0.995 | x0.530 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 3 | 78.065 | 77.426 | x0.992 | level | 3 of 4 | - | - | x1.003 | x0.996 | x0.270 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4 | 49.100 | 49.052 | x0.999 | level | 1 of 4 | - | - | x1.005 | x0.996 | x0.696 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 6 | 43.301 | 43.099 | x0.995 | level | 2 of 4 | - | - | x1.001 | x0.996 | x0.389 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8 | 30.775 | 30.869 | x1.003 | level | 3 of 4 | - | - | x0.997 | x0.997 | x0.625 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 12 | 27.352 | 27.116 | x0.991 | level | 4 of 4 | - | - | x1.000 | x0.998 | x0.858 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16 | 23.524 | 23.463 | x0.997 | level | 2 of 4 | - | - | x1.003 | x0.998 | x0.745 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 24 | 20.188 | 20.144 | x0.998 | level | 3 of 4 | - | - | x1.003 | x0.999 | x0.581 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32 | 18.530 | 18.752 | x1.012 | level | 2 of 4 | - | - | x1.004 | x0.999 | x0.513 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 48 | 16.765 | 16.763 | x1.000 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.668 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 64 | 15.931 | 16.260 | x1.021 | level | 2 of 4 | - | - | x1.004 | x1.000 | x0.868 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 128 | 14.509 | 14.520 | x1.001 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.830 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 256 | 13.915 | 13.958 | x1.003 | level | 2 of 4 | - | - | x1.004 | x1.000 | x0.815 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 512 | 13.620 | 13.693 | x1.005 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.864 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1024 | 13.523 | 13.559 | x1.003 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.790 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2048 | 13.579 | 13.829 | x1.018 | level | 1 of 4 | - | - | x1.009 | x1.000 | x0.901 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4096 | 14.246 | 14.223 | x0.998 | level | 3 of 4 | - | - | x1.004 | x1.000 | x1.041 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8192 | 6.956 | 6.731 | x0.968 | level | 3 of 4 | - | - | x0.970 | x0.976 | x0.985 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16384 | 6.579 | 6.008 | x0.913 | level | 2 of 4 | - | - | x0.919 | x1.027 | x0.979 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32768 | 6.350 | 6.421 | x1.011 | level | 1 of 4 | - | - | x1.013 | x0.996 | x1.016 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 65536 | 5.101 | 4.968 | x0.974 | level | 3 of 4 | - | - | x0.972 | x0.984 | x0.996 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 131072 | 7.717 | 6.973 | x0.904 | level | 2 of 4 | - | - | x0.904 | x1.082 | x0.902 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 262144 | 7.494 | 7.739 | x1.033 | level | 1 of 4 | - | - | x1.035 | x0.991 | x1.021 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.695 | 0.655 | x0.943 | level | 4 of 4 | x0.746 | - | x0.947 | x0.974 | x0.793 |
| blake3-servil-mt / solo / ContinuousMessages / 128 B | 0.345 | 0.336 | x0.975 | level | 3 of 4 | x0.837 | - | x0.979 | x0.975 | x0.896 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.182 | 0.182 | x1.002 | level | 2 of 4 | x0.946 | - | x1.004 | x0.975 | x0.919 |
| blake3-servil-mt / solo / ContinuousMessages / 512 B | 0.110 | 0.108 | x0.984 | level | 3 of 4 | x0.891 | - | x0.988 | x0.979 | x0.848 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.0799 | 0.0731 | x0.915 | level | 3 of 4 | x0.912 | - | x0.918 | x0.986 | x1.119 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0726 | 0.0723 | x0.995 | level | 2 of 4 | x0.932 | - | x0.999 | x0.994 | x0.926 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0544 | 0.0518 | x0.953 | level | 4 of 4 | x0.953 | - | x0.954 | x1.007 | x1.029 |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.0499 | 0.0476 | x0.954 | level | 2 of 4 | x1.017 | - | x0.944 | x1.012 | x1.159 |
| blake3-servil-mt / solo / ContinuousMessages / 256 KiB | 0.0478 | 0.0482 | x1.007 | level | 2 of 4 | x0.998 | - | x0.999 | x1.010 | x1.031 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0462 | 0.0447 | x0.967 | level | 3 of 4 | x0.962 | - | x0.967 | x1.008 | x1.115 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.0470 | 0.0470 | x1.002 | level | 3 of 4 | x1.031 | - | x0.999 | x1.008 | x0.959 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0453 | 0.0443 | x0.977 | level | 3 of 4 | x0.965 | - | x0.975 | x1.009 | x1.055 |
| blake3-servil-mt / solo / ContinuousMessages / 64 MiB | 0.0608 | 0.0604 | x0.993 | level | 3 of 4 | x0.992 | - | x0.993 | x1.009 | x0.986 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 6.187 | 6.266 | x1.013 | level | 1 of 4 | x1.022 | - | x1.012 | x0.977 | x0.989 |
| blake3-servil-mt / solo / ContinuousBatches / 64 | 3.772 | 3.837 | x1.017 | level | 2 of 4 | x0.996 | - | x1.016 | x0.989 | x0.984 |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 3.425 | 3.659 | x1.068 | level | 1 of 4 | x0.976 | - | x1.067 | x0.986 | x0.882 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 3.626 | 3.397 | x0.937 | level | 3 of 4 | x0.933 | - | x0.935 | x0.982 | x1.196 |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 4.029 | 3.896 | x0.967 | level | 4 of 4 | x1.034 | - | x0.960 | x1.000 | x1.138 |
| blake3-servil-mt / solo / ContinuousBatches / 16384 | 3.924 | 4.011 | x1.022 | level | 0 of 4 | x1.020 | - | x1.018 | x1.008 | x1.027 |
| blake3-servil-mt / solo / ContinuousBatches / 65536 | 3.244 | 3.445 | x1.062 | level | 1 of 4 | x1.078 | - | x1.062 | x0.972 | x1.052 |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.955 | 0.949 | x0.994 | level | 3 of 4 | x0.994 | - | x0.993 | x1.000 | x0.934 |
| blake3-servil-mt / solo / LentMessages / 128 B | 0.954 | 0.959 | x1.005 | level | 1 of 4 | x1.005 | - | x1.005 | x1.000 | x1.023 |
| blake3-servil-mt / solo / LentMessages / 256 B | 0.935 | 0.935 | x1.000 | level | 2 of 4 | x1.000 | - | x1.001 | x1.000 | x0.829 |
| blake3-servil-mt / solo / LentMessages / 512 B | 0.931 | 0.931 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.015 |
| blake3-servil-mt / solo / LentMessages / 1 KiB | 0.928 | 0.929 | x1.002 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x1.991 |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.317 | 0.317 | x1.000 | level | 2 of 4 | x1.000 | - | x1.001 | x1.000 | x1.319 |
| blake3-servil-mt / solo / LentMessages / 16 KiB | 0.215 | 0.215 | x1.004 | level | 2 of 4 | x1.004 | - | x1.003 | x1.000 | x1.397 |
| blake3-servil-mt / solo / LentMessages / 64 KiB | 0.216 | 0.216 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.331 |
| blake3-servil-mt / solo / LentMessages / 256 KiB | 0.219 | 0.220 | x1.002 | level | 1 of 4 | x1.003 | - | x1.003 | x1.000 | x0.828 |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.0788 | 0.0785 | x0.996 | level | 2 of 4 | x1.044 | - | x1.001 | x1.011 | x0.990 |
| blake3-servil-mt / solo / LentMessages / 4 MiB | 0.0665 | 0.0659 | x0.990 | level | 3 of 4 | x0.997 | - | x0.989 | x0.989 | x0.983 |
| blake3-servil-mt / solo / LentMessages / 16 MiB | 0.0890 | 0.0918 | x1.032 | level | 1 of 4 | x1.070 | - | x1.032 | x0.977 | x1.051 |
| blake3-servil-mt / solo / LentMessages / 64 MiB | 0.0816 | 0.0812 | x0.995 | level | 3 of 4 | x0.985 | - | x0.995 | x1.002 | x1.003 |
| blake3-servil-mt / solo / Interleaved / 256 | 0.261 | 0.264 | x1.010 | level | 1 of 4 | x1.010 | - | x1.009 | x1.000 | x0.979 |
| blake3-servil-mt / solo / Collection / git objects | 0.0139 | 0.0140 | x1.007 | level | 2 of 4 | x1.023 | - | x1.008 | x0.996 | x0.995 |
| blake3-servil-mt / solo / Collection / Nix files | 0.0211 | 0.0211 | x1.000 | level | 3 of 4 | x1.002 | - | x1.006 | x1.022 | x1.021 |
| blake3-servil-mt / solo / LentBatches / 16 | 16.210 | 16.485 | x1.017 | level | 2 of 4 | x1.017 | - | x1.017 | x0.999 | x0.947 |
| blake3-servil-mt / solo / LentBatches / 64 | 13.819 | 13.775 | x0.997 | level | 2 of 4 | x0.997 | - | x0.996 | x1.000 | x0.902 |
| blake3-servil-mt / solo / LentBatches / 256 | 13.661 | 13.701 | x1.003 | level | 2 of 4 | x1.003 | - | x1.003 | x1.000 | x0.884 |
| blake3-servil-mt / solo / LentBatches / 1024 | 13.862 | 13.855 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x1.053 |
| blake3-servil-mt / solo / LentBatches / 4096 | 14.492 | 14.535 | x1.003 | level | 1 of 4 | x1.003 | - | x1.002 | x1.000 | x0.960 |
| blake3-servil-mt / solo / LentBatches / 16384 | 5.375 | 5.389 | x1.003 | level | 2 of 4 | x1.056 | - | x1.006 | x1.009 | x0.985 |
| blake3-servil-mt / solo / LentBatches / 65536 | 4.722 | 4.757 | x1.007 | level | 1 of 4 | x1.003 | - | x0.994 | x1.007 | x1.000 |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.0640 | 0.0651 | x1.018 | level | 1 of 4 | x0.966 | - | x1.016 | x1.003 | x0.997 |
| blake3-servil-mt / solo / ContinuousCollection / Nix files | 0.0656 | 0.0667 | x1.018 | level | 1 of 4 | x0.968 | - | x1.018 | x1.003 | x1.022 |
| blake3-servil-mt / solo / MerkleTree / 1024 | 0.262 | 0.260 | x0.994 | level | 3 of 4 | x0.994 | - | x0.993 | x1.000 | x1.016 |
| blake3-servil-mt / solo / MerkleTree / 4096 | 0.129 | 0.134 | x1.034 | level | 1 of 4 | x1.086 | - | x1.025 | x0.992 | x0.967 |
| blake3-servil-mt / solo / MerkleTree / 16384 | 0.138 | 0.137 | x0.997 | level | 2 of 4 | x0.978 | - | x0.999 | x1.005 | x1.132 |
| blake3-servil-mt / solo / MerkleTree / 65536 | 0.152 | 0.152 | x1.000 | level | 2 of 4 | x0.997 | - | x1.000 | x1.006 | x0.957 |
| blake3-servil-mt / solo / MerkleTree / 262144 | 0.348 | 0.343 | x0.986 | level | 3 of 4 | x0.936 | - | x0.986 | x1.005 | x0.978 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 32 B | 0.288 | 0.278 | x0.965 | level | 1 of 4 | x0.911 | - | x0.967 | x1.054 | x0.947 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 32 B | 0.436 | 0.437 | x1.002 | level | 3 of 4 | x1.052 | - | x1.002 | x0.887 | x0.985 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 16 B | 0.351 | 0.347 | x0.988 | level | 4 of 4 | x0.985 | - | x0.986 | x0.981 | x1.001 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 48 B | 0.179 | 0.219 | x1.224 | level | 1 of 4 | x1.693 | - | x1.216 | x0.901 | x1.261 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 48 B | 0.397 | 0.395 | x0.996 | level | 4 of 4 | x0.969 | - | x0.996 | x1.019 | x1.001 |
| blake3-servil-mt / solo / InterleavedTurn / 256 | 0.778 | 0.779 | x1.001 | level | 1 of 4 | - | - | x0.986 | x0.912 | x1.018 |
| blake3-servil-mt / solo / InterleavedTurn / 1024 x 1 KiB | 0.328 | 0.327 | x0.997 | level | 3 of 4 | - | - | x0.998 | x0.977 | x0.983 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 256 | 0.744 | 0.750 | x1.008 | level | 1 of 4 | - | - | x1.001 | x0.916 | x0.987 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.475 | 0.464 | x0.977 | level | 3 of 4 | - | - | x0.987 | x0.973 | x0.985 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 256 | 0.545 | 0.535 | x0.981 | level | 4 of 4 | - | - | x0.973 | x0.866 | x0.964 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.289 | 0.300 | x1.038 | level | 2 of 4 | - | - | x1.036 | x0.991 | x0.981 |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.0504 | 0.0450 | x0.892 | level | 3 of 4 | x1.029 | - | x0.892 | x1.004 | x1.189 |
| blake3-servil-mt / solo / ReceivingMessage / 2 μs | 0.0939 | 0.0930 | x0.990 | level | 3 of 4 | x0.994 | - | x0.999 | x1.000 | x1.027 |
| blake3-servil-mt / solo / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 4 of 4 | x1.076 | - | x0.997 | x0.954 | x0.982 |
| blake3-servil-mt / solo / IncrementalMessage / 64 B | 8.061 | 8.920 | x1.107 | level | 2 of 4 | - | - | x1.069 | x1.002 | x1.058 |
| blake3-servil-mt / solo / IncrementalMessage / 1 KiB | 1.539 | 1.629 | x1.059 | level | 1 of 4 | - | - | x1.037 | x1.000 | x1.025 |
| blake3-servil-mt / solo / IncrementalMessage / 4 KiB | 0.729 | 0.753 | x1.033 | level | 1 of 4 | - | - | x1.019 | x1.000 | x1.017 |
| blake3-servil-mt / solo / LentIncrementalMessage / 64 B | 1.275 | 1.273 | x0.999 | level | 3 of 4 | x0.999 | - | x0.998 | x1.000 | x1.279 |
| blake3-servil-mt / solo / LentIncrementalMessage / 1 KiB | 0.951 | 0.952 | x1.001 | level | 2 of 4 | x1.001 | - | x1.000 | x1.000 | x0.809 |
| blake3-servil-mt / solo / LentIncrementalMessage / 4 KiB | 0.329 | 0.329 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.837 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 5.355 | 5.561 | x1.038 | level | 1 of 4 | x1.083 | - | x1.046 | x0.992 | x1.199 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 4 KiB | 0.136 | 0.123 | x0.904 | level | 3 of 4 | x0.948 | - | x0.904 | x1.002 | x1.090 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 1 MiB | 0.0469 | 0.0504 | x1.074 | level | 1 of 4 | x0.907 | - | x1.065 | x1.008 | x0.827 |
| blake3-servil-mt / solo / ContinuousLentMessages / 64 B | 0.608 | 0.579 | x0.952 | level | 3 of 4 | x0.643 | - | x0.956 | x0.971 | x0.924 |
| blake3-servil-mt / solo / ContinuousLentMessages / 4 KiB | 0.0378 | 0.0372 | x0.983 | level | 2 of 4 | x1.005 | - | x0.985 | x0.972 | x0.970 |
| blake3-servil-mt / solo / ContinuousLentMessages / 1 MiB | 0.00874 | 0.00878 | x1.004 | level | 1 of 4 | x1.012 | - | x0.999 | x1.009 | x1.122 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.666 | 0.636 | x0.954 | level | 3 of 4 | - | - | x0.954 | x0.974 | x0.829 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 128 B | 0.351 | 0.327 | x0.932 | level | 4 of 4 | - | - | x0.931 | x0.975 | x0.893 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.192 | 0.182 | x0.945 | level | 4 of 4 | - | - | x0.950 | x0.975 | x0.871 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 512 B | 0.125 | 0.127 | x1.018 | level | 2 of 4 | - | - | x1.017 | x0.979 | x1.004 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.0977 | 0.0951 | x0.973 | level | 2 of 4 | - | - | x0.978 | x0.985 | x1.015 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.113 | 0.114 | x1.011 | level | 2 of 4 | - | - | x0.993 | x0.999 | x0.957 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.0883 | 0.0924 | x1.047 | level | 0 of 4 | - | - | x1.033 | x1.010 | x1.045 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.0752 | 0.0778 | x1.035 | level | 1 of 4 | - | - | x1.024 | x1.013 | x0.984 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 KiB | 0.0734 | 0.0744 | x1.013 | level | 1 of 4 | - | - | x1.008 | x1.010 | x0.985 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0746 | 0.0746 | x1.001 | level | 2 of 4 | - | - | x1.002 | x1.004 | x0.998 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.0779 | 0.0775 | x0.995 | level | 2 of 4 | - | - | x0.994 | x1.017 | x0.988 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.0755 | 0.0769 | x1.018 | level | 1 of 4 | - | - | x1.016 | x1.009 | x1.005 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 MiB | 0.0763 | 0.0775 | x1.015 | level | 0 of 4 | - | - | x1.019 | x1.007 | x0.981 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 7.506 | 7.406 | x0.987 | level | 2 of 4 | - | - | x0.980 | x0.978 | x0.995 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 64 | 5.584 | 5.492 | x0.984 | level | 3 of 4 | - | - | x0.985 | x0.989 | x0.952 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 256 | 5.221 | 5.406 | x1.035 | level | 0 of 4 | - | - | x1.010 | x1.008 | x1.017 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 4.989 | 4.976 | x0.997 | level | 2 of 4 | - | - | x1.007 | x0.995 | x0.946 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 4096 | 5.880 | 5.670 | x0.964 | level | 3 of 4 | - | - | x0.964 | x1.040 | x1.038 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16384 | 4.862 | 5.259 | x1.082 | level | 1 of 4 | - | - | x1.089 | x0.936 | x1.262 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 65536 | 6.204 | 6.621 | x1.067 | level | 1 of 4 | - | - | x1.067 | x1.024 | x1.143 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.953 | 0.948 | x0.996 | level | 4 of 4 | - | - | x1.000 | x1.000 | x0.911 |
| blake3-servil-mt / shared-one-cache / LentMessages / 128 B | 0.952 | 0.953 | x1.001 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.048 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 B | 0.932 | 0.933 | x1.001 | level | 0 of 4 | - | - | x1.001 | x1.000 | x0.785 |
| blake3-servil-mt / shared-one-cache / LentMessages / 512 B | 0.931 | 0.929 | x0.997 | level | 4 of 4 | - | - | x0.998 | x1.000 | x0.652 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 KiB | 0.926 | 0.926 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.139 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.317 | 0.316 | x0.997 | level | 4 of 4 | - | - | x0.996 | x1.000 | x1.152 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 KiB | 0.215 | 0.215 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.747 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 KiB | 0.217 | 0.215 | x0.992 | level | 2 of 4 | - | - | x0.993 | x1.000 | x0.624 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 KiB | 0.220 | 0.219 | x0.998 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.708 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 MiB | 0.100 | 0.0981 | x0.978 | level | 2 of 4 | - | - | x0.976 | x0.970 | x0.871 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 MiB | 0.0719 | 0.0732 | x1.018 | level | 1 of 4 | - | - | x1.027 | x1.012 | x1.003 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 MiB | 0.133 | 0.141 | x1.062 | level | 0 of 4 | - | - | x1.065 | x1.000 | x1.169 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 MiB | 0.112 | 0.112 | x1.006 | level | 1 of 4 | - | - | x1.004 | x1.001 | x1.011 |
| blake3-servil-mt / shared-one-cache / Interleaved / 256 | 0.269 | 0.264 | x0.980 | level | 3 of 4 | - | - | x0.980 | x0.993 | x1.000 |
| blake3-servil-mt / shared-one-cache / Collection / git objects | 0.0291 | 0.0310 | x1.064 | level | 1 of 4 | - | - | x0.907 | x0.922 | x0.920 |
| blake3-servil-mt / shared-one-cache / Collection / Nix files | 0.0318 | 0.0320 | x1.007 | level | 1 of 4 | - | - | x0.969 | x0.952 | x0.950 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16 | 16.196 | 16.439 | x1.015 | level | 1 of 4 | - | - | x1.014 | x0.999 | x1.054 |
| blake3-servil-mt / shared-one-cache / LentBatches / 64 | 13.646 | 13.811 | x1.012 | level | 1 of 4 | - | - | x1.012 | x1.000 | x0.845 |
| blake3-servil-mt / shared-one-cache / LentBatches / 256 | 13.667 | 13.611 | x0.996 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.793 |
| blake3-servil-mt / shared-one-cache / LentBatches / 1024 | 13.803 | 13.793 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.817 |
| blake3-servil-mt / shared-one-cache / LentBatches / 4096 | 14.433 | 14.366 | x0.995 | level | 2 of 4 | - | - | x0.995 | x1.000 | x0.975 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16384 | 6.052 | 6.205 | x1.025 | level | 0 of 4 | - | - | x1.020 | x1.007 | x1.017 |
| blake3-servil-mt / shared-one-cache / LentBatches / 65536 | 6.308 | 7.369 | x1.168 | level | 2 of 4 | - | - | x1.150 | x1.023 | x1.378 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.0927 | 0.0943 | x1.018 | level | 1 of 4 | - | - | x1.013 | x1.003 | x0.965 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / Nix files | 0.0921 | 0.0926 | x1.005 | level | 1 of 4 | - | - | x1.008 | x1.000 | x0.943 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1024 | 0.262 | 0.262 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.955 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 4096 | 0.146 | 0.151 | x1.031 | level | 1 of 4 | - | - | x1.033 | x1.018 | x1.044 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 16384 | 0.155 | 0.164 | x1.059 | level | 1 of 4 | - | - | x1.058 | x0.974 | x0.888 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 | 0.237 | 0.240 | x1.013 | level | 1 of 4 | - | - | x1.012 | x0.977 | x1.044 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 262144 | 0.355 | 0.351 | x0.989 | level | 3 of 4 | - | - | x0.988 | x0.979 | x1.010 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 32 B | 0.365 | 0.367 | x1.007 | level | 2 of 4 | - | - | x1.005 | x0.973 | x0.979 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 32 B | 0.514 | 0.515 | x1.003 | level | 2 of 4 | - | - | x0.997 | x0.995 | x1.012 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 16 B | 0.582 | 0.580 | x0.997 | level | 3 of 4 | - | - | x1.005 | x1.079 | x0.895 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 48 B | 0.296 | 0.306 | x1.032 | level | 0 of 4 | - | - | x1.030 | x0.960 | x0.991 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 48 B | 0.434 | 0.431 | x0.992 | level | 2 of 4 | - | - | x0.992 | x1.058 | x1.004 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.0773 | 0.0803 | x1.039 | level | 1 of 4 | - | - | x1.030 | x1.008 | x1.021 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 2 μs | 0.0953 | 0.0961 | x1.008 | level | 1 of 4 | - | - | x0.999 | x1.008 | x0.984 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 4 of 4 | - | - | x1.007 | x0.994 | x0.981 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 64 B | 1.273 | 1.271 | x0.998 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.561 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 1 KiB | 0.950 | 0.949 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.107 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 4 KiB | 0.328 | 0.329 | x1.002 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.075 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 16.373 | 15.230 | x0.930 | level | 3 of 4 | - | - | x1.078 | x0.993 | x0.977 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 4 KiB | 0.247 | 0.238 | x0.967 | level | 3 of 4 | - | - | x1.090 | x1.007 | x1.008 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 1 MiB | 0.0768 | 0.0773 | x1.007 | level | 1 of 4 | - | - | x1.013 | x1.006 | x0.987 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 64 B | 0.595 | 0.562 | x0.945 | level | 4 of 4 | - | - | x0.930 | x0.971 | x1.016 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 4 KiB | 0.0821 | 0.0771 | x0.939 | level | 3 of 4 | - | - | x0.943 | x0.988 | x0.880 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 1 MiB | 0.0160 | 0.0161 | x1.002 | level | 2 of 4 | - | - | x0.950 | x0.937 | x0.974 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 B | 1.205 | 0.928 | x0.770 | level | 4 of 4 | - | - | x0.766 | x0.974 | x0.845 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 128 B | 0.651 | 0.571 | x0.878 | level | 2 of 4 | - | - | x0.868 | x0.975 | x0.918 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 256 B | 0.384 | 0.374 | x0.975 | level | 2 of 4 | - | - | x0.962 | x0.975 | x1.028 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 512 B | 0.206 | 0.176 | x0.855 | level | 3 of 4 | - | - | x0.855 | x0.979 | x0.967 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 KiB | 0.144 | 0.124 | x0.861 | level | 3 of 4 | - | - | x0.859 | x0.987 | x0.945 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 4 KiB | 0.104 | 0.112 | x1.080 | level | 0 of 4 | - | - | x1.080 | x0.993 | x0.933 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 16 KiB | 0.0831 | 0.0837 | x1.007 | level | 1 of 4 | - | - | x1.006 | x1.007 | x1.007 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 KiB | 0.0879 | 0.0887 | x1.008 | level | 2 of 4 | - | - | x1.000 | x1.012 | x1.002 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 256 KiB | 0.0872 | 0.0922 | x1.056 | level | 1 of 4 | - | - | x1.041 | x1.011 | x0.941 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 MiB | 0.0912 | 0.0947 | x1.039 | level | 1 of 4 | - | - | x1.026 | x1.003 | x0.937 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 4 MiB | 0.0920 | 0.0953 | x1.036 | level | 1 of 4 | - | - | x1.014 | x1.019 | x0.953 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 16 MiB | 0.0924 | 0.0954 | x1.032 | level | 1 of 4 | - | - | x1.017 | x1.015 | x0.943 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 MiB | 0.111 | 0.111 | x0.998 | level | 3 of 4 | - | - | x0.990 | x1.010 | x0.946 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 16 | 13.872 | 14.247 | x1.027 | level | 1 of 4 | - | - | x1.019 | x0.975 | x0.979 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 64 | 9.234 | 9.008 | x0.976 | level | 3 of 4 | - | - | x0.963 | x0.990 | x0.951 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 256 | 7.995 | 7.985 | x0.999 | level | 2 of 4 | - | - | x0.986 | x0.994 | x0.889 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 1024 | 7.520 | 7.427 | x0.988 | level | 3 of 4 | - | - | x0.973 | x0.983 | x0.880 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 4096 | 8.557 | 8.276 | x0.967 | level | 3 of 4 | - | - | x0.968 | x1.001 | x1.142 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 16384 | 7.884 | 7.755 | x0.984 | level | 2 of 4 | - | - | x0.982 | x0.977 | x1.028 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 65536 | 6.290 | 6.086 | x0.968 | level | 2 of 4 | - | - | x0.967 | x0.986 | x0.955 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 B | 0.950 | 0.951 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.680 |
| blake3-servil-mt / shared-two-caches / LentMessages / 128 B | 0.954 | 0.954 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.152 |
| blake3-servil-mt / shared-two-caches / LentMessages / 256 B | 0.933 | 0.935 | x1.002 | level | 0 of 4 | - | - | x1.002 | x1.000 | x0.911 |
| blake3-servil-mt / shared-two-caches / LentMessages / 512 B | 0.931 | 0.931 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.169 |
| blake3-servil-mt / shared-two-caches / LentMessages / 1 KiB | 0.928 | 0.927 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.809 |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 KiB | 0.318 | 0.316 | x0.996 | level | 4 of 4 | - | - | x0.996 | x1.000 | x0.921 |
| blake3-servil-mt / shared-two-caches / LentMessages / 16 KiB | 0.215 | 0.215 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.992 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 KiB | 0.217 | 0.216 | x0.993 | level | 2 of 4 | - | - | x0.993 | x1.000 | x0.804 |
| blake3-servil-mt / shared-two-caches / LentMessages / 256 KiB | 0.219 | 0.218 | x0.996 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.698 |
| blake3-servil-mt / shared-two-caches / LentMessages / 1 MiB | 0.108 | 0.109 | x1.009 | level | 1 of 4 | - | - | x1.011 | x1.007 | x1.033 |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 MiB | 0.0844 | 0.0825 | x0.977 | level | 2 of 4 | - | - | x0.977 | x1.005 | x0.979 |
| blake3-servil-mt / shared-two-caches / LentMessages / 16 MiB | 0.0966 | 0.0927 | x0.959 | level | 2 of 4 | - | - | x0.954 | x1.031 | x0.869 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 MiB | 0.0843 | 0.0856 | x1.016 | level | 2 of 4 | - | - | x1.017 | x1.020 | x0.998 |
| blake3-servil-mt / shared-two-caches / Interleaved / 256 | 0.257 | 0.256 | x0.998 | level | 2 of 4 | - | - | x0.998 | x0.998 | x0.982 |
| blake3-servil-mt / shared-two-caches / Collection / git objects | 0.0295 | 0.0291 | x0.989 | level | 1 of 4 | - | - | x1.010 | x1.009 | x1.005 |
| blake3-servil-mt / shared-two-caches / Collection / Nix files | 0.0318 | 0.0315 | x0.990 | level | 3 of 4 | - | - | x1.017 | x1.042 | x1.032 |
| blake3-servil-mt / shared-two-caches / LentBatches / 16 | 16.226 | 16.468 | x1.015 | level | 1 of 4 | - | - | x1.015 | x0.999 | x1.063 |
| blake3-servil-mt / shared-two-caches / LentBatches / 64 | 13.653 | 13.814 | x1.012 | level | 1 of 4 | - | - | x1.012 | x1.000 | x0.835 |
| blake3-servil-mt / shared-two-caches / LentBatches / 256 | 13.680 | 13.619 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.825 |
| blake3-servil-mt / shared-two-caches / LentBatches / 1024 | 13.811 | 14.226 | x1.030 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.828 |
| blake3-servil-mt / shared-two-caches / LentBatches / 4096 | 14.476 | 14.382 | x0.994 | level | 2 of 4 | - | - | x0.994 | x1.000 | x1.011 |
| blake3-servil-mt / shared-two-caches / LentBatches / 16384 | 7.783 | 7.757 | x0.997 | level | 2 of 4 | - | - | x0.992 | x0.995 | x0.992 |
| blake3-servil-mt / shared-two-caches / LentBatches / 65536 | 6.324 | 5.963 | x0.943 | level | 2 of 4 | - | - | x0.943 | x1.007 | x0.996 |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / git objects | 0.101 | 0.0995 | x0.987 | level | 2 of 4 | - | - | x0.985 | x1.005 | x1.040 |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / Nix files | 0.107 | 0.105 | x0.984 | level | 2 of 4 | - | - | x0.981 | x1.004 | x1.057 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1024 | 0.261 | 0.260 | x0.996 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.968 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 4096 | 0.132 | 0.130 | x0.988 | level | 3 of 4 | - | - | x0.983 | x0.994 | x1.002 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 16384 | 0.137 | 0.142 | x1.034 | level | 2 of 4 | - | - | x1.038 | x0.991 | x1.125 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 | 0.180 | 0.178 | x0.989 | level | 2 of 4 | - | - | x0.989 | x1.012 | x1.001 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 262144 | 0.332 | 0.345 | x1.040 | level | 1 of 4 | - | - | x1.039 | x0.811 | x0.990 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 x 32 B | 0.355 | 0.354 | x0.995 | level | 2 of 4 | - | - | x0.995 | x1.014 | x0.991 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 32 B | 0.505 | 0.485 | x0.959 | level | 3 of 4 | - | - | x0.965 | x0.929 | x0.990 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 16 B | 0.524 | 0.517 | x0.987 | level | 3 of 4 | - | - | x0.998 | x1.043 | x0.937 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 x 48 B | 0.280 | 0.287 | x1.025 | level | 0 of 4 | - | - | x1.024 | x0.975 | x0.985 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 48 B | 0.436 | 0.430 | x0.986 | level | 3 of 4 | - | - | x0.986 | x0.948 | x1.005 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / saturated | 0.0943 | 0.0942 | x0.998 | level | 1 of 4 | - | - | x0.982 | x1.021 | x0.982 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / 2 μs | 0.105 | 0.102 | x0.972 | level | 3 of 4 | - | - | x1.059 | x0.992 | x0.931 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 3 of 4 | - | - | x0.767 | x0.963 | x0.810 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 64 B | 1.275 | 1.271 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.786 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 1 KiB | 0.952 | 0.951 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.070 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 4 KiB | 0.328 | 0.329 | x1.001 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.858 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 64 B | 16.577 | 17.074 | x1.030 | level | 1 of 4 | - | - | x1.038 | x0.992 | x0.991 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 4 KiB | 0.227 | 0.227 | x0.998 | level | 3 of 4 | - | - | x1.001 | x1.001 | x0.952 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 1 MiB | 0.0905 | 0.0936 | x1.035 | level | 1 of 4 | - | - | x1.021 | x1.009 | x0.977 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 64 B | 0.661 | 0.618 | x0.936 | level | 4 of 4 | - | - | x0.933 | x0.971 | x0.937 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 4 KiB | 0.0675 | 0.0699 | x1.036 | level | 1 of 4 | - | - | x1.022 | x0.983 | x0.879 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 1 MiB | 0.0207 | 0.0174 | x0.841 | level | 3 of 4 | - | - | x0.865 | x0.856 | x0.826 |

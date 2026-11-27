# Nightly drift check: e1966b498bc7 -> 87a0ab4b9f3c

- Host: bench-zen3
- Experiment: `bench=3f119a507807078649d8700112994fce24666868|base=e1966b498bc769db3d51451a4ddc8188a19ed593|target=87a0ab4b9f3cebfa30a791993573bfb4b128ae4e|cells=all|layouts=default`
- bench-hashes: `3f119a507807078649d8700112994fce24666868`
- BLAKE3-Servil base: `e1966b498bc769db3d51451a4ddc8188a19ed593`
- BLAKE3-Servil target: `87a0ab4b9f3cebfa30a791993573bfb4b128ae4e`
- Scope: `--cells all` (layouts: default)
- Deciding stage: stage 2 (kept-drift/second)
- Verdict: **REGRESSION** (exit `1`)

## Stage 2 (deciding, kept-drift/second)

compare: old side: bench 3f119a507807 clean; servil e1966b498bc7 clean
compare: new side: bench 3f119a507807 clean; servil 87a0ab4b9f3c clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / IdleOneMessage / 4 KiB | 0.778 | 0.759 | x0.976 | level | 32 of 64 | - | - | x1.001 | x1.000 | x0.985 |
| blake3-servil-mt / solo / OneMessage / 512 B | 2.008 | 1.990 | x0.991 | level | 35 of 64 | - | - | x0.993 | x1.000 | x0.995 |
| blake3-servil-mt / solo / ManyMessages / 4 | 173.720 | 171.728 | x0.989 | level | 35 of 64 | - | - | x0.991 | x1.000 | x0.982 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.706 | 0.689 | x0.976 | level | 44 of 64 | x0.762 | - | x0.980 | x0.979 | x0.987 |
| blake3-servil-mt / solo / ContinuousMessages / 128 B | 0.351 | 0.347 | x0.989 | level | 41 of 64 | x0.808 | - | x0.992 | x0.979 | x1.046 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.184 | 0.184 | x0.997 | level | 35 of 64 | x0.935 | - | x0.999 | x0.980 | x1.149 |
| blake3-servil-mt / solo / ContinuousMessages / 64 MiB | 0.0625 | 0.0630 | x1.008 | level | 22 of 64 | x0.999 | - | x1.008 | x1.009 | x1.007 |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.0466 | 0.0470 | x1.008 | level | 29 of 64 | x0.972 | - | x1.009 | x1.007 | x1.010 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.680 | 0.717 | x1.055 | slower | 9 of 64 | - | - | x1.055 | x0.979 | x1.067 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 128 B | 0.353 | 0.367 | x1.041 | level | 18 of 64 | - | - | x1.040 | x0.979 | x1.109 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.195 | 0.203 | x1.042 | level | 19 of 64 | - | - | x1.041 | x0.979 | x1.127 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 MiB | 0.0823 | 0.0828 | x1.006 | level | 25 of 64 | - | - | x1.007 | x1.009 | x1.018 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.0782 | 0.0784 | x1.002 | level | 36 of 64 | - | - | x0.998 | x1.005 | x0.999 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 B | 1.423 | 0.992 | x0.697 | faster | 59 of 64 | - | - | x0.692 | x0.978 | x1.003 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 128 B | 0.730 | 0.669 | x0.916 | faster | 43 of 64 | - | - | x0.899 | x0.979 | x1.034 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 256 B | 0.401 | 0.398 | x0.994 | level | 36 of 64 | - | - | x0.979 | x0.979 | x1.231 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 MiB | 0.114 | 0.116 | x1.019 | level | 25 of 64 | - | - | x1.008 | x1.011 | x0.904 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / saturated | 0.0939 | 0.0964 | x1.027 | level | 24 of 64 | - | - | x1.010 | x1.017 | x0.954 |

## Stage 1 (initial screen, kept-drift)

compare: old side: bench 3f119a507807 clean; servil e1966b498bc7 clean
compare: new side: bench 3f119a507807 clean; servil 87a0ab4b9f3c clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 7.241 | 7.035 | x0.972 | level | 3 of 4 | - | - | x0.999 | x1.003 | x1.017 |
| blake3-servil-st / solo / OneMessage / 128 B | 4.312 | 4.114 | x0.954 | level | 3 of 4 | - | - | x0.985 | x1.001 | x1.023 |
| blake3-servil-st / solo / OneMessage / 256 B | 2.558 | 2.675 | x1.046 | level | 0 of 4 | - | - | x1.017 | x1.001 | x1.027 |
| blake3-servil-st / solo / OneMessage / 512 B | 1.892 | 1.848 | x0.977 | level | 2 of 4 | - | - | x1.009 | x1.002 | x1.013 |
| blake3-servil-st / solo / OneMessage / 1 KiB | 1.394 | 1.406 | x1.009 | level | 0 of 4 | - | - | x1.008 | x1.001 | x1.014 |
| blake3-servil-st / solo / OneMessage / 1536 B | 1.446 | 1.418 | x0.980 | level | 2 of 4 | - | - | x0.978 | x0.998 | x0.970 |
| blake3-servil-st / solo / OneMessage / 2 KiB | 0.957 | 0.935 | x0.977 | level | 3 of 4 | - | - | x0.980 | x1.001 | x0.992 |
| blake3-servil-st / solo / OneMessage / 2304 B | 1.122 | 1.096 | x0.977 | level | 3 of 4 | - | - | x0.991 | x1.000 | x1.009 |
| blake3-servil-st / solo / OneMessage / 3 KiB | 0.832 | 0.825 | x0.991 | level | 2 of 4 | - | - | x0.990 | x1.000 | x1.008 |
| blake3-servil-st / solo / OneMessage / 3839 B | 0.959 | 0.951 | x0.992 | level | 3 of 4 | - | - | x0.986 | x1.000 | x0.989 |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.609 | 0.605 | x0.993 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.000 |
| blake3-servil-st / solo / OneMessage / 4470 B | 0.696 | 0.680 | x0.977 | level | 4 of 4 | - | - | x0.994 | x1.000 | x0.993 |
| blake3-servil-st / solo / OneMessage / 7935 B | 0.539 | 0.545 | x1.010 | level | 1 of 4 | - | - | x0.990 | x1.000 | x0.990 |
| blake3-servil-st / solo / OneMessage / 8 KiB | 0.446 | 0.457 | x1.025 | level | 2 of 4 | - | - | x0.983 | x1.000 | x0.995 |
| blake3-servil-st / solo / OneMessage / 16 KiB | 0.375 | 0.375 | x1.000 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.019 |
| blake3-servil-st / solo / OneMessage / 32 KiB | 0.336 | 0.333 | x0.991 | level | 2 of 4 | - | - | x0.995 | x1.000 | x1.038 |
| blake3-servil-st / solo / OneMessage / 64 KiB | 0.311 | 0.314 | x1.010 | level | 1 of 4 | - | - | x0.996 | x1.000 | x1.005 |
| blake3-servil-st / solo / OneMessage / 128 KiB | 0.303 | 0.303 | x1.000 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.028 |
| blake3-servil-st / solo / OneMessage / 256 KiB | 0.295 | 0.293 | x0.992 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.030 |
| blake3-servil-st / solo / OneMessage / 512 KiB | 0.284 | 0.288 | x1.013 | level | 1 of 4 | - | - | x1.007 | x1.000 | x1.035 |
| blake3-servil-st / solo / OneMessage / 1 MiB | 0.283 | 0.285 | x1.006 | level | 1 of 4 | - | - | x1.008 | x1.000 | x1.034 |
| blake3-servil-st / solo / OneMessage / 2 MiB | 0.297 | 0.296 | x0.995 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.023 |
| blake3-servil-st / solo / OneMessage / 3 MiB | 0.304 | 0.303 | x0.995 | level | 3 of 4 | - | - | x0.994 | x1.000 | x1.020 |
| blake3-servil-st / solo / OneMessage / 4 MiB | 0.297 | 0.296 | x0.995 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.013 |
| blake3-servil-st / solo / OneMessage / 8 MiB | 0.313 | 0.312 | x0.996 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.011 |
| blake3-servil-st / solo / OneMessage / 32 MiB | 0.302 | 0.300 | x0.992 | level | 3 of 4 | - | - | x0.993 | x1.000 | x0.996 |
| blake3-servil-st / solo / OneMessage / 64 MiB | 0.303 | 0.301 | x0.994 | level | 4 of 4 | - | - | x0.994 | x1.000 | x1.003 |
| blake3-servil-st / solo / OneMessage / 128 MiB | 0.300 | 0.298 | x0.992 | level | 3 of 4 | - | - | x0.991 | x1.000 | x1.006 |
| blake3-servil-st / solo / ManyMessages / 1 | 459.375 | 459.470 | x1.000 | level | 1 of 4 | - | - | x1.002 | x1.001 | x1.023 |
| blake3-servil-st / solo / ManyMessages / 2 | 300.639 | 298.665 | x0.993 | level | 2 of 4 | - | - | x1.051 | x1.002 | x0.980 |
| blake3-servil-st / solo / ManyMessages / 3 | 203.559 | 205.546 | x1.010 | level | 3 of 4 | - | - | x1.036 | x1.003 | x0.989 |
| blake3-servil-st / solo / ManyMessages / 4 | 148.413 | 158.790 | x1.070 | level | 1 of 4 | - | - | x1.085 | x1.002 | x0.992 |
| blake3-servil-st / solo / ManyMessages / 6 | 134.823 | 130.843 | x0.970 | level | 2 of 4 | - | - | x1.022 | x1.003 | x0.993 |
| blake3-servil-st / solo / ManyMessages / 8 | 113.468 | 110.636 | x0.975 | level | 3 of 4 | - | - | x0.996 | x1.003 | x1.002 |
| blake3-servil-st / solo / ManyMessages / 12 | 88.374 | 83.177 | x0.941 | level | 3 of 4 | - | - | x0.991 | x1.003 | x1.006 |
| blake3-servil-st / solo / ManyMessages / 16 | 64.503 | 62.710 | x0.972 | level | 3 of 4 | - | - | x0.986 | x1.003 | x0.997 |
| blake3-servil-st / solo / ManyMessages / 24 | 47.859 | 48.947 | x1.023 | level | 2 of 4 | - | - | x1.021 | x1.003 | x1.000 |
| blake3-servil-st / solo / ManyMessages / 32 | 41.488 | 39.093 | x0.942 | level | 3 of 4 | - | - | x0.981 | x1.003 | x1.000 |
| blake3-servil-st / solo / ManyMessages / 48 | 31.796 | 31.982 | x1.006 | level | 2 of 4 | - | - | x1.008 | x1.001 | x0.997 |
| blake3-servil-st / solo / ManyMessages / 64 | 29.266 | 27.977 | x0.956 | level | 3 of 4 | - | - | x0.982 | x1.001 | x0.983 |
| blake3-servil-st / solo / ManyMessages / 128 | 23.941 | 23.635 | x0.987 | level | 2 of 4 | - | - | x1.011 | x1.000 | x1.006 |
| blake3-servil-st / solo / ManyMessages / 256 | 21.000 | 20.705 | x0.986 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.017 |
| blake3-servil-st / solo / ManyMessages / 512 | 19.131 | 19.166 | x1.002 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.018 |
| blake3-servil-st / solo / ManyMessages / 1024 | 18.508 | 18.719 | x1.011 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.997 |
| blake3-servil-st / solo / ManyMessages / 2048 | 18.422 | 18.173 | x0.986 | level | 3 of 4 | - | - | x0.993 | x1.000 | x1.003 |
| blake3-servil-st / solo / ManyMessages / 4096 | 18.100 | 17.924 | x0.990 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.982 |
| blake3-servil-st / solo / ManyMessages / 8192 | 17.279 | 17.301 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.009 |
| blake3-servil-st / solo / ManyMessages / 16384 | 17.150 | 17.195 | x1.003 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.010 |
| blake3-servil-st / solo / ManyMessages / 32768 | 17.454 | 17.442 | x0.999 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.002 |
| blake3-servil-st / solo / ManyMessages / 65536 | 17.507 | 17.453 | x0.997 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.007 |
| blake3-servil-st / solo / ManyMessages / 131072 | 17.874 | 18.027 | x1.009 | level | 1 of 4 | - | - | x1.005 | x1.000 | x1.016 |
| blake3-servil-st / solo / ManyMessages / 262144 | 18.355 | 18.419 | x1.003 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.012 |
| blake3-servil-st / solo / ManyLongMessages / 4 | 1775.503 | 1799.941 | x1.014 | level | 2 of 4 | - | - | x1.015 | x1.000 | x1.033 |
| blake3-servil-st / solo / ManyLongMessages / 16 | 1225.810 | 1228.897 | x1.003 | level | 2 of 4 | - | - | x1.004 | x1.000 | x1.012 |
| blake3-servil-st / solo / ManyLongMessages / 64 | 1182.029 | 1182.873 | x1.001 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.992 |
| blake3-servil-st / solo / ManyLongMessages / 256 | 1135.469 | 1141.249 | x1.005 | level | 1 of 4 | - | - | x1.006 | x1.000 | x0.999 |
| blake3-servil-st / solo / IdleOneMessage / 64 B | 5.576 | 5.288 | x0.948 | level | 3 of 4 | - | - | x0.996 | x0.997 | x0.991 |
| blake3-servil-st / solo / IdleOneMessage / 128 B | 3.965 | 3.822 | x0.964 | level | 2 of 4 | - | - | x1.002 | x0.996 | x1.054 |
| blake3-servil-st / solo / IdleOneMessage / 256 B | 2.818 | 2.738 | x0.972 | level | 4 of 4 | - | - | x0.995 | x0.998 | x1.071 |
| blake3-servil-st / solo / IdleOneMessage / 512 B | 2.415 | 2.425 | x1.004 | level | 2 of 4 | - | - | x0.996 | x0.999 | x0.891 |
| blake3-servil-st / solo / IdleOneMessage / 1 KiB | 2.205 | 2.144 | x0.972 | level | 4 of 4 | - | - | x0.997 | x0.999 | x0.822 |
| blake3-servil-st / solo / IdleOneMessage / 1536 B | 1.765 | 1.719 | x0.974 | level | 3 of 4 | - | - | x0.993 | x0.997 | x0.801 |
| blake3-servil-st / solo / IdleOneMessage / 2 KiB | 1.265 | 1.233 | x0.975 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.733 |
| blake3-servil-st / solo / IdleOneMessage / 2304 B | 1.406 | 1.443 | x1.026 | level | 1 of 4 | - | - | x1.003 | x1.000 | x0.879 |
| blake3-servil-st / solo / IdleOneMessage / 3 KiB | 1.056 | 1.023 | x0.969 | level | 2 of 4 | - | - | x0.993 | x1.000 | x0.694 |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 1.127 | 1.117 | x0.992 | level | 3 of 4 | - | - | x0.985 | x1.000 | x0.919 |
| blake3-servil-st / solo / IdleOneMessage / 4 KiB | 0.753 | 0.839 | x1.113 | level | 0 of 4 | - | - | x0.998 | x1.000 | x0.811 |
| blake3-servil-st / solo / IdleOneMessage / 4470 B | 0.927 | 0.920 | x0.992 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.892 |
| blake3-servil-st / solo / IdleOneMessage / 7935 B | 0.591 | 0.588 | x0.994 | level | 2 of 4 | - | - | x0.989 | x1.000 | x0.756 |
| blake3-servil-st / solo / IdleOneMessage / 8 KiB | 0.542 | 0.543 | x1.001 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.014 |
| blake3-servil-st / solo / IdleOneMessage / 16 KiB | 0.486 | 0.489 | x1.007 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.898 |
| blake3-servil-st / solo / IdleOneMessage / 32 KiB | 0.477 | 0.467 | x0.978 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.918 |
| blake3-servil-st / solo / IdleOneMessage / 64 KiB | 0.466 | 0.469 | x1.007 | level | 1 of 4 | - | - | x0.996 | x1.000 | x1.097 |
| blake3-servil-st / solo / IdleOneMessage / 128 KiB | 0.467 | 0.458 | x0.982 | level | 3 of 4 | - | - | x0.994 | x1.000 | x1.012 |
| blake3-servil-st / solo / IdleOneMessage / 256 KiB | 0.469 | 0.469 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.089 |
| blake3-servil-st / solo / IdleOneMessage / 512 KiB | 0.489 | 0.485 | x0.991 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.013 |
| blake3-servil-st / solo / IdleOneMessage / 1 MiB | 0.486 | 0.480 | x0.988 | level | 3 of 4 | - | - | x1.003 | x1.000 | x1.035 |
| blake3-servil-st / solo / IdleOneMessage / 2 MiB | 0.498 | 0.487 | x0.977 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.018 |
| blake3-servil-st / solo / IdleOneMessage / 3 MiB | 0.451 | 0.453 | x1.005 | level | 1 of 4 | - | - | x0.998 | x1.000 | x1.015 |
| blake3-servil-st / solo / IdleOneMessage / 4 MiB | 0.405 | 0.423 | x1.045 | level | 0 of 4 | - | - | x0.999 | x1.000 | x1.008 |
| blake3-servil-st / solo / IdleOneMessage / 8 MiB | 0.330 | 0.328 | x0.992 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.005 |
| blake3-servil-st / solo / IdleOneMessage / 32 MiB | 0.299 | 0.297 | x0.994 | level | 3 of 4 | - | - | x0.992 | x1.000 | x0.999 |
| blake3-servil-st / solo / IdleOneMessage / 64 MiB | 0.301 | 0.301 | x1.000 | level | 2 of 4 | - | - | x0.993 | x1.000 | x1.002 |
| blake3-servil-st / solo / IdleOneMessage / 128 MiB | 0.303 | 0.299 | x0.987 | level | 4 of 4 | - | - | x0.987 | x1.000 | x1.004 |
| blake3-servil-st / solo / IdleManyMessages / 1 | 392.547 | 376.010 | x0.958 | level | 2 of 4 | - | - | x0.994 | x0.998 | x0.857 |
| blake3-servil-st / solo / IdleManyMessages / 2 | 197.354 | 194.465 | x0.985 | level | 2 of 4 | - | - | x0.988 | x0.995 | x0.795 |
| blake3-servil-st / solo / IdleManyMessages / 3 | 181.037 | 173.001 | x0.956 | level | 2 of 4 | - | - | x0.999 | x0.996 | x1.093 |
| blake3-servil-st / solo / IdleManyMessages / 4 | 111.082 | 108.827 | x0.980 | level | 3 of 4 | - | - | x1.002 | x0.996 | x0.799 |
| blake3-servil-st / solo / IdleManyMessages / 6 | 97.395 | 92.536 | x0.950 | level | 2 of 4 | - | - | x0.979 | x0.997 | x0.715 |
| blake3-servil-st / solo / IdleManyMessages / 8 | 72.456 | 67.712 | x0.935 | level | 3 of 4 | - | - | x0.994 | x0.996 | x1.022 |
| blake3-servil-st / solo / IdleManyMessages / 12 | 59.248 | 59.965 | x1.012 | level | 1 of 4 | - | - | x0.996 | x0.997 | x0.808 |
| blake3-servil-st / solo / IdleManyMessages / 16 | 51.402 | 53.885 | x1.048 | level | 1 of 4 | - | - | x1.001 | x0.997 | x0.938 |
| blake3-servil-st / solo / IdleManyMessages / 24 | 45.035 | 43.646 | x0.969 | level | 4 of 4 | - | - | x0.989 | x0.999 | x0.837 |
| blake3-servil-st / solo / IdleManyMessages / 32 | 40.072 | 40.415 | x1.009 | level | 1 of 4 | - | - | x0.984 | x0.999 | x0.837 |
| blake3-servil-st / solo / IdleManyMessages / 48 | 36.754 | 36.449 | x0.992 | level | 2 of 4 | - | - | x1.000 | x0.999 | x1.013 |
| blake3-servil-st / solo / IdleManyMessages / 64 | 35.089 | 33.640 | x0.959 | level | 3 of 4 | - | - | x0.976 | x0.999 | x0.808 |
| blake3-servil-st / solo / IdleManyMessages / 128 | 31.376 | 31.927 | x1.018 | level | 1 of 4 | - | - | x0.997 | x1.000 | x0.894 |
| blake3-servil-st / solo / IdleManyMessages / 256 | 29.592 | 31.068 | x1.050 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.891 |
| blake3-servil-st / solo / IdleManyMessages / 512 | 29.590 | 29.518 | x0.998 | level | 2 of 4 | - | - | x0.992 | x1.000 | x0.976 |
| blake3-servil-st / solo / IdleManyMessages / 1024 | 29.104 | 28.663 | x0.985 | level | 2 of 4 | - | - | x0.992 | x1.000 | x0.948 |
| blake3-servil-st / solo / IdleManyMessages / 2048 | 29.397 | 29.354 | x0.999 | level | 3 of 4 | - | - | x0.985 | x1.000 | x1.017 |
| blake3-servil-st / solo / IdleManyMessages / 4096 | 29.969 | 28.516 | x0.952 | level | 4 of 4 | - | - | x0.995 | x1.000 | x1.026 |
| blake3-servil-st / solo / IdleManyMessages / 8192 | 28.905 | 29.627 | x1.025 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.048 |
| blake3-servil-st / solo / IdleManyMessages / 16384 | 30.076 | 30.878 | x1.027 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.994 |
| blake3-servil-st / solo / IdleManyMessages / 32768 | 30.499 | 30.275 | x0.993 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.990 |
| blake3-servil-st / solo / IdleManyMessages / 65536 | 26.612 | 26.694 | x1.003 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.021 |
| blake3-servil-st / solo / IdleManyMessages / 131072 | 20.547 | 20.830 | x1.014 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.034 |
| blake3-servil-st / solo / IdleManyMessages / 262144 | 18.029 | 18.034 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.988 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 B | 2.430 | 2.423 | x0.997 | level | 2 of 4 | - | - | x1.003 | x0.994 | x0.903 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 B | 1.750 | 1.691 | x0.966 | level | 3 of 4 | - | - | x1.002 | x0.995 | x0.817 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 B | 1.307 | 1.308 | x1.001 | level | 1 of 4 | - | - | x1.003 | x0.997 | x1.053 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 B | 1.125 | 1.125 | x1.000 | level | 2 of 4 | - | - | x1.002 | x0.999 | x0.710 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 KiB | 1.047 | 1.027 | x0.981 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.936 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1536 B | 0.803 | 0.808 | x1.006 | level | 3 of 4 | - | - | x0.995 | x0.997 | x0.704 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 KiB | 0.572 | 0.570 | x0.995 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.483 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2304 B | 0.655 | 0.652 | x0.995 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.701 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.475 | 0.474 | x0.998 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.770 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3839 B | 0.502 | 0.498 | x0.991 | level | 3 of 4 | - | - | x0.992 | x1.000 | x0.684 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 KiB | 0.355 | 0.354 | x0.996 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.776 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4470 B | 0.427 | 0.426 | x0.998 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.863 |
| blake3-servil-st / solo / BriefIdleOneMessage / 7935 B | 0.274 | 0.269 | x0.981 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.562 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 KiB | 0.246 | 0.246 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.613 |
| blake3-servil-st / solo / BriefIdleOneMessage / 16 KiB | 0.230 | 0.233 | x1.016 | level | 0 of 4 | - | - | x1.006 | x1.000 | x0.868 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 KiB | 0.224 | 0.223 | x0.996 | level | 2 of 4 | - | - | x1.007 | x1.000 | x1.595 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 KiB | 0.221 | 0.219 | x0.991 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.895 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 KiB | 0.221 | 0.219 | x0.991 | level | 4 of 4 | - | - | x0.994 | x1.000 | x1.026 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 KiB | 0.226 | 0.225 | x0.995 | level | 2 of 4 | - | - | x0.995 | x1.000 | x0.990 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 KiB | 0.233 | 0.232 | x0.996 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.994 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 MiB | 0.235 | 0.236 | x1.004 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.050 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 MiB | 0.238 | 0.238 | x1.000 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.031 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 MiB | 0.238 | 0.238 | x0.998 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.008 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 MiB | 0.239 | 0.238 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.011 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 MiB | 0.246 | 0.245 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.003 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 MiB | 0.296 | 0.292 | x0.988 | level | 3 of 4 | - | - | x0.988 | x1.000 | x1.000 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 MiB | 0.298 | 0.295 | x0.990 | level | 4 of 4 | - | - | x0.990 | x1.000 | x0.993 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 MiB | 0.301 | 0.297 | x0.988 | level | 3 of 4 | - | - | x0.987 | x1.000 | x1.002 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1 | 175.218 | 169.134 | x0.965 | level | 3 of 4 | - | - | x1.000 | x0.997 | x0.708 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2 | 88.771 | 89.097 | x1.004 | level | 2 of 4 | - | - | x1.004 | x0.995 | x0.561 |
| blake3-servil-st / solo / BriefIdleManyMessages / 3 | 77.276 | 77.737 | x1.006 | level | 1 of 4 | - | - | x1.005 | x0.996 | x0.658 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4 | 48.508 | 48.827 | x1.007 | level | 1 of 4 | - | - | x1.006 | x0.996 | x0.504 |
| blake3-servil-st / solo / BriefIdleManyMessages / 6 | 42.751 | 42.822 | x1.002 | level | 1 of 4 | - | - | x1.002 | x0.997 | x0.792 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8 | 30.405 | 30.281 | x0.996 | level | 2 of 4 | - | - | x0.999 | x0.997 | x0.950 |
| blake3-servil-st / solo / BriefIdleManyMessages / 12 | 27.145 | 27.087 | x0.998 | level | 2 of 4 | - | - | x1.000 | x0.997 | x0.799 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16 | 23.286 | 23.353 | x1.003 | level | 2 of 4 | - | - | x1.003 | x0.998 | x1.547 |
| blake3-servil-st / solo / BriefIdleManyMessages / 24 | 20.053 | 20.071 | x1.001 | level | 2 of 4 | - | - | x1.000 | x0.998 | x1.495 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32 | 18.348 | 20.692 | x1.128 | level | 2 of 4 | - | - | x1.002 | x0.999 | x2.362 |
| blake3-servil-st / solo / BriefIdleManyMessages / 48 | 16.818 | 16.752 | x0.996 | level | 3 of 4 | - | - | x0.995 | x0.999 | x1.052 |
| blake3-servil-st / solo / BriefIdleManyMessages / 64 | 15.887 | 15.879 | x1.000 | level | 3 of 4 | - | - | x1.000 | x0.999 | x1.107 |
| blake3-servil-st / solo / BriefIdleManyMessages / 128 | 14.704 | 14.531 | x0.988 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.163 |
| blake3-servil-st / solo / BriefIdleManyMessages / 256 | 13.911 | 13.941 | x1.002 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.266 |
| blake3-servil-st / solo / BriefIdleManyMessages / 512 | 13.686 | 13.646 | x0.997 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.028 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1024 | 14.043 | 13.467 | x0.959 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.764 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2048 | 13.761 | 13.562 | x0.986 | level | 3 of 4 | - | - | x0.989 | x1.000 | x1.042 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4096 | 14.201 | 14.054 | x0.990 | level | 3 of 4 | - | - | x0.989 | x1.000 | x1.065 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8192 | 14.452 | 14.458 | x1.000 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.031 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16384 | 14.592 | 14.657 | x1.004 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.033 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32768 | 14.843 | 14.855 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.994 |
| blake3-servil-st / solo / BriefIdleManyMessages / 65536 | 15.158 | 15.015 | x0.991 | level | 3 of 4 | - | - | x0.991 | x1.000 | x1.026 |
| blake3-servil-st / solo / BriefIdleManyMessages / 131072 | 15.138 | 15.025 | x0.993 | level | 3 of 4 | - | - | x0.993 | x1.000 | x1.107 |
| blake3-servil-st / solo / BriefIdleManyMessages / 262144 | 15.856 | 15.755 | x0.994 | level | 2 of 4 | - | - | x0.994 | x1.000 | x0.980 |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.884 | 0.885 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | x1.133 |
| blake3-servil-st / solo / ContinuousMessages / 128 B | 0.898 | 0.907 | x1.009 | level | 1 of 4 | x1.009 | - | x1.010 | x1.000 | x0.891 |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 0.914 | 0.911 | x0.996 | level | 3 of 4 | x0.996 | - | x0.996 | x1.000 | x0.903 |
| blake3-servil-st / solo / ContinuousMessages / 512 B | 0.930 | 0.930 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.827 |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 0.927 | 0.924 | x0.996 | level | 3 of 4 | x0.997 | - | x1.000 | x1.000 | x0.646 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.316 | 0.315 | x0.998 | level | 4 of 4 | x0.998 | - | x0.999 | x1.000 | x0.830 |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.215 | 0.217 | x1.007 | level | 0 of 4 | x1.007 | - | x1.008 | x1.000 | x0.984 |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.217 | 0.217 | x1.004 | level | 1 of 4 | x1.004 | - | x1.004 | x1.000 | x1.291 |
| blake3-servil-st / solo / ContinuousMessages / 256 KiB | 0.218 | 0.219 | x1.005 | level | 1 of 4 | x1.005 | - | x1.004 | x1.000 | x1.053 |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.219 | 0.220 | x1.004 | level | 2 of 4 | x1.004 | - | x1.003 | x1.000 | x0.797 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.219 | 0.219 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x1.261 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.221 | 0.221 | x1.000 | level | 2 of 4 | x1.000 | - | x0.999 | x1.000 | x1.009 |
| blake3-servil-st / solo / ContinuousMessages / 64 MiB | 0.253 | 0.256 | x1.011 | level | 1 of 4 | x1.010 | - | x1.011 | x1.000 | x1.163 |
| blake3-servil-st / solo / ContinuousBatches / 16 | 16.459 | 16.948 | x1.030 | level | 1 of 4 | x1.030 | - | x1.033 | x0.999 | x0.966 |
| blake3-servil-st / solo / ContinuousBatches / 64 | 13.743 | 13.887 | x1.010 | level | 1 of 4 | x1.011 | - | x1.011 | x1.000 | x1.097 |
| blake3-servil-st / solo / ContinuousBatches / 256 | 13.674 | 13.728 | x1.004 | level | 2 of 4 | x1.004 | - | x1.004 | x1.000 | x1.131 |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 13.870 | 13.921 | x1.004 | level | 2 of 4 | x1.004 | - | x1.004 | x1.000 | x1.024 |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 14.505 | 14.489 | x0.999 | level | 2 of 4 | x0.999 | - | x1.000 | x1.000 | x1.001 |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 14.993 | 15.023 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.000 | x1.038 |
| blake3-servil-st / solo / ContinuousBatches / 65536 | 15.036 | 15.069 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.000 | x0.964 |
| blake3-servil-st / solo / LentMessages / 64 B | 0.884 | 0.885 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | x1.133 |
| blake3-servil-st / solo / LentMessages / 128 B | 0.898 | 0.907 | x1.009 | level | 1 of 4 | x1.009 | - | x1.010 | x1.000 | x0.891 |
| blake3-servil-st / solo / LentMessages / 256 B | 0.914 | 0.911 | x0.996 | level | 3 of 4 | x0.996 | - | x0.996 | x1.000 | x0.903 |
| blake3-servil-st / solo / LentMessages / 512 B | 0.930 | 0.930 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.827 |
| blake3-servil-st / solo / LentMessages / 1 KiB | 0.927 | 0.924 | x0.996 | level | 3 of 4 | x0.997 | - | x1.000 | x1.000 | x0.646 |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.316 | 0.315 | x0.998 | level | 4 of 4 | x0.998 | - | x0.999 | x1.000 | x0.830 |
| blake3-servil-st / solo / LentMessages / 16 KiB | 0.215 | 0.217 | x1.007 | level | 0 of 4 | x1.007 | - | x1.008 | x1.000 | x0.984 |
| blake3-servil-st / solo / LentMessages / 64 KiB | 0.217 | 0.217 | x1.004 | level | 1 of 4 | x1.004 | - | x1.004 | x1.000 | x1.291 |
| blake3-servil-st / solo / LentMessages / 256 KiB | 0.220 | 0.220 | x0.998 | level | 2 of 4 | x0.998 | - | x0.997 | x1.000 | x1.211 |
| blake3-servil-st / solo / LentMessages / 1 MiB | 0.231 | 0.231 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x1.000 | x0.977 |
| blake3-servil-st / solo / LentMessages / 4 MiB | 0.234 | 0.233 | x0.997 | level | 2 of 4 | x0.998 | - | x0.997 | x1.000 | x0.968 |
| blake3-servil-st / solo / LentMessages / 16 MiB | 0.259 | 0.258 | x0.996 | level | 2 of 4 | x0.996 | - | x0.996 | x1.000 | x1.008 |
| blake3-servil-st / solo / LentMessages / 64 MiB | 0.300 | 0.296 | x0.988 | level | 2 of 4 | x0.988 | - | x0.987 | x1.000 | x1.010 |
| blake3-servil-st / solo / Interleaved / 256 | 0.259 | 0.261 | x1.008 | level | 1 of 4 | x1.008 | - | x1.009 | x0.998 | x0.971 |
| blake3-servil-st / solo / Collection / git objects | 0.248 | 0.246 | x0.994 | level | 3 of 4 | x0.995 | - | x0.995 | x1.000 | x0.978 |
| blake3-servil-st / solo / Collection / Nix files | 0.232 | 0.233 | x1.003 | level | 2 of 4 | x1.003 | - | x1.003 | x0.999 | x1.019 |
| blake3-servil-st / solo / LentBatches / 16 | 16.459 | 16.948 | x1.030 | level | 1 of 4 | x1.030 | - | x1.033 | x0.999 | x0.966 |
| blake3-servil-st / solo / LentBatches / 64 | 13.743 | 13.887 | x1.010 | level | 1 of 4 | x1.011 | - | x1.011 | x1.000 | x1.097 |
| blake3-servil-st / solo / LentBatches / 256 | 13.674 | 13.728 | x1.004 | level | 2 of 4 | x1.004 | - | x1.004 | x1.000 | x1.131 |
| blake3-servil-st / solo / LentBatches / 1024 | 13.870 | 13.921 | x1.004 | level | 2 of 4 | x1.004 | - | x1.004 | x1.000 | x1.024 |
| blake3-servil-st / solo / LentBatches / 4096 | 14.505 | 14.489 | x0.999 | level | 2 of 4 | x0.999 | - | x1.000 | x1.000 | x1.001 |
| blake3-servil-st / solo / LentBatches / 16384 | 14.993 | 15.023 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.000 | x1.038 |
| blake3-servil-st / solo / LentBatches / 65536 | 15.036 | 15.069 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.000 | x0.964 |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.269 | 0.271 | x1.009 | level | 1 of 4 | x1.009 | - | x1.009 | x1.000 | x0.924 |
| blake3-servil-st / solo / ContinuousCollection / Nix files | 0.277 | 0.275 | x0.993 | level | 2 of 4 | x0.993 | - | x0.994 | x1.000 | x0.945 |
| blake3-servil-st / solo / MerkleTree / 1024 | 0.261 | 0.262 | x1.002 | level | 1 of 4 | x1.002 | - | x1.001 | x1.000 | x1.058 |
| blake3-servil-st / solo / MerkleTree / 4096 | 0.270 | 0.270 | x1.001 | level | 2 of 4 | x1.000 | - | x0.999 | x1.000 | x1.076 |
| blake3-servil-st / solo / MerkleTree / 16384 | 0.273 | 0.273 | x0.998 | level | 2 of 4 | x0.998 | - | x0.999 | x1.000 | x1.020 |
| blake3-servil-st / solo / MerkleTree / 65536 | 0.306 | 0.305 | x0.998 | level | 3 of 4 | x0.998 | - | x0.999 | x1.000 | x0.970 |
| blake3-servil-st / solo / MerkleTree / 262144 | 0.556 | 0.549 | x0.987 | level | 3 of 4 | x0.987 | - | x0.986 | x1.000 | x0.992 |
| blake3-servil-st / solo / MerkleTree / 65536 x 32 B | 0.835 | 0.834 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x1.010 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 32 B | 1.103 | 1.103 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.977 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 16 B | 1.674 | 1.672 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x0.971 |
| blake3-servil-st / solo / MerkleTree / 65536 x 48 B | 0.572 | 0.574 | x1.003 | level | 1 of 4 | x1.003 | - | x1.002 | x1.000 | x1.009 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 48 B | 0.839 | 0.842 | x1.003 | level | 1 of 4 | x1.003 | - | x1.003 | x1.000 | x1.012 |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.481 | 0.478 | x0.993 | level | 3 of 4 | - | - | x0.994 | x0.991 | x1.005 |
| blake3-servil-st / solo / InterleavedTurn / 1024 x 1 KiB | 0.526 | 0.527 | x1.001 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.992 |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.689 | 0.700 | x1.016 | level | 1 of 4 | - | - | x1.032 | x1.023 | x0.989 |
| blake3-servil-st / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.838 | 0.845 | x1.008 | level | 1 of 4 | - | - | x1.003 | x1.000 | x0.990 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.392 | 0.392 | x0.999 | level | 3 of 4 | - | - | x1.001 | x0.989 | x1.000 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.434 | 0.431 | x0.994 | level | 2 of 4 | - | - | x0.995 | x1.000 | x0.993 |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.229 | 0.229 | x1.001 | level | 1 of 4 | x1.001 | - | x1.002 | x1.000 | x1.013 |
| blake3-servil-st / solo / ReceivingMessage / 2 μs | 0.230 | 0.231 | x1.003 | level | 2 of 4 | x1.003 | - | x1.003 | x1.000 | x0.970 |
| blake3-servil-st / solo / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 2 of 4 | x1.000 | - | x1.003 | x1.000 | x0.983 |
| blake3-servil-st / solo / IncrementalMessage / 64 B | 7.367 | 7.729 | x1.049 | level | 0 of 4 | - | - | x1.062 | x1.000 | x0.964 |
| blake3-servil-st / solo / IncrementalMessage / 1 KiB | 1.547 | 1.551 | x1.002 | level | 2 of 4 | - | - | x0.986 | x1.000 | x0.981 |
| blake3-servil-st / solo / IncrementalMessage / 4 KiB | 0.740 | 0.717 | x0.969 | level | 2 of 4 | - | - | x0.981 | x1.001 | x1.004 |
| blake3-servil-st / solo / LentIncrementalMessage / 64 B | 1.168 | 1.166 | x0.998 | level | 3 of 4 | x0.998 | - | x1.000 | x1.000 | x1.372 |
| blake3-servil-st / solo / LentIncrementalMessage / 1 KiB | 0.951 | 0.953 | x1.002 | level | 1 of 4 | x1.002 | - | x1.001 | x1.000 | x1.056 |
| blake3-servil-st / solo / LentIncrementalMessage / 4 KiB | 0.329 | 0.329 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | x0.764 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 0.869 | 0.866 | x0.998 | level | 2 of 4 | x0.998 | - | x0.998 | x1.000 | x0.936 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 4 KiB | 0.316 | 0.317 | x1.001 | level | 0 of 4 | x1.002 | - | x1.001 | x1.000 | x0.803 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 1 MiB | 0.220 | 0.220 | x1.001 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x1.132 |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 0.839 | 0.837 | x0.998 | level | 2 of 4 | x0.998 | - | x0.998 | x1.000 | x0.992 |
| blake3-servil-st / solo / ContinuousLentMessages / 4 KiB | 0.307 | 0.307 | x1.002 | level | 1 of 4 | x1.002 | - | x1.001 | x1.000 | x1.063 |
| blake3-servil-st / solo / ContinuousLentMessages / 1 MiB | 0.204 | 0.204 | x0.998 | level | 2 of 4 | x0.998 | - | x0.997 | x1.000 | x0.912 |
| blake3-servil-mt / solo / OneMessage / 64 B | 7.947 | 8.110 | x1.021 | level | 2 of 4 | - | - | x1.018 | x1.002 | x1.013 |
| blake3-servil-mt / solo / OneMessage / 128 B | 4.507 | 4.585 | x1.017 | level | 0 of 4 | - | - | x1.014 | x1.003 | x1.020 |
| blake3-servil-mt / solo / OneMessage / 256 B | 2.777 | 2.815 | x1.013 | level | 0 of 4 | - | - | x1.014 | x1.002 | x1.016 |
| blake3-servil-mt / solo / OneMessage / 512 B | 1.908 | 2.024 | x1.061 | level | 0 of 4 | - | - | x1.032 | x1.002 | x1.021 |
| blake3-servil-mt / solo / OneMessage / 1 KiB | 1.428 | 1.451 | x1.016 | level | 0 of 4 | - | - | x1.020 | x1.002 | x1.000 |
| blake3-servil-mt / solo / OneMessage / 1536 B | 1.408 | 1.402 | x0.996 | level | 2 of 4 | - | - | x0.994 | x0.998 | x0.994 |
| blake3-servil-mt / solo / OneMessage / 2 KiB | 0.955 | 0.960 | x1.005 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.993 |
| blake3-servil-mt / solo / OneMessage / 2304 B | 1.138 | 1.136 | x0.998 | level | 1 of 4 | - | - | x1.006 | x1.000 | x1.011 |
| blake3-servil-mt / solo / OneMessage / 3 KiB | 0.855 | 0.824 | x0.963 | level | 3 of 4 | - | - | x0.961 | x1.000 | x0.994 |
| blake3-servil-mt / solo / OneMessage / 3839 B | 0.966 | 0.959 | x0.993 | level | 3 of 4 | - | - | x0.988 | x1.000 | x1.006 |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 0.647 | 0.619 | x0.956 | level | 3 of 4 | - | - | x0.977 | x1.000 | x1.001 |
| blake3-servil-mt / solo / OneMessage / 4470 B | 0.697 | 0.692 | x0.993 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.991 |
| blake3-servil-mt / solo / OneMessage / 7935 B | 0.534 | 0.539 | x1.009 | level | 1 of 4 | - | - | x1.008 | x1.000 | x0.986 |
| blake3-servil-mt / solo / OneMessage / 8 KiB | 0.443 | 0.450 | x1.016 | level | 1 of 4 | - | - | x1.013 | x1.000 | x1.012 |
| blake3-servil-mt / solo / OneMessage / 16 KiB | 0.384 | 0.396 | x1.033 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.012 |
| blake3-servil-mt / solo / OneMessage / 32 KiB | 0.335 | 0.337 | x1.008 | level | 1 of 4 | - | - | x1.007 | x1.000 | x1.029 |
| blake3-servil-mt / solo / OneMessage / 64 KiB | 0.310 | 0.319 | x1.027 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.048 |
| blake3-servil-mt / solo / OneMessage / 128 KiB | 0.301 | 0.301 | x0.999 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.021 |
| blake3-servil-mt / solo / OneMessage / 256 KiB | 0.295 | 0.295 | x1.000 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.037 |
| blake3-servil-mt / solo / OneMessage / 512 KiB | 0.186 | 0.187 | x1.006 | level | 2 of 4 | - | - | x1.007 | x0.947 | x1.009 |
| blake3-servil-mt / solo / OneMessage / 1 MiB | 0.140 | 0.138 | x0.990 | level | 3 of 4 | - | - | x0.983 | x0.958 | x1.012 |
| blake3-servil-mt / solo / OneMessage / 2 MiB | 0.158 | 0.159 | x1.007 | level | 2 of 4 | - | - | x1.010 | x0.993 | x1.013 |
| blake3-servil-mt / solo / OneMessage / 3 MiB | 0.156 | 0.154 | x0.988 | level | 3 of 4 | - | - | x0.986 | x0.996 | x1.008 |
| blake3-servil-mt / solo / OneMessage / 4 MiB | 0.123 | 0.119 | x0.964 | level | 3 of 4 | - | - | x0.965 | x0.993 | x1.000 |
| blake3-servil-mt / solo / OneMessage / 8 MiB | 0.151 | 0.150 | x0.991 | level | 2 of 4 | - | - | x0.992 | x0.996 | x1.007 |
| blake3-servil-mt / solo / OneMessage / 32 MiB | 0.0798 | 0.0804 | x1.008 | level | 2 of 4 | - | - | x1.007 | x0.991 | x1.014 |
| blake3-servil-mt / solo / OneMessage / 64 MiB | 0.0861 | 0.0907 | x1.053 | level | 3 of 4 | - | - | x1.053 | x1.131 | x1.053 |
| blake3-servil-mt / solo / OneMessage / 128 MiB | 0.0758 | 0.0757 | x0.999 | level | 1 of 4 | - | - | x0.999 | x0.997 | x1.001 |
| blake3-servil-mt / solo / ManyMessages / 1 | 466.522 | 468.042 | x1.003 | level | 2 of 4 | - | - | x1.009 | x1.001 | x1.003 |
| blake3-servil-mt / solo / ManyMessages / 2 | 298.128 | 288.327 | x0.967 | level | 4 of 4 | - | - | x1.013 | x1.004 | x0.975 |
| blake3-servil-mt / solo / ManyMessages / 3 | 209.959 | 213.868 | x1.019 | level | 1 of 4 | - | - | x1.056 | x1.001 | x0.989 |
| blake3-servil-mt / solo / ManyMessages / 4 | 154.849 | 164.516 | x1.062 | level | 0 of 4 | - | - | x1.074 | x1.004 | x0.985 |
| blake3-servil-mt / solo / ManyMessages / 6 | 131.889 | 137.413 | x1.042 | level | 1 of 4 | - | - | x1.037 | x1.005 | x0.999 |
| blake3-servil-mt / solo / ManyMessages / 8 | 120.148 | 112.507 | x0.936 | level | 2 of 4 | - | - | x0.987 | x1.006 | x0.997 |
| blake3-servil-mt / solo / ManyMessages / 12 | 89.246 | 84.846 | x0.951 | level | 3 of 4 | - | - | x0.965 | x1.002 | x1.001 |
| blake3-servil-mt / solo / ManyMessages / 16 | 65.260 | 64.431 | x0.987 | level | 2 of 4 | - | - | x1.000 | x1.004 | x0.994 |
| blake3-servil-mt / solo / ManyMessages / 24 | 48.422 | 48.283 | x0.997 | level | 3 of 4 | - | - | x1.019 | x1.003 | x1.000 |
| blake3-servil-mt / solo / ManyMessages / 32 | 41.053 | 40.043 | x0.975 | level | 3 of 4 | - | - | x0.986 | x1.003 | x0.989 |
| blake3-servil-mt / solo / ManyMessages / 48 | 32.567 | 32.478 | x0.997 | level | 2 of 4 | - | - | x1.003 | x1.001 | x0.995 |
| blake3-servil-mt / solo / ManyMessages / 64 | 28.846 | 29.377 | x1.018 | level | 2 of 4 | - | - | x1.002 | x1.001 | x0.980 |
| blake3-servil-mt / solo / ManyMessages / 128 | 23.675 | 24.267 | x1.025 | level | 1 of 4 | - | - | x1.027 | x1.001 | x0.974 |
| blake3-servil-mt / solo / ManyMessages / 256 | 20.921 | 20.861 | x0.997 | level | 2 of 4 | - | - | x0.998 | x1.001 | x0.980 |
| blake3-servil-mt / solo / ManyMessages / 512 | 19.386 | 19.060 | x0.983 | level | 3 of 4 | - | - | x0.985 | x1.000 | x1.012 |
| blake3-servil-mt / solo / ManyMessages / 1024 | 18.817 | 18.418 | x0.979 | level | 3 of 4 | - | - | x0.991 | x1.000 | x0.975 |
| blake3-servil-mt / solo / ManyMessages / 2048 | 18.432 | 18.280 | x0.992 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.000 |
| blake3-servil-mt / solo / ManyMessages / 4096 | 18.029 | 17.834 | x0.989 | level | 3 of 4 | - | - | x0.993 | x1.000 | x1.009 |
| blake3-servil-mt / solo / ManyMessages / 8192 | 10.099 | 9.841 | x0.974 | level | 3 of 4 | - | - | x0.966 | x0.953 | x1.009 |
| blake3-servil-mt / solo / ManyMessages / 16384 | 9.059 | 9.250 | x1.021 | level | 2 of 4 | - | - | x1.026 | x0.948 | x1.024 |
| blake3-servil-mt / solo / ManyMessages / 32768 | 9.419 | 8.856 | x0.940 | level | 3 of 4 | - | - | x0.942 | x1.064 | x0.965 |
| blake3-servil-mt / solo / ManyMessages / 65536 | 7.780 | 7.497 | x0.964 | level | 4 of 4 | - | - | x0.962 | x0.978 | x1.017 |
| blake3-servil-mt / solo / ManyMessages / 131072 | 9.228 | 9.681 | x1.049 | level | 2 of 4 | - | - | x1.049 | x0.930 | x1.112 |
| blake3-servil-mt / solo / ManyMessages / 262144 | 9.964 | 10.089 | x1.013 | level | 1 of 4 | - | - | x1.013 | x0.987 | x1.018 |
| blake3-servil-mt / solo / ManyLongMessages / 4 | 1782.568 | 1799.928 | x1.010 | level | 1 of 4 | - | - | x1.008 | x1.000 | x1.034 |
| blake3-servil-mt / solo / ManyLongMessages / 16 | 1239.972 | 1221.590 | x0.985 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.996 |
| blake3-servil-mt / solo / ManyLongMessages / 64 | 1191.614 | 1172.520 | x0.984 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.989 |
| blake3-servil-mt / solo / ManyLongMessages / 256 | 658.787 | 660.034 | x1.002 | level | 2 of 4 | - | - | x1.008 | x0.941 | x1.031 |
| blake3-servil-mt / solo / IdleOneMessage / 64 B | 5.447 | 5.314 | x0.976 | level | 3 of 4 | - | - | x0.989 | x0.997 | x0.913 |
| blake3-servil-mt / solo / IdleOneMessage / 128 B | 3.713 | 3.678 | x0.990 | level | 2 of 4 | - | - | x0.992 | x0.996 | x0.967 |
| blake3-servil-mt / solo / IdleOneMessage / 256 B | 2.807 | 2.810 | x1.001 | level | 2 of 4 | - | - | x0.995 | x0.999 | x0.853 |
| blake3-servil-mt / solo / IdleOneMessage / 512 B | 2.404 | 2.362 | x0.983 | level | 3 of 4 | - | - | x0.990 | x0.999 | x0.625 |
| blake3-servil-mt / solo / IdleOneMessage / 1 KiB | 2.184 | 2.148 | x0.983 | level | 4 of 4 | - | - | x1.006 | x1.000 | x0.959 |
| blake3-servil-mt / solo / IdleOneMessage / 1536 B | 1.721 | 1.757 | x1.021 | level | 2 of 4 | - | - | x0.995 | x0.997 | x0.993 |
| blake3-servil-mt / solo / IdleOneMessage / 2 KiB | 1.233 | 1.265 | x1.027 | level | 1 of 4 | - | - | x0.999 | x0.999 | x0.589 |
| blake3-servil-mt / solo / IdleOneMessage / 2304 B | 1.427 | 1.429 | x1.001 | level | 2 of 4 | - | - | x0.994 | x1.000 | x0.558 |
| blake3-servil-mt / solo / IdleOneMessage / 3 KiB | 1.050 | 1.037 | x0.988 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.918 |
| blake3-servil-mt / solo / IdleOneMessage / 3839 B | 1.142 | 1.120 | x0.981 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.957 |
| blake3-servil-mt / solo / IdleOneMessage / 4 KiB | 0.772 | 0.801 | x1.037 | level | 1 of 4 | - | - | x1.005 | x1.000 | x0.988 |
| blake3-servil-mt / solo / IdleOneMessage / 4470 B | 0.932 | 0.930 | x0.997 | level | 2 of 4 | - | - | x0.993 | x1.000 | x0.777 |
| blake3-servil-mt / solo / IdleOneMessage / 7935 B | 0.599 | 0.580 | x0.969 | level | 3 of 4 | - | - | x0.987 | x1.000 | x0.801 |
| blake3-servil-mt / solo / IdleOneMessage / 8 KiB | 0.536 | 0.543 | x1.013 | level | 1 of 4 | - | - | x0.996 | x1.000 | x0.787 |
| blake3-servil-mt / solo / IdleOneMessage / 16 KiB | 0.499 | 0.506 | x1.015 | level | 2 of 4 | - | - | x1.006 | x1.000 | x0.976 |
| blake3-servil-mt / solo / IdleOneMessage / 32 KiB | 0.481 | 0.475 | x0.988 | level | 3 of 4 | - | - | x1.006 | x1.000 | x1.369 |
| blake3-servil-mt / solo / IdleOneMessage / 64 KiB | 0.478 | 0.466 | x0.973 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.989 |
| blake3-servil-mt / solo / IdleOneMessage / 128 KiB | 0.466 | 0.469 | x1.006 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.087 |
| blake3-servil-mt / solo / IdleOneMessage / 256 KiB | 0.477 | 0.475 | x0.997 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.112 |
| blake3-servil-mt / solo / IdleOneMessage / 512 KiB | 0.229 | 0.223 | x0.974 | level | 2 of 4 | - | - | x0.987 | x0.967 | x0.979 |
| blake3-servil-mt / solo / IdleOneMessage / 1 MiB | 0.204 | 0.200 | x0.978 | level | 2 of 4 | - | - | x1.002 | x0.935 | x1.045 |
| blake3-servil-mt / solo / IdleOneMessage / 2 MiB | 0.207 | 0.208 | x1.004 | level | 1 of 4 | - | - | x1.005 | x0.991 | x1.010 |
| blake3-servil-mt / solo / IdleOneMessage / 3 MiB | 0.202 | 0.200 | x0.991 | level | 4 of 4 | - | - | x0.994 | x0.992 | x1.008 |
| blake3-servil-mt / solo / IdleOneMessage / 4 MiB | 0.203 | 0.204 | x1.003 | level | 2 of 4 | - | - | x0.992 | x0.986 | x1.010 |
| blake3-servil-mt / solo / IdleOneMessage / 8 MiB | 0.176 | 0.175 | x0.995 | level | 2 of 4 | - | - | x0.983 | x0.993 | x1.009 |
| blake3-servil-mt / solo / IdleOneMessage / 32 MiB | 0.0735 | 0.0736 | x1.001 | level | 3 of 4 | - | - | x1.013 | x0.998 | x1.012 |
| blake3-servil-mt / solo / IdleOneMessage / 64 MiB | 0.0729 | 0.0730 | x1.001 | level | 2 of 4 | - | - | x1.006 | x1.013 | x1.011 |
| blake3-servil-mt / solo / IdleOneMessage / 128 MiB | 0.0734 | 0.0728 | x0.992 | level | 3 of 4 | - | - | x1.002 | x0.990 | x0.998 |
| blake3-servil-mt / solo / IdleManyMessages / 1 | 378.154 | 386.358 | x1.022 | level | 1 of 4 | - | - | x1.010 | x0.998 | x1.127 |
| blake3-servil-mt / solo / IdleManyMessages / 2 | 199.893 | 196.041 | x0.981 | level | 3 of 4 | - | - | x0.992 | x0.995 | x0.933 |
| blake3-servil-mt / solo / IdleManyMessages / 3 | 174.141 | 177.389 | x1.019 | level | 2 of 4 | - | - | x0.993 | x0.996 | x0.882 |
| blake3-servil-mt / solo / IdleManyMessages / 4 | 109.214 | 113.730 | x1.041 | level | 2 of 4 | - | - | x1.005 | x0.996 | x0.774 |
| blake3-servil-mt / solo / IdleManyMessages / 6 | 93.954 | 92.673 | x0.986 | level | 4 of 4 | - | - | x0.994 | x0.997 | x0.700 |
| blake3-servil-mt / solo / IdleManyMessages / 8 | 69.806 | 67.524 | x0.967 | level | 1 of 4 | - | - | x0.997 | x0.997 | x1.045 |
| blake3-servil-mt / solo / IdleManyMessages / 12 | 60.561 | 59.941 | x0.990 | level | 3 of 4 | - | - | x0.996 | x0.998 | x0.992 |
| blake3-servil-mt / solo / IdleManyMessages / 16 | 50.740 | 52.215 | x1.029 | level | 1 of 4 | - | - | x1.006 | x0.997 | x1.289 |
| blake3-servil-mt / solo / IdleManyMessages / 24 | 43.465 | 47.455 | x1.092 | level | 0 of 4 | - | - | x1.003 | x0.998 | x0.871 |
| blake3-servil-mt / solo / IdleManyMessages / 32 | 40.495 | 39.713 | x0.981 | level | 3 of 4 | - | - | x0.997 | x0.999 | x1.015 |
| blake3-servil-mt / solo / IdleManyMessages / 48 | 36.307 | 36.988 | x1.019 | level | 1 of 4 | - | - | x1.002 | x0.999 | x0.923 |
| blake3-servil-mt / solo / IdleManyMessages / 64 | 35.380 | 33.989 | x0.961 | level | 3 of 4 | - | - | x0.997 | x0.999 | x0.985 |
| blake3-servil-mt / solo / IdleManyMessages / 128 | 31.143 | 32.729 | x1.051 | level | 1 of 4 | - | - | x0.994 | x1.000 | x0.792 |
| blake3-servil-mt / solo / IdleManyMessages / 256 | 29.497 | 28.926 | x0.981 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.459 |
| blake3-servil-mt / solo / IdleManyMessages / 512 | 28.929 | 28.037 | x0.969 | level | 4 of 4 | - | - | x0.993 | x1.000 | x1.226 |
| blake3-servil-mt / solo / IdleManyMessages / 1024 | 29.745 | 28.881 | x0.971 | level | 3 of 4 | - | - | x0.987 | x1.000 | x0.901 |
| blake3-servil-mt / solo / IdleManyMessages / 2048 | 29.552 | 29.183 | x0.988 | level | 2 of 4 | - | - | x0.992 | x1.000 | x1.048 |
| blake3-servil-mt / solo / IdleManyMessages / 4096 | 29.564 | 29.590 | x1.001 | level | 2 of 4 | - | - | x0.995 | x1.000 | x1.056 |
| blake3-servil-mt / solo / IdleManyMessages / 8192 | 13.827 | 12.606 | x0.912 | level | 4 of 4 | - | - | x0.922 | x0.949 | x1.028 |
| blake3-servil-mt / solo / IdleManyMessages / 16384 | 11.847 | 11.906 | x1.005 | level | 2 of 4 | - | - | x0.971 | x0.949 | x1.018 |
| blake3-servil-mt / solo / IdleManyMessages / 32768 | 12.219 | 11.390 | x0.932 | level | 2 of 4 | - | - | x0.940 | x1.047 | x0.941 |
| blake3-servil-mt / solo / IdleManyMessages / 65536 | 10.188 | 9.866 | x0.968 | level | 2 of 4 | - | - | x0.967 | x0.988 | x1.032 |
| blake3-servil-mt / solo / IdleManyMessages / 131072 | 10.323 | 10.968 | x1.062 | level | 1 of 4 | - | - | x1.046 | x0.925 | x1.111 |
| blake3-servil-mt / solo / IdleManyMessages / 262144 | 9.363 | 9.521 | x1.017 | level | 1 of 4 | - | - | x1.004 | x1.002 | x1.005 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 B | 2.560 | 2.446 | x0.956 | level | 4 of 4 | - | - | x1.000 | x0.993 | x0.880 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 B | 1.713 | 1.706 | x0.996 | level | 3 of 4 | - | - | x1.002 | x0.996 | x0.840 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 B | 1.318 | 1.317 | x0.999 | level | 3 of 4 | - | - | x1.003 | x0.998 | x0.911 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 B | 1.130 | 1.128 | x0.998 | level | 3 of 4 | - | - | x1.001 | x0.999 | x0.998 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 KiB | 1.031 | 1.030 | x1.000 | level | 2 of 4 | - | - | x1.000 | x0.999 | x1.022 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1536 B | 0.807 | 0.801 | x0.993 | level | 4 of 4 | - | - | x0.996 | x0.997 | x0.893 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 KiB | 0.574 | 0.572 | x0.998 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.624 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2304 B | 0.652 | 0.652 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.009 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 KiB | 0.475 | 0.476 | x1.003 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.793 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3839 B | 0.499 | 0.500 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.186 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 KiB | 0.413 | 0.354 | x0.857 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.830 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4470 B | 0.427 | 0.427 | x1.000 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.184 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 7935 B | 0.270 | 0.277 | x1.027 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.581 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 KiB | 0.247 | 0.251 | x1.016 | level | 0 of 4 | - | - | x1.000 | x1.000 | x0.775 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 16 KiB | 0.230 | 0.238 | x1.036 | level | 1 of 4 | - | - | x1.008 | x1.000 | x1.061 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 KiB | 0.222 | 0.223 | x1.007 | level | 1 of 4 | - | - | x1.006 | x1.000 | x1.931 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 KiB | 0.220 | 0.219 | x0.996 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.901 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 KiB | 0.221 | 0.221 | x1.002 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.989 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 KiB | 0.225 | 0.224 | x0.996 | level | 2 of 4 | - | - | x0.995 | x1.000 | x0.960 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 KiB | 0.130 | 0.130 | x1.003 | level | 3 of 4 | - | - | x1.001 | x0.994 | x0.987 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 MiB | 0.1000 | 0.107 | x1.067 | level | 2 of 4 | - | - | x1.072 | x0.958 | x1.020 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 MiB | 0.116 | 0.114 | x0.984 | level | 3 of 4 | - | - | x0.989 | x0.976 | x1.008 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 MiB | 0.113 | 0.113 | x1.000 | level | 2 of 4 | - | - | x1.002 | x0.994 | x1.002 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 MiB | 0.108 | 0.109 | x1.010 | level | 2 of 4 | - | - | x1.011 | x0.992 | x1.005 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 MiB | 0.116 | 0.114 | x0.984 | level | 3 of 4 | - | - | x0.987 | x0.998 | x0.997 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 MiB | 0.0604 | 0.0608 | x1.006 | level | 2 of 4 | - | - | x1.007 | x0.998 | x1.022 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 MiB | 0.0673 | 0.0684 | x1.016 | level | 2 of 4 | - | - | x1.016 | x1.034 | x1.020 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 MiB | 0.0681 | 0.0680 | x0.998 | level | 2 of 4 | - | - | x0.997 | x0.993 | x1.003 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1 | 170.316 | 170.417 | x1.001 | level | 2 of 4 | - | - | x1.004 | x0.997 | x0.891 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2 | 90.378 | 89.429 | x0.990 | level | 3 of 4 | - | - | x0.994 | x0.996 | x0.713 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 3 | 77.976 | 78.222 | x1.003 | level | 2 of 4 | - | - | x1.000 | x0.996 | x0.736 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4 | 49.016 | 49.353 | x1.007 | level | 1 of 4 | - | - | x1.003 | x0.996 | x0.927 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 6 | 45.309 | 53.124 | x1.172 | level | 2 of 4 | - | - | x1.003 | x0.997 | x0.666 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8 | 30.669 | 30.392 | x0.991 | level | 2 of 4 | - | - | x0.998 | x0.997 | x1.586 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 12 | 27.248 | 27.321 | x1.003 | level | 1 of 4 | - | - | x1.004 | x0.998 | x1.450 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16 | 23.386 | 23.450 | x1.003 | level | 1 of 4 | - | - | x1.003 | x0.998 | x4.303 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 24 | 20.133 | 20.670 | x1.027 | level | 1 of 4 | - | - | x1.003 | x0.998 | x1.549 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32 | 18.588 | 18.505 | x0.996 | level | 2 of 4 | - | - | x0.996 | x0.999 | x1.522 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 48 | 16.792 | 16.801 | x1.001 | level | 2 of 4 | - | - | x1.000 | x0.999 | x1.440 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 64 | 15.923 | 15.938 | x1.001 | level | 2 of 4 | - | - | x1.004 | x0.999 | x1.172 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 128 | 14.526 | 14.528 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.184 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 256 | 14.167 | 13.990 | x0.987 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.538 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 512 | 13.676 | 13.679 | x1.000 | level | 1 of 4 | - | - | x0.998 | x1.000 | x0.967 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1024 | 13.543 | 13.469 | x0.995 | level | 2 of 4 | - | - | x0.994 | x1.000 | x0.768 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2048 | 13.793 | 13.589 | x0.985 | level | 3 of 4 | - | - | x0.991 | x1.000 | x1.035 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4096 | 14.264 | 14.109 | x0.989 | level | 3 of 4 | - | - | x0.990 | x1.000 | x1.067 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8192 | 7.221 | 6.980 | x0.967 | level | 3 of 4 | - | - | x0.959 | x0.946 | x1.016 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16384 | 6.435 | 6.777 | x1.053 | level | 3 of 4 | - | - | x1.060 | x0.957 | x1.047 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32768 | 6.338 | 6.145 | x0.970 | level | 2 of 4 | - | - | x0.972 | x0.977 | x1.013 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 65536 | 5.086 | 5.013 | x0.986 | level | 3 of 4 | - | - | x0.984 | x0.992 | x1.028 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 131072 | 7.023 | 7.622 | x1.085 | level | 2 of 4 | - | - | x1.082 | x0.929 | x1.122 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 262144 | 7.595 | 7.751 | x1.021 | level | 0 of 4 | - | - | x1.019 | x1.002 | x1.021 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.680 | 0.670 | x0.986 | level | 2 of 4 | x0.793 | - | x0.989 | x0.979 | x0.709 |
| blake3-servil-mt / solo / ContinuousMessages / 128 B | 0.342 | 0.341 | x0.996 | level | 1 of 4 | x0.816 | - | x1.000 | x0.979 | x0.841 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.180 | 0.181 | x1.005 | level | 1 of 4 | x0.960 | - | x1.005 | x0.980 | x1.006 |
| blake3-servil-mt / solo / ContinuousMessages / 512 B | 0.110 | 0.110 | x0.997 | level | 2 of 4 | x1.021 | - | x0.996 | x0.983 | x1.023 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.0779 | 0.0781 | x1.004 | level | 2 of 4 | x0.900 | - | x1.007 | x0.990 | x0.986 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0719 | 0.0707 | x0.983 | level | 2 of 4 | x0.965 | - | x0.986 | x0.999 | x0.919 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0537 | 0.0519 | x0.967 | level | 4 of 4 | x0.977 | - | x0.967 | x1.010 | x1.032 |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.0508 | 0.0530 | x1.042 | level | 1 of 4 | x0.954 | - | x1.043 | x1.010 | x0.922 |
| blake3-servil-mt / solo / ContinuousMessages / 256 KiB | 0.0473 | 0.0473 | x0.999 | level | 2 of 4 | x0.983 | - | x0.995 | x1.009 | x1.020 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0464 | 0.0457 | x0.984 | level | 2 of 4 | x0.984 | - | x0.984 | x1.010 | x1.073 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.0440 | 0.0424 | x0.963 | level | 3 of 4 | x1.003 | - | x0.962 | x1.008 | x1.056 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0452 | 0.0427 | x0.945 | level | 3 of 4 | x1.010 | - | x0.948 | x1.009 | x1.110 |
| blake3-servil-mt / solo / ContinuousMessages / 64 MiB | 0.0598 | 0.0601 | x1.006 | level | 1 of 4 | x1.007 | - | x1.006 | x1.009 | x1.011 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 6.156 | 6.114 | x0.993 | level | 2 of 4 | x0.987 | - | x0.991 | x0.980 | x0.986 |
| blake3-servil-mt / solo / ContinuousBatches / 64 | 3.934 | 3.885 | x0.988 | level | 2 of 4 | x0.996 | - | x0.987 | x0.990 | x0.988 |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 3.380 | 3.311 | x0.980 | level | 2 of 4 | x0.990 | - | x0.978 | x0.995 | x1.046 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 3.517 | 3.393 | x0.965 | level | 3 of 4 | x0.978 | - | x0.962 | x0.981 | x1.085 |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 4.063 | 4.077 | x1.004 | level | 1 of 4 | x1.023 | - | x1.005 | x1.008 | x0.978 |
| blake3-servil-mt / solo / ContinuousBatches / 16384 | 4.206 | 4.269 | x1.015 | level | 1 of 4 | x1.033 | - | x1.014 | x1.010 | x1.085 |
| blake3-servil-mt / solo / ContinuousBatches / 65536 | 3.387 | 3.251 | x0.960 | level | 2 of 4 | x0.920 | - | x0.960 | x1.007 | x0.968 |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.953 | 0.950 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x1.000 | x1.163 |
| blake3-servil-mt / solo / LentMessages / 128 B | 0.955 | 0.956 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x1.221 |
| blake3-servil-mt / solo / LentMessages / 256 B | 0.938 | 0.935 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x1.465 |
| blake3-servil-mt / solo / LentMessages / 512 B | 0.932 | 0.932 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x1.345 |
| blake3-servil-mt / solo / LentMessages / 1 KiB | 0.929 | 0.928 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.743 |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.317 | 0.317 | x1.001 | level | 1 of 4 | x1.002 | - | x1.001 | x1.000 | x1.475 |
| blake3-servil-mt / solo / LentMessages / 16 KiB | 0.215 | 0.217 | x1.010 | level | 0 of 4 | x1.010 | - | x1.008 | x1.000 | x1.236 |
| blake3-servil-mt / solo / LentMessages / 64 KiB | 0.217 | 0.217 | x1.004 | level | 1 of 4 | x1.004 | - | x1.004 | x1.000 | x1.427 |
| blake3-servil-mt / solo / LentMessages / 256 KiB | 0.220 | 0.220 | x0.998 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x1.022 |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.0798 | 0.0784 | x0.982 | level | 3 of 4 | x0.961 | - | x0.977 | x0.995 | x1.006 |
| blake3-servil-mt / solo / LentMessages / 4 MiB | 0.0648 | 0.0652 | x1.005 | level | 1 of 4 | x1.075 | - | x1.000 | x1.011 | x0.986 |
| blake3-servil-mt / solo / LentMessages / 16 MiB | 0.0930 | 0.0938 | x1.009 | level | 1 of 4 | x1.028 | - | x1.006 | x0.993 | x0.993 |
| blake3-servil-mt / solo / LentMessages / 64 MiB | 0.0807 | 0.0817 | x1.012 | level | 1 of 4 | x0.999 | - | x1.013 | x1.002 | x1.010 |
| blake3-servil-mt / solo / Interleaved / 256 | 0.260 | 0.262 | x1.006 | level | 1 of 4 | x1.006 | - | x1.007 | x1.005 | x0.971 |
| blake3-servil-mt / solo / Collection / git objects | 0.0140 | 0.0140 | x1.000 | level | 2 of 4 | x1.018 | - | x1.014 | x1.006 | x1.008 |
| blake3-servil-mt / solo / Collection / Nix files | 0.0208 | 0.0208 | x1.001 | level | 2 of 4 | x1.005 | - | x1.002 | x1.000 | x1.004 |
| blake3-servil-mt / solo / LentBatches / 16 | 16.257 | 16.413 | x1.010 | level | 2 of 4 | x1.010 | - | x1.008 | x0.999 | x1.003 |
| blake3-servil-mt / solo / LentBatches / 64 | 13.720 | 13.764 | x1.003 | level | 2 of 4 | x1.003 | - | x1.003 | x1.000 | x1.031 |
| blake3-servil-mt / solo / LentBatches / 256 | 13.683 | 13.687 | x1.000 | level | 3 of 4 | x1.000 | - | x1.001 | x1.000 | x1.149 |
| blake3-servil-mt / solo / LentBatches / 1024 | 13.884 | 13.921 | x1.003 | level | 2 of 4 | x1.002 | - | x1.003 | x1.000 | x1.026 |
| blake3-servil-mt / solo / LentBatches / 4096 | 14.472 | 14.488 | x1.001 | level | 2 of 4 | x1.001 | - | x1.000 | x1.000 | x1.029 |
| blake3-servil-mt / solo / LentBatches / 16384 | 5.421 | 5.341 | x0.985 | level | 4 of 4 | x0.943 | - | x0.980 | x0.997 | x1.009 |
| blake3-servil-mt / solo / LentBatches / 65536 | 4.707 | 4.978 | x1.058 | level | 2 of 4 | x1.171 | - | x1.044 | x0.999 | x1.007 |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.0636 | 0.0644 | x1.012 | level | 1 of 4 | x1.004 | - | x1.017 | x1.004 | x1.002 |
| blake3-servil-mt / solo / ContinuousCollection / Nix files | 0.0636 | 0.0657 | x1.033 | level | 1 of 4 | x1.014 | - | x1.034 | x1.004 | x0.936 |
| blake3-servil-mt / solo / MerkleTree / 1024 | 0.261 | 0.262 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | x1.032 |
| blake3-servil-mt / solo / MerkleTree / 4096 | 0.129 | 0.130 | x1.007 | level | 2 of 4 | x1.026 | - | x1.007 | x1.000 | x1.013 |
| blake3-servil-mt / solo / MerkleTree / 16384 | 0.141 | 0.142 | x1.004 | level | 2 of 4 | x1.065 | - | x1.006 | x0.985 | x1.176 |
| blake3-servil-mt / solo / MerkleTree / 65536 | 0.150 | 0.150 | x1.004 | level | 1 of 4 | x1.053 | - | x1.004 | x0.989 | x0.969 |
| blake3-servil-mt / solo / MerkleTree / 262144 | 0.350 | 0.345 | x0.986 | level | 2 of 4 | x0.996 | - | x0.986 | x1.006 | x0.991 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 32 B | 0.250 | 0.259 | x1.035 | level | 1 of 4 | x1.182 | - | x1.038 | x0.946 | x1.139 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 32 B | 0.434 | 0.432 | x0.994 | level | 2 of 4 | x0.980 | - | x0.994 | x1.030 | x1.021 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 16 B | 0.350 | 0.343 | x0.980 | level | 3 of 4 | x0.978 | - | x0.984 | x0.998 | x1.001 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 48 B | 0.186 | 0.182 | x0.979 | level | 2 of 4 | x0.975 | - | x0.977 | x1.037 | x1.089 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 48 B | 0.395 | 0.396 | x1.003 | level | 2 of 4 | x1.002 | - | x1.003 | x1.006 | x0.996 |
| blake3-servil-mt / solo / InterleavedTurn / 256 | 0.780 | 0.802 | x1.028 | level | 1 of 4 | - | - | x0.971 | x0.901 | x0.991 |
| blake3-servil-mt / solo / InterleavedTurn / 1024 x 1 KiB | 0.345 | 0.325 | x0.942 | level | 3 of 4 | - | - | x0.970 | x0.982 | x1.001 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 256 | 0.772 | 0.741 | x0.960 | level | 2 of 4 | - | - | x0.942 | x0.900 | x0.960 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.486 | 0.478 | x0.983 | level | 3 of 4 | - | - | x0.973 | x0.981 | x1.005 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 256 | 0.555 | 0.542 | x0.977 | level | 4 of 4 | - | - | x0.955 | x0.839 | x0.969 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.297 | 0.289 | x0.974 | level | 2 of 4 | - | - | x0.977 | x0.994 | x0.986 |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.0474 | 0.0474 | x1.000 | level | 2 of 4 | x0.989 | - | x0.997 | x1.006 | x0.996 |
| blake3-servil-mt / solo / ReceivingMessage / 2 μs | 0.0929 | 0.0929 | x1.001 | level | 0 of 4 | x1.021 | - | x1.050 | x1.003 | x0.966 |
| blake3-servil-mt / solo / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 4 of 4 | x1.078 | - | x0.975 | x0.951 | x0.980 |
| blake3-servil-mt / solo / IncrementalMessage / 64 B | 7.984 | 7.844 | x0.983 | level | 2 of 4 | - | - | x1.009 | x1.000 | x0.944 |
| blake3-servil-mt / solo / IncrementalMessage / 1 KiB | 1.558 | 1.524 | x0.978 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.979 |
| blake3-servil-mt / solo / IncrementalMessage / 4 KiB | 0.736 | 0.781 | x1.060 | level | 2 of 4 | - | - | x1.000 | x1.001 | x1.015 |
| blake3-servil-mt / solo / LentIncrementalMessage / 64 B | 1.274 | 1.273 | x0.999 | level | 3 of 4 | x0.999 | - | x0.998 | x1.000 | x1.038 |
| blake3-servil-mt / solo / LentIncrementalMessage / 1 KiB | 0.951 | 0.952 | x1.002 | level | 1 of 4 | x1.002 | - | x1.001 | x1.000 | x1.068 |
| blake3-servil-mt / solo / LentIncrementalMessage / 4 KiB | 0.331 | 0.329 | x0.994 | level | 3 of 4 | x0.993 | - | x0.999 | x1.000 | x0.815 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 5.328 | 5.135 | x0.964 | level | 2 of 4 | x0.974 | - | x0.966 | x0.997 | x1.093 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 4 KiB | 0.149 | 0.129 | x0.864 | level | 3 of 4 | x0.865 | - | x0.863 | x1.003 | x1.064 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 1 MiB | 0.0495 | 0.0446 | x0.900 | level | 4 of 4 | x1.039 | - | x0.898 | x1.009 | x1.363 |
| blake3-servil-mt / solo / ContinuousLentMessages / 64 B | 0.598 | 0.601 | x1.006 | level | 2 of 4 | x0.614 | - | x1.012 | x0.976 | x0.796 |
| blake3-servil-mt / solo / ContinuousLentMessages / 4 KiB | 0.0379 | 0.0385 | x1.017 | level | 2 of 4 | x0.976 | - | x1.010 | x0.994 | x0.905 |
| blake3-servil-mt / solo / ContinuousLentMessages / 1 MiB | 0.00870 | 0.00877 | x1.009 | level | 2 of 4 | x1.001 | - | x1.011 | x1.004 | x0.882 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.652 | 0.688 | x1.055 | level | 0 of 4 | - | - | x1.055 | x0.979 | x0.981 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 128 B | 0.331 | 0.358 | x1.081 | level | 0 of 4 | - | - | x1.078 | x0.979 | x1.141 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.186 | 0.192 | x1.033 | level | 1 of 4 | - | - | x1.028 | x0.980 | x1.158 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 512 B | 0.124 | 0.127 | x1.018 | level | 2 of 4 | - | - | x1.018 | x0.983 | x0.976 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.0967 | 0.0984 | x1.018 | level | 1 of 4 | - | - | x1.012 | x0.992 | x0.985 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.118 | 0.113 | x0.960 | level | 4 of 4 | - | - | x0.994 | x0.994 | x0.921 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.0909 | 0.0885 | x0.974 | level | 2 of 4 | - | - | x0.999 | x1.005 | x0.997 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.0749 | 0.0754 | x1.006 | level | 1 of 4 | - | - | x1.007 | x1.008 | x1.011 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 KiB | 0.0746 | 0.0744 | x0.997 | level | 2 of 4 | - | - | x0.991 | x1.014 | x1.012 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0747 | 0.0745 | x0.996 | level | 1 of 4 | - | - | x1.000 | x1.010 | x1.007 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.0782 | 0.0779 | x0.997 | level | 1 of 4 | - | - | x1.014 | x1.004 | x1.017 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.0750 | 0.0761 | x1.014 | level | 1 of 4 | - | - | x1.015 | x1.006 | x1.037 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 MiB | 0.0762 | 0.0772 | x1.012 | level | 1 of 4 | - | - | x1.019 | x1.007 | x0.993 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 7.510 | 7.309 | x0.973 | level | 3 of 4 | - | - | x0.973 | x0.975 | x0.992 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 64 | 5.638 | 5.408 | x0.959 | level | 4 of 4 | - | - | x0.969 | x0.975 | x1.033 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 256 | 5.291 | 5.478 | x1.035 | level | 1 of 4 | - | - | x1.012 | x0.997 | x0.990 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 4.994 | 4.924 | x0.986 | level | 1 of 4 | - | - | x1.005 | x0.969 | x1.101 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 4096 | 5.794 | 5.056 | x0.873 | level | 3 of 4 | - | - | x0.884 | x1.007 | x0.975 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16384 | 4.934 | 4.710 | x0.955 | level | 4 of 4 | - | - | x0.949 | x1.067 | x0.930 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 65536 | 7.891 | 6.334 | x0.803 | level | 3 of 4 | - | - | x0.799 | x1.200 | x0.696 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.950 | 0.948 | x0.998 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.797 |
| blake3-servil-mt / shared-one-cache / LentMessages / 128 B | 0.951 | 0.951 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.033 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 B | 0.933 | 0.932 | x0.998 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.952 |
| blake3-servil-mt / shared-one-cache / LentMessages / 512 B | 0.929 | 0.929 | x1.000 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.730 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 KiB | 0.926 | 0.926 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.048 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.318 | 0.316 | x0.996 | level | 4 of 4 | - | - | x0.996 | x1.000 | x1.100 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 KiB | 0.215 | 0.216 | x1.002 | level | 0 of 4 | - | - | x1.002 | x1.000 | x0.899 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 KiB | 0.217 | 0.217 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.036 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 KiB | 0.220 | 0.219 | x0.998 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.878 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 MiB | 0.0969 | 0.0981 | x1.013 | level | 3 of 4 | - | - | x1.012 | x0.972 | x0.962 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 MiB | 0.0762 | 0.0749 | x0.983 | level | 2 of 4 | - | - | x0.977 | x0.979 | x0.879 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 MiB | 0.140 | 0.138 | x0.982 | level | 2 of 4 | - | - | x0.980 | x1.015 | x0.966 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 MiB | 0.110 | 0.112 | x1.020 | level | 0 of 4 | - | - | x1.019 | x1.019 | x1.036 |
| blake3-servil-mt / shared-one-cache / Interleaved / 256 | 0.266 | 0.265 | x0.997 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.970 |
| blake3-servil-mt / shared-one-cache / Collection / git objects | 0.0300 | 0.0294 | x0.979 | level | 2 of 4 | - | - | x0.923 | x0.931 | x0.925 |
| blake3-servil-mt / shared-one-cache / Collection / Nix files | 0.0352 | 0.0341 | x0.967 | level | 1 of 4 | - | - | x0.983 | x0.956 | x0.961 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16 | 16.169 | 16.194 | x1.001 | level | 2 of 4 | - | - | x1.001 | x0.999 | x1.006 |
| blake3-servil-mt / shared-one-cache / LentBatches / 64 | 13.732 | 13.753 | x1.002 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.066 |
| blake3-servil-mt / shared-one-cache / LentBatches / 256 | 13.658 | 13.597 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.962 |
| blake3-servil-mt / shared-one-cache / LentBatches / 1024 | 13.784 | 13.814 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.000 |
| blake3-servil-mt / shared-one-cache / LentBatches / 4096 | 14.420 | 14.485 | x1.004 | level | 1 of 4 | - | - | x1.004 | x1.000 | x0.970 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16384 | 6.528 | 6.311 | x0.967 | level | 3 of 4 | - | - | x0.971 | x0.964 | x1.012 |
| blake3-servil-mt / shared-one-cache / LentBatches / 65536 | 6.998 | 7.020 | x1.003 | level | 2 of 4 | - | - | x1.008 | x0.952 | x1.125 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.0927 | 0.0924 | x0.996 | level | 3 of 4 | - | - | x1.004 | x1.007 | x0.945 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / Nix files | 0.0925 | 0.0921 | x0.995 | level | 4 of 4 | - | - | x1.002 | x1.001 | x0.966 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1024 | 0.263 | 0.262 | x0.997 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.023 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 4096 | 0.147 | 0.149 | x1.016 | level | 2 of 4 | - | - | x1.012 | x1.004 | x1.073 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 16384 | 0.169 | 0.161 | x0.951 | level | 4 of 4 | - | - | x0.950 | x1.001 | x1.005 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 | 0.231 | 0.237 | x1.024 | level | 2 of 4 | - | - | x1.027 | x0.974 | x1.036 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 262144 | 0.349 | 0.347 | x0.995 | level | 3 of 4 | - | - | x0.994 | x0.981 | x0.991 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 32 B | 0.366 | 0.369 | x1.006 | level | 1 of 4 | - | - | x1.003 | x0.981 | x0.966 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 32 B | 0.516 | 0.521 | x1.010 | level | 2 of 4 | - | - | x1.007 | x1.023 | x1.000 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 16 B | 0.584 | 0.586 | x1.004 | level | 1 of 4 | - | - | x1.021 | x1.021 | x1.032 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 48 B | 0.292 | 0.304 | x1.042 | level | 0 of 4 | - | - | x1.042 | x0.922 | x1.037 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 48 B | 0.435 | 0.436 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.006 | x0.993 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.0785 | 0.0783 | x0.997 | level | 3 of 4 | - | - | x0.997 | x0.998 | x1.007 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 2 μs | 0.0956 | 0.0954 | x0.998 | level | 2 of 4 | - | - | x0.995 | x1.004 | x0.991 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 4 of 4 | - | - | x0.974 | x0.991 | x0.954 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 64 B | 1.272 | 1.271 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x3.312 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 1 KiB | 0.950 | 0.949 | x0.999 | level | 4 of 4 | - | - | x0.999 | x1.000 | x0.934 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 4 KiB | 0.328 | 0.328 | x1.002 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.141 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 16.547 | 14.931 | x0.902 | level | 3 of 4 | - | - | x0.907 | x0.989 | x0.974 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 4 KiB | 0.261 | 0.250 | x0.958 | level | 2 of 4 | - | - | x1.099 | x0.996 | x0.976 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 1 MiB | 0.0770 | 0.0773 | x1.003 | level | 2 of 4 | - | - | x0.999 | x1.016 | x1.065 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 64 B | 0.598 | 0.595 | x0.996 | level | 2 of 4 | - | - | x0.997 | x0.976 | x0.977 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 4 KiB | 0.0818 | 0.0704 | x0.861 | level | 3 of 4 | - | - | x0.952 | x0.980 | x0.872 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 1 MiB | 0.0164 | 0.0181 | x1.103 | level | 1 of 4 | - | - | x1.050 | x1.053 | x0.968 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 B | 1.336 | 0.933 | x0.698 | level | 4 of 4 | - | - | x0.697 | x0.978 | x0.962 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 128 B | 0.635 | 0.568 | x0.895 | level | 3 of 4 | - | - | x0.886 | x0.979 | x1.162 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 256 B | 0.380 | 0.422 | x1.110 | level | 0 of 4 | - | - | x1.089 | x0.979 | x1.423 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 512 B | 0.215 | 0.171 | x0.795 | level | 4 of 4 | - | - | x0.792 | x0.982 | x1.141 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 KiB | 0.159 | 0.136 | x0.855 | level | 4 of 4 | - | - | x0.854 | x0.990 | x0.925 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 4 KiB | 0.113 | 0.108 | x0.956 | level | 3 of 4 | - | - | x0.958 | x1.000 | x0.942 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 16 KiB | 0.0882 | 0.0857 | x0.972 | level | 3 of 4 | - | - | x0.971 | x1.009 | x1.075 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 KiB | 0.0917 | 0.0949 | x1.035 | level | 2 of 4 | - | - | x1.020 | x1.011 | x0.897 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 256 KiB | 0.0918 | 0.0968 | x1.055 | level | 1 of 4 | - | - | x1.042 | x1.007 | x0.931 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 MiB | 0.0918 | 0.0969 | x1.056 | level | 1 of 4 | - | - | x1.039 | x1.009 | x0.927 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 4 MiB | 0.0908 | 0.0896 | x0.987 | level | 3 of 4 | - | - | x0.973 | x1.011 | x1.030 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 16 MiB | 0.0938 | 0.0917 | x0.977 | level | 2 of 4 | - | - | x0.963 | x1.011 | x1.040 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 MiB | 0.111 | 0.116 | x1.051 | level | 0 of 4 | - | - | x1.042 | x1.011 | x0.824 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 16 | 14.116 | 13.615 | x0.964 | level | 4 of 4 | - | - | x0.961 | x0.978 | x0.977 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 64 | 9.343 | 9.184 | x0.983 | level | 1 of 4 | - | - | x0.969 | x0.990 | x0.943 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 256 | 8.016 | 8.088 | x1.009 | level | 1 of 4 | - | - | x0.994 | x0.999 | x0.815 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 1024 | 7.589 | 7.446 | x0.981 | level | 2 of 4 | - | - | x0.965 | x0.982 | x0.901 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 4096 | 8.523 | 8.300 | x0.974 | level | 3 of 4 | - | - | x0.974 | x1.003 | x1.142 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 16384 | 8.154 | 7.927 | x0.972 | level | 4 of 4 | - | - | x0.972 | x1.004 | x1.021 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 65536 | 6.254 | 5.816 | x0.930 | level | 3 of 4 | - | - | x0.930 | x1.045 | x0.870 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 B | 0.950 | 0.952 | x1.002 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.138 |
| blake3-servil-mt / shared-two-caches / LentMessages / 128 B | 0.954 | 0.954 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.959 |
| blake3-servil-mt / shared-two-caches / LentMessages / 256 B | 0.934 | 0.933 | x0.998 | level | 4 of 4 | - | - | x1.000 | x1.000 | x0.968 |
| blake3-servil-mt / shared-two-caches / LentMessages / 512 B | 0.931 | 0.930 | x0.999 | level | 4 of 4 | - | - | x0.999 | x1.000 | x0.892 |
| blake3-servil-mt / shared-two-caches / LentMessages / 1 KiB | 0.927 | 0.927 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.676 |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 KiB | 0.318 | 0.317 | x0.996 | level | 4 of 4 | - | - | x0.996 | x1.000 | x0.865 |
| blake3-servil-mt / shared-two-caches / LentMessages / 16 KiB | 0.216 | 0.216 | x1.002 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.804 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 KiB | 0.217 | 0.217 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.884 |
| blake3-servil-mt / shared-two-caches / LentMessages / 256 KiB | 0.220 | 0.219 | x0.996 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.953 |
| blake3-servil-mt / shared-two-caches / LentMessages / 1 MiB | 0.107 | 0.107 | x1.002 | level | 2 of 4 | - | - | x1.006 | x1.004 | x0.997 |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 MiB | 0.0838 | 0.0903 | x1.076 | level | 0 of 4 | - | - | x1.073 | x1.001 | x1.007 |
| blake3-servil-mt / shared-two-caches / LentMessages / 16 MiB | 0.0969 | 0.0978 | x1.010 | level | 2 of 4 | - | - | x1.009 | x1.005 | x0.948 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 MiB | 0.0835 | 0.0844 | x1.011 | level | 1 of 4 | - | - | x1.008 | x1.044 | x1.035 |
| blake3-servil-mt / shared-two-caches / Interleaved / 256 | 0.257 | 0.256 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.964 |
| blake3-servil-mt / shared-two-caches / Collection / git objects | 0.0301 | 0.0286 | x0.949 | level | 4 of 4 | - | - | x0.995 | x0.991 | x0.990 |
| blake3-servil-mt / shared-two-caches / Collection / Nix files | 0.0324 | 0.0321 | x0.990 | level | 3 of 4 | - | - | x1.019 | x1.035 | x1.069 |
| blake3-servil-mt / shared-two-caches / LentBatches / 16 | 16.190 | 16.235 | x1.003 | level | 2 of 4 | - | - | x1.002 | x0.999 | x0.950 |
| blake3-servil-mt / shared-two-caches / LentBatches / 64 | 13.752 | 13.756 | x1.000 | level | 3 of 4 | - | - | x1.001 | x1.000 | x0.983 |
| blake3-servil-mt / shared-two-caches / LentBatches / 256 | 13.669 | 13.607 | x0.995 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.884 |
| blake3-servil-mt / shared-two-caches / LentBatches / 1024 | 13.798 | 13.829 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.002 |
| blake3-servil-mt / shared-two-caches / LentBatches / 4096 | 14.439 | 14.423 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.994 |
| blake3-servil-mt / shared-two-caches / LentBatches / 16384 | 7.634 | 7.539 | x0.988 | level | 3 of 4 | - | - | x0.992 | x1.002 | x1.029 |
| blake3-servil-mt / shared-two-caches / LentBatches / 65536 | 6.057 | 6.383 | x1.054 | level | 1 of 4 | - | - | x1.053 | x1.007 | x0.931 |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / git objects | 0.105 | 0.105 | x1.003 | level | 3 of 4 | - | - | x1.001 | x1.005 | x0.994 |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / Nix files | 0.108 | 0.107 | x0.994 | level | 2 of 4 | - | - | x0.991 | x1.004 | x0.996 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1024 | 0.261 | 0.261 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.017 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 4096 | 0.138 | 0.141 | x1.027 | level | 1 of 4 | - | - | x1.027 | x0.992 | x1.003 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 16384 | 0.135 | 0.146 | x1.083 | level | 1 of 4 | - | - | x1.085 | x0.973 | x1.257 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 | 0.178 | 0.180 | x1.009 | level | 2 of 4 | - | - | x1.009 | x0.979 | x0.956 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 262144 | 0.344 | 0.344 | x1.001 | level | 1 of 4 | - | - | x1.001 | x0.984 | x0.999 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 x 32 B | 0.356 | 0.357 | x1.003 | level | 1 of 4 | - | - | x1.002 | x0.993 | x0.987 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 32 B | 0.495 | 0.513 | x1.036 | level | 0 of 4 | - | - | x1.031 | x1.072 | x1.012 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 16 B | 0.529 | 0.527 | x0.996 | level | 2 of 4 | - | - | x1.011 | x1.006 | x0.998 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 x 48 B | 0.274 | 0.284 | x1.035 | level | 0 of 4 | - | - | x1.036 | x0.947 | x1.018 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 48 B | 0.437 | 0.436 | x0.998 | level | 3 of 4 | - | - | x1.002 | x0.906 | x0.986 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / saturated | 0.0945 | 0.103 | x1.094 | level | 0 of 4 | - | - | x1.079 | x1.015 | x0.903 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / 2 μs | 0.107 | 0.107 | x1.000 | level | 2 of 4 | - | - | x1.087 | x1.004 | x0.923 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 4 of 4 | - | - | x0.712 | x0.957 | x0.771 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 64 B | 1.274 | 1.272 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x2.787 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 1 KiB | 0.951 | 0.950 | x0.998 | level | 4 of 4 | - | - | x0.998 | x1.000 | x0.984 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 4 KiB | 0.328 | 0.329 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.996 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 64 B | 16.790 | 15.803 | x0.941 | level | 4 of 4 | - | - | x0.943 | x0.993 | x1.018 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 4 KiB | 0.237 | 0.227 | x0.959 | level | 4 of 4 | - | - | x0.965 | x1.001 | x0.904 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 1 MiB | 0.0929 | 0.0906 | x0.976 | level | 3 of 4 | - | - | x0.961 | x1.010 | x1.050 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 64 B | 0.652 | 0.662 | x1.015 | level | 1 of 4 | - | - | x1.013 | x0.976 | x0.941 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 4 KiB | 0.0677 | 0.0661 | x0.977 | level | 3 of 4 | - | - | x0.971 | x0.989 | x0.879 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 1 MiB | 0.0168 | 0.0182 | x1.079 | level | 1 of 4 | - | - | x1.229 | x1.235 | x1.262 |

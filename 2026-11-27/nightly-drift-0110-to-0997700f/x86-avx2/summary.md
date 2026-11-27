# Nightly drift check: e1966b498bc7 -> 0997700f35b0

- Host: bench-zen3
- Experiment: `bench=3f119a507807078649d8700112994fce24666868|base=e1966b498bc769db3d51451a4ddc8188a19ed593|target=0997700f35b06db27b70dc4659964561ae500038|cells=all|layouts=default`
- bench-hashes: `3f119a507807078649d8700112994fce24666868`
- BLAKE3-Servil base: `e1966b498bc769db3d51451a4ddc8188a19ed593`
- BLAKE3-Servil target: `0997700f35b06db27b70dc4659964561ae500038`
- Scope: `--cells all` (layouts: default)
- Deciding stage: stage 2 (kept-drift/second)
- Verdict: **no regression** (exit `0`)

## Stage 2 (deciding, kept-drift/second)

compare: old side: bench 3f119a507807 clean; servil e1966b498bc7 clean
compare: new side: bench 3f119a507807 clean; servil 0997700f35b0 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / BriefIdleManyMessages / 1 | 171.469 | 176.834 | x1.031 | level | 10 of 64 | - | - | x1.011 | x1.007 | x1.108 |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.903 | 0.942 | x1.043 | level | 3 of 64 | x1.043 | - | x1.042 | x1.011 | x0.919 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 0.874 | 0.893 | x1.021 | level | 2 of 64 | x1.021 | - | x1.020 | x1.011 | x1.032 |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 0.841 | 0.835 | x0.993 | level | 55 of 64 | x0.993 | - | x0.993 | x1.012 | x0.866 |
| blake3-servil-mt / solo / IdleOneMessage / 2 KiB | 1.251 | 1.247 | x0.997 | level | 29 of 64 | - | - | x1.001 | x1.000 | x0.945 |
| blake3-servil-mt / solo / IdleManyMessages / 4 | 110.291 | 110.201 | x0.999 | level | 30 of 64 | - | - | x1.003 | x0.997 | x0.940 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 6.146 | 5.988 | x0.974 | level | 52 of 64 | x0.976 | - | x0.974 | x0.977 | x0.993 |
| blake3-servil-mt / solo / ContinuousBatches / 65536 | 3.363 | 3.397 | x1.010 | level | 35 of 64 | x1.019 | - | x1.010 | x0.989 | x1.006 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 7.438 | 7.366 | x0.990 | level | 35 of 64 | - | - | x0.987 | x0.977 | x0.987 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 65536 | 6.673 | 6.427 | x0.963 | level | 35 of 64 | - | - | x0.963 | x0.994 | x0.955 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 16 | 14.162 | 14.228 | x1.005 | level | 32 of 64 | - | - | x0.998 | x0.976 | x0.980 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 65536 | 6.254 | 6.040 | x0.966 | level | 40 of 64 | - | - | x0.966 | x1.022 | x0.938 |

## Stage 1 (initial screen, kept-drift)

compare: old side: bench 3f119a507807 clean; servil e1966b498bc7 clean
compare: new side: bench 3f119a507807 clean; servil 0997700f35b0 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 7.443 | 6.856 | x0.921 | level | 3 of 4 | - | - | x0.950 | x1.005 | x0.987 |
| blake3-servil-st / solo / OneMessage / 128 B | 4.227 | 3.993 | x0.945 | level | 3 of 4 | - | - | x0.957 | x1.003 | x0.983 |
| blake3-servil-st / solo / OneMessage / 256 B | 2.648 | 2.519 | x0.951 | level | 3 of 4 | - | - | x0.955 | x1.001 | x0.969 |
| blake3-servil-st / solo / OneMessage / 512 B | 1.842 | 1.869 | x1.014 | level | 3 of 4 | - | - | x0.957 | x1.001 | x0.976 |
| blake3-servil-st / solo / OneMessage / 1 KiB | 1.396 | 1.352 | x0.968 | level | 3 of 4 | - | - | x0.969 | x1.000 | x0.975 |
| blake3-servil-st / solo / OneMessage / 1536 B | 1.445 | 1.420 | x0.982 | level | 2 of 4 | - | - | x1.011 | x0.996 | x0.971 |
| blake3-servil-st / solo / OneMessage / 2 KiB | 0.931 | 0.906 | x0.973 | level | 3 of 4 | - | - | x0.973 | x1.000 | x0.990 |
| blake3-servil-st / solo / OneMessage / 2304 B | 1.123 | 1.080 | x0.962 | level | 2 of 4 | - | - | x0.963 | x1.000 | x1.002 |
| blake3-servil-st / solo / OneMessage / 3 KiB | 0.830 | 0.815 | x0.982 | level | 3 of 4 | - | - | x0.983 | x0.999 | x1.018 |
| blake3-servil-st / solo / OneMessage / 3839 B | 0.969 | 0.934 | x0.965 | level | 4 of 4 | - | - | x0.963 | x0.999 | x0.991 |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.603 | 0.608 | x1.007 | level | 2 of 4 | - | - | x0.978 | x0.999 | x1.015 |
| blake3-servil-st / solo / OneMessage / 4470 B | 0.690 | 0.685 | x0.992 | level | 3 of 4 | - | - | x0.971 | x1.000 | x0.994 |
| blake3-servil-st / solo / OneMessage / 7935 B | 0.540 | 0.542 | x1.002 | level | 2 of 4 | - | - | x0.988 | x1.000 | x0.991 |
| blake3-servil-st / solo / OneMessage / 8 KiB | 0.439 | 0.423 | x0.964 | level | 4 of 4 | - | - | x0.966 | x1.000 | x0.982 |
| blake3-servil-st / solo / OneMessage / 16 KiB | 0.382 | 0.373 | x0.977 | level | 3 of 4 | - | - | x0.988 | x1.000 | x1.019 |
| blake3-servil-st / solo / OneMessage / 32 KiB | 0.330 | 0.333 | x1.009 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.992 |
| blake3-servil-st / solo / OneMessage / 64 KiB | 0.314 | 0.312 | x0.991 | level | 2 of 4 | - | - | x0.992 | x1.000 | x1.000 |
| blake3-servil-st / solo / OneMessage / 128 KiB | 0.303 | 0.302 | x0.998 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.979 |
| blake3-servil-st / solo / OneMessage / 256 KiB | 0.294 | 0.295 | x1.004 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.987 |
| blake3-servil-st / solo / OneMessage / 512 KiB | 0.287 | 0.284 | x0.990 | level | 3 of 4 | - | - | x0.989 | x1.000 | x1.013 |
| blake3-servil-st / solo / OneMessage / 1 MiB | 0.287 | 0.286 | x0.996 | level | 2 of 4 | - | - | x0.994 | x1.000 | x1.036 |
| blake3-servil-st / solo / OneMessage / 2 MiB | 0.298 | 0.296 | x0.991 | level | 3 of 4 | - | - | x0.992 | x1.000 | x1.049 |
| blake3-servil-st / solo / OneMessage / 3 MiB | 0.305 | 0.302 | x0.991 | level | 3 of 4 | - | - | x0.991 | x1.000 | x1.038 |
| blake3-servil-st / solo / OneMessage / 4 MiB | 0.297 | 0.295 | x0.993 | level | 3 of 4 | - | - | x0.993 | x1.000 | x1.040 |
| blake3-servil-st / solo / OneMessage / 8 MiB | 0.312 | 0.312 | x1.000 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.045 |
| blake3-servil-st / solo / OneMessage / 32 MiB | 0.300 | 0.302 | x1.007 | level | 2 of 4 | - | - | x1.007 | x1.000 | x1.017 |
| blake3-servil-st / solo / OneMessage / 64 MiB | 0.300 | 0.303 | x1.008 | level | 2 of 4 | - | - | x1.008 | x1.000 | x1.021 |
| blake3-servil-st / solo / OneMessage / 128 MiB | 0.298 | 0.301 | x1.012 | level | 2 of 4 | - | - | x1.012 | x1.000 | x1.002 |
| blake3-servil-st / solo / ManyMessages / 1 | 481.574 | 491.607 | x1.021 | level | 3 of 4 | - | - | x1.015 | x1.012 | x0.987 |
| blake3-servil-st / solo / ManyMessages / 2 | 277.328 | 267.596 | x0.965 | level | 3 of 4 | - | - | x0.977 | x0.999 | x0.965 |
| blake3-servil-st / solo / ManyMessages / 3 | 209.093 | 195.754 | x0.936 | level | 3 of 4 | - | - | x0.946 | x0.997 | x0.969 |
| blake3-servil-st / solo / ManyMessages / 4 | 155.559 | 152.365 | x0.979 | level | 2 of 4 | - | - | x0.972 | x1.000 | x0.968 |
| blake3-servil-st / solo / ManyMessages / 6 | 127.130 | 119.682 | x0.941 | level | 3 of 4 | - | - | x0.947 | x1.000 | x0.982 |
| blake3-servil-st / solo / ManyMessages / 8 | 108.664 | 106.112 | x0.977 | level | 2 of 4 | - | - | x0.945 | x0.998 | x0.985 |
| blake3-servil-st / solo / ManyMessages / 12 | 83.554 | 78.471 | x0.939 | level | 3 of 4 | - | - | x0.963 | x1.002 | x0.979 |
| blake3-servil-st / solo / ManyMessages / 16 | 60.135 | 59.161 | x0.984 | level | 3 of 4 | - | - | x0.984 | x0.999 | x0.976 |
| blake3-servil-st / solo / ManyMessages / 24 | 44.936 | 43.497 | x0.968 | level | 3 of 4 | - | - | x0.971 | x0.999 | x0.976 |
| blake3-servil-st / solo / ManyMessages / 32 | 38.084 | 36.281 | x0.953 | level | 3 of 4 | - | - | x0.959 | x1.000 | x0.977 |
| blake3-servil-st / solo / ManyMessages / 48 | 30.764 | 29.030 | x0.944 | level | 3 of 4 | - | - | x0.957 | x1.000 | x0.966 |
| blake3-servil-st / solo / ManyMessages / 64 | 27.113 | 26.219 | x0.967 | level | 2 of 4 | - | - | x0.968 | x1.000 | x0.980 |
| blake3-servil-st / solo / ManyMessages / 128 | 23.835 | 23.389 | x0.981 | level | 2 of 4 | - | - | x0.959 | x1.000 | x0.966 |
| blake3-servil-st / solo / ManyMessages / 256 | 21.257 | 20.626 | x0.970 | level | 3 of 4 | - | - | x0.988 | x1.000 | x0.954 |
| blake3-servil-st / solo / ManyMessages / 512 | 19.165 | 19.106 | x0.997 | level | 2 of 4 | - | - | x0.982 | x1.000 | x0.969 |
| blake3-servil-st / solo / ManyMessages / 1024 | 18.498 | 18.491 | x1.000 | level | 2 of 4 | - | - | x0.994 | x1.000 | x0.998 |
| blake3-servil-st / solo / ManyMessages / 2048 | 18.268 | 18.283 | x1.001 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.990 |
| blake3-servil-st / solo / ManyMessages / 4096 | 17.876 | 17.929 | x1.003 | level | 2 of 4 | - | - | x1.005 | x1.000 | x0.998 |
| blake3-servil-st / solo / ManyMessages / 8192 | 17.215 | 17.220 | x1.000 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.987 |
| blake3-servil-st / solo / ManyMessages / 16384 | 17.177 | 17.141 | x0.998 | level | 1 of 4 | - | - | x0.997 | x1.000 | x0.975 |
| blake3-servil-st / solo / ManyMessages / 32768 | 17.509 | 17.431 | x0.996 | level | 1 of 4 | - | - | x0.996 | x1.000 | x1.001 |
| blake3-servil-st / solo / ManyMessages / 65536 | 17.624 | 17.550 | x0.996 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.007 |
| blake3-servil-st / solo / ManyMessages / 131072 | 18.178 | 17.940 | x0.987 | level | 4 of 4 | - | - | x0.988 | x1.000 | x0.996 |
| blake3-servil-st / solo / ManyMessages / 262144 | 18.508 | 18.387 | x0.993 | level | 3 of 4 | - | - | x0.993 | x1.000 | x0.995 |
| blake3-servil-st / solo / ManyLongMessages / 4 | 1855.052 | 1812.485 | x0.977 | level | 2 of 4 | - | - | x0.988 | x1.000 | x0.972 |
| blake3-servil-st / solo / ManyLongMessages / 16 | 1231.056 | 1224.016 | x0.994 | level | 3 of 4 | - | - | x0.981 | x0.998 | x0.937 |
| blake3-servil-st / solo / ManyLongMessages / 64 | 1181.341 | 1180.533 | x0.999 | level | 2 of 4 | - | - | x0.996 | x0.998 | x0.934 |
| blake3-servil-st / solo / ManyLongMessages / 256 | 1139.593 | 1144.739 | x1.005 | level | 2 of 4 | - | - | x1.003 | x0.998 | x1.002 |
| blake3-servil-st / solo / IdleOneMessage / 64 B | 5.396 | 5.544 | x1.027 | level | 1 of 4 | - | - | x1.013 | x1.009 | x1.071 |
| blake3-servil-st / solo / IdleOneMessage / 128 B | 3.701 | 3.783 | x1.022 | level | 2 of 4 | - | - | x1.009 | x1.004 | x1.004 |
| blake3-servil-st / solo / IdleOneMessage / 256 B | 2.809 | 2.878 | x1.024 | level | 1 of 4 | - | - | x1.009 | x1.002 | x1.284 |
| blake3-servil-st / solo / IdleOneMessage / 512 B | 2.407 | 2.479 | x1.030 | level | 1 of 4 | - | - | x1.009 | x1.002 | x1.377 |
| blake3-servil-st / solo / IdleOneMessage / 1 KiB | 2.243 | 2.157 | x0.961 | level | 4 of 4 | - | - | x1.003 | x1.002 | x0.955 |
| blake3-servil-st / solo / IdleOneMessage / 1536 B | 1.836 | 1.747 | x0.951 | level | 3 of 4 | - | - | x1.008 | x0.998 | x1.102 |
| blake3-servil-st / solo / IdleOneMessage / 2 KiB | 1.242 | 1.308 | x1.053 | level | 1 of 4 | - | - | x1.006 | x1.001 | x0.762 |
| blake3-servil-st / solo / IdleOneMessage / 2304 B | 1.428 | 1.421 | x0.995 | level | 3 of 4 | - | - | x1.001 | x1.002 | x1.158 |
| blake3-servil-st / solo / IdleOneMessage / 3 KiB | 1.066 | 1.003 | x0.941 | level | 4 of 4 | - | - | x1.010 | x1.000 | x0.964 |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 1.097 | 1.087 | x0.991 | level | 2 of 4 | - | - | x1.000 | x1.001 | x1.370 |
| blake3-servil-st / solo / IdleOneMessage / 4 KiB | 0.821 | 0.756 | x0.920 | level | 3 of 4 | - | - | x0.994 | x1.001 | x1.022 |
| blake3-servil-st / solo / IdleOneMessage / 4470 B | 0.923 | 0.930 | x1.007 | level | 2 of 4 | - | - | x1.000 | x1.001 | x0.655 |
| blake3-servil-st / solo / IdleOneMessage / 7935 B | 0.610 | 0.601 | x0.986 | level | 3 of 4 | - | - | x1.004 | x1.001 | x1.199 |
| blake3-servil-st / solo / IdleOneMessage / 8 KiB | 0.538 | 0.531 | x0.986 | level | 3 of 4 | - | - | x1.006 | x1.001 | x1.206 |
| blake3-servil-st / solo / IdleOneMessage / 16 KiB | 0.493 | 0.515 | x1.044 | level | 0 of 4 | - | - | x0.997 | x1.000 | x1.055 |
| blake3-servil-st / solo / IdleOneMessage / 32 KiB | 0.487 | 0.480 | x0.985 | level | 3 of 4 | - | - | x0.992 | x1.000 | x1.095 |
| blake3-servil-st / solo / IdleOneMessage / 64 KiB | 0.474 | 0.457 | x0.963 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.188 |
| blake3-servil-st / solo / IdleOneMessage / 128 KiB | 0.482 | 0.473 | x0.980 | level | 3 of 4 | - | - | x1.005 | x1.000 | x0.873 |
| blake3-servil-st / solo / IdleOneMessage / 256 KiB | 0.467 | 0.476 | x1.021 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.974 |
| blake3-servil-st / solo / IdleOneMessage / 512 KiB | 0.481 | 0.472 | x0.982 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.994 |
| blake3-servil-st / solo / IdleOneMessage / 1 MiB | 0.488 | 0.495 | x1.015 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.989 |
| blake3-servil-st / solo / IdleOneMessage / 2 MiB | 0.495 | 0.487 | x0.983 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.015 |
| blake3-servil-st / solo / IdleOneMessage / 3 MiB | 0.450 | 0.442 | x0.982 | level | 3 of 4 | - | - | x1.001 | x1.000 | x1.006 |
| blake3-servil-st / solo / IdleOneMessage / 4 MiB | 0.426 | 0.409 | x0.960 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.022 |
| blake3-servil-st / solo / IdleOneMessage / 8 MiB | 0.333 | 0.335 | x1.007 | level | 2 of 4 | - | - | x0.986 | x1.000 | x1.071 |
| blake3-servil-st / solo / IdleOneMessage / 32 MiB | 0.297 | 0.298 | x1.002 | level | 2 of 4 | - | - | x1.007 | x1.000 | x1.023 |
| blake3-servil-st / solo / IdleOneMessage / 64 MiB | 0.300 | 0.302 | x1.008 | level | 2 of 4 | - | - | x1.011 | x1.000 | x1.031 |
| blake3-servil-st / solo / IdleOneMessage / 128 MiB | 0.299 | 0.303 | x1.013 | level | 2 of 4 | - | - | x1.014 | x1.000 | x1.004 |
| blake3-servil-st / solo / IdleManyMessages / 1 | 378.693 | 389.309 | x1.028 | level | 1 of 4 | - | - | x1.019 | x1.015 | x1.515 |
| blake3-servil-st / solo / IdleManyMessages / 2 | 233.508 | 196.564 | x0.842 | level | 4 of 4 | - | - | x0.993 | x1.007 | x0.992 |
| blake3-servil-st / solo / IdleManyMessages / 3 | 177.197 | 170.712 | x0.963 | level | 3 of 4 | - | - | x0.998 | x1.002 | x0.916 |
| blake3-servil-st / solo / IdleManyMessages / 4 | 111.261 | 107.885 | x0.970 | level | 3 of 4 | - | - | x1.004 | x1.002 | x1.179 |
| blake3-servil-st / solo / IdleManyMessages / 6 | 95.159 | 93.458 | x0.982 | level | 3 of 4 | - | - | x0.998 | x1.003 | x1.064 |
| blake3-servil-st / solo / IdleManyMessages / 8 | 68.273 | 68.177 | x0.999 | level | 2 of 4 | - | - | x0.995 | x1.002 | x1.107 |
| blake3-servil-st / solo / IdleManyMessages / 12 | 59.058 | 59.135 | x1.001 | level | 3 of 4 | - | - | x1.003 | x1.001 | x1.118 |
| blake3-servil-st / solo / IdleManyMessages / 16 | 50.761 | 51.751 | x1.019 | level | 2 of 4 | - | - | x0.990 | x1.001 | x0.752 |
| blake3-servil-st / solo / IdleManyMessages / 24 | 43.331 | 45.211 | x1.043 | level | 2 of 4 | - | - | x0.997 | x1.001 | x0.992 |
| blake3-servil-st / solo / IdleManyMessages / 32 | 39.753 | 41.570 | x1.046 | level | 1 of 4 | - | - | x1.012 | x1.001 | x1.352 |
| blake3-servil-st / solo / IdleManyMessages / 48 | 36.186 | 37.443 | x1.035 | level | 0 of 4 | - | - | x0.995 | x1.001 | x1.216 |
| blake3-servil-st / solo / IdleManyMessages / 64 | 34.322 | 33.703 | x0.982 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.117 |
| blake3-servil-st / solo / IdleManyMessages / 128 | 30.319 | 31.160 | x1.028 | level | 2 of 4 | - | - | x0.994 | x1.001 | x1.273 |
| blake3-servil-st / solo / IdleManyMessages / 256 | 29.865 | 29.909 | x1.001 | level | 3 of 4 | - | - | x0.989 | x1.000 | x0.996 |
| blake3-servil-st / solo / IdleManyMessages / 512 | 29.302 | 28.621 | x0.977 | level | 3 of 4 | - | - | x0.992 | x1.000 | x0.981 |
| blake3-servil-st / solo / IdleManyMessages / 1024 | 29.439 | 28.390 | x0.964 | level | 3 of 4 | - | - | x0.993 | x1.000 | x1.100 |
| blake3-servil-st / solo / IdleManyMessages / 2048 | 28.565 | 29.577 | x1.035 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.948 |
| blake3-servil-st / solo / IdleManyMessages / 4096 | 29.890 | 29.019 | x0.971 | level | 3 of 4 | - | - | x1.005 | x1.000 | x0.957 |
| blake3-servil-st / solo / IdleManyMessages / 8192 | 30.417 | 29.315 | x0.964 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.961 |
| blake3-servil-st / solo / IdleManyMessages / 16384 | 30.643 | 30.729 | x1.003 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.950 |
| blake3-servil-st / solo / IdleManyMessages / 32768 | 30.598 | 30.053 | x0.982 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.985 |
| blake3-servil-st / solo / IdleManyMessages / 65536 | 26.543 | 26.783 | x1.009 | level | 2 of 4 | - | - | x0.995 | x1.000 | x1.009 |
| blake3-servil-st / solo / IdleManyMessages / 131072 | 20.741 | 20.964 | x1.011 | level | 1 of 4 | - | - | x0.997 | x1.000 | x1.018 |
| blake3-servil-st / solo / IdleManyMessages / 262144 | 18.268 | 17.896 | x0.980 | level | 4 of 4 | - | - | x0.996 | x1.000 | x0.976 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 B | 2.529 | 2.480 | x0.981 | level | 1 of 4 | - | - | x1.005 | x1.007 | x0.952 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 B | 1.701 | 1.719 | x1.010 | level | 0 of 4 | - | - | x1.005 | x1.005 | x0.803 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 B | 1.309 | 1.319 | x1.008 | level | 0 of 4 | - | - | x1.007 | x1.001 | x1.269 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 B | 1.129 | 1.128 | x0.999 | level | 1 of 4 | - | - | x1.000 | x1.002 | x0.599 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 KiB | 1.032 | 1.051 | x1.018 | level | 2 of 4 | - | - | x1.000 | x1.002 | x0.813 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1536 B | 0.802 | 0.817 | x1.019 | level | 1 of 4 | - | - | x1.005 | x0.999 | x1.566 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 KiB | 0.571 | 0.572 | x1.002 | level | 1 of 4 | - | - | x1.002 | x1.001 | x0.902 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2304 B | 0.654 | 0.678 | x1.037 | level | 1 of 4 | - | - | x1.002 | x1.002 | x1.048 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.496 | 0.505 | x1.018 | level | 1 of 4 | - | - | x1.005 | x1.001 | x0.896 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3839 B | 0.502 | 0.502 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.001 | x0.778 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 KiB | 0.355 | 0.354 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.001 | x0.738 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4470 B | 0.428 | 0.427 | x0.997 | level | 3 of 4 | - | - | x1.000 | x1.001 | x0.824 |
| blake3-servil-st / solo / BriefIdleOneMessage / 7935 B | 0.270 | 0.268 | x0.994 | level | 3 of 4 | - | - | x0.994 | x1.001 | x0.575 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 KiB | 0.247 | 0.247 | x1.002 | level | 2 of 4 | - | - | x1.001 | x1.001 | x0.845 |
| blake3-servil-st / solo / BriefIdleOneMessage / 16 KiB | 0.230 | 0.233 | x1.013 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.061 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 KiB | 0.225 | 0.224 | x0.995 | level | 2 of 4 | - | - | x0.995 | x1.000 | x1.123 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 KiB | 0.219 | 0.220 | x1.005 | level | 1 of 4 | - | - | x0.996 | x1.000 | x1.184 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 KiB | 0.220 | 0.220 | x0.999 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.842 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 KiB | 0.224 | 0.225 | x1.002 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.949 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 KiB | 0.232 | 0.231 | x0.998 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.971 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 MiB | 0.235 | 0.235 | x1.001 | level | 1 of 4 | - | - | x0.998 | x1.000 | x1.002 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 MiB | 0.237 | 0.237 | x0.998 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.030 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 MiB | 0.238 | 0.238 | x0.998 | level | 1 of 4 | - | - | x0.997 | x1.000 | x1.027 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 MiB | 0.239 | 0.238 | x0.995 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.043 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 MiB | 0.250 | 0.245 | x0.981 | level | 3 of 4 | - | - | x0.980 | x1.000 | x1.091 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 MiB | 0.293 | 0.294 | x1.005 | level | 2 of 4 | - | - | x1.005 | x1.000 | x1.021 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 MiB | 0.295 | 0.297 | x1.008 | level | 2 of 4 | - | - | x1.008 | x1.000 | x1.027 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 MiB | 0.297 | 0.301 | x1.014 | level | 2 of 4 | - | - | x1.014 | x1.000 | x1.002 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1 | 172.110 | 187.950 | x1.092 | level | 1 of 4 | - | - | x1.008 | x1.018 | x1.238 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2 | 87.812 | 87.327 | x0.994 | level | 3 of 4 | - | - | x0.996 | x1.007 | x0.862 |
| blake3-servil-st / solo / BriefIdleManyMessages / 3 | 77.010 | 76.748 | x0.997 | level | 2 of 4 | - | - | x0.998 | x1.001 | x1.265 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4 | 48.474 | 48.458 | x1.000 | level | 2 of 4 | - | - | x0.999 | x1.002 | x0.633 |
| blake3-servil-st / solo / BriefIdleManyMessages / 6 | 42.578 | 42.632 | x1.001 | level | 2 of 4 | - | - | x0.999 | x1.002 | x0.491 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8 | 30.300 | 30.357 | x1.002 | level | 2 of 4 | - | - | x0.999 | x1.002 | x0.435 |
| blake3-servil-st / solo / BriefIdleManyMessages / 12 | 27.036 | 27.146 | x1.004 | level | 1 of 4 | - | - | x1.002 | x1.002 | x0.607 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16 | 23.364 | 23.302 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.001 | x0.721 |
| blake3-servil-st / solo / BriefIdleManyMessages / 24 | 20.251 | 20.318 | x1.003 | level | 2 of 4 | - | - | x0.992 | x1.001 | x0.559 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32 | 18.560 | 18.323 | x0.987 | level | 3 of 4 | - | - | x0.991 | x1.001 | x0.716 |
| blake3-servil-st / solo / BriefIdleManyMessages / 48 | 16.812 | 16.687 | x0.993 | level | 3 of 4 | - | - | x0.991 | x1.000 | x0.569 |
| blake3-servil-st / solo / BriefIdleManyMessages / 64 | 15.940 | 15.888 | x0.997 | level | 1 of 4 | - | - | x0.995 | x1.000 | x0.712 |
| blake3-servil-st / solo / BriefIdleManyMessages / 128 | 14.610 | 14.786 | x1.012 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.904 |
| blake3-servil-st / solo / BriefIdleManyMessages / 256 | 14.327 | 13.942 | x0.973 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.183 |
| blake3-servil-st / solo / BriefIdleManyMessages / 512 | 14.511 | 13.532 | x0.933 | level | 3 of 4 | - | - | x0.995 | x1.000 | x1.106 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1024 | 13.582 | 13.443 | x0.990 | level | 1 of 4 | - | - | x0.992 | x1.000 | x1.011 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2048 | 13.676 | 13.784 | x1.008 | level | 1 of 4 | - | - | x0.997 | x1.000 | x0.888 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4096 | 14.160 | 14.253 | x1.007 | level | 1 of 4 | - | - | x1.008 | x1.000 | x0.940 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8192 | 14.357 | 14.349 | x0.999 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.988 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16384 | 14.650 | 14.550 | x0.993 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.961 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32768 | 14.948 | 14.823 | x0.992 | level | 2 of 4 | - | - | x0.992 | x1.000 | x1.020 |
| blake3-servil-st / solo / BriefIdleManyMessages / 65536 | 15.067 | 15.123 | x1.004 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.015 |
| blake3-servil-st / solo / BriefIdleManyMessages / 131072 | 15.140 | 15.093 | x0.997 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.060 |
| blake3-servil-st / solo / BriefIdleManyMessages / 262144 | 15.936 | 15.829 | x0.993 | level | 3 of 4 | - | - | x0.993 | x1.000 | x0.977 |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.886 | 0.934 | x1.054 | level | 0 of 4 | x1.054 | - | x1.054 | x1.011 | x1.166 |
| blake3-servil-st / solo / ContinuousMessages / 128 B | 0.908 | 0.929 | x1.023 | level | 0 of 4 | x1.023 | - | x1.019 | x1.006 | x1.562 |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 0.917 | 0.921 | x1.004 | level | 0 of 4 | x1.005 | - | x1.005 | x1.003 | x0.922 |
| blake3-servil-st / solo / ContinuousMessages / 512 B | 0.928 | 0.938 | x1.011 | level | 0 of 4 | x1.011 | - | x1.010 | x1.002 | x0.728 |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 0.925 | 0.927 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.001 | x1.119 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.316 | 0.316 | x1.000 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | x0.667 |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.215 | 0.215 | x1.000 | level | 2 of 4 | x1.000 | - | x0.999 | x1.000 | x0.831 |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.216 | 0.217 | x1.002 | level | 3 of 4 | x1.001 | - | x0.998 | x1.000 | x0.896 |
| blake3-servil-st / solo / ContinuousMessages / 256 KiB | 0.218 | 0.218 | x1.000 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x0.981 |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.219 | 0.220 | x1.004 | level | 2 of 4 | x1.004 | - | x1.001 | x1.000 | x0.976 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.219 | 0.219 | x0.998 | level | 2 of 4 | x0.998 | - | x0.999 | x1.000 | x0.980 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.221 | 0.221 | x0.999 | level | 2 of 4 | x0.999 | - | x0.997 | x1.000 | x0.999 |
| blake3-servil-st / solo / ContinuousMessages / 64 MiB | 0.251 | 0.258 | x1.027 | level | 1 of 4 | x1.027 | - | x1.027 | x1.000 | x1.179 |
| blake3-servil-st / solo / ContinuousBatches / 16 | 16.490 | 15.739 | x0.954 | level | 3 of 4 | x0.955 | - | x0.952 | x0.999 | x0.989 |
| blake3-servil-st / solo / ContinuousBatches / 64 | 13.775 | 13.610 | x0.988 | level | 2 of 4 | x0.988 | - | x0.988 | x1.000 | x0.523 |
| blake3-servil-st / solo / ContinuousBatches / 256 | 13.686 | 13.626 | x0.996 | level | 3 of 4 | x0.996 | - | x0.996 | x1.000 | x0.960 |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 13.872 | 13.844 | x0.998 | level | 2 of 4 | x0.998 | - | x0.999 | x1.000 | x1.404 |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 14.449 | 14.473 | x1.002 | level | 2 of 4 | x1.002 | - | x1.001 | x1.000 | x1.002 |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 14.953 | 14.892 | x0.996 | level | 2 of 4 | x0.996 | - | x0.996 | x1.000 | x1.111 |
| blake3-servil-st / solo / ContinuousBatches / 65536 | 14.965 | 14.978 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x0.991 |
| blake3-servil-st / solo / LentMessages / 64 B | 0.886 | 0.934 | x1.054 | level | 0 of 4 | x1.054 | - | x1.054 | x1.011 | x1.166 |
| blake3-servil-st / solo / LentMessages / 128 B | 0.908 | 0.929 | x1.023 | level | 0 of 4 | x1.023 | - | x1.019 | x1.006 | x1.562 |
| blake3-servil-st / solo / LentMessages / 256 B | 0.917 | 0.921 | x1.004 | level | 0 of 4 | x1.005 | - | x1.005 | x1.003 | x0.922 |
| blake3-servil-st / solo / LentMessages / 512 B | 0.928 | 0.938 | x1.011 | level | 0 of 4 | x1.011 | - | x1.010 | x1.002 | x0.728 |
| blake3-servil-st / solo / LentMessages / 1 KiB | 0.925 | 0.927 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.001 | x1.119 |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.316 | 0.316 | x1.000 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | x0.667 |
| blake3-servil-st / solo / LentMessages / 16 KiB | 0.215 | 0.215 | x1.000 | level | 2 of 4 | x1.000 | - | x0.999 | x1.000 | x0.831 |
| blake3-servil-st / solo / LentMessages / 64 KiB | 0.216 | 0.217 | x1.002 | level | 3 of 4 | x1.001 | - | x0.998 | x1.000 | x0.896 |
| blake3-servil-st / solo / LentMessages / 256 KiB | 0.219 | 0.219 | x0.999 | level | 2 of 4 | x0.999 | - | x1.001 | x1.000 | x0.914 |
| blake3-servil-st / solo / LentMessages / 1 MiB | 0.231 | 0.229 | x0.994 | level | 2 of 4 | x0.993 | - | x0.995 | x1.000 | x1.064 |
| blake3-servil-st / solo / LentMessages / 4 MiB | 0.232 | 0.234 | x1.005 | level | 2 of 4 | x1.005 | - | x1.006 | x1.000 | x1.055 |
| blake3-servil-st / solo / LentMessages / 16 MiB | 0.256 | 0.257 | x1.003 | level | 2 of 4 | x1.002 | - | x1.001 | x1.000 | x1.012 |
| blake3-servil-st / solo / LentMessages / 64 MiB | 0.297 | 0.300 | x1.010 | level | 2 of 4 | x1.010 | - | x1.010 | x1.000 | x1.004 |
| blake3-servil-st / solo / Interleaved / 256 | 0.258 | 0.261 | x1.010 | level | 2 of 4 | x1.009 | - | x1.010 | x1.005 | x0.987 |
| blake3-servil-st / solo / Collection / git objects | 0.247 | 0.246 | x0.995 | level | 2 of 4 | x0.995 | - | x0.994 | x1.000 | x0.941 |
| blake3-servil-st / solo / Collection / Nix files | 0.233 | 0.233 | x0.998 | level | 2 of 4 | x0.998 | - | x0.998 | x1.000 | x0.995 |
| blake3-servil-st / solo / LentBatches / 16 | 16.490 | 15.739 | x0.954 | level | 3 of 4 | x0.955 | - | x0.952 | x0.999 | x0.989 |
| blake3-servil-st / solo / LentBatches / 64 | 13.775 | 13.610 | x0.988 | level | 2 of 4 | x0.988 | - | x0.988 | x1.000 | x0.523 |
| blake3-servil-st / solo / LentBatches / 256 | 13.686 | 13.626 | x0.996 | level | 3 of 4 | x0.996 | - | x0.996 | x1.000 | x0.960 |
| blake3-servil-st / solo / LentBatches / 1024 | 13.872 | 13.844 | x0.998 | level | 2 of 4 | x0.998 | - | x0.999 | x1.000 | x1.404 |
| blake3-servil-st / solo / LentBatches / 4096 | 14.449 | 14.473 | x1.002 | level | 2 of 4 | x1.002 | - | x1.001 | x1.000 | x1.002 |
| blake3-servil-st / solo / LentBatches / 16384 | 14.953 | 14.892 | x0.996 | level | 2 of 4 | x0.996 | - | x0.996 | x1.000 | x1.111 |
| blake3-servil-st / solo / LentBatches / 65536 | 14.965 | 14.978 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x0.991 |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.268 | 0.272 | x1.017 | level | 0 of 4 | x1.017 | - | x1.016 | x1.000 | x1.018 |
| blake3-servil-st / solo / ContinuousCollection / Nix files | 0.274 | 0.275 | x1.005 | level | 1 of 4 | x1.005 | - | x1.005 | x1.000 | x1.021 |
| blake3-servil-st / solo / MerkleTree / 1024 | 0.261 | 0.261 | x1.002 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x1.066 |
| blake3-servil-st / solo / MerkleTree / 4096 | 0.275 | 0.271 | x0.985 | level | 3 of 4 | x0.998 | - | x1.000 | x1.000 | x0.864 |
| blake3-servil-st / solo / MerkleTree / 16384 | 0.272 | 0.273 | x1.002 | level | 1 of 4 | x1.002 | - | x1.001 | x1.000 | x0.940 |
| blake3-servil-st / solo / MerkleTree / 65536 | 0.302 | 0.309 | x1.022 | level | 1 of 4 | x1.021 | - | x1.020 | x1.000 | x0.998 |
| blake3-servil-st / solo / MerkleTree / 262144 | 0.550 | 0.547 | x0.994 | level | 3 of 4 | x0.994 | - | x0.993 | x1.000 | x0.989 |
| blake3-servil-st / solo / MerkleTree / 65536 x 32 B | 0.836 | 0.836 | x1.000 | level | 2 of 4 | x1.000 | - | x0.999 | x1.000 | x1.063 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 32 B | 1.101 | 1.094 | x0.994 | level | 3 of 4 | x0.994 | - | x0.994 | x1.000 | x1.004 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 16 B | 1.672 | 1.673 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.039 |
| blake3-servil-st / solo / MerkleTree / 65536 x 48 B | 0.573 | 0.570 | x0.996 | level | 3 of 4 | x0.996 | - | x0.997 | x1.000 | x1.039 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 48 B | 0.840 | 0.837 | x0.996 | level | 3 of 4 | x0.996 | - | x0.997 | x1.000 | x0.999 |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.489 | 0.483 | x0.988 | level | 3 of 4 | - | - | x0.986 | x0.977 | x0.987 |
| blake3-servil-st / solo / InterleavedTurn / 1024 x 1 KiB | 0.524 | 0.521 | x0.994 | level | 3 of 4 | - | - | x0.994 | x0.998 | x1.002 |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.695 | 0.680 | x0.978 | level | 3 of 4 | - | - | x1.023 | x1.032 | x0.996 |
| blake3-servil-st / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.823 | 0.829 | x1.007 | level | 1 of 4 | - | - | x0.994 | x0.998 | x1.016 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.396 | 0.389 | x0.983 | level | 3 of 4 | - | - | x0.984 | x0.976 | x0.992 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.447 | 0.427 | x0.957 | level | 4 of 4 | - | - | x0.956 | x0.998 | x1.015 |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.229 | 0.228 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x1.000 | x0.972 |
| blake3-servil-st / solo / ReceivingMessage / 2 μs | 0.230 | 0.230 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x1.000 | x0.986 |
| blake3-servil-st / solo / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 2 of 4 | x1.000 | - | x1.005 | x1.000 | x0.985 |
| blake3-servil-st / solo / IncrementalMessage / 64 B | 7.623 | 7.293 | x0.957 | level | 3 of 4 | - | - | x0.958 | x1.008 | x1.027 |
| blake3-servil-st / solo / IncrementalMessage / 1 KiB | 1.502 | 1.537 | x1.024 | level | 2 of 4 | - | - | x0.991 | x1.001 | x0.984 |
| blake3-servil-st / solo / IncrementalMessage / 4 KiB | 0.705 | 0.690 | x0.979 | level | 3 of 4 | - | - | x0.974 | x1.000 | x1.016 |
| blake3-servil-st / solo / LentIncrementalMessage / 64 B | 1.165 | 1.168 | x1.003 | level | 1 of 4 | x1.002 | - | x1.001 | x1.005 | x1.494 |
| blake3-servil-st / solo / LentIncrementalMessage / 1 KiB | 0.951 | 0.958 | x1.007 | level | 0 of 4 | x1.007 | - | x1.004 | x1.001 | x1.894 |
| blake3-servil-st / solo / LentIncrementalMessage / 4 KiB | 0.329 | 0.329 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | x1.135 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 0.870 | 0.895 | x1.029 | level | 0 of 4 | x1.029 | - | x1.027 | x1.011 | x0.881 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 4 KiB | 0.316 | 0.317 | x1.002 | level | 2 of 4 | x1.002 | - | x1.001 | x1.000 | x0.775 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 1 MiB | 0.219 | 0.219 | x1.002 | level | 3 of 4 | x1.002 | - | x1.002 | x1.000 | x1.020 |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 0.840 | 0.835 | x0.993 | level | 3 of 4 | x0.994 | - | x0.995 | x1.012 | x0.967 |
| blake3-servil-st / solo / ContinuousLentMessages / 4 KiB | 0.307 | 0.307 | x1.003 | level | 1 of 4 | x1.002 | - | x1.000 | x1.000 | x1.840 |
| blake3-servil-st / solo / ContinuousLentMessages / 1 MiB | 0.204 | 0.204 | x0.999 | level | 1 of 4 | x0.999 | - | x1.002 | x1.000 | x1.005 |
| blake3-servil-mt / solo / OneMessage / 64 B | 7.787 | 7.606 | x0.977 | level | 3 of 4 | - | - | x0.975 | x1.004 | x1.015 |
| blake3-servil-mt / solo / OneMessage / 128 B | 4.656 | 4.374 | x0.940 | level | 3 of 4 | - | - | x0.955 | x1.003 | x0.986 |
| blake3-servil-mt / solo / OneMessage / 256 B | 2.784 | 2.596 | x0.932 | level | 4 of 4 | - | - | x0.944 | x1.003 | x0.975 |
| blake3-servil-mt / solo / OneMessage / 512 B | 1.930 | 1.829 | x0.948 | level | 3 of 4 | - | - | x0.955 | x1.001 | x0.974 |
| blake3-servil-mt / solo / OneMessage / 1 KiB | 1.463 | 1.416 | x0.968 | level | 3 of 4 | - | - | x0.972 | x1.001 | x0.990 |
| blake3-servil-mt / solo / OneMessage / 1536 B | 1.497 | 1.391 | x0.929 | level | 3 of 4 | - | - | x0.956 | x0.996 | x0.978 |
| blake3-servil-mt / solo / OneMessage / 2 KiB | 0.976 | 0.955 | x0.979 | level | 3 of 4 | - | - | x0.971 | x0.998 | x1.015 |
| blake3-servil-mt / solo / OneMessage / 2304 B | 1.137 | 1.077 | x0.947 | level | 3 of 4 | - | - | x0.947 | x1.000 | x0.990 |
| blake3-servil-mt / solo / OneMessage / 3 KiB | 0.879 | 0.838 | x0.954 | level | 3 of 4 | - | - | x0.945 | x0.999 | x0.984 |
| blake3-servil-mt / solo / OneMessage / 3839 B | 0.982 | 0.961 | x0.979 | level | 3 of 4 | - | - | x0.959 | x1.000 | x0.994 |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 0.618 | 0.595 | x0.961 | level | 3 of 4 | - | - | x0.956 | x0.999 | x1.012 |
| blake3-servil-mt / solo / OneMessage / 4470 B | 0.708 | 0.685 | x0.968 | level | 3 of 4 | - | - | x0.968 | x1.000 | x0.991 |
| blake3-servil-mt / solo / OneMessage / 7935 B | 0.545 | 0.559 | x1.026 | level | 1 of 4 | - | - | x0.981 | x1.000 | x0.996 |
| blake3-servil-mt / solo / OneMessage / 8 KiB | 0.458 | 0.437 | x0.954 | level | 3 of 4 | - | - | x0.980 | x0.999 | x0.981 |
| blake3-servil-mt / solo / OneMessage / 16 KiB | 0.376 | 0.378 | x1.006 | level | 1 of 4 | - | - | x0.986 | x1.000 | x1.026 |
| blake3-servil-mt / solo / OneMessage / 32 KiB | 0.332 | 0.334 | x1.004 | level | 1 of 4 | - | - | x0.991 | x1.000 | x0.985 |
| blake3-servil-mt / solo / OneMessage / 64 KiB | 0.311 | 0.311 | x0.999 | level | 2 of 4 | - | - | x0.992 | x1.000 | x1.000 |
| blake3-servil-mt / solo / OneMessage / 128 KiB | 0.301 | 0.343 | x1.138 | level | 1 of 4 | - | - | x0.994 | x1.000 | x0.963 |
| blake3-servil-mt / solo / OneMessage / 256 KiB | 0.294 | 0.293 | x0.999 | level | 3 of 4 | - | - | x0.995 | x1.000 | x1.004 |
| blake3-servil-mt / solo / OneMessage / 512 KiB | 0.185 | 0.175 | x0.949 | level | 3 of 4 | - | - | x0.951 | x1.065 | x1.005 |
| blake3-servil-mt / solo / OneMessage / 1 MiB | 0.137 | 0.141 | x1.034 | level | 2 of 4 | - | - | x1.036 | x0.987 | x1.000 |
| blake3-servil-mt / solo / OneMessage / 2 MiB | 0.159 | 0.157 | x0.987 | level | 3 of 4 | - | - | x0.987 | x1.029 | x0.995 |
| blake3-servil-mt / solo / OneMessage / 3 MiB | 0.153 | 0.155 | x1.012 | level | 0 of 4 | - | - | x1.014 | x1.014 | x1.013 |
| blake3-servil-mt / solo / OneMessage / 4 MiB | 0.120 | 0.119 | x0.992 | level | 3 of 4 | - | - | x0.994 | x1.035 | x0.990 |
| blake3-servil-mt / solo / OneMessage / 8 MiB | 0.151 | 0.151 | x1.005 | level | 2 of 4 | - | - | x1.004 | x1.007 | x1.009 |
| blake3-servil-mt / solo / OneMessage / 32 MiB | 0.0809 | 0.0809 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.017 | x1.004 |
| blake3-servil-mt / solo / OneMessage / 64 MiB | 0.0860 | 0.0862 | x1.002 | level | 2 of 4 | - | - | x1.002 | x0.994 | x1.006 |
| blake3-servil-mt / solo / OneMessage / 128 MiB | 0.0761 | 0.0764 | x1.003 | level | 1 of 4 | - | - | x1.003 | x1.003 | x1.017 |
| blake3-servil-mt / solo / ManyMessages / 1 | 484.110 | 477.127 | x0.986 | level | 2 of 4 | - | - | x0.982 | x1.014 | x0.962 |
| blake3-servil-mt / solo / ManyMessages / 2 | 288.469 | 278.153 | x0.964 | level | 3 of 4 | - | - | x0.968 | x1.001 | x0.946 |
| blake3-servil-mt / solo / ManyMessages / 3 | 210.214 | 196.561 | x0.935 | level | 3 of 4 | - | - | x0.935 | x0.998 | x0.940 |
| blake3-servil-mt / solo / ManyMessages / 4 | 160.179 | 154.524 | x0.965 | level | 4 of 4 | - | - | x0.962 | x1.000 | x0.953 |
| blake3-servil-mt / solo / ManyMessages / 6 | 127.177 | 120.125 | x0.945 | level | 3 of 4 | - | - | x0.947 | x1.000 | x0.963 |
| blake3-servil-mt / solo / ManyMessages / 8 | 113.115 | 102.037 | x0.902 | level | 4 of 4 | - | - | x0.917 | x1.002 | x0.986 |
| blake3-servil-mt / solo / ManyMessages / 12 | 80.711 | 83.864 | x1.039 | level | 2 of 4 | - | - | x1.003 | x1.001 | x0.968 |
| blake3-servil-mt / solo / ManyMessages / 16 | 61.218 | 60.210 | x0.984 | level | 3 of 4 | - | - | x0.986 | x1.000 | x0.973 |
| blake3-servil-mt / solo / ManyMessages / 24 | 47.736 | 45.061 | x0.944 | level | 4 of 4 | - | - | x0.972 | x0.998 | x0.971 |
| blake3-servil-mt / solo / ManyMessages / 32 | 38.789 | 37.211 | x0.959 | level | 2 of 4 | - | - | x0.963 | x1.000 | x0.967 |
| blake3-servil-mt / solo / ManyMessages / 48 | 30.745 | 30.104 | x0.979 | level | 2 of 4 | - | - | x0.962 | x1.000 | x0.966 |
| blake3-servil-mt / solo / ManyMessages / 64 | 28.438 | 27.061 | x0.952 | level | 4 of 4 | - | - | x0.956 | x0.999 | x0.971 |
| blake3-servil-mt / solo / ManyMessages / 128 | 23.439 | 23.086 | x0.985 | level | 3 of 4 | - | - | x0.979 | x1.000 | x0.972 |
| blake3-servil-mt / solo / ManyMessages / 256 | 21.368 | 20.689 | x0.968 | level | 2 of 4 | - | - | x0.987 | x1.000 | x0.980 |
| blake3-servil-mt / solo / ManyMessages / 512 | 19.337 | 19.083 | x0.987 | level | 3 of 4 | - | - | x0.993 | x1.000 | x0.982 |
| blake3-servil-mt / solo / ManyMessages / 1024 | 18.489 | 18.297 | x0.990 | level | 2 of 4 | - | - | x0.993 | x1.000 | x1.005 |
| blake3-servil-mt / solo / ManyMessages / 2048 | 18.281 | 18.228 | x0.997 | level | 1 of 4 | - | - | x0.997 | x1.000 | x1.005 |
| blake3-servil-mt / solo / ManyMessages / 4096 | 17.773 | 17.840 | x1.004 | level | 1 of 4 | - | - | x1.003 | x1.000 | x0.999 |
| blake3-servil-mt / solo / ManyMessages / 8192 | 9.791 | 9.937 | x1.015 | level | 2 of 4 | - | - | x1.018 | x1.006 | x0.980 |
| blake3-servil-mt / solo / ManyMessages / 16384 | 8.777 | 9.025 | x1.028 | level | 1 of 4 | - | - | x1.026 | x1.008 | x0.996 |
| blake3-servil-mt / solo / ManyMessages / 32768 | 9.063 | 9.131 | x1.008 | level | 1 of 4 | - | - | x1.011 | x1.048 | x0.993 |
| blake3-servil-mt / solo / ManyMessages / 65536 | 8.183 | 8.285 | x1.012 | level | 3 of 4 | - | - | x1.013 | x1.002 | x1.011 |
| blake3-servil-mt / solo / ManyMessages / 131072 | 9.888 | 9.164 | x0.927 | level | 3 of 4 | - | - | x0.925 | x1.179 | x0.875 |
| blake3-servil-mt / solo / ManyMessages / 262144 | 10.100 | 10.119 | x1.002 | level | 1 of 4 | - | - | x1.002 | x1.021 | x0.998 |
| blake3-servil-mt / solo / ManyLongMessages / 4 | 1808.601 | 1790.130 | x0.990 | level | 2 of 4 | - | - | x0.987 | x1.000 | x0.980 |
| blake3-servil-mt / solo / ManyLongMessages / 16 | 1255.996 | 1215.923 | x0.968 | level | 3 of 4 | - | - | x0.978 | x0.998 | x0.927 |
| blake3-servil-mt / solo / ManyLongMessages / 64 | 1174.429 | 1169.623 | x0.996 | level | 2 of 4 | - | - | x0.998 | x0.998 | x0.943 |
| blake3-servil-mt / solo / ManyLongMessages / 256 | 623.452 | 652.507 | x1.047 | level | 1 of 4 | - | - | x1.055 | x0.989 | x1.007 |
| blake3-servil-mt / solo / IdleOneMessage / 64 B | 5.450 | 5.623 | x1.032 | level | 1 of 4 | - | - | x1.017 | x1.009 | x1.161 |
| blake3-servil-mt / solo / IdleOneMessage / 128 B | 3.736 | 3.824 | x1.024 | level | 2 of 4 | - | - | x1.009 | x1.004 | x1.061 |
| blake3-servil-mt / solo / IdleOneMessage / 256 B | 2.948 | 2.876 | x0.976 | level | 2 of 4 | - | - | x1.007 | x1.002 | x1.074 |
| blake3-servil-mt / solo / IdleOneMessage / 512 B | 2.482 | 2.406 | x0.969 | level | 4 of 4 | - | - | x1.002 | x1.002 | x0.996 |
| blake3-servil-mt / solo / IdleOneMessage / 1 KiB | 2.181 | 2.208 | x1.012 | level | 2 of 4 | - | - | x1.010 | x1.002 | x1.148 |
| blake3-servil-mt / solo / IdleOneMessage / 1536 B | 1.763 | 1.795 | x1.018 | level | 1 of 4 | - | - | x1.011 | x0.999 | x1.018 |
| blake3-servil-mt / solo / IdleOneMessage / 2 KiB | 1.225 | 1.361 | x1.111 | level | 0 of 4 | - | - | x1.020 | x1.001 | x1.519 |
| blake3-servil-mt / solo / IdleOneMessage / 2304 B | 1.405 | 1.387 | x0.987 | level | 2 of 4 | - | - | x1.002 | x1.002 | x1.202 |
| blake3-servil-mt / solo / IdleOneMessage / 3 KiB | 1.079 | 1.048 | x0.971 | level | 3 of 4 | - | - | x1.011 | x1.000 | x1.418 |
| blake3-servil-mt / solo / IdleOneMessage / 3839 B | 1.099 | 1.094 | x0.995 | level | 3 of 4 | - | - | x1.006 | x1.001 | x1.073 |
| blake3-servil-mt / solo / IdleOneMessage / 4 KiB | 0.768 | 0.782 | x1.018 | level | 1 of 4 | - | - | x1.015 | x1.001 | x1.046 |
| blake3-servil-mt / solo / IdleOneMessage / 4470 B | 0.968 | 0.958 | x0.989 | level | 2 of 4 | - | - | x1.006 | x1.001 | x1.216 |
| blake3-servil-mt / solo / IdleOneMessage / 7935 B | 0.608 | 0.576 | x0.949 | level | 3 of 4 | - | - | x0.996 | x1.001 | x0.993 |
| blake3-servil-mt / solo / IdleOneMessage / 8 KiB | 0.526 | 0.544 | x1.035 | level | 1 of 4 | - | - | x1.006 | x1.001 | x1.134 |
| blake3-servil-mt / solo / IdleOneMessage / 16 KiB | 0.515 | 0.486 | x0.943 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.356 |
| blake3-servil-mt / solo / IdleOneMessage / 32 KiB | 0.489 | 0.478 | x0.976 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.220 |
| blake3-servil-mt / solo / IdleOneMessage / 64 KiB | 0.487 | 0.453 | x0.930 | level | 4 of 4 | - | - | x0.997 | x1.000 | x1.049 |
| blake3-servil-mt / solo / IdleOneMessage / 128 KiB | 0.469 | 0.461 | x0.983 | level | 1 of 4 | - | - | x1.003 | x1.000 | x0.906 |
| blake3-servil-mt / solo / IdleOneMessage / 256 KiB | 0.471 | 0.456 | x0.968 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.923 |
| blake3-servil-mt / solo / IdleOneMessage / 512 KiB | 0.225 | 0.223 | x0.990 | level | 2 of 4 | - | - | x0.991 | x1.031 | x1.015 |
| blake3-servil-mt / solo / IdleOneMessage / 1 MiB | 0.194 | 0.206 | x1.061 | level | 2 of 4 | - | - | x1.037 | x0.975 | x1.030 |
| blake3-servil-mt / solo / IdleOneMessage / 2 MiB | 0.204 | 0.208 | x1.017 | level | 1 of 4 | - | - | x1.031 | x1.016 | x1.005 |
| blake3-servil-mt / solo / IdleOneMessage / 3 MiB | 0.201 | 0.201 | x1.002 | level | 2 of 4 | - | - | x0.999 | x1.006 | x0.999 |
| blake3-servil-mt / solo / IdleOneMessage / 4 MiB | 0.208 | 0.203 | x0.975 | level | 3 of 4 | - | - | x1.009 | x1.018 | x0.993 |
| blake3-servil-mt / solo / IdleOneMessage / 8 MiB | 0.174 | 0.174 | x1.001 | level | 2 of 4 | - | - | x0.974 | x0.992 | x1.003 |
| blake3-servil-mt / solo / IdleOneMessage / 32 MiB | 0.0745 | 0.0739 | x0.992 | level | 2 of 4 | - | - | x1.005 | x0.999 | x0.998 |
| blake3-servil-mt / solo / IdleOneMessage / 64 MiB | 0.0743 | 0.0740 | x0.996 | level | 3 of 4 | - | - | x1.002 | x0.977 | x1.003 |
| blake3-servil-mt / solo / IdleOneMessage / 128 MiB | 0.0734 | 0.0738 | x1.006 | level | 1 of 4 | - | - | x1.006 | x1.005 | x1.019 |
| blake3-servil-mt / solo / IdleManyMessages / 1 | 388.868 | 402.782 | x1.036 | level | 1 of 4 | - | - | x1.020 | x1.014 | x1.154 |
| blake3-servil-mt / solo / IdleManyMessages / 2 | 208.613 | 205.045 | x0.983 | level | 1 of 4 | - | - | x1.008 | x1.006 | x0.955 |
| blake3-servil-mt / solo / IdleManyMessages / 3 | 172.784 | 174.562 | x1.010 | level | 1 of 4 | - | - | x1.010 | x1.002 | x0.938 |
| blake3-servil-mt / solo / IdleManyMessages / 4 | 109.044 | 121.397 | x1.113 | level | 0 of 4 | - | - | x1.009 | x1.002 | x1.143 |
| blake3-servil-mt / solo / IdleManyMessages / 6 | 94.847 | 95.673 | x1.009 | level | 1 of 4 | - | - | x0.996 | x1.003 | x0.891 |
| blake3-servil-mt / solo / IdleManyMessages / 8 | 68.270 | 68.934 | x1.010 | level | 1 of 4 | - | - | x0.994 | x1.002 | x0.798 |
| blake3-servil-mt / solo / IdleManyMessages / 12 | 63.642 | 61.061 | x0.959 | level | 2 of 4 | - | - | x0.997 | x1.001 | x1.473 |
| blake3-servil-mt / solo / IdleManyMessages / 16 | 50.758 | 50.895 | x1.003 | level | 1 of 4 | - | - | x1.004 | x1.001 | x1.148 |
| blake3-servil-mt / solo / IdleManyMessages / 24 | 44.263 | 44.016 | x0.994 | level | 2 of 4 | - | - | x0.999 | x1.001 | x1.080 |
| blake3-servil-mt / solo / IdleManyMessages / 32 | 40.310 | 39.371 | x0.977 | level | 2 of 4 | - | - | x0.984 | x1.001 | x0.828 |
| blake3-servil-mt / solo / IdleManyMessages / 48 | 36.768 | 36.065 | x0.981 | level | 2 of 4 | - | - | x0.981 | x1.000 | x0.833 |
| blake3-servil-mt / solo / IdleManyMessages / 64 | 33.641 | 34.815 | x1.035 | level | 1 of 4 | - | - | x0.993 | x1.000 | x0.972 |
| blake3-servil-mt / solo / IdleManyMessages / 128 | 31.411 | 32.315 | x1.029 | level | 1 of 4 | - | - | x1.012 | x1.001 | x1.651 |
| blake3-servil-mt / solo / IdleManyMessages / 256 | 30.040 | 29.255 | x0.974 | level | 4 of 4 | - | - | x0.993 | x1.000 | x1.217 |
| blake3-servil-mt / solo / IdleManyMessages / 512 | 29.058 | 28.426 | x0.978 | level | 3 of 4 | - | - | x0.994 | x1.000 | x1.054 |
| blake3-servil-mt / solo / IdleManyMessages / 1024 | 28.690 | 28.900 | x1.007 | level | 2 of 4 | - | - | x0.989 | x1.000 | x1.054 |
| blake3-servil-mt / solo / IdleManyMessages / 2048 | 29.502 | 28.954 | x0.981 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.946 |
| blake3-servil-mt / solo / IdleManyMessages / 4096 | 30.110 | 29.031 | x0.964 | level | 3 of 4 | - | - | x1.004 | x1.000 | x0.976 |
| blake3-servil-mt / solo / IdleManyMessages / 8192 | 12.991 | 13.442 | x1.035 | level | 2 of 4 | - | - | x1.030 | x1.031 | x0.992 |
| blake3-servil-mt / solo / IdleManyMessages / 16384 | 11.864 | 11.739 | x0.989 | level | 2 of 4 | - | - | x1.018 | x1.045 | x0.980 |
| blake3-servil-mt / solo / IdleManyMessages / 32768 | 11.042 | 12.410 | x1.124 | level | 1 of 4 | - | - | x1.091 | x0.964 | x1.053 |
| blake3-servil-mt / solo / IdleManyMessages / 65536 | 10.442 | 10.569 | x1.012 | level | 1 of 4 | - | - | x1.043 | x1.009 | x1.023 |
| blake3-servil-mt / solo / IdleManyMessages / 131072 | 11.054 | 10.515 | x0.951 | level | 2 of 4 | - | - | x0.935 | x1.074 | x0.902 |
| blake3-servil-mt / solo / IdleManyMessages / 262144 | 9.349 | 9.523 | x1.019 | level | 0 of 4 | - | - | x1.004 | x1.017 | x1.007 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 B | 2.472 | 2.499 | x1.011 | level | 0 of 4 | - | - | x1.004 | x1.007 | x1.284 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 B | 1.711 | 1.730 | x1.011 | level | 0 of 4 | - | - | x1.006 | x1.005 | x0.991 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 B | 1.320 | 1.324 | x1.003 | level | 1 of 4 | - | - | x1.003 | x1.002 | x1.084 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 B | 1.134 | 1.134 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.002 | x0.655 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 KiB | 1.034 | 1.034 | x1.000 | level | 3 of 4 | - | - | x0.997 | x1.002 | x0.879 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1536 B | 0.803 | 0.805 | x1.002 | level | 1 of 4 | - | - | x1.002 | x0.999 | x1.398 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 KiB | 0.584 | 0.602 | x1.031 | level | 3 of 4 | - | - | x0.998 | x1.002 | x0.966 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2304 B | 0.656 | 0.660 | x1.005 | level | 2 of 4 | - | - | x0.995 | x1.002 | x1.068 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 KiB | 0.476 | 0.560 | x1.176 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.928 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3839 B | 0.506 | 0.501 | x0.990 | level | 3 of 4 | - | - | x1.001 | x1.000 | x0.842 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 KiB | 0.355 | 0.355 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.001 | x0.805 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4470 B | 0.428 | 0.428 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.001 | x0.930 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 7935 B | 0.270 | 0.270 | x1.002 | level | 1 of 4 | - | - | x0.998 | x1.001 | x0.638 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 KiB | 0.247 | 0.248 | x1.001 | level | 2 of 4 | - | - | x1.002 | x1.001 | x0.668 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 16 KiB | 0.230 | 0.235 | x1.019 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.960 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 KiB | 0.222 | 0.224 | x1.006 | level | 1 of 4 | - | - | x0.998 | x1.000 | x1.117 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 KiB | 0.219 | 0.219 | x1.000 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.186 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 KiB | 0.218 | 0.219 | x1.001 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.878 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 KiB | 0.225 | 0.225 | x0.999 | level | 1 of 4 | - | - | x0.998 | x1.000 | x0.964 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 KiB | 0.125 | 0.120 | x0.959 | level | 3 of 4 | - | - | x0.961 | x1.034 | x0.985 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 MiB | 0.0952 | 0.103 | x1.082 | level | 2 of 4 | - | - | x1.095 | x1.001 | x1.001 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 MiB | 0.109 | 0.115 | x1.055 | level | 1 of 4 | - | - | x1.055 | x0.994 | x1.031 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 MiB | 0.108 | 0.110 | x1.018 | level | 2 of 4 | - | - | x1.019 | x0.965 | x1.040 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 MiB | 0.112 | 0.109 | x0.972 | level | 3 of 4 | - | - | x0.973 | x1.006 | x0.997 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 MiB | 0.116 | 0.114 | x0.990 | level | 3 of 4 | - | - | x0.991 | x1.017 | x1.011 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 MiB | 0.0608 | 0.0608 | x1.000 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.004 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 MiB | 0.0687 | 0.0686 | x0.998 | level | 2 of 4 | - | - | x1.003 | x0.996 | x1.008 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 MiB | 0.0686 | 0.0688 | x1.004 | level | 2 of 4 | - | - | x1.004 | x0.997 | x1.016 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1 | 187.522 | 181.368 | x0.967 | level | 1 of 4 | - | - | x1.006 | x1.019 | x1.139 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2 | 89.502 | 93.416 | x1.044 | level | 2 of 4 | - | - | x0.996 | x1.008 | x0.633 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 3 | 77.759 | 77.442 | x0.996 | level | 2 of 4 | - | - | x0.996 | x1.001 | x0.775 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4 | 49.073 | 48.775 | x0.994 | level | 3 of 4 | - | - | x0.996 | x1.002 | x0.574 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 6 | 43.130 | 42.921 | x0.995 | level | 3 of 4 | - | - | x0.997 | x1.003 | x0.398 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8 | 30.547 | 30.558 | x1.000 | level | 1 of 4 | - | - | x1.001 | x1.002 | x0.596 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 12 | 27.210 | 27.240 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.002 | x0.850 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16 | 23.456 | 23.344 | x0.995 | level | 3 of 4 | - | - | x0.996 | x1.001 | x0.611 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 24 | 20.304 | 20.101 | x0.990 | level | 3 of 4 | - | - | x0.992 | x1.001 | x0.419 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32 | 18.823 | 18.433 | x0.979 | level | 2 of 4 | - | - | x0.991 | x1.001 | x0.553 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 48 | 16.859 | 16.733 | x0.993 | level | 3 of 4 | - | - | x0.990 | x1.001 | x0.579 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 64 | 16.288 | 15.899 | x0.976 | level | 2 of 4 | - | - | x0.993 | x1.001 | x0.457 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 128 | 14.572 | 14.862 | x1.020 | level | 1 of 4 | - | - | x0.998 | x1.000 | x0.925 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 256 | 14.178 | 13.924 | x0.982 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.975 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 512 | 13.682 | 13.638 | x0.997 | level | 2 of 4 | - | - | x0.994 | x1.000 | x1.071 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1024 | 13.574 | 13.401 | x0.987 | level | 4 of 4 | - | - | x0.990 | x1.000 | x0.966 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2048 | 13.585 | 13.597 | x1.001 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.892 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4096 | 14.053 | 14.202 | x1.011 | level | 1 of 4 | - | - | x1.009 | x1.000 | x0.995 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8192 | 6.748 | 6.914 | x1.024 | level | 2 of 4 | - | - | x1.034 | x1.044 | x0.993 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16384 | 6.163 | 6.228 | x1.011 | level | 1 of 4 | - | - | x1.008 | x1.014 | x1.008 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32768 | 6.424 | 6.925 | x1.078 | level | 1 of 4 | - | - | x1.081 | x0.990 | x1.058 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 65536 | 5.583 | 5.652 | x1.012 | level | 2 of 4 | - | - | x1.012 | x1.011 | x1.022 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 131072 | 7.693 | 6.818 | x0.886 | level | 2 of 4 | - | - | x0.886 | x1.116 | x0.893 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 262144 | 7.862 | 7.994 | x1.017 | level | 0 of 4 | - | - | x1.016 | x1.008 | x1.007 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.693 | 0.677 | x0.976 | level | 2 of 4 | x0.712 | - | x0.976 | x0.977 | x0.886 |
| blake3-servil-mt / solo / ContinuousMessages / 128 B | 0.347 | 0.342 | x0.987 | level | 2 of 4 | x0.784 | - | x0.989 | x0.977 | x0.937 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.185 | 0.181 | x0.978 | level | 2 of 4 | x0.946 | - | x0.979 | x0.977 | x1.168 |
| blake3-servil-mt / solo / ContinuousMessages / 512 B | 0.111 | 0.108 | x0.974 | level | 4 of 4 | x0.877 | - | x0.974 | x0.981 | x0.942 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.0789 | 0.0733 | x0.930 | level | 4 of 4 | x0.888 | - | x0.932 | x0.988 | x1.064 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0717 | 0.0708 | x0.988 | level | 3 of 4 | x0.910 | - | x0.998 | x0.995 | x0.847 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0518 | 0.0523 | x1.010 | level | 2 of 4 | x0.958 | - | x1.015 | x1.010 | x0.924 |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.0497 | 0.0486 | x0.978 | level | 2 of 4 | x1.017 | - | x0.973 | x1.012 | x1.067 |
| blake3-servil-mt / solo / ContinuousMessages / 256 KiB | 0.0472 | 0.0447 | x0.946 | level | 3 of 4 | x0.978 | - | x0.947 | x1.010 | x1.171 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0470 | 0.0431 | x0.918 | level | 4 of 4 | x0.957 | - | x0.919 | x1.008 | x1.232 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.0455 | 0.0448 | x0.984 | level | 2 of 4 | x0.964 | - | x0.982 | x1.011 | x1.048 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0463 | 0.0447 | x0.966 | level | 1 of 4 | x1.006 | - | x0.963 | x1.012 | x1.109 |
| blake3-servil-mt / solo / ContinuousMessages / 64 MiB | 0.0608 | 0.0610 | x1.004 | level | 2 of 4 | x1.002 | - | x1.005 | x1.009 | x0.992 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 6.272 | 6.040 | x0.963 | level | 4 of 4 | x0.966 | - | x0.962 | x0.977 | x0.994 |
| blake3-servil-mt / solo / ContinuousBatches / 64 | 3.824 | 3.973 | x1.039 | level | 0 of 4 | x1.030 | - | x1.036 | x0.989 | x0.955 |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 3.455 | 3.482 | x1.008 | level | 2 of 4 | x0.960 | - | x1.007 | x0.997 | x0.975 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 3.405 | 3.462 | x1.017 | level | 2 of 4 | x0.978 | - | x1.016 | x0.982 | x0.918 |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 3.918 | 4.019 | x1.026 | level | 1 of 4 | x1.013 | - | x1.028 | x0.989 | x0.928 |
| blake3-servil-mt / solo / ContinuousBatches / 16384 | 4.170 | 4.045 | x0.970 | level | 2 of 4 | x0.975 | - | x0.965 | x0.965 | x0.963 |
| blake3-servil-mt / solo / ContinuousBatches / 65536 | 3.124 | 3.725 | x1.193 | level | 1 of 4 | x1.243 | - | x1.194 | x0.954 | x1.107 |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.957 | 0.987 | x1.032 | level | 0 of 4 | x1.032 | - | x1.032 | x1.010 | x1.103 |
| blake3-servil-mt / solo / LentMessages / 128 B | 0.954 | 0.968 | x1.015 | level | 0 of 4 | x1.015 | - | x1.016 | x1.006 | x1.100 |
| blake3-servil-mt / solo / LentMessages / 256 B | 0.935 | 0.939 | x1.005 | level | 0 of 4 | x1.005 | - | x1.005 | x1.003 | x1.231 |
| blake3-servil-mt / solo / LentMessages / 512 B | 0.932 | 0.940 | x1.009 | level | 0 of 4 | x1.009 | - | x1.009 | x1.002 | x1.334 |
| blake3-servil-mt / solo / LentMessages / 1 KiB | 0.928 | 0.932 | x1.004 | level | 0 of 4 | x1.004 | - | x1.002 | x1.001 | x1.023 |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.317 | 0.317 | x0.998 | level | 3 of 4 | x0.998 | - | x0.999 | x1.000 | x0.580 |
| blake3-servil-mt / solo / LentMessages / 16 KiB | 0.215 | 0.215 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.859 |
| blake3-servil-mt / solo / LentMessages / 64 KiB | 0.216 | 0.216 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.872 |
| blake3-servil-mt / solo / LentMessages / 256 KiB | 0.219 | 0.219 | x0.998 | level | 2 of 4 | x0.998 | - | x0.998 | x1.000 | x0.986 |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.0776 | 0.0787 | x1.013 | level | 1 of 4 | x1.017 | - | x1.014 | x0.991 | x0.961 |
| blake3-servil-mt / solo / LentMessages / 4 MiB | 0.0661 | 0.0662 | x1.002 | level | 3 of 4 | x0.999 | - | x1.014 | x0.998 | x1.020 |
| blake3-servil-mt / solo / LentMessages / 16 MiB | 0.0903 | 0.0944 | x1.045 | level | 1 of 4 | x1.031 | - | x1.045 | x1.005 | x1.028 |
| blake3-servil-mt / solo / LentMessages / 64 MiB | 0.0813 | 0.0817 | x1.005 | level | 1 of 4 | x0.998 | - | x1.006 | x0.997 | x1.004 |
| blake3-servil-mt / solo / Interleaved / 256 | 0.260 | 0.260 | x0.998 | level | 2 of 4 | x0.998 | - | x0.998 | x0.992 | x0.985 |
| blake3-servil-mt / solo / Collection / git objects | 0.0140 | 0.0139 | x0.997 | level | 2 of 4 | x0.981 | - | x0.995 | x0.998 | x1.000 |
| blake3-servil-mt / solo / Collection / Nix files | 0.0214 | 0.0208 | x0.975 | level | 4 of 4 | x0.941 | - | x0.999 | x1.006 | x1.006 |
| blake3-servil-mt / solo / LentBatches / 16 | 16.291 | 15.968 | x0.980 | level | 3 of 4 | x0.980 | - | x0.979 | x0.999 | x0.888 |
| blake3-servil-mt / solo / LentBatches / 64 | 13.736 | 13.693 | x0.997 | level | 2 of 4 | x0.997 | - | x0.997 | x1.000 | x0.795 |
| blake3-servil-mt / solo / LentBatches / 256 | 13.667 | 13.654 | x0.999 | level | 3 of 4 | x0.999 | - | x0.997 | x1.000 | x0.973 |
| blake3-servil-mt / solo / LentBatches / 1024 | 13.851 | 13.840 | x0.999 | level | 1 of 4 | x0.999 | - | x0.999 | x1.000 | x1.399 |
| blake3-servil-mt / solo / LentBatches / 4096 | 14.458 | 14.437 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.996 |
| blake3-servil-mt / solo / LentBatches / 16384 | 5.398 | 5.284 | x0.979 | level | 4 of 4 | x1.020 | - | x0.973 | x0.985 | x0.990 |
| blake3-servil-mt / solo / LentBatches / 65536 | 5.157 | 4.900 | x0.950 | level | 1 of 4 | x0.841 | - | x0.937 | x0.997 | x0.991 |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.0635 | 0.0642 | x1.011 | level | 2 of 4 | x0.997 | - | x1.011 | x1.004 | x1.026 |
| blake3-servil-mt / solo / ContinuousCollection / Nix files | 0.0646 | 0.0647 | x1.003 | level | 3 of 4 | x0.982 | - | x1.002 | x1.004 | x0.972 |
| blake3-servil-mt / solo / MerkleTree / 1024 | 0.260 | 0.262 | x1.008 | level | 1 of 4 | x1.007 | - | x1.006 | x1.000 | x1.049 |
| blake3-servil-mt / solo / MerkleTree / 4096 | 0.134 | 0.130 | x0.970 | level | 3 of 4 | x0.964 | - | x0.976 | x0.998 | x1.035 |
| blake3-servil-mt / solo / MerkleTree / 16384 | 0.136 | 0.137 | x1.006 | level | 2 of 4 | x1.000 | - | x1.008 | x0.998 | x0.980 |
| blake3-servil-mt / solo / MerkleTree / 65536 | 0.149 | 0.150 | x1.000 | level | 3 of 4 | x1.011 | - | x1.000 | x1.000 | x1.024 |
| blake3-servil-mt / solo / MerkleTree / 262144 | 0.351 | 0.341 | x0.970 | level | 4 of 4 | x0.908 | - | x0.969 | x1.023 | x0.962 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 32 B | 0.273 | 0.281 | x1.030 | level | 1 of 4 | x1.136 | - | x1.047 | x0.953 | x1.069 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 32 B | 0.434 | 0.433 | x0.996 | level | 2 of 4 | x0.997 | - | x0.994 | x0.988 | x0.987 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 16 B | 0.346 | 0.346 | x1.000 | level | 2 of 4 | x1.001 | - | x0.995 | x0.990 | x1.020 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 48 B | 0.181 | 0.191 | x1.059 | level | 1 of 4 | x1.191 | - | x1.053 | x0.964 | x1.217 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 48 B | 0.397 | 0.397 | x1.000 | level | 2 of 4 | x0.982 | - | x1.000 | x0.984 | x0.996 |
| blake3-servil-mt / solo / InterleavedTurn / 256 | 0.780 | 0.793 | x1.017 | level | 1 of 4 | - | - | x0.988 | x0.904 | x1.009 |
| blake3-servil-mt / solo / InterleavedTurn / 1024 x 1 KiB | 0.326 | 0.331 | x1.014 | level | 1 of 4 | - | - | x1.011 | x0.999 | x0.997 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 256 | 0.765 | 0.753 | x0.984 | level | 2 of 4 | - | - | x0.961 | x0.886 | x1.005 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.490 | 0.490 | x1.001 | level | 2 of 4 | - | - | x1.024 | x0.999 | x1.013 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 256 | 0.554 | 0.554 | x1.000 | level | 2 of 4 | - | - | x0.959 | x0.853 | x0.992 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.296 | 0.293 | x0.989 | level | 3 of 4 | - | - | x0.987 | x1.001 | x1.030 |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.0459 | 0.0466 | x1.015 | level | 1 of 4 | x0.931 | - | x1.018 | x1.006 | x1.013 |
| blake3-servil-mt / solo / ReceivingMessage / 2 μs | 0.0929 | 0.0929 | x1.000 | level | 1 of 4 | x0.958 | - | x0.938 | x0.998 | x1.035 |
| blake3-servil-mt / solo / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 4 of 4 | x1.078 | - | x0.984 | x0.953 | x1.030 |
| blake3-servil-mt / solo / IncrementalMessage / 64 B | 7.825 | 7.770 | x0.993 | level | 3 of 4 | - | - | x0.986 | x1.007 | x1.036 |
| blake3-servil-mt / solo / IncrementalMessage / 1 KiB | 1.521 | 1.538 | x1.011 | level | 2 of 4 | - | - | x0.984 | x1.002 | x0.986 |
| blake3-servil-mt / solo / IncrementalMessage / 4 KiB | 0.699 | 0.706 | x1.010 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.016 |
| blake3-servil-mt / solo / LentIncrementalMessage / 64 B | 1.274 | 1.271 | x0.998 | level | 2 of 4 | x0.998 | - | x0.999 | x1.005 | x1.315 |
| blake3-servil-mt / solo / LentIncrementalMessage / 1 KiB | 0.952 | 0.955 | x1.003 | level | 0 of 4 | x1.003 | - | x1.002 | x1.001 | x1.416 |
| blake3-servil-mt / solo / LentIncrementalMessage / 4 KiB | 0.329 | 0.329 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.852 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 5.474 | 5.122 | x0.936 | level | 3 of 4 | x0.893 | - | x0.937 | x0.998 | x1.056 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 4 KiB | 0.146 | 0.153 | x1.046 | level | 2 of 4 | x1.028 | - | x1.048 | x1.005 | x1.050 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 1 MiB | 0.0465 | 0.0444 | x0.955 | level | 2 of 4 | x1.056 | - | x0.951 | x1.009 | x1.175 |
| blake3-servil-mt / solo / ContinuousLentMessages / 64 B | 0.603 | 0.586 | x0.972 | level | 2 of 4 | x0.781 | - | x0.975 | x0.971 | x0.886 |
| blake3-servil-mt / solo / ContinuousLentMessages / 4 KiB | 0.0380 | 0.0372 | x0.978 | level | 3 of 4 | x0.988 | - | x0.983 | x0.965 | x0.954 |
| blake3-servil-mt / solo / ContinuousLentMessages / 1 MiB | 0.00879 | 0.00875 | x0.996 | level | 3 of 4 | x1.005 | - | x0.994 | x0.999 | x0.971 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.676 | 0.650 | x0.961 | level | 2 of 4 | - | - | x0.961 | x0.977 | x0.953 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 128 B | 0.334 | 0.330 | x0.990 | level | 2 of 4 | - | - | x0.987 | x0.977 | x1.144 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.184 | 0.189 | x1.031 | level | 1 of 4 | - | - | x1.031 | x0.978 | x1.278 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 512 B | 0.128 | 0.128 | x1.002 | level | 1 of 4 | - | - | x1.006 | x0.980 | x1.028 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.0962 | 0.0965 | x1.003 | level | 2 of 4 | - | - | x0.998 | x0.991 | x1.014 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.120 | 0.116 | x0.971 | level | 3 of 4 | - | - | x0.980 | x1.011 | x0.981 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.0919 | 0.0886 | x0.964 | level | 4 of 4 | - | - | x0.986 | x1.012 | x0.945 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.0754 | 0.0759 | x1.008 | level | 1 of 4 | - | - | x1.008 | x1.007 | x0.952 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 KiB | 0.0747 | 0.0753 | x1.009 | level | 1 of 4 | - | - | x1.011 | x1.006 | x0.954 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0753 | 0.0755 | x1.003 | level | 2 of 4 | - | - | x1.001 | x1.009 | x1.049 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.0780 | 0.0784 | x1.006 | level | 2 of 4 | - | - | x0.996 | x1.009 | x0.983 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.0755 | 0.0763 | x1.011 | level | 1 of 4 | - | - | x1.008 | x1.009 | x0.982 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 MiB | 0.0762 | 0.0786 | x1.031 | level | 0 of 4 | - | - | x1.035 | x1.010 | x0.976 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 7.396 | 7.225 | x0.977 | level | 3 of 4 | - | - | x0.971 | x0.975 | x0.981 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 64 | 5.572 | 5.449 | x0.978 | level | 4 of 4 | - | - | x0.973 | x0.992 | x0.972 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 256 | 5.305 | 5.370 | x1.012 | level | 1 of 4 | - | - | x1.009 | x0.994 | x1.026 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 5.052 | 4.960 | x0.982 | level | 3 of 4 | - | - | x0.984 | x0.992 | x0.972 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 4096 | 6.189 | 5.844 | x0.944 | level | 3 of 4 | - | - | x0.945 | x1.001 | x1.016 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16384 | 4.666 | 5.218 | x1.118 | level | 1 of 4 | - | - | x1.119 | x0.947 | x1.214 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 65536 | 6.594 | 6.632 | x1.006 | level | 2 of 4 | - | - | x1.004 | x1.031 | x0.938 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.949 | 0.983 | x1.036 | level | 0 of 4 | - | - | x1.035 | x1.010 | x1.207 |
| blake3-servil-mt / shared-one-cache / LentMessages / 128 B | 0.952 | 0.970 | x1.019 | level | 0 of 4 | - | - | x1.018 | x1.006 | x0.854 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 B | 0.933 | 0.937 | x1.004 | level | 1 of 4 | - | - | x1.004 | x1.003 | x0.879 |
| blake3-servil-mt / shared-one-cache / LentMessages / 512 B | 0.928 | 0.934 | x1.006 | level | 0 of 4 | - | - | x1.006 | x1.002 | x1.121 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 KiB | 0.926 | 0.927 | x1.002 | level | 0 of 4 | - | - | x1.002 | x1.001 | x0.987 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.319 | 0.316 | x0.991 | level | 4 of 4 | - | - | x0.992 | x1.000 | x1.174 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 KiB | 0.215 | 0.215 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.759 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 KiB | 0.216 | 0.220 | x1.023 | level | 1 of 4 | - | - | x0.999 | x1.000 | x0.836 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 KiB | 0.219 | 0.220 | x1.007 | level | 1 of 4 | - | - | x1.007 | x1.000 | x0.907 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 MiB | 0.0983 | 0.0983 | x1.001 | level | 2 of 4 | - | - | x0.999 | x1.050 | x1.022 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 MiB | 0.0720 | 0.0736 | x1.023 | level | 2 of 4 | - | - | x1.027 | x1.030 | x1.081 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 MiB | 0.139 | 0.136 | x0.979 | level | 3 of 4 | - | - | x0.972 | x0.998 | x0.976 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 MiB | 0.110 | 0.110 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.006 | x0.992 |
| blake3-servil-mt / shared-one-cache / Interleaved / 256 | 0.266 | 0.267 | x1.001 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.995 |
| blake3-servil-mt / shared-one-cache / Collection / git objects | 0.0305 | 0.0306 | x1.001 | level | 2 of 4 | - | - | x1.003 | x0.990 | x1.002 |
| blake3-servil-mt / shared-one-cache / Collection / Nix files | 0.0320 | 0.0341 | x1.064 | level | 1 of 4 | - | - | x1.027 | x1.034 | x1.043 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16 | 16.233 | 15.842 | x0.976 | level | 3 of 4 | - | - | x0.976 | x0.999 | x1.002 |
| blake3-servil-mt / shared-one-cache / LentBatches / 64 | 13.673 | 13.663 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.203 |
| blake3-servil-mt / shared-one-cache / LentBatches / 256 | 13.651 | 13.560 | x0.993 | level | 3 of 4 | - | - | x0.993 | x1.000 | x0.757 |
| blake3-servil-mt / shared-one-cache / LentBatches / 1024 | 13.785 | 13.793 | x1.001 | level | 1 of 4 | - | - | x0.998 | x1.000 | x0.991 |
| blake3-servil-mt / shared-one-cache / LentBatches / 4096 | 14.389 | 14.882 | x1.034 | level | 2 of 4 | - | - | x1.004 | x1.000 | x0.967 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16384 | 6.265 | 6.400 | x1.022 | level | 1 of 4 | - | - | x1.021 | x1.034 | x1.178 |
| blake3-servil-mt / shared-one-cache / LentBatches / 65536 | 6.180 | 6.829 | x1.105 | level | 2 of 4 | - | - | x1.103 | x1.011 | x1.284 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.0933 | 0.0924 | x0.991 | level | 2 of 4 | - | - | x0.990 | x1.003 | x0.940 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / Nix files | 0.0929 | 0.0926 | x0.997 | level | 2 of 4 | - | - | x0.997 | x1.005 | x0.980 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1024 | 0.263 | 0.262 | x0.996 | level | 1 of 4 | - | - | x0.997 | x1.000 | x1.088 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 4096 | 0.144 | 0.156 | x1.084 | level | 1 of 4 | - | - | x1.091 | x1.006 | x1.072 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 16384 | 0.168 | 0.164 | x0.977 | level | 3 of 4 | - | - | x0.974 | x1.021 | x0.872 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 | 0.234 | 0.245 | x1.046 | level | 1 of 4 | - | - | x1.046 | x0.936 | x1.068 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 262144 | 0.353 | 0.351 | x0.995 | level | 2 of 4 | - | - | x0.996 | x1.018 | x0.995 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 32 B | 0.366 | 0.361 | x0.986 | level | 3 of 4 | - | - | x0.987 | x1.024 | x1.011 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 32 B | 0.516 | 0.528 | x1.024 | level | 2 of 4 | - | - | x1.020 | x1.046 | x1.005 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 16 B | 0.586 | 0.574 | x0.979 | level | 2 of 4 | - | - | x0.982 | x1.055 | x0.954 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 48 B | 0.296 | 0.303 | x1.025 | level | 0 of 4 | - | - | x1.023 | x0.962 | x0.986 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 48 B | 0.437 | 0.436 | x0.997 | level | 2 of 4 | - | - | x1.000 | x0.979 | x0.996 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.0786 | 0.0779 | x0.991 | level | 2 of 4 | - | - | x0.989 | x1.000 | x0.976 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 2 μs | 0.0958 | 0.0949 | x0.991 | level | 4 of 4 | - | - | x0.995 | x1.001 | x0.975 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 4 of 4 | - | - | x1.010 | x0.991 | x0.974 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 64 B | 1.269 | 1.305 | x1.028 | level | 1 of 4 | - | - | x1.006 | x1.005 | x1.181 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 1 KiB | 0.950 | 0.952 | x1.002 | level | 0 of 4 | - | - | x1.002 | x1.001 | x1.080 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 4 KiB | 0.328 | 0.328 | x0.999 | level | 3 of 4 | - | - | x1.000 | x1.001 | x0.874 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 15.762 | 15.752 | x0.999 | level | 1 of 4 | - | - | x0.963 | x0.993 | x1.006 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 4 KiB | 0.237 | 0.242 | x1.021 | level | 2 of 4 | - | - | x1.106 | x0.994 | x1.042 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 1 MiB | 0.0779 | 0.0783 | x1.005 | level | 2 of 4 | - | - | x1.007 | x1.004 | x1.001 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 64 B | 0.615 | 0.576 | x0.937 | level | 3 of 4 | - | - | x0.939 | x0.971 | x1.080 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 4 KiB | 0.0794 | 0.0811 | x1.022 | level | 1 of 4 | - | - | x0.972 | x0.982 | x0.864 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 1 MiB | 0.0174 | 0.0165 | x0.949 | level | 3 of 4 | - | - | x1.020 | x1.023 | x0.988 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 B | 1.292 | 0.927 | x0.717 | level | 4 of 4 | - | - | x0.716 | x0.976 | x0.980 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 128 B | 0.675 | 0.564 | x0.835 | level | 3 of 4 | - | - | x0.825 | x0.977 | x1.090 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 256 B | 0.386 | 0.403 | x1.044 | level | 1 of 4 | - | - | x1.028 | x0.977 | x1.247 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 512 B | 0.217 | 0.181 | x0.833 | level | 4 of 4 | - | - | x0.829 | x0.980 | x0.904 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 KiB | 0.142 | 0.115 | x0.810 | level | 4 of 4 | - | - | x0.809 | x0.989 | x0.951 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 4 KiB | 0.104 | 0.108 | x1.038 | level | 2 of 4 | - | - | x1.037 | x0.998 | x0.907 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 16 KiB | 0.0895 | 0.0865 | x0.967 | level | 3 of 4 | - | - | x0.968 | x1.008 | x1.018 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 KiB | 0.0905 | 0.0936 | x1.034 | level | 0 of 4 | - | - | x1.021 | x1.010 | x0.911 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 256 KiB | 0.0905 | 0.0921 | x1.018 | level | 2 of 4 | - | - | x1.005 | x1.011 | x0.995 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 MiB | 0.0910 | 0.0930 | x1.022 | level | 1 of 4 | - | - | x1.009 | x1.010 | x1.022 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 4 MiB | 0.0902 | 0.0939 | x1.040 | level | 2 of 4 | - | - | x1.025 | x1.011 | x0.979 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 16 MiB | 0.0938 | 0.0918 | x0.978 | level | 3 of 4 | - | - | x0.965 | x1.013 | x1.051 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 MiB | 0.110 | 0.111 | x1.007 | level | 1 of 4 | - | - | x0.996 | x1.012 | x0.887 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 16 | 13.393 | 14.624 | x1.092 | level | 1 of 4 | - | - | x1.084 | x0.975 | x0.985 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 64 | 9.296 | 9.469 | x1.019 | level | 1 of 4 | - | - | x1.008 | x0.988 | x0.925 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 256 | 7.972 | 8.065 | x1.012 | level | 1 of 4 | - | - | x1.000 | x0.995 | x0.901 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 1024 | 7.551 | 7.410 | x0.981 | level | 4 of 4 | - | - | x0.966 | x0.983 | x0.880 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 4096 | 8.339 | 8.356 | x1.002 | level | 2 of 4 | - | - | x1.001 | x0.995 | x1.060 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 16384 | 7.932 | 8.073 | x1.018 | level | 1 of 4 | - | - | x1.019 | x1.038 | x1.034 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 65536 | 5.715 | 6.036 | x1.056 | level | 0 of 4 | - | - | x1.057 | x0.976 | x1.149 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 B | 0.951 | 0.983 | x1.033 | level | 0 of 4 | - | - | x1.034 | x1.010 | x1.087 |
| blake3-servil-mt / shared-two-caches / LentMessages / 128 B | 0.954 | 0.967 | x1.014 | level | 0 of 4 | - | - | x1.013 | x1.006 | x1.012 |
| blake3-servil-mt / shared-two-caches / LentMessages / 256 B | 0.934 | 0.938 | x1.005 | level | 0 of 4 | - | - | x1.005 | x1.003 | x1.048 |
| blake3-servil-mt / shared-two-caches / LentMessages / 512 B | 0.930 | 0.937 | x1.007 | level | 0 of 4 | - | - | x1.007 | x1.002 | x1.089 |
| blake3-servil-mt / shared-two-caches / LentMessages / 1 KiB | 0.927 | 0.928 | x1.002 | level | 0 of 4 | - | - | x1.002 | x1.001 | x1.117 |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 KiB | 0.319 | 0.317 | x0.992 | level | 4 of 4 | - | - | x0.991 | x1.000 | x1.018 |
| blake3-servil-mt / shared-two-caches / LentMessages / 16 KiB | 0.215 | 0.215 | x0.999 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.958 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 KiB | 0.216 | 0.216 | x1.001 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.842 |
| blake3-servil-mt / shared-two-caches / LentMessages / 256 KiB | 0.218 | 0.219 | x1.005 | level | 1 of 4 | - | - | x1.004 | x1.000 | x0.964 |
| blake3-servil-mt / shared-two-caches / LentMessages / 1 MiB | 0.107 | 0.103 | x0.972 | level | 3 of 4 | - | - | x0.969 | x0.989 | x1.011 |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 MiB | 0.0869 | 0.0870 | x1.001 | level | 1 of 4 | - | - | x0.999 | x0.997 | x0.995 |
| blake3-servil-mt / shared-two-caches / LentMessages / 16 MiB | 0.0853 | 0.0887 | x1.041 | level | 1 of 4 | - | - | x1.041 | x0.988 | x1.071 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 MiB | 0.0836 | 0.0844 | x1.009 | level | 2 of 4 | - | - | x1.007 | x1.018 | x0.988 |
| blake3-servil-mt / shared-two-caches / Interleaved / 256 | 0.257 | 0.257 | x1.001 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.004 |
| blake3-servil-mt / shared-two-caches / Collection / git objects | 0.0302 | 0.0294 | x0.973 | level | 3 of 4 | - | - | x0.972 | x0.972 | x0.979 |
| blake3-servil-mt / shared-two-caches / Collection / Nix files | 0.0311 | 0.0321 | x1.035 | level | 1 of 4 | - | - | x1.033 | x1.017 | x1.012 |
| blake3-servil-mt / shared-two-caches / LentBatches / 16 | 16.273 | 15.816 | x0.972 | level | 3 of 4 | - | - | x0.973 | x0.999 | x1.025 |
| blake3-servil-mt / shared-two-caches / LentBatches / 64 | 13.681 | 13.673 | x0.999 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.277 |
| blake3-servil-mt / shared-two-caches / LentBatches / 256 | 13.674 | 13.575 | x0.993 | level | 3 of 4 | - | - | x0.993 | x1.000 | x0.737 |
| blake3-servil-mt / shared-two-caches / LentBatches / 1024 | 13.804 | 13.776 | x0.998 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.990 |
| blake3-servil-mt / shared-two-caches / LentBatches / 4096 | 14.367 | 14.337 | x0.998 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.973 |
| blake3-servil-mt / shared-two-caches / LentBatches / 16384 | 7.678 | 7.854 | x1.023 | level | 2 of 4 | - | - | x1.020 | x1.000 | x0.994 |
| blake3-servil-mt / shared-two-caches / LentBatches / 65536 | 6.230 | 6.141 | x0.986 | level | 2 of 4 | - | - | x0.985 | x0.998 | x0.978 |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / git objects | 0.103 | 0.104 | x1.014 | level | 1 of 4 | - | - | x1.012 | x1.005 | x0.975 |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / Nix files | 0.105 | 0.106 | x1.003 | level | 2 of 4 | - | - | x1.001 | x1.005 | x1.018 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1024 | 0.262 | 0.261 | x0.995 | level | 1 of 4 | - | - | x0.995 | x1.000 | x1.079 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 4096 | 0.134 | 0.132 | x0.982 | level | 2 of 4 | - | - | x0.981 | x0.998 | x0.995 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 16384 | 0.139 | 0.147 | x1.058 | level | 1 of 4 | - | - | x1.059 | x1.008 | x0.988 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 | 0.177 | 0.177 | x1.001 | level | 2 of 4 | - | - | x0.999 | x1.021 | x0.971 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 262144 | 0.346 | 0.345 | x0.997 | level | 3 of 4 | - | - | x0.997 | x0.997 | x1.000 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 x 32 B | 0.354 | 0.354 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.009 | x0.997 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 32 B | 0.491 | 0.498 | x1.013 | level | 3 of 4 | - | - | x1.011 | x0.982 | x1.009 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 16 B | 0.524 | 0.523 | x0.998 | level | 2 of 4 | - | - | x0.978 | x0.923 | x1.159 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 x 48 B | 0.282 | 0.286 | x1.013 | level | 0 of 4 | - | - | x1.010 | x0.987 | x1.000 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 48 B | 0.432 | 0.428 | x0.991 | level | 3 of 4 | - | - | x0.992 | x1.026 | x0.996 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / saturated | 0.0941 | 0.0913 | x0.971 | level | 4 of 4 | - | - | x0.958 | x1.018 | x1.057 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / 2 μs | 0.105 | 0.103 | x0.987 | level | 2 of 4 | - | - | x1.017 | x1.013 | x1.016 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 4 of 4 | - | - | x0.606 | x0.961 | x0.783 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 64 B | 1.271 | 1.276 | x1.004 | level | 1 of 4 | - | - | x1.004 | x1.005 | x0.844 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 1 KiB | 0.951 | 0.953 | x1.002 | level | 0 of 4 | - | - | x1.002 | x1.001 | x0.866 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 4 KiB | 0.328 | 0.328 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.001 | x1.259 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 64 B | 16.643 | 16.571 | x0.996 | level | 2 of 4 | - | - | x0.998 | x0.996 | x1.016 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 4 KiB | 0.231 | 0.229 | x0.993 | level | 2 of 4 | - | - | x0.998 | x1.008 | x0.952 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 1 MiB | 0.0909 | 0.0955 | x1.051 | level | 1 of 4 | - | - | x1.035 | x1.010 | x0.961 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 64 B | 0.654 | 0.630 | x0.963 | level | 4 of 4 | - | - | x0.960 | x0.971 | x1.129 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 4 KiB | 0.0671 | 0.0681 | x1.014 | level | 1 of 4 | - | - | x1.001 | x0.984 | x0.861 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 1 MiB | 0.0207 | 0.0175 | x0.846 | level | 3 of 4 | - | - | x0.773 | x0.774 | x0.715 |

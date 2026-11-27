# Nightly drift check: e1966b498bc7 -> 17ccf2c8f5bb

- Host: fast-feedback-icelake-147
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
| blake3-servil-st / solo / ManyLongMessages / 16 | 4945.924 | 4238.021 | x0.857 | faster | 64 of 64 | - | - | x0.858 | x0.566 | x1.116 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4 | 59.092 | 59.817 | x1.012 | level | 26 of 64 | - | - | x1.001 | x0.998 | - |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 1.517 | 1.520 | x1.002 | level | 19 of 64 | x1.002 | - | x1.002 | x1.012 | x0.806 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 1.460 | 1.468 | x1.005 | level | 25 of 64 | x1.005 | - | x1.006 | x1.013 | - |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 1.385 | 1.386 | x1.001 | level | 39 of 64 | x1.001 | - | x1.001 | x1.015 | - |
| blake3-servil-mt / solo / IdleOneMessage / 2 KiB | 6.557 | 6.535 | x0.997 | level | 32 of 64 | - | - | x1.000 | x1.000 | - |
| blake3-servil-mt / solo / IdleOneMessage / 7935 B | 2.522 | 2.530 | x1.003 | level | 32 of 64 | - | - | x1.000 | x1.000 | x0.793 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 12.544 | 12.406 | x0.989 | level | 47 of 64 | x1.046 | - | x0.979 | x0.942 | x2.617 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 16.941 | 16.951 | x1.001 | level | 29 of 64 | - | - | x1.002 | x0.941 | x9.354 |

## Stage 1 (initial screen, kept-drift)

compare: old side: bench 3f119a507807 clean; servil e1966b498bc7 clean
compare: new side: bench 3f119a507807 clean; servil 17ccf2c8f5bb clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 18.843 | 18.707 | x0.993 | level | 2 of 4 | - | - | x1.009 | x1.007 | x1.159 |
| blake3-servil-st / solo / OneMessage / 128 B | 10.977 | 10.892 | x0.992 | level | 2 of 4 | - | - | x0.995 | x1.005 | x1.104 |
| blake3-servil-st / solo / OneMessage / 256 B | 6.090 | 6.027 | x0.990 | level | 2 of 4 | - | - | x0.992 | x1.004 | x1.129 |
| blake3-servil-st / solo / OneMessage / 512 B | 3.807 | 3.742 | x0.983 | level | 3 of 4 | - | - | x0.995 | x1.002 | x1.152 |
| blake3-servil-st / solo / OneMessage / 1 KiB | 2.675 | 2.587 | x0.967 | level | 3 of 4 | - | - | x0.980 | x1.001 | x1.109 |
| blake3-servil-st / solo / OneMessage / 1536 B | 4.677 | 4.723 | x1.010 | level | 2 of 4 | - | - | x1.013 | x0.998 | x1.053 |
| blake3-servil-st / solo / OneMessage / 2 KiB | 4.228 | 4.210 | x0.996 | level | 3 of 4 | - | - | x1.000 | x1.001 | x1.047 |
| blake3-servil-st / solo / OneMessage / 2304 B | 4.508 | 4.460 | x0.989 | level | 3 of 4 | - | - | x0.986 | x1.002 | x1.030 |
| blake3-servil-st / solo / OneMessage / 3 KiB | 3.133 | 3.092 | x0.987 | level | 3 of 4 | - | - | x0.988 | x1.001 | x0.978 |
| blake3-servil-st / solo / OneMessage / 3839 B | 2.755 | 2.747 | x0.997 | level | 3 of 4 | - | - | x1.001 | x1.001 | x1.042 |
| blake3-servil-st / solo / OneMessage / 4 KiB | 2.326 | 2.312 | x0.994 | level | 2 of 4 | - | - | x0.993 | x1.001 | x1.051 |
| blake3-servil-st / solo / OneMessage / 4470 B | 2.560 | 2.497 | x0.976 | level | 3 of 4 | - | - | x0.977 | x1.001 | x1.032 |
| blake3-servil-st / solo / OneMessage / 7935 B | 2.040 | 2.039 | x1.000 | level | 2 of 4 | - | - | x1.002 | x1.001 | x1.056 |
| blake3-servil-st / solo / OneMessage / 8 KiB | 1.884 | 1.844 | x0.978 | level | 1 of 4 | - | - | x1.006 | x1.000 | x1.060 |
| blake3-servil-st / solo / OneMessage / 16 KiB | 1.342 | 1.329 | x0.990 | level | 3 of 4 | - | - | x0.997 | x1.001 | x1.028 |
| blake3-servil-st / solo / OneMessage / 32 KiB | 1.243 | 1.240 | x0.997 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.005 |
| blake3-servil-st / solo / OneMessage / 64 KiB | 1.062 | 1.051 | x0.990 | level | 3 of 4 | - | - | x0.989 | x1.000 | x1.003 |
| blake3-servil-st / solo / OneMessage / 128 KiB | 0.673 | 0.671 | x0.997 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.993 |
| blake3-servil-st / solo / OneMessage / 256 KiB | 0.484 | 0.483 | x0.999 | level | 2 of 4 | - | - | x1.005 | x1.000 | x1.001 |
| blake3-servil-st / solo / OneMessage / 512 KiB | 0.420 | 0.424 | x1.009 | level | 0 of 4 | - | - | x1.007 | x1.000 | x0.998 |
| blake3-servil-st / solo / OneMessage / 1 MiB | 0.394 | 0.394 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.007 |
| blake3-servil-st / solo / OneMessage / 2 MiB | 0.385 | 0.386 | x1.003 | level | 0 of 4 | - | - | x1.002 | x1.000 | x1.032 |
| blake3-servil-st / solo / OneMessage / 3 MiB | 0.382 | 0.382 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.028 |
| blake3-servil-st / solo / OneMessage / 4 MiB | 0.378 | 0.379 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.009 |
| blake3-servil-st / solo / OneMessage / 8 MiB | 0.379 | 0.382 | x1.006 | level | 0 of 4 | - | - | x1.006 | x1.000 | x1.048 |
| blake3-servil-st / solo / OneMessage / 32 MiB | 0.355 | 0.354 | x0.997 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.002 |
| blake3-servil-st / solo / OneMessage / 64 MiB | 0.354 | 0.354 | x1.002 | level | 0 of 4 | - | - | x1.000 | x1.000 | x1.001 |
| blake3-servil-st / solo / OneMessage / 128 MiB | 0.354 | 0.354 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.001 |
| blake3-servil-st / solo / ManyMessages / 1 | 1058.594 | 1024.438 | x0.968 | level | 2 of 4 | - | - | x0.982 | x1.009 | x0.990 |
| blake3-servil-st / solo / ManyMessages / 2 | 854.625 | 860.385 | x1.007 | level | 2 of 4 | - | - | x1.005 | x0.998 | x0.924 |
| blake3-servil-st / solo / ManyMessages / 3 | 661.179 | 685.621 | x1.037 | level | 1 of 4 | - | - | x1.017 | x0.999 | x0.934 |
| blake3-servil-st / solo / ManyMessages / 4 | 412.592 | 415.090 | x1.006 | level | 2 of 4 | - | - | x0.999 | x0.998 | x0.940 |
| blake3-servil-st / solo / ManyMessages / 6 | 365.699 | 363.257 | x0.993 | level | 3 of 4 | - | - | x0.998 | x0.998 | x0.926 |
| blake3-servil-st / solo / ManyMessages / 8 | 274.314 | 264.924 | x0.966 | level | 3 of 4 | - | - | x0.988 | x0.999 | x0.925 |
| blake3-servil-st / solo / ManyMessages / 12 | 219.163 | 213.560 | x0.974 | level | 3 of 4 | - | - | x0.982 | x0.999 | x0.911 |
| blake3-servil-st / solo / ManyMessages / 16 | 153.746 | 156.707 | x1.019 | level | 1 of 4 | - | - | x1.001 | x0.999 | x0.925 |
| blake3-servil-st / solo / ManyMessages / 24 | 138.414 | 138.867 | x1.003 | level | 2 of 4 | - | - | x1.008 | x0.999 | x0.934 |
| blake3-servil-st / solo / ManyMessages / 32 | 111.880 | 111.222 | x0.994 | level | 2 of 4 | - | - | x0.998 | x0.999 | x0.924 |
| blake3-servil-st / solo / ManyMessages / 48 | 99.264 | 98.740 | x0.995 | level | 2 of 4 | - | - | x0.995 | x0.999 | x0.897 |
| blake3-servil-st / solo / ManyMessages / 64 | 91.941 | 92.280 | x1.004 | level | 2 of 4 | - | - | x1.005 | x1.000 | x0.926 |
| blake3-servil-st / solo / ManyMessages / 128 | 84.438 | 84.498 | x1.001 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.966 |
| blake3-servil-st / solo / ManyMessages / 256 | 80.327 | 79.751 | x0.993 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.975 |
| blake3-servil-st / solo / ManyMessages / 512 | 77.903 | 77.896 | x1.000 | level | 2 of 4 | - | - | x1.004 | x1.000 | x0.997 |
| blake3-servil-st / solo / ManyMessages / 1024 | 66.180 | 65.672 | x0.992 | level | 3 of 4 | - | - | x0.990 | x1.000 | x1.003 |
| blake3-servil-st / solo / ManyMessages / 2048 | 42.482 | 42.141 | x0.992 | level | 4 of 4 | - | - | x0.994 | x1.000 | x0.981 |
| blake3-servil-st / solo / ManyMessages / 4096 | 31.167 | 31.203 | x1.001 | level | 1 of 4 | - | - | x0.999 | x1.000 | x1.003 |
| blake3-servil-st / solo / ManyMessages / 8192 | 27.359 | 27.392 | x1.001 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.019 |
| blake3-servil-st / solo / ManyMessages / 16384 | 25.240 | 25.290 | x1.002 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.981 |
| blake3-servil-st / solo / ManyMessages / 32768 | 24.679 | 24.838 | x1.006 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.021 |
| blake3-servil-st / solo / ManyMessages / 65536 | 24.524 | 24.517 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.987 |
| blake3-servil-st / solo / ManyMessages / 131072 | 24.734 | 24.839 | x1.004 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.013 |
| blake3-servil-st / solo / ManyMessages / 262144 | 25.394 | 25.372 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.000 |
| blake3-servil-st / solo / ManyLongMessages / 4 | 8202.995 | 8256.021 | x1.006 | level | 1 of 4 | - | - | x0.997 | x1.001 | x1.004 |
| blake3-servil-st / solo / ManyLongMessages / 16 | 4882.781 | 4265.198 | x0.874 | level | 4 of 4 | - | - | x0.864 | x0.566 | x1.114 |
| blake3-servil-st / solo / ManyLongMessages / 64 | 1981.148 | 1985.046 | x1.002 | level | 3 of 4 | - | - | x0.995 | x1.002 | x0.978 |
| blake3-servil-st / solo / ManyLongMessages / 256 | 1612.509 | 1603.876 | x0.995 | level | 3 of 4 | - | - | x0.995 | x1.002 | x0.983 |
| blake3-servil-st / solo / IdleOneMessage / 64 B | 8.389 | 8.637 | x1.030 | level | 2 of 4 | - | - | x1.007 | x1.006 | x0.758 |
| blake3-servil-st / solo / IdleOneMessage / 128 B | 6.154 | 6.306 | x1.025 | level | 1 of 4 | - | - | x1.010 | x1.005 | x0.857 |
| blake3-servil-st / solo / IdleOneMessage / 256 B | 4.548 | 4.780 | x1.051 | level | 0 of 4 | - | - | x1.005 | x1.003 | x0.820 |
| blake3-servil-st / solo / IdleOneMessage / 512 B | 4.185 | 4.089 | x0.977 | level | 2 of 4 | - | - | x0.997 | x1.002 | x0.782 |
| blake3-servil-st / solo / IdleOneMessage / 1 KiB | 3.814 | 3.742 | x0.981 | level | 3 of 4 | - | - | x1.001 | x1.001 | x0.682 |
| blake3-servil-st / solo / IdleOneMessage / 1536 B | 7.755 | 7.414 | x0.956 | level | 3 of 4 | - | - | x1.021 | x0.998 | x2.515 |
| blake3-servil-st / solo / IdleOneMessage / 2 KiB | 6.452 | 6.505 | x1.008 | level | 1 of 4 | - | - | x1.001 | x1.001 | x1.123 |
| blake3-servil-st / solo / IdleOneMessage / 2304 B | 6.735 | 6.726 | x0.999 | level | 2 of 4 | - | - | x0.992 | x1.001 | x0.394 |
| blake3-servil-st / solo / IdleOneMessage / 3 KiB | 4.663 | 4.616 | x0.990 | level | 2 of 4 | - | - | x0.990 | x1.000 | x0.656 |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 3.727 | 3.813 | x1.023 | level | 1 of 4 | - | - | x0.996 | x1.001 | x0.977 |
| blake3-servil-st / solo / IdleOneMessage / 4 KiB | 3.514 | 3.385 | x0.963 | level | 3 of 4 | - | - | x1.002 | x1.001 | x1.586 |
| blake3-servil-st / solo / IdleOneMessage / 4470 B | 3.641 | 3.792 | x1.041 | level | 1 of 4 | - | - | x1.003 | x1.001 | x1.013 |
| blake3-servil-st / solo / IdleOneMessage / 7935 B | 2.557 | 2.471 | x0.966 | level | 4 of 4 | - | - | x1.002 | x1.001 | x2.037 |
| blake3-servil-st / solo / IdleOneMessage / 8 KiB | 2.420 | 2.425 | x1.002 | level | 1 of 4 | - | - | x0.999 | x1.000 | x0.546 |
| blake3-servil-st / solo / IdleOneMessage / 16 KiB | 1.593 | 1.506 | x0.945 | level | 4 of 4 | - | - | x1.005 | x1.000 | x1.101 |
| blake3-servil-st / solo / IdleOneMessage / 32 KiB | 1.329 | 1.327 | x0.998 | level | 2 of 4 | - | - | x1.006 | x1.000 | x1.405 |
| blake3-servil-st / solo / IdleOneMessage / 64 KiB | 0.847 | 0.820 | x0.968 | level | 3 of 4 | - | - | x0.984 | x1.000 | x1.105 |
| blake3-servil-st / solo / IdleOneMessage / 128 KiB | 0.679 | 0.672 | x0.989 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.995 |
| blake3-servil-st / solo / IdleOneMessage / 256 KiB | 0.486 | 0.479 | x0.986 | level | 4 of 4 | - | - | x0.988 | x1.000 | x1.920 |
| blake3-servil-st / solo / IdleOneMessage / 512 KiB | 0.371 | 0.369 | x0.995 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.966 |
| blake3-servil-st / solo / IdleOneMessage / 1 MiB | 0.359 | 0.359 | x1.000 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.957 |
| blake3-servil-st / solo / IdleOneMessage / 2 MiB | 0.350 | 0.350 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.032 |
| blake3-servil-st / solo / IdleOneMessage / 3 MiB | 0.344 | 0.344 | x1.001 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.961 |
| blake3-servil-st / solo / IdleOneMessage / 4 MiB | 0.341 | 0.341 | x0.999 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.018 |
| blake3-servil-st / solo / IdleOneMessage / 8 MiB | 0.339 | 0.339 | x0.999 | level | 1 of 4 | - | - | x0.998 | x1.000 | x0.984 |
| blake3-servil-st / solo / IdleOneMessage / 32 MiB | 0.345 | 0.346 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.995 |
| blake3-servil-st / solo / IdleOneMessage / 64 MiB | 0.350 | 0.351 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.001 |
| blake3-servil-st / solo / IdleOneMessage / 128 MiB | 0.353 | 0.353 | x1.000 | level | 3 of 4 | - | - | x1.001 | x1.000 | x1.001 |
| blake3-servil-st / solo / IdleManyMessages / 1 | 688.887 | 687.018 | x0.997 | level | 2 of 4 | - | - | x0.984 | x1.009 | x0.860 |
| blake3-servil-st / solo / IdleManyMessages / 2 | 809.589 | 763.758 | x0.943 | level | 3 of 4 | - | - | x0.987 | x0.998 | x0.701 |
| blake3-servil-st / solo / IdleManyMessages / 3 | 786.496 | 772.366 | x0.982 | level | 3 of 4 | - | - | x1.006 | x0.998 | x0.943 |
| blake3-servil-st / solo / IdleManyMessages / 4 | 383.375 | 386.089 | x1.007 | level | 2 of 4 | - | - | x1.005 | x0.998 | x0.727 |
| blake3-servil-st / solo / IdleManyMessages / 6 | 442.043 | 456.977 | x1.034 | level | 1 of 4 | - | - | x0.999 | x0.998 | x0.584 |
| blake3-servil-st / solo / IdleManyMessages / 8 | 298.741 | 294.904 | x0.987 | level | 3 of 4 | - | - | x0.995 | x0.998 | x1.575 |
| blake3-servil-st / solo / IdleManyMessages / 12 | 293.586 | 297.756 | x1.014 | level | 1 of 4 | - | - | x1.001 | x0.998 | x1.239 |
| blake3-servil-st / solo / IdleManyMessages / 16 | 193.927 | 202.910 | x1.046 | level | 1 of 4 | - | - | x0.993 | x0.999 | x0.524 |
| blake3-servil-st / solo / IdleManyMessages / 24 | 226.569 | 222.259 | x0.981 | level | 2 of 4 | - | - | x0.999 | x0.999 | x0.332 |
| blake3-servil-st / solo / IdleManyMessages / 32 | 186.133 | 179.641 | x0.965 | level | 3 of 4 | - | - | x1.002 | x0.999 | x1.009 |
| blake3-servil-st / solo / IdleManyMessages / 48 | 173.489 | 173.542 | x1.000 | level | 2 of 4 | - | - | x0.999 | x0.999 | x1.527 |
| blake3-servil-st / solo / IdleManyMessages / 64 | 167.950 | 161.908 | x0.964 | level | 4 of 4 | - | - | x0.997 | x0.999 | x0.881 |
| blake3-servil-st / solo / IdleManyMessages / 128 | 122.905 | 123.811 | x1.007 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.011 |
| blake3-servil-st / solo / IdleManyMessages / 256 | 95.603 | 95.242 | x0.996 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.770 |
| blake3-servil-st / solo / IdleManyMessages / 512 | 83.250 | 85.810 | x1.031 | level | 0 of 4 | - | - | x1.001 | x1.000 | x1.174 |
| blake3-servil-st / solo / IdleManyMessages / 1024 | 53.378 | 54.660 | x1.024 | level | 1 of 4 | - | - | x1.047 | x1.000 | x0.807 |
| blake3-servil-st / solo / IdleManyMessages / 2048 | 42.028 | 42.559 | x1.013 | level | 1 of 4 | - | - | x1.007 | x1.000 | x1.038 |
| blake3-servil-st / solo / IdleManyMessages / 4096 | 30.813 | 30.955 | x1.005 | level | 1 of 4 | - | - | x0.998 | x1.000 | x1.393 |
| blake3-servil-st / solo / IdleManyMessages / 8192 | 24.104 | 23.890 | x0.991 | level | 4 of 4 | - | - | x0.997 | x1.000 | x0.932 |
| blake3-servil-st / solo / IdleManyMessages / 16384 | 23.634 | 23.697 | x1.003 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.973 |
| blake3-servil-st / solo / IdleManyMessages / 32768 | 22.735 | 22.753 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.019 |
| blake3-servil-st / solo / IdleManyMessages / 65536 | 22.278 | 22.301 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.974 |
| blake3-servil-st / solo / IdleManyMessages / 131072 | 22.132 | 22.128 | x1.000 | level | 3 of 4 | - | - | x1.001 | x1.000 | x0.978 |
| blake3-servil-st / solo / IdleManyMessages / 262144 | 22.630 | 22.649 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.980 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 B | 3.163 | 3.126 | x0.988 | level | 2 of 4 | - | - | x1.006 | x1.007 | x1.363 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 B | 2.346 | 2.389 | x1.018 | level | 1 of 4 | - | - | x1.009 | x1.005 | x0.291 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 B | 1.765 | 1.767 | x1.001 | level | 2 of 4 | - | - | x1.002 | x1.003 | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 B | 1.606 | 1.616 | x1.006 | level | 1 of 4 | - | - | x1.005 | x1.002 | x1.410 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 KiB | 1.499 | 1.511 | x1.009 | level | 0 of 4 | - | - | x1.007 | x1.001 | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 1536 B | 1.277 | 1.255 | x0.982 | level | 3 of 4 | - | - | x0.999 | x0.998 | x0.784 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 KiB | 0.889 | 0.901 | x1.014 | level | 2 of 4 | - | - | x1.010 | x1.001 | x0.808 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2304 B | 1.005 | 1.005 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.002 | x0.767 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.700 | 0.762 | x1.088 | level | 1 of 4 | - | - | x1.073 | x1.001 | x0.777 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3839 B | 0.583 | 0.582 | x0.998 | level | 2 of 4 | - | - | x0.999 | x1.001 | x1.124 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 KiB | 0.482 | 0.481 | x0.998 | level | 2 of 4 | - | - | x0.999 | x1.001 | x2.565 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4470 B | 0.595 | 0.596 | x1.003 | level | 1 of 4 | - | - | x1.003 | x1.001 | x0.832 |
| blake3-servil-st / solo / BriefIdleOneMessage / 7935 B | 0.444 | 0.445 | x1.003 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.058 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 KiB | 0.399 | 0.393 | x0.986 | level | 3 of 4 | - | - | x0.993 | x1.000 | x0.944 |
| blake3-servil-st / solo / BriefIdleOneMessage / 16 KiB | 0.299 | 0.297 | x0.995 | level | 1 of 4 | - | - | x0.995 | x1.000 | x0.661 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 KiB | 0.295 | 0.294 | x0.996 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.893 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 KiB | 0.286 | 0.286 | x1.000 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.432 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 KiB | 0.283 | 0.282 | x0.998 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.467 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 KiB | 0.280 | 0.280 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.722 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 KiB | 0.286 | 0.287 | x1.001 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.812 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 MiB | 0.326 | 0.325 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.982 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 MiB | 0.335 | 0.335 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.996 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 MiB | 0.334 | 0.334 | x0.999 | level | 4 of 4 | - | - | x0.999 | x1.000 | x0.948 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 MiB | 0.334 | 0.334 | x0.998 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.998 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 MiB | 0.362 | 0.362 | x0.999 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.931 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 MiB | 0.347 | 0.346 | x0.998 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.001 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 MiB | 0.351 | 0.351 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.001 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 MiB | 0.353 | 0.353 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.001 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1 | 239.252 | 239.313 | x1.000 | level | 1 of 4 | - | - | x1.006 | x1.008 | x0.831 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2 | 217.271 | 220.339 | x1.014 | level | 3 of 4 | - | - | x0.998 | x0.997 | x0.617 |
| blake3-servil-st / solo / BriefIdleManyMessages / 3 | 139.844 | 128.825 | x0.921 | level | 3 of 4 | - | - | x0.954 | x0.997 | x1.039 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4 | 65.731 | 72.424 | x1.102 | level | 0 of 4 | - | - | x1.035 | x0.996 | x0.497 |
| blake3-servil-st / solo / BriefIdleManyMessages / 6 | 60.034 | 60.116 | x1.001 | level | 1 of 4 | - | - | x1.001 | x0.998 | x0.682 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8 | 41.554 | 42.745 | x1.029 | level | 1 of 4 | - | - | x1.014 | x0.999 | x0.533 |
| blake3-servil-st / solo / BriefIdleManyMessages / 12 | 37.009 | 37.506 | x1.013 | level | 1 of 4 | - | - | x1.008 | x0.999 | x0.984 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16 | 25.890 | 26.045 | x1.006 | level | 1 of 4 | - | - | x1.003 | x0.998 | x1.417 |
| blake3-servil-st / solo / BriefIdleManyMessages / 24 | 26.953 | 26.930 | x0.999 | level | 1 of 4 | - | - | x0.999 | x0.999 | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 32 | 21.826 | 21.773 | x0.998 | level | 1 of 4 | - | - | x0.999 | x0.999 | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 48 | 19.657 | 19.637 | x0.999 | level | 2 of 4 | - | - | x0.999 | x0.998 | x1.788 |
| blake3-servil-st / solo / BriefIdleManyMessages / 64 | 18.991 | 19.017 | x1.001 | level | 2 of 4 | - | - | x1.000 | x0.999 | x1.340 |
| blake3-servil-st / solo / BriefIdleManyMessages / 128 | 17.740 | 17.824 | x1.005 | level | 0 of 4 | - | - | x1.003 | x0.999 | x1.129 |
| blake3-servil-st / solo / BriefIdleManyMessages / 256 | 18.333 | 18.203 | x0.993 | level | 2 of 4 | - | - | x0.998 | x0.999 | x0.977 |
| blake3-servil-st / solo / BriefIdleManyMessages / 512 | 18.360 | 18.465 | x1.006 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.945 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1024 | 18.114 | 18.603 | x1.027 | level | 0 of 4 | - | - | x1.002 | x1.000 | x0.903 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2048 | 18.030 | 18.009 | x0.999 | level | 3 of 4 | - | - | x1.001 | x1.000 | x0.862 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4096 | 17.985 | 18.069 | x1.005 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.695 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8192 | 19.300 | 19.356 | x1.003 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.012 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16384 | 21.697 | 21.690 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.978 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32768 | 21.786 | 21.811 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.043 |
| blake3-servil-st / solo / BriefIdleManyMessages / 65536 | 21.953 | 21.929 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.980 |
| blake3-servil-st / solo / BriefIdleManyMessages / 131072 | 23.607 | 23.623 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.985 |
| blake3-servil-st / solo / BriefIdleManyMessages / 262144 | 22.618 | 22.611 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.999 |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 1.516 | 1.513 | x0.998 | level | 2 of 4 | x0.998 | - | x0.997 | x1.012 | x0.423 |
| blake3-servil-st / solo / ContinuousMessages / 128 B | 1.443 | 1.447 | x1.002 | level | 2 of 4 | x1.002 | - | x1.004 | x1.007 | - |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 1.403 | 1.411 | x1.005 | level | 1 of 4 | x1.005 | - | x1.005 | x1.004 | x1.655 |
| blake3-servil-st / solo / ContinuousMessages / 512 B | 1.405 | 1.410 | x1.004 | level | 0 of 4 | x1.007 | - | x1.008 | x1.003 | x2.206 |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 1.401 | 1.397 | x0.997 | level | 3 of 4 | x0.998 | - | x0.998 | x1.001 | x1.817 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.435 | 0.435 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.001 | - |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.271 | 0.268 | x0.988 | level | 4 of 4 | x0.988 | - | x0.988 | x1.000 | x3.668 |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.281 | 0.283 | x1.006 | level | 0 of 4 | x1.006 | - | x1.006 | x1.000 | x2.248 |
| blake3-servil-st / solo / ContinuousMessages / 256 KiB | 0.300 | 0.299 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.418 |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.299 | 0.299 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x1.533 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.304 | 0.305 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x0.601 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.304 | 0.305 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x0.944 |
| blake3-servil-st / solo / ContinuousMessages / 64 MiB | 0.319 | 0.320 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.000 | x1.009 |
| blake3-servil-st / solo / ContinuousBatches / 16 | 20.888 | 20.785 | x0.995 | level | 3 of 4 | x0.996 | - | x0.996 | x0.998 | x1.785 |
| blake3-servil-st / solo / ContinuousBatches / 64 | 17.998 | 17.886 | x0.994 | level | 4 of 4 | x0.994 | - | x0.995 | x0.999 | - |
| blake3-servil-st / solo / ContinuousBatches / 256 | 17.775 | 17.538 | x0.987 | level | 4 of 4 | x0.987 | - | x0.987 | x1.000 | - |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 19.111 | 19.653 | x1.028 | level | 0 of 4 | x1.026 | - | x1.026 | x0.999 | - |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 19.355 | 19.410 | x1.003 | level | 2 of 4 | x1.003 | - | x1.003 | x1.000 | x0.379 |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 22.450 | 22.602 | x1.007 | level | 0 of 4 | x1.006 | - | x1.006 | x1.000 | x0.788 |
| blake3-servil-st / solo / ContinuousBatches / 65536 | 22.948 | 23.105 | x1.007 | level | 0 of 4 | x1.007 | - | x1.007 | x1.000 | x0.578 |
| blake3-servil-st / solo / LentMessages / 64 B | 1.516 | 1.513 | x0.998 | level | 2 of 4 | x0.998 | - | x0.997 | x1.012 | x0.423 |
| blake3-servil-st / solo / LentMessages / 128 B | 1.443 | 1.447 | x1.002 | level | 2 of 4 | x1.002 | - | x1.004 | x1.007 | - |
| blake3-servil-st / solo / LentMessages / 256 B | 1.403 | 1.411 | x1.005 | level | 1 of 4 | x1.005 | - | x1.005 | x1.004 | x1.655 |
| blake3-servil-st / solo / LentMessages / 512 B | 1.405 | 1.410 | x1.004 | level | 0 of 4 | x1.007 | - | x1.008 | x1.003 | x2.206 |
| blake3-servil-st / solo / LentMessages / 1 KiB | 1.401 | 1.397 | x0.997 | level | 3 of 4 | x0.998 | - | x0.998 | x1.001 | x1.817 |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.435 | 0.435 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.001 | - |
| blake3-servil-st / solo / LentMessages / 16 KiB | 0.271 | 0.268 | x0.988 | level | 4 of 4 | x0.988 | - | x0.988 | x1.000 | x3.668 |
| blake3-servil-st / solo / LentMessages / 64 KiB | 0.281 | 0.283 | x1.006 | level | 0 of 4 | x1.006 | - | x1.006 | x1.000 | x2.248 |
| blake3-servil-st / solo / LentMessages / 256 KiB | 0.277 | 0.278 | x1.004 | level | 0 of 4 | x1.004 | - | x1.004 | x1.000 | x0.555 |
| blake3-servil-st / solo / LentMessages / 1 MiB | 0.316 | 0.316 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x0.942 |
| blake3-servil-st / solo / LentMessages / 4 MiB | 0.330 | 0.331 | x1.003 | level | 1 of 4 | x1.003 | - | x1.004 | x1.000 | x1.731 |
| blake3-servil-st / solo / LentMessages / 16 MiB | 0.341 | 0.343 | x1.005 | level | 1 of 4 | x1.005 | - | x1.005 | x1.000 | x1.089 |
| blake3-servil-st / solo / LentMessages / 64 MiB | 0.350 | 0.349 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x1.001 |
| blake3-servil-st / solo / Interleaved / 256 | 0.392 | 0.393 | x1.003 | level | 1 of 4 | x1.003 | - | x1.003 | x0.999 | x1.150 |
| blake3-servil-st / solo / Collection / git objects | 0.273 | 0.272 | x0.996 | level | 3 of 4 | x0.998 | - | x0.999 | x0.999 | x0.988 |
| blake3-servil-st / solo / Collection / Nix files | 0.263 | 0.263 | x1.002 | level | 1 of 4 | x1.002 | - | x1.001 | x0.999 | x1.118 |
| blake3-servil-st / solo / LentBatches / 16 | 20.888 | 20.785 | x0.995 | level | 3 of 4 | x0.996 | - | x0.996 | x0.998 | x1.785 |
| blake3-servil-st / solo / LentBatches / 64 | 17.998 | 17.886 | x0.994 | level | 4 of 4 | x0.994 | - | x0.995 | x0.999 | - |
| blake3-servil-st / solo / LentBatches / 256 | 17.775 | 17.538 | x0.987 | level | 4 of 4 | x0.987 | - | x0.987 | x1.000 | - |
| blake3-servil-st / solo / LentBatches / 1024 | 19.111 | 19.653 | x1.028 | level | 0 of 4 | x1.026 | - | x1.026 | x0.999 | - |
| blake3-servil-st / solo / LentBatches / 4096 | 19.355 | 19.410 | x1.003 | level | 2 of 4 | x1.003 | - | x1.003 | x1.000 | x0.379 |
| blake3-servil-st / solo / LentBatches / 16384 | 22.450 | 22.602 | x1.007 | level | 0 of 4 | x1.006 | - | x1.006 | x1.000 | x0.788 |
| blake3-servil-st / solo / LentBatches / 65536 | 22.948 | 23.105 | x1.007 | level | 0 of 4 | x1.007 | - | x1.007 | x1.000 | x0.578 |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.350 | 0.351 | x1.002 | level | 0 of 4 | x1.001 | - | x1.001 | x1.000 | x0.996 |
| blake3-servil-st / solo / ContinuousCollection / Nix files | 0.359 | 0.359 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.000 | x1.044 |
| blake3-servil-st / solo / MerkleTree / 1024 | 0.350 | 0.351 | x1.002 | level | 1 of 4 | x1.003 | - | x1.003 | x1.001 | x2.372 |
| blake3-servil-st / solo / MerkleTree / 4096 | 0.404 | 0.403 | x0.998 | level | 2 of 4 | x0.998 | - | x0.999 | x1.001 | x0.874 |
| blake3-servil-st / solo / MerkleTree / 16384 | 0.425 | 0.412 | x0.970 | level | 2 of 4 | x0.989 | - | x0.989 | x1.001 | x1.172 |
| blake3-servil-st / solo / MerkleTree / 65536 | 0.440 | 0.443 | x1.005 | level | 1 of 4 | x1.005 | - | x1.005 | x1.001 | x1.061 |
| blake3-servil-st / solo / MerkleTree / 262144 | 0.469 | 0.468 | x0.998 | level | 2 of 4 | x0.998 | - | x0.998 | x1.001 | x1.006 |
| blake3-servil-st / solo / MerkleTree / 65536 x 32 B | 1.051 | 1.050 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.944 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 32 B | 1.086 | 1.087 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | x1.032 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 16 B | 2.106 | 2.113 | x1.003 | level | 2 of 4 | x1.003 | - | x1.003 | x1.000 | x1.018 |
| blake3-servil-st / solo / MerkleTree / 65536 x 48 B | 0.741 | 0.742 | x1.001 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x0.808 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 48 B | 0.775 | 0.778 | x1.004 | level | 2 of 4 | x1.004 | - | x1.004 | x1.000 | x1.018 |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.749 | 0.754 | x1.007 | level | 0 of 4 | - | - | x1.007 | x1.005 | x1.002 |
| blake3-servil-st / solo / InterleavedTurn / 1024 x 1 KiB | 0.844 | 0.847 | x1.003 | level | 2 of 4 | - | - | x0.999 | x0.997 | x0.981 |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.656 | 0.658 | x1.004 | level | 2 of 4 | - | - | x1.011 | x1.018 | x1.010 |
| blake3-servil-st / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.800 | 0.801 | x1.001 | level | 2 of 4 | - | - | x1.001 | x0.997 | x0.991 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.516 | 0.519 | x1.005 | level | 2 of 4 | - | - | x1.005 | x1.010 | x1.005 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.726 | 0.726 | x1.001 | level | 1 of 4 | - | - | x1.000 | x0.997 | x0.963 |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.318 | 0.317 | x0.999 | level | 2 of 4 | x0.998 | - | x0.998 | x1.001 | x1.382 |
| blake3-servil-st / solo / ReceivingMessage / 2 μs | 0.320 | 0.320 | x1.001 | level | 2 of 4 | x1.000 | - | x1.000 | x1.001 | x1.294 |
| blake3-servil-st / solo / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 1 of 4 | x1.001 | - | x1.000 | x1.001 | x1.476 |
| blake3-servil-st / solo / IncrementalMessage / 64 B | 18.494 | 18.794 | x1.016 | level | 1 of 4 | - | - | x1.017 | x1.003 | x1.142 |
| blake3-servil-st / solo / IncrementalMessage / 1 KiB | 3.320 | 3.714 | x1.119 | level | 1 of 4 | - | - | x1.112 | x1.002 | x1.177 |
| blake3-servil-st / solo / IncrementalMessage / 4 KiB | 2.486 | 2.484 | x0.999 | level | 2 of 4 | - | - | x0.993 | x1.001 | x1.055 |
| blake3-servil-st / solo / LentIncrementalMessage / 64 B | 1.683 | 1.687 | x1.003 | level | 3 of 4 | x1.003 | - | x1.003 | x1.006 | - |
| blake3-servil-st / solo / LentIncrementalMessage / 1 KiB | 1.437 | 1.439 | x1.002 | level | 0 of 4 | x1.002 | - | x1.002 | x1.002 | x1.441 |
| blake3-servil-st / solo / LentIncrementalMessage / 4 KiB | 0.454 | 0.453 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.001 | x0.905 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 1.457 | 1.461 | x1.003 | level | 1 of 4 | x1.003 | - | x1.003 | x1.013 | x1.056 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 4 KiB | 0.438 | 0.436 | x0.995 | level | 4 of 4 | x0.995 | - | x0.995 | x1.001 | x1.073 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 1 MiB | 0.297 | 0.285 | x0.958 | level | 4 of 4 | x0.960 | - | x0.960 | x1.000 | x0.791 |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 1.382 | 1.381 | x0.999 | level | 3 of 4 | x0.999 | - | x1.000 | x1.015 | x0.816 |
| blake3-servil-st / solo / ContinuousLentMessages / 4 KiB | 0.424 | 0.424 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.001 | x1.482 |
| blake3-servil-st / solo / ContinuousLentMessages / 1 MiB | 0.242 | 0.242 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.000 | x0.721 |
| blake3-servil-mt / solo / OneMessage / 64 B | 20.759 | 20.728 | x0.998 | level | 2 of 4 | - | - | x0.994 | x1.007 | x1.078 |
| blake3-servil-mt / solo / OneMessage / 128 B | 11.456 | 11.119 | x0.971 | level | 2 of 4 | - | - | x0.985 | x1.005 | x1.061 |
| blake3-servil-mt / solo / OneMessage / 256 B | 6.455 | 6.245 | x0.968 | level | 3 of 4 | - | - | x0.982 | x1.003 | x1.104 |
| blake3-servil-mt / solo / OneMessage / 512 B | 3.829 | 3.763 | x0.983 | level | 2 of 4 | - | - | x0.994 | x1.002 | x1.052 |
| blake3-servil-mt / solo / OneMessage / 1 KiB | 2.690 | 2.609 | x0.970 | level | 3 of 4 | - | - | x0.975 | x1.001 | x1.066 |
| blake3-servil-mt / solo / OneMessage / 1536 B | 4.877 | 4.646 | x0.953 | level | 3 of 4 | - | - | x0.964 | x0.998 | x1.044 |
| blake3-servil-mt / solo / OneMessage / 2 KiB | 4.244 | 4.156 | x0.979 | level | 3 of 4 | - | - | x0.986 | x1.000 | x1.016 |
| blake3-servil-mt / solo / OneMessage / 2304 B | 4.537 | 4.464 | x0.984 | level | 3 of 4 | - | - | x0.994 | x1.002 | x0.995 |
| blake3-servil-mt / solo / OneMessage / 3 KiB | 3.130 | 3.098 | x0.990 | level | 2 of 4 | - | - | x0.981 | x1.001 | x0.965 |
| blake3-servil-mt / solo / OneMessage / 3839 B | 2.751 | 2.753 | x1.001 | level | 2 of 4 | - | - | x0.998 | x1.001 | x1.056 |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 2.340 | 2.325 | x0.994 | level | 3 of 4 | - | - | x0.990 | x1.001 | x0.997 |
| blake3-servil-mt / solo / OneMessage / 4470 B | 2.526 | 2.522 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.001 | x1.051 |
| blake3-servil-mt / solo / OneMessage / 7935 B | 2.066 | 2.036 | x0.985 | level | 3 of 4 | - | - | x0.991 | x1.001 | x1.056 |
| blake3-servil-mt / solo / OneMessage / 8 KiB | 1.841 | 1.895 | x1.029 | level | 0 of 4 | - | - | x1.001 | x1.000 | x1.042 |
| blake3-servil-mt / solo / OneMessage / 16 KiB | 1.351 | 1.330 | x0.985 | level | 4 of 4 | - | - | x0.989 | x1.000 | x1.012 |
| blake3-servil-mt / solo / OneMessage / 32 KiB | 1.249 | 1.245 | x0.997 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.001 |
| blake3-servil-mt / solo / OneMessage / 64 KiB | 1.052 | 1.057 | x1.005 | level | 1 of 4 | - | - | x1.006 | x1.000 | x1.020 |
| blake3-servil-mt / solo / OneMessage / 128 KiB | 0.664 | 0.677 | x1.019 | level | 0 of 4 | - | - | x1.009 | x1.000 | x0.989 |
| blake3-servil-mt / solo / OneMessage / 256 KiB | 0.483 | 0.487 | x1.009 | level | 1 of 4 | - | - | x1.008 | x1.000 | x0.993 |
| blake3-servil-mt / solo / OneMessage / 512 KiB | 0.433 | 0.442 | x1.022 | level | 1 of 4 | - | - | x1.023 | x0.863 | x1.010 |
| blake3-servil-mt / solo / OneMessage / 1 MiB | 0.328 | 0.329 | x1.002 | level | 1 of 4 | - | - | x0.999 | x0.769 | x1.014 |
| blake3-servil-mt / solo / OneMessage / 2 MiB | 0.245 | 0.241 | x0.984 | level | 3 of 4 | - | - | x0.981 | x0.793 | x0.983 |
| blake3-servil-mt / solo / OneMessage / 3 MiB | 0.214 | 0.210 | x0.979 | level | 3 of 4 | - | - | x0.987 | x0.860 | x0.979 |
| blake3-servil-mt / solo / OneMessage / 4 MiB | 0.195 | 0.193 | x0.987 | level | 3 of 4 | - | - | x0.987 | x0.845 | x0.986 |
| blake3-servil-mt / solo / OneMessage / 8 MiB | 0.165 | 0.165 | x1.001 | level | 3 of 4 | - | - | x0.998 | x0.932 | x1.005 |
| blake3-servil-mt / solo / OneMessage / 32 MiB | 0.112 | 0.112 | x0.999 | level | 2 of 4 | - | - | x0.995 | x0.987 | x0.993 |
| blake3-servil-mt / solo / OneMessage / 64 MiB | 0.107 | 0.106 | x0.997 | level | 3 of 4 | - | - | x0.998 | x0.991 | x0.999 |
| blake3-servil-mt / solo / OneMessage / 128 MiB | 0.105 | 0.104 | x0.998 | level | 3 of 4 | - | - | x0.998 | x0.997 | x1.000 |
| blake3-servil-mt / solo / ManyMessages / 1 | 1165.124 | 1136.894 | x0.976 | level | 2 of 4 | - | - | x0.989 | x1.008 | x0.954 |
| blake3-servil-mt / solo / ManyMessages / 2 | 845.154 | 902.292 | x1.068 | level | 1 of 4 | - | - | x1.034 | x0.998 | x0.922 |
| blake3-servil-mt / solo / ManyMessages / 3 | 674.672 | 688.945 | x1.021 | level | 2 of 4 | - | - | x1.019 | x0.998 | x0.898 |
| blake3-servil-mt / solo / ManyMessages / 4 | 415.950 | 434.194 | x1.044 | level | 1 of 4 | - | - | x1.034 | x0.998 | x0.945 |
| blake3-servil-mt / solo / ManyMessages / 6 | 376.595 | 378.454 | x1.005 | level | 2 of 4 | - | - | x1.013 | x0.998 | x0.916 |
| blake3-servil-mt / solo / ManyMessages / 8 | 263.496 | 268.562 | x1.019 | level | 1 of 4 | - | - | x1.030 | x0.998 | x0.953 |
| blake3-servil-mt / solo / ManyMessages / 12 | 210.582 | 213.101 | x1.012 | level | 2 of 4 | - | - | x1.002 | x0.999 | x0.905 |
| blake3-servil-mt / solo / ManyMessages / 16 | 154.635 | 159.204 | x1.030 | level | 2 of 4 | - | - | x1.012 | x0.999 | x0.935 |
| blake3-servil-mt / solo / ManyMessages / 24 | 138.981 | 140.997 | x1.015 | level | 2 of 4 | - | - | x1.008 | x0.999 | x0.932 |
| blake3-servil-mt / solo / ManyMessages / 32 | 112.026 | 113.911 | x1.017 | level | 1 of 4 | - | - | x1.032 | x0.999 | x0.907 |
| blake3-servil-mt / solo / ManyMessages / 48 | 98.826 | 100.293 | x1.015 | level | 2 of 4 | - | - | x1.014 | x0.999 | x0.896 |
| blake3-servil-mt / solo / ManyMessages / 64 | 93.260 | 93.919 | x1.007 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.919 |
| blake3-servil-mt / solo / ManyMessages / 128 | 84.353 | 84.974 | x1.007 | level | 1 of 4 | - | - | x1.003 | x1.000 | x0.969 |
| blake3-servil-mt / solo / ManyMessages / 256 | 80.108 | 80.150 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.981 |
| blake3-servil-mt / solo / ManyMessages / 512 | 77.878 | 78.374 | x1.006 | level | 0 of 4 | - | - | x1.004 | x1.000 | x0.975 |
| blake3-servil-mt / solo / ManyMessages / 1024 | 66.057 | 65.969 | x0.999 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.994 |
| blake3-servil-mt / solo / ManyMessages / 2048 | 42.641 | 42.675 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.006 |
| blake3-servil-mt / solo / ManyMessages / 4096 | 31.129 | 31.146 | x1.001 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.012 |
| blake3-servil-mt / solo / ManyMessages / 8192 | 25.494 | 25.584 | x1.004 | level | 2 of 4 | - | - | x0.996 | x0.861 | x0.996 |
| blake3-servil-mt / solo / ManyMessages / 16384 | 18.709 | 19.351 | x1.034 | level | 1 of 4 | - | - | x1.031 | x0.931 | x1.008 |
| blake3-servil-mt / solo / ManyMessages / 32768 | 15.079 | 14.863 | x0.986 | level | 2 of 4 | - | - | x0.982 | x0.849 | x0.981 |
| blake3-servil-mt / solo / ManyMessages / 65536 | 12.179 | 12.003 | x0.986 | level | 4 of 4 | - | - | x0.982 | x0.855 | x0.980 |
| blake3-servil-mt / solo / ManyMessages / 131072 | 10.653 | 10.620 | x0.997 | level | 3 of 4 | - | - | x0.995 | x0.892 | x0.990 |
| blake3-servil-mt / solo / ManyMessages / 262144 | 9.989 | 9.959 | x0.997 | level | 3 of 4 | - | - | x0.997 | x0.899 | x1.002 |
| blake3-servil-mt / solo / ManyLongMessages / 4 | 8250.339 | 8229.694 | x0.997 | level | 2 of 4 | - | - | x0.997 | x1.001 | x0.984 |
| blake3-servil-mt / solo / ManyLongMessages / 16 | 4899.041 | 4245.113 | x0.867 | faster | 4 of 4 | - | - | x0.866 | x0.566 | x1.109 |
| blake3-servil-mt / solo / ManyLongMessages / 64 | 2015.821 | 1984.152 | x0.984 | level | 2 of 4 | - | - | x1.004 | x1.002 | x0.983 |
| blake3-servil-mt / solo / ManyLongMessages / 256 | 1395.458 | 1382.654 | x0.991 | level | 3 of 4 | - | - | x0.988 | x0.867 | x0.991 |
| blake3-servil-mt / solo / IdleOneMessage / 64 B | 8.549 | 8.385 | x0.981 | level | 2 of 4 | - | - | x0.997 | x1.006 | x0.604 |
| blake3-servil-mt / solo / IdleOneMessage / 128 B | 6.393 | 6.462 | x1.011 | level | 2 of 4 | - | - | x1.005 | x1.005 | x2.162 |
| blake3-servil-mt / solo / IdleOneMessage / 256 B | 4.779 | 4.832 | x1.011 | level | 1 of 4 | - | - | x0.998 | x1.003 | - |
| blake3-servil-mt / solo / IdleOneMessage / 512 B | 4.225 | 4.201 | x0.994 | level | 3 of 4 | - | - | x0.993 | x1.002 | x1.432 |
| blake3-servil-mt / solo / IdleOneMessage / 1 KiB | 3.733 | 3.716 | x0.995 | level | 2 of 4 | - | - | x1.001 | x1.001 | x0.937 |
| blake3-servil-mt / solo / IdleOneMessage / 1536 B | 7.696 | 7.711 | x1.002 | level | 2 of 4 | - | - | x0.996 | x0.998 | x1.890 |
| blake3-servil-mt / solo / IdleOneMessage / 2 KiB | 6.367 | 6.707 | x1.053 | level | 0 of 4 | - | - | x1.001 | x1.001 | - |
| blake3-servil-mt / solo / IdleOneMessage / 2304 B | 6.430 | 6.725 | x1.046 | level | 1 of 4 | - | - | x1.006 | x1.001 | x0.633 |
| blake3-servil-mt / solo / IdleOneMessage / 3 KiB | 4.531 | 4.510 | x0.995 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.350 |
| blake3-servil-mt / solo / IdleOneMessage / 3839 B | 3.849 | 3.915 | x1.017 | level | 1 of 4 | - | - | x0.998 | x1.001 | x1.565 |
| blake3-servil-mt / solo / IdleOneMessage / 4 KiB | 3.416 | 3.326 | x0.974 | level | 4 of 4 | - | - | x1.003 | x1.001 | x1.668 |
| blake3-servil-mt / solo / IdleOneMessage / 4470 B | 3.617 | 3.789 | x1.047 | level | 1 of 4 | - | - | x1.003 | x1.001 | x1.066 |
| blake3-servil-mt / solo / IdleOneMessage / 7935 B | 2.494 | 2.636 | x1.057 | level | 0 of 4 | - | - | x1.001 | x1.001 | x1.443 |
| blake3-servil-mt / solo / IdleOneMessage / 8 KiB | 2.461 | 2.495 | x1.014 | level | 2 of 4 | - | - | x1.007 | x1.000 | x1.313 |
| blake3-servil-mt / solo / IdleOneMessage / 16 KiB | 1.553 | 1.553 | x1.000 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.256 |
| blake3-servil-mt / solo / IdleOneMessage / 32 KiB | 1.357 | 1.344 | x0.991 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.286 |
| blake3-servil-mt / solo / IdleOneMessage / 64 KiB | 0.854 | 0.823 | x0.964 | level | 3 of 4 | - | - | x0.987 | x1.000 | x1.759 |
| blake3-servil-mt / solo / IdleOneMessage / 128 KiB | 0.679 | 0.681 | x1.003 | level | 2 of 4 | - | - | x1.023 | x1.000 | x1.055 |
| blake3-servil-mt / solo / IdleOneMessage / 256 KiB | 0.484 | 0.485 | x1.003 | level | 1 of 4 | - | - | x1.006 | x1.000 | x1.940 |
| blake3-servil-mt / solo / IdleOneMessage / 512 KiB | 0.256 | 0.268 | x1.045 | level | 1 of 4 | - | - | x1.055 | x0.897 | x1.107 |
| blake3-servil-mt / solo / IdleOneMessage / 1 MiB | 0.222 | 0.226 | x1.018 | level | 1 of 4 | - | - | x1.013 | x0.948 | x0.956 |
| blake3-servil-mt / solo / IdleOneMessage / 2 MiB | 0.173 | 0.172 | x0.992 | level | 3 of 4 | - | - | x0.988 | x1.024 | x0.959 |
| blake3-servil-mt / solo / IdleOneMessage / 3 MiB | 0.155 | 0.156 | x1.006 | level | 2 of 4 | - | - | x1.002 | x1.098 | x0.953 |
| blake3-servil-mt / solo / IdleOneMessage / 4 MiB | 0.147 | 0.148 | x1.009 | level | 0 of 4 | - | - | x1.009 | x1.089 | x0.947 |
| blake3-servil-mt / solo / IdleOneMessage / 8 MiB | 0.131 | 0.131 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.011 | x0.918 |
| blake3-servil-mt / solo / IdleOneMessage / 32 MiB | 0.110 | 0.110 | x0.999 | level | 2 of 4 | - | - | x0.998 | x0.982 | x0.984 |
| blake3-servil-mt / solo / IdleOneMessage / 64 MiB | 0.104 | 0.103 | x0.996 | level | 3 of 4 | - | - | x0.997 | x0.990 | x0.999 |
| blake3-servil-mt / solo / IdleOneMessage / 128 MiB | 0.104 | 0.103 | x0.997 | level | 4 of 4 | - | - | x0.997 | x0.998 | x0.997 |
| blake3-servil-mt / solo / IdleManyMessages / 1 | 658.303 | 682.115 | x1.036 | level | 2 of 4 | - | - | x0.984 | x1.009 | x0.831 |
| blake3-servil-mt / solo / IdleManyMessages / 2 | 762.810 | 774.261 | x1.015 | level | 1 of 4 | - | - | x0.990 | x0.998 | x0.868 |
| blake3-servil-mt / solo / IdleManyMessages / 3 | 789.672 | 801.420 | x1.015 | level | 2 of 4 | - | - | x0.998 | x0.998 | x0.751 |
| blake3-servil-mt / solo / IdleManyMessages / 4 | 395.656 | 396.990 | x1.003 | level | 2 of 4 | - | - | x0.997 | x0.997 | x0.497 |
| blake3-servil-mt / solo / IdleManyMessages / 6 | 449.325 | 449.104 | x1.000 | level | 2 of 4 | - | - | x1.007 | x0.998 | x0.543 |
| blake3-servil-mt / solo / IdleManyMessages / 8 | 291.206 | 294.844 | x1.012 | level | 2 of 4 | - | - | x0.983 | x0.998 | x0.964 |
| blake3-servil-mt / solo / IdleManyMessages / 12 | 297.945 | 286.978 | x0.963 | level | 3 of 4 | - | - | x1.000 | x0.999 | x1.211 |
| blake3-servil-mt / solo / IdleManyMessages / 16 | 209.904 | 205.635 | x0.980 | level | 3 of 4 | - | - | x0.992 | x0.999 | x0.581 |
| blake3-servil-mt / solo / IdleManyMessages / 24 | 223.361 | 226.653 | x1.015 | level | 0 of 4 | - | - | x0.997 | x0.999 | x0.709 |
| blake3-servil-mt / solo / IdleManyMessages / 32 | 187.143 | 183.448 | x0.980 | level | 4 of 4 | - | - | x0.994 | x0.999 | x0.733 |
| blake3-servil-mt / solo / IdleManyMessages / 48 | 178.535 | 178.618 | x1.000 | level | 1 of 4 | - | - | x0.998 | x0.999 | x0.741 |
| blake3-servil-mt / solo / IdleManyMessages / 64 | 162.855 | 162.326 | x0.997 | level | 2 of 4 | - | - | x1.000 | x0.999 | x0.837 |
| blake3-servil-mt / solo / IdleManyMessages / 128 | 118.965 | 120.896 | x1.016 | level | 1 of 4 | - | - | x0.999 | x1.000 | x0.711 |
| blake3-servil-mt / solo / IdleManyMessages / 256 | 94.840 | 97.007 | x1.023 | level | 1 of 4 | - | - | x0.997 | x1.000 | x0.701 |
| blake3-servil-mt / solo / IdleManyMessages / 512 | 84.026 | 82.777 | x0.985 | level | 1 of 4 | - | - | x0.999 | x1.000 | x1.377 |
| blake3-servil-mt / solo / IdleManyMessages / 1024 | 53.798 | 54.299 | x1.009 | level | 2 of 4 | - | - | x1.013 | x1.000 | x0.563 |
| blake3-servil-mt / solo / IdleManyMessages / 2048 | 43.703 | 42.780 | x0.979 | level | 3 of 4 | - | - | x0.984 | x1.000 | x0.603 |
| blake3-servil-mt / solo / IdleManyMessages / 4096 | 31.320 | 31.057 | x0.992 | level | 3 of 4 | - | - | x1.003 | x1.000 | x0.724 |
| blake3-servil-mt / solo / IdleManyMessages / 8192 | 13.306 | 13.512 | x1.015 | level | 0 of 4 | - | - | x1.018 | x0.974 | x1.225 |
| blake3-servil-mt / solo / IdleManyMessages / 16384 | 11.621 | 11.706 | x1.007 | level | 1 of 4 | - | - | x1.005 | x1.102 | x1.039 |
| blake3-servil-mt / solo / IdleManyMessages / 32768 | 10.726 | 10.474 | x0.977 | level | 3 of 4 | - | - | x0.979 | x1.204 | x0.984 |
| blake3-servil-mt / solo / IdleManyMessages / 65536 | 9.367 | 9.407 | x1.004 | level | 2 of 4 | - | - | x1.001 | x1.278 | x1.000 |
| blake3-servil-mt / solo / IdleManyMessages / 131072 | 8.485 | 8.492 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.025 | x0.985 |
| blake3-servil-mt / solo / IdleManyMessages / 262144 | 7.977 | 7.992 | x1.002 | level | 2 of 4 | - | - | x1.001 | x1.040 | x0.990 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 B | 3.196 | 3.265 | x1.022 | level | 1 of 4 | - | - | x1.009 | x1.007 | x0.885 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 B | 2.370 | 2.431 | x1.026 | level | 1 of 4 | - | - | x1.013 | x1.005 | x1.731 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 B | 1.787 | 1.822 | x1.019 | level | 1 of 4 | - | - | x1.006 | x1.003 | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 B | 1.643 | 1.652 | x1.006 | level | 1 of 4 | - | - | x1.011 | x1.002 | x1.989 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 KiB | 1.506 | 1.513 | x1.005 | level | 0 of 4 | - | - | x1.004 | x1.001 | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1536 B | 1.275 | 1.266 | x0.993 | level | 2 of 4 | - | - | x0.995 | x0.998 | x1.484 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 KiB | 0.902 | 0.918 | x1.019 | level | 1 of 4 | - | - | x1.021 | x1.001 | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2304 B | 1.002 | 1.034 | x1.032 | level | 1 of 4 | - | - | x1.028 | x1.001 | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 KiB | 0.778 | 0.802 | x1.031 | level | 2 of 4 | - | - | x1.027 | x1.001 | x2.598 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3839 B | 0.587 | 0.587 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.001 | x1.326 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 KiB | 0.486 | 0.487 | x1.003 | level | 2 of 4 | - | - | x0.998 | x1.001 | x0.814 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4470 B | 0.594 | 0.596 | x1.003 | level | 2 of 4 | - | - | x1.003 | x1.001 | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 7935 B | 0.449 | 0.454 | x1.013 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.661 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 KiB | 0.396 | 0.398 | x1.005 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.230 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 16 KiB | 0.300 | 0.298 | x0.994 | level | 1 of 4 | - | - | x0.998 | x1.000 | x1.006 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 KiB | 0.294 | 0.293 | x0.999 | level | 1 of 4 | - | - | x0.999 | x1.000 | x1.678 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 KiB | 0.285 | 0.285 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.708 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 KiB | 0.283 | 0.283 | x0.998 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.054 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 KiB | 0.280 | 0.281 | x1.003 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.967 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 KiB | 0.139 | 0.155 | x1.115 | level | 1 of 4 | - | - | x1.112 | x0.986 | x1.693 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 MiB | 0.153 | 0.162 | x1.060 | level | 1 of 4 | - | - | x1.058 | x0.990 | x1.126 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 MiB | 0.135 | 0.134 | x0.990 | level | 3 of 4 | - | - | x0.990 | x0.935 | x1.069 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 MiB | 0.122 | 0.122 | x1.002 | level | 1 of 4 | - | - | x0.999 | x1.003 | x1.032 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 MiB | 0.119 | 0.120 | x1.002 | level | 1 of 4 | - | - | x1.002 | x1.001 | x1.123 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 MiB | 0.132 | 0.132 | x1.002 | level | 2 of 4 | - | - | x1.002 | x0.996 | x0.941 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 MiB | 0.109 | 0.109 | x0.997 | level | 3 of 4 | - | - | x0.997 | x0.999 | x1.011 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 MiB | 0.106 | 0.106 | x0.996 | level | 4 of 4 | - | - | x0.997 | x0.998 | x1.014 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 MiB | 0.104 | 0.103 | x0.998 | level | 4 of 4 | - | - | x0.997 | x0.998 | x0.998 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1 | 235.618 | 236.857 | x1.005 | level | 1 of 4 | - | - | x1.000 | x1.008 | x0.789 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2 | 208.054 | 211.713 | x1.018 | level | 2 of 4 | - | - | x1.009 | x0.997 | x0.949 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 3 | 135.494 | 134.527 | x0.993 | level | 2 of 4 | - | - | x0.995 | x0.997 | x2.153 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4 | 69.158 | 67.418 | x0.975 | level | 3 of 4 | - | - | x0.991 | x0.996 | x2.044 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 6 | 59.755 | 59.791 | x1.001 | level | 1 of 4 | - | - | x1.001 | x0.998 | x0.638 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8 | 42.393 | 42.978 | x1.014 | level | 1 of 4 | - | - | x1.011 | x0.998 | x0.650 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 12 | 37.464 | 38.135 | x1.018 | level | 1 of 4 | - | - | x1.003 | x0.999 | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16 | 26.234 | 26.442 | x1.008 | level | 1 of 4 | - | - | x1.001 | x0.999 | x1.000 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 24 | 27.120 | 27.010 | x0.996 | level | 2 of 4 | - | - | x0.998 | x0.999 | x0.333 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32 | 21.851 | 22.144 | x1.013 | level | 1 of 4 | - | - | x1.003 | x0.999 | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 48 | 20.044 | 19.956 | x0.996 | level | 2 of 4 | - | - | x1.001 | x0.998 | x0.825 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 64 | 19.108 | 19.038 | x0.996 | level | 3 of 4 | - | - | x0.999 | x0.999 | x1.708 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 128 | 17.828 | 17.909 | x1.005 | level | 0 of 4 | - | - | x1.003 | x0.999 | x0.939 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 256 | 18.253 | 18.237 | x0.999 | level | 3 of 4 | - | - | x0.999 | x0.999 | x0.947 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 512 | 18.332 | 18.387 | x1.003 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.677 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1024 | 18.102 | 18.103 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.964 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2048 | 17.987 | 18.216 | x1.013 | level | 1 of 4 | - | - | x1.011 | x1.000 | x1.512 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4096 | 17.992 | 18.053 | x1.003 | level | 0 of 4 | - | - | x1.003 | x1.000 | x1.688 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8192 | 10.704 | 10.817 | x1.011 | level | 2 of 4 | - | - | x1.009 | x0.901 | x1.121 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16384 | 9.487 | 9.655 | x1.018 | level | 1 of 4 | - | - | x1.016 | x0.984 | x0.987 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32768 | 8.434 | 8.487 | x1.006 | level | 1 of 4 | - | - | x1.004 | x0.944 | x1.037 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 65536 | 8.046 | 8.036 | x0.999 | level | 2 of 4 | - | - | x0.997 | x0.990 | x0.982 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 131072 | 8.524 | 8.509 | x0.998 | level | 2 of 4 | - | - | x0.997 | x0.993 | x0.994 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 262144 | 8.085 | 8.053 | x0.996 | level | 3 of 4 | - | - | x0.995 | x0.925 | x0.967 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 1.135 | 1.094 | x0.964 | level | 4 of 4 | x0.991 | - | x0.963 | x0.960 | x0.861 |
| blake3-servil-mt / solo / ContinuousMessages / 128 B | 0.550 | 0.539 | x0.980 | level | 3 of 4 | x0.962 | - | x0.980 | x0.961 | x0.804 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.294 | 0.290 | x0.984 | level | 3 of 4 | x0.983 | - | x0.984 | x0.962 | x1.089 |
| blake3-servil-mt / solo / ContinuousMessages / 512 B | 0.198 | 0.197 | x0.997 | level | 2 of 4 | x0.981 | - | x0.997 | x0.966 | x1.034 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.142 | 0.143 | x1.006 | level | 2 of 4 | x0.932 | - | x1.006 | x0.968 | x1.545 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.100 | 0.0976 | x0.973 | level | 4 of 4 | x1.077 | - | x0.971 | x0.957 | x0.988 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0907 | 0.0938 | x1.035 | level | 1 of 4 | x1.098 | - | x1.035 | x0.960 | x1.513 |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.0744 | 0.0759 | x1.020 | level | 1 of 4 | x0.995 | - | x1.020 | x1.021 | x1.139 |
| blake3-servil-mt / solo / ContinuousMessages / 256 KiB | 0.0734 | 0.0754 | x1.026 | level | 0 of 4 | x0.999 | - | x1.024 | x1.017 | x1.156 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0847 | 0.0856 | x1.011 | level | 2 of 4 | x0.952 | - | x1.011 | x1.018 | x1.137 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.102 | 0.102 | x1.006 | level | 2 of 4 | x1.013 | - | x1.008 | x1.024 | x1.001 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0985 | 0.0991 | x1.006 | level | 2 of 4 | x1.026 | - | x1.006 | x1.009 | x0.918 |
| blake3-servil-mt / solo / ContinuousMessages / 64 MiB | 0.110 | 0.110 | x1.003 | level | 1 of 4 | x0.996 | - | x1.003 | x1.011 | x0.993 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 14.892 | 14.704 | x0.987 | level | 3 of 4 | x0.993 | - | x0.988 | x0.968 | x1.068 |
| blake3-servil-mt / solo / ContinuousBatches / 64 | 9.363 | 9.333 | x0.997 | level | 3 of 4 | x1.008 | - | x1.000 | x0.969 | x0.751 |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 7.375 | 7.310 | x0.991 | level | 4 of 4 | x1.003 | - | x0.991 | x0.958 | x0.828 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 7.051 | 7.024 | x0.996 | level | 3 of 4 | x0.998 | - | x0.998 | x1.029 | x0.979 |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 7.030 | 7.052 | x1.003 | level | 2 of 4 | x0.985 | - | x1.002 | x0.742 | x0.214 |
| blake3-servil-mt / solo / ContinuousBatches / 16384 | 9.252 | 9.285 | x1.004 | level | 2 of 4 | x1.001 | - | x1.004 | x1.046 | x0.478 |
| blake3-servil-mt / solo / ContinuousBatches / 65536 | 8.981 | 9.131 | x1.017 | level | 0 of 4 | x1.001 | - | x1.016 | x0.945 | x1.016 |
| blake3-servil-mt / solo / LentMessages / 64 B | 1.518 | 1.523 | x1.003 | level | 2 of 4 | x1.003 | - | x1.003 | x1.012 | - |
| blake3-servil-mt / solo / LentMessages / 128 B | 1.445 | 1.446 | x1.001 | level | 3 of 4 | x0.999 | - | x0.999 | x1.007 | - |
| blake3-servil-mt / solo / LentMessages / 256 B | 1.410 | 1.414 | x1.003 | level | 2 of 4 | x1.003 | - | x1.003 | x1.004 | - |
| blake3-servil-mt / solo / LentMessages / 512 B | 1.404 | 1.414 | x1.007 | level | 0 of 4 | x1.007 | - | x1.006 | x1.003 | - |
| blake3-servil-mt / solo / LentMessages / 1 KiB | 1.402 | 1.401 | x0.999 | level | 2 of 4 | x0.999 | - | x1.000 | x1.001 | x0.584 |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.438 | 0.435 | x0.995 | level | 4 of 4 | x0.998 | - | x0.998 | x1.001 | x1.437 |
| blake3-servil-mt / solo / LentMessages / 16 KiB | 0.271 | 0.267 | x0.987 | level | 4 of 4 | x0.987 | - | x0.987 | x1.000 | x0.657 |
| blake3-servil-mt / solo / LentMessages / 64 KiB | 0.280 | 0.282 | x1.006 | level | 0 of 4 | x1.006 | - | x1.006 | x1.000 | x1.791 |
| blake3-servil-mt / solo / LentMessages / 256 KiB | 0.277 | 0.279 | x1.006 | level | 0 of 4 | x1.005 | - | x1.005 | x1.000 | x0.274 |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.134 | 0.136 | x1.016 | level | 0 of 4 | x1.015 | - | x1.017 | x1.060 | x0.508 |
| blake3-servil-mt / solo / LentMessages / 4 MiB | 0.117 | 0.118 | x1.008 | level | 1 of 4 | x1.005 | - | x1.008 | x1.007 | x0.464 |
| blake3-servil-mt / solo / LentMessages / 16 MiB | 0.117 | 0.118 | x1.010 | level | 1 of 4 | x1.020 | - | x1.010 | x1.042 | x0.997 |
| blake3-servil-mt / solo / LentMessages / 64 MiB | 0.110 | 0.111 | x1.005 | level | 2 of 4 | x0.998 | - | x1.005 | x1.000 | x1.004 |
| blake3-servil-mt / solo / Interleaved / 256 | 0.391 | 0.393 | x1.004 | level | 1 of 4 | x1.004 | - | x1.004 | x0.999 | x0.950 |
| blake3-servil-mt / solo / Collection / git objects | 0.0164 | 0.0162 | x0.989 | level | 2 of 4 | x0.999 | - | x0.991 | x0.990 | x1.002 |
| blake3-servil-mt / solo / Collection / Nix files | 0.0241 | 0.0235 | x0.972 | level | 4 of 4 | x0.986 | - | x0.972 | x1.002 | x1.073 |
| blake3-servil-mt / solo / LentBatches / 16 | 20.997 | 20.834 | x0.992 | level | 3 of 4 | x0.992 | - | x0.992 | x0.998 | - |
| blake3-servil-mt / solo / LentBatches / 64 | 18.019 | 17.879 | x0.992 | level | 4 of 4 | x0.992 | - | x0.992 | x0.999 | - |
| blake3-servil-mt / solo / LentBatches / 256 | 17.820 | 17.555 | x0.985 | level | 4 of 4 | x0.985 | - | x0.985 | x1.000 | - |
| blake3-servil-mt / solo / LentBatches / 1024 | 19.126 | 19.573 | x1.023 | level | 0 of 4 | x1.023 | - | x1.024 | x0.999 | - |
| blake3-servil-mt / solo / LentBatches / 4096 | 19.330 | 19.381 | x1.003 | level | 1 of 4 | x1.003 | - | x1.003 | x1.000 | - |
| blake3-servil-mt / solo / LentBatches / 16384 | 11.244 | 11.349 | x1.009 | level | 1 of 4 | x1.021 | - | x1.009 | x1.013 | x3.147 |
| blake3-servil-mt / solo / LentBatches / 65536 | 9.928 | 10.284 | x1.036 | level | 0 of 4 | x1.062 | - | x1.036 | x1.036 | x1.168 |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.110 | 0.110 | x1.006 | level | 1 of 4 | x0.984 | - | x1.007 | x0.975 | x1.007 |
| blake3-servil-mt / solo / ContinuousCollection / Nix files | 0.108 | 0.109 | x1.008 | level | 1 of 4 | x1.017 | - | x1.013 | x0.977 | x1.048 |
| blake3-servil-mt / solo / MerkleTree / 1024 | 0.350 | 0.351 | x1.002 | level | 1 of 4 | x1.002 | - | x1.003 | x1.001 | x1.365 |
| blake3-servil-mt / solo / MerkleTree / 4096 | 0.229 | 0.231 | x1.006 | level | 1 of 4 | x1.024 | - | x1.007 | x1.005 | x0.870 |
| blake3-servil-mt / solo / MerkleTree / 16384 | 0.197 | 0.194 | x0.982 | level | 3 of 4 | x1.015 | - | x0.981 | x0.995 | x0.970 |
| blake3-servil-mt / solo / MerkleTree / 65536 | 0.166 | 0.167 | x1.006 | level | 1 of 4 | x1.012 | - | x1.005 | x1.011 | x1.003 |
| blake3-servil-mt / solo / MerkleTree / 262144 | 0.147 | 0.147 | x0.999 | level | 2 of 4 | x1.001 | - | x1.000 | x0.999 | x1.009 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 32 B | 0.259 | 0.256 | x0.989 | level | 3 of 4 | x0.992 | - | x0.991 | x0.979 | x0.985 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 32 B | 0.151 | 0.150 | x0.996 | level | 2 of 4 | x1.001 | - | x0.997 | x0.998 | x1.001 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 16 B | 0.276 | 0.276 | x1.002 | level | 1 of 4 | x1.004 | - | x1.002 | x0.997 | x1.006 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 48 B | 0.209 | 0.209 | x0.998 | level | 2 of 4 | x0.999 | - | x1.000 | x0.989 | x1.057 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 48 B | 0.139 | 0.139 | x1.006 | level | 1 of 4 | x1.001 | - | x1.006 | x1.000 | x1.001 |
| blake3-servil-mt / solo / InterleavedTurn / 256 | 1.019 | 0.994 | x0.975 | level | 3 of 4 | - | - | x0.957 | x0.935 | x0.978 |
| blake3-servil-mt / solo / InterleavedTurn / 1024 x 1 KiB | 0.696 | 0.705 | x1.013 | level | 2 of 4 | - | - | x1.002 | x0.983 | x0.998 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 256 | 0.664 | 0.670 | x1.010 | level | 2 of 4 | - | - | x0.988 | x0.956 | x0.987 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.653 | 0.662 | x1.015 | level | 1 of 4 | - | - | x1.012 | x0.983 | x0.981 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 256 | 0.672 | 0.686 | x1.021 | level | 2 of 4 | - | - | x1.012 | x0.923 | x1.037 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.622 | 0.629 | x1.011 | level | 1 of 4 | - | - | x1.009 | x0.983 | x0.992 |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.103 | 0.104 | x1.007 | level | 2 of 4 | x0.990 | - | x1.007 | x1.001 | x1.141 |
| blake3-servil-mt / solo / ReceivingMessage / 2 μs | 0.105 | 0.105 | x1.005 | level | 1 of 4 | x0.992 | - | x1.005 | x1.000 | x1.040 |
| blake3-servil-mt / solo / ReceivingMessage / 20 μs | 0.918 | 0.918 | x1.000 | level | 1 of 4 | x0.998 | - | x1.002 | x1.007 | x1.127 |
| blake3-servil-mt / solo / IncrementalMessage / 64 B | 19.814 | 19.921 | x1.005 | level | 2 of 4 | - | - | x1.013 | x1.003 | x1.092 |
| blake3-servil-mt / solo / IncrementalMessage / 1 KiB | 3.437 | 3.403 | x0.990 | level | 3 of 4 | - | - | x0.998 | x1.001 | x1.157 |
| blake3-servil-mt / solo / IncrementalMessage / 4 KiB | 2.460 | 2.430 | x0.988 | level | 3 of 4 | - | - | x0.990 | x1.001 | x1.027 |
| blake3-servil-mt / solo / LentIncrementalMessage / 64 B | 1.850 | 1.858 | x1.004 | level | 1 of 4 | x1.001 | - | x1.001 | x1.006 | - |
| blake3-servil-mt / solo / LentIncrementalMessage / 1 KiB | 1.436 | 1.440 | x1.003 | level | 0 of 4 | x1.003 | - | x1.002 | x1.002 | x1.922 |
| blake3-servil-mt / solo / LentIncrementalMessage / 4 KiB | 0.454 | 0.453 | x0.997 | level | 4 of 4 | x0.997 | - | x0.997 | x1.001 | x0.846 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 13.092 | 14.138 | x1.080 | level | 0 of 4 | x1.408 | - | x1.070 | x0.943 | x5.244 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 4 KiB | 0.254 | 0.265 | x1.042 | level | 0 of 4 | x1.114 | - | x1.047 | x0.943 | x3.350 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 1 MiB | 0.0840 | 0.0851 | x1.014 | level | 1 of 4 | x0.996 | - | x1.012 | x1.017 | x1.311 |
| blake3-servil-mt / solo / ContinuousLentMessages / 64 B | 1.023 | 1.008 | x0.985 | level | 3 of 4 | x1.221 | - | x0.984 | x0.953 | x0.991 |
| blake3-servil-mt / solo / ContinuousLentMessages / 4 KiB | 0.0511 | 0.0511 | x1.000 | level | 2 of 4 | x1.084 | - | x0.995 | x0.945 | x0.687 |
| blake3-servil-mt / solo / ContinuousLentMessages / 1 MiB | 0.00874 | 0.00874 | x1.000 | level | 2 of 4 | x0.993 | - | x1.000 | x1.002 | x1.478 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 1.122 | 1.136 | x1.013 | level | 2 of 4 | - | - | x1.012 | x0.960 | x0.929 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 128 B | 0.569 | 0.570 | x1.001 | level | 1 of 4 | - | - | x1.001 | x0.961 | x1.143 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.311 | 0.325 | x1.046 | level | 1 of 4 | - | - | x1.046 | x0.962 | x0.958 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 512 B | 0.224 | 0.239 | x1.069 | level | 1 of 4 | - | - | x1.070 | x0.966 | x0.936 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.162 | 0.167 | x1.033 | level | 1 of 4 | - | - | x1.034 | x0.968 | x1.083 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.107 | 0.109 | x1.019 | level | 2 of 4 | - | - | x1.015 | x0.958 | x0.844 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.109 | 0.112 | x1.031 | level | 1 of 4 | - | - | x1.028 | x0.970 | x0.809 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.0807 | 0.0807 | x0.999 | level | 2 of 4 | - | - | x0.998 | x1.025 | x0.881 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 KiB | 0.0805 | 0.0802 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.015 | x1.006 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0873 | 0.0906 | x1.037 | level | 1 of 4 | - | - | x1.035 | x0.996 | x1.117 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.104 | 0.105 | x1.012 | level | 1 of 4 | - | - | x1.020 | x0.990 | x1.083 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.105 | 0.106 | x1.012 | level | 1 of 4 | - | - | x1.011 | x1.016 | x0.934 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 MiB | 0.128 | 0.129 | x1.013 | level | 1 of 4 | - | - | x1.013 | x1.013 | x0.994 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 15.345 | 15.356 | x1.001 | level | 1 of 4 | - | - | x1.001 | x0.969 | x0.832 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 64 | 9.759 | 9.713 | x0.995 | level | 1 of 4 | - | - | x0.995 | x0.973 | x0.990 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 256 | 7.695 | 7.692 | x1.000 | level | 1 of 4 | - | - | x1.000 | x0.959 | x0.808 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 7.210 | 7.098 | x0.984 | level | 2 of 4 | - | - | x0.984 | x0.979 | x0.918 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 4096 | 7.580 | 7.419 | x0.979 | level | 3 of 4 | - | - | x0.978 | x1.017 | x0.608 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16384 | 9.548 | 9.606 | x1.006 | level | 0 of 4 | - | - | x1.005 | x1.121 | x0.504 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 65536 | 9.236 | 9.172 | x0.993 | level | 3 of 4 | - | - | x0.993 | x0.942 | x1.454 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 1.518 | 1.515 | x0.998 | level | 3 of 4 | - | - | x0.999 | x1.012 | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 128 B | 1.443 | 1.436 | x0.995 | level | 4 of 4 | - | - | x0.995 | x1.007 | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 B | 1.434 | 1.409 | x0.983 | level | 4 of 4 | - | - | x0.982 | x1.004 | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 512 B | 1.411 | 1.414 | x1.003 | level | 0 of 4 | - | - | x1.003 | x1.002 | x1.261 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 KiB | 1.398 | 1.400 | x1.001 | level | 0 of 4 | - | - | x1.001 | x1.001 | x1.484 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.441 | 0.437 | x0.990 | level | 4 of 4 | - | - | x0.990 | x1.001 | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 KiB | 0.272 | 0.271 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.734 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 KiB | 0.281 | 0.280 | x0.999 | level | 4 of 4 | - | - | x0.999 | x1.000 | x0.667 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 KiB | 0.277 | 0.277 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.279 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 MiB | 0.152 | 0.153 | x1.006 | level | 1 of 4 | - | - | x1.008 | x1.055 | x1.050 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 MiB | 0.125 | 0.124 | x0.996 | level | 2 of 4 | - | - | x0.998 | x1.014 | x2.021 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 MiB | 0.139 | 0.137 | x0.982 | level | 3 of 4 | - | - | x0.985 | x0.994 | x0.962 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 MiB | 0.124 | 0.124 | x1.002 | level | 1 of 4 | - | - | x1.002 | x1.001 | x1.002 |
| blake3-servil-mt / shared-one-cache / Interleaved / 256 | 0.384 | 0.384 | x0.999 | level | 3 of 4 | - | - | x1.000 | x0.999 | x0.830 |
| blake3-servil-mt / shared-one-cache / Collection / git objects | 0.0277 | 0.0265 | x0.956 | level | 3 of 4 | - | - | x0.961 | x0.956 | x0.960 |
| blake3-servil-mt / shared-one-cache / Collection / Nix files | 0.0326 | 0.0331 | x1.014 | level | 0 of 4 | - | - | x1.020 | x1.002 | x0.994 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16 | 20.549 | 20.861 | x1.015 | level | 0 of 4 | - | - | x1.012 | x0.998 | x0.448 |
| blake3-servil-mt / shared-one-cache / LentBatches / 64 | 18.051 | 18.019 | x0.998 | level | 2 of 4 | - | - | x0.998 | x0.999 | - |
| blake3-servil-mt / shared-one-cache / LentBatches / 256 | 17.744 | 17.707 | x0.998 | level | 3 of 4 | - | - | x0.998 | x0.999 | x0.830 |
| blake3-servil-mt / shared-one-cache / LentBatches / 1024 | 19.317 | 19.061 | x0.987 | level | 4 of 4 | - | - | x0.987 | x0.999 | x2.817 |
| blake3-servil-mt / shared-one-cache / LentBatches / 4096 | 19.286 | 18.995 | x0.985 | level | 4 of 4 | - | - | x0.985 | x1.000 | x1.549 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16384 | 12.846 | 12.712 | x0.990 | level | 3 of 4 | - | - | x0.990 | x1.069 | x1.561 |
| blake3-servil-mt / shared-one-cache / LentBatches / 65536 | 10.613 | 10.494 | x0.989 | level | 4 of 4 | - | - | x0.989 | x0.988 | x1.865 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.125 | 0.126 | x1.005 | level | 2 of 4 | - | - | x1.005 | x0.975 | x0.984 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / Nix files | 0.123 | 0.124 | x1.011 | level | 1 of 4 | - | - | x1.012 | x0.979 | x1.012 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1024 | 0.350 | 0.349 | x0.997 | level | 4 of 4 | - | - | x0.997 | x1.001 | x1.326 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 4096 | 0.251 | 0.252 | x1.005 | level | 1 of 4 | - | - | x1.005 | x1.002 | x0.583 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 16384 | 0.202 | 0.204 | x1.009 | level | 1 of 4 | - | - | x1.006 | x0.996 | x0.652 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 | 0.192 | 0.192 | x1.000 | level | 3 of 4 | - | - | x0.999 | x0.989 | x1.015 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 262144 | 0.175 | 0.175 | x0.999 | level | 2 of 4 | - | - | x0.997 | x0.999 | x0.999 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 32 B | 0.287 | 0.282 | x0.986 | level | 3 of 4 | - | - | x0.987 | x0.987 | x0.945 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 32 B | 0.233 | 0.232 | x0.999 | level | 3 of 4 | - | - | x1.011 | x0.945 | x1.031 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 16 B | 0.422 | 0.422 | x1.001 | level | 2 of 4 | - | - | x0.995 | x1.014 | x0.992 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 48 B | 0.230 | 0.227 | x0.985 | level | 3 of 4 | - | - | x0.987 | x0.998 | x0.656 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 48 B | 0.196 | 0.196 | x0.999 | level | 2 of 4 | - | - | x0.999 | x0.995 | x1.000 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.108 | 0.110 | x1.012 | level | 1 of 4 | - | - | x1.011 | x1.011 | x1.043 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 2 μs | 0.110 | 0.111 | x1.012 | level | 1 of 4 | - | - | x1.012 | x0.998 | x1.039 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 20 μs | 0.918 | 0.918 | x1.000 | level | 2 of 4 | - | - | x0.994 | x1.012 | x1.007 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 64 B | 1.853 | 1.853 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.006 | x0.916 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 1 KiB | 1.436 | 1.440 | x1.003 | level | 0 of 4 | - | - | x1.002 | x1.002 | x0.920 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 4 KiB | 0.454 | 0.455 | x1.003 | level | 0 of 4 | - | - | x1.003 | x1.001 | x0.988 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 17.694 | 17.845 | x1.009 | level | 2 of 4 | - | - | x0.957 | x0.942 | x17.645 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 4 KiB | 0.296 | 0.306 | x1.036 | level | 1 of 4 | - | - | x1.030 | x0.943 | x12.511 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 1 MiB | 0.0882 | 0.0892 | x1.012 | level | 1 of 4 | - | - | x1.012 | x1.011 | x1.018 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 64 B | 1.024 | 0.999 | x0.975 | level | 3 of 4 | - | - | x0.976 | x0.953 | x0.980 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 4 KiB | 0.0659 | 0.0640 | x0.971 | level | 3 of 4 | - | - | x0.962 | x0.946 | x0.988 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 1 MiB | 0.0184 | 0.0175 | x0.955 | level | 2 of 4 | - | - | x1.043 | x1.048 | x0.564 |

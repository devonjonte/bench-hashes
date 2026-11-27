# Nightly drift check: e1966b498bc7 -> 17ccf2c8f5bb

- Host: bench-9700x
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
| blake3-servil-st / solo / OneMessage / 128 B | 3.505 | 3.275 | x0.934 | level | 38 of 64 | - | - | x0.972 | x1.006 | x0.964 |
| blake3-servil-st / solo / OneMessage / 16 KiB | 0.401 | 0.400 | x0.996 | level | 37 of 64 | - | - | x0.998 | x1.000 | x1.003 |
| blake3-servil-st / solo / IdleManyMessages / 1 | 235.434 | 237.478 | x1.009 | level | 21 of 64 | - | - | x1.004 | x1.007 | x1.056 |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.746 | 0.751 | x1.007 | level | 0 of 64 | x1.007 | - | x1.007 | x1.012 | x1.036 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 0.755 | 0.759 | x1.005 | level | 0 of 64 | x1.005 | - | x1.005 | x1.013 | x0.978 |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 0.721 | 0.724 | x1.004 | level | 0 of 64 | x1.004 | - | x1.004 | x1.015 | - |
| blake3-servil-mt / solo / OneMessage / 64 B | 5.725 | 5.511 | x0.963 | level | 33 of 64 | - | - | x0.983 | x1.007 | x0.980 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 4.799 | 4.736 | x0.987 | level | 46 of 64 | x1.004 | - | x0.986 | x0.943 | x1.016 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 4.519 | 4.484 | x0.992 | level | 33 of 64 | - | - | x0.971 | x0.949 | x1.017 |

## Stage 1 (initial screen, kept-drift)

compare: old side: bench 3f119a507807 clean; servil e1966b498bc7 clean
compare: new side: bench 3f119a507807 clean; servil 17ccf2c8f5bb clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 6.298 | 6.857 | x1.089 | level | 1 of 4 | - | - | x1.060 | x0.991 | x1.079 |
| blake3-servil-st / solo / OneMessage / 128 B | 3.912 | 4.183 | x1.069 | level | 0 of 4 | - | - | x1.050 | x0.995 | x1.074 |
| blake3-servil-st / solo / OneMessage / 256 B | 2.644 | 2.686 | x1.016 | level | 2 of 4 | - | - | x1.019 | x1.006 | x1.092 |
| blake3-servil-st / solo / OneMessage / 512 B | 1.881 | 1.856 | x0.987 | level | 3 of 4 | - | - | x1.016 | x1.001 | x1.078 |
| blake3-servil-st / solo / OneMessage / 1 KiB | 1.502 | 1.485 | x0.989 | level | 4 of 4 | - | - | x0.996 | x1.001 | x1.084 |
| blake3-servil-st / solo / OneMessage / 1536 B | 1.381 | 1.364 | x0.988 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.986 |
| blake3-servil-st / solo / OneMessage / 2 KiB | 0.828 | 0.834 | x1.008 | level | 1 of 4 | - | - | x1.017 | x1.001 | x0.987 |
| blake3-servil-st / solo / OneMessage / 2304 B | 1.023 | 1.028 | x1.004 | level | 1 of 4 | - | - | x1.012 | x1.003 | x1.012 |
| blake3-servil-st / solo / OneMessage / 3 KiB | 0.696 | 0.727 | x1.045 | level | 1 of 4 | - | - | x1.052 | x1.000 | x1.008 |
| blake3-servil-st / solo / OneMessage / 3839 B | 0.768 | 0.768 | x1.000 | level | 2 of 4 | - | - | x1.014 | x0.999 | x0.999 |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.444 | 0.460 | x1.035 | level | 0 of 4 | - | - | x1.026 | x1.000 | x1.002 |
| blake3-servil-st / solo / OneMessage / 4470 B | 0.584 | 0.587 | x1.005 | level | 3 of 4 | - | - | x1.015 | x1.001 | x1.004 |
| blake3-servil-st / solo / OneMessage / 7935 B | 0.612 | 0.600 | x0.980 | level | 2 of 4 | - | - | x0.984 | x1.000 | x1.013 |
| blake3-servil-st / solo / OneMessage / 8 KiB | 0.363 | 0.385 | x1.061 | level | 1 of 4 | - | - | x1.067 | x1.000 | x1.006 |
| blake3-servil-st / solo / OneMessage / 16 KiB | 0.220 | 0.243 | x1.103 | level | 1 of 4 | - | - | x1.100 | x1.000 | x0.986 |
| blake3-servil-st / solo / OneMessage / 32 KiB | 0.190 | 0.196 | x1.032 | level | 1 of 4 | - | - | x1.038 | x1.000 | x0.969 |
| blake3-servil-st / solo / OneMessage / 64 KiB | 0.142 | 0.143 | x1.006 | level | 2 of 4 | - | - | x1.008 | x1.000 | x0.998 |
| blake3-servil-st / solo / OneMessage / 128 KiB | 0.115 | 0.115 | x0.997 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.023 |
| blake3-servil-st / solo / OneMessage / 256 KiB | 0.102 | 0.102 | x0.996 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.118 |
| blake3-servil-st / solo / OneMessage / 512 KiB | 0.0906 | 0.0907 | x1.002 | level | 3 of 4 | - | - | x1.002 | x1.000 | x1.028 |
| blake3-servil-st / solo / OneMessage / 1 MiB | 0.0851 | 0.0856 | x1.006 | level | 0 of 4 | - | - | x1.003 | x1.000 | x1.070 |
| blake3-servil-st / solo / OneMessage / 2 MiB | 0.0846 | 0.0845 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.004 |
| blake3-servil-st / solo / OneMessage / 3 MiB | 0.0849 | 0.0844 | x0.994 | level | 3 of 4 | - | - | x0.995 | x1.000 | x1.005 |
| blake3-servil-st / solo / OneMessage / 4 MiB | 0.0844 | 0.0847 | x1.004 | level | 2 of 4 | - | - | x1.004 | x1.000 | x1.012 |
| blake3-servil-st / solo / OneMessage / 8 MiB | 0.0899 | 0.0903 | x1.005 | level | 2 of 4 | - | - | x1.004 | x1.000 | x1.030 |
| blake3-servil-st / solo / OneMessage / 32 MiB | 0.129 | 0.130 | x1.003 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.993 |
| blake3-servil-st / solo / OneMessage / 64 MiB | 0.130 | 0.130 | x1.001 | level | 3 of 4 | - | - | x1.001 | x1.000 | x0.994 |
| blake3-servil-st / solo / OneMessage / 128 MiB | 0.130 | 0.130 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.995 |
| blake3-servil-st / solo / ManyMessages / 1 | 655.512 | 723.594 | x1.104 | level | 2 of 4 | - | - | x1.016 | x1.016 | x1.017 |
| blake3-servil-st / solo / ManyMessages / 2 | 273.502 | 268.697 | x0.982 | level | 3 of 4 | - | - | x0.941 | x1.000 | x0.912 |
| blake3-servil-st / solo / ManyMessages / 3 | 212.287 | 201.068 | x0.947 | level | 3 of 4 | - | - | x0.943 | x1.005 | x0.931 |
| blake3-servil-st / solo / ManyMessages / 4 | 131.584 | 123.972 | x0.942 | level | 1 of 4 | - | - | x0.953 | x1.001 | x0.980 |
| blake3-servil-st / solo / ManyMessages / 6 | 104.966 | 99.379 | x0.947 | level | 1 of 4 | - | - | x0.944 | x1.009 | x0.946 |
| blake3-servil-st / solo / ManyMessages / 8 | 100.713 | 97.073 | x0.964 | level | 2 of 4 | - | - | x0.981 | x1.009 | x1.031 |
| blake3-servil-st / solo / ManyMessages / 12 | 79.633 | 75.422 | x0.947 | level | 1 of 4 | - | - | x0.971 | x1.005 | x1.013 |
| blake3-servil-st / solo / ManyMessages / 16 | 64.548 | 55.496 | x0.860 | level | 4 of 4 | - | - | x0.922 | x1.004 | x1.003 |
| blake3-servil-st / solo / ManyMessages / 24 | 51.431 | 48.536 | x0.944 | level | 3 of 4 | - | - | x0.990 | x1.007 | x1.017 |
| blake3-servil-st / solo / ManyMessages / 32 | 32.227 | 29.879 | x0.927 | level | 3 of 4 | - | - | x0.976 | x1.002 | x1.003 |
| blake3-servil-st / solo / ManyMessages / 48 | 22.673 | 21.419 | x0.945 | level | 3 of 4 | - | - | x0.982 | x1.001 | x1.014 |
| blake3-servil-st / solo / ManyMessages / 64 | 18.889 | 18.001 | x0.953 | level | 3 of 4 | - | - | x0.992 | x1.000 | x1.012 |
| blake3-servil-st / solo / ManyMessages / 128 | 13.282 | 13.213 | x0.995 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.989 |
| blake3-servil-st / solo / ManyMessages / 256 | 10.461 | 10.537 | x1.007 | level | 2 of 4 | - | - | x1.024 | x0.999 | x1.005 |
| blake3-servil-st / solo / ManyMessages / 512 | 8.888 | 8.810 | x0.991 | level | 2 of 4 | - | - | x1.003 | x0.999 | x0.939 |
| blake3-servil-st / solo / ManyMessages / 1024 | 8.013 | 7.968 | x0.994 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.979 |
| blake3-servil-st / solo / ManyMessages / 2048 | 7.647 | 7.592 | x0.993 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.113 |
| blake3-servil-st / solo / ManyMessages / 4096 | 7.465 | 7.427 | x0.995 | level | 2 of 4 | - | - | x0.995 | x1.000 | x1.018 |
| blake3-servil-st / solo / ManyMessages / 8192 | 7.047 | 7.090 | x1.006 | level | 2 of 4 | - | - | x1.005 | x1.000 | x1.020 |
| blake3-servil-st / solo / ManyMessages / 16384 | 6.736 | 6.766 | x1.004 | level | 2 of 4 | - | - | x1.004 | x1.000 | x0.999 |
| blake3-servil-st / solo / ManyMessages / 32768 | 6.744 | 6.762 | x1.003 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.007 |
| blake3-servil-st / solo / ManyMessages / 65536 | 6.897 | 6.919 | x1.003 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.007 |
| blake3-servil-st / solo / ManyMessages / 131072 | 7.201 | 7.201 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.991 |
| blake3-servil-st / solo / ManyMessages / 262144 | 7.650 | 7.655 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.998 |
| blake3-servil-st / solo / ManyLongMessages / 4 | 1697.977 | 1671.291 | x0.984 | level | 2 of 4 | - | - | x0.977 | x1.001 | x1.001 |
| blake3-servil-st / solo / ManyLongMessages / 16 | 1375.779 | 617.629 | x0.449 | faster | 4 of 4 | - | - | x0.454 | x0.575 | x1.372 |
| blake3-servil-st / solo / ManyLongMessages / 64 | 496.432 | 486.052 | x0.979 | level | 4 of 4 | - | - | x0.977 | x0.998 | x1.025 |
| blake3-servil-st / solo / ManyLongMessages / 256 | 447.372 | 442.234 | x0.989 | level | 4 of 4 | - | - | x0.988 | x0.998 | x0.950 |
| blake3-servil-st / solo / IdleOneMessage / 64 B | 3.438 | 3.524 | x1.025 | level | 1 of 4 | - | - | x1.012 | x1.005 | x0.626 |
| blake3-servil-st / solo / IdleOneMessage / 128 B | 2.420 | 2.435 | x1.006 | level | 1 of 4 | - | - | x1.006 | x1.004 | x1.331 |
| blake3-servil-st / solo / IdleOneMessage / 256 B | 1.969 | 1.950 | x0.990 | level | 3 of 4 | - | - | x1.001 | x1.003 | x0.951 |
| blake3-servil-st / solo / IdleOneMessage / 512 B | 1.678 | 1.662 | x0.991 | level | 2 of 4 | - | - | x1.000 | x1.002 | x0.974 |
| blake3-servil-st / solo / IdleOneMessage / 1 KiB | 1.563 | 1.556 | x0.995 | level | 3 of 4 | - | - | x1.001 | x1.001 | x1.106 |
| blake3-servil-st / solo / IdleOneMessage / 1536 B | 1.132 | 1.139 | x1.006 | level | 0 of 4 | - | - | x0.998 | x0.998 | x0.835 |
| blake3-servil-st / solo / IdleOneMessage / 2 KiB | 0.843 | 0.831 | x0.985 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.274 |
| blake3-servil-st / solo / IdleOneMessage / 2304 B | 0.931 | 0.926 | x0.995 | level | 3 of 4 | - | - | x0.995 | x1.001 | x2.337 |
| blake3-servil-st / solo / IdleOneMessage / 3 KiB | 0.596 | 0.591 | x0.992 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.328 |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 0.490 | 0.476 | x0.971 | level | 3 of 4 | - | - | x0.997 | x1.001 | x0.745 |
| blake3-servil-st / solo / IdleOneMessage / 4 KiB | 0.442 | 0.436 | x0.987 | level | 2 of 4 | - | - | x0.999 | x1.001 | x0.689 |
| blake3-servil-st / solo / IdleOneMessage / 4470 B | 0.544 | 0.543 | x0.998 | level | 2 of 4 | - | - | x0.999 | x1.001 | x0.598 |
| blake3-servil-st / solo / IdleOneMessage / 7935 B | 0.276 | 0.274 | x0.992 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.861 |
| blake3-servil-st / solo / IdleOneMessage / 8 KiB | 0.259 | 0.258 | x0.996 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.548 |
| blake3-servil-st / solo / IdleOneMessage / 16 KiB | 0.144 | 0.146 | x1.008 | level | 1 of 4 | - | - | x1.003 | x1.000 | x2.270 |
| blake3-servil-st / solo / IdleOneMessage / 32 KiB | 0.100 | 0.102 | x1.021 | level | 2 of 4 | - | - | x1.002 | x1.000 | x2.371 |
| blake3-servil-st / solo / IdleOneMessage / 64 KiB | 0.0910 | 0.0908 | x0.998 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.040 |
| blake3-servil-st / solo / IdleOneMessage / 128 KiB | 0.0878 | 0.0893 | x1.017 | level | 1 of 4 | - | - | x0.990 | x1.000 | x0.380 |
| blake3-servil-st / solo / IdleOneMessage / 256 KiB | 0.0868 | 0.0879 | x1.013 | level | 1 of 4 | - | - | x0.990 | x1.000 | x0.849 |
| blake3-servil-st / solo / IdleOneMessage / 512 KiB | 0.0949 | 0.0947 | x0.999 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.968 |
| blake3-servil-st / solo / IdleOneMessage / 1 MiB | 0.0980 | 0.0982 | x1.002 | level | 1 of 4 | - | - | x0.989 | x1.000 | x1.037 |
| blake3-servil-st / solo / IdleOneMessage / 2 MiB | 0.0983 | 0.0979 | x0.996 | level | 2 of 4 | - | - | x0.988 | x1.000 | x1.042 |
| blake3-servil-st / solo / IdleOneMessage / 3 MiB | 0.101 | 0.0983 | x0.975 | level | 4 of 4 | - | - | x0.992 | x1.000 | x1.051 |
| blake3-servil-st / solo / IdleOneMessage / 4 MiB | 0.0983 | 0.0985 | x1.002 | level | 2 of 4 | - | - | x0.992 | x1.000 | x1.088 |
| blake3-servil-st / solo / IdleOneMessage / 8 MiB | 0.0982 | 0.0967 | x0.985 | level | 2 of 4 | - | - | x0.994 | x1.000 | x1.042 |
| blake3-servil-st / solo / IdleOneMessage / 32 MiB | 0.124 | 0.125 | x1.001 | level | 2 of 4 | - | - | x1.004 | x1.000 | x0.998 |
| blake3-servil-st / solo / IdleOneMessage / 64 MiB | 0.129 | 0.129 | x1.001 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.998 |
| blake3-servil-st / solo / IdleOneMessage / 128 MiB | 0.130 | 0.129 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.995 |
| blake3-servil-st / solo / IdleManyMessages / 1 | 236.231 | 239.419 | x1.013 | level | 1 of 4 | - | - | x1.001 | x1.008 | x0.693 |
| blake3-servil-st / solo / IdleManyMessages / 2 | 118.938 | 119.644 | x1.006 | level | 2 of 4 | - | - | x1.000 | x0.998 | x0.512 |
| blake3-servil-st / solo / IdleManyMessages / 3 | 103.801 | 104.383 | x1.006 | level | 1 of 4 | - | - | x1.002 | x0.998 | x1.498 |
| blake3-servil-st / solo / IdleManyMessages / 4 | 61.476 | 61.904 | x1.007 | level | 1 of 4 | - | - | x1.002 | x0.998 | x2.714 |
| blake3-servil-st / solo / IdleManyMessages / 6 | 53.519 | 52.775 | x0.986 | level | 2 of 4 | - | - | x1.001 | x0.998 | x1.287 |
| blake3-servil-st / solo / IdleManyMessages / 8 | 33.453 | 34.952 | x1.045 | level | 1 of 4 | - | - | x1.033 | x0.998 | x0.328 |
| blake3-servil-st / solo / IdleManyMessages / 12 | 29.797 | 31.116 | x1.044 | level | 2 of 4 | - | - | x1.027 | x0.999 | x0.572 |
| blake3-servil-st / solo / IdleManyMessages / 16 | 17.261 | 16.762 | x0.971 | level | 3 of 4 | - | - | x0.997 | x0.998 | x2.444 |
| blake3-servil-st / solo / IdleManyMessages / 24 | 15.996 | 16.304 | x1.019 | level | 3 of 4 | - | - | x1.020 | x0.999 | x1.396 |
| blake3-servil-st / solo / IdleManyMessages / 32 | 12.499 | 12.235 | x0.979 | level | 3 of 4 | - | - | x0.986 | x0.999 | x0.180 |
| blake3-servil-st / solo / IdleManyMessages / 48 | 10.770 | 10.580 | x0.982 | level | 3 of 4 | - | - | x0.995 | x0.999 | x0.971 |
| blake3-servil-st / solo / IdleManyMessages / 64 | 9.862 | 9.696 | x0.983 | level | 3 of 4 | - | - | x0.998 | x0.999 | x1.298 |
| blake3-servil-st / solo / IdleManyMessages / 128 | 8.761 | 8.777 | x1.002 | level | 2 of 4 | - | - | x0.999 | x0.999 | x0.850 |
| blake3-servil-st / solo / IdleManyMessages / 256 | 8.140 | 8.001 | x0.983 | level | 3 of 4 | - | - | x1.007 | x0.999 | x1.618 |
| blake3-servil-st / solo / IdleManyMessages / 512 | 7.590 | 7.703 | x1.015 | level | 2 of 4 | - | - | x0.995 | x1.000 | x0.789 |
| blake3-servil-st / solo / IdleManyMessages / 1024 | 7.635 | 7.453 | x0.976 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.783 |
| blake3-servil-st / solo / IdleManyMessages / 2048 | 7.600 | 7.512 | x0.988 | level | 3 of 4 | - | - | x1.002 | x1.000 | x1.037 |
| blake3-servil-st / solo / IdleManyMessages / 4096 | 7.767 | 7.742 | x0.997 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.020 |
| blake3-servil-st / solo / IdleManyMessages / 8192 | 8.381 | 8.323 | x0.993 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.971 |
| blake3-servil-st / solo / IdleManyMessages / 16384 | 8.640 | 8.663 | x1.003 | level | 2 of 4 | - | - | x1.006 | x1.000 | x0.989 |
| blake3-servil-st / solo / IdleManyMessages / 32768 | 8.630 | 8.783 | x1.018 | level | 0 of 4 | - | - | x1.002 | x1.000 | x0.983 |
| blake3-servil-st / solo / IdleManyMessages / 65536 | 8.183 | 8.443 | x1.032 | level | 1 of 4 | - | - | x0.999 | x1.000 | x0.970 |
| blake3-servil-st / solo / IdleManyMessages / 131072 | 7.781 | 7.779 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.990 |
| blake3-servil-st / solo / IdleManyMessages / 262144 | 8.203 | 8.168 | x0.996 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.027 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 B | 2.469 | 2.431 | x0.985 | level | 3 of 4 | - | - | x0.999 | x1.006 | x0.834 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 B | 1.692 | 1.703 | x1.006 | level | 0 of 4 | - | - | x1.004 | x1.004 | x0.629 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 B | 1.357 | 1.358 | x1.000 | level | 1 of 4 | - | - | x1.002 | x1.003 | x0.653 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 B | 1.167 | 1.168 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.002 | x2.442 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 KiB | 1.078 | 1.079 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.001 | x0.874 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1536 B | 0.809 | 0.810 | x1.001 | level | 1 of 4 | - | - | x1.001 | x0.998 | x1.370 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 KiB | 0.584 | 0.584 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.205 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2304 B | 0.652 | 0.648 | x0.995 | level | 4 of 4 | - | - | x0.995 | x1.001 | x0.774 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.418 | 0.418 | x1.000 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.475 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3839 B | 0.341 | 0.340 | x0.997 | level | 3 of 4 | - | - | x0.999 | x1.001 | x1.022 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 KiB | 0.311 | 0.311 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.001 | x0.840 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4470 B | 0.383 | 0.383 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.001 | x0.330 |
| blake3-servil-st / solo / BriefIdleOneMessage / 7935 B | 0.192 | 0.192 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.001 | x1.013 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 KiB | 0.180 | 0.179 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x2.087 |
| blake3-servil-st / solo / BriefIdleOneMessage / 16 KiB | 0.101 | 0.101 | x1.003 | level | 2 of 4 | - | - | x1.004 | x1.000 | x0.944 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 KiB | 0.0705 | 0.0706 | x1.002 | level | 1 of 4 | - | - | x1.003 | x1.000 | x0.906 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 KiB | 0.0653 | 0.0654 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.697 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 KiB | 0.0628 | 0.0629 | x1.002 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.507 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 KiB | 0.0622 | 0.0619 | x0.994 | level | 4 of 4 | - | - | x0.995 | x1.000 | x0.603 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 KiB | 0.0673 | 0.0669 | x0.995 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.962 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 MiB | 0.0705 | 0.0698 | x0.990 | level | 3 of 4 | - | - | x0.989 | x1.000 | x1.001 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 MiB | 0.0711 | 0.0703 | x0.990 | level | 3 of 4 | - | - | x0.990 | x1.000 | x0.967 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 MiB | 0.0705 | 0.0697 | x0.989 | level | 2 of 4 | - | - | x0.990 | x1.000 | x0.956 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 MiB | 0.0702 | 0.0697 | x0.993 | level | 2 of 4 | - | - | x0.992 | x1.000 | x0.935 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 MiB | 0.0717 | 0.0712 | x0.994 | level | 2 of 4 | - | - | x0.992 | x1.000 | x0.956 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 MiB | 0.127 | 0.127 | x1.004 | level | 2 of 4 | - | - | x1.004 | x1.000 | x0.995 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 MiB | 0.130 | 0.130 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.997 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 MiB | 0.130 | 0.130 | x0.996 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.996 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1 | 166.327 | 166.191 | x0.999 | level | 3 of 4 | - | - | x1.001 | x1.008 | x0.638 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2 | 83.431 | 83.536 | x1.001 | level | 2 of 4 | - | - | x1.004 | x0.998 | x0.308 |
| blake3-servil-st / solo / BriefIdleManyMessages / 3 | 72.063 | 72.003 | x0.999 | level | 2 of 4 | - | - | x1.000 | x0.998 | x0.748 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4 | 42.346 | 42.200 | x0.997 | level | 3 of 4 | - | - | x1.002 | x0.998 | x0.327 |
| blake3-servil-st / solo / BriefIdleManyMessages / 6 | 36.803 | 36.665 | x0.996 | level | 3 of 4 | - | - | x1.000 | x0.998 | x0.879 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8 | 22.678 | 23.989 | x1.058 | level | 3 of 4 | - | - | x1.037 | x0.998 | x0.548 |
| blake3-servil-st / solo / BriefIdleManyMessages / 12 | 20.503 | 21.378 | x1.043 | level | 3 of 4 | - | - | x1.031 | x0.999 | x0.778 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16 | 11.902 | 11.680 | x0.981 | level | 3 of 4 | - | - | x0.992 | x0.998 | x1.075 |
| blake3-servil-st / solo / BriefIdleManyMessages / 24 | 11.086 | 11.366 | x1.025 | level | 3 of 4 | - | - | x1.020 | x0.999 | x0.983 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32 | 8.497 | 8.349 | x0.983 | level | 3 of 4 | - | - | x0.990 | x0.999 | x0.741 |
| blake3-servil-st / solo / BriefIdleManyMessages / 48 | 7.370 | 7.284 | x0.988 | level | 3 of 4 | - | - | x0.993 | x0.999 | x0.939 |
| blake3-servil-st / solo / BriefIdleManyMessages / 64 | 6.782 | 6.723 | x0.991 | level | 3 of 4 | - | - | x0.996 | x0.999 | x1.100 |
| blake3-servil-st / solo / BriefIdleManyMessages / 128 | 5.947 | 5.921 | x0.996 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.988 |
| blake3-servil-st / solo / BriefIdleManyMessages / 256 | 5.640 | 5.625 | x0.997 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.389 |
| blake3-servil-st / solo / BriefIdleManyMessages / 512 | 5.439 | 5.440 | x1.000 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.515 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1024 | 5.359 | 5.413 | x1.010 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.561 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2048 | 5.357 | 5.352 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.982 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4096 | 5.474 | 5.474 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.049 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8192 | 5.870 | 5.847 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.959 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16384 | 6.033 | 6.023 | x0.998 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.977 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32768 | 6.088 | 6.089 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.982 |
| blake3-servil-st / solo / BriefIdleManyMessages / 65536 | 6.038 | 6.051 | x1.002 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.983 |
| blake3-servil-st / solo / BriefIdleManyMessages / 131072 | 6.079 | 6.052 | x0.996 | level | 2 of 4 | - | - | x0.995 | x1.000 | x1.001 |
| blake3-servil-st / solo / BriefIdleManyMessages / 262144 | 6.996 | 6.983 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.990 |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.747 | 0.751 | x1.006 | level | 0 of 4 | x1.006 | - | x1.006 | x1.012 | x0.900 |
| blake3-servil-st / solo / ContinuousMessages / 128 B | 0.857 | 0.858 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.007 | x1.272 |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 0.914 | 0.916 | x1.002 | level | 0 of 4 | x1.002 | - | x1.002 | x1.004 | x1.048 |
| blake3-servil-st / solo / ContinuousMessages / 512 B | 0.943 | 0.944 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.002 | x1.287 |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 0.961 | 0.962 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.001 | x0.968 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.284 | 0.285 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.001 | x1.214 |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.0910 | 0.0909 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.967 |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.0653 | 0.0650 | x0.996 | level | 3 of 4 | x0.996 | - | x0.995 | x1.000 | x1.028 |
| blake3-servil-st / solo / ContinuousMessages / 256 KiB | 0.0668 | 0.0667 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x1.000 | x0.801 |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.0675 | 0.0678 | x1.004 | level | 2 of 4 | x1.003 | - | x1.001 | x1.000 | x1.019 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.0686 | 0.0685 | x0.999 | level | 2 of 4 | x0.999 | - | x0.998 | x1.000 | x0.962 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.0688 | 0.0688 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.956 |
| blake3-servil-st / solo / ContinuousMessages / 64 MiB | 0.0797 | 0.0795 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x1.000 | x0.993 |
| blake3-servil-st / solo / ContinuousBatches / 16 | 6.040 | 6.023 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x0.998 | x0.960 |
| blake3-servil-st / solo / ContinuousBatches / 64 | 5.314 | 5.309 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x0.999 | x1.454 |
| blake3-servil-st / solo / ContinuousBatches / 256 | 5.272 | 5.278 | x1.001 | level | 2 of 4 | x1.001 | - | x1.000 | x1.000 | x1.387 |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 5.626 | 5.620 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x0.489 |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 5.505 | 5.483 | x0.996 | level | 4 of 4 | x0.997 | - | x0.997 | x1.000 | x0.143 |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 6.119 | 6.141 | x1.004 | level | 0 of 4 | x1.004 | - | x1.004 | x1.000 | x1.016 |
| blake3-servil-st / solo / ContinuousBatches / 65536 | 6.177 | 6.178 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.958 |
| blake3-servil-st / solo / LentMessages / 64 B | 0.747 | 0.751 | x1.006 | level | 0 of 4 | x1.006 | - | x1.006 | x1.012 | x0.900 |
| blake3-servil-st / solo / LentMessages / 128 B | 0.857 | 0.858 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.007 | x1.272 |
| blake3-servil-st / solo / LentMessages / 256 B | 0.914 | 0.916 | x1.002 | level | 0 of 4 | x1.002 | - | x1.002 | x1.004 | x1.048 |
| blake3-servil-st / solo / LentMessages / 512 B | 0.943 | 0.944 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.002 | x1.287 |
| blake3-servil-st / solo / LentMessages / 1 KiB | 0.961 | 0.962 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.001 | x0.968 |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.284 | 0.285 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.001 | x1.214 |
| blake3-servil-st / solo / LentMessages / 16 KiB | 0.0910 | 0.0909 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.967 |
| blake3-servil-st / solo / LentMessages / 64 KiB | 0.0653 | 0.0650 | x0.996 | level | 3 of 4 | x0.996 | - | x0.995 | x1.000 | x1.028 |
| blake3-servil-st / solo / LentMessages / 256 KiB | 0.0615 | 0.0614 | x0.998 | level | 4 of 4 | x0.998 | - | x0.997 | x1.000 | x0.830 |
| blake3-servil-st / solo / LentMessages / 1 MiB | 0.0690 | 0.0690 | x1.001 | level | 2 of 4 | x1.001 | - | x1.002 | x1.000 | x0.986 |
| blake3-servil-st / solo / LentMessages / 4 MiB | 0.0710 | 0.0696 | x0.981 | level | 4 of 4 | x0.981 | - | x0.980 | x1.000 | x0.698 |
| blake3-servil-st / solo / LentMessages / 16 MiB | 0.0757 | 0.0759 | x1.003 | level | 2 of 4 | x1.003 | - | x1.002 | x1.000 | x0.993 |
| blake3-servil-st / solo / LentMessages / 64 MiB | 0.131 | 0.130 | x0.994 | level | 3 of 4 | x0.994 | - | x0.994 | x1.000 | x0.992 |
| blake3-servil-st / solo / Interleaved / 256 | 0.109 | 0.109 | x0.994 | level | 4 of 4 | x0.994 | - | x0.994 | x0.998 | x0.983 |
| blake3-servil-st / solo / Collection / git objects | 0.0845 | 0.0840 | x0.994 | level | 3 of 4 | x0.994 | - | x0.994 | x0.999 | x1.002 |
| blake3-servil-st / solo / Collection / Nix files | 0.0740 | 0.0738 | x0.996 | level | 2 of 4 | x0.996 | - | x0.996 | x0.999 | x0.992 |
| blake3-servil-st / solo / LentBatches / 16 | 6.040 | 6.023 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x0.998 | x0.960 |
| blake3-servil-st / solo / LentBatches / 64 | 5.314 | 5.309 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x0.999 | x1.454 |
| blake3-servil-st / solo / LentBatches / 256 | 5.272 | 5.278 | x1.001 | level | 2 of 4 | x1.001 | - | x1.000 | x1.000 | x1.387 |
| blake3-servil-st / solo / LentBatches / 1024 | 5.626 | 5.620 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x0.489 |
| blake3-servil-st / solo / LentBatches / 4096 | 5.505 | 5.483 | x0.996 | level | 4 of 4 | x0.997 | - | x0.997 | x1.000 | x0.143 |
| blake3-servil-st / solo / LentBatches / 16384 | 6.119 | 6.141 | x1.004 | level | 0 of 4 | x1.004 | - | x1.004 | x1.000 | x1.016 |
| blake3-servil-st / solo / LentBatches / 65536 | 6.177 | 6.178 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.958 |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.110 | 0.110 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.015 |
| blake3-servil-st / solo / ContinuousCollection / Nix files | 0.117 | 0.117 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.999 |
| blake3-servil-st / solo / MerkleTree / 1024 | 0.0995 | 0.0995 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.001 | x0.995 |
| blake3-servil-st / solo / MerkleTree / 4096 | 0.107 | 0.107 | x1.002 | level | 2 of 4 | x1.002 | - | x1.001 | x1.001 | x1.191 |
| blake3-servil-st / solo / MerkleTree / 16384 | 0.107 | 0.107 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.001 | x0.923 |
| blake3-servil-st / solo / MerkleTree / 65536 | 0.120 | 0.119 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x1.001 | x0.988 |
| blake3-servil-st / solo / MerkleTree / 262144 | 0.160 | 0.160 | x0.997 | level | 3 of 4 | x0.998 | - | x0.997 | x1.001 | x1.000 |
| blake3-servil-st / solo / MerkleTree / 65536 x 32 B | 0.307 | 0.308 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.000 | x1.055 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 32 B | 0.389 | 0.389 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.999 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 16 B | 0.699 | 0.702 | x1.005 | level | 1 of 4 | x1.005 | - | x1.004 | x1.000 | x1.062 |
| blake3-servil-st / solo / MerkleTree / 65536 x 48 B | 0.215 | 0.215 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x1.346 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 48 B | 0.287 | 0.287 | x0.997 | level | 3 of 4 | x0.998 | - | x0.997 | x1.000 | x1.001 |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.241 | 0.240 | x0.996 | level | 3 of 4 | - | - | x0.997 | x1.010 | x1.044 |
| blake3-servil-st / solo / InterleavedTurn / 1024 x 1 KiB | 0.204 | 0.207 | x1.013 | level | 1 of 4 | - | - | x1.013 | x0.997 | x0.981 |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.271 | 0.270 | x0.996 | level | 1 of 4 | - | - | x0.994 | x0.981 | x0.915 |
| blake3-servil-st / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.229 | 0.235 | x1.026 | level | 1 of 4 | - | - | x1.032 | x0.997 | x1.002 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.192 | 0.194 | x1.009 | level | 2 of 4 | - | - | x1.011 | x1.005 | x0.919 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.171 | 0.172 | x1.005 | level | 2 of 4 | - | - | x1.006 | x0.997 | x0.986 |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.0838 | 0.0836 | x0.998 | level | 3 of 4 | x0.998 | - | x0.999 | x1.001 | x0.957 |
| blake3-servil-st / solo / ReceivingMessage / 2 μs | 0.0923 | 0.0923 | x1.000 | level | 3 of 4 | x0.998 | - | x0.999 | x1.001 | x0.993 |
| blake3-servil-st / solo / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 2 of 4 | x1.001 | - | x1.000 | x1.001 | x0.915 |
| blake3-servil-st / solo / IncrementalMessage / 64 B | 7.399 | 8.732 | x1.180 | level | 0 of 4 | - | - | x1.109 | x1.007 | x1.021 |
| blake3-servil-st / solo / IncrementalMessage / 1 KiB | 1.868 | 1.964 | x1.051 | level | 0 of 4 | - | - | x1.033 | x1.005 | x1.007 |
| blake3-servil-st / solo / IncrementalMessage / 4 KiB | 0.556 | 0.578 | x1.038 | level | 1 of 4 | - | - | x1.016 | x1.000 | x0.995 |
| blake3-servil-st / solo / LentIncrementalMessage / 64 B | 0.806 | 0.806 | x1.000 | level | 0 of 4 | x1.000 | - | x1.000 | x1.006 | x1.076 |
| blake3-servil-st / solo / LentIncrementalMessage / 1 KiB | 0.988 | 0.990 | x1.002 | level | 0 of 4 | x1.002 | - | x1.002 | x1.002 | x0.819 |
| blake3-servil-st / solo / LentIncrementalMessage / 4 KiB | 0.290 | 0.290 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.001 | x1.013 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 0.756 | 0.760 | x1.005 | level | 0 of 4 | x1.005 | - | x1.004 | x1.013 | x1.156 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 4 KiB | 0.284 | 0.285 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.001 | x1.329 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 1 MiB | 0.0676 | 0.0674 | x0.997 | level | 2 of 4 | x0.997 | - | x0.997 | x1.000 | x0.959 |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 0.722 | 0.725 | x1.004 | level | 0 of 4 | x1.004 | - | x1.004 | x1.015 | x1.095 |
| blake3-servil-st / solo / ContinuousLentMessages / 4 KiB | 0.281 | 0.281 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.001 | x0.828 |
| blake3-servil-st / solo / ContinuousLentMessages / 1 MiB | 0.0567 | 0.0559 | x0.985 | level | 4 of 4 | x0.985 | - | x0.984 | x1.000 | x0.678 |
| blake3-servil-mt / solo / OneMessage / 64 B | 6.847 | 7.574 | x1.106 | level | 0 of 4 | - | - | x1.073 | x0.994 | x1.092 |
| blake3-servil-mt / solo / OneMessage / 128 B | 4.241 | 4.246 | x1.001 | level | 2 of 4 | - | - | x1.004 | x0.995 | x1.088 |
| blake3-servil-mt / solo / OneMessage / 256 B | 2.830 | 2.792 | x0.986 | level | 1 of 4 | - | - | x1.016 | x1.006 | x1.086 |
| blake3-servil-mt / solo / OneMessage / 512 B | 1.935 | 1.873 | x0.968 | level | 3 of 4 | - | - | x0.986 | x1.001 | x1.114 |
| blake3-servil-mt / solo / OneMessage / 1 KiB | 1.527 | 1.513 | x0.991 | level | 3 of 4 | - | - | x0.992 | x1.002 | x1.078 |
| blake3-servil-mt / solo / OneMessage / 1536 B | 1.416 | 1.385 | x0.978 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.989 |
| blake3-servil-mt / solo / OneMessage / 2 KiB | 0.850 | 0.852 | x1.002 | level | 2 of 4 | - | - | x1.011 | x1.001 | x0.989 |
| blake3-servil-mt / solo / OneMessage / 2304 B | 1.028 | 1.000 | x0.972 | level | 3 of 4 | - | - | x0.993 | x1.002 | x0.999 |
| blake3-servil-mt / solo / OneMessage / 3 KiB | 0.732 | 0.730 | x0.997 | level | 2 of 4 | - | - | x1.017 | x1.001 | x0.999 |
| blake3-servil-mt / solo / OneMessage / 3839 B | 0.776 | 0.796 | x1.026 | level | 1 of 4 | - | - | x1.026 | x0.999 | x1.008 |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 0.486 | 0.480 | x0.989 | level | 2 of 4 | - | - | x1.000 | x1.001 | x0.990 |
| blake3-servil-mt / solo / OneMessage / 4470 B | 0.596 | 0.601 | x1.008 | level | 2 of 4 | - | - | x1.022 | x1.001 | x0.998 |
| blake3-servil-mt / solo / OneMessage / 7935 B | 0.613 | 0.610 | x0.995 | level | 3 of 4 | - | - | x0.993 | x1.000 | x1.020 |
| blake3-servil-mt / solo / OneMessage / 8 KiB | 0.367 | 0.395 | x1.075 | level | 1 of 4 | - | - | x1.084 | x0.999 | x1.015 |
| blake3-servil-mt / solo / OneMessage / 16 KiB | 0.222 | 0.237 | x1.071 | level | 1 of 4 | - | - | x1.082 | x1.000 | x0.984 |
| blake3-servil-mt / solo / OneMessage / 32 KiB | 0.193 | 0.197 | x1.020 | level | 2 of 4 | - | - | x1.024 | x1.000 | x0.962 |
| blake3-servil-mt / solo / OneMessage / 64 KiB | 0.143 | 0.144 | x1.012 | level | 1 of 4 | - | - | x1.017 | x1.000 | x0.984 |
| blake3-servil-mt / solo / OneMessage / 128 KiB | 0.114 | 0.116 | x1.015 | level | 1 of 4 | - | - | x1.015 | x1.000 | x1.081 |
| blake3-servil-mt / solo / OneMessage / 256 KiB | 0.102 | 0.102 | x0.998 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.045 |
| blake3-servil-mt / solo / OneMessage / 512 KiB | 0.0610 | 0.0611 | x1.002 | level | 2 of 4 | - | - | x1.008 | x0.996 | x0.992 |
| blake3-servil-mt / solo / OneMessage / 1 MiB | 0.0490 | 0.0488 | x0.996 | level | 2 of 4 | - | - | x0.993 | x0.988 | x1.010 |
| blake3-servil-mt / solo / OneMessage / 2 MiB | 0.0430 | 0.0435 | x1.010 | level | 1 of 4 | - | - | x1.008 | x0.990 | x1.011 |
| blake3-servil-mt / solo / OneMessage / 3 MiB | 0.0416 | 0.0413 | x0.993 | level | 4 of 4 | - | - | x0.994 | x0.991 | x1.003 |
| blake3-servil-mt / solo / OneMessage / 4 MiB | 0.0390 | 0.0390 | x1.001 | level | 2 of 4 | - | - | x1.003 | x0.997 | x1.003 |
| blake3-servil-mt / solo / OneMessage / 8 MiB | 0.0380 | 0.0380 | x1.001 | level | 2 of 4 | - | - | x0.999 | x0.989 | x1.009 |
| blake3-servil-mt / solo / OneMessage / 32 MiB | 0.0748 | 0.0744 | x0.995 | level | 2 of 4 | - | - | x0.994 | x0.998 | x0.997 |
| blake3-servil-mt / solo / OneMessage / 64 MiB | 0.0747 | 0.0742 | x0.994 | level | 2 of 4 | - | - | x0.994 | x1.001 | x0.998 |
| blake3-servil-mt / solo / OneMessage / 128 MiB | 0.0740 | 0.0738 | x0.996 | level | 1 of 4 | - | - | x0.996 | x1.000 | x0.998 |
| blake3-servil-mt / solo / ManyMessages / 1 | 630.875 | 647.616 | x1.027 | level | 2 of 4 | - | - | x1.032 | x1.018 | x1.025 |
| blake3-servil-mt / solo / ManyMessages / 2 | 284.298 | 261.556 | x0.920 | level | 3 of 4 | - | - | x0.915 | x1.004 | x0.905 |
| blake3-servil-mt / solo / ManyMessages / 3 | 213.470 | 197.895 | x0.927 | level | 3 of 4 | - | - | x0.935 | x1.002 | x0.938 |
| blake3-servil-mt / solo / ManyMessages / 4 | 141.704 | 128.274 | x0.905 | level | 3 of 4 | - | - | x0.918 | x1.001 | x0.979 |
| blake3-servil-mt / solo / ManyMessages / 6 | 101.988 | 99.044 | x0.971 | level | 2 of 4 | - | - | x0.981 | x1.001 | x0.963 |
| blake3-servil-mt / solo / ManyMessages / 8 | 103.773 | 98.957 | x0.954 | level | 1 of 4 | - | - | x0.973 | x1.007 | x1.034 |
| blake3-servil-mt / solo / ManyMessages / 12 | 81.995 | 75.079 | x0.916 | level | 2 of 4 | - | - | x0.940 | x1.005 | x1.003 |
| blake3-servil-mt / solo / ManyMessages / 16 | 60.284 | 55.958 | x0.928 | level | 3 of 4 | - | - | x0.969 | x1.006 | x0.996 |
| blake3-servil-mt / solo / ManyMessages / 24 | 49.523 | 48.484 | x0.979 | level | 2 of 4 | - | - | x1.001 | x1.007 | x1.014 |
| blake3-servil-mt / solo / ManyMessages / 32 | 32.756 | 30.354 | x0.927 | level | 2 of 4 | - | - | x0.977 | x1.008 | x1.001 |
| blake3-servil-mt / solo / ManyMessages / 48 | 24.492 | 21.755 | x0.888 | level | 3 of 4 | - | - | x0.940 | x1.004 | x1.007 |
| blake3-servil-mt / solo / ManyMessages / 64 | 18.937 | 18.708 | x0.988 | level | 2 of 4 | - | - | x1.019 | x1.001 | x1.012 |
| blake3-servil-mt / solo / ManyMessages / 128 | 13.548 | 13.229 | x0.976 | level | 1 of 4 | - | - | x1.011 | x1.000 | x0.994 |
| blake3-servil-mt / solo / ManyMessages / 256 | 10.177 | 10.536 | x1.035 | level | 1 of 4 | - | - | x1.039 | x0.999 | x0.995 |
| blake3-servil-mt / solo / ManyMessages / 512 | 8.914 | 8.939 | x1.003 | level | 2 of 4 | - | - | x1.017 | x0.999 | x0.949 |
| blake3-servil-mt / solo / ManyMessages / 1024 | 8.092 | 8.049 | x0.995 | level | 3 of 4 | - | - | x1.002 | x0.999 | x0.995 |
| blake3-servil-mt / solo / ManyMessages / 2048 | 7.643 | 7.608 | x0.995 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.058 |
| blake3-servil-mt / solo / ManyMessages / 4096 | 7.514 | 7.449 | x0.991 | level | 2 of 4 | - | - | x0.995 | x1.000 | x1.013 |
| blake3-servil-mt / solo / ManyMessages / 8192 | 3.279 | 3.328 | x1.015 | level | 2 of 4 | - | - | x1.015 | x0.999 | x0.980 |
| blake3-servil-mt / solo / ManyMessages / 16384 | 2.770 | 2.766 | x0.999 | level | 2 of 4 | - | - | x0.993 | x0.993 | x0.962 |
| blake3-servil-mt / solo / ManyMessages / 32768 | 2.630 | 2.608 | x0.991 | level | 3 of 4 | - | - | x0.990 | x0.968 | x0.972 |
| blake3-servil-mt / solo / ManyMessages / 65536 | 2.408 | 2.408 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.001 | x0.955 |
| blake3-servil-mt / solo / ManyMessages / 131072 | 2.431 | 2.456 | x1.010 | level | 1 of 4 | - | - | x1.013 | x1.025 | x0.992 |
| blake3-servil-mt / solo / ManyMessages / 262144 | 2.894 | 2.897 | x1.001 | level | 2 of 4 | - | - | x1.001 | x0.989 | x1.019 |
| blake3-servil-mt / solo / ManyLongMessages / 4 | 1702.714 | 1756.722 | x1.032 | level | 2 of 4 | - | - | x0.992 | x1.001 | x0.982 |
| blake3-servil-mt / solo / ManyLongMessages / 16 | 1376.831 | 622.688 | x0.452 | faster | 4 of 4 | - | - | x0.455 | x0.575 | x1.350 |
| blake3-servil-mt / solo / ManyLongMessages / 64 | 495.867 | 491.453 | x0.991 | level | 2 of 4 | - | - | x0.986 | x0.998 | x1.086 |
| blake3-servil-mt / solo / ManyLongMessages / 256 | 242.650 | 239.542 | x0.987 | level | 3 of 4 | - | - | x0.985 | x0.982 | x0.982 |
| blake3-servil-mt / solo / IdleOneMessage / 64 B | 3.452 | 3.512 | x1.017 | level | 1 of 4 | - | - | x1.005 | x1.005 | x0.712 |
| blake3-servil-mt / solo / IdleOneMessage / 128 B | 2.428 | 2.461 | x1.014 | level | 1 of 4 | - | - | x1.003 | x1.004 | x0.936 |
| blake3-servil-mt / solo / IdleOneMessage / 256 B | 1.953 | 1.934 | x0.990 | level | 3 of 4 | - | - | x1.003 | x1.003 | x1.035 |
| blake3-servil-mt / solo / IdleOneMessage / 512 B | 1.671 | 1.676 | x1.003 | level | 2 of 4 | - | - | x0.999 | x1.002 | x0.547 |
| blake3-servil-mt / solo / IdleOneMessage / 1 KiB | 1.536 | 1.525 | x0.993 | level | 2 of 4 | - | - | x1.002 | x1.001 | x1.597 |
| blake3-servil-mt / solo / IdleOneMessage / 1536 B | 1.143 | 1.156 | x1.012 | level | 1 of 4 | - | - | x1.001 | x0.998 | x0.715 |
| blake3-servil-mt / solo / IdleOneMessage / 2 KiB | 0.832 | 0.838 | x1.007 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.312 |
| blake3-servil-mt / solo / IdleOneMessage / 2304 B | 0.949 | 0.911 | x0.960 | level | 4 of 4 | - | - | x0.997 | x1.001 | x1.699 |
| blake3-servil-mt / solo / IdleOneMessage / 3 KiB | 0.601 | 0.597 | x0.993 | level | 3 of 4 | - | - | x1.003 | x1.000 | x1.340 |
| blake3-servil-mt / solo / IdleOneMessage / 3839 B | 0.486 | 0.483 | x0.995 | level | 2 of 4 | - | - | x1.004 | x1.001 | x2.126 |
| blake3-servil-mt / solo / IdleOneMessage / 4 KiB | 0.448 | 0.435 | x0.971 | level | 4 of 4 | - | - | x0.999 | x1.001 | x0.386 |
| blake3-servil-mt / solo / IdleOneMessage / 4470 B | 0.547 | 0.553 | x1.009 | level | 1 of 4 | - | - | x0.999 | x1.001 | x0.198 |
| blake3-servil-mt / solo / IdleOneMessage / 7935 B | 0.277 | 0.282 | x1.018 | level | 1 of 4 | - | - | x0.999 | x1.001 | x0.653 |
| blake3-servil-mt / solo / IdleOneMessage / 8 KiB | 0.255 | 0.259 | x1.016 | level | 2 of 4 | - | - | x1.005 | x1.000 | x1.947 |
| blake3-servil-mt / solo / IdleOneMessage / 16 KiB | 0.147 | 0.146 | x0.989 | level | 3 of 4 | - | - | x1.013 | x1.000 | x1.556 |
| blake3-servil-mt / solo / IdleOneMessage / 32 KiB | 0.101 | 0.0985 | x0.977 | level | 3 of 4 | - | - | x1.001 | x1.000 | x0.427 |
| blake3-servil-mt / solo / IdleOneMessage / 64 KiB | 0.0929 | 0.0928 | x0.999 | level | 2 of 4 | - | - | x1.002 | x1.000 | x2.620 |
| blake3-servil-mt / solo / IdleOneMessage / 128 KiB | 0.0873 | 0.0868 | x0.994 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.200 |
| blake3-servil-mt / solo / IdleOneMessage / 256 KiB | 0.0871 | 0.0864 | x0.992 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.867 |
| blake3-servil-mt / solo / IdleOneMessage / 512 KiB | 0.0593 | 0.0613 | x1.033 | level | 1 of 4 | - | - | x1.028 | x1.010 | x0.968 |
| blake3-servil-mt / solo / IdleOneMessage / 1 MiB | 0.0521 | 0.0511 | x0.981 | level | 3 of 4 | - | - | x0.996 | x1.006 | x0.993 |
| blake3-servil-mt / solo / IdleOneMessage / 2 MiB | 0.0466 | 0.0465 | x0.999 | level | 2 of 4 | - | - | x0.990 | x1.014 | x1.002 |
| blake3-servil-mt / solo / IdleOneMessage / 3 MiB | 0.0445 | 0.0440 | x0.987 | level | 3 of 4 | - | - | x0.991 | x1.006 | x1.003 |
| blake3-servil-mt / solo / IdleOneMessage / 4 MiB | 0.0417 | 0.0419 | x1.005 | level | 1 of 4 | - | - | x0.999 | x1.000 | x1.016 |
| blake3-servil-mt / solo / IdleOneMessage / 8 MiB | 0.0388 | 0.0386 | x0.995 | level | 2 of 4 | - | - | x1.015 | x1.016 | x1.025 |
| blake3-servil-mt / solo / IdleOneMessage / 32 MiB | 0.0696 | 0.0691 | x0.992 | level | 4 of 4 | - | - | x0.997 | x1.001 | x0.999 |
| blake3-servil-mt / solo / IdleOneMessage / 64 MiB | 0.0737 | 0.0732 | x0.993 | level | 2 of 4 | - | - | x0.990 | x1.001 | x0.999 |
| blake3-servil-mt / solo / IdleOneMessage / 128 MiB | 0.0738 | 0.0734 | x0.995 | level | 2 of 4 | - | - | x0.992 | x0.998 | x0.998 |
| blake3-servil-mt / solo / IdleManyMessages / 1 | 235.964 | 236.571 | x1.003 | level | 2 of 4 | - | - | x1.003 | x1.009 | x0.737 |
| blake3-servil-mt / solo / IdleManyMessages / 2 | 121.227 | 121.297 | x1.001 | level | 3 of 4 | - | - | x1.000 | x0.998 | x1.339 |
| blake3-servil-mt / solo / IdleManyMessages / 3 | 103.508 | 103.421 | x0.999 | level | 3 of 4 | - | - | x0.997 | x0.998 | x1.149 |
| blake3-servil-mt / solo / IdleManyMessages / 4 | 61.658 | 61.249 | x0.993 | level | 2 of 4 | - | - | x0.996 | x0.998 | x0.423 |
| blake3-servil-mt / solo / IdleManyMessages / 6 | 53.705 | 54.105 | x1.007 | level | 2 of 4 | - | - | x1.001 | x0.998 | x0.834 |
| blake3-servil-mt / solo / IdleManyMessages / 8 | 32.660 | 35.035 | x1.073 | level | 1 of 4 | - | - | x1.041 | x0.998 | x4.425 |
| blake3-servil-mt / solo / IdleManyMessages / 12 | 29.578 | 30.969 | x1.047 | level | 1 of 4 | - | - | x1.033 | x0.998 | x1.872 |
| blake3-servil-mt / solo / IdleManyMessages / 16 | 17.475 | 16.739 | x0.958 | level | 3 of 4 | - | - | x0.991 | x0.998 | x0.523 |
| blake3-servil-mt / solo / IdleManyMessages / 24 | 16.153 | 16.379 | x1.014 | level | 3 of 4 | - | - | x1.024 | x0.999 | x0.840 |
| blake3-servil-mt / solo / IdleManyMessages / 32 | 12.295 | 12.121 | x0.986 | level | 3 of 4 | - | - | x0.997 | x0.999 | x2.569 |
| blake3-servil-mt / solo / IdleManyMessages / 48 | 10.670 | 10.566 | x0.990 | level | 3 of 4 | - | - | x0.997 | x0.999 | x1.003 |
| blake3-servil-mt / solo / IdleManyMessages / 64 | 9.978 | 9.651 | x0.967 | level | 4 of 4 | - | - | x1.000 | x0.999 | x3.835 |
| blake3-servil-mt / solo / IdleManyMessages / 128 | 8.732 | 8.769 | x1.004 | level | 2 of 4 | - | - | x0.998 | x0.999 | x1.157 |
| blake3-servil-mt / solo / IdleManyMessages / 256 | 8.297 | 8.171 | x0.985 | level | 2 of 4 | - | - | x0.995 | x0.999 | x0.937 |
| blake3-servil-mt / solo / IdleManyMessages / 512 | 7.618 | 7.537 | x0.989 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.892 |
| blake3-servil-mt / solo / IdleManyMessages / 1024 | 7.694 | 7.595 | x0.987 | level | 2 of 4 | - | - | x0.993 | x1.000 | x0.553 |
| blake3-servil-mt / solo / IdleManyMessages / 2048 | 7.731 | 7.504 | x0.971 | level | 4 of 4 | - | - | x0.986 | x1.000 | x0.931 |
| blake3-servil-mt / solo / IdleManyMessages / 4096 | 7.740 | 7.705 | x0.995 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.032 |
| blake3-servil-mt / solo / IdleManyMessages / 8192 | 3.360 | 3.388 | x1.008 | level | 1 of 4 | - | - | x1.011 | x0.984 | x0.993 |
| blake3-servil-mt / solo / IdleManyMessages / 16384 | 3.006 | 3.021 | x1.005 | level | 1 of 4 | - | - | x1.002 | x0.998 | x0.992 |
| blake3-servil-mt / solo / IdleManyMessages / 32768 | 2.996 | 2.955 | x0.986 | level | 3 of 4 | - | - | x1.014 | x1.028 | x0.985 |
| blake3-servil-mt / solo / IdleManyMessages / 65536 | 2.564 | 2.545 | x0.993 | level | 3 of 4 | - | - | x0.992 | x1.006 | x0.989 |
| blake3-servil-mt / solo / IdleManyMessages / 131072 | 2.447 | 2.437 | x0.996 | level | 3 of 4 | - | - | x1.001 | x1.001 | x0.994 |
| blake3-servil-mt / solo / IdleManyMessages / 262144 | 3.350 | 3.393 | x1.013 | level | 2 of 4 | - | - | x1.006 | x0.990 | x0.998 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 B | 2.494 | 2.451 | x0.983 | level | 3 of 4 | - | - | x0.999 | x1.005 | x0.903 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 B | 1.703 | 1.704 | x1.001 | level | 2 of 4 | - | - | x1.003 | x1.004 | x0.546 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 B | 1.362 | 1.360 | x0.999 | level | 2 of 4 | - | - | x1.002 | x1.003 | x1.037 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 B | 1.170 | 1.168 | x0.999 | level | 3 of 4 | - | - | x1.001 | x1.002 | x1.090 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 KiB | 1.114 | 1.081 | x0.971 | level | 1 of 4 | - | - | x0.999 | x1.001 | x0.877 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1536 B | 0.809 | 0.809 | x1.001 | level | 2 of 4 | - | - | x1.000 | x0.998 | x1.473 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 KiB | 0.585 | 0.584 | x0.998 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.345 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2304 B | 0.653 | 0.651 | x0.996 | level | 4 of 4 | - | - | x0.996 | x1.001 | x0.470 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 KiB | 0.419 | 0.419 | x1.000 | level | 3 of 4 | - | - | x1.002 | x1.000 | x0.559 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3839 B | 0.341 | 0.341 | x0.999 | level | 1 of 4 | - | - | x0.998 | x1.001 | x0.524 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 KiB | 0.312 | 0.312 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.001 | x0.922 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4470 B | 0.383 | 0.383 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.001 | x0.816 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 7935 B | 0.193 | 0.193 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.001 | x0.704 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 KiB | 0.180 | 0.180 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x2.700 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 16 KiB | 0.101 | 0.101 | x1.006 | level | 1 of 4 | - | - | x1.005 | x1.000 | x1.308 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 KiB | 0.0705 | 0.0707 | x1.003 | level | 1 of 4 | - | - | x1.003 | x1.000 | x0.553 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 KiB | 0.0653 | 0.0654 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.643 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 KiB | 0.0627 | 0.0627 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.132 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 KiB | 0.0621 | 0.0622 | x1.002 | level | 1 of 4 | - | - | x0.997 | x1.000 | x0.856 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 KiB | 0.0494 | 0.0500 | x1.012 | level | 2 of 4 | - | - | x1.012 | x1.001 | x0.973 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 MiB | 0.0445 | 0.0437 | x0.981 | level | 3 of 4 | - | - | x0.985 | x1.002 | x0.993 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 MiB | 0.0370 | 0.0366 | x0.988 | level | 3 of 4 | - | - | x0.988 | x1.002 | x0.997 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 MiB | 0.0328 | 0.0325 | x0.992 | level | 3 of 4 | - | - | x0.992 | x0.999 | x0.993 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 MiB | 0.0310 | 0.0310 | x1.001 | level | 1 of 4 | - | - | x1.004 | x1.004 | x0.990 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 MiB | 0.0296 | 0.0294 | x0.993 | level | 3 of 4 | - | - | x0.994 | x0.998 | x0.983 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 MiB | 0.0701 | 0.0696 | x0.993 | level | 4 of 4 | - | - | x0.993 | x0.999 | x0.998 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 MiB | 0.0744 | 0.0740 | x0.994 | level | 2 of 4 | - | - | x0.993 | x0.998 | x0.997 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 MiB | 0.0741 | 0.0740 | x0.998 | level | 2 of 4 | - | - | x0.996 | x1.001 | x0.998 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1 | 165.009 | 165.861 | x1.005 | level | 1 of 4 | - | - | x1.010 | x1.008 | x0.518 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2 | 83.511 | 83.322 | x0.998 | level | 3 of 4 | - | - | x1.002 | x0.998 | x0.577 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 3 | 72.346 | 72.192 | x0.998 | level | 2 of 4 | - | - | x1.001 | x0.998 | x1.305 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4 | 42.538 | 43.852 | x1.031 | level | 2 of 4 | - | - | x1.002 | x0.998 | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 6 | 36.874 | 36.656 | x0.994 | level | 3 of 4 | - | - | x0.999 | x0.998 | x0.801 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8 | 22.803 | 24.793 | x1.087 | level | 3 of 4 | - | - | x1.038 | x0.998 | x0.335 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 12 | 20.576 | 21.514 | x1.046 | level | 2 of 4 | - | - | x1.032 | x0.999 | x0.610 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16 | 11.984 | 11.730 | x0.979 | level | 3 of 4 | - | - | x0.990 | x0.998 | x0.602 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 24 | 11.125 | 11.420 | x1.027 | level | 3 of 4 | - | - | x1.020 | x0.999 | x0.886 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32 | 8.542 | 8.379 | x0.981 | level | 4 of 4 | - | - | x0.989 | x0.999 | x1.709 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 48 | 7.382 | 7.324 | x0.992 | level | 2 of 4 | - | - | x0.995 | x0.999 | x1.200 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 64 | 6.789 | 6.732 | x0.991 | level | 3 of 4 | - | - | x0.996 | x0.999 | x0.925 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 128 | 5.959 | 5.959 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.421 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 256 | 5.652 | 5.650 | x1.000 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.041 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 512 | 5.445 | 5.441 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.336 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1024 | 5.358 | 5.355 | x0.999 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.677 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2048 | 5.325 | 5.331 | x1.001 | level | 3 of 4 | - | - | x1.001 | x1.000 | x0.977 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4096 | 5.459 | 5.410 | x0.991 | level | 4 of 4 | - | - | x0.997 | x1.000 | x1.017 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8192 | 2.834 | 2.817 | x0.994 | level | 2 of 4 | - | - | x0.990 | x0.982 | x0.983 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16384 | 2.424 | 2.454 | x1.013 | level | 1 of 4 | - | - | x1.012 | x1.002 | x0.994 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32768 | 2.252 | 2.235 | x0.992 | level | 3 of 4 | - | - | x0.992 | x1.002 | x0.982 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 65536 | 1.866 | 1.864 | x0.999 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.977 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 131072 | 1.825 | 1.842 | x1.010 | level | 1 of 4 | - | - | x1.007 | x0.987 | x0.997 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 262144 | 2.339 | 2.311 | x0.988 | level | 3 of 4 | - | - | x0.988 | x0.996 | x0.991 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.362 | 0.358 | x0.987 | level | 3 of 4 | x0.973 | - | x0.987 | x0.960 | x1.009 |
| blake3-servil-mt / solo / ContinuousMessages / 128 B | 0.181 | 0.177 | x0.979 | level | 3 of 4 | x0.977 | - | x0.977 | x0.960 | x0.960 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.0958 | 0.0928 | x0.969 | level | 4 of 4 | x0.979 | - | x0.967 | x0.961 | x0.953 |
| blake3-servil-mt / solo / ContinuousMessages / 512 B | 0.0517 | 0.0507 | x0.979 | level | 4 of 4 | x0.962 | - | x0.977 | x0.961 | x0.982 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.0403 | 0.0404 | x1.004 | level | 2 of 4 | x1.060 | - | x1.001 | x0.965 | x0.990 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0351 | 0.0344 | x0.981 | level | 3 of 4 | x1.041 | - | x0.978 | x0.968 | x0.992 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0293 | 0.0294 | x1.005 | level | 1 of 4 | x1.020 | - | x1.000 | x0.981 | x0.988 |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.0266 | 0.0278 | x1.045 | level | 1 of 4 | x1.035 | - | x1.054 | x1.008 | x1.012 |
| blake3-servil-mt / solo / ContinuousMessages / 256 KiB | 0.0266 | 0.0276 | x1.037 | level | 1 of 4 | x1.028 | - | x1.034 | x1.005 | x1.012 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0244 | 0.0245 | x1.002 | level | 1 of 4 | x0.971 | - | x1.004 | x1.004 | x0.992 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.0250 | 0.0251 | x1.004 | level | 2 of 4 | x1.025 | - | x1.004 | x1.004 | x0.987 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0257 | 0.0259 | x1.009 | level | 1 of 4 | x0.967 | - | x1.011 | x1.004 | x0.993 |
| blake3-servil-mt / solo / ContinuousMessages / 64 MiB | 0.0313 | 0.0313 | x1.000 | level | 2 of 4 | x0.994 | - | x1.001 | x1.004 | x0.996 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 2.875 | 2.887 | x1.004 | level | 2 of 4 | x0.980 | - | x1.003 | x0.962 | x1.067 |
| blake3-servil-mt / solo / ContinuousBatches / 64 | 1.882 | 1.860 | x0.988 | level | 2 of 4 | x1.004 | - | x0.984 | x0.972 | x1.013 |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 2.139 | 2.087 | x0.976 | level | 2 of 4 | x0.957 | - | x0.976 | x0.983 | x0.996 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 1.863 | 1.867 | x1.002 | level | 3 of 4 | x1.032 | - | x0.999 | x1.003 | x1.002 |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 2.095 | 2.072 | x0.989 | level | 3 of 4 | x0.978 | - | x0.987 | x1.000 | x1.001 |
| blake3-servil-mt / solo / ContinuousBatches / 16384 | 2.132 | 2.162 | x1.014 | level | 1 of 4 | x1.004 | - | x1.013 | x0.998 | x0.997 |
| blake3-servil-mt / solo / ContinuousBatches / 65536 | 1.731 | 1.749 | x1.011 | level | 2 of 4 | x1.006 | - | x1.013 | x0.999 | x1.025 |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.745 | 0.747 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.012 | x1.082 |
| blake3-servil-mt / solo / LentMessages / 128 B | 0.856 | 0.857 | x1.001 | level | 0 of 4 | x1.002 | - | x1.001 | x1.007 | x0.914 |
| blake3-servil-mt / solo / LentMessages / 256 B | 0.914 | 0.916 | x1.002 | level | 0 of 4 | x1.002 | - | x1.002 | x1.004 | x1.075 |
| blake3-servil-mt / solo / LentMessages / 512 B | 0.945 | 0.943 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.002 | x0.938 |
| blake3-servil-mt / solo / LentMessages / 1 KiB | 0.961 | 0.962 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.001 | x0.683 |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.285 | 0.285 | x1.001 | level | 1 of 4 | x1.000 | - | x1.000 | x1.001 | x2.328 |
| blake3-servil-mt / solo / LentMessages / 16 KiB | 0.0910 | 0.0911 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | x1.091 |
| blake3-servil-mt / solo / LentMessages / 64 KiB | 0.0653 | 0.0650 | x0.995 | level | 3 of 4 | x0.995 | - | x0.996 | x1.000 | x1.611 |
| blake3-servil-mt / solo / LentMessages / 256 KiB | 0.0616 | 0.0615 | x0.998 | level | 4 of 4 | x0.998 | - | x0.999 | x1.000 | x0.842 |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.0380 | 0.0375 | x0.986 | level | 2 of 4 | x0.999 | - | x1.004 | x1.008 | x0.994 |
| blake3-servil-mt / solo / LentMessages / 4 MiB | 0.0314 | 0.0330 | x1.048 | level | 0 of 4 | x1.047 | - | x0.998 | x1.016 | x0.955 |
| blake3-servil-mt / solo / LentMessages / 16 MiB | 0.0300 | 0.0297 | x0.991 | level | 3 of 4 | x0.987 | - | x1.005 | x1.001 | x0.993 |
| blake3-servil-mt / solo / LentMessages / 64 MiB | 0.0746 | 0.0735 | x0.986 | level | 4 of 4 | x0.999 | - | x0.985 | x0.999 | x0.997 |
| blake3-servil-mt / solo / Interleaved / 256 | 0.109 | 0.109 | x0.996 | level | 2 of 4 | x0.996 | - | x0.995 | x0.999 | x0.994 |
| blake3-servil-mt / solo / Collection / git objects | 0.0178 | 0.0174 | x0.979 | level | 3 of 4 | x1.001 | - | x0.977 | x0.983 | x0.977 |
| blake3-servil-mt / solo / Collection / Nix files | 0.0175 | 0.0177 | x1.011 | level | 1 of 4 | x1.014 | - | x0.997 | x1.011 | x1.011 |
| blake3-servil-mt / solo / LentBatches / 16 | 6.047 | 6.027 | x0.997 | level | 3 of 4 | x0.997 | - | x0.996 | x0.998 | x0.563 |
| blake3-servil-mt / solo / LentBatches / 64 | 5.317 | 5.321 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x0.999 | x1.101 |
| blake3-servil-mt / solo / LentBatches / 256 | 5.271 | 5.279 | x1.002 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x2.889 |
| blake3-servil-mt / solo / LentBatches / 1024 | 5.620 | 5.622 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.264 |
| blake3-servil-mt / solo / LentBatches / 4096 | 5.496 | 5.485 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x0.227 |
| blake3-servil-mt / solo / LentBatches / 16384 | 2.750 | 2.790 | x1.015 | level | 2 of 4 | x1.025 | - | x1.004 | x1.001 | x0.993 |
| blake3-servil-mt / solo / LentBatches / 65536 | 2.274 | 2.309 | x1.015 | level | 1 of 4 | x1.018 | - | x1.005 | x1.007 | x1.005 |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.0353 | 0.0351 | x0.994 | level | 2 of 4 | x1.000 | - | x0.990 | x0.989 | x0.999 |
| blake3-servil-mt / solo / ContinuousCollection / Nix files | 0.0332 | 0.0339 | x1.019 | level | 1 of 4 | x0.972 | - | x1.019 | x0.989 | x0.992 |
| blake3-servil-mt / solo / MerkleTree / 1024 | 0.0995 | 0.0995 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.001 | x1.026 |
| blake3-servil-mt / solo / MerkleTree / 4096 | 0.0579 | 0.0553 | x0.956 | level | 4 of 4 | x0.973 | - | x1.006 | x1.003 | x1.009 |
| blake3-servil-mt / solo / MerkleTree / 16384 | 0.0458 | 0.0453 | x0.991 | level | 3 of 4 | x0.987 | - | x0.993 | x0.998 | x1.083 |
| blake3-servil-mt / solo / MerkleTree / 65536 | 0.0413 | 0.0414 | x1.002 | level | 2 of 4 | x1.004 | - | x0.991 | x1.002 | x1.000 |
| blake3-servil-mt / solo / MerkleTree / 262144 | 0.0905 | 0.0903 | x0.998 | level | 3 of 4 | x0.997 | - | x0.997 | x0.997 | x0.998 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 32 B | 0.0808 | 0.0774 | x0.958 | level | 3 of 4 | x0.965 | - | x1.000 | x1.004 | x0.974 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 32 B | 0.179 | 0.178 | x0.996 | level | 1 of 4 | x0.996 | - | x0.996 | x1.003 | x1.001 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 16 B | 0.272 | 0.272 | x1.001 | level | 2 of 4 | x1.005 | - | x1.002 | x1.002 | x0.961 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 48 B | 0.0616 | 0.0574 | x0.932 | level | 4 of 4 | x0.949 | - | x1.002 | x0.997 | x0.966 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 48 B | 0.149 | 0.149 | x0.997 | level | 3 of 4 | x1.007 | - | x0.995 | x0.999 | x1.001 |
| blake3-servil-mt / solo / InterleavedTurn / 256 | 0.282 | 0.283 | x1.002 | level | 2 of 4 | - | - | x0.982 | x1.001 | x0.971 |
| blake3-servil-mt / solo / InterleavedTurn / 1024 x 1 KiB | 0.146 | 0.156 | x1.066 | level | 2 of 4 | - | - | x1.065 | x0.983 | x0.997 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 256 | 0.236 | 0.243 | x1.029 | level | 2 of 4 | - | - | x1.014 | x1.000 | x0.967 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.186 | 0.210 | x1.129 | level | 2 of 4 | - | - | x1.093 | x0.983 | x1.056 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 256 | 0.208 | 0.203 | x0.978 | level | 2 of 4 | - | - | x0.982 | x0.978 | x0.974 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.139 | 0.151 | x1.083 | level | 3 of 4 | - | - | x1.082 | x0.983 | x0.948 |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.0276 | 0.0274 | x0.994 | level | 3 of 4 | x0.961 | - | x0.993 | x1.003 | x1.012 |
| blake3-servil-mt / solo / ReceivingMessage / 2 μs | 0.0922 | 0.0922 | x1.000 | level | 2 of 4 | x0.999 | - | x1.015 | x1.002 | x1.041 |
| blake3-servil-mt / solo / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 1 of 4 | x0.994 | - | x0.958 | x1.003 | x0.928 |
| blake3-servil-mt / solo / IncrementalMessage / 64 B | 8.745 | 9.093 | x1.040 | level | 2 of 4 | - | - | x1.018 | x1.010 | x1.016 |
| blake3-servil-mt / solo / IncrementalMessage / 1 KiB | 1.782 | 1.801 | x1.011 | level | 2 of 4 | - | - | x0.995 | x1.007 | x1.006 |
| blake3-servil-mt / solo / IncrementalMessage / 4 KiB | 0.573 | 0.587 | x1.023 | level | 2 of 4 | - | - | x1.007 | x1.001 | x0.987 |
| blake3-servil-mt / solo / LentIncrementalMessage / 64 B | 0.800 | 0.778 | x0.973 | level | 4 of 4 | x0.973 | - | x0.973 | x1.006 | x1.082 |
| blake3-servil-mt / solo / LentIncrementalMessage / 1 KiB | 0.988 | 0.989 | x1.002 | level | 0 of 4 | x1.002 | - | x1.001 | x1.002 | x0.714 |
| blake3-servil-mt / solo / LentIncrementalMessage / 4 KiB | 0.290 | 0.290 | x1.000 | level | 1 of 4 | x1.000 | - | x0.999 | x1.001 | x1.112 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 4.271 | 4.119 | x0.965 | level | 3 of 4 | x0.975 | - | x0.964 | x0.945 | x1.052 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 4 KiB | 0.0616 | 0.0630 | x1.022 | level | 1 of 4 | x1.094 | - | x1.010 | x0.957 | x1.035 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 1 MiB | 0.0245 | 0.0246 | x1.005 | level | 1 of 4 | x1.041 | - | x1.001 | x1.004 | x0.997 |
| blake3-servil-mt / solo / ContinuousLentMessages / 64 B | 0.287 | 0.288 | x1.003 | level | 1 of 4 | x1.309 | - | x0.999 | x0.952 | x1.026 |
| blake3-servil-mt / solo / ContinuousLentMessages / 4 KiB | 0.0209 | 0.0211 | x1.013 | level | 0 of 4 | x1.067 | - | x1.001 | x0.975 | x0.960 |
| blake3-servil-mt / solo / ContinuousLentMessages / 1 MiB | 0.00803 | 0.00801 | x0.997 | level | 3 of 4 | x0.990 | - | x0.999 | x1.001 | x0.887 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.357 | 0.339 | x0.952 | level | 3 of 4 | - | - | x0.947 | x0.960 | x1.119 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 128 B | 0.176 | 0.172 | x0.975 | level | 3 of 4 | - | - | x0.964 | x0.960 | x1.007 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.0981 | 0.0988 | x1.008 | level | 1 of 4 | - | - | x1.006 | x0.961 | x0.946 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 512 B | 0.0601 | 0.0612 | x1.018 | level | 1 of 4 | - | - | x1.012 | x0.961 | x1.045 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.0491 | 0.0501 | x1.020 | level | 1 of 4 | - | - | x1.016 | x0.965 | x1.028 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.0609 | 0.0645 | x1.059 | level | 1 of 4 | - | - | x0.990 | x0.998 | x0.995 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.0383 | 0.0379 | x0.989 | level | 3 of 4 | - | - | x0.978 | x0.979 | x1.001 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.0330 | 0.0333 | x1.008 | level | 2 of 4 | - | - | x1.013 | x1.008 | x1.021 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 KiB | 0.0322 | 0.0330 | x1.027 | level | 0 of 4 | - | - | x1.021 | x1.005 | x1.015 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0325 | 0.0329 | x1.012 | level | 0 of 4 | - | - | x1.013 | x1.004 | x1.000 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.0331 | 0.0345 | x1.042 | level | 1 of 4 | - | - | x1.047 | x1.004 | x1.000 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.0399 | 0.0400 | x1.003 | level | 3 of 4 | - | - | x0.994 | x1.003 | x1.011 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 MiB | 0.0459 | 0.0463 | x1.009 | level | 3 of 4 | - | - | x1.006 | x1.004 | x0.985 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 3.451 | 3.355 | x0.972 | level | 3 of 4 | - | - | x0.947 | x0.962 | x1.079 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 64 | 2.509 | 2.488 | x0.992 | level | 2 of 4 | - | - | x0.978 | x0.973 | x1.041 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 256 | 2.578 | 2.627 | x1.019 | level | 1 of 4 | - | - | x1.021 | x0.985 | x0.969 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 2.358 | 2.411 | x1.023 | level | 1 of 4 | - | - | x1.019 | x1.002 | x0.976 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 4096 | 2.714 | 2.699 | x0.995 | level | 2 of 4 | - | - | x1.004 | x1.013 | x0.975 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16384 | 2.462 | 2.479 | x1.007 | level | 2 of 4 | - | - | x0.972 | x1.008 | x0.929 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 65536 | 2.302 | 2.289 | x0.995 | level | 2 of 4 | - | - | x0.982 | x1.007 | x1.065 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.747 | 0.747 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.012 | x1.003 |
| blake3-servil-mt / shared-one-cache / LentMessages / 128 B | 0.856 | 0.857 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.007 | x1.295 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 B | 0.914 | 0.916 | x1.002 | level | 0 of 4 | - | - | x1.002 | x1.004 | x1.075 |
| blake3-servil-mt / shared-one-cache / LentMessages / 512 B | 0.944 | 0.943 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.002 | x0.916 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 KiB | 0.962 | 0.961 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.001 | x1.057 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.284 | 0.285 | x1.001 | level | 0 of 4 | - | - | x1.000 | x1.001 | x0.916 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 KiB | 0.0911 | 0.0910 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.929 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 KiB | 0.0655 | 0.0651 | x0.994 | level | 4 of 4 | - | - | x0.994 | x1.000 | x0.853 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 KiB | 0.0618 | 0.0615 | x0.994 | level | 4 of 4 | - | - | x0.995 | x1.000 | x0.358 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 MiB | 0.0452 | 0.0454 | x1.005 | level | 2 of 4 | - | - | x1.007 | x1.011 | x1.004 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 MiB | 0.0388 | 0.0375 | x0.966 | level | 3 of 4 | - | - | x0.994 | x1.002 | x0.922 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 MiB | 0.0746 | 0.0723 | x0.969 | level | 4 of 4 | - | - | x0.972 | x0.986 | x0.973 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 MiB | 0.130 | 0.131 | x1.005 | level | 3 of 4 | - | - | x0.997 | x1.010 | x1.000 |
| blake3-servil-mt / shared-one-cache / Interleaved / 256 | 0.109 | 0.109 | x0.995 | level | 4 of 4 | - | - | x0.994 | x0.999 | x0.980 |
| blake3-servil-mt / shared-one-cache / Collection / git objects | 0.0418 | 0.0416 | x0.995 | level | 3 of 4 | - | - | x1.089 | x1.060 | x1.090 |
| blake3-servil-mt / shared-one-cache / Collection / Nix files | 0.0366 | 0.0366 | x1.001 | level | 1 of 4 | - | - | x1.104 | x1.115 | x1.088 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16 | 6.044 | 6.060 | x1.003 | level | 0 of 4 | - | - | x1.002 | x0.997 | x0.981 |
| blake3-servil-mt / shared-one-cache / LentBatches / 64 | 5.336 | 5.322 | x0.997 | level | 4 of 4 | - | - | x0.997 | x0.999 | x0.834 |
| blake3-servil-mt / shared-one-cache / LentBatches / 256 | 5.262 | 5.258 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.966 |
| blake3-servil-mt / shared-one-cache / LentBatches / 1024 | 5.628 | 5.621 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.744 |
| blake3-servil-mt / shared-one-cache / LentBatches / 4096 | 5.505 | 5.478 | x0.995 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.521 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16384 | 3.035 | 3.049 | x1.005 | level | 2 of 4 | - | - | x1.003 | x0.998 | x1.002 |
| blake3-servil-mt / shared-one-cache / LentBatches / 65536 | 2.543 | 2.615 | x1.028 | level | 1 of 4 | - | - | x1.011 | x1.019 | x0.961 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.0518 | 0.0502 | x0.969 | level | 4 of 4 | - | - | x0.939 | x0.989 | x1.055 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / Nix files | 0.0507 | 0.0508 | x1.002 | level | 1 of 4 | - | - | x0.988 | x0.989 | x1.014 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1024 | 0.0996 | 0.0995 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.001 | x0.335 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 4096 | 0.0631 | 0.0621 | x0.985 | level | 2 of 4 | - | - | x1.004 | x1.003 | x0.990 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 16384 | 0.0494 | 0.0489 | x0.989 | level | 3 of 4 | - | - | x0.993 | x1.006 | x0.976 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 | 0.119 | 0.119 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.003 | x1.007 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 262144 | 0.183 | 0.183 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.012 | x1.000 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 32 B | 0.0929 | 0.0954 | x1.026 | level | 1 of 4 | - | - | x0.998 | x1.008 | x0.973 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 32 B | 0.345 | 0.346 | x1.002 | level | 1 of 4 | - | - | x0.984 | x0.993 | x0.992 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 16 B | 0.535 | 0.540 | x1.008 | level | 2 of 4 | - | - | x1.022 | x0.996 | x0.991 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 48 B | 0.0670 | 0.0694 | x1.036 | level | 1 of 4 | - | - | x1.006 | x1.005 | x0.897 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 48 B | 0.278 | 0.276 | x0.993 | level | 3 of 4 | - | - | x0.994 | x0.934 | x0.982 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.0452 | 0.0434 | x0.959 | level | 3 of 4 | - | - | x0.949 | x1.008 | x1.039 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 2 μs | 0.0923 | 0.0922 | x0.999 | level | 3 of 4 | - | - | x0.956 | x0.998 | x1.023 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 4 of 4 | - | - | x0.963 | x1.001 | x0.908 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 64 B | 0.780 | 0.779 | x0.999 | level | 4 of 4 | - | - | x0.998 | x1.006 | x1.102 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 1 KiB | 0.987 | 0.989 | x1.002 | level | 0 of 4 | - | - | x1.002 | x1.001 | x1.084 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 4 KiB | 0.290 | 0.290 | x1.001 | level | 0 of 4 | - | - | x1.000 | x1.001 | x1.035 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 3.912 | 4.494 | x1.149 | level | 1 of 4 | - | - | x0.970 | x0.944 | x1.037 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 4 KiB | 0.0677 | 0.0744 | x1.099 | level | 2 of 4 | - | - | x1.013 | x1.004 | x1.025 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 1 MiB | 0.0322 | 0.0328 | x1.021 | level | 1 of 4 | - | - | x1.016 | x1.004 | x1.001 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 64 B | 0.283 | 0.295 | x1.041 | level | 0 of 4 | - | - | x1.019 | x0.952 | x1.014 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 4 KiB | 0.0370 | 0.0384 | x1.038 | level | 2 of 4 | - | - | x0.995 | x0.978 | x0.950 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 1 MiB | 0.0145 | 0.0147 | x1.018 | level | 2 of 4 | - | - | x0.986 | x0.985 | x0.931 |

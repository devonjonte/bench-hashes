# Nightly drift check: e1966b498bc7 -> 87a0ab4b9f3c

- Host: bench-9700x
- Experiment: `bench=3f119a507807078649d8700112994fce24666868|base=e1966b498bc769db3d51451a4ddc8188a19ed593|target=87a0ab4b9f3cebfa30a791993573bfb4b128ae4e|cells=all|layouts=default`
- bench-hashes: `3f119a507807078649d8700112994fce24666868`
- BLAKE3-Servil base: `e1966b498bc769db3d51451a4ddc8188a19ed593`
- BLAKE3-Servil target: `87a0ab4b9f3cebfa30a791993573bfb4b128ae4e`
- Scope: `--cells all` (layouts: default)
- Deciding stage: stage 2 (kept-drift/second)
- Verdict: **no regression** (exit `0`)

## Stage 2 (deciding, kept-drift/second)

compare: old side: bench 3f119a507807 clean; servil e1966b498bc7 clean
compare: new side: bench 3f119a507807 clean; servil 87a0ab4b9f3c clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / ManyMessages / 8 | 231.659 | 229.608 | x0.991 | level | 39 of 64 | - | - | x0.988 | x0.999 | x0.991 |
| blake3-servil-st / solo / ManyMessages / 24 | 142.412 | 143.746 | x1.009 | level | 32 of 64 | - | - | x1.008 | x1.000 | x0.991 |
| blake3-servil-st / solo / ManyMessages / 64 | 38.945 | 38.684 | x0.993 | level | 32 of 64 | - | - | x0.998 | x0.999 | x0.994 |
| blake3-servil-st / solo / ManyMessages / 128 | 23.167 | 23.256 | x1.004 | level | 30 of 64 | - | - | x1.000 | x0.999 | x1.004 |
| blake3-servil-mt / solo / ManyMessages / 8 | 234.068 | 232.468 | x0.993 | level | 33 of 64 | - | - | x0.991 | x0.999 | x0.993 |
| blake3-servil-mt / solo / ManyMessages / 64 | 38.917 | 38.884 | x0.999 | level | 33 of 64 | - | - | x0.996 | x0.999 | x0.997 |
| blake3-servil-mt / solo / ManyMessages / 128 | 23.334 | 23.396 | x1.003 | level | 32 of 64 | - | - | x1.001 | x0.999 | x1.010 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 4 KiB | 0.0711 | 0.0709 | x0.998 | level | 36 of 64 | x1.005 | - | x0.998 | x0.956 | x1.017 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 4 KiB | 0.0696 | 0.0673 | x0.967 | level | 38 of 64 | - | - | x0.980 | x0.968 | x1.016 |

## Stage 1 (initial screen, kept-drift)

compare: old side: bench 3f119a507807 clean; servil e1966b498bc7 clean
compare: new side: bench 3f119a507807 clean; servil 87a0ab4b9f3c clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 6.155 | 6.514 | x1.058 | level | 2 of 4 | - | - | x0.979 | x0.988 | x0.911 |
| blake3-servil-st / solo / OneMessage / 128 B | 4.045 | 4.047 | x1.001 | level | 2 of 4 | - | - | x0.970 | x0.994 | x0.907 |
| blake3-servil-st / solo / OneMessage / 256 B | 2.600 | 2.751 | x1.058 | level | 2 of 4 | - | - | x1.014 | x1.001 | x0.966 |
| blake3-servil-st / solo / OneMessage / 512 B | 1.771 | 1.863 | x1.052 | level | 1 of 4 | - | - | x1.021 | x0.999 | x0.928 |
| blake3-servil-st / solo / OneMessage / 1 KiB | 1.483 | 1.525 | x1.028 | level | 0 of 4 | - | - | x1.005 | x0.998 | x0.957 |
| blake3-servil-st / solo / OneMessage / 1536 B | 1.383 | 1.325 | x0.958 | level | 4 of 4 | - | - | x0.947 | x0.994 | x0.957 |
| blake3-servil-st / solo / OneMessage / 2 KiB | 0.837 | 0.813 | x0.972 | level | 3 of 4 | - | - | x0.963 | x0.998 | x0.985 |
| blake3-servil-st / solo / OneMessage / 2304 B | 1.020 | 0.982 | x0.963 | level | 3 of 4 | - | - | x0.950 | x0.998 | x0.974 |
| blake3-servil-st / solo / OneMessage / 3 KiB | 0.700 | 0.743 | x1.060 | level | 1 of 4 | - | - | x1.034 | x0.999 | x0.988 |
| blake3-servil-st / solo / OneMessage / 3839 B | 0.752 | 0.767 | x1.020 | level | 2 of 4 | - | - | x1.009 | x0.997 | x0.983 |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.460 | 0.461 | x1.002 | level | 3 of 4 | - | - | x0.990 | x0.996 | x0.994 |
| blake3-servil-st / solo / OneMessage / 4470 B | 0.578 | 0.573 | x0.990 | level | 3 of 4 | - | - | x0.983 | x0.999 | x0.992 |
| blake3-servil-st / solo / OneMessage / 7935 B | 0.597 | 0.587 | x0.983 | level | 2 of 4 | - | - | x0.985 | x1.000 | x0.992 |
| blake3-servil-st / solo / OneMessage / 8 KiB | 0.350 | 0.358 | x1.023 | level | 1 of 4 | - | - | x1.002 | x0.999 | x1.017 |
| blake3-servil-st / solo / OneMessage / 16 KiB | 0.216 | 0.220 | x1.021 | level | 2 of 4 | - | - | x1.016 | x1.000 | x0.963 |
| blake3-servil-st / solo / OneMessage / 32 KiB | 0.193 | 0.197 | x1.017 | level | 1 of 4 | - | - | x1.012 | x1.000 | x0.979 |
| blake3-servil-st / solo / OneMessage / 64 KiB | 0.142 | 0.143 | x1.005 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.001 |
| blake3-servil-st / solo / OneMessage / 128 KiB | 0.117 | 0.115 | x0.987 | level | 4 of 4 | - | - | x0.986 | x1.000 | x1.013 |
| blake3-servil-st / solo / OneMessage / 256 KiB | 0.103 | 0.102 | x0.993 | level | 4 of 4 | - | - | x0.995 | x1.000 | x0.973 |
| blake3-servil-st / solo / OneMessage / 512 KiB | 0.0905 | 0.0911 | x1.007 | level | 1 of 4 | - | - | x1.007 | x1.000 | x1.120 |
| blake3-servil-st / solo / OneMessage / 1 MiB | 0.0853 | 0.0856 | x1.004 | level | 1 of 4 | - | - | x1.005 | x1.000 | x1.103 |
| blake3-servil-st / solo / OneMessage / 2 MiB | 0.0845 | 0.0849 | x1.004 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.125 |
| blake3-servil-st / solo / OneMessage / 3 MiB | 0.0847 | 0.0849 | x1.002 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.113 |
| blake3-servil-st / solo / OneMessage / 4 MiB | 0.0846 | 0.0847 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.102 |
| blake3-servil-st / solo / OneMessage / 8 MiB | 0.0909 | 0.0902 | x0.992 | level | 3 of 4 | - | - | x1.001 | x1.000 | x1.084 |
| blake3-servil-st / solo / OneMessage / 32 MiB | 0.131 | 0.131 | x0.998 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.029 |
| blake3-servil-st / solo / OneMessage / 64 MiB | 0.131 | 0.131 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.028 |
| blake3-servil-st / solo / OneMessage / 128 MiB | 0.131 | 0.131 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.034 |
| blake3-servil-st / solo / ManyMessages / 1 | 655.172 | 631.199 | x0.963 | level | 2 of 4 | - | - | x0.926 | x1.004 | x1.013 |
| blake3-servil-st / solo / ManyMessages / 2 | 276.261 | 278.146 | x1.007 | level | 2 of 4 | - | - | x0.936 | x0.999 | x0.924 |
| blake3-servil-st / solo / ManyMessages / 3 | 226.796 | 233.659 | x1.030 | level | 1 of 4 | - | - | x0.973 | x1.000 | x0.939 |
| blake3-servil-st / solo / ManyMessages / 4 | 145.035 | 149.289 | x1.029 | level | 1 of 4 | - | - | x0.956 | x0.999 | x0.949 |
| blake3-servil-st / solo / ManyMessages / 6 | 107.662 | 108.902 | x1.012 | level | 2 of 4 | - | - | x0.940 | x1.004 | x0.940 |
| blake3-servil-st / solo / ManyMessages / 8 | 103.314 | 112.599 | x1.090 | level | 1 of 4 | - | - | x1.038 | x1.005 | x0.989 |
| blake3-servil-st / solo / ManyMessages / 12 | 81.031 | 83.753 | x1.034 | level | 2 of 4 | - | - | x0.995 | x0.996 | x0.983 |
| blake3-servil-st / solo / ManyMessages / 16 | 59.472 | 62.626 | x1.053 | level | 1 of 4 | - | - | x0.975 | x0.994 | x0.990 |
| blake3-servil-st / solo / ManyMessages / 24 | 49.540 | 52.706 | x1.064 | level | 0 of 4 | - | - | x1.024 | x1.003 | x0.983 |
| blake3-servil-st / solo / ManyMessages / 32 | 32.149 | 34.012 | x1.058 | level | 1 of 4 | - | - | x1.007 | x1.000 | x0.986 |
| blake3-servil-st / solo / ManyMessages / 48 | 23.296 | 24.442 | x1.049 | level | 1 of 4 | - | - | x1.002 | x0.996 | x0.993 |
| blake3-servil-st / solo / ManyMessages / 64 | 18.252 | 19.972 | x1.094 | level | 0 of 4 | - | - | x1.035 | x0.996 | x0.986 |
| blake3-servil-st / solo / ManyMessages / 128 | 13.188 | 13.890 | x1.053 | level | 0 of 4 | - | - | x1.025 | x1.000 | x0.998 |
| blake3-servil-st / solo / ManyMessages / 256 | 10.374 | 10.601 | x1.022 | level | 1 of 4 | - | - | x1.031 | x1.000 | x1.000 |
| blake3-servil-st / solo / ManyMessages / 512 | 8.889 | 9.076 | x1.021 | level | 1 of 4 | - | - | x1.013 | x1.000 | x1.022 |
| blake3-servil-st / solo / ManyMessages / 1024 | 8.112 | 8.091 | x0.998 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.008 |
| blake3-servil-st / solo / ManyMessages / 2048 | 7.665 | 7.653 | x0.998 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.070 |
| blake3-servil-st / solo / ManyMessages / 4096 | 7.574 | 7.441 | x0.982 | level | 3 of 4 | - | - | x0.983 | x1.000 | x1.068 |
| blake3-servil-st / solo / ManyMessages / 8192 | 7.094 | 7.052 | x0.994 | level | 3 of 4 | - | - | x0.992 | x1.000 | x1.112 |
| blake3-servil-st / solo / ManyMessages / 16384 | 6.752 | 6.746 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.067 |
| blake3-servil-st / solo / ManyMessages / 32768 | 6.783 | 6.773 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.071 |
| blake3-servil-st / solo / ManyMessages / 65536 | 6.941 | 6.916 | x0.996 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.020 |
| blake3-servil-st / solo / ManyMessages / 131072 | 7.215 | 7.218 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.008 |
| blake3-servil-st / solo / ManyMessages / 262144 | 7.677 | 7.701 | x1.003 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.002 |
| blake3-servil-st / solo / ManyLongMessages / 4 | 1679.810 | 1715.125 | x1.021 | level | 0 of 4 | - | - | x1.015 | x1.000 | x0.988 |
| blake3-servil-st / solo / ManyLongMessages / 16 | 1385.862 | 1388.699 | x1.002 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.039 |
| blake3-servil-st / solo / ManyLongMessages / 64 | 504.073 | 498.279 | x0.989 | level | 3 of 4 | - | - | x0.990 | x1.000 | x0.954 |
| blake3-servil-st / solo / ManyLongMessages / 256 | 449.097 | 446.645 | x0.995 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.983 |
| blake3-servil-st / solo / IdleOneMessage / 64 B | 3.459 | 3.448 | x0.997 | level | 2 of 4 | - | - | x0.998 | x0.999 | x0.860 |
| blake3-servil-st / solo / IdleOneMessage / 128 B | 2.413 | 2.405 | x0.997 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.181 |
| blake3-servil-st / solo / IdleOneMessage / 256 B | 1.912 | 1.905 | x0.996 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.687 |
| blake3-servil-st / solo / IdleOneMessage / 512 B | 1.642 | 1.689 | x1.029 | level | 0 of 4 | - | - | x1.001 | x1.000 | x0.684 |
| blake3-servil-st / solo / IdleOneMessage / 1 KiB | 1.533 | 1.515 | x0.988 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.911 |
| blake3-servil-st / solo / IdleOneMessage / 1536 B | 1.133 | 1.136 | x1.003 | level | 2 of 4 | - | - | x1.000 | x0.997 | x1.107 |
| blake3-servil-st / solo / IdleOneMessage / 2 KiB | 0.829 | 0.829 | x1.000 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.802 |
| blake3-servil-st / solo / IdleOneMessage / 2304 B | 0.919 | 0.921 | x1.003 | level | 2 of 4 | - | - | x0.995 | x1.000 | x1.401 |
| blake3-servil-st / solo / IdleOneMessage / 3 KiB | 0.586 | 0.589 | x1.006 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.506 |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 0.477 | 0.487 | x1.021 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.462 |
| blake3-servil-st / solo / IdleOneMessage / 4 KiB | 0.446 | 0.445 | x0.998 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.477 |
| blake3-servil-st / solo / IdleOneMessage / 4470 B | 0.551 | 0.546 | x0.992 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.642 |
| blake3-servil-st / solo / IdleOneMessage / 7935 B | 0.275 | 0.275 | x1.000 | level | 2 of 4 | - | - | x0.992 | x1.000 | x0.357 |
| blake3-servil-st / solo / IdleOneMessage / 8 KiB | 0.256 | 0.253 | x0.988 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.872 |
| blake3-servil-st / solo / IdleOneMessage / 16 KiB | 0.146 | 0.144 | x0.989 | level | 2 of 4 | - | - | x0.995 | x1.000 | x0.742 |
| blake3-servil-st / solo / IdleOneMessage / 32 KiB | 0.0991 | 0.0994 | x1.003 | level | 1 of 4 | - | - | x0.999 | x1.000 | x2.024 |
| blake3-servil-st / solo / IdleOneMessage / 64 KiB | 0.0904 | 0.0928 | x1.026 | level | 1 of 4 | - | - | x0.994 | x1.000 | x0.709 |
| blake3-servil-st / solo / IdleOneMessage / 128 KiB | 0.0879 | 0.0872 | x0.993 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.947 |
| blake3-servil-st / solo / IdleOneMessage / 256 KiB | 0.0880 | 0.0870 | x0.989 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.729 |
| blake3-servil-st / solo / IdleOneMessage / 512 KiB | 0.0969 | 0.0944 | x0.974 | level | 2 of 4 | - | - | x0.989 | x1.000 | x1.056 |
| blake3-servil-st / solo / IdleOneMessage / 1 MiB | 0.0986 | 0.0978 | x0.991 | level | 2 of 4 | - | - | x0.991 | x1.000 | x1.247 |
| blake3-servil-st / solo / IdleOneMessage / 2 MiB | 0.0992 | 0.0995 | x1.003 | level | 1 of 4 | - | - | x0.993 | x1.000 | x1.186 |
| blake3-servil-st / solo / IdleOneMessage / 3 MiB | 0.0981 | 0.0982 | x1.001 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.178 |
| blake3-servil-st / solo / IdleOneMessage / 4 MiB | 0.0985 | 0.0968 | x0.984 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.161 |
| blake3-servil-st / solo / IdleOneMessage / 8 MiB | 0.0984 | 0.0975 | x0.991 | level | 2 of 4 | - | - | x0.990 | x1.000 | x1.145 |
| blake3-servil-st / solo / IdleOneMessage / 32 MiB | 0.125 | 0.125 | x1.002 | level | 2 of 4 | - | - | x1.011 | x1.000 | x1.029 |
| blake3-servil-st / solo / IdleOneMessage / 64 MiB | 0.130 | 0.130 | x0.998 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.029 |
| blake3-servil-st / solo / IdleOneMessage / 128 MiB | 0.131 | 0.130 | x0.996 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.035 |
| blake3-servil-st / solo / IdleManyMessages / 1 | 232.968 | 234.615 | x1.007 | level | 1 of 4 | - | - | x0.991 | x1.002 | x0.733 |
| blake3-servil-st / solo / IdleManyMessages / 2 | 119.079 | 120.195 | x1.009 | level | 2 of 4 | - | - | x0.996 | x0.998 | x1.116 |
| blake3-servil-st / solo / IdleManyMessages / 3 | 104.413 | 105.692 | x1.012 | level | 1 of 4 | - | - | x1.004 | x0.999 | x0.665 |
| blake3-servil-st / solo / IdleManyMessages / 4 | 61.535 | 62.051 | x1.008 | level | 2 of 4 | - | - | x1.000 | x0.998 | x0.739 |
| blake3-servil-st / solo / IdleManyMessages / 6 | 53.738 | 53.012 | x0.986 | level | 3 of 4 | - | - | x0.997 | x0.999 | x0.820 |
| blake3-servil-st / solo / IdleManyMessages / 8 | 32.940 | 32.232 | x0.979 | level | 3 of 4 | - | - | x0.993 | x0.999 | x0.600 |
| blake3-servil-st / solo / IdleManyMessages / 12 | 29.923 | 29.236 | x0.977 | level | 3 of 4 | - | - | x0.994 | x0.999 | x0.547 |
| blake3-servil-st / solo / IdleManyMessages / 16 | 16.986 | 17.568 | x1.034 | level | 0 of 4 | - | - | x1.016 | x0.999 | x4.356 |
| blake3-servil-st / solo / IdleManyMessages / 24 | 15.828 | 15.647 | x0.989 | level | 3 of 4 | - | - | x0.997 | x0.999 | x1.169 |
| blake3-servil-st / solo / IdleManyMessages / 32 | 12.174 | 11.930 | x0.980 | level | 3 of 4 | - | - | x0.999 | x0.999 | x1.891 |
| blake3-servil-st / solo / IdleManyMessages / 48 | 10.648 | 10.546 | x0.990 | level | 3 of 4 | - | - | x0.995 | x0.999 | x0.673 |
| blake3-servil-st / solo / IdleManyMessages / 64 | 9.785 | 9.715 | x0.993 | level | 2 of 4 | - | - | x0.995 | x1.000 | x1.201 |
| blake3-servil-st / solo / IdleManyMessages / 128 | 8.730 | 8.515 | x0.975 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.837 |
| blake3-servil-st / solo / IdleManyMessages / 256 | 8.000 | 8.045 | x1.006 | level | 1 of 4 | - | - | x0.989 | x1.000 | x0.388 |
| blake3-servil-st / solo / IdleManyMessages / 512 | 7.594 | 7.673 | x1.010 | level | 1 of 4 | - | - | x0.997 | x1.000 | x1.405 |
| blake3-servil-st / solo / IdleManyMessages / 1024 | 7.491 | 7.449 | x0.994 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.930 |
| blake3-servil-st / solo / IdleManyMessages / 2048 | 7.553 | 7.679 | x1.017 | level | 1 of 4 | - | - | x0.985 | x1.000 | x0.834 |
| blake3-servil-st / solo / IdleManyMessages / 4096 | 7.748 | 7.703 | x0.994 | level | 3 of 4 | - | - | x0.990 | x1.000 | x0.891 |
| blake3-servil-st / solo / IdleManyMessages / 8192 | 8.413 | 8.477 | x1.008 | level | 1 of 4 | - | - | x0.994 | x1.000 | x0.991 |
| blake3-servil-st / solo / IdleManyMessages / 16384 | 8.502 | 8.552 | x1.006 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.999 |
| blake3-servil-st / solo / IdleManyMessages / 32768 | 8.536 | 8.652 | x1.014 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.996 |
| blake3-servil-st / solo / IdleManyMessages / 65536 | 8.624 | 8.505 | x0.986 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.004 |
| blake3-servil-st / solo / IdleManyMessages / 131072 | 7.789 | 7.696 | x0.988 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.993 |
| blake3-servil-st / solo / IdleManyMessages / 262144 | 8.034 | 8.108 | x1.009 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.994 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 B | 2.401 | 2.396 | x0.998 | level | 2 of 4 | - | - | x1.000 | x0.999 | x0.874 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 B | 1.685 | 1.690 | x1.003 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.334 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 B | 1.354 | 1.351 | x0.997 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.163 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 B | 1.165 | 1.164 | x0.999 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.470 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 KiB | 1.078 | 1.078 | x1.000 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.662 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1536 B | 0.811 | 0.809 | x0.997 | level | 4 of 4 | - | - | x0.997 | x0.997 | x1.011 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 KiB | 0.584 | 0.584 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.133 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2304 B | 0.652 | 0.648 | x0.994 | level | 4 of 4 | - | - | x0.995 | x1.000 | x1.303 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.418 | 0.417 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.288 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3839 B | 0.341 | 0.341 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.828 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 KiB | 0.312 | 0.311 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.978 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4470 B | 0.383 | 0.383 | x0.998 | level | 4 of 4 | - | - | x0.999 | x1.000 | x1.197 |
| blake3-servil-st / solo / BriefIdleOneMessage / 7935 B | 0.193 | 0.192 | x0.996 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.619 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 KiB | 0.179 | 0.179 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.963 |
| blake3-servil-st / solo / BriefIdleOneMessage / 16 KiB | 0.101 | 0.0998 | x0.991 | level | 4 of 4 | - | - | x0.993 | x1.000 | x0.905 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 KiB | 0.0706 | 0.0702 | x0.995 | level | 4 of 4 | - | - | x0.995 | x1.000 | x0.883 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 KiB | 0.0654 | 0.0652 | x0.997 | level | 4 of 4 | - | - | x0.997 | x1.000 | x0.655 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 KiB | 0.0627 | 0.0628 | x1.002 | level | 1 of 4 | - | - | x0.999 | x1.000 | x1.389 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 KiB | 0.0622 | 0.0618 | x0.994 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.496 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 KiB | 0.0676 | 0.0670 | x0.990 | level | 3 of 4 | - | - | x0.991 | x1.000 | x1.028 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 MiB | 0.0705 | 0.0697 | x0.989 | level | 3 of 4 | - | - | x0.988 | x1.000 | x1.143 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 MiB | 0.0712 | 0.0701 | x0.984 | level | 3 of 4 | - | - | x0.988 | x1.000 | x1.140 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 MiB | 0.0706 | 0.0698 | x0.989 | level | 3 of 4 | - | - | x0.993 | x1.000 | x1.137 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 MiB | 0.0703 | 0.0696 | x0.991 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.128 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 MiB | 0.0719 | 0.0710 | x0.988 | level | 3 of 4 | - | - | x0.988 | x1.000 | x1.138 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 MiB | 0.128 | 0.128 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.030 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 MiB | 0.131 | 0.131 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.030 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 MiB | 0.131 | 0.131 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.035 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1 | 165.134 | 164.983 | x0.999 | level | 3 of 4 | - | - | x1.000 | x1.002 | x0.780 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2 | 83.356 | 83.244 | x0.999 | level | 2 of 4 | - | - | x1.000 | x0.998 | x0.379 |
| blake3-servil-st / solo / BriefIdleManyMessages / 3 | 71.921 | 71.953 | x1.000 | level | 2 of 4 | - | - | x1.001 | x0.999 | x0.816 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4 | 42.537 | 42.238 | x0.993 | level | 2 of 4 | - | - | x0.997 | x0.998 | x0.765 |
| blake3-servil-st / solo / BriefIdleManyMessages / 6 | 36.773 | 36.771 | x1.000 | level | 2 of 4 | - | - | x1.000 | x0.999 | x0.544 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8 | 22.756 | 22.438 | x0.986 | level | 4 of 4 | - | - | x0.995 | x0.999 | x0.931 |
| blake3-servil-st / solo / BriefIdleManyMessages / 12 | 20.579 | 20.474 | x0.995 | level | 4 of 4 | - | - | x0.997 | x0.999 | x1.372 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16 | 11.864 | 11.723 | x0.988 | level | 4 of 4 | - | - | x0.992 | x0.999 | x0.988 |
| blake3-servil-st / solo / BriefIdleManyMessages / 24 | 11.022 | 10.912 | x0.990 | level | 4 of 4 | - | - | x0.992 | x0.999 | x0.514 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32 | 8.458 | 8.359 | x0.988 | level | 4 of 4 | - | - | x0.993 | x0.999 | x0.690 |
| blake3-servil-st / solo / BriefIdleManyMessages / 48 | 7.355 | 7.287 | x0.991 | level | 4 of 4 | - | - | x0.993 | x0.999 | x0.870 |
| blake3-servil-st / solo / BriefIdleManyMessages / 64 | 6.787 | 6.710 | x0.989 | level | 4 of 4 | - | - | x0.992 | x0.999 | x0.379 |
| blake3-servil-st / solo / BriefIdleManyMessages / 128 | 5.953 | 5.925 | x0.995 | level | 4 of 4 | - | - | x0.996 | x1.000 | x0.990 |
| blake3-servil-st / solo / BriefIdleManyMessages / 256 | 5.662 | 5.605 | x0.990 | level | 4 of 4 | - | - | x0.991 | x1.000 | x0.813 |
| blake3-servil-st / solo / BriefIdleManyMessages / 512 | 5.446 | 5.427 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.000 | x2.568 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1024 | 5.382 | 5.357 | x0.995 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.141 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2048 | 5.387 | 5.358 | x0.995 | level | 2 of 4 | - | - | x0.993 | x1.000 | x0.807 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4096 | 5.505 | 5.467 | x0.993 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.865 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8192 | 5.882 | 5.884 | x1.000 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.020 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16384 | 6.049 | 6.053 | x1.001 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.991 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32768 | 6.081 | 6.098 | x1.003 | level | 1 of 4 | - | - | x1.004 | x1.000 | x0.986 |
| blake3-servil-st / solo / BriefIdleManyMessages / 65536 | 6.045 | 6.036 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.980 |
| blake3-servil-st / solo / BriefIdleManyMessages / 131072 | 6.070 | 6.083 | x1.002 | level | 1 of 4 | - | - | x1.003 | x1.000 | x0.988 |
| blake3-servil-st / solo / BriefIdleManyMessages / 262144 | 7.009 | 7.020 | x1.002 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.989 |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.747 | 0.746 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.699 |
| blake3-servil-st / solo / ContinuousMessages / 128 B | 0.857 | 0.858 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x1.016 |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 0.914 | 0.915 | x1.001 | level | 0 of 4 | x1.001 | - | x1.000 | x1.000 | x0.608 |
| blake3-servil-st / solo / ContinuousMessages / 512 B | 0.943 | 0.943 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x0.633 |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 0.962 | 0.962 | x0.999 | level | 2 of 4 | x0.999 | - | x1.000 | x1.000 | x0.858 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.285 | 0.285 | x1.000 | level | 2 of 4 | x1.000 | - | x1.001 | x1.000 | x1.810 |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.0910 | 0.0909 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x1.000 |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.0652 | 0.0651 | x0.999 | level | 3 of 4 | x0.999 | - | x0.998 | x1.000 | x1.182 |
| blake3-servil-st / solo / ContinuousMessages / 256 KiB | 0.0669 | 0.0666 | x0.997 | level | 2 of 4 | x0.997 | - | x0.997 | x1.000 | x0.906 |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.0676 | 0.0677 | x1.001 | level | 0 of 4 | x1.001 | - | x1.001 | x1.000 | x1.067 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.0687 | 0.0686 | x0.998 | level | 4 of 4 | x0.998 | - | x0.997 | x1.000 | x0.974 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.0688 | 0.0688 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.081 |
| blake3-servil-st / solo / ContinuousMessages / 64 MiB | 0.0795 | 0.0797 | x1.002 | level | 2 of 4 | x1.002 | - | x1.003 | x1.000 | x1.004 |
| blake3-servil-st / solo / ContinuousBatches / 16 | 6.054 | 6.043 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x0.999 | x1.098 |
| blake3-servil-st / solo / ContinuousBatches / 64 | 5.321 | 5.325 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x0.999 | x1.213 |
| blake3-servil-st / solo / ContinuousBatches / 256 | 5.304 | 5.205 | x0.981 | level | 4 of 4 | x0.981 | - | x0.981 | x1.000 | x1.665 |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 5.625 | 5.636 | x1.002 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x0.112 |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 5.562 | 5.492 | x0.987 | level | 3 of 4 | x0.987 | - | x0.988 | x1.000 | x0.291 |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 6.142 | 6.127 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x0.997 |
| blake3-servil-st / solo / ContinuousBatches / 65536 | 6.167 | 6.204 | x1.006 | level | 0 of 4 | x1.006 | - | x1.006 | x1.000 | x1.730 |
| blake3-servil-st / solo / LentMessages / 64 B | 0.747 | 0.746 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.699 |
| blake3-servil-st / solo / LentMessages / 128 B | 0.857 | 0.858 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x1.016 |
| blake3-servil-st / solo / LentMessages / 256 B | 0.914 | 0.915 | x1.001 | level | 0 of 4 | x1.001 | - | x1.000 | x1.000 | x0.608 |
| blake3-servil-st / solo / LentMessages / 512 B | 0.943 | 0.943 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x0.633 |
| blake3-servil-st / solo / LentMessages / 1 KiB | 0.962 | 0.962 | x0.999 | level | 2 of 4 | x0.999 | - | x1.000 | x1.000 | x0.858 |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.285 | 0.285 | x1.000 | level | 2 of 4 | x1.000 | - | x1.001 | x1.000 | x1.810 |
| blake3-servil-st / solo / LentMessages / 16 KiB | 0.0910 | 0.0909 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x1.000 |
| blake3-servil-st / solo / LentMessages / 64 KiB | 0.0652 | 0.0651 | x0.999 | level | 3 of 4 | x0.999 | - | x0.998 | x1.000 | x1.182 |
| blake3-servil-st / solo / LentMessages / 256 KiB | 0.0621 | 0.0615 | x0.990 | level | 3 of 4 | x0.990 | - | x0.990 | x1.000 | x0.224 |
| blake3-servil-st / solo / LentMessages / 1 MiB | 0.0691 | 0.0689 | x0.998 | level | 2 of 4 | x0.997 | - | x0.997 | x1.000 | x1.072 |
| blake3-servil-st / solo / LentMessages / 4 MiB | 0.0696 | 0.0705 | x1.014 | level | 1 of 4 | x1.014 | - | x1.014 | x1.000 | x1.511 |
| blake3-servil-st / solo / LentMessages / 16 MiB | 0.0759 | 0.0763 | x1.006 | level | 0 of 4 | x1.005 | - | x1.006 | x1.000 | x1.121 |
| blake3-servil-st / solo / LentMessages / 64 MiB | 0.131 | 0.132 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | x1.028 |
| blake3-servil-st / solo / Interleaved / 256 | 0.109 | 0.109 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x0.999 | x1.002 |
| blake3-servil-st / solo / Collection / git objects | 0.0842 | 0.0847 | x1.005 | level | 1 of 4 | x1.005 | - | x1.006 | x0.999 | x1.037 |
| blake3-servil-st / solo / Collection / Nix files | 0.0740 | 0.0744 | x1.005 | level | 1 of 4 | x1.005 | - | x1.005 | x0.999 | x1.050 |
| blake3-servil-st / solo / LentBatches / 16 | 6.054 | 6.043 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x0.999 | x1.098 |
| blake3-servil-st / solo / LentBatches / 64 | 5.321 | 5.325 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x0.999 | x1.213 |
| blake3-servil-st / solo / LentBatches / 256 | 5.304 | 5.205 | x0.981 | level | 4 of 4 | x0.981 | - | x0.981 | x1.000 | x1.665 |
| blake3-servil-st / solo / LentBatches / 1024 | 5.625 | 5.636 | x1.002 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x0.112 |
| blake3-servil-st / solo / LentBatches / 4096 | 5.562 | 5.492 | x0.987 | level | 3 of 4 | x0.987 | - | x0.988 | x1.000 | x0.291 |
| blake3-servil-st / solo / LentBatches / 16384 | 6.142 | 6.127 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x0.997 |
| blake3-servil-st / solo / LentBatches / 65536 | 6.167 | 6.204 | x1.006 | level | 0 of 4 | x1.006 | - | x1.006 | x1.000 | x1.730 |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.109 | 0.111 | x1.013 | level | 0 of 4 | x1.013 | - | x1.013 | x1.000 | x1.131 |
| blake3-servil-st / solo / ContinuousCollection / Nix files | 0.117 | 0.118 | x1.006 | level | 0 of 4 | x1.006 | - | x1.006 | x1.000 | x1.098 |
| blake3-servil-st / solo / MerkleTree / 1024 | 0.1000 | 0.0995 | x0.995 | level | 2 of 4 | x0.995 | - | x0.996 | x1.001 | x1.878 |
| blake3-servil-st / solo / MerkleTree / 4096 | 0.107 | 0.107 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.001 | x1.016 |
| blake3-servil-st / solo / MerkleTree / 16384 | 0.107 | 0.107 | x0.998 | level | 2 of 4 | x0.998 | - | x0.998 | x1.001 | x0.913 |
| blake3-servil-st / solo / MerkleTree / 65536 | 0.119 | 0.120 | x1.003 | level | 1 of 4 | x1.003 | - | x1.003 | x1.001 | x1.001 |
| blake3-servil-st / solo / MerkleTree / 262144 | 0.160 | 0.161 | x1.005 | level | 1 of 4 | x1.005 | - | x1.005 | x1.001 | x1.001 |
| blake3-servil-st / solo / MerkleTree / 65536 x 32 B | 0.308 | 0.308 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x1.002 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 32 B | 0.388 | 0.389 | x1.004 | level | 1 of 4 | x1.004 | - | x1.004 | x1.000 | x0.999 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 16 B | 0.699 | 0.703 | x1.006 | level | 1 of 4 | x1.006 | - | x1.006 | x1.000 | x1.020 |
| blake3-servil-st / solo / MerkleTree / 65536 x 48 B | 0.215 | 0.215 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.984 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 48 B | 0.286 | 0.287 | x1.004 | level | 1 of 4 | x1.004 | - | x1.005 | x1.000 | x1.006 |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.244 | 0.244 | x1.001 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.938 |
| blake3-servil-st / solo / InterleavedTurn / 1024 x 1 KiB | 0.207 | 0.208 | x1.009 | level | 1 of 4 | - | - | x1.008 | x1.000 | x0.988 |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.270 | 0.268 | x0.990 | level | 2 of 4 | - | - | x0.988 | x1.001 | x1.019 |
| blake3-servil-st / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.238 | 0.228 | x0.957 | level | 4 of 4 | - | - | x0.979 | x1.000 | x1.022 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.194 | 0.194 | x0.999 | level | 2 of 4 | - | - | x1.001 | x1.007 | x1.020 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.173 | 0.168 | x0.972 | level | 3 of 4 | - | - | x0.971 | x1.000 | x1.016 |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.0836 | 0.0835 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x1.025 |
| blake3-servil-st / solo / ReceivingMessage / 2 μs | 0.0922 | 0.0922 | x0.999 | level | 2 of 4 | x0.999 | - | x1.001 | x1.000 | x1.008 |
| blake3-servil-st / solo / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 1 of 4 | x1.005 | - | x1.000 | x1.000 | x0.994 |
| blake3-servil-st / solo / IncrementalMessage / 64 B | 7.528 | 8.522 | x1.132 | level | 2 of 4 | - | - | x1.062 | x1.002 | x0.931 |
| blake3-servil-st / solo / IncrementalMessage / 1 KiB | 1.766 | 1.839 | x1.041 | level | 2 of 4 | - | - | x1.032 | x1.004 | x0.968 |
| blake3-servil-st / solo / IncrementalMessage / 4 KiB | 0.552 | 0.578 | x1.048 | level | 1 of 4 | - | - | x1.036 | x1.001 | x0.988 |
| blake3-servil-st / solo / LentIncrementalMessage / 64 B | 0.807 | 0.806 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x1.212 |
| blake3-servil-st / solo / LentIncrementalMessage / 1 KiB | 0.988 | 0.988 | x1.001 | level | 2 of 4 | x1.001 | - | x1.000 | x1.000 | x0.893 |
| blake3-servil-st / solo / LentIncrementalMessage / 4 KiB | 0.290 | 0.290 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x1.083 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 0.756 | 0.757 | x1.001 | level | 0 of 4 | x1.001 | - | x1.000 | x1.000 | x0.912 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 4 KiB | 0.284 | 0.284 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.736 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 1 MiB | 0.0680 | 0.0676 | x0.995 | level | 4 of 4 | x0.995 | - | x0.995 | x1.000 | x1.000 |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 0.722 | 0.723 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | x1.092 |
| blake3-servil-st / solo / ContinuousLentMessages / 4 KiB | 0.281 | 0.280 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.487 |
| blake3-servil-st / solo / ContinuousLentMessages / 1 MiB | 0.0566 | 0.0563 | x0.994 | level | 2 of 4 | x0.994 | - | x0.993 | x1.000 | x0.835 |
| blake3-servil-mt / solo / OneMessage / 64 B | 6.600 | 7.114 | x1.078 | level | 1 of 4 | - | - | x1.010 | x0.991 | x0.954 |
| blake3-servil-mt / solo / OneMessage / 128 B | 4.014 | 4.244 | x1.057 | level | 2 of 4 | - | - | x0.980 | x0.996 | x0.954 |
| blake3-servil-mt / solo / OneMessage / 256 B | 2.624 | 2.901 | x1.106 | level | 0 of 4 | - | - | x1.048 | x1.003 | x1.017 |
| blake3-servil-mt / solo / OneMessage / 512 B | 1.820 | 1.957 | x1.075 | level | 1 of 4 | - | - | x1.044 | x0.999 | x1.008 |
| blake3-servil-mt / solo / OneMessage / 1 KiB | 1.524 | 1.525 | x1.001 | level | 3 of 4 | - | - | x0.990 | x0.998 | x0.960 |
| blake3-servil-mt / solo / OneMessage / 1536 B | 1.402 | 1.371 | x0.978 | level | 3 of 4 | - | - | x0.959 | x0.994 | x0.956 |
| blake3-servil-mt / solo / OneMessage / 2 KiB | 0.836 | 0.866 | x1.036 | level | 1 of 4 | - | - | x0.996 | x0.997 | x0.994 |
| blake3-servil-mt / solo / OneMessage / 2304 B | 1.015 | 1.016 | x1.001 | level | 3 of 4 | - | - | x0.979 | x0.998 | x0.989 |
| blake3-servil-mt / solo / OneMessage / 3 KiB | 0.742 | 0.740 | x0.997 | level | 2 of 4 | - | - | x0.985 | x1.000 | x0.988 |
| blake3-servil-mt / solo / OneMessage / 3839 B | 0.770 | 0.780 | x1.013 | level | 1 of 4 | - | - | x1.005 | x0.998 | x1.003 |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 0.468 | 0.478 | x1.023 | level | 3 of 4 | - | - | x0.995 | x0.996 | x1.012 |
| blake3-servil-mt / solo / OneMessage / 4470 B | 0.603 | 0.583 | x0.966 | level | 3 of 4 | - | - | x0.951 | x0.999 | x0.995 |
| blake3-servil-mt / solo / OneMessage / 7935 B | 0.601 | 0.590 | x0.982 | level | 3 of 4 | - | - | x0.970 | x0.999 | x0.996 |
| blake3-servil-mt / solo / OneMessage / 8 KiB | 0.359 | 0.368 | x1.025 | level | 1 of 4 | - | - | x1.002 | x0.999 | x1.004 |
| blake3-servil-mt / solo / OneMessage / 16 KiB | 0.215 | 0.222 | x1.035 | level | 1 of 4 | - | - | x1.021 | x0.999 | x0.962 |
| blake3-servil-mt / solo / OneMessage / 32 KiB | 0.195 | 0.201 | x1.035 | level | 1 of 4 | - | - | x1.028 | x1.000 | x0.969 |
| blake3-servil-mt / solo / OneMessage / 64 KiB | 0.144 | 0.145 | x1.006 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.019 |
| blake3-servil-mt / solo / OneMessage / 128 KiB | 0.117 | 0.116 | x0.990 | level | 3 of 4 | - | - | x0.989 | x1.000 | x0.984 |
| blake3-servil-mt / solo / OneMessage / 256 KiB | 0.104 | 0.102 | x0.988 | level | 4 of 4 | - | - | x0.988 | x1.000 | x0.965 |
| blake3-servil-mt / solo / OneMessage / 512 KiB | 0.0613 | 0.0609 | x0.993 | level | 3 of 4 | - | - | x0.997 | x0.999 | x1.018 |
| blake3-servil-mt / solo / OneMessage / 1 MiB | 0.0486 | 0.0478 | x0.984 | level | 4 of 4 | - | - | x0.982 | x0.997 | x1.013 |
| blake3-servil-mt / solo / OneMessage / 2 MiB | 0.0432 | 0.0437 | x1.013 | level | 1 of 4 | - | - | x1.007 | x1.002 | x1.019 |
| blake3-servil-mt / solo / OneMessage / 3 MiB | 0.0412 | 0.0412 | x1.001 | level | 2 of 4 | - | - | x0.999 | x0.999 | x1.035 |
| blake3-servil-mt / solo / OneMessage / 4 MiB | 0.0393 | 0.0389 | x0.991 | level | 2 of 4 | - | - | x0.990 | x0.987 | x1.016 |
| blake3-servil-mt / solo / OneMessage / 8 MiB | 0.0382 | 0.0379 | x0.991 | level | 3 of 4 | - | - | x0.990 | x0.988 | x1.002 |
| blake3-servil-mt / solo / OneMessage / 32 MiB | 0.0762 | 0.0751 | x0.986 | level | 4 of 4 | - | - | x0.987 | x1.000 | x0.996 |
| blake3-servil-mt / solo / OneMessage / 64 MiB | 0.0759 | 0.0750 | x0.988 | level | 3 of 4 | - | - | x0.988 | x1.003 | x0.996 |
| blake3-servil-mt / solo / OneMessage / 128 MiB | 0.0754 | 0.0743 | x0.985 | level | 4 of 4 | - | - | x0.986 | x0.999 | x0.996 |
| blake3-servil-mt / solo / ManyMessages / 1 | 655.693 | 641.306 | x0.978 | level | 3 of 4 | - | - | x0.930 | x1.002 | x1.007 |
| blake3-servil-mt / solo / ManyMessages / 2 | 284.946 | 306.818 | x1.077 | level | 2 of 4 | - | - | x1.008 | x0.997 | x0.942 |
| blake3-servil-mt / solo / ManyMessages / 3 | 233.394 | 234.719 | x1.006 | level | 1 of 4 | - | - | x0.943 | x0.995 | x0.943 |
| blake3-servil-mt / solo / ManyMessages / 4 | 148.315 | 145.112 | x0.978 | level | 2 of 4 | - | - | x0.912 | x0.997 | x0.942 |
| blake3-servil-mt / solo / ManyMessages / 6 | 113.471 | 113.777 | x1.003 | level | 2 of 4 | - | - | x0.956 | x0.998 | x0.938 |
| blake3-servil-mt / solo / ManyMessages / 8 | 106.093 | 113.417 | x1.069 | level | 0 of 4 | - | - | x1.000 | x1.000 | x0.990 |
| blake3-servil-mt / solo / ManyMessages / 12 | 80.158 | 84.608 | x1.056 | level | 1 of 4 | - | - | x0.998 | x0.995 | x0.973 |
| blake3-servil-mt / solo / ManyMessages / 16 | 58.941 | 59.987 | x1.018 | level | 1 of 4 | - | - | x0.966 | x0.994 | x0.975 |
| blake3-servil-mt / solo / ManyMessages / 24 | 50.098 | 52.008 | x1.038 | level | 0 of 4 | - | - | x1.003 | x0.999 | x0.987 |
| blake3-servil-mt / solo / ManyMessages / 32 | 32.438 | 33.787 | x1.042 | level | 1 of 4 | - | - | x0.999 | x0.996 | x0.981 |
| blake3-servil-mt / solo / ManyMessages / 48 | 23.699 | 24.777 | x1.045 | level | 1 of 4 | - | - | x1.008 | x0.997 | x0.991 |
| blake3-servil-mt / solo / ManyMessages / 64 | 18.997 | 20.116 | x1.059 | level | 0 of 4 | - | - | x1.023 | x0.998 | x0.989 |
| blake3-servil-mt / solo / ManyMessages / 128 | 13.206 | 14.067 | x1.065 | level | 0 of 4 | - | - | x1.031 | x1.001 | x0.984 |
| blake3-servil-mt / solo / ManyMessages / 256 | 10.618 | 10.818 | x1.019 | level | 1 of 4 | - | - | x1.015 | x1.000 | x0.979 |
| blake3-servil-mt / solo / ManyMessages / 512 | 8.953 | 9.050 | x1.011 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.995 |
| blake3-servil-mt / solo / ManyMessages / 1024 | 8.046 | 8.066 | x1.002 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.010 |
| blake3-servil-mt / solo / ManyMessages / 2048 | 7.742 | 7.635 | x0.986 | level | 3 of 4 | - | - | x0.983 | x1.000 | x1.023 |
| blake3-servil-mt / solo / ManyMessages / 4096 | 7.560 | 7.485 | x0.990 | level | 3 of 4 | - | - | x0.990 | x1.000 | x1.085 |
| blake3-servil-mt / solo / ManyMessages / 8192 | 3.327 | 3.314 | x0.996 | level | 2 of 4 | - | - | x0.997 | x1.017 | x1.029 |
| blake3-servil-mt / solo / ManyMessages / 16384 | 2.790 | 2.772 | x0.993 | level | 2 of 4 | - | - | x0.995 | x0.992 | x1.022 |
| blake3-servil-mt / solo / ManyMessages / 32768 | 2.643 | 2.641 | x0.999 | level | 1 of 4 | - | - | x0.998 | x0.989 | x1.040 |
| blake3-servil-mt / solo / ManyMessages / 65536 | 2.418 | 2.420 | x1.001 | level | 2 of 4 | - | - | x1.000 | x0.994 | x1.045 |
| blake3-servil-mt / solo / ManyMessages / 131072 | 2.446 | 2.432 | x0.994 | level | 3 of 4 | - | - | x0.993 | x0.999 | x1.011 |
| blake3-servil-mt / solo / ManyMessages / 262144 | 2.905 | 2.932 | x1.009 | level | 1 of 4 | - | - | x1.001 | x0.987 | x0.991 |
| blake3-servil-mt / solo / ManyLongMessages / 4 | 1684.425 | 1693.858 | x1.006 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.007 |
| blake3-servil-mt / solo / ManyLongMessages / 16 | 1382.975 | 1387.719 | x1.003 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.008 |
| blake3-servil-mt / solo / ManyLongMessages / 64 | 505.221 | 499.650 | x0.989 | level | 3 of 4 | - | - | x0.992 | x1.000 | x0.980 |
| blake3-servil-mt / solo / ManyLongMessages / 256 | 241.343 | 239.195 | x0.991 | level | 2 of 4 | - | - | x0.990 | x0.983 | x1.011 |
| blake3-servil-mt / solo / IdleOneMessage / 64 B | 3.459 | 3.447 | x0.997 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.012 |
| blake3-servil-mt / solo / IdleOneMessage / 128 B | 2.431 | 2.441 | x1.004 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.736 |
| blake3-servil-mt / solo / IdleOneMessage / 256 B | 1.958 | 1.937 | x0.989 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.079 |
| blake3-servil-mt / solo / IdleOneMessage / 512 B | 1.623 | 1.643 | x1.012 | level | 1 of 4 | - | - | x0.998 | x1.000 | x0.577 |
| blake3-servil-mt / solo / IdleOneMessage / 1 KiB | 1.519 | 1.518 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.390 |
| blake3-servil-mt / solo / IdleOneMessage / 1536 B | 1.136 | 1.142 | x1.005 | level | 1 of 4 | - | - | x0.996 | x0.997 | x0.682 |
| blake3-servil-mt / solo / IdleOneMessage / 2 KiB | 0.842 | 0.833 | x0.988 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.650 |
| blake3-servil-mt / solo / IdleOneMessage / 2304 B | 0.915 | 0.914 | x0.999 | level | 3 of 4 | - | - | x0.995 | x1.000 | x2.059 |
| blake3-servil-mt / solo / IdleOneMessage / 3 KiB | 0.599 | 0.598 | x0.999 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.802 |
| blake3-servil-mt / solo / IdleOneMessage / 3839 B | 0.489 | 0.486 | x0.993 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.257 |
| blake3-servil-mt / solo / IdleOneMessage / 4 KiB | 0.445 | 0.436 | x0.980 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.488 |
| blake3-servil-mt / solo / IdleOneMessage / 4470 B | 0.546 | 0.539 | x0.987 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.001 |
| blake3-servil-mt / solo / IdleOneMessage / 7935 B | 0.282 | 0.276 | x0.979 | level | 3 of 4 | - | - | x0.986 | x1.000 | x0.400 |
| blake3-servil-mt / solo / IdleOneMessage / 8 KiB | 0.257 | 0.257 | x1.000 | level | 1 of 4 | - | - | x0.999 | x1.000 | x0.918 |
| blake3-servil-mt / solo / IdleOneMessage / 16 KiB | 0.146 | 0.143 | x0.977 | level | 3 of 4 | - | - | x0.995 | x1.000 | x2.632 |
| blake3-servil-mt / solo / IdleOneMessage / 32 KiB | 0.102 | 0.0988 | x0.971 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.253 |
| blake3-servil-mt / solo / IdleOneMessage / 64 KiB | 0.0931 | 0.0920 | x0.988 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.816 |
| blake3-servil-mt / solo / IdleOneMessage / 128 KiB | 0.0874 | 0.0865 | x0.989 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.649 |
| blake3-servil-mt / solo / IdleOneMessage / 256 KiB | 0.0896 | 0.0883 | x0.985 | level | 3 of 4 | - | - | x0.993 | x1.000 | x0.644 |
| blake3-servil-mt / solo / IdleOneMessage / 512 KiB | 0.0613 | 0.0595 | x0.971 | level | 3 of 4 | - | - | x0.990 | x1.007 | x1.036 |
| blake3-servil-mt / solo / IdleOneMessage / 1 MiB | 0.0516 | 0.0519 | x1.005 | level | 1 of 4 | - | - | x0.997 | x1.037 | x1.021 |
| blake3-servil-mt / solo / IdleOneMessage / 2 MiB | 0.0470 | 0.0461 | x0.982 | level | 3 of 4 | - | - | x0.987 | x1.016 | x1.023 |
| blake3-servil-mt / solo / IdleOneMessage / 3 MiB | 0.0445 | 0.0444 | x0.998 | level | 1 of 4 | - | - | x0.983 | x0.990 | x1.025 |
| blake3-servil-mt / solo / IdleOneMessage / 4 MiB | 0.0420 | 0.0417 | x0.992 | level | 3 of 4 | - | - | x1.013 | x1.011 | x1.019 |
| blake3-servil-mt / solo / IdleOneMessage / 8 MiB | 0.0391 | 0.0389 | x0.995 | level | 2 of 4 | - | - | x0.978 | x0.997 | x1.021 |
| blake3-servil-mt / solo / IdleOneMessage / 32 MiB | 0.0705 | 0.0696 | x0.987 | level | 4 of 4 | - | - | x0.978 | x1.000 | x0.999 |
| blake3-servil-mt / solo / IdleOneMessage / 64 MiB | 0.0749 | 0.0739 | x0.986 | level | 4 of 4 | - | - | x0.989 | x1.002 | x0.998 |
| blake3-servil-mt / solo / IdleOneMessage / 128 MiB | 0.0750 | 0.0740 | x0.986 | level | 4 of 4 | - | - | x0.988 | x1.000 | x0.996 |
| blake3-servil-mt / solo / IdleManyMessages / 1 | 235.283 | 237.414 | x1.009 | level | 2 of 4 | - | - | x0.996 | x1.002 | x0.677 |
| blake3-servil-mt / solo / IdleManyMessages / 2 | 119.470 | 119.709 | x1.002 | level | 2 of 4 | - | - | x0.997 | x0.998 | x0.367 |
| blake3-servil-mt / solo / IdleManyMessages / 3 | 104.482 | 104.135 | x0.997 | level | 2 of 4 | - | - | x1.001 | x0.998 | x2.342 |
| blake3-servil-mt / solo / IdleManyMessages / 4 | 61.636 | 60.799 | x0.986 | level | 3 of 4 | - | - | x1.000 | x0.998 | x2.376 |
| blake3-servil-mt / solo / IdleManyMessages / 6 | 53.693 | 53.599 | x0.998 | level | 2 of 4 | - | - | x1.000 | x0.999 | x0.798 |
| blake3-servil-mt / solo / IdleManyMessages / 8 | 33.020 | 32.594 | x0.987 | level | 3 of 4 | - | - | x0.998 | x0.999 | x0.817 |
| blake3-servil-mt / solo / IdleManyMessages / 12 | 29.379 | 29.540 | x1.005 | level | 2 of 4 | - | - | x0.998 | x0.999 | x1.396 |
| blake3-servil-mt / solo / IdleManyMessages / 16 | 17.264 | 17.044 | x0.987 | level | 3 of 4 | - | - | x0.993 | x0.999 | x0.541 |
| blake3-servil-mt / solo / IdleManyMessages / 24 | 16.062 | 15.816 | x0.985 | level | 3 of 4 | - | - | x0.997 | x0.999 | x0.877 |
| blake3-servil-mt / solo / IdleManyMessages / 32 | 12.065 | 12.209 | x1.012 | level | 1 of 4 | - | - | x1.000 | x0.999 | x0.630 |
| blake3-servil-mt / solo / IdleManyMessages / 48 | 10.627 | 10.590 | x0.996 | level | 3 of 4 | - | - | x0.999 | x0.999 | x1.587 |
| blake3-servil-mt / solo / IdleManyMessages / 64 | 9.917 | 9.844 | x0.993 | level | 3 of 4 | - | - | x0.993 | x1.000 | x0.419 |
| blake3-servil-mt / solo / IdleManyMessages / 128 | 8.612 | 8.662 | x1.006 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.710 |
| blake3-servil-mt / solo / IdleManyMessages / 256 | 8.096 | 8.017 | x0.990 | level | 2 of 4 | - | - | x0.992 | x1.000 | x0.679 |
| blake3-servil-mt / solo / IdleManyMessages / 512 | 7.696 | 7.713 | x1.002 | level | 2 of 4 | - | - | x1.005 | x1.000 | x3.599 |
| blake3-servil-mt / solo / IdleManyMessages / 1024 | 7.552 | 7.562 | x1.001 | level | 3 of 4 | - | - | x0.995 | x1.000 | x1.195 |
| blake3-servil-mt / solo / IdleManyMessages / 2048 | 7.634 | 7.555 | x0.990 | level | 2 of 4 | - | - | x0.995 | x1.000 | x0.900 |
| blake3-servil-mt / solo / IdleManyMessages / 4096 | 7.962 | 7.667 | x0.963 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.849 |
| blake3-servil-mt / solo / IdleManyMessages / 8192 | 3.393 | 3.415 | x1.006 | level | 2 of 4 | - | - | x1.029 | x1.032 | x1.033 |
| blake3-servil-mt / solo / IdleManyMessages / 16384 | 2.968 | 3.031 | x1.021 | level | 1 of 4 | - | - | x1.010 | x1.003 | x1.028 |
| blake3-servil-mt / solo / IdleManyMessages / 32768 | 2.936 | 3.006 | x1.024 | level | 1 of 4 | - | - | x1.010 | x1.009 | x1.041 |
| blake3-servil-mt / solo / IdleManyMessages / 65536 | 2.551 | 2.566 | x1.006 | level | 1 of 4 | - | - | x1.035 | x1.015 | x1.047 |
| blake3-servil-mt / solo / IdleManyMessages / 131072 | 2.441 | 2.428 | x0.994 | level | 3 of 4 | - | - | x0.991 | x0.988 | x1.021 |
| blake3-servil-mt / solo / IdleManyMessages / 262144 | 3.192 | 3.224 | x1.010 | level | 3 of 4 | - | - | x1.007 | x0.990 | x0.986 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 B | 2.436 | 2.412 | x0.990 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.149 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 B | 1.696 | 1.695 | x0.999 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.508 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 B | 1.354 | 1.354 | x1.001 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.838 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 B | 1.167 | 1.166 | x0.999 | level | 4 of 4 | - | - | x0.999 | x1.000 | x1.402 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 KiB | 1.080 | 1.080 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.779 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1536 B | 0.811 | 0.809 | x0.998 | level | 3 of 4 | - | - | x0.998 | x0.997 | x0.916 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 KiB | 0.585 | 0.585 | x1.000 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.650 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2304 B | 0.654 | 0.650 | x0.994 | level | 4 of 4 | - | - | x0.994 | x1.000 | x0.758 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 KiB | 0.419 | 0.418 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.183 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3839 B | 0.341 | 0.341 | x0.999 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.748 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 KiB | 0.312 | 0.311 | x0.998 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.921 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4470 B | 0.384 | 0.383 | x0.998 | level | 4 of 4 | - | - | x0.998 | x1.000 | x0.865 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 7935 B | 0.194 | 0.192 | x0.994 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.689 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 KiB | 0.179 | 0.179 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x2.992 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 16 KiB | 0.100 | 0.0998 | x0.993 | level | 4 of 4 | - | - | x0.993 | x1.000 | x0.748 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 KiB | 0.0706 | 0.0702 | x0.994 | level | 4 of 4 | - | - | x0.995 | x1.000 | x0.678 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 KiB | 0.0654 | 0.0652 | x0.997 | level | 4 of 4 | - | - | x0.997 | x1.000 | x1.621 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 KiB | 0.0626 | 0.0628 | x1.003 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.234 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 KiB | 0.0623 | 0.0621 | x0.998 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.682 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 KiB | 0.0499 | 0.0486 | x0.973 | level | 3 of 4 | - | - | x0.971 | x0.997 | x1.006 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 MiB | 0.0441 | 0.0436 | x0.989 | level | 2 of 4 | - | - | x0.987 | x1.009 | x1.015 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 MiB | 0.0367 | 0.0366 | x0.995 | level | 2 of 4 | - | - | x0.996 | x1.010 | x1.014 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 MiB | 0.0327 | 0.0326 | x0.997 | level | 4 of 4 | - | - | x0.997 | x0.990 | x1.020 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 MiB | 0.0310 | 0.0309 | x0.995 | level | 3 of 4 | - | - | x1.002 | x1.004 | x1.012 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 MiB | 0.0297 | 0.0291 | x0.980 | level | 4 of 4 | - | - | x0.982 | x0.993 | x1.016 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 MiB | 0.0710 | 0.0701 | x0.987 | level | 3 of 4 | - | - | x0.988 | x1.001 | x0.998 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 MiB | 0.0755 | 0.0745 | x0.986 | level | 4 of 4 | - | - | x0.986 | x0.999 | x0.995 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 MiB | 0.0754 | 0.0743 | x0.985 | level | 4 of 4 | - | - | x0.986 | x1.002 | x0.996 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1 | 173.797 | 166.397 | x0.957 | level | 2 of 4 | - | - | x1.000 | x1.002 | x0.876 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2 | 83.553 | 83.538 | x1.000 | level | 2 of 4 | - | - | x1.000 | x0.998 | x0.438 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 3 | 72.051 | 72.227 | x1.002 | level | 1 of 4 | - | - | x1.000 | x0.999 | x0.690 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4 | 42.772 | 42.580 | x0.996 | level | 3 of 4 | - | - | x0.997 | x0.998 | x0.364 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 6 | 36.941 | 36.883 | x0.998 | level | 3 of 4 | - | - | x0.999 | x0.999 | x0.609 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8 | 22.798 | 22.660 | x0.994 | level | 3 of 4 | - | - | x0.996 | x0.999 | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 12 | 20.616 | 20.579 | x0.998 | level | 3 of 4 | - | - | x0.999 | x0.999 | x0.991 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16 | 11.915 | 11.759 | x0.987 | level | 4 of 4 | - | - | x0.992 | x0.999 | x0.697 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 24 | 11.045 | 10.932 | x0.990 | level | 3 of 4 | - | - | x0.994 | x0.999 | x0.825 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32 | 8.482 | 8.386 | x0.989 | level | 3 of 4 | - | - | x0.994 | x0.999 | x0.601 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 48 | 7.365 | 7.292 | x0.990 | level | 3 of 4 | - | - | x0.994 | x0.999 | x0.929 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 64 | 6.783 | 6.725 | x0.991 | level | 4 of 4 | - | - | x0.994 | x0.999 | x0.419 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 128 | 5.972 | 5.948 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.144 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 256 | 5.663 | 5.618 | x0.992 | level | 3 of 4 | - | - | x0.992 | x1.000 | x0.746 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 512 | 5.444 | 5.433 | x0.998 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.689 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1024 | 5.365 | 5.355 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.253 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2048 | 5.351 | 5.331 | x0.996 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.880 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4096 | 5.420 | 5.399 | x0.996 | level | 4 of 4 | - | - | x0.997 | x1.000 | x0.855 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8192 | 2.828 | 2.807 | x0.992 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.007 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16384 | 2.445 | 2.464 | x1.007 | level | 1 of 4 | - | - | x1.015 | x0.997 | x1.024 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32768 | 2.246 | 2.293 | x1.021 | level | 1 of 4 | - | - | x1.022 | x1.014 | x1.036 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 65536 | 1.858 | 1.881 | x1.012 | level | 0 of 4 | - | - | x1.013 | x0.998 | x1.031 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 131072 | 1.832 | 1.812 | x0.989 | level | 3 of 4 | - | - | x0.990 | x0.998 | x1.011 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 262144 | 2.369 | 2.341 | x0.988 | level | 3 of 4 | - | - | x0.989 | x0.982 | x0.980 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.358 | 0.366 | x1.024 | level | 2 of 4 | x1.027 | - | x1.022 | x0.977 | x1.007 |
| blake3-servil-mt / solo / ContinuousMessages / 128 B | 0.184 | 0.184 | x1.001 | level | 1 of 4 | x0.992 | - | x1.001 | x0.977 | x1.023 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.0967 | 0.0988 | x1.021 | level | 0 of 4 | x1.007 | - | x1.020 | x0.977 | x0.914 |
| blake3-servil-mt / solo / ContinuousMessages / 512 B | 0.0510 | 0.0519 | x1.017 | level | 1 of 4 | x1.045 | - | x1.012 | x0.978 | x0.957 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.0404 | 0.0403 | x0.997 | level | 2 of 4 | x1.085 | - | x0.989 | x0.984 | x1.006 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0358 | 0.0359 | x1.003 | level | 2 of 4 | x1.025 | - | x0.988 | x0.981 | x0.993 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0304 | 0.0274 | x0.901 | level | 4 of 4 | x0.962 | - | x0.894 | x0.983 | x1.003 |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.0267 | 0.0272 | x1.021 | level | 1 of 4 | x1.026 | - | x1.023 | x1.008 | x1.019 |
| blake3-servil-mt / solo / ContinuousMessages / 256 KiB | 0.0267 | 0.0267 | x1.002 | level | 2 of 4 | x1.004 | - | x1.004 | x1.004 | x1.014 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0245 | 0.0244 | x0.998 | level | 2 of 4 | x0.990 | - | x0.998 | x1.002 | x0.993 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.0252 | 0.0253 | x1.004 | level | 3 of 4 | x0.987 | - | x1.005 | x1.002 | x0.993 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0258 | 0.0256 | x0.989 | level | 2 of 4 | x0.998 | - | x0.986 | x1.002 | x0.999 |
| blake3-servil-mt / solo / ContinuousMessages / 64 MiB | 0.0314 | 0.0313 | x0.998 | level | 3 of 4 | x1.009 | - | x0.995 | x1.002 | x0.996 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 2.913 | 2.874 | x0.987 | level | 4 of 4 | x1.055 | - | x0.986 | x0.975 | x1.071 |
| blake3-servil-mt / solo / ContinuousBatches / 64 | 1.872 | 1.853 | x0.990 | level | 3 of 4 | x1.013 | - | x0.989 | x0.984 | x1.004 |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 2.184 | 1.975 | x0.904 | level | 4 of 4 | x0.944 | - | x0.899 | x0.990 | x1.000 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 1.850 | 1.875 | x1.014 | level | 2 of 4 | x0.989 | - | x1.014 | x1.005 | x0.995 |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 2.015 | 2.060 | x1.022 | level | 1 of 4 | x1.005 | - | x1.021 | x1.001 | x1.014 |
| blake3-servil-mt / solo / ContinuousBatches / 16384 | 2.153 | 2.085 | x0.968 | level | 3 of 4 | x0.980 | - | x1.003 | x1.000 | x1.020 |
| blake3-servil-mt / solo / ContinuousBatches / 65536 | 1.793 | 1.720 | x0.959 | level | 3 of 4 | x0.968 | - | x0.999 | x1.000 | x0.954 |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.747 | 0.746 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.254 |
| blake3-servil-mt / solo / LentMessages / 128 B | 0.856 | 0.857 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x2.190 |
| blake3-servil-mt / solo / LentMessages / 256 B | 0.914 | 0.914 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x0.628 |
| blake3-servil-mt / solo / LentMessages / 512 B | 0.944 | 0.945 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x1.241 |
| blake3-servil-mt / solo / LentMessages / 1 KiB | 0.962 | 0.962 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x0.943 |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.285 | 0.285 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.134 |
| blake3-servil-mt / solo / LentMessages / 16 KiB | 0.0909 | 0.0911 | x1.002 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x1.363 |
| blake3-servil-mt / solo / LentMessages / 64 KiB | 0.0651 | 0.0652 | x1.001 | level | 2 of 4 | x1.001 | - | x1.000 | x1.000 | x0.943 |
| blake3-servil-mt / solo / LentMessages / 256 KiB | 0.0620 | 0.0615 | x0.992 | level | 2 of 4 | x0.992 | - | x0.991 | x1.000 | x0.107 |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.0380 | 0.0389 | x1.024 | level | 2 of 4 | x1.024 | - | x0.993 | x0.995 | x0.996 |
| blake3-servil-mt / solo / LentMessages / 4 MiB | 0.0328 | 0.0324 | x0.989 | level | 2 of 4 | x0.997 | - | x0.998 | x0.996 | x1.020 |
| blake3-servil-mt / solo / LentMessages / 16 MiB | 0.0299 | 0.0299 | x1.003 | level | 2 of 4 | x1.004 | - | x0.999 | x0.997 | x1.010 |
| blake3-servil-mt / solo / LentMessages / 64 MiB | 0.0753 | 0.0741 | x0.985 | level | 3 of 4 | x0.994 | - | x0.983 | x0.997 | x0.995 |
| blake3-servil-mt / solo / Interleaved / 256 | 0.109 | 0.109 | x1.003 | level | 1 of 4 | x1.003 | - | x1.004 | x0.999 | x1.011 |
| blake3-servil-mt / solo / Collection / git objects | 0.0175 | 0.0172 | x0.984 | level | 3 of 4 | x0.995 | - | x0.999 | x0.989 | x0.984 |
| blake3-servil-mt / solo / Collection / Nix files | 0.0175 | 0.0171 | x0.975 | level | 4 of 4 | x0.975 | - | x1.006 | x0.997 | x0.981 |
| blake3-servil-mt / solo / LentBatches / 16 | 6.065 | 6.045 | x0.997 | level | 2 of 4 | x0.997 | - | x0.997 | x0.999 | x0.902 |
| blake3-servil-mt / solo / LentBatches / 64 | 5.309 | 5.328 | x1.003 | level | 1 of 4 | x1.003 | - | x1.004 | x0.999 | x1.923 |
| blake3-servil-mt / solo / LentBatches / 256 | 5.312 | 5.207 | x0.980 | level | 4 of 4 | x0.980 | - | x0.980 | x1.000 | x0.653 |
| blake3-servil-mt / solo / LentBatches / 1024 | 5.623 | 5.633 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.000 | x3.525 |
| blake3-servil-mt / solo / LentBatches / 4096 | 5.563 | 5.493 | x0.987 | level | 3 of 4 | x0.988 | - | x0.988 | x1.000 | x0.291 |
| blake3-servil-mt / solo / LentBatches / 16384 | 2.687 | 2.632 | x0.980 | level | 3 of 4 | x0.986 | - | x1.000 | x0.999 | x0.988 |
| blake3-servil-mt / solo / LentBatches / 65536 | 2.351 | 2.322 | x0.988 | level | 2 of 4 | x0.991 | - | x1.000 | x1.001 | x1.002 |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.0350 | 0.0365 | x1.041 | level | 2 of 4 | x1.046 | - | x1.040 | x0.993 | x0.970 |
| blake3-servil-mt / solo / ContinuousCollection / Nix files | 0.0330 | 0.0337 | x1.022 | level | 1 of 4 | x0.985 | - | x1.021 | x0.994 | x1.013 |
| blake3-servil-mt / solo / MerkleTree / 1024 | 0.100 | 0.0995 | x0.995 | level | 3 of 4 | x0.995 | - | x0.995 | x1.001 | x1.627 |
| blake3-servil-mt / solo / MerkleTree / 4096 | 0.0566 | 0.0578 | x1.022 | level | 1 of 4 | x1.014 | - | x0.999 | x1.000 | x0.979 |
| blake3-servil-mt / solo / MerkleTree / 16384 | 0.0468 | 0.0456 | x0.974 | level | 3 of 4 | x0.978 | - | x0.993 | x1.003 | x0.992 |
| blake3-servil-mt / solo / MerkleTree / 65536 | 0.0411 | 0.0410 | x0.998 | level | 2 of 4 | x0.995 | - | x1.000 | x1.002 | x0.982 |
| blake3-servil-mt / solo / MerkleTree / 262144 | 0.0901 | 0.0905 | x1.004 | level | 1 of 4 | x0.999 | - | x1.004 | x1.003 | x1.005 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 32 B | 0.0802 | 0.0792 | x0.988 | level | 2 of 4 | x0.986 | - | x1.004 | x1.001 | x1.043 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 32 B | 0.179 | 0.179 | x0.997 | level | 2 of 4 | x1.007 | - | x0.997 | x0.997 | x1.004 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 16 B | 0.271 | 0.272 | x1.004 | level | 1 of 4 | x1.012 | - | x1.002 | x0.993 | x0.842 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 48 B | 0.0596 | 0.0621 | x1.041 | level | 1 of 4 | x1.036 | - | x0.993 | x1.004 | x0.973 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 48 B | 0.149 | 0.149 | x0.997 | level | 3 of 4 | x1.010 | - | x0.999 | x0.993 | x1.004 |
| blake3-servil-mt / solo / InterleavedTurn / 256 | 0.280 | 0.280 | x1.001 | level | 2 of 4 | - | - | x0.995 | x0.985 | x0.975 |
| blake3-servil-mt / solo / InterleavedTurn / 1024 x 1 KiB | 0.157 | 0.142 | x0.907 | level | 2 of 4 | - | - | x0.905 | x0.994 | x0.933 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 256 | 0.241 | 0.233 | x0.967 | level | 3 of 4 | - | - | x0.959 | x1.009 | x1.029 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.204 | 0.182 | x0.894 | level | 3 of 4 | - | - | x0.881 | x0.994 | x1.020 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 256 | 0.207 | 0.203 | x0.978 | level | 3 of 4 | - | - | x0.985 | x1.008 | x1.004 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.153 | 0.136 | x0.887 | level | 4 of 4 | - | - | x0.884 | x0.994 | x1.012 |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.0275 | 0.0276 | x1.004 | level | 1 of 4 | x1.039 | - | x1.004 | x1.000 | x0.994 |
| blake3-servil-mt / solo / ReceivingMessage / 2 μs | 0.0922 | 0.0922 | x1.000 | level | 1 of 4 | x0.990 | - | x1.001 | x1.001 | x0.996 |
| blake3-servil-mt / solo / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 3 of 4 | x1.019 | - | x1.129 | x1.001 | x1.142 |
| blake3-servil-mt / solo / IncrementalMessage / 64 B | 8.878 | 8.683 | x0.978 | level | 2 of 4 | - | - | x0.963 | x0.997 | x0.957 |
| blake3-servil-mt / solo / IncrementalMessage / 1 KiB | 1.751 | 1.728 | x0.986 | level | 2 of 4 | - | - | x0.986 | x1.003 | x0.979 |
| blake3-servil-mt / solo / IncrementalMessage / 4 KiB | 0.570 | 0.572 | x1.004 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.003 |
| blake3-servil-mt / solo / LentIncrementalMessage / 64 B | 0.779 | 0.780 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x1.198 |
| blake3-servil-mt / solo / LentIncrementalMessage / 1 KiB | 0.989 | 0.988 | x0.999 | level | 4 of 4 | x0.999 | - | x1.000 | x1.000 | x0.649 |
| blake3-servil-mt / solo / LentIncrementalMessage / 4 KiB | 0.290 | 0.290 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x1.411 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 4.237 | 4.273 | x1.008 | level | 1 of 4 | x1.006 | - | x1.004 | x0.944 | x1.089 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 4 KiB | 0.0590 | 0.0624 | x1.057 | level | 1 of 4 | x1.125 | - | x1.046 | x0.957 | x1.019 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 1 MiB | 0.0245 | 0.0244 | x0.996 | level | 2 of 4 | x1.004 | - | x0.993 | x1.002 | x0.992 |
| blake3-servil-mt / solo / ContinuousLentMessages / 64 B | 0.294 | 0.289 | x0.983 | level | 3 of 4 | x1.085 | - | x0.981 | x0.974 | x1.109 |
| blake3-servil-mt / solo / ContinuousLentMessages / 4 KiB | 0.0212 | 0.0213 | x1.006 | level | 1 of 4 | x1.032 | - | x1.014 | x0.997 | x0.985 |
| blake3-servil-mt / solo / ContinuousLentMessages / 1 MiB | 0.00805 | 0.00791 | x0.983 | level | 3 of 4 | x0.990 | - | x0.986 | x0.986 | x0.995 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.341 | 0.344 | x1.007 | level | 1 of 4 | - | - | x1.006 | x0.977 | x0.962 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 128 B | 0.175 | 0.178 | x1.017 | level | 2 of 4 | - | - | x1.018 | x0.977 | x0.900 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.100 | 0.100 | x1.000 | level | 2 of 4 | - | - | x1.001 | x0.977 | x0.946 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 512 B | 0.0607 | 0.0619 | x1.021 | level | 2 of 4 | - | - | x1.035 | x0.978 | x0.962 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.0464 | 0.0480 | x1.035 | level | 1 of 4 | - | - | x1.046 | x0.984 | x0.964 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.0596 | 0.0565 | x0.948 | level | 3 of 4 | - | - | x1.017 | x1.028 | x0.999 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.0379 | 0.0375 | x0.989 | level | 3 of 4 | - | - | x0.990 | x0.984 | x1.019 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.0328 | 0.0332 | x1.015 | level | 1 of 4 | - | - | x1.024 | x1.008 | x1.031 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 KiB | 0.0320 | 0.0325 | x1.013 | level | 1 of 4 | - | - | x1.011 | x1.004 | x1.017 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0323 | 0.0326 | x1.009 | level | 1 of 4 | - | - | x1.013 | x0.999 | x0.995 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.0337 | 0.0337 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.002 | x0.990 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.0413 | 0.0406 | x0.984 | level | 2 of 4 | - | - | x0.983 | x1.004 | x1.003 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 MiB | 0.0492 | 0.0487 | x0.990 | level | 2 of 4 | - | - | x0.988 | x1.002 | x1.001 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 3.493 | 3.458 | x0.990 | level | 2 of 4 | - | - | x0.984 | x0.974 | x1.002 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 64 | 2.498 | 2.503 | x1.002 | level | 2 of 4 | - | - | x1.007 | x0.985 | x0.996 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 256 | 2.525 | 2.554 | x1.012 | level | 2 of 4 | - | - | x1.022 | x0.989 | x0.955 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 2.333 | 2.354 | x1.009 | level | 2 of 4 | - | - | x1.014 | x1.005 | x0.958 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 4096 | 2.739 | 2.853 | x1.041 | level | 1 of 4 | - | - | x1.004 | x1.007 | x1.006 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16384 | 2.476 | 2.484 | x1.003 | level | 1 of 4 | - | - | x1.030 | x1.001 | x1.048 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 65536 | 2.232 | 2.209 | x0.990 | level | 2 of 4 | - | - | x1.016 | x1.003 | x0.988 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.746 | 0.747 | x1.001 | level | 0 of 4 | - | - | x1.001 | x1.000 | x1.130 |
| blake3-servil-mt / shared-one-cache / LentMessages / 128 B | 0.856 | 0.857 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.992 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 B | 0.914 | 0.914 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.056 |
| blake3-servil-mt / shared-one-cache / LentMessages / 512 B | 0.944 | 0.945 | x1.002 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.026 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 KiB | 0.962 | 0.961 | x1.000 | level | 4 of 4 | - | - | x1.000 | x1.000 | x0.953 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.285 | 0.285 | x1.000 | level | 0 of 4 | - | - | x1.001 | x1.000 | x1.096 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 KiB | 0.0910 | 0.0909 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.200 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 KiB | 0.0654 | 0.0653 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.853 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 KiB | 0.0619 | 0.0615 | x0.993 | level | 4 of 4 | - | - | x0.993 | x1.000 | x1.096 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 MiB | 0.0456 | 0.0460 | x1.009 | level | 1 of 4 | - | - | x0.978 | x0.985 | x0.984 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 MiB | 0.0390 | 0.0388 | x0.995 | level | 2 of 4 | - | - | x1.017 | x1.017 | x1.132 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 MiB | 0.0717 | 0.0717 | x1.000 | level | 2 of 4 | - | - | x0.993 | x0.999 | x0.980 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 MiB | 0.130 | 0.131 | x1.007 | level | 1 of 4 | - | - | x1.006 | x1.025 | x1.005 |
| blake3-servil-mt / shared-one-cache / Interleaved / 256 | 0.109 | 0.109 | x1.001 | level | 2 of 4 | - | - | x1.001 | x0.999 | x1.003 |
| blake3-servil-mt / shared-one-cache / Collection / git objects | 0.0428 | 0.0407 | x0.952 | level | 3 of 4 | - | - | x0.903 | x0.905 | x0.909 |
| blake3-servil-mt / shared-one-cache / Collection / Nix files | 0.0366 | 0.0370 | x1.011 | level | 1 of 4 | - | - | x0.952 | x0.962 | x0.972 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16 | 6.043 | 6.077 | x1.006 | level | 0 of 4 | - | - | x1.005 | x0.997 | x1.262 |
| blake3-servil-mt / shared-one-cache / LentBatches / 64 | 5.340 | 5.326 | x0.997 | level | 3 of 4 | - | - | x0.997 | x0.999 | x1.014 |
| blake3-servil-mt / shared-one-cache / LentBatches / 256 | 5.264 | 5.227 | x0.993 | level | 4 of 4 | - | - | x0.993 | x1.000 | x1.016 |
| blake3-servil-mt / shared-one-cache / LentBatches / 1024 | 5.624 | 5.625 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.731 |
| blake3-servil-mt / shared-one-cache / LentBatches / 4096 | 5.483 | 5.469 | x0.997 | level | 4 of 4 | - | - | x0.998 | x1.000 | x0.931 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16384 | 3.173 | 3.027 | x0.954 | level | 3 of 4 | - | - | x0.994 | x0.988 | x0.989 |
| blake3-servil-mt / shared-one-cache / LentBatches / 65536 | 2.566 | 2.666 | x1.039 | level | 1 of 4 | - | - | x1.007 | x0.999 | x1.104 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.0523 | 0.0510 | x0.975 | level | 3 of 4 | - | - | x0.989 | x0.993 | x0.999 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / Nix files | 0.0506 | 0.0506 | x0.999 | level | 2 of 4 | - | - | x0.997 | x0.992 | x1.003 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1024 | 0.0996 | 0.0999 | x1.003 | level | 0 of 4 | - | - | x1.003 | x1.001 | x0.931 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 4096 | 0.0624 | 0.0616 | x0.987 | level | 1 of 4 | - | - | x1.000 | x1.003 | x0.985 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 16384 | 0.0499 | 0.0497 | x0.997 | level | 2 of 4 | - | - | x1.009 | x1.029 | x1.015 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 | 0.119 | 0.119 | x0.997 | level | 2 of 4 | - | - | x1.004 | x1.011 | x1.003 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 262144 | 0.182 | 0.182 | x1.001 | level | 3 of 4 | - | - | x1.003 | x0.991 | x0.995 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 32 B | 0.0910 | 0.0917 | x1.007 | level | 1 of 4 | - | - | x1.010 | x1.002 | x1.143 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 32 B | 0.344 | 0.347 | x1.009 | level | 1 of 4 | - | - | x0.979 | x1.026 | x0.999 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 16 B | 0.540 | 0.542 | x1.004 | level | 2 of 4 | - | - | x0.998 | x1.008 | x1.006 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 48 B | 0.0684 | 0.0662 | x0.968 | level | 2 of 4 | - | - | x1.016 | x1.005 | x1.164 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 48 B | 0.275 | 0.276 | x1.003 | level | 1 of 4 | - | - | x1.012 | x0.991 | x0.994 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.0424 | 0.0425 | x1.003 | level | 2 of 4 | - | - | x0.997 | x0.997 | x1.006 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 2 μs | 0.0923 | 0.0923 | x1.000 | level | 1 of 4 | - | - | x1.010 | x1.009 | x0.992 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 1 of 4 | - | - | x1.025 | x1.008 | x1.076 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 64 B | 0.780 | 0.780 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.031 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 1 KiB | 0.988 | 0.988 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.188 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 4 KiB | 0.290 | 0.290 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.117 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 4.252 | 4.100 | x0.964 | level | 2 of 4 | - | - | x0.982 | x0.944 | x1.063 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 4 KiB | 0.0659 | 0.0738 | x1.120 | level | 1 of 4 | - | - | x0.980 | x0.964 | x1.008 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 1 MiB | 0.0323 | 0.0324 | x1.005 | level | 2 of 4 | - | - | x1.013 | x1.002 | x0.997 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 64 B | 0.288 | 0.290 | x1.005 | level | 3 of 4 | - | - | x1.008 | x0.974 | x0.982 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 4 KiB | 0.0402 | 0.0391 | x0.972 | level | 3 of 4 | - | - | x0.973 | x0.970 | x0.989 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 1 MiB | 0.0148 | 0.0159 | x1.071 | level | 1 of 4 | - | - | x1.089 | x1.085 | x1.114 |

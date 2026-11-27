# Nightly drift check: e1966b498bc7 -> 17ccf2c8f5bb

- Host: electric-rhino
- Experiment: `bench=3f119a507807078649d8700112994fce24666868|base=e1966b498bc769db3d51451a4ddc8188a19ed593|target=17ccf2c8f5bb689ec552be1c976b54311da0c29f|cells=all|layouts=default`
- bench-hashes: `3f119a507807078649d8700112994fce24666868`
- BLAKE3-Servil base: `e1966b498bc769db3d51451a4ddc8188a19ed593`
- BLAKE3-Servil target: `17ccf2c8f5bb689ec552be1c976b54311da0c29f`
- Scope: `--cells all` (layouts: default)
- Deciding stage: stage 2 (kept-drift/second)
- Verdict: **REGRESSION** (exit `1`)

## Stage 2 (deciding, kept-drift/second)

compare: old side: bench 3f119a507807 clean; servil e1966b498bc7 clean
compare: new side: bench 3f119a507807 clean; servil 17ccf2c8f5bb clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 8 KiB | 0.531 | 0.532 | x1.004 | level | 29 of 64 | - | - | x1.004 | x1.001 | x0.996 |
| blake3-servil-st / solo / ManyMessages / 64 | 31.440 | 30.497 | x0.970 | level | 35 of 64 | - | - | x0.982 | x1.000 | x0.992 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1 | 198.100 | 201.456 | x1.017 | level | 7 of 64 | - | - | x1.007 | x1.008 | - |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.942 | 0.946 | x1.004 | level | 6 of 64 | x1.005 | - | x1.006 | x1.012 | x0.980 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 0.952 | 0.955 | x1.003 | level | 9 of 64 | x1.003 | - | x1.003 | x1.013 | x0.866 |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 0.909 | 0.913 | x1.005 | level | 2 of 64 | x1.005 | - | x1.004 | x1.015 | x1.035 |
| blake3-servil-mt / solo / MerkleTree / 16384 | 0.0617 | 0.0672 | x1.089 | slower | 22 of 64 | x1.219 | - | x1.090 | x0.988 | x1.036 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 4 KiB | 0.0815 | 0.0705 | x0.865 | faster | 54 of 64 | x0.867 | - | x0.868 | x1.002 | x1.028 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 16384 | 0.105 | 0.103 | x0.981 | level | 43 of 64 | - | - | x0.981 | x1.003 | x0.989 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 4 KiB | 0.241 | 0.240 | x0.999 | level | 39 of 64 | - | - | x1.012 | x0.995 | x1.007 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 16384 | 0.0828 | 0.0826 | x0.997 | level | 32 of 64 | - | - | x0.997 | x0.999 | x1.004 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 4 KiB | 0.281 | 0.280 | x0.998 | level | 35 of 64 | - | - | x0.999 | x1.000 | x1.008 |

## Stage 1 (initial screen, kept-drift)

compare: old side: bench 3f119a507807 clean; servil e1966b498bc7 clean
compare: new side: bench 3f119a507807 clean; servil 17ccf2c8f5bb clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 5.192 | 5.207 | x1.003 | level | 1 of 4 | - | - | x1.023 | x1.005 | x0.950 |
| blake3-servil-st / solo / OneMessage / 128 B | 3.505 | 3.353 | x0.957 | level | 3 of 4 | - | - | x0.969 | x1.005 | x0.940 |
| blake3-servil-st / solo / OneMessage / 256 B | 2.423 | 2.415 | x0.997 | level | 2 of 4 | - | - | x0.999 | x1.004 | x0.975 |
| blake3-servil-st / solo / OneMessage / 512 B | 1.865 | 1.859 | x0.996 | level | 2 of 4 | - | - | x0.995 | x1.001 | x0.978 |
| blake3-servil-st / solo / OneMessage / 1 KiB | 1.642 | 1.646 | x1.002 | level | 2 of 4 | - | - | x0.997 | x1.002 | x0.986 |
| blake3-servil-st / solo / OneMessage / 1536 B | 1.499 | 1.540 | x1.028 | level | 2 of 4 | - | - | x1.021 | x1.000 | x0.936 |
| blake3-servil-st / solo / OneMessage / 2 KiB | 1.060 | 1.021 | x0.963 | level | 3 of 4 | - | - | x0.984 | x1.004 | x0.955 |
| blake3-servil-st / solo / OneMessage / 2304 B | 1.176 | 1.199 | x1.019 | level | 1 of 4 | - | - | x1.015 | x1.003 | x1.015 |
| blake3-servil-st / solo / OneMessage / 3 KiB | 0.809 | 0.848 | x1.049 | level | 0 of 4 | - | - | x1.046 | x1.003 | x1.010 |
| blake3-servil-st / solo / OneMessage / 3839 B | 0.802 | 0.870 | x1.085 | level | 0 of 4 | - | - | x1.074 | x1.003 | x1.004 |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.554 | 0.588 | x1.061 | level | 0 of 4 | - | - | x1.052 | x1.002 | x0.997 |
| blake3-servil-st / solo / OneMessage / 4470 B | 0.673 | 0.694 | x1.031 | level | 1 of 4 | - | - | x1.024 | x1.003 | x0.996 |
| blake3-servil-st / solo / OneMessage / 7935 B | 0.587 | 0.601 | x1.025 | level | 1 of 4 | - | - | x1.024 | x1.001 | x1.021 |
| blake3-servil-st / solo / OneMessage / 8 KiB | 0.425 | 0.454 | x1.069 | level | 0 of 4 | - | - | x1.042 | x1.001 | x0.998 |
| blake3-servil-st / solo / OneMessage / 16 KiB | 0.300 | 0.306 | x1.020 | level | 2 of 4 | - | - | x1.028 | x1.001 | x1.020 |
| blake3-servil-st / solo / OneMessage / 32 KiB | 0.197 | 0.200 | x1.014 | level | 2 of 4 | - | - | x1.012 | x1.001 | x1.038 |
| blake3-servil-st / solo / OneMessage / 64 KiB | 0.149 | 0.147 | x0.985 | level | 3 of 4 | - | - | x0.984 | x1.000 | x0.992 |
| blake3-servil-st / solo / OneMessage / 128 KiB | 0.124 | 0.124 | x0.998 | level | 3 of 4 | - | - | x1.002 | x1.000 | x0.998 |
| blake3-servil-st / solo / OneMessage / 256 KiB | 0.114 | 0.113 | x0.987 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.985 |
| blake3-servil-st / solo / OneMessage / 512 KiB | 0.102 | 0.103 | x1.002 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.019 |
| blake3-servil-st / solo / OneMessage / 1 MiB | 0.0975 | 0.0977 | x1.002 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.036 |
| blake3-servil-st / solo / OneMessage / 2 MiB | 0.0979 | 0.0978 | x0.999 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.014 |
| blake3-servil-st / solo / OneMessage / 3 MiB | 0.0995 | 0.0993 | x0.998 | level | 4 of 4 | - | - | x0.999 | x1.000 | x0.983 |
| blake3-servil-st / solo / OneMessage / 4 MiB | 0.0985 | 0.0982 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.964 |
| blake3-servil-st / solo / OneMessage / 8 MiB | 0.105 | 0.105 | x0.997 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.994 |
| blake3-servil-st / solo / OneMessage / 32 MiB | 0.115 | 0.113 | x0.980 | level | 4 of 4 | - | - | x0.980 | x1.000 | x0.956 |
| blake3-servil-st / solo / OneMessage / 64 MiB | 0.115 | 0.113 | x0.981 | level | 4 of 4 | - | - | x0.980 | x1.000 | x0.987 |
| blake3-servil-st / solo / OneMessage / 128 MiB | 0.115 | 0.113 | x0.981 | level | 4 of 4 | - | - | x0.981 | x1.000 | x0.989 |
| blake3-servil-st / solo / ManyMessages / 1 | 460.489 | 481.460 | x1.046 | level | 1 of 4 | - | - | x1.037 | x1.011 | x1.034 |
| blake3-servil-st / solo / ManyMessages / 2 | 244.162 | 252.275 | x1.033 | level | 2 of 4 | - | - | x0.986 | x1.005 | x0.955 |
| blake3-servil-st / solo / ManyMessages / 3 | 195.735 | 204.404 | x1.044 | level | 1 of 4 | - | - | x1.019 | x1.006 | x0.948 |
| blake3-servil-st / solo / ManyMessages / 4 | 126.753 | 141.134 | x1.113 | level | 0 of 4 | - | - | x1.049 | x1.008 | x0.956 |
| blake3-servil-st / solo / ManyMessages / 6 | 104.996 | 115.535 | x1.100 | level | 0 of 4 | - | - | x1.056 | x1.003 | x0.999 |
| blake3-servil-st / solo / ManyMessages / 8 | 156.443 | 163.864 | x1.047 | level | 2 of 4 | - | - | x1.045 | x1.008 | x1.000 |
| blake3-servil-st / solo / ManyMessages / 12 | 118.080 | 118.285 | x1.002 | level | 2 of 4 | - | - | x1.011 | x1.004 | x0.986 |
| blake3-servil-st / solo / ManyMessages / 16 | 98.339 | 102.540 | x1.043 | level | 1 of 4 | - | - | x1.034 | x0.999 | x0.984 |
| blake3-servil-st / solo / ManyMessages / 24 | 99.822 | 102.605 | x1.028 | level | 1 of 4 | - | - | x1.055 | x1.001 | x0.998 |
| blake3-servil-st / solo / ManyMessages / 32 | 44.800 | 49.398 | x1.103 | level | 0 of 4 | - | - | x1.105 | x0.998 | x1.007 |
| blake3-servil-st / solo / ManyMessages / 48 | 31.950 | 36.301 | x1.136 | level | 0 of 4 | - | - | x1.143 | x0.996 | x1.005 |
| blake3-servil-st / solo / ManyMessages / 64 | 26.192 | 29.209 | x1.115 | level | 0 of 4 | - | - | x1.117 | x1.001 | x0.999 |
| blake3-servil-st / solo / ManyMessages / 128 | 17.668 | 19.454 | x1.101 | level | 0 of 4 | - | - | x1.106 | x1.001 | x1.001 |
| blake3-servil-st / solo / ManyMessages / 256 | 13.309 | 13.830 | x1.039 | level | 2 of 4 | - | - | x1.040 | x0.999 | x1.024 |
| blake3-servil-st / solo / ManyMessages / 512 | 11.003 | 11.214 | x1.019 | level | 1 of 4 | - | - | x1.012 | x1.000 | x1.064 |
| blake3-servil-st / solo / ManyMessages / 1024 | 9.678 | 9.640 | x0.996 | level | 3 of 4 | - | - | x0.994 | x1.000 | x1.000 |
| blake3-servil-st / solo / ManyMessages / 2048 | 9.070 | 9.005 | x0.993 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.926 |
| blake3-servil-st / solo / ManyMessages / 4096 | 8.791 | 8.690 | x0.989 | level | 3 of 4 | - | - | x0.989 | x1.000 | x0.966 |
| blake3-servil-st / solo / ManyMessages / 8192 | 8.216 | 8.250 | x1.004 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.992 |
| blake3-servil-st / solo / ManyMessages / 16384 | 7.853 | 7.877 | x1.003 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.980 |
| blake3-servil-st / solo / ManyMessages / 32768 | 7.863 | 7.876 | x1.002 | level | 3 of 4 | - | - | x1.002 | x1.000 | x1.038 |
| blake3-servil-st / solo / ManyMessages / 65536 | 7.958 | 8.018 | x1.008 | level | 2 of 4 | - | - | x1.009 | x1.000 | x1.015 |
| blake3-servil-st / solo / ManyMessages / 131072 | 8.327 | 8.376 | x1.006 | level | 2 of 4 | - | - | x1.006 | x1.000 | x0.992 |
| blake3-servil-st / solo / ManyMessages / 262144 | 8.742 | 8.749 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.992 |
| blake3-servil-st / solo / ManyLongMessages / 4 | 1813.712 | 1839.710 | x1.014 | level | 2 of 4 | - | - | x1.012 | x1.001 | x1.012 |
| blake3-servil-st / solo / ManyLongMessages / 16 | 1638.011 | 660.875 | x0.403 | faster | 4 of 4 | - | - | x0.408 | x0.575 | x1.329 |
| blake3-servil-st / solo / ManyLongMessages / 64 | 573.369 | 558.804 | x0.975 | level | 4 of 4 | - | - | x0.974 | x0.998 | x1.022 |
| blake3-servil-st / solo / ManyLongMessages / 256 | 519.886 | 517.782 | x0.996 | level | 4 of 4 | - | - | x0.996 | x0.998 | x1.007 |
| blake3-servil-st / solo / IdleOneMessage / 64 B | 3.004 | 3.025 | x1.007 | level | 1 of 4 | - | - | x1.004 | x1.005 | x0.900 |
| blake3-servil-st / solo / IdleOneMessage / 128 B | 2.136 | 2.124 | x0.995 | level | 3 of 4 | - | - | x1.006 | x1.004 | x1.125 |
| blake3-servil-st / solo / IdleOneMessage / 256 B | 1.759 | 1.760 | x1.001 | level | 2 of 4 | - | - | x1.002 | x1.003 | x2.432 |
| blake3-servil-st / solo / IdleOneMessage / 512 B | 1.614 | 1.636 | x1.014 | level | 1 of 4 | - | - | x1.003 | x1.002 | x0.753 |
| blake3-servil-st / solo / IdleOneMessage / 1 KiB | 1.524 | 1.533 | x1.006 | level | 1 of 4 | - | - | x1.000 | x1.001 | x1.011 |
| blake3-servil-st / solo / IdleOneMessage / 1536 B | 1.182 | 1.185 | x1.002 | level | 2 of 4 | - | - | x0.997 | x0.997 | x0.671 |
| blake3-servil-st / solo / IdleOneMessage / 2 KiB | 0.855 | 0.857 | x1.002 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.861 |
| blake3-servil-st / solo / IdleOneMessage / 2304 B | 0.963 | 0.961 | x0.998 | level | 3 of 4 | - | - | x0.999 | x1.001 | x1.463 |
| blake3-servil-st / solo / IdleOneMessage / 3 KiB | 0.622 | 0.623 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x2.910 |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 0.510 | 0.511 | x1.002 | level | 1 of 4 | - | - | x1.004 | x1.000 | x0.840 |
| blake3-servil-st / solo / IdleOneMessage / 4 KiB | 0.468 | 0.467 | x0.998 | level | 2 of 4 | - | - | x0.999 | x1.000 | x3.013 |
| blake3-servil-st / solo / IdleOneMessage / 4470 B | 0.584 | 0.577 | x0.988 | level | 3 of 4 | - | - | x0.998 | x1.001 | x1.252 |
| blake3-servil-st / solo / IdleOneMessage / 7935 B | 0.293 | 0.294 | x1.003 | level | 2 of 4 | - | - | x1.006 | x1.000 | x3.663 |
| blake3-servil-st / solo / IdleOneMessage / 8 KiB | 0.272 | 0.273 | x1.004 | level | 1 of 4 | - | - | x0.998 | x1.000 | x0.273 |
| blake3-servil-st / solo / IdleOneMessage / 16 KiB | 0.152 | 0.154 | x1.016 | level | 1 of 4 | - | - | x1.007 | x1.000 | x2.237 |
| blake3-servil-st / solo / IdleOneMessage / 32 KiB | 0.106 | 0.107 | x1.009 | level | 1 of 4 | - | - | x0.999 | x1.000 | x0.800 |
| blake3-servil-st / solo / IdleOneMessage / 64 KiB | 0.0976 | 0.0978 | x1.002 | level | 2 of 4 | - | - | x0.994 | x1.000 | x0.448 |
| blake3-servil-st / solo / IdleOneMessage / 128 KiB | 0.0925 | 0.0938 | x1.013 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.280 |
| blake3-servil-st / solo / IdleOneMessage / 256 KiB | 0.0913 | 0.0914 | x1.001 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.835 |
| blake3-servil-st / solo / IdleOneMessage / 512 KiB | 0.0964 | 0.0962 | x0.999 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.010 |
| blake3-servil-st / solo / IdleOneMessage / 1 MiB | 0.0943 | 0.0946 | x1.003 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.985 |
| blake3-servil-st / solo / IdleOneMessage / 2 MiB | 0.0882 | 0.0880 | x0.997 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.949 |
| blake3-servil-st / solo / IdleOneMessage / 3 MiB | 0.0873 | 0.0871 | x0.998 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.960 |
| blake3-servil-st / solo / IdleOneMessage / 4 MiB | 0.0873 | 0.0870 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.978 |
| blake3-servil-st / solo / IdleOneMessage / 8 MiB | 0.0882 | 0.0880 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.994 |
| blake3-servil-st / solo / IdleOneMessage / 32 MiB | 0.114 | 0.112 | x0.981 | level | 3 of 4 | - | - | x0.981 | x1.000 | x0.960 |
| blake3-servil-st / solo / IdleOneMessage / 64 MiB | 0.115 | 0.113 | x0.981 | level | 4 of 4 | - | - | x0.981 | x1.000 | x0.990 |
| blake3-servil-st / solo / IdleOneMessage / 128 MiB | 0.115 | 0.113 | x0.982 | level | 4 of 4 | - | - | x0.982 | x1.000 | x0.982 |
| blake3-servil-st / solo / IdleManyMessages / 1 | 210.167 | 208.552 | x0.992 | level | 1 of 4 | - | - | x1.010 | x1.007 | x1.202 |
| blake3-servil-st / solo / IdleManyMessages / 2 | 104.578 | 105.110 | x1.005 | level | 1 of 4 | - | - | x1.006 | x0.998 | x1.551 |
| blake3-servil-st / solo / IdleManyMessages / 3 | 91.528 | 91.145 | x0.996 | level | 2 of 4 | - | - | x0.998 | x0.998 | x0.641 |
| blake3-servil-st / solo / IdleManyMessages / 4 | 53.667 | 55.144 | x1.028 | level | 0 of 4 | - | - | x1.010 | x0.997 | x1.560 |
| blake3-servil-st / solo / IdleManyMessages / 6 | 50.579 | 50.582 | x1.000 | level | 1 of 4 | - | - | x1.003 | x0.998 | x1.437 |
| blake3-servil-st / solo / IdleManyMessages / 8 | 33.469 | 34.032 | x1.017 | level | 1 of 4 | - | - | x1.006 | x0.998 | x1.443 |
| blake3-servil-st / solo / IdleManyMessages / 12 | 31.657 | 31.830 | x1.005 | level | 2 of 4 | - | - | x1.011 | x0.999 | x0.642 |
| blake3-servil-st / solo / IdleManyMessages / 16 | 18.198 | 18.515 | x1.017 | level | 2 of 4 | - | - | x1.002 | x0.998 | x0.663 |
| blake3-servil-st / solo / IdleManyMessages / 24 | 17.177 | 17.335 | x1.009 | level | 1 of 4 | - | - | x0.997 | x0.999 | x0.381 |
| blake3-servil-st / solo / IdleManyMessages / 32 | 13.119 | 12.973 | x0.989 | level | 3 of 4 | - | - | x0.997 | x0.999 | x0.356 |
| blake3-servil-st / solo / IdleManyMessages / 48 | 11.265 | 11.341 | x1.007 | level | 2 of 4 | - | - | x0.999 | x0.999 | x0.537 |
| blake3-servil-st / solo / IdleManyMessages / 64 | 10.341 | 10.470 | x1.012 | level | 2 of 4 | - | - | x1.008 | x0.999 | x2.523 |
| blake3-servil-st / solo / IdleManyMessages / 128 | 9.227 | 9.298 | x1.008 | level | 1 of 4 | - | - | x1.003 | x0.999 | x1.160 |
| blake3-servil-st / solo / IdleManyMessages / 256 | 8.646 | 8.668 | x1.002 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.690 |
| blake3-servil-st / solo / IdleManyMessages / 512 | 8.277 | 8.426 | x1.018 | level | 1 of 4 | - | - | x0.999 | x1.000 | x0.408 |
| blake3-servil-st / solo / IdleManyMessages / 1024 | 8.138 | 8.144 | x1.001 | level | 1 of 4 | - | - | x0.993 | x1.000 | x0.543 |
| blake3-servil-st / solo / IdleManyMessages / 2048 | 8.025 | 8.052 | x1.003 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.979 |
| blake3-servil-st / solo / IdleManyMessages / 4096 | 7.961 | 8.037 | x1.010 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.028 |
| blake3-servil-st / solo / IdleManyMessages / 8192 | 8.167 | 8.221 | x1.007 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.924 |
| blake3-servil-st / solo / IdleManyMessages / 16384 | 7.894 | 7.890 | x1.000 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.929 |
| blake3-servil-st / solo / IdleManyMessages / 32768 | 7.520 | 7.529 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.948 |
| blake3-servil-st / solo / IdleManyMessages / 65536 | 7.457 | 7.458 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.952 |
| blake3-servil-st / solo / IdleManyMessages / 131072 | 7.472 | 7.450 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.937 |
| blake3-servil-st / solo / IdleManyMessages / 262144 | 8.070 | 8.034 | x0.996 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.021 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 B | 3.020 | 3.027 | x1.002 | level | 1 of 4 | - | - | x1.001 | x1.005 | x0.903 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 B | 2.112 | 2.133 | x1.010 | level | 2 of 4 | - | - | x1.005 | x1.004 | x1.028 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 B | 1.685 | 1.694 | x1.005 | level | 1 of 4 | - | - | x1.003 | x1.003 | x1.004 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 B | 1.457 | 1.473 | x1.011 | level | 1 of 4 | - | - | x1.002 | x1.002 | x0.925 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 KiB | 1.347 | 1.350 | x1.002 | level | 0 of 4 | - | - | x1.000 | x1.000 | x1.802 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1536 B | 1.018 | 1.013 | x0.995 | level | 3 of 4 | - | - | x0.999 | x0.997 | x1.101 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 KiB | 0.731 | 0.729 | x0.998 | level | 4 of 4 | - | - | x0.997 | x1.000 | x0.695 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2304 B | 0.816 | 0.814 | x0.997 | level | 3 of 4 | - | - | x0.994 | x1.001 | x0.427 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.528 | 0.523 | x0.991 | level | 4 of 4 | - | - | x0.998 | x1.000 | x1.267 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3839 B | 0.426 | 0.428 | x1.003 | level | 2 of 4 | - | - | x1.002 | x1.000 | x3.750 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 KiB | 0.390 | 0.391 | x1.001 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.858 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4470 B | 0.484 | 0.486 | x1.005 | level | 1 of 4 | - | - | x1.001 | x1.001 | x1.424 |
| blake3-servil-st / solo / BriefIdleOneMessage / 7935 B | 0.241 | 0.241 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.000 | x2.067 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 KiB | 0.223 | 0.226 | x1.010 | level | 0 of 4 | - | - | x1.007 | x1.000 | x1.465 |
| blake3-servil-st / solo / BriefIdleOneMessage / 16 KiB | 0.125 | 0.126 | x1.007 | level | 0 of 4 | - | - | x1.007 | x1.000 | x1.882 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 KiB | 0.0895 | 0.0890 | x0.994 | level | 1 of 4 | - | - | x0.999 | x1.000 | x1.063 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 KiB | 0.0812 | 0.0808 | x0.995 | level | 4 of 4 | - | - | x0.995 | x1.000 | x0.586 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 KiB | 0.0779 | 0.0778 | x0.999 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.210 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 KiB | 0.0777 | 0.0776 | x0.998 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.675 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 KiB | 0.0840 | 0.0837 | x0.996 | level | 4 of 4 | - | - | x0.997 | x1.000 | x1.001 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 MiB | 0.0873 | 0.0869 | x0.995 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.903 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 MiB | 0.0877 | 0.0876 | x0.998 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.943 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 MiB | 0.0875 | 0.0873 | x0.998 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.932 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 MiB | 0.0876 | 0.0872 | x0.995 | level | 4 of 4 | - | - | x0.995 | x1.000 | x0.923 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 MiB | 0.0883 | 0.0879 | x0.996 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.955 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 MiB | 0.114 | 0.112 | x0.977 | level | 4 of 4 | - | - | x0.977 | x1.000 | x0.978 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 MiB | 0.115 | 0.113 | x0.983 | level | 3 of 4 | - | - | x0.979 | x1.000 | x0.985 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 MiB | 0.115 | 0.113 | x0.982 | level | 4 of 4 | - | - | x0.982 | x1.000 | x0.985 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1 | 204.238 | 206.033 | x1.009 | level | 2 of 4 | - | - | x1.010 | x1.008 | x0.739 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2 | 105.332 | 106.060 | x1.007 | level | 2 of 4 | - | - | x1.004 | x0.998 | x0.919 |
| blake3-servil-st / solo / BriefIdleManyMessages / 3 | 90.459 | 90.415 | x1.000 | level | 2 of 4 | - | - | x1.002 | x0.998 | x1.010 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4 | 52.591 | 54.008 | x1.027 | level | 1 of 4 | - | - | x1.008 | x0.997 | x1.271 |
| blake3-servil-st / solo / BriefIdleManyMessages / 6 | 45.744 | 47.110 | x1.030 | level | 0 of 4 | - | - | x1.006 | x0.998 | x1.094 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8 | 28.167 | 28.465 | x1.011 | level | 2 of 4 | - | - | x1.006 | x0.998 | x1.691 |
| blake3-servil-st / solo / BriefIdleManyMessages / 12 | 25.760 | 25.737 | x0.999 | level | 2 of 4 | - | - | x1.002 | x0.999 | x1.638 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16 | 14.683 | 14.767 | x1.006 | level | 2 of 4 | - | - | x1.005 | x0.998 | x0.723 |
| blake3-servil-st / solo / BriefIdleManyMessages / 24 | 13.875 | 13.780 | x0.993 | level | 3 of 4 | - | - | x1.006 | x0.999 | x0.789 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32 | 10.498 | 10.583 | x1.008 | level | 1 of 4 | - | - | x1.007 | x0.999 | x1.193 |
| blake3-servil-st / solo / BriefIdleManyMessages / 48 | 9.137 | 9.195 | x1.006 | level | 2 of 4 | - | - | x1.004 | x0.999 | x0.581 |
| blake3-servil-st / solo / BriefIdleManyMessages / 64 | 8.429 | 8.474 | x1.005 | level | 1 of 4 | - | - | x1.007 | x0.999 | x0.797 |
| blake3-servil-st / solo / BriefIdleManyMessages / 128 | 7.400 | 7.432 | x1.004 | level | 1 of 4 | - | - | x1.003 | x0.999 | x1.238 |
| blake3-servil-st / solo / BriefIdleManyMessages / 256 | 7.030 | 7.150 | x1.017 | level | 0 of 4 | - | - | x1.005 | x1.000 | x1.042 |
| blake3-servil-st / solo / BriefIdleManyMessages / 512 | 6.805 | 6.807 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.760 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1024 | 6.722 | 6.700 | x0.997 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.555 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2048 | 6.664 | 6.669 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.021 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4096 | 6.818 | 6.818 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.994 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8192 | 7.217 | 7.278 | x1.008 | level | 0 of 4 | - | - | x1.006 | x1.000 | x0.965 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16384 | 7.447 | 7.446 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.959 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32768 | 7.505 | 7.514 | x1.001 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.995 |
| blake3-servil-st / solo / BriefIdleManyMessages / 65536 | 7.459 | 7.474 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.003 |
| blake3-servil-st / solo / BriefIdleManyMessages / 131072 | 7.461 | 7.454 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.980 |
| blake3-servil-st / solo / BriefIdleManyMessages / 262144 | 8.050 | 8.016 | x0.996 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.026 |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.940 | 0.946 | x1.007 | level | 0 of 4 | x1.007 | - | x1.006 | x1.012 | x1.003 |
| blake3-servil-st / solo / ContinuousMessages / 128 B | 1.079 | 1.080 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.007 | x0.769 |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 1.153 | 1.154 | x1.000 | level | 1 of 4 | x1.001 | - | x1.002 | x1.004 | x0.559 |
| blake3-servil-st / solo / ContinuousMessages / 512 B | 1.188 | 1.189 | x1.001 | level | 2 of 4 | x1.001 | - | x1.000 | x1.002 | x0.564 |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 1.213 | 1.213 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.001 | x0.763 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.358 | 0.357 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.001 | x0.149 |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.114 | 0.114 | x1.000 | level | 1 of 4 | x1.000 | - | x0.999 | x1.000 | x3.227 |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.0810 | 0.0809 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x1.275 |
| blake3-servil-st / solo / ContinuousMessages / 256 KiB | 0.0828 | 0.0828 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x1.046 |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.0841 | 0.0848 | x1.008 | level | 1 of 4 | x1.008 | - | x1.008 | x1.000 | x1.045 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.0854 | 0.0855 | x1.001 | level | 1 of 4 | x1.001 | - | x1.002 | x1.000 | x0.999 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.0854 | 0.0855 | x1.001 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x0.904 |
| blake3-servil-st / solo / ContinuousMessages / 64 MiB | 0.0975 | 0.0975 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x0.992 |
| blake3-servil-st / solo / ContinuousBatches / 16 | 7.549 | 7.558 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x0.998 | x0.473 |
| blake3-servil-st / solo / ContinuousBatches / 64 | 6.653 | 6.638 | x0.998 | level | 2 of 4 | x0.998 | - | x0.997 | x0.999 | x0.800 |
| blake3-servil-st / solo / ContinuousBatches / 256 | 6.611 | 6.604 | x0.999 | level | 2 of 4 | x0.999 | - | x0.998 | x1.000 | x14.211 |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 7.054 | 7.058 | x1.001 | level | 2 of 4 | x1.000 | - | x0.999 | x1.000 | x44.932 |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 6.872 | 6.874 | x1.000 | level | 3 of 4 | x1.000 | - | x1.001 | x1.000 | x0.885 |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 7.649 | 7.639 | x0.999 | level | 3 of 4 | x0.998 | - | x0.997 | x1.000 | x0.828 |
| blake3-servil-st / solo / ContinuousBatches / 65536 | 7.662 | 7.703 | x1.005 | level | 1 of 4 | x1.005 | - | x1.005 | x1.000 | x1.104 |
| blake3-servil-st / solo / LentMessages / 64 B | 0.940 | 0.946 | x1.007 | level | 0 of 4 | x1.007 | - | x1.006 | x1.012 | x1.003 |
| blake3-servil-st / solo / LentMessages / 128 B | 1.079 | 1.080 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.007 | x0.769 |
| blake3-servil-st / solo / LentMessages / 256 B | 1.153 | 1.154 | x1.000 | level | 1 of 4 | x1.001 | - | x1.002 | x1.004 | x0.559 |
| blake3-servil-st / solo / LentMessages / 512 B | 1.188 | 1.189 | x1.001 | level | 2 of 4 | x1.001 | - | x1.000 | x1.002 | x0.564 |
| blake3-servil-st / solo / LentMessages / 1 KiB | 1.213 | 1.213 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.001 | x0.763 |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.358 | 0.357 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.001 | x0.149 |
| blake3-servil-st / solo / LentMessages / 16 KiB | 0.114 | 0.114 | x1.000 | level | 1 of 4 | x1.000 | - | x0.999 | x1.000 | x3.227 |
| blake3-servil-st / solo / LentMessages / 64 KiB | 0.0810 | 0.0809 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x1.275 |
| blake3-servil-st / solo / LentMessages / 256 KiB | 0.0758 | 0.0760 | x1.003 | level | 2 of 4 | x1.003 | - | x1.003 | x1.000 | x0.561 |
| blake3-servil-st / solo / LentMessages / 1 MiB | 0.0860 | 0.0860 | x1.000 | level | 2 of 4 | x1.000 | - | x0.998 | x1.000 | x0.941 |
| blake3-servil-st / solo / LentMessages / 4 MiB | 0.0861 | 0.0862 | x1.001 | level | 1 of 4 | x1.001 | - | x1.002 | x1.000 | x0.955 |
| blake3-servil-st / solo / LentMessages / 16 MiB | 0.0912 | 0.0920 | x1.008 | level | 0 of 4 | x1.009 | - | x1.008 | x1.000 | x0.980 |
| blake3-servil-st / solo / LentMessages / 64 MiB | 0.116 | 0.116 | x0.996 | level | 2 of 4 | x0.996 | - | x0.996 | x1.000 | x1.009 |
| blake3-servil-st / solo / Interleaved / 256 | 0.137 | 0.137 | x0.996 | level | 4 of 4 | x0.997 | - | x0.998 | x0.998 | x0.973 |
| blake3-servil-st / solo / Collection / git objects | 0.0982 | 0.0979 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x0.999 | x0.996 |
| blake3-servil-st / solo / Collection / Nix files | 0.0888 | 0.0883 | x0.994 | level | 3 of 4 | x0.994 | - | x0.995 | x0.999 | x0.991 |
| blake3-servil-st / solo / LentBatches / 16 | 7.549 | 7.558 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x0.998 | x0.473 |
| blake3-servil-st / solo / LentBatches / 64 | 6.653 | 6.638 | x0.998 | level | 2 of 4 | x0.998 | - | x0.997 | x0.999 | x0.800 |
| blake3-servil-st / solo / LentBatches / 256 | 6.611 | 6.604 | x0.999 | level | 2 of 4 | x0.999 | - | x0.998 | x1.000 | x14.211 |
| blake3-servil-st / solo / LentBatches / 1024 | 7.054 | 7.058 | x1.001 | level | 2 of 4 | x1.000 | - | x0.999 | x1.000 | x44.932 |
| blake3-servil-st / solo / LentBatches / 4096 | 6.872 | 6.874 | x1.000 | level | 3 of 4 | x1.000 | - | x1.001 | x1.000 | x0.885 |
| blake3-servil-st / solo / LentBatches / 16384 | 7.649 | 7.639 | x0.999 | level | 3 of 4 | x0.998 | - | x0.997 | x1.000 | x0.828 |
| blake3-servil-st / solo / LentBatches / 65536 | 7.662 | 7.703 | x1.005 | level | 1 of 4 | x1.005 | - | x1.005 | x1.000 | x1.104 |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.135 | 0.135 | x1.000 | level | 2 of 4 | x1.000 | - | x1.001 | x1.000 | x1.012 |
| blake3-servil-st / solo / ContinuousCollection / Nix files | 0.145 | 0.146 | x1.003 | level | 1 of 4 | x1.003 | - | x1.003 | x1.000 | x1.049 |
| blake3-servil-st / solo / MerkleTree / 1024 | 0.123 | 0.123 | x0.999 | level | 2 of 4 | x0.999 | - | x1.000 | x1.001 | x0.586 |
| blake3-servil-st / solo / MerkleTree / 4096 | 0.134 | 0.133 | x0.992 | level | 4 of 4 | x0.992 | - | x0.992 | x1.001 | x0.527 |
| blake3-servil-st / solo / MerkleTree / 16384 | 0.133 | 0.133 | x1.000 | level | 1 of 4 | x1.000 | - | x1.001 | x1.001 | x0.921 |
| blake3-servil-st / solo / MerkleTree / 65536 | 0.141 | 0.141 | x1.000 | level | 2 of 4 | x1.000 | - | x0.999 | x1.001 | x0.983 |
| blake3-servil-st / solo / MerkleTree / 262144 | 0.151 | 0.151 | x0.998 | level | 2 of 4 | x0.998 | - | x0.997 | x1.001 | x1.014 |
| blake3-servil-st / solo / MerkleTree / 65536 x 32 B | 0.385 | 0.385 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.992 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 32 B | 0.421 | 0.421 | x1.000 | level | 2 of 4 | x1.000 | - | x1.002 | x1.000 | x0.933 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 16 B | 0.812 | 0.811 | x0.999 | level | 2 of 4 | x0.999 | - | x1.002 | x1.000 | x0.996 |
| blake3-servil-st / solo / MerkleTree / 65536 x 48 B | 0.268 | 0.268 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | x0.932 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 48 B | 0.297 | 0.297 | x0.998 | level | 2 of 4 | x0.998 | - | x0.998 | x1.000 | x0.914 |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.250 | 0.246 | x0.985 | level | 4 of 4 | - | - | x0.987 | x1.002 | x1.009 |
| blake3-servil-st / solo / InterleavedTurn / 1024 x 1 KiB | 0.231 | 0.229 | x0.993 | level | 2 of 4 | - | - | x0.993 | x0.997 | x1.035 |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.207 | 0.207 | x0.998 | level | 2 of 4 | - | - | x0.997 | x1.002 | x0.980 |
| blake3-servil-st / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.190 | 0.188 | x0.992 | level | 3 of 4 | - | - | x0.993 | x0.997 | x1.030 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.203 | 0.201 | x0.991 | level | 2 of 4 | - | - | x0.994 | x0.999 | x0.952 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.189 | 0.189 | x1.002 | level | 2 of 4 | - | - | x1.001 | x0.997 | x1.007 |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.105 | 0.105 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.001 | x0.962 |
| blake3-servil-st / solo / ReceivingMessage / 2 μs | 0.106 | 0.106 | x1.001 | level | 2 of 4 | x1.001 | - | x0.999 | x1.001 | x0.978 |
| blake3-servil-st / solo / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 2 of 4 | x1.000 | - | x0.999 | x1.001 | x0.954 |
| blake3-servil-st / solo / IncrementalMessage / 64 B | 6.314 | 6.398 | x1.013 | level | 1 of 4 | - | - | x1.010 | x1.001 | x0.980 |
| blake3-servil-st / solo / IncrementalMessage / 1 KiB | 1.909 | 1.956 | x1.024 | level | 1 of 4 | - | - | x1.016 | x1.002 | x1.033 |
| blake3-servil-st / solo / IncrementalMessage / 4 KiB | 0.625 | 0.648 | x1.037 | level | 0 of 4 | - | - | x1.029 | x1.001 | x1.005 |
| blake3-servil-st / solo / LentIncrementalMessage / 64 B | 1.016 | 1.015 | x0.999 | level | 3 of 4 | x0.999 | - | x1.000 | x1.006 | x1.158 |
| blake3-servil-st / solo / LentIncrementalMessage / 1 KiB | 1.245 | 1.246 | x1.001 | level | 1 of 4 | x1.001 | - | x1.002 | x1.002 | x1.288 |
| blake3-servil-st / solo / LentIncrementalMessage / 4 KiB | 0.364 | 0.364 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.001 | x1.085 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 0.951 | 0.963 | x1.013 | level | 0 of 4 | x1.013 | - | x1.004 | x1.013 | x0.978 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 4 KiB | 0.357 | 0.358 | x1.001 | level | 0 of 4 | x1.001 | - | x1.001 | x1.001 | x1.818 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 1 MiB | 0.0839 | 0.0825 | x0.983 | level | 4 of 4 | x0.983 | - | x0.982 | x1.000 | x0.979 |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 0.908 | 0.913 | x1.005 | level | 0 of 4 | x1.004 | - | x1.004 | x1.015 | x0.996 |
| blake3-servil-st / solo / ContinuousLentMessages / 4 KiB | 0.353 | 0.353 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.001 | x0.308 |
| blake3-servil-st / solo / ContinuousLentMessages / 1 MiB | 0.0697 | 0.0693 | x0.994 | level | 3 of 4 | x0.994 | - | x0.994 | x1.000 | x0.941 |
| blake3-servil-mt / solo / OneMessage / 64 B | 6.049 | 6.090 | x1.007 | level | 2 of 4 | - | - | x1.037 | x1.003 | x0.940 |
| blake3-servil-mt / solo / OneMessage / 128 B | 3.463 | 3.582 | x1.034 | level | 1 of 4 | - | - | x1.042 | x0.998 | x0.968 |
| blake3-servil-mt / solo / OneMessage / 256 B | 2.505 | 2.584 | x1.032 | level | 1 of 4 | - | - | x1.015 | x1.000 | x0.961 |
| blake3-servil-mt / solo / OneMessage / 512 B | 1.948 | 1.949 | x1.000 | level | 2 of 4 | - | - | x0.994 | x1.002 | x0.964 |
| blake3-servil-mt / solo / OneMessage / 1 KiB | 1.688 | 1.670 | x0.990 | level | 2 of 4 | - | - | x1.001 | x1.002 | x0.980 |
| blake3-servil-mt / solo / OneMessage / 1536 B | 1.555 | 1.537 | x0.988 | level | 3 of 4 | - | - | x0.985 | x1.000 | x0.937 |
| blake3-servil-mt / solo / OneMessage / 2 KiB | 1.040 | 1.034 | x0.994 | level | 2 of 4 | - | - | x0.990 | x1.002 | x0.954 |
| blake3-servil-mt / solo / OneMessage / 2304 B | 1.194 | 1.209 | x1.012 | level | 1 of 4 | - | - | x1.013 | x1.005 | x1.009 |
| blake3-servil-mt / solo / OneMessage / 3 KiB | 0.808 | 0.851 | x1.053 | level | 1 of 4 | - | - | x1.045 | x1.002 | x0.999 |
| blake3-servil-mt / solo / OneMessage / 3839 B | 0.798 | 0.862 | x1.080 | level | 0 of 4 | - | - | x1.071 | x1.002 | x1.000 |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 0.565 | 0.594 | x1.050 | level | 0 of 4 | - | - | x1.037 | x1.002 | x0.995 |
| blake3-servil-mt / solo / OneMessage / 4470 B | 0.690 | 0.690 | x1.000 | level | 3 of 4 | - | - | x1.002 | x1.002 | x0.986 |
| blake3-servil-mt / solo / OneMessage / 7935 B | 0.598 | 0.608 | x1.017 | level | 1 of 4 | - | - | x1.014 | x1.002 | x1.022 |
| blake3-servil-mt / solo / OneMessage / 8 KiB | 0.430 | 0.451 | x1.048 | level | 0 of 4 | - | - | x1.040 | x1.002 | x0.988 |
| blake3-servil-mt / solo / OneMessage / 16 KiB | 0.307 | 0.305 | x0.995 | level | 2 of 4 | - | - | x0.995 | x1.001 | x1.009 |
| blake3-servil-mt / solo / OneMessage / 32 KiB | 0.205 | 0.198 | x0.967 | level | 3 of 4 | - | - | x0.971 | x1.001 | x1.025 |
| blake3-servil-mt / solo / OneMessage / 64 KiB | 0.147 | 0.147 | x1.000 | level | 3 of 4 | - | - | x1.002 | x1.000 | x1.015 |
| blake3-servil-mt / solo / OneMessage / 128 KiB | 0.124 | 0.124 | x0.998 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.015 |
| blake3-servil-mt / solo / OneMessage / 256 KiB | 0.113 | 0.113 | x0.999 | level | 3 of 4 | - | - | x1.001 | x1.000 | x1.042 |
| blake3-servil-mt / solo / OneMessage / 512 KiB | 0.0671 | 0.0688 | x1.026 | level | 0 of 4 | - | - | x1.034 | x1.122 | x1.014 |
| blake3-servil-mt / solo / OneMessage / 1 MiB | 0.0523 | 0.0542 | x1.035 | level | 1 of 4 | - | - | x1.041 | x1.056 | x1.006 |
| blake3-servil-mt / solo / OneMessage / 2 MiB | 0.0658 | 0.0663 | x1.009 | level | 1 of 4 | - | - | x1.011 | x1.039 | x1.005 |
| blake3-servil-mt / solo / OneMessage / 3 MiB | 0.0714 | 0.0714 | x1.000 | level | 2 of 4 | - | - | x0.999 | x1.035 | x0.995 |
| blake3-servil-mt / solo / OneMessage / 4 MiB | 0.0423 | 0.0430 | x1.018 | level | 1 of 4 | - | - | x1.013 | x1.013 | x1.000 |
| blake3-servil-mt / solo / OneMessage / 8 MiB | 0.0694 | 0.0702 | x1.011 | level | 0 of 4 | - | - | x1.012 | x1.006 | x1.002 |
| blake3-servil-mt / solo / OneMessage / 32 MiB | 0.0363 | 0.0364 | x1.003 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.013 |
| blake3-servil-mt / solo / OneMessage / 64 MiB | 0.0341 | 0.0341 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.001 | x1.018 |
| blake3-servil-mt / solo / OneMessage / 128 MiB | 0.0356 | 0.0354 | x0.996 | level | 3 of 4 | - | - | x0.996 | x0.997 | x1.013 |
| blake3-servil-mt / solo / ManyMessages / 1 | 479.311 | 510.856 | x1.066 | level | 1 of 4 | - | - | x1.052 | x1.012 | x1.037 |
| blake3-servil-mt / solo / ManyMessages / 2 | 237.641 | 274.933 | x1.157 | level | 0 of 4 | - | - | x1.090 | x1.005 | x1.007 |
| blake3-servil-mt / solo / ManyMessages / 3 | 201.942 | 221.323 | x1.096 | level | 2 of 4 | - | - | x1.051 | x1.008 | x0.998 |
| blake3-servil-mt / solo / ManyMessages / 4 | 140.591 | 160.000 | x1.138 | level | 1 of 4 | - | - | x1.108 | x1.010 | x0.987 |
| blake3-servil-mt / solo / ManyMessages / 6 | 109.251 | 129.291 | x1.183 | level | 0 of 4 | - | - | x1.131 | x1.003 | x1.007 |
| blake3-servil-mt / solo / ManyMessages / 8 | 157.326 | 170.662 | x1.085 | level | 2 of 4 | - | - | x1.070 | x1.013 | x1.012 |
| blake3-servil-mt / solo / ManyMessages / 12 | 114.711 | 124.211 | x1.083 | level | 1 of 4 | - | - | x1.073 | x1.002 | x0.998 |
| blake3-servil-mt / solo / ManyMessages / 16 | 102.109 | 106.386 | x1.042 | level | 2 of 4 | - | - | x1.036 | x0.997 | x1.008 |
| blake3-servil-mt / solo / ManyMessages / 24 | 98.909 | 106.281 | x1.075 | level | 0 of 4 | - | - | x1.070 | x0.997 | x1.005 |
| blake3-servil-mt / solo / ManyMessages / 32 | 46.051 | 50.720 | x1.101 | level | 0 of 4 | - | - | x1.094 | x0.998 | x1.009 |
| blake3-servil-mt / solo / ManyMessages / 48 | 32.285 | 36.798 | x1.140 | level | 0 of 4 | - | - | x1.131 | x0.994 | x1.021 |
| blake3-servil-mt / solo / ManyMessages / 64 | 26.338 | 29.415 | x1.117 | level | 0 of 4 | - | - | x1.135 | x1.003 | x1.003 |
| blake3-servil-mt / solo / ManyMessages / 128 | 17.958 | 19.845 | x1.105 | level | 1 of 4 | - | - | x1.108 | x1.000 | x0.994 |
| blake3-servil-mt / solo / ManyMessages / 256 | 13.667 | 14.149 | x1.035 | level | 2 of 4 | - | - | x1.049 | x1.000 | x1.033 |
| blake3-servil-mt / solo / ManyMessages / 512 | 10.962 | 11.281 | x1.029 | level | 1 of 4 | - | - | x1.030 | x0.999 | x1.056 |
| blake3-servil-mt / solo / ManyMessages / 1024 | 9.675 | 9.644 | x0.997 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.997 |
| blake3-servil-mt / solo / ManyMessages / 2048 | 9.092 | 9.056 | x0.996 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.933 |
| blake3-servil-mt / solo / ManyMessages / 4096 | 8.805 | 8.711 | x0.989 | level | 3 of 4 | - | - | x0.988 | x1.000 | x0.948 |
| blake3-servil-mt / solo / ManyMessages / 8192 | 3.683 | 3.863 | x1.049 | level | 0 of 4 | - | - | x1.042 | x1.042 | x1.017 |
| blake3-servil-mt / solo / ManyMessages / 16384 | 3.036 | 3.114 | x1.026 | level | 1 of 4 | - | - | x1.023 | x1.018 | x1.031 |
| blake3-servil-mt / solo / ManyMessages / 32768 | 2.730 | 2.757 | x1.010 | level | 1 of 4 | - | - | x1.006 | x1.021 | x1.025 |
| blake3-servil-mt / solo / ManyMessages / 65536 | 2.602 | 3.320 | x1.276 | level | 1 of 4 | - | - | x1.277 | x0.904 | x1.197 |
| blake3-servil-mt / solo / ManyMessages / 131072 | 4.458 | 4.595 | x1.031 | level | 1 of 4 | - | - | x1.033 | x0.995 | x1.030 |
| blake3-servil-mt / solo / ManyMessages / 262144 | 4.657 | 4.686 | x1.006 | level | 1 of 4 | - | - | x1.007 | x1.015 | x1.014 |
| blake3-servil-mt / solo / ManyLongMessages / 4 | 1821.773 | 1852.776 | x1.017 | level | 2 of 4 | - | - | x1.015 | x1.000 | x1.019 |
| blake3-servil-mt / solo / ManyLongMessages / 16 | 1641.450 | 665.674 | x0.406 | faster | 4 of 4 | - | - | x0.412 | x0.575 | x1.338 |
| blake3-servil-mt / solo / ManyLongMessages / 64 | 574.262 | 557.713 | x0.971 | level | 4 of 4 | - | - | x0.973 | x0.998 | x0.995 |
| blake3-servil-mt / solo / ManyLongMessages / 256 | 307.093 | 296.388 | x0.965 | level | 2 of 4 | - | - | x0.959 | x0.905 | x1.055 |
| blake3-servil-mt / solo / IdleOneMessage / 64 B | 3.022 | 3.067 | x1.015 | level | 2 of 4 | - | - | x1.003 | x1.005 | x0.916 |
| blake3-servil-mt / solo / IdleOneMessage / 128 B | 2.145 | 2.160 | x1.007 | level | 2 of 4 | - | - | x1.001 | x1.004 | x1.187 |
| blake3-servil-mt / solo / IdleOneMessage / 256 B | 1.764 | 1.776 | x1.006 | level | 1 of 4 | - | - | x1.003 | x1.003 | x0.925 |
| blake3-servil-mt / solo / IdleOneMessage / 512 B | 1.620 | 1.623 | x1.002 | level | 2 of 4 | - | - | x1.001 | x1.002 | x0.832 |
| blake3-servil-mt / solo / IdleOneMessage / 1 KiB | 1.549 | 1.539 | x0.993 | level | 3 of 4 | - | - | x0.999 | x1.001 | x0.912 |
| blake3-servil-mt / solo / IdleOneMessage / 1536 B | 1.171 | 1.180 | x1.007 | level | 2 of 4 | - | - | x1.000 | x0.997 | x0.770 |
| blake3-servil-mt / solo / IdleOneMessage / 2 KiB | 0.856 | 0.857 | x1.001 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.933 |
| blake3-servil-mt / solo / IdleOneMessage / 2304 B | 0.965 | 0.965 | x1.000 | level | 3 of 4 | - | - | x0.998 | x1.001 | x4.320 |
| blake3-servil-mt / solo / IdleOneMessage / 3 KiB | 0.625 | 0.632 | x1.011 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.640 |
| blake3-servil-mt / solo / IdleOneMessage / 3839 B | 0.512 | 0.512 | x1.002 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.926 |
| blake3-servil-mt / solo / IdleOneMessage / 4 KiB | 0.469 | 0.469 | x0.999 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.446 |
| blake3-servil-mt / solo / IdleOneMessage / 4470 B | 0.580 | 0.578 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.001 | x0.566 |
| blake3-servil-mt / solo / IdleOneMessage / 7935 B | 0.291 | 0.293 | x1.005 | level | 1 of 4 | - | - | x1.002 | x1.000 | x3.377 |
| blake3-servil-mt / solo / IdleOneMessage / 8 KiB | 0.272 | 0.273 | x1.003 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.204 |
| blake3-servil-mt / solo / IdleOneMessage / 16 KiB | 0.152 | 0.153 | x1.007 | level | 1 of 4 | - | - | x0.997 | x1.000 | x0.854 |
| blake3-servil-mt / solo / IdleOneMessage / 32 KiB | 0.106 | 0.108 | x1.016 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.751 |
| blake3-servil-mt / solo / IdleOneMessage / 64 KiB | 0.0973 | 0.0977 | x1.004 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.953 |
| blake3-servil-mt / solo / IdleOneMessage / 128 KiB | 0.0933 | 0.0934 | x1.001 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.597 |
| blake3-servil-mt / solo / IdleOneMessage / 256 KiB | 0.0912 | 0.0915 | x1.003 | level | 1 of 4 | - | - | x0.998 | x1.000 | x0.863 |
| blake3-servil-mt / solo / IdleOneMessage / 512 KiB | 0.0636 | 0.0627 | x0.986 | level | 2 of 4 | - | - | x0.985 | x1.006 | x1.005 |
| blake3-servil-mt / solo / IdleOneMessage / 1 MiB | 0.0560 | 0.0589 | x1.052 | level | 2 of 4 | - | - | x1.056 | x1.052 | x1.001 |
| blake3-servil-mt / solo / IdleOneMessage / 2 MiB | 0.0613 | 0.0610 | x0.996 | level | 2 of 4 | - | - | x0.996 | x1.033 | x0.997 |
| blake3-servil-mt / solo / IdleOneMessage / 3 MiB | 0.0609 | 0.0600 | x0.984 | level | 2 of 4 | - | - | x0.981 | x1.001 | x0.991 |
| blake3-servil-mt / solo / IdleOneMessage / 4 MiB | 0.0399 | 0.0464 | x1.162 | level | 0 of 4 | - | - | x1.161 | x0.974 | x1.021 |
| blake3-servil-mt / solo / IdleOneMessage / 8 MiB | 0.0661 | 0.0663 | x1.004 | level | 1 of 4 | - | - | x1.003 | x0.997 | x1.000 |
| blake3-servil-mt / solo / IdleOneMessage / 32 MiB | 0.0323 | 0.0323 | x0.998 | level | 1 of 4 | - | - | x0.999 | x0.999 | x1.014 |
| blake3-servil-mt / solo / IdleOneMessage / 64 MiB | 0.0340 | 0.0340 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.002 | x0.998 |
| blake3-servil-mt / solo / IdleOneMessage / 128 MiB | 0.0336 | 0.0334 | x0.995 | level | 3 of 4 | - | - | x0.995 | x0.996 | x1.014 |
| blake3-servil-mt / solo / IdleManyMessages / 1 | 206.823 | 208.868 | x1.010 | level | 1 of 4 | - | - | x1.008 | x1.007 | x1.058 |
| blake3-servil-mt / solo / IdleManyMessages / 2 | 106.419 | 109.416 | x1.028 | level | 1 of 4 | - | - | x1.011 | x0.998 | x0.659 |
| blake3-servil-mt / solo / IdleManyMessages / 3 | 92.420 | 93.157 | x1.008 | level | 2 of 4 | - | - | x1.004 | x0.998 | x0.609 |
| blake3-servil-mt / solo / IdleManyMessages / 4 | 53.543 | 54.775 | x1.023 | level | 1 of 4 | - | - | x1.009 | x0.997 | x1.045 |
| blake3-servil-mt / solo / IdleManyMessages / 6 | 51.003 | 50.631 | x0.993 | level | 2 of 4 | - | - | x1.005 | x0.998 | x0.875 |
| blake3-servil-mt / solo / IdleManyMessages / 8 | 34.454 | 34.515 | x1.002 | level | 2 of 4 | - | - | x0.999 | x0.998 | x1.106 |
| blake3-servil-mt / solo / IdleManyMessages / 12 | 31.028 | 31.769 | x1.024 | level | 0 of 4 | - | - | x1.013 | x0.998 | x0.773 |
| blake3-servil-mt / solo / IdleManyMessages / 16 | 18.037 | 18.548 | x1.028 | level | 2 of 4 | - | - | x1.013 | x0.998 | x3.521 |
| blake3-servil-mt / solo / IdleManyMessages / 24 | 17.375 | 17.266 | x0.994 | level | 2 of 4 | - | - | x0.997 | x0.999 | x1.150 |
| blake3-servil-mt / solo / IdleManyMessages / 32 | 12.919 | 13.360 | x1.034 | level | 2 of 4 | - | - | x1.011 | x0.999 | x1.563 |
| blake3-servil-mt / solo / IdleManyMessages / 48 | 11.283 | 11.422 | x1.012 | level | 1 of 4 | - | - | x1.017 | x0.999 | x1.546 |
| blake3-servil-mt / solo / IdleManyMessages / 64 | 10.336 | 10.374 | x1.004 | level | 2 of 4 | - | - | x1.000 | x0.999 | x1.069 |
| blake3-servil-mt / solo / IdleManyMessages / 128 | 9.266 | 9.291 | x1.003 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.103 |
| blake3-servil-mt / solo / IdleManyMessages / 256 | 8.680 | 8.733 | x1.006 | level | 1 of 4 | - | - | x0.998 | x0.999 | x0.545 |
| blake3-servil-mt / solo / IdleManyMessages / 512 | 8.272 | 8.360 | x1.011 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.766 |
| blake3-servil-mt / solo / IdleManyMessages / 1024 | 8.083 | 8.147 | x1.008 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.546 |
| blake3-servil-mt / solo / IdleManyMessages / 2048 | 7.972 | 8.026 | x1.007 | level | 1 of 4 | - | - | x0.996 | x1.000 | x0.745 |
| blake3-servil-mt / solo / IdleManyMessages / 4096 | 7.975 | 8.007 | x1.004 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.900 |
| blake3-servil-mt / solo / IdleManyMessages / 8192 | 3.535 | 3.723 | x1.053 | level | 1 of 4 | - | - | x1.049 | x1.029 | x1.031 |
| blake3-servil-mt / solo / IdleManyMessages / 16384 | 3.191 | 3.578 | x1.121 | level | 1 of 4 | - | - | x1.125 | x1.043 | x1.009 |
| blake3-servil-mt / solo / IdleManyMessages / 32768 | 2.699 | 2.968 | x1.100 | level | 1 of 4 | - | - | x1.104 | x1.031 | x1.013 |
| blake3-servil-mt / solo / IdleManyMessages / 65536 | 2.435 | 3.431 | x1.409 | level | 0 of 4 | - | - | x1.406 | x0.908 | x1.140 |
| blake3-servil-mt / solo / IdleManyMessages / 131072 | 4.110 | 4.211 | x1.025 | level | 0 of 4 | - | - | x1.025 | x1.004 | x1.009 |
| blake3-servil-mt / solo / IdleManyMessages / 262144 | 4.191 | 4.217 | x1.006 | level | 1 of 4 | - | - | x1.007 | x1.001 | x1.007 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 B | 3.034 | 3.047 | x1.004 | level | 2 of 4 | - | - | x1.003 | x1.005 | x1.075 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 B | 2.113 | 2.126 | x1.006 | level | 1 of 4 | - | - | x1.004 | x1.004 | x1.408 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 B | 1.694 | 1.700 | x1.004 | level | 1 of 4 | - | - | x1.002 | x1.003 | x1.642 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 B | 1.459 | 1.462 | x1.002 | level | 1 of 4 | - | - | x1.001 | x1.002 | x2.656 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 KiB | 1.349 | 1.351 | x1.002 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.496 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1536 B | 1.013 | 1.026 | x1.013 | level | 1 of 4 | - | - | x1.000 | x0.997 | x0.979 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 KiB | 0.734 | 0.730 | x0.995 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.950 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2304 B | 0.817 | 0.813 | x0.995 | level | 4 of 4 | - | - | x0.994 | x1.001 | x0.455 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 KiB | 0.526 | 0.527 | x1.003 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.070 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3839 B | 0.426 | 0.430 | x1.009 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.893 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 KiB | 0.392 | 0.389 | x0.994 | level | 4 of 4 | - | - | x0.997 | x1.000 | x0.563 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4470 B | 0.486 | 0.481 | x0.991 | level | 3 of 4 | - | - | x0.998 | x1.001 | x1.170 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 7935 B | 0.241 | 0.243 | x1.007 | level | 1 of 4 | - | - | x1.000 | x1.000 | x2.067 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 KiB | 0.224 | 0.225 | x1.003 | level | 1 of 4 | - | - | x1.005 | x1.000 | x1.629 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 16 KiB | 0.126 | 0.126 | x1.005 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.913 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 KiB | 0.0898 | 0.0882 | x0.982 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.053 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 KiB | 0.0820 | 0.0844 | x1.029 | level | 2 of 4 | - | - | x0.994 | x1.000 | x1.002 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 KiB | 0.0781 | 0.0784 | x1.004 | level | 1 of 4 | - | - | x0.997 | x1.000 | x0.981 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 KiB | 0.0779 | 0.0778 | x0.999 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.175 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 KiB | 0.0572 | 0.0584 | x1.021 | level | 1 of 4 | - | - | x1.025 | x1.055 | x1.006 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 MiB | 0.0475 | 0.0489 | x1.030 | level | 1 of 4 | - | - | x1.031 | x1.038 | x0.998 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 MiB | 0.0712 | 0.0635 | x0.892 | level | 4 of 4 | - | - | x0.887 | x1.077 | x0.983 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 MiB | 0.0721 | 0.0656 | x0.910 | level | 2 of 4 | - | - | x0.907 | x1.060 | x0.987 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 MiB | 0.0404 | 0.0442 | x1.092 | level | 0 of 4 | - | - | x1.088 | x0.989 | x1.008 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 MiB | 0.0672 | 0.0669 | x0.995 | level | 2 of 4 | - | - | x0.994 | x1.002 | x0.988 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 MiB | 0.0314 | 0.0313 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.042 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 MiB | 0.0332 | 0.0332 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.004 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 MiB | 0.0333 | 0.0331 | x0.995 | level | 3 of 4 | - | - | x0.996 | x0.997 | x1.004 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1 | 204.512 | 207.059 | x1.012 | level | 2 of 4 | - | - | x1.011 | x1.007 | x0.900 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2 | 105.148 | 106.597 | x1.014 | level | 0 of 4 | - | - | x1.012 | x0.998 | x1.205 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 3 | 91.716 | 91.541 | x0.998 | level | 2 of 4 | - | - | x1.008 | x0.998 | x0.951 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4 | 53.758 | 53.529 | x0.996 | level | 2 of 4 | - | - | x1.007 | x0.998 | x0.354 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 6 | 45.779 | 46.243 | x1.010 | level | 1 of 4 | - | - | x1.009 | x0.998 | x0.930 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8 | 28.487 | 28.756 | x1.009 | level | 2 of 4 | - | - | x1.007 | x0.998 | x2.782 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 12 | 25.733 | 26.115 | x1.015 | level | 1 of 4 | - | - | x1.007 | x0.998 | x0.849 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16 | 14.773 | 15.020 | x1.017 | level | 1 of 4 | - | - | x1.010 | x0.998 | x0.886 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 24 | 13.726 | 13.905 | x1.013 | level | 0 of 4 | - | - | x1.009 | x0.999 | x0.755 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32 | 10.552 | 10.635 | x1.008 | level | 2 of 4 | - | - | x1.008 | x0.999 | x0.885 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 48 | 9.151 | 9.331 | x1.020 | level | 0 of 4 | - | - | x1.008 | x0.999 | x0.871 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 64 | 8.460 | 8.494 | x1.004 | level | 2 of 4 | - | - | x1.005 | x0.999 | x1.130 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 128 | 7.435 | 7.536 | x1.013 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.244 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 256 | 7.079 | 7.100 | x1.003 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.912 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 512 | 6.849 | 6.841 | x0.999 | level | 1 of 4 | - | - | x1.003 | x1.000 | x0.751 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1024 | 6.711 | 6.674 | x0.995 | level | 4 of 4 | - | - | x0.997 | x1.000 | x0.414 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2048 | 6.655 | 6.649 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.949 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4096 | 6.770 | 6.756 | x0.998 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.961 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8192 | 3.102 | 3.407 | x1.098 | level | 0 of 4 | - | - | x1.088 | x1.035 | x1.034 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16384 | 2.719 | 2.865 | x1.054 | level | 1 of 4 | - | - | x1.046 | x1.010 | x1.014 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32768 | 2.598 | 2.668 | x1.027 | level | 0 of 4 | - | - | x1.020 | x0.999 | x1.013 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 65536 | 2.388 | 3.210 | x1.344 | level | 0 of 4 | - | - | x1.340 | x0.929 | x1.120 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 131072 | 4.138 | 4.239 | x1.024 | level | 2 of 4 | - | - | x1.024 | x1.017 | x1.019 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 262144 | 4.222 | 4.237 | x1.004 | level | 1 of 4 | - | - | x1.004 | x1.005 | x1.004 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.446 | 0.400 | x0.898 | level | 4 of 4 | x0.818 | - | x0.900 | x0.962 | x1.068 |
| blake3-servil-mt / solo / ContinuousMessages / 128 B | 0.233 | 0.213 | x0.916 | level | 4 of 4 | x0.861 | - | x0.917 | x0.962 | x1.149 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.118 | 0.117 | x0.992 | level | 2 of 4 | x0.951 | - | x0.992 | x0.963 | x0.888 |
| blake3-servil-mt / solo / ContinuousMessages / 512 B | 0.0704 | 0.0633 | x0.900 | level | 4 of 4 | x0.841 | - | x0.904 | x0.965 | x1.115 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.0524 | 0.0504 | x0.962 | level | 3 of 4 | x0.825 | - | x0.974 | x0.972 | x1.027 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0459 | 0.0448 | x0.977 | level | 3 of 4 | x1.000 | - | x0.965 | x0.990 | x0.974 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0371 | 0.0363 | x0.978 | level | 2 of 4 | x0.700 | - | x0.980 | x1.017 | x1.008 |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.0335 | 0.0348 | x1.040 | level | 1 of 4 | x1.033 | - | x1.040 | x1.020 | x1.042 |
| blake3-servil-mt / solo / ContinuousMessages / 256 KiB | 0.0327 | 0.0334 | x1.021 | level | 1 of 4 | x1.010 | - | x1.022 | x1.018 | x0.998 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0298 | 0.0301 | x1.011 | level | 0 of 4 | x0.992 | - | x1.012 | x1.017 | x1.004 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.0312 | 0.0309 | x0.990 | level | 2 of 4 | x0.958 | - | x0.990 | x1.017 | x1.010 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0313 | 0.0316 | x1.011 | level | 2 of 4 | x0.969 | - | x1.010 | x1.017 | x1.005 |
| blake3-servil-mt / solo / ContinuousMessages / 64 MiB | 0.0338 | 0.0344 | x1.017 | level | 0 of 4 | x1.031 | - | x1.017 | x1.017 | x1.007 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 3.697 | 3.679 | x0.995 | level | 3 of 4 | x1.046 | - | x0.994 | x0.964 | x0.940 |
| blake3-servil-mt / solo / ContinuousBatches / 64 | 2.473 | 2.287 | x0.925 | level | 4 of 4 | x0.994 | - | x0.925 | x0.976 | x1.125 |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 2.676 | 2.656 | x0.993 | level | 2 of 4 | x0.996 | - | x0.994 | x0.991 | x1.010 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 2.365 | 2.381 | x1.007 | level | 1 of 4 | x1.048 | - | x1.006 | x0.978 | x0.996 |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 2.532 | 2.488 | x0.983 | level | 2 of 4 | x1.049 | - | x0.985 | x0.990 | x1.019 |
| blake3-servil-mt / solo / ContinuousBatches / 16384 | 2.558 | 2.551 | x0.997 | level | 3 of 4 | x0.988 | - | x1.001 | x1.000 | x0.986 |
| blake3-servil-mt / solo / ContinuousBatches / 65536 | 2.903 | 2.961 | x1.020 | level | 2 of 4 | x1.022 | - | x1.021 | x0.999 | x1.013 |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.941 | 0.939 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.012 | x1.070 |
| blake3-servil-mt / solo / LentMessages / 128 B | 1.078 | 1.079 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.007 | x0.583 |
| blake3-servil-mt / solo / LentMessages / 256 B | 1.151 | 1.153 | x1.002 | level | 0 of 4 | x1.002 | - | x1.002 | x1.004 | x1.083 |
| blake3-servil-mt / solo / LentMessages / 512 B | 1.189 | 1.189 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.002 | x0.821 |
| blake3-servil-mt / solo / LentMessages / 1 KiB | 1.212 | 1.213 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.001 | x0.270 |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.357 | 0.358 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.001 | x0.754 |
| blake3-servil-mt / solo / LentMessages / 16 KiB | 0.114 | 0.114 | x1.003 | level | 1 of 4 | x1.003 | - | x1.002 | x1.000 | x1.686 |
| blake3-servil-mt / solo / LentMessages / 64 KiB | 0.0810 | 0.0809 | x0.999 | level | 3 of 4 | x0.999 | - | x0.998 | x1.000 | x1.145 |
| blake3-servil-mt / solo / LentMessages / 256 KiB | 0.0758 | 0.0761 | x1.004 | level | 0 of 4 | x1.004 | - | x1.004 | x1.000 | x0.766 |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.0451 | 0.0452 | x1.001 | level | 1 of 4 | x1.001 | - | x0.996 | x0.988 | x1.004 |
| blake3-servil-mt / solo / LentMessages / 4 MiB | 0.0392 | 0.0393 | x1.002 | level | 2 of 4 | x1.002 | - | x1.003 | x1.008 | x1.053 |
| blake3-servil-mt / solo / LentMessages / 16 MiB | 0.0340 | 0.0343 | x1.009 | level | 1 of 4 | x1.003 | - | x1.012 | x1.008 | x1.018 |
| blake3-servil-mt / solo / LentMessages / 64 MiB | 0.0336 | 0.0338 | x1.006 | level | 2 of 4 | x0.999 | - | x1.007 | x1.000 | x1.012 |
| blake3-servil-mt / solo / Interleaved / 256 | 0.137 | 0.137 | x0.999 | level | 3 of 4 | x0.999 | - | x1.000 | x0.999 | x0.980 |
| blake3-servil-mt / solo / Collection / git objects | 0.00833 | 0.00822 | x0.987 | level | 3 of 4 | x0.994 | - | x0.989 | x1.005 | x1.018 |
| blake3-servil-mt / solo / Collection / Nix files | 0.0110 | 0.0121 | x1.100 | level | 0 of 4 | x1.032 | - | x1.109 | x1.096 | x1.120 |
| blake3-servil-mt / solo / LentBatches / 16 | 7.549 | 7.578 | x1.004 | level | 1 of 4 | x1.004 | - | x1.004 | x0.998 | x4.155 |
| blake3-servil-mt / solo / LentBatches / 64 | 6.643 | 6.643 | x1.000 | level | 1 of 4 | x1.000 | - | x0.999 | x0.999 | x1.040 |
| blake3-servil-mt / solo / LentBatches / 256 | 6.611 | 6.604 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x3.981 |
| blake3-servil-mt / solo / LentBatches / 1024 | 7.057 | 7.048 | x0.999 | level | 3 of 4 | x0.999 | - | x0.998 | x1.000 | x0.803 |
| blake3-servil-mt / solo / LentBatches / 4096 | 6.865 | 7.069 | x1.030 | level | 2 of 4 | x1.029 | - | x1.001 | x1.000 | x0.910 |
| blake3-servil-mt / solo / LentBatches / 16384 | 3.242 | 3.212 | x0.991 | level | 2 of 4 | x0.979 | - | x0.994 | x1.023 | x0.978 |
| blake3-servil-mt / solo / LentBatches / 65536 | 2.819 | 2.847 | x1.010 | level | 0 of 4 | x1.024 | - | x1.009 | x1.004 | x1.040 |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.0388 | 0.0388 | x1.000 | level | 3 of 4 | x0.985 | - | x0.999 | x1.005 | x1.004 |
| blake3-servil-mt / solo / ContinuousCollection / Nix files | 0.0392 | 0.0385 | x0.982 | level | 3 of 4 | x0.997 | - | x0.982 | x1.001 | x1.020 |
| blake3-servil-mt / solo / MerkleTree / 1024 | 0.124 | 0.123 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x1.001 | x0.491 |
| blake3-servil-mt / solo / MerkleTree / 4096 | 0.0696 | 0.0706 | x1.015 | level | 1 of 4 | x1.049 | - | x1.012 | x1.000 | x0.990 |
| blake3-servil-mt / solo / MerkleTree / 16384 | 0.0651 | 0.0839 | x1.290 | level | 0 of 4 | x1.692 | - | x1.291 | x0.964 | x1.110 |
| blake3-servil-mt / solo / MerkleTree / 65536 | 0.0805 | 0.0734 | x0.912 | level | 3 of 4 | x0.918 | - | x0.910 | x1.038 | x0.862 |
| blake3-servil-mt / solo / MerkleTree / 262144 | 0.0487 | 0.0502 | x1.031 | level | 1 of 4 | x1.036 | - | x1.030 | x0.994 | x1.059 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 32 B | 0.0943 | 0.0943 | x1.000 | level | 2 of 4 | x1.071 | - | x0.997 | x0.994 | x0.815 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 32 B | 0.0604 | 0.0610 | x1.011 | level | 2 of 4 | x1.000 | - | x1.009 | x1.007 | x0.992 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 16 B | 0.136 | 0.138 | x1.010 | level | 2 of 4 | x0.989 | - | x1.010 | x1.059 | x0.913 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 48 B | 0.0706 | 0.0693 | x0.983 | level | 2 of 4 | x0.988 | - | x0.984 | x1.005 | x0.861 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 48 B | 0.0534 | 0.0548 | x1.026 | level | 1 of 4 | x1.024 | - | x1.028 | x1.006 | x1.111 |
| blake3-servil-mt / solo / InterleavedTurn / 256 | 0.300 | 0.292 | x0.973 | level | 4 of 4 | - | - | x0.996 | x0.940 | x1.022 |
| blake3-servil-mt / solo / InterleavedTurn / 1024 x 1 KiB | 0.149 | 0.145 | x0.976 | level | 3 of 4 | - | - | x0.974 | x0.988 | x1.046 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 256 | 0.187 | 0.184 | x0.979 | level | 3 of 4 | - | - | x0.991 | x0.963 | x0.969 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.143 | 0.143 | x1.001 | level | 2 of 4 | - | - | x1.001 | x0.995 | x1.041 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 256 | 0.220 | 0.214 | x0.972 | level | 4 of 4 | - | - | x0.997 | x0.976 | x0.998 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.140 | 0.136 | x0.974 | level | 4 of 4 | - | - | x0.967 | x0.987 | x0.940 |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.0349 | 0.0353 | x1.011 | level | 1 of 4 | x0.997 | - | x1.020 | x1.014 | x0.991 |
| blake3-servil-mt / solo / ReceivingMessage / 2 μs | 0.0921 | 0.0920 | x1.000 | level | 3 of 4 | x0.979 | - | x0.977 | x1.014 | x0.964 |
| blake3-servil-mt / solo / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 4 of 4 | x1.167 | - | x0.919 | x1.016 | x0.872 |
| blake3-servil-mt / solo / IncrementalMessage / 64 B | 7.195 | 7.463 | x1.037 | level | 1 of 4 | - | - | x1.035 | x1.009 | x0.992 |
| blake3-servil-mt / solo / IncrementalMessage / 1 KiB | 1.814 | 1.848 | x1.019 | level | 2 of 4 | - | - | x1.022 | x1.000 | x1.023 |
| blake3-servil-mt / solo / IncrementalMessage / 4 KiB | 0.629 | 0.652 | x1.036 | level | 0 of 4 | - | - | x1.028 | x1.002 | x1.004 |
| blake3-servil-mt / solo / LentIncrementalMessage / 64 B | 0.947 | 0.967 | x1.021 | level | 0 of 4 | x1.021 | - | x1.021 | x1.006 | x0.264 |
| blake3-servil-mt / solo / LentIncrementalMessage / 1 KiB | 1.245 | 1.246 | x1.001 | level | 0 of 4 | x1.001 | - | x1.002 | x1.002 | x0.231 |
| blake3-servil-mt / solo / LentIncrementalMessage / 4 KiB | 0.365 | 0.364 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.001 | x0.161 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 6.336 | 5.948 | x0.939 | level | 4 of 4 | x0.963 | - | x0.935 | x0.996 | x1.054 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 4 KiB | 0.106 | 0.102 | x0.963 | level | 3 of 4 | x1.070 | - | x0.962 | x1.009 | x1.006 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 1 MiB | 0.0302 | 0.0298 | x0.987 | level | 3 of 4 | x1.095 | - | x0.991 | x1.017 | x0.997 |
| blake3-servil-mt / solo / ContinuousLentMessages / 64 B | 0.366 | 0.378 | x1.033 | level | 2 of 4 | x0.893 | - | x1.020 | x0.955 | x0.914 |
| blake3-servil-mt / solo / ContinuousLentMessages / 4 KiB | 0.0349 | 0.0364 | x1.043 | level | 0 of 4 | x1.133 | - | x1.048 | x0.957 | x1.012 |
| blake3-servil-mt / solo / ContinuousLentMessages / 1 MiB | 0.00351 | 0.00344 | x0.980 | level | 4 of 4 | x0.978 | - | x0.979 | x1.011 | x0.909 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.427 | 0.412 | x0.963 | level | 3 of 4 | - | - | x0.964 | x0.962 | x1.062 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 128 B | 0.218 | 0.216 | x0.989 | level | 3 of 4 | - | - | x0.989 | x0.962 | x1.010 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.120 | 0.121 | x1.008 | level | 2 of 4 | - | - | x1.006 | x0.963 | x1.025 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 512 B | 0.0773 | 0.0804 | x1.041 | level | 0 of 4 | - | - | x1.028 | x0.965 | x0.997 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.0607 | 0.0627 | x1.033 | level | 0 of 4 | - | - | x1.028 | x0.972 | x1.057 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.0989 | 0.103 | x1.041 | level | 1 of 4 | - | - | x0.950 | x0.983 | x0.955 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.0490 | 0.0490 | x1.001 | level | 2 of 4 | - | - | x0.966 | x1.018 | x1.015 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.0397 | 0.0400 | x1.007 | level | 2 of 4 | - | - | x1.005 | x1.020 | x1.000 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 KiB | 0.0377 | 0.0383 | x1.017 | level | 0 of 4 | - | - | x1.018 | x1.018 | x1.031 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0383 | 0.0390 | x1.018 | level | 0 of 4 | - | - | x1.016 | x1.017 | x1.000 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.0397 | 0.0407 | x1.025 | level | 0 of 4 | - | - | x1.024 | x1.018 | x0.996 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.0484 | 0.0480 | x0.993 | level | 2 of 4 | - | - | x0.993 | x1.017 | x1.018 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 MiB | 0.0537 | 0.0500 | x0.932 | level | 4 of 4 | - | - | x0.928 | x1.017 | x1.090 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 4.268 | 4.386 | x1.027 | level | 0 of 4 | - | - | x1.017 | x0.964 | x1.027 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 64 | 3.104 | 3.077 | x0.991 | level | 3 of 4 | - | - | x0.986 | x0.977 | x1.016 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 256 | 3.122 | 3.135 | x1.004 | level | 2 of 4 | - | - | x0.996 | x0.992 | x1.000 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 2.918 | 2.936 | x1.006 | level | 1 of 4 | - | - | x0.994 | x0.980 | x1.010 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 4096 | 3.256 | 3.431 | x1.054 | level | 1 of 4 | - | - | x1.066 | x1.004 | x0.996 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16384 | 3.011 | 2.900 | x0.963 | level | 3 of 4 | - | - | x0.953 | x1.014 | x1.010 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 65536 | 3.405 | 2.871 | x0.843 | level | 4 of 4 | - | - | x0.827 | x1.086 | x0.750 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.940 | 0.939 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.012 | x0.962 |
| blake3-servil-mt / shared-one-cache / LentMessages / 128 B | 1.077 | 1.079 | x1.002 | level | 2 of 4 | - | - | x1.001 | x1.007 | x0.791 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 B | 1.151 | 1.153 | x1.002 | level | 0 of 4 | - | - | x1.002 | x1.004 | x0.977 |
| blake3-servil-mt / shared-one-cache / LentMessages / 512 B | 1.188 | 1.189 | x1.000 | level | 0 of 4 | - | - | x1.000 | x1.002 | x1.038 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 KiB | 1.211 | 1.211 | x1.000 | level | 4 of 4 | - | - | x1.000 | x1.001 | x0.848 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.358 | 0.358 | x1.000 | level | 4 of 4 | - | - | x1.000 | x1.001 | x0.995 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 KiB | 0.114 | 0.114 | x0.997 | level | 4 of 4 | - | - | x0.997 | x1.000 | x1.183 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 KiB | 0.0812 | 0.0810 | x0.996 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.778 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 KiB | 0.0761 | 0.0760 | x0.998 | level | 4 of 4 | - | - | x0.998 | x1.000 | x1.117 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 MiB | 0.0546 | 0.0566 | x1.036 | level | 1 of 4 | - | - | x1.037 | x1.023 | x1.000 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 MiB | 0.0452 | 0.0438 | x0.968 | level | 2 of 4 | - | - | x0.968 | x1.030 | x0.949 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 MiB | 0.0574 | 0.0571 | x0.994 | level | 2 of 4 | - | - | x0.996 | x0.993 | x1.005 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 MiB | 0.0501 | 0.0507 | x1.010 | level | 1 of 4 | - | - | x1.010 | x1.020 | x1.013 |
| blake3-servil-mt / shared-one-cache / Interleaved / 256 | 0.137 | 0.136 | x0.998 | level | 2 of 4 | - | - | x0.998 | x0.999 | x0.991 |
| blake3-servil-mt / shared-one-cache / Collection / git objects | 0.0157 | 0.0163 | x1.042 | level | 0 of 4 | - | - | x0.883 | x0.894 | x0.900 |
| blake3-servil-mt / shared-one-cache / Collection / Nix files | 0.0182 | 0.0181 | x0.990 | level | 2 of 4 | - | - | x1.025 | x1.024 | x1.000 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16 | 7.558 | 7.567 | x1.001 | level | 1 of 4 | - | - | x1.001 | x0.997 | x1.053 |
| blake3-servil-mt / shared-one-cache / LentBatches / 64 | 6.660 | 6.781 | x1.018 | level | 2 of 4 | - | - | x0.998 | x0.999 | x0.898 |
| blake3-servil-mt / shared-one-cache / LentBatches / 256 | 6.589 | 6.592 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.229 |
| blake3-servil-mt / shared-one-cache / LentBatches / 1024 | 7.049 | 7.040 | x0.999 | level | 4 of 4 | - | - | x0.999 | x1.000 | x0.912 |
| blake3-servil-mt / shared-one-cache / LentBatches / 4096 | 6.837 | 6.811 | x0.996 | level | 4 of 4 | - | - | x0.996 | x1.000 | x0.898 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16384 | 3.713 | 3.789 | x1.021 | level | 1 of 4 | - | - | x1.018 | x1.007 | x0.996 |
| blake3-servil-mt / shared-one-cache / LentBatches / 65536 | 3.133 | 3.350 | x1.069 | level | 1 of 4 | - | - | x1.079 | x1.041 | x1.118 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.0587 | 0.0593 | x1.010 | level | 0 of 4 | - | - | x1.009 | x1.005 | x1.006 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / Nix files | 0.0585 | 0.0588 | x1.005 | level | 2 of 4 | - | - | x0.992 | x0.997 | x0.995 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1024 | 0.124 | 0.124 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.001 | x1.110 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 4096 | 0.0763 | 0.0778 | x1.020 | level | 1 of 4 | - | - | x1.019 | x1.005 | x0.989 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 16384 | 0.101 | 0.102 | x1.010 | level | 2 of 4 | - | - | x1.007 | x0.984 | x1.030 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 | 0.124 | 0.123 | x0.990 | level | 3 of 4 | - | - | x0.989 | x0.996 | x0.989 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 262144 | 0.0698 | 0.0689 | x0.987 | level | 2 of 4 | - | - | x0.989 | x0.995 | x0.975 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 32 B | 0.189 | 0.167 | x0.888 | level | 1 of 4 | - | - | x0.883 | x1.170 | x0.732 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 32 B | 0.0799 | 0.0812 | x1.017 | level | 0 of 4 | - | - | x1.021 | x1.033 | x1.025 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 16 B | 0.187 | 0.184 | x0.989 | level | 3 of 4 | - | - | x0.978 | x0.962 | x0.969 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 48 B | 0.123 | 0.127 | x1.026 | level | 2 of 4 | - | - | x1.022 | x0.985 | x1.017 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 48 B | 0.0670 | 0.0673 | x1.004 | level | 2 of 4 | - | - | x1.006 | x0.989 | x0.972 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.0459 | 0.0488 | x1.063 | level | 0 of 4 | - | - | x1.061 | x1.009 | x0.988 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 2 μs | 0.0921 | 0.0921 | x1.000 | level | 3 of 4 | - | - | x0.995 | x1.013 | x0.996 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 4 of 4 | - | - | x0.885 | x1.009 | x0.723 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 64 B | 0.946 | 0.967 | x1.021 | level | 0 of 4 | - | - | x1.022 | x1.006 | x1.104 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 1 KiB | 1.244 | 1.246 | x1.002 | level | 0 of 4 | - | - | x1.002 | x1.001 | x1.205 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 4 KiB | 0.364 | 0.365 | x1.001 | level | 0 of 4 | - | - | x1.001 | x1.001 | x1.023 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 16.920 | 17.411 | x1.029 | level | 1 of 4 | - | - | x0.898 | x1.002 | x0.998 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 4 KiB | 0.263 | 0.354 | x1.348 | level | 0 of 4 | - | - | x1.046 | x0.995 | x0.977 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 1 MiB | 0.0397 | 0.0398 | x1.002 | level | 3 of 4 | - | - | x1.004 | x1.017 | x0.988 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 64 B | 0.364 | 0.375 | x1.030 | level | 2 of 4 | - | - | x1.029 | x0.955 | x1.018 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 4 KiB | 0.0794 | 0.0761 | x0.959 | level | 3 of 4 | - | - | x0.967 | x0.974 | x0.994 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 1 MiB | 0.00617 | 0.00635 | x1.030 | level | 2 of 4 | - | - | x0.891 | x0.871 | x0.829 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 B | 0.922 | 0.578 | x0.626 | faster | 4 of 4 | - | - | x0.627 | x0.962 | x0.974 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 128 B | 0.468 | 0.339 | x0.726 | faster | 4 of 4 | - | - | x0.726 | x0.962 | x0.894 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 256 B | 0.254 | 0.217 | x0.855 | level | 4 of 4 | - | - | x0.853 | x0.963 | x0.884 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 512 B | 0.152 | 0.128 | x0.842 | level | 3 of 4 | - | - | x0.842 | x0.965 | x0.910 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 KiB | 0.123 | 0.0973 | x0.794 | level | 4 of 4 | - | - | x0.797 | x0.971 | x0.965 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 4 KiB | 0.0992 | 0.0960 | x0.967 | level | 2 of 4 | - | - | x0.961 | x0.994 | x0.967 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 16 KiB | 0.0800 | 0.0727 | x0.909 | level | 3 of 4 | - | - | x0.907 | x1.020 | x1.012 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 KiB | 0.0749 | 0.0618 | x0.824 | level | 4 of 4 | - | - | x0.828 | x1.021 | x1.030 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 256 KiB | 0.0740 | 0.0619 | x0.837 | level | 4 of 4 | - | - | x0.835 | x1.020 | x1.033 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 MiB | 0.0745 | 0.0567 | x0.762 | level | 4 of 4 | - | - | x0.762 | x1.020 | x0.992 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 4 MiB | 0.0699 | 0.0544 | x0.778 | level | 4 of 4 | - | - | x0.781 | x1.018 | x1.000 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 16 MiB | 0.0725 | 0.0545 | x0.751 | level | 4 of 4 | - | - | x0.756 | x1.020 | x1.023 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 MiB | 0.0738 | 0.0630 | x0.853 | level | 4 of 4 | - | - | x0.851 | x1.019 | x1.025 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 16 | 9.050 | 8.608 | x0.951 | level | 2 of 4 | - | - | x0.947 | x0.964 | x0.971 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 64 | 7.103 | 6.049 | x0.852 | level | 4 of 4 | - | - | x0.851 | x0.977 | x1.030 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 256 | 6.729 | 5.774 | x0.858 | level | 4 of 4 | - | - | x0.858 | x0.993 | x1.001 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 1024 | 5.870 | 4.652 | x0.793 | level | 4 of 4 | - | - | x0.795 | x0.983 | x0.981 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 4096 | 5.287 | 5.315 | x1.005 | level | 2 of 4 | - | - | x1.005 | x0.991 | x0.998 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 16384 | 4.413 | 4.415 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.004 | x0.998 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 65536 | 3.262 | 3.181 | x0.975 | level | 3 of 4 | - | - | x0.975 | x0.993 | x0.999 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 B | 0.939 | 0.939 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.012 | x0.891 |
| blake3-servil-mt / shared-two-caches / LentMessages / 128 B | 1.077 | 1.079 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.007 | x0.896 |
| blake3-servil-mt / shared-two-caches / LentMessages / 256 B | 1.151 | 1.154 | x1.002 | level | 0 of 4 | - | - | x1.002 | x1.004 | x0.998 |
| blake3-servil-mt / shared-two-caches / LentMessages / 512 B | 1.188 | 1.189 | x1.001 | level | 1 of 4 | - | - | x1.000 | x1.002 | x0.899 |
| blake3-servil-mt / shared-two-caches / LentMessages / 1 KiB | 1.211 | 1.211 | x1.000 | level | 4 of 4 | - | - | x1.000 | x1.001 | x0.745 |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 KiB | 0.358 | 0.358 | x0.999 | level | 4 of 4 | - | - | x0.999 | x1.001 | x0.948 |
| blake3-servil-mt / shared-two-caches / LentMessages / 16 KiB | 0.114 | 0.114 | x0.996 | level | 4 of 4 | - | - | x0.996 | x1.000 | x1.090 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 KiB | 0.0811 | 0.0809 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.891 |
| blake3-servil-mt / shared-two-caches / LentMessages / 256 KiB | 0.0771 | 0.0773 | x1.002 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.132 |
| blake3-servil-mt / shared-two-caches / LentMessages / 1 MiB | 0.0635 | 0.0642 | x1.010 | level | 1 of 4 | - | - | x1.009 | x1.010 | x1.001 |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 MiB | 0.0431 | 0.0451 | x1.047 | level | 1 of 4 | - | - | x1.045 | x0.997 | x0.984 |
| blake3-servil-mt / shared-two-caches / LentMessages / 16 MiB | 0.0382 | 0.0377 | x0.988 | level | 2 of 4 | - | - | x0.988 | x1.024 | x0.992 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 MiB | 0.0373 | 0.0371 | x0.996 | level | 2 of 4 | - | - | x1.000 | x0.998 | x1.000 |
| blake3-servil-mt / shared-two-caches / Interleaved / 256 | 0.137 | 0.136 | x0.997 | level | 3 of 4 | - | - | x0.997 | x0.998 | x0.986 |
| blake3-servil-mt / shared-two-caches / Collection / git objects | 0.0157 | 0.0157 | x0.999 | level | 2 of 4 | - | - | x1.006 | x0.998 | x0.994 |
| blake3-servil-mt / shared-two-caches / Collection / Nix files | 0.0172 | 0.0175 | x1.020 | level | 0 of 4 | - | - | x1.006 | x1.023 | x1.010 |
| blake3-servil-mt / shared-two-caches / LentBatches / 16 | 7.545 | 7.556 | x1.002 | level | 1 of 4 | - | - | x1.002 | x0.997 | x1.185 |
| blake3-servil-mt / shared-two-caches / LentBatches / 64 | 6.629 | 6.639 | x1.001 | level | 2 of 4 | - | - | x1.001 | x0.999 | x0.930 |
| blake3-servil-mt / shared-two-caches / LentBatches / 256 | 6.584 | 6.590 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.134 |
| blake3-servil-mt / shared-two-caches / LentBatches / 1024 | 7.044 | 7.033 | x0.999 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.909 |
| blake3-servil-mt / shared-two-caches / LentBatches / 4096 | 6.965 | 6.935 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.889 |
| blake3-servil-mt / shared-two-caches / LentBatches / 16384 | 4.263 | 4.367 | x1.024 | level | 1 of 4 | - | - | x1.019 | x0.989 | x1.001 |
| blake3-servil-mt / shared-two-caches / LentBatches / 65536 | 2.967 | 2.946 | x0.993 | level | 3 of 4 | - | - | x0.992 | x1.001 | x0.980 |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / git objects | 0.0724 | 0.0661 | x0.913 | level | 3 of 4 | - | - | x0.914 | x1.005 | x1.005 |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / Nix files | 0.0690 | 0.0662 | x0.960 | level | 3 of 4 | - | - | x0.961 | x1.002 | x1.013 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1024 | 0.126 | 0.126 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.001 | x1.085 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 4096 | 0.0748 | 0.0741 | x0.991 | level | 3 of 4 | - | - | x0.983 | x0.996 | x0.994 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 16384 | 0.0902 | 0.0878 | x0.974 | level | 3 of 4 | - | - | x0.974 | x1.001 | x1.007 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 | 0.0830 | 0.0824 | x0.993 | level | 2 of 4 | - | - | x0.992 | x0.995 | x0.994 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 262144 | 0.0622 | 0.0592 | x0.953 | level | 4 of 4 | - | - | x0.949 | x0.913 | x0.963 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 x 32 B | 0.178 | 0.168 | x0.945 | level | 3 of 4 | - | - | x0.947 | x1.083 | x0.922 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 32 B | 0.0808 | 0.0804 | x0.994 | level | 2 of 4 | - | - | x0.992 | x0.976 | x1.046 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 16 B | 0.160 | 0.157 | x0.978 | level | 4 of 4 | - | - | x0.971 | x0.947 | x0.994 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 x 48 B | 0.135 | 0.128 | x0.945 | level | 2 of 4 | - | - | x0.945 | x1.045 | x0.927 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 48 B | 0.0648 | 0.0651 | x1.005 | level | 1 of 4 | - | - | x1.007 | x1.001 | x0.974 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / saturated | 0.0745 | 0.0608 | x0.817 | level | 4 of 4 | - | - | x0.815 | x1.018 | x0.999 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / 2 μs | 0.101 | 0.0922 | x0.909 | faster | 4 of 4 | - | - | x0.898 | x1.013 | x1.042 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 2 of 4 | - | - | x0.807 | x0.998 | x0.960 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 64 B | 0.946 | 0.966 | x1.022 | level | 0 of 4 | - | - | x1.022 | x1.006 | x1.162 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 1 KiB | 1.244 | 1.246 | x1.002 | level | 0 of 4 | - | - | x1.002 | x1.001 | x1.270 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 4 KiB | 0.364 | 0.364 | x1.001 | level | 0 of 4 | - | - | x1.001 | x1.001 | x0.956 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 64 B | 17.413 | 17.036 | x0.978 | level | 4 of 4 | - | - | x0.983 | x0.998 | x1.004 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 4 KiB | 0.277 | 0.296 | x1.070 | level | 0 of 4 | - | - | x1.031 | x1.018 | x0.983 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 1 MiB | 0.0819 | 0.0586 | x0.716 | faster | 4 of 4 | - | - | x0.725 | x1.020 | x0.989 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 64 B | 0.426 | 0.431 | x1.011 | level | 2 of 4 | - | - | x1.011 | x0.955 | x1.004 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 4 KiB | 0.0682 | 0.0614 | x0.900 | level | 4 of 4 | - | - | x0.959 | x0.967 | x0.989 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 1 MiB | 0.00710 | 0.00668 | x0.941 | level | 3 of 4 | - | - | x0.855 | x0.832 | x0.754 |

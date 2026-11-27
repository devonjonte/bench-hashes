# Nightly drift check: e1966b498bc7 -> 0997700f35b0

- Host: electric-rhino
- Experiment: `bench=3f119a507807078649d8700112994fce24666868|base=e1966b498bc769db3d51451a4ddc8188a19ed593|target=0997700f35b06db27b70dc4659964561ae500038|cells=all|layouts=default`
- bench-hashes: `3f119a507807078649d8700112994fce24666868`
- BLAKE3-Servil base: `e1966b498bc769db3d51451a4ddc8188a19ed593`
- BLAKE3-Servil target: `0997700f35b06db27b70dc4659964561ae500038`
- Scope: `--cells all` (layouts: default)
- Deciding stage: stage 2 (kept-drift/second)
- Verdict: **REGRESSION** (exit `1`)

## Stage 2 (deciding, kept-drift/second)

compare: old side: bench 3f119a507807 clean; servil e1966b498bc7 clean
compare: new side: bench 3f119a507807 clean; servil 0997700f35b0 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / ManyMessages / 1 | 633.965 | 677.731 | x1.069 | slower | 19 of 64 | - | - | x1.071 | x1.010 | x1.025 |
| blake3-servil-st / solo / ManyMessages / 2 | 304.910 | 297.180 | x0.975 | level | 35 of 64 | - | - | x0.973 | x0.997 | x0.990 |
| blake3-servil-st / solo / ManyMessages / 8 | 222.510 | 222.044 | x0.998 | level | 31 of 64 | - | - | x0.999 | x0.998 | x0.996 |
| blake3-servil-st / solo / ManyMessages / 48 | 48.304 | 47.243 | x0.978 | level | 37 of 64 | - | - | x0.979 | x1.002 | x1.015 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.208 | 0.208 | x0.998 | level | 33 of 64 | - | - | x1.001 | x0.999 | x1.005 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 0.952 | 0.954 | x1.003 | level | 2 of 64 | x1.003 | - | x1.003 | x1.013 | x0.886 |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 0.909 | 0.914 | x1.005 | level | 2 of 64 | x1.005 | - | x1.004 | x1.015 | x0.922 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.0493 | 0.0469 | x0.952 | level | 47 of 64 | x0.846 | - | x0.954 | x0.988 | x1.074 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.0597 | 0.0626 | x1.050 | level | 15 of 64 | - | - | x1.050 | x0.988 | x1.034 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 KiB | 0.108 | 0.103 | x0.951 | level | 45 of 64 | - | - | x0.952 | x0.987 | x0.954 |

## Stage 1 (initial screen, kept-drift)

compare: old side: bench 3f119a507807 clean; servil e1966b498bc7 clean
compare: new side: bench 3f119a507807 clean; servil 0997700f35b0 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 5.670 | 5.243 | x0.925 | level | 1 of 4 | - | - | x0.952 | x1.010 | x1.018 |
| blake3-servil-st / solo / OneMessage / 128 B | 3.535 | 3.579 | x1.013 | level | 1 of 4 | - | - | x0.999 | x1.004 | x1.048 |
| blake3-servil-st / solo / OneMessage / 256 B | 2.586 | 2.594 | x1.003 | level | 1 of 4 | - | - | x1.003 | x1.007 | x1.084 |
| blake3-servil-st / solo / OneMessage / 512 B | 1.911 | 1.859 | x0.973 | level | 3 of 4 | - | - | x0.973 | x1.007 | x1.044 |
| blake3-servil-st / solo / OneMessage / 1 KiB | 1.644 | 1.627 | x0.989 | level | 3 of 4 | - | - | x0.989 | x1.004 | x1.031 |
| blake3-servil-st / solo / OneMessage / 1536 B | 1.485 | 1.438 | x0.969 | level | 3 of 4 | - | - | x0.978 | x1.000 | x1.005 |
| blake3-servil-st / solo / OneMessage / 2 KiB | 0.985 | 0.971 | x0.985 | level | 3 of 4 | - | - | x0.988 | x1.004 | x1.008 |
| blake3-servil-st / solo / OneMessage / 2304 B | 1.183 | 1.154 | x0.975 | level | 3 of 4 | - | - | x0.975 | x1.003 | x1.033 |
| blake3-servil-st / solo / OneMessage / 3 KiB | 0.798 | 0.818 | x1.026 | level | 1 of 4 | - | - | x1.028 | x1.002 | x1.047 |
| blake3-servil-st / solo / OneMessage / 3839 B | 0.798 | 0.811 | x1.016 | level | 1 of 4 | - | - | x1.020 | x1.001 | x1.049 |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.575 | 0.572 | x0.996 | level | 3 of 4 | - | - | x0.999 | x0.998 | x1.051 |
| blake3-servil-st / solo / OneMessage / 4470 B | 0.689 | 0.685 | x0.994 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.062 |
| blake3-servil-st / solo / OneMessage / 7935 B | 0.594 | 0.608 | x1.023 | level | 1 of 4 | - | - | x1.023 | x1.001 | x1.037 |
| blake3-servil-st / solo / OneMessage / 8 KiB | 0.433 | 0.431 | x0.993 | level | 2 of 4 | - | - | x0.994 | x1.001 | x1.050 |
| blake3-servil-st / solo / OneMessage / 16 KiB | 0.301 | 0.305 | x1.016 | level | 0 of 4 | - | - | x1.009 | x1.001 | x1.026 |
| blake3-servil-st / solo / OneMessage / 32 KiB | 0.204 | 0.197 | x0.967 | level | 3 of 4 | - | - | x0.967 | x1.000 | x1.025 |
| blake3-servil-st / solo / OneMessage / 64 KiB | 0.154 | 0.147 | x0.956 | level | 4 of 4 | - | - | x0.957 | x1.000 | x0.999 |
| blake3-servil-st / solo / OneMessage / 128 KiB | 0.126 | 0.124 | x0.986 | level | 3 of 4 | - | - | x0.989 | x1.000 | x1.020 |
| blake3-servil-st / solo / OneMessage / 256 KiB | 0.114 | 0.112 | x0.986 | level | 3 of 4 | - | - | x0.987 | x1.000 | x1.009 |
| blake3-servil-st / solo / OneMessage / 512 KiB | 0.103 | 0.102 | x0.992 | level | 3 of 4 | - | - | x0.994 | x1.000 | x1.080 |
| blake3-servil-st / solo / OneMessage / 1 MiB | 0.0976 | 0.0976 | x1.000 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.060 |
| blake3-servil-st / solo / OneMessage / 2 MiB | 0.0987 | 0.0984 | x0.997 | level | 4 of 4 | - | - | x0.996 | x1.000 | x1.048 |
| blake3-servil-st / solo / OneMessage / 3 MiB | 0.101 | 0.0999 | x0.992 | level | 4 of 4 | - | - | x0.991 | x1.000 | x1.052 |
| blake3-servil-st / solo / OneMessage / 4 MiB | 0.0985 | 0.0984 | x0.999 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.051 |
| blake3-servil-st / solo / OneMessage / 8 MiB | 0.105 | 0.105 | x0.999 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.075 |
| blake3-servil-st / solo / OneMessage / 32 MiB | 0.115 | 0.115 | x1.002 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.055 |
| blake3-servil-st / solo / OneMessage / 64 MiB | 0.115 | 0.115 | x1.006 | level | 1 of 4 | - | - | x1.006 | x1.000 | x1.054 |
| blake3-servil-st / solo / OneMessage / 128 MiB | 0.115 | 0.116 | x1.007 | level | 1 of 4 | - | - | x1.007 | x1.000 | x1.060 |
| blake3-servil-st / solo / ManyMessages / 1 | 438.227 | 466.993 | x1.066 | level | 1 of 4 | - | - | x1.053 | x1.017 | x1.129 |
| blake3-servil-st / solo / ManyMessages / 2 | 265.499 | 281.433 | x1.060 | level | 0 of 4 | - | - | x1.014 | x1.007 | x0.997 |
| blake3-servil-st / solo / ManyMessages / 3 | 202.819 | 213.338 | x1.052 | level | 0 of 4 | - | - | x1.001 | x1.009 | x0.960 |
| blake3-servil-st / solo / ManyMessages / 4 | 151.441 | 150.424 | x0.993 | level | 2 of 4 | - | - | x0.978 | x1.010 | x0.976 |
| blake3-servil-st / solo / ManyMessages / 6 | 117.793 | 120.926 | x1.027 | level | 1 of 4 | - | - | x0.988 | x1.002 | x0.987 |
| blake3-servil-st / solo / ManyMessages / 8 | 162.667 | 181.706 | x1.117 | level | 0 of 4 | - | - | x1.080 | x1.006 | x0.997 |
| blake3-servil-st / solo / ManyMessages / 12 | 127.800 | 124.859 | x0.977 | level | 2 of 4 | - | - | x0.971 | x1.006 | x1.000 |
| blake3-servil-st / solo / ManyMessages / 16 | 98.022 | 99.130 | x1.011 | level | 3 of 4 | - | - | x0.995 | x1.006 | x0.998 |
| blake3-servil-st / solo / ManyMessages / 24 | 100.794 | 97.468 | x0.967 | level | 2 of 4 | - | - | x0.963 | x1.001 | x0.986 |
| blake3-servil-st / solo / ManyMessages / 32 | 47.812 | 47.448 | x0.992 | level | 2 of 4 | - | - | x0.986 | x0.999 | x0.984 |
| blake3-servil-st / solo / ManyMessages / 48 | 33.448 | 35.567 | x1.063 | level | 1 of 4 | - | - | x1.037 | x1.003 | x0.998 |
| blake3-servil-st / solo / ManyMessages / 64 | 27.459 | 28.358 | x1.033 | level | 1 of 4 | - | - | x1.021 | x0.996 | x1.006 |
| blake3-servil-st / solo / ManyMessages / 128 | 18.840 | 18.670 | x0.991 | level | 2 of 4 | - | - | x0.989 | x0.998 | x1.013 |
| blake3-servil-st / solo / ManyMessages / 256 | 13.635 | 13.810 | x1.013 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.994 |
| blake3-servil-st / solo / ManyMessages / 512 | 11.114 | 11.243 | x1.012 | level | 2 of 4 | - | - | x1.004 | x1.000 | x0.977 |
| blake3-servil-st / solo / ManyMessages / 1024 | 9.772 | 9.675 | x0.990 | level | 2 of 4 | - | - | x0.992 | x1.000 | x0.942 |
| blake3-servil-st / solo / ManyMessages / 2048 | 9.119 | 9.048 | x0.992 | level | 3 of 4 | - | - | x0.992 | x1.000 | x0.901 |
| blake3-servil-st / solo / ManyMessages / 4096 | 8.882 | 8.841 | x0.995 | level | 3 of 4 | - | - | x0.983 | x1.000 | x0.920 |
| blake3-servil-st / solo / ManyMessages / 8192 | 8.223 | 8.220 | x1.000 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.912 |
| blake3-servil-st / solo / ManyMessages / 16384 | 7.854 | 7.845 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.938 |
| blake3-servil-st / solo / ManyMessages / 32768 | 7.900 | 7.872 | x0.996 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.977 |
| blake3-servil-st / solo / ManyMessages / 65536 | 7.979 | 7.969 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.018 |
| blake3-servil-st / solo / ManyMessages / 131072 | 8.349 | 8.347 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.011 |
| blake3-servil-st / solo / ManyMessages / 262144 | 8.752 | 8.795 | x1.005 | level | 1 of 4 | - | - | x1.005 | x1.000 | x1.023 |
| blake3-servil-st / solo / ManyLongMessages / 4 | 1831.574 | 1853.452 | x1.012 | level | 2 of 4 | - | - | x1.002 | x1.001 | x1.016 |
| blake3-servil-st / solo / ManyLongMessages / 16 | 1640.402 | 668.066 | x0.407 | faster | 4 of 4 | - | - | x0.413 | x0.575 | x1.284 |
| blake3-servil-st / solo / ManyLongMessages / 64 | 570.530 | 559.901 | x0.981 | level | 4 of 4 | - | - | x0.981 | x0.998 | x0.911 |
| blake3-servil-st / solo / ManyLongMessages / 256 | 520.070 | 517.359 | x0.995 | level | 3 of 4 | - | - | x0.994 | x0.998 | x0.906 |
| blake3-servil-st / solo / IdleOneMessage / 64 B | 3.112 | 3.043 | x0.978 | level | 2 of 4 | - | - | x1.010 | x1.014 | x0.809 |
| blake3-servil-st / solo / IdleOneMessage / 128 B | 2.195 | 2.160 | x0.984 | level | 3 of 4 | - | - | x1.005 | x1.011 | x0.329 |
| blake3-servil-st / solo / IdleOneMessage / 256 B | 1.779 | 1.769 | x0.994 | level | 2 of 4 | - | - | x1.006 | x1.008 | x1.982 |
| blake3-servil-st / solo / IdleOneMessage / 512 B | 1.639 | 1.614 | x0.985 | level | 2 of 4 | - | - | x1.005 | x1.005 | x2.901 |
| blake3-servil-st / solo / IdleOneMessage / 1 KiB | 1.552 | 1.526 | x0.983 | level | 3 of 4 | - | - | x1.004 | x1.003 | x1.400 |
| blake3-servil-st / solo / IdleOneMessage / 1536 B | 1.178 | 1.157 | x0.982 | level | 3 of 4 | - | - | x0.997 | x0.999 | x1.150 |
| blake3-servil-st / solo / IdleOneMessage / 2 KiB | 0.870 | 0.860 | x0.989 | level | 2 of 4 | - | - | x1.001 | x1.002 | x1.253 |
| blake3-servil-st / solo / IdleOneMessage / 2304 B | 0.979 | 0.968 | x0.989 | level | 3 of 4 | - | - | x0.996 | x1.003 | x0.819 |
| blake3-servil-st / solo / IdleOneMessage / 3 KiB | 0.630 | 0.628 | x0.996 | level | 2 of 4 | - | - | x1.003 | x1.002 | x1.698 |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 0.516 | 0.522 | x1.012 | level | 1 of 4 | - | - | x0.994 | x1.002 | x0.550 |
| blake3-servil-st / solo / IdleOneMessage / 4 KiB | 0.465 | 0.472 | x1.015 | level | 0 of 4 | - | - | x1.001 | x1.002 | x1.115 |
| blake3-servil-st / solo / IdleOneMessage / 4470 B | 0.583 | 0.586 | x1.005 | level | 2 of 4 | - | - | x0.998 | x1.002 | x0.542 |
| blake3-servil-st / solo / IdleOneMessage / 7935 B | 0.293 | 0.296 | x1.010 | level | 2 of 4 | - | - | x0.997 | x1.001 | x1.256 |
| blake3-servil-st / solo / IdleOneMessage / 8 KiB | 0.274 | 0.279 | x1.018 | level | 0 of 4 | - | - | x1.005 | x1.001 | x1.136 |
| blake3-servil-st / solo / IdleOneMessage / 16 KiB | 0.154 | 0.155 | x1.007 | level | 1 of 4 | - | - | x1.014 | x1.001 | x3.597 |
| blake3-servil-st / solo / IdleOneMessage / 32 KiB | 0.108 | 0.109 | x1.006 | level | 2 of 4 | - | - | x1.009 | x1.001 | x4.191 |
| blake3-servil-st / solo / IdleOneMessage / 64 KiB | 0.0995 | 0.0985 | x0.990 | level | 4 of 4 | - | - | x1.009 | x1.000 | x4.604 |
| blake3-servil-st / solo / IdleOneMessage / 128 KiB | 0.0937 | 0.0919 | x0.981 | level | 4 of 4 | - | - | x0.999 | x1.000 | x0.600 |
| blake3-servil-st / solo / IdleOneMessage / 256 KiB | 0.0919 | 0.0905 | x0.985 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.386 |
| blake3-servil-st / solo / IdleOneMessage / 512 KiB | 0.0975 | 0.0960 | x0.985 | level | 3 of 4 | - | - | x0.992 | x1.000 | x0.947 |
| blake3-servil-st / solo / IdleOneMessage / 1 MiB | 0.0949 | 0.0943 | x0.994 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.033 |
| blake3-servil-st / solo / IdleOneMessage / 2 MiB | 0.0885 | 0.0884 | x0.999 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.065 |
| blake3-servil-st / solo / IdleOneMessage / 3 MiB | 0.0874 | 0.0873 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.060 |
| blake3-servil-st / solo / IdleOneMessage / 4 MiB | 0.0873 | 0.0870 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.049 |
| blake3-servil-st / solo / IdleOneMessage / 8 MiB | 0.0882 | 0.0882 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.093 |
| blake3-servil-st / solo / IdleOneMessage / 32 MiB | 0.114 | 0.114 | x1.003 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.047 |
| blake3-servil-st / solo / IdleOneMessage / 64 MiB | 0.115 | 0.116 | x1.007 | level | 1 of 4 | - | - | x1.007 | x1.000 | x1.058 |
| blake3-servil-st / solo / IdleOneMessage / 128 MiB | 0.115 | 0.116 | x1.005 | level | 2 of 4 | - | - | x1.007 | x1.000 | x1.057 |
| blake3-servil-st / solo / IdleManyMessages / 1 | 204.891 | 208.380 | x1.017 | level | 1 of 4 | - | - | x1.009 | x1.013 | x1.085 |
| blake3-servil-st / solo / IdleManyMessages / 2 | 104.625 | 105.011 | x1.004 | level | 2 of 4 | - | - | x1.002 | x1.002 | x0.573 |
| blake3-servil-st / solo / IdleManyMessages / 3 | 90.618 | 91.956 | x1.015 | level | 1 of 4 | - | - | x1.002 | x1.002 | x1.789 |
| blake3-servil-st / solo / IdleManyMessages / 4 | 53.352 | 54.217 | x1.016 | level | 2 of 4 | - | - | x1.007 | x1.002 | x4.839 |
| blake3-servil-st / solo / IdleManyMessages / 6 | 51.259 | 52.596 | x1.026 | level | 1 of 4 | - | - | x1.009 | x1.002 | x0.717 |
| blake3-servil-st / solo / IdleManyMessages / 8 | 33.809 | 33.414 | x0.988 | level | 2 of 4 | - | - | x0.993 | x1.002 | x0.351 |
| blake3-servil-st / solo / IdleManyMessages / 12 | 31.541 | 31.406 | x0.996 | level | 3 of 4 | - | - | x1.005 | x1.001 | x2.892 |
| blake3-servil-st / solo / IdleManyMessages / 16 | 18.357 | 18.247 | x0.994 | level | 3 of 4 | - | - | x1.000 | x1.002 | x0.616 |
| blake3-servil-st / solo / IdleManyMessages / 24 | 17.312 | 17.494 | x1.011 | level | 1 of 4 | - | - | x1.007 | x1.001 | x0.286 |
| blake3-servil-st / solo / IdleManyMessages / 32 | 12.913 | 13.095 | x1.014 | level | 0 of 4 | - | - | x0.998 | x1.001 | x0.446 |
| blake3-servil-st / solo / IdleManyMessages / 48 | 11.461 | 11.517 | x1.005 | level | 1 of 4 | - | - | x1.009 | x1.001 | x4.376 |
| blake3-servil-st / solo / IdleManyMessages / 64 | 10.462 | 10.506 | x1.004 | level | 2 of 4 | - | - | x1.014 | x1.001 | x3.780 |
| blake3-servil-st / solo / IdleManyMessages / 128 | 9.339 | 9.202 | x0.985 | level | 3 of 4 | - | - | x1.005 | x1.000 | x0.846 |
| blake3-servil-st / solo / IdleManyMessages / 256 | 8.747 | 8.707 | x0.995 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.763 |
| blake3-servil-st / solo / IdleManyMessages / 512 | 8.365 | 8.423 | x1.007 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.554 |
| blake3-servil-st / solo / IdleManyMessages / 1024 | 8.184 | 8.183 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.155 |
| blake3-servil-st / solo / IdleManyMessages / 2048 | 8.089 | 8.024 | x0.992 | level | 2 of 4 | - | - | x0.991 | x1.000 | x0.653 |
| blake3-servil-st / solo / IdleManyMessages / 4096 | 7.972 | 8.024 | x1.007 | level | 1 of 4 | - | - | x0.998 | x1.000 | x0.784 |
| blake3-servil-st / solo / IdleManyMessages / 8192 | 8.168 | 8.246 | x1.010 | level | 0 of 4 | - | - | x1.002 | x1.000 | x0.914 |
| blake3-servil-st / solo / IdleManyMessages / 16384 | 7.858 | 7.957 | x1.013 | level | 0 of 4 | - | - | x1.004 | x1.000 | x0.934 |
| blake3-servil-st / solo / IdleManyMessages / 32768 | 7.494 | 7.516 | x1.003 | level | 0 of 4 | - | - | x1.003 | x1.000 | x0.970 |
| blake3-servil-st / solo / IdleManyMessages / 65536 | 7.451 | 7.448 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.976 |
| blake3-servil-st / solo / IdleManyMessages / 131072 | 7.462 | 7.432 | x0.996 | level | 4 of 4 | - | - | x0.996 | x1.000 | x0.945 |
| blake3-servil-st / solo / IdleManyMessages / 262144 | 8.025 | 8.007 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.981 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 B | 3.028 | 3.023 | x0.998 | level | 2 of 4 | - | - | x1.005 | x1.014 | x1.020 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 B | 2.144 | 2.131 | x0.994 | level | 2 of 4 | - | - | x1.008 | x1.012 | x0.503 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 B | 1.688 | 1.710 | x1.013 | level | 0 of 4 | - | - | x1.005 | x1.008 | x1.424 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 B | 1.456 | 1.461 | x1.003 | level | 1 of 4 | - | - | x1.003 | x1.005 | x0.550 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 KiB | 1.354 | 1.350 | x0.997 | level | 1 of 4 | - | - | x1.001 | x1.003 | x0.682 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1536 B | 1.018 | 1.022 | x1.004 | level | 3 of 4 | - | - | x1.000 | x0.999 | x1.194 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 KiB | 0.730 | 0.731 | x1.001 | level | 2 of 4 | - | - | x1.002 | x1.002 | x1.081 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2304 B | 0.815 | 0.811 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.003 | x1.144 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.523 | 0.529 | x1.010 | level | 3 of 4 | - | - | x1.000 | x1.002 | x0.379 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3839 B | 0.426 | 0.426 | x1.000 | level | 2 of 4 | - | - | x1.002 | x1.002 | x1.021 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 KiB | 0.390 | 0.393 | x1.009 | level | 0 of 4 | - | - | x1.002 | x1.002 | x3.550 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4470 B | 0.482 | 0.482 | x1.000 | level | 3 of 4 | - | - | x1.001 | x1.002 | x0.427 |
| blake3-servil-st / solo / BriefIdleOneMessage / 7935 B | 0.242 | 0.242 | x1.000 | level | 2 of 4 | - | - | x0.998 | x1.001 | x1.252 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 KiB | 0.226 | 0.224 | x0.992 | level | 2 of 4 | - | - | x1.002 | x1.001 | x1.357 |
| blake3-servil-st / solo / BriefIdleOneMessage / 16 KiB | 0.127 | 0.127 | x1.004 | level | 1 of 4 | - | - | x1.005 | x1.001 | x1.034 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 KiB | 0.0886 | 0.0881 | x0.994 | level | 3 of 4 | - | - | x0.995 | x1.001 | x0.812 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 KiB | 0.0814 | 0.0808 | x0.993 | level | 4 of 4 | - | - | x0.994 | x1.000 | x0.628 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 KiB | 0.0779 | 0.0781 | x1.001 | level | 1 of 4 | - | - | x1.003 | x1.000 | x0.964 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 KiB | 0.0783 | 0.0774 | x0.988 | level | 3 of 4 | - | - | x0.990 | x1.000 | x1.408 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 KiB | 0.0845 | 0.0837 | x0.990 | level | 3 of 4 | - | - | x0.992 | x1.000 | x0.951 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 MiB | 0.0873 | 0.0872 | x0.999 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.989 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 MiB | 0.0880 | 0.0877 | x0.997 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.050 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 MiB | 0.0878 | 0.0874 | x0.995 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.039 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 MiB | 0.0877 | 0.0872 | x0.994 | level | 3 of 4 | - | - | x0.995 | x1.000 | x1.042 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 MiB | 0.0885 | 0.0882 | x0.997 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.048 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 MiB | 0.114 | 0.114 | x1.001 | level | 1 of 4 | - | - | x1.005 | x1.000 | x1.030 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 MiB | 0.115 | 0.116 | x1.010 | level | 1 of 4 | - | - | x1.006 | x1.000 | x1.058 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 MiB | 0.115 | 0.116 | x1.007 | level | 1 of 4 | - | - | x1.007 | x1.000 | x1.058 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1 | 206.774 | 204.477 | x0.989 | level | 2 of 4 | - | - | x0.999 | x1.014 | x0.996 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2 | 104.207 | 106.275 | x1.020 | level | 2 of 4 | - | - | x1.003 | x1.003 | x1.522 |
| blake3-servil-st / solo / BriefIdleManyMessages / 3 | 90.304 | 90.355 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.002 | x0.711 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4 | 52.647 | 53.347 | x1.013 | level | 2 of 4 | - | - | x1.004 | x1.003 | x1.474 |
| blake3-servil-st / solo / BriefIdleManyMessages / 6 | 45.722 | 45.785 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.002 | x1.028 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8 | 28.398 | 28.348 | x0.998 | level | 3 of 4 | - | - | x0.999 | x1.002 | x1.579 |
| blake3-servil-st / solo / BriefIdleManyMessages / 12 | 26.132 | 25.730 | x0.985 | level | 2 of 4 | - | - | x1.000 | x1.001 | x1.634 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16 | 14.672 | 14.677 | x1.000 | level | 2 of 4 | - | - | x1.003 | x1.002 | x1.347 |
| blake3-servil-st / solo / BriefIdleManyMessages / 24 | 13.766 | 13.715 | x0.996 | level | 3 of 4 | - | - | x1.003 | x1.001 | x1.748 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32 | 10.468 | 10.529 | x1.006 | level | 1 of 4 | - | - | x1.007 | x1.001 | x1.575 |
| blake3-servil-st / solo / BriefIdleManyMessages / 48 | 9.140 | 9.247 | x1.012 | level | 1 of 4 | - | - | x1.005 | x1.001 | x1.096 |
| blake3-servil-st / solo / BriefIdleManyMessages / 64 | 8.507 | 8.451 | x0.993 | level | 2 of 4 | - | - | x1.003 | x1.001 | x0.915 |
| blake3-servil-st / solo / BriefIdleManyMessages / 128 | 7.405 | 7.425 | x1.003 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.905 |
| blake3-servil-st / solo / BriefIdleManyMessages / 256 | 7.060 | 7.052 | x0.999 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.011 |
| blake3-servil-st / solo / BriefIdleManyMessages / 512 | 6.861 | 6.825 | x0.995 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.459 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1024 | 6.671 | 6.678 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.128 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2048 | 6.683 | 6.661 | x0.997 | level | 2 of 4 | - | - | x0.995 | x1.000 | x0.904 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4096 | 6.775 | 6.819 | x1.006 | level | 1 of 4 | - | - | x1.003 | x1.000 | x0.908 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8192 | 7.267 | 7.271 | x1.001 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.881 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16384 | 7.424 | 7.441 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.917 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32768 | 7.476 | 7.500 | x1.003 | level | 0 of 4 | - | - | x1.001 | x1.000 | x0.946 |
| blake3-servil-st / solo / BriefIdleManyMessages / 65536 | 7.461 | 7.463 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.930 |
| blake3-servil-st / solo / BriefIdleManyMessages / 131072 | 7.453 | 7.440 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.982 |
| blake3-servil-st / solo / BriefIdleManyMessages / 262144 | 8.030 | 8.006 | x0.997 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.927 |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.940 | 0.946 | x1.006 | level | 0 of 4 | x1.006 | - | x1.007 | x1.012 | x0.612 |
| blake3-servil-st / solo / ContinuousMessages / 128 B | 1.079 | 1.080 | x1.001 | level | 0 of 4 | x1.001 | - | x1.001 | x1.007 | x1.254 |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 1.154 | 1.154 | x1.000 | level | 2 of 4 | x1.000 | - | x1.001 | x1.004 | x1.561 |
| blake3-servil-st / solo / ContinuousMessages / 512 B | 1.190 | 1.189 | x0.999 | level | 4 of 4 | x0.998 | - | x1.000 | x1.002 | x1.784 |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 1.212 | 1.212 | x1.000 | level | 1 of 4 | x1.000 | - | x1.001 | x1.001 | x0.389 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.358 | 0.358 | x1.000 | level | 3 of 4 | x1.000 | - | x0.999 | x1.001 | x0.187 |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.114 | 0.114 | x1.003 | level | 2 of 4 | x1.003 | - | x0.999 | x1.000 | x3.179 |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.0811 | 0.0808 | x0.996 | level | 4 of 4 | x0.996 | - | x0.996 | x1.000 | x0.382 |
| blake3-servil-st / solo / ContinuousMessages / 256 KiB | 0.0829 | 0.0825 | x0.995 | level | 3 of 4 | x0.995 | - | x0.996 | x1.000 | x1.126 |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.0842 | 0.0860 | x1.021 | level | 1 of 4 | x1.022 | - | x1.001 | x1.000 | x1.037 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.0856 | 0.0854 | x0.997 | level | 3 of 4 | x0.997 | - | x0.998 | x1.000 | x0.986 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.0856 | 0.0855 | x0.999 | level | 2 of 4 | x0.999 | - | x1.000 | x1.000 | x1.204 |
| blake3-servil-st / solo / ContinuousMessages / 64 MiB | 0.0976 | 0.0974 | x0.998 | level | 3 of 4 | x0.998 | - | x0.996 | x1.000 | x1.008 |
| blake3-servil-st / solo / ContinuousBatches / 16 | 7.556 | 7.552 | x0.999 | level | 3 of 4 | x0.999 | - | x1.000 | x0.998 | x1.320 |
| blake3-servil-st / solo / ContinuousBatches / 64 | 6.648 | 6.673 | x1.004 | level | 1 of 4 | x1.004 | - | x1.003 | x0.999 | x2.889 |
| blake3-servil-st / solo / ContinuousBatches / 256 | 6.603 | 6.646 | x1.007 | level | 2 of 4 | x1.007 | - | x1.007 | x1.000 | x36.789 |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 7.030 | 7.035 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x105.738 |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 6.871 | 6.811 | x0.991 | level | 3 of 4 | x0.991 | - | x0.991 | x1.000 | x0.261 |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 7.609 | 7.582 | x0.996 | level | 2 of 4 | x0.997 | - | x0.997 | x1.000 | x0.797 |
| blake3-servil-st / solo / ContinuousBatches / 65536 | 7.674 | 7.684 | x1.001 | level | 3 of 4 | x1.001 | - | x1.003 | x1.000 | x1.208 |
| blake3-servil-st / solo / LentMessages / 64 B | 0.940 | 0.946 | x1.006 | level | 0 of 4 | x1.006 | - | x1.007 | x1.012 | x0.612 |
| blake3-servil-st / solo / LentMessages / 128 B | 1.079 | 1.080 | x1.001 | level | 0 of 4 | x1.001 | - | x1.001 | x1.007 | x1.254 |
| blake3-servil-st / solo / LentMessages / 256 B | 1.154 | 1.154 | x1.000 | level | 2 of 4 | x1.000 | - | x1.001 | x1.004 | x1.561 |
| blake3-servil-st / solo / LentMessages / 512 B | 1.190 | 1.189 | x0.999 | level | 4 of 4 | x0.998 | - | x1.000 | x1.002 | x1.784 |
| blake3-servil-st / solo / LentMessages / 1 KiB | 1.212 | 1.212 | x1.000 | level | 1 of 4 | x1.000 | - | x1.001 | x1.001 | x0.389 |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.358 | 0.358 | x1.000 | level | 3 of 4 | x1.000 | - | x0.999 | x1.001 | x0.187 |
| blake3-servil-st / solo / LentMessages / 16 KiB | 0.114 | 0.114 | x1.003 | level | 2 of 4 | x1.003 | - | x0.999 | x1.000 | x3.179 |
| blake3-servil-st / solo / LentMessages / 64 KiB | 0.0811 | 0.0808 | x0.996 | level | 4 of 4 | x0.996 | - | x0.996 | x1.000 | x0.382 |
| blake3-servil-st / solo / LentMessages / 256 KiB | 0.0761 | 0.0763 | x1.003 | level | 3 of 4 | x1.003 | - | x1.004 | x1.000 | x1.917 |
| blake3-servil-st / solo / LentMessages / 1 MiB | 0.0864 | 0.0862 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x0.918 |
| blake3-servil-st / solo / LentMessages / 4 MiB | 0.0862 | 0.0861 | x0.998 | level | 3 of 4 | x0.998 | - | x0.999 | x1.000 | x1.076 |
| blake3-servil-st / solo / LentMessages / 16 MiB | 0.0914 | 0.0955 | x1.044 | level | 2 of 4 | x1.035 | - | x1.019 | x1.000 | x1.161 |
| blake3-servil-st / solo / LentMessages / 64 MiB | 0.117 | 0.117 | x1.000 | level | 2 of 4 | x1.001 | - | x1.004 | x1.000 | x1.059 |
| blake3-servil-st / solo / Interleaved / 256 | 0.137 | 0.136 | x0.995 | level | 4 of 4 | x0.995 | - | x0.995 | x0.998 | x0.990 |
| blake3-servil-st / solo / Collection / git objects | 0.0987 | 0.0983 | x0.996 | level | 3 of 4 | x0.996 | - | x0.997 | x0.999 | x1.036 |
| blake3-servil-st / solo / Collection / Nix files | 0.0893 | 0.0891 | x0.998 | level | 2 of 4 | x0.998 | - | x1.000 | x0.999 | x1.041 |
| blake3-servil-st / solo / LentBatches / 16 | 7.556 | 7.552 | x0.999 | level | 3 of 4 | x0.999 | - | x1.000 | x0.998 | x1.320 |
| blake3-servil-st / solo / LentBatches / 64 | 6.648 | 6.673 | x1.004 | level | 1 of 4 | x1.004 | - | x1.003 | x0.999 | x2.889 |
| blake3-servil-st / solo / LentBatches / 256 | 6.603 | 6.646 | x1.007 | level | 2 of 4 | x1.007 | - | x1.007 | x1.000 | x36.789 |
| blake3-servil-st / solo / LentBatches / 1024 | 7.030 | 7.035 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x105.738 |
| blake3-servil-st / solo / LentBatches / 4096 | 6.871 | 6.811 | x0.991 | level | 3 of 4 | x0.991 | - | x0.991 | x1.000 | x0.261 |
| blake3-servil-st / solo / LentBatches / 16384 | 7.609 | 7.582 | x0.996 | level | 2 of 4 | x0.997 | - | x0.997 | x1.000 | x0.797 |
| blake3-servil-st / solo / LentBatches / 65536 | 7.674 | 7.684 | x1.001 | level | 3 of 4 | x1.001 | - | x1.003 | x1.000 | x1.208 |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.136 | 0.135 | x0.994 | level | 3 of 4 | x0.994 | - | x0.994 | x1.000 | x1.052 |
| blake3-servil-st / solo / ContinuousCollection / Nix files | 0.147 | 0.146 | x0.993 | level | 3 of 4 | x0.993 | - | x0.998 | x1.000 | x1.037 |
| blake3-servil-st / solo / MerkleTree / 1024 | 0.124 | 0.124 | x1.002 | level | 3 of 4 | x1.002 | - | x1.002 | x1.001 | x1.188 |
| blake3-servil-st / solo / MerkleTree / 4096 | 0.134 | 0.134 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.001 | x0.780 |
| blake3-servil-st / solo / MerkleTree / 16384 | 0.134 | 0.133 | x0.996 | level | 4 of 4 | x0.995 | - | x0.998 | x1.001 | x1.024 |
| blake3-servil-st / solo / MerkleTree / 65536 | 0.141 | 0.141 | x0.999 | level | 4 of 4 | x0.998 | - | x0.998 | x1.001 | x0.962 |
| blake3-servil-st / solo / MerkleTree / 262144 | 0.151 | 0.151 | x0.998 | level | 2 of 4 | x0.998 | - | x0.998 | x1.001 | x0.952 |
| blake3-servil-st / solo / MerkleTree / 65536 x 32 B | 0.384 | 0.385 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | x0.873 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 32 B | 0.420 | 0.420 | x0.998 | level | 3 of 4 | x0.998 | - | x0.999 | x1.000 | x0.986 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 16 B | 0.808 | 0.808 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | x1.029 |
| blake3-servil-st / solo / MerkleTree / 65536 x 48 B | 0.269 | 0.268 | x0.998 | level | 4 of 4 | x0.998 | - | x0.999 | x1.000 | x1.044 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 48 B | 0.299 | 0.299 | x1.000 | level | 1 of 4 | x1.000 | - | x1.001 | x1.000 | x1.069 |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.250 | 0.247 | x0.991 | level | 3 of 4 | - | - | x0.993 | x1.003 | x1.019 |
| blake3-servil-st / solo / InterleavedTurn / 1024 x 1 KiB | 0.229 | 0.229 | x1.000 | level | 2 of 4 | - | - | x0.998 | x0.997 | x1.043 |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.207 | 0.206 | x0.993 | level | 2 of 4 | - | - | x0.991 | x1.001 | x1.012 |
| blake3-servil-st / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.195 | 0.190 | x0.971 | level | 4 of 4 | - | - | x0.970 | x0.997 | x1.026 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.203 | 0.204 | x1.009 | level | 2 of 4 | - | - | x1.011 | x1.032 | x0.982 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.194 | 0.188 | x0.966 | level | 3 of 4 | - | - | x0.964 | x0.997 | x1.016 |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.105 | 0.105 | x0.994 | level | 3 of 4 | x0.994 | - | x0.994 | x1.001 | x0.972 |
| blake3-servil-st / solo / ReceivingMessage / 2 μs | 0.107 | 0.108 | x1.007 | level | 3 of 4 | x1.007 | - | x0.991 | x1.001 | x0.977 |
| blake3-servil-st / solo / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 1 of 4 | x0.996 | - | x0.994 | x1.001 | x0.967 |
| blake3-servil-st / solo / IncrementalMessage / 64 B | 6.919 | 6.990 | x1.010 | level | 2 of 4 | - | - | x1.019 | x1.011 | x1.052 |
| blake3-servil-st / solo / IncrementalMessage / 1 KiB | 1.951 | 2.013 | x1.032 | level | 1 of 4 | - | - | x1.030 | x1.001 | x1.055 |
| blake3-servil-st / solo / IncrementalMessage / 4 KiB | 0.627 | 0.623 | x0.993 | level | 2 of 4 | - | - | x0.995 | x0.996 | x1.031 |
| blake3-servil-st / solo / LentIncrementalMessage / 64 B | 1.016 | 1.016 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.006 | x0.793 |
| blake3-servil-st / solo / LentIncrementalMessage / 1 KiB | 1.246 | 1.248 | x1.001 | level | 1 of 4 | x1.001 | - | x1.002 | x1.002 | x0.326 |
| blake3-servil-st / solo / LentIncrementalMessage / 4 KiB | 0.365 | 0.365 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.001 | x0.940 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 0.951 | 0.954 | x1.003 | level | 0 of 4 | x1.003 | - | x1.004 | x1.013 | x1.371 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 4 KiB | 0.357 | 0.357 | x1.000 | level | 1 of 4 | x1.000 | - | x1.001 | x1.001 | x3.696 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 1 MiB | 0.0840 | 0.0823 | x0.979 | level | 4 of 4 | x0.979 | - | x0.978 | x1.000 | x0.892 |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 0.908 | 0.912 | x1.004 | level | 0 of 4 | x1.004 | - | x1.004 | x1.015 | x1.644 |
| blake3-servil-st / solo / ContinuousLentMessages / 4 KiB | 0.353 | 0.358 | x1.013 | level | 0 of 4 | x1.013 | - | x1.001 | x1.001 | x0.248 |
| blake3-servil-st / solo / ContinuousLentMessages / 1 MiB | 0.0692 | 0.0695 | x1.006 | level | 1 of 4 | x1.005 | - | x1.007 | x1.000 | x1.356 |
| blake3-servil-mt / solo / OneMessage / 64 B | 6.376 | 6.074 | x0.953 | level | 3 of 4 | - | - | x0.979 | x1.015 | x1.019 |
| blake3-servil-mt / solo / OneMessage / 128 B | 3.926 | 4.014 | x1.022 | level | 2 of 4 | - | - | x1.017 | x1.006 | x1.059 |
| blake3-servil-mt / solo / OneMessage / 256 B | 2.663 | 2.739 | x1.029 | level | 1 of 4 | - | - | x1.012 | x1.003 | x1.072 |
| blake3-servil-mt / solo / OneMessage / 512 B | 1.951 | 1.947 | x0.998 | level | 2 of 4 | - | - | x1.002 | x1.006 | x1.062 |
| blake3-servil-mt / solo / OneMessage / 1 KiB | 1.669 | 1.672 | x1.002 | level | 3 of 4 | - | - | x1.009 | x1.003 | x1.064 |
| blake3-servil-mt / solo / OneMessage / 1536 B | 1.474 | 1.478 | x1.002 | level | 2 of 4 | - | - | x0.997 | x0.999 | x1.009 |
| blake3-servil-mt / solo / OneMessage / 2 KiB | 1.002 | 1.002 | x0.999 | level | 3 of 4 | - | - | x0.998 | x1.003 | x1.004 |
| blake3-servil-mt / solo / OneMessage / 2304 B | 1.204 | 1.156 | x0.961 | level | 3 of 4 | - | - | x0.964 | x1.004 | x1.015 |
| blake3-servil-mt / solo / OneMessage / 3 KiB | 0.797 | 0.819 | x1.028 | level | 1 of 4 | - | - | x1.026 | x1.003 | x1.059 |
| blake3-servil-mt / solo / OneMessage / 3839 B | 0.805 | 0.821 | x1.019 | level | 1 of 4 | - | - | x1.008 | x1.000 | x1.021 |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 0.580 | 0.578 | x0.996 | level | 2 of 4 | - | - | x0.996 | x0.998 | x1.039 |
| blake3-servil-mt / solo / OneMessage / 4470 B | 0.697 | 0.683 | x0.980 | level | 3 of 4 | - | - | x0.985 | x1.001 | x1.039 |
| blake3-servil-mt / solo / OneMessage / 7935 B | 0.590 | 0.616 | x1.044 | level | 1 of 4 | - | - | x1.044 | x1.001 | x1.024 |
| blake3-servil-mt / solo / OneMessage / 8 KiB | 0.442 | 0.444 | x1.004 | level | 2 of 4 | - | - | x1.009 | x1.001 | x1.044 |
| blake3-servil-mt / solo / OneMessage / 16 KiB | 0.304 | 0.305 | x1.003 | level | 2 of 4 | - | - | x1.009 | x1.000 | x1.011 |
| blake3-servil-mt / solo / OneMessage / 32 KiB | 0.207 | 0.197 | x0.950 | level | 3 of 4 | - | - | x0.961 | x1.000 | x1.031 |
| blake3-servil-mt / solo / OneMessage / 64 KiB | 0.152 | 0.149 | x0.982 | level | 3 of 4 | - | - | x0.978 | x1.000 | x1.009 |
| blake3-servil-mt / solo / OneMessage / 128 KiB | 0.126 | 0.124 | x0.982 | level | 4 of 4 | - | - | x0.984 | x1.000 | x1.000 |
| blake3-servil-mt / solo / OneMessage / 256 KiB | 0.115 | 0.113 | x0.986 | level | 3 of 4 | - | - | x0.988 | x1.000 | x1.029 |
| blake3-servil-mt / solo / OneMessage / 512 KiB | 0.0678 | 0.0696 | x1.026 | level | 2 of 4 | - | - | x1.025 | x1.055 | x0.949 |
| blake3-servil-mt / solo / OneMessage / 1 MiB | 0.0517 | 0.0533 | x1.032 | level | 0 of 4 | - | - | x1.030 | x0.988 | x0.979 |
| blake3-servil-mt / solo / OneMessage / 2 MiB | 0.0650 | 0.0650 | x1.000 | level | 1 of 4 | - | - | x0.999 | x1.010 | x0.984 |
| blake3-servil-mt / solo / OneMessage / 3 MiB | 0.0717 | 0.0705 | x0.983 | level | 3 of 4 | - | - | x0.984 | x1.008 | x0.987 |
| blake3-servil-mt / solo / OneMessage / 4 MiB | 0.0426 | 0.0431 | x1.013 | level | 1 of 4 | - | - | x1.015 | x0.999 | x0.992 |
| blake3-servil-mt / solo / OneMessage / 8 MiB | 0.0695 | 0.0700 | x1.008 | level | 0 of 4 | - | - | x1.009 | x1.005 | x0.996 |
| blake3-servil-mt / solo / OneMessage / 32 MiB | 0.0364 | 0.0365 | x1.003 | level | 1 of 4 | - | - | x1.003 | x1.001 | x0.987 |
| blake3-servil-mt / solo / OneMessage / 64 MiB | 0.0340 | 0.0343 | x1.007 | level | 1 of 4 | - | - | x1.007 | x1.003 | x0.981 |
| blake3-servil-mt / solo / OneMessage / 128 MiB | 0.0353 | 0.0355 | x1.004 | level | 1 of 4 | - | - | x1.004 | x1.002 | x0.982 |
| blake3-servil-mt / solo / ManyMessages / 1 | 485.134 | 536.827 | x1.107 | level | 1 of 4 | - | - | x1.082 | x1.016 | x1.074 |
| blake3-servil-mt / solo / ManyMessages / 2 | 278.859 | 282.977 | x1.015 | level | 1 of 4 | - | - | x0.984 | x1.010 | x0.959 |
| blake3-servil-mt / solo / ManyMessages / 3 | 215.496 | 230.018 | x1.067 | level | 1 of 4 | - | - | x1.023 | x1.003 | x0.967 |
| blake3-servil-mt / solo / ManyMessages / 4 | 151.367 | 154.148 | x1.018 | level | 2 of 4 | - | - | x0.978 | x1.006 | x0.975 |
| blake3-servil-mt / solo / ManyMessages / 6 | 123.867 | 126.348 | x1.020 | level | 1 of 4 | - | - | x0.997 | x1.003 | x0.996 |
| blake3-servil-mt / solo / ManyMessages / 8 | 166.095 | 172.579 | x1.039 | level | 2 of 4 | - | - | x1.027 | x1.007 | x0.987 |
| blake3-servil-mt / solo / ManyMessages / 12 | 125.679 | 128.474 | x1.022 | level | 2 of 4 | - | - | x1.003 | x1.008 | x1.001 |
| blake3-servil-mt / solo / ManyMessages / 16 | 99.624 | 100.276 | x1.007 | level | 2 of 4 | - | - | x0.995 | x1.006 | x1.009 |
| blake3-servil-mt / solo / ManyMessages / 24 | 100.106 | 105.486 | x1.054 | level | 1 of 4 | - | - | x1.041 | x1.002 | x1.001 |
| blake3-servil-mt / solo / ManyMessages / 32 | 49.951 | 48.174 | x0.964 | level | 2 of 4 | - | - | x0.958 | x1.004 | x1.002 |
| blake3-servil-mt / solo / ManyMessages / 48 | 35.051 | 35.022 | x0.999 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.009 |
| blake3-servil-mt / solo / ManyMessages / 64 | 28.444 | 28.823 | x1.013 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.022 |
| blake3-servil-mt / solo / ManyMessages / 128 | 18.572 | 18.883 | x1.017 | level | 2 of 4 | - | - | x1.008 | x1.000 | x1.032 |
| blake3-servil-mt / solo / ManyMessages / 256 | 13.711 | 13.846 | x1.010 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.015 |
| blake3-servil-mt / solo / ManyMessages / 512 | 11.204 | 11.225 | x1.002 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.998 |
| blake3-servil-mt / solo / ManyMessages / 1024 | 9.845 | 9.733 | x0.989 | level | 2 of 4 | - | - | x0.991 | x1.000 | x0.923 |
| blake3-servil-mt / solo / ManyMessages / 2048 | 9.140 | 9.039 | x0.989 | level | 2 of 4 | - | - | x0.988 | x1.000 | x0.897 |
| blake3-servil-mt / solo / ManyMessages / 4096 | 8.880 | 8.757 | x0.986 | level | 3 of 4 | - | - | x0.988 | x1.000 | x0.934 |
| blake3-servil-mt / solo / ManyMessages / 8192 | 3.708 | 3.760 | x1.014 | level | 2 of 4 | - | - | x1.028 | x1.027 | x0.994 |
| blake3-servil-mt / solo / ManyMessages / 16384 | 3.038 | 3.086 | x1.016 | level | 3 of 4 | - | - | x1.018 | x0.998 | x0.993 |
| blake3-servil-mt / solo / ManyMessages / 32768 | 2.749 | 2.756 | x1.003 | level | 2 of 4 | - | - | x1.007 | x0.998 | x0.999 |
| blake3-servil-mt / solo / ManyMessages / 65536 | 2.971 | 2.674 | x0.900 | level | 2 of 4 | - | - | x0.900 | x1.047 | x0.942 |
| blake3-servil-mt / solo / ManyMessages / 131072 | 4.497 | 4.453 | x0.990 | level | 3 of 4 | - | - | x0.990 | x1.006 | x0.994 |
| blake3-servil-mt / solo / ManyMessages / 262144 | 4.627 | 4.685 | x1.012 | level | 0 of 4 | - | - | x1.013 | x1.007 | x1.012 |
| blake3-servil-mt / solo / ManyLongMessages / 4 | 1846.950 | 1877.530 | x1.017 | level | 1 of 4 | - | - | x1.007 | x1.001 | x1.041 |
| blake3-servil-mt / solo / ManyLongMessages / 16 | 1642.133 | 666.693 | x0.406 | faster | 4 of 4 | - | - | x0.412 | x0.575 | x1.270 |
| blake3-servil-mt / solo / ManyLongMessages / 64 | 569.555 | 560.430 | x0.984 | level | 3 of 4 | - | - | x0.982 | x0.998 | x0.928 |
| blake3-servil-mt / solo / ManyLongMessages / 256 | 313.301 | 298.063 | x0.951 | level | 4 of 4 | - | - | x0.953 | x0.936 | x1.038 |
| blake3-servil-mt / solo / IdleOneMessage / 64 B | 3.011 | 3.124 | x1.037 | level | 0 of 4 | - | - | x1.009 | x1.014 | x0.860 |
| blake3-servil-mt / solo / IdleOneMessage / 128 B | 2.192 | 2.195 | x1.001 | level | 3 of 4 | - | - | x1.006 | x1.011 | x0.342 |
| blake3-servil-mt / solo / IdleOneMessage / 256 B | 1.755 | 1.794 | x1.022 | level | 0 of 4 | - | - | x1.007 | x1.008 | x1.126 |
| blake3-servil-mt / solo / IdleOneMessage / 512 B | 1.621 | 1.624 | x1.002 | level | 1 of 4 | - | - | x1.006 | x1.005 | x1.585 |
| blake3-servil-mt / solo / IdleOneMessage / 1 KiB | 1.552 | 1.543 | x0.994 | level | 2 of 4 | - | - | x1.004 | x1.002 | x1.646 |
| blake3-servil-mt / solo / IdleOneMessage / 1536 B | 1.193 | 1.159 | x0.972 | level | 3 of 4 | - | - | x0.997 | x0.999 | x0.660 |
| blake3-servil-mt / solo / IdleOneMessage / 2 KiB | 0.872 | 0.869 | x0.997 | level | 2 of 4 | - | - | x1.001 | x1.002 | x0.623 |
| blake3-servil-mt / solo / IdleOneMessage / 2304 B | 0.982 | 0.971 | x0.989 | level | 3 of 4 | - | - | x0.994 | x1.003 | x0.835 |
| blake3-servil-mt / solo / IdleOneMessage / 3 KiB | 0.631 | 0.632 | x1.003 | level | 1 of 4 | - | - | x1.005 | x1.002 | x1.041 |
| blake3-servil-mt / solo / IdleOneMessage / 3839 B | 0.515 | 0.516 | x1.003 | level | 2 of 4 | - | - | x0.998 | x1.002 | x0.469 |
| blake3-servil-mt / solo / IdleOneMessage / 4 KiB | 0.466 | 0.473 | x1.016 | level | 0 of 4 | - | - | x0.999 | x1.002 | x0.245 |
| blake3-servil-mt / solo / IdleOneMessage / 4470 B | 0.577 | 0.584 | x1.013 | level | 1 of 4 | - | - | x1.001 | x1.002 | x1.104 |
| blake3-servil-mt / solo / IdleOneMessage / 7935 B | 0.293 | 0.296 | x1.009 | level | 1 of 4 | - | - | x0.994 | x1.001 | x0.574 |
| blake3-servil-mt / solo / IdleOneMessage / 8 KiB | 0.275 | 0.278 | x1.012 | level | 1 of 4 | - | - | x1.005 | x1.001 | x3.410 |
| blake3-servil-mt / solo / IdleOneMessage / 16 KiB | 0.154 | 0.156 | x1.012 | level | 0 of 4 | - | - | x1.014 | x1.001 | x9.924 |
| blake3-servil-mt / solo / IdleOneMessage / 32 KiB | 0.108 | 0.107 | x0.992 | level | 3 of 4 | - | - | x1.003 | x1.001 | x2.510 |
| blake3-servil-mt / solo / IdleOneMessage / 64 KiB | 0.0994 | 0.0992 | x0.998 | level | 2 of 4 | - | - | x1.011 | x1.000 | x7.536 |
| blake3-servil-mt / solo / IdleOneMessage / 128 KiB | 0.0936 | 0.0924 | x0.987 | level | 3 of 4 | - | - | x1.007 | x1.000 | x1.581 |
| blake3-servil-mt / solo / IdleOneMessage / 256 KiB | 0.0918 | 0.0906 | x0.987 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.169 |
| blake3-servil-mt / solo / IdleOneMessage / 512 KiB | 0.0619 | 0.0626 | x1.012 | level | 1 of 4 | - | - | x1.023 | x1.005 | x0.972 |
| blake3-servil-mt / solo / IdleOneMessage / 1 MiB | 0.0567 | 0.0574 | x1.013 | level | 2 of 4 | - | - | x1.012 | x0.986 | x0.992 |
| blake3-servil-mt / solo / IdleOneMessage / 2 MiB | 0.0608 | 0.0533 | x0.876 | level | 3 of 4 | - | - | x0.880 | x1.073 | x0.991 |
| blake3-servil-mt / solo / IdleOneMessage / 3 MiB | 0.0595 | 0.0515 | x0.864 | level | 3 of 4 | - | - | x0.865 | x1.059 | x0.991 |
| blake3-servil-mt / solo / IdleOneMessage / 4 MiB | 0.0595 | 0.0529 | x0.888 | level | 2 of 4 | - | - | x0.887 | x1.042 | x0.988 |
| blake3-servil-mt / solo / IdleOneMessage / 8 MiB | 0.0666 | 0.0665 | x0.998 | level | 2 of 4 | - | - | x0.997 | x0.993 | x1.011 |
| blake3-servil-mt / solo / IdleOneMessage / 32 MiB | 0.0324 | 0.0327 | x1.009 | level | 0 of 4 | - | - | x1.009 | x1.007 | x0.995 |
| blake3-servil-mt / solo / IdleOneMessage / 64 MiB | 0.0341 | 0.0342 | x1.003 | level | 1 of 4 | - | - | x1.004 | x1.004 | x1.004 |
| blake3-servil-mt / solo / IdleOneMessage / 128 MiB | 0.0335 | 0.0335 | x1.000 | level | 3 of 4 | - | - | x1.001 | x0.998 | x1.009 |
| blake3-servil-mt / solo / IdleManyMessages / 1 | 209.401 | 209.835 | x1.002 | level | 1 of 4 | - | - | x1.012 | x1.013 | x1.108 |
| blake3-servil-mt / solo / IdleManyMessages / 2 | 105.946 | 107.049 | x1.010 | level | 1 of 4 | - | - | x1.003 | x1.002 | x0.551 |
| blake3-servil-mt / solo / IdleManyMessages / 3 | 92.833 | 92.767 | x0.999 | level | 2 of 4 | - | - | x1.008 | x1.002 | x1.879 |
| blake3-servil-mt / solo / IdleManyMessages / 4 | 54.630 | 55.062 | x1.008 | level | 1 of 4 | - | - | x1.008 | x1.002 | x5.874 |
| blake3-servil-mt / solo / IdleManyMessages / 6 | 51.203 | 51.341 | x1.003 | level | 2 of 4 | - | - | x1.006 | x1.002 | x0.599 |
| blake3-servil-mt / solo / IdleManyMessages / 8 | 33.880 | 34.301 | x1.012 | level | 1 of 4 | - | - | x1.003 | x1.002 | x0.512 |
| blake3-servil-mt / solo / IdleManyMessages / 12 | 31.723 | 31.502 | x0.993 | level | 2 of 4 | - | - | x1.008 | x1.001 | x4.165 |
| blake3-servil-mt / solo / IdleManyMessages / 16 | 18.106 | 18.168 | x1.003 | level | 2 of 4 | - | - | x1.011 | x1.002 | x1.102 |
| blake3-servil-mt / solo / IdleManyMessages / 24 | 17.351 | 18.094 | x1.043 | level | 1 of 4 | - | - | x1.027 | x1.001 | x1.236 |
| blake3-servil-mt / solo / IdleManyMessages / 32 | 13.137 | 13.136 | x1.000 | level | 3 of 4 | - | - | x1.002 | x1.001 | x0.594 |
| blake3-servil-mt / solo / IdleManyMessages / 48 | 11.448 | 11.473 | x1.002 | level | 2 of 4 | - | - | x1.012 | x1.001 | x6.893 |
| blake3-servil-mt / solo / IdleManyMessages / 64 | 10.559 | 10.491 | x0.994 | level | 3 of 4 | - | - | x1.008 | x1.001 | x3.751 |
| blake3-servil-mt / solo / IdleManyMessages / 128 | 9.321 | 9.234 | x0.991 | level | 3 of 4 | - | - | x1.005 | x1.000 | x1.071 |
| blake3-servil-mt / solo / IdleManyMessages / 256 | 8.724 | 8.706 | x0.998 | level | 2 of 4 | - | - | x1.004 | x1.000 | x0.811 |
| blake3-servil-mt / solo / IdleManyMessages / 512 | 8.352 | 8.404 | x1.006 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.801 |
| blake3-servil-mt / solo / IdleManyMessages / 1024 | 8.182 | 8.168 | x0.998 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.095 |
| blake3-servil-mt / solo / IdleManyMessages / 2048 | 8.048 | 8.060 | x1.002 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.681 |
| blake3-servil-mt / solo / IdleManyMessages / 4096 | 7.949 | 8.002 | x1.007 | level | 0 of 4 | - | - | x0.997 | x1.000 | x0.798 |
| blake3-servil-mt / solo / IdleManyMessages / 8192 | 3.523 | 3.577 | x1.015 | level | 1 of 4 | - | - | x1.006 | x0.971 | x0.987 |
| blake3-servil-mt / solo / IdleManyMessages / 16384 | 3.274 | 3.319 | x1.014 | level | 0 of 4 | - | - | x1.001 | x0.986 | x0.997 |
| blake3-servil-mt / solo / IdleManyMessages / 32768 | 2.920 | 2.874 | x0.984 | level | 2 of 4 | - | - | x0.981 | x0.994 | x0.994 |
| blake3-servil-mt / solo / IdleManyMessages / 65536 | 2.507 | 2.864 | x1.142 | level | 2 of 4 | - | - | x1.144 | x0.962 | x1.064 |
| blake3-servil-mt / solo / IdleManyMessages / 131072 | 4.129 | 4.165 | x1.009 | level | 0 of 4 | - | - | x1.010 | x1.003 | x0.990 |
| blake3-servil-mt / solo / IdleManyMessages / 262144 | 4.178 | 4.198 | x1.005 | level | 1 of 4 | - | - | x1.005 | x0.997 | x0.993 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 B | 3.010 | 3.037 | x1.009 | level | 1 of 4 | - | - | x1.011 | x1.013 | x1.360 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 B | 2.128 | 2.136 | x1.004 | level | 2 of 4 | - | - | x1.010 | x1.011 | x1.822 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 B | 1.696 | 1.702 | x1.004 | level | 1 of 4 | - | - | x1.004 | x1.008 | x1.321 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 B | 1.466 | 1.473 | x1.004 | level | 1 of 4 | - | - | x1.002 | x1.005 | x0.570 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 KiB | 1.350 | 1.351 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.003 | x1.153 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1536 B | 1.014 | 1.016 | x1.002 | level | 2 of 4 | - | - | x1.000 | x0.999 | x1.585 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 KiB | 0.731 | 0.732 | x1.002 | level | 1 of 4 | - | - | x1.002 | x1.002 | x1.051 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2304 B | 0.827 | 0.813 | x0.984 | level | 4 of 4 | - | - | x0.996 | x1.003 | x0.950 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 KiB | 0.523 | 0.524 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.002 | x0.461 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3839 B | 0.425 | 0.427 | x1.004 | level | 0 of 4 | - | - | x1.005 | x1.002 | x0.743 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 KiB | 0.392 | 0.392 | x0.999 | level | 3 of 4 | - | - | x1.000 | x1.002 | x1.164 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4470 B | 0.482 | 0.482 | x1.000 | level | 2 of 4 | - | - | x1.002 | x1.002 | x0.805 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 7935 B | 0.242 | 0.241 | x0.996 | level | 2 of 4 | - | - | x0.997 | x1.001 | x0.904 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 KiB | 0.225 | 0.225 | x0.998 | level | 2 of 4 | - | - | x1.001 | x1.001 | x1.271 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 16 KiB | 0.126 | 0.126 | x1.005 | level | 1 of 4 | - | - | x1.006 | x1.001 | x1.993 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 KiB | 0.0891 | 0.0889 | x0.998 | level | 2 of 4 | - | - | x0.995 | x1.001 | x0.855 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 KiB | 0.0815 | 0.0811 | x0.995 | level | 3 of 4 | - | - | x0.994 | x1.000 | x1.239 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 KiB | 0.0780 | 0.0780 | x1.001 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.479 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 KiB | 0.0781 | 0.0777 | x0.995 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.295 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 KiB | 0.0578 | 0.0589 | x1.019 | level | 1 of 4 | - | - | x1.017 | x1.019 | x0.962 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 MiB | 0.0479 | 0.0473 | x0.988 | level | 2 of 4 | - | - | x0.985 | x0.966 | x0.987 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 MiB | 0.0639 | 0.0516 | x0.808 | level | 3 of 4 | - | - | x0.807 | x1.106 | x0.981 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 MiB | 0.0652 | 0.0527 | x0.808 | level | 3 of 4 | - | - | x0.806 | x1.094 | x0.985 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 MiB | 0.0538 | 0.0461 | x0.857 | level | 4 of 4 | - | - | x0.855 | x1.049 | x0.990 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 MiB | 0.0672 | 0.0670 | x0.997 | level | 2 of 4 | - | - | x0.997 | x1.003 | x0.999 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 MiB | 0.0315 | 0.0318 | x1.009 | level | 0 of 4 | - | - | x1.009 | x1.003 | x1.000 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 MiB | 0.0333 | 0.0333 | x1.001 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.970 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 MiB | 0.0331 | 0.0332 | x1.001 | level | 3 of 4 | - | - | x1.002 | x1.000 | x0.995 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1 | 204.109 | 207.882 | x1.018 | level | 1 of 4 | - | - | x1.012 | x1.013 | x1.448 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2 | 105.550 | 106.784 | x1.012 | level | 2 of 4 | - | - | x1.004 | x1.002 | x2.193 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 3 | 90.659 | 91.924 | x1.014 | level | 2 of 4 | - | - | x1.005 | x1.002 | x2.196 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4 | 52.758 | 53.422 | x1.013 | level | 0 of 4 | - | - | x1.007 | x1.002 | x1.782 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 6 | 46.101 | 46.120 | x1.000 | level | 1 of 4 | - | - | x1.005 | x1.002 | x1.474 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8 | 29.028 | 28.616 | x0.986 | level | 3 of 4 | - | - | x1.001 | x1.002 | x1.582 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 12 | 25.834 | 25.854 | x1.001 | level | 2 of 4 | - | - | x1.002 | x1.001 | x1.674 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16 | 14.836 | 14.816 | x0.999 | level | 2 of 4 | - | - | x1.006 | x1.002 | x1.164 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 24 | 13.819 | 13.812 | x0.999 | level | 1 of 4 | - | - | x1.005 | x1.001 | x1.077 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32 | 10.517 | 10.546 | x1.003 | level | 0 of 4 | - | - | x1.003 | x1.001 | x0.421 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 48 | 9.232 | 9.201 | x0.997 | level | 2 of 4 | - | - | x1.003 | x1.001 | x1.527 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 64 | 8.442 | 8.476 | x1.004 | level | 0 of 4 | - | - | x1.004 | x1.001 | x1.348 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 128 | 7.467 | 7.537 | x1.009 | level | 1 of 4 | - | - | x1.006 | x1.000 | x1.228 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 256 | 7.032 | 7.072 | x1.006 | level | 1 of 4 | - | - | x1.005 | x1.000 | x1.116 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 512 | 6.803 | 6.818 | x1.002 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.740 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1024 | 6.686 | 6.726 | x1.006 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.979 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2048 | 6.660 | 6.649 | x0.998 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.671 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4096 | 6.743 | 6.749 | x1.001 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.830 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8192 | 3.113 | 3.216 | x1.033 | level | 1 of 4 | - | - | x1.023 | x0.999 | x0.998 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16384 | 2.813 | 2.828 | x1.005 | level | 2 of 4 | - | - | x1.002 | x0.984 | x0.990 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32768 | 2.575 | 2.626 | x1.020 | level | 2 of 4 | - | - | x1.020 | x0.993 | x0.988 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 65536 | 2.576 | 2.764 | x1.073 | level | 1 of 4 | - | - | x1.076 | x0.989 | x1.014 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 131072 | 4.201 | 4.178 | x0.994 | level | 2 of 4 | - | - | x0.994 | x1.019 | x0.987 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 262144 | 4.211 | 4.217 | x1.001 | level | 2 of 4 | - | - | x1.001 | x0.996 | x0.995 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.457 | 0.405 | x0.887 | level | 4 of 4 | x0.813 | - | x0.887 | x0.976 | x1.181 |
| blake3-servil-mt / solo / ContinuousMessages / 128 B | 0.240 | 0.222 | x0.927 | level | 4 of 4 | x0.881 | - | x0.929 | x0.976 | x1.009 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.119 | 0.119 | x0.995 | level | 2 of 4 | x0.964 | - | x0.996 | x0.977 | x0.915 |
| blake3-servil-mt / solo / ContinuousMessages / 512 B | 0.0700 | 0.0661 | x0.945 | level | 3 of 4 | x0.903 | - | x0.946 | x0.979 | x1.047 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.0547 | 0.0507 | x0.926 | level | 4 of 4 | x0.753 | - | x0.939 | x0.988 | x1.052 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0439 | 0.0447 | x1.019 | level | 1 of 4 | x0.997 | - | x1.023 | x0.999 | x0.990 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0364 | 0.0366 | x1.004 | level | 3 of 4 | x0.714 | - | x1.008 | x1.018 | x0.995 |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.0343 | 0.0323 | x0.942 | level | 3 of 4 | x0.950 | - | x0.943 | x1.021 | x0.982 |
| blake3-servil-mt / solo / ContinuousMessages / 256 KiB | 0.0321 | 0.0326 | x1.015 | level | 2 of 4 | x1.012 | - | x1.015 | x1.018 | x1.058 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0310 | 0.0305 | x0.984 | level | 3 of 4 | x0.974 | - | x0.984 | x1.017 | x0.993 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.0313 | 0.0312 | x0.997 | level | 2 of 4 | x0.973 | - | x0.999 | x1.017 | x0.993 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0314 | 0.0319 | x1.017 | level | 2 of 4 | x1.048 | - | x1.018 | x1.016 | x0.991 |
| blake3-servil-mt / solo / ContinuousMessages / 64 MiB | 0.0356 | 0.0345 | x0.969 | level | 3 of 4 | x1.003 | - | x0.969 | x1.016 | x1.005 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 3.680 | 3.648 | x0.992 | level | 1 of 4 | x1.067 | - | x0.992 | x0.973 | x0.937 |
| blake3-servil-mt / solo / ContinuousBatches / 64 | 2.303 | 2.283 | x0.991 | level | 3 of 4 | x1.011 | - | x0.992 | x0.986 | x1.018 |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 2.656 | 2.738 | x1.031 | level | 1 of 4 | x1.013 | - | x1.040 | x0.996 | x1.010 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 2.376 | 2.406 | x1.013 | level | 0 of 4 | x1.043 | - | x1.015 | x0.983 | x0.962 |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 2.495 | 2.561 | x1.026 | level | 1 of 4 | x0.987 | - | x1.018 | x0.991 | x0.983 |
| blake3-servil-mt / solo / ContinuousBatches / 16384 | 2.523 | 2.489 | x0.986 | level | 3 of 4 | x0.978 | - | x0.990 | x0.995 | x1.010 |
| blake3-servil-mt / solo / ContinuousBatches / 65536 | 3.099 | 2.871 | x0.927 | level | 4 of 4 | x0.877 | - | x0.927 | x1.012 | x0.962 |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.940 | 0.940 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.012 | x0.519 |
| blake3-servil-mt / solo / LentMessages / 128 B | 1.078 | 1.079 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.007 | x1.949 |
| blake3-servil-mt / solo / LentMessages / 256 B | 1.152 | 1.153 | x1.001 | level | 0 of 4 | x1.001 | - | x1.002 | x1.004 | x1.027 |
| blake3-servil-mt / solo / LentMessages / 512 B | 1.190 | 1.189 | x0.999 | level | 3 of 4 | x0.999 | - | x1.000 | x1.002 | x1.088 |
| blake3-servil-mt / solo / LentMessages / 1 KiB | 1.212 | 1.212 | x1.000 | level | 4 of 4 | x1.000 | - | x1.000 | x1.001 | x1.042 |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.358 | 0.358 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.001 | x0.864 |
| blake3-servil-mt / solo / LentMessages / 16 KiB | 0.114 | 0.114 | x1.003 | level | 1 of 4 | x1.003 | - | x1.001 | x1.000 | x1.313 |
| blake3-servil-mt / solo / LentMessages / 64 KiB | 0.0812 | 0.0808 | x0.995 | level | 4 of 4 | x0.995 | - | x0.996 | x1.000 | x0.875 |
| blake3-servil-mt / solo / LentMessages / 256 KiB | 0.0761 | 0.0763 | x1.003 | level | 2 of 4 | x1.003 | - | x1.004 | x1.000 | x2.165 |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.0452 | 0.0451 | x0.999 | level | 2 of 4 | x1.006 | - | x1.002 | x0.989 | x0.990 |
| blake3-servil-mt / solo / LentMessages / 4 MiB | 0.0389 | 0.0395 | x1.015 | level | 1 of 4 | x1.024 | - | x1.021 | x1.005 | x0.942 |
| blake3-servil-mt / solo / LentMessages / 16 MiB | 0.0339 | 0.0340 | x1.003 | level | 2 of 4 | x1.004 | - | x1.004 | x1.003 | x0.991 |
| blake3-servil-mt / solo / LentMessages / 64 MiB | 0.0340 | 0.0338 | x0.996 | level | 2 of 4 | x1.007 | - | x0.995 | x0.999 | x0.968 |
| blake3-servil-mt / solo / Interleaved / 256 | 0.137 | 0.136 | x0.995 | level | 4 of 4 | x0.995 | - | x0.995 | x0.998 | x0.998 |
| blake3-servil-mt / solo / Collection / git objects | 0.00834 | 0.00829 | x0.994 | level | 3 of 4 | x0.993 | - | x0.997 | x0.997 | x1.025 |
| blake3-servil-mt / solo / Collection / Nix files | 0.0111 | 0.0113 | x1.013 | level | 1 of 4 | x1.035 | - | x1.016 | x1.023 | x1.046 |
| blake3-servil-mt / solo / LentBatches / 16 | 7.576 | 7.583 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x0.998 | x1.412 |
| blake3-servil-mt / solo / LentBatches / 64 | 6.648 | 6.687 | x1.006 | level | 1 of 4 | x1.006 | - | x1.005 | x0.999 | x1.436 |
| blake3-servil-mt / solo / LentBatches / 256 | 6.597 | 6.653 | x1.008 | level | 1 of 4 | x1.008 | - | x1.008 | x1.000 | x42.358 |
| blake3-servil-mt / solo / LentBatches / 1024 | 7.032 | 7.034 | x1.000 | level | 1 of 4 | x1.000 | - | x1.001 | x1.000 | x0.553 |
| blake3-servil-mt / solo / LentBatches / 4096 | 6.877 | 6.813 | x0.991 | level | 3 of 4 | x0.991 | - | x0.991 | x1.000 | x0.280 |
| blake3-servil-mt / solo / LentBatches / 16384 | 3.183 | 3.230 | x1.015 | level | 1 of 4 | x1.029 | - | x1.015 | x0.990 | x0.985 |
| blake3-servil-mt / solo / LentBatches / 65536 | 3.015 | 2.910 | x0.965 | level | 3 of 4 | x0.893 | - | x0.967 | x1.003 | x0.989 |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.0385 | 0.0392 | x1.019 | level | 1 of 4 | x0.989 | - | x1.019 | x1.009 | x0.987 |
| blake3-servil-mt / solo / ContinuousCollection / Nix files | 0.0400 | 0.0389 | x0.972 | level | 3 of 4 | x1.004 | - | x0.973 | x1.007 | x0.997 |
| blake3-servil-mt / solo / MerkleTree / 1024 | 0.124 | 0.124 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.001 | x1.460 |
| blake3-servil-mt / solo / MerkleTree / 4096 | 0.0707 | 0.0703 | x0.994 | level | 1 of 4 | x1.018 | - | x0.987 | x0.986 | x1.024 |
| blake3-servil-mt / solo / MerkleTree / 16384 | 0.0734 | 0.0759 | x1.034 | level | 2 of 4 | x1.046 | - | x1.035 | x0.992 | x1.007 |
| blake3-servil-mt / solo / MerkleTree / 65536 | 0.0802 | 0.0778 | x0.970 | level | 3 of 4 | x0.929 | - | x0.970 | x1.028 | x0.949 |
| blake3-servil-mt / solo / MerkleTree / 262144 | 0.0499 | 0.0475 | x0.951 | level | 4 of 4 | x0.869 | - | x0.951 | x1.019 | x0.885 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 32 B | 0.0911 | 0.0928 | x1.019 | level | 1 of 4 | x1.014 | - | x1.018 | x0.998 | x1.052 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 32 B | 0.0619 | 0.0617 | x0.997 | level | 3 of 4 | x0.991 | - | x0.998 | x1.010 | x0.975 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 16 B | 0.133 | 0.132 | x0.986 | level | 3 of 4 | x0.994 | - | x0.987 | x0.985 | x0.977 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 48 B | 0.0675 | 0.0680 | x1.007 | level | 2 of 4 | x1.023 | - | x1.008 | x0.999 | x1.040 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 48 B | 0.0537 | 0.0530 | x0.987 | level | 3 of 4 | x0.982 | - | x0.988 | x0.991 | x0.966 |
| blake3-servil-mt / solo / InterleavedTurn / 256 | 0.296 | 0.306 | x1.033 | level | 1 of 4 | - | - | x1.025 | x0.899 | x0.993 |
| blake3-servil-mt / solo / InterleavedTurn / 1024 x 1 KiB | 0.151 | 0.147 | x0.979 | level | 3 of 4 | - | - | x0.983 | x1.002 | x0.993 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 256 | 0.191 | 0.196 | x1.029 | level | 2 of 4 | - | - | x1.037 | x0.963 | x0.968 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.149 | 0.141 | x0.943 | level | 3 of 4 | - | - | x0.945 | x0.991 | x0.971 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 256 | 0.223 | 0.229 | x1.030 | level | 2 of 4 | - | - | x1.024 | x0.903 | x0.927 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.139 | 0.137 | x0.991 | level | 3 of 4 | - | - | x0.990 | x0.996 | x0.988 |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.0344 | 0.0352 | x1.024 | level | 0 of 4 | x1.034 | - | x1.010 | x1.012 | x0.994 |
| blake3-servil-mt / solo / ReceivingMessage / 2 μs | 0.0921 | 0.0920 | x1.000 | level | 3 of 4 | x1.013 | - | x0.986 | x1.014 | x0.971 |
| blake3-servil-mt / solo / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 4 of 4 | x1.182 | - | x0.999 | x1.015 | x0.983 |
| blake3-servil-mt / solo / IncrementalMessage / 64 B | 7.870 | 7.295 | x0.927 | level | 2 of 4 | - | - | x0.953 | x1.011 | x1.080 |
| blake3-servil-mt / solo / IncrementalMessage / 1 KiB | 1.877 | 1.858 | x0.990 | level | 2 of 4 | - | - | x0.990 | x1.002 | x1.057 |
| blake3-servil-mt / solo / IncrementalMessage / 4 KiB | 0.635 | 0.622 | x0.979 | level | 3 of 4 | - | - | x0.982 | x1.000 | x1.039 |
| blake3-servil-mt / solo / LentIncrementalMessage / 64 B | 0.947 | 0.968 | x1.022 | level | 0 of 4 | x1.022 | - | x1.021 | x1.006 | x0.198 |
| blake3-servil-mt / solo / LentIncrementalMessage / 1 KiB | 1.245 | 1.247 | x1.002 | level | 0 of 4 | x1.002 | - | x1.002 | x1.002 | x0.878 |
| blake3-servil-mt / solo / LentIncrementalMessage / 4 KiB | 0.365 | 0.365 | x1.000 | level | 2 of 4 | x1.001 | - | x1.001 | x1.001 | x0.433 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 5.201 | 5.749 | x1.105 | level | 1 of 4 | x1.040 | - | x1.106 | x0.997 | x1.111 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 4 KiB | 0.0954 | 0.0811 | x0.850 | level | 3 of 4 | x0.836 | - | x0.850 | x1.008 | x1.023 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 1 MiB | 0.0297 | 0.0299 | x1.004 | level | 2 of 4 | x0.967 | - | x1.002 | x1.017 | x1.000 |
| blake3-servil-mt / solo / ContinuousLentMessages / 64 B | 0.367 | 0.359 | x0.980 | level | 2 of 4 | x0.743 | - | x0.974 | x0.971 | x1.177 |
| blake3-servil-mt / solo / ContinuousLentMessages / 4 KiB | 0.0355 | 0.0358 | x1.011 | level | 2 of 4 | x0.995 | - | x1.006 | x0.996 | x1.040 |
| blake3-servil-mt / solo / ContinuousLentMessages / 1 MiB | 0.00348 | 0.00347 | x0.997 | level | 3 of 4 | x0.996 | - | x0.994 | x1.007 | x1.013 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.426 | 0.415 | x0.976 | level | 3 of 4 | - | - | x0.976 | x0.976 | x1.020 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 128 B | 0.233 | 0.214 | x0.919 | level | 3 of 4 | - | - | x0.919 | x0.976 | x1.211 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.129 | 0.117 | x0.905 | level | 4 of 4 | - | - | x0.906 | x0.977 | x1.086 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 512 B | 0.0756 | 0.0755 | x0.999 | level | 2 of 4 | - | - | x0.991 | x0.979 | x1.045 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.0595 | 0.0628 | x1.055 | level | 0 of 4 | - | - | x1.050 | x0.988 | x0.959 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.0892 | 0.0900 | x1.008 | level | 2 of 4 | - | - | x0.978 | x0.993 | x0.996 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.0505 | 0.0450 | x0.890 | level | 3 of 4 | - | - | x0.878 | x1.019 | x1.012 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.0397 | 0.0396 | x0.997 | level | 3 of 4 | - | - | x0.994 | x1.021 | x0.984 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 KiB | 0.0372 | 0.0378 | x1.016 | level | 0 of 4 | - | - | x1.018 | x1.018 | x1.013 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0383 | 0.0387 | x1.010 | level | 1 of 4 | - | - | x1.008 | x1.017 | x1.005 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.0396 | 0.0399 | x1.008 | level | 1 of 4 | - | - | x1.006 | x1.017 | x1.002 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.0478 | 0.0501 | x1.048 | level | 0 of 4 | - | - | x1.044 | x1.015 | x0.963 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 MiB | 0.0526 | 0.0531 | x1.011 | level | 1 of 4 | - | - | x1.012 | x1.017 | x0.971 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 4.240 | 4.174 | x0.984 | level | 2 of 4 | - | - | x0.976 | x0.973 | x1.025 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 64 | 3.109 | 3.009 | x0.968 | level | 4 of 4 | - | - | x0.974 | x0.982 | x1.051 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 256 | 3.096 | 3.122 | x1.008 | level | 2 of 4 | - | - | x1.004 | x0.996 | x1.002 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 2.927 | 2.907 | x0.993 | level | 3 of 4 | - | - | x0.994 | x0.982 | x1.000 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 4096 | 3.322 | 3.250 | x0.978 | level | 3 of 4 | - | - | x0.980 | x1.001 | x0.996 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16384 | 2.872 | 2.919 | x1.016 | level | 1 of 4 | - | - | x1.020 | x0.985 | x1.021 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 65536 | 3.128 | 3.090 | x0.988 | level | 1 of 4 | - | - | x0.987 | x1.011 | x0.923 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.939 | 0.939 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.012 | x0.719 |
| blake3-servil-mt / shared-one-cache / LentMessages / 128 B | 1.077 | 1.078 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.007 | x1.190 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 B | 1.151 | 1.153 | x1.002 | level | 0 of 4 | - | - | x1.002 | x1.004 | x1.036 |
| blake3-servil-mt / shared-one-cache / LentMessages / 512 B | 1.188 | 1.188 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.002 | x0.905 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 KiB | 1.211 | 1.211 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.001 | x1.070 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.358 | 0.358 | x1.000 | level | 4 of 4 | - | - | x0.999 | x1.001 | x1.075 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 KiB | 0.114 | 0.114 | x0.998 | level | 4 of 4 | - | - | x0.998 | x1.000 | x1.037 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 KiB | 0.0814 | 0.0810 | x0.995 | level | 4 of 4 | - | - | x0.995 | x1.000 | x0.817 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 KiB | 0.0764 | 0.0761 | x0.995 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.189 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 MiB | 0.0537 | 0.0541 | x1.007 | level | 3 of 4 | - | - | x1.010 | x1.018 | x0.993 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 MiB | 0.0433 | 0.0435 | x1.006 | level | 1 of 4 | - | - | x1.006 | x1.006 | x1.080 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 MiB | 0.0569 | 0.0555 | x0.975 | level | 3 of 4 | - | - | x0.978 | x0.931 | x1.102 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 MiB | 0.0513 | 0.0501 | x0.976 | level | 3 of 4 | - | - | x1.003 | x0.988 | x1.002 |
| blake3-servil-mt / shared-one-cache / Interleaved / 256 | 0.137 | 0.137 | x0.998 | level | 3 of 4 | - | - | x0.998 | x0.999 | x1.008 |
| blake3-servil-mt / shared-one-cache / Collection / git objects | 0.0157 | 0.0154 | x0.980 | level | 4 of 4 | - | - | x1.033 | x1.034 | x1.044 |
| blake3-servil-mt / shared-one-cache / Collection / Nix files | 0.0175 | 0.0174 | x0.995 | level | 2 of 4 | - | - | x0.997 | x0.982 | x0.993 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16 | 7.547 | 7.559 | x1.002 | level | 1 of 4 | - | - | x1.002 | x0.998 | x0.947 |
| blake3-servil-mt / shared-one-cache / LentBatches / 64 | 6.627 | 6.683 | x1.008 | level | 1 of 4 | - | - | x1.008 | x0.999 | x0.964 |
| blake3-servil-mt / shared-one-cache / LentBatches / 256 | 6.595 | 6.593 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.993 |
| blake3-servil-mt / shared-one-cache / LentBatches / 1024 | 7.047 | 7.046 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.874 |
| blake3-servil-mt / shared-one-cache / LentBatches / 4096 | 6.844 | 6.812 | x0.995 | level | 2 of 4 | - | - | x0.995 | x1.000 | x0.616 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16384 | 3.729 | 3.666 | x0.983 | level | 3 of 4 | - | - | x0.985 | x1.002 | x0.977 |
| blake3-servil-mt / shared-one-cache / LentBatches / 65536 | 3.520 | 3.256 | x0.925 | level | 3 of 4 | - | - | x0.926 | x1.029 | x0.953 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.0589 | 0.0597 | x1.013 | level | 0 of 4 | - | - | x1.016 | x1.010 | x0.996 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / Nix files | 0.0579 | 0.0580 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.008 | x0.997 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1024 | 0.124 | 0.124 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.001 | x1.103 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 4096 | 0.0767 | 0.0761 | x0.992 | level | 1 of 4 | - | - | x0.992 | x0.999 | x0.999 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 16384 | 0.103 | 0.101 | x0.976 | level | 3 of 4 | - | - | x0.975 | x1.004 | x0.972 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 | 0.125 | 0.124 | x0.992 | level | 2 of 4 | - | - | x0.993 | x1.014 | x0.980 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 262144 | 0.0691 | 0.0688 | x0.995 | level | 3 of 4 | - | - | x1.002 | x0.990 | x1.061 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 32 B | 0.190 | 0.179 | x0.941 | level | 2 of 4 | - | - | x0.942 | x1.081 | x0.898 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 32 B | 0.0813 | 0.0805 | x0.990 | level | 2 of 4 | - | - | x0.988 | x0.993 | x0.984 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 16 B | 0.188 | 0.190 | x1.011 | level | 2 of 4 | - | - | x1.020 | x1.007 | x1.006 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 48 B | 0.134 | 0.124 | x0.931 | level | 2 of 4 | - | - | x0.929 | x0.999 | x0.852 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 48 B | 0.0673 | 0.0671 | x0.997 | level | 3 of 4 | - | - | x0.999 | x1.004 | x1.011 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.0486 | 0.0483 | x0.995 | level | 3 of 4 | - | - | x0.997 | x1.011 | x1.012 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 2 μs | 0.0921 | 0.0921 | x1.000 | level | 2 of 4 | - | - | x0.980 | x1.016 | x1.000 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 4 of 4 | - | - | x0.918 | x1.010 | x0.780 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 64 B | 0.947 | 0.967 | x1.021 | level | 0 of 4 | - | - | x1.021 | x1.006 | x0.970 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 1 KiB | 1.244 | 1.246 | x1.002 | level | 0 of 4 | - | - | x1.002 | x1.002 | x1.064 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 4 KiB | 0.364 | 0.365 | x1.001 | level | 0 of 4 | - | - | x1.001 | x1.001 | x1.113 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 17.621 | 17.329 | x0.983 | level | 2 of 4 | - | - | x1.095 | x1.000 | x1.108 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 4 KiB | 0.278 | 0.270 | x0.973 | level | 2 of 4 | - | - | x0.914 | x1.000 | x1.001 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 1 MiB | 0.0396 | 0.0395 | x0.997 | level | 2 of 4 | - | - | x0.995 | x1.017 | x0.996 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 64 B | 0.364 | 0.353 | x0.968 | level | 4 of 4 | - | - | x0.968 | x0.971 | x1.034 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 4 KiB | 0.0821 | 0.0762 | x0.928 | level | 3 of 4 | - | - | x0.992 | x0.976 | x1.035 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 1 MiB | 0.00707 | 0.00621 | x0.879 | level | 4 of 4 | - | - | x0.914 | x0.885 | x0.845 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 B | 0.878 | 0.640 | x0.730 | level | 4 of 4 | - | - | x0.730 | x0.976 | x0.995 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 128 B | 0.486 | 0.343 | x0.706 | level | 4 of 4 | - | - | x0.706 | x0.976 | x0.984 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 256 B | 0.256 | 0.206 | x0.806 | level | 4 of 4 | - | - | x0.805 | x0.977 | x0.900 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 512 B | 0.153 | 0.135 | x0.883 | level | 4 of 4 | - | - | x0.882 | x0.979 | x0.908 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 KiB | 0.122 | 0.0931 | x0.762 | level | 4 of 4 | - | - | x0.762 | x0.988 | x0.946 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 4 KiB | 0.0933 | 0.0852 | x0.913 | level | 2 of 4 | - | - | x0.910 | x0.998 | x0.968 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 16 KiB | 0.0770 | 0.0685 | x0.889 | level | 2 of 4 | - | - | x0.889 | x1.015 | x1.011 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 KiB | 0.0797 | 0.0624 | x0.784 | level | 4 of 4 | - | - | x0.789 | x1.022 | x1.005 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 256 KiB | 0.0751 | 0.0621 | x0.827 | level | 4 of 4 | - | - | x0.825 | x1.020 | x1.011 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 MiB | 0.0767 | 0.0585 | x0.763 | level | 4 of 4 | - | - | x0.762 | x1.020 | x0.990 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 4 MiB | 0.0737 | 0.0584 | x0.793 | level | 4 of 4 | - | - | x0.792 | x1.018 | x0.971 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 16 MiB | 0.0723 | 0.0572 | x0.791 | level | 4 of 4 | - | - | x0.794 | x1.019 | x0.984 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 MiB | 0.0790 | 0.0656 | x0.831 | level | 4 of 4 | - | - | x0.830 | x1.019 | x1.027 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 16 | 9.298 | 8.097 | x0.871 | level | 3 of 4 | - | - | x0.877 | x0.973 | x0.997 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 64 | 7.435 | 5.904 | x0.794 | level | 4 of 4 | - | - | x0.798 | x0.986 | x1.033 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 256 | 6.922 | 5.824 | x0.841 | level | 4 of 4 | - | - | x0.839 | x0.997 | x0.971 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 1024 | 5.904 | 4.598 | x0.779 | level | 4 of 4 | - | - | x0.779 | x0.985 | x1.039 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 4096 | 5.430 | 5.399 | x0.994 | level | 2 of 4 | - | - | x0.993 | x0.992 | x1.011 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 16384 | 4.410 | 4.397 | x0.997 | level | 2 of 4 | - | - | x0.997 | x1.004 | x0.991 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 65536 | 3.276 | 3.267 | x0.997 | level | 2 of 4 | - | - | x0.997 | x1.006 | x0.997 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 B | 0.940 | 0.939 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.012 | x0.750 |
| blake3-servil-mt / shared-two-caches / LentMessages / 128 B | 1.077 | 1.078 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.007 | x0.794 |
| blake3-servil-mt / shared-two-caches / LentMessages / 256 B | 1.151 | 1.153 | x1.002 | level | 0 of 4 | - | - | x1.002 | x1.004 | x0.822 |
| blake3-servil-mt / shared-two-caches / LentMessages / 512 B | 1.188 | 1.189 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.002 | x0.853 |
| blake3-servil-mt / shared-two-caches / LentMessages / 1 KiB | 1.212 | 1.211 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.001 | x1.012 |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 KiB | 0.358 | 0.357 | x1.000 | level | 4 of 4 | - | - | x1.000 | x1.001 | x1.106 |
| blake3-servil-mt / shared-two-caches / LentMessages / 16 KiB | 0.114 | 0.114 | x0.997 | level | 4 of 4 | - | - | x0.997 | x1.000 | x1.011 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 KiB | 0.0813 | 0.0809 | x0.995 | level | 4 of 4 | - | - | x0.995 | x1.000 | x0.933 |
| blake3-servil-mt / shared-two-caches / LentMessages / 256 KiB | 0.0773 | 0.0770 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.181 |
| blake3-servil-mt / shared-two-caches / LentMessages / 1 MiB | 0.0639 | 0.0637 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.015 | x0.997 |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 MiB | 0.0426 | 0.0438 | x1.030 | level | 0 of 4 | - | - | x1.032 | x0.991 | x1.012 |
| blake3-servil-mt / shared-two-caches / LentMessages / 16 MiB | 0.0385 | 0.0387 | x1.005 | level | 2 of 4 | - | - | x1.007 | x0.988 | x0.972 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 MiB | 0.0373 | 0.0374 | x1.002 | level | 0 of 4 | - | - | x1.002 | x0.997 | x1.008 |
| blake3-servil-mt / shared-two-caches / Interleaved / 256 | 0.137 | 0.136 | x0.999 | level | 3 of 4 | - | - | x0.999 | x0.999 | x1.002 |
| blake3-servil-mt / shared-two-caches / Collection / git objects | 0.0152 | 0.0154 | x1.009 | level | 1 of 4 | - | - | x1.026 | x1.029 | x1.030 |
| blake3-servil-mt / shared-two-caches / Collection / Nix files | 0.0173 | 0.0172 | x0.992 | level | 2 of 4 | - | - | x0.990 | x1.000 | x1.014 |
| blake3-servil-mt / shared-two-caches / LentBatches / 16 | 7.533 | 7.551 | x1.002 | level | 0 of 4 | - | - | x1.002 | x0.998 | x1.148 |
| blake3-servil-mt / shared-two-caches / LentBatches / 64 | 6.636 | 6.676 | x1.006 | level | 1 of 4 | - | - | x1.006 | x0.999 | x0.913 |
| blake3-servil-mt / shared-two-caches / LentBatches / 256 | 6.584 | 6.585 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.903 |
| blake3-servil-mt / shared-two-caches / LentBatches / 1024 | 7.046 | 7.038 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.155 |
| blake3-servil-mt / shared-two-caches / LentBatches / 4096 | 6.961 | 6.928 | x0.995 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.628 |
| blake3-servil-mt / shared-two-caches / LentBatches / 16384 | 4.324 | 4.234 | x0.979 | level | 4 of 4 | - | - | x0.978 | x1.000 | x0.986 |
| blake3-servil-mt / shared-two-caches / LentBatches / 65536 | 2.883 | 2.966 | x1.029 | level | 0 of 4 | - | - | x1.031 | x0.999 | x0.988 |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / git objects | 0.0736 | 0.0680 | x0.924 | level | 3 of 4 | - | - | x0.924 | x1.009 | x0.998 |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / Nix files | 0.0710 | 0.0660 | x0.930 | level | 4 of 4 | - | - | x0.929 | x1.008 | x1.032 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1024 | 0.126 | 0.126 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.001 | x1.091 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 4096 | 0.0739 | 0.0732 | x0.991 | level | 2 of 4 | - | - | x0.992 | x1.000 | x0.998 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 16384 | 0.0869 | 0.0828 | x0.953 | level | 4 of 4 | - | - | x0.954 | x1.013 | x0.991 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 | 0.0841 | 0.0833 | x0.989 | level | 3 of 4 | - | - | x0.990 | x0.988 | x0.987 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 262144 | 0.0599 | 0.0592 | x0.988 | level | 3 of 4 | - | - | x0.990 | x0.998 | x0.958 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 x 32 B | 0.180 | 0.175 | x0.977 | level | 4 of 4 | - | - | x0.977 | x1.037 | x0.972 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 32 B | 0.0797 | 0.0818 | x1.027 | level | 0 of 4 | - | - | x1.028 | x1.040 | x0.976 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 16 B | 0.158 | 0.158 | x1.001 | level | 2 of 4 | - | - | x0.997 | x1.168 | x0.916 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 x 48 B | 0.133 | 0.139 | x1.049 | level | 1 of 4 | - | - | x1.049 | x0.958 | x1.017 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 48 B | 0.0648 | 0.0645 | x0.995 | level | 2 of 4 | - | - | x0.994 | x1.002 | x0.918 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / saturated | 0.0760 | 0.0647 | x0.851 | level | 4 of 4 | - | - | x0.849 | x1.023 | x0.983 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / 2 μs | 0.102 | 0.0924 | x0.908 | level | 4 of 4 | - | - | x0.922 | x1.006 | x1.012 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 2 of 4 | - | - | x0.811 | x1.004 | x0.945 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 64 B | 0.946 | 0.967 | x1.022 | level | 0 of 4 | - | - | x1.022 | x1.006 | x0.957 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 1 KiB | 1.244 | 1.246 | x1.002 | level | 0 of 4 | - | - | x1.002 | x1.002 | x1.042 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 4 KiB | 0.364 | 0.365 | x1.001 | level | 0 of 4 | - | - | x1.001 | x1.001 | x0.910 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 64 B | 17.327 | 17.834 | x1.029 | level | 1 of 4 | - | - | x1.049 | x0.992 | x1.104 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 4 KiB | 0.282 | 0.257 | x0.909 | level | 4 of 4 | - | - | x0.903 | x1.004 | x1.007 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 1 MiB | 0.0813 | 0.0611 | x0.752 | level | 4 of 4 | - | - | x0.761 | x1.020 | x0.990 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 64 B | 0.431 | 0.420 | x0.974 | level | 3 of 4 | - | - | x0.974 | x0.971 | x1.024 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 4 KiB | 0.0664 | 0.0645 | x0.971 | level | 3 of 4 | - | - | x1.001 | x0.973 | x1.030 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 1 MiB | 0.00744 | 0.00716 | x0.962 | level | 3 of 4 | - | - | x0.934 | x0.925 | x0.904 |

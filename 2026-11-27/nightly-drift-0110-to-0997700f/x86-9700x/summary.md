# Nightly drift check: e1966b498bc7 -> 0997700f35b0

- Host: bench-9700x
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
| blake3-servil-st / solo / ManyMessages / 1 | 399.935 | 406.711 | x1.017 | level | 28 of 64 | - | - | x1.011 | x1.012 | x1.010 |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.749 | 0.754 | x1.006 | level | 0 of 64 | x1.006 | - | x1.006 | x1.012 | x0.966 |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.242 | 0.236 | x0.978 | level | 44 of 64 | - | - | x0.990 | x0.999 | x0.985 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 0.758 | 0.761 | x1.005 | level | 0 of 64 | x1.005 | - | x1.005 | x1.013 | x0.940 |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 0.725 | 0.727 | x1.004 | level | 1 of 64 | x1.004 | - | x1.004 | x1.015 | x0.801 |
| blake3-servil-mt / solo / IdleOneMessage / 4470 B | 0.550 | 0.551 | x1.001 | level | 31 of 64 | - | - | x1.000 | x1.001 | x1.022 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 32 B | 0.0790 | 0.0797 | x1.010 | level | 27 of 64 | x1.008 | - | x1.000 | x1.000 | x1.000 |
| blake3-servil-mt / solo / ContinuousLentMessages / 4 KiB | 0.0210 | 0.0210 | x0.998 | level | 38 of 64 | x0.991 | - | x0.997 | x0.979 | x0.983 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 32 B | 0.0929 | 0.0926 | x0.997 | level | 33 of 64 | - | - | x0.994 | x0.998 | x0.913 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 4 KiB | 0.0413 | 0.0398 | x0.965 | level | 39 of 64 | - | - | x0.991 | x0.978 | x0.955 |

## Stage 1 (initial screen, kept-drift)

compare: old side: bench 3f119a507807 clean; servil e1966b498bc7 clean
compare: new side: bench 3f119a507807 clean; servil 0997700f35b0 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 6.889 | 6.752 | x0.980 | level | 2 of 4 | - | - | x0.970 | x0.989 | x0.942 |
| blake3-servil-st / solo / OneMessage / 128 B | 4.252 | 3.950 | x0.929 | level | 2 of 4 | - | - | x0.933 | x0.991 | x0.921 |
| blake3-servil-st / solo / OneMessage / 256 B | 2.737 | 2.589 | x0.946 | level | 2 of 4 | - | - | x0.938 | x1.003 | x0.951 |
| blake3-servil-st / solo / OneMessage / 512 B | 1.896 | 1.856 | x0.979 | level | 3 of 4 | - | - | x0.981 | x1.003 | x0.970 |
| blake3-servil-st / solo / OneMessage / 1 KiB | 1.500 | 1.500 | x1.000 | level | 2 of 4 | - | - | x0.991 | x0.999 | x0.966 |
| blake3-servil-st / solo / OneMessage / 1536 B | 1.401 | 1.427 | x1.019 | level | 1 of 4 | - | - | x1.013 | x0.999 | x0.978 |
| blake3-servil-st / solo / OneMessage / 2 KiB | 0.847 | 0.844 | x0.997 | level | 2 of 4 | - | - | x0.978 | x0.999 | x0.973 |
| blake3-servil-st / solo / OneMessage / 2304 B | 1.044 | 1.014 | x0.971 | level | 3 of 4 | - | - | x0.974 | x1.001 | x0.995 |
| blake3-servil-st / solo / OneMessage / 3 KiB | 0.713 | 0.711 | x0.996 | level | 2 of 4 | - | - | x0.991 | x0.998 | x0.991 |
| blake3-servil-st / solo / OneMessage / 3839 B | 0.793 | 0.760 | x0.959 | level | 4 of 4 | - | - | x0.966 | x0.999 | x1.007 |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.465 | 0.467 | x1.004 | level | 2 of 4 | - | - | x0.993 | x0.997 | x0.991 |
| blake3-servil-st / solo / OneMessage / 4470 B | 0.606 | 0.603 | x0.994 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.998 |
| blake3-servil-st / solo / OneMessage / 7935 B | 0.604 | 0.591 | x0.977 | level | 3 of 4 | - | - | x0.977 | x1.001 | x0.969 |
| blake3-servil-st / solo / OneMessage / 8 KiB | 0.373 | 0.374 | x1.004 | level | 2 of 4 | - | - | x0.999 | x1.002 | x0.992 |
| blake3-servil-st / solo / OneMessage / 16 KiB | 0.226 | 0.231 | x1.019 | level | 1 of 4 | - | - | x0.999 | x1.000 | x0.983 |
| blake3-servil-st / solo / OneMessage / 32 KiB | 0.197 | 0.196 | x0.997 | level | 3 of 4 | - | - | x0.990 | x1.000 | x0.965 |
| blake3-servil-st / solo / OneMessage / 64 KiB | 0.144 | 0.148 | x1.032 | level | 1 of 4 | - | - | x1.028 | x1.000 | x0.987 |
| blake3-servil-st / solo / OneMessage / 128 KiB | 0.116 | 0.118 | x1.019 | level | 1 of 4 | - | - | x1.015 | x1.000 | x0.922 |
| blake3-servil-st / solo / OneMessage / 256 KiB | 0.102 | 0.105 | x1.024 | level | 1 of 4 | - | - | x1.020 | x1.000 | x0.868 |
| blake3-servil-st / solo / OneMessage / 512 KiB | 0.0911 | 0.0912 | x1.002 | level | 2 of 4 | - | - | x1.005 | x1.000 | x0.869 |
| blake3-servil-st / solo / OneMessage / 1 MiB | 0.0853 | 0.0858 | x1.005 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.031 |
| blake3-servil-st / solo / OneMessage / 2 MiB | 0.0847 | 0.0851 | x1.005 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.039 |
| blake3-servil-st / solo / OneMessage / 3 MiB | 0.0848 | 0.0854 | x1.007 | level | 1 of 4 | - | - | x1.006 | x1.000 | x1.053 |
| blake3-servil-st / solo / OneMessage / 4 MiB | 0.0847 | 0.0852 | x1.007 | level | 1 of 4 | - | - | x1.007 | x1.000 | x1.071 |
| blake3-servil-st / solo / OneMessage / 8 MiB | 0.0900 | 0.0907 | x1.009 | level | 1 of 4 | - | - | x1.007 | x1.000 | x1.069 |
| blake3-servil-st / solo / OneMessage / 32 MiB | 0.130 | 0.131 | x1.010 | level | 1 of 4 | - | - | x1.010 | x1.000 | x1.020 |
| blake3-servil-st / solo / OneMessage / 64 MiB | 0.130 | 0.132 | x1.011 | level | 1 of 4 | - | - | x1.009 | x1.000 | x1.024 |
| blake3-servil-st / solo / OneMessage / 128 MiB | 0.131 | 0.131 | x1.004 | level | 2 of 4 | - | - | x1.005 | x1.000 | x1.017 |
| blake3-servil-st / solo / ManyMessages / 1 | 606.365 | 711.396 | x1.173 | level | 0 of 4 | - | - | x1.140 | x1.005 | x1.196 |
| blake3-servil-st / solo / ManyMessages / 2 | 278.357 | 278.423 | x1.000 | level | 1 of 4 | - | - | x0.996 | x0.986 | x1.024 |
| blake3-servil-st / solo / ManyMessages / 3 | 215.297 | 219.688 | x1.020 | level | 2 of 4 | - | - | x0.996 | x0.994 | x1.015 |
| blake3-servil-st / solo / ManyMessages / 4 | 140.914 | 139.418 | x0.989 | level | 2 of 4 | - | - | x0.987 | x0.993 | x1.011 |
| blake3-servil-st / solo / ManyMessages / 6 | 110.609 | 109.736 | x0.992 | level | 1 of 4 | - | - | x0.990 | x0.998 | x0.989 |
| blake3-servil-st / solo / ManyMessages / 8 | 104.979 | 109.035 | x1.039 | level | 1 of 4 | - | - | x1.010 | x1.001 | x1.011 |
| blake3-servil-st / solo / ManyMessages / 12 | 81.043 | 78.157 | x0.964 | level | 3 of 4 | - | - | x0.964 | x0.996 | x1.010 |
| blake3-servil-st / solo / ManyMessages / 16 | 57.850 | 59.625 | x1.031 | level | 1 of 4 | - | - | x1.025 | x0.991 | x1.017 |
| blake3-servil-st / solo / ManyMessages / 24 | 49.643 | 50.898 | x1.025 | level | 2 of 4 | - | - | x1.003 | x0.997 | x1.003 |
| blake3-servil-st / solo / ManyMessages / 32 | 31.521 | 31.216 | x0.990 | level | 2 of 4 | - | - | x0.977 | x0.996 | x0.997 |
| blake3-servil-st / solo / ManyMessages / 48 | 22.663 | 23.382 | x1.032 | level | 1 of 4 | - | - | x1.017 | x0.996 | x1.001 |
| blake3-servil-st / solo / ManyMessages / 64 | 19.319 | 18.930 | x0.980 | level | 1 of 4 | - | - | x0.967 | x0.998 | x1.006 |
| blake3-servil-st / solo / ManyMessages / 128 | 13.663 | 13.506 | x0.989 | level | 1 of 4 | - | - | x0.982 | x1.000 | x1.006 |
| blake3-servil-st / solo / ManyMessages / 256 | 10.419 | 10.529 | x1.011 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.989 |
| blake3-servil-st / solo / ManyMessages / 512 | 9.010 | 9.137 | x1.014 | level | 1 of 4 | - | - | x1.013 | x1.000 | x0.935 |
| blake3-servil-st / solo / ManyMessages / 1024 | 8.046 | 8.141 | x1.012 | level | 1 of 4 | - | - | x1.007 | x1.000 | x0.912 |
| blake3-servil-st / solo / ManyMessages / 2048 | 7.589 | 7.781 | x1.025 | level | 1 of 4 | - | - | x1.019 | x1.000 | x0.905 |
| blake3-servil-st / solo / ManyMessages / 4096 | 7.468 | 7.592 | x1.017 | level | 1 of 4 | - | - | x1.018 | x1.000 | x0.995 |
| blake3-servil-st / solo / ManyMessages / 8192 | 7.047 | 7.117 | x1.010 | level | 1 of 4 | - | - | x1.010 | x1.000 | x0.924 |
| blake3-servil-st / solo / ManyMessages / 16384 | 6.747 | 6.789 | x1.006 | level | 1 of 4 | - | - | x1.007 | x1.000 | x0.950 |
| blake3-servil-st / solo / ManyMessages / 32768 | 6.762 | 6.807 | x1.007 | level | 1 of 4 | - | - | x1.007 | x1.000 | x0.949 |
| blake3-servil-st / solo / ManyMessages / 65536 | 6.913 | 6.957 | x1.006 | level | 1 of 4 | - | - | x1.006 | x1.000 | x0.969 |
| blake3-servil-st / solo / ManyMessages / 131072 | 7.229 | 7.237 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.990 |
| blake3-servil-st / solo / ManyMessages / 262144 | 7.702 | 7.693 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.981 |
| blake3-servil-st / solo / ManyLongMessages / 4 | 1687.980 | 1753.292 | x1.039 | level | 1 of 4 | - | - | x1.032 | x1.001 | x0.990 |
| blake3-servil-st / solo / ManyLongMessages / 16 | 1378.474 | 633.125 | x0.459 | faster | 4 of 4 | - | - | x0.465 | x0.575 | x1.298 |
| blake3-servil-st / solo / ManyLongMessages / 64 | 503.765 | 492.238 | x0.977 | level | 4 of 4 | - | - | x0.976 | x0.998 | x0.884 |
| blake3-servil-st / solo / ManyLongMessages / 256 | 447.813 | 444.100 | x0.992 | level | 4 of 4 | - | - | x0.992 | x0.998 | x0.841 |
| blake3-servil-st / solo / IdleOneMessage / 64 B | 3.438 | 3.497 | x1.017 | level | 0 of 4 | - | - | x1.006 | x1.007 | x0.884 |
| blake3-servil-st / solo / IdleOneMessage / 128 B | 2.435 | 2.448 | x1.005 | level | 1 of 4 | - | - | x1.007 | x1.006 | x0.518 |
| blake3-servil-st / solo / IdleOneMessage / 256 B | 1.942 | 1.944 | x1.001 | level | 2 of 4 | - | - | x1.004 | x1.004 | x1.247 |
| blake3-servil-st / solo / IdleOneMessage / 512 B | 1.641 | 1.666 | x1.015 | level | 1 of 4 | - | - | x0.999 | x1.002 | x0.567 |
| blake3-servil-st / solo / IdleOneMessage / 1 KiB | 1.534 | 1.552 | x1.012 | level | 2 of 4 | - | - | x1.002 | x1.001 | x1.566 |
| blake3-servil-st / solo / IdleOneMessage / 1536 B | 1.146 | 1.128 | x0.984 | level | 1 of 4 | - | - | x0.998 | x0.998 | x1.317 |
| blake3-servil-st / solo / IdleOneMessage / 2 KiB | 0.845 | 0.826 | x0.978 | level | 4 of 4 | - | - | x0.997 | x1.001 | x0.440 |
| blake3-servil-st / solo / IdleOneMessage / 2304 B | 0.930 | 0.913 | x0.982 | level | 3 of 4 | - | - | x0.994 | x1.001 | x1.354 |
| blake3-servil-st / solo / IdleOneMessage / 3 KiB | 0.589 | 0.589 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.001 | x1.104 |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 0.488 | 0.483 | x0.989 | level | 4 of 4 | - | - | x1.004 | x1.001 | x0.918 |
| blake3-servil-st / solo / IdleOneMessage / 4 KiB | 0.441 | 0.450 | x1.020 | level | 1 of 4 | - | - | x0.999 | x1.001 | x0.840 |
| blake3-servil-st / solo / IdleOneMessage / 4470 B | 0.552 | 0.542 | x0.981 | level | 3 of 4 | - | - | x1.002 | x1.001 | x3.147 |
| blake3-servil-st / solo / IdleOneMessage / 7935 B | 0.279 | 0.277 | x0.992 | level | 3 of 4 | - | - | x0.997 | x1.001 | x0.545 |
| blake3-servil-st / solo / IdleOneMessage / 8 KiB | 0.257 | 0.258 | x1.005 | level | 2 of 4 | - | - | x1.003 | x1.001 | x0.780 |
| blake3-servil-st / solo / IdleOneMessage / 16 KiB | 0.144 | 0.147 | x1.015 | level | 2 of 4 | - | - | x0.997 | x1.001 | x0.429 |
| blake3-servil-st / solo / IdleOneMessage / 32 KiB | 0.0999 | 0.100 | x1.003 | level | 1 of 4 | - | - | x1.006 | x1.000 | x1.456 |
| blake3-servil-st / solo / IdleOneMessage / 64 KiB | 0.0900 | 0.0929 | x1.032 | level | 1 of 4 | - | - | x0.996 | x1.000 | x0.280 |
| blake3-servil-st / solo / IdleOneMessage / 128 KiB | 0.0889 | 0.0875 | x0.985 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.297 |
| blake3-servil-st / solo / IdleOneMessage / 256 KiB | 0.0872 | 0.0872 | x1.000 | level | 2 of 4 | - | - | x1.013 | x1.000 | x1.558 |
| blake3-servil-st / solo / IdleOneMessage / 512 KiB | 0.0957 | 0.0938 | x0.980 | level | 4 of 4 | - | - | x1.007 | x1.000 | x1.017 |
| blake3-servil-st / solo / IdleOneMessage / 1 MiB | 0.0977 | 0.0974 | x0.996 | level | 2 of 4 | - | - | x1.005 | x1.000 | x0.968 |
| blake3-servil-st / solo / IdleOneMessage / 2 MiB | 0.0978 | 0.0984 | x1.006 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.970 |
| blake3-servil-st / solo / IdleOneMessage / 3 MiB | 0.0970 | 0.0973 | x1.003 | level | 3 of 4 | - | - | x1.001 | x1.000 | x0.967 |
| blake3-servil-st / solo / IdleOneMessage / 4 MiB | 0.0980 | 0.0966 | x0.986 | level | 3 of 4 | - | - | x1.001 | x1.000 | x0.984 |
| blake3-servil-st / solo / IdleOneMessage / 8 MiB | 0.0972 | 0.0980 | x1.007 | level | 1 of 4 | - | - | x0.998 | x1.000 | x0.967 |
| blake3-servil-st / solo / IdleOneMessage / 32 MiB | 0.124 | 0.126 | x1.013 | level | 1 of 4 | - | - | x1.018 | x1.000 | x1.018 |
| blake3-servil-st / solo / IdleOneMessage / 64 MiB | 0.129 | 0.130 | x1.009 | level | 1 of 4 | - | - | x1.007 | x1.000 | x1.024 |
| blake3-servil-st / solo / IdleOneMessage / 128 MiB | 0.130 | 0.131 | x1.005 | level | 2 of 4 | - | - | x1.006 | x1.000 | x1.019 |
| blake3-servil-st / solo / IdleManyMessages / 1 | 233.835 | 239.753 | x1.025 | level | 0 of 4 | - | - | x1.007 | x1.010 | x0.989 |
| blake3-servil-st / solo / IdleManyMessages / 2 | 120.874 | 122.082 | x1.010 | level | 1 of 4 | - | - | x0.998 | x0.999 | x0.981 |
| blake3-servil-st / solo / IdleManyMessages / 3 | 104.411 | 103.830 | x0.994 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.440 |
| blake3-servil-st / solo / IdleManyMessages / 4 | 61.370 | 61.941 | x1.009 | level | 2 of 4 | - | - | x1.009 | x1.000 | x1.115 |
| blake3-servil-st / solo / IdleManyMessages / 6 | 53.669 | 52.578 | x0.980 | level | 3 of 4 | - | - | x0.997 | x0.999 | x0.964 |
| blake3-servil-st / solo / IdleManyMessages / 8 | 32.466 | 32.425 | x0.999 | level | 3 of 4 | - | - | x1.003 | x0.999 | x2.049 |
| blake3-servil-st / solo / IdleManyMessages / 12 | 29.382 | 30.045 | x1.023 | level | 0 of 4 | - | - | x1.020 | x1.000 | x1.058 |
| blake3-servil-st / solo / IdleManyMessages / 16 | 17.149 | 17.003 | x0.992 | level | 2 of 4 | - | - | x0.994 | x1.000 | x0.665 |
| blake3-servil-st / solo / IdleManyMessages / 24 | 15.879 | 16.036 | x1.010 | level | 2 of 4 | - | - | x1.002 | x0.999 | x1.685 |
| blake3-servil-st / solo / IdleManyMessages / 32 | 12.216 | 12.078 | x0.989 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.157 |
| blake3-servil-st / solo / IdleManyMessages / 48 | 10.714 | 10.486 | x0.979 | level | 4 of 4 | - | - | x0.999 | x1.000 | x0.676 |
| blake3-servil-st / solo / IdleManyMessages / 64 | 9.942 | 9.914 | x0.997 | level | 3 of 4 | - | - | x1.001 | x1.000 | x1.499 |
| blake3-servil-st / solo / IdleManyMessages / 128 | 8.778 | 8.648 | x0.985 | level | 4 of 4 | - | - | x0.996 | x1.000 | x0.403 |
| blake3-servil-st / solo / IdleManyMessages / 256 | 8.273 | 7.985 | x0.965 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.029 |
| blake3-servil-st / solo / IdleManyMessages / 512 | 7.665 | 7.671 | x1.001 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.597 |
| blake3-servil-st / solo / IdleManyMessages / 1024 | 7.531 | 7.530 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.250 |
| blake3-servil-st / solo / IdleManyMessages / 2048 | 7.539 | 7.515 | x0.997 | level | 2 of 4 | - | - | x1.012 | x1.000 | x1.120 |
| blake3-servil-st / solo / IdleManyMessages / 4096 | 7.854 | 7.791 | x0.992 | level | 3 of 4 | - | - | x1.013 | x1.000 | x1.118 |
| blake3-servil-st / solo / IdleManyMessages / 8192 | 8.331 | 8.300 | x0.996 | level | 3 of 4 | - | - | x1.005 | x1.000 | x1.025 |
| blake3-servil-st / solo / IdleManyMessages / 16384 | 8.477 | 8.698 | x1.026 | level | 0 of 4 | - | - | x1.004 | x1.000 | x1.028 |
| blake3-servil-st / solo / IdleManyMessages / 32768 | 8.450 | 8.618 | x1.020 | level | 0 of 4 | - | - | x1.009 | x1.000 | x1.026 |
| blake3-servil-st / solo / IdleManyMessages / 65536 | 8.439 | 8.554 | x1.014 | level | 1 of 4 | - | - | x1.008 | x1.000 | x1.004 |
| blake3-servil-st / solo / IdleManyMessages / 131072 | 7.839 | 7.618 | x0.972 | level | 3 of 4 | - | - | x1.009 | x1.000 | x0.983 |
| blake3-servil-st / solo / IdleManyMessages / 262144 | 8.084 | 8.316 | x1.029 | level | 1 of 4 | - | - | x1.032 | x1.000 | x1.056 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 B | 2.422 | 2.435 | x1.005 | level | 1 of 4 | - | - | x1.004 | x1.006 | x1.041 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 B | 1.692 | 1.699 | x1.004 | level | 0 of 4 | - | - | x1.005 | x1.006 | x0.930 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 B | 1.357 | 1.356 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.004 | x0.563 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 B | 1.167 | 1.167 | x1.001 | level | 1 of 4 | - | - | x1.002 | x1.002 | x0.976 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 KiB | 1.078 | 1.078 | x1.000 | level | 3 of 4 | - | - | x1.001 | x1.001 | x1.897 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1536 B | 0.810 | 0.810 | x0.999 | level | 3 of 4 | - | - | x0.999 | x0.998 | x0.859 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 KiB | 0.584 | 0.584 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.001 | x0.533 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2304 B | 0.652 | 0.649 | x0.995 | level | 4 of 4 | - | - | x0.995 | x1.002 | x0.295 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.418 | 0.418 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.545 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3839 B | 0.341 | 0.341 | x1.002 | level | 2 of 4 | - | - | x1.001 | x1.001 | x1.427 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 KiB | 0.311 | 0.311 | x0.999 | level | 3 of 4 | - | - | x1.000 | x1.001 | x0.810 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4470 B | 0.383 | 0.383 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.001 | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 7935 B | 0.193 | 0.198 | x1.025 | level | 2 of 4 | - | - | x1.000 | x1.001 | x0.642 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 KiB | 0.179 | 0.179 | x0.996 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.242 |
| blake3-servil-st / solo / BriefIdleOneMessage / 16 KiB | 0.101 | 0.100 | x0.995 | level | 3 of 4 | - | - | x0.996 | x1.001 | x0.842 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 KiB | 0.0706 | 0.0707 | x1.002 | level | 2 of 4 | - | - | x1.004 | x1.000 | x0.748 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 KiB | 0.0653 | 0.0681 | x1.042 | level | 1 of 4 | - | - | x1.006 | x1.000 | x1.157 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 KiB | 0.0628 | 0.0631 | x1.005 | level | 2 of 4 | - | - | x1.006 | x1.000 | x1.934 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 KiB | 0.0623 | 0.0627 | x1.007 | level | 2 of 4 | - | - | x1.007 | x1.000 | x2.072 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 KiB | 0.0669 | 0.0669 | x1.000 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.940 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 MiB | 0.0697 | 0.0703 | x1.009 | level | 2 of 4 | - | - | x1.006 | x1.000 | x0.999 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 MiB | 0.0705 | 0.0704 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.009 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 MiB | 0.0702 | 0.0700 | x0.997 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.998 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 MiB | 0.0700 | 0.0701 | x1.002 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.979 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 MiB | 0.0714 | 0.0716 | x1.002 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.973 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 MiB | 0.127 | 0.128 | x1.012 | level | 1 of 4 | - | - | x1.012 | x1.000 | x1.018 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 MiB | 0.130 | 0.131 | x1.009 | level | 1 of 4 | - | - | x1.009 | x1.000 | x1.026 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 MiB | 0.131 | 0.131 | x1.004 | level | 2 of 4 | - | - | x1.004 | x1.000 | x1.019 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1 | 165.643 | 168.065 | x1.015 | level | 1 of 4 | - | - | x1.007 | x1.011 | x1.236 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2 | 83.496 | 84.608 | x1.013 | level | 1 of 4 | - | - | x1.011 | x1.000 | x2.255 |
| blake3-servil-st / solo / BriefIdleManyMessages / 3 | 72.103 | 72.250 | x1.002 | level | 3 of 4 | - | - | x1.003 | x1.000 | x0.607 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4 | 42.182 | 43.061 | x1.021 | level | 1 of 4 | - | - | x1.015 | x1.000 | x1.944 |
| blake3-servil-st / solo / BriefIdleManyMessages / 6 | 36.807 | 37.023 | x1.006 | level | 2 of 4 | - | - | x1.005 | x0.999 | x1.830 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8 | 23.191 | 22.713 | x0.979 | level | 2 of 4 | - | - | x0.989 | x0.999 | x0.805 |
| blake3-servil-st / solo / BriefIdleManyMessages / 12 | 20.834 | 20.459 | x0.982 | level | 3 of 4 | - | - | x0.990 | x1.000 | x0.804 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16 | 11.924 | 11.881 | x0.996 | level | 1 of 4 | - | - | x0.998 | x1.000 | x1.035 |
| blake3-servil-st / solo / BriefIdleManyMessages / 24 | 11.262 | 11.019 | x0.978 | level | 3 of 4 | - | - | x0.987 | x1.000 | x1.351 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32 | 8.485 | 8.454 | x0.996 | level | 2 of 4 | - | - | x0.999 | x1.000 | x2.523 |
| blake3-servil-st / solo / BriefIdleManyMessages / 48 | 7.373 | 7.324 | x0.993 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.058 |
| blake3-servil-st / solo / BriefIdleManyMessages / 64 | 6.776 | 6.762 | x0.998 | level | 3 of 4 | - | - | x1.001 | x1.000 | x1.166 |
| blake3-servil-st / solo / BriefIdleManyMessages / 128 | 5.962 | 5.954 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.764 |
| blake3-servil-st / solo / BriefIdleManyMessages / 256 | 5.642 | 5.648 | x1.001 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.254 |
| blake3-servil-st / solo / BriefIdleManyMessages / 512 | 5.445 | 5.447 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.715 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1024 | 5.360 | 5.368 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.758 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2048 | 5.394 | 5.400 | x1.001 | level | 1 of 4 | - | - | x1.008 | x1.000 | x1.182 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4096 | 5.461 | 5.507 | x1.008 | level | 1 of 4 | - | - | x1.007 | x1.000 | x1.114 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8192 | 5.851 | 5.837 | x0.998 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.010 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16384 | 6.046 | 6.048 | x1.000 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.058 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32768 | 6.071 | 6.091 | x1.003 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.059 |
| blake3-servil-st / solo / BriefIdleManyMessages / 65536 | 6.029 | 6.047 | x1.003 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.012 |
| blake3-servil-st / solo / BriefIdleManyMessages / 131072 | 6.065 | 6.084 | x1.003 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.997 |
| blake3-servil-st / solo / BriefIdleManyMessages / 262144 | 6.996 | 7.042 | x1.007 | level | 1 of 4 | - | - | x1.006 | x1.000 | x1.039 |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.746 | 0.752 | x1.008 | level | 0 of 4 | x1.008 | - | x1.007 | x1.012 | x0.839 |
| blake3-servil-st / solo / ContinuousMessages / 128 B | 0.857 | 0.857 | x1.000 | level | 2 of 4 | x1.000 | - | x1.001 | x1.007 | x1.372 |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 0.914 | 0.915 | x1.001 | level | 0 of 4 | x1.001 | - | x1.001 | x1.004 | x0.796 |
| blake3-servil-st / solo / ContinuousMessages / 512 B | 0.944 | 0.944 | x1.000 | level | 2 of 4 | x1.000 | - | x1.001 | x1.002 | x1.103 |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 0.962 | 0.962 | x1.000 | level | 1 of 4 | x1.001 | - | x1.001 | x1.001 | x0.800 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.285 | 0.285 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.811 |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.0911 | 0.0910 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x0.583 |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.0651 | 0.0652 | x1.002 | level | 2 of 4 | x1.002 | - | x1.001 | x1.000 | x0.901 |
| blake3-servil-st / solo / ContinuousMessages / 256 KiB | 0.0667 | 0.0668 | x1.002 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x0.719 |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.0674 | 0.0677 | x1.004 | level | 1 of 4 | x1.004 | - | x1.005 | x1.000 | x1.099 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.0684 | 0.0686 | x1.003 | level | 1 of 4 | x1.003 | - | x1.005 | x1.000 | x1.029 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.0686 | 0.0689 | x1.004 | level | 1 of 4 | x1.004 | - | x1.005 | x1.000 | x1.009 |
| blake3-servil-st / solo / ContinuousMessages / 64 MiB | 0.0794 | 0.0797 | x1.005 | level | 1 of 4 | x1.004 | - | x1.004 | x1.000 | x1.001 |
| blake3-servil-st / solo / ContinuousBatches / 16 | 6.036 | 6.049 | x1.002 | level | 3 of 4 | x1.002 | - | x1.002 | x0.998 | x0.880 |
| blake3-servil-st / solo / ContinuousBatches / 64 | 5.312 | 5.337 | x1.005 | level | 1 of 4 | x1.005 | - | x1.005 | x0.999 | x0.783 |
| blake3-servil-st / solo / ContinuousBatches / 256 | 5.308 | 5.318 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.000 | x0.798 |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 5.617 | 5.607 | x0.998 | level | 3 of 4 | x0.998 | - | x0.999 | x1.000 | x2.168 |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 5.496 | 5.478 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x1.000 | x0.144 |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 6.137 | 6.128 | x0.999 | level | 2 of 4 | x0.999 | - | x0.998 | x1.000 | x1.015 |
| blake3-servil-st / solo / ContinuousBatches / 65536 | 6.171 | 6.157 | x0.998 | level | 3 of 4 | x0.998 | - | x0.997 | x1.000 | x1.027 |
| blake3-servil-st / solo / LentMessages / 64 B | 0.746 | 0.752 | x1.008 | level | 0 of 4 | x1.008 | - | x1.007 | x1.012 | x0.839 |
| blake3-servil-st / solo / LentMessages / 128 B | 0.857 | 0.857 | x1.000 | level | 2 of 4 | x1.000 | - | x1.001 | x1.007 | x1.372 |
| blake3-servil-st / solo / LentMessages / 256 B | 0.914 | 0.915 | x1.001 | level | 0 of 4 | x1.001 | - | x1.001 | x1.004 | x0.796 |
| blake3-servil-st / solo / LentMessages / 512 B | 0.944 | 0.944 | x1.000 | level | 2 of 4 | x1.000 | - | x1.001 | x1.002 | x1.103 |
| blake3-servil-st / solo / LentMessages / 1 KiB | 0.962 | 0.962 | x1.000 | level | 1 of 4 | x1.001 | - | x1.001 | x1.001 | x0.800 |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.285 | 0.285 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.811 |
| blake3-servil-st / solo / LentMessages / 16 KiB | 0.0911 | 0.0910 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x0.583 |
| blake3-servil-st / solo / LentMessages / 64 KiB | 0.0651 | 0.0652 | x1.002 | level | 2 of 4 | x1.002 | - | x1.001 | x1.000 | x0.901 |
| blake3-servil-st / solo / LentMessages / 256 KiB | 0.0615 | 0.0616 | x1.001 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x1.017 |
| blake3-servil-st / solo / LentMessages / 1 MiB | 0.0690 | 0.0689 | x0.998 | level | 2 of 4 | x0.998 | - | x0.999 | x1.000 | x1.037 |
| blake3-servil-st / solo / LentMessages / 4 MiB | 0.0701 | 0.0697 | x0.995 | level | 3 of 4 | x0.995 | - | x0.995 | x1.000 | x0.953 |
| blake3-servil-st / solo / LentMessages / 16 MiB | 0.0752 | 0.0755 | x1.004 | level | 1 of 4 | x1.004 | - | x1.005 | x1.000 | x1.055 |
| blake3-servil-st / solo / LentMessages / 64 MiB | 0.131 | 0.132 | x1.007 | level | 1 of 4 | x1.007 | - | x1.007 | x1.000 | x1.025 |
| blake3-servil-st / solo / Interleaved / 256 | 0.109 | 0.109 | x1.002 | level | 3 of 4 | x1.002 | - | x1.002 | x1.001 | x1.000 |
| blake3-servil-st / solo / Collection / git objects | 0.0841 | 0.0849 | x1.010 | level | 1 of 4 | x1.010 | - | x1.010 | x0.999 | x1.030 |
| blake3-servil-st / solo / Collection / Nix files | 0.0736 | 0.0748 | x1.016 | level | 0 of 4 | x1.016 | - | x1.016 | x0.999 | x1.040 |
| blake3-servil-st / solo / LentBatches / 16 | 6.036 | 6.049 | x1.002 | level | 3 of 4 | x1.002 | - | x1.002 | x0.998 | x0.880 |
| blake3-servil-st / solo / LentBatches / 64 | 5.312 | 5.337 | x1.005 | level | 1 of 4 | x1.005 | - | x1.005 | x0.999 | x0.783 |
| blake3-servil-st / solo / LentBatches / 256 | 5.308 | 5.318 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.000 | x0.798 |
| blake3-servil-st / solo / LentBatches / 1024 | 5.617 | 5.607 | x0.998 | level | 3 of 4 | x0.998 | - | x0.999 | x1.000 | x2.168 |
| blake3-servil-st / solo / LentBatches / 4096 | 5.496 | 5.478 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x1.000 | x0.144 |
| blake3-servil-st / solo / LentBatches / 16384 | 6.137 | 6.128 | x0.999 | level | 2 of 4 | x0.999 | - | x0.998 | x1.000 | x1.015 |
| blake3-servil-st / solo / LentBatches / 65536 | 6.171 | 6.157 | x0.998 | level | 3 of 4 | x0.998 | - | x0.997 | x1.000 | x1.027 |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.110 | 0.110 | x1.003 | level | 2 of 4 | x1.003 | - | x1.003 | x1.000 | x1.037 |
| blake3-servil-st / solo / ContinuousCollection / Nix files | 0.117 | 0.117 | x1.004 | level | 1 of 4 | x1.004 | - | x1.004 | x1.000 | x1.048 |
| blake3-servil-st / solo / MerkleTree / 1024 | 0.0996 | 0.0994 | x0.998 | level | 3 of 4 | x0.998 | - | x0.999 | x1.001 | x0.088 |
| blake3-servil-st / solo / MerkleTree / 4096 | 0.107 | 0.107 | x0.996 | level | 3 of 4 | x0.996 | - | x0.996 | x1.001 | x0.684 |
| blake3-servil-st / solo / MerkleTree / 16384 | 0.107 | 0.107 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.001 | x0.795 |
| blake3-servil-st / solo / MerkleTree / 65536 | 0.120 | 0.119 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.001 | x0.920 |
| blake3-servil-st / solo / MerkleTree / 262144 | 0.160 | 0.160 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.001 | x0.999 |
| blake3-servil-st / solo / MerkleTree / 65536 x 32 B | 0.308 | 0.308 | x0.998 | level | 2 of 4 | x0.998 | - | x0.998 | x1.000 | x0.824 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 32 B | 0.389 | 0.389 | x0.999 | level | 2 of 4 | x0.999 | - | x1.000 | x1.000 | x0.996 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 16 B | 0.700 | 0.701 | x1.002 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x1.047 |
| blake3-servil-st / solo / MerkleTree / 65536 x 48 B | 0.215 | 0.215 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.181 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 48 B | 0.287 | 0.287 | x1.002 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x1.003 |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.242 | 0.241 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.007 | x0.936 |
| blake3-servil-st / solo / InterleavedTurn / 1024 x 1 KiB | 0.207 | 0.205 | x0.990 | level | 2 of 4 | - | - | x0.990 | x0.997 | x0.973 |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.275 | 0.266 | x0.968 | level | 2 of 4 | - | - | x0.989 | x0.955 | x0.957 |
| blake3-servil-st / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.228 | 0.227 | x0.994 | level | 2 of 4 | - | - | x1.005 | x0.997 | x0.980 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.201 | 0.194 | x0.967 | level | 4 of 4 | - | - | x0.970 | x0.988 | x0.981 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.170 | 0.164 | x0.963 | level | 3 of 4 | - | - | x0.963 | x0.997 | x1.002 |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.0836 | 0.0837 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.001 | x1.024 |
| blake3-servil-st / solo / ReceivingMessage / 2 μs | 0.0922 | 0.0922 | x1.000 | level | 1 of 4 | x1.000 | - | x1.001 | x1.001 | x0.995 |
| blake3-servil-st / solo / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 2 of 4 | x0.997 | - | x0.996 | x1.001 | x0.908 |
| blake3-servil-st / solo / IncrementalMessage / 64 B | 7.957 | 8.471 | x1.065 | level | 1 of 4 | - | - | x1.042 | x0.996 | x1.035 |
| blake3-servil-st / solo / IncrementalMessage / 1 KiB | 1.829 | 1.818 | x0.994 | level | 2 of 4 | - | - | x1.003 | x1.002 | x1.047 |
| blake3-servil-st / solo / IncrementalMessage / 4 KiB | 0.568 | 0.579 | x1.020 | level | 1 of 4 | - | - | x1.015 | x0.998 | x1.012 |
| blake3-servil-st / solo / LentIncrementalMessage / 64 B | 0.807 | 0.807 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.006 | x1.273 |
| blake3-servil-st / solo / LentIncrementalMessage / 1 KiB | 0.988 | 0.989 | x1.001 | level | 0 of 4 | x1.001 | - | x1.002 | x1.002 | x0.798 |
| blake3-servil-st / solo / LentIncrementalMessage / 4 KiB | 0.290 | 0.290 | x1.000 | level | 2 of 4 | x1.000 | - | x0.999 | x1.001 | x0.792 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 0.756 | 0.759 | x1.004 | level | 0 of 4 | x1.004 | - | x1.005 | x1.013 | x1.010 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 4 KiB | 0.284 | 0.284 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.001 | x0.894 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 1 MiB | 0.0676 | 0.0680 | x1.006 | level | 2 of 4 | x1.006 | - | x1.007 | x1.000 | x1.126 |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 0.722 | 0.725 | x1.004 | level | 0 of 4 | x1.004 | - | x1.005 | x1.015 | x1.341 |
| blake3-servil-st / solo / ContinuousLentMessages / 4 KiB | 0.281 | 0.281 | x1.000 | level | 2 of 4 | x1.001 | - | x1.000 | x1.001 | x1.193 |
| blake3-servil-st / solo / ContinuousLentMessages / 1 MiB | 0.0556 | 0.0560 | x1.008 | level | 2 of 4 | x1.008 | - | x1.008 | x1.000 | x1.323 |
| blake3-servil-mt / solo / OneMessage / 64 B | 7.517 | 6.964 | x0.926 | level | 2 of 4 | - | - | x0.935 | x0.988 | x0.962 |
| blake3-servil-mt / solo / OneMessage / 128 B | 4.507 | 4.345 | x0.964 | level | 3 of 4 | - | - | x0.959 | x0.992 | x0.972 |
| blake3-servil-mt / solo / OneMessage / 256 B | 2.901 | 2.757 | x0.951 | level | 2 of 4 | - | - | x0.969 | x1.006 | x0.973 |
| blake3-servil-mt / solo / OneMessage / 512 B | 1.936 | 1.933 | x0.998 | level | 1 of 4 | - | - | x0.990 | x1.003 | x1.006 |
| blake3-servil-mt / solo / OneMessage / 1 KiB | 1.589 | 1.529 | x0.962 | level | 4 of 4 | - | - | x0.975 | x1.001 | x0.986 |
| blake3-servil-mt / solo / OneMessage / 1536 B | 1.435 | 1.420 | x0.990 | level | 2 of 4 | - | - | x0.971 | x0.998 | x0.981 |
| blake3-servil-mt / solo / OneMessage / 2 KiB | 0.859 | 0.858 | x0.999 | level | 2 of 4 | - | - | x0.995 | x0.999 | x0.979 |
| blake3-servil-mt / solo / OneMessage / 2304 B | 1.044 | 1.064 | x1.018 | level | 1 of 4 | - | - | x1.009 | x1.001 | x1.000 |
| blake3-servil-mt / solo / OneMessage / 3 KiB | 0.750 | 0.738 | x0.984 | level | 3 of 4 | - | - | x0.983 | x0.999 | x0.998 |
| blake3-servil-mt / solo / OneMessage / 3839 B | 0.772 | 0.781 | x1.011 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.019 |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 0.465 | 0.470 | x1.012 | level | 2 of 4 | - | - | x1.005 | x0.997 | x1.007 |
| blake3-servil-mt / solo / OneMessage / 4470 B | 0.601 | 0.611 | x1.016 | level | 1 of 4 | - | - | x1.018 | x1.000 | x1.012 |
| blake3-servil-mt / solo / OneMessage / 7935 B | 0.595 | 0.597 | x1.003 | level | 2 of 4 | - | - | x1.002 | x1.001 | x0.962 |
| blake3-servil-mt / solo / OneMessage / 8 KiB | 0.387 | 0.379 | x0.979 | level | 3 of 4 | - | - | x0.973 | x1.001 | x0.995 |
| blake3-servil-mt / solo / OneMessage / 16 KiB | 0.226 | 0.230 | x1.019 | level | 1 of 4 | - | - | x1.012 | x1.000 | x0.985 |
| blake3-servil-mt / solo / OneMessage / 32 KiB | 0.196 | 0.200 | x1.017 | level | 2 of 4 | - | - | x1.006 | x1.000 | x0.978 |
| blake3-servil-mt / solo / OneMessage / 64 KiB | 0.145 | 0.147 | x1.014 | level | 2 of 4 | - | - | x1.016 | x1.000 | x0.951 |
| blake3-servil-mt / solo / OneMessage / 128 KiB | 0.116 | 0.118 | x1.021 | level | 2 of 4 | - | - | x1.018 | x1.000 | x0.924 |
| blake3-servil-mt / solo / OneMessage / 256 KiB | 0.102 | 0.104 | x1.017 | level | 1 of 4 | - | - | x1.016 | x1.000 | x0.885 |
| blake3-servil-mt / solo / OneMessage / 512 KiB | 0.0604 | 0.0607 | x1.005 | level | 1 of 4 | - | - | x1.006 | x0.949 | x0.995 |
| blake3-servil-mt / solo / OneMessage / 1 MiB | 0.0485 | 0.0483 | x0.996 | level | 2 of 4 | - | - | x0.995 | x0.982 | x0.996 |
| blake3-servil-mt / solo / OneMessage / 2 MiB | 0.0433 | 0.0435 | x1.003 | level | 2 of 4 | - | - | x1.005 | x0.994 | x1.008 |
| blake3-servil-mt / solo / OneMessage / 3 MiB | 0.0414 | 0.0411 | x0.994 | level | 2 of 4 | - | - | x0.993 | x0.984 | x0.998 |
| blake3-servil-mt / solo / OneMessage / 4 MiB | 0.0391 | 0.0392 | x1.002 | level | 2 of 4 | - | - | x1.002 | x0.987 | x1.012 |
| blake3-servil-mt / solo / OneMessage / 8 MiB | 0.0379 | 0.0381 | x1.007 | level | 2 of 4 | - | - | x1.007 | x0.999 | x1.002 |
| blake3-servil-mt / solo / OneMessage / 32 MiB | 0.0752 | 0.0754 | x1.004 | level | 2 of 4 | - | - | x1.003 | x0.997 | x0.999 |
| blake3-servil-mt / solo / OneMessage / 64 MiB | 0.0750 | 0.0752 | x1.002 | level | 2 of 4 | - | - | x1.002 | x0.995 | x0.999 |
| blake3-servil-mt / solo / OneMessage / 128 MiB | 0.0745 | 0.0748 | x1.004 | level | 1 of 4 | - | - | x1.004 | x0.998 | x1.000 |
| blake3-servil-mt / solo / ManyMessages / 1 | 658.477 | 742.906 | x1.128 | level | 1 of 4 | - | - | x1.127 | x1.003 | x1.106 |
| blake3-servil-mt / solo / ManyMessages / 2 | 306.466 | 293.831 | x0.959 | level | 2 of 4 | - | - | x0.946 | x0.994 | x0.952 |
| blake3-servil-mt / solo / ManyMessages / 3 | 234.303 | 227.172 | x0.970 | level | 1 of 4 | - | - | x0.941 | x0.996 | x0.948 |
| blake3-servil-mt / solo / ManyMessages / 4 | 149.910 | 152.514 | x1.017 | level | 3 of 4 | - | - | x1.007 | x0.996 | x0.954 |
| blake3-servil-mt / solo / ManyMessages / 6 | 114.594 | 110.980 | x0.968 | level | 1 of 4 | - | - | x0.954 | x0.995 | x0.928 |
| blake3-servil-mt / solo / ManyMessages / 8 | 107.359 | 105.449 | x0.982 | level | 2 of 4 | - | - | x0.956 | x0.998 | x0.970 |
| blake3-servil-mt / solo / ManyMessages / 12 | 83.611 | 81.564 | x0.976 | level | 3 of 4 | - | - | x0.971 | x0.994 | x0.981 |
| blake3-servil-mt / solo / ManyMessages / 16 | 59.332 | 58.712 | x0.990 | level | 1 of 4 | - | - | x0.974 | x0.990 | x0.975 |
| blake3-servil-mt / solo / ManyMessages / 24 | 51.947 | 52.301 | x1.007 | level | 1 of 4 | - | - | x1.005 | x0.999 | x0.972 |
| blake3-servil-mt / solo / ManyMessages / 32 | 33.044 | 33.266 | x1.007 | level | 1 of 4 | - | - | x0.987 | x0.994 | x0.965 |
| blake3-servil-mt / solo / ManyMessages / 48 | 23.676 | 23.742 | x1.003 | level | 1 of 4 | - | - | x0.992 | x0.994 | x0.973 |
| blake3-servil-mt / solo / ManyMessages / 64 | 19.765 | 19.365 | x0.980 | level | 3 of 4 | - | - | x0.966 | x0.995 | x0.985 |
| blake3-servil-mt / solo / ManyMessages / 128 | 14.016 | 13.550 | x0.967 | level | 3 of 4 | - | - | x0.970 | x1.001 | x0.981 |
| blake3-servil-mt / solo / ManyMessages / 256 | 10.718 | 10.807 | x1.008 | level | 1 of 4 | - | - | x1.002 | x0.999 | x0.945 |
| blake3-servil-mt / solo / ManyMessages / 512 | 9.095 | 9.172 | x1.008 | level | 1 of 4 | - | - | x1.004 | x1.000 | x0.921 |
| blake3-servil-mt / solo / ManyMessages / 1024 | 8.114 | 8.216 | x1.013 | level | 0 of 4 | - | - | x1.011 | x1.000 | x0.929 |
| blake3-servil-mt / solo / ManyMessages / 2048 | 7.608 | 7.807 | x1.026 | level | 0 of 4 | - | - | x1.024 | x1.000 | x0.958 |
| blake3-servil-mt / solo / ManyMessages / 4096 | 7.455 | 7.655 | x1.027 | level | 2 of 4 | - | - | x1.026 | x1.000 | x0.997 |
| blake3-servil-mt / solo / ManyMessages / 8192 | 3.303 | 3.341 | x1.012 | level | 1 of 4 | - | - | x1.002 | x0.998 | x1.000 |
| blake3-servil-mt / solo / ManyMessages / 16384 | 2.784 | 2.785 | x1.000 | level | 2 of 4 | - | - | x1.003 | x1.005 | x0.999 |
| blake3-servil-mt / solo / ManyMessages / 32768 | 2.630 | 2.646 | x1.006 | level | 2 of 4 | - | - | x1.005 | x0.994 | x1.005 |
| blake3-servil-mt / solo / ManyMessages / 65536 | 2.417 | 2.427 | x1.004 | level | 2 of 4 | - | - | x1.003 | x0.996 | x1.013 |
| blake3-servil-mt / solo / ManyMessages / 131072 | 2.427 | 2.442 | x1.006 | level | 1 of 4 | - | - | x1.007 | x1.008 | x1.009 |
| blake3-servil-mt / solo / ManyMessages / 262144 | 2.906 | 2.904 | x0.999 | level | 2 of 4 | - | - | x0.998 | x0.989 | x0.995 |
| blake3-servil-mt / solo / ManyLongMessages / 4 | 1719.329 | 1754.536 | x1.020 | level | 1 of 4 | - | - | x1.014 | x1.001 | x0.968 |
| blake3-servil-mt / solo / ManyLongMessages / 16 | 1378.319 | 636.717 | x0.462 | faster | 4 of 4 | - | - | x0.467 | x0.575 | x1.270 |
| blake3-servil-mt / solo / ManyLongMessages / 64 | 501.700 | 492.731 | x0.982 | level | 4 of 4 | - | - | x0.980 | x0.998 | x0.899 |
| blake3-servil-mt / solo / ManyLongMessages / 256 | 240.387 | 238.291 | x0.991 | level | 2 of 4 | - | - | x0.987 | x0.991 | x1.001 |
| blake3-servil-mt / solo / IdleOneMessage / 64 B | 3.504 | 3.518 | x1.004 | level | 1 of 4 | - | - | x1.014 | x1.007 | x1.053 |
| blake3-servil-mt / solo / IdleOneMessage / 128 B | 2.462 | 2.478 | x1.006 | level | 1 of 4 | - | - | x1.001 | x1.006 | x0.597 |
| blake3-servil-mt / solo / IdleOneMessage / 256 B | 1.939 | 1.961 | x1.011 | level | 2 of 4 | - | - | x1.002 | x1.004 | x0.800 |
| blake3-servil-mt / solo / IdleOneMessage / 512 B | 1.669 | 1.691 | x1.013 | level | 1 of 4 | - | - | x1.001 | x1.002 | x0.484 |
| blake3-servil-mt / solo / IdleOneMessage / 1 KiB | 1.539 | 1.523 | x0.989 | level | 3 of 4 | - | - | x1.002 | x1.001 | x1.039 |
| blake3-servil-mt / solo / IdleOneMessage / 1536 B | 1.151 | 1.127 | x0.979 | level | 3 of 4 | - | - | x0.997 | x0.998 | x1.100 |
| blake3-servil-mt / solo / IdleOneMessage / 2 KiB | 0.826 | 0.820 | x0.993 | level | 3 of 4 | - | - | x1.000 | x1.001 | x1.158 |
| blake3-servil-mt / solo / IdleOneMessage / 2304 B | 0.917 | 0.915 | x0.997 | level | 3 of 4 | - | - | x0.996 | x1.001 | x0.926 |
| blake3-servil-mt / solo / IdleOneMessage / 3 KiB | 0.598 | 0.590 | x0.987 | level | 3 of 4 | - | - | x0.999 | x1.001 | x0.945 |
| blake3-servil-mt / solo / IdleOneMessage / 3839 B | 0.487 | 0.484 | x0.994 | level | 3 of 4 | - | - | x0.999 | x1.001 | x0.346 |
| blake3-servil-mt / solo / IdleOneMessage / 4 KiB | 0.444 | 0.447 | x1.006 | level | 1 of 4 | - | - | x0.999 | x1.001 | x0.746 |
| blake3-servil-mt / solo / IdleOneMessage / 4470 B | 0.534 | 0.566 | x1.058 | level | 0 of 4 | - | - | x0.997 | x1.001 | x0.922 |
| blake3-servil-mt / solo / IdleOneMessage / 7935 B | 0.282 | 0.277 | x0.985 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.709 |
| blake3-servil-mt / solo / IdleOneMessage / 8 KiB | 0.256 | 0.261 | x1.022 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.014 |
| blake3-servil-mt / solo / IdleOneMessage / 16 KiB | 0.144 | 0.143 | x0.997 | level | 2 of 4 | - | - | x1.001 | x1.001 | x2.076 |
| blake3-servil-mt / solo / IdleOneMessage / 32 KiB | 0.100 | 0.101 | x1.008 | level | 2 of 4 | - | - | x1.005 | x1.000 | x1.589 |
| blake3-servil-mt / solo / IdleOneMessage / 64 KiB | 0.0906 | 0.0905 | x0.998 | level | 2 of 4 | - | - | x1.005 | x1.000 | x0.535 |
| blake3-servil-mt / solo / IdleOneMessage / 128 KiB | 0.0876 | 0.0878 | x1.003 | level | 2 of 4 | - | - | x1.005 | x1.000 | x0.557 |
| blake3-servil-mt / solo / IdleOneMessage / 256 KiB | 0.0888 | 0.0873 | x0.984 | level | 2 of 4 | - | - | x1.013 | x1.000 | x1.752 |
| blake3-servil-mt / solo / IdleOneMessage / 512 KiB | 0.0583 | 0.0599 | x1.026 | level | 1 of 4 | - | - | x1.023 | x0.990 | x1.007 |
| blake3-servil-mt / solo / IdleOneMessage / 1 MiB | 0.0508 | 0.0517 | x1.017 | level | 1 of 4 | - | - | x1.011 | x0.986 | x0.998 |
| blake3-servil-mt / solo / IdleOneMessage / 2 MiB | 0.0464 | 0.0468 | x1.009 | level | 1 of 4 | - | - | x1.002 | x0.980 | x0.994 |
| blake3-servil-mt / solo / IdleOneMessage / 3 MiB | 0.0442 | 0.0443 | x1.001 | level | 2 of 4 | - | - | x0.995 | x0.985 | x0.977 |
| blake3-servil-mt / solo / IdleOneMessage / 4 MiB | 0.0421 | 0.0418 | x0.994 | level | 3 of 4 | - | - | x1.013 | x1.005 | x0.988 |
| blake3-servil-mt / solo / IdleOneMessage / 8 MiB | 0.0389 | 0.0388 | x0.997 | level | 3 of 4 | - | - | x1.014 | x1.006 | x0.969 |
| blake3-servil-mt / solo / IdleOneMessage / 32 MiB | 0.0696 | 0.0701 | x1.007 | level | 1 of 4 | - | - | x1.020 | x0.993 | x0.997 |
| blake3-servil-mt / solo / IdleOneMessage / 64 MiB | 0.0739 | 0.0742 | x1.003 | level | 1 of 4 | - | - | x1.006 | x0.997 | x0.998 |
| blake3-servil-mt / solo / IdleOneMessage / 128 MiB | 0.0742 | 0.0744 | x1.003 | level | 2 of 4 | - | - | x1.007 | x0.998 | x0.999 |
| blake3-servil-mt / solo / IdleManyMessages / 1 | 235.982 | 240.170 | x1.018 | level | 0 of 4 | - | - | x1.008 | x1.010 | x1.079 |
| blake3-servil-mt / solo / IdleManyMessages / 2 | 120.785 | 121.756 | x1.008 | level | 1 of 4 | - | - | x0.999 | x0.999 | x1.097 |
| blake3-servil-mt / solo / IdleManyMessages / 3 | 105.231 | 104.447 | x0.993 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.680 |
| blake3-servil-mt / solo / IdleManyMessages / 4 | 61.537 | 62.143 | x1.010 | level | 3 of 4 | - | - | x1.012 | x1.000 | x1.845 |
| blake3-servil-mt / solo / IdleManyMessages / 6 | 53.125 | 53.511 | x1.007 | level | 2 of 4 | - | - | x0.995 | x0.999 | x0.814 |
| blake3-servil-mt / solo / IdleManyMessages / 8 | 32.837 | 32.833 | x1.000 | level | 3 of 4 | - | - | x0.998 | x0.999 | x0.569 |
| blake3-servil-mt / solo / IdleManyMessages / 12 | 29.743 | 29.496 | x0.992 | level | 3 of 4 | - | - | x1.004 | x1.000 | x0.973 |
| blake3-servil-mt / solo / IdleManyMessages / 16 | 17.283 | 17.346 | x1.004 | level | 1 of 4 | - | - | x1.007 | x1.000 | x1.349 |
| blake3-servil-mt / solo / IdleManyMessages / 24 | 16.173 | 16.294 | x1.008 | level | 1 of 4 | - | - | x1.002 | x0.999 | x0.635 |
| blake3-servil-mt / solo / IdleManyMessages / 32 | 12.296 | 12.351 | x1.004 | level | 1 of 4 | - | - | x1.008 | x1.000 | x1.612 |
| blake3-servil-mt / solo / IdleManyMessages / 48 | 10.719 | 10.929 | x1.020 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.388 |
| blake3-servil-mt / solo / IdleManyMessages / 64 | 10.035 | 9.734 | x0.970 | level | 3 of 4 | - | - | x1.003 | x1.000 | x1.531 |
| blake3-servil-mt / solo / IdleManyMessages / 128 | 8.709 | 8.611 | x0.989 | level | 3 of 4 | - | - | x1.001 | x1.000 | x0.520 |
| blake3-servil-mt / solo / IdleManyMessages / 256 | 8.091 | 7.975 | x0.986 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.946 |
| blake3-servil-mt / solo / IdleManyMessages / 512 | 7.701 | 7.726 | x1.003 | level | 3 of 4 | - | - | x1.005 | x1.000 | x1.348 |
| blake3-servil-mt / solo / IdleManyMessages / 1024 | 7.578 | 7.598 | x1.003 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.048 |
| blake3-servil-mt / solo / IdleManyMessages / 2048 | 7.675 | 7.639 | x0.995 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.978 |
| blake3-servil-mt / solo / IdleManyMessages / 4096 | 7.760 | 7.808 | x1.006 | level | 2 of 4 | - | - | x1.012 | x1.000 | x1.146 |
| blake3-servil-mt / solo / IdleManyMessages / 8192 | 3.410 | 3.390 | x0.994 | level | 1 of 4 | - | - | x1.028 | x1.006 | x1.010 |
| blake3-servil-mt / solo / IdleManyMessages / 16384 | 3.031 | 3.043 | x1.004 | level | 2 of 4 | - | - | x1.011 | x0.998 | x1.017 |
| blake3-servil-mt / solo / IdleManyMessages / 32768 | 3.019 | 3.018 | x1.000 | level | 3 of 4 | - | - | x1.010 | x0.972 | x1.022 |
| blake3-servil-mt / solo / IdleManyMessages / 65536 | 2.597 | 2.582 | x0.995 | level | 2 of 4 | - | - | x1.010 | x1.004 | x1.016 |
| blake3-servil-mt / solo / IdleManyMessages / 131072 | 2.484 | 2.470 | x0.994 | level | 2 of 4 | - | - | x0.994 | x0.997 | x1.012 |
| blake3-servil-mt / solo / IdleManyMessages / 262144 | 3.334 | 3.382 | x1.014 | level | 2 of 4 | - | - | x1.031 | x0.996 | x0.978 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 B | 2.421 | 2.440 | x1.008 | level | 1 of 4 | - | - | x1.008 | x1.006 | x1.227 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 B | 1.700 | 1.712 | x1.007 | level | 0 of 4 | - | - | x1.006 | x1.005 | x1.031 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 B | 1.362 | 1.363 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.004 | x1.204 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 B | 1.167 | 1.169 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.002 | x0.542 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 KiB | 1.080 | 1.081 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.001 | x0.644 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1536 B | 0.811 | 0.808 | x0.997 | level | 3 of 4 | - | - | x0.998 | x0.998 | x1.418 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 KiB | 0.586 | 0.585 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.001 | x1.201 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2304 B | 0.655 | 0.650 | x0.993 | level | 4 of 4 | - | - | x0.994 | x1.001 | x0.534 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 KiB | 0.420 | 0.419 | x0.997 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.559 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3839 B | 0.341 | 0.342 | x1.001 | level | 2 of 4 | - | - | x1.002 | x1.001 | x0.663 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 KiB | 0.312 | 0.312 | x0.998 | level | 2 of 4 | - | - | x0.999 | x1.001 | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4470 B | 0.384 | 0.383 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.001 | x0.852 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 7935 B | 0.194 | 0.193 | x0.995 | level | 4 of 4 | - | - | x0.995 | x1.001 | x1.433 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 KiB | 0.179 | 0.179 | x0.998 | level | 2 of 4 | - | - | x0.999 | x1.001 | x2.052 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 16 KiB | 0.101 | 0.100 | x0.996 | level | 2 of 4 | - | - | x0.996 | x1.001 | x0.704 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 KiB | 0.0706 | 0.0708 | x1.003 | level | 2 of 4 | - | - | x1.004 | x1.000 | x0.856 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 KiB | 0.0654 | 0.0658 | x1.006 | level | 1 of 4 | - | - | x1.006 | x1.000 | x0.334 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 KiB | 0.0630 | 0.0634 | x1.007 | level | 2 of 4 | - | - | x1.004 | x1.000 | x0.292 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 KiB | 0.0625 | 0.0625 | x1.000 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.052 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 KiB | 0.0480 | 0.0483 | x1.004 | level | 2 of 4 | - | - | x1.002 | x0.989 | x0.994 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 MiB | 0.0436 | 0.0435 | x0.998 | level | 2 of 4 | - | - | x0.999 | x0.979 | x0.999 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 MiB | 0.0363 | 0.0365 | x1.006 | level | 1 of 4 | - | - | x1.007 | x0.997 | x0.989 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 MiB | 0.0329 | 0.0324 | x0.986 | level | 4 of 4 | - | - | x0.986 | x1.003 | x0.995 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 MiB | 0.0311 | 0.0311 | x1.000 | level | 2 of 4 | - | - | x0.996 | x0.993 | x0.987 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 MiB | 0.0294 | 0.0293 | x0.997 | level | 3 of 4 | - | - | x0.995 | x0.990 | x0.976 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 MiB | 0.0700 | 0.0704 | x1.005 | level | 2 of 4 | - | - | x1.005 | x0.999 | x0.999 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 MiB | 0.0746 | 0.0748 | x1.003 | level | 2 of 4 | - | - | x1.005 | x0.999 | x1.000 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 MiB | 0.0745 | 0.0747 | x1.003 | level | 1 of 4 | - | - | x1.003 | x0.997 | x1.000 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1 | 166.552 | 166.881 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.011 | x1.038 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2 | 83.627 | 84.004 | x1.005 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.483 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 3 | 72.469 | 72.688 | x1.003 | level | 3 of 4 | - | - | x1.005 | x1.000 | x0.805 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4 | 42.299 | 43.121 | x1.019 | level | 1 of 4 | - | - | x1.013 | x1.000 | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 6 | 36.818 | 36.942 | x1.003 | level | 1 of 4 | - | - | x1.004 | x0.999 | x1.643 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8 | 23.289 | 22.667 | x0.973 | level | 2 of 4 | - | - | x0.985 | x0.999 | x1.554 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 12 | 20.908 | 20.612 | x0.986 | level | 1 of 4 | - | - | x0.990 | x1.000 | x0.922 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16 | 12.070 | 12.122 | x1.004 | level | 2 of 4 | - | - | x1.004 | x1.000 | x0.903 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 24 | 11.311 | 11.154 | x0.986 | level | 2 of 4 | - | - | x0.993 | x0.999 | x0.758 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32 | 8.511 | 8.568 | x1.007 | level | 1 of 4 | - | - | x1.005 | x1.000 | x1.083 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 48 | 7.406 | 7.405 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.550 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 64 | 6.798 | 6.818 | x1.003 | level | 2 of 4 | - | - | x1.004 | x1.000 | x0.673 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 128 | 5.971 | 5.990 | x1.003 | level | 1 of 4 | - | - | x1.003 | x1.000 | x0.834 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 256 | 5.654 | 5.663 | x1.001 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.965 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 512 | 5.438 | 5.449 | x1.002 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.579 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1024 | 5.426 | 5.366 | x0.989 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.454 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2048 | 5.324 | 5.336 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.180 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4096 | 5.405 | 5.418 | x1.002 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.063 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8192 | 2.805 | 2.827 | x1.008 | level | 2 of 4 | - | - | x1.009 | x1.002 | x1.012 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16384 | 2.450 | 2.435 | x0.994 | level | 2 of 4 | - | - | x0.996 | x0.998 | x1.009 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32768 | 2.248 | 2.267 | x1.008 | level | 2 of 4 | - | - | x1.010 | x1.002 | x1.017 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 65536 | 1.879 | 1.875 | x0.998 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.011 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 131072 | 1.797 | 1.814 | x1.009 | level | 1 of 4 | - | - | x1.010 | x1.016 | x1.004 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 262144 | 2.324 | 2.323 | x1.000 | level | 2 of 4 | - | - | x0.998 | x1.004 | x0.975 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.367 | 0.357 | x0.975 | level | 4 of 4 | x0.985 | - | x0.976 | x0.974 | x1.006 |
| blake3-servil-mt / solo / ContinuousMessages / 128 B | 0.189 | 0.179 | x0.946 | level | 4 of 4 | x0.961 | - | x0.946 | x0.974 | x1.158 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.0965 | 0.0940 | x0.975 | level | 4 of 4 | x0.979 | - | x0.977 | x0.975 | x0.966 |
| blake3-servil-mt / solo / ContinuousMessages / 512 B | 0.0512 | 0.0498 | x0.973 | level | 4 of 4 | x0.980 | - | x0.971 | x0.976 | x1.017 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.0399 | 0.0400 | x1.002 | level | 2 of 4 | x1.024 | - | x0.997 | x0.982 | x1.004 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0363 | 0.0351 | x0.967 | level | 3 of 4 | x1.011 | - | x0.970 | x0.980 | x0.964 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0306 | 0.0299 | x0.977 | level | 3 of 4 | x0.983 | - | x0.980 | x0.983 | x1.011 |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.0270 | 0.0276 | x1.024 | level | 2 of 4 | x1.034 | - | x1.029 | x1.009 | x1.007 |
| blake3-servil-mt / solo / ContinuousMessages / 256 KiB | 0.0267 | 0.0259 | x0.969 | level | 3 of 4 | x0.962 | - | x0.966 | x1.005 | x0.989 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0245 | 0.0243 | x0.992 | level | 4 of 4 | x0.976 | - | x0.994 | x1.004 | x1.004 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.0250 | 0.0250 | x0.998 | level | 2 of 4 | x0.993 | - | x0.997 | x1.003 | x1.005 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0255 | 0.0254 | x0.998 | level | 3 of 4 | x1.033 | - | x0.997 | x1.003 | x0.997 |
| blake3-servil-mt / solo / ContinuousMessages / 64 MiB | 0.0312 | 0.0313 | x1.002 | level | 3 of 4 | x1.016 | - | x0.999 | x1.003 | x0.996 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 2.899 | 2.864 | x0.988 | level | 4 of 4 | x1.037 | - | x0.989 | x0.971 | x1.007 |
| blake3-servil-mt / solo / ContinuousBatches / 64 | 1.885 | 1.859 | x0.986 | level | 4 of 4 | x1.046 | - | x0.984 | x0.982 | x1.006 |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 2.174 | 2.120 | x0.975 | level | 3 of 4 | x0.989 | - | x0.975 | x0.988 | x0.980 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 1.865 | 1.863 | x0.999 | level | 1 of 4 | x1.014 | - | x1.000 | x1.004 | x1.018 |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 2.069 | 2.045 | x0.988 | level | 2 of 4 | x0.963 | - | x0.990 | x1.001 | x0.994 |
| blake3-servil-mt / solo / ContinuousBatches / 16384 | 2.073 | 2.133 | x1.029 | level | 1 of 4 | x1.023 | - | x1.002 | x1.001 | x1.050 |
| blake3-servil-mt / solo / ContinuousBatches / 65536 | 1.743 | 1.758 | x1.008 | level | 2 of 4 | x1.014 | - | x0.991 | x1.000 | x1.019 |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.746 | 0.748 | x1.002 | level | 0 of 4 | x1.002 | - | x1.003 | x1.012 | x4.921 |
| blake3-servil-mt / solo / LentMessages / 128 B | 0.856 | 0.857 | x1.002 | level | 0 of 4 | x1.002 | - | x1.002 | x1.007 | x2.040 |
| blake3-servil-mt / solo / LentMessages / 256 B | 0.914 | 0.916 | x1.002 | level | 0 of 4 | x1.002 | - | x1.002 | x1.004 | x2.641 |
| blake3-servil-mt / solo / LentMessages / 512 B | 0.945 | 0.944 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.002 | x0.346 |
| blake3-servil-mt / solo / LentMessages / 1 KiB | 0.962 | 0.962 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.001 | x1.613 |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.285 | 0.285 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.839 |
| blake3-servil-mt / solo / LentMessages / 16 KiB | 0.0910 | 0.0910 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x1.122 |
| blake3-servil-mt / solo / LentMessages / 64 KiB | 0.0651 | 0.0653 | x1.002 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x0.913 |
| blake3-servil-mt / solo / LentMessages / 256 KiB | 0.0615 | 0.0617 | x1.003 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x2.450 |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.0369 | 0.0381 | x1.033 | level | 1 of 4 | x1.015 | - | x1.008 | x1.009 | x1.015 |
| blake3-servil-mt / solo / LentMessages / 4 MiB | 0.0320 | 0.0321 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.003 | x1.004 |
| blake3-servil-mt / solo / LentMessages / 16 MiB | 0.0293 | 0.0298 | x1.015 | level | 0 of 4 | x1.015 | - | x1.019 | x1.004 | x0.996 |
| blake3-servil-mt / solo / LentMessages / 64 MiB | 0.0748 | 0.0741 | x0.990 | level | 3 of 4 | x1.000 | - | x0.990 | x0.996 | x0.997 |
| blake3-servil-mt / solo / Interleaved / 256 | 0.109 | 0.108 | x0.997 | level | 2 of 4 | x0.997 | - | x0.997 | x0.999 | x0.989 |
| blake3-servil-mt / solo / Collection / git objects | 0.0176 | 0.0174 | x0.988 | level | 3 of 4 | x0.997 | - | x1.003 | x1.001 | x1.001 |
| blake3-servil-mt / solo / Collection / Nix files | 0.0169 | 0.0172 | x1.020 | level | 1 of 4 | x1.018 | - | x1.004 | x0.990 | x0.984 |
| blake3-servil-mt / solo / LentBatches / 16 | 6.053 | 6.067 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x0.998 | x0.779 |
| blake3-servil-mt / solo / LentBatches / 64 | 5.310 | 5.356 | x1.009 | level | 1 of 4 | x1.009 | - | x1.009 | x0.999 | x0.630 |
| blake3-servil-mt / solo / LentBatches / 256 | 5.296 | 5.343 | x1.009 | level | 1 of 4 | x1.009 | - | x1.008 | x1.000 | x2.403 |
| blake3-servil-mt / solo / LentBatches / 1024 | 5.613 | 5.624 | x1.002 | level | 3 of 4 | x1.002 | - | x1.002 | x1.000 | x0.940 |
| blake3-servil-mt / solo / LentBatches / 4096 | 5.495 | 5.512 | x1.003 | level | 3 of 4 | x1.003 | - | x1.003 | x1.000 | x0.296 |
| blake3-servil-mt / solo / LentBatches / 16384 | 2.732 | 2.621 | x0.960 | level | 4 of 4 | x0.966 | - | x1.014 | x0.999 | x1.014 |
| blake3-servil-mt / solo / LentBatches / 65536 | 2.315 | 2.265 | x0.978 | level | 3 of 4 | x0.976 | - | x1.007 | x1.001 | x1.013 |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.0348 | 0.0349 | x1.003 | level | 2 of 4 | x0.986 | - | x1.006 | x0.993 | x1.002 |
| blake3-servil-mt / solo / ContinuousCollection / Nix files | 0.0331 | 0.0333 | x1.008 | level | 2 of 4 | x1.025 | - | x0.997 | x0.995 | x1.003 |
| blake3-servil-mt / solo / MerkleTree / 1024 | 0.0996 | 0.0995 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.001 | x0.073 |
| blake3-servil-mt / solo / MerkleTree / 4096 | 0.0560 | 0.0559 | x0.997 | level | 3 of 4 | x0.995 | - | x1.004 | x1.000 | x1.006 |
| blake3-servil-mt / solo / MerkleTree / 16384 | 0.0472 | 0.0468 | x0.991 | level | 3 of 4 | x0.990 | - | x0.987 | x0.997 | x1.016 |
| blake3-servil-mt / solo / MerkleTree / 65536 | 0.0412 | 0.0408 | x0.990 | level | 4 of 4 | x0.986 | - | x0.994 | x0.997 | x0.980 |
| blake3-servil-mt / solo / MerkleTree / 262144 | 0.0905 | 0.0906 | x1.001 | level | 1 of 4 | x0.999 | - | x1.002 | x0.995 | x1.006 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 32 B | 0.0781 | 0.0833 | x1.066 | level | 0 of 4 | x1.053 | - | x1.003 | x0.996 | x1.051 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 32 B | 0.180 | 0.179 | x0.994 | level | 2 of 4 | x1.012 | - | x0.992 | x1.003 | x1.007 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 16 B | 0.271 | 0.271 | x1.001 | level | 2 of 4 | x1.004 | - | x1.004 | x1.007 | x1.041 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 48 B | 0.0593 | 0.0579 | x0.976 | level | 4 of 4 | x0.982 | - | x0.999 | x0.995 | x1.028 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 48 B | 0.149 | 0.149 | x0.995 | level | 3 of 4 | x1.015 | - | x0.995 | x0.996 | x1.006 |
| blake3-servil-mt / solo / InterleavedTurn / 256 | 0.281 | 0.279 | x0.996 | level | 3 of 4 | - | - | x0.981 | x0.995 | x0.966 |
| blake3-servil-mt / solo / InterleavedTurn / 1024 x 1 KiB | 0.143 | 0.141 | x0.985 | level | 2 of 4 | - | - | x0.981 | x0.993 | x0.971 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 256 | 0.243 | 0.247 | x1.016 | level | 2 of 4 | - | - | x1.021 | x0.933 | x0.997 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.183 | 0.188 | x1.023 | level | 2 of 4 | - | - | x1.031 | x0.994 | x0.961 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 256 | 0.202 | 0.205 | x1.014 | level | 3 of 4 | - | - | x0.991 | x0.983 | x1.000 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.138 | 0.134 | x0.970 | level | 3 of 4 | - | - | x0.966 | x0.993 | x0.950 |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.0273 | 0.0276 | x1.009 | level | 1 of 4 | x0.976 | - | x1.014 | x1.001 | x0.989 |
| blake3-servil-mt / solo / ReceivingMessage / 2 μs | 0.0922 | 0.0922 | x1.001 | level | 1 of 4 | x1.029 | - | x0.996 | x1.001 | x1.016 |
| blake3-servil-mt / solo / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 2 of 4 | x1.011 | - | x1.059 | x1.003 | x1.040 |
| blake3-servil-mt / solo / IncrementalMessage / 64 B | 9.150 | 9.317 | x1.018 | level | 1 of 4 | - | - | x1.017 | x0.995 | x1.045 |
| blake3-servil-mt / solo / IncrementalMessage / 1 KiB | 1.803 | 1.822 | x1.010 | level | 2 of 4 | - | - | x1.005 | x1.000 | x1.017 |
| blake3-servil-mt / solo / IncrementalMessage / 4 KiB | 0.573 | 0.572 | x0.998 | level | 2 of 4 | - | - | x0.989 | x1.000 | x1.007 |
| blake3-servil-mt / solo / LentIncrementalMessage / 64 B | 0.779 | 0.778 | x0.999 | level | 4 of 4 | x0.999 | - | x0.999 | x1.006 | x1.348 |
| blake3-servil-mt / solo / LentIncrementalMessage / 1 KiB | 0.988 | 0.990 | x1.002 | level | 0 of 4 | x1.002 | - | x1.002 | x1.002 | x1.015 |
| blake3-servil-mt / solo / LentIncrementalMessage / 4 KiB | 0.290 | 0.290 | x1.000 | level | 2 of 4 | x0.999 | - | x0.999 | x1.001 | x1.099 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 4.223 | 4.248 | x1.006 | level | 1 of 4 | x1.003 | - | x1.006 | x0.945 | x1.079 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 4 KiB | 0.0645 | 0.0624 | x0.968 | level | 4 of 4 | x0.951 | - | x0.979 | x0.958 | x1.010 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 1 MiB | 0.0243 | 0.0243 | x1.001 | level | 3 of 4 | x1.041 | - | x0.997 | x1.004 | x1.008 |
| blake3-servil-mt / solo / ContinuousLentMessages / 64 B | 0.287 | 0.290 | x1.010 | level | 2 of 4 | x1.111 | - | x1.012 | x0.969 | x0.960 |
| blake3-servil-mt / solo / ContinuousLentMessages / 4 KiB | 0.0210 | 0.0211 | x1.004 | level | 1 of 4 | x0.999 | - | x1.005 | x0.986 | x0.983 |
| blake3-servil-mt / solo / ContinuousLentMessages / 1 MiB | 0.00791 | 0.00791 | x1.000 | level | 2 of 4 | x1.023 | - | x1.008 | x0.997 | x0.920 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.349 | 0.332 | x0.951 | level | 3 of 4 | - | - | x0.952 | x0.974 | x1.081 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 128 B | 0.178 | 0.171 | x0.960 | level | 4 of 4 | - | - | x0.962 | x0.974 | x0.988 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.0962 | 0.0949 | x0.987 | level | 3 of 4 | - | - | x0.985 | x0.975 | x0.956 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 512 B | 0.0602 | 0.0585 | x0.972 | level | 3 of 4 | - | - | x0.977 | x0.976 | x0.992 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.0482 | 0.0477 | x0.989 | level | 1 of 4 | - | - | x0.987 | x0.982 | x0.971 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.0664 | 0.0531 | x0.800 | level | 4 of 4 | - | - | x0.966 | x0.958 | x0.951 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.0380 | 0.0378 | x0.997 | level | 1 of 4 | - | - | x1.005 | x0.982 | x0.988 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.0332 | 0.0330 | x0.994 | level | 2 of 4 | - | - | x0.988 | x1.009 | x0.999 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 KiB | 0.0323 | 0.0318 | x0.985 | level | 3 of 4 | - | - | x0.980 | x1.005 | x1.012 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0329 | 0.0325 | x0.987 | level | 4 of 4 | - | - | x0.989 | x1.004 | x0.993 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.0332 | 0.0340 | x1.023 | level | 1 of 4 | - | - | x1.025 | x1.003 | x1.001 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.0399 | 0.0404 | x1.014 | level | 1 of 4 | - | - | x1.014 | x1.003 | x0.985 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 MiB | 0.0459 | 0.0464 | x1.012 | level | 2 of 4 | - | - | x1.010 | x1.004 | x0.986 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 3.486 | 3.415 | x0.980 | level | 3 of 4 | - | - | x0.966 | x0.971 | x1.035 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 64 | 2.500 | 2.454 | x0.981 | level | 2 of 4 | - | - | x0.982 | x0.981 | x1.021 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 256 | 2.594 | 2.508 | x0.967 | level | 4 of 4 | - | - | x0.961 | x0.988 | x1.056 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 2.358 | 2.329 | x0.987 | level | 4 of 4 | - | - | x0.987 | x1.004 | x0.998 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 4096 | 2.837 | 2.716 | x0.957 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.000 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16384 | 2.423 | 2.397 | x0.989 | level | 3 of 4 | - | - | x1.041 | x1.004 | x1.074 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 65536 | 2.182 | 2.200 | x1.009 | level | 2 of 4 | - | - | x1.020 | x0.986 | x0.997 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.746 | 0.748 | x1.003 | level | 0 of 4 | - | - | x1.003 | x1.012 | x0.960 |
| blake3-servil-mt / shared-one-cache / LentMessages / 128 B | 0.856 | 0.857 | x1.001 | level | 0 of 4 | - | - | x1.001 | x1.007 | x0.752 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 B | 0.914 | 0.916 | x1.002 | level | 0 of 4 | - | - | x1.002 | x1.004 | x0.770 |
| blake3-servil-mt / shared-one-cache / LentMessages / 512 B | 0.944 | 0.943 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.002 | x0.849 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 KiB | 0.962 | 0.962 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.001 | x1.147 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.284 | 0.285 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.001 | x0.963 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 KiB | 0.0911 | 0.0908 | x0.997 | level | 4 of 4 | - | - | x0.997 | x1.000 | x1.098 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 KiB | 0.0653 | 0.0654 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.700 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 KiB | 0.0618 | 0.0616 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.036 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 MiB | 0.0460 | 0.0435 | x0.947 | level | 3 of 4 | - | - | x1.013 | x0.984 | x1.004 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 MiB | 0.0381 | 0.0381 | x1.000 | level | 3 of 4 | - | - | x1.009 | x1.007 | x1.030 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 MiB | 0.0712 | 0.0739 | x1.038 | level | 0 of 4 | - | - | x1.033 | x1.035 | x1.000 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 MiB | 0.130 | 0.131 | x1.008 | level | 1 of 4 | - | - | x0.993 | x1.025 | x1.009 |
| blake3-servil-mt / shared-one-cache / Interleaved / 256 | 0.109 | 0.109 | x1.000 | level | 1 of 4 | - | - | x1.000 | x0.999 | x1.012 |
| blake3-servil-mt / shared-one-cache / Collection / git objects | 0.0399 | 0.0402 | x1.006 | level | 2 of 4 | - | - | x0.978 | x0.983 | x0.979 |
| blake3-servil-mt / shared-one-cache / Collection / Nix files | 0.0363 | 0.0363 | x1.000 | level | 2 of 4 | - | - | x1.053 | x1.047 | x1.040 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16 | 6.043 | 6.059 | x1.003 | level | 0 of 4 | - | - | x1.003 | x0.998 | x1.091 |
| blake3-servil-mt / shared-one-cache / LentBatches / 64 | 5.332 | 5.359 | x1.005 | level | 1 of 4 | - | - | x1.005 | x0.999 | x0.804 |
| blake3-servil-mt / shared-one-cache / LentBatches / 256 | 5.262 | 5.255 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.130 |
| blake3-servil-mt / shared-one-cache / LentBatches / 1024 | 5.616 | 5.622 | x1.001 | level | 0 of 4 | - | - | x1.001 | x1.000 | x1.132 |
| blake3-servil-mt / shared-one-cache / LentBatches / 4096 | 5.508 | 5.477 | x0.994 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.737 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16384 | 2.989 | 3.016 | x1.009 | level | 2 of 4 | - | - | x1.003 | x1.011 | x1.003 |
| blake3-servil-mt / shared-one-cache / LentBatches / 65536 | 2.548 | 2.564 | x1.006 | level | 3 of 4 | - | - | x1.007 | x1.012 | x1.069 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.0525 | 0.0510 | x0.971 | level | 4 of 4 | - | - | x0.962 | x0.993 | x1.039 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / Nix files | 0.0519 | 0.0495 | x0.954 | level | 4 of 4 | - | - | x0.935 | x0.995 | x1.059 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1024 | 0.0996 | 0.0998 | x1.002 | level | 0 of 4 | - | - | x1.002 | x1.001 | x0.969 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 4096 | 0.0634 | 0.0629 | x0.992 | level | 2 of 4 | - | - | x0.996 | x1.002 | x0.993 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 16384 | 0.0500 | 0.0501 | x1.003 | level | 1 of 4 | - | - | x0.997 | x1.002 | x1.070 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 | 0.119 | 0.119 | x0.998 | level | 3 of 4 | - | - | x1.001 | x0.993 | x0.979 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 262144 | 0.182 | 0.183 | x1.004 | level | 0 of 4 | - | - | x1.002 | x1.030 | x1.007 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 32 B | 0.0971 | 0.0938 | x0.966 | level | 3 of 4 | - | - | x1.006 | x1.006 | x0.986 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 32 B | 0.343 | 0.345 | x1.007 | level | 2 of 4 | - | - | x0.991 | x1.030 | x0.999 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 16 B | 0.544 | 0.546 | x1.003 | level | 2 of 4 | - | - | x0.994 | x1.020 | x0.995 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 48 B | 0.0693 | 0.0695 | x1.002 | level | 1 of 4 | - | - | x0.988 | x0.995 | x1.039 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 48 B | 0.276 | 0.279 | x1.013 | level | 2 of 4 | - | - | x1.002 | x1.100 | x1.015 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.0434 | 0.0441 | x1.016 | level | 2 of 4 | - | - | x1.013 | x0.998 | x1.004 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 2 μs | 0.0928 | 0.0923 | x0.995 | level | 1 of 4 | - | - | x1.030 | x0.997 | x0.977 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 3 of 4 | - | - | x0.962 | x1.001 | x0.843 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 64 B | 0.780 | 0.779 | x0.998 | level | 4 of 4 | - | - | x0.998 | x1.006 | x1.039 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 1 KiB | 0.988 | 0.989 | x1.002 | level | 0 of 4 | - | - | x1.001 | x1.002 | x1.272 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 4 KiB | 0.290 | 0.290 | x1.001 | level | 0 of 4 | - | - | x1.001 | x1.001 | x1.200 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 4.353 | 4.344 | x0.998 | level | 2 of 4 | - | - | x0.998 | x0.945 | x1.064 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 4 KiB | 0.0686 | 0.0696 | x1.014 | level | 3 of 4 | - | - | x0.974 | x0.961 | x1.004 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 1 MiB | 0.0325 | 0.0320 | x0.984 | level | 2 of 4 | - | - | x0.975 | x1.006 | x0.992 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 64 B | 0.290 | 0.290 | x1.000 | level | 3 of 4 | - | - | x1.001 | x0.969 | x0.982 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 4 KiB | 0.0388 | 0.0426 | x1.097 | level | 0 of 4 | - | - | x1.043 | x1.016 | x0.965 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 1 MiB | 0.0160 | 0.0138 | x0.865 | level | 4 of 4 | - | - | x0.881 | x0.882 | x0.788 |

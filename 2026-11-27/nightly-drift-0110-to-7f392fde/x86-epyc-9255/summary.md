# Nightly drift check: e1966b498bc7 -> 7f392fdebc90

- Host: electric-rhino
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
| blake3-servil-st / solo / ManyMessages / 3 | 225.311 | 225.951 | x1.003 | level | 32 of 64 | - | - | x1.002 | x1.002 | x0.999 |
| blake3-servil-st / solo / ManyMessages / 24 | 145.417 | 143.440 | x0.986 | level | 33 of 64 | - | - | x0.989 | x1.000 | x0.996 |
| blake3-servil-mt / solo / OneMessage / 4470 B | 0.843 | 0.842 | x0.999 | level | 30 of 64 | - | - | x1.002 | x1.000 | x1.003 |
| blake3-servil-mt / solo / ManyMessages / 2 | 288.577 | 288.749 | x1.001 | level | 35 of 64 | - | - | x0.999 | x1.002 | x1.006 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.0549 | 0.0517 | x0.943 | faster | 49 of 64 | x0.904 | - | x0.946 | x0.986 | x1.143 |
| blake3-servil-mt / solo / MerkleTree / 16384 | 0.0654 | 0.0631 | x0.965 | level | 39 of 64 | x0.910 | - | x0.963 | x1.003 | x0.977 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 48 B | 0.122 | 0.125 | x1.024 | level | 30 of 64 | x1.050 | - | x1.024 | x0.985 | x1.036 |
| blake3-servil-mt / solo / ContinuousLentMessages / 1 MiB | 0.00344 | 0.00348 | x1.012 | level | 15 of 64 | x1.017 | - | x1.001 | x1.014 | x0.989 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.0606 | 0.0618 | x1.019 | level | 23 of 64 | - | - | x1.018 | x0.986 | x0.987 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 16384 | 0.106 | 0.106 | x0.997 | level | 31 of 64 | - | - | x0.997 | x0.998 | x1.004 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 48 B | 0.156 | 0.156 | x0.997 | level | 40 of 64 | - | - | x0.996 | x1.001 | x0.999 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 1 MiB | 0.00653 | 0.00654 | x1.002 | level | 37 of 64 | - | - | x1.015 | x1.020 | x1.018 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 KiB | 0.130 | 0.106 | x0.815 | faster | 63 of 64 | - | - | x0.816 | x0.986 | x0.935 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 16384 | 0.0845 | 0.0848 | x1.004 | level | 31 of 64 | - | - | x1.004 | x0.999 | x0.996 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 x 48 B | 0.138 | 0.137 | x0.992 | level | 49 of 64 | - | - | x0.993 | x1.001 | x0.995 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 1 MiB | 0.00703 | 0.00725 | x1.031 | level | 23 of 64 | - | - | x1.037 | x1.044 | x1.048 |

## Stage 1 (initial screen, kept-drift)

compare: old side: bench 3f119a507807 clean; servil e1966b498bc7 clean
compare: new side: bench 3f119a507807 clean; servil 7f392fdebc90 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 5.580 | 5.527 | x0.990 | level | 2 of 4 | - | - | x1.022 | x0.997 | x0.957 |
| blake3-servil-st / solo / OneMessage / 128 B | 3.354 | 3.245 | x0.967 | level | 3 of 4 | - | - | x0.988 | x1.004 | x0.946 |
| blake3-servil-st / solo / OneMessage / 256 B | 2.432 | 2.375 | x0.977 | level | 3 of 4 | - | - | x0.975 | x1.000 | x0.943 |
| blake3-servil-st / solo / OneMessage / 512 B | 1.926 | 1.798 | x0.934 | level | 4 of 4 | - | - | x0.959 | x1.000 | x0.961 |
| blake3-servil-st / solo / OneMessage / 1 KiB | 1.641 | 1.607 | x0.979 | level | 4 of 4 | - | - | x0.986 | x1.001 | x0.981 |
| blake3-servil-st / solo / OneMessage / 1536 B | 1.525 | 1.495 | x0.980 | level | 2 of 4 | - | - | x0.990 | x0.999 | x0.979 |
| blake3-servil-st / solo / OneMessage / 2 KiB | 1.030 | 1.031 | x1.002 | level | 2 of 4 | - | - | x1.013 | x1.004 | x0.982 |
| blake3-servil-st / solo / OneMessage / 2304 B | 1.173 | 1.168 | x0.996 | level | 3 of 4 | - | - | x1.003 | x1.002 | x0.998 |
| blake3-servil-st / solo / OneMessage / 3 KiB | 0.808 | 0.809 | x1.002 | level | 1 of 4 | - | - | x1.012 | x1.000 | x1.016 |
| blake3-servil-st / solo / OneMessage / 3839 B | 0.781 | 0.795 | x1.018 | level | 2 of 4 | - | - | x1.023 | x1.000 | x0.992 |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.560 | 0.573 | x1.022 | level | 1 of 4 | - | - | x1.035 | x1.000 | x0.991 |
| blake3-servil-st / solo / OneMessage / 4470 B | 0.672 | 0.688 | x1.024 | level | 1 of 4 | - | - | x1.026 | x1.000 | x0.996 |
| blake3-servil-st / solo / OneMessage / 7935 B | 0.596 | 0.594 | x0.995 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.001 |
| blake3-servil-st / solo / OneMessage / 8 KiB | 0.444 | 0.430 | x0.968 | level | 3 of 4 | - | - | x0.985 | x1.000 | x0.978 |
| blake3-servil-st / solo / OneMessage / 16 KiB | 0.314 | 0.299 | x0.950 | level | 4 of 4 | - | - | x0.969 | x1.001 | x0.969 |
| blake3-servil-st / solo / OneMessage / 32 KiB | 0.205 | 0.191 | x0.929 | level | 4 of 4 | - | - | x0.933 | x1.000 | x0.970 |
| blake3-servil-st / solo / OneMessage / 64 KiB | 0.150 | 0.146 | x0.976 | level | 4 of 4 | - | - | x0.973 | x1.000 | x0.938 |
| blake3-servil-st / solo / OneMessage / 128 KiB | 0.125 | 0.124 | x0.988 | level | 4 of 4 | - | - | x0.989 | x1.000 | x0.974 |
| blake3-servil-st / solo / OneMessage / 256 KiB | 0.113 | 0.112 | x0.990 | level | 3 of 4 | - | - | x0.991 | x1.000 | x0.984 |
| blake3-servil-st / solo / OneMessage / 512 KiB | 0.103 | 0.102 | x0.998 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.993 |
| blake3-servil-st / solo / OneMessage / 1 MiB | 0.0979 | 0.0980 | x1.002 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.037 |
| blake3-servil-st / solo / OneMessage / 2 MiB | 0.0987 | 0.0983 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.050 |
| blake3-servil-st / solo / OneMessage / 3 MiB | 0.100 | 0.100 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.055 |
| blake3-servil-st / solo / OneMessage / 4 MiB | 0.0988 | 0.0986 | x0.998 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.042 |
| blake3-servil-st / solo / OneMessage / 8 MiB | 0.106 | 0.106 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.033 |
| blake3-servil-st / solo / OneMessage / 32 MiB | 0.114 | 0.116 | x1.014 | level | 1 of 4 | - | - | x1.012 | x1.000 | x1.031 |
| blake3-servil-st / solo / OneMessage / 64 MiB | 0.115 | 0.116 | x1.010 | level | 1 of 4 | - | - | x1.014 | x1.000 | x1.030 |
| blake3-servil-st / solo / OneMessage / 128 MiB | 0.115 | 0.116 | x1.013 | level | 1 of 4 | - | - | x1.013 | x1.000 | x1.032 |
| blake3-servil-st / solo / ManyMessages / 1 | 428.705 | 465.992 | x1.087 | level | 1 of 4 | - | - | x1.053 | x1.007 | x1.046 |
| blake3-servil-st / solo / ManyMessages / 2 | 243.885 | 256.677 | x1.052 | level | 2 of 4 | - | - | x1.020 | x1.006 | x0.991 |
| blake3-servil-st / solo / ManyMessages / 3 | 194.897 | 210.800 | x1.082 | level | 0 of 4 | - | - | x1.042 | x1.008 | x1.003 |
| blake3-servil-st / solo / ManyMessages / 4 | 131.247 | 139.853 | x1.066 | level | 1 of 4 | - | - | x1.038 | x1.008 | x1.030 |
| blake3-servil-st / solo / ManyMessages / 6 | 116.291 | 120.714 | x1.038 | level | 1 of 4 | - | - | x1.024 | x1.004 | x1.013 |
| blake3-servil-st / solo / ManyMessages / 8 | 158.932 | 159.440 | x1.003 | level | 3 of 4 | - | - | x1.016 | x1.009 | x1.024 |
| blake3-servil-st / solo / ManyMessages / 12 | 115.863 | 117.017 | x1.010 | level | 1 of 4 | - | - | x1.018 | x1.003 | x1.011 |
| blake3-servil-st / solo / ManyMessages / 16 | 94.351 | 98.420 | x1.043 | level | 2 of 4 | - | - | x1.031 | x1.001 | x1.016 |
| blake3-servil-st / solo / ManyMessages / 24 | 95.251 | 100.908 | x1.059 | level | 0 of 4 | - | - | x1.065 | x1.003 | x1.012 |
| blake3-servil-st / solo / ManyMessages / 32 | 44.422 | 47.157 | x1.062 | level | 1 of 4 | - | - | x1.084 | x1.005 | x1.014 |
| blake3-servil-st / solo / ManyMessages / 48 | 33.095 | 34.350 | x1.038 | level | 1 of 4 | - | - | x1.059 | x0.997 | x1.015 |
| blake3-servil-st / solo / ManyMessages / 64 | 27.568 | 28.071 | x1.018 | level | 3 of 4 | - | - | x1.047 | x1.002 | x1.009 |
| blake3-servil-st / solo / ManyMessages / 128 | 18.513 | 18.810 | x1.016 | level | 1 of 4 | - | - | x1.035 | x1.000 | x1.000 |
| blake3-servil-st / solo / ManyMessages / 256 | 13.420 | 13.763 | x1.026 | level | 2 of 4 | - | - | x1.032 | x1.000 | x0.965 |
| blake3-servil-st / solo / ManyMessages / 512 | 11.019 | 11.192 | x1.016 | level | 2 of 4 | - | - | x1.021 | x1.000 | x0.949 |
| blake3-servil-st / solo / ManyMessages / 1024 | 9.535 | 9.772 | x1.025 | level | 0 of 4 | - | - | x1.026 | x1.000 | x0.958 |
| blake3-servil-st / solo / ManyMessages / 2048 | 9.022 | 9.049 | x1.003 | level | 2 of 4 | - | - | x1.005 | x1.000 | x0.939 |
| blake3-servil-st / solo / ManyMessages / 4096 | 8.825 | 8.750 | x0.991 | level | 2 of 4 | - | - | x0.994 | x1.000 | x0.917 |
| blake3-servil-st / solo / ManyMessages / 8192 | 8.217 | 8.186 | x0.996 | level | 4 of 4 | - | - | x0.996 | x1.000 | x0.956 |
| blake3-servil-st / solo / ManyMessages / 16384 | 7.882 | 7.854 | x0.997 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.933 |
| blake3-servil-st / solo / ManyMessages / 32768 | 7.889 | 7.873 | x0.998 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.978 |
| blake3-servil-st / solo / ManyMessages / 65536 | 7.968 | 7.989 | x1.003 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.001 |
| blake3-servil-st / solo / ManyMessages / 131072 | 8.340 | 8.378 | x1.005 | level | 2 of 4 | - | - | x1.005 | x1.000 | x1.015 |
| blake3-servil-st / solo / ManyMessages / 262144 | 8.754 | 8.783 | x1.003 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.014 |
| blake3-servil-st / solo / ManyLongMessages / 4 | 1836.550 | 1858.662 | x1.012 | level | 1 of 4 | - | - | x1.005 | x1.000 | x0.967 |
| blake3-servil-st / solo / ManyLongMessages / 16 | 1643.434 | 684.439 | x0.416 | faster | 4 of 4 | - | - | x0.424 | x0.576 | x1.309 |
| blake3-servil-st / solo / ManyLongMessages / 64 | 572.989 | 560.828 | x0.979 | level | 4 of 4 | - | - | x0.980 | x1.000 | x0.968 |
| blake3-servil-st / solo / ManyLongMessages / 256 | 520.448 | 519.245 | x0.998 | level | 3 of 4 | - | - | x0.994 | x0.999 | x0.986 |
| blake3-servil-st / solo / IdleOneMessage / 64 B | 3.053 | 3.033 | x0.994 | level | 2 of 4 | - | - | x0.994 | x1.006 | x0.977 |
| blake3-servil-st / solo / IdleOneMessage / 128 B | 2.156 | 2.115 | x0.981 | level | 3 of 4 | - | - | x0.994 | x1.004 | x1.046 |
| blake3-servil-st / solo / IdleOneMessage / 256 B | 1.745 | 1.754 | x1.005 | level | 2 of 4 | - | - | x1.000 | x1.003 | x1.639 |
| blake3-servil-st / solo / IdleOneMessage / 512 B | 1.634 | 1.605 | x0.982 | level | 2 of 4 | - | - | x0.998 | x1.002 | x0.846 |
| blake3-servil-st / solo / IdleOneMessage / 1 KiB | 1.542 | 1.542 | x1.000 | level | 2 of 4 | - | - | x0.999 | x1.001 | x1.029 |
| blake3-servil-st / solo / IdleOneMessage / 1536 B | 1.162 | 1.180 | x1.015 | level | 1 of 4 | - | - | x0.996 | x0.998 | x0.266 |
| blake3-servil-st / solo / IdleOneMessage / 2 KiB | 0.842 | 0.866 | x1.028 | level | 0 of 4 | - | - | x1.000 | x1.001 | x1.072 |
| blake3-servil-st / solo / IdleOneMessage / 2304 B | 0.958 | 0.973 | x1.016 | level | 0 of 4 | - | - | x0.998 | x1.001 | x2.831 |
| blake3-servil-st / solo / IdleOneMessage / 3 KiB | 0.624 | 0.622 | x0.996 | level | 3 of 4 | - | - | x1.000 | x1.001 | x1.418 |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 0.517 | 0.512 | x0.990 | level | 3 of 4 | - | - | x1.003 | x1.001 | x1.300 |
| blake3-servil-st / solo / IdleOneMessage / 4 KiB | 0.471 | 0.469 | x0.995 | level | 3 of 4 | - | - | x1.002 | x1.001 | x2.788 |
| blake3-servil-st / solo / IdleOneMessage / 4470 B | 0.587 | 0.579 | x0.988 | level | 3 of 4 | - | - | x1.002 | x1.001 | x0.696 |
| blake3-servil-st / solo / IdleOneMessage / 7935 B | 0.293 | 0.291 | x0.994 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.093 |
| blake3-servil-st / solo / IdleOneMessage / 8 KiB | 0.274 | 0.271 | x0.988 | level | 3 of 4 | - | - | x1.001 | x1.000 | x1.650 |
| blake3-servil-st / solo / IdleOneMessage / 16 KiB | 0.156 | 0.153 | x0.979 | level | 3 of 4 | - | - | x0.996 | x1.001 | x0.661 |
| blake3-servil-st / solo / IdleOneMessage / 32 KiB | 0.108 | 0.107 | x0.996 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.131 |
| blake3-servil-st / solo / IdleOneMessage / 64 KiB | 0.0984 | 0.0981 | x0.997 | level | 1 of 4 | - | - | x0.999 | x1.000 | x1.211 |
| blake3-servil-st / solo / IdleOneMessage / 128 KiB | 0.0934 | 0.0935 | x1.002 | level | 1 of 4 | - | - | x0.995 | x1.000 | x0.658 |
| blake3-servil-st / solo / IdleOneMessage / 256 KiB | 0.0904 | 0.0928 | x1.027 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.302 |
| blake3-servil-st / solo / IdleOneMessage / 512 KiB | 0.0951 | 0.0971 | x1.021 | level | 1 of 4 | - | - | x0.995 | x1.000 | x1.015 |
| blake3-servil-st / solo / IdleOneMessage / 1 MiB | 0.0936 | 0.0946 | x1.010 | level | 2 of 4 | - | - | x0.994 | x1.000 | x1.029 |
| blake3-servil-st / solo / IdleOneMessage / 2 MiB | 0.0881 | 0.0882 | x1.001 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.036 |
| blake3-servil-st / solo / IdleOneMessage / 3 MiB | 0.0871 | 0.0872 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.052 |
| blake3-servil-st / solo / IdleOneMessage / 4 MiB | 0.0869 | 0.0871 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.037 |
| blake3-servil-st / solo / IdleOneMessage / 8 MiB | 0.0881 | 0.0880 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.044 |
| blake3-servil-st / solo / IdleOneMessage / 32 MiB | 0.114 | 0.115 | x1.012 | level | 1 of 4 | - | - | x1.012 | x1.000 | x1.030 |
| blake3-servil-st / solo / IdleOneMessage / 64 MiB | 0.115 | 0.116 | x1.012 | level | 1 of 4 | - | - | x1.012 | x1.000 | x1.025 |
| blake3-servil-st / solo / IdleOneMessage / 128 MiB | 0.115 | 0.116 | x1.010 | level | 1 of 4 | - | - | x1.012 | x1.000 | x1.028 |
| blake3-servil-st / solo / IdleManyMessages / 1 | 207.991 | 207.844 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.007 | x0.804 |
| blake3-servil-st / solo / IdleManyMessages / 2 | 108.531 | 105.192 | x0.969 | level | 3 of 4 | - | - | x0.995 | x1.003 | x1.845 |
| blake3-servil-st / solo / IdleManyMessages / 3 | 91.123 | 89.924 | x0.987 | level | 2 of 4 | - | - | x0.994 | x1.002 | x0.734 |
| blake3-servil-st / solo / IdleManyMessages / 4 | 53.752 | 53.097 | x0.988 | level | 4 of 4 | - | - | x0.987 | x1.004 | x0.185 |
| blake3-servil-st / solo / IdleManyMessages / 6 | 51.023 | 50.378 | x0.987 | level | 3 of 4 | - | - | x0.995 | x1.003 | x2.175 |
| blake3-servil-st / solo / IdleManyMessages / 8 | 33.646 | 33.362 | x0.992 | level | 2 of 4 | - | - | x0.999 | x1.003 | x0.811 |
| blake3-servil-st / solo / IdleManyMessages / 12 | 31.598 | 31.039 | x0.982 | level | 3 of 4 | - | - | x0.993 | x1.003 | x0.709 |
| blake3-servil-st / solo / IdleManyMessages / 16 | 18.378 | 18.480 | x1.006 | level | 1 of 4 | - | - | x0.990 | x1.002 | x0.554 |
| blake3-servil-st / solo / IdleManyMessages / 24 | 17.493 | 17.397 | x0.995 | level | 2 of 4 | - | - | x1.001 | x1.002 | x3.214 |
| blake3-servil-st / solo / IdleManyMessages / 32 | 13.072 | 13.034 | x0.997 | level | 2 of 4 | - | - | x1.003 | x1.001 | x0.938 |
| blake3-servil-st / solo / IdleManyMessages / 48 | 11.335 | 11.298 | x0.997 | level | 2 of 4 | - | - | x1.004 | x1.001 | x1.039 |
| blake3-servil-st / solo / IdleManyMessages / 64 | 10.511 | 10.462 | x0.995 | level | 2 of 4 | - | - | x0.993 | x1.001 | x0.174 |
| blake3-servil-st / solo / IdleManyMessages / 128 | 9.166 | 9.361 | x1.021 | level | 1 of 4 | - | - | x0.998 | x1.001 | x0.484 |
| blake3-servil-st / solo / IdleManyMessages / 256 | 8.675 | 8.785 | x1.013 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.037 |
| blake3-servil-st / solo / IdleManyMessages / 512 | 8.357 | 8.397 | x1.005 | level | 2 of 4 | - | - | x1.004 | x1.000 | x1.480 |
| blake3-servil-st / solo / IdleManyMessages / 1024 | 8.170 | 8.167 | x1.000 | level | 2 of 4 | - | - | x1.009 | x1.000 | x1.606 |
| blake3-servil-st / solo / IdleManyMessages / 2048 | 8.097 | 7.948 | x0.982 | level | 3 of 4 | - | - | x1.003 | x1.000 | x0.902 |
| blake3-servil-st / solo / IdleManyMessages / 4096 | 8.102 | 8.005 | x0.988 | level | 4 of 4 | - | - | x1.002 | x1.000 | x1.071 |
| blake3-servil-st / solo / IdleManyMessages / 8192 | 8.273 | 8.183 | x0.989 | level | 3 of 4 | - | - | x1.001 | x1.000 | x0.894 |
| blake3-servil-st / solo / IdleManyMessages / 16384 | 7.916 | 7.869 | x0.994 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.846 |
| blake3-servil-st / solo / IdleManyMessages / 32768 | 7.500 | 7.492 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.849 |
| blake3-servil-st / solo / IdleManyMessages / 65536 | 7.445 | 7.442 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.871 |
| blake3-servil-st / solo / IdleManyMessages / 131072 | 7.474 | 7.432 | x0.994 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.827 |
| blake3-servil-st / solo / IdleManyMessages / 262144 | 8.052 | 8.050 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.944 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 B | 3.032 | 3.026 | x0.998 | level | 3 of 4 | - | - | x0.994 | x1.006 | x1.019 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 B | 2.107 | 2.169 | x1.029 | level | 1 of 4 | - | - | x0.997 | x1.005 | x0.990 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 B | 1.691 | 1.840 | x1.088 | level | 1 of 4 | - | - | x1.003 | x1.003 | x1.615 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 B | 1.457 | 1.459 | x1.001 | level | 1 of 4 | - | - | x0.999 | x1.002 | x0.333 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 KiB | 1.346 | 1.351 | x1.004 | level | 1 of 4 | - | - | x1.000 | x1.001 | x0.972 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1536 B | 1.011 | 1.012 | x1.001 | level | 2 of 4 | - | - | x0.999 | x0.998 | x1.114 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 KiB | 0.733 | 0.730 | x0.995 | level | 3 of 4 | - | - | x0.997 | x1.001 | x1.640 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2304 B | 0.816 | 0.812 | x0.995 | level | 4 of 4 | - | - | x0.994 | x1.001 | x0.648 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.523 | 0.524 | x1.002 | level | 0 of 4 | - | - | x1.002 | x1.001 | x0.753 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3839 B | 0.426 | 0.428 | x1.005 | level | 1 of 4 | - | - | x1.005 | x1.001 | x1.668 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 KiB | 0.393 | 0.391 | x0.994 | level | 2 of 4 | - | - | x0.999 | x1.001 | x1.285 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4470 B | 0.481 | 0.483 | x1.003 | level | 0 of 4 | - | - | x1.001 | x1.001 | x0.832 |
| blake3-servil-st / solo / BriefIdleOneMessage / 7935 B | 0.240 | 0.241 | x1.006 | level | 1 of 4 | - | - | x1.005 | x1.000 | x2.783 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 KiB | 0.223 | 0.224 | x1.002 | level | 2 of 4 | - | - | x1.001 | x1.001 | x0.454 |
| blake3-servil-st / solo / BriefIdleOneMessage / 16 KiB | 0.126 | 0.127 | x1.008 | level | 1 of 4 | - | - | x1.001 | x1.001 | x0.624 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 KiB | 0.0881 | 0.0884 | x1.004 | level | 1 of 4 | - | - | x1.004 | x1.000 | x0.600 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 KiB | 0.0817 | 0.0816 | x0.999 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.826 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 KiB | 0.0781 | 0.0780 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.709 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 KiB | 0.0778 | 0.0774 | x0.994 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.145 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 KiB | 0.0841 | 0.0838 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.997 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 MiB | 0.0872 | 0.0869 | x0.997 | level | 3 of 4 | - | - | x0.994 | x1.000 | x1.025 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 MiB | 0.0877 | 0.0874 | x0.997 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.041 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 MiB | 0.0875 | 0.0873 | x0.997 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.998 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 MiB | 0.0874 | 0.0871 | x0.997 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.012 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 MiB | 0.0886 | 0.0880 | x0.994 | level | 2 of 4 | - | - | x0.994 | x1.000 | x1.006 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 MiB | 0.114 | 0.115 | x1.009 | level | 1 of 4 | - | - | x1.009 | x1.000 | x1.021 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 MiB | 0.115 | 0.116 | x1.010 | level | 1 of 4 | - | - | x1.010 | x1.000 | x1.023 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 MiB | 0.115 | 0.116 | x1.010 | level | 1 of 4 | - | - | x1.012 | x1.000 | x1.030 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1 | 207.136 | 204.756 | x0.989 | level | 3 of 4 | - | - | x0.997 | x1.008 | x0.890 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2 | 105.460 | 105.376 | x0.999 | level | 2 of 4 | - | - | x0.996 | x1.004 | x1.006 |
| blake3-servil-st / solo / BriefIdleManyMessages / 3 | 90.632 | 91.645 | x1.011 | level | 2 of 4 | - | - | x0.997 | x1.002 | x1.378 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4 | 53.172 | 52.782 | x0.993 | level | 3 of 4 | - | - | x0.997 | x1.004 | x0.890 |
| blake3-servil-st / solo / BriefIdleManyMessages / 6 | 45.814 | 45.811 | x1.000 | level | 3 of 4 | - | - | x0.999 | x1.003 | x1.300 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8 | 28.769 | 28.663 | x0.996 | level | 1 of 4 | - | - | x0.989 | x1.002 | x1.247 |
| blake3-servil-st / solo / BriefIdleManyMessages / 12 | 25.883 | 25.663 | x0.992 | level | 1 of 4 | - | - | x0.993 | x1.003 | x1.018 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16 | 14.699 | 14.725 | x1.002 | level | 1 of 4 | - | - | x0.999 | x1.002 | x1.017 |
| blake3-servil-st / solo / BriefIdleManyMessages / 24 | 13.812 | 13.717 | x0.993 | level | 1 of 4 | - | - | x0.993 | x1.002 | x2.119 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32 | 10.627 | 10.535 | x0.991 | level | 2 of 4 | - | - | x0.999 | x1.001 | x1.542 |
| blake3-servil-st / solo / BriefIdleManyMessages / 48 | 9.165 | 9.240 | x1.008 | level | 2 of 4 | - | - | x1.001 | x1.001 | x1.074 |
| blake3-servil-st / solo / BriefIdleManyMessages / 64 | 8.572 | 8.433 | x0.984 | level | 4 of 4 | - | - | x0.995 | x1.001 | x0.716 |
| blake3-servil-st / solo / BriefIdleManyMessages / 128 | 7.457 | 7.434 | x0.997 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.412 |
| blake3-servil-st / solo / BriefIdleManyMessages / 256 | 7.043 | 7.127 | x1.012 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.820 |
| blake3-servil-st / solo / BriefIdleManyMessages / 512 | 6.802 | 6.840 | x1.006 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.504 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1024 | 6.665 | 6.703 | x1.006 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.042 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2048 | 6.657 | 6.662 | x1.001 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.755 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4096 | 6.827 | 6.798 | x0.996 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.900 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8192 | 7.304 | 7.267 | x0.995 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.874 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16384 | 7.449 | 7.440 | x0.999 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.860 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32768 | 7.494 | 7.477 | x0.998 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.850 |
| blake3-servil-st / solo / BriefIdleManyMessages / 65536 | 7.456 | 7.458 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.890 |
| blake3-servil-st / solo / BriefIdleManyMessages / 131072 | 7.466 | 7.443 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.859 |
| blake3-servil-st / solo / BriefIdleManyMessages / 262144 | 8.073 | 8.052 | x0.997 | level | 3 of 4 | - | - | x1.001 | x1.000 | x0.964 |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.940 | 0.941 | x1.002 | level | 0 of 4 | x1.002 | - | x1.001 | x1.000 | x0.798 |
| blake3-servil-st / solo / ContinuousMessages / 128 B | 1.078 | 1.079 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | x1.019 |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 1.151 | 1.152 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | x0.561 |
| blake3-servil-st / solo / ContinuousMessages / 512 B | 1.188 | 1.189 | x1.001 | level | 0 of 4 | x1.001 | - | x1.000 | x1.000 | x0.742 |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 1.212 | 1.212 | x1.001 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x0.885 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.358 | 0.358 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x0.244 |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.114 | 0.114 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x0.638 |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.0810 | 0.0809 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x0.392 |
| blake3-servil-st / solo / ContinuousMessages / 256 KiB | 0.0827 | 0.0827 | x1.000 | level | 2 of 4 | x1.000 | - | x0.999 | x1.000 | x0.492 |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.0842 | 0.0841 | x0.998 | level | 2 of 4 | x0.998 | - | x0.998 | x1.000 | x0.926 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.0854 | 0.0855 | x1.000 | level | 2 of 4 | x1.000 | - | x0.999 | x1.000 | x0.963 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.0854 | 0.0853 | x1.000 | level | 3 of 4 | x1.000 | - | x0.999 | x1.000 | x0.908 |
| blake3-servil-st / solo / ContinuousMessages / 64 MiB | 0.0975 | 0.0977 | x1.002 | level | 2 of 4 | x1.002 | - | x1.000 | x1.000 | x0.966 |
| blake3-servil-st / solo / ContinuousBatches / 16 | 7.543 | 7.562 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x0.998 | x11.987 |
| blake3-servil-st / solo / ContinuousBatches / 64 | 6.636 | 6.646 | x1.001 | level | 2 of 4 | x1.002 | - | x1.003 | x0.999 | x2.238 |
| blake3-servil-st / solo / ContinuousBatches / 256 | 6.624 | 6.583 | x0.994 | level | 3 of 4 | x0.994 | - | x0.993 | x1.000 | x34.415 |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 7.079 | 7.042 | x0.995 | level | 3 of 4 | x0.995 | - | x0.994 | x1.000 | x60.148 |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 6.907 | 6.842 | x0.991 | level | 3 of 4 | x0.991 | - | x0.992 | x1.000 | x1.381 |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 7.709 | 7.640 | x0.991 | level | 3 of 4 | x0.991 | - | x0.991 | x1.000 | x0.948 |
| blake3-servil-st / solo / ContinuousBatches / 65536 | 7.698 | 7.701 | x1.000 | level | 2 of 4 | x1.000 | - | x1.001 | x1.000 | x1.211 |
| blake3-servil-st / solo / LentMessages / 64 B | 0.940 | 0.941 | x1.002 | level | 0 of 4 | x1.002 | - | x1.001 | x1.000 | x0.798 |
| blake3-servil-st / solo / LentMessages / 128 B | 1.078 | 1.079 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | x1.019 |
| blake3-servil-st / solo / LentMessages / 256 B | 1.151 | 1.152 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | x0.561 |
| blake3-servil-st / solo / LentMessages / 512 B | 1.188 | 1.189 | x1.001 | level | 0 of 4 | x1.001 | - | x1.000 | x1.000 | x0.742 |
| blake3-servil-st / solo / LentMessages / 1 KiB | 1.212 | 1.212 | x1.001 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x0.885 |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.358 | 0.358 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x0.244 |
| blake3-servil-st / solo / LentMessages / 16 KiB | 0.114 | 0.114 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x0.638 |
| blake3-servil-st / solo / LentMessages / 64 KiB | 0.0810 | 0.0809 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x0.392 |
| blake3-servil-st / solo / LentMessages / 256 KiB | 0.0759 | 0.0760 | x1.001 | level | 2 of 4 | x1.001 | - | x1.003 | x1.000 | x1.605 |
| blake3-servil-st / solo / LentMessages / 1 MiB | 0.0857 | 0.0862 | x1.005 | level | 1 of 4 | x1.005 | - | x1.005 | x1.000 | x1.020 |
| blake3-servil-st / solo / LentMessages / 4 MiB | 0.0860 | 0.0864 | x1.004 | level | 2 of 4 | x1.004 | - | x1.005 | x1.000 | x1.060 |
| blake3-servil-st / solo / LentMessages / 16 MiB | 0.0917 | 0.0912 | x0.995 | level | 3 of 4 | x0.994 | - | x0.994 | x1.000 | x1.053 |
| blake3-servil-st / solo / LentMessages / 64 MiB | 0.117 | 0.118 | x1.012 | level | 1 of 4 | x1.012 | - | x1.011 | x1.000 | x1.019 |
| blake3-servil-st / solo / Interleaved / 256 | 0.137 | 0.137 | x0.998 | level | 3 of 4 | x0.998 | - | x0.997 | x0.999 | x0.983 |
| blake3-servil-st / solo / Collection / git objects | 0.0981 | 0.0985 | x1.004 | level | 2 of 4 | x1.003 | - | x1.002 | x0.999 | x1.026 |
| blake3-servil-st / solo / Collection / Nix files | 0.0888 | 0.0891 | x1.003 | level | 2 of 4 | x1.003 | - | x1.002 | x0.999 | x1.024 |
| blake3-servil-st / solo / LentBatches / 16 | 7.543 | 7.562 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x0.998 | x11.987 |
| blake3-servil-st / solo / LentBatches / 64 | 6.636 | 6.646 | x1.001 | level | 2 of 4 | x1.002 | - | x1.003 | x0.999 | x2.238 |
| blake3-servil-st / solo / LentBatches / 256 | 6.624 | 6.583 | x0.994 | level | 3 of 4 | x0.994 | - | x0.993 | x1.000 | x34.415 |
| blake3-servil-st / solo / LentBatches / 1024 | 7.079 | 7.042 | x0.995 | level | 3 of 4 | x0.995 | - | x0.994 | x1.000 | x60.148 |
| blake3-servil-st / solo / LentBatches / 4096 | 6.907 | 6.842 | x0.991 | level | 3 of 4 | x0.991 | - | x0.992 | x1.000 | x1.381 |
| blake3-servil-st / solo / LentBatches / 16384 | 7.709 | 7.640 | x0.991 | level | 3 of 4 | x0.991 | - | x0.991 | x1.000 | x0.948 |
| blake3-servil-st / solo / LentBatches / 65536 | 7.698 | 7.701 | x1.000 | level | 2 of 4 | x1.000 | - | x1.001 | x1.000 | x1.211 |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.136 | 0.136 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x1.043 |
| blake3-servil-st / solo / ContinuousCollection / Nix files | 0.147 | 0.146 | x0.998 | level | 3 of 4 | x0.998 | - | x0.999 | x1.000 | x1.026 |
| blake3-servil-st / solo / MerkleTree / 1024 | 0.123 | 0.123 | x1.000 | level | 2 of 4 | x1.000 | - | x0.999 | x1.001 | x0.225 |
| blake3-servil-st / solo / MerkleTree / 4096 | 0.134 | 0.134 | x1.002 | level | 2 of 4 | x1.003 | - | x1.002 | x1.001 | x1.123 |
| blake3-servil-st / solo / MerkleTree / 16384 | 0.133 | 0.133 | x1.001 | level | 2 of 4 | x1.001 | - | x1.000 | x1.001 | x1.077 |
| blake3-servil-st / solo / MerkleTree / 65536 | 0.141 | 0.141 | x1.001 | level | 2 of 4 | x1.001 | - | x1.000 | x1.001 | x0.961 |
| blake3-servil-st / solo / MerkleTree / 262144 | 0.151 | 0.151 | x1.002 | level | 2 of 4 | x1.001 | - | x1.002 | x1.001 | x0.987 |
| blake3-servil-st / solo / MerkleTree / 65536 x 32 B | 0.385 | 0.384 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.078 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 32 B | 0.419 | 0.422 | x1.008 | level | 1 of 4 | x1.007 | - | x1.003 | x1.000 | x0.922 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 16 B | 0.807 | 0.805 | x0.997 | level | 3 of 4 | x0.997 | - | x0.998 | x1.000 | x1.098 |
| blake3-servil-st / solo / MerkleTree / 65536 x 48 B | 0.269 | 0.269 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.034 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 48 B | 0.297 | 0.297 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x0.924 |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.249 | 0.242 | x0.971 | level | 4 of 4 | - | - | x0.973 | x0.980 | x0.998 |
| blake3-servil-st / solo / InterleavedTurn / 1024 x 1 KiB | 0.228 | 0.230 | x1.009 | level | 1 of 4 | - | - | x1.009 | x1.000 | x1.034 |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.208 | 0.207 | x0.992 | level | 3 of 4 | - | - | x0.992 | x0.999 | x1.034 |
| blake3-servil-st / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.191 | 0.191 | x1.003 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.013 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.205 | 0.204 | x0.994 | level | 3 of 4 | - | - | x1.000 | x1.008 | x1.008 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.189 | 0.189 | x1.002 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.023 |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.105 | 0.105 | x1.001 | level | 2 of 4 | x1.001 | - | x0.999 | x1.000 | x0.969 |
| blake3-servil-st / solo / ReceivingMessage / 2 μs | 0.106 | 0.106 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x0.979 |
| blake3-servil-st / solo / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 2 of 4 | x1.001 | - | x0.998 | x1.000 | x0.888 |
| blake3-servil-st / solo / IncrementalMessage / 64 B | 6.178 | 6.099 | x0.987 | level | 2 of 4 | - | - | x0.992 | x1.001 | x1.017 |
| blake3-servil-st / solo / IncrementalMessage / 1 KiB | 1.948 | 1.915 | x0.983 | level | 3 of 4 | - | - | x0.989 | x0.997 | x1.040 |
| blake3-servil-st / solo / IncrementalMessage / 4 KiB | 0.619 | 0.617 | x0.997 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.993 |
| blake3-servil-st / solo / LentIncrementalMessage / 64 B | 1.048 | 1.016 | x0.970 | level | 2 of 4 | x0.970 | - | x0.994 | x1.000 | x0.405 |
| blake3-servil-st / solo / LentIncrementalMessage / 1 KiB | 1.244 | 1.244 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | x0.509 |
| blake3-servil-st / solo / LentIncrementalMessage / 4 KiB | 0.364 | 0.365 | x1.001 | level | 1 of 4 | x1.000 | - | x0.999 | x1.000 | x0.730 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 0.950 | 0.951 | x1.001 | level | 0 of 4 | x1.001 | - | x1.000 | x1.000 | x0.890 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 4 KiB | 0.358 | 0.357 | x0.998 | level | 4 of 4 | x0.998 | - | x0.999 | x1.000 | x3.911 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 1 MiB | 0.0843 | 0.0823 | x0.976 | level | 4 of 4 | x0.975 | - | x0.975 | x1.000 | x0.781 |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 0.908 | 0.908 | x1.000 | level | 3 of 4 | x1.000 | - | x1.001 | x1.000 | x1.074 |
| blake3-servil-st / solo / ContinuousLentMessages / 4 KiB | 0.353 | 0.353 | x0.999 | level | 3 of 4 | x0.999 | - | x1.000 | x1.000 | x0.223 |
| blake3-servil-st / solo / ContinuousLentMessages / 1 MiB | 0.0692 | 0.0713 | x1.030 | level | 2 of 4 | x1.029 | - | x1.000 | x1.000 | x1.093 |
| blake3-servil-mt / solo / OneMessage / 64 B | 5.915 | 5.586 | x0.944 | level | 2 of 4 | - | - | x0.976 | x1.000 | x0.937 |
| blake3-servil-mt / solo / OneMessage / 128 B | 3.659 | 3.384 | x0.925 | level | 4 of 4 | - | - | x0.959 | x1.002 | x0.946 |
| blake3-servil-mt / solo / OneMessage / 256 B | 2.440 | 2.412 | x0.988 | level | 3 of 4 | - | - | x1.000 | x0.998 | x0.984 |
| blake3-servil-mt / solo / OneMessage / 512 B | 1.961 | 1.918 | x0.978 | level | 3 of 4 | - | - | x0.990 | x1.002 | x0.984 |
| blake3-servil-mt / solo / OneMessage / 1 KiB | 1.679 | 1.667 | x0.993 | level | 2 of 4 | - | - | x0.998 | x1.002 | x0.992 |
| blake3-servil-mt / solo / OneMessage / 1536 B | 1.548 | 1.524 | x0.985 | level | 3 of 4 | - | - | x0.992 | x0.998 | x0.970 |
| blake3-servil-mt / solo / OneMessage / 2 KiB | 1.049 | 1.044 | x0.996 | level | 1 of 4 | - | - | x1.012 | x1.002 | x0.997 |
| blake3-servil-mt / solo / OneMessage / 2304 B | 1.199 | 1.180 | x0.984 | level | 3 of 4 | - | - | x0.993 | x1.001 | x1.009 |
| blake3-servil-mt / solo / OneMessage / 3 KiB | 0.825 | 0.819 | x0.993 | level | 3 of 4 | - | - | x0.998 | x0.999 | x1.004 |
| blake3-servil-mt / solo / OneMessage / 3839 B | 0.811 | 0.808 | x0.997 | level | 2 of 4 | - | - | x1.008 | x0.998 | x1.011 |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 0.585 | 0.582 | x0.995 | level | 2 of 4 | - | - | x1.008 | x1.001 | x1.018 |
| blake3-servil-mt / solo / OneMessage / 4470 B | 0.679 | 0.715 | x1.053 | level | 0 of 4 | - | - | x1.044 | x1.001 | x1.010 |
| blake3-servil-mt / solo / OneMessage / 7935 B | 0.595 | 0.585 | x0.984 | level | 2 of 4 | - | - | x0.991 | x1.000 | x0.992 |
| blake3-servil-mt / solo / OneMessage / 8 KiB | 0.443 | 0.432 | x0.974 | level | 2 of 4 | - | - | x0.984 | x1.001 | x0.997 |
| blake3-servil-mt / solo / OneMessage / 16 KiB | 0.308 | 0.303 | x0.982 | level | 2 of 4 | - | - | x0.987 | x1.001 | x0.981 |
| blake3-servil-mt / solo / OneMessage / 32 KiB | 0.207 | 0.190 | x0.914 | faster | 4 of 4 | - | - | x0.920 | x1.000 | x0.970 |
| blake3-servil-mt / solo / OneMessage / 64 KiB | 0.152 | 0.145 | x0.958 | level | 4 of 4 | - | - | x0.964 | x1.000 | x0.955 |
| blake3-servil-mt / solo / OneMessage / 128 KiB | 0.126 | 0.123 | x0.980 | level | 4 of 4 | - | - | x0.980 | x1.000 | x0.943 |
| blake3-servil-mt / solo / OneMessage / 256 KiB | 0.113 | 0.113 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.918 |
| blake3-servil-mt / solo / OneMessage / 512 KiB | 0.0676 | 0.0703 | x1.040 | level | 0 of 4 | - | - | x1.045 | x0.947 | x0.907 |
| blake3-servil-mt / solo / OneMessage / 1 MiB | 0.0521 | 0.0527 | x1.011 | level | 3 of 4 | - | - | x1.007 | x0.972 | x0.986 |
| blake3-servil-mt / solo / OneMessage / 2 MiB | 0.0644 | 0.0646 | x1.004 | level | 1 of 4 | - | - | x1.006 | x1.001 | x0.990 |
| blake3-servil-mt / solo / OneMessage / 3 MiB | 0.0711 | 0.0714 | x1.004 | level | 1 of 4 | - | - | x1.003 | x0.976 | x0.998 |
| blake3-servil-mt / solo / OneMessage / 4 MiB | 0.0423 | 0.0428 | x1.012 | level | 1 of 4 | - | - | x1.013 | x0.992 | x0.987 |
| blake3-servil-mt / solo / OneMessage / 8 MiB | 0.0695 | 0.0694 | x0.999 | level | 2 of 4 | - | - | x0.998 | x0.994 | x0.994 |
| blake3-servil-mt / solo / OneMessage / 32 MiB | 0.0364 | 0.0365 | x1.004 | level | 1 of 4 | - | - | x1.004 | x1.000 | x0.995 |
| blake3-servil-mt / solo / OneMessage / 64 MiB | 0.0343 | 0.0343 | x0.999 | level | 2 of 4 | - | - | x0.999 | x0.992 | x0.982 |
| blake3-servil-mt / solo / OneMessage / 128 MiB | 0.0355 | 0.0357 | x1.006 | level | 1 of 4 | - | - | x1.006 | x1.002 | x0.985 |
| blake3-servil-mt / solo / ManyMessages / 1 | 501.024 | 497.417 | x0.993 | level | 2 of 4 | - | - | x0.987 | x1.011 | x0.978 |
| blake3-servil-mt / solo / ManyMessages / 2 | 271.814 | 288.169 | x1.060 | level | 0 of 4 | - | - | x1.028 | x1.005 | x0.959 |
| blake3-servil-mt / solo / ManyMessages / 3 | 211.079 | 208.718 | x0.989 | level | 2 of 4 | - | - | x0.991 | x1.005 | x0.972 |
| blake3-servil-mt / solo / ManyMessages / 4 | 150.126 | 154.771 | x1.031 | level | 1 of 4 | - | - | x1.023 | x1.003 | x0.997 |
| blake3-servil-mt / solo / ManyMessages / 6 | 119.820 | 122.609 | x1.023 | level | 2 of 4 | - | - | x1.018 | x1.010 | x0.995 |
| blake3-servil-mt / solo / ManyMessages / 8 | 163.341 | 165.866 | x1.015 | level | 2 of 4 | - | - | x1.018 | x1.008 | x1.012 |
| blake3-servil-mt / solo / ManyMessages / 12 | 119.263 | 113.973 | x0.956 | level | 2 of 4 | - | - | x0.971 | x1.005 | x0.987 |
| blake3-servil-mt / solo / ManyMessages / 16 | 103.171 | 100.764 | x0.977 | level | 2 of 4 | - | - | x0.993 | x1.009 | x1.001 |
| blake3-servil-mt / solo / ManyMessages / 24 | 96.712 | 99.986 | x1.034 | level | 1 of 4 | - | - | x1.038 | x1.000 | x1.005 |
| blake3-servil-mt / solo / ManyMessages / 32 | 46.142 | 47.890 | x1.038 | level | 1 of 4 | - | - | x1.060 | x1.004 | x0.999 |
| blake3-servil-mt / solo / ManyMessages / 48 | 33.726 | 33.905 | x1.005 | level | 1 of 4 | - | - | x1.025 | x0.998 | x0.987 |
| blake3-servil-mt / solo / ManyMessages / 64 | 27.927 | 28.666 | x1.026 | level | 1 of 4 | - | - | x1.017 | x1.003 | x0.993 |
| blake3-servil-mt / solo / ManyMessages / 128 | 18.378 | 18.508 | x1.007 | level | 2 of 4 | - | - | x1.017 | x1.000 | x0.985 |
| blake3-servil-mt / solo / ManyMessages / 256 | 13.430 | 13.581 | x1.011 | level | 1 of 4 | - | - | x1.024 | x1.001 | x0.965 |
| blake3-servil-mt / solo / ManyMessages / 512 | 11.041 | 11.294 | x1.023 | level | 1 of 4 | - | - | x1.020 | x1.000 | x0.926 |
| blake3-servil-mt / solo / ManyMessages / 1024 | 9.631 | 9.748 | x1.012 | level | 2 of 4 | - | - | x1.021 | x1.000 | x0.949 |
| blake3-servil-mt / solo / ManyMessages / 2048 | 9.062 | 9.053 | x0.999 | level | 1 of 4 | - | - | x1.005 | x1.000 | x0.933 |
| blake3-servil-mt / solo / ManyMessages / 4096 | 8.869 | 8.780 | x0.990 | level | 4 of 4 | - | - | x0.992 | x1.000 | x0.905 |
| blake3-servil-mt / solo / ManyMessages / 8192 | 3.732 | 3.854 | x1.033 | level | 1 of 4 | - | - | x1.046 | x1.028 | x0.980 |
| blake3-servil-mt / solo / ManyMessages / 16384 | 3.069 | 3.086 | x1.006 | level | 2 of 4 | - | - | x1.007 | x0.989 | x0.974 |
| blake3-servil-mt / solo / ManyMessages / 32768 | 2.699 | 2.776 | x1.028 | level | 0 of 4 | - | - | x1.031 | x1.003 | x1.012 |
| blake3-servil-mt / solo / ManyMessages / 65536 | 2.632 | 2.933 | x1.114 | level | 2 of 4 | - | - | x1.114 | x0.955 | x1.087 |
| blake3-servil-mt / solo / ManyMessages / 131072 | 4.469 | 4.632 | x1.036 | level | 0 of 4 | - | - | x1.026 | x1.005 | x1.025 |
| blake3-servil-mt / solo / ManyMessages / 262144 | 4.639 | 4.653 | x1.003 | level | 1 of 4 | - | - | x1.004 | x1.008 | x1.009 |
| blake3-servil-mt / solo / ManyLongMessages / 4 | 1870.109 | 1871.927 | x1.001 | level | 3 of 4 | - | - | x1.008 | x1.000 | x0.970 |
| blake3-servil-mt / solo / ManyLongMessages / 16 | 1644.311 | 686.365 | x0.417 | faster | 4 of 4 | - | - | x0.425 | x0.577 | x1.319 |
| blake3-servil-mt / solo / ManyLongMessages / 64 | 574.342 | 561.891 | x0.978 | level | 4 of 4 | - | - | x0.979 | x1.000 | x0.917 |
| blake3-servil-mt / solo / ManyLongMessages / 256 | 311.901 | 292.134 | x0.937 | level | 3 of 4 | - | - | x0.938 | x0.911 | x1.033 |
| blake3-servil-mt / solo / IdleOneMessage / 64 B | 3.041 | 3.075 | x1.011 | level | 0 of 4 | - | - | x0.998 | x1.007 | x0.999 |
| blake3-servil-mt / solo / IdleOneMessage / 128 B | 2.121 | 2.175 | x1.026 | level | 1 of 4 | - | - | x1.001 | x1.005 | x1.580 |
| blake3-servil-mt / solo / IdleOneMessage / 256 B | 1.749 | 1.754 | x1.003 | level | 2 of 4 | - | - | x0.999 | x1.003 | x2.246 |
| blake3-servil-mt / solo / IdleOneMessage / 512 B | 1.621 | 1.601 | x0.988 | level | 2 of 4 | - | - | x0.998 | x1.002 | x0.348 |
| blake3-servil-mt / solo / IdleOneMessage / 1 KiB | 1.552 | 1.544 | x0.995 | level | 2 of 4 | - | - | x0.999 | x1.001 | x0.822 |
| blake3-servil-mt / solo / IdleOneMessage / 1536 B | 1.156 | 1.180 | x1.021 | level | 1 of 4 | - | - | x0.997 | x0.998 | x0.517 |
| blake3-servil-mt / solo / IdleOneMessage / 2 KiB | 0.846 | 0.871 | x1.030 | level | 0 of 4 | - | - | x0.999 | x1.001 | x0.880 |
| blake3-servil-mt / solo / IdleOneMessage / 2304 B | 0.958 | 0.967 | x1.010 | level | 1 of 4 | - | - | x0.997 | x1.001 | x1.079 |
| blake3-servil-mt / solo / IdleOneMessage / 3 KiB | 0.624 | 0.625 | x1.002 | level | 2 of 4 | - | - | x1.005 | x1.001 | x5.413 |
| blake3-servil-mt / solo / IdleOneMessage / 3839 B | 0.514 | 0.509 | x0.992 | level | 3 of 4 | - | - | x1.004 | x1.001 | x2.115 |
| blake3-servil-mt / solo / IdleOneMessage / 4 KiB | 0.476 | 0.465 | x0.977 | level | 4 of 4 | - | - | x1.000 | x1.001 | x1.086 |
| blake3-servil-mt / solo / IdleOneMessage / 4470 B | 0.589 | 0.580 | x0.984 | level | 4 of 4 | - | - | x1.005 | x1.001 | x1.008 |
| blake3-servil-mt / solo / IdleOneMessage / 7935 B | 0.296 | 0.296 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.850 |
| blake3-servil-mt / solo / IdleOneMessage / 8 KiB | 0.273 | 0.270 | x0.988 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.808 |
| blake3-servil-mt / solo / IdleOneMessage / 16 KiB | 0.154 | 0.153 | x0.994 | level | 2 of 4 | - | - | x1.003 | x1.001 | x2.092 |
| blake3-servil-mt / solo / IdleOneMessage / 32 KiB | 0.108 | 0.107 | x0.985 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.008 |
| blake3-servil-mt / solo / IdleOneMessage / 64 KiB | 0.0983 | 0.0981 | x0.997 | level | 1 of 4 | - | - | x0.997 | x1.000 | x0.586 |
| blake3-servil-mt / solo / IdleOneMessage / 128 KiB | 0.0940 | 0.0935 | x0.995 | level | 2 of 4 | - | - | x0.986 | x1.000 | x0.119 |
| blake3-servil-mt / solo / IdleOneMessage / 256 KiB | 0.0908 | 0.0927 | x1.021 | level | 1 of 4 | - | - | x0.996 | x1.000 | x1.130 |
| blake3-servil-mt / solo / IdleOneMessage / 512 KiB | 0.0629 | 0.0644 | x1.024 | level | 2 of 4 | - | - | x0.999 | x0.991 | x0.926 |
| blake3-servil-mt / solo / IdleOneMessage / 1 MiB | 0.0578 | 0.0577 | x0.999 | level | 1 of 4 | - | - | x0.980 | x0.952 | x0.981 |
| blake3-servil-mt / solo / IdleOneMessage / 2 MiB | 0.0525 | 0.0554 | x1.055 | level | 1 of 4 | - | - | x1.048 | x0.973 | x0.989 |
| blake3-servil-mt / solo / IdleOneMessage / 3 MiB | 0.0504 | 0.0544 | x1.079 | level | 1 of 4 | - | - | x1.078 | x0.980 | x0.996 |
| blake3-servil-mt / solo / IdleOneMessage / 4 MiB | 0.0678 | 0.0670 | x0.988 | level | 2 of 4 | - | - | x0.988 | x1.020 | x0.996 |
| blake3-servil-mt / solo / IdleOneMessage / 8 MiB | 0.0664 | 0.0665 | x1.002 | level | 2 of 4 | - | - | x1.001 | x1.001 | x1.006 |
| blake3-servil-mt / solo / IdleOneMessage / 32 MiB | 0.0327 | 0.0327 | x0.999 | level | 2 of 4 | - | - | x1.000 | x0.999 | x0.999 |
| blake3-servil-mt / solo / IdleOneMessage / 64 MiB | 0.0341 | 0.0342 | x1.004 | level | 0 of 4 | - | - | x1.004 | x1.003 | x0.981 |
| blake3-servil-mt / solo / IdleOneMessage / 128 MiB | 0.0337 | 0.0335 | x0.994 | level | 3 of 4 | - | - | x0.994 | x0.987 | x1.003 |
| blake3-servil-mt / solo / IdleManyMessages / 1 | 206.310 | 207.604 | x1.006 | level | 2 of 4 | - | - | x1.000 | x1.007 | x0.750 |
| blake3-servil-mt / solo / IdleManyMessages / 2 | 106.044 | 108.817 | x1.026 | level | 1 of 4 | - | - | x0.997 | x1.003 | x2.626 |
| blake3-servil-mt / solo / IdleManyMessages / 3 | 92.115 | 93.505 | x1.015 | level | 1 of 4 | - | - | x0.997 | x1.002 | x1.156 |
| blake3-servil-mt / solo / IdleManyMessages / 4 | 54.495 | 54.750 | x1.005 | level | 2 of 4 | - | - | x0.990 | x1.003 | x0.140 |
| blake3-servil-mt / solo / IdleManyMessages / 6 | 50.973 | 52.694 | x1.034 | level | 1 of 4 | - | - | x1.006 | x1.003 | x3.222 |
| blake3-servil-mt / solo / IdleManyMessages / 8 | 34.294 | 33.668 | x0.982 | level | 3 of 4 | - | - | x0.996 | x1.002 | x0.796 |
| blake3-servil-mt / solo / IdleManyMessages / 12 | 31.430 | 31.450 | x1.001 | level | 3 of 4 | - | - | x1.005 | x1.002 | x0.714 |
| blake3-servil-mt / solo / IdleManyMessages / 16 | 18.063 | 18.613 | x1.030 | level | 0 of 4 | - | - | x0.996 | x1.002 | x0.688 |
| blake3-servil-mt / solo / IdleManyMessages / 24 | 17.109 | 17.480 | x1.022 | level | 2 of 4 | - | - | x1.024 | x1.002 | x6.326 |
| blake3-servil-mt / solo / IdleManyMessages / 32 | 13.126 | 13.097 | x0.998 | level | 1 of 4 | - | - | x0.999 | x1.001 | x1.001 |
| blake3-servil-mt / solo / IdleManyMessages / 48 | 11.426 | 11.347 | x0.993 | level | 3 of 4 | - | - | x1.003 | x1.001 | x0.725 |
| blake3-servil-mt / solo / IdleManyMessages / 64 | 10.555 | 10.453 | x0.990 | level | 2 of 4 | - | - | x0.988 | x1.001 | x0.109 |
| blake3-servil-mt / solo / IdleManyMessages / 128 | 9.176 | 9.345 | x1.018 | level | 1 of 4 | - | - | x1.001 | x1.001 | x0.772 |
| blake3-servil-mt / solo / IdleManyMessages / 256 | 8.689 | 8.876 | x1.022 | level | 1 of 4 | - | - | x1.010 | x1.000 | x2.751 |
| blake3-servil-mt / solo / IdleManyMessages / 512 | 8.552 | 8.406 | x0.983 | level | 3 of 4 | - | - | x1.003 | x1.000 | x1.327 |
| blake3-servil-mt / solo / IdleManyMessages / 1024 | 8.157 | 8.135 | x0.997 | level | 3 of 4 | - | - | x1.007 | x1.000 | x0.964 |
| blake3-servil-mt / solo / IdleManyMessages / 2048 | 8.066 | 7.922 | x0.982 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.463 |
| blake3-servil-mt / solo / IdleManyMessages / 4096 | 8.107 | 7.937 | x0.979 | level | 4 of 4 | - | - | x0.995 | x1.000 | x0.917 |
| blake3-servil-mt / solo / IdleManyMessages / 8192 | 3.557 | 3.587 | x1.009 | level | 1 of 4 | - | - | x1.012 | x0.973 | x0.985 |
| blake3-servil-mt / solo / IdleManyMessages / 16384 | 3.363 | 3.280 | x0.976 | level | 3 of 4 | - | - | x0.980 | x0.995 | x0.966 |
| blake3-servil-mt / solo / IdleManyMessages / 32768 | 2.827 | 2.787 | x0.986 | level | 4 of 4 | - | - | x0.985 | x0.988 | x0.972 |
| blake3-servil-mt / solo / IdleManyMessages / 65536 | 2.609 | 2.501 | x0.958 | level | 2 of 4 | - | - | x0.958 | x1.016 | x0.947 |
| blake3-servil-mt / solo / IdleManyMessages / 131072 | 3.994 | 4.141 | x1.037 | level | 0 of 4 | - | - | x1.036 | x0.995 | x0.973 |
| blake3-servil-mt / solo / IdleManyMessages / 262144 | 4.209 | 4.198 | x0.997 | level | 1 of 4 | - | - | x0.998 | x1.012 | x0.975 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 B | 3.247 | 3.196 | x0.984 | level | 3 of 4 | - | - | x0.988 | x1.007 | x1.176 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 B | 2.145 | 2.113 | x0.985 | level | 2 of 4 | - | - | x0.999 | x1.005 | x1.114 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 B | 1.697 | 1.699 | x1.001 | level | 0 of 4 | - | - | x1.001 | x1.004 | x2.601 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 B | 1.460 | 1.475 | x1.011 | level | 1 of 4 | - | - | x1.003 | x1.002 | x1.448 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 KiB | 1.348 | 1.349 | x1.000 | level | 2 of 4 | - | - | x0.999 | x1.001 | x1.445 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1536 B | 1.014 | 1.012 | x0.998 | level | 3 of 4 | - | - | x0.997 | x0.998 | x0.816 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 KiB | 0.731 | 0.731 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.001 | x1.306 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2304 B | 0.818 | 0.814 | x0.995 | level | 3 of 4 | - | - | x0.995 | x1.001 | x2.378 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 KiB | 0.524 | 0.524 | x0.999 | level | 3 of 4 | - | - | x0.998 | x1.001 | x0.463 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3839 B | 0.426 | 0.430 | x1.008 | level | 1 of 4 | - | - | x1.003 | x1.001 | x0.828 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 KiB | 0.390 | 0.390 | x1.000 | level | 2 of 4 | - | - | x0.999 | x1.001 | x1.550 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4470 B | 0.482 | 0.482 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.001 | x0.838 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 7935 B | 0.241 | 0.241 | x1.000 | level | 2 of 4 | - | - | x1.002 | x1.000 | x2.169 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 KiB | 0.224 | 0.225 | x1.005 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.582 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 16 KiB | 0.126 | 0.127 | x1.007 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.081 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 KiB | 0.0883 | 0.0884 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.210 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 KiB | 0.0822 | 0.0815 | x0.991 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.757 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 KiB | 0.0781 | 0.0779 | x0.997 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.707 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 KiB | 0.0779 | 0.0778 | x0.998 | level | 2 of 4 | - | - | x0.995 | x1.000 | x1.142 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 KiB | 0.0574 | 0.0577 | x1.005 | level | 2 of 4 | - | - | x1.003 | x0.983 | x0.939 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 MiB | 0.0494 | 0.0474 | x0.961 | level | 4 of 4 | - | - | x0.959 | x0.942 | x0.984 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 MiB | 0.0469 | 0.0577 | x1.230 | level | 1 of 4 | - | - | x1.226 | x0.893 | x1.012 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 MiB | 0.0480 | 0.0585 | x1.219 | level | 1 of 4 | - | - | x1.216 | x0.910 | x1.001 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 MiB | 0.0630 | 0.0586 | x0.930 | level | 4 of 4 | - | - | x0.929 | x1.040 | x0.972 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 MiB | 0.0676 | 0.0677 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.007 | x0.990 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 MiB | 0.0318 | 0.0317 | x0.997 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.984 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 MiB | 0.0334 | 0.0334 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.976 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 MiB | 0.0334 | 0.0332 | x0.994 | level | 3 of 4 | - | - | x0.994 | x0.988 | x0.990 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1 | 205.703 | 208.977 | x1.016 | level | 1 of 4 | - | - | x1.000 | x1.008 | x1.028 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2 | 104.551 | 104.630 | x1.001 | level | 2 of 4 | - | - | x0.997 | x1.003 | x1.761 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 3 | 90.525 | 91.734 | x1.013 | level | 2 of 4 | - | - | x1.000 | x1.002 | x1.545 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4 | 52.711 | 52.927 | x1.004 | level | 1 of 4 | - | - | x0.999 | x1.003 | x0.419 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 6 | 46.023 | 46.050 | x1.001 | level | 2 of 4 | - | - | x0.998 | x1.003 | x0.707 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8 | 28.951 | 28.678 | x0.991 | level | 2 of 4 | - | - | x0.990 | x1.002 | x0.583 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 12 | 26.183 | 26.073 | x0.996 | level | 2 of 4 | - | - | x0.993 | x1.002 | x1.199 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16 | 14.969 | 14.805 | x0.989 | level | 2 of 4 | - | - | x0.998 | x1.002 | x0.792 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 24 | 13.913 | 13.926 | x1.001 | level | 2 of 4 | - | - | x0.992 | x1.002 | x2.205 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32 | 10.537 | 10.562 | x1.002 | level | 1 of 4 | - | - | x0.997 | x1.001 | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 48 | 9.173 | 9.166 | x0.999 | level | 2 of 4 | - | - | x0.998 | x1.001 | x0.302 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 64 | 8.457 | 8.516 | x1.007 | level | 1 of 4 | - | - | x0.998 | x1.001 | x0.490 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 128 | 7.459 | 7.537 | x1.010 | level | 1 of 4 | - | - | x1.003 | x1.001 | x1.217 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 256 | 7.043 | 7.106 | x1.009 | level | 0 of 4 | - | - | x1.004 | x1.000 | x0.771 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 512 | 6.819 | 6.821 | x1.000 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.214 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1024 | 6.665 | 6.710 | x1.007 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.381 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2048 | 6.652 | 6.632 | x0.997 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.353 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4096 | 6.748 | 6.732 | x0.998 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.837 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8192 | 3.262 | 3.185 | x0.976 | level | 2 of 4 | - | - | x0.967 | x0.977 | x0.996 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16384 | 2.869 | 2.833 | x0.987 | level | 3 of 4 | - | - | x0.980 | x0.986 | x0.974 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32768 | 2.639 | 2.591 | x0.982 | level | 3 of 4 | - | - | x0.978 | x0.994 | x0.963 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 65536 | 2.402 | 2.818 | x1.173 | level | 0 of 4 | - | - | x1.174 | x0.962 | x1.030 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 131072 | 4.188 | 4.205 | x1.004 | level | 2 of 4 | - | - | x1.004 | x1.019 | x0.975 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 262144 | 4.238 | 4.210 | x0.993 | level | 3 of 4 | - | - | x0.993 | x1.023 | x0.965 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.448 | 0.410 | x0.915 | level | 4 of 4 | x0.830 | - | x0.918 | x0.974 | x1.082 |
| blake3-servil-mt / solo / ContinuousMessages / 128 B | 0.243 | 0.220 | x0.902 | level | 4 of 4 | x0.846 | - | x0.911 | x0.974 | x1.300 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.123 | 0.117 | x0.950 | level | 4 of 4 | x0.921 | - | x0.952 | x0.975 | x1.141 |
| blake3-servil-mt / solo / ContinuousMessages / 512 B | 0.0714 | 0.0626 | x0.876 | level | 4 of 4 | x0.808 | - | x0.879 | x0.977 | x1.206 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.0548 | 0.0507 | x0.924 | level | 3 of 4 | x0.802 | - | x0.936 | x0.986 | x1.091 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0449 | 0.0440 | x0.980 | level | 2 of 4 | x0.978 | - | x0.982 | x0.997 | x1.008 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0365 | 0.0359 | x0.983 | level | 3 of 4 | x0.727 | - | x0.988 | x1.017 | x0.992 |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.0329 | 0.0330 | x1.003 | level | 1 of 4 | x0.996 | - | x1.002 | x1.021 | x0.905 |
| blake3-servil-mt / solo / ContinuousMessages / 256 KiB | 0.0331 | 0.0336 | x1.014 | level | 2 of 4 | x1.005 | - | x1.014 | x1.017 | x1.035 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0296 | 0.0296 | x1.002 | level | 2 of 4 | x0.998 | - | x1.001 | x1.016 | x1.004 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.0313 | 0.0308 | x0.984 | level | 1 of 4 | x0.989 | - | x0.984 | x1.016 | x1.009 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0321 | 0.0317 | x0.989 | level | 2 of 4 | x0.984 | - | x0.988 | x1.016 | x1.004 |
| blake3-servil-mt / solo / ContinuousMessages / 64 MiB | 0.0342 | 0.0343 | x1.004 | level | 2 of 4 | x0.983 | - | x1.005 | x1.016 | x0.998 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 3.693 | 3.662 | x0.991 | level | 2 of 4 | x1.019 | - | x0.992 | x0.973 | x1.053 |
| blake3-servil-mt / solo / ContinuousBatches / 64 | 2.323 | 2.325 | x1.001 | level | 2 of 4 | x1.011 | - | x1.000 | x0.986 | x1.001 |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 2.642 | 2.622 | x0.992 | level | 2 of 4 | x1.064 | - | x0.990 | x0.995 | x0.964 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 2.463 | 2.392 | x0.971 | level | 3 of 4 | x0.999 | - | x0.995 | x0.981 | x0.961 |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 2.640 | 2.466 | x0.934 | level | 4 of 4 | x1.036 | - | x0.939 | x0.992 | x1.077 |
| blake3-servil-mt / solo / ContinuousBatches / 16384 | 2.589 | 2.524 | x0.975 | level | 4 of 4 | x0.994 | - | x0.982 | x1.003 | x1.019 |
| blake3-servil-mt / solo / ContinuousBatches / 65536 | 3.006 | 3.123 | x1.039 | level | 1 of 4 | x1.063 | - | x1.039 | x0.993 | x1.043 |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.941 | 0.941 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x2.235 |
| blake3-servil-mt / solo / LentMessages / 128 B | 1.077 | 1.078 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x2.228 |
| blake3-servil-mt / solo / LentMessages / 256 B | 1.150 | 1.151 | x1.001 | level | 0 of 4 | x1.001 | - | x1.000 | x1.000 | x0.548 |
| blake3-servil-mt / solo / LentMessages / 512 B | 1.188 | 1.207 | x1.016 | level | 1 of 4 | x1.016 | - | x1.000 | x1.000 | x0.988 |
| blake3-servil-mt / solo / LentMessages / 1 KiB | 1.211 | 1.212 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | x1.095 |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.358 | 0.358 | x0.999 | level | 4 of 4 | x1.000 | - | x1.000 | x1.000 | x0.769 |
| blake3-servil-mt / solo / LentMessages / 16 KiB | 0.114 | 0.114 | x0.999 | level | 1 of 4 | x1.000 | - | x0.999 | x1.000 | x0.830 |
| blake3-servil-mt / solo / LentMessages / 64 KiB | 0.0808 | 0.0809 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | x0.396 |
| blake3-servil-mt / solo / LentMessages / 256 KiB | 0.0759 | 0.0759 | x1.000 | level | 2 of 4 | x1.000 | - | x1.001 | x1.000 | x3.120 |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.0456 | 0.0457 | x1.002 | level | 2 of 4 | x0.983 | - | x1.005 | x1.023 | x1.002 |
| blake3-servil-mt / solo / LentMessages / 4 MiB | 0.0397 | 0.0394 | x0.992 | level | 2 of 4 | x0.977 | - | x1.011 | x1.003 | x0.945 |
| blake3-servil-mt / solo / LentMessages / 16 MiB | 0.0341 | 0.0339 | x0.994 | level | 2 of 4 | x0.995 | - | x0.998 | x1.008 | x0.998 |
| blake3-servil-mt / solo / LentMessages / 64 MiB | 0.0340 | 0.0339 | x0.997 | level | 3 of 4 | x1.002 | - | x0.997 | x0.997 | x0.982 |
| blake3-servil-mt / solo / Interleaved / 256 | 0.137 | 0.137 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x0.999 | x0.992 |
| blake3-servil-mt / solo / Collection / git objects | 0.00832 | 0.00829 | x0.997 | level | 3 of 4 | x0.995 | - | x1.004 | x1.013 | x1.038 |
| blake3-servil-mt / solo / Collection / Nix files | 0.0112 | 0.0112 | x1.003 | level | 1 of 4 | x1.006 | - | x1.000 | x1.000 | x1.006 |
| blake3-servil-mt / solo / LentBatches / 16 | 7.548 | 7.571 | x1.003 | level | 1 of 4 | x1.002 | - | x1.001 | x0.998 | x0.121 |
| blake3-servil-mt / solo / LentBatches / 64 | 6.629 | 6.633 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x0.999 | - |
| blake3-servil-mt / solo / LentBatches / 256 | 6.611 | 6.594 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x1.000 | x78.137 |
| blake3-servil-mt / solo / LentBatches / 1024 | 7.059 | 7.045 | x0.998 | level | 2 of 4 | x0.998 | - | x0.998 | x1.000 | x0.169 |
| blake3-servil-mt / solo / LentBatches / 4096 | 6.894 | 6.846 | x0.993 | level | 3 of 4 | x0.993 | - | x0.994 | x1.000 | x1.332 |
| blake3-servil-mt / solo / LentBatches / 16384 | 3.193 | 3.223 | x1.010 | level | 1 of 4 | x0.979 | - | x1.011 | x1.006 | x1.000 |
| blake3-servil-mt / solo / LentBatches / 65536 | 2.839 | 2.859 | x1.007 | level | 1 of 4 | x1.005 | - | x1.006 | x1.000 | x0.989 |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.0387 | 0.0390 | x1.009 | level | 2 of 4 | x0.982 | - | x1.009 | x1.008 | x0.986 |
| blake3-servil-mt / solo / ContinuousCollection / Nix files | 0.0398 | 0.0375 | x0.943 | level | 4 of 4 | x1.000 | - | x0.942 | x1.006 | x0.979 |
| blake3-servil-mt / solo / MerkleTree / 1024 | 0.124 | 0.123 | x0.997 | level | 3 of 4 | x0.997 | - | x0.996 | x1.001 | x0.225 |
| blake3-servil-mt / solo / MerkleTree / 4096 | 0.0705 | 0.0712 | x1.010 | level | 2 of 4 | x1.022 | - | x1.011 | x1.003 | x1.020 |
| blake3-servil-mt / solo / MerkleTree / 16384 | 0.0695 | 0.0655 | x0.942 | level | 3 of 4 | x0.908 | - | x0.942 | x1.007 | x0.940 |
| blake3-servil-mt / solo / MerkleTree / 65536 | 0.0759 | 0.0779 | x1.026 | level | 2 of 4 | x1.026 | - | x1.026 | x0.973 | x1.039 |
| blake3-servil-mt / solo / MerkleTree / 262144 | 0.0490 | 0.0495 | x1.010 | level | 2 of 4 | x0.998 | - | x1.010 | x0.991 | x1.027 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 32 B | 0.0947 | 0.0919 | x0.971 | level | 2 of 4 | x1.007 | - | x0.974 | x0.993 | x0.963 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 32 B | 0.0613 | 0.0614 | x1.001 | level | 1 of 4 | x0.994 | - | x1.002 | x0.992 | x1.024 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 16 B | 0.131 | 0.136 | x1.037 | level | 1 of 4 | x1.012 | - | x1.039 | x1.099 | x0.868 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 48 B | 0.0692 | 0.0710 | x1.025 | level | 1 of 4 | x1.135 | - | x1.024 | x0.993 | x0.969 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 48 B | 0.0523 | 0.0539 | x1.031 | level | 2 of 4 | x1.000 | - | x1.031 | x1.033 | x0.994 |
| blake3-servil-mt / solo / InterleavedTurn / 256 | 0.291 | 0.294 | x1.009 | level | 1 of 4 | - | - | x0.995 | x0.908 | x0.989 |
| blake3-servil-mt / solo / InterleavedTurn / 1024 x 1 KiB | 0.148 | 0.147 | x0.993 | level | 3 of 4 | - | - | x0.992 | x0.994 | x0.986 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 256 | 0.183 | 0.192 | x1.046 | level | 1 of 4 | - | - | x1.038 | x0.930 | x0.971 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.148 | 0.139 | x0.944 | level | 4 of 4 | - | - | x0.947 | x0.984 | x0.987 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 256 | 0.213 | 0.221 | x1.037 | level | 1 of 4 | - | - | x1.024 | x0.904 | x0.970 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.140 | 0.138 | x0.984 | level | 3 of 4 | - | - | x0.989 | x0.993 | x1.048 |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.0355 | 0.0345 | x0.972 | level | 4 of 4 | x0.990 | - | x0.973 | x1.013 | x1.023 |
| blake3-servil-mt / solo / ReceivingMessage / 2 μs | 0.0920 | 0.0920 | x1.000 | level | 1 of 4 | x0.977 | - | x1.011 | x1.014 | x0.993 |
| blake3-servil-mt / solo / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 4 of 4 | x1.188 | - | x1.003 | x1.015 | x0.951 |
| blake3-servil-mt / solo / IncrementalMessage / 64 B | 7.107 | 7.097 | x0.999 | level | 2 of 4 | - | - | x0.992 | x1.002 | x1.062 |
| blake3-servil-mt / solo / IncrementalMessage / 1 KiB | 1.844 | 1.835 | x0.995 | level | 2 of 4 | - | - | x0.994 | x0.998 | x1.047 |
| blake3-servil-mt / solo / IncrementalMessage / 4 KiB | 0.624 | 0.617 | x0.988 | level | 2 of 4 | - | - | x0.993 | x1.001 | x0.985 |
| blake3-servil-mt / solo / LentIncrementalMessage / 64 B | 0.948 | 0.947 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.126 |
| blake3-servil-mt / solo / LentIncrementalMessage / 1 KiB | 1.243 | 1.244 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.390 |
| blake3-servil-mt / solo / LentIncrementalMessage / 4 KiB | 0.364 | 0.365 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | x0.115 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 5.676 | 5.289 | x0.932 | level | 2 of 4 | x0.906 | - | x0.930 | x0.995 | x1.115 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 4 KiB | 0.0986 | 0.0788 | x0.800 | level | 3 of 4 | x0.789 | - | x0.799 | x1.011 | x1.013 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 1 MiB | 0.0298 | 0.0303 | x1.018 | level | 2 of 4 | x1.025 | - | x1.017 | x1.016 | x0.998 |
| blake3-servil-mt / solo / ContinuousLentMessages / 64 B | 0.368 | 0.353 | x0.961 | level | 4 of 4 | x0.665 | - | x0.964 | x0.971 | x1.116 |
| blake3-servil-mt / solo / ContinuousLentMessages / 4 KiB | 0.0349 | 0.0356 | x1.020 | level | 1 of 4 | x1.015 | - | x1.018 | x0.998 | x1.055 |
| blake3-servil-mt / solo / ContinuousLentMessages / 1 MiB | 0.00347 | 0.00348 | x1.005 | level | 0 of 4 | x1.002 | - | x1.004 | x1.007 | x1.036 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.415 | 0.402 | x0.969 | level | 4 of 4 | - | - | x0.969 | x0.974 | x0.974 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 128 B | 0.221 | 0.216 | x0.978 | level | 4 of 4 | - | - | x0.978 | x0.974 | x0.998 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.120 | 0.116 | x0.969 | level | 3 of 4 | - | - | x0.969 | x0.975 | x0.986 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 512 B | 0.0745 | 0.0770 | x1.033 | level | 1 of 4 | - | - | x1.026 | x0.977 | x1.006 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.0586 | 0.0620 | x1.058 | level | 0 of 4 | - | - | x1.058 | x0.985 | x0.965 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.0981 | 0.0871 | x0.888 | level | 4 of 4 | - | - | x0.979 | x0.980 | x0.960 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.0505 | 0.0448 | x0.888 | level | 3 of 4 | - | - | x0.892 | x1.010 | x1.012 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.0398 | 0.0395 | x0.994 | level | 3 of 4 | - | - | x0.994 | x1.021 | x0.981 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 KiB | 0.0375 | 0.0380 | x1.014 | level | 1 of 4 | - | - | x1.017 | x1.017 | x1.044 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0386 | 0.0388 | x1.005 | level | 2 of 4 | - | - | x1.006 | x1.016 | x1.010 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.0399 | 0.0402 | x1.008 | level | 1 of 4 | - | - | x1.010 | x1.016 | x1.016 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.0474 | 0.0466 | x0.983 | level | 3 of 4 | - | - | x0.984 | x1.016 | x1.030 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 MiB | 0.0517 | 0.0525 | x1.015 | level | 1 of 4 | - | - | x1.014 | x1.016 | x1.006 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 4.155 | 4.247 | x1.022 | level | 1 of 4 | - | - | x1.012 | x0.973 | x0.985 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 64 | 3.099 | 3.026 | x0.976 | level | 3 of 4 | - | - | x0.975 | x0.986 | x1.020 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 256 | 3.118 | 3.093 | x0.992 | level | 3 of 4 | - | - | x0.988 | x0.996 | x0.984 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 2.905 | 2.908 | x1.001 | level | 2 of 4 | - | - | x0.995 | x0.983 | x0.960 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 4096 | 3.281 | 3.222 | x0.982 | level | 3 of 4 | - | - | x0.966 | x0.980 | x0.984 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16384 | 2.805 | 2.852 | x1.017 | level | 2 of 4 | - | - | x1.020 | x1.005 | x0.983 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 65536 | 3.451 | 2.998 | x0.869 | level | 4 of 4 | - | - | x0.858 | x1.034 | x0.870 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.940 | 0.940 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.889 |
| blake3-servil-mt / shared-one-cache / LentMessages / 128 B | 1.077 | 1.078 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.921 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 B | 1.151 | 1.151 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.965 |
| blake3-servil-mt / shared-one-cache / LentMessages / 512 B | 1.188 | 1.189 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.514 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 KiB | 1.212 | 1.212 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.099 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.358 | 0.358 | x0.999 | level | 4 of 4 | - | - | x0.999 | x1.000 | x1.389 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 KiB | 0.114 | 0.114 | x0.997 | level | 4 of 4 | - | - | x0.997 | x1.000 | x1.174 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 KiB | 0.0813 | 0.0813 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.008 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 KiB | 0.0762 | 0.0760 | x0.998 | level | 4 of 4 | - | - | x0.998 | x1.000 | x1.719 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 MiB | 0.0539 | 0.0538 | x0.998 | level | 2 of 4 | - | - | x1.000 | x0.985 | x1.005 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 MiB | 0.0463 | 0.0432 | x0.933 | level | 3 of 4 | - | - | x0.934 | x0.993 | x0.973 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 MiB | 0.0552 | 0.0567 | x1.027 | level | 1 of 4 | - | - | x1.022 | x1.041 | x0.938 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 MiB | 0.0498 | 0.0506 | x1.016 | level | 1 of 4 | - | - | x1.013 | x1.022 | x1.022 |
| blake3-servil-mt / shared-one-cache / Interleaved / 256 | 0.137 | 0.137 | x1.004 | level | 0 of 4 | - | - | x1.004 | x1.000 | x1.023 |
| blake3-servil-mt / shared-one-cache / Collection / git objects | 0.0158 | 0.0158 | x1.000 | level | 3 of 4 | - | - | x1.024 | x1.017 | x1.004 |
| blake3-servil-mt / shared-one-cache / Collection / Nix files | 0.0176 | 0.0175 | x0.993 | level | 3 of 4 | - | - | x0.996 | x1.009 | x1.003 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16 | 7.551 | 7.552 | x1.000 | level | 2 of 4 | - | - | x1.000 | x0.998 | x0.950 |
| blake3-servil-mt / shared-one-cache / LentBatches / 64 | 6.647 | 6.655 | x1.001 | level | 1 of 4 | - | - | x1.001 | x0.999 | x0.826 |
| blake3-servil-mt / shared-one-cache / LentBatches / 256 | 6.567 | 6.572 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.193 |
| blake3-servil-mt / shared-one-cache / LentBatches / 1024 | 7.041 | 7.045 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.809 |
| blake3-servil-mt / shared-one-cache / LentBatches / 4096 | 6.837 | 6.839 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.608 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16384 | 3.718 | 3.646 | x0.981 | level | 1 of 4 | - | - | x0.978 | x0.971 | x1.000 |
| blake3-servil-mt / shared-one-cache / LentBatches / 65536 | 3.431 | 3.568 | x1.040 | level | 1 of 4 | - | - | x1.045 | x0.972 | x1.103 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.0592 | 0.0595 | x1.006 | level | 1 of 4 | - | - | x1.007 | x1.009 | x1.001 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / Nix files | 0.0576 | 0.0583 | x1.012 | level | 0 of 4 | - | - | x1.017 | x1.007 | x0.996 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1024 | 0.124 | 0.124 | x1.001 | level | 3 of 4 | - | - | x1.001 | x1.001 | x0.861 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 4096 | 0.0774 | 0.0768 | x0.993 | level | 2 of 4 | - | - | x0.997 | x1.005 | x1.002 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 16384 | 0.101 | 0.102 | x1.004 | level | 2 of 4 | - | - | x1.005 | x1.003 | x0.997 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 | 0.124 | 0.123 | x0.994 | level | 3 of 4 | - | - | x0.993 | x0.994 | x1.008 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 262144 | 0.0699 | 0.0696 | x0.996 | level | 3 of 4 | - | - | x0.995 | x1.004 | x1.008 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 32 B | 0.189 | 0.190 | x1.003 | level | 2 of 4 | - | - | x1.004 | x1.004 | x0.988 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 32 B | 0.0815 | 0.0811 | x0.995 | level | 2 of 4 | - | - | x0.996 | x0.985 | x0.977 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 16 B | 0.183 | 0.189 | x1.033 | level | 1 of 4 | - | - | x1.041 | x1.085 | x1.002 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 48 B | 0.111 | 0.129 | x1.159 | level | 1 of 4 | - | - | x1.168 | x0.903 | x1.332 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 48 B | 0.0674 | 0.0675 | x1.001 | level | 3 of 4 | - | - | x1.003 | x1.000 | x0.987 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.0467 | 0.0479 | x1.026 | level | 1 of 4 | - | - | x1.028 | x1.010 | x0.975 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 2 μs | 0.0921 | 0.0921 | x1.000 | level | 2 of 4 | - | - | x1.068 | x1.010 | x0.958 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 4 of 4 | - | - | x0.908 | x1.007 | x0.755 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 64 B | 0.947 | 0.947 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.965 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 1 KiB | 1.244 | 1.244 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.971 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 4 KiB | 0.364 | 0.365 | x1.002 | level | 0 of 4 | - | - | x1.001 | x1.000 | x1.066 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 17.336 | 17.406 | x1.004 | level | 1 of 4 | - | - | x1.010 | x0.989 | x1.116 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 4 KiB | 0.281 | 0.274 | x0.977 | level | 2 of 4 | - | - | x0.865 | x0.996 | x0.985 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 1 MiB | 0.0393 | 0.0397 | x1.010 | level | 1 of 4 | - | - | x1.008 | x1.016 | x1.011 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 64 B | 0.357 | 0.349 | x0.977 | level | 4 of 4 | - | - | x0.977 | x0.971 | x0.994 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 4 KiB | 0.0756 | 0.0841 | x1.112 | level | 1 of 4 | - | - | x1.054 | x0.985 | x1.050 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 1 MiB | 0.00611 | 0.00689 | x1.129 | level | 0 of 4 | - | - | x1.122 | x1.159 | x1.211 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 B | 0.848 | 0.641 | x0.755 | level | 4 of 4 | - | - | x0.755 | x0.974 | x0.929 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 128 B | 0.467 | 0.354 | x0.759 | level | 4 of 4 | - | - | x0.759 | x0.974 | x0.955 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 256 B | 0.254 | 0.199 | x0.785 | level | 4 of 4 | - | - | x0.784 | x0.975 | x0.871 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 512 B | 0.159 | 0.128 | x0.807 | level | 4 of 4 | - | - | x0.806 | x0.977 | x0.907 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 KiB | 0.125 | 0.0981 | x0.785 | level | 4 of 4 | - | - | x0.788 | x0.985 | x0.928 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 4 KiB | 0.104 | 0.0869 | x0.837 | level | 3 of 4 | - | - | x0.814 | x1.003 | x0.956 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 16 KiB | 0.0975 | 0.0745 | x0.764 | level | 4 of 4 | - | - | x0.763 | x1.014 | x0.977 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 KiB | 0.0768 | 0.0616 | x0.802 | level | 4 of 4 | - | - | x0.805 | x1.022 | x1.002 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 256 KiB | 0.0800 | 0.0625 | x0.781 | level | 4 of 4 | - | - | x0.779 | x1.020 | x1.011 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 MiB | 0.0777 | 0.0577 | x0.743 | level | 4 of 4 | - | - | x0.747 | x1.019 | x0.987 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 4 MiB | 0.0762 | 0.0567 | x0.744 | level | 4 of 4 | - | - | x0.751 | x1.018 | x0.991 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 16 MiB | 0.0758 | 0.0573 | x0.757 | level | 4 of 4 | - | - | x0.767 | x1.020 | x1.011 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 MiB | 0.0780 | 0.0640 | x0.821 | level | 4 of 4 | - | - | x0.820 | x1.019 | x1.054 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 16 | 8.776 | 8.223 | x0.937 | level | 4 of 4 | - | - | x0.933 | x0.973 | x1.000 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 64 | 6.657 | 5.790 | x0.870 | level | 4 of 4 | - | - | x0.866 | x0.986 | x1.019 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 256 | 7.116 | 5.758 | x0.809 | level | 4 of 4 | - | - | x0.808 | x0.997 | x0.982 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 1024 | 6.005 | 4.751 | x0.791 | level | 4 of 4 | - | - | x0.791 | x0.985 | x0.944 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 4096 | 5.321 | 5.202 | x0.978 | level | 3 of 4 | - | - | x0.978 | x0.993 | x1.007 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 16384 | 4.372 | 4.419 | x1.011 | level | 1 of 4 | - | - | x1.011 | x0.996 | x0.998 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 65536 | 3.274 | 3.168 | x0.968 | level | 3 of 4 | - | - | x0.967 | x1.005 | x0.972 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 B | 0.939 | 0.939 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.043 |
| blake3-servil-mt / shared-two-caches / LentMessages / 128 B | 1.077 | 1.078 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.927 |
| blake3-servil-mt / shared-two-caches / LentMessages / 256 B | 1.151 | 1.151 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.129 |
| blake3-servil-mt / shared-two-caches / LentMessages / 512 B | 1.188 | 1.188 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.145 |
| blake3-servil-mt / shared-two-caches / LentMessages / 1 KiB | 1.211 | 1.211 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.920 |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 KiB | 0.358 | 0.358 | x1.000 | level | 4 of 4 | - | - | x0.999 | x1.000 | x1.246 |
| blake3-servil-mt / shared-two-caches / LentMessages / 16 KiB | 0.114 | 0.114 | x0.997 | level | 4 of 4 | - | - | x0.997 | x1.000 | x1.163 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 KiB | 0.0812 | 0.0812 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.773 |
| blake3-servil-mt / shared-two-caches / LentMessages / 256 KiB | 0.0772 | 0.0773 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.767 |
| blake3-servil-mt / shared-two-caches / LentMessages / 1 MiB | 0.0644 | 0.0630 | x0.978 | level | 3 of 4 | - | - | x0.977 | x0.987 | x1.003 |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 MiB | 0.0440 | 0.0422 | x0.960 | level | 2 of 4 | - | - | x0.958 | x0.997 | x1.027 |
| blake3-servil-mt / shared-two-caches / LentMessages / 16 MiB | 0.0380 | 0.0409 | x1.077 | level | 1 of 4 | - | - | x1.079 | x0.988 | x1.071 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 MiB | 0.0374 | 0.0374 | x1.001 | level | 2 of 4 | - | - | x1.002 | x0.999 | x0.994 |
| blake3-servil-mt / shared-two-caches / Interleaved / 256 | 0.137 | 0.137 | x1.003 | level | 0 of 4 | - | - | x1.002 | x0.999 | x1.010 |
| blake3-servil-mt / shared-two-caches / Collection / git objects | 0.0153 | 0.0154 | x1.005 | level | 2 of 4 | - | - | x0.982 | x0.979 | x0.982 |
| blake3-servil-mt / shared-two-caches / Collection / Nix files | 0.0173 | 0.0174 | x1.003 | level | 1 of 4 | - | - | x1.011 | x1.008 | x1.000 |
| blake3-servil-mt / shared-two-caches / LentBatches / 16 | 7.543 | 7.538 | x0.999 | level | 2 of 4 | - | - | x0.999 | x0.998 | x1.010 |
| blake3-servil-mt / shared-two-caches / LentBatches / 64 | 6.636 | 6.642 | x1.001 | level | 1 of 4 | - | - | x1.001 | x0.999 | x0.974 |
| blake3-servil-mt / shared-two-caches / LentBatches / 256 | 6.564 | 6.559 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.703 |
| blake3-servil-mt / shared-two-caches / LentBatches / 1024 | 7.031 | 7.037 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.047 |
| blake3-servil-mt / shared-two-caches / LentBatches / 4096 | 6.966 | 6.954 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.593 |
| blake3-servil-mt / shared-two-caches / LentBatches / 16384 | 4.314 | 4.200 | x0.974 | level | 3 of 4 | - | - | x0.973 | x0.992 | x1.009 |
| blake3-servil-mt / shared-two-caches / LentBatches / 65536 | 3.273 | 2.951 | x0.902 | level | 4 of 4 | - | - | x0.903 | x0.989 | x0.983 |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / git objects | 0.0761 | 0.0718 | x0.943 | level | 3 of 4 | - | - | x0.944 | x1.008 | x0.971 |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / Nix files | 0.0706 | 0.0696 | x0.987 | level | 1 of 4 | - | - | x0.986 | x1.007 | x0.996 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1024 | 0.126 | 0.126 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.001 | x0.874 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 4096 | 0.0734 | 0.0740 | x1.009 | level | 1 of 4 | - | - | x1.010 | x1.000 | x1.003 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 16384 | 0.0823 | 0.0902 | x1.097 | level | 0 of 4 | - | - | x1.097 | x0.982 | x1.110 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 | 0.0843 | 0.0831 | x0.986 | level | 3 of 4 | - | - | x0.986 | x1.004 | x0.984 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 262144 | 0.0613 | 0.0599 | x0.977 | level | 2 of 4 | - | - | x0.976 | x0.961 | x0.976 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 x 32 B | 0.177 | 0.176 | x0.991 | level | 3 of 4 | - | - | x0.993 | x1.018 | x0.993 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 32 B | 0.0797 | 0.0819 | x1.027 | level | 1 of 4 | - | - | x1.034 | x1.027 | x1.003 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 16 B | 0.158 | 0.158 | x0.999 | level | 2 of 4 | - | - | x0.999 | x0.930 | x1.009 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 x 48 B | 0.122 | 0.137 | x1.125 | level | 0 of 4 | - | - | x1.126 | x0.910 | x1.174 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 48 B | 0.0645 | 0.0639 | x0.992 | level | 3 of 4 | - | - | x0.990 | x0.995 | x0.963 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / saturated | 0.0768 | 0.0648 | x0.844 | level | 4 of 4 | - | - | x0.843 | x1.018 | x0.988 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / 2 μs | 0.101 | 0.0923 | x0.910 | level | 4 of 4 | - | - | x0.924 | x1.007 | x1.031 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 3 of 4 | - | - | x0.805 | x0.991 | x0.953 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 64 B | 0.946 | 0.946 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.960 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 1 KiB | 1.244 | 1.244 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.104 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 4 KiB | 0.364 | 0.364 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.925 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 64 B | 17.399 | 17.842 | x1.025 | level | 0 of 4 | - | - | x1.019 | x0.994 | x1.124 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 4 KiB | 0.283 | 0.258 | x0.911 | level | 4 of 4 | - | - | x0.889 | x1.004 | x0.999 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 1 MiB | 0.0815 | 0.0588 | x0.721 | faster | 4 of 4 | - | - | x0.726 | x1.020 | x0.991 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 64 B | 0.428 | 0.418 | x0.977 | level | 3 of 4 | - | - | x0.977 | x0.971 | x0.986 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 4 KiB | 0.0649 | 0.0646 | x0.996 | level | 3 of 4 | - | - | x1.016 | x0.982 | x1.033 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 1 MiB | 0.00722 | 0.00728 | x1.008 | level | 2 of 4 | - | - | x0.985 | x0.964 | x0.928 |

# Nightly drift check: e1966b498bc7 -> 87a0ab4b9f3c

- Host: electric-rhino
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
| blake3-servil-st / solo / ManyMessages / 3 | 228.762 | 229.335 | x1.003 | level | 37 of 64 | - | - | x1.005 | x0.997 | x1.001 |
| blake3-servil-st / solo / ManyMessages / 6 | 128.139 | 129.015 | x1.007 | level | 30 of 64 | - | - | x1.009 | x0.998 | x1.000 |
| blake3-servil-st / solo / ManyMessages / 8 | 200.617 | 222.629 | x1.110 | slower | 24 of 64 | - | - | x1.088 | x0.997 | x0.998 |
| blake3-servil-mt / solo / ManyMessages / 2 | 276.182 | 275.442 | x0.997 | level | 38 of 64 | - | - | x1.002 | x0.999 | x0.996 |
| blake3-servil-mt / solo / ManyMessages / 6 | 136.399 | 137.233 | x1.006 | level | 31 of 64 | - | - | x1.012 | x0.999 | x1.000 |
| blake3-servil-mt / solo / ContinuousMessages / 512 B | 0.0694 | 0.0642 | x0.924 | faster | 51 of 64 | x0.858 | - | x0.925 | x0.981 | x1.116 |
| blake3-servil-mt / solo / ContinuousMessages / 64 MiB | 0.0351 | 0.0352 | x1.003 | level | 30 of 64 | x1.007 | - | x1.003 | x1.015 | x1.001 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 32 B | 0.142 | 0.143 | x1.011 | level | 31 of 64 | x1.031 | - | x1.011 | x0.994 | x1.002 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 512 B | 0.0779 | 0.0797 | x1.024 | level | 30 of 64 | - | - | x1.021 | x0.981 | x1.010 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 MiB | 0.0525 | 0.0542 | x1.031 | level | 18 of 64 | - | - | x1.032 | x1.015 | x0.992 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 32 B | 0.182 | 0.181 | x0.993 | level | 47 of 64 | - | - | x0.993 | x0.998 | x0.998 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 512 B | 0.156 | 0.160 | x1.030 | level | 26 of 64 | - | - | x1.028 | x0.981 | x0.888 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 MiB | 0.0826 | 0.0727 | x0.880 | faster | 56 of 64 | - | - | x0.881 | x1.018 | x1.043 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 x 32 B | 0.169 | 0.168 | x0.996 | level | 40 of 64 | - | - | x0.996 | x0.995 | x0.995 |

## Stage 1 (initial screen, kept-drift)

compare: old side: bench 3f119a507807 clean; servil e1966b498bc7 clean
compare: new side: bench 3f119a507807 clean; servil 87a0ab4b9f3c clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 5.318 | 5.253 | x0.988 | level | 2 of 4 | - | - | x1.000 | x0.999 | x0.938 |
| blake3-servil-st / solo / OneMessage / 128 B | 3.424 | 3.550 | x1.037 | level | 1 of 4 | - | - | x1.007 | x1.003 | x1.006 |
| blake3-servil-st / solo / OneMessage / 256 B | 2.357 | 2.456 | x1.042 | level | 1 of 4 | - | - | x1.011 | x1.001 | x0.991 |
| blake3-servil-st / solo / OneMessage / 512 B | 1.881 | 1.867 | x0.993 | level | 2 of 4 | - | - | x0.974 | x0.996 | x0.994 |
| blake3-servil-st / solo / OneMessage / 1 KiB | 1.629 | 1.653 | x1.014 | level | 0 of 4 | - | - | x0.989 | x0.999 | x1.004 |
| blake3-servil-st / solo / OneMessage / 1536 B | 1.502 | 1.507 | x1.003 | level | 2 of 4 | - | - | x0.991 | x0.999 | x0.958 |
| blake3-servil-st / solo / OneMessage / 2 KiB | 1.015 | 1.016 | x1.001 | level | 2 of 4 | - | - | x0.991 | x1.001 | x0.980 |
| blake3-servil-st / solo / OneMessage / 2304 B | 1.173 | 1.169 | x0.996 | level | 2 of 4 | - | - | x0.990 | x1.001 | x1.006 |
| blake3-servil-st / solo / OneMessage / 3 KiB | 0.817 | 0.817 | x1.000 | level | 2 of 4 | - | - | x0.991 | x1.000 | x1.012 |
| blake3-servil-st / solo / OneMessage / 3839 B | 0.825 | 0.805 | x0.975 | level | 2 of 4 | - | - | x0.971 | x0.999 | x1.002 |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.578 | 0.565 | x0.979 | level | 3 of 4 | - | - | x0.976 | x1.000 | x1.020 |
| blake3-servil-st / solo / OneMessage / 4470 B | 0.693 | 0.680 | x0.982 | level | 3 of 4 | - | - | x0.977 | x1.001 | x1.019 |
| blake3-servil-st / solo / OneMessage / 7935 B | 0.593 | 0.586 | x0.988 | level | 2 of 4 | - | - | x0.980 | x1.000 | x0.994 |
| blake3-servil-st / solo / OneMessage / 8 KiB | 0.454 | 0.436 | x0.960 | level | 4 of 4 | - | - | x0.955 | x1.001 | x0.986 |
| blake3-servil-st / solo / OneMessage / 16 KiB | 0.322 | 0.305 | x0.947 | level | 3 of 4 | - | - | x0.942 | x1.001 | x1.013 |
| blake3-servil-st / solo / OneMessage / 32 KiB | 0.208 | 0.205 | x0.985 | level | 3 of 4 | - | - | x0.986 | x0.999 | x1.040 |
| blake3-servil-st / solo / OneMessage / 64 KiB | 0.154 | 0.153 | x0.994 | level | 1 of 4 | - | - | x0.989 | x1.000 | x1.003 |
| blake3-servil-st / solo / OneMessage / 128 KiB | 0.128 | 0.127 | x0.996 | level | 2 of 4 | - | - | x0.989 | x1.000 | x0.982 |
| blake3-servil-st / solo / OneMessage / 256 KiB | 0.115 | 0.114 | x0.993 | level | 3 of 4 | - | - | x0.992 | x1.000 | x0.968 |
| blake3-servil-st / solo / OneMessage / 512 KiB | 0.103 | 0.103 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.016 |
| blake3-servil-st / solo / OneMessage / 1 MiB | 0.0983 | 0.0980 | x0.997 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.086 |
| blake3-servil-st / solo / OneMessage / 2 MiB | 0.0986 | 0.0991 | x1.005 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.076 |
| blake3-servil-st / solo / OneMessage / 3 MiB | 0.101 | 0.101 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.089 |
| blake3-servil-st / solo / OneMessage / 4 MiB | 0.0988 | 0.0988 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.094 |
| blake3-servil-st / solo / OneMessage / 8 MiB | 0.106 | 0.106 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.101 |
| blake3-servil-st / solo / OneMessage / 32 MiB | 0.114 | 0.115 | x1.010 | level | 0 of 4 | - | - | x1.010 | x1.000 | x1.079 |
| blake3-servil-st / solo / OneMessage / 64 MiB | 0.114 | 0.116 | x1.012 | level | 0 of 4 | - | - | x1.012 | x1.000 | x1.062 |
| blake3-servil-st / solo / OneMessage / 128 MiB | 0.115 | 0.116 | x1.007 | level | 1 of 4 | - | - | x1.007 | x1.000 | x1.060 |
| blake3-servil-st / solo / ManyMessages / 1 | 461.892 | 429.364 | x0.930 | level | 3 of 4 | - | - | x0.919 | x1.001 | x1.018 |
| blake3-servil-st / solo / ManyMessages / 2 | 232.113 | 256.080 | x1.103 | level | 1 of 4 | - | - | x1.035 | x1.003 | x1.031 |
| blake3-servil-st / solo / ManyMessages / 3 | 192.781 | 216.759 | x1.124 | level | 1 of 4 | - | - | x1.052 | x1.007 | x1.006 |
| blake3-servil-st / solo / ManyMessages / 4 | 130.388 | 144.748 | x1.110 | level | 1 of 4 | - | - | x1.033 | x1.009 | x1.015 |
| blake3-servil-st / solo / ManyMessages / 6 | 107.857 | 122.390 | x1.135 | level | 1 of 4 | - | - | x1.068 | x1.006 | x1.030 |
| blake3-servil-st / solo / ManyMessages / 8 | 165.039 | 179.484 | x1.088 | level | 0 of 4 | - | - | x1.054 | x1.007 | x1.019 |
| blake3-servil-st / solo / ManyMessages / 12 | 125.082 | 129.007 | x1.031 | level | 2 of 4 | - | - | x1.015 | x1.001 | x1.016 |
| blake3-servil-st / solo / ManyMessages / 16 | 100.566 | 96.340 | x0.958 | level | 2 of 4 | - | - | x0.958 | x1.005 | x1.002 |
| blake3-servil-st / solo / ManyMessages / 24 | 109.322 | 107.262 | x0.981 | level | 2 of 4 | - | - | x0.974 | x0.997 | x1.016 |
| blake3-servil-st / solo / ManyMessages / 32 | 52.190 | 49.903 | x0.956 | level | 2 of 4 | - | - | x0.954 | x1.000 | x1.005 |
| blake3-servil-st / solo / ManyMessages / 48 | 35.835 | 34.158 | x0.953 | level | 2 of 4 | - | - | x0.946 | x0.999 | x1.004 |
| blake3-servil-st / solo / ManyMessages / 64 | 29.598 | 28.494 | x0.963 | level | 2 of 4 | - | - | x0.959 | x0.999 | x1.007 |
| blake3-servil-st / solo / ManyMessages / 128 | 20.202 | 19.407 | x0.961 | level | 2 of 4 | - | - | x0.955 | x1.003 | x1.010 |
| blake3-servil-st / solo / ManyMessages / 256 | 14.270 | 13.949 | x0.978 | level | 4 of 4 | - | - | x0.972 | x1.000 | x1.030 |
| blake3-servil-st / solo / ManyMessages / 512 | 11.308 | 11.147 | x0.986 | level | 4 of 4 | - | - | x0.982 | x0.999 | x1.084 |
| blake3-servil-st / solo / ManyMessages / 1024 | 9.769 | 9.784 | x1.001 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.049 |
| blake3-servil-st / solo / ManyMessages / 2048 | 9.250 | 9.106 | x0.984 | level | 3 of 4 | - | - | x0.990 | x1.000 | x1.046 |
| blake3-servil-st / solo / ManyMessages / 4096 | 8.872 | 8.888 | x1.002 | level | 3 of 4 | - | - | x1.003 | x1.000 | x1.058 |
| blake3-servil-st / solo / ManyMessages / 8192 | 8.186 | 8.242 | x1.007 | level | 1 of 4 | - | - | x1.007 | x1.000 | x1.086 |
| blake3-servil-st / solo / ManyMessages / 16384 | 7.855 | 7.886 | x1.004 | level | 0 of 4 | - | - | x1.002 | x1.000 | x1.061 |
| blake3-servil-st / solo / ManyMessages / 32768 | 7.872 | 7.902 | x1.004 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.035 |
| blake3-servil-st / solo / ManyMessages / 65536 | 7.998 | 7.992 | x0.999 | level | 1 of 4 | - | - | x0.999 | x1.000 | x1.023 |
| blake3-servil-st / solo / ManyMessages / 131072 | 8.316 | 8.380 | x1.008 | level | 1 of 4 | - | - | x1.007 | x1.000 | x1.018 |
| blake3-servil-st / solo / ManyMessages / 262144 | 8.712 | 8.779 | x1.008 | level | 0 of 4 | - | - | x1.004 | x1.000 | x1.014 |
| blake3-servil-st / solo / ManyLongMessages / 4 | 1828.408 | 1857.422 | x1.016 | level | 1 of 4 | - | - | x1.015 | x0.999 | x1.039 |
| blake3-servil-st / solo / ManyLongMessages / 16 | 1640.232 | 1638.952 | x0.999 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.020 |
| blake3-servil-st / solo / ManyLongMessages / 64 | 573.656 | 571.635 | x0.996 | level | 3 of 4 | - | - | x0.995 | x1.000 | x1.002 |
| blake3-servil-st / solo / ManyLongMessages / 256 | 519.988 | 520.708 | x1.001 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.120 |
| blake3-servil-st / solo / IdleOneMessage / 64 B | 3.018 | 2.987 | x0.990 | level | 3 of 4 | - | - | x0.990 | x1.004 | x0.677 |
| blake3-servil-st / solo / IdleOneMessage / 128 B | 2.103 | 2.102 | x0.999 | level | 2 of 4 | - | - | x0.997 | x1.003 | x0.944 |
| blake3-servil-st / solo / IdleOneMessage / 256 B | 1.804 | 1.778 | x0.986 | level | 3 of 4 | - | - | x0.993 | x1.002 | x0.633 |
| blake3-servil-st / solo / IdleOneMessage / 512 B | 1.632 | 1.615 | x0.989 | level | 3 of 4 | - | - | x0.996 | x1.001 | x2.100 |
| blake3-servil-st / solo / IdleOneMessage / 1 KiB | 1.538 | 1.514 | x0.984 | level | 2 of 4 | - | - | x0.998 | x1.001 | x2.142 |
| blake3-servil-st / solo / IdleOneMessage / 1536 B | 1.185 | 1.153 | x0.973 | level | 4 of 4 | - | - | x0.998 | x0.998 | x0.739 |
| blake3-servil-st / solo / IdleOneMessage / 2 KiB | 0.866 | 0.846 | x0.978 | level | 4 of 4 | - | - | x0.997 | x1.001 | x0.583 |
| blake3-servil-st / solo / IdleOneMessage / 2304 B | 0.965 | 0.955 | x0.990 | level | 2 of 4 | - | - | x0.991 | x1.001 | x0.557 |
| blake3-servil-st / solo / IdleOneMessage / 3 KiB | 0.622 | 0.627 | x1.007 | level | 2 of 4 | - | - | x0.997 | x1.001 | x0.637 |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 0.510 | 0.516 | x1.012 | level | 2 of 4 | - | - | x1.000 | x1.001 | x1.095 |
| blake3-servil-st / solo / IdleOneMessage / 4 KiB | 0.473 | 0.471 | x0.997 | level | 3 of 4 | - | - | x1.000 | x1.001 | x1.629 |
| blake3-servil-st / solo / IdleOneMessage / 4470 B | 0.587 | 0.585 | x0.997 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.592 |
| blake3-servil-st / solo / IdleOneMessage / 7935 B | 0.296 | 0.297 | x1.003 | level | 1 of 4 | - | - | x0.995 | x1.000 | x0.715 |
| blake3-servil-st / solo / IdleOneMessage / 8 KiB | 0.272 | 0.275 | x1.011 | level | 1 of 4 | - | - | x0.998 | x1.000 | x0.747 |
| blake3-servil-st / solo / IdleOneMessage / 16 KiB | 0.152 | 0.156 | x1.025 | level | 0 of 4 | - | - | x1.000 | x1.000 | x0.462 |
| blake3-servil-st / solo / IdleOneMessage / 32 KiB | 0.107 | 0.107 | x1.008 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.521 |
| blake3-servil-st / solo / IdleOneMessage / 64 KiB | 0.0981 | 0.0965 | x0.983 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.115 |
| blake3-servil-st / solo / IdleOneMessage / 128 KiB | 0.0940 | 0.0914 | x0.973 | level | 4 of 4 | - | - | x1.001 | x1.000 | x1.445 |
| blake3-servil-st / solo / IdleOneMessage / 256 KiB | 0.0920 | 0.0900 | x0.978 | level | 4 of 4 | - | - | x1.005 | x1.000 | x1.759 |
| blake3-servil-st / solo / IdleOneMessage / 512 KiB | 0.0970 | 0.0951 | x0.980 | level | 4 of 4 | - | - | x1.002 | x1.000 | x1.020 |
| blake3-servil-st / solo / IdleOneMessage / 1 MiB | 0.0947 | 0.0933 | x0.985 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.968 |
| blake3-servil-st / solo / IdleOneMessage / 2 MiB | 0.0886 | 0.0880 | x0.993 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.945 |
| blake3-servil-st / solo / IdleOneMessage / 3 MiB | 0.0875 | 0.0870 | x0.995 | level | 4 of 4 | - | - | x0.995 | x1.000 | x0.967 |
| blake3-servil-st / solo / IdleOneMessage / 4 MiB | 0.0872 | 0.0869 | x0.997 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.971 |
| blake3-servil-st / solo / IdleOneMessage / 8 MiB | 0.0881 | 0.0879 | x0.997 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.978 |
| blake3-servil-st / solo / IdleOneMessage / 32 MiB | 0.115 | 0.115 | x1.005 | level | 1 of 4 | - | - | x1.005 | x1.000 | x1.048 |
| blake3-servil-st / solo / IdleOneMessage / 64 MiB | 0.114 | 0.116 | x1.012 | level | 0 of 4 | - | - | x1.012 | x1.000 | x1.065 |
| blake3-servil-st / solo / IdleOneMessage / 128 MiB | 0.116 | 0.116 | x1.007 | level | 1 of 4 | - | - | x1.007 | x1.000 | x1.058 |
| blake3-servil-st / solo / IdleManyMessages / 1 | 204.666 | 204.757 | x1.000 | level | 2 of 4 | - | - | x0.999 | x1.003 | x1.110 |
| blake3-servil-st / solo / IdleManyMessages / 2 | 105.564 | 105.933 | x1.003 | level | 2 of 4 | - | - | x0.997 | x1.001 | x0.554 |
| blake3-servil-st / solo / IdleManyMessages / 3 | 91.444 | 90.070 | x0.985 | level | 3 of 4 | - | - | x0.993 | x1.001 | x0.550 |
| blake3-servil-st / solo / IdleManyMessages / 4 | 53.361 | 53.034 | x0.994 | level | 2 of 4 | - | - | x0.998 | x1.002 | x3.996 |
| blake3-servil-st / solo / IdleManyMessages / 6 | 50.599 | 50.623 | x1.000 | level | 2 of 4 | - | - | x0.993 | x1.001 | x0.818 |
| blake3-servil-st / solo / IdleManyMessages / 8 | 33.646 | 34.458 | x1.024 | level | 2 of 4 | - | - | x1.002 | x1.001 | x0.943 |
| blake3-servil-st / solo / IdleManyMessages / 12 | 31.126 | 31.237 | x1.004 | level | 2 of 4 | - | - | x1.002 | x1.001 | x1.985 |
| blake3-servil-st / solo / IdleManyMessages / 16 | 18.783 | 17.815 | x0.948 | level | 4 of 4 | - | - | x0.977 | x1.001 | x0.627 |
| blake3-servil-st / solo / IdleManyMessages / 24 | 17.113 | 16.870 | x0.986 | level | 3 of 4 | - | - | x0.988 | x1.001 | x0.559 |
| blake3-servil-st / solo / IdleManyMessages / 32 | 13.238 | 13.036 | x0.985 | level | 3 of 4 | - | - | x0.992 | x1.001 | x0.828 |
| blake3-servil-st / solo / IdleManyMessages / 48 | 11.362 | 11.524 | x1.014 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.922 |
| blake3-servil-st / solo / IdleManyMessages / 64 | 10.567 | 10.449 | x0.989 | level | 3 of 4 | - | - | x1.005 | x1.000 | x12.849 |
| blake3-servil-st / solo / IdleManyMessages / 128 | 9.318 | 9.133 | x0.980 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.311 |
| blake3-servil-st / solo / IdleManyMessages / 256 | 8.733 | 8.652 | x0.991 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.436 |
| blake3-servil-st / solo / IdleManyMessages / 512 | 8.338 | 8.279 | x0.993 | level | 2 of 4 | - | - | x0.994 | x1.000 | x0.454 |
| blake3-servil-st / solo / IdleManyMessages / 1024 | 8.123 | 8.134 | x1.001 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.675 |
| blake3-servil-st / solo / IdleManyMessages / 2048 | 7.990 | 8.003 | x1.002 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.710 |
| blake3-servil-st / solo / IdleManyMessages / 4096 | 8.020 | 8.102 | x1.010 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.115 |
| blake3-servil-st / solo / IdleManyMessages / 8192 | 8.225 | 8.254 | x1.004 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.983 |
| blake3-servil-st / solo / IdleManyMessages / 16384 | 7.886 | 7.894 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.935 |
| blake3-servil-st / solo / IdleManyMessages / 32768 | 7.464 | 7.461 | x1.000 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.908 |
| blake3-servil-st / solo / IdleManyMessages / 65536 | 7.425 | 7.405 | x0.997 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.944 |
| blake3-servil-st / solo / IdleManyMessages / 131072 | 7.428 | 7.415 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.937 |
| blake3-servil-st / solo / IdleManyMessages / 262144 | 7.965 | 7.950 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.939 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 B | 3.066 | 2.995 | x0.977 | level | 2 of 4 | - | - | x0.991 | x1.004 | x1.069 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 B | 2.109 | 2.099 | x0.995 | level | 4 of 4 | - | - | x0.996 | x1.003 | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 B | 1.699 | 1.686 | x0.992 | level | 3 of 4 | - | - | x0.998 | x1.002 | x0.921 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 B | 1.455 | 1.456 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.001 | x1.048 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 KiB | 1.346 | 1.347 | x1.001 | level | 1 of 4 | - | - | x1.000 | x1.001 | x0.631 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1536 B | 1.013 | 1.013 | x1.000 | level | 3 of 4 | - | - | x0.999 | x0.998 | x1.341 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 KiB | 0.731 | 0.729 | x0.998 | level | 2 of 4 | - | - | x0.998 | x1.001 | x1.198 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2304 B | 0.816 | 0.811 | x0.994 | level | 4 of 4 | - | - | x0.993 | x1.001 | x1.374 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.523 | 0.523 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.001 | x0.807 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3839 B | 0.426 | 0.425 | x0.997 | level | 4 of 4 | - | - | x0.997 | x1.001 | x0.862 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 KiB | 0.390 | 0.389 | x0.997 | level | 2 of 4 | - | - | x0.999 | x1.001 | x2.422 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4470 B | 0.481 | 0.486 | x1.010 | level | 1 of 4 | - | - | x1.001 | x1.001 | x0.571 |
| blake3-servil-st / solo / BriefIdleOneMessage / 7935 B | 0.240 | 0.240 | x1.001 | level | 1 of 4 | - | - | x0.999 | x1.000 | x0.418 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 KiB | 0.224 | 0.223 | x0.999 | level | 3 of 4 | - | - | x0.998 | x1.000 | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 16 KiB | 0.126 | 0.127 | x1.007 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.230 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 KiB | 0.0882 | 0.0880 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.422 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 KiB | 0.0809 | 0.0813 | x1.004 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.020 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 KiB | 0.0779 | 0.0776 | x0.996 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.952 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 KiB | 0.0775 | 0.0776 | x1.002 | level | 2 of 4 | - | - | x1.001 | x1.000 | x2.575 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 KiB | 0.0837 | 0.0839 | x1.003 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.007 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 MiB | 0.0868 | 0.0868 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.997 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 MiB | 0.0876 | 0.0872 | x0.996 | level | 2 of 4 | - | - | x0.995 | x1.000 | x0.924 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 MiB | 0.0877 | 0.0872 | x0.995 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.941 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 MiB | 0.0874 | 0.0870 | x0.995 | level | 2 of 4 | - | - | x0.995 | x1.000 | x0.930 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 MiB | 0.0881 | 0.0880 | x0.998 | level | 1 of 4 | - | - | x0.998 | x1.000 | x0.975 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 MiB | 0.114 | 0.115 | x1.006 | level | 0 of 4 | - | - | x1.007 | x1.000 | x1.055 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 MiB | 0.114 | 0.116 | x1.013 | level | 0 of 4 | - | - | x1.012 | x1.000 | x1.063 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 MiB | 0.116 | 0.116 | x1.007 | level | 1 of 4 | - | - | x1.008 | x1.000 | x1.061 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1 | 204.435 | 204.025 | x0.998 | level | 3 of 4 | - | - | x0.996 | x1.003 | x0.989 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2 | 103.807 | 104.255 | x1.004 | level | 1 of 4 | - | - | x1.000 | x1.001 | x1.445 |
| blake3-servil-st / solo / BriefIdleManyMessages / 3 | 90.332 | 91.696 | x1.015 | level | 2 of 4 | - | - | x0.998 | x1.001 | x1.643 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4 | 60.830 | 52.460 | x0.862 | level | 3 of 4 | - | - | x0.997 | x1.001 | x1.328 |
| blake3-servil-st / solo / BriefIdleManyMessages / 6 | 45.629 | 45.944 | x1.007 | level | 2 of 4 | - | - | x0.999 | x1.001 | x0.960 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8 | 28.155 | 28.267 | x1.004 | level | 1 of 4 | - | - | x1.000 | x1.001 | x0.662 |
| blake3-servil-st / solo / BriefIdleManyMessages / 12 | 25.534 | 25.619 | x1.003 | level | 1 of 4 | - | - | x0.998 | x1.001 | x1.019 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16 | 14.814 | 14.653 | x0.989 | level | 3 of 4 | - | - | x0.994 | x1.001 | x0.462 |
| blake3-servil-st / solo / BriefIdleManyMessages / 24 | 13.696 | 13.737 | x1.003 | level | 2 of 4 | - | - | x0.996 | x1.001 | x0.849 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32 | 10.561 | 10.451 | x0.990 | level | 3 of 4 | - | - | x0.995 | x1.001 | x1.434 |
| blake3-servil-st / solo / BriefIdleManyMessages / 48 | 9.162 | 9.108 | x0.994 | level | 3 of 4 | - | - | x0.998 | x1.001 | x2.682 |
| blake3-servil-st / solo / BriefIdleManyMessages / 64 | 8.529 | 8.424 | x0.988 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.064 |
| blake3-servil-st / solo / BriefIdleManyMessages / 128 | 7.406 | 7.398 | x0.999 | level | 3 of 4 | - | - | x0.998 | x1.000 | x2.455 |
| blake3-servil-st / solo / BriefIdleManyMessages / 256 | 7.200 | 7.061 | x0.981 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.758 |
| blake3-servil-st / solo / BriefIdleManyMessages / 512 | 6.864 | 6.795 | x0.990 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.936 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1024 | 6.671 | 6.682 | x1.002 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.191 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2048 | 6.673 | 6.628 | x0.993 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.713 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4096 | 6.760 | 6.774 | x1.002 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.081 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8192 | 7.253 | 7.236 | x0.998 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.977 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16384 | 7.397 | 7.392 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.959 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32768 | 7.465 | 7.457 | x0.999 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.897 |
| blake3-servil-st / solo / BriefIdleManyMessages / 65536 | 7.442 | 7.433 | x0.999 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.902 |
| blake3-servil-st / solo / BriefIdleManyMessages / 131072 | 7.434 | 7.420 | x0.998 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.914 |
| blake3-servil-st / solo / BriefIdleManyMessages / 262144 | 7.953 | 7.937 | x0.998 | level | 4 of 4 | - | - | x0.998 | x1.000 | x0.947 |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.940 | 0.940 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | x0.958 |
| blake3-servil-st / solo / ContinuousMessages / 128 B | 1.078 | 1.080 | x1.002 | level | 0 of 4 | x1.002 | - | x1.001 | x1.000 | x1.107 |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 1.153 | 1.152 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x1.022 |
| blake3-servil-st / solo / ContinuousMessages / 512 B | 1.189 | 1.189 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.542 |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 1.212 | 1.212 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.741 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.358 | 0.358 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.478 |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.114 | 0.114 | x0.998 | level | 4 of 4 | x0.998 | - | x0.998 | x1.000 | x0.930 |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.0809 | 0.0807 | x0.997 | level | 2 of 4 | x0.998 | - | x0.996 | x1.000 | x2.269 |
| blake3-servil-st / solo / ContinuousMessages / 256 KiB | 0.0827 | 0.0826 | x1.000 | level | 2 of 4 | x0.999 | - | x0.998 | x1.000 | x0.908 |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.0842 | 0.0840 | x0.998 | level | 2 of 4 | x0.998 | - | x0.997 | x1.000 | x0.997 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.0855 | 0.0854 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x1.008 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.0853 | 0.0852 | x0.998 | level | 2 of 4 | x0.998 | - | x0.998 | x1.000 | x1.062 |
| blake3-servil-st / solo / ContinuousMessages / 64 MiB | 0.0973 | 0.0975 | x1.002 | level | 1 of 4 | x1.002 | - | x1.001 | x1.000 | x1.020 |
| blake3-servil-st / solo / ContinuousBatches / 16 | 7.559 | 7.514 | x0.994 | level | 3 of 4 | x0.994 | - | x0.993 | x0.998 | x3.861 |
| blake3-servil-st / solo / ContinuousBatches / 64 | 6.641 | 6.646 | x1.001 | level | 2 of 4 | x1.001 | - | x1.000 | x0.999 | x2.949 |
| blake3-servil-st / solo / ContinuousBatches / 256 | 6.606 | 6.672 | x1.010 | level | 0 of 4 | x1.010 | - | x1.008 | x1.000 | x17.865 |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 7.034 | 7.090 | x1.008 | level | 0 of 4 | x1.008 | - | x1.006 | x1.000 | x49.115 |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 6.848 | 6.836 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x2.369 |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 7.649 | 7.637 | x0.998 | level | 2 of 4 | x0.998 | - | x0.999 | x1.000 | x1.010 |
| blake3-servil-st / solo / ContinuousBatches / 65536 | 7.671 | 7.652 | x0.997 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x0.975 |
| blake3-servil-st / solo / LentMessages / 64 B | 0.940 | 0.940 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | x0.958 |
| blake3-servil-st / solo / LentMessages / 128 B | 1.078 | 1.080 | x1.002 | level | 0 of 4 | x1.002 | - | x1.001 | x1.000 | x1.107 |
| blake3-servil-st / solo / LentMessages / 256 B | 1.153 | 1.152 | x1.000 | level | 3 of 4 | x1.000 | - | x1.000 | x1.000 | x1.022 |
| blake3-servil-st / solo / LentMessages / 512 B | 1.189 | 1.189 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.542 |
| blake3-servil-st / solo / LentMessages / 1 KiB | 1.212 | 1.212 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.741 |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.358 | 0.358 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.478 |
| blake3-servil-st / solo / LentMessages / 16 KiB | 0.114 | 0.114 | x0.998 | level | 4 of 4 | x0.998 | - | x0.998 | x1.000 | x0.930 |
| blake3-servil-st / solo / LentMessages / 64 KiB | 0.0809 | 0.0807 | x0.997 | level | 2 of 4 | x0.998 | - | x0.996 | x1.000 | x2.269 |
| blake3-servil-st / solo / LentMessages / 256 KiB | 0.0760 | 0.0760 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x2.270 |
| blake3-servil-st / solo / LentMessages / 1 MiB | 0.0859 | 0.0859 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.020 |
| blake3-servil-st / solo / LentMessages / 4 MiB | 0.0863 | 0.0859 | x0.995 | level | 3 of 4 | x0.995 | - | x0.996 | x1.000 | x1.090 |
| blake3-servil-st / solo / LentMessages / 16 MiB | 0.0915 | 0.0914 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x1.087 |
| blake3-servil-st / solo / LentMessages / 64 MiB | 0.116 | 0.118 | x1.016 | level | 2 of 4 | x1.016 | - | x1.016 | x1.000 | x1.076 |
| blake3-servil-st / solo / Interleaved / 256 | 0.137 | 0.137 | x0.999 | level | 3 of 4 | x0.999 | - | x0.998 | x0.999 | x1.000 |
| blake3-servil-st / solo / Collection / git objects | 0.0984 | 0.0984 | x1.000 | level | 3 of 4 | x1.000 | - | x1.001 | x0.999 | x1.031 |
| blake3-servil-st / solo / Collection / Nix files | 0.0887 | 0.0892 | x1.005 | level | 1 of 4 | x1.006 | - | x1.006 | x0.999 | x1.045 |
| blake3-servil-st / solo / LentBatches / 16 | 7.559 | 7.514 | x0.994 | level | 3 of 4 | x0.994 | - | x0.993 | x0.998 | x3.861 |
| blake3-servil-st / solo / LentBatches / 64 | 6.641 | 6.646 | x1.001 | level | 2 of 4 | x1.001 | - | x1.000 | x0.999 | x2.949 |
| blake3-servil-st / solo / LentBatches / 256 | 6.606 | 6.672 | x1.010 | level | 0 of 4 | x1.010 | - | x1.008 | x1.000 | x17.865 |
| blake3-servil-st / solo / LentBatches / 1024 | 7.034 | 7.090 | x1.008 | level | 0 of 4 | x1.008 | - | x1.006 | x1.000 | x49.115 |
| blake3-servil-st / solo / LentBatches / 4096 | 6.848 | 6.836 | x0.998 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x2.369 |
| blake3-servil-st / solo / LentBatches / 16384 | 7.649 | 7.637 | x0.998 | level | 2 of 4 | x0.998 | - | x0.999 | x1.000 | x1.010 |
| blake3-servil-st / solo / LentBatches / 65536 | 7.671 | 7.652 | x0.997 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x0.975 |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.135 | 0.135 | x0.999 | level | 2 of 4 | x0.999 | - | x0.998 | x1.000 | x0.998 |
| blake3-servil-st / solo / ContinuousCollection / Nix files | 0.146 | 0.146 | x0.999 | level | 2 of 4 | x1.000 | - | x0.998 | x1.000 | x1.014 |
| blake3-servil-st / solo / MerkleTree / 1024 | 0.123 | 0.124 | x1.010 | level | 0 of 4 | x1.010 | - | x1.009 | x1.001 | x8.081 |
| blake3-servil-st / solo / MerkleTree / 4096 | 0.134 | 0.134 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.001 | x0.906 |
| blake3-servil-st / solo / MerkleTree / 16384 | 0.133 | 0.133 | x0.999 | level | 3 of 4 | x1.000 | - | x1.000 | x1.001 | x0.975 |
| blake3-servil-st / solo / MerkleTree / 65536 | 0.141 | 0.141 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.001 | x0.973 |
| blake3-servil-st / solo / MerkleTree / 262144 | 0.152 | 0.151 | x0.994 | level | 3 of 4 | x0.995 | - | x0.995 | x1.001 | x0.959 |
| blake3-servil-st / solo / MerkleTree / 65536 x 32 B | 0.385 | 0.385 | x1.001 | level | 1 of 4 | x1.001 | - | x0.999 | x1.000 | x1.039 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 32 B | 0.421 | 0.421 | x1.002 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x1.047 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 16 B | 0.809 | 0.814 | x1.006 | level | 0 of 4 | x1.009 | - | x1.005 | x1.000 | x1.122 |
| blake3-servil-st / solo / MerkleTree / 65536 x 48 B | 0.268 | 0.268 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.016 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 48 B | 0.297 | 0.298 | x1.004 | level | 0 of 4 | x1.004 | - | x1.005 | x1.000 | x1.114 |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.246 | 0.245 | x0.996 | level | 2 of 4 | - | - | x0.995 | x0.990 | x1.010 |
| blake3-servil-st / solo / InterleavedTurn / 1024 x 1 KiB | 0.234 | 0.231 | x0.989 | level | 2 of 4 | - | - | x0.987 | x1.000 | x0.992 |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.209 | 0.209 | x1.001 | level | 2 of 4 | - | - | x1.003 | x0.998 | x0.965 |
| blake3-servil-st / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.193 | 0.192 | x0.996 | level | 2 of 4 | - | - | x0.995 | x1.000 | x0.965 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.207 | 0.206 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.982 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.190 | 0.188 | x0.988 | level | 2 of 4 | - | - | x0.990 | x1.000 | x0.979 |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.105 | 0.106 | x1.010 | level | 2 of 4 | x1.011 | - | x0.998 | x1.000 | x0.980 |
| blake3-servil-st / solo / ReceivingMessage / 2 μs | 0.107 | 0.106 | x0.991 | level | 2 of 4 | x0.991 | - | x0.998 | x1.000 | x0.980 |
| blake3-servil-st / solo / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 1 of 4 | x0.998 | - | x1.000 | x1.000 | x1.064 |
| blake3-servil-st / solo / IncrementalMessage / 64 B | 6.106 | 5.780 | x0.947 | level | 3 of 4 | - | - | x0.946 | x1.005 | x0.976 |
| blake3-servil-st / solo / IncrementalMessage / 1 KiB | 1.832 | 1.845 | x1.007 | level | 2 of 4 | - | - | x0.993 | x1.001 | x0.997 |
| blake3-servil-st / solo / IncrementalMessage / 4 KiB | 0.636 | 0.641 | x1.008 | level | 1 of 4 | - | - | x0.988 | x1.000 | x1.012 |
| blake3-servil-st / solo / LentIncrementalMessage / 64 B | 1.015 | 1.016 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | x0.806 |
| blake3-servil-st / solo / LentIncrementalMessage / 1 KiB | 1.245 | 1.245 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.895 |
| blake3-servil-st / solo / LentIncrementalMessage / 4 KiB | 0.365 | 0.365 | x1.000 | level | 2 of 4 | x1.000 | - | x1.001 | x1.000 | x0.866 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 0.950 | 0.951 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x1.000 | x1.273 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 4 KiB | 0.358 | 0.358 | x0.999 | level | 3 of 4 | x0.999 | - | x1.000 | x1.000 | x2.325 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 1 MiB | 0.0839 | 0.0811 | x0.968 | level | 4 of 4 | x0.968 | - | x0.965 | x1.000 | x0.972 |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 0.908 | 0.908 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.051 |
| blake3-servil-st / solo / ContinuousLentMessages / 4 KiB | 0.353 | 0.353 | x0.999 | level | 2 of 4 | x0.999 | - | x1.000 | x1.000 | x0.419 |
| blake3-servil-st / solo / ContinuousLentMessages / 1 MiB | 0.0695 | 0.0695 | x1.000 | level | 3 of 4 | x1.000 | - | x1.001 | x1.000 | x1.018 |
| blake3-servil-mt / solo / OneMessage / 64 B | 5.692 | 5.974 | x1.050 | level | 1 of 4 | - | - | x1.005 | x0.999 | x0.997 |
| blake3-servil-mt / solo / OneMessage / 128 B | 3.544 | 3.678 | x1.038 | level | 2 of 4 | - | - | x1.013 | x0.999 | x1.047 |
| blake3-servil-mt / solo / OneMessage / 256 B | 2.518 | 2.621 | x1.041 | level | 2 of 4 | - | - | x1.004 | x0.999 | x1.038 |
| blake3-servil-mt / solo / OneMessage / 512 B | 1.974 | 1.995 | x1.010 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.027 |
| blake3-servil-mt / solo / OneMessage / 1 KiB | 1.673 | 1.682 | x1.006 | level | 2 of 4 | - | - | x0.991 | x0.999 | x1.077 |
| blake3-servil-mt / solo / OneMessage / 1536 B | 1.573 | 1.567 | x0.996 | level | 2 of 4 | - | - | x0.986 | x0.997 | x0.973 |
| blake3-servil-mt / solo / OneMessage / 2 KiB | 1.053 | 1.049 | x0.996 | level | 2 of 4 | - | - | x0.984 | x0.999 | x0.983 |
| blake3-servil-mt / solo / OneMessage / 2304 B | 1.206 | 1.183 | x0.980 | level | 2 of 4 | - | - | x0.975 | x0.999 | x1.020 |
| blake3-servil-mt / solo / OneMessage / 3 KiB | 0.845 | 0.823 | x0.974 | level | 2 of 4 | - | - | x0.978 | x1.001 | x1.005 |
| blake3-servil-mt / solo / OneMessage / 3839 B | 0.829 | 0.825 | x0.994 | level | 2 of 4 | - | - | x0.978 | x1.000 | x1.014 |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 0.600 | 0.577 | x0.961 | level | 3 of 4 | - | - | x0.958 | x0.999 | x1.024 |
| blake3-servil-mt / solo / OneMessage / 4470 B | 0.711 | 0.682 | x0.959 | level | 3 of 4 | - | - | x0.955 | x0.999 | x1.021 |
| blake3-servil-mt / solo / OneMessage / 7935 B | 0.610 | 0.594 | x0.975 | level | 2 of 4 | - | - | x0.970 | x1.001 | x0.994 |
| blake3-servil-mt / solo / OneMessage / 8 KiB | 0.456 | 0.443 | x0.972 | level | 2 of 4 | - | - | x0.960 | x1.001 | x0.994 |
| blake3-servil-mt / solo / OneMessage / 16 KiB | 0.321 | 0.310 | x0.966 | level | 3 of 4 | - | - | x0.964 | x1.000 | x1.011 |
| blake3-servil-mt / solo / OneMessage / 32 KiB | 0.212 | 0.208 | x0.980 | level | 3 of 4 | - | - | x0.980 | x0.999 | x1.056 |
| blake3-servil-mt / solo / OneMessage / 64 KiB | 0.153 | 0.152 | x0.997 | level | 2 of 4 | - | - | x0.994 | x1.000 | x1.010 |
| blake3-servil-mt / solo / OneMessage / 128 KiB | 0.127 | 0.126 | x0.998 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.003 |
| blake3-servil-mt / solo / OneMessage / 256 KiB | 0.115 | 0.115 | x0.997 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.984 |
| blake3-servil-mt / solo / OneMessage / 512 KiB | 0.0690 | 0.0679 | x0.984 | level | 3 of 4 | - | - | x0.988 | x1.034 | x1.017 |
| blake3-servil-mt / solo / OneMessage / 1 MiB | 0.0525 | 0.0521 | x0.992 | level | 2 of 4 | - | - | x0.995 | x1.013 | x1.012 |
| blake3-servil-mt / solo / OneMessage / 2 MiB | 0.0651 | 0.0661 | x1.016 | level | 2 of 4 | - | - | x1.018 | x0.997 | x1.007 |
| blake3-servil-mt / solo / OneMessage / 3 MiB | 0.0701 | 0.0714 | x1.018 | level | 1 of 4 | - | - | x1.021 | x1.012 | x1.004 |
| blake3-servil-mt / solo / OneMessage / 4 MiB | 0.0425 | 0.0419 | x0.984 | level | 4 of 4 | - | - | x0.984 | x0.997 | x1.002 |
| blake3-servil-mt / solo / OneMessage / 8 MiB | 0.0695 | 0.0698 | x1.003 | level | 1 of 4 | - | - | x1.003 | x1.002 | x0.999 |
| blake3-servil-mt / solo / OneMessage / 32 MiB | 0.0364 | 0.0364 | x1.002 | level | 1 of 4 | - | - | x1.002 | x0.998 | x0.966 |
| blake3-servil-mt / solo / OneMessage / 64 MiB | 0.0339 | 0.0341 | x1.006 | level | 1 of 4 | - | - | x1.006 | x1.003 | x0.958 |
| blake3-servil-mt / solo / OneMessage / 128 MiB | 0.0354 | 0.0354 | x1.000 | level | 1 of 4 | - | - | x1.000 | x0.994 | x0.966 |
| blake3-servil-mt / solo / ManyMessages / 1 | 508.422 | 492.389 | x0.968 | level | 1 of 4 | - | - | x0.948 | x1.002 | x1.006 |
| blake3-servil-mt / solo / ManyMessages / 2 | 240.521 | 266.606 | x1.108 | level | 1 of 4 | - | - | x1.040 | x1.006 | x1.018 |
| blake3-servil-mt / solo / ManyMessages / 3 | 211.024 | 222.907 | x1.056 | level | 2 of 4 | - | - | x1.015 | x1.005 | x0.982 |
| blake3-servil-mt / solo / ManyMessages / 4 | 140.357 | 155.268 | x1.106 | level | 1 of 4 | - | - | x1.043 | x1.010 | x1.006 |
| blake3-servil-mt / solo / ManyMessages / 6 | 113.102 | 126.858 | x1.122 | level | 1 of 4 | - | - | x1.055 | x1.001 | x1.044 |
| blake3-servil-mt / solo / ManyMessages / 8 | 167.080 | 175.066 | x1.048 | level | 1 of 4 | - | - | x1.015 | x1.006 | x1.022 |
| blake3-servil-mt / solo / ManyMessages / 12 | 130.238 | 133.567 | x1.026 | level | 2 of 4 | - | - | x1.007 | x0.999 | x1.010 |
| blake3-servil-mt / solo / ManyMessages / 16 | 100.192 | 100.413 | x1.002 | level | 2 of 4 | - | - | x0.985 | x1.002 | x1.007 |
| blake3-servil-mt / solo / ManyMessages / 24 | 108.021 | 110.042 | x1.019 | level | 2 of 4 | - | - | x1.007 | x1.000 | x1.007 |
| blake3-servil-mt / solo / ManyMessages / 32 | 50.970 | 50.567 | x0.992 | level | 2 of 4 | - | - | x0.953 | x1.000 | x1.002 |
| blake3-servil-mt / solo / ManyMessages / 48 | 36.357 | 35.134 | x0.966 | level | 2 of 4 | - | - | x0.958 | x1.001 | x1.001 |
| blake3-servil-mt / solo / ManyMessages / 64 | 29.710 | 29.027 | x0.977 | level | 2 of 4 | - | - | x0.979 | x0.999 | x1.010 |
| blake3-servil-mt / solo / ManyMessages / 128 | 20.045 | 19.153 | x0.956 | level | 3 of 4 | - | - | x0.952 | x1.002 | x0.976 |
| blake3-servil-mt / solo / ManyMessages / 256 | 14.291 | 14.015 | x0.981 | level | 3 of 4 | - | - | x0.978 | x1.000 | x1.029 |
| blake3-servil-mt / solo / ManyMessages / 512 | 11.326 | 11.228 | x0.991 | level | 3 of 4 | - | - | x0.989 | x1.000 | x1.071 |
| blake3-servil-mt / solo / ManyMessages / 1024 | 9.816 | 9.849 | x1.003 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.044 |
| blake3-servil-mt / solo / ManyMessages / 2048 | 9.231 | 9.178 | x0.994 | level | 3 of 4 | - | - | x0.994 | x1.000 | x1.047 |
| blake3-servil-mt / solo / ManyMessages / 4096 | 8.889 | 8.945 | x1.006 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.045 |
| blake3-servil-mt / solo / ManyMessages / 8192 | 3.725 | 3.771 | x1.012 | level | 1 of 4 | - | - | x1.027 | x1.037 | x1.017 |
| blake3-servil-mt / solo / ManyMessages / 16384 | 3.032 | 2.993 | x0.987 | level | 2 of 4 | - | - | x0.995 | x1.016 | x1.018 |
| blake3-servil-mt / solo / ManyMessages / 32768 | 2.693 | 2.688 | x0.998 | level | 2 of 4 | - | - | x1.004 | x1.011 | x1.021 |
| blake3-servil-mt / solo / ManyMessages / 65536 | 2.921 | 2.932 | x1.004 | level | 1 of 4 | - | - | x1.006 | x1.004 | x1.024 |
| blake3-servil-mt / solo / ManyMessages / 131072 | 3.942 | 4.539 | x1.151 | level | 2 of 4 | - | - | x1.153 | x0.927 | x1.159 |
| blake3-servil-mt / solo / ManyMessages / 262144 | 4.628 | 4.671 | x1.009 | level | 1 of 4 | - | - | x1.010 | x0.998 | x1.016 |
| blake3-servil-mt / solo / ManyLongMessages / 4 | 1868.273 | 1866.301 | x0.999 | level | 2 of 4 | - | - | x1.006 | x1.000 | x1.032 |
| blake3-servil-mt / solo / ManyLongMessages / 16 | 1636.485 | 1655.320 | x1.012 | level | 0 of 4 | - | - | x1.011 | x1.000 | x1.028 |
| blake3-servil-mt / solo / ManyLongMessages / 64 | 575.455 | 570.641 | x0.992 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.983 |
| blake3-servil-mt / solo / ManyLongMessages / 256 | 320.763 | 303.422 | x0.946 | level | 3 of 4 | - | - | x0.947 | x0.981 | x1.002 |
| blake3-servil-mt / solo / IdleOneMessage / 64 B | 3.063 | 3.009 | x0.982 | level | 3 of 4 | - | - | x0.988 | x1.004 | x0.805 |
| blake3-servil-mt / solo / IdleOneMessage / 128 B | 2.168 | 2.131 | x0.983 | level | 2 of 4 | - | - | x0.994 | x1.003 | x0.756 |
| blake3-servil-mt / solo / IdleOneMessage / 256 B | 1.774 | 1.786 | x1.007 | level | 2 of 4 | - | - | x0.994 | x1.002 | x0.385 |
| blake3-servil-mt / solo / IdleOneMessage / 512 B | 1.615 | 1.625 | x1.006 | level | 2 of 4 | - | - | x0.996 | x1.001 | x1.928 |
| blake3-servil-mt / solo / IdleOneMessage / 1 KiB | 1.549 | 1.525 | x0.984 | level | 2 of 4 | - | - | x0.999 | x1.001 | x2.080 |
| blake3-servil-mt / solo / IdleOneMessage / 1536 B | 1.185 | 1.156 | x0.976 | level | 4 of 4 | - | - | x0.999 | x0.998 | x1.797 |
| blake3-servil-mt / solo / IdleOneMessage / 2 KiB | 0.871 | 0.847 | x0.972 | level | 4 of 4 | - | - | x0.998 | x1.001 | x1.139 |
| blake3-servil-mt / solo / IdleOneMessage / 2304 B | 0.966 | 0.958 | x0.992 | level | 2 of 4 | - | - | x0.995 | x1.001 | x0.482 |
| blake3-servil-mt / solo / IdleOneMessage / 3 KiB | 0.622 | 0.625 | x1.004 | level | 2 of 4 | - | - | x0.996 | x1.001 | x0.358 |
| blake3-servil-mt / solo / IdleOneMessage / 3839 B | 0.517 | 0.511 | x0.989 | level | 3 of 4 | - | - | x0.998 | x1.001 | x0.861 |
| blake3-servil-mt / solo / IdleOneMessage / 4 KiB | 0.470 | 0.472 | x1.003 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.022 |
| blake3-servil-mt / solo / IdleOneMessage / 4470 B | 0.585 | 0.587 | x1.003 | level | 2 of 4 | - | - | x1.002 | x1.001 | x1.294 |
| blake3-servil-mt / solo / IdleOneMessage / 7935 B | 0.296 | 0.295 | x0.997 | level | 2 of 4 | - | - | x0.992 | x1.000 | x0.429 |
| blake3-servil-mt / solo / IdleOneMessage / 8 KiB | 0.274 | 0.279 | x1.018 | level | 1 of 4 | - | - | x0.993 | x1.000 | x0.288 |
| blake3-servil-mt / solo / IdleOneMessage / 16 KiB | 0.152 | 0.156 | x1.027 | level | 0 of 4 | - | - | x1.000 | x1.000 | x0.455 |
| blake3-servil-mt / solo / IdleOneMessage / 32 KiB | 0.107 | 0.107 | x0.995 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.528 |
| blake3-servil-mt / solo / IdleOneMessage / 64 KiB | 0.0992 | 0.0964 | x0.971 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.852 |
| blake3-servil-mt / solo / IdleOneMessage / 128 KiB | 0.0936 | 0.0915 | x0.977 | level | 4 of 4 | - | - | x1.003 | x1.000 | x1.111 |
| blake3-servil-mt / solo / IdleOneMessage / 256 KiB | 0.0927 | 0.0900 | x0.971 | level | 4 of 4 | - | - | x1.001 | x1.000 | x1.506 |
| blake3-servil-mt / solo / IdleOneMessage / 512 KiB | 0.0626 | 0.0605 | x0.966 | level | 3 of 4 | - | - | x0.986 | x1.000 | x1.018 |
| blake3-servil-mt / solo / IdleOneMessage / 1 MiB | 0.0559 | 0.0545 | x0.977 | level | 1 of 4 | - | - | x0.987 | x1.007 | x0.987 |
| blake3-servil-mt / solo / IdleOneMessage / 2 MiB | 0.0612 | 0.0537 | x0.878 | level | 2 of 4 | - | - | x0.886 | x1.083 | x0.963 |
| blake3-servil-mt / solo / IdleOneMessage / 3 MiB | 0.0606 | 0.0520 | x0.858 | level | 2 of 4 | - | - | x0.858 | x1.047 | x0.958 |
| blake3-servil-mt / solo / IdleOneMessage / 4 MiB | 0.0590 | 0.0512 | x0.868 | level | 3 of 4 | - | - | x0.868 | x1.046 | x0.948 |
| blake3-servil-mt / solo / IdleOneMessage / 8 MiB | 0.0664 | 0.0664 | x1.001 | level | 1 of 4 | - | - | x1.000 | x1.004 | x0.971 |
| blake3-servil-mt / solo / IdleOneMessage / 32 MiB | 0.0325 | 0.0324 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.001 | x0.946 |
| blake3-servil-mt / solo / IdleOneMessage / 64 MiB | 0.0343 | 0.0344 | x1.002 | level | 2 of 4 | - | - | x1.003 | x0.999 | x0.983 |
| blake3-servil-mt / solo / IdleOneMessage / 128 MiB | 0.0336 | 0.0336 | x1.002 | level | 1 of 4 | - | - | x1.002 | x0.999 | x0.979 |
| blake3-servil-mt / solo / IdleManyMessages / 1 | 210.247 | 205.458 | x0.977 | level | 2 of 4 | - | - | x0.991 | x1.003 | x1.116 |
| blake3-servil-mt / solo / IdleManyMessages / 2 | 104.456 | 106.711 | x1.022 | level | 1 of 4 | - | - | x0.997 | x1.001 | x0.640 |
| blake3-servil-mt / solo / IdleManyMessages / 3 | 91.216 | 91.439 | x1.002 | level | 2 of 4 | - | - | x0.997 | x1.001 | x0.595 |
| blake3-servil-mt / solo / IdleManyMessages / 4 | 53.614 | 54.660 | x1.020 | level | 2 of 4 | - | - | x1.002 | x1.001 | x7.597 |
| blake3-servil-mt / solo / IdleManyMessages / 6 | 51.305 | 50.497 | x0.984 | level | 2 of 4 | - | - | x0.992 | x1.001 | x0.549 |
| blake3-servil-mt / solo / IdleManyMessages / 8 | 34.567 | 33.738 | x0.976 | level | 2 of 4 | - | - | x0.986 | x1.001 | x0.426 |
| blake3-servil-mt / solo / IdleManyMessages / 12 | 31.709 | 31.478 | x0.993 | level | 3 of 4 | - | - | x1.004 | x1.001 | x2.902 |
| blake3-servil-mt / solo / IdleManyMessages / 16 | 18.660 | 18.150 | x0.973 | level | 4 of 4 | - | - | x0.994 | x1.001 | x1.119 |
| blake3-servil-mt / solo / IdleManyMessages / 24 | 17.153 | 17.582 | x1.025 | level | 1 of 4 | - | - | x0.997 | x1.001 | x0.829 |
| blake3-servil-mt / solo / IdleManyMessages / 32 | 13.273 | 13.107 | x0.987 | level | 3 of 4 | - | - | x0.990 | x1.001 | x0.777 |
| blake3-servil-mt / solo / IdleManyMessages / 48 | 11.565 | 11.431 | x0.988 | level | 2 of 4 | - | - | x0.989 | x1.000 | x0.897 |
| blake3-servil-mt / solo / IdleManyMessages / 64 | 10.602 | 10.519 | x0.992 | level | 2 of 4 | - | - | x1.005 | x1.000 | x9.689 |
| blake3-servil-mt / solo / IdleManyMessages / 128 | 9.330 | 9.127 | x0.978 | level | 3 of 4 | - | - | x1.001 | x1.000 | x1.407 |
| blake3-servil-mt / solo / IdleManyMessages / 256 | 8.793 | 8.590 | x0.977 | level | 4 of 4 | - | - | x0.994 | x1.000 | x0.497 |
| blake3-servil-mt / solo / IdleManyMessages / 512 | 8.356 | 8.286 | x0.992 | level | 2 of 4 | - | - | x0.991 | x1.000 | x0.138 |
| blake3-servil-mt / solo / IdleManyMessages / 1024 | 8.091 | 8.094 | x1.000 | level | 2 of 4 | - | - | x0.995 | x1.000 | x0.313 |
| blake3-servil-mt / solo / IdleManyMessages / 2048 | 7.946 | 7.972 | x1.003 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.428 |
| blake3-servil-mt / solo / IdleManyMessages / 4096 | 7.968 | 8.034 | x1.008 | level | 2 of 4 | - | - | x1.004 | x1.000 | x1.146 |
| blake3-servil-mt / solo / IdleManyMessages / 8192 | 3.729 | 3.481 | x0.933 | level | 4 of 4 | - | - | x0.947 | x1.029 | x1.012 |
| blake3-servil-mt / solo / IdleManyMessages / 16384 | 3.331 | 3.194 | x0.959 | level | 2 of 4 | - | - | x0.960 | x1.009 | x1.001 |
| blake3-servil-mt / solo / IdleManyMessages / 32768 | 2.870 | 2.763 | x0.963 | level | 3 of 4 | - | - | x0.969 | x1.004 | x0.992 |
| blake3-servil-mt / solo / IdleManyMessages / 65536 | 3.089 | 2.751 | x0.891 | level | 2 of 4 | - | - | x0.892 | x1.038 | x0.965 |
| blake3-servil-mt / solo / IdleManyMessages / 131072 | 4.132 | 4.159 | x1.007 | level | 2 of 4 | - | - | x1.006 | x0.993 | x0.992 |
| blake3-servil-mt / solo / IdleManyMessages / 262144 | 4.186 | 4.168 | x0.996 | level | 4 of 4 | - | - | x0.996 | x1.001 | x0.973 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 B | 3.081 | 3.072 | x0.997 | level | 2 of 4 | - | - | x0.990 | x1.004 | x1.125 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 B | 2.117 | 2.109 | x0.996 | level | 3 of 4 | - | - | x0.995 | x1.003 | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 B | 1.695 | 1.706 | x1.006 | level | 2 of 4 | - | - | x0.995 | x1.002 | x0.669 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 B | 1.459 | 1.459 | x1.000 | level | 3 of 4 | - | - | x0.998 | x1.001 | x0.700 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 KiB | 1.349 | 1.354 | x1.004 | level | 1 of 4 | - | - | x1.000 | x1.001 | x1.025 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1536 B | 1.013 | 1.023 | x1.010 | level | 1 of 4 | - | - | x1.000 | x0.998 | x1.535 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 KiB | 0.734 | 0.730 | x0.995 | level | 3 of 4 | - | - | x0.998 | x1.001 | x1.644 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2304 B | 0.821 | 0.811 | x0.988 | level | 4 of 4 | - | - | x0.991 | x1.001 | x1.173 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 KiB | 0.527 | 0.523 | x0.992 | level | 4 of 4 | - | - | x0.997 | x1.001 | x0.579 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3839 B | 0.430 | 0.427 | x0.992 | level | 4 of 4 | - | - | x0.996 | x1.001 | x2.739 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 KiB | 0.391 | 0.391 | x1.000 | level | 2 of 4 | - | - | x0.998 | x1.001 | x2.379 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4470 B | 0.485 | 0.481 | x0.991 | level | 3 of 4 | - | - | x0.996 | x1.001 | x0.412 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 7935 B | 0.240 | 0.240 | x0.999 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.946 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 KiB | 0.226 | 0.224 | x0.991 | level | 3 of 4 | - | - | x0.997 | x1.000 | x2.103 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 16 KiB | 0.126 | 0.127 | x1.012 | level | 0 of 4 | - | - | x0.999 | x1.000 | x4.425 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 KiB | 0.0883 | 0.0879 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.000 | x0.657 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 KiB | 0.0848 | 0.0809 | x0.954 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.705 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 KiB | 0.0777 | 0.0778 | x1.001 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.330 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 KiB | 0.0779 | 0.0774 | x0.994 | level | 3 of 4 | - | - | x0.997 | x1.000 | x2.131 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 KiB | 0.0582 | 0.0562 | x0.966 | level | 4 of 4 | - | - | x0.966 | x1.011 | x1.016 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 MiB | 0.0477 | 0.0474 | x0.994 | level | 2 of 4 | - | - | x0.997 | x1.001 | x0.996 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 MiB | 0.0707 | 0.0580 | x0.820 | level | 2 of 4 | - | - | x0.823 | x1.133 | x0.952 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 MiB | 0.0722 | 0.0589 | x0.817 | level | 4 of 4 | - | - | x0.817 | x1.116 | x0.947 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 MiB | 0.0521 | 0.0467 | x0.896 | level | 4 of 4 | - | - | x0.898 | x1.046 | x0.945 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 MiB | 0.0670 | 0.0671 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.003 | x0.970 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 MiB | 0.0315 | 0.0316 | x1.002 | level | 2 of 4 | - | - | x1.003 | x1.001 | x0.939 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 MiB | 0.0335 | 0.0335 | x1.002 | level | 2 of 4 | - | - | x1.003 | x1.001 | x0.957 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 MiB | 0.0334 | 0.0333 | x0.999 | level | 3 of 4 | - | - | x0.999 | x0.994 | x0.982 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1 | 208.819 | 203.945 | x0.977 | level | 4 of 4 | - | - | x0.995 | x1.003 | x1.180 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2 | 105.198 | 104.417 | x0.993 | level | 4 of 4 | - | - | x0.997 | x1.002 | x1.613 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 3 | 90.937 | 90.117 | x0.991 | level | 2 of 4 | - | - | x0.996 | x1.001 | x1.187 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4 | 52.453 | 52.703 | x1.005 | level | 2 of 4 | - | - | x0.996 | x1.001 | x1.239 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 6 | 45.738 | 45.601 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.001 | x0.799 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8 | 28.382 | 28.397 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.001 | x0.807 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 12 | 25.725 | 25.898 | x1.007 | level | 1 of 4 | - | - | x1.000 | x1.001 | x0.670 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16 | 14.791 | 14.713 | x0.995 | level | 2 of 4 | - | - | x0.995 | x1.001 | x0.738 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 24 | 13.733 | 13.690 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.001 | x1.277 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32 | 10.528 | 10.550 | x1.002 | level | 2 of 4 | - | - | x0.997 | x1.001 | x3.178 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 48 | 9.180 | 9.131 | x0.995 | level | 3 of 4 | - | - | x0.994 | x1.001 | x2.123 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 64 | 8.452 | 8.468 | x1.002 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.007 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 128 | 7.436 | 7.435 | x1.000 | level | 1 of 4 | - | - | x0.998 | x1.000 | x1.272 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 256 | 7.068 | 7.059 | x0.999 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.837 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 512 | 6.830 | 6.796 | x0.995 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.181 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1024 | 6.666 | 6.686 | x1.003 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.808 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2048 | 6.619 | 6.597 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.569 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4096 | 6.696 | 6.733 | x1.006 | level | 2 of 4 | - | - | x1.004 | x1.000 | x1.149 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8192 | 3.244 | 3.272 | x1.009 | level | 1 of 4 | - | - | x1.039 | x1.074 | x1.001 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16384 | 2.768 | 2.819 | x1.018 | level | 2 of 4 | - | - | x1.027 | x1.019 | x0.990 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32768 | 2.577 | 2.628 | x1.020 | level | 1 of 4 | - | - | x1.026 | x1.016 | x0.992 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 65536 | 2.705 | 2.705 | x1.000 | level | 2 of 4 | - | - | x1.003 | x1.013 | x0.980 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 131072 | 3.708 | 4.197 | x1.132 | level | 2 of 4 | - | - | x1.132 | x0.959 | x1.048 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 262144 | 4.221 | 4.203 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.005 | x0.965 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.446 | 0.416 | x0.932 | level | 4 of 4 | x0.858 | - | x0.933 | x0.979 | x1.130 |
| blake3-servil-mt / solo / ContinuousMessages / 128 B | 0.235 | 0.233 | x0.992 | level | 2 of 4 | x0.911 | - | x0.976 | x0.979 | x1.127 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.120 | 0.119 | x0.990 | level | 3 of 4 | x0.942 | - | x0.995 | x0.979 | x1.029 |
| blake3-servil-mt / solo / ContinuousMessages / 512 B | 0.0712 | 0.0647 | x0.909 | level | 3 of 4 | x0.839 | - | x0.911 | x0.981 | x1.118 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.0547 | 0.0524 | x0.957 | level | 4 of 4 | x0.808 | - | x0.966 | x0.990 | x1.086 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0460 | 0.0450 | x0.980 | level | 2 of 4 | x0.997 | - | x0.979 | x1.001 | x1.001 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0371 | 0.0388 | x1.047 | level | 2 of 4 | x0.740 | - | x1.047 | x1.018 | x1.008 |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.0337 | 0.0339 | x1.005 | level | 2 of 4 | x1.000 | - | x1.004 | x1.020 | x1.075 |
| blake3-servil-mt / solo / ContinuousMessages / 256 KiB | 0.0335 | 0.0332 | x0.994 | level | 2 of 4 | x0.992 | - | x0.993 | x1.016 | x1.013 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0295 | 0.0304 | x1.031 | level | 0 of 4 | x1.048 | - | x1.030 | x1.016 | x1.001 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.0306 | 0.0315 | x1.031 | level | 1 of 4 | x0.988 | - | x1.029 | x1.016 | x0.986 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0317 | 0.0326 | x1.026 | level | 1 of 4 | x1.039 | - | x1.024 | x1.015 | x1.013 |
| blake3-servil-mt / solo / ContinuousMessages / 64 MiB | 0.0348 | 0.0406 | x1.167 | level | 0 of 4 | x1.048 | - | x1.166 | x1.015 | x0.908 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 3.811 | 3.592 | x0.942 | level | 3 of 4 | x1.045 | - | x0.944 | x0.976 | x1.089 |
| blake3-servil-mt / solo / ContinuousBatches / 64 | 2.339 | 2.390 | x1.022 | level | 2 of 4 | x0.985 | - | x1.021 | x0.987 | x1.000 |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 2.714 | 2.691 | x0.991 | level | 3 of 4 | x0.987 | - | x1.012 | x0.996 | x1.038 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 2.396 | 2.468 | x1.030 | level | 2 of 4 | x1.023 | - | x1.007 | x0.981 | x0.924 |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 2.601 | 2.493 | x0.959 | level | 3 of 4 | x0.961 | - | x0.976 | x0.992 | x1.036 |
| blake3-servil-mt / solo / ContinuousBatches / 16384 | 2.523 | 2.599 | x1.030 | level | 1 of 4 | x1.036 | - | x1.032 | x0.999 | x0.996 |
| blake3-servil-mt / solo / ContinuousBatches / 65536 | 3.094 | 2.871 | x0.928 | level | 3 of 4 | x0.879 | - | x0.928 | x1.014 | x0.948 |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.940 | 0.940 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x1.149 |
| blake3-servil-mt / solo / LentMessages / 128 B | 1.078 | 1.080 | x1.003 | level | 1 of 4 | x1.003 | - | x1.002 | x1.000 | x0.571 |
| blake3-servil-mt / solo / LentMessages / 256 B | 1.152 | 1.152 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.678 |
| blake3-servil-mt / solo / LentMessages / 512 B | 1.189 | 1.189 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x1.180 |
| blake3-servil-mt / solo / LentMessages / 1 KiB | 1.212 | 1.212 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.493 |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.358 | 0.362 | x1.010 | level | 1 of 4 | x1.010 | - | x1.000 | x1.000 | x1.876 |
| blake3-servil-mt / solo / LentMessages / 16 KiB | 0.114 | 0.114 | x0.998 | level | 3 of 4 | x0.999 | - | x0.998 | x1.000 | x0.690 |
| blake3-servil-mt / solo / LentMessages / 64 KiB | 0.0809 | 0.0807 | x0.997 | level | 3 of 4 | x0.997 | - | x0.996 | x1.000 | x0.295 |
| blake3-servil-mt / solo / LentMessages / 256 KiB | 0.0759 | 0.0759 | x1.000 | level | 1 of 4 | x1.000 | - | x1.001 | x1.000 | x6.547 |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.0450 | 0.0455 | x1.012 | level | 2 of 4 | x0.994 | - | x1.015 | x1.006 | x1.003 |
| blake3-servil-mt / solo / LentMessages / 4 MiB | 0.0392 | 0.0392 | x1.000 | level | 1 of 4 | x0.992 | - | x1.001 | x0.994 | x1.076 |
| blake3-servil-mt / solo / LentMessages / 16 MiB | 0.0340 | 0.0340 | x0.999 | level | 2 of 4 | x1.007 | - | x1.001 | x1.001 | x0.999 |
| blake3-servil-mt / solo / LentMessages / 64 MiB | 0.0338 | 0.0339 | x1.003 | level | 2 of 4 | x1.005 | - | x1.003 | x1.000 | x1.006 |
| blake3-servil-mt / solo / Interleaved / 256 | 0.137 | 0.137 | x0.999 | level | 2 of 4 | x0.999 | - | x0.998 | x1.000 | x1.004 |
| blake3-servil-mt / solo / Collection / git objects | 0.00830 | 0.00828 | x0.997 | level | 2 of 4 | x0.992 | - | x1.003 | x0.998 | x0.999 |
| blake3-servil-mt / solo / Collection / Nix files | 0.0112 | 0.0112 | x0.998 | level | 2 of 4 | x1.007 | - | x1.007 | x0.995 | x1.008 |
| blake3-servil-mt / solo / LentBatches / 16 | 7.552 | 7.532 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x0.998 | x0.898 |
| blake3-servil-mt / solo / LentBatches / 64 | 6.642 | 6.649 | x1.001 | level | 1 of 4 | x1.001 | - | x1.000 | x0.999 | x0.307 |
| blake3-servil-mt / solo / LentBatches / 256 | 6.611 | 6.671 | x1.009 | level | 0 of 4 | x1.009 | - | x1.008 | x1.000 | x25.992 |
| blake3-servil-mt / solo / LentBatches / 1024 | 7.039 | 7.090 | x1.007 | level | 1 of 4 | x1.007 | - | x1.005 | x1.000 | x0.774 |
| blake3-servil-mt / solo / LentBatches / 4096 | 6.841 | 6.835 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x3.557 |
| blake3-servil-mt / solo / LentBatches / 16384 | 3.211 | 3.192 | x0.994 | level | 3 of 4 | x0.991 | - | x0.994 | x0.997 | x0.999 |
| blake3-servil-mt / solo / LentBatches / 65536 | 2.963 | 2.895 | x0.977 | level | 3 of 4 | x0.980 | - | x0.978 | x0.996 | x0.994 |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.0404 | 0.0397 | x0.982 | level | 3 of 4 | x1.018 | - | x0.973 | x1.009 | x0.984 |
| blake3-servil-mt / solo / ContinuousCollection / Nix files | 0.0393 | 0.0383 | x0.974 | level | 3 of 4 | x1.019 | - | x0.974 | x1.006 | x0.986 |
| blake3-servil-mt / solo / MerkleTree / 1024 | 0.123 | 0.124 | x1.011 | level | 0 of 4 | x1.011 | - | x1.010 | x1.001 | x6.461 |
| blake3-servil-mt / solo / MerkleTree / 4096 | 0.0700 | 0.0700 | x1.000 | level | 1 of 4 | x1.001 | - | x0.997 | x0.996 | x1.002 |
| blake3-servil-mt / solo / MerkleTree / 16384 | 0.0623 | 0.0699 | x1.123 | level | 1 of 4 | x1.271 | - | x1.123 | x0.984 | x1.074 |
| blake3-servil-mt / solo / MerkleTree / 65536 | 0.0732 | 0.0753 | x1.028 | level | 2 of 4 | x0.998 | - | x1.030 | x1.001 | x1.049 |
| blake3-servil-mt / solo / MerkleTree / 262144 | 0.0483 | 0.0496 | x1.026 | level | 2 of 4 | x1.058 | - | x1.027 | x0.988 | x1.098 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 32 B | 0.0939 | 0.0982 | x1.046 | level | 2 of 4 | x1.145 | - | x1.044 | x0.981 | x0.939 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 32 B | 0.0611 | 0.0611 | x1.000 | level | 2 of 4 | x1.008 | - | x1.000 | x1.001 | x0.988 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 16 B | 0.130 | 0.132 | x1.015 | level | 2 of 4 | x1.005 | - | x1.015 | x1.014 | x1.005 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 48 B | 0.0688 | 0.0696 | x1.011 | level | 3 of 4 | x1.039 | - | x1.009 | x0.998 | x0.816 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 48 B | 0.0523 | 0.0522 | x1.000 | level | 3 of 4 | x1.005 | - | x1.001 | x1.007 | x0.940 |
| blake3-servil-mt / solo / InterleavedTurn / 256 | 0.304 | 0.297 | x0.978 | level | 3 of 4 | - | - | x0.963 | x0.899 | x0.969 |
| blake3-servil-mt / solo / InterleavedTurn / 1024 x 1 KiB | 0.148 | 0.142 | x0.960 | level | 3 of 4 | - | - | x0.964 | x0.994 | x1.070 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 256 | 0.194 | 0.185 | x0.955 | level | 3 of 4 | - | - | x0.967 | x0.939 | x0.996 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.142 | 0.138 | x0.969 | level | 4 of 4 | - | - | x0.973 | x0.996 | x0.883 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 256 | 0.224 | 0.214 | x0.956 | level | 4 of 4 | - | - | x0.951 | x0.963 | x1.006 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.138 | 0.135 | x0.978 | level | 4 of 4 | - | - | x0.975 | x0.997 | x0.902 |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.0343 | 0.0349 | x1.016 | level | 1 of 4 | x1.057 | - | x1.015 | x1.011 | x0.984 |
| blake3-servil-mt / solo / ReceivingMessage / 2 μs | 0.0921 | 0.0920 | x1.000 | level | 2 of 4 | x0.992 | - | x0.991 | x1.013 | x0.959 |
| blake3-servil-mt / solo / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 4 of 4 | x1.170 | - | x0.913 | x1.014 | x0.902 |
| blake3-servil-mt / solo / IncrementalMessage / 64 B | 6.665 | 6.543 | x0.982 | level | 2 of 4 | - | - | x0.958 | x1.001 | x0.980 |
| blake3-servil-mt / solo / IncrementalMessage / 1 KiB | 1.854 | 1.845 | x0.995 | level | 2 of 4 | - | - | x0.994 | x1.000 | x1.045 |
| blake3-servil-mt / solo / IncrementalMessage / 4 KiB | 0.631 | 0.627 | x0.994 | level | 3 of 4 | - | - | x0.985 | x0.999 | x1.026 |
| blake3-servil-mt / solo / LentIncrementalMessage / 64 B | 0.946 | 0.947 | x1.001 | level | 0 of 4 | x1.001 | - | x1.001 | x1.000 | x0.252 |
| blake3-servil-mt / solo / LentIncrementalMessage / 1 KiB | 1.244 | 1.245 | x1.001 | level | 1 of 4 | x1.000 | - | x1.000 | x1.000 | x0.701 |
| blake3-servil-mt / solo / LentIncrementalMessage / 4 KiB | 0.365 | 0.365 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x0.111 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 5.451 | 5.115 | x0.938 | level | 3 of 4 | x0.903 | - | x0.937 | x0.994 | x1.071 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 4 KiB | 0.0886 | 0.0679 | x0.767 | level | 4 of 4 | x0.754 | - | x0.766 | x1.011 | x1.009 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 1 MiB | 0.0297 | 0.0299 | x1.007 | level | 1 of 4 | x0.971 | - | x1.007 | x1.015 | x0.999 |
| blake3-servil-mt / solo / ContinuousLentMessages / 64 B | 0.372 | 0.373 | x1.004 | level | 2 of 4 | x0.764 | - | x0.977 | x0.976 | x1.105 |
| blake3-servil-mt / solo / ContinuousLentMessages / 4 KiB | 0.0350 | 0.0359 | x1.026 | level | 1 of 4 | x1.017 | - | x1.005 | x1.000 | x1.074 |
| blake3-servil-mt / solo / ContinuousLentMessages / 1 MiB | 0.00352 | 0.00351 | x0.998 | level | 2 of 4 | x0.994 | - | x1.003 | x1.013 | x0.940 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.428 | 0.427 | x0.998 | level | 2 of 4 | - | - | x0.998 | x0.979 | x0.966 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 128 B | 0.224 | 0.225 | x1.005 | level | 1 of 4 | - | - | x1.005 | x0.979 | x0.945 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.124 | 0.126 | x1.016 | level | 1 of 4 | - | - | x1.017 | x0.979 | x0.959 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 512 B | 0.0749 | 0.0799 | x1.067 | level | 0 of 4 | - | - | x1.065 | x0.981 | x0.953 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.0597 | 0.0618 | x1.034 | level | 1 of 4 | - | - | x1.038 | x0.990 | x0.948 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.0922 | 0.0932 | x1.010 | level | 2 of 4 | - | - | x1.022 | x1.003 | x0.977 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.0477 | 0.0462 | x0.968 | level | 3 of 4 | - | - | x0.981 | x1.011 | x0.992 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.0398 | 0.0395 | x0.992 | level | 3 of 4 | - | - | x0.997 | x1.020 | x0.980 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 KiB | 0.0376 | 0.0377 | x1.001 | level | 2 of 4 | - | - | x1.003 | x1.016 | x0.960 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0382 | 0.0389 | x1.017 | level | 1 of 4 | - | - | x1.021 | x1.015 | x1.007 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.0401 | 0.0401 | x0.999 | level | 2 of 4 | - | - | x1.003 | x1.016 | x1.009 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.0470 | 0.0487 | x1.035 | level | 2 of 4 | - | - | x1.037 | x1.015 | x0.976 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 MiB | 0.0513 | 0.0524 | x1.021 | level | 2 of 4 | - | - | x1.023 | x1.015 | x0.940 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 4.145 | 4.191 | x1.011 | level | 1 of 4 | - | - | x1.011 | x0.976 | x1.001 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 64 | 3.120 | 2.979 | x0.955 | level | 4 of 4 | - | - | x0.957 | x0.988 | x1.024 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 256 | 3.124 | 3.086 | x0.988 | level | 3 of 4 | - | - | x0.993 | x0.997 | x1.015 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 2.912 | 2.927 | x1.005 | level | 2 of 4 | - | - | x1.007 | x0.983 | x1.005 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 4096 | 3.303 | 3.163 | x0.958 | level | 3 of 4 | - | - | x0.976 | x0.981 | x0.985 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16384 | 2.976 | 2.848 | x0.957 | level | 2 of 4 | - | - | x0.961 | x0.991 | x0.995 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 65536 | 3.387 | 3.086 | x0.911 | level | 3 of 4 | - | - | x0.906 | x1.012 | x0.816 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.939 | 0.941 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.987 |
| blake3-servil-mt / shared-one-cache / LentMessages / 128 B | 1.078 | 1.079 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.914 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 B | 1.151 | 1.151 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.156 |
| blake3-servil-mt / shared-one-cache / LentMessages / 512 B | 1.188 | 1.188 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.952 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 KiB | 1.212 | 1.212 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.190 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.358 | 0.365 | x1.019 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.158 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 KiB | 0.114 | 0.114 | x0.997 | level | 4 of 4 | - | - | x0.997 | x1.000 | x1.081 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 KiB | 0.0813 | 0.0812 | x0.998 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.123 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 KiB | 0.0764 | 0.0761 | x0.997 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.202 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 MiB | 0.0529 | 0.0532 | x1.006 | level | 2 of 4 | - | - | x1.009 | x1.007 | x0.991 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 MiB | 0.0434 | 0.0431 | x0.993 | level | 2 of 4 | - | - | x0.991 | x0.994 | x1.006 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 MiB | 0.0566 | 0.0559 | x0.988 | level | 3 of 4 | - | - | x0.988 | x0.959 | x1.010 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 MiB | 0.0509 | 0.0503 | x0.988 | level | 3 of 4 | - | - | x0.980 | x0.976 | x0.982 |
| blake3-servil-mt / shared-one-cache / Interleaved / 256 | 0.137 | 0.137 | x1.000 | level | 3 of 4 | - | - | x1.000 | x0.999 | x0.997 |
| blake3-servil-mt / shared-one-cache / Collection / git objects | 0.0154 | 0.0160 | x1.036 | level | 1 of 4 | - | - | x0.943 | x0.935 | x0.930 |
| blake3-servil-mt / shared-one-cache / Collection / Nix files | 0.0175 | 0.0176 | x1.008 | level | 2 of 4 | - | - | x1.007 | x1.022 | x1.015 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16 | 7.549 | 7.581 | x1.004 | level | 0 of 4 | - | - | x1.004 | x0.998 | x1.134 |
| blake3-servil-mt / shared-one-cache / LentBatches / 64 | 6.639 | 6.647 | x1.001 | level | 1 of 4 | - | - | x1.001 | x0.999 | x1.133 |
| blake3-servil-mt / shared-one-cache / LentBatches / 256 | 6.580 | 6.596 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.110 |
| blake3-servil-mt / shared-one-cache / LentBatches / 1024 | 7.046 | 7.043 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.194 |
| blake3-servil-mt / shared-one-cache / LentBatches / 4096 | 6.829 | 6.903 | x1.011 | level | 1 of 4 | - | - | x1.011 | x1.000 | x3.322 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16384 | 3.689 | 3.658 | x0.991 | level | 2 of 4 | - | - | x0.989 | x0.993 | x1.020 |
| blake3-servil-mt / shared-one-cache / LentBatches / 65536 | 3.334 | 3.033 | x0.910 | level | 4 of 4 | - | - | x0.916 | x1.021 | x0.988 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.0589 | 0.0597 | x1.014 | level | 0 of 4 | - | - | x1.024 | x1.009 | x0.986 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / Nix files | 0.0577 | 0.0586 | x1.015 | level | 1 of 4 | - | - | x1.016 | x1.006 | x0.975 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1024 | 0.124 | 0.124 | x1.006 | level | 0 of 4 | - | - | x1.007 | x1.001 | x1.708 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 4096 | 0.0768 | 0.0755 | x0.983 | level | 3 of 4 | - | - | x0.982 | x0.994 | x0.999 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 16384 | 0.104 | 0.0990 | x0.955 | level | 3 of 4 | - | - | x0.954 | x1.011 | x0.933 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 | 0.125 | 0.124 | x0.992 | level | 2 of 4 | - | - | x0.992 | x1.001 | x1.001 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 262144 | 0.0698 | 0.0695 | x0.996 | level | 3 of 4 | - | - | x0.989 | x1.004 | x1.005 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 32 B | 0.171 | 0.190 | x1.109 | level | 0 of 4 | - | - | x1.111 | x0.903 | x1.176 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 32 B | 0.0801 | 0.0807 | x1.008 | level | 3 of 4 | - | - | x1.004 | x1.028 | x1.025 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 16 B | 0.178 | 0.181 | x1.013 | level | 1 of 4 | - | - | x1.010 | x1.015 | x1.034 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 48 B | 0.131 | 0.124 | x0.947 | level | 2 of 4 | - | - | x0.942 | x1.016 | x0.866 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 48 B | 0.0676 | 0.0677 | x1.003 | level | 1 of 4 | - | - | x1.004 | x1.015 | x1.015 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.0491 | 0.0496 | x1.010 | level | 1 of 4 | - | - | x1.012 | x1.007 | x0.964 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 2 μs | 0.0922 | 0.0921 | x0.999 | level | 4 of 4 | - | - | x0.960 | x1.020 | x1.004 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 4 of 4 | - | - | x0.922 | x0.999 | x0.779 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 64 B | 0.946 | 0.956 | x1.010 | level | 1 of 4 | - | - | x1.010 | x1.000 | x1.029 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 1 KiB | 1.244 | 1.244 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.933 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 4 KiB | 0.364 | 0.365 | x1.002 | level | 0 of 4 | - | - | x1.001 | x1.000 | x0.909 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 17.303 | 17.257 | x0.997 | level | 2 of 4 | - | - | x1.027 | x1.010 | x1.102 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 4 KiB | 0.271 | 0.253 | x0.932 | level | 3 of 4 | - | - | x0.882 | x1.002 | x0.987 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 1 MiB | 0.0393 | 0.0393 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.015 | x1.003 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 64 B | 0.357 | 0.356 | x0.999 | level | 3 of 4 | - | - | x0.999 | x0.976 | x0.968 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 4 KiB | 0.0819 | 0.0801 | x0.977 | level | 2 of 4 | - | - | x1.009 | x0.984 | x1.053 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 1 MiB | 0.00651 | 0.00605 | x0.929 | level | 4 of 4 | - | - | x0.985 | x0.982 | x0.963 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 B | 0.890 | 0.680 | x0.764 | faster | 4 of 4 | - | - | x0.764 | x0.979 | x0.941 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 128 B | 0.470 | 0.393 | x0.835 | level | 3 of 4 | - | - | x0.834 | x0.979 | x0.931 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 256 B | 0.258 | 0.230 | x0.893 | level | 3 of 4 | - | - | x0.891 | x0.979 | x0.859 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 512 B | 0.159 | 0.149 | x0.933 | level | 2 of 4 | - | - | x0.932 | x0.981 | x0.854 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 KiB | 0.135 | 0.0950 | x0.705 | level | 4 of 4 | - | - | x0.707 | x0.990 | x0.918 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 4 KiB | 0.0885 | 0.0852 | x0.963 | level | 3 of 4 | - | - | x0.960 | x1.008 | x0.979 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 16 KiB | 0.0934 | 0.0664 | x0.711 | level | 3 of 4 | - | - | x0.714 | x1.011 | x1.004 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 KiB | 0.0853 | 0.0624 | x0.731 | level | 4 of 4 | - | - | x0.737 | x1.020 | x1.000 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 256 KiB | 0.0791 | 0.0625 | x0.790 | level | 4 of 4 | - | - | x0.789 | x1.019 | x0.998 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 MiB | 0.0726 | 0.0571 | x0.787 | level | 4 of 4 | - | - | x0.786 | x1.018 | x0.983 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 4 MiB | 0.0750 | 0.0544 | x0.725 | level | 4 of 4 | - | - | x0.732 | x1.016 | x0.992 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 16 MiB | 0.0766 | 0.0569 | x0.743 | level | 4 of 4 | - | - | x0.748 | x1.015 | x0.982 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 MiB | 0.0816 | 0.0652 | x0.799 | level | 4 of 4 | - | - | x0.798 | x1.018 | x1.026 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 16 | 9.741 | 8.720 | x0.895 | level | 4 of 4 | - | - | x0.892 | x0.976 | x0.994 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 64 | 6.980 | 6.522 | x0.934 | level | 3 of 4 | - | - | x0.942 | x0.988 | x0.949 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 256 | 6.899 | 6.117 | x0.887 | level | 4 of 4 | - | - | x0.885 | x0.998 | x0.926 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 1024 | 6.222 | 4.900 | x0.788 | faster | 4 of 4 | - | - | x0.791 | x0.985 | x0.986 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 4096 | 5.282 | 5.326 | x1.008 | level | 2 of 4 | - | - | x1.009 | x0.991 | x0.986 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 16384 | 4.299 | 4.373 | x1.017 | level | 1 of 4 | - | - | x1.018 | x1.000 | x0.987 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 65536 | 3.225 | 3.015 | x0.935 | level | 3 of 4 | - | - | x0.935 | x1.001 | x0.954 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 B | 0.940 | 0.939 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.234 |
| blake3-servil-mt / shared-two-caches / LentMessages / 128 B | 1.077 | 1.079 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.945 |
| blake3-servil-mt / shared-two-caches / LentMessages / 256 B | 1.151 | 1.151 | x1.000 | level | 4 of 4 | - | - | x1.000 | x1.000 | x0.906 |
| blake3-servil-mt / shared-two-caches / LentMessages / 512 B | 1.188 | 1.189 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.126 |
| blake3-servil-mt / shared-two-caches / LentMessages / 1 KiB | 1.211 | 1.212 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.044 |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 KiB | 0.358 | 0.358 | x0.999 | level | 4 of 4 | - | - | x0.999 | x1.000 | x0.860 |
| blake3-servil-mt / shared-two-caches / LentMessages / 16 KiB | 0.114 | 0.114 | x0.997 | level | 4 of 4 | - | - | x0.997 | x1.000 | x0.925 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 KiB | 0.0811 | 0.0810 | x0.999 | level | 4 of 4 | - | - | x0.998 | x1.000 | x1.069 |
| blake3-servil-mt / shared-two-caches / LentMessages / 256 KiB | 0.0775 | 0.0773 | x0.997 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.140 |
| blake3-servil-mt / shared-two-caches / LentMessages / 1 MiB | 0.0633 | 0.0629 | x0.994 | level | 3 of 4 | - | - | x0.995 | x1.015 | x0.992 |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 MiB | 0.0430 | 0.0419 | x0.972 | level | 3 of 4 | - | - | x0.974 | x1.007 | x0.962 |
| blake3-servil-mt / shared-two-caches / LentMessages / 16 MiB | 0.0361 | 0.0387 | x1.074 | level | 1 of 4 | - | - | x1.075 | x0.981 | x1.074 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 MiB | 0.0377 | 0.0377 | x1.000 | level | 1 of 4 | - | - | x1.000 | x0.994 | x0.987 |
| blake3-servil-mt / shared-two-caches / Interleaved / 256 | 0.137 | 0.136 | x0.998 | level | 3 of 4 | - | - | x0.998 | x0.999 | x0.994 |
| blake3-servil-mt / shared-two-caches / Collection / git objects | 0.0152 | 0.0155 | x1.019 | level | 0 of 4 | - | - | x0.991 | x0.979 | x0.966 |
| blake3-servil-mt / shared-two-caches / Collection / Nix files | 0.0172 | 0.0174 | x1.011 | level | 1 of 4 | - | - | x1.004 | x0.990 | x0.989 |
| blake3-servil-mt / shared-two-caches / LentBatches / 16 | 7.547 | 7.570 | x1.003 | level | 0 of 4 | - | - | x1.003 | x0.998 | x1.025 |
| blake3-servil-mt / shared-two-caches / LentBatches / 64 | 6.635 | 6.632 | x1.000 | level | 2 of 4 | - | - | x1.000 | x0.999 | x0.780 |
| blake3-servil-mt / shared-two-caches / LentBatches / 256 | 6.578 | 6.588 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.709 |
| blake3-servil-mt / shared-two-caches / LentBatches / 1024 | 7.036 | 7.034 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.513 |
| blake3-servil-mt / shared-two-caches / LentBatches / 4096 | 6.972 | 7.033 | x1.009 | level | 2 of 4 | - | - | x1.009 | x1.000 | x3.131 |
| blake3-servil-mt / shared-two-caches / LentBatches / 16384 | 4.220 | 4.157 | x0.985 | level | 2 of 4 | - | - | x0.984 | x0.992 | x1.007 |
| blake3-servil-mt / shared-two-caches / LentBatches / 65536 | 2.967 | 2.944 | x0.992 | level | 1 of 4 | - | - | x0.994 | x0.997 | x0.983 |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / git objects | 0.0740 | 0.0653 | x0.883 | level | 3 of 4 | - | - | x0.890 | x1.009 | x0.979 |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / Nix files | 0.0733 | 0.0661 | x0.901 | level | 3 of 4 | - | - | x0.900 | x1.007 | x0.989 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1024 | 0.126 | 0.126 | x1.006 | level | 0 of 4 | - | - | x1.006 | x1.001 | x1.696 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 4096 | 0.0739 | 0.0736 | x0.996 | level | 2 of 4 | - | - | x0.999 | x1.002 | x1.000 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 16384 | 0.0874 | 0.0839 | x0.960 | level | 2 of 4 | - | - | x0.960 | x1.007 | x1.000 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 | 0.0832 | 0.0843 | x1.013 | level | 1 of 4 | - | - | x1.014 | x0.993 | x1.039 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 262144 | 0.0617 | 0.0608 | x0.985 | level | 2 of 4 | - | - | x0.984 | x1.026 | x0.950 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 x 32 B | 0.179 | 0.179 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.011 | x1.001 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 32 B | 0.0805 | 0.0796 | x0.989 | level | 3 of 4 | - | - | x0.989 | x1.007 | x1.001 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 16 B | 0.157 | 0.157 | x0.998 | level | 2 of 4 | - | - | x0.998 | x1.025 | x0.981 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 x 48 B | 0.138 | 0.122 | x0.883 | level | 4 of 4 | - | - | x0.884 | x1.107 | x0.832 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 48 B | 0.0646 | 0.0647 | x1.001 | level | 2 of 4 | - | - | x1.004 | x1.006 | x1.050 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / saturated | 0.0799 | 0.0629 | x0.787 | level | 4 of 4 | - | - | x0.788 | x1.012 | x0.999 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / 2 μs | 0.102 | 0.0923 | x0.903 | faster | 4 of 4 | - | - | x0.899 | x1.006 | x1.043 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 4 of 4 | - | - | x0.841 | x0.985 | x0.976 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 64 B | 0.945 | 0.955 | x1.010 | level | 1 of 4 | - | - | x1.009 | x1.000 | x1.029 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 1 KiB | 1.244 | 1.245 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.952 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 4 KiB | 0.364 | 0.365 | x1.001 | level | 0 of 4 | - | - | x1.001 | x1.000 | x1.097 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 64 B | 17.320 | 18.005 | x1.040 | level | 0 of 4 | - | - | x1.115 | x0.992 | x1.084 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 4 KiB | 0.272 | 0.261 | x0.957 | level | 3 of 4 | - | - | x0.954 | x1.005 | x0.992 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 1 MiB | 0.0789 | 0.0598 | x0.758 | faster | 4 of 4 | - | - | x0.766 | x1.018 | x0.989 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 64 B | 0.419 | 0.432 | x1.030 | level | 1 of 4 | - | - | x1.030 | x0.976 | x0.875 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 4 KiB | 0.0664 | 0.0649 | x0.978 | level | 3 of 4 | - | - | x1.017 | x0.987 | x1.043 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 1 MiB | 0.00709 | 0.00662 | x0.934 | level | 2 of 4 | - | - | x0.973 | x0.973 | x0.923 |

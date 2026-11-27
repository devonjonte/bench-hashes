# Nightly drift check: e1966b498bc7 -> 0997700f35b0

- Host: fast-feedback-icelake-147
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
| blake3-servil-st / solo / IdleOneMessage / 64 B | 8.377 | 8.499 | x1.015 | level | 25 of 64 | - | - | x1.008 | x1.005 | x1.007 |
| blake3-servil-st / solo / IdleOneMessage / 128 B | 6.072 | 6.157 | x1.014 | level | 31 of 64 | - | - | x1.007 | x1.004 | x0.813 |
| blake3-servil-st / solo / IdleOneMessage / 256 B | 4.799 | 4.806 | x1.002 | level | 29 of 64 | - | - | x1.004 | x1.003 | x1.070 |
| blake3-servil-st / solo / IdleOneMessage / 8 KiB | 2.388 | 2.353 | x0.985 | level | 45 of 64 | - | - | x1.001 | x1.000 | x1.427 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1 | 226.789 | 231.472 | x1.021 | level | 24 of 64 | - | - | x1.005 | x1.009 | - |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 1.515 | 1.526 | x1.007 | level | 14 of 64 | x1.007 | - | x1.007 | x1.012 | - |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 1.458 | 1.466 | x1.005 | level | 27 of 64 | x1.005 | - | x1.005 | x1.013 | - |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 1.387 | 1.421 | x1.024 | level | 3 of 64 | x1.024 | - | x1.024 | x1.015 | - |

## Stage 1 (initial screen, kept-drift)

compare: old side: bench 3f119a507807 clean; servil e1966b498bc7 clean
compare: new side: bench 3f119a507807 clean; servil 0997700f35b0 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 20.003 | 19.191 | x0.959 | level | 3 of 4 | - | - | x0.963 | x1.005 | x1.001 |
| blake3-servil-st / solo / OneMessage / 128 B | 11.321 | 10.915 | x0.964 | level | 3 of 4 | - | - | x0.977 | x1.004 | x1.014 |
| blake3-servil-st / solo / OneMessage / 256 B | 6.007 | 5.939 | x0.989 | level | 2 of 4 | - | - | x0.987 | x1.002 | x1.035 |
| blake3-servil-st / solo / OneMessage / 512 B | 3.784 | 3.692 | x0.976 | level | 4 of 4 | - | - | x0.972 | x1.002 | x1.028 |
| blake3-servil-st / solo / OneMessage / 1 KiB | 2.629 | 2.647 | x1.007 | level | 2 of 4 | - | - | x1.008 | x1.001 | x1.017 |
| blake3-servil-st / solo / OneMessage / 1536 B | 4.827 | 4.778 | x0.990 | level | 4 of 4 | - | - | x0.993 | x0.998 | x0.999 |
| blake3-servil-st / solo / OneMessage / 2 KiB | 4.182 | 4.229 | x1.011 | level | 1 of 4 | - | - | x1.008 | x1.001 | x0.986 |
| blake3-servil-st / solo / OneMessage / 2304 B | 4.426 | 4.459 | x1.007 | level | 1 of 4 | - | - | x1.011 | x1.001 | x1.020 |
| blake3-servil-st / solo / OneMessage / 3 KiB | 3.119 | 3.110 | x0.997 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.007 |
| blake3-servil-st / solo / OneMessage / 3839 B | 2.742 | 2.744 | x1.001 | level | 1 of 4 | - | - | x0.993 | x1.001 | x1.017 |
| blake3-servil-st / solo / OneMessage / 4 KiB | 2.313 | 2.328 | x1.007 | level | 0 of 4 | - | - | x1.007 | x1.000 | x1.034 |
| blake3-servil-st / solo / OneMessage / 4470 B | 2.526 | 2.603 | x1.031 | level | 1 of 4 | - | - | x1.019 | x1.001 | x1.032 |
| blake3-servil-st / solo / OneMessage / 7935 B | 2.023 | 2.036 | x1.007 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.995 |
| blake3-servil-st / solo / OneMessage / 8 KiB | 1.837 | 1.851 | x1.007 | level | 1 of 4 | - | - | x1.007 | x1.000 | x1.019 |
| blake3-servil-st / solo / OneMessage / 16 KiB | 1.328 | 1.339 | x1.008 | level | 1 of 4 | - | - | x1.005 | x1.000 | x0.995 |
| blake3-servil-st / solo / OneMessage / 32 KiB | 1.240 | 1.237 | x0.998 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.962 |
| blake3-servil-st / solo / OneMessage / 64 KiB | 1.050 | 1.057 | x1.007 | level | 1 of 4 | - | - | x1.008 | x1.000 | x0.952 |
| blake3-servil-st / solo / OneMessage / 128 KiB | 0.670 | 0.670 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.990 |
| blake3-servil-st / solo / OneMessage / 256 KiB | 0.485 | 0.485 | x1.001 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.006 |
| blake3-servil-st / solo / OneMessage / 512 KiB | 0.421 | 0.421 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.994 |
| blake3-servil-st / solo / OneMessage / 1 MiB | 0.396 | 0.395 | x0.997 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.997 |
| blake3-servil-st / solo / OneMessage / 2 MiB | 0.386 | 0.388 | x1.006 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.981 |
| blake3-servil-st / solo / OneMessage / 3 MiB | 0.381 | 0.382 | x1.002 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.002 |
| blake3-servil-st / solo / OneMessage / 4 MiB | 0.379 | 0.379 | x1.000 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.994 |
| blake3-servil-st / solo / OneMessage / 8 MiB | 0.380 | 0.382 | x1.005 | level | 0 of 4 | - | - | x1.003 | x1.000 | x1.017 |
| blake3-servil-st / solo / OneMessage / 32 MiB | 0.355 | 0.355 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.999 |
| blake3-servil-st / solo / OneMessage / 64 MiB | 0.355 | 0.354 | x0.999 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.002 |
| blake3-servil-st / solo / OneMessage / 128 MiB | 0.354 | 0.355 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.997 |
| blake3-servil-st / solo / ManyMessages / 1 | 1064.085 | 1031.010 | x0.969 | level | 3 of 4 | - | - | x0.984 | x1.009 | x0.887 |
| blake3-servil-st / solo / ManyMessages / 2 | 835.090 | 868.883 | x1.040 | level | 2 of 4 | - | - | x1.025 | x0.997 | x0.912 |
| blake3-servil-st / solo / ManyMessages / 3 | 649.323 | 661.405 | x1.019 | level | 3 of 4 | - | - | x1.010 | x0.998 | x0.887 |
| blake3-servil-st / solo / ManyMessages / 4 | 406.059 | 411.383 | x1.013 | level | 2 of 4 | - | - | x1.011 | x0.997 | x0.906 |
| blake3-servil-st / solo / ManyMessages / 6 | 348.255 | 349.866 | x1.005 | level | 2 of 4 | - | - | x0.999 | x0.998 | x0.879 |
| blake3-servil-st / solo / ManyMessages / 8 | 248.696 | 248.057 | x0.997 | level | 2 of 4 | - | - | x0.997 | x0.999 | x0.909 |
| blake3-servil-st / solo / ManyMessages / 12 | 202.771 | 201.962 | x0.996 | level | 2 of 4 | - | - | x0.992 | x0.998 | x0.878 |
| blake3-servil-st / solo / ManyMessages / 16 | 145.231 | 153.488 | x1.057 | level | 1 of 4 | - | - | x1.043 | x0.998 | x0.899 |
| blake3-servil-st / solo / ManyMessages / 24 | 134.769 | 136.625 | x1.014 | level | 1 of 4 | - | - | x1.021 | x0.999 | x0.873 |
| blake3-servil-st / solo / ManyMessages / 32 | 109.960 | 113.019 | x1.028 | level | 1 of 4 | - | - | x1.027 | x0.999 | x0.845 |
| blake3-servil-st / solo / ManyMessages / 48 | 95.048 | 98.444 | x1.036 | level | 1 of 4 | - | - | x1.028 | x0.999 | x0.862 |
| blake3-servil-st / solo / ManyMessages / 64 | 90.200 | 93.166 | x1.033 | level | 2 of 4 | - | - | x1.023 | x0.999 | x0.853 |
| blake3-servil-st / solo / ManyMessages / 128 | 83.294 | 84.282 | x1.012 | level | 1 of 4 | - | - | x1.006 | x1.000 | x0.903 |
| blake3-servil-st / solo / ManyMessages / 256 | 79.284 | 80.046 | x1.010 | level | 1 of 4 | - | - | x1.006 | x1.000 | x0.954 |
| blake3-servil-st / solo / ManyMessages / 512 | 77.913 | 77.806 | x0.999 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.934 |
| blake3-servil-st / solo / ManyMessages / 1024 | 66.018 | 66.178 | x1.002 | level | 3 of 4 | - | - | x1.003 | x1.000 | x0.957 |
| blake3-servil-st / solo / ManyMessages / 2048 | 42.569 | 42.699 | x1.003 | level | 1 of 4 | - | - | x1.005 | x1.000 | x0.973 |
| blake3-servil-st / solo / ManyMessages / 4096 | 31.193 | 31.039 | x0.995 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.996 |
| blake3-servil-st / solo / ManyMessages / 8192 | 27.383 | 27.215 | x0.994 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.001 |
| blake3-servil-st / solo / ManyMessages / 16384 | 25.292 | 25.267 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.005 |
| blake3-servil-st / solo / ManyMessages / 32768 | 24.839 | 24.680 | x0.994 | level | 4 of 4 | - | - | x0.994 | x1.000 | x0.997 |
| blake3-servil-st / solo / ManyMessages / 65536 | 24.698 | 24.494 | x0.992 | level | 4 of 4 | - | - | x0.992 | x1.000 | x1.016 |
| blake3-servil-st / solo / ManyMessages / 131072 | 24.809 | 24.705 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.011 |
| blake3-servil-st / solo / ManyMessages / 262144 | 25.430 | 25.210 | x0.991 | level | 4 of 4 | - | - | x0.991 | x1.000 | x1.003 |
| blake3-servil-st / solo / ManyLongMessages / 4 | 8195.379 | 8164.494 | x0.996 | level | 2 of 4 | - | - | x1.001 | x1.001 | x0.972 |
| blake3-servil-st / solo / ManyLongMessages / 16 | 4985.936 | 4222.999 | x0.847 | faster | 4 of 4 | - | - | x0.849 | x0.566 | x1.048 |
| blake3-servil-st / solo / ManyLongMessages / 64 | 1980.282 | 1977.143 | x0.998 | level | 2 of 4 | - | - | x0.997 | x1.002 | x0.957 |
| blake3-servil-st / solo / ManyLongMessages / 256 | 1613.284 | 1604.362 | x0.994 | level | 3 of 4 | - | - | x0.994 | x1.002 | x1.000 |
| blake3-servil-st / solo / IdleOneMessage / 64 B | 8.504 | 9.291 | x1.093 | level | 0 of 4 | - | - | x1.032 | x1.005 | x1.313 |
| blake3-servil-st / solo / IdleOneMessage / 128 B | 6.242 | 6.590 | x1.056 | level | 1 of 4 | - | - | x1.024 | x1.004 | x0.649 |
| blake3-servil-st / solo / IdleOneMessage / 256 B | 4.547 | 4.884 | x1.074 | level | 0 of 4 | - | - | x1.023 | x1.002 | x0.902 |
| blake3-servil-st / solo / IdleOneMessage / 512 B | 4.171 | 4.193 | x1.005 | level | 2 of 4 | - | - | x1.038 | x1.001 | x0.634 |
| blake3-servil-st / solo / IdleOneMessage / 1 KiB | 3.776 | 3.850 | x1.019 | level | 2 of 4 | - | - | x1.012 | x1.001 | x1.303 |
| blake3-servil-st / solo / IdleOneMessage / 1536 B | 7.848 | 7.718 | x0.983 | level | 2 of 4 | - | - | x1.015 | x0.997 | x0.960 |
| blake3-servil-st / solo / IdleOneMessage / 2 KiB | 6.551 | 6.518 | x0.995 | level | 2 of 4 | - | - | x1.007 | x1.000 | x1.299 |
| blake3-servil-st / solo / IdleOneMessage / 2304 B | 6.917 | 6.532 | x0.944 | level | 3 of 4 | - | - | x0.996 | x1.001 | x1.308 |
| blake3-servil-st / solo / IdleOneMessage / 3 KiB | 4.497 | 4.636 | x1.031 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.127 |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 3.904 | 3.871 | x0.991 | level | 3 of 4 | - | - | x1.002 | x1.001 | x1.040 |
| blake3-servil-st / solo / IdleOneMessage / 4 KiB | 3.533 | 3.549 | x1.005 | level | 2 of 4 | - | - | x1.007 | x1.000 | x1.365 |
| blake3-servil-st / solo / IdleOneMessage / 4470 B | 3.713 | 3.815 | x1.027 | level | 1 of 4 | - | - | x1.002 | x1.001 | x0.584 |
| blake3-servil-st / solo / IdleOneMessage / 7935 B | 2.521 | 2.467 | x0.979 | level | 4 of 4 | - | - | x1.001 | x1.000 | x1.099 |
| blake3-servil-st / solo / IdleOneMessage / 8 KiB | 2.322 | 2.445 | x1.053 | level | 0 of 4 | - | - | x1.004 | x1.000 | x0.221 |
| blake3-servil-st / solo / IdleOneMessage / 16 KiB | 1.554 | 1.584 | x1.019 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.413 |
| blake3-servil-st / solo / IdleOneMessage / 32 KiB | 1.327 | 1.336 | x1.007 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.530 |
| blake3-servil-st / solo / IdleOneMessage / 64 KiB | 0.836 | 0.836 | x1.000 | level | 3 of 4 | - | - | x1.004 | x1.000 | x0.789 |
| blake3-servil-st / solo / IdleOneMessage / 128 KiB | 0.674 | 0.675 | x1.001 | level | 1 of 4 | - | - | x1.009 | x1.000 | x1.072 |
| blake3-servil-st / solo / IdleOneMessage / 256 KiB | 0.483 | 0.484 | x1.001 | level | 2 of 4 | - | - | x0.994 | x1.000 | x1.842 |
| blake3-servil-st / solo / IdleOneMessage / 512 KiB | 0.366 | 0.372 | x1.015 | level | 0 of 4 | - | - | x1.001 | x1.000 | x0.877 |
| blake3-servil-st / solo / IdleOneMessage / 1 MiB | 0.359 | 0.360 | x1.004 | level | 1 of 4 | - | - | x1.006 | x1.000 | x1.037 |
| blake3-servil-st / solo / IdleOneMessage / 2 MiB | 0.350 | 0.350 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.003 |
| blake3-servil-st / solo / IdleOneMessage / 3 MiB | 0.344 | 0.344 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.013 |
| blake3-servil-st / solo / IdleOneMessage / 4 MiB | 0.341 | 0.341 | x1.001 | level | 0 of 4 | - | - | x1.000 | x1.000 | x1.013 |
| blake3-servil-st / solo / IdleOneMessage / 8 MiB | 0.339 | 0.339 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.002 |
| blake3-servil-st / solo / IdleOneMessage / 32 MiB | 0.346 | 0.346 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.992 |
| blake3-servil-st / solo / IdleOneMessage / 64 MiB | 0.351 | 0.351 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.001 |
| blake3-servil-st / solo / IdleOneMessage / 128 MiB | 0.353 | 0.354 | x1.001 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.997 |
| blake3-servil-st / solo / IdleManyMessages / 1 | 652.447 | 665.648 | x1.020 | level | 2 of 4 | - | - | x1.029 | x1.008 | x0.814 |
| blake3-servil-st / solo / IdleManyMessages / 2 | 764.177 | 769.683 | x1.007 | level | 2 of 4 | - | - | x1.026 | x0.997 | x0.473 |
| blake3-servil-st / solo / IdleManyMessages / 3 | 760.625 | 818.322 | x1.076 | level | 0 of 4 | - | - | x1.011 | x0.997 | x1.441 |
| blake3-servil-st / solo / IdleManyMessages / 4 | 391.803 | 386.217 | x0.986 | level | 1 of 4 | - | - | x1.009 | x0.997 | x1.142 |
| blake3-servil-st / solo / IdleManyMessages / 6 | 432.716 | 433.981 | x1.003 | level | 2 of 4 | - | - | x1.000 | x0.998 | x0.863 |
| blake3-servil-st / solo / IdleManyMessages / 8 | 291.413 | 294.605 | x1.011 | level | 2 of 4 | - | - | x1.010 | x0.998 | x1.097 |
| blake3-servil-st / solo / IdleManyMessages / 12 | 289.771 | 285.786 | x0.986 | level | 3 of 4 | - | - | x0.997 | x0.998 | x1.031 |
| blake3-servil-st / solo / IdleManyMessages / 16 | 197.957 | 207.189 | x1.047 | level | 2 of 4 | - | - | x1.005 | x0.998 | x0.539 |
| blake3-servil-st / solo / IdleManyMessages / 24 | 226.053 | 226.161 | x1.000 | level | 3 of 4 | - | - | x1.005 | x0.999 | x1.286 |
| blake3-servil-st / solo / IdleManyMessages / 32 | 182.661 | 181.585 | x0.994 | level | 2 of 4 | - | - | x1.005 | x0.999 | x0.869 |
| blake3-servil-st / solo / IdleManyMessages / 48 | 166.433 | 174.114 | x1.046 | level | 1 of 4 | - | - | x1.003 | x0.999 | x1.035 |
| blake3-servil-st / solo / IdleManyMessages / 64 | 164.144 | 160.028 | x0.975 | level | 3 of 4 | - | - | x0.999 | x0.999 | x0.916 |
| blake3-servil-st / solo / IdleManyMessages / 128 | 122.547 | 118.869 | x0.970 | level | 3 of 4 | - | - | x1.002 | x1.000 | x0.788 |
| blake3-servil-st / solo / IdleManyMessages / 256 | 97.803 | 95.606 | x0.978 | level | 4 of 4 | - | - | x1.003 | x1.000 | x0.982 |
| blake3-servil-st / solo / IdleManyMessages / 512 | 83.010 | 83.377 | x1.004 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.169 |
| blake3-servil-st / solo / IdleManyMessages / 1024 | 54.729 | 53.388 | x0.976 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.820 |
| blake3-servil-st / solo / IdleManyMessages / 2048 | 42.977 | 42.019 | x0.978 | level | 3 of 4 | - | - | x0.981 | x1.000 | x1.034 |
| blake3-servil-st / solo / IdleManyMessages / 4096 | 30.945 | 31.192 | x1.008 | level | 1 of 4 | - | - | x0.998 | x1.000 | x0.888 |
| blake3-servil-st / solo / IdleManyMessages / 8192 | 23.799 | 23.852 | x1.002 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.948 |
| blake3-servil-st / solo / IdleManyMessages / 16384 | 23.709 | 23.673 | x0.998 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.978 |
| blake3-servil-st / solo / IdleManyMessages / 32768 | 22.700 | 22.646 | x0.998 | level | 4 of 4 | - | - | x0.998 | x1.000 | x1.003 |
| blake3-servil-st / solo / IdleManyMessages / 65536 | 22.272 | 22.253 | x0.999 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.011 |
| blake3-servil-st / solo / IdleManyMessages / 131072 | 22.143 | 22.076 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.000 | x0.983 |
| blake3-servil-st / solo / IdleManyMessages / 262144 | 22.513 | 22.462 | x0.998 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.009 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 B | 3.138 | 3.300 | x1.052 | level | 1 of 4 | - | - | x1.012 | x1.005 | x1.002 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 B | 2.429 | 2.470 | x1.017 | level | 2 of 4 | - | - | x1.010 | x1.004 | x1.074 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 B | 1.763 | 1.795 | x1.018 | level | 2 of 4 | - | - | x1.007 | x1.003 | x0.946 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 B | 1.617 | 1.623 | x1.004 | level | 2 of 4 | - | - | x1.001 | x1.002 | x0.844 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 KiB | 1.503 | 1.516 | x1.009 | level | 1 of 4 | - | - | x1.006 | x1.001 | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 1536 B | 1.218 | 1.224 | x1.005 | level | 2 of 4 | - | - | x1.003 | x0.997 | x1.285 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 KiB | 0.896 | 0.896 | x1.000 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.717 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2304 B | 1.023 | 1.041 | x1.017 | level | 1 of 4 | - | - | x1.014 | x1.001 | x0.731 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.827 | 0.964 | x1.167 | level | 1 of 4 | - | - | x1.149 | x1.000 | x2.761 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3839 B | 0.584 | 0.591 | x1.011 | level | 2 of 4 | - | - | x1.009 | x1.001 | x0.842 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 KiB | 0.484 | 0.489 | x1.011 | level | 2 of 4 | - | - | x1.014 | x1.000 | x0.894 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4470 B | 0.593 | 0.604 | x1.018 | level | 0 of 4 | - | - | x1.015 | x1.001 | x0.884 |
| blake3-servil-st / solo / BriefIdleOneMessage / 7935 B | 0.443 | 0.444 | x1.003 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.134 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 KiB | 0.396 | 0.401 | x1.013 | level | 1 of 4 | - | - | x1.011 | x1.000 | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 16 KiB | 0.296 | 0.297 | x1.006 | level | 1 of 4 | - | - | x1.006 | x1.000 | x1.079 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 KiB | 0.294 | 0.294 | x1.001 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.205 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 KiB | 0.286 | 0.287 | x1.003 | level | 0 of 4 | - | - | x1.001 | x1.000 | x0.765 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 KiB | 0.282 | 0.282 | x0.998 | level | 3 of 4 | - | - | x1.001 | x1.000 | x1.983 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 KiB | 0.280 | 0.281 | x1.004 | level | 0 of 4 | - | - | x1.001 | x1.000 | x0.572 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 KiB | 0.286 | 0.286 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.956 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 MiB | 0.326 | 0.325 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.989 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 MiB | 0.335 | 0.335 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.041 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 MiB | 0.334 | 0.334 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.994 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 MiB | 0.334 | 0.334 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.969 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 MiB | 0.362 | 0.362 | x1.001 | level | 0 of 4 | - | - | x1.000 | x1.000 | x0.983 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 MiB | 0.347 | 0.347 | x1.001 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.000 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 MiB | 0.351 | 0.351 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.001 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 MiB | 0.354 | 0.354 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.997 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1 | 229.515 | 247.370 | x1.078 | level | 1 of 4 | - | - | x1.027 | x1.009 | x1.108 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2 | 245.514 | 254.013 | x1.035 | level | 0 of 4 | - | - | x1.011 | x0.998 | x0.764 |
| blake3-servil-st / solo / BriefIdleManyMessages / 3 | 110.056 | 118.766 | x1.079 | level | 0 of 4 | - | - | x1.028 | x0.998 | x1.101 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4 | 65.154 | 67.068 | x1.029 | level | 1 of 4 | - | - | x1.010 | x0.998 | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 6 | 59.848 | 60.986 | x1.019 | level | 2 of 4 | - | - | x1.009 | x0.999 | x1.319 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8 | 41.484 | 42.555 | x1.026 | level | 1 of 4 | - | - | x1.011 | x0.999 | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 12 | 36.839 | 37.798 | x1.026 | level | 1 of 4 | - | - | x1.013 | x0.999 | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 16 | 26.193 | 26.716 | x1.020 | level | 1 of 4 | - | - | x1.010 | x0.998 | x0.508 |
| blake3-servil-st / solo / BriefIdleManyMessages / 24 | 27.322 | 27.285 | x0.999 | level | 2 of 4 | - | - | x1.010 | x0.999 | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 32 | 21.787 | 22.129 | x1.016 | level | 0 of 4 | - | - | x1.011 | x0.999 | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 48 | 19.799 | 19.826 | x1.001 | level | 1 of 4 | - | - | x1.005 | x0.999 | x1.028 |
| blake3-servil-st / solo / BriefIdleManyMessages / 64 | 18.858 | 19.020 | x1.009 | level | 0 of 4 | - | - | x1.007 | x0.999 | x1.021 |
| blake3-servil-st / solo / BriefIdleManyMessages / 128 | 17.737 | 17.929 | x1.011 | level | 0 of 4 | - | - | x1.010 | x1.000 | x1.166 |
| blake3-servil-st / solo / BriefIdleManyMessages / 256 | 18.227 | 18.248 | x1.001 | level | 1 of 4 | - | - | x1.006 | x1.000 | x0.876 |
| blake3-servil-st / solo / BriefIdleManyMessages / 512 | 18.333 | 18.439 | x1.006 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.025 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1024 | 18.081 | 18.129 | x1.003 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.963 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2048 | 17.990 | 17.998 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.915 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4096 | 18.018 | 18.022 | x1.000 | level | 3 of 4 | - | - | x1.001 | x1.000 | x1.186 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8192 | 19.271 | 19.260 | x0.999 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.896 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16384 | 21.700 | 21.696 | x1.000 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.989 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32768 | 21.790 | 21.732 | x0.997 | level | 4 of 4 | - | - | x0.997 | x1.000 | x1.004 |
| blake3-servil-st / solo / BriefIdleManyMessages / 65536 | 22.087 | 21.871 | x0.990 | level | 4 of 4 | - | - | x0.997 | x1.000 | x1.008 |
| blake3-servil-st / solo / BriefIdleManyMessages / 131072 | 23.606 | 23.628 | x1.001 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.993 |
| blake3-servil-st / solo / BriefIdleManyMessages / 262144 | 22.518 | 22.456 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.008 |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 1.511 | 1.506 | x0.996 | level | 1 of 4 | x0.998 | - | x0.998 | x1.012 | x0.934 |
| blake3-servil-st / solo / ContinuousMessages / 128 B | 1.440 | 1.443 | x1.002 | level | 1 of 4 | x1.002 | - | x1.001 | x1.007 | - |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 1.403 | 1.411 | x1.005 | level | 0 of 4 | x1.004 | - | x1.004 | x1.004 | - |
| blake3-servil-st / solo / ContinuousMessages / 512 B | 1.403 | 1.405 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.003 | x0.833 |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 1.397 | 1.398 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.001 | x3.418 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.436 | 0.439 | x1.007 | level | 0 of 4 | x1.007 | - | x1.007 | x1.001 | x1.732 |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.271 | 0.272 | x1.002 | level | 2 of 4 | x1.002 | - | x1.003 | x1.000 | x5.684 |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.281 | 0.281 | x0.997 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x0.083 |
| blake3-servil-st / solo / ContinuousMessages / 256 KiB | 0.299 | 0.299 | x0.999 | level | 4 of 4 | x0.999 | - | x0.999 | x1.000 | x0.141 |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.299 | 0.298 | x0.999 | level | 2 of 4 | x0.999 | - | x1.000 | x1.000 | x0.835 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.304 | 0.304 | x1.000 | level | 2 of 4 | x1.000 | - | x1.001 | x1.000 | x0.726 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.304 | 0.306 | x1.006 | level | 1 of 4 | x1.003 | - | x1.003 | x1.000 | x1.612 |
| blake3-servil-st / solo / ContinuousMessages / 64 MiB | 0.319 | 0.320 | x1.004 | level | 0 of 4 | x1.004 | - | x1.004 | x1.000 | x1.008 |
| blake3-servil-st / solo / ContinuousBatches / 16 | 21.124 | 20.883 | x0.989 | level | 3 of 4 | x0.988 | - | x0.988 | x0.998 | x2.564 |
| blake3-servil-st / solo / ContinuousBatches / 64 | 18.019 | 18.077 | x1.003 | level | 0 of 4 | x1.003 | - | x1.003 | x0.999 | - |
| blake3-servil-st / solo / ContinuousBatches / 256 | 17.788 | 17.724 | x0.996 | level | 3 of 4 | x0.996 | - | x0.997 | x1.000 | - |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 19.282 | 19.502 | x1.011 | level | 1 of 4 | x1.013 | - | x1.013 | x0.999 | - |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 19.262 | 19.387 | x1.006 | level | 1 of 4 | x1.007 | - | x1.006 | x1.000 | - |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 22.410 | 22.601 | x1.009 | level | 0 of 4 | x1.008 | - | x1.009 | x1.000 | x0.480 |
| blake3-servil-st / solo / ContinuousBatches / 65536 | 23.034 | 23.070 | x1.002 | level | 2 of 4 | x1.001 | - | x1.002 | x1.000 | x0.697 |
| blake3-servil-st / solo / LentMessages / 64 B | 1.511 | 1.506 | x0.996 | level | 1 of 4 | x0.998 | - | x0.998 | x1.012 | x0.934 |
| blake3-servil-st / solo / LentMessages / 128 B | 1.440 | 1.443 | x1.002 | level | 1 of 4 | x1.002 | - | x1.001 | x1.007 | - |
| blake3-servil-st / solo / LentMessages / 256 B | 1.403 | 1.411 | x1.005 | level | 0 of 4 | x1.004 | - | x1.004 | x1.004 | - |
| blake3-servil-st / solo / LentMessages / 512 B | 1.403 | 1.405 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.003 | x0.833 |
| blake3-servil-st / solo / LentMessages / 1 KiB | 1.397 | 1.398 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.001 | x3.418 |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.436 | 0.439 | x1.007 | level | 0 of 4 | x1.007 | - | x1.007 | x1.001 | x1.732 |
| blake3-servil-st / solo / LentMessages / 16 KiB | 0.271 | 0.272 | x1.002 | level | 2 of 4 | x1.002 | - | x1.003 | x1.000 | x5.684 |
| blake3-servil-st / solo / LentMessages / 64 KiB | 0.281 | 0.281 | x0.997 | level | 3 of 4 | x0.998 | - | x0.998 | x1.000 | x0.083 |
| blake3-servil-st / solo / LentMessages / 256 KiB | 0.277 | 0.277 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.000 | x0.726 |
| blake3-servil-st / solo / LentMessages / 1 MiB | 0.314 | 0.315 | x1.004 | level | 2 of 4 | x1.004 | - | x1.004 | x1.000 | x0.911 |
| blake3-servil-st / solo / LentMessages / 4 MiB | 0.330 | 0.336 | x1.016 | level | 2 of 4 | x1.007 | - | x1.006 | x1.000 | x1.686 |
| blake3-servil-st / solo / LentMessages / 16 MiB | 0.340 | 0.341 | x1.003 | level | 1 of 4 | x1.004 | - | x1.004 | x1.000 | x1.324 |
| blake3-servil-st / solo / LentMessages / 64 MiB | 0.349 | 0.350 | x1.003 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x1.000 |
| blake3-servil-st / solo / Interleaved / 256 | 0.392 | 0.392 | x1.000 | level | 2 of 4 | x1.001 | - | x1.000 | x0.999 | x0.760 |
| blake3-servil-st / solo / Collection / git objects | 0.272 | 0.272 | x0.999 | level | 2 of 4 | x1.000 | - | x1.000 | x0.999 | x1.019 |
| blake3-servil-st / solo / Collection / Nix files | 0.262 | 0.263 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x0.999 | x1.019 |
| blake3-servil-st / solo / LentBatches / 16 | 21.124 | 20.883 | x0.989 | level | 3 of 4 | x0.988 | - | x0.988 | x0.998 | x2.564 |
| blake3-servil-st / solo / LentBatches / 64 | 18.019 | 18.077 | x1.003 | level | 0 of 4 | x1.003 | - | x1.003 | x0.999 | - |
| blake3-servil-st / solo / LentBatches / 256 | 17.788 | 17.724 | x0.996 | level | 3 of 4 | x0.996 | - | x0.997 | x1.000 | - |
| blake3-servil-st / solo / LentBatches / 1024 | 19.282 | 19.502 | x1.011 | level | 1 of 4 | x1.013 | - | x1.013 | x0.999 | - |
| blake3-servil-st / solo / LentBatches / 4096 | 19.262 | 19.387 | x1.006 | level | 1 of 4 | x1.007 | - | x1.006 | x1.000 | - |
| blake3-servil-st / solo / LentBatches / 16384 | 22.410 | 22.601 | x1.009 | level | 0 of 4 | x1.008 | - | x1.009 | x1.000 | x0.480 |
| blake3-servil-st / solo / LentBatches / 65536 | 23.034 | 23.070 | x1.002 | level | 2 of 4 | x1.001 | - | x1.002 | x1.000 | x0.697 |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.351 | 0.350 | x0.999 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.000 |
| blake3-servil-st / solo / ContinuousCollection / Nix files | 0.359 | 0.359 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x1.017 |
| blake3-servil-st / solo / MerkleTree / 1024 | 0.349 | 0.350 | x1.003 | level | 0 of 4 | x1.003 | - | x1.003 | x1.001 | x1.292 |
| blake3-servil-st / solo / MerkleTree / 4096 | 0.402 | 0.400 | x0.996 | level | 3 of 4 | x0.997 | - | x0.998 | x1.001 | x1.341 |
| blake3-servil-st / solo / MerkleTree / 16384 | 0.411 | 0.412 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.001 | x0.984 |
| blake3-servil-st / solo / MerkleTree / 65536 | 0.439 | 0.444 | x1.011 | level | 1 of 4 | x1.010 | - | x1.010 | x1.001 | x0.978 |
| blake3-servil-st / solo / MerkleTree / 262144 | 0.466 | 0.470 | x1.008 | level | 1 of 4 | x1.008 | - | x1.008 | x1.001 | x0.984 |
| blake3-servil-st / solo / MerkleTree / 65536 x 32 B | 1.052 | 1.054 | x1.002 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x0.950 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 32 B | 1.085 | 1.093 | x1.007 | level | 0 of 4 | x1.007 | - | x1.007 | x1.000 | x0.974 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 16 B | 2.109 | 2.119 | x1.004 | level | 1 of 4 | x1.005 | - | x1.005 | x1.000 | x0.994 |
| blake3-servil-st / solo / MerkleTree / 65536 x 48 B | 0.742 | 0.744 | x1.002 | level | 1 of 4 | x1.002 | - | x1.002 | x1.000 | x1.353 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 48 B | 0.776 | 0.780 | x1.004 | level | 0 of 4 | x1.004 | - | x1.004 | x1.000 | x0.995 |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.749 | 0.749 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.001 | x1.010 |
| blake3-servil-st / solo / InterleavedTurn / 1024 x 1 KiB | 0.843 | 0.859 | x1.019 | level | 1 of 4 | - | - | x1.019 | x0.997 | x1.044 |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.654 | 0.671 | x1.025 | level | 0 of 4 | - | - | x1.013 | x1.012 | x1.054 |
| blake3-servil-st / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.799 | 0.807 | x1.010 | level | 1 of 4 | - | - | x1.008 | x0.997 | x0.975 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.515 | 0.519 | x1.007 | level | 0 of 4 | - | - | x1.010 | x1.005 | x1.020 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.723 | 0.731 | x1.011 | level | 0 of 4 | - | - | x1.011 | x0.997 | x0.971 |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.317 | 0.318 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.001 | x0.888 |
| blake3-servil-st / solo / ReceivingMessage / 2 μs | 0.320 | 0.320 | x1.001 | level | 2 of 4 | x1.001 | - | x1.001 | x1.001 | x0.691 |
| blake3-servil-st / solo / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 2 of 4 | x0.999 | - | x1.000 | x1.001 | x0.833 |
| blake3-servil-st / solo / IncrementalMessage / 64 B | 18.116 | 19.235 | x1.062 | level | 1 of 4 | - | - | x1.027 | x1.003 | x1.178 |
| blake3-servil-st / solo / IncrementalMessage / 1 KiB | 3.170 | 3.312 | x1.045 | level | 1 of 4 | - | - | x1.042 | x1.001 | x1.218 |
| blake3-servil-st / solo / IncrementalMessage / 4 KiB | 2.481 | 2.472 | x0.996 | level | 3 of 4 | - | - | x0.997 | x1.001 | x1.064 |
| blake3-servil-st / solo / LentIncrementalMessage / 64 B | 1.706 | 1.699 | x0.996 | level | 2 of 4 | x0.996 | - | x0.996 | x1.006 | x4.444 |
| blake3-servil-st / solo / LentIncrementalMessage / 1 KiB | 1.442 | 1.441 | x1.000 | level | 1 of 4 | x1.001 | - | x1.002 | x1.002 | x1.700 |
| blake3-servil-st / solo / LentIncrementalMessage / 4 KiB | 0.455 | 0.456 | x1.004 | level | 1 of 4 | x1.004 | - | x1.004 | x1.001 | x1.283 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 1.464 | 1.458 | x0.996 | level | 2 of 4 | x0.996 | - | x0.996 | x1.013 | x1.199 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 4 KiB | 0.439 | 0.440 | x1.003 | level | 2 of 4 | x1.002 | - | x1.002 | x1.001 | x1.127 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 1 MiB | 0.296 | 0.283 | x0.955 | level | 4 of 4 | x0.955 | - | x0.955 | x1.000 | x0.897 |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 1.382 | 1.381 | x1.000 | level | 2 of 4 | x1.000 | - | x0.999 | x1.015 | x0.955 |
| blake3-servil-st / solo / ContinuousLentMessages / 4 KiB | 0.424 | 0.424 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.001 | x1.183 |
| blake3-servil-st / solo / ContinuousLentMessages / 1 MiB | 0.242 | 0.243 | x1.005 | level | 2 of 4 | x1.002 | - | x1.002 | x1.000 | x1.936 |
| blake3-servil-mt / solo / OneMessage / 64 B | 20.794 | 20.293 | x0.976 | level | 2 of 4 | - | - | x0.977 | x1.004 | x1.068 |
| blake3-servil-mt / solo / OneMessage / 128 B | 11.459 | 11.281 | x0.984 | level | 2 of 4 | - | - | x0.985 | x1.004 | x1.002 |
| blake3-servil-mt / solo / OneMessage / 256 B | 6.148 | 6.046 | x0.983 | level | 3 of 4 | - | - | x0.982 | x1.002 | x1.022 |
| blake3-servil-mt / solo / OneMessage / 512 B | 3.885 | 3.853 | x0.992 | level | 2 of 4 | - | - | x0.992 | x1.002 | x1.045 |
| blake3-servil-mt / solo / OneMessage / 1 KiB | 2.692 | 2.642 | x0.982 | level | 3 of 4 | - | - | x0.984 | x1.001 | x1.020 |
| blake3-servil-mt / solo / OneMessage / 1536 B | 4.978 | 4.719 | x0.948 | level | 3 of 4 | - | - | x0.955 | x0.997 | x0.964 |
| blake3-servil-mt / solo / OneMessage / 2 KiB | 4.265 | 4.243 | x0.995 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.977 |
| blake3-servil-mt / solo / OneMessage / 2304 B | 4.433 | 4.496 | x1.014 | level | 1 of 4 | - | - | x1.015 | x1.001 | x0.940 |
| blake3-servil-mt / solo / OneMessage / 3 KiB | 3.117 | 3.117 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.012 |
| blake3-servil-mt / solo / OneMessage / 3839 B | 2.739 | 2.752 | x1.005 | level | 1 of 4 | - | - | x1.002 | x1.001 | x0.972 |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 2.331 | 2.333 | x1.001 | level | 2 of 4 | - | - | x1.004 | x1.000 | x1.000 |
| blake3-servil-mt / solo / OneMessage / 4470 B | 2.522 | 2.561 | x1.016 | level | 2 of 4 | - | - | x1.012 | x1.001 | x0.985 |
| blake3-servil-mt / solo / OneMessage / 7935 B | 2.046 | 2.045 | x1.000 | level | 3 of 4 | - | - | x1.007 | x1.001 | x0.994 |
| blake3-servil-mt / solo / OneMessage / 8 KiB | 1.846 | 1.852 | x1.003 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.022 |
| blake3-servil-mt / solo / OneMessage / 16 KiB | 1.334 | 1.339 | x1.003 | level | 1 of 4 | - | - | x1.004 | x1.000 | x0.982 |
| blake3-servil-mt / solo / OneMessage / 32 KiB | 1.243 | 1.246 | x1.003 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.953 |
| blake3-servil-mt / solo / OneMessage / 64 KiB | 1.045 | 1.057 | x1.011 | level | 0 of 4 | - | - | x1.008 | x1.000 | x0.959 |
| blake3-servil-mt / solo / OneMessage / 128 KiB | 0.672 | 0.667 | x0.992 | level | 2 of 4 | - | - | x0.994 | x1.000 | x0.989 |
| blake3-servil-mt / solo / OneMessage / 256 KiB | 0.486 | 0.482 | x0.991 | level | 3 of 4 | - | - | x0.992 | x1.000 | x0.988 |
| blake3-servil-mt / solo / OneMessage / 512 KiB | 0.441 | 0.458 | x1.037 | level | 2 of 4 | - | - | x1.036 | x1.189 | x0.993 |
| blake3-servil-mt / solo / OneMessage / 1 MiB | 0.341 | 0.331 | x0.972 | level | 3 of 4 | - | - | x0.974 | x1.075 | x0.974 |
| blake3-servil-mt / solo / OneMessage / 2 MiB | 0.245 | 0.242 | x0.990 | level | 2 of 4 | - | - | x0.991 | x1.028 | x0.979 |
| blake3-servil-mt / solo / OneMessage / 3 MiB | 0.215 | 0.211 | x0.983 | level | 2 of 4 | - | - | x1.001 | x1.084 | x0.995 |
| blake3-servil-mt / solo / OneMessage / 4 MiB | 0.194 | 0.193 | x0.997 | level | 2 of 4 | - | - | x0.998 | x1.038 | x1.000 |
| blake3-servil-mt / solo / OneMessage / 8 MiB | 0.165 | 0.166 | x1.005 | level | 2 of 4 | - | - | x1.005 | x1.065 | x1.004 |
| blake3-servil-mt / solo / OneMessage / 32 MiB | 0.112 | 0.112 | x0.997 | level | 3 of 4 | - | - | x0.998 | x1.004 | x0.999 |
| blake3-servil-mt / solo / OneMessage / 64 MiB | 0.107 | 0.107 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.007 | x1.000 |
| blake3-servil-mt / solo / OneMessage / 128 MiB | 0.105 | 0.105 | x1.000 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.996 |
| blake3-servil-mt / solo / ManyMessages / 1 | 1103.057 | 1084.588 | x0.983 | level | 3 of 4 | - | - | x0.989 | x1.008 | x0.904 |
| blake3-servil-mt / solo / ManyMessages / 2 | 829.009 | 870.264 | x1.050 | level | 2 of 4 | - | - | x1.034 | x0.997 | x0.920 |
| blake3-servil-mt / solo / ManyMessages / 3 | 653.388 | 664.916 | x1.018 | level | 2 of 4 | - | - | x1.025 | x0.998 | x0.890 |
| blake3-servil-mt / solo / ManyMessages / 4 | 402.483 | 422.420 | x1.050 | level | 2 of 4 | - | - | x1.025 | x0.997 | x0.889 |
| blake3-servil-mt / solo / ManyMessages / 6 | 361.320 | 375.156 | x1.038 | level | 1 of 4 | - | - | x1.025 | x0.998 | x0.865 |
| blake3-servil-mt / solo / ManyMessages / 8 | 269.697 | 264.539 | x0.981 | level | 2 of 4 | - | - | x1.005 | x0.998 | x0.901 |
| blake3-servil-mt / solo / ManyMessages / 12 | 208.695 | 216.160 | x1.036 | level | 2 of 4 | - | - | x1.027 | x0.998 | x0.879 |
| blake3-servil-mt / solo / ManyMessages / 16 | 152.770 | 157.239 | x1.029 | level | 2 of 4 | - | - | x1.012 | x0.998 | x0.911 |
| blake3-servil-mt / solo / ManyMessages / 24 | 142.307 | 142.509 | x1.001 | level | 1 of 4 | - | - | x1.014 | x0.999 | x0.888 |
| blake3-servil-mt / solo / ManyMessages / 32 | 109.049 | 116.540 | x1.069 | level | 1 of 4 | - | - | x1.025 | x0.999 | x0.874 |
| blake3-servil-mt / solo / ManyMessages / 48 | 97.456 | 99.851 | x1.025 | level | 2 of 4 | - | - | x1.013 | x0.999 | x0.852 |
| blake3-servil-mt / solo / ManyMessages / 64 | 91.741 | 93.513 | x1.019 | level | 1 of 4 | - | - | x1.016 | x0.999 | x0.869 |
| blake3-servil-mt / solo / ManyMessages / 128 | 84.385 | 84.270 | x0.999 | level | 2 of 4 | - | - | x1.004 | x1.000 | x0.907 |
| blake3-servil-mt / solo / ManyMessages / 256 | 79.620 | 79.832 | x1.003 | level | 2 of 4 | - | - | x1.004 | x1.000 | x0.926 |
| blake3-servil-mt / solo / ManyMessages / 512 | 77.539 | 77.720 | x1.002 | level | 1 of 4 | - | - | x1.003 | x1.000 | x0.953 |
| blake3-servil-mt / solo / ManyMessages / 1024 | 65.890 | 66.178 | x1.004 | level | 1 of 4 | - | - | x1.004 | x1.000 | x0.959 |
| blake3-servil-mt / solo / ManyMessages / 2048 | 42.314 | 42.583 | x1.006 | level | 1 of 4 | - | - | x1.005 | x1.000 | x0.994 |
| blake3-servil-mt / solo / ManyMessages / 4096 | 31.082 | 31.130 | x1.002 | level | 3 of 4 | - | - | x1.001 | x1.000 | x0.985 |
| blake3-servil-mt / solo / ManyMessages / 8192 | 25.742 | 26.153 | x1.016 | level | 2 of 4 | - | - | x1.019 | x1.168 | x1.007 |
| blake3-servil-mt / solo / ManyMessages / 16384 | 19.240 | 19.126 | x0.994 | level | 2 of 4 | - | - | x0.994 | x1.064 | x0.994 |
| blake3-servil-mt / solo / ManyMessages / 32768 | 14.967 | 15.009 | x1.003 | level | 2 of 4 | - | - | x1.005 | x1.050 | x0.995 |
| blake3-servil-mt / solo / ManyMessages / 65536 | 12.139 | 12.225 | x1.007 | level | 2 of 4 | - | - | x1.010 | x1.102 | x1.014 |
| blake3-servil-mt / solo / ManyMessages / 131072 | 10.618 | 10.653 | x1.003 | level | 2 of 4 | - | - | x1.004 | x1.051 | x0.998 |
| blake3-servil-mt / solo / ManyMessages / 262144 | 9.995 | 9.965 | x0.997 | level | 3 of 4 | - | - | x0.998 | x1.020 | x1.000 |
| blake3-servil-mt / solo / ManyLongMessages / 4 | 8220.480 | 8256.141 | x1.004 | level | 1 of 4 | - | - | x1.002 | x1.001 | x0.992 |
| blake3-servil-mt / solo / ManyLongMessages / 16 | 4930.325 | 4260.186 | x0.864 | faster | 4 of 4 | - | - | x0.863 | x0.566 | x1.047 |
| blake3-servil-mt / solo / ManyLongMessages / 64 | 1981.253 | 1958.359 | x0.988 | level | 4 of 4 | - | - | x0.989 | x1.002 | x0.961 |
| blake3-servil-mt / solo / ManyLongMessages / 256 | 1397.098 | 1432.243 | x1.025 | level | 2 of 4 | - | - | x1.027 | x1.143 | x0.998 |
| blake3-servil-mt / solo / IdleOneMessage / 64 B | 8.383 | 8.682 | x1.036 | level | 1 of 4 | - | - | x1.016 | x1.004 | x1.341 |
| blake3-servil-mt / solo / IdleOneMessage / 128 B | 6.529 | 6.565 | x1.006 | level | 1 of 4 | - | - | x1.010 | x1.004 | x1.214 |
| blake3-servil-mt / solo / IdleOneMessage / 256 B | 4.969 | 4.882 | x0.983 | level | 2 of 4 | - | - | x1.000 | x1.002 | x1.611 |
| blake3-servil-mt / solo / IdleOneMessage / 512 B | 4.276 | 4.182 | x0.978 | level | 1 of 4 | - | - | x1.001 | x1.001 | x1.040 |
| blake3-servil-mt / solo / IdleOneMessage / 1 KiB | 3.796 | 3.603 | x0.949 | level | 3 of 4 | - | - | x0.999 | x1.001 | - |
| blake3-servil-mt / solo / IdleOneMessage / 1536 B | 7.742 | 7.737 | x0.999 | level | 3 of 4 | - | - | x1.027 | x0.997 | x0.980 |
| blake3-servil-mt / solo / IdleOneMessage / 2 KiB | 6.552 | 6.670 | x1.018 | level | 2 of 4 | - | - | x1.004 | x1.000 | x2.753 |
| blake3-servil-mt / solo / IdleOneMessage / 2304 B | 6.644 | 6.644 | x1.000 | level | 3 of 4 | - | - | x0.995 | x1.001 | x0.776 |
| blake3-servil-mt / solo / IdleOneMessage / 3 KiB | 4.568 | 4.692 | x1.027 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.274 |
| blake3-servil-mt / solo / IdleOneMessage / 3839 B | 3.831 | 3.933 | x1.027 | level | 0 of 4 | - | - | x0.999 | x1.001 | x1.473 |
| blake3-servil-mt / solo / IdleOneMessage / 4 KiB | 3.553 | 3.555 | x1.000 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.446 |
| blake3-servil-mt / solo / IdleOneMessage / 4470 B | 3.795 | 3.801 | x1.002 | level | 3 of 4 | - | - | x1.002 | x1.001 | x0.563 |
| blake3-servil-mt / solo / IdleOneMessage / 7935 B | 2.503 | 2.460 | x0.983 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.401 |
| blake3-servil-mt / solo / IdleOneMessage / 8 KiB | 2.415 | 2.362 | x0.978 | level | 3 of 4 | - | - | x1.002 | x1.000 | x0.651 |
| blake3-servil-mt / solo / IdleOneMessage / 16 KiB | 1.537 | 1.575 | x1.024 | level | 1 of 4 | - | - | x0.996 | x1.000 | x2.261 |
| blake3-servil-mt / solo / IdleOneMessage / 32 KiB | 1.347 | 1.321 | x0.981 | level | 3 of 4 | - | - | x1.009 | x1.000 | x1.111 |
| blake3-servil-mt / solo / IdleOneMessage / 64 KiB | 0.848 | 0.860 | x1.013 | level | 1 of 4 | - | - | x1.023 | x1.000 | x1.723 |
| blake3-servil-mt / solo / IdleOneMessage / 128 KiB | 0.675 | 0.692 | x1.025 | level | 1 of 4 | - | - | x1.025 | x1.000 | x1.132 |
| blake3-servil-mt / solo / IdleOneMessage / 256 KiB | 0.482 | 0.483 | x1.001 | level | 3 of 4 | - | - | x1.006 | x1.000 | x1.023 |
| blake3-servil-mt / solo / IdleOneMessage / 512 KiB | 0.264 | 0.255 | x0.966 | level | 4 of 4 | - | - | x0.966 | x1.020 | x0.941 |
| blake3-servil-mt / solo / IdleOneMessage / 1 MiB | 0.225 | 0.223 | x0.989 | level | 3 of 4 | - | - | x0.980 | x1.091 | x1.153 |
| blake3-servil-mt / solo / IdleOneMessage / 2 MiB | 0.172 | 0.172 | x0.998 | level | 1 of 4 | - | - | x0.994 | x1.001 | x1.066 |
| blake3-servil-mt / solo / IdleOneMessage / 3 MiB | 0.158 | 0.158 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.078 | x0.951 |
| blake3-servil-mt / solo / IdleOneMessage / 4 MiB | 0.149 | 0.149 | x1.000 | level | 2 of 4 | - | - | x1.002 | x1.127 | x0.916 |
| blake3-servil-mt / solo / IdleOneMessage / 8 MiB | 0.131 | 0.131 | x1.000 | level | 3 of 4 | - | - | x1.001 | x1.013 | x1.023 |
| blake3-servil-mt / solo / IdleOneMessage / 32 MiB | 0.110 | 0.110 | x1.004 | level | 2 of 4 | - | - | x1.003 | x1.008 | x1.010 |
| blake3-servil-mt / solo / IdleOneMessage / 64 MiB | 0.103 | 0.103 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.005 | x0.992 |
| blake3-servil-mt / solo / IdleOneMessage / 128 MiB | 0.104 | 0.104 | x0.999 | level | 4 of 4 | - | - | x0.999 | x1.000 | x0.999 |
| blake3-servil-mt / solo / IdleManyMessages / 1 | 677.388 | 699.927 | x1.033 | level | 2 of 4 | - | - | x0.990 | x1.008 | x0.817 |
| blake3-servil-mt / solo / IdleManyMessages / 2 | 770.258 | 756.023 | x0.982 | level | 3 of 4 | - | - | x1.001 | x0.997 | x0.830 |
| blake3-servil-mt / solo / IdleManyMessages / 3 | 798.428 | 765.443 | x0.959 | level | 3 of 4 | - | - | x0.993 | x0.998 | x1.754 |
| blake3-servil-mt / solo / IdleManyMessages / 4 | 383.981 | 382.764 | x0.997 | level | 2 of 4 | - | - | x0.996 | x0.997 | x0.946 |
| blake3-servil-mt / solo / IdleManyMessages / 6 | 432.624 | 449.459 | x1.039 | level | 1 of 4 | - | - | x1.005 | x0.998 | x0.871 |
| blake3-servil-mt / solo / IdleManyMessages / 8 | 295.463 | 288.057 | x0.975 | level | 2 of 4 | - | - | x0.997 | x0.998 | x0.508 |
| blake3-servil-mt / solo / IdleManyMessages / 12 | 283.504 | 286.474 | x1.010 | level | 1 of 4 | - | - | x0.994 | x0.999 | x1.422 |
| blake3-servil-mt / solo / IdleManyMessages / 16 | 202.151 | 203.169 | x1.005 | level | 1 of 4 | - | - | x1.005 | x0.998 | x1.047 |
| blake3-servil-mt / solo / IdleManyMessages / 24 | 223.472 | 223.128 | x0.998 | level | 2 of 4 | - | - | x1.001 | x0.999 | x1.101 |
| blake3-servil-mt / solo / IdleManyMessages / 32 | 182.930 | 181.007 | x0.989 | level | 2 of 4 | - | - | x0.999 | x0.998 | x0.914 |
| blake3-servil-mt / solo / IdleManyMessages / 48 | 167.482 | 174.563 | x1.042 | level | 1 of 4 | - | - | x0.997 | x0.999 | x0.829 |
| blake3-servil-mt / solo / IdleManyMessages / 64 | 160.211 | 163.782 | x1.022 | level | 1 of 4 | - | - | x0.999 | x0.999 | x0.990 |
| blake3-servil-mt / solo / IdleManyMessages / 128 | 121.060 | 120.413 | x0.995 | level | 3 of 4 | - | - | x1.001 | x1.000 | x0.925 |
| blake3-servil-mt / solo / IdleManyMessages / 256 | 95.625 | 94.467 | x0.988 | level | 1 of 4 | - | - | x0.999 | x1.000 | x0.728 |
| blake3-servil-mt / solo / IdleManyMessages / 512 | 83.241 | 82.341 | x0.989 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.010 |
| blake3-servil-mt / solo / IdleManyMessages / 1024 | 54.147 | 53.316 | x0.985 | level | 3 of 4 | - | - | x0.989 | x1.000 | x0.914 |
| blake3-servil-mt / solo / IdleManyMessages / 2048 | 43.584 | 43.804 | x1.005 | level | 1 of 4 | - | - | x0.999 | x1.000 | x0.802 |
| blake3-servil-mt / solo / IdleManyMessages / 4096 | 30.840 | 31.513 | x1.022 | level | 1 of 4 | - | - | x1.017 | x1.000 | x0.706 |
| blake3-servil-mt / solo / IdleManyMessages / 8192 | 13.596 | 13.307 | x0.979 | level | 3 of 4 | - | - | x0.989 | x1.001 | x0.922 |
| blake3-servil-mt / solo / IdleManyMessages / 16384 | 11.770 | 11.766 | x1.000 | level | 2 of 4 | - | - | x1.006 | x0.991 | x0.979 |
| blake3-servil-mt / solo / IdleManyMessages / 32768 | 10.665 | 10.608 | x0.995 | level | 2 of 4 | - | - | x1.001 | x0.999 | x1.017 |
| blake3-servil-mt / solo / IdleManyMessages / 65536 | 9.461 | 9.457 | x1.000 | level | 2 of 4 | - | - | x1.002 | x1.000 | x0.999 |
| blake3-servil-mt / solo / IdleManyMessages / 131072 | 8.511 | 8.499 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.018 | x1.008 |
| blake3-servil-mt / solo / IdleManyMessages / 262144 | 7.974 | 7.974 | x1.000 | level | 2 of 4 | - | - | x1.000 | x0.996 | x1.018 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 B | 3.240 | 3.281 | x1.013 | level | 1 of 4 | - | - | x1.000 | x1.005 | x1.021 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 B | 2.474 | 2.389 | x0.965 | level | 3 of 4 | - | - | x0.989 | x1.003 | x0.532 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 B | 1.800 | 1.806 | x1.003 | level | 3 of 4 | - | - | x0.995 | x1.003 | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 B | 1.647 | 1.636 | x0.993 | level | 3 of 4 | - | - | x0.994 | x1.001 | x1.465 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 KiB | 1.567 | 1.507 | x0.962 | level | 3 of 4 | - | - | x0.996 | x1.001 | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1536 B | 1.216 | 1.226 | x1.009 | level | 1 of 4 | - | - | x1.011 | x0.997 | x1.368 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 KiB | 0.905 | 0.921 | x1.018 | level | 2 of 4 | - | - | x1.014 | x1.000 | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2304 B | 1.026 | 1.008 | x0.983 | level | 2 of 4 | - | - | x0.984 | x1.001 | x0.754 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 KiB | 0.751 | 0.842 | x1.121 | level | 0 of 4 | - | - | x1.116 | x1.000 | x0.975 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3839 B | 0.581 | 0.583 | x1.004 | level | 1 of 4 | - | - | x1.003 | x1.001 | x1.010 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 KiB | 0.480 | 0.482 | x1.005 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.752 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4470 B | 0.589 | 0.593 | x1.007 | level | 1 of 4 | - | - | x1.006 | x1.001 | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 7935 B | 0.441 | 0.440 | x0.998 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.041 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 KiB | 0.391 | 0.393 | x1.006 | level | 1 of 4 | - | - | x1.005 | x1.000 | x1.099 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 16 KiB | 0.294 | 0.295 | x1.004 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.479 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 KiB | 0.292 | 0.293 | x1.002 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.031 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 KiB | 0.286 | 0.285 | x0.997 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.867 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 KiB | 0.282 | 0.282 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.532 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 KiB | 0.280 | 0.280 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.823 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 KiB | 0.143 | 0.135 | x0.943 | level | 3 of 4 | - | - | x0.942 | x0.992 | x0.798 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 MiB | 0.155 | 0.151 | x0.974 | level | 3 of 4 | - | - | x0.971 | x1.033 | x1.186 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 MiB | 0.134 | 0.135 | x1.004 | level | 2 of 4 | - | - | x1.003 | x1.049 | x1.061 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 MiB | 0.122 | 0.122 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.032 | x0.885 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 MiB | 0.120 | 0.119 | x0.998 | level | 3 of 4 | - | - | x0.999 | x1.043 | x0.664 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 MiB | 0.132 | 0.132 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.005 | x0.957 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 MiB | 0.109 | 0.109 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.995 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 MiB | 0.106 | 0.106 | x1.000 | level | 2 of 4 | - | - | x1.000 | x0.998 | x0.975 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 MiB | 0.104 | 0.104 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.999 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1 | 239.423 | 250.742 | x1.047 | level | 1 of 4 | - | - | x1.015 | x1.009 | x0.944 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2 | 251.764 | 261.055 | x1.037 | level | 0 of 4 | - | - | x1.019 | x0.998 | x0.735 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 3 | 108.394 | 111.977 | x1.033 | level | 0 of 4 | - | - | x1.015 | x0.998 | x2.334 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4 | 66.824 | 67.272 | x1.007 | level | 1 of 4 | - | - | x1.010 | x0.998 | x0.565 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 6 | 59.996 | 61.256 | x1.021 | level | 1 of 4 | - | - | x1.010 | x0.999 | x2.021 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8 | 41.811 | 43.900 | x1.050 | level | 1 of 4 | - | - | x1.010 | x0.999 | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 12 | 37.471 | 38.483 | x1.027 | level | 0 of 4 | - | - | x1.014 | x0.999 | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16 | 26.033 | 26.477 | x1.017 | level | 1 of 4 | - | - | x1.009 | x0.998 | x0.423 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 24 | 27.009 | 27.017 | x1.000 | level | 1 of 4 | - | - | x1.007 | x0.999 | x0.342 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32 | 21.585 | 21.799 | x1.010 | level | 1 of 4 | - | - | x1.006 | x0.999 | x0.678 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 48 | 19.724 | 19.908 | x1.009 | level | 1 of 4 | - | - | x1.006 | x0.999 | x1.022 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 64 | 18.909 | 19.038 | x1.007 | level | 0 of 4 | - | - | x1.005 | x0.999 | x1.251 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 128 | 17.829 | 17.960 | x1.007 | level | 0 of 4 | - | - | x1.007 | x1.000 | x1.003 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 256 | 18.176 | 18.266 | x1.005 | level | 0 of 4 | - | - | x1.005 | x1.000 | x0.729 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 512 | 18.297 | 18.462 | x1.009 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.874 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1024 | 18.055 | 18.047 | x1.000 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.900 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2048 | 17.963 | 18.017 | x1.003 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.975 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4096 | 17.992 | 18.036 | x1.002 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.213 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8192 | 11.052 | 11.160 | x1.010 | level | 3 of 4 | - | - | x1.014 | x1.099 | x0.937 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16384 | 9.519 | 9.541 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.040 | x1.018 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32768 | 8.506 | 8.472 | x0.996 | level | 2 of 4 | - | - | x1.000 | x1.051 | x1.000 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 65536 | 8.068 | 8.027 | x0.995 | level | 3 of 4 | - | - | x1.000 | x1.010 | x0.995 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 131072 | 8.530 | 8.516 | x0.998 | level | 2 of 4 | - | - | x0.999 | x0.994 | x1.021 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 262144 | 7.999 | 8.029 | x1.004 | level | 2 of 4 | - | - | x1.000 | x1.023 | x0.994 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 1.132 | 1.106 | x0.977 | level | 2 of 4 | x0.962 | - | x0.976 | x0.975 | x0.947 |
| blake3-servil-mt / solo / ContinuousMessages / 128 B | 0.583 | 0.543 | x0.932 | level | 4 of 4 | x0.959 | - | x0.932 | x0.975 | x0.610 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.301 | 0.294 | x0.974 | level | 3 of 4 | x0.976 | - | x0.974 | x0.976 | x1.285 |
| blake3-servil-mt / solo / ContinuousMessages / 512 B | 0.214 | 0.200 | x0.937 | level | 3 of 4 | x0.986 | - | x0.937 | x0.978 | x0.801 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.144 | 0.147 | x1.021 | level | 0 of 4 | x0.973 | - | x1.021 | x0.983 | x1.213 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.101 | 0.0961 | x0.955 | level | 4 of 4 | x1.033 | - | x0.954 | x0.973 | x0.976 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0908 | 0.0951 | x1.047 | level | 1 of 4 | x1.014 | - | x1.046 | x0.966 | x0.971 |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.0750 | 0.0758 | x1.011 | level | 2 of 4 | x1.001 | - | x1.011 | x1.021 | x1.009 |
| blake3-servil-mt / solo / ContinuousMessages / 256 KiB | 0.0735 | 0.0748 | x1.018 | level | 1 of 4 | x1.020 | - | x1.018 | x1.017 | x0.804 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0858 | 0.0852 | x0.992 | level | 3 of 4 | x0.963 | - | x0.993 | x1.013 | x1.112 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.101 | 0.100 | x0.994 | level | 2 of 4 | x1.012 | - | x0.995 | x1.002 | x0.976 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0980 | 0.0987 | x1.008 | level | 2 of 4 | x1.007 | - | x1.008 | x1.021 | x1.437 |
| blake3-servil-mt / solo / ContinuousMessages / 64 MiB | 0.109 | 0.111 | x1.013 | level | 0 of 4 | x1.007 | - | x1.013 | x1.004 | x1.006 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 15.119 | 14.973 | x0.990 | level | 3 of 4 | x0.991 | - | x0.990 | x0.975 | x1.254 |
| blake3-servil-mt / solo / ContinuousBatches / 64 | 9.439 | 9.475 | x1.004 | level | 0 of 4 | x1.007 | - | x1.004 | x0.979 | x0.912 |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 7.276 | 7.183 | x0.987 | level | 4 of 4 | x0.986 | - | x0.987 | x0.930 | x0.571 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 6.922 | 6.920 | x1.000 | level | 3 of 4 | x1.003 | - | x1.000 | x0.946 | x2.152 |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 7.033 | 7.116 | x1.012 | level | 1 of 4 | x1.007 | - | x1.011 | x1.002 | x0.985 |
| blake3-servil-mt / solo / ContinuousBatches / 16384 | 9.209 | 9.199 | x0.999 | level | 3 of 4 | x0.998 | - | x0.999 | x0.958 | x0.447 |
| blake3-servil-mt / solo / ContinuousBatches / 65536 | 8.934 | 9.059 | x1.014 | level | 2 of 4 | x1.015 | - | x1.013 | x1.003 | x1.557 |
| blake3-servil-mt / solo / LentMessages / 64 B | 1.520 | 1.519 | x0.999 | level | 1 of 4 | x0.999 | - | x0.999 | x1.012 | - |
| blake3-servil-mt / solo / LentMessages / 128 B | 1.448 | 1.438 | x0.993 | level | 4 of 4 | x0.993 | - | x0.993 | x1.007 | - |
| blake3-servil-mt / solo / LentMessages / 256 B | 1.410 | 1.417 | x1.005 | level | 3 of 4 | x1.004 | - | x1.004 | x1.004 | x0.695 |
| blake3-servil-mt / solo / LentMessages / 512 B | 1.409 | 1.408 | x0.999 | level | 2 of 4 | x1.000 | - | x1.000 | x1.003 | x0.566 |
| blake3-servil-mt / solo / LentMessages / 1 KiB | 1.400 | 1.399 | x1.000 | level | 2 of 4 | x0.999 | - | x0.999 | x1.001 | x0.197 |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.438 | 0.441 | x1.007 | level | 2 of 4 | x1.005 | - | x1.004 | x1.001 | x3.057 |
| blake3-servil-mt / solo / LentMessages / 16 KiB | 0.272 | 0.272 | x1.001 | level | 2 of 4 | x1.000 | - | x0.999 | x1.000 | x0.254 |
| blake3-servil-mt / solo / LentMessages / 64 KiB | 0.280 | 0.280 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | - |
| blake3-servil-mt / solo / LentMessages / 256 KiB | 0.277 | 0.278 | x1.005 | level | 0 of 4 | x1.005 | - | x1.002 | x1.000 | x0.738 |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.132 | 0.132 | x1.001 | level | 3 of 4 | x0.988 | - | x1.001 | x0.994 | x0.286 |
| blake3-servil-mt / solo / LentMessages / 4 MiB | 0.118 | 0.118 | x1.000 | level | 2 of 4 | x1.004 | - | x1.001 | x1.017 | x0.616 |
| blake3-servil-mt / solo / LentMessages / 16 MiB | 0.117 | 0.117 | x0.998 | level | 2 of 4 | x1.004 | - | x0.998 | x1.002 | x1.034 |
| blake3-servil-mt / solo / LentMessages / 64 MiB | 0.110 | 0.110 | x0.998 | level | 2 of 4 | x1.001 | - | x0.998 | x1.000 | x1.008 |
| blake3-servil-mt / solo / Interleaved / 256 | 0.393 | 0.392 | x0.998 | level | 2 of 4 | x0.998 | - | x0.998 | x0.995 | x0.659 |
| blake3-servil-mt / solo / Collection / git objects | 0.0162 | 0.0163 | x1.007 | level | 1 of 4 | x0.998 | - | x1.005 | x1.000 | x0.951 |
| blake3-servil-mt / solo / Collection / Nix files | 0.0244 | 0.0241 | x0.988 | level | 3 of 4 | x0.992 | - | x0.988 | x0.980 | x0.865 |
| blake3-servil-mt / solo / LentBatches / 16 | 21.188 | 21.018 | x0.992 | level | 2 of 4 | x0.992 | - | x0.992 | x0.998 | - |
| blake3-servil-mt / solo / LentBatches / 64 | 18.022 | 18.140 | x1.007 | level | 0 of 4 | x1.006 | - | x1.006 | x0.999 | - |
| blake3-servil-mt / solo / LentBatches / 256 | 17.842 | 17.748 | x0.995 | level | 4 of 4 | x0.994 | - | x0.995 | x1.000 | - |
| blake3-servil-mt / solo / LentBatches / 1024 | 19.220 | 19.447 | x1.012 | level | 0 of 4 | x1.011 | - | x1.011 | x0.999 | - |
| blake3-servil-mt / solo / LentBatches / 4096 | 19.224 | 19.406 | x1.009 | level | 1 of 4 | x1.009 | - | x1.009 | x1.000 | - |
| blake3-servil-mt / solo / LentBatches / 16384 | 11.089 | 11.244 | x1.014 | level | 1 of 4 | x1.004 | - | x1.018 | x1.041 | - |
| blake3-servil-mt / solo / LentBatches / 65536 | 10.143 | 10.318 | x1.017 | level | 3 of 4 | x1.008 | - | x1.018 | x1.003 | x0.948 |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.111 | 0.110 | x0.995 | level | 3 of 4 | x0.998 | - | x0.997 | x0.985 | x1.006 |
| blake3-servil-mt / solo / ContinuousCollection / Nix files | 0.109 | 0.108 | x0.989 | level | 3 of 4 | x1.014 | - | x0.995 | x0.988 | x1.011 |
| blake3-servil-mt / solo / MerkleTree / 1024 | 0.350 | 0.350 | x1.002 | level | 1 of 4 | x1.002 | - | x1.003 | x1.001 | x1.052 |
| blake3-servil-mt / solo / MerkleTree / 4096 | 0.230 | 0.229 | x0.997 | level | 2 of 4 | x0.997 | - | x0.999 | x1.004 | x0.467 |
| blake3-servil-mt / solo / MerkleTree / 16384 | 0.192 | 0.195 | x1.018 | level | 1 of 4 | x1.011 | - | x1.019 | x1.024 | x1.682 |
| blake3-servil-mt / solo / MerkleTree / 65536 | 0.165 | 0.169 | x1.022 | level | 0 of 4 | x1.000 | - | x1.022 | x1.004 | x0.988 |
| blake3-servil-mt / solo / MerkleTree / 262144 | 0.145 | 0.148 | x1.022 | level | 0 of 4 | x0.995 | - | x1.022 | x0.997 | x0.986 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 32 B | 0.257 | 0.261 | x1.015 | level | 0 of 4 | x1.017 | - | x1.015 | x1.017 | x1.328 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 32 B | 0.149 | 0.152 | x1.018 | level | 1 of 4 | x1.002 | - | x1.018 | x0.998 | x0.980 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 16 B | 0.274 | 0.275 | x1.003 | level | 1 of 4 | x1.003 | - | x1.004 | x1.005 | x0.975 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 48 B | 0.210 | 0.211 | x1.004 | level | 1 of 4 | x1.007 | - | x1.005 | x1.002 | x1.128 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 48 B | 0.139 | 0.139 | x1.001 | level | 2 of 4 | x1.000 | - | x1.001 | x1.002 | x0.998 |
| blake3-servil-mt / solo / InterleavedTurn / 256 | 1.012 | 1.007 | x0.995 | level | 2 of 4 | - | - | x1.003 | x1.001 | x1.015 |
| blake3-servil-mt / solo / InterleavedTurn / 1024 x 1 KiB | 0.697 | 0.681 | x0.978 | level | 2 of 4 | - | - | x0.976 | x0.999 | x1.010 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 256 | 0.658 | 0.669 | x1.016 | level | 1 of 4 | - | - | x1.024 | x1.053 | x1.032 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.655 | 0.637 | x0.972 | level | 4 of 4 | - | - | x0.976 | x0.995 | x1.000 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 256 | 0.663 | 0.662 | x0.999 | level | 1 of 4 | - | - | x0.992 | x1.010 | x1.000 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.620 | 0.606 | x0.976 | level | 4 of 4 | - | - | x0.976 | x0.993 | x1.000 |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.103 | 0.104 | x1.006 | level | 2 of 4 | x0.989 | - | x1.008 | x1.010 | x0.863 |
| blake3-servil-mt / solo / ReceivingMessage / 2 μs | 0.104 | 0.105 | x1.007 | level | 2 of 4 | x0.981 | - | x1.009 | x0.996 | x0.807 |
| blake3-servil-mt / solo / ReceivingMessage / 20 μs | 0.918 | 0.918 | x1.000 | level | 2 of 4 | x0.995 | - | x1.012 | x1.007 | x0.839 |
| blake3-servil-mt / solo / IncrementalMessage / 64 B | 19.874 | 20.327 | x1.023 | level | 2 of 4 | - | - | x1.011 | x1.002 | x1.146 |
| blake3-servil-mt / solo / IncrementalMessage / 1 KiB | 3.590 | 3.250 | x0.905 | level | 2 of 4 | - | - | x0.917 | x1.001 | x1.218 |
| blake3-servil-mt / solo / IncrementalMessage / 4 KiB | 2.461 | 2.478 | x1.007 | level | 0 of 4 | - | - | x1.007 | x1.001 | x1.071 |
| blake3-servil-mt / solo / LentIncrementalMessage / 64 B | 1.857 | 1.862 | x1.003 | level | 3 of 4 | x1.003 | - | x1.002 | x1.006 | x1.714 |
| blake3-servil-mt / solo / LentIncrementalMessage / 1 KiB | 1.438 | 1.441 | x1.003 | level | 0 of 4 | x1.003 | - | x1.003 | x1.002 | x2.040 |
| blake3-servil-mt / solo / LentIncrementalMessage / 4 KiB | 0.455 | 0.455 | x1.000 | level | 1 of 4 | x1.000 | - | x1.000 | x1.001 | x0.851 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 13.237 | 13.546 | x1.023 | level | 2 of 4 | x1.150 | - | x1.009 | x0.947 | x10.497 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 4 KiB | 0.251 | 0.252 | x1.002 | level | 3 of 4 | x0.993 | - | x1.004 | x0.947 | x5.650 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 1 MiB | 0.0848 | 0.0848 | x1.000 | level | 3 of 4 | x1.026 | - | x1.000 | x1.031 | x1.250 |
| blake3-servil-mt / solo / ContinuousLentMessages / 64 B | 1.018 | 0.994 | x0.977 | level | 3 of 4 | x0.935 | - | x0.976 | x0.969 | x0.772 |
| blake3-servil-mt / solo / ContinuousLentMessages / 4 KiB | 0.0512 | 0.0481 | x0.941 | level | 3 of 4 | x0.953 | - | x0.937 | x0.964 | x0.649 |
| blake3-servil-mt / solo / ContinuousLentMessages / 1 MiB | 0.00876 | 0.00879 | x1.003 | level | 1 of 4 | x0.993 | - | x1.004 | x1.001 | x1.211 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 1.140 | 1.090 | x0.956 | level | 4 of 4 | - | - | x0.956 | x0.975 | x0.931 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 128 B | 0.600 | 0.550 | x0.916 | level | 4 of 4 | - | - | x0.916 | x0.975 | x0.940 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.339 | 0.310 | x0.912 | level | 3 of 4 | - | - | x0.933 | x0.976 | x1.009 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 512 B | 0.256 | 0.250 | x0.978 | level | 3 of 4 | - | - | x0.977 | x0.978 | x0.994 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.180 | 0.174 | x0.963 | level | 3 of 4 | - | - | x0.963 | x0.983 | x1.124 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.107 | 0.107 | x0.997 | level | 3 of 4 | - | - | x0.989 | x0.976 | x1.009 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.109 | 0.108 | x0.996 | level | 3 of 4 | - | - | x0.996 | x0.966 | x0.821 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.0808 | 0.0807 | x0.999 | level | 2 of 4 | - | - | x0.998 | x1.028 | x0.945 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 KiB | 0.0799 | 0.0799 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.013 | x0.961 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0912 | 0.0907 | x0.995 | level | 2 of 4 | - | - | x0.995 | x1.013 | x0.887 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.105 | 0.105 | x1.004 | level | 2 of 4 | - | - | x1.005 | x1.025 | x1.078 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.104 | 0.105 | x1.009 | level | 1 of 4 | - | - | x1.010 | x1.010 | x0.966 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 MiB | 0.130 | 0.129 | x0.993 | level | 3 of 4 | - | - | x0.995 | x1.013 | x1.021 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 15.685 | 15.515 | x0.989 | level | 3 of 4 | - | - | x0.989 | x0.976 | x0.999 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 64 | 10.039 | 9.825 | x0.979 | level | 4 of 4 | - | - | x0.979 | x0.982 | x0.909 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 256 | 7.941 | 7.720 | x0.972 | level | 3 of 4 | - | - | x0.973 | x0.967 | x1.170 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 7.560 | 7.318 | x0.968 | level | 3 of 4 | - | - | x0.969 | x1.016 | x0.549 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 4096 | 7.867 | 7.624 | x0.969 | level | 3 of 4 | - | - | x0.970 | x1.047 | x0.874 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16384 | 9.690 | 9.666 | x0.998 | level | 2 of 4 | - | - | x0.996 | x0.984 | x0.753 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 65536 | 9.253 | 9.206 | x0.995 | level | 4 of 4 | - | - | x0.995 | x1.002 | x0.520 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 1.518 | 1.524 | x1.004 | level | 2 of 4 | - | - | x1.004 | x1.012 | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 128 B | 1.449 | 1.437 | x0.992 | level | 4 of 4 | - | - | x0.992 | x1.007 | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 B | 1.431 | 1.409 | x0.984 | level | 4 of 4 | - | - | x0.984 | x1.004 | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 512 B | 1.410 | 1.414 | x1.003 | level | 0 of 4 | - | - | x1.003 | x1.002 | x2.401 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 KiB | 1.398 | 1.400 | x1.001 | level | 0 of 4 | - | - | x1.001 | x1.001 | x1.139 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.441 | 0.437 | x0.990 | level | 4 of 4 | - | - | x0.990 | x1.001 | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 KiB | 0.272 | 0.271 | x0.997 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.062 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 KiB | 0.281 | 0.281 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.000 | x2.589 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 KiB | 0.277 | 0.277 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.015 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 MiB | 0.151 | 0.150 | x0.992 | level | 3 of 4 | - | - | x0.997 | x1.111 | x1.167 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 MiB | 0.125 | 0.125 | x0.995 | level | 3 of 4 | - | - | x0.995 | x0.950 | x0.858 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 MiB | 0.140 | 0.137 | x0.979 | level | 3 of 4 | - | - | x0.980 | x1.007 | x1.010 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 MiB | 0.124 | 0.125 | x1.002 | level | 1 of 4 | - | - | x1.002 | x1.001 | x1.001 |
| blake3-servil-mt / shared-one-cache / Interleaved / 256 | 0.384 | 0.385 | x1.002 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.189 |
| blake3-servil-mt / shared-one-cache / Collection / git objects | 0.0270 | 0.0263 | x0.975 | level | 4 of 4 | - | - | x1.051 | x1.054 | x1.013 |
| blake3-servil-mt / shared-one-cache / Collection / Nix files | 0.0328 | 0.0339 | x1.033 | level | 1 of 4 | - | - | x1.015 | x1.007 | x0.974 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16 | 20.510 | 20.913 | x1.020 | level | 0 of 4 | - | - | x1.018 | x0.998 | x0.606 |
| blake3-servil-mt / shared-one-cache / LentBatches / 64 | 17.999 | 18.063 | x1.004 | level | 1 of 4 | - | - | x1.003 | x0.999 | x0.946 |
| blake3-servil-mt / shared-one-cache / LentBatches / 256 | 17.788 | 17.645 | x0.992 | level | 4 of 4 | - | - | x0.992 | x1.000 | x0.844 |
| blake3-servil-mt / shared-one-cache / LentBatches / 1024 | 19.320 | 19.173 | x0.992 | level | 4 of 4 | - | - | x0.992 | x1.000 | x3.283 |
| blake3-servil-mt / shared-one-cache / LentBatches / 4096 | 19.298 | 19.137 | x0.992 | level | 4 of 4 | - | - | x0.992 | x1.000 | - |
| blake3-servil-mt / shared-one-cache / LentBatches / 16384 | 12.762 | 12.607 | x0.988 | level | 4 of 4 | - | - | x0.988 | x1.039 | x1.368 |
| blake3-servil-mt / shared-one-cache / LentBatches / 65536 | 10.577 | 10.401 | x0.983 | level | 4 of 4 | - | - | x0.983 | x0.983 | x1.361 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.128 | 0.127 | x0.993 | level | 2 of 4 | - | - | x0.993 | x0.985 | x0.981 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / Nix files | 0.126 | 0.124 | x0.985 | level | 2 of 4 | - | - | x0.988 | x0.990 | x0.998 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1024 | 0.350 | 0.349 | x0.997 | level | 4 of 4 | - | - | x0.998 | x1.001 | x2.149 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 4096 | 0.250 | 0.252 | x1.005 | level | 1 of 4 | - | - | x1.005 | x0.999 | x0.777 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 16384 | 0.202 | 0.203 | x1.002 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.844 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 | 0.193 | 0.192 | x0.997 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.991 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 262144 | 0.175 | 0.174 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.006 | x1.014 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 32 B | 0.286 | 0.285 | x0.995 | level | 3 of 4 | - | - | x0.994 | x0.987 | x0.583 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 32 B | 0.232 | 0.232 | x1.000 | level | 3 of 4 | - | - | x0.997 | x1.016 | x0.993 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 16 B | 0.421 | 0.423 | x1.004 | level | 2 of 4 | - | - | x1.004 | x1.028 | x0.994 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 48 B | 0.231 | 0.228 | x0.983 | level | 4 of 4 | - | - | x0.991 | x1.008 | x0.483 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 48 B | 0.195 | 0.196 | x1.005 | level | 2 of 4 | - | - | x1.001 | x1.019 | x0.990 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.111 | 0.110 | x0.984 | level | 2 of 4 | - | - | x0.984 | x1.017 | x0.973 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 2 μs | 0.113 | 0.111 | x0.984 | level | 2 of 4 | - | - | x0.984 | x1.012 | x0.971 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 20 μs | 0.918 | 0.918 | x1.000 | level | 4 of 4 | - | - | x1.017 | x1.008 | x0.983 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 64 B | 1.856 | 1.864 | x1.004 | level | 1 of 4 | - | - | x1.004 | x1.006 | x0.859 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 1 KiB | 1.437 | 1.440 | x1.002 | level | 0 of 4 | - | - | x1.002 | x1.002 | x0.982 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 4 KiB | 0.454 | 0.455 | x1.003 | level | 0 of 4 | - | - | x1.003 | x1.001 | x0.914 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 18.175 | 17.417 | x0.958 | level | 3 of 4 | - | - | x1.012 | x0.945 | x14.760 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 4 KiB | 0.295 | 0.290 | x0.982 | level | 3 of 4 | - | - | x0.987 | x0.947 | x18.815 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 1 MiB | 0.0887 | 0.0904 | x1.020 | level | 1 of 4 | - | - | x1.021 | x1.009 | x1.023 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 64 B | 1.076 | 1.005 | x0.934 | level | 4 of 4 | - | - | x0.936 | x0.969 | x0.932 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 4 KiB | 0.0643 | 0.0621 | x0.965 | level | 3 of 4 | - | - | x0.954 | x0.965 | x1.263 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 1 MiB | 0.0175 | 0.0200 | x1.144 | level | 1 of 4 | - | - | x1.074 | x1.077 | x0.955 |

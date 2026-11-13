compare: old side: bench 3363bee8ff5e clean; servil b5b988d8982b clean
compare: new side: bench 97c0fbcbedb8 clean; servil bf2da8b957f5 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 16.674 | 15.396 | x0.923 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 128 B | 9.593 | 9.504 | x0.991 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 256 B | 5.524 | 5.390 | x0.976 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 512 B | 3.551 | 3.577 | x1.008 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 1 KiB | 2.531 | 2.551 | x1.008 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 1536 B | 5.052 | 4.822 | x0.955 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 2 KiB | 4.257 | 4.234 | x0.995 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 2304 B | 4.489 | 4.469 | x0.996 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 3 KiB | 4.963 | 3.144 | x0.633 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 3839 B | 4.925 | 3.175 | x0.645 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 4 KiB | 2.330 | 2.317 | x0.994 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 4470 B | 2.584 | 2.588 | x1.001 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 7935 B | 3.414 | 2.190 | x0.642 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 8 KiB | 1.857 | 1.851 | x0.997 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 16 KiB | 1.343 | 1.342 | x0.999 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 32 KiB | 1.242 | 1.251 | x1.007 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 64 KiB | 1.063 | 1.058 | x0.995 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 128 KiB | 0.668 | 0.674 | x1.010 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 256 KiB | 0.480 | 0.480 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 512 KiB | 0.421 | 0.425 | x1.007 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 1 MiB | 0.392 | 0.391 | x0.998 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 2 MiB | 0.378 | 0.379 | x1.001 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 3 MiB | 0.372 | 0.373 | x1.001 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 4 MiB | 0.370 | 0.368 | x0.995 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 8 MiB | 0.370 | 0.371 | x1.002 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 32 MiB | 0.348 | 0.350 | x1.004 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 64 MiB | 0.348 | 0.349 | x1.004 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 128 MiB | 0.347 | 0.349 | x1.003 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 1 | 1038.687 | 1013.876 | x0.976 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 2 | 729.732 | 717.301 | x0.983 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 3 | 612.555 | 599.357 | x0.978 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 4 | 393.852 | 402.715 | x1.023 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 6 | 340.793 | 358.639 | x1.052 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 8 | 260.334 | 261.972 | x1.006 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 12 | 206.682 | 207.251 | x1.003 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 16 | 156.479 | 152.028 | x0.972 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 24 | 141.113 | 139.821 | x0.991 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 32 | 112.505 | 112.434 | x0.999 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 48 | 100.930 | 99.814 | x0.989 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 64 | 93.272 | 91.751 | x0.984 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 128 | 84.675 | 84.319 | x0.996 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 256 | 80.094 | 80.213 | x1.001 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 512 | 77.886 | 77.733 | x0.998 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 1024 | 66.731 | 66.596 | x0.998 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 2048 | 42.615 | 42.822 | x1.005 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 4096 | 31.061 | 31.163 | x1.003 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 8192 | 27.661 | 27.460 | x0.993 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 16384 | 25.526 | 25.350 | x0.993 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 32768 | 24.695 | 24.509 | x0.992 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 65536 | 24.501 | 24.263 | x0.990 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 131072 | 24.551 | 24.311 | x0.990 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 262144 | 25.024 | 24.775 | x0.990 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / ManyLongMessages / 4 | 8251.871 | 8281.057 | x1.004 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / ManyLongMessages / 16 | 4937.644 | 4933.764 | x0.999 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ManyLongMessages / 64 | 1967.356 | 1960.848 | x0.997 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / ManyLongMessages / 256 | 1605.884 | 1603.487 | x0.999 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 64 B | 7.966 | 8.493 | x1.066 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 128 B | 5.841 | 5.486 | x0.939 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 256 B | 4.495 | 4.401 | x0.979 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 512 B | 4.168 | 4.395 | x1.054 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 1 KiB | 3.674 | 3.533 | x0.961 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 1536 B | 9.121 | 9.050 | x0.992 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 2 KiB | 8.111 | 8.398 | x1.035 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 2304 B | 8.810 | 8.835 | x1.003 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 3 KiB | 8.646 | 6.137 | x0.710 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 8.071 | 6.812 | x0.844 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 4 KiB | 4.354 | 4.395 | x1.009 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 4470 B | 5.065 | 5.139 | x1.015 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 7935 B | 4.924 | 3.917 | x0.796 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 8 KiB | 3.191 | 3.117 | x0.977 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 16 KiB | 1.945 | 2.001 | x1.029 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 32 KiB | 1.523 | 1.519 | x0.997 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 64 KiB | 1.014 | 0.981 | x0.967 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 128 KiB | 0.627 | 0.630 | x1.005 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 256 KiB | 0.504 | 0.506 | x1.004 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 512 KiB | 0.386 | 0.385 | x0.997 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 1 MiB | 0.357 | 0.359 | x1.004 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 2 MiB | 0.346 | 0.347 | x1.002 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 3 MiB | 0.339 | 0.341 | x1.006 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 4 MiB | 0.336 | 0.337 | x1.004 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 8 MiB | 0.332 | 0.334 | x1.006 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 32 MiB | 0.340 | 0.340 | x1.002 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 64 MiB | 0.344 | 0.345 | x1.003 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 128 MiB | 0.346 | 0.347 | x1.004 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 1 | 588.855 | 630.570 | x1.071 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 2 | 769.822 | 751.181 | x0.976 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 3 | 786.437 | 786.520 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 4 | 392.047 | 387.751 | x0.989 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 6 | 426.431 | 419.837 | x0.985 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 8 | 284.547 | 277.045 | x0.974 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 12 | 282.251 | 279.740 | x0.991 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 16 | 198.441 | 194.597 | x0.981 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 24 | 217.604 | 211.957 | x0.974 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 32 | 181.714 | 168.234 | x0.926 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 48 | 178.391 | 167.968 | x0.942 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 64 | 171.374 | 168.584 | x0.984 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 128 | 165.587 | 167.966 | x1.014 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 256 | 122.574 | 121.819 | x0.994 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 512 | 97.213 | 96.933 | x0.997 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 1024 | 64.777 | 63.895 | x0.986 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 2048 | 40.379 | 40.461 | x1.002 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 4096 | 32.179 | 31.693 | x0.985 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 8192 | 25.264 | 25.428 | x1.006 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 16384 | 24.368 | 24.342 | x0.999 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 32768 | 23.015 | 22.880 | x0.994 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 65536 | 22.452 | 22.351 | x0.995 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 131072 | 22.190 | 22.132 | x0.997 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 262144 | 22.486 | 22.412 | x0.997 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 B | 2.683 | 2.628 | x0.979 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 B | 2.097 | 2.088 | x0.996 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 B | 1.857 | 1.888 | x1.017 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 B | 1.681 | 1.764 | x1.049 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 KiB | 1.651 | 1.818 | x1.101 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 1536 B | 2.634 | 2.559 | x0.972 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 KiB | 0.882 | 0.893 | x1.013 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 2304 B | 1.055 | 1.011 | x0.958 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 1.082 | 1.036 | x0.957 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 3839 B | 1.141 | 0.824 | x0.722 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 KiB | 0.644 | 0.488 | x0.757 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 4470 B | 0.580 | 0.592 | x1.020 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 7935 B | 0.762 | 0.547 | x0.717 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 KiB | 0.391 | 0.393 | x1.006 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 16 KiB | 0.286 | 0.291 | x1.017 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 KiB | 0.290 | 0.292 | x1.005 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 KiB | 0.281 | 0.283 | x1.007 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 KiB | 0.278 | 0.280 | x1.007 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 KiB | 0.277 | 0.279 | x1.005 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 KiB | 0.283 | 0.283 | x1.003 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 MiB | 0.319 | 0.319 | x0.998 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 MiB | 0.326 | 0.328 | x1.007 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 MiB | 0.326 | 0.327 | x1.004 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 MiB | 0.326 | 0.327 | x1.005 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 MiB | 0.355 | 0.357 | x1.004 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 MiB | 0.340 | 0.341 | x1.003 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 MiB | 0.344 | 0.345 | x1.004 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 MiB | 0.346 | 0.347 | x1.003 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 1 | 209.151 | 220.820 | x1.056 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 2 | 123.264 | 129.155 | x1.048 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 3 | 227.260 | 237.831 | x1.047 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 4 | 136.859 | 143.115 | x1.046 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 6 | 61.399 | 63.652 | x1.037 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 8 | 39.941 | 41.630 | x1.042 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 12 | 35.925 | 36.720 | x1.022 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 16 | 25.013 | 25.993 | x1.039 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 24 | 25.726 | 26.101 | x1.015 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 32 | 20.864 | 21.198 | x1.016 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 48 | 19.352 | 19.498 | x1.008 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 64 | 18.517 | 18.766 | x1.013 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 128 | 17.330 | 17.369 | x1.002 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 256 | 17.788 | 17.832 | x1.002 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 512 | 18.267 | 18.208 | x0.997 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 1024 | 18.041 | 18.021 | x0.999 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 2048 | 17.988 | 17.921 | x0.996 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 4096 | 17.952 | 17.955 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 8192 | 19.321 | 19.335 | x1.001 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 16384 | 21.912 | 21.882 | x0.999 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 32768 | 21.800 | 21.709 | x0.996 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 65536 | 21.834 | 21.734 | x0.995 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 131072 | 23.352 | 23.283 | x0.997 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 262144 | 22.521 | 22.416 | x0.995 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 1.589 | 1.519 | x0.956 | level | 4 of 4 | x0.956 | - |
| blake3-servil-st / solo / ContinuousMessages / 128 B | 1.501 | 1.456 | x0.970 | level | 4 of 4 | x0.970 | - |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 1.438 | 1.412 | x0.982 | level | 4 of 4 | x0.982 | - |
| blake3-servil-st / solo / ContinuousMessages / 512 B | 1.422 | 1.404 | x0.987 | level | 4 of 4 | x0.989 | - |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 1.403 | 1.398 | x0.996 | level | 3 of 4 | x0.996 | - |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.435 | 0.436 | x1.002 | level | 1 of 4 | x1.002 | - |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.269 | 0.271 | x1.006 | level | 0 of 4 | x1.006 | - |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.277 | 0.278 | x1.005 | level | 0 of 4 | x1.005 | - |
| blake3-servil-st / solo / ContinuousMessages / 256 KiB | 0.297 | 0.302 | x1.019 | level | 0 of 4 | x1.019 | - |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.300 | 0.302 | x1.007 | level | 0 of 4 | x1.007 | - |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.306 | 0.308 | x1.006 | level | 0 of 4 | x1.006 | - |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.307 | 0.309 | x1.008 | level | 0 of 4 | x1.005 | - |
| blake3-servil-st / solo / ContinuousMessages / 64 MiB | 0.323 | 0.325 | x1.005 | level | 0 of 4 | x1.005 | - |
| blake3-servil-st / solo / ContinuousBatches / 16 | 21.087 | 20.938 | x0.993 | level | 3 of 4 | x0.993 | - |
| blake3-servil-st / solo / ContinuousBatches / 64 | 17.966 | 17.817 | x0.992 | level | 4 of 4 | x0.992 | - |
| blake3-servil-st / solo / ContinuousBatches / 256 | 17.884 | 17.644 | x0.987 | level | 4 of 4 | x0.987 | - |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 19.390 | 19.015 | x0.981 | level | 4 of 4 | x0.981 | - |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 19.315 | 19.183 | x0.993 | level | 2 of 4 | x0.994 | - |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 22.582 | 22.324 | x0.989 | level | 4 of 4 | x0.988 | - |
| blake3-servil-st / solo / ContinuousBatches / 65536 | 22.920 | 22.724 | x0.991 | level | 4 of 4 | x0.990 | - |
| blake3-servil-st / solo / LentMessages / 64 B | 1.589 | 1.519 | x0.956 | level | 4 of 4 | x0.956 | - |
| blake3-servil-st / solo / LentMessages / 128 B | 1.501 | 1.456 | x0.970 | level | 4 of 4 | x0.970 | - |
| blake3-servil-st / solo / LentMessages / 256 B | 1.438 | 1.412 | x0.982 | level | 4 of 4 | x0.982 | - |
| blake3-servil-st / solo / LentMessages / 512 B | 1.422 | 1.404 | x0.987 | level | 4 of 4 | x0.989 | - |
| blake3-servil-st / solo / LentMessages / 1 KiB | 1.403 | 1.398 | x0.996 | level | 3 of 4 | x0.996 | - |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.435 | 0.436 | x1.002 | level | 1 of 4 | x1.002 | - |
| blake3-servil-st / solo / LentMessages / 16 KiB | 0.269 | 0.271 | x1.006 | level | 0 of 4 | x1.006 | - |
| blake3-servil-st / solo / LentMessages / 64 KiB | 0.277 | 0.278 | x1.005 | level | 0 of 4 | x1.005 | - |
| blake3-servil-st / solo / LentMessages / 256 KiB | 0.273 | 0.275 | x1.005 | level | 0 of 4 | x1.004 | - |
| blake3-servil-st / solo / LentMessages / 1 MiB | 0.312 | 0.313 | x1.005 | level | 0 of 4 | x1.005 | - |
| blake3-servil-st / solo / LentMessages / 4 MiB | 0.324 | 0.325 | x1.002 | level | 1 of 4 | x1.002 | - |
| blake3-servil-st / solo / LentMessages / 16 MiB | 0.340 | 0.342 | x1.005 | level | 1 of 4 | x1.005 | - |
| blake3-servil-st / solo / LentMessages / 64 MiB | 0.344 | 0.345 | x1.003 | level | 1 of 4 | x1.003 | - |
| blake3-servil-st / solo / Interleaved / 256 | 0.396 | 0.389 | x0.982 | level | 4 of 4 | x0.984 | - |
| blake3-servil-st / solo / Collection / git objects | 0.292 | 0.288 | x0.984 | level | 4 of 4 | x0.984 | - |
| blake3-servil-st / solo / Collection / Nix files | 0.292 | 0.282 | x0.966 | faster | 4 of 4 | x0.966 | - |
| blake3-servil-st / solo / LentBatches / 16 | 21.087 | 20.938 | x0.993 | level | 3 of 4 | x0.993 | - |
| blake3-servil-st / solo / LentBatches / 64 | 17.966 | 17.817 | x0.992 | level | 4 of 4 | x0.992 | - |
| blake3-servil-st / solo / LentBatches / 256 | 17.884 | 17.644 | x0.987 | level | 4 of 4 | x0.987 | - |
| blake3-servil-st / solo / LentBatches / 1024 | 19.390 | 19.015 | x0.981 | level | 4 of 4 | x0.981 | - |
| blake3-servil-st / solo / LentBatches / 4096 | 19.315 | 19.183 | x0.993 | level | 2 of 4 | x0.994 | - |
| blake3-servil-st / solo / LentBatches / 16384 | 22.582 | 22.324 | x0.989 | level | 4 of 4 | x0.988 | - |
| blake3-servil-st / solo / LentBatches / 65536 | 22.920 | 22.724 | x0.991 | level | 4 of 4 | x0.990 | - |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.356 | 0.347 | x0.974 | level | 4 of 4 | x0.974 | - |
| blake3-servil-st / solo / ContinuousCollection / Nix files | 0.368 | 0.356 | x0.965 | faster | 4 of 4 | x0.966 | - |
| blake3-servil-st / solo / MerkleTree / 1024 | 0.348 | 0.348 | x1.000 | level | 3 of 4 | x1.000 | - |
| blake3-servil-st / solo / MerkleTree / 4096 | 0.397 | 0.395 | x0.997 | level | 3 of 4 | x0.997 | - |
| blake3-servil-st / solo / MerkleTree / 16384 | 0.406 | 0.406 | x0.999 | level | 2 of 4 | x0.999 | - |
| blake3-servil-st / solo / MerkleTree / 65536 | 0.433 | 0.433 | x1.000 | level | 2 of 4 | x1.000 | - |
| blake3-servil-st / solo / MerkleTree / 262144 | 0.461 | 0.461 | x1.000 | level | 2 of 4 | x1.000 | - |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.744 | 0.728 | x0.978 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.698 | 0.676 | x0.969 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.528 | 0.514 | x0.975 | level | 4 of 4 | - | - |

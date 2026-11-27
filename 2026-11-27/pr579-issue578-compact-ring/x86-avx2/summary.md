# Nightly drift check: 2557d53c772e -> 7f392fdebc90

- Host: bench-zen3
- Experiment: `bench=3f119a507807078649d8700112994fce24666868|base=2557d53c772edfa2f3eeb28b8c8827919a27d608|target=7f392fdebc90aa362c7115cceb1824df2319102b|cells=all|layouts=default`
- bench-hashes: `3f119a507807078649d8700112994fce24666868`
- BLAKE3-Servil base: `2557d53c772edfa2f3eeb28b8c8827919a27d608`
- BLAKE3-Servil target: `7f392fdebc90aa362c7115cceb1824df2319102b`
- Scope: `--cells all` (layouts: default)
- Deciding stage: stage 2 (kept-drift/second)
- Verdict: **no regression** (exit `0`)

## Stage 2 (deciding, kept-drift/second)

compare: old side: bench 3f119a507807 clean; servil 2557d53c772e clean
compare: new side: bench 3f119a507807 clean; servil 7f392fdebc90 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / ManyMessages / 6 | 147.734 | 147.059 | x0.995 | level | 30 of 64 | - | - | x1.002 | x1.000 | x1.003 |
| blake3-servil-st / solo / IdleManyMessages / 6 | 95.185 | 93.624 | x0.984 | level | 39 of 64 | - | - | x0.995 | x1.000 | x1.076 |
| blake3-servil-st / solo / IncrementalMessage / 64 B | 7.181 | 7.224 | x1.006 | level | 27 of 64 | - | - | x1.000 | x1.000 | x1.011 |
| blake3-servil-mt / solo / OneMessage / 256 B | 2.880 | 2.862 | x0.994 | level | 29 of 64 | - | - | x0.997 | x1.000 | x1.014 |
| blake3-servil-mt / solo / IdleManyMessages / 2 | 199.620 | 199.090 | x0.997 | level | 38 of 64 | - | - | x1.001 | x1.000 | x1.167 |
| blake3-servil-mt / solo / ContinuousCollection / Nix files | 0.0616 | 0.0613 | x0.995 | level | 37 of 64 | x1.002 | - | x0.996 | x0.999 | x0.996 |
| blake3-servil-mt / solo / IncrementalMessage / 64 B | 7.594 | 7.676 | x1.011 | level | 23 of 64 | - | - | x1.006 | x1.000 | x1.023 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 5.837 | 5.725 | x0.981 | level | 37 of 64 | x1.013 | - | x0.980 | x0.998 | x1.009 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / Nix files | 0.0915 | 0.0914 | x0.998 | level | 31 of 64 | - | - | x0.999 | x0.999 | x0.993 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 14.107 | 13.949 | x0.989 | level | 34 of 64 | - | - | x0.992 | x0.998 | x1.012 |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / Nix files | 0.105 | 0.105 | x0.996 | level | 32 of 64 | - | - | x0.996 | x0.999 | x1.015 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 64 B | 17.019 | 16.929 | x0.995 | level | 33 of 64 | - | - | x0.994 | x1.000 | x1.008 |

## Stage 1 (initial screen, kept-drift)

compare: old side: bench 3f119a507807 clean; servil 2557d53c772e clean
compare: new side: bench 3f119a507807 clean; servil 7f392fdebc90 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy | cycles | instructions | cache misses |
|---|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 7.054 | 8.062 | x1.143 | level | 2 of 4 | - | - | x1.051 | x1.001 | x1.084 |
| blake3-servil-st / solo / OneMessage / 128 B | 4.391 | 4.539 | x1.034 | level | 2 of 4 | - | - | x1.014 | x1.002 | x1.059 |
| blake3-servil-st / solo / OneMessage / 256 B | 2.626 | 2.689 | x1.024 | level | 1 of 4 | - | - | x1.026 | x1.000 | x1.075 |
| blake3-servil-st / solo / OneMessage / 512 B | 1.848 | 1.862 | x1.008 | level | 2 of 4 | - | - | x1.012 | x1.001 | x1.064 |
| blake3-servil-st / solo / OneMessage / 1 KiB | 1.394 | 1.476 | x1.058 | level | 1 of 4 | - | - | x1.018 | x1.001 | x1.058 |
| blake3-servil-st / solo / OneMessage / 1536 B | 1.431 | 1.848 | x1.291 | level | 1 of 4 | - | - | x0.997 | x1.000 | x1.007 |
| blake3-servil-st / solo / OneMessage / 2 KiB | 0.985 | 0.947 | x0.962 | level | 3 of 4 | - | - | x0.991 | x1.001 | x1.000 |
| blake3-servil-st / solo / OneMessage / 2304 B | 1.102 | 1.146 | x1.040 | level | 2 of 4 | - | - | x1.019 | x1.001 | x1.002 |
| blake3-servil-st / solo / OneMessage / 3 KiB | 0.872 | 0.852 | x0.977 | level | 3 of 4 | - | - | x1.003 | x1.001 | x0.975 |
| blake3-servil-st / solo / OneMessage / 3839 B | 0.952 | 0.951 | x0.998 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.013 |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.605 | 0.615 | x1.017 | level | 1 of 4 | - | - | x1.017 | x1.000 | x1.001 |
| blake3-servil-st / solo / OneMessage / 4470 B | 0.695 | 0.704 | x1.014 | level | 2 of 4 | - | - | x1.014 | x1.000 | x1.008 |
| blake3-servil-st / solo / OneMessage / 7935 B | 0.542 | 0.524 | x0.967 | level | 3 of 4 | - | - | x0.965 | x1.000 | x1.010 |
| blake3-servil-st / solo / OneMessage / 8 KiB | 0.437 | 0.438 | x1.002 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.022 |
| blake3-servil-st / solo / OneMessage / 16 KiB | 0.375 | 0.368 | x0.982 | level | 3 of 4 | - | - | x0.982 | x1.000 | x1.025 |
| blake3-servil-st / solo / OneMessage / 32 KiB | 0.334 | 0.330 | x0.989 | level | 2 of 4 | - | - | x0.992 | x1.000 | x1.022 |
| blake3-servil-st / solo / OneMessage / 64 KiB | 0.312 | 0.311 | x0.997 | level | 2 of 4 | - | - | x0.995 | x1.000 | x1.019 |
| blake3-servil-st / solo / OneMessage / 128 KiB | 0.304 | 0.302 | x0.994 | level | 3 of 4 | - | - | x0.993 | x1.000 | x1.053 |
| blake3-servil-st / solo / OneMessage / 256 KiB | 0.294 | 0.292 | x0.994 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.038 |
| blake3-servil-st / solo / OneMessage / 512 KiB | 0.286 | 0.285 | x0.998 | level | 3 of 4 | - | - | x0.995 | x1.000 | x1.045 |
| blake3-servil-st / solo / OneMessage / 1 MiB | 0.287 | 0.284 | x0.989 | level | 4 of 4 | - | - | x0.991 | x1.000 | x1.032 |
| blake3-servil-st / solo / OneMessage / 2 MiB | 0.297 | 0.296 | x0.996 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.040 |
| blake3-servil-st / solo / OneMessage / 3 MiB | 0.303 | 0.303 | x0.999 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.038 |
| blake3-servil-st / solo / OneMessage / 4 MiB | 0.295 | 0.298 | x1.012 | level | 1 of 4 | - | - | x1.011 | x1.000 | x1.052 |
| blake3-servil-st / solo / OneMessage / 8 MiB | 0.310 | 0.311 | x1.002 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.038 |
| blake3-servil-st / solo / OneMessage / 32 MiB | 0.301 | 0.300 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.062 |
| blake3-servil-st / solo / OneMessage / 64 MiB | 0.301 | 0.300 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.045 |
| blake3-servil-st / solo / OneMessage / 128 MiB | 0.300 | 0.298 | x0.996 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.044 |
| blake3-servil-st / solo / ManyMessages / 1 | 440.871 | 468.462 | x1.063 | level | 1 of 4 | - | - | x1.051 | x1.003 | x1.017 |
| blake3-servil-st / solo / ManyMessages / 2 | 276.275 | 291.196 | x1.054 | level | 2 of 4 | - | - | x1.056 | x1.006 | x1.004 |
| blake3-servil-st / solo / ManyMessages / 3 | 207.980 | 220.858 | x1.062 | level | 1 of 4 | - | - | x1.048 | x1.006 | x0.977 |
| blake3-servil-st / solo / ManyMessages / 4 | 156.369 | 164.309 | x1.051 | level | 1 of 4 | - | - | x1.090 | x1.005 | x1.038 |
| blake3-servil-st / solo / ManyMessages / 6 | 123.576 | 132.133 | x1.069 | level | 0 of 4 | - | - | x1.074 | x1.004 | x1.039 |
| blake3-servil-st / solo / ManyMessages / 8 | 115.689 | 114.405 | x0.989 | level | 2 of 4 | - | - | x1.002 | x1.006 | x1.031 |
| blake3-servil-st / solo / ManyMessages / 12 | 84.621 | 83.716 | x0.989 | level | 2 of 4 | - | - | x1.013 | x1.004 | x1.026 |
| blake3-servil-st / solo / ManyMessages / 16 | 63.900 | 63.256 | x0.990 | level | 2 of 4 | - | - | x1.007 | x1.003 | x1.023 |
| blake3-servil-st / solo / ManyMessages / 24 | 47.727 | 46.987 | x0.985 | level | 3 of 4 | - | - | x0.999 | x1.003 | x1.016 |
| blake3-servil-st / solo / ManyMessages / 32 | 39.721 | 38.880 | x0.979 | level | 2 of 4 | - | - | x1.003 | x1.001 | x1.006 |
| blake3-servil-st / solo / ManyMessages / 48 | 32.729 | 30.985 | x0.947 | level | 2 of 4 | - | - | x0.968 | x1.002 | x1.009 |
| blake3-servil-st / solo / ManyMessages / 64 | 29.496 | 27.411 | x0.929 | level | 4 of 4 | - | - | x0.974 | x1.001 | x1.006 |
| blake3-servil-st / solo / ManyMessages / 128 | 24.078 | 23.337 | x0.969 | level | 2 of 4 | - | - | x0.996 | x1.001 | x1.019 |
| blake3-servil-st / solo / ManyMessages / 256 | 21.125 | 21.025 | x0.995 | level | 3 of 4 | - | - | x0.992 | x1.000 | x1.025 |
| blake3-servil-st / solo / ManyMessages / 512 | 19.394 | 18.904 | x0.975 | level | 3 of 4 | - | - | x0.977 | x1.000 | x1.024 |
| blake3-servil-st / solo / ManyMessages / 1024 | 18.645 | 18.418 | x0.988 | level | 3 of 4 | - | - | x0.990 | x1.000 | x1.020 |
| blake3-servil-st / solo / ManyMessages / 2048 | 18.344 | 18.191 | x0.992 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.010 |
| blake3-servil-st / solo / ManyMessages / 4096 | 18.007 | 17.930 | x0.996 | level | 4 of 4 | - | - | x0.998 | x1.000 | x0.994 |
| blake3-servil-st / solo / ManyMessages / 8192 | 17.343 | 17.235 | x0.994 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.007 |
| blake3-servil-st / solo / ManyMessages / 16384 | 17.128 | 17.150 | x1.001 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.999 |
| blake3-servil-st / solo / ManyMessages / 32768 | 17.401 | 17.309 | x0.995 | level | 2 of 4 | - | - | x0.995 | x1.000 | x0.985 |
| blake3-servil-st / solo / ManyMessages / 65536 | 17.569 | 17.520 | x0.997 | level | 2 of 4 | - | - | x0.996 | x1.000 | x0.981 |
| blake3-servil-st / solo / ManyMessages / 131072 | 18.044 | 18.043 | x1.000 | level | 1 of 4 | - | - | x0.999 | x1.000 | x0.991 |
| blake3-servil-st / solo / ManyMessages / 262144 | 18.491 | 18.456 | x0.998 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.990 |
| blake3-servil-st / solo / ManyLongMessages / 4 | 1784.175 | 1864.867 | x1.045 | level | 1 of 4 | - | - | x1.020 | x1.000 | x1.019 |
| blake3-servil-st / solo / ManyLongMessages / 16 | 1220.082 | 1214.395 | x0.995 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.013 |
| blake3-servil-st / solo / ManyLongMessages / 64 | 1176.495 | 1167.358 | x0.992 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.067 |
| blake3-servil-st / solo / ManyLongMessages / 256 | 1140.264 | 1136.001 | x0.996 | level | 3 of 4 | - | - | x0.999 | x1.000 | x0.976 |
| blake3-servil-st / solo / IdleOneMessage / 64 B | 5.421 | 5.346 | x0.986 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.040 |
| blake3-servil-st / solo / IdleOneMessage / 128 B | 3.681 | 3.794 | x1.031 | level | 2 of 4 | - | - | x1.004 | x1.005 | x0.717 |
| blake3-servil-st / solo / IdleOneMessage / 256 B | 2.833 | 2.814 | x0.993 | level | 3 of 4 | - | - | x0.995 | x1.001 | x1.255 |
| blake3-servil-st / solo / IdleOneMessage / 512 B | 2.500 | 2.399 | x0.960 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.854 |
| blake3-servil-st / solo / IdleOneMessage / 1 KiB | 2.125 | 2.219 | x1.044 | level | 1 of 4 | - | - | x1.000 | x1.001 | x0.997 |
| blake3-servil-st / solo / IdleOneMessage / 1536 B | 1.740 | 1.689 | x0.970 | level | 3 of 4 | - | - | x1.008 | x1.001 | x1.093 |
| blake3-servil-st / solo / IdleOneMessage / 2 KiB | 1.234 | 1.234 | x1.000 | level | 3 of 4 | - | - | x0.999 | x1.001 | x1.097 |
| blake3-servil-st / solo / IdleOneMessage / 2304 B | 1.450 | 1.399 | x0.965 | level | 3 of 4 | - | - | x1.002 | x1.000 | x0.910 |
| blake3-servil-st / solo / IdleOneMessage / 3 KiB | 1.020 | 1.059 | x1.038 | level | 1 of 4 | - | - | x1.013 | x1.000 | x1.271 |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 1.118 | 1.092 | x0.977 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.140 |
| blake3-servil-st / solo / IdleOneMessage / 4 KiB | 0.768 | 0.753 | x0.980 | level | 2 of 4 | - | - | x1.009 | x1.000 | x0.974 |
| blake3-servil-st / solo / IdleOneMessage / 4470 B | 0.941 | 0.918 | x0.976 | level | 3 of 4 | - | - | x1.001 | x1.000 | x0.911 |
| blake3-servil-st / solo / IdleOneMessage / 7935 B | 0.583 | 0.590 | x1.011 | level | 1 of 4 | - | - | x1.009 | x1.000 | x1.565 |
| blake3-servil-st / solo / IdleOneMessage / 8 KiB | 0.538 | 0.523 | x0.972 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.182 |
| blake3-servil-st / solo / IdleOneMessage / 16 KiB | 0.517 | 0.491 | x0.950 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.243 |
| blake3-servil-st / solo / IdleOneMessage / 32 KiB | 0.491 | 0.485 | x0.988 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.996 |
| blake3-servil-st / solo / IdleOneMessage / 64 KiB | 0.473 | 0.466 | x0.986 | level | 2 of 4 | - | - | x0.992 | x1.000 | x1.017 |
| blake3-servil-st / solo / IdleOneMessage / 128 KiB | 0.462 | 0.463 | x1.001 | level | 1 of 4 | - | - | x0.990 | x1.000 | x1.204 |
| blake3-servil-st / solo / IdleOneMessage / 256 KiB | 0.483 | 0.479 | x0.990 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.102 |
| blake3-servil-st / solo / IdleOneMessage / 512 KiB | 0.490 | 0.470 | x0.960 | level | 4 of 4 | - | - | x0.993 | x1.000 | x1.131 |
| blake3-servil-st / solo / IdleOneMessage / 1 MiB | 0.477 | 0.464 | x0.973 | level | 3 of 4 | - | - | x0.999 | x1.000 | x1.063 |
| blake3-servil-st / solo / IdleOneMessage / 2 MiB | 0.490 | 0.489 | x0.998 | level | 3 of 4 | - | - | x0.995 | x1.000 | x1.059 |
| blake3-servil-st / solo / IdleOneMessage / 3 MiB | 0.463 | 0.459 | x0.992 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.046 |
| blake3-servil-st / solo / IdleOneMessage / 4 MiB | 0.422 | 0.432 | x1.023 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.062 |
| blake3-servil-st / solo / IdleOneMessage / 8 MiB | 0.326 | 0.328 | x1.005 | level | 2 of 4 | - | - | x1.002 | x1.000 | x1.046 |
| blake3-servil-st / solo / IdleOneMessage / 32 MiB | 0.297 | 0.297 | x1.000 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.055 |
| blake3-servil-st / solo / IdleOneMessage / 64 MiB | 0.300 | 0.300 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.048 |
| blake3-servil-st / solo / IdleOneMessage / 128 MiB | 0.301 | 0.301 | x1.001 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.033 |
| blake3-servil-st / solo / IdleManyMessages / 1 | 372.115 | 385.193 | x1.035 | level | 1 of 4 | - | - | x1.017 | x1.001 | x0.822 |
| blake3-servil-st / solo / IdleManyMessages / 2 | 197.325 | 204.253 | x1.035 | level | 0 of 4 | - | - | x1.016 | x1.002 | x0.909 |
| blake3-servil-st / solo / IdleManyMessages / 3 | 166.670 | 184.352 | x1.106 | level | 1 of 4 | - | - | x1.020 | x1.002 | x0.910 |
| blake3-servil-st / solo / IdleManyMessages / 4 | 105.064 | 119.778 | x1.140 | level | 0 of 4 | - | - | x1.030 | x1.001 | x0.957 |
| blake3-servil-st / solo / IdleManyMessages / 6 | 92.317 | 99.453 | x1.077 | level | 0 of 4 | - | - | x1.023 | x1.001 | x0.823 |
| blake3-servil-st / solo / IdleManyMessages / 8 | 66.656 | 67.499 | x1.013 | level | 2 of 4 | - | - | x1.001 | x1.002 | x0.873 |
| blake3-servil-st / solo / IdleManyMessages / 12 | 61.661 | 60.630 | x0.983 | level | 2 of 4 | - | - | x1.006 | x1.001 | x0.555 |
| blake3-servil-st / solo / IdleManyMessages / 16 | 50.484 | 51.919 | x1.028 | level | 1 of 4 | - | - | x1.007 | x1.002 | x0.945 |
| blake3-servil-st / solo / IdleManyMessages / 24 | 47.818 | 44.651 | x0.934 | level | 2 of 4 | - | - | x1.011 | x1.001 | x0.793 |
| blake3-servil-st / solo / IdleManyMessages / 32 | 39.746 | 40.348 | x1.015 | level | 0 of 4 | - | - | x0.997 | x1.001 | x0.607 |
| blake3-servil-st / solo / IdleManyMessages / 48 | 36.993 | 35.913 | x0.971 | level | 3 of 4 | - | - | x1.004 | x1.001 | x0.766 |
| blake3-servil-st / solo / IdleManyMessages / 64 | 33.891 | 33.927 | x1.001 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.453 |
| blake3-servil-st / solo / IdleManyMessages / 128 | 31.033 | 30.495 | x0.983 | level | 2 of 4 | - | - | x1.005 | x1.000 | x0.604 |
| blake3-servil-st / solo / IdleManyMessages / 256 | 28.428 | 29.613 | x1.042 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.799 |
| blake3-servil-st / solo / IdleManyMessages / 512 | 28.591 | 28.091 | x0.983 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.788 |
| blake3-servil-st / solo / IdleManyMessages / 1024 | 29.000 | 28.543 | x0.984 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.052 |
| blake3-servil-st / solo / IdleManyMessages / 2048 | 29.141 | 28.908 | x0.992 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.182 |
| blake3-servil-st / solo / IdleManyMessages / 4096 | 28.474 | 29.170 | x1.024 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.047 |
| blake3-servil-st / solo / IdleManyMessages / 8192 | 30.041 | 30.103 | x1.002 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.067 |
| blake3-servil-st / solo / IdleManyMessages / 16384 | 29.641 | 29.886 | x1.008 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.035 |
| blake3-servil-st / solo / IdleManyMessages / 32768 | 29.337 | 29.453 | x1.004 | level | 1 of 4 | - | - | x0.999 | x1.000 | x1.025 |
| blake3-servil-st / solo / IdleManyMessages / 65536 | 26.952 | 26.335 | x0.977 | level | 4 of 4 | - | - | x1.001 | x1.000 | x1.020 |
| blake3-servil-st / solo / IdleManyMessages / 131072 | 20.800 | 21.146 | x1.017 | level | 1 of 4 | - | - | x1.006 | x1.000 | x0.968 |
| blake3-servil-st / solo / IdleManyMessages / 262144 | 17.889 | 18.083 | x1.011 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.988 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 B | 2.422 | 2.524 | x1.042 | level | 0 of 4 | - | - | x1.003 | x1.000 | x0.833 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 B | 1.688 | 1.743 | x1.032 | level | 1 of 4 | - | - | x1.003 | x1.006 | x1.253 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 B | 1.303 | 1.306 | x1.003 | level | 2 of 4 | - | - | x1.004 | x1.001 | x1.185 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 B | 1.200 | 1.142 | x0.951 | level | 2 of 4 | - | - | x1.002 | x1.001 | x1.055 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 KiB | 1.042 | 1.027 | x0.986 | level | 3 of 4 | - | - | x1.000 | x1.001 | x1.099 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1536 B | 0.809 | 0.800 | x0.989 | level | 3 of 4 | - | - | x1.001 | x1.001 | x0.775 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 KiB | 0.570 | 0.570 | x1.001 | level | 1 of 4 | - | - | x0.999 | x1.001 | x0.748 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2304 B | 0.652 | 0.652 | x0.999 | level | 1 of 4 | - | - | x1.001 | x1.001 | x1.174 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.473 | 0.483 | x1.022 | level | 1 of 4 | - | - | x1.008 | x1.000 | x1.148 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3839 B | 0.499 | 0.500 | x1.003 | level | 3 of 4 | - | - | x0.994 | x1.000 | x0.981 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 KiB | 0.353 | 0.353 | x0.999 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.863 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4470 B | 0.426 | 0.427 | x1.002 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.015 |
| blake3-servil-st / solo / BriefIdleOneMessage / 7935 B | 0.268 | 0.269 | x1.003 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.711 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 KiB | 0.246 | 0.251 | x1.020 | level | 1 of 4 | - | - | x1.003 | x1.000 | x0.965 |
| blake3-servil-st / solo / BriefIdleOneMessage / 16 KiB | 0.229 | 0.230 | x1.003 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.187 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 KiB | 0.223 | 0.224 | x1.002 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.808 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 KiB | 0.219 | 0.217 | x0.994 | level | 2 of 4 | - | - | x0.994 | x1.000 | x0.758 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 KiB | 0.218 | 0.218 | x0.996 | level | 2 of 4 | - | - | x0.994 | x1.000 | x1.072 |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 KiB | 0.224 | 0.226 | x1.007 | level | 0 of 4 | - | - | x1.000 | x1.000 | x1.066 |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 KiB | 0.232 | 0.231 | x0.994 | level | 4 of 4 | - | - | x0.996 | x1.000 | x1.118 |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 MiB | 0.235 | 0.234 | x0.994 | level | 4 of 4 | - | - | x0.995 | x1.000 | x1.072 |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 MiB | 0.238 | 0.236 | x0.994 | level | 4 of 4 | - | - | x0.995 | x1.000 | x1.078 |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 MiB | 0.238 | 0.237 | x0.996 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.083 |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 MiB | 0.238 | 0.237 | x0.997 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.076 |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 MiB | 0.244 | 0.246 | x1.007 | level | 2 of 4 | - | - | x1.007 | x1.000 | x1.056 |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 MiB | 0.292 | 0.293 | x1.003 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.068 |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 MiB | 0.295 | 0.295 | x1.000 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.059 |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 MiB | 0.299 | 0.299 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.040 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1 | 168.813 | 179.238 | x1.062 | level | 0 of 4 | - | - | x1.012 | x1.002 | x0.981 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2 | 87.831 | 88.390 | x1.006 | level | 1 of 4 | - | - | x1.004 | x1.002 | x0.625 |
| blake3-servil-st / solo / BriefIdleManyMessages / 3 | 76.850 | 77.054 | x1.003 | level | 1 of 4 | - | - | x1.002 | x1.002 | x0.499 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4 | 48.320 | 48.635 | x1.007 | level | 2 of 4 | - | - | x1.007 | x1.001 | x0.948 |
| blake3-servil-st / solo / BriefIdleManyMessages / 6 | 42.557 | 42.987 | x1.010 | level | 1 of 4 | - | - | x1.008 | x1.001 | x1.294 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8 | 30.257 | 30.495 | x1.008 | level | 0 of 4 | - | - | x1.007 | x1.003 | x1.002 |
| blake3-servil-st / solo / BriefIdleManyMessages / 12 | 27.222 | 27.321 | x1.004 | level | 1 of 4 | - | - | x1.000 | x1.001 | x0.838 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16 | 23.283 | 23.453 | x1.007 | level | 0 of 4 | - | - | x1.002 | x1.001 | x0.662 |
| blake3-servil-st / solo / BriefIdleManyMessages / 24 | 20.017 | 20.067 | x1.003 | level | 2 of 4 | - | - | x1.001 | x1.001 | x1.161 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32 | 18.348 | 18.419 | x1.004 | level | 1 of 4 | - | - | x1.000 | x1.001 | x0.759 |
| blake3-servil-st / solo / BriefIdleManyMessages / 48 | 16.714 | 16.724 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.793 |
| blake3-servil-st / solo / BriefIdleManyMessages / 64 | 15.876 | 16.119 | x1.015 | level | 0 of 4 | - | - | x1.002 | x1.000 | x0.692 |
| blake3-servil-st / solo / BriefIdleManyMessages / 128 | 14.717 | 14.518 | x0.987 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.221 |
| blake3-servil-st / solo / BriefIdleManyMessages / 256 | 13.928 | 13.906 | x0.998 | level | 3 of 4 | - | - | x1.001 | x1.000 | x0.896 |
| blake3-servil-st / solo / BriefIdleManyMessages / 512 | 13.633 | 13.585 | x0.997 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.795 |
| blake3-servil-st / solo / BriefIdleManyMessages / 1024 | 13.385 | 13.498 | x1.008 | level | 1 of 4 | - | - | x1.004 | x1.000 | x1.040 |
| blake3-servil-st / solo / BriefIdleManyMessages / 2048 | 13.627 | 13.624 | x1.000 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.054 |
| blake3-servil-st / solo / BriefIdleManyMessages / 4096 | 14.145 | 14.037 | x0.992 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.057 |
| blake3-servil-st / solo / BriefIdleManyMessages / 8192 | 14.404 | 14.424 | x1.001 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.024 |
| blake3-servil-st / solo / BriefIdleManyMessages / 16384 | 14.534 | 14.538 | x1.000 | level | 3 of 4 | - | - | x1.002 | x1.000 | x1.032 |
| blake3-servil-st / solo / BriefIdleManyMessages / 32768 | 14.852 | 14.782 | x0.995 | level | 3 of 4 | - | - | x0.995 | x1.000 | x0.990 |
| blake3-servil-st / solo / BriefIdleManyMessages / 65536 | 14.989 | 15.068 | x1.005 | level | 1 of 4 | - | - | x1.005 | x1.000 | x1.029 |
| blake3-servil-st / solo / BriefIdleManyMessages / 131072 | 15.123 | 15.198 | x1.005 | level | 2 of 4 | - | - | x1.003 | x1.000 | x0.978 |
| blake3-servil-st / solo / BriefIdleManyMessages / 262144 | 15.863 | 15.811 | x0.997 | level | 2 of 4 | - | - | x0.997 | x1.000 | x0.973 |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.886 | 0.887 | x1.002 | level | 2 of 4 | x1.002 | - | x1.000 | x1.000 | x0.707 |
| blake3-servil-st / solo / ContinuousMessages / 128 B | 0.907 | 0.902 | x0.995 | level | 3 of 4 | x0.995 | - | x0.995 | x1.000 | x0.683 |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 0.911 | 0.916 | x1.005 | level | 0 of 4 | x1.005 | - | x1.005 | x1.000 | x0.786 |
| blake3-servil-st / solo / ContinuousMessages / 512 B | 0.929 | 0.930 | x1.002 | level | 1 of 4 | x1.002 | - | x1.000 | x1.000 | x1.306 |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 0.924 | 0.928 | x1.004 | level | 3 of 4 | x1.003 | - | x1.000 | x1.000 | x2.013 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.316 | 0.316 | x0.999 | level | 4 of 4 | x0.999 | - | x0.999 | x1.000 | x1.699 |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.215 | 0.215 | x0.999 | level | 2 of 4 | x1.000 | - | x0.999 | x1.000 | x0.653 |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.216 | 0.216 | x1.003 | level | 1 of 4 | x1.003 | - | x1.003 | x1.000 | x0.954 |
| blake3-servil-st / solo / ContinuousMessages / 256 KiB | 0.218 | 0.219 | x1.001 | level | 2 of 4 | x1.001 | - | x0.999 | x1.000 | x0.820 |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.219 | 0.219 | x1.002 | level | 2 of 4 | x1.002 | - | x1.001 | x1.000 | x0.990 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.218 | 0.219 | x1.003 | level | 2 of 4 | x1.003 | - | x1.002 | x1.000 | x0.979 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.220 | 0.221 | x1.003 | level | 2 of 4 | x1.003 | - | x1.003 | x1.000 | x0.992 |
| blake3-servil-st / solo / ContinuousMessages / 64 MiB | 0.252 | 0.245 | x0.975 | level | 4 of 4 | x0.975 | - | x0.976 | x1.000 | x0.826 |
| blake3-servil-st / solo / ContinuousBatches / 16 | 15.648 | 16.268 | x1.040 | level | 2 of 4 | x1.039 | - | x1.040 | x1.000 | x1.083 |
| blake3-servil-st / solo / ContinuousBatches / 64 | 13.533 | 13.731 | x1.015 | level | 2 of 4 | x1.015 | - | x1.014 | x1.000 | x0.910 |
| blake3-servil-st / solo / ContinuousBatches / 256 | 13.560 | 13.673 | x1.008 | level | 2 of 4 | x1.008 | - | x1.008 | x1.000 | x0.810 |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 13.778 | 13.851 | x1.005 | level | 2 of 4 | x1.005 | - | x1.006 | x1.000 | x0.974 |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 14.493 | 14.457 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x1.000 | x1.029 |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 14.742 | 14.957 | x1.015 | level | 1 of 4 | x1.015 | - | x1.012 | x1.000 | x0.996 |
| blake3-servil-st / solo / ContinuousBatches / 65536 | 14.921 | 15.064 | x1.010 | level | 1 of 4 | x1.009 | - | x1.009 | x1.000 | x0.946 |
| blake3-servil-st / solo / LentMessages / 64 B | 0.886 | 0.887 | x1.002 | level | 2 of 4 | x1.002 | - | x1.000 | x1.000 | x0.707 |
| blake3-servil-st / solo / LentMessages / 128 B | 0.907 | 0.902 | x0.995 | level | 3 of 4 | x0.995 | - | x0.995 | x1.000 | x0.683 |
| blake3-servil-st / solo / LentMessages / 256 B | 0.911 | 0.916 | x1.005 | level | 0 of 4 | x1.005 | - | x1.005 | x1.000 | x0.786 |
| blake3-servil-st / solo / LentMessages / 512 B | 0.929 | 0.930 | x1.002 | level | 1 of 4 | x1.002 | - | x1.000 | x1.000 | x1.306 |
| blake3-servil-st / solo / LentMessages / 1 KiB | 0.924 | 0.928 | x1.004 | level | 3 of 4 | x1.003 | - | x1.000 | x1.000 | x2.013 |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.316 | 0.316 | x0.999 | level | 4 of 4 | x0.999 | - | x0.999 | x1.000 | x1.699 |
| blake3-servil-st / solo / LentMessages / 16 KiB | 0.215 | 0.215 | x0.999 | level | 2 of 4 | x1.000 | - | x0.999 | x1.000 | x0.653 |
| blake3-servil-st / solo / LentMessages / 64 KiB | 0.216 | 0.216 | x1.003 | level | 1 of 4 | x1.003 | - | x1.003 | x1.000 | x0.954 |
| blake3-servil-st / solo / LentMessages / 256 KiB | 0.219 | 0.220 | x1.005 | level | 1 of 4 | x1.005 | - | x1.006 | x1.000 | x0.908 |
| blake3-servil-st / solo / LentMessages / 1 MiB | 0.228 | 0.230 | x1.008 | level | 1 of 4 | x1.008 | - | x1.006 | x1.000 | x0.953 |
| blake3-servil-st / solo / LentMessages / 4 MiB | 0.232 | 0.233 | x1.005 | level | 1 of 4 | x1.005 | - | x1.004 | x1.000 | x1.070 |
| blake3-servil-st / solo / LentMessages / 16 MiB | 0.263 | 0.258 | x0.981 | level | 4 of 4 | x0.981 | - | x0.983 | x1.000 | x1.021 |
| blake3-servil-st / solo / LentMessages / 64 MiB | 0.298 | 0.298 | x1.003 | level | 2 of 4 | x1.003 | - | x1.003 | x1.000 | x1.045 |
| blake3-servil-st / solo / Interleaved / 256 | 0.262 | 0.263 | x1.003 | level | 2 of 4 | x1.003 | - | x1.002 | x1.002 | x0.988 |
| blake3-servil-st / solo / Collection / git objects | 0.247 | 0.247 | x1.001 | level | 1 of 4 | x1.001 | - | x1.002 | x1.000 | x0.977 |
| blake3-servil-st / solo / Collection / Nix files | 0.232 | 0.233 | x1.004 | level | 3 of 4 | x1.004 | - | x1.004 | x1.000 | x1.050 |
| blake3-servil-st / solo / LentBatches / 16 | 15.648 | 16.268 | x1.040 | level | 2 of 4 | x1.039 | - | x1.040 | x1.000 | x1.083 |
| blake3-servil-st / solo / LentBatches / 64 | 13.533 | 13.731 | x1.015 | level | 2 of 4 | x1.015 | - | x1.014 | x1.000 | x0.910 |
| blake3-servil-st / solo / LentBatches / 256 | 13.560 | 13.673 | x1.008 | level | 2 of 4 | x1.008 | - | x1.008 | x1.000 | x0.810 |
| blake3-servil-st / solo / LentBatches / 1024 | 13.778 | 13.851 | x1.005 | level | 2 of 4 | x1.005 | - | x1.006 | x1.000 | x0.974 |
| blake3-servil-st / solo / LentBatches / 4096 | 14.493 | 14.457 | x0.997 | level | 3 of 4 | x0.997 | - | x0.997 | x1.000 | x1.029 |
| blake3-servil-st / solo / LentBatches / 16384 | 14.742 | 14.957 | x1.015 | level | 1 of 4 | x1.015 | - | x1.012 | x1.000 | x0.996 |
| blake3-servil-st / solo / LentBatches / 65536 | 14.921 | 15.064 | x1.010 | level | 1 of 4 | x1.009 | - | x1.009 | x1.000 | x0.946 |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.270 | 0.269 | x0.996 | level | 3 of 4 | x0.996 | - | x0.996 | x1.000 | x0.960 |
| blake3-servil-st / solo / ContinuousCollection / Nix files | 0.274 | 0.274 | x0.999 | level | 2 of 4 | x0.999 | - | x0.999 | x1.000 | x1.077 |
| blake3-servil-st / solo / MerkleTree / 1024 | 0.260 | 0.261 | x1.004 | level | 1 of 4 | x1.003 | - | x1.003 | x1.000 | x1.041 |
| blake3-servil-st / solo / MerkleTree / 4096 | 0.271 | 0.270 | x0.996 | level | 3 of 4 | x0.997 | - | x0.996 | x1.000 | x1.044 |
| blake3-servil-st / solo / MerkleTree / 16384 | 0.272 | 0.272 | x0.999 | level | 2 of 4 | x1.000 | - | x1.001 | x1.000 | x1.003 |
| blake3-servil-st / solo / MerkleTree / 65536 | 0.304 | 0.303 | x0.995 | level | 3 of 4 | x0.995 | - | x0.996 | x1.000 | x1.012 |
| blake3-servil-st / solo / MerkleTree / 262144 | 0.542 | 0.539 | x0.995 | level | 3 of 4 | x0.995 | - | x0.995 | x1.000 | x1.009 |
| blake3-servil-st / solo / MerkleTree / 65536 x 32 B | 0.832 | 0.836 | x1.004 | level | 1 of 4 | x1.004 | - | x1.004 | x1.000 | x0.972 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 32 B | 1.092 | 1.097 | x1.004 | level | 1 of 4 | x1.004 | - | x1.004 | x1.000 | x0.989 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 16 B | 1.666 | 1.673 | x1.005 | level | 0 of 4 | x1.004 | - | x1.004 | x1.000 | x1.004 |
| blake3-servil-st / solo / MerkleTree / 65536 x 48 B | 0.569 | 0.573 | x1.006 | level | 1 of 4 | x1.006 | - | x1.006 | x1.000 | x0.935 |
| blake3-servil-st / solo / MerkleTree / 1048576 x 48 B | 0.836 | 0.838 | x1.003 | level | 2 of 4 | x1.003 | - | x1.003 | x1.000 | x1.002 |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.481 | 0.486 | x1.010 | level | 2 of 4 | - | - | x1.009 | x0.997 | x1.002 |
| blake3-servil-st / solo / InterleavedTurn / 1024 x 1 KiB | 0.526 | 0.522 | x0.994 | level | 2 of 4 | - | - | x0.996 | x1.000 | x1.011 |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.683 | 0.717 | x1.051 | level | 1 of 4 | - | - | x1.006 | x1.018 | x1.008 |
| blake3-servil-st / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.840 | 0.845 | x1.006 | level | 2 of 4 | - | - | x0.992 | x1.000 | x0.994 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.392 | 0.392 | x0.998 | level | 3 of 4 | - | - | x1.001 | x0.990 | x1.003 |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.435 | 0.423 | x0.973 | level | 3 of 4 | - | - | x0.973 | x1.000 | x1.003 |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.228 | 0.228 | x0.998 | level | 3 of 4 | x0.998 | - | x0.997 | x1.000 | x0.897 |
| blake3-servil-st / solo / ReceivingMessage / 2 μs | 0.230 | 0.230 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x1.023 |
| blake3-servil-st / solo / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 2 of 4 | x0.996 | - | x0.995 | x1.000 | x0.886 |
| blake3-servil-st / solo / IncrementalMessage / 64 B | 7.211 | 8.078 | x1.120 | level | 0 of 4 | - | - | x1.079 | x1.005 | x1.009 |
| blake3-servil-st / solo / IncrementalMessage / 1 KiB | 1.535 | 1.560 | x1.017 | level | 1 of 4 | - | - | x1.014 | x1.003 | x1.022 |
| blake3-servil-st / solo / IncrementalMessage / 4 KiB | 0.740 | 0.725 | x0.980 | level | 2 of 4 | - | - | x1.002 | x1.001 | x0.988 |
| blake3-servil-st / solo / LentIncrementalMessage / 64 B | 1.159 | 1.163 | x1.003 | level | 2 of 4 | x1.003 | - | x1.002 | x1.000 | x0.575 |
| blake3-servil-st / solo / LentIncrementalMessage / 1 KiB | 0.953 | 0.952 | x0.998 | level | 2 of 4 | x0.998 | - | x0.998 | x1.000 | x1.251 |
| blake3-servil-st / solo / LentIncrementalMessage / 4 KiB | 0.331 | 0.329 | x0.995 | level | 4 of 4 | x0.996 | - | x0.997 | x1.000 | x0.872 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 64 B | 0.868 | 0.870 | x1.003 | level | 1 of 4 | x1.003 | - | x1.003 | x1.000 | x1.068 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 4 KiB | 0.317 | 0.316 | x0.999 | level | 3 of 4 | x0.999 | - | x0.999 | x1.000 | x1.101 |
| blake3-servil-st / solo / ContinuousKeyedMessages / 1 MiB | 0.219 | 0.219 | x1.001 | level | 1 of 4 | x1.001 | - | x1.002 | x1.000 | x1.007 |
| blake3-servil-st / solo / ContinuousLentMessages / 64 B | 0.839 | 0.841 | x1.002 | level | 2 of 4 | x1.002 | - | x1.000 | x1.000 | x1.362 |
| blake3-servil-st / solo / ContinuousLentMessages / 4 KiB | 0.306 | 0.307 | x1.003 | level | 2 of 4 | x1.004 | - | x1.002 | x1.000 | x2.311 |
| blake3-servil-st / solo / ContinuousLentMessages / 1 MiB | 0.203 | 0.203 | x1.000 | level | 2 of 4 | x1.000 | - | x1.002 | x1.000 | x0.990 |
| blake3-servil-mt / solo / OneMessage / 64 B | 7.782 | 8.256 | x1.061 | level | 0 of 4 | - | - | x1.063 | x1.003 | x1.095 |
| blake3-servil-mt / solo / OneMessage / 128 B | 4.464 | 4.841 | x1.084 | level | 1 of 4 | - | - | x1.073 | x1.003 | x1.093 |
| blake3-servil-mt / solo / OneMessage / 256 B | 2.761 | 3.013 | x1.091 | level | 0 of 4 | - | - | x1.064 | x1.001 | x1.097 |
| blake3-servil-mt / solo / OneMessage / 512 B | 1.950 | 2.030 | x1.041 | level | 1 of 4 | - | - | x1.034 | x1.001 | x1.091 |
| blake3-servil-mt / solo / OneMessage / 1 KiB | 1.421 | 1.452 | x1.023 | level | 0 of 4 | - | - | x1.029 | x1.001 | x1.082 |
| blake3-servil-mt / solo / OneMessage / 1536 B | 1.448 | 1.450 | x1.001 | level | 2 of 4 | - | - | x1.034 | x1.001 | x1.026 |
| blake3-servil-mt / solo / OneMessage / 2 KiB | 1.006 | 1.000 | x0.995 | level | 2 of 4 | - | - | x1.026 | x1.001 | x1.025 |
| blake3-servil-mt / solo / OneMessage / 2304 B | 1.106 | 1.135 | x1.027 | level | 0 of 4 | - | - | x1.051 | x1.000 | x1.020 |
| blake3-servil-mt / solo / OneMessage / 3 KiB | 0.850 | 0.874 | x1.028 | level | 3 of 4 | - | - | x1.029 | x1.000 | x1.026 |
| blake3-servil-mt / solo / OneMessage / 3839 B | 0.978 | 0.969 | x0.991 | level | 2 of 4 | - | - | x1.006 | x1.000 | x1.044 |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 0.620 | 0.619 | x0.999 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.033 |
| blake3-servil-mt / solo / OneMessage / 4470 B | 0.693 | 0.719 | x1.037 | level | 0 of 4 | - | - | x1.030 | x1.000 | x1.038 |
| blake3-servil-mt / solo / OneMessage / 7935 B | 0.545 | 0.534 | x0.980 | level | 3 of 4 | - | - | x0.982 | x1.000 | x1.019 |
| blake3-servil-mt / solo / OneMessage / 8 KiB | 0.431 | 0.443 | x1.026 | level | 3 of 4 | - | - | x1.025 | x1.000 | x1.038 |
| blake3-servil-mt / solo / OneMessage / 16 KiB | 0.374 | 0.376 | x1.004 | level | 2 of 4 | - | - | x1.003 | x1.000 | x1.030 |
| blake3-servil-mt / solo / OneMessage / 32 KiB | 0.335 | 0.341 | x1.017 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.024 |
| blake3-servil-mt / solo / OneMessage / 64 KiB | 0.310 | 0.312 | x1.006 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.036 |
| blake3-servil-mt / solo / OneMessage / 128 KiB | 0.301 | 0.301 | x1.000 | level | 2 of 4 | - | - | x0.998 | x1.000 | x1.032 |
| blake3-servil-mt / solo / OneMessage / 256 KiB | 0.298 | 0.294 | x0.989 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.034 |
| blake3-servil-mt / solo / OneMessage / 512 KiB | 0.183 | 0.180 | x0.986 | level | 2 of 4 | - | - | x0.983 | x1.002 | x1.006 |
| blake3-servil-mt / solo / OneMessage / 1 MiB | 0.143 | 0.137 | x0.960 | level | 4 of 4 | - | - | x0.963 | x1.009 | x0.993 |
| blake3-servil-mt / solo / OneMessage / 2 MiB | 0.157 | 0.155 | x0.984 | level | 3 of 4 | - | - | x0.984 | x0.988 | x0.994 |
| blake3-servil-mt / solo / OneMessage / 3 MiB | 0.154 | 0.154 | x0.999 | level | 2 of 4 | - | - | x0.998 | x1.003 | x1.002 |
| blake3-servil-mt / solo / OneMessage / 4 MiB | 0.120 | 0.124 | x1.032 | level | 1 of 4 | - | - | x1.033 | x0.933 | x1.065 |
| blake3-servil-mt / solo / OneMessage / 8 MiB | 0.152 | 0.150 | x0.987 | level | 3 of 4 | - | - | x0.989 | x0.993 | x0.990 |
| blake3-servil-mt / solo / OneMessage / 32 MiB | 0.0814 | 0.0806 | x0.990 | level | 3 of 4 | - | - | x0.992 | x0.997 | x0.986 |
| blake3-servil-mt / solo / OneMessage / 64 MiB | 0.0815 | 0.0814 | x0.998 | level | 3 of 4 | - | - | x0.997 | x1.013 | x0.991 |
| blake3-servil-mt / solo / OneMessage / 128 MiB | 0.0778 | 0.0777 | x0.998 | level | 2 of 4 | - | - | x0.998 | x1.001 | x0.998 |
| blake3-servil-mt / solo / ManyMessages / 1 | 429.074 | 483.582 | x1.127 | level | 1 of 4 | - | - | x1.100 | x1.003 | x1.003 |
| blake3-servil-mt / solo / ManyMessages / 2 | 282.000 | 313.820 | x1.113 | level | 1 of 4 | - | - | x1.111 | x1.007 | x0.974 |
| blake3-servil-mt / solo / ManyMessages / 3 | 215.767 | 220.563 | x1.022 | level | 2 of 4 | - | - | x1.034 | x1.005 | x0.965 |
| blake3-servil-mt / solo / ManyMessages / 4 | 162.989 | 168.861 | x1.036 | level | 3 of 4 | - | - | x1.049 | x1.005 | x1.043 |
| blake3-servil-mt / solo / ManyMessages / 6 | 127.054 | 136.184 | x1.072 | level | 1 of 4 | - | - | x1.084 | x1.004 | x1.032 |
| blake3-servil-mt / solo / ManyMessages / 8 | 113.540 | 115.117 | x1.014 | level | 2 of 4 | - | - | x1.023 | x1.005 | x1.027 |
| blake3-servil-mt / solo / ManyMessages / 12 | 85.227 | 85.991 | x1.009 | level | 2 of 4 | - | - | x1.029 | x1.003 | x1.021 |
| blake3-servil-mt / solo / ManyMessages / 16 | 66.928 | 65.728 | x0.982 | level | 2 of 4 | - | - | x1.003 | x1.003 | x1.013 |
| blake3-servil-mt / solo / ManyMessages / 24 | 49.498 | 49.570 | x1.001 | level | 1 of 4 | - | - | x1.028 | x1.003 | x1.006 |
| blake3-servil-mt / solo / ManyMessages / 32 | 40.968 | 39.942 | x0.975 | level | 2 of 4 | - | - | x0.992 | x1.002 | x1.013 |
| blake3-servil-mt / solo / ManyMessages / 48 | 31.955 | 31.388 | x0.982 | level | 2 of 4 | - | - | x0.997 | x1.001 | x0.997 |
| blake3-servil-mt / solo / ManyMessages / 64 | 28.824 | 28.206 | x0.979 | level | 2 of 4 | - | - | x0.989 | x1.001 | x0.987 |
| blake3-servil-mt / solo / ManyMessages / 128 | 23.672 | 23.719 | x1.002 | level | 3 of 4 | - | - | x1.017 | x1.001 | x1.005 |
| blake3-servil-mt / solo / ManyMessages / 256 | 21.043 | 20.957 | x0.996 | level | 2 of 4 | - | - | x0.989 | x1.000 | x0.996 |
| blake3-servil-mt / solo / ManyMessages / 512 | 19.631 | 19.070 | x0.971 | level | 2 of 4 | - | - | x0.978 | x1.000 | x0.992 |
| blake3-servil-mt / solo / ManyMessages / 1024 | 18.516 | 18.349 | x0.991 | level | 2 of 4 | - | - | x0.992 | x1.000 | x1.020 |
| blake3-servil-mt / solo / ManyMessages / 2048 | 18.310 | 18.202 | x0.994 | level | 3 of 4 | - | - | x0.996 | x1.000 | x1.011 |
| blake3-servil-mt / solo / ManyMessages / 4096 | 17.938 | 17.815 | x0.993 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.006 |
| blake3-servil-mt / solo / ManyMessages / 8192 | 10.008 | 9.796 | x0.979 | level | 4 of 4 | - | - | x0.977 | x0.992 | x0.996 |
| blake3-servil-mt / solo / ManyMessages / 16384 | 8.345 | 8.955 | x1.073 | level | 1 of 4 | - | - | x1.076 | x0.944 | x1.032 |
| blake3-servil-mt / solo / ManyMessages / 32768 | 8.925 | 8.259 | x0.925 | level | 2 of 4 | - | - | x0.920 | x1.084 | x0.931 |
| blake3-servil-mt / solo / ManyMessages / 65536 | 8.271 | 7.981 | x0.965 | level | 2 of 4 | - | - | x0.965 | x0.989 | x0.984 |
| blake3-servil-mt / solo / ManyMessages / 131072 | 9.678 | 9.785 | x1.011 | level | 2 of 4 | - | - | x1.011 | x0.994 | x1.025 |
| blake3-servil-mt / solo / ManyMessages / 262144 | 10.171 | 10.122 | x0.995 | level | 2 of 4 | - | - | x0.995 | x1.003 | x1.002 |
| blake3-servil-mt / solo / ManyLongMessages / 4 | 1845.361 | 1813.593 | x0.983 | level | 2 of 4 | - | - | x1.016 | x1.000 | x1.014 |
| blake3-servil-mt / solo / ManyLongMessages / 16 | 1237.440 | 1225.150 | x0.990 | level | 3 of 4 | - | - | x1.001 | x1.000 | x1.045 |
| blake3-servil-mt / solo / ManyLongMessages / 64 | 1209.101 | 1164.724 | x0.963 | level | 3 of 4 | - | - | x0.995 | x1.000 | x1.065 |
| blake3-servil-mt / solo / ManyLongMessages / 256 | 609.048 | 639.061 | x1.049 | level | 1 of 4 | - | - | x1.054 | x0.925 | x1.021 |
| blake3-servil-mt / solo / IdleOneMessage / 64 B | 5.462 | 5.474 | x1.002 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.078 |
| blake3-servil-mt / solo / IdleOneMessage / 128 B | 3.752 | 3.758 | x1.002 | level | 3 of 4 | - | - | x1.001 | x1.004 | x1.042 |
| blake3-servil-mt / solo / IdleOneMessage / 256 B | 2.844 | 2.813 | x0.989 | level | 2 of 4 | - | - | x0.995 | x1.001 | x1.113 |
| blake3-servil-mt / solo / IdleOneMessage / 512 B | 2.473 | 2.416 | x0.977 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.822 |
| blake3-servil-mt / solo / IdleOneMessage / 1 KiB | 2.203 | 2.117 | x0.961 | level | 4 of 4 | - | - | x0.994 | x1.001 | x0.863 |
| blake3-servil-mt / solo / IdleOneMessage / 1536 B | 1.722 | 1.728 | x1.004 | level | 2 of 4 | - | - | x1.001 | x1.001 | x1.132 |
| blake3-servil-mt / solo / IdleOneMessage / 2 KiB | 1.260 | 1.266 | x1.005 | level | 2 of 4 | - | - | x1.005 | x1.001 | x1.159 |
| blake3-servil-mt / solo / IdleOneMessage / 2304 B | 1.375 | 1.388 | x1.010 | level | 2 of 4 | - | - | x0.990 | x1.001 | x0.830 |
| blake3-servil-mt / solo / IdleOneMessage / 3 KiB | 1.057 | 1.105 | x1.046 | level | 1 of 4 | - | - | x1.004 | x1.000 | x0.905 |
| blake3-servil-mt / solo / IdleOneMessage / 3839 B | 1.087 | 1.106 | x1.017 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.050 |
| blake3-servil-mt / solo / IdleOneMessage / 4 KiB | 0.754 | 0.787 | x1.044 | level | 0 of 4 | - | - | x0.997 | x1.000 | x1.028 |
| blake3-servil-mt / solo / IdleOneMessage / 4470 B | 0.916 | 0.937 | x1.023 | level | 2 of 4 | - | - | x1.005 | x1.000 | x1.120 |
| blake3-servil-mt / solo / IdleOneMessage / 7935 B | 0.607 | 0.597 | x0.983 | level | 2 of 4 | - | - | x1.011 | x1.000 | x1.477 |
| blake3-servil-mt / solo / IdleOneMessage / 8 KiB | 0.537 | 0.545 | x1.015 | level | 2 of 4 | - | - | x1.009 | x1.000 | x1.090 |
| blake3-servil-mt / solo / IdleOneMessage / 16 KiB | 0.499 | 0.488 | x0.979 | level | 3 of 4 | - | - | x1.003 | x1.000 | x1.254 |
| blake3-servil-mt / solo / IdleOneMessage / 32 KiB | 0.491 | 0.472 | x0.962 | level | 3 of 4 | - | - | x0.995 | x1.000 | x1.033 |
| blake3-servil-mt / solo / IdleOneMessage / 64 KiB | 0.473 | 0.461 | x0.975 | level | 2 of 4 | - | - | x0.991 | x1.000 | x0.991 |
| blake3-servil-mt / solo / IdleOneMessage / 128 KiB | 0.459 | 0.447 | x0.974 | level | 3 of 4 | - | - | x0.988 | x1.000 | x1.193 |
| blake3-servil-mt / solo / IdleOneMessage / 256 KiB | 0.479 | 0.462 | x0.964 | level | 4 of 4 | - | - | x1.001 | x1.000 | x1.084 |
| blake3-servil-mt / solo / IdleOneMessage / 512 KiB | 0.239 | 0.216 | x0.905 | level | 3 of 4 | - | - | x0.916 | x1.008 | x1.022 |
| blake3-servil-mt / solo / IdleOneMessage / 1 MiB | 0.194 | 0.192 | x0.991 | level | 2 of 4 | - | - | x0.973 | x0.999 | x1.017 |
| blake3-servil-mt / solo / IdleOneMessage / 2 MiB | 0.209 | 0.200 | x0.958 | level | 4 of 4 | - | - | x1.017 | x1.020 | x1.018 |
| blake3-servil-mt / solo / IdleOneMessage / 3 MiB | 0.201 | 0.196 | x0.974 | level | 4 of 4 | - | - | x1.015 | x1.023 | x1.006 |
| blake3-servil-mt / solo / IdleOneMessage / 4 MiB | 0.205 | 0.204 | x0.992 | level | 3 of 4 | - | - | x0.981 | x0.997 | x1.001 |
| blake3-servil-mt / solo / IdleOneMessage / 8 MiB | 0.172 | 0.161 | x0.939 | level | 4 of 4 | - | - | x0.959 | x1.077 | x0.938 |
| blake3-servil-mt / solo / IdleOneMessage / 32 MiB | 0.0739 | 0.0739 | x0.999 | level | 2 of 4 | - | - | x0.992 | x0.987 | x0.989 |
| blake3-servil-mt / solo / IdleOneMessage / 64 MiB | 0.0755 | 0.0747 | x0.989 | level | 3 of 4 | - | - | x0.999 | x1.007 | x0.989 |
| blake3-servil-mt / solo / IdleOneMessage / 128 MiB | 0.0750 | 0.0755 | x1.006 | level | 1 of 4 | - | - | x1.007 | x0.999 | x0.999 |
| blake3-servil-mt / solo / IdleManyMessages / 1 | 375.736 | 398.388 | x1.060 | level | 0 of 4 | - | - | x1.015 | x1.001 | x0.801 |
| blake3-servil-mt / solo / IdleManyMessages / 2 | 195.837 | 206.244 | x1.053 | level | 0 of 4 | - | - | x1.028 | x1.002 | x0.962 |
| blake3-servil-mt / solo / IdleManyMessages / 3 | 179.688 | 176.032 | x0.980 | level | 1 of 4 | - | - | x1.013 | x1.002 | x0.686 |
| blake3-servil-mt / solo / IdleManyMessages / 4 | 110.755 | 111.949 | x1.011 | level | 1 of 4 | - | - | x1.023 | x1.001 | x0.797 |
| blake3-servil-mt / solo / IdleManyMessages / 6 | 94.212 | 97.437 | x1.034 | level | 0 of 4 | - | - | x1.016 | x1.001 | x0.740 |
| blake3-servil-mt / solo / IdleManyMessages / 8 | 66.664 | 69.541 | x1.043 | level | 0 of 4 | - | - | x1.017 | x1.002 | x0.761 |
| blake3-servil-mt / solo / IdleManyMessages / 12 | 61.090 | 61.231 | x1.002 | level | 2 of 4 | - | - | x1.002 | x1.001 | x0.528 |
| blake3-servil-mt / solo / IdleManyMessages / 16 | 50.703 | 51.061 | x1.007 | level | 0 of 4 | - | - | x1.000 | x1.001 | x0.632 |
| blake3-servil-mt / solo / IdleManyMessages / 24 | 46.092 | 43.884 | x0.952 | level | 2 of 4 | - | - | x1.005 | x1.001 | x0.732 |
| blake3-servil-mt / solo / IdleManyMessages / 32 | 40.170 | 40.600 | x1.011 | level | 2 of 4 | - | - | x1.001 | x1.001 | x0.592 |
| blake3-servil-mt / solo / IdleManyMessages / 48 | 37.028 | 39.939 | x1.079 | level | 2 of 4 | - | - | x0.996 | x1.001 | x0.570 |
| blake3-servil-mt / solo / IdleManyMessages / 64 | 34.737 | 33.565 | x0.966 | level | 3 of 4 | - | - | x1.004 | x1.000 | x0.767 |
| blake3-servil-mt / solo / IdleManyMessages / 128 | 30.415 | 30.885 | x1.015 | level | 0 of 4 | - | - | x1.000 | x1.000 | x0.664 |
| blake3-servil-mt / solo / IdleManyMessages / 256 | 29.701 | 29.662 | x0.999 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.963 |
| blake3-servil-mt / solo / IdleManyMessages / 512 | 29.193 | 29.344 | x1.005 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.859 |
| blake3-servil-mt / solo / IdleManyMessages / 1024 | 28.877 | 29.131 | x1.009 | level | 2 of 4 | - | - | x0.995 | x1.000 | x1.013 |
| blake3-servil-mt / solo / IdleManyMessages / 2048 | 29.439 | 28.943 | x0.983 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.105 |
| blake3-servil-mt / solo / IdleManyMessages / 4096 | 29.041 | 29.271 | x1.008 | level | 3 of 4 | - | - | x0.997 | x1.000 | x1.037 |
| blake3-servil-mt / solo / IdleManyMessages / 8192 | 13.107 | 13.035 | x0.995 | level | 3 of 4 | - | - | x0.995 | x1.034 | x1.018 |
| blake3-servil-mt / solo / IdleManyMessages / 16384 | 11.393 | 12.102 | x1.062 | level | 2 of 4 | - | - | x1.016 | x0.975 | x1.056 |
| blake3-servil-mt / solo / IdleManyMessages / 32768 | 12.040 | 10.527 | x0.874 | level | 4 of 4 | - | - | x0.893 | x1.120 | x0.883 |
| blake3-servil-mt / solo / IdleManyMessages / 65536 | 10.441 | 10.122 | x0.969 | level | 3 of 4 | - | - | x0.973 | x1.006 | x1.007 |
| blake3-servil-mt / solo / IdleManyMessages / 131072 | 11.071 | 11.121 | x1.004 | level | 2 of 4 | - | - | x0.993 | x0.980 | x1.020 |
| blake3-servil-mt / solo / IdleManyMessages / 262144 | 9.387 | 9.310 | x0.992 | level | 4 of 4 | - | - | x1.005 | x0.996 | x0.999 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 B | 2.451 | 2.468 | x1.007 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.924 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 B | 1.740 | 1.775 | x1.020 | level | 2 of 4 | - | - | x1.003 | x1.006 | x0.838 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 B | 1.311 | 1.315 | x1.003 | level | 2 of 4 | - | - | x1.004 | x1.001 | x1.575 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 B | 1.148 | 1.128 | x0.983 | level | 3 of 4 | - | - | x0.999 | x1.001 | x0.946 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 KiB | 1.029 | 1.029 | x1.000 | level | 3 of 4 | - | - | x0.998 | x1.001 | x0.863 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1536 B | 0.802 | 0.802 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.001 | x0.604 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 KiB | 0.572 | 0.573 | x1.002 | level | 1 of 4 | - | - | x1.001 | x1.001 | x0.748 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2304 B | 0.653 | 0.654 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.001 | x0.855 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 KiB | 0.475 | 0.483 | x1.017 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.205 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3839 B | 0.501 | 0.497 | x0.992 | level | 4 of 4 | - | - | x0.993 | x1.000 | x1.007 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 KiB | 0.360 | 0.354 | x0.983 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.944 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4470 B | 0.426 | 0.434 | x1.019 | level | 1 of 4 | - | - | x1.003 | x1.000 | x0.954 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 7935 B | 0.269 | 0.269 | x1.002 | level | 1 of 4 | - | - | x1.003 | x1.000 | x1.905 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 KiB | 0.246 | 0.257 | x1.041 | level | 1 of 4 | - | - | x1.004 | x1.000 | x0.852 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 16 KiB | 0.232 | 0.230 | x0.990 | level | 2 of 4 | - | - | x1.001 | x1.000 | x1.238 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 KiB | 0.226 | 0.223 | x0.986 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.773 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 KiB | 0.223 | 0.220 | x0.988 | level | 2 of 4 | - | - | x0.993 | x1.000 | x0.771 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 KiB | 0.219 | 0.218 | x0.994 | level | 2 of 4 | - | - | x0.993 | x1.000 | x1.108 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 KiB | 0.225 | 0.225 | x1.001 | level | 3 of 4 | - | - | x1.000 | x1.000 | x1.087 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 KiB | 0.128 | 0.109 | x0.852 | level | 3 of 4 | - | - | x0.852 | x0.995 | x1.025 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 MiB | 0.0994 | 0.0976 | x0.982 | level | 1 of 4 | - | - | x0.991 | x1.030 | x1.011 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 MiB | 0.114 | 0.114 | x1.005 | level | 2 of 4 | - | - | x1.009 | x1.017 | x0.998 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 MiB | 0.112 | 0.113 | x1.003 | level | 2 of 4 | - | - | x1.003 | x1.008 | x1.003 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 MiB | 0.107 | 0.115 | x1.071 | level | 1 of 4 | - | - | x1.072 | x0.983 | x1.040 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 MiB | 0.115 | 0.115 | x1.002 | level | 2 of 4 | - | - | x1.002 | x0.978 | x1.009 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 MiB | 0.0617 | 0.0611 | x0.990 | level | 3 of 4 | - | - | x0.990 | x0.992 | x1.001 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 MiB | 0.0685 | 0.0682 | x0.996 | level | 4 of 4 | - | - | x0.997 | x0.997 | x0.988 |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 MiB | 0.0708 | 0.0707 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.004 | x0.999 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1 | 170.202 | 172.200 | x1.012 | level | 0 of 4 | - | - | x1.009 | x1.001 | x0.718 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2 | 88.666 | 89.538 | x1.010 | level | 1 of 4 | - | - | x1.007 | x1.002 | x0.746 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 3 | 77.420 | 78.014 | x1.008 | level | 1 of 4 | - | - | x1.005 | x1.002 | x0.677 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4 | 48.647 | 49.566 | x1.019 | level | 0 of 4 | - | - | x1.011 | x1.002 | x0.750 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 6 | 42.972 | 44.548 | x1.037 | level | 0 of 4 | - | - | x1.007 | x1.001 | x0.809 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8 | 31.178 | 30.664 | x0.984 | level | 1 of 4 | - | - | x1.004 | x1.002 | x0.856 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 12 | 27.296 | 27.385 | x1.003 | level | 1 of 4 | - | - | x1.004 | x1.001 | x0.865 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16 | 23.476 | 23.854 | x1.016 | level | 2 of 4 | - | - | x1.001 | x1.001 | x0.638 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 24 | 20.165 | 20.223 | x1.003 | level | 1 of 4 | - | - | x1.002 | x1.001 | x0.894 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32 | 18.425 | 18.483 | x1.003 | level | 2 of 4 | - | - | x1.001 | x1.001 | x0.550 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 48 | 16.757 | 16.747 | x0.999 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.887 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 64 | 15.892 | 15.930 | x1.002 | level | 1 of 4 | - | - | x1.002 | x1.000 | x1.005 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 128 | 14.688 | 14.888 | x1.014 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.943 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 256 | 13.916 | 13.922 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.064 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 512 | 13.690 | 13.877 | x1.014 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.832 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1024 | 13.393 | 13.446 | x1.004 | level | 2 of 4 | - | - | x1.004 | x1.000 | x1.035 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2048 | 13.614 | 13.648 | x1.003 | level | 1 of 4 | - | - | x0.996 | x1.000 | x1.047 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4096 | 14.065 | 14.051 | x0.999 | level | 1 of 4 | - | - | x0.997 | x1.000 | x1.061 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8192 | 6.785 | 6.727 | x0.991 | level | 3 of 4 | - | - | x0.992 | x1.005 | x1.015 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16384 | 6.094 | 6.205 | x1.018 | level | 1 of 4 | - | - | x1.018 | x1.027 | x0.994 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32768 | 6.580 | 5.606 | x0.852 | level | 3 of 4 | - | - | x0.851 | x1.076 | x0.889 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 65536 | 5.634 | 5.647 | x1.002 | level | 1 of 4 | - | - | x1.005 | x0.998 | x1.003 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 131072 | 7.676 | 7.569 | x0.986 | level | 3 of 4 | - | - | x0.982 | x1.023 | x0.983 |
| blake3-servil-mt / solo / BriefIdleManyMessages / 262144 | 7.636 | 7.674 | x1.005 | level | 2 of 4 | - | - | x1.006 | x0.984 | x1.012 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.673 | 0.651 | x0.968 | level | 4 of 4 | x0.952 | - | x0.969 | x0.995 | x1.077 |
| blake3-servil-mt / solo / ContinuousMessages / 128 B | 0.343 | 0.330 | x0.962 | level | 4 of 4 | x1.025 | - | x0.964 | x0.996 | x1.144 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.181 | 0.177 | x0.979 | level | 3 of 4 | x1.002 | - | x0.979 | x0.996 | x1.268 |
| blake3-servil-mt / solo / ContinuousMessages / 512 B | 0.110 | 0.108 | x0.988 | level | 4 of 4 | x1.017 | - | x0.990 | x0.996 | x0.924 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.0826 | 0.0740 | x0.896 | level | 4 of 4 | x0.897 | - | x0.895 | x0.996 | x1.098 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0727 | 0.0717 | x0.986 | level | 2 of 4 | x0.994 | - | x0.983 | x0.998 | x1.065 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0555 | 0.0539 | x0.972 | level | 2 of 4 | x1.051 | - | x0.972 | x0.998 | x1.029 |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.0510 | 0.0522 | x1.023 | level | 1 of 4 | x0.972 | - | x1.025 | x1.000 | x0.994 |
| blake3-servil-mt / solo / ContinuousMessages / 256 KiB | 0.0506 | 0.0487 | x0.962 | level | 3 of 4 | x1.037 | - | x0.955 | x1.001 | x1.174 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0462 | 0.0424 | x0.916 | level | 4 of 4 | x1.017 | - | x0.916 | x1.001 | x1.185 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.0478 | 0.0446 | x0.932 | level | 3 of 4 | x1.000 | - | x0.927 | x1.002 | x1.206 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0464 | 0.0463 | x0.997 | level | 3 of 4 | x0.984 | - | x0.996 | x1.000 | x1.028 |
| blake3-servil-mt / solo / ContinuousMessages / 64 MiB | 0.0617 | 0.0619 | x1.003 | level | 1 of 4 | x1.002 | - | x1.005 | x1.000 | x0.990 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 6.074 | 6.146 | x1.012 | level | 1 of 4 | x1.032 | - | x1.010 | x0.997 | x1.003 |
| blake3-servil-mt / solo / ContinuousBatches / 64 | 3.935 | 4.108 | x1.044 | level | 1 of 4 | x0.979 | - | x1.041 | x0.999 | x0.938 |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 3.383 | 3.349 | x0.990 | level | 2 of 4 | x1.066 | - | x0.991 | x1.002 | x0.999 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 3.502 | 3.339 | x0.953 | level | 3 of 4 | x1.034 | - | x0.951 | x1.002 | x1.203 |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 3.960 | 3.978 | x1.004 | level | 2 of 4 | x0.998 | - | x1.005 | x0.996 | x0.955 |
| blake3-servil-mt / solo / ContinuousBatches / 16384 | 4.189 | 4.004 | x0.956 | level | 3 of 4 | x0.964 | - | x0.957 | x1.037 | x0.961 |
| blake3-servil-mt / solo / ContinuousBatches / 65536 | 3.215 | 3.318 | x1.032 | level | 2 of 4 | x1.064 | - | x1.037 | x0.990 | x1.007 |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.952 | 0.956 | x1.004 | level | 2 of 4 | x1.004 | - | x1.005 | x1.000 | x0.694 |
| blake3-servil-mt / solo / LentMessages / 128 B | 0.950 | 0.954 | x1.005 | level | 0 of 4 | x1.005 | - | x1.003 | x1.000 | x0.878 |
| blake3-servil-mt / solo / LentMessages / 256 B | 0.934 | 0.935 | x1.001 | level | 1 of 4 | x1.001 | - | x1.001 | x1.000 | x1.084 |
| blake3-servil-mt / solo / LentMessages / 512 B | 0.931 | 0.933 | x1.002 | level | 2 of 4 | x1.002 | - | x1.001 | x1.000 | x1.107 |
| blake3-servil-mt / solo / LentMessages / 1 KiB | 0.929 | 0.929 | x1.000 | level | 2 of 4 | x1.000 | - | x1.000 | x1.000 | x1.346 |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.317 | 0.317 | x0.998 | level | 2 of 4 | x0.998 | - | x0.999 | x1.000 | x1.316 |
| blake3-servil-mt / solo / LentMessages / 16 KiB | 0.215 | 0.215 | x1.001 | level | 2 of 4 | x1.001 | - | x1.002 | x1.000 | x0.698 |
| blake3-servil-mt / solo / LentMessages / 64 KiB | 0.216 | 0.217 | x1.003 | level | 1 of 4 | x1.004 | - | x1.003 | x1.000 | x0.887 |
| blake3-servil-mt / solo / LentMessages / 256 KiB | 0.219 | 0.220 | x1.005 | level | 1 of 4 | x1.004 | - | x1.005 | x1.000 | x1.079 |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.0786 | 0.0790 | x1.006 | level | 2 of 4 | x0.970 | - | x1.010 | x1.002 | x0.939 |
| blake3-servil-mt / solo / LentMessages / 4 MiB | 0.0654 | 0.0647 | x0.990 | level | 3 of 4 | x1.003 | - | x0.989 | x0.996 | x1.002 |
| blake3-servil-mt / solo / LentMessages / 16 MiB | 0.0945 | 0.0926 | x0.980 | level | 3 of 4 | x1.031 | - | x0.978 | x0.984 | x1.010 |
| blake3-servil-mt / solo / LentMessages / 64 MiB | 0.0812 | 0.0814 | x1.002 | level | 2 of 4 | x1.020 | - | x1.002 | x0.990 | x0.998 |
| blake3-servil-mt / solo / Interleaved / 256 | 0.260 | 0.262 | x1.004 | level | 2 of 4 | x1.004 | - | x1.004 | x1.002 | x1.060 |
| blake3-servil-mt / solo / Collection / git objects | 0.0140 | 0.0139 | x0.996 | level | 2 of 4 | x0.988 | - | x1.001 | x1.007 | x0.995 |
| blake3-servil-mt / solo / Collection / Nix files | 0.0209 | 0.0210 | x1.005 | level | 1 of 4 | x1.053 | - | x0.996 | x0.975 | x0.956 |
| blake3-servil-mt / solo / LentBatches / 16 | 15.743 | 16.439 | x1.044 | level | 1 of 4 | x1.044 | - | x1.045 | x1.000 | x1.070 |
| blake3-servil-mt / solo / LentBatches / 64 | 13.594 | 13.770 | x1.013 | level | 2 of 4 | x1.014 | - | x1.013 | x1.000 | x1.075 |
| blake3-servil-mt / solo / LentBatches / 256 | 13.592 | 13.719 | x1.009 | level | 1 of 4 | x1.008 | - | x1.008 | x1.000 | x0.753 |
| blake3-servil-mt / solo / LentBatches / 1024 | 13.770 | 13.848 | x1.006 | level | 2 of 4 | x1.006 | - | x1.006 | x1.000 | x0.963 |
| blake3-servil-mt / solo / LentBatches / 4096 | 14.485 | 14.385 | x0.993 | level | 3 of 4 | x0.993 | - | x0.994 | x1.000 | x0.995 |
| blake3-servil-mt / solo / LentBatches / 16384 | 5.449 | 5.429 | x0.996 | level | 2 of 4 | x0.987 | - | x0.996 | x1.004 | x0.996 |
| blake3-servil-mt / solo / LentBatches / 65536 | 5.050 | 4.805 | x0.951 | level | 3 of 4 | x0.835 | - | x0.953 | x1.013 | x0.976 |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.0648 | 0.0649 | x1.002 | level | 2 of 4 | x0.969 | - | x1.004 | x0.999 | x1.044 |
| blake3-servil-mt / solo / ContinuousCollection / Nix files | 0.0640 | 0.0641 | x1.002 | level | 3 of 4 | x0.979 | - | x0.999 | x1.000 | x0.981 |
| blake3-servil-mt / solo / MerkleTree / 1024 | 0.261 | 0.261 | x1.002 | level | 1 of 4 | x1.002 | - | x1.001 | x1.000 | x1.047 |
| blake3-servil-mt / solo / MerkleTree / 4096 | 0.128 | 0.131 | x1.018 | level | 1 of 4 | x1.026 | - | x1.021 | x1.007 | x0.972 |
| blake3-servil-mt / solo / MerkleTree / 16384 | 0.144 | 0.140 | x0.978 | level | 3 of 4 | x0.981 | - | x0.983 | x1.003 | x1.002 |
| blake3-servil-mt / solo / MerkleTree / 65536 | 0.149 | 0.145 | x0.972 | level | 3 of 4 | x0.903 | - | x0.970 | x0.980 | x0.949 |
| blake3-servil-mt / solo / MerkleTree / 262144 | 0.343 | 0.342 | x0.995 | level | 2 of 4 | x0.969 | - | x0.995 | x0.999 | x0.992 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 32 B | 0.267 | 0.236 | x0.884 | level | 4 of 4 | x0.619 | - | x0.887 | x1.131 | x0.827 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 32 B | 0.434 | 0.432 | x0.995 | level | 3 of 4 | x0.983 | - | x0.996 | x1.003 | x1.012 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 16 B | 0.348 | 0.343 | x0.988 | level | 4 of 4 | x0.973 | - | x0.990 | x1.018 | x1.024 |
| blake3-servil-mt / solo / MerkleTree / 65536 x 48 B | 0.205 | 0.184 | x0.897 | level | 3 of 4 | x0.727 | - | x0.889 | x1.057 | x0.959 |
| blake3-servil-mt / solo / MerkleTree / 1048576 x 48 B | 0.396 | 0.396 | x1.000 | level | 2 of 4 | x0.991 | - | x0.999 | x1.010 | x1.003 |
| blake3-servil-mt / solo / InterleavedTurn / 256 | 0.793 | 0.795 | x1.002 | level | 2 of 4 | - | - | x0.993 | x0.992 | x1.004 |
| blake3-servil-mt / solo / InterleavedTurn / 1024 x 1 KiB | 0.326 | 0.325 | x0.997 | level | 3 of 4 | - | - | x0.995 | x0.994 | x0.991 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 256 | 0.750 | 0.743 | x0.990 | level | 4 of 4 | - | - | x0.981 | x1.017 | x0.992 |
| blake3-servil-mt / solo / IdleInterleavedTurn / 1024 x 1 KiB | 0.472 | 0.483 | x1.025 | level | 1 of 4 | - | - | x0.999 | x0.997 | x0.999 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 256 | 0.541 | 0.535 | x0.989 | level | 3 of 4 | - | - | x0.994 | x0.984 | x0.981 |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 1024 x 1 KiB | 0.291 | 0.287 | x0.986 | level | 3 of 4 | - | - | x0.984 | x0.994 | x0.997 |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.0469 | 0.0455 | x0.971 | level | 3 of 4 | x0.989 | - | x0.973 | x1.002 | x1.034 |
| blake3-servil-mt / solo / ReceivingMessage / 2 μs | 0.0930 | 0.0930 | x0.999 | level | 3 of 4 | x1.043 | - | x1.022 | x0.999 | x0.962 |
| blake3-servil-mt / solo / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 2 of 4 | x0.996 | - | x0.986 | x1.000 | x1.040 |
| blake3-servil-mt / solo / IncrementalMessage / 64 B | 7.505 | 9.100 | x1.213 | level | 0 of 4 | - | - | x1.122 | x1.005 | x1.022 |
| blake3-servil-mt / solo / IncrementalMessage / 1 KiB | 1.533 | 1.565 | x1.021 | level | 1 of 4 | - | - | x1.019 | x1.001 | x1.010 |
| blake3-servil-mt / solo / IncrementalMessage / 4 KiB | 0.724 | 0.732 | x1.011 | level | 2 of 4 | - | - | x1.037 | x1.001 | x0.999 |
| blake3-servil-mt / solo / LentIncrementalMessage / 64 B | 1.265 | 1.272 | x1.006 | level | 0 of 4 | x1.006 | - | x1.006 | x1.000 | x0.657 |
| blake3-servil-mt / solo / LentIncrementalMessage / 1 KiB | 0.952 | 0.951 | x0.999 | level | 1 of 4 | x0.999 | - | x0.998 | x1.000 | x1.062 |
| blake3-servil-mt / solo / LentIncrementalMessage / 4 KiB | 0.331 | 0.329 | x0.993 | level | 4 of 4 | x0.994 | - | x0.996 | x1.000 | x1.485 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 64 B | 5.394 | 5.373 | x0.996 | level | 2 of 4 | x0.977 | - | x0.997 | x0.999 | x1.025 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 4 KiB | 0.144 | 0.123 | x0.859 | level | 4 of 4 | x0.829 | - | x0.855 | x0.999 | x0.950 |
| blake3-servil-mt / solo / ContinuousKeyedMessages / 1 MiB | 0.0430 | 0.0454 | x1.056 | level | 1 of 4 | x0.966 | - | x1.048 | x1.002 | x0.927 |
| blake3-servil-mt / solo / ContinuousLentMessages / 64 B | 0.595 | 0.566 | x0.952 | level | 3 of 4 | x0.948 | - | x0.953 | x0.995 | x0.967 |
| blake3-servil-mt / solo / ContinuousLentMessages / 4 KiB | 0.0377 | 0.0369 | x0.980 | level | 4 of 4 | x0.970 | - | x0.971 | x1.001 | x0.887 |
| blake3-servil-mt / solo / ContinuousLentMessages / 1 MiB | 0.00868 | 0.00870 | x1.003 | level | 1 of 4 | x1.002 | - | x1.003 | x1.002 | x1.028 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.685 | 0.631 | x0.920 | level | 4 of 4 | - | - | x0.921 | x0.995 | x1.104 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 128 B | 0.357 | 0.329 | x0.923 | level | 4 of 4 | - | - | x0.923 | x0.995 | x1.073 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.195 | 0.184 | x0.940 | level | 4 of 4 | - | - | x0.940 | x0.996 | x1.066 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 512 B | 0.130 | 0.124 | x0.953 | level | 4 of 4 | - | - | x0.954 | x0.996 | x0.957 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.0969 | 0.0975 | x1.006 | level | 1 of 4 | - | - | x1.006 | x0.996 | x1.009 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.116 | 0.114 | x0.977 | level | 3 of 4 | - | - | x0.978 | x1.004 | x0.996 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.0919 | 0.0902 | x0.981 | level | 2 of 4 | - | - | x0.977 | x1.005 | x0.979 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.0770 | 0.0754 | x0.979 | level | 3 of 4 | - | - | x0.979 | x1.004 | x0.995 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 KiB | 0.0761 | 0.0749 | x0.985 | level | 2 of 4 | - | - | x0.983 | x1.003 | x1.007 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0762 | 0.0767 | x1.007 | level | 1 of 4 | - | - | x0.999 | x1.001 | x1.041 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.0782 | 0.0790 | x1.011 | level | 1 of 4 | - | - | x0.997 | x0.994 | x0.998 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.0770 | 0.0760 | x0.987 | level | 3 of 4 | - | - | x0.992 | x0.996 | x0.971 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 MiB | 0.0766 | 0.0753 | x0.984 | level | 3 of 4 | - | - | x0.987 | x1.001 | x1.024 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 7.310 | 7.517 | x1.028 | level | 2 of 4 | - | - | x1.029 | x0.997 | x0.995 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 64 | 5.545 | 5.459 | x0.984 | level | 2 of 4 | - | - | x1.000 | x0.993 | x0.983 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 256 | 5.302 | 5.342 | x1.008 | level | 2 of 4 | - | - | x0.994 | x1.015 | x0.990 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 4.969 | 4.917 | x0.990 | level | 2 of 4 | - | - | x0.984 | x1.004 | x0.984 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 4096 | 5.135 | 5.481 | x1.067 | level | 2 of 4 | - | - | x1.059 | x1.012 | x1.070 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16384 | 4.795 | 4.865 | x1.015 | level | 2 of 4 | - | - | x1.007 | x1.006 | x1.031 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 65536 | 6.454 | 6.783 | x1.051 | level | 2 of 4 | - | - | x1.050 | x1.003 | x1.016 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.947 | 0.948 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.903 |
| blake3-servil-mt / shared-one-cache / LentMessages / 128 B | 0.955 | 0.952 | x0.997 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.814 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 B | 0.933 | 0.933 | x0.999 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.889 |
| blake3-servil-mt / shared-one-cache / LentMessages / 512 B | 0.927 | 0.928 | x1.001 | level | 0 of 4 | - | - | x1.001 | x1.000 | x1.065 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 KiB | 0.926 | 0.926 | x1.000 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.079 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.316 | 0.316 | x0.999 | level | 3 of 4 | - | - | x0.998 | x1.000 | x1.216 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 KiB | 0.215 | 0.214 | x0.999 | level | 1 of 4 | - | - | x0.999 | x1.000 | x0.738 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 KiB | 0.215 | 0.215 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.945 |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 KiB | 0.219 | 0.219 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.115 |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 MiB | 0.0974 | 0.0962 | x0.987 | level | 3 of 4 | - | - | x0.987 | x0.991 | x0.853 |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 MiB | 0.0678 | 0.0699 | x1.031 | level | 0 of 4 | - | - | x1.025 | x1.012 | x1.027 |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 MiB | 0.135 | 0.132 | x0.975 | level | 3 of 4 | - | - | x0.980 | x0.985 | x0.953 |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 MiB | 0.110 | 0.112 | x1.016 | level | 2 of 4 | - | - | x1.015 | x1.067 | x1.054 |
| blake3-servil-mt / shared-one-cache / Interleaved / 256 | 0.269 | 0.265 | x0.985 | level | 4 of 4 | - | - | x0.985 | x1.001 | x0.993 |
| blake3-servil-mt / shared-one-cache / Collection / git objects | 0.0304 | 0.0302 | x0.992 | level | 1 of 4 | - | - | x0.974 | x0.960 | x0.957 |
| blake3-servil-mt / shared-one-cache / Collection / Nix files | 0.0317 | 0.0324 | x1.020 | level | 1 of 4 | - | - | x1.028 | x1.040 | x1.044 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16 | 15.757 | 16.385 | x1.040 | level | 2 of 4 | - | - | x1.043 | x1.000 | x1.256 |
| blake3-servil-mt / shared-one-cache / LentBatches / 64 | 13.644 | 13.763 | x1.009 | level | 2 of 4 | - | - | x1.009 | x1.000 | x1.020 |
| blake3-servil-mt / shared-one-cache / LentBatches / 256 | 13.532 | 13.604 | x1.005 | level | 1 of 4 | - | - | x1.004 | x1.000 | x0.890 |
| blake3-servil-mt / shared-one-cache / LentBatches / 1024 | 13.710 | 13.800 | x1.007 | level | 1 of 4 | - | - | x1.006 | x1.000 | x1.059 |
| blake3-servil-mt / shared-one-cache / LentBatches / 4096 | 14.381 | 14.398 | x1.001 | level | 1 of 4 | - | - | x1.002 | x1.000 | x0.983 |
| blake3-servil-mt / shared-one-cache / LentBatches / 16384 | 6.098 | 6.327 | x1.038 | level | 1 of 4 | - | - | x1.034 | x0.987 | x0.917 |
| blake3-servil-mt / shared-one-cache / LentBatches / 65536 | 7.742 | 6.586 | x0.851 | level | 4 of 4 | - | - | x0.849 | x1.030 | x0.803 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.0942 | 0.0932 | x0.989 | level | 3 of 4 | - | - | x0.993 | x0.998 | x1.000 |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / Nix files | 0.0928 | 0.0931 | x1.004 | level | 2 of 4 | - | - | x1.001 | x1.002 | x1.000 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1024 | 0.261 | 0.261 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.013 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 4096 | 0.146 | 0.151 | x1.029 | level | 1 of 4 | - | - | x1.035 | x1.012 | x1.025 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 16384 | 0.164 | 0.161 | x0.979 | level | 2 of 4 | - | - | x0.977 | x1.005 | x1.153 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 | 0.236 | 0.238 | x1.006 | level | 2 of 4 | - | - | x1.005 | x1.010 | x1.024 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 262144 | 0.351 | 0.351 | x0.999 | level | 1 of 4 | - | - | x1.000 | x1.006 | x1.001 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 32 B | 0.366 | 0.366 | x1.000 | level | 3 of 4 | - | - | x1.000 | x1.007 | x1.005 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 32 B | 0.516 | 0.520 | x1.008 | level | 2 of 4 | - | - | x1.012 | x1.012 | x0.992 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 16 B | 0.580 | 0.587 | x1.012 | level | 1 of 4 | - | - | x0.994 | x1.002 | x1.004 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 x 48 B | 0.295 | 0.295 | x1.001 | level | 2 of 4 | - | - | x1.000 | x0.989 | x1.032 |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1048576 x 48 B | 0.434 | 0.432 | x0.996 | level | 2 of 4 | - | - | x0.996 | x1.059 | x0.995 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.0788 | 0.0789 | x1.001 | level | 2 of 4 | - | - | x1.002 | x1.014 | x1.002 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 2 μs | 0.0955 | 0.0953 | x0.997 | level | 1 of 4 | - | - | x1.012 | x0.995 | x0.991 |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 2 of 4 | - | - | x0.995 | x0.995 | x0.997 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 64 B | 1.267 | 1.270 | x1.003 | level | 1 of 4 | - | - | x1.003 | x1.000 | x0.288 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 1 KiB | 0.949 | 0.949 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.900 |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 4 KiB | 0.328 | 0.328 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x0.968 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 64 B | 15.201 | 15.901 | x1.046 | level | 2 of 4 | - | - | x1.032 | x1.007 | x0.949 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 4 KiB | 0.247 | 0.254 | x1.026 | level | 1 of 4 | - | - | x0.993 | x1.009 | x0.992 |
| blake3-servil-mt / shared-one-cache / ContinuousKeyedMessages / 1 MiB | 0.0774 | 0.0779 | x1.006 | level | 1 of 4 | - | - | x0.999 | x1.001 | x0.969 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 64 B | 0.574 | 0.557 | x0.971 | level | 3 of 4 | - | - | x0.971 | x0.995 | x0.936 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 4 KiB | 0.0803 | 0.0739 | x0.919 | level | 3 of 4 | - | - | x1.003 | x1.001 | x0.995 |
| blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 1 MiB | 0.0172 | 0.0177 | x1.029 | level | 2 of 4 | - | - | x0.932 | x0.928 | x0.916 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 B | 0.906 | 0.921 | x1.016 | level | 1 of 4 | - | - | x1.017 | x0.995 | x1.106 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 128 B | 0.543 | 0.561 | x1.034 | level | 1 of 4 | - | - | x1.031 | x0.996 | x1.098 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 256 B | 0.378 | 0.369 | x0.978 | level | 2 of 4 | - | - | x0.979 | x0.996 | x1.169 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 512 B | 0.173 | 0.182 | x1.050 | level | 1 of 4 | - | - | x1.047 | x0.996 | x1.002 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 KiB | 0.131 | 0.124 | x0.943 | level | 3 of 4 | - | - | x0.943 | x0.996 | x0.966 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 4 KiB | 0.108 | 0.107 | x0.986 | level | 3 of 4 | - | - | x0.984 | x0.998 | x0.982 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 16 KiB | 0.0820 | 0.0849 | x1.035 | level | 0 of 4 | - | - | x1.034 | x0.998 | x0.951 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 KiB | 0.0886 | 0.0901 | x1.016 | level | 1 of 4 | - | - | x1.015 | x1.001 | x0.961 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 256 KiB | 0.0935 | 0.0891 | x0.953 | level | 3 of 4 | - | - | x0.954 | x1.000 | x1.090 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 MiB | 0.0946 | 0.0891 | x0.942 | level | 3 of 4 | - | - | x0.944 | x0.998 | x1.100 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 4 MiB | 0.0895 | 0.0891 | x0.996 | level | 2 of 4 | - | - | x0.996 | x1.002 | x1.011 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 16 MiB | 0.0927 | 0.0884 | x0.954 | level | 3 of 4 | - | - | x0.955 | x0.997 | x1.079 |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 MiB | 0.110 | 0.106 | x0.967 | level | 3 of 4 | - | - | x0.967 | x1.001 | x1.081 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 16 | 14.074 | 14.090 | x1.001 | level | 2 of 4 | - | - | x1.002 | x0.997 | x1.006 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 64 | 9.182 | 9.130 | x0.994 | level | 2 of 4 | - | - | x0.994 | x0.997 | x0.995 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 256 | 7.794 | 7.765 | x0.996 | level | 1 of 4 | - | - | x0.994 | x1.000 | x0.943 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 1024 | 7.435 | 7.421 | x0.998 | level | 2 of 4 | - | - | x0.999 | x0.998 | x0.983 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 4096 | 8.258 | 8.503 | x1.030 | level | 0 of 4 | - | - | x1.030 | x1.007 | x0.918 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 16384 | 7.589 | 7.760 | x1.022 | level | 1 of 4 | - | - | x1.023 | x0.979 | x1.024 |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 65536 | 6.235 | 6.190 | x0.993 | level | 2 of 4 | - | - | x0.993 | x1.036 | x1.009 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 B | 0.950 | 0.951 | x1.001 | level | 2 of 4 | - | - | x1.001 | x1.000 | x0.773 |
| blake3-servil-mt / shared-two-caches / LentMessages / 128 B | 0.956 | 0.954 | x0.998 | level | 2 of 4 | - | - | x0.998 | x1.000 | x0.726 |
| blake3-servil-mt / shared-two-caches / LentMessages / 256 B | 0.935 | 0.934 | x0.999 | level | 3 of 4 | - | - | x1.000 | x1.000 | x0.797 |
| blake3-servil-mt / shared-two-caches / LentMessages / 512 B | 0.930 | 0.930 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x1.080 |
| blake3-servil-mt / shared-two-caches / LentMessages / 1 KiB | 0.927 | 0.928 | x1.001 | level | 1 of 4 | - | - | x1.000 | x1.000 | x1.188 |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 KiB | 0.317 | 0.316 | x0.999 | level | 3 of 4 | - | - | x0.998 | x1.000 | x0.956 |
| blake3-servil-mt / shared-two-caches / LentMessages / 16 KiB | 0.215 | 0.215 | x0.999 | level | 1 of 4 | - | - | x0.999 | x1.000 | x0.925 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 KiB | 0.215 | 0.216 | x1.001 | level | 1 of 4 | - | - | x1.001 | x1.000 | x0.809 |
| blake3-servil-mt / shared-two-caches / LentMessages / 256 KiB | 0.218 | 0.219 | x1.002 | level | 1 of 4 | - | - | x1.001 | x1.000 | x1.094 |
| blake3-servil-mt / shared-two-caches / LentMessages / 1 MiB | 0.106 | 0.102 | x0.965 | level | 3 of 4 | - | - | x0.970 | x1.010 | x0.997 |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 MiB | 0.0830 | 0.0830 | x0.999 | level | 2 of 4 | - | - | x0.999 | x1.000 | x1.069 |
| blake3-servil-mt / shared-two-caches / LentMessages / 16 MiB | 0.0945 | 0.0976 | x1.033 | level | 1 of 4 | - | - | x1.031 | x1.015 | x1.043 |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 MiB | 0.0847 | 0.0853 | x1.007 | level | 2 of 4 | - | - | x1.010 | x1.041 | x1.042 |
| blake3-servil-mt / shared-two-caches / Interleaved / 256 | 0.256 | 0.257 | x1.003 | level | 1 of 4 | - | - | x1.003 | x1.001 | x0.983 |
| blake3-servil-mt / shared-two-caches / Collection / git objects | 0.0291 | 0.0298 | x1.022 | level | 1 of 4 | - | - | x0.999 | x0.991 | x0.988 |
| blake3-servil-mt / shared-two-caches / Collection / Nix files | 0.0316 | 0.0314 | x0.993 | level | 3 of 4 | - | - | x0.992 | x0.996 | x0.976 |
| blake3-servil-mt / shared-two-caches / LentBatches / 16 | 15.743 | 16.409 | x1.042 | level | 2 of 4 | - | - | x1.043 | x1.000 | x1.082 |
| blake3-servil-mt / shared-two-caches / LentBatches / 64 | 13.658 | 13.772 | x1.008 | level | 1 of 4 | - | - | x1.008 | x1.000 | x0.972 |
| blake3-servil-mt / shared-two-caches / LentBatches / 256 | 13.557 | 13.607 | x1.004 | level | 3 of 4 | - | - | x1.004 | x1.000 | x0.914 |
| blake3-servil-mt / shared-two-caches / LentBatches / 1024 | 13.729 | 13.803 | x1.005 | level | 1 of 4 | - | - | x1.006 | x1.000 | x1.068 |
| blake3-servil-mt / shared-two-caches / LentBatches / 4096 | 14.351 | 14.388 | x1.003 | level | 1 of 4 | - | - | x1.000 | x1.000 | x0.976 |
| blake3-servil-mt / shared-two-caches / LentBatches / 16384 | 7.764 | 7.624 | x0.982 | level | 3 of 4 | - | - | x0.984 | x0.998 | x0.979 |
| blake3-servil-mt / shared-two-caches / LentBatches / 65536 | 6.261 | 5.828 | x0.931 | level | 3 of 4 | - | - | x0.936 | x0.997 | x1.010 |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / git objects | 0.101 | 0.104 | x1.031 | level | 2 of 4 | - | - | x1.029 | x1.000 | x0.942 |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / Nix files | 0.0999 | 0.106 | x1.060 | level | 0 of 4 | - | - | x1.058 | x1.000 | x0.914 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1024 | 0.261 | 0.260 | x0.996 | level | 2 of 4 | - | - | x0.997 | x1.000 | x1.036 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 4096 | 0.132 | 0.132 | x1.002 | level | 2 of 4 | - | - | x1.003 | x1.001 | x1.000 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 16384 | 0.151 | 0.143 | x0.944 | level | 3 of 4 | - | - | x0.945 | x1.011 | x1.036 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 | 0.178 | 0.181 | x1.015 | level | 0 of 4 | - | - | x1.015 | x0.998 | x1.019 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 262144 | 0.346 | 0.346 | x0.999 | level | 3 of 4 | - | - | x0.999 | x1.007 | x1.008 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 x 32 B | 0.349 | 0.353 | x1.011 | level | 3 of 4 | - | - | x1.012 | x0.984 | x0.985 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 32 B | 0.492 | 0.491 | x0.997 | level | 2 of 4 | - | - | x0.999 | x1.001 | x0.981 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 16 B | 0.521 | 0.528 | x1.013 | level | 1 of 4 | - | - | x1.006 | x1.016 | x0.928 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 65536 x 48 B | 0.275 | 0.285 | x1.035 | level | 1 of 4 | - | - | x1.032 | x0.966 | x0.966 |
| blake3-servil-mt / shared-two-caches / MerkleTree / 1048576 x 48 B | 0.431 | 0.431 | x1.000 | level | 2 of 4 | - | - | x0.999 | x0.987 | x1.004 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / saturated | 0.0904 | 0.0935 | x1.035 | level | 1 of 4 | - | - | x1.033 | x1.002 | x0.952 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / 2 μs | 0.101 | 0.101 | x0.997 | level | 1 of 4 | - | - | x1.034 | x0.992 | x0.938 |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 3 of 4 | - | - | x0.727 | x0.999 | x0.865 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 64 B | 1.269 | 1.273 | x1.003 | level | 1 of 4 | - | - | x1.003 | x1.000 | x0.302 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 1 KiB | 0.951 | 0.951 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.996 |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 4 KiB | 0.328 | 0.328 | x1.000 | level | 2 of 4 | - | - | x1.000 | x1.000 | x0.974 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 64 B | 15.911 | 16.905 | x1.062 | level | 0 of 4 | - | - | x1.064 | x1.000 | x0.983 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 4 KiB | 0.229 | 0.226 | x0.987 | level | 3 of 4 | - | - | x0.987 | x1.001 | x1.002 |
| blake3-servil-mt / shared-two-caches / ContinuousKeyedMessages / 1 MiB | 0.0920 | 0.0913 | x0.992 | level | 3 of 4 | - | - | x0.993 | x1.000 | x0.986 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 64 B | 0.635 | 0.630 | x0.992 | level | 2 of 4 | - | - | x0.994 | x0.995 | x0.939 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 4 KiB | 0.0669 | 0.0689 | x1.030 | level | 1 of 4 | - | - | x1.042 | x0.983 | x0.993 |
| blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 1 MiB | 0.0196 | 0.0175 | x0.891 | level | 3 of 4 | - | - | x0.827 | x0.817 | x0.813 |

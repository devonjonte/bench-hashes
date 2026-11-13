compare: old side: bench 3363bee8ff5e clean; servil b5b988d8982b clean
compare: new side: bench 97c0fbcbedb8 clean; servil bf2da8b957f5 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 7.090 | 7.502 | x1.058 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 128 B | 4.219 | 4.437 | x1.052 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 256 B | 2.616 | 2.632 | x1.006 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 512 B | 2.043 | 2.024 | x0.991 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 1 KiB | 1.402 | 1.419 | x1.012 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 1536 B | 1.482 | 1.484 | x1.001 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 2 KiB | 0.978 | 0.996 | x1.019 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 2304 B | 1.120 | 1.163 | x1.038 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 3 KiB | 1.011 | 0.876 | x0.866 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 3839 B | 1.022 | 0.995 | x0.974 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.604 | 0.651 | x1.078 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 4470 B | 0.690 | 0.723 | x1.047 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 7935 B | 0.607 | 0.554 | x0.913 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 8 KiB | 0.467 | 0.475 | x1.017 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 16 KiB | 0.388 | 0.397 | x1.023 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 32 KiB | 0.331 | 0.339 | x1.023 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 64 KiB | 0.308 | 0.312 | x1.013 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 128 KiB | 0.297 | 0.300 | x1.010 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 256 KiB | 0.290 | 0.294 | x1.015 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 512 KiB | 0.288 | 0.287 | x0.996 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 1 MiB | 0.287 | 0.290 | x1.010 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 2 MiB | 0.294 | 0.295 | x1.005 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 3 MiB | 0.296 | 0.296 | x1.001 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 4 MiB | 0.296 | 0.296 | x1.001 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 8 MiB | 0.309 | 0.308 | x0.998 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 32 MiB | 0.298 | 0.298 | x0.999 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 64 MiB | 0.297 | 0.298 | x1.004 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 128 MiB | 0.299 | 0.298 | x0.996 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 1 | 389.781 | 459.464 | x1.179 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 2 | 282.982 | 296.821 | x1.049 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 3 | 200.377 | 216.467 | x1.080 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 4 | 152.093 | 165.624 | x1.089 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 6 | 131.545 | 137.773 | x1.047 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 8 | 140.569 | 141.881 | x1.009 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 12 | 102.494 | 99.839 | x0.974 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 16 | 69.960 | 74.536 | x1.065 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 24 | 53.009 | 54.967 | x1.037 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 32 | 42.314 | 43.200 | x1.021 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 48 | 33.595 | 35.995 | x1.071 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 64 | 29.281 | 30.068 | x1.027 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 128 | 23.859 | 23.068 | x0.967 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 256 | 21.103 | 20.411 | x0.967 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 512 | 19.079 | 19.067 | x0.999 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 1024 | 18.487 | 18.169 | x0.983 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 2048 | 18.456 | 17.774 | x0.963 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 4096 | 17.935 | 17.713 | x0.988 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 8192 | 17.379 | 17.231 | x0.991 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 16384 | 17.224 | 17.143 | x0.995 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 32768 | 17.424 | 17.264 | x0.991 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 65536 | 17.686 | 17.556 | x0.993 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 131072 | 17.925 | 17.795 | x0.993 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 262144 | 18.145 | 18.015 | x0.993 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / ManyLongMessages / 4 | 1765.704 | 1755.593 | x0.994 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ManyLongMessages / 16 | 1231.570 | 1211.143 | x0.983 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / ManyLongMessages / 64 | 1169.792 | 1172.578 | x1.002 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / ManyLongMessages / 256 | 1148.223 | 1176.310 | x1.024 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 64 B | 5.679 | 5.638 | x0.993 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 128 B | 3.777 | 3.821 | x1.012 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 256 B | 2.826 | 2.950 | x1.044 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 512 B | 2.330 | 2.431 | x1.044 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 1 KiB | 2.179 | 2.168 | x0.995 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 1536 B | 1.716 | 1.754 | x1.022 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 2 KiB | 1.191 | 1.145 | x0.962 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 2304 B | 1.369 | 1.377 | x1.006 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 3 KiB | 1.576 | 1.071 | x0.679 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 1.084 | 1.083 | x0.998 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 4 KiB | 0.754 | 0.772 | x1.024 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 4470 B | 0.962 | 0.915 | x0.950 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 7935 B | 0.633 | 0.570 | x0.900 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 8 KiB | 0.551 | 0.512 | x0.931 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 16 KiB | 0.499 | 0.495 | x0.990 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 32 KiB | 0.476 | 0.485 | x1.018 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 64 KiB | 0.472 | 0.464 | x0.983 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 128 KiB | 0.455 | 0.466 | x1.024 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 256 KiB | 0.468 | 0.463 | x0.989 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 512 KiB | 0.466 | 0.481 | x1.031 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 1 MiB | 0.489 | 0.499 | x1.021 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 2 MiB | 0.465 | 0.478 | x1.028 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 3 MiB | 0.438 | 0.461 | x1.052 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 4 MiB | 0.419 | 0.427 | x1.020 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 8 MiB | 0.330 | 0.328 | x0.997 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 32 MiB | 0.294 | 0.295 | x1.006 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 64 MiB | 0.295 | 0.295 | x0.999 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 128 MiB | 0.298 | 0.298 | x1.000 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 1 | 398.389 | 421.763 | x1.059 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 2 | 217.657 | 207.817 | x0.955 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 3 | 181.277 | 183.350 | x1.011 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 4 | 110.864 | 116.027 | x1.047 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 6 | 99.978 | 98.451 | x0.985 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 8 | 72.953 | 70.202 | x0.962 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 12 | 64.288 | 63.366 | x0.986 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 16 | 52.822 | 53.335 | x1.010 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 24 | 45.144 | 44.769 | x0.992 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 32 | 41.639 | 41.196 | x0.989 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 48 | 36.056 | 39.581 | x1.098 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 64 | 34.419 | 34.330 | x0.997 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 128 | 31.948 | 31.751 | x0.994 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 256 | 30.357 | 29.663 | x0.977 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 512 | 29.912 | 29.147 | x0.974 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 1024 | 29.709 | 28.617 | x0.963 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 2048 | 29.743 | 28.138 | x0.946 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 4096 | 31.032 | 28.504 | x0.919 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 8192 | 30.042 | 28.269 | x0.941 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 16384 | 30.078 | 29.070 | x0.966 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 32768 | 30.755 | 29.603 | x0.963 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 65536 | 26.556 | 26.276 | x0.989 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 131072 | 20.838 | 20.673 | x0.992 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 262144 | 17.858 | 17.727 | x0.993 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 B | 2.581 | 2.628 | x1.018 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 B | 1.771 | 1.791 | x1.011 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 B | 1.341 | 1.358 | x1.012 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 B | 1.143 | 1.177 | x1.029 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 KiB | 1.061 | 1.036 | x0.977 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 1536 B | 0.844 | 0.815 | x0.965 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 KiB | 0.588 | 0.595 | x1.013 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 2304 B | 0.663 | 0.684 | x1.032 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.713 | 0.484 | x0.678 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 3839 B | 0.513 | 0.494 | x0.963 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 KiB | 0.358 | 0.371 | x1.036 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 4470 B | 0.429 | 0.433 | x1.010 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 7935 B | 0.279 | 0.268 | x0.963 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 KiB | 0.247 | 0.250 | x1.014 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 16 KiB | 0.231 | 0.233 | x1.011 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 KiB | 0.221 | 0.225 | x1.015 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 KiB | 0.216 | 0.219 | x1.015 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 KiB | 0.218 | 0.219 | x1.003 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 KiB | 0.221 | 0.225 | x1.018 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 KiB | 0.231 | 0.233 | x1.010 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 MiB | 0.233 | 0.236 | x1.010 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 MiB | 0.236 | 0.238 | x1.009 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 MiB | 0.236 | 0.239 | x1.011 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 MiB | 0.237 | 0.239 | x1.010 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 MiB | 0.241 | 0.243 | x1.010 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 MiB | 0.283 | 0.284 | x1.002 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 MiB | 0.292 | 0.293 | x1.002 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 MiB | 0.297 | 0.296 | x0.998 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 1 | 186.369 | 190.710 | x1.023 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 2 | 95.806 | 97.610 | x1.019 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 3 | 81.947 | 83.195 | x1.015 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 4 | 51.651 | 52.949 | x1.025 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 6 | 45.138 | 46.663 | x1.034 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 8 | 32.390 | 33.241 | x1.026 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 12 | 28.459 | 29.077 | x1.022 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 16 | 24.429 | 25.192 | x1.031 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 24 | 20.876 | 21.190 | x1.015 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 32 | 19.302 | 19.307 | x1.000 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 48 | 17.536 | 17.702 | x1.009 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 64 | 16.558 | 16.300 | x0.984 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 128 | 15.057 | 14.886 | x0.989 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 256 | 14.369 | 14.301 | x0.995 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 512 | 13.861 | 13.698 | x0.988 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 1024 | 13.997 | 13.384 | x0.956 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 2048 | 14.009 | 13.471 | x0.962 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 4096 | 14.598 | 13.982 | x0.958 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 8192 | 14.703 | 14.379 | x0.978 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 16384 | 14.775 | 14.531 | x0.983 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 32768 | 14.871 | 14.754 | x0.992 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 65536 | 15.804 | 15.440 | x0.977 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 131072 | 15.521 | 15.368 | x0.990 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 262144 | 15.631 | 15.509 | x0.992 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 1.046 | 0.891 | x0.852 | faster | 4 of 4 | x0.853 | - |
| blake3-servil-st / solo / ContinuousMessages / 128 B | 0.986 | 0.901 | x0.914 | faster | 4 of 4 | x0.914 | - |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 0.955 | 0.906 | x0.949 | level | 4 of 4 | x0.949 | - |
| blake3-servil-st / solo / ContinuousMessages / 512 B | 0.935 | 0.928 | x0.993 | level | 4 of 4 | x0.993 | - |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 0.924 | 0.924 | x1.000 | level | 2 of 4 | x1.000 | - |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.316 | 0.316 | x0.999 | level | 4 of 4 | x0.999 | - |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.215 | 0.216 | x1.007 | level | 1 of 4 | x1.007 | - |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.215 | 0.218 | x1.017 | level | 0 of 4 | x1.017 | - |
| blake3-servil-st / solo / ContinuousMessages / 256 KiB | 0.216 | 0.223 | x1.033 | level | 0 of 4 | x1.033 | - |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.220 | 0.224 | x1.018 | level | 0 of 4 | x1.018 | - |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.220 | 0.223 | x1.015 | level | 0 of 4 | x1.015 | - |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.221 | 0.225 | x1.015 | level | 0 of 4 | x1.015 | - |
| blake3-servil-st / solo / ContinuousMessages / 64 MiB | 0.245 | 0.249 | x1.015 | level | 0 of 4 | x1.015 | - |
| blake3-servil-st / solo / ContinuousBatches / 16 | 17.002 | 17.685 | x1.040 | level | 1 of 4 | x1.041 | - |
| blake3-servil-st / solo / ContinuousBatches / 64 | 13.928 | 14.085 | x1.011 | level | 1 of 4 | x1.012 | - |
| blake3-servil-st / solo / ContinuousBatches / 256 | 13.707 | 13.658 | x0.996 | level | 3 of 4 | x0.996 | - |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 13.828 | 13.778 | x0.996 | level | 2 of 4 | x0.996 | - |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 14.501 | 14.432 | x0.995 | level | 2 of 4 | x0.995 | - |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 14.707 | 14.667 | x0.997 | level | 2 of 4 | x0.997 | - |
| blake3-servil-st / solo / ContinuousBatches / 65536 | 14.899 | 14.916 | x1.001 | level | 2 of 4 | x1.001 | - |
| blake3-servil-st / solo / LentMessages / 64 B | 1.046 | 0.891 | x0.852 | faster | 4 of 4 | x0.853 | - |
| blake3-servil-st / solo / LentMessages / 128 B | 0.986 | 0.901 | x0.914 | faster | 4 of 4 | x0.914 | - |
| blake3-servil-st / solo / LentMessages / 256 B | 0.955 | 0.906 | x0.949 | level | 4 of 4 | x0.949 | - |
| blake3-servil-st / solo / LentMessages / 512 B | 0.935 | 0.928 | x0.993 | level | 4 of 4 | x0.993 | - |
| blake3-servil-st / solo / LentMessages / 1 KiB | 0.924 | 0.924 | x1.000 | level | 2 of 4 | x1.000 | - |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.316 | 0.316 | x0.999 | level | 4 of 4 | x0.999 | - |
| blake3-servil-st / solo / LentMessages / 16 KiB | 0.215 | 0.216 | x1.007 | level | 1 of 4 | x1.007 | - |
| blake3-servil-st / solo / LentMessages / 64 KiB | 0.215 | 0.218 | x1.017 | level | 0 of 4 | x1.017 | - |
| blake3-servil-st / solo / LentMessages / 256 KiB | 0.218 | 0.222 | x1.015 | level | 1 of 4 | x1.015 | - |
| blake3-servil-st / solo / LentMessages / 1 MiB | 0.228 | 0.230 | x1.009 | level | 1 of 4 | x1.010 | - |
| blake3-servil-st / solo / LentMessages / 4 MiB | 0.235 | 0.237 | x1.010 | level | 0 of 4 | x1.008 | - |
| blake3-servil-st / solo / LentMessages / 16 MiB | 0.251 | 0.254 | x1.009 | level | 0 of 4 | x1.009 | - |
| blake3-servil-st / solo / LentMessages / 64 MiB | 0.291 | 0.291 | x1.001 | level | 3 of 4 | x1.001 | - |
| blake3-servil-st / solo / Interleaved / 256 | 0.263 | 0.260 | x0.992 | level | 3 of 4 | x0.992 | - |
| blake3-servil-st / solo / Collection / git objects | 0.246 | 0.242 | x0.984 | level | 4 of 4 | x0.984 | - |
| blake3-servil-st / solo / Collection / Nix files | 0.241 | 0.237 | x0.983 | level | 4 of 4 | x0.983 | - |
| blake3-servil-st / solo / LentBatches / 16 | 17.002 | 17.685 | x1.040 | level | 1 of 4 | x1.041 | - |
| blake3-servil-st / solo / LentBatches / 64 | 13.928 | 14.085 | x1.011 | level | 1 of 4 | x1.012 | - |
| blake3-servil-st / solo / LentBatches / 256 | 13.707 | 13.658 | x0.996 | level | 3 of 4 | x0.996 | - |
| blake3-servil-st / solo / LentBatches / 1024 | 13.828 | 13.778 | x0.996 | level | 2 of 4 | x0.996 | - |
| blake3-servil-st / solo / LentBatches / 4096 | 14.501 | 14.432 | x0.995 | level | 2 of 4 | x0.995 | - |
| blake3-servil-st / solo / LentBatches / 16384 | 14.707 | 14.667 | x0.997 | level | 2 of 4 | x0.997 | - |
| blake3-servil-st / solo / LentBatches / 65536 | 14.899 | 14.916 | x1.001 | level | 2 of 4 | x1.001 | - |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.266 | 0.263 | x0.988 | level | 4 of 4 | x0.988 | - |
| blake3-servil-st / solo / ContinuousCollection / Nix files | 0.276 | 0.268 | x0.971 | level | 4 of 4 | x0.970 | - |
| blake3-servil-st / solo / MerkleTree / 1024 | 0.260 | 0.261 | x1.001 | level | 1 of 4 | x1.001 | - |
| blake3-servil-st / solo / MerkleTree / 4096 | 0.271 | 0.270 | x0.997 | level | 4 of 4 | x0.997 | - |
| blake3-servil-st / solo / MerkleTree / 16384 | 0.275 | 0.276 | x1.003 | level | 1 of 4 | x1.004 | - |
| blake3-servil-st / solo / MerkleTree / 65536 | 0.300 | 0.300 | x1.000 | level | 1 of 4 | x1.000 | - |
| blake3-servil-st / solo / MerkleTree / 262144 | 0.542 | 0.546 | x1.007 | level | 1 of 4 | x1.007 | - |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.493 | 0.474 | x0.961 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.742 | 0.735 | x0.991 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.417 | 0.397 | x0.952 | level | 3 of 4 | - | - |

compare: old side: bench 3363bee8ff5e clean; servil b5b988d8982b clean
compare: new side: bench 7c1645d455a9 clean; servil 5663b129e2c0 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 11.831 | 13.451 | x1.137 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 128 B | 7.234 | 6.917 | x0.956 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 256 B | 4.184 | 4.045 | x0.967 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 512 B | 2.600 | 2.559 | x0.984 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 1 KiB | 1.730 | 1.675 | x0.968 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 1536 B | 1.795 | 1.759 | x0.980 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 2 KiB | 1.203 | 1.235 | x1.027 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 2304 B | 1.264 | 1.276 | x1.010 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 3 KiB | 1.107 | 0.983 | x0.887 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 3839 B | 0.978 | 0.971 | x0.993 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.686 | 0.710 | x1.036 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 4470 B | 0.820 | 0.816 | x0.996 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 7935 B | 0.546 | 0.539 | x0.988 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 8 KiB | 0.469 | 0.479 | x1.021 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 16 KiB | 0.346 | 0.361 | x1.043 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 32 KiB | 0.321 | 0.312 | x0.971 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 64 KiB | 0.297 | 0.290 | x0.978 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 128 KiB | 0.294 | 0.294 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 256 KiB | 0.295 | 0.287 | x0.974 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 512 KiB | 0.275 | 0.273 | x0.994 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 1 MiB | 0.269 | 0.272 | x1.009 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 2 MiB | 0.252 | 0.252 | x0.998 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 3 MiB | 0.246 | 0.246 | x0.998 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 4 MiB | 0.243 | 0.243 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 8 MiB | 0.248 | 0.248 | x0.997 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 32 MiB | 0.250 | 0.248 | x0.990 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 64 MiB | 0.248 | 0.248 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 128 MiB | 0.248 | 0.249 | x1.003 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 1 | 735.974 | 774.098 | x1.052 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 2 | 480.472 | 474.523 | x0.988 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 3 | 313.599 | 341.515 | x1.089 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 4 | 244.893 | 258.739 | x1.057 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 6 | 182.381 | 186.961 | x1.025 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 8 | 143.606 | 150.361 | x1.047 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 12 | 113.604 | 105.280 | x0.927 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 16 | 83.559 | 80.260 | x0.961 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 24 | 59.120 | 62.352 | x1.055 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 32 | 52.037 | 51.253 | x0.985 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 48 | 38.737 | 39.762 | x1.026 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 64 | 33.962 | 34.917 | x1.028 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 128 | 28.346 | 26.675 | x0.941 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 256 | 21.371 | 21.330 | x0.998 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 512 | 19.181 | 19.608 | x1.022 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 1024 | 18.468 | 18.488 | x1.001 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 2048 | 18.254 | 18.608 | x1.019 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 4096 | 18.107 | 18.522 | x1.023 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 8192 | 17.559 | 17.860 | x1.017 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 16384 | 16.829 | 16.791 | x0.998 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 32768 | 16.024 | 15.841 | x0.989 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 65536 | 15.446 | 15.405 | x0.997 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 131072 | 15.763 | 15.590 | x0.989 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 262144 | 15.093 | 15.042 | x0.997 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / ManyLongMessages / 4 | 1782.943 | 1832.929 | x1.028 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / ManyLongMessages / 16 | 1166.600 | 1141.429 | x0.978 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / ManyLongMessages / 64 | 1137.058 | 1147.663 | x1.009 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / ManyLongMessages / 256 | 1096.077 | 1086.236 | x0.991 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 64 B | 18.878 | 15.936 | x0.844 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 128 B | 9.268 | 8.280 | x0.893 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 256 B | 5.077 | 5.151 | x1.015 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 512 B | 3.081 | 2.593 | x0.842 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 1 KiB | 1.774 | 1.649 | x0.929 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 1536 B | 2.144 | 2.095 | x0.977 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 2 KiB | 1.599 | 1.603 | x1.003 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 2304 B | 1.691 | 1.884 | x1.115 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 3 KiB | 1.394 | 1.358 | x0.974 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 1.324 | 1.231 | x0.930 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 4 KiB | 0.986 | 0.977 | x0.991 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 4470 B | 0.996 | 1.032 | x1.036 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 7935 B | 0.671 | 0.657 | x0.979 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 8 KiB | 0.592 | 0.605 | x1.021 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 16 KiB | 0.417 | 0.421 | x1.010 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 32 KiB | 0.317 | 0.333 | x1.051 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 64 KiB | 0.280 | 0.286 | x1.020 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 128 KiB | 0.255 | 0.260 | x1.021 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 256 KiB | 0.245 | 0.250 | x1.022 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 512 KiB | 0.245 | 0.243 | x0.994 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 1 MiB | 0.245 | 0.246 | x1.001 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 2 MiB | 0.247 | 0.245 | x0.992 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 3 MiB | 0.251 | 0.247 | x0.986 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 4 MiB | 0.252 | 0.255 | x1.013 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 8 MiB | 0.264 | 0.269 | x1.021 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 32 MiB | 0.248 | 0.250 | x1.006 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 64 MiB | 0.248 | 0.250 | x1.008 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 128 MiB | 0.248 | 0.249 | x1.003 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 1 | 1551.854 | 1494.739 | x0.963 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 2 | 809.273 | 948.282 | x1.172 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 3 | 550.476 | 631.607 | x1.147 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 4 | 400.469 | 451.259 | x1.127 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 6 | 279.699 | 311.238 | x1.113 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 8 | 222.324 | 239.485 | x1.077 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 12 | 153.152 | 174.897 | x1.142 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 16 | 112.534 | 133.916 | x1.190 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 24 | 79.712 | 91.659 | x1.150 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 32 | 62.718 | 69.436 | x1.107 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 48 | 45.623 | 50.172 | x1.100 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 64 | 38.288 | 43.037 | x1.124 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 128 | 27.083 | 29.872 | x1.103 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 256 | 20.555 | 21.845 | x1.063 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 512 | 17.250 | 18.549 | x1.075 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 1024 | 16.068 | 16.404 | x1.021 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 2048 | 15.663 | 15.827 | x1.010 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 4096 | 15.439 | 15.648 | x1.014 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 8192 | 15.492 | 15.539 | x1.003 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 16384 | 15.592 | 15.594 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 32768 | 15.572 | 15.474 | x0.994 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 65536 | 16.078 | 15.906 | x0.989 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 131072 | 16.395 | 16.426 | x1.002 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 262144 | 15.298 | 15.116 | x0.988 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 B | 1.194 | 1.180 | x0.988 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 B | 0.944 | 0.935 | x0.991 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 B | 0.820 | 0.819 | x0.998 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 B | 0.761 | 0.761 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 KiB | 0.735 | 0.731 | x0.994 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 1536 B | 0.571 | 0.570 | x0.998 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 KiB | 0.404 | 0.406 | x1.004 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 2304 B | 0.468 | 0.467 | x0.997 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.518 | 0.382 | x0.738 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 3839 B | 0.426 | 0.410 | x0.963 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 KiB | 0.280 | 0.281 | x1.000 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 4470 B | 0.325 | 0.326 | x1.000 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 7935 B | 0.240 | 0.237 | x0.985 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 KiB | 0.212 | 0.212 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 16 KiB | 0.213 | 0.215 | x1.007 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 KiB | 0.204 | 0.202 | x0.991 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 KiB | 0.194 | 0.194 | x0.997 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 KiB | 0.194 | 0.193 | x0.997 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 256 KiB | 0.194 | 0.193 | x0.998 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 KiB | 0.202 | 0.202 | x1.003 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 MiB | 0.219 | 0.219 | x1.002 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 2 MiB | 0.221 | 0.221 | x1.003 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 MiB | 0.220 | 0.219 | x0.998 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 MiB | 0.217 | 0.218 | x1.004 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 8 MiB | 0.223 | 0.225 | x1.008 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 32 MiB | 0.242 | 0.243 | x1.003 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 64 MiB | 0.246 | 0.247 | x1.005 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 128 MiB | 0.247 | 0.247 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 1 | 85.174 | 87.242 | x1.024 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 2 | 42.890 | 43.508 | x1.014 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 3 | 46.389 | 42.254 | x0.911 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 4 | 26.283 | 26.390 | x1.004 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 6 | 25.160 | 25.450 | x1.011 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 8 | 17.270 | 17.368 | x1.006 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 12 | 16.981 | 17.213 | x1.014 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 16 | 14.931 | 14.871 | x0.996 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 24 | 14.039 | 14.086 | x1.003 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 32 | 13.755 | 13.814 | x1.004 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 48 | 13.631 | 13.482 | x0.989 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 64 | 13.462 | 13.207 | x0.981 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 128 | 13.181 | 13.065 | x0.991 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 256 | 13.854 | 13.891 | x1.003 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 512 | 12.758 | 12.798 | x1.003 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 1024 | 12.519 | 12.341 | x0.986 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 2048 | 12.522 | 12.383 | x0.989 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 4096 | 12.596 | 12.404 | x0.985 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 8192 | 13.409 | 13.191 | x0.984 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 16384 | 14.199 | 14.068 | x0.991 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 32768 | 14.158 | 13.979 | x0.987 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 65536 | 14.247 | 14.084 | x0.989 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 131072 | 14.441 | 14.456 | x1.001 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 262144 | 14.371 | 14.355 | x0.999 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.688 | 0.696 | x1.012 | level | 0 of 4 | x1.011 | x1.033 |
| blake3-servil-st / solo / ContinuousMessages / 128 B | 0.692 | 0.684 | x0.988 | level | 4 of 4 | x0.988 | x1.000 |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 0.692 | 0.687 | x0.993 | level | 4 of 4 | x0.993 | x1.003 |
| blake3-servil-st / solo / ContinuousMessages / 512 B | 0.693 | 0.696 | x1.005 | level | 2 of 4 | x1.004 | x0.993 |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 0.697 | 0.696 | x0.999 | level | 2 of 4 | x0.998 | x1.041 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.263 | 0.262 | x0.995 | level | 4 of 4 | x0.995 | x1.000 |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.189 | 0.188 | x0.998 | level | 3 of 4 | x0.998 | x1.001 |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.194 | 0.194 | x1.001 | level | 2 of 4 | x1.001 | x0.869 |
| blake3-servil-st / solo / ContinuousMessages / 256 KiB | 0.195 | 0.196 | x1.009 | level | 0 of 4 | x1.009 | x0.950 |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.197 | 0.198 | x1.007 | level | 1 of 4 | x1.008 | x1.084 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.208 | 0.201 | x0.964 | level | 4 of 4 | x0.964 | x0.938 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.204 | 0.205 | x1.003 | level | 2 of 4 | x1.003 | x1.000 |
| blake3-servil-st / solo / ContinuousMessages / 64 MiB | 0.226 | 0.223 | x0.988 | level | 3 of 4 | x0.988 | x0.977 |
| blake3-servil-st / solo / ContinuousBatches / 16 | 12.945 | 12.974 | x1.002 | level | 1 of 4 | x1.002 | x1.020 |
| blake3-servil-st / solo / ContinuousBatches / 64 | 12.198 | 12.164 | x0.997 | level | 3 of 4 | x0.997 | x0.932 |
| blake3-servil-st / solo / ContinuousBatches / 256 | 12.422 | 12.487 | x1.005 | level | 2 of 4 | x1.004 | x1.043 |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 12.932 | 12.968 | x1.003 | level | 3 of 4 | x1.002 | x1.155 |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 12.848 | 12.846 | x1.000 | level | 1 of 4 | x1.000 | x0.989 |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 13.883 | 13.942 | x1.004 | level | 1 of 4 | x1.004 | x1.070 |
| blake3-servil-st / solo / ContinuousBatches / 65536 | 14.062 | 14.095 | x1.002 | level | 0 of 4 | x1.002 | x0.950 |
| blake3-servil-st / solo / LentMessages / 64 B | 0.688 | 0.696 | x1.012 | level | 0 of 4 | x1.011 | x1.033 |
| blake3-servil-st / solo / LentMessages / 128 B | 0.692 | 0.684 | x0.988 | level | 4 of 4 | x0.988 | x1.000 |
| blake3-servil-st / solo / LentMessages / 256 B | 0.692 | 0.687 | x0.993 | level | 4 of 4 | x0.993 | x1.003 |
| blake3-servil-st / solo / LentMessages / 512 B | 0.693 | 0.696 | x1.005 | level | 2 of 4 | x1.004 | x0.993 |
| blake3-servil-st / solo / LentMessages / 1 KiB | 0.697 | 0.696 | x0.999 | level | 2 of 4 | x0.998 | x1.041 |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.263 | 0.262 | x0.995 | level | 4 of 4 | x0.995 | x1.000 |
| blake3-servil-st / solo / LentMessages / 16 KiB | 0.189 | 0.188 | x0.998 | level | 3 of 4 | x0.998 | x1.001 |
| blake3-servil-st / solo / LentMessages / 64 KiB | 0.194 | 0.194 | x1.001 | level | 2 of 4 | x1.001 | x0.869 |
| blake3-servil-st / solo / LentMessages / 256 KiB | 0.193 | 0.195 | x1.006 | level | 1 of 4 | x1.006 | x1.056 |
| blake3-servil-st / solo / LentMessages / 1 MiB | 0.207 | 0.209 | x1.010 | level | 0 of 4 | x1.010 | x1.064 |
| blake3-servil-st / solo / LentMessages / 4 MiB | 0.211 | 0.212 | x1.004 | level | 2 of 4 | x1.004 | x0.976 |
| blake3-servil-st / solo / LentMessages / 16 MiB | 0.235 | 0.231 | x0.980 | level | 3 of 4 | x0.980 | x0.964 |
| blake3-servil-st / solo / LentMessages / 64 MiB | 0.251 | 0.249 | x0.990 | level | 3 of 4 | x0.991 | x0.982 |
| blake3-servil-st / solo / Interleaved / 256 | 0.236 | 0.234 | x0.988 | level | 3 of 4 | x0.988 | x0.989 |
| blake3-servil-st / solo / Collection / git objects | 0.207 | 0.204 | x0.987 | level | 4 of 4 | x0.987 | x0.998 |
| blake3-servil-st / solo / Collection / Nix files | 0.206 | 0.205 | x0.992 | level | 3 of 4 | x0.992 | x0.997 |
| blake3-servil-st / solo / LentBatches / 16 | 12.945 | 12.974 | x1.002 | level | 1 of 4 | x1.002 | x1.020 |
| blake3-servil-st / solo / LentBatches / 64 | 12.198 | 12.164 | x0.997 | level | 3 of 4 | x0.997 | x0.932 |
| blake3-servil-st / solo / LentBatches / 256 | 12.422 | 12.487 | x1.005 | level | 2 of 4 | x1.004 | x1.043 |
| blake3-servil-st / solo / LentBatches / 1024 | 12.932 | 12.968 | x1.003 | level | 3 of 4 | x1.002 | x1.155 |
| blake3-servil-st / solo / LentBatches / 4096 | 12.848 | 12.846 | x1.000 | level | 1 of 4 | x1.000 | x0.989 |
| blake3-servil-st / solo / LentBatches / 16384 | 13.883 | 13.942 | x1.004 | level | 1 of 4 | x1.004 | x1.070 |
| blake3-servil-st / solo / LentBatches / 65536 | 14.062 | 14.095 | x1.002 | level | 0 of 4 | x1.002 | x0.950 |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.235 | 0.229 | x0.975 | level | 3 of 4 | x0.975 | x0.980 |
| blake3-servil-st / solo / ContinuousCollection / Nix files | 0.243 | 0.241 | x0.991 | level | 3 of 4 | x0.991 | x0.980 |
| blake3-servil-st / solo / MerkleTree / 1024 | 0.234 | 0.232 | x0.995 | level | 3 of 4 | x0.995 | x0.849 |
| blake3-servil-st / solo / MerkleTree / 4096 | 0.251 | 0.252 | x1.005 | level | 2 of 4 | x1.005 | x0.968 |
| blake3-servil-st / solo / MerkleTree / 16384 | 0.255 | 0.254 | x0.994 | level | 3 of 4 | x0.994 | x0.951 |
| blake3-servil-st / solo / MerkleTree / 65536 | 0.290 | 0.290 | x1.001 | level | 3 of 4 | x1.001 | x1.017 |
| blake3-servil-st / solo / MerkleTree / 262144 | 0.306 | 0.305 | x0.995 | level | 3 of 4 | x0.995 | x0.979 |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.398 | 0.405 | x1.018 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.389 | 0.377 | x0.970 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.312 | 0.310 | x0.994 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 64 B | 13.150 | 13.403 | x1.019 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 128 B | 7.639 | 7.980 | x1.045 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 256 B | 4.413 | 4.388 | x0.994 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 512 B | 2.776 | 2.740 | x0.987 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 1 KiB | 1.816 | 1.838 | x1.012 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 1536 B | 1.799 | 1.840 | x1.023 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 2 KiB | 1.229 | 1.181 | x0.961 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 2304 B | 1.292 | 1.333 | x1.031 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 3 KiB | 1.101 | 1.008 | x0.915 | level | 4 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 3839 B | 1.083 | 0.982 | x0.907 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 0.710 | 0.750 | x1.056 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 4470 B | 0.794 | 0.839 | x1.056 | level | 0 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 7935 B | 0.548 | 0.551 | x1.005 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 8 KiB | 0.483 | 0.486 | x1.005 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 16 KiB | 0.355 | 0.355 | x1.001 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 32 KiB | 0.314 | 0.325 | x1.033 | level | 0 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 64 KiB | 0.302 | 0.294 | x0.974 | level | 4 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 128 KiB | 0.297 | 0.289 | x0.973 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 256 KiB | 0.288 | 0.286 | x0.993 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 512 KiB | 0.238 | 0.234 | x0.987 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 1 MiB | 0.162 | 0.159 | x0.982 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 2 MiB | 0.118 | 0.117 | x0.993 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 3 MiB | 0.106 | 0.104 | x0.982 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 4 MiB | 0.0990 | 0.0980 | x0.990 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 8 MiB | 0.0915 | 0.0909 | x0.993 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 32 MiB | 0.0775 | 0.0773 | x0.997 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 64 MiB | 0.0759 | 0.0757 | x0.997 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 128 MiB | 0.0760 | 0.0753 | x0.991 | level | 4 of 4 | - | - |
| blake3-servil-mt / solo / ManyMessages / 1 | 787.387 | 816.930 | x1.038 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / ManyMessages / 2 | 466.028 | 474.193 | x1.018 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / ManyMessages / 3 | 310.234 | 344.203 | x1.109 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / ManyMessages / 4 | 254.374 | 257.746 | x1.013 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / ManyMessages / 6 | 185.753 | 189.530 | x1.020 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / ManyMessages / 8 | 143.397 | 150.636 | x1.050 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / ManyMessages / 12 | 101.855 | 110.344 | x1.083 | level | 0 of 4 | - | - |
| blake3-servil-mt / solo / ManyMessages / 16 | 83.548 | 81.528 | x0.976 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / ManyMessages / 24 | 61.761 | 66.300 | x1.073 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / ManyMessages / 32 | 48.610 | 54.373 | x1.119 | level | 0 of 4 | - | - |
| blake3-servil-mt / solo / ManyMessages / 48 | 41.537 | 39.675 | x0.955 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / ManyMessages / 64 | 34.513 | 38.464 | x1.114 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / ManyMessages / 128 | 26.469 | 26.140 | x0.988 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / ManyMessages / 256 | 21.113 | 21.092 | x0.999 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / ManyMessages / 512 | 19.189 | 19.520 | x1.017 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / ManyMessages / 1024 | 18.486 | 18.553 | x1.004 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / ManyMessages / 2048 | 18.106 | 18.389 | x1.016 | level | 0 of 4 | - | - |
| blake3-servil-mt / solo / ManyMessages / 4096 | 18.445 | 18.348 | x0.995 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / ManyMessages / 8192 | 14.651 | 14.789 | x1.009 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / ManyMessages / 16384 | 9.897 | 9.746 | x0.985 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / ManyMessages / 32768 | 7.577 | 7.404 | x0.977 | level | 4 of 4 | - | - |
| blake3-servil-mt / solo / ManyMessages / 65536 | 6.326 | 6.300 | x0.996 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / ManyMessages / 131072 | 5.985 | 5.934 | x0.992 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / ManyMessages / 262144 | 5.560 | 5.506 | x0.990 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / ManyLongMessages / 4 | 1806.566 | 1834.355 | x1.015 | level | 0 of 4 | - | - |
| blake3-servil-mt / solo / ManyLongMessages / 16 | 1154.696 | 1150.231 | x0.996 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / ManyLongMessages / 64 | 1135.577 | 1139.290 | x1.003 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / ManyLongMessages / 256 | 675.716 | 661.829 | x0.979 | level | 4 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 64 B | 20.365 | 19.996 | x0.982 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 128 B | 10.687 | 10.468 | x0.980 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 256 B | 5.625 | 5.550 | x0.987 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 512 B | 3.177 | 3.060 | x0.963 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 1 KiB | 1.873 | 1.996 | x1.066 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 1536 B | 2.202 | 2.216 | x1.006 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 2 KiB | 1.798 | 1.717 | x0.955 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 2304 B | 1.796 | 1.921 | x1.070 | level | 0 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 3 KiB | 1.408 | 1.356 | x0.963 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 3839 B | 1.338 | 1.322 | x0.988 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 4 KiB | 0.981 | 1.035 | x1.055 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 4470 B | 1.057 | 1.084 | x1.025 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 7935 B | 0.689 | 0.703 | x1.021 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 8 KiB | 0.600 | 0.636 | x1.060 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 16 KiB | 0.400 | 0.443 | x1.106 | level | 0 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 32 KiB | 0.320 | 0.344 | x1.076 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 64 KiB | 0.278 | 0.291 | x1.045 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 128 KiB | 0.255 | 0.268 | x1.050 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 256 KiB | 0.243 | 0.254 | x1.045 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 512 KiB | 0.247 | 0.245 | x0.991 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 1 MiB | 0.170 | 0.166 | x0.975 | level | 4 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 2 MiB | 0.128 | 0.126 | x0.983 | level | 4 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 3 MiB | 0.115 | 0.116 | x1.005 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 4 MiB | 0.111 | 0.109 | x0.981 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 8 MiB | 0.108 | 0.109 | x1.007 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 32 MiB | 0.0776 | 0.0781 | x1.007 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 64 MiB | 0.0764 | 0.0764 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 128 MiB | 0.0758 | 0.0754 | x0.996 | level | 4 of 4 | - | - |
| blake3-servil-mt / solo / IdleManyMessages / 1 | 1471.227 | 1604.194 | x1.090 | level | 0 of 4 | - | - |
| blake3-servil-mt / solo / IdleManyMessages / 2 | 813.386 | 934.050 | x1.148 | level | 0 of 4 | - | - |
| blake3-servil-mt / solo / IdleManyMessages / 3 | 568.531 | 643.131 | x1.131 | level | 0 of 4 | - | - |
| blake3-servil-mt / solo / IdleManyMessages / 4 | 404.096 | 474.022 | x1.173 | level | 0 of 4 | - | - |
| blake3-servil-mt / solo / IdleManyMessages / 6 | 274.375 | 327.828 | x1.195 | level | 0 of 4 | - | - |
| blake3-servil-mt / solo / IdleManyMessages / 8 | 215.725 | 255.389 | x1.184 | level | 0 of 4 | - | - |
| blake3-servil-mt / solo / IdleManyMessages / 12 | 152.457 | 177.971 | x1.167 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / IdleManyMessages / 16 | 114.707 | 129.092 | x1.125 | level | 0 of 4 | - | - |
| blake3-servil-mt / solo / IdleManyMessages / 24 | 77.180 | 92.308 | x1.196 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / IdleManyMessages / 32 | 62.212 | 75.365 | x1.211 | level | 0 of 4 | - | - |
| blake3-servil-mt / solo / IdleManyMessages / 48 | 46.115 | 50.930 | x1.104 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / IdleManyMessages / 64 | 39.320 | 41.610 | x1.058 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / IdleManyMessages / 128 | 27.003 | 28.307 | x1.048 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / IdleManyMessages / 256 | 23.321 | 22.323 | x0.957 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / IdleManyMessages / 512 | 17.416 | 18.334 | x1.053 | level | 0 of 4 | - | - |
| blake3-servil-mt / solo / IdleManyMessages / 1024 | 16.276 | 16.747 | x1.029 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / IdleManyMessages / 2048 | 15.642 | 15.886 | x1.016 | level | 0 of 4 | - | - |
| blake3-servil-mt / solo / IdleManyMessages / 4096 | 15.368 | 15.781 | x1.027 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / IdleManyMessages / 8192 | 15.507 | 15.065 | x0.971 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / IdleManyMessages / 16384 | 10.653 | 10.421 | x0.978 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / IdleManyMessages / 32768 | 8.028 | 7.815 | x0.973 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / IdleManyMessages / 65536 | 6.950 | 6.980 | x1.004 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / IdleManyMessages / 131072 | 6.899 | 6.814 | x0.988 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / IdleManyMessages / 262144 | 5.881 | 5.844 | x0.994 | level | 4 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 B | 1.230 | 1.215 | x0.987 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 B | 0.961 | 0.953 | x0.992 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 B | 0.824 | 0.823 | x0.999 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 B | 0.778 | 0.766 | x0.986 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 KiB | 0.737 | 0.736 | x0.999 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1536 B | 0.577 | 0.572 | x0.991 | level | 4 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 KiB | 0.405 | 0.405 | x1.002 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2304 B | 0.469 | 0.473 | x1.006 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 KiB | 0.518 | 0.378 | x0.731 | faster | 4 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3839 B | 0.421 | 0.411 | x0.977 | level | 4 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 KiB | 0.279 | 0.280 | x1.003 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4470 B | 0.326 | 0.328 | x1.007 | level | 0 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 7935 B | 0.241 | 0.238 | x0.987 | level | 4 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 KiB | 0.210 | 0.210 | x1.001 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 16 KiB | 0.217 | 0.217 | x0.997 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 KiB | 0.199 | 0.201 | x1.007 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 KiB | 0.194 | 0.194 | x0.999 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 KiB | 0.194 | 0.194 | x0.998 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 256 KiB | 0.194 | 0.193 | x0.995 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 512 KiB | 0.151 | 0.152 | x1.008 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 1 MiB | 0.0920 | 0.0897 | x0.975 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 2 MiB | 0.0860 | 0.0857 | x0.996 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 3 MiB | 0.0765 | 0.0758 | x0.990 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 4 MiB | 0.0728 | 0.0731 | x1.003 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 8 MiB | 0.0712 | 0.0704 | x0.988 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 32 MiB | 0.0725 | 0.0727 | x1.004 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 64 MiB | 0.0742 | 0.0751 | x1.012 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleOneMessage / 128 MiB | 0.0751 | 0.0752 | x1.002 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1 | 87.369 | 88.791 | x1.016 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2 | 43.280 | 44.123 | x1.019 | level | 0 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 3 | 42.312 | 43.073 | x1.018 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4 | 26.745 | 26.975 | x1.009 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 6 | 25.526 | 25.472 | x0.998 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8 | 17.440 | 17.557 | x1.007 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 12 | 17.065 | 17.167 | x1.006 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16 | 14.966 | 15.033 | x1.004 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 24 | 14.143 | 14.220 | x1.005 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32 | 13.719 | 13.788 | x1.005 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 48 | 13.710 | 13.502 | x0.985 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 64 | 13.381 | 13.305 | x0.994 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 128 | 13.229 | 13.012 | x0.984 | level | 4 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 256 | 13.647 | 13.818 | x1.013 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 512 | 12.926 | 12.712 | x0.984 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 1024 | 12.520 | 12.354 | x0.987 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 2048 | 12.508 | 12.383 | x0.990 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 4096 | 12.590 | 12.395 | x0.984 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 8192 | 9.782 | 10.283 | x1.051 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 16384 | 7.062 | 7.003 | x0.992 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 32768 | 5.455 | 5.429 | x0.995 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 65536 | 4.787 | 4.806 | x1.004 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 131072 | 4.786 | 4.790 | x1.001 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleManyMessages / 262144 | 5.087 | 5.057 | x0.994 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.270 | 0.273 | x1.013 | level | 1 of 4 | x1.008 | x1.006 |
| blake3-servil-mt / solo / ContinuousMessages / 128 B | 0.149 | 0.159 | x1.064 | level | 1 of 4 | x1.026 | x1.116 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.0887 | 0.0882 | x0.995 | level | 2 of 4 | x1.018 | x1.030 |
| blake3-servil-mt / solo / ContinuousMessages / 512 B | 0.0671 | 0.0668 | x0.995 | level | 2 of 4 | x1.015 | x1.023 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.0662 | 0.0651 | x0.983 | level | 3 of 4 | x0.994 | x0.921 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0522 | 0.0518 | x0.991 | level | 3 of 4 | x1.015 | x0.933 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0459 | 0.0457 | x0.997 | level | 2 of 4 | x1.046 | x0.955 |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.0384 | 0.0400 | x1.041 | level | 2 of 4 | x0.937 | x0.977 |
| blake3-servil-mt / solo / ContinuousMessages / 256 KiB | 0.0392 | 0.0393 | x1.002 | level | 3 of 4 | x0.995 | x0.942 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0406 | 0.0414 | x1.019 | level | 1 of 4 | x1.037 | x1.029 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.0458 | 0.0437 | x0.954 | level | 4 of 4 | x1.003 | x0.926 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0497 | 0.0502 | x1.010 | level | 3 of 4 | x1.012 | x0.955 |
| blake3-servil-mt / solo / ContinuousMessages / 64 MiB | 0.0635 | 0.0626 | x0.987 | level | 3 of 4 | x1.008 | x1.017 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 4.075 | 4.067 | x0.998 | level | 2 of 4 | x1.007 | x1.016 |
| blake3-servil-mt / solo / ContinuousBatches / 64 | 3.871 | 3.858 | x0.997 | level | 2 of 4 | x1.004 | x1.010 |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 3.551 | 3.627 | x1.021 | level | 0 of 4 | x0.972 | x0.995 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 3.595 | 3.652 | x1.016 | level | 1 of 4 | x1.002 | x0.978 |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 3.656 | 3.673 | x1.005 | level | 2 of 4 | x0.976 | x0.959 |
| blake3-servil-mt / solo / ContinuousBatches / 16384 | 4.035 | 3.930 | x0.974 | level | 2 of 4 | x0.952 | x0.936 |
| blake3-servil-mt / solo / ContinuousBatches / 65536 | 3.957 | 3.980 | x1.006 | level | 1 of 4 | x1.007 | x0.989 |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.700 | 0.698 | x0.997 | level | 1 of 4 | x0.998 | x0.998 |
| blake3-servil-mt / solo / LentMessages / 128 B | 0.693 | 0.691 | x0.997 | level | 3 of 4 | x0.997 | x1.103 |
| blake3-servil-mt / solo / LentMessages / 256 B | 0.693 | 0.687 | x0.992 | level | 4 of 4 | x0.992 | x0.961 |
| blake3-servil-mt / solo / LentMessages / 512 B | 0.690 | 0.693 | x1.005 | level | 1 of 4 | x1.005 | x1.115 |
| blake3-servil-mt / solo / LentMessages / 1 KiB | 0.693 | 0.691 | x0.996 | level | 3 of 4 | x0.997 | x0.975 |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.262 | 0.263 | x1.003 | level | 2 of 4 | x1.003 | x1.079 |
| blake3-servil-mt / solo / LentMessages / 16 KiB | 0.188 | 0.189 | x1.004 | level | 2 of 4 | x1.003 | x0.987 |
| blake3-servil-mt / solo / LentMessages / 64 KiB | 0.194 | 0.194 | x1.002 | level | 2 of 4 | x1.002 | x1.043 |
| blake3-servil-mt / solo / LentMessages / 256 KiB | 0.193 | 0.194 | x1.003 | level | 1 of 4 | x1.003 | x0.974 |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.0665 | 0.0659 | x0.990 | level | 4 of 4 | x0.998 | x1.014 |
| blake3-servil-mt / solo / LentMessages / 4 MiB | 0.0627 | 0.0621 | x0.990 | level | 3 of 4 | x0.992 | x1.027 |
| blake3-servil-mt / solo / LentMessages / 16 MiB | 0.0683 | 0.0682 | x0.998 | level | 2 of 4 | x1.006 | x1.002 |
| blake3-servil-mt / solo / LentMessages / 64 MiB | 0.0740 | 0.0744 | x1.005 | level | 0 of 4 | x1.001 | x0.996 |
| blake3-servil-mt / solo / Interleaved / 256 | 0.235 | 0.233 | x0.991 | level | 3 of 4 | x0.991 | x0.984 |
| blake3-servil-mt / solo / Collection / git objects | 0.0230 | 0.0228 | x0.992 | level | 3 of 4 | x1.002 | x1.025 |
| blake3-servil-mt / solo / Collection / Nix files | 0.0263 | 0.0263 | x0.997 | level | 2 of 4 | x0.993 | x0.954 |
| blake3-servil-mt / solo / LentBatches / 16 | 12.921 | 13.029 | x1.008 | level | 2 of 4 | x1.008 | x1.057 |
| blake3-servil-mt / solo / LentBatches / 64 | 12.195 | 12.227 | x1.003 | level | 1 of 4 | x1.003 | x0.985 |
| blake3-servil-mt / solo / LentBatches / 256 | 12.403 | 12.401 | x1.000 | level | 1 of 4 | x1.000 | x0.956 |
| blake3-servil-mt / solo / LentBatches / 1024 | 12.912 | 12.898 | x0.999 | level | 2 of 4 | x0.999 | x0.991 |
| blake3-servil-mt / solo / LentBatches / 4096 | 12.899 | 12.861 | x0.997 | level | 2 of 4 | x0.997 | x0.847 |
| blake3-servil-mt / solo / LentBatches / 16384 | 5.335 | 5.323 | x0.998 | level | 3 of 4 | x0.997 | x0.956 |
| blake3-servil-mt / solo / LentBatches / 65536 | 5.199 | 5.171 | x0.995 | level | 3 of 4 | x1.000 | x0.993 |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.0628 | 0.0657 | x1.047 | level | 1 of 4 | x1.025 | x1.044 |
| blake3-servil-mt / solo / ContinuousCollection / Nix files | 0.0632 | 0.0619 | x0.980 | level | 2 of 4 | x0.992 | x0.973 |
| blake3-servil-mt / solo / MerkleTree / 1024 | 0.232 | 0.232 | x1.000 | level | 2 of 4 | x1.000 | x1.019 |
| blake3-servil-mt / solo / MerkleTree / 4096 | 0.123 | 0.122 | x0.991 | level | 3 of 4 | x1.000 | x0.961 |
| blake3-servil-mt / solo / MerkleTree / 16384 | 0.101 | 0.109 | x1.077 | level | 1 of 4 | x1.019 | x1.119 |
| blake3-servil-mt / solo / MerkleTree / 65536 | 0.0927 | 0.0928 | x1.000 | level | 1 of 4 | x1.003 | x1.002 |
| blake3-servil-mt / solo / MerkleTree / 262144 | 0.109 | 0.109 | x1.002 | level | 1 of 4 | x0.995 | x1.006 |
| blake3-servil-mt / solo / InterleavedTurn / 256 | 0.401 | 0.395 | x0.984 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / IdleInterleavedTurn / 256 | 0.392 | 0.380 | x0.969 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / BriefIdleInterleavedTurn / 256 | 0.307 | 0.305 | x0.992 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.284 | 0.289 | x1.019 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 128 B | 0.163 | 0.166 | x1.015 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.107 | 0.107 | x1.006 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 512 B | 0.0811 | 0.0810 | x0.999 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.0704 | 0.0696 | x0.988 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.0614 | 0.0614 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.0515 | 0.0507 | x0.985 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.0452 | 0.0435 | x0.962 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 KiB | 0.0446 | 0.0441 | x0.988 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0478 | 0.0485 | x1.016 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.0514 | 0.0684 | x1.331 | slower | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.0619 | 0.0805 | x1.299 | slower | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 MiB | 0.0716 | 0.0825 | x1.152 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 4.957 | 4.898 | x0.988 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 64 | 4.270 | 4.297 | x1.006 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 256 | 3.913 | 3.899 | x0.996 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 3.989 | 3.979 | x0.997 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 4096 | 4.003 | 3.975 | x0.993 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16384 | 4.228 | 4.211 | x0.996 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 65536 | 4.518 | 4.508 | x0.998 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.726 | 0.706 | x0.973 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 128 B | 0.702 | 0.701 | x0.999 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 B | 0.701 | 0.699 | x0.997 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 512 B | 0.704 | 0.701 | x0.995 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 KiB | 0.701 | 0.703 | x1.002 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.265 | 0.266 | x1.003 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 KiB | 0.189 | 0.189 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 KiB | 0.197 | 0.199 | x1.010 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 256 KiB | 0.196 | 0.197 | x1.004 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 MiB | 0.0720 | 0.0723 | x1.005 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 MiB | 0.0682 | 0.0676 | x0.992 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 MiB | 0.132 | 0.132 | x1.000 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 MiB | 0.144 | 0.143 | x0.999 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / Interleaved / 256 | 0.244 | 0.238 | x0.977 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / Collection / git objects | 0.0456 | 0.0458 | x1.004 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / Collection / Nix files | 0.0464 | 0.0460 | x0.993 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentBatches / 16 | 13.185 | 13.140 | x0.997 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentBatches / 64 | 12.384 | 12.376 | x0.999 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentBatches / 256 | 12.545 | 12.597 | x1.004 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentBatches / 1024 | 13.067 | 13.081 | x1.001 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentBatches / 4096 | 13.075 | 13.082 | x1.001 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentBatches / 16384 | 5.781 | 5.809 | x1.005 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentBatches / 65536 | 5.701 | 5.664 | x0.994 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.0775 | 0.0756 | x0.975 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / Nix files | 0.0764 | 0.0706 | x0.924 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / MerkleTree / 1024 | 0.236 | 0.236 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / MerkleTree / 4096 | 0.130 | 0.130 | x1.001 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / MerkleTree / 16384 | 0.117 | 0.115 | x0.988 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / MerkleTree / 65536 | 0.157 | 0.154 | x0.986 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / MerkleTree / 262144 | 0.203 | 0.201 | x0.993 | level | 3 of 4 | - | - |

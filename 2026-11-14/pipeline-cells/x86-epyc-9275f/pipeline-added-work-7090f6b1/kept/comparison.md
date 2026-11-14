compare: old side: bench 55436819e59a clean; servil f62bc6ac0bc1 clean
compare: new side: bench 7090f6b14bd7 clean; servil f62bc6ac0bc1 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 1.256 | 1.442 | x1.148 | level | 0 of 4 | x1.143 | - |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.141 | 0.167 | x1.185 | level | 0 of 4 | x1.049 | - |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.112 | 0.124 | x1.104 | level | 0 of 4 | x1.103 | - |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.106 | 0.116 | x1.095 | level | 0 of 4 | x1.042 | - |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 12.138 | 12.366 | x1.019 | level | 0 of 4 | x1.001 | - |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 9.473 | 9.501 | x1.003 | level | 1 of 4 | x0.989 | - |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 7.174 | 7.759 | x1.082 | level | 1 of 4 | x1.030 | - |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.842 | 0.843 | x1.001 | level | 1 of 4 | x1.001 | - |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.321 | 0.321 | x0.999 | level | 3 of 4 | x0.998 | - |
| blake3-servil-mt / solo / LentMessages / 64 KiB | 0.0726 | 0.0725 | x0.999 | level | 2 of 4 | x0.998 | - |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.104 | 0.102 | x0.979 | level | 3 of 4 | x0.992 | - |
| blake3-servil-mt / solo / LentBatches / 16 | 6.764 | 6.766 | x1.000 | level | 2 of 4 | x1.000 | - |
| blake3-servil-mt / solo / LentBatches / 256 | 5.799 | 5.792 | x0.999 | level | 1 of 4 | x0.999 | - |
| blake3-servil-mt / solo / LentBatches / 4096 | 6.075 | 6.115 | x1.006 | level | 1 of 4 | x1.007 | - |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.116 | 0.126 | x1.084 | level | 0 of 4 | x1.029 | - |
| blake3-servil-mt / solo / ContinuousCollection / Nix files | 0.111 | 0.121 | x1.093 | level | 0 of 4 | x1.028 | - |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.115 | 0.112 | x0.974 | level | 3 of 4 | x0.972 | - |
| blake3-servil-mt / solo / ReceivingMessage / 2 μs | 0.112 | 0.109 | x0.974 | level | 3 of 4 | x0.951 | - |
| blake3-servil-mt / solo / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 3 of 4 | x1.058 | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.919 | 1.243 | x1.352 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.144 | 0.175 | x1.212 | slower | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.125 | 0.128 | x1.026 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.121 | 0.128 | x1.052 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 10.819 | 11.905 | x1.100 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 256 | 9.347 | 9.999 | x1.070 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 4096 | 8.637 | 9.116 | x1.055 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.840 | 0.840 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.320 | 0.320 | x1.000 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 KiB | 0.0726 | 0.0726 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 MiB | 0.132 | 0.138 | x1.044 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentBatches / 16 | 6.762 | 6.755 | x0.999 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentBatches / 256 | 5.842 | 5.844 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentBatches / 4096 | 6.125 | 6.113 | x0.998 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.123 | 0.142 | x1.155 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / Nix files | 0.122 | 0.139 | x1.140 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.128 | 0.127 | x0.986 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 2 μs | 0.125 | 0.128 | x1.022 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 B | 1.124 | 1.283 | x1.142 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 4 KiB | 0.132 | 0.164 | x1.242 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 KiB | 0.102 | 0.109 | x1.075 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 MiB | 0.0912 | 0.104 | x1.142 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 16 | 10.786 | 11.507 | x1.067 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 256 | 8.417 | 9.135 | x1.085 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 4096 | 7.625 | 7.651 | x1.003 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 B | 0.843 | 0.842 | x0.998 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 KiB | 0.321 | 0.321 | x1.000 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 KiB | 0.0727 | 0.0726 | x0.999 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentMessages / 1 MiB | 0.105 | 0.109 | x1.030 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentBatches / 16 | 6.779 | 6.765 | x0.998 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentBatches / 256 | 5.851 | 5.856 | x1.001 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentBatches / 4096 | 6.250 | 6.236 | x0.998 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / git objects | 0.100 | 0.112 | x1.118 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / Nix files | 0.0996 | 0.107 | x1.070 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / saturated | 0.111 | 0.108 | x0.974 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / 2 μs | 0.111 | 0.112 | x1.008 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 3 of 4 | - | - |

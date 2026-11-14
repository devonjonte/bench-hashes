compare: old side: bench 8d9eb92ada88 clean; servil f62bc6ac0bc1 clean
compare: new side: bench 2c8676842fea clean; servil f62bc6ac0bc1 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 5.296 | 4.439 | x0.838 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.692 | 0.681 | x0.984 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.0790 | 0.0750 | x0.950 | level | 4 of 4 | x0.950 | - |
| blake3-servil-st / solo / LentMessages / 64 B | 0.842 | 0.842 | x1.000 | level | 1 of 4 | x1.000 | - |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.321 | 0.322 | x1.002 | level | 1 of 4 | x1.002 | - |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.123 | 0.123 | x0.997 | level | 2 of 4 | x0.997 | - |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.163 | 0.163 | x1.000 | level | 1 of 4 | x1.000 | - |
| blake3-servil-mt / solo / OneMessage / 64 B | 5.770 | 4.977 | x0.863 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 0.696 | 0.712 | x1.022 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.105 | 0.101 | x0.959 | level | 3 of 4 | x0.978 | - |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.842 | 0.843 | x1.001 | level | 1 of 4 | x1.002 | - |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.321 | 0.321 | x1.001 | level | 1 of 4 | x1.000 | - |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.102 | 0.109 | x1.067 | level | 2 of 4 | x1.028 | - |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.111 | 0.110 | x0.997 | level | 3 of 4 | x0.986 | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.118 | 0.111 | x0.947 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.840 | 0.840 | x0.999 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.320 | 0.320 | x1.001 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.129 | 0.124 | x0.962 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.122 | 0.117 | x0.960 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 MiB | 0.0992 | 0.101 | x1.019 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 B | 0.842 | 0.842 | x1.000 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 KiB | 0.321 | 0.321 | x1.000 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / git objects | 0.101 | 0.110 | x1.097 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / saturated | 0.107 | 0.111 | x1.033 | level | 1 of 4 | - | - |

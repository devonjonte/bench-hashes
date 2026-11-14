compare: old side: bench 2c8676842fea clean; servil f62bc6ac0bc1 clean
compare: new side: bench 2c8676842fea clean; servil f62bc6ac0bc1 clean
compare: both sides are one build: an A/A comparison
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 4.909 | 4.512 | x0.919 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.669 | 0.653 | x0.976 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.0765 | 0.0750 | x0.981 | level | 4 of 4 | x0.980 | - |
| blake3-servil-st / solo / LentMessages / 64 B | 0.842 | 0.843 | x1.001 | level | 2 of 4 | x1.001 | - |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.321 | 0.321 | x1.001 | level | 0 of 4 | x1.001 | - |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.123 | 0.124 | x1.012 | level | 0 of 4 | x1.012 | - |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.163 | 0.163 | x1.003 | level | 1 of 4 | x1.002 | - |
| blake3-servil-mt / solo / OneMessage / 64 B | 5.526 | 5.106 | x0.924 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 0.686 | 0.683 | x0.995 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.105 | 0.103 | x0.984 | level | 2 of 4 | x0.987 | - |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.841 | 0.843 | x1.002 | level | 2 of 4 | x1.002 | - |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.321 | 0.321 | x0.999 | level | 3 of 4 | x0.999 | - |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.115 | 0.110 | x0.958 | level | 2 of 4 | x0.981 | - |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.113 | 0.112 | x0.984 | level | 4 of 4 | x0.982 | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0910 | 0.106 | x1.167 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.840 | 0.841 | x1.001 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.320 | 0.320 | x1.000 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.105 | 0.120 | x1.141 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.113 | 0.120 | x1.057 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 MiB | 0.0869 | 0.0895 | x1.029 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 B | 0.841 | 0.842 | x1.001 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 KiB | 0.321 | 0.321 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / git objects | 0.0949 | 0.0958 | x1.009 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / saturated | 0.101 | 0.105 | x1.034 | level | 3 of 4 | - | - |

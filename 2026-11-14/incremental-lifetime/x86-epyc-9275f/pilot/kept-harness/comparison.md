compare: old side: bench 8d9eb92ada88 clean; servil f62bc6ac0bc1 clean
compare: new side: bench 2c8676842fea clean; servil f62bc6ac0bc1 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 4.509 | 4.513 | x1.001 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.665 | 0.676 | x1.016 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.0786 | 0.0752 | x0.958 | level | 4 of 4 | x0.958 | - |
| blake3-servil-st / solo / LentMessages / 64 B | 0.843 | 0.842 | x0.999 | level | 2 of 4 | x0.999 | - |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.321 | 0.321 | x1.000 | level | 2 of 4 | x1.000 | - |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.123 | 0.123 | x1.000 | level | 2 of 4 | x1.000 | - |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.163 | 0.162 | x0.998 | level | 3 of 4 | x0.997 | - |
| blake3-servil-mt / solo / OneMessage / 64 B | 4.762 | 4.851 | x1.019 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 0.686 | 0.675 | x0.983 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.105 | 0.104 | x0.990 | level | 3 of 4 | x0.987 | - |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.842 | 0.841 | x0.998 | level | 3 of 4 | x0.998 | - |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.324 | 0.321 | x0.992 | level | 3 of 4 | x0.993 | - |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.115 | 0.111 | x0.961 | level | 3 of 4 | x0.986 | - |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.111 | 0.110 | x0.987 | level | 3 of 4 | x0.972 | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.104 | 0.123 | x1.182 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.840 | 0.840 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.320 | 0.320 | x1.000 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.109 | 0.134 | x1.231 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.110 | 0.128 | x1.159 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 MiB | 0.0848 | 0.0968 | x1.141 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 B | 0.842 | 0.842 | x1.000 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 KiB | 0.321 | 0.321 | x1.001 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / git objects | 0.0922 | 0.0982 | x1.066 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / saturated | 0.0987 | 0.107 | x1.086 | level | 1 of 4 | - | - |

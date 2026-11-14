compare: old side: bench 8d9eb92ada88 clean; servil f62bc6ac0bc1 clean
compare: new side: bench 2c8676842fea clean; servil f62bc6ac0bc1 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 5.378 | 5.369 | x0.998 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.613 | 0.583 | x0.951 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.199 | 0.198 | x0.999 | level | 3 of 4 | x0.998 | - |
| blake3-servil-st / solo / LentMessages / 64 B | 0.702 | 0.703 | x1.002 | level | 2 of 4 | x1.002 | - |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.290 | 0.290 | x1.000 | level | 2 of 4 | x1.000 | - |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.212 | 0.212 | x1.001 | level | 1 of 4 | x1.001 | - |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.266 | 0.264 | x0.996 | level | 3 of 4 | x0.996 | - |
| blake3-servil-mt / solo / OneMessage / 64 B | 6.187 | 6.132 | x0.991 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 0.877 | 0.859 | x0.980 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0398 | 0.0399 | x1.003 | level | 1 of 4 | x1.002 | - |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.708 | 0.715 | x1.011 | level | 1 of 4 | x1.011 | - |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.291 | 0.290 | x0.998 | level | 3 of 4 | x0.997 | - |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.0406 | 0.0404 | x0.994 | level | 3 of 4 | x1.004 | - |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.0418 | 0.0419 | x1.002 | level | 2 of 4 | x1.008 | - |
| blake3-servil-mt / shared-os / ContinuousMessages / 1 MiB | 0.0780 | 0.0808 | x1.036 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-os / LentMessages / 64 B | 0.719 | 0.721 | x1.003 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-os / LentMessages / 4 KiB | 0.299 | 0.298 | x0.998 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-os / ContinuousCollection / git objects | 0.0983 | 0.103 | x1.051 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-os / ReceivingMessage / saturated | 0.0889 | 0.0825 | x0.928 | level | 4 of 4 | - | - |

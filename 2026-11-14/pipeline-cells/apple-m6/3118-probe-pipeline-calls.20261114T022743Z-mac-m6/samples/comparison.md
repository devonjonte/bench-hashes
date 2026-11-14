compare: old side: bench d1c20fdfcf75 clean; servil f62bc6ac0bc1 clean
compare: new side: bench 55436819e59a clean; servil f62bc6ac0bc1 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.709 | 0.708 | x0.999 | level | 3 of 4 | x0.999 | - |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.292 | 0.293 | x1.005 | level | 2 of 4 | x1.005 | - |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.196 | 0.195 | x0.999 | level | 3 of 4 | x0.999 | - |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.199 | 0.197 | x0.992 | level | 4 of 4 | x0.993 | - |
| blake3-servil-st / solo / ContinuousBatches / 16 | 17.784 | 17.815 | x1.002 | level | 2 of 4 | x1.002 | - |
| blake3-servil-st / solo / ContinuousBatches / 256 | 13.096 | 13.108 | x1.001 | level | 1 of 4 | x1.001 | - |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 10.042 | 10.076 | x1.003 | level | 0 of 4 | x1.004 | - |
| blake3-servil-st / solo / LentMessages / 64 B | 0.709 | 0.708 | x0.999 | level | 3 of 4 | x0.999 | - |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.292 | 0.293 | x1.005 | level | 2 of 4 | x1.005 | - |
| blake3-servil-st / solo / LentMessages / 64 KiB | 0.196 | 0.195 | x0.999 | level | 3 of 4 | x0.999 | - |
| blake3-servil-st / solo / LentMessages / 1 MiB | 0.138 | 0.137 | x0.990 | level | 4 of 4 | x0.990 | - |
| blake3-servil-st / solo / LentBatches / 16 | 17.784 | 17.815 | x1.002 | level | 2 of 4 | x1.002 | - |
| blake3-servil-st / solo / LentBatches / 256 | 13.096 | 13.108 | x1.001 | level | 1 of 4 | x1.001 | - |
| blake3-servil-st / solo / LentBatches / 4096 | 10.042 | 10.076 | x1.003 | level | 0 of 4 | x1.004 | - |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.203 | 0.201 | x0.987 | level | 4 of 4 | x0.987 | - |
| blake3-servil-st / solo / ContinuousCollection / Nix files | 0.195 | 0.197 | x1.007 | level | 3 of 4 | x1.008 | - |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.263 | 0.256 | x0.974 | level | 4 of 4 | x0.974 | - |
| blake3-servil-st / solo / ReceivingMessage / 2 μs | 0.262 | 0.261 | x0.995 | level | 3 of 4 | x0.995 | - |
| blake3-servil-st / solo / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 2 of 4 | x1.015 | - |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.714 | 0.333 | x0.466 | faster | 4 of 4 | x3.024 | - |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.293 | 0.0676 | x0.230 | faster | 4 of 4 | x2.169 | - |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.196 | 0.0508 | x0.259 | faster | 4 of 4 | x2.348 | - |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.196 | 0.0539 | x0.274 | faster | 4 of 4 | x2.213 | - |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 17.707 | 5.103 | x0.288 | faster | 4 of 4 | x1.730 | - |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 13.115 | 4.041 | x0.308 | faster | 4 of 4 | x2.164 | - |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 9.934 | 3.970 | x0.400 | faster | 4 of 4 | x2.591 | - |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.714 | 0.710 | x0.995 | level | 4 of 4 | x0.995 | - |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.293 | 0.297 | x1.014 | level | 1 of 4 | x1.014 | - |
| blake3-servil-mt / solo / LentMessages / 64 KiB | 0.196 | 0.196 | x0.998 | level | 3 of 4 | x0.999 | - |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.0984 | 0.0898 | x0.913 | faster | 4 of 4 | x1.128 | - |
| blake3-servil-mt / solo / LentBatches / 16 | 17.707 | 17.769 | x1.003 | level | 1 of 4 | x1.004 | - |
| blake3-servil-mt / solo / LentBatches / 256 | 13.115 | 13.128 | x1.001 | level | 0 of 4 | x1.000 | - |
| blake3-servil-mt / solo / LentBatches / 4096 | 9.934 | 10.072 | x1.014 | level | 0 of 4 | x1.013 | - |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.201 | 0.0412 | x0.205 | faster | 4 of 4 | x2.044 | - |
| blake3-servil-mt / solo / ContinuousCollection / Nix files | 0.181 | 0.0412 | x0.227 | faster | 4 of 4 | x1.695 | - |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.260 | 0.0416 | x0.160 | faster | 4 of 4 | x1.736 | - |
| blake3-servil-mt / solo / ReceivingMessage / 2 μs | 0.263 | 0.0936 | x0.355 | faster | 4 of 4 | x1.500 | - |
| blake3-servil-mt / solo / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 0 of 4 | x0.834 | - |
| blake3-servil-mt / shared-os / ContinuousMessages / 64 B | 0.721 | 0.361 | x0.501 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-os / ContinuousMessages / 4 KiB | 0.314 | 0.136 | x0.434 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-os / ContinuousMessages / 64 KiB | 0.226 | 0.0799 | x0.354 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-os / ContinuousMessages / 1 MiB | 0.227 | 0.0827 | x0.364 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-os / ContinuousBatches / 16 | 20.017 | 5.904 | x0.295 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-os / ContinuousBatches / 256 | 15.550 | 4.943 | x0.318 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-os / ContinuousBatches / 4096 | 12.734 | 4.493 | x0.353 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-os / LentMessages / 64 B | 0.721 | 0.735 | x1.019 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-os / LentMessages / 4 KiB | 0.314 | 0.311 | x0.990 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-os / LentMessages / 64 KiB | 0.226 | 0.226 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-os / LentMessages / 1 MiB | 0.0835 | 0.0857 | x1.027 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-os / LentBatches / 16 | 20.017 | 19.877 | x0.993 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-os / LentBatches / 256 | 15.550 | 15.572 | x1.001 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-os / LentBatches / 4096 | 12.734 | 12.699 | x0.997 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-os / ContinuousCollection / git objects | 0.234 | 0.0987 | x0.422 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-os / ContinuousCollection / Nix files | 0.212 | 0.104 | x0.489 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-os / ReceivingMessage / saturated | 0.265 | 0.0841 | x0.318 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-os / ReceivingMessage / 2 μs | 0.265 | 0.0943 | x0.355 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-os / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 0 of 4 | - | - |

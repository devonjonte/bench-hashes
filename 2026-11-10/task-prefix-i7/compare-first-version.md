compare: old side: bench c28044174c7d clean; servil 0145287bd520 clean
compare: new side: bench c28044174c7d clean; servil 208cb42a93fa clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.688 | 0.683 | x0.994 | level | 3 of 4 | x0.994 | x0.969 |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 0.687 | 0.690 | x1.005 | level | 1 of 4 | x1.004 | x1.037 |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 0.693 | 0.691 | x0.996 | level | 2 of 4 | x0.997 | x0.964 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.262 | 0.262 | x0.999 | level | 3 of 4 | x0.999 | x1.030 |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.186 | 0.190 | x1.022 | level | 0 of 4 | x1.022 | x1.022 |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.195 | 0.197 | x1.012 | level | 2 of 4 | x1.012 | x0.953 |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.202 | 0.199 | x0.986 | level | 1 of 4 | x0.986 | x1.019 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.206 | 0.202 | x0.979 | level | 3 of 4 | x0.979 | x0.960 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.205 | 0.204 | x0.995 | level | 2 of 4 | x0.995 | x1.012 |
| blake3-servil-st / solo / ContinuousBatches / 16 | 13.147 | 13.079 | x0.995 | level | 3 of 4 | x0.994 | x1.050 |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 12.906 | 12.789 | x0.991 | level | 4 of 4 | x0.991 | x0.991 |
| blake3-servil-st / solo / LentMessages / 64 B | 0.688 | 0.683 | x0.994 | level | 3 of 4 | x0.994 | x0.969 |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.231 | 0.234 | x1.011 | level | 0 of 4 | x1.011 | x0.998 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.274 | 0.279 | x1.018 | level | 1 of 4 | x1.012 | x0.978 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.0885 | 0.0904 | x1.021 | level | 1 of 4 | x0.999 | x0.938 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.0670 | 0.0636 | x0.949 | level | 4 of 4 | x0.933 | x0.880 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0516 | 0.0484 | x0.938 | faster | 4 of 4 | x0.982 | x1.001 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0461 | 0.0415 | x0.901 | faster | 4 of 4 | x0.981 | x0.888 |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.0391 | 0.0373 | x0.954 | level | 4 of 4 | x0.966 | x1.030 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0430 | 0.0410 | x0.953 | level | 4 of 4 | x0.963 | x1.058 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.0442 | 0.0438 | x0.991 | level | 3 of 4 | x0.976 | x1.000 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0519 | 0.0492 | x0.948 | level | 3 of 4 | x0.963 | x0.941 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 4.176 | 4.195 | x1.004 | level | 2 of 4 | x1.034 | x1.063 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 3.622 | 3.563 | x0.984 | level | 4 of 4 | x0.929 | x0.951 |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.700 | 0.695 | x0.992 | level | 3 of 4 | x0.992 | x0.981 |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.0657 | 0.0618 | x0.941 | level | 4 of 4 | x0.990 | x0.966 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.280 | 0.296 | x1.055 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.103 | 0.107 | x1.045 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.0696 | 0.0667 | x0.959 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.0609 | 0.0627 | x1.030 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.0507 | 0.0475 | x0.938 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.0448 | 0.0429 | x0.958 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0492 | 0.0469 | x0.955 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.0753 | 0.0678 | x0.901 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.0804 | 0.0780 | x0.970 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 4.871 | 4.862 | x0.998 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 4.022 | 3.933 | x0.978 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.713 | 0.711 | x0.997 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.0783 | 0.0720 | x0.920 | level | 3 of 4 | - | - |
| blake3-servil-pipeline / solo / ContinuousBatches / 16 | 52.513 | 52.179 | x0.994 | level | 2 of 4 | x0.986 | x1.037 |
| blake3-servil-pipeline / solo / ContinuousBatches / 1024 | 10.151 | 10.060 | x0.991 | level | 2 of 4 | x0.997 | x0.995 |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 16 | 49.373 | 49.628 | x1.005 | level | 1 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 1024 | 12.270 | 12.408 | x1.011 | level | 3 of 4 | - | - |

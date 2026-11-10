compare: old side: bench c28044174c7d clean; servil 0145287bd520 clean
compare: new side: bench c28044174c7d clean; servil 4bbdb0b1c18d clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.693 | 0.690 | x0.995 | level | 3 of 4 | x0.995 | x0.986 |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 0.689 | 0.688 | x0.998 | level | 3 of 4 | x0.999 | x0.986 |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 0.694 | 0.694 | x1.000 | level | 2 of 4 | x1.000 | x0.996 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.261 | 0.261 | x1.003 | level | 1 of 4 | x1.003 | x1.077 |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.189 | 0.186 | x0.986 | level | 4 of 4 | x0.986 | x1.027 |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.196 | 0.194 | x0.992 | level | 2 of 4 | x0.991 | x0.945 |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.197 | 0.198 | x1.006 | level | 1 of 4 | x1.006 | x1.015 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.203 | 0.203 | x1.000 | level | 2 of 4 | x0.999 | x1.041 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.206 | 0.209 | x1.017 | level | 0 of 4 | x1.016 | x1.021 |
| blake3-servil-st / solo / ContinuousBatches / 16 | 13.096 | 13.012 | x0.994 | level | 2 of 4 | x0.994 | x1.041 |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 12.833 | 12.843 | x1.001 | level | 1 of 4 | x1.001 | x1.018 |
| blake3-servil-st / solo / LentMessages / 64 B | 0.693 | 0.690 | x0.995 | level | 3 of 4 | x0.995 | x0.986 |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.230 | 0.230 | x1.002 | level | 1 of 4 | x1.003 | x1.020 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.274 | 0.264 | x0.964 | level | 4 of 4 | x0.935 | x1.019 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.0876 | 0.0899 | x1.026 | level | 2 of 4 | x0.985 | x1.041 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.0659 | 0.0636 | x0.964 | level | 3 of 4 | x0.988 | x0.958 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0524 | 0.0471 | x0.899 | level | 4 of 4 | x1.027 | x0.940 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0489 | 0.0423 | x0.865 | level | 4 of 4 | x1.006 | x0.935 |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.0392 | 0.0374 | x0.956 | level | 4 of 4 | x0.994 | x1.003 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0427 | 0.0423 | x0.989 | level | 3 of 4 | x0.958 | x1.009 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.0443 | 0.0436 | x0.984 | level | 3 of 4 | x0.957 | x1.042 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0506 | 0.0505 | x0.997 | level | 2 of 4 | x1.002 | x0.916 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 4.119 | 4.122 | x1.001 | level | 2 of 4 | x1.017 | x0.965 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 3.625 | 3.533 | x0.975 | level | 3 of 4 | x0.998 | x0.998 |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.697 | 0.698 | x1.003 | level | 1 of 4 | x1.003 | x1.011 |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.0663 | 0.0622 | x0.939 | level | 3 of 4 | x0.978 | x0.940 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.281 | 0.280 | x0.998 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.105 | 0.107 | x1.020 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.0705 | 0.0641 | x0.909 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.0614 | 0.0608 | x0.990 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.0517 | 0.0468 | x0.904 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.0449 | 0.0432 | x0.962 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0482 | 0.0466 | x0.966 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.0711 | 0.0687 | x0.966 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.0804 | 0.0780 | x0.969 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 4.802 | 4.846 | x1.009 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 4.014 | 3.904 | x0.973 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.710 | 0.725 | x1.020 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.0751 | 0.0716 | x0.953 | level | 4 of 4 | - | - |
| blake3-servil-pipeline / solo / ContinuousBatches / 16 | 52.101 | 56.158 | x1.078 | level | 0 of 4 | x1.021 | x1.055 |
| blake3-servil-pipeline / solo / ContinuousBatches / 1024 | 10.621 | 10.272 | x0.967 | level | 3 of 4 | x0.977 | x0.918 |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 16 | 48.976 | 49.219 | x1.005 | level | 2 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 1024 | 12.434 | 12.556 | x1.010 | level | 2 of 4 | - | - |

compare: old side: bench 2c8676842fea clean; servil f62bc6ac0bc1 clean
compare: new side: bench 2c8676842fea clean; servil f62bc6ac0bc1 clean
compare: both sides are one build: an A/A comparison
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 4.634 | 5.148 | x1.111 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 1 KiB | 1.497 | 1.525 | x1.019 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.681 | 0.684 | x1.005 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / LentMessages / 64 B | 0.841 | 0.842 | x1.002 | level | 1 of 4 | x1.001 | - |
| blake3-servil-st / solo / LentMessages / 1 KiB | 1.085 | 1.084 | x1.000 | level | 2 of 4 | x0.999 | - |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.321 | 0.321 | x1.000 | level | 2 of 4 | x1.000 | - |
| blake3-servil-st / solo / IncrementalMessage / 64 B | 30.721 | 30.299 | x0.986 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IncrementalMessage / 1 KiB | 3.007 | 2.990 | x0.994 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IncrementalMessage / 4 KiB | 1.131 | 1.104 | x0.976 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / LentIncrementalMessage / 64 B | 3.402 | 3.435 | x1.009 | level | 0 of 4 | x1.009 | - |
| blake3-servil-st / solo / LentIncrementalMessage / 1 KiB | 1.266 | 1.266 | x1.000 | level | 2 of 4 | x1.000 | - |
| blake3-servil-st / solo / LentIncrementalMessage / 4 KiB | 0.383 | 0.382 | x0.998 | level | 3 of 4 | x0.998 | - |
| blake3-servil-mt / solo / OneMessage / 64 B | 5.491 | 5.836 | x1.063 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 1 KiB | 1.511 | 1.540 | x1.019 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 0.704 | 0.700 | x0.995 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.842 | 0.842 | x1.000 | level | 2 of 4 | x1.000 | - |
| blake3-servil-mt / solo / LentMessages / 1 KiB | 1.085 | 1.085 | x1.000 | level | 2 of 4 | x0.999 | - |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.321 | 0.321 | x1.001 | level | 2 of 4 | x1.000 | - |
| blake3-servil-mt / solo / IncrementalMessage / 64 B | 30.877 | 30.107 | x0.975 | level | 4 of 4 | - | - |
| blake3-servil-mt / solo / IncrementalMessage / 1 KiB | 2.965 | 2.974 | x1.003 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / IncrementalMessage / 4 KiB | 1.108 | 1.120 | x1.011 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / LentIncrementalMessage / 64 B | 3.409 | 3.404 | x0.999 | level | 4 of 4 | x0.998 | - |
| blake3-servil-mt / solo / LentIncrementalMessage / 1 KiB | 1.267 | 1.267 | x1.000 | level | 1 of 4 | x1.000 | - |
| blake3-servil-mt / solo / LentIncrementalMessage / 4 KiB | 0.383 | 0.383 | x0.998 | level | 3 of 4 | x0.998 | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.840 | 0.839 | x0.999 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 KiB | 1.083 | 1.083 | x1.000 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.320 | 0.320 | x1.000 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 64 B | 3.403 | 3.397 | x0.998 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 1 KiB | 1.264 | 1.263 | x1.000 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 4 KiB | 0.382 | 0.382 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 B | 0.842 | 0.841 | x0.999 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentMessages / 1 KiB | 1.085 | 1.085 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 KiB | 0.321 | 0.321 | x0.999 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 64 B | 3.409 | 3.404 | x0.999 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 1 KiB | 1.265 | 1.266 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 4 KiB | 0.384 | 0.383 | x0.996 | level | 2 of 4 | - | - |

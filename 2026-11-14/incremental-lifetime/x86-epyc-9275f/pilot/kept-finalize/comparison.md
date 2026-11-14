compare: old side: bench 2c8676842fea clean; servil c5d8331c7c3c clean
compare: new side: bench 2c8676842fea clean; servil 0932d4a610e2 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 5.316 | 5.190 | x0.976 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 1 KiB | 1.560 | 1.489 | x0.955 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.696 | 0.677 | x0.973 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / LentMessages / 64 B | 0.843 | 0.842 | x1.000 | level | 3 of 4 | x0.999 | - |
| blake3-servil-st / solo / LentMessages / 1 KiB | 1.087 | 1.086 | x1.000 | level | 3 of 4 | x1.000 | - |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.321 | 0.321 | x1.001 | level | 0 of 4 | x1.000 | - |
| blake3-servil-st / solo / IncrementalMessage / 64 B | 29.684 | 22.493 | x0.758 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / IncrementalMessage / 1 KiB | 2.914 | 2.513 | x0.862 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / IncrementalMessage / 4 KiB | 1.106 | 0.952 | x0.861 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / LentIncrementalMessage / 64 B | 3.407 | 2.443 | x0.717 | faster | 4 of 4 | x0.717 | - |
| blake3-servil-st / solo / LentIncrementalMessage / 1 KiB | 1.270 | 1.203 | x0.947 | faster | 4 of 4 | x0.948 | - |
| blake3-servil-st / solo / LentIncrementalMessage / 4 KiB | 0.384 | 0.347 | x0.904 | faster | 4 of 4 | x0.904 | - |
| blake3-servil-mt / solo / OneMessage / 64 B | 6.113 | 5.330 | x0.872 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 1 KiB | 1.578 | 1.514 | x0.959 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 0.698 | 0.704 | x1.009 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.843 | 0.842 | x0.999 | level | 3 of 4 | x0.999 | - |
| blake3-servil-mt / solo / LentMessages / 1 KiB | 1.086 | 1.086 | x1.000 | level | 2 of 4 | x1.000 | - |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.321 | 0.321 | x1.000 | level | 2 of 4 | x1.000 | - |
| blake3-servil-mt / solo / IncrementalMessage / 64 B | 29.895 | 21.743 | x0.727 | faster | 4 of 4 | - | - |
| blake3-servil-mt / solo / IncrementalMessage / 1 KiB | 2.942 | 2.541 | x0.864 | faster | 4 of 4 | - | - |
| blake3-servil-mt / solo / IncrementalMessage / 4 KiB | 1.124 | 0.967 | x0.860 | faster | 4 of 4 | - | - |
| blake3-servil-mt / solo / LentIncrementalMessage / 64 B | 3.411 | 2.441 | x0.715 | faster | 4 of 4 | x0.716 | - |
| blake3-servil-mt / solo / LentIncrementalMessage / 1 KiB | 1.267 | 1.203 | x0.949 | faster | 4 of 4 | x0.949 | - |
| blake3-servil-mt / solo / LentIncrementalMessage / 4 KiB | 0.384 | 0.347 | x0.905 | faster | 4 of 4 | x0.905 | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.839 | 0.839 | x1.000 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 KiB | 1.084 | 1.083 | x0.999 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.321 | 0.320 | x0.999 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 64 B | 3.404 | 2.434 | x0.715 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 1 KiB | 1.263 | 1.199 | x0.949 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentIncrementalMessage / 4 KiB | 0.382 | 0.346 | x0.906 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 B | 0.840 | 0.842 | x1.002 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentMessages / 1 KiB | 1.085 | 1.085 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 KiB | 0.321 | 0.321 | x1.000 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 64 B | 3.408 | 2.440 | x0.716 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 1 KiB | 1.266 | 1.202 | x0.949 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentIncrementalMessage / 4 KiB | 0.383 | 0.346 | x0.906 | faster | 4 of 4 | - | - |

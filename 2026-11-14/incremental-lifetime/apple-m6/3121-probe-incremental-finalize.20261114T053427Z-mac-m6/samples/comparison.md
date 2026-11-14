compare: old side: bench 2c8676842fea clean; servil c5d8331c7c3c clean
compare: new side: bench 2c8676842fea clean; servil 0932d4a610e2 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 5.991 | 5.969 | x0.996 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 1 KiB | 1.009 | 1.039 | x1.030 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.598 | 0.601 | x1.005 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / LentMessages / 64 B | 0.687 | 0.698 | x1.016 | level | 1 of 4 | x1.016 | - |
| blake3-servil-st / solo / LentMessages / 1 KiB | 0.675 | 0.670 | x0.992 | level | 2 of 4 | x0.991 | - |
| blake3-servil-st / solo / LentMessages / 4 KiB | 0.290 | 0.291 | x1.002 | level | 1 of 4 | x1.002 | - |
| blake3-servil-st / solo / IncrementalMessage / 64 B | 16.578 | 13.516 | x0.815 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / IncrementalMessage / 1 KiB | 1.598 | 1.427 | x0.893 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / IncrementalMessage / 4 KiB | 0.786 | 0.719 | x0.916 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / LentIncrementalMessage / 64 B | 6.504 | 3.899 | x0.599 | faster | 4 of 4 | x0.600 | - |
| blake3-servil-st / solo / LentIncrementalMessage / 1 KiB | 1.023 | 0.853 | x0.835 | faster | 4 of 4 | x0.834 | - |
| blake3-servil-st / solo / LentIncrementalMessage / 4 KiB | 0.395 | 0.351 | x0.889 | faster | 4 of 4 | x0.889 | - |
| blake3-servil-mt / solo / OneMessage / 64 B | 6.067 | 6.852 | x1.129 | level | 0 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 1 KiB | 1.046 | 1.088 | x1.039 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 4 KiB | 0.884 | 0.903 | x1.021 | level | 1 of 4 | - | - |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.707 | 0.708 | x1.000 | level | 2 of 4 | x1.000 | - |
| blake3-servil-mt / solo / LentMessages / 1 KiB | 0.679 | 0.673 | x0.992 | level | 3 of 4 | x0.991 | - |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.290 | 0.290 | x1.002 | level | 1 of 4 | x1.002 | - |
| blake3-servil-mt / solo / IncrementalMessage / 64 B | 16.195 | 13.663 | x0.844 | faster | 4 of 4 | - | - |
| blake3-servil-mt / solo / IncrementalMessage / 1 KiB | 1.613 | 1.438 | x0.891 | level | 4 of 4 | - | - |
| blake3-servil-mt / solo / IncrementalMessage / 4 KiB | 1.034 | 0.977 | x0.945 | faster | 4 of 4 | - | - |
| blake3-servil-mt / solo / LentIncrementalMessage / 64 B | 6.370 | 3.652 | x0.573 | faster | 4 of 4 | x0.574 | - |
| blake3-servil-mt / solo / LentIncrementalMessage / 1 KiB | 1.031 | 0.854 | x0.828 | faster | 4 of 4 | x0.829 | - |
| blake3-servil-mt / solo / LentIncrementalMessage / 4 KiB | 0.394 | 0.351 | x0.890 | faster | 4 of 4 | x0.890 | - |
| blake3-servil-mt / shared-os / LentMessages / 64 B | 0.720 | 0.750 | x1.041 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-os / LentMessages / 1 KiB | 0.692 | 0.692 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-os / LentMessages / 4 KiB | 0.295 | 0.294 | x0.997 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-os / LentIncrementalMessage / 64 B | 7.433 | 4.264 | x0.574 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-os / LentIncrementalMessage / 1 KiB | 1.065 | 0.877 | x0.824 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-os / LentIncrementalMessage / 4 KiB | 0.404 | 0.354 | x0.878 | faster | 4 of 4 | - | - |

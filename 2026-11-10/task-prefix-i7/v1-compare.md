compare: old side: bench c28044174c7d clean; servil 0145287bd520 clean
compare: new side: bench c28044174c7d clean; servil 868e093c16a3 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.690 | 0.700 | x1.014 | level | 2 of 16 | x1.014 | x1.042 |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 0.692 | 0.691 | x0.999 | level | 8 of 16 | x0.999 | x0.985 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.261 | 0.261 | x1.000 | level | 11 of 16 | x0.999 | x1.005 |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.191 | 0.190 | x0.994 | level | 7 of 16 | x0.994 | x1.007 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.279 | 0.280 | x1.004 | level | 8 of 16 | x0.994 | x0.995 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.0903 | 0.0901 | x0.997 | level | 8 of 16 | x1.000 | x1.009 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0521 | 0.0483 | x0.926 | faster | 16 of 16 | x1.001 | x0.978 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0465 | 0.0418 | x0.899 | faster | 16 of 16 | x1.000 | x0.921 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.289 | 0.286 | x0.991 | level | 9 of 16 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.107 | 0.106 | x0.984 | level | 9 of 16 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.0605 | 0.0613 | x1.014 | level | 6 of 16 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.0518 | 0.0476 | x0.919 | faster | 16 of 16 | - | - |

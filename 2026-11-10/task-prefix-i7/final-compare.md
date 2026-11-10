compare: old side: bench c28044174c7d clean; servil 0145287bd520 clean
compare: new side: bench c28044174c7d clean; servil 826f91407fc3 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.690 | 0.704 | x1.020 | level | 3 of 16 | x1.020 | x1.032 |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 0.691 | 0.691 | x1.001 | level | 8 of 16 | x1.000 | x0.947 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.263 | 0.262 | x0.998 | level | 11 of 16 | x0.998 | x1.003 |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.191 | 0.188 | x0.984 | level | 14 of 16 | x0.984 | x0.963 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.274 | 0.282 | x1.028 | level | 3 of 16 | x1.044 | x0.998 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.0890 | 0.0906 | x1.018 | level | 7 of 16 | x1.001 | x1.013 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0522 | 0.0486 | x0.931 | faster | 15 of 16 | x0.977 | x0.935 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0467 | 0.0421 | x0.902 | faster | 15 of 16 | x0.997 | x0.943 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.286 | 0.290 | x1.013 | level | 5 of 16 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.106 | 0.108 | x1.020 | level | 5 of 16 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.0615 | 0.0612 | x0.997 | level | 8 of 16 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.0521 | 0.0472 | x0.904 | faster | 16 of 16 | - | - |

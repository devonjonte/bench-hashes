compare: old side: bench c28044174c7d clean; servil 0145287bd520 clean
compare: new side: bench c28044174c7d clean; servil 10e4afb748bc clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.689 | 0.710 | x1.030 | slower | 1 of 32 | x1.030 | x1.052 |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 0.691 | 0.692 | x1.001 | level | 16 of 32 | x1.002 | x0.985 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.275 | 0.275 | x0.999 | level | 16 of 32 | x1.000 | x1.028 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.0895 | 0.0892 | x0.997 | level | 13 of 32 | x0.995 | x0.995 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.285 | 0.285 | x0.998 | level | 16 of 32 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.107 | 0.106 | x0.988 | level | 18 of 32 | - | - |

compare: old side: bench c28044174c7d clean; servil f4378b28a31e clean
compare: new side: bench c28044174c7d clean; servil 54cc1e9aac4d clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.199 | 0.199 | x0.997 | level | 9 of 16 | x0.998 | x0.992 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.203 | 0.203 | x0.998 | level | 7 of 16 | x0.999 | x1.017 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.208 | 0.206 | x0.992 | level | 12 of 16 | x0.992 | x0.972 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0409 | 0.0407 | x0.994 | level | 8 of 16 | x0.993 | x1.000 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.0434 | 0.0436 | x1.003 | level | 7 of 16 | x0.980 | x1.014 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0509 | 0.0480 | x0.943 | faster | 14 of 16 | x0.959 | x0.960 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0473 | 0.0469 | x0.990 | level | 11 of 16 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.0692 | 0.0503 | x0.726 | faster | 16 of 16 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.0805 | 0.0623 | x0.774 | faster | 16 of 16 | - | - |

compare: old side: bench 3363bee8ff5e clean; servil e4ef6f0779b4 clean
compare: new side: bench 3363bee8ff5e clean; servil 06f6e26de800 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.199 | 0.199 | x0.995 | level | 9 of 16 | x0.995 | x1.013 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.203 | 0.202 | x0.997 | level | 8 of 16 | x0.997 | x0.978 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.207 | 0.206 | x0.994 | level | 10 of 16 | x0.994 | x0.985 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0417 | 0.0413 | x0.990 | level | 11 of 16 | x0.967 | x1.007 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.0463 | 0.0443 | x0.958 | faster | 15 of 16 | x1.003 | x0.991 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0488 | 0.0503 | x1.032 | slower | 3 of 16 | x0.980 | x1.008 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0484 | 0.0488 | x1.009 | level | 4 of 16 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.0514 | 0.0781 | x1.520 | slower | 0 of 16 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.0628 | 0.0815 | x1.298 | slower | 0 of 16 | - | - |

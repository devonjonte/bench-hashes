compare: old side: bench c28044174c7d clean; servil 605c53e3e1c1 clean
compare: new side: bench c28044174c7d clean; servil 54cc1e9aac4d clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.201 | 0.199 | x0.989 | level | 10 of 16 | x0.989 | x1.013 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.202 | 0.205 | x1.014 | level | 4 of 16 | x1.013 | x1.069 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.207 | 0.207 | x0.996 | level | 8 of 16 | x0.996 | x0.996 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0411 | 0.0413 | x1.003 | level | 10 of 16 | x1.005 | x1.005 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.0441 | 0.0443 | x1.004 | level | 7 of 16 | x0.998 | x1.063 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0477 | 0.0484 | x1.014 | level | 6 of 16 | x0.985 | x1.036 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0466 | 0.0471 | x1.010 | level | 8 of 16 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.0495 | 0.0502 | x1.014 | level | 3 of 16 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.0612 | 0.0623 | x1.019 | level | 5 of 16 | - | - |

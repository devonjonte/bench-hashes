compare: old side: bench c28044174c7d clean; servil f4378b28a31e clean
compare: new side: bench c28044174c7d clean; servil 605c53e3e1c1 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.200 | 0.200 | x1.001 | level | 7 of 16 | x1.001 | x1.025 |
| blake3-servil-st / solo / ContinuousMessages / 4 MiB | 0.202 | 0.202 | x0.998 | level | 9 of 16 | x0.999 | x0.999 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.208 | 0.206 | x0.989 | level | 11 of 16 | x0.989 | x0.964 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0414 | 0.0412 | x0.995 | level | 8 of 16 | x1.013 | x1.002 |
| blake3-servil-mt / solo / ContinuousMessages / 4 MiB | 0.0434 | 0.0445 | x1.027 | level | 4 of 16 | x1.018 | x0.999 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0497 | 0.0473 | x0.953 | faster | 16 of 16 | x0.999 | x0.950 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0469 | 0.0468 | x0.998 | level | 8 of 16 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 MiB | 0.0686 | 0.0496 | x0.723 | faster | 16 of 16 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.0799 | 0.0611 | x0.765 | faster | 16 of 16 | - | - |

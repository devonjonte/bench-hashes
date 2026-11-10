compare: old side: bench f43ff077761b clean; servil c3e1f90551ba clean
compare: new side: bench f43ff077761b clean; servil 203d92a228c8 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.276 | 0.276 | x1.000 | level | 38 of 64 | x1.000 | x1.001 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 3.638 | 3.621 | x0.995 | level | 35 of 64 | x0.979 | x1.000 |
| blake3-servil-mt / solo / ContinuousBatches / 65536 | 3.969 | 3.969 | x1.000 | level | 35 of 64 | x0.999 | x1.009 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.288 | 0.291 | x1.011 | level | 28 of 64 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 3.963 | 3.954 | x0.998 | level | 32 of 64 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 65536 | 4.540 | 4.545 | x1.001 | level | 33 of 64 | - | - |
| blake3-servil-pipeline / solo / ContinuousBatches / 1024 | 11.473 | 12.824 | x1.118 | slower | 6 of 64 | x1.089 | x1.060 |
| blake3-servil-pipeline / solo / ContinuousBatches / 65536 | 9.756 | 9.793 | x1.004 | level | 29 of 64 | x1.004 | x1.004 |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 1024 | 12.526 | 12.490 | x0.997 | level | 30 of 64 | - | - |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 65536 | 12.227 | 12.120 | x0.991 | level | 42 of 64 | - | - |

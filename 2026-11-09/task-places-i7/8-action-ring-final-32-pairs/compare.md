compare: old side: bench f43ff077761b clean; servil c3e1f90551ba clean
compare: new side: bench f43ff077761b clean; servil 887fa7cd03ed clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / ContinuousBatches / 16 | 13.011 | 13.056 | x1.003 | level | 16 of 32 | x1.004 | x1.007 |
| blake3-servil-st / solo / ContinuousBatches / 64 | 12.293 | 12.312 | x1.002 | level | 16 of 32 | x1.002 | x1.028 |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.237 | 0.237 | x0.996 | level | 20 of 32 | x0.996 | x0.976 |
| blake3-servil-st / solo / ReceivingMessage / 2 μs | 0.238 | 0.239 | x1.004 | level | 14 of 32 | x1.004 | x1.010 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 4.149 | 4.122 | x0.993 | level | 19 of 32 | x0.998 | x0.964 |
| blake3-servil-mt / solo / ContinuousBatches / 64 | 3.932 | 3.890 | x0.989 | level | 20 of 32 | x0.983 | x0.997 |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.237 | 0.237 | x1.000 | level | 12 of 32 | x1.000 | x0.991 |
| blake3-servil-mt / solo / ReceivingMessage / 2 μs | 0.239 | 0.238 | x0.999 | level | 15 of 32 | x0.999 | x0.991 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 4.829 | 4.856 | x1.006 | level | 13 of 32 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 64 | 4.270 | 4.264 | x0.999 | level | 17 of 32 | - | - |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.247 | 0.247 | x0.998 | level | 18 of 32 | - | - |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 2 μs | 0.249 | 0.249 | x0.999 | level | 16 of 32 | - | - |
| blake3-servil-pipeline / solo / ContinuousBatches / 16 | 58.723 | 52.196 | x0.889 | faster | 31 of 32 | x0.928 | x0.842 |
| blake3-servil-pipeline / solo / ContinuousBatches / 64 | 22.335 | 21.752 | x0.974 | level | 30 of 32 | x0.969 | x0.948 |
| blake3-servil-pipeline / solo / ReceivingMessage / saturated | 0.0815 | 0.0753 | x0.924 | faster | 31 of 32 | x1.039 | x0.935 |
| blake3-servil-pipeline / solo / ReceivingMessage / 2 μs | 0.0928 | 0.0929 | x1.000 | level | 24 of 32 | x0.928 | x1.000 |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 16 | 54.603 | 50.287 | x0.921 | faster | 32 of 32 | - | - |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 64 | 22.325 | 21.801 | x0.977 | level | 29 of 32 | - | - |
| blake3-servil-pipeline / shared-one-cache / ReceivingMessage / saturated | 0.102 | 0.0952 | x0.935 | faster | 29 of 32 | - | - |
| blake3-servil-pipeline / shared-one-cache / ReceivingMessage / 2 μs | 0.103 | 0.0974 | x0.948 | faster | 29 of 32 | - | - |

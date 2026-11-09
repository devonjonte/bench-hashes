compare: old side: bench 0bb31ed5186e clean; servil c7936a5f4a8f clean
compare: new side: bench 0bb31ed5186e clean; servil 6d3f3880edf6 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / ContinuousMessages / 256 B | 0.694 | 0.693 | x0.998 | level | 19 of 32 | x0.998 | x0.982 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.207 | 0.207 | x1.001 | level | 14 of 32 | x1.001 | x1.011 |
| blake3-servil-st / solo / ContinuousBatches / 16 | 13.010 | 13.057 | x1.004 | level | 12 of 32 | x1.004 | x0.993 |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 13.999 | 14.062 | x1.005 | level | 10 of 32 | x1.005 | x1.030 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.0913 | 0.0903 | x0.989 | level | 19 of 32 | x0.972 | x0.998 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0514 | 0.0510 | x0.992 | level | 17 of 32 | x1.011 | x0.993 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 4.090 | 4.145 | x1.013 | level | 10 of 32 | x1.008 | x0.977 |
| blake3-servil-mt / solo / ContinuousBatches / 16384 | 3.906 | 3.896 | x0.997 | level | 19 of 32 | x1.009 | x1.002 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.107 | 0.107 | x0.996 | level | 18 of 32 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.0827 | 0.0838 | x1.013 | level | 14 of 32 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 4.850 | 4.857 | x1.001 | level | 16 of 32 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16384 | 4.294 | 4.294 | x1.000 | level | 19 of 32 | - | - |
| blake3-servil-pipeline / solo / ContinuousBatches / 16 | 58.330 | 58.721 | x1.007 | level | 12 of 32 | x0.988 | x0.977 |
| blake3-servil-pipeline / solo / ContinuousBatches / 16384 | 9.833 | 10.016 | x1.019 | level | 10 of 32 | x1.013 | x1.007 |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 16 | 53.343 | 55.374 | x1.038 | slower | 1 of 32 | - | - |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 16384 | 11.278 | 11.327 | x1.004 | level | 11 of 32 | - | - |

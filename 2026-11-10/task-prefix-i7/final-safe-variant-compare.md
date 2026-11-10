compare: old side: bench c28044174c7d clean; servil 0145287bd520 clean
compare: new side: bench c28044174c7d clean; servil f9eca59a3458 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.693 | 0.708 | x1.022 | level | 1 of 16 | x1.022 | x1.056 |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 0.690 | 0.689 | x0.998 | level | 10 of 16 | x0.998 | x1.025 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.262 | 0.262 | x0.999 | level | 8 of 16 | x0.999 | x0.993 |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.189 | 0.189 | x1.001 | level | 8 of 16 | x1.001 | x0.990 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.273 | 0.287 | x1.050 | slower | 1 of 16 | x1.076 | x1.041 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.0915 | 0.0910 | x0.994 | level | 10 of 16 | x0.987 | x1.014 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0518 | 0.0488 | x0.941 | faster | 14 of 16 | x0.981 | x0.961 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0464 | 0.0427 | x0.920 | faster | 13 of 16 | x0.996 | x0.943 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.293 | 0.297 | x1.014 | level | 6 of 16 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.107 | 0.110 | x1.020 | level | 7 of 16 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.0611 | 0.0612 | x1.002 | level | 6 of 16 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.0512 | 0.0468 | x0.914 | faster | 15 of 16 | - | - |

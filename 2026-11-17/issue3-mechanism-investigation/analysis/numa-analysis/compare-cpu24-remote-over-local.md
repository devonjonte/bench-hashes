compare: old side: bench d7723f110a6f clean; servil 27eacce3a5c2 clean
compare: new side: bench d7723f110a6f clean; servil 27eacce3a5c2 clean
compare: both sides report the same sources; build and run settings may differ
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-mt / solo / OneMessage / 64 B | 9.889 | 11.365 | x1.149 | level | 2 of 8 | - | - |
| blake3-servil-mt / solo / OneMessage / 128 B | 7.203 | 9.576 | x1.329 | level | 3 of 8 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 64 B | 7.419 | 6.607 | x0.890 | level | 4 of 8 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 128 B | 4.366 | 4.186 | x0.959 | level | 3 of 8 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 256 B | 3.239 | 3.655 | x1.128 | slower | 0 of 8 | - | - |
| blake3-servil-st / solo / OneMessage / 64 B | 6.624 | 9.830 | x1.484 | slower | 0 of 8 | - | - |
| blake3-servil-st / solo / OneMessage / 128 B | 4.361 | 6.951 | x1.594 | slower | 0 of 8 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 64 B | 6.533 | 7.072 | x1.083 | level | 3 of 8 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 128 B | 4.478 | 4.911 | x1.097 | level | 2 of 8 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 256 B | 3.465 | 2.948 | x0.851 | level | 7 of 8 | - | - |

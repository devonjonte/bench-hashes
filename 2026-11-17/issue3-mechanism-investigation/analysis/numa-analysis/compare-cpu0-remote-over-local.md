compare: old side: bench d7723f110a6f clean; servil 27eacce3a5c2 clean
compare: new side: bench d7723f110a6f clean; servil 27eacce3a5c2 clean
compare: both sides report the same sources; build and run settings may differ
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-mt / solo / OneMessage / 64 B | 9.617 | 12.872 | x1.339 | slower | 1 of 8 | - | - |
| blake3-servil-mt / solo / OneMessage / 128 B | 6.655 | 8.793 | x1.321 | slower | 1 of 8 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 64 B | 6.010 | 5.921 | x0.985 | level | 5 of 8 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 128 B | 3.953 | 3.875 | x0.980 | level | 5 of 8 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 256 B | 3.103 | 2.950 | x0.951 | level | 4 of 8 | - | - |
| blake3-servil-st / solo / OneMessage / 64 B | 8.022 | 10.754 | x1.341 | slower | 1 of 8 | - | - |
| blake3-servil-st / solo / OneMessage / 128 B | 5.611 | 7.424 | x1.323 | slower | 1 of 8 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 64 B | 5.851 | 5.853 | x1.000 | level | 3 of 8 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 128 B | 3.919 | 3.924 | x1.001 | level | 4 of 8 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 256 B | 2.879 | 2.894 | x1.005 | level | 4 of 8 | - | - |

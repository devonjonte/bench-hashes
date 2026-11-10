compare: old side: bench eb1002b81009 clean; servil a4095ba6d1e3 clean
compare: new side: bench eb1002b81009 clean; servil d3e907a8ef7b clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 1 KiB | 1.626 | 1.555 | x0.956 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 2304 B | 1.144 | 1.148 | x1.003 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 3 KiB | 1.101 | 0.861 | x0.782 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 3839 B | 0.890 | 0.895 | x1.006 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 4470 B | 0.776 | 0.685 | x0.883 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 7935 B | 0.489 | 0.484 | x0.989 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 16 KiB | 0.363 | 0.360 | x0.992 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 3 KiB | 1.546 | 0.858 | x0.555 | level | 4 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 1 KiB | 1.639 | 1.537 | x0.938 | level | 4 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 2304 B | 1.156 | 1.136 | x0.982 | level | 3 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 3 KiB | 1.037 | 0.872 | x0.841 | level | 4 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 3839 B | 0.968 | 0.898 | x0.927 | level | 4 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 4470 B | 0.727 | 0.701 | x0.964 | level | 4 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 7935 B | 0.489 | 0.486 | x0.995 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / OneMessage / 16 KiB | 0.369 | 0.364 | x0.988 | level | 2 of 4 | - | - |
| blake3-servil-mt / solo / IdleOneMessage / 3 KiB | 1.518 | 1.006 | x0.662 | level | 3 of 4 | - | - |

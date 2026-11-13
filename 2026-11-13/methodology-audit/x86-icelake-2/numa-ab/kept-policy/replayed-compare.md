compare: old side: bench 3363bee8ff5e clean; servil b5b988d8982b clean
compare: new side: bench 97c0fbcbedb8 clean; servil bf2da8b957f5 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 16.509 | 15.038 | x0.911 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 256 B | 5.975 | 5.525 | x0.925 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 4 KiB | 2.446 | 2.480 | x1.014 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 64 KiB | 1.075 | 1.073 | x0.998 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 128 | 87.647 | 88.214 | x1.006 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 8.065 | 6.429 | x0.797 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 1.068 | 0.639 | x0.598 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.908 | 0.899 | x0.990 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.602 | 0.598 | x0.993 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.482 | 0.477 | x0.989 | level | 4 of 4 | - | - |

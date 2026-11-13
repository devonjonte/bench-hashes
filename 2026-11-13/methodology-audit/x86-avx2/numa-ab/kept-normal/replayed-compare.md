compare: old side: bench 3363bee8ff5e clean; servil b5b988d8982b clean
compare: new side: bench 97c0fbcbedb8 clean; servil bf2da8b957f5 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 7.478 | 6.851 | x0.916 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 256 B | 2.629 | 2.851 | x1.084 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.701 | 0.776 | x1.107 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 64 KiB | 0.325 | 0.328 | x1.007 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 128 | 27.825 | 28.023 | x1.007 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 1.070 | 1.043 | x0.974 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.712 | 0.474 | x0.666 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.804 | 0.793 | x0.986 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.621 | 0.630 | x1.014 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.344 | 0.365 | x1.062 | level | 1 of 4 | - | - |

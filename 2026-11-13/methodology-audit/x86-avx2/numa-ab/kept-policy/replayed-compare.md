compare: old side: bench 3363bee8ff5e clean; servil b5b988d8982b clean
compare: new side: bench 97c0fbcbedb8 clean; servil bf2da8b957f5 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 7.159 | 6.342 | x0.886 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 256 B | 2.796 | 2.564 | x0.917 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.705 | 0.746 | x1.058 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 64 KiB | 0.324 | 0.330 | x1.018 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 128 | 27.815 | 29.022 | x1.043 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 1.080 | 1.079 | x0.999 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.708 | 0.475 | x0.670 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.691 | 0.680 | x0.984 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.622 | 0.634 | x1.020 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.354 | 0.350 | x0.988 | level | 3 of 4 | - | - |

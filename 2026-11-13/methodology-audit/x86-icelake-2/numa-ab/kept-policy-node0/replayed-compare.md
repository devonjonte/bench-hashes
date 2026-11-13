compare: old side: bench 3363bee8ff5e clean; servil b5b988d8982b clean
compare: new side: bench 97c0fbcbedb8 clean; servil bf2da8b957f5 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 14.184 | 13.549 | x0.955 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 256 B | 5.040 | 5.115 | x1.015 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 4 KiB | 2.332 | 2.350 | x1.008 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 64 KiB | 1.062 | 1.069 | x1.007 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 128 | 83.463 | 83.878 | x1.005 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 8.140 | 6.489 | x0.797 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 1.069 | 0.635 | x0.593 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.873 | 0.874 | x1.001 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.607 | 0.597 | x0.983 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.484 | 0.473 | x0.978 | level | 4 of 4 | - | - |

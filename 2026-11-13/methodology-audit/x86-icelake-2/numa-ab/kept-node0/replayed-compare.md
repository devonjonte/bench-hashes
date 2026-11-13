compare: old side: bench 3363bee8ff5e clean; servil b5b988d8982b clean
compare: new side: bench 97c0fbcbedb8 clean; servil bf2da8b957f5 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 15.044 | 14.525 | x0.965 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 256 B | 5.219 | 4.932 | x0.945 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 4 KiB | 2.392 | 2.411 | x1.008 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 64 KiB | 1.065 | 1.074 | x1.008 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 128 | 86.741 | 85.381 | x0.984 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 7.981 | 6.498 | x0.814 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 1.068 | 0.674 | x0.631 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.989 | 0.972 | x0.984 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.604 | 0.601 | x0.996 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.481 | 0.475 | x0.987 | level | 4 of 4 | - | - |

compare: old side: bench 3363bee8ff5e clean; servil b5b988d8982b clean
compare: new side: bench 97c0fbcbedb8 clean; servil bf2da8b957f5 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 6.711 | 8.671 | x1.292 | level | 0 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 256 B | 2.734 | 2.585 | x0.945 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 4 KiB | 1.011 | 0.735 | x0.727 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 64 KiB | 0.330 | 0.335 | x1.015 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 128 | 28.695 | 27.554 | x0.960 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 1.130 | 1.055 | x0.934 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.725 | 0.477 | x0.658 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.831 | 0.804 | x0.967 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.637 | 0.609 | x0.956 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.352 | 0.354 | x1.006 | level | 2 of 4 | - | - |

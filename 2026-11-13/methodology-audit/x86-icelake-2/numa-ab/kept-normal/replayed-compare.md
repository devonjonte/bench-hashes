compare: old side: bench 3363bee8ff5e clean; servil b5b988d8982b clean
compare: new side: bench 97c0fbcbedb8 clean; servil bf2da8b957f5 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 15.665 | 17.672 | x1.128 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 256 B | 6.463 | 5.576 | x0.863 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 4 KiB | 2.550 | 2.414 | x0.946 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 64 KiB | 1.057 | 1.090 | x1.032 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 128 | 85.651 | 86.481 | x1.010 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 8.168 | 6.492 | x0.795 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 1.078 | 0.641 | x0.595 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / InterleavedTurn / 256 | 1.019 | 0.994 | x0.975 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.608 | 0.599 | x0.985 | level | 4 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.484 | 0.475 | x0.983 | level | 4 of 4 | - | - |

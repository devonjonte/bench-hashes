compare: old side: bench 3363bee8ff5e clean; servil b5b988d8982b clean
compare: new side: bench 97c0fbcbedb8 clean; servil bf2da8b957f5 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 6.246 | 6.523 | x1.044 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 256 B | 2.530 | 2.571 | x1.016 | level | 1 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.716 | 0.697 | x0.973 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / OneMessage / 64 KiB | 0.326 | 0.322 | x0.987 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / ManyMessages / 128 | 28.696 | 27.494 | x0.958 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 3839 B | 1.033 | 1.056 | x1.022 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 3 KiB | 0.723 | 0.491 | x0.680 | faster | 4 of 4 | - | - |
| blake3-servil-st / solo / InterleavedTurn / 256 | 0.688 | 0.671 | x0.974 | level | 2 of 4 | - | - |
| blake3-servil-st / solo / IdleInterleavedTurn / 256 | 0.637 | 0.635 | x0.996 | level | 3 of 4 | - | - |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.351 | 0.351 | x0.998 | level | 2 of 4 | - | - |

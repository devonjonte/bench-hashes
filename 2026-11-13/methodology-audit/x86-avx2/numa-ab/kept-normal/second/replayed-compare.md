compare: old side: bench 3363bee8ff5e clean; servil b5b988d8982b clean
compare: new side: bench 97c0fbcbedb8 clean; servil bf2da8b957f5 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 256 B | 3.429 | 3.322 | x0.969 | level | 36 of 64 | - | - |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.948 | 0.997 | x1.052 | slower | 13 of 64 | - | - |
| blake3-servil-st / solo / BriefIdleInterleavedTurn / 256 | 0.478 | 0.476 | x0.996 | level | 34 of 64 | - | - |

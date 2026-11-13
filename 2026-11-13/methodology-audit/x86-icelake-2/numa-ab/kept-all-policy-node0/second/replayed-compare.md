compare: old side: bench 3363bee8ff5e clean; servil b5b988d8982b clean
compare: new side: bench 97c0fbcbedb8 clean; servil bf2da8b957f5 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / ManyMessages / 6 | 322.381 | 320.150 | x0.993 | level | 33 of 64 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 64 B | 7.529 | 7.394 | x0.982 | level | 40 of 64 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 2 KiB | 8.266 | 8.296 | x1.004 | level | 30 of 64 | - | - |
| blake3-servil-st / solo / IdleManyMessages / 1 | 547.280 | 572.644 | x1.046 | slower | 24 of 64 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 512 B | 1.549 | 1.541 | x0.994 | level | 43 of 64 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 1 KiB | 1.478 | 1.475 | x0.998 | level | 42 of 64 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 2 | 128.770 | 133.732 | x1.039 | slower | 19 of 64 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 16 | 27.516 | 28.982 | x1.053 | slower | 2 of 64 | - | - |

compare: old side: bench 3363bee8ff5e clean; servil b5b988d8982b clean
compare: new side: bench 97c0fbcbedb8 clean; servil bf2da8b957f5 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.701 | 0.724 | x1.033 | slower | 24 of 64 | - | - |
| blake3-servil-st / solo / OneMessage / 4470 B | 0.744 | 0.776 | x1.043 | slower | 15 of 64 | - | - |
| blake3-servil-st / solo / ManyMessages / 3 | 210.207 | 224.183 | x1.066 | slower | 21 of 64 | - | - |
| blake3-servil-st / solo / ManyMessages / 16 | 84.134 | 87.657 | x1.042 | slower | 23 of 64 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 512 B | 2.441 | 2.422 | x0.992 | level | 35 of 64 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 6 | 44.841 | 45.715 | x1.019 | level | 9 of 64 | - | - |
| blake3-servil-st / solo / BriefIdleManyMessages / 16 | 24.381 | 24.675 | x1.012 | level | 11 of 64 | - | - |
| blake3-servil-st / solo / ContinuousMessages / 256 KiB | 0.221 | 0.222 | x1.009 | level | 3 of 64 | x1.009 | - |

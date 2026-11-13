compare: old side: bench 3363bee8ff5e clean; servil b5b988d8982b clean
compare: new side: bench e310174178ac clean; servil bf2da8b957f5 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 2304 B | 1.146 | 1.159 | x1.011 | level | 29 of 64 | - | - |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.576 | 0.595 | x1.033 | slower | 23 of 64 | - | - |
| blake3-servil-st / solo / OneMessage / 16 KiB | 0.355 | 0.366 | x1.031 | slower | 18 of 64 | - | - |
| blake3-servil-st / solo / OneMessage / 32 KiB | 0.220 | 0.227 | x1.031 | slower | 17 of 64 | - | - |

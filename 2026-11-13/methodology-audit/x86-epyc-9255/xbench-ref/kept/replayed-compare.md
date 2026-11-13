compare: old side: bench 3363bee8ff5e clean; servil b5b988d8982b clean
compare: new side: bench e310174178ac clean; servil bf2da8b957f5 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 5.724 | 6.002 | x1.049 | level | 11 of 24 | - | - |
| blake3-servil-st / solo / OneMessage / 1536 B | 1.770 | 1.806 | x1.021 | level | 7 of 24 | - | - |
| blake3-servil-st / solo / OneMessage / 2304 B | 1.454 | 1.506 | x1.035 | level | 9 of 24 | - | - |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.731 | 0.783 | x1.071 | level | 5 of 24 | - | - |
| blake3-servil-st / solo / OneMessage / 16 KiB | 0.424 | 0.441 | x1.041 | level | 6 of 24 | - | - |
| blake3-servil-st / solo / OneMessage / 32 KiB | 0.265 | 0.281 | x1.059 | slower | 3 of 24 | - | - |
| blake3-servil-st / solo / OneMessage / 64 KiB | 0.188 | 0.195 | x1.040 | slower | 3 of 24 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 4 KiB | 0.430 | 0.430 | x1.000 | level | 9 of 24 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 KiB | 0.387 | 0.388 | x1.003 | level | 3 of 24 | - | - |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.962 | 0.940 | x0.977 | level | 20 of 24 | x0.977 | - |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.358 | 0.358 | x1.000 | level | 12 of 24 | x1.000 | - |
| blake3-official / solo / OneMessage / 64 B | 7.330 | 7.491 | x1.022 | level | 12 of 24 | - | - |
| blake3-official / solo / OneMessage / 1536 B | 2.012 | 1.995 | x0.992 | level | 16 of 24 | - | - |
| blake3-official / solo / OneMessage / 2304 B | 1.315 | 1.312 | x0.997 | level | 11 of 24 | - | - |
| blake3-official / solo / OneMessage / 4 KiB | 0.672 | 0.680 | x1.012 | level | 15 of 24 | - | - |
| blake3-official / solo / OneMessage / 16 KiB | 0.405 | 0.413 | x1.018 | level | 11 of 24 | - | - |
| blake3-official / solo / OneMessage / 32 KiB | 0.273 | 0.276 | x1.009 | level | 12 of 24 | - | - |
| blake3-official / solo / OneMessage / 64 KiB | 0.198 | 0.201 | x1.012 | level | 13 of 24 | - | - |
| blake3-official / solo / IdleOneMessage / 4 KiB | 0.427 | 0.428 | x1.003 | level | 10 of 24 | - | - |
| blake3-official / solo / BriefIdleOneMessage / 4 KiB | 0.385 | 0.385 | x1.000 | level | 10 of 24 | - | - |
| blake3-official / solo / ContinuousMessages / 64 B | 1.468 | 1.197 | x0.816 | faster | 20 of 24 | x0.818 | - |
| blake3-official / solo / ContinuousMessages / 4 KiB | 0.356 | 0.356 | x1.000 | level | 16 of 24 | x1.000 | - |
| sha256-ring / solo / OneMessage / 64 B | 10.143 | 10.774 | x1.062 | level | 8 of 24 | - | - |
| sha256-ring / solo / OneMessage / 1536 B | 1.021 | 1.043 | x1.022 | level | 10 of 24 | - | - |
| sha256-ring / solo / OneMessage / 2304 B | 0.829 | 0.840 | x1.013 | level | 10 of 24 | - | - |
| sha256-ring / solo / OneMessage / 4 KiB | 0.722 | 0.737 | x1.021 | level | 9 of 24 | - | - |
| sha256-ring / solo / OneMessage / 16 KiB | 0.564 | 0.565 | x1.003 | level | 12 of 24 | - | - |
| sha256-ring / solo / OneMessage / 32 KiB | 0.530 | 0.532 | x1.004 | level | 9 of 24 | - | - |
| sha256-ring / solo / OneMessage / 64 KiB | 0.516 | 0.517 | x1.002 | level | 9 of 24 | - | - |
| sha256-ring / solo / IdleOneMessage / 4 KiB | 0.576 | 0.577 | x1.001 | level | 12 of 24 | - | - |
| sha256-ring / solo / BriefIdleOneMessage / 4 KiB | 0.523 | 0.522 | x0.998 | level | 13 of 24 | - | - |
| sha256-ring / solo / ContinuousMessages / 64 B | 1.275 | 1.196 | x0.938 | faster | 24 of 24 | x0.938 | - |
| sha256-ring / solo / ContinuousMessages / 4 KiB | 0.492 | 0.492 | x1.000 | level | 10 of 24 | x1.000 | - |

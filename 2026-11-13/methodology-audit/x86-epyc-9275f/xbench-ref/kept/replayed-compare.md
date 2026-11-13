compare: old side: bench 3363bee8ff5e clean; servil b5b988d8982b clean
compare: new side: bench e310174178ac clean; servil bf2da8b957f5 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / OneMessage / 64 B | 5.854 | 5.695 | x0.973 | level | 16 of 24 | - | - |
| blake3-servil-st / solo / OneMessage / 1536 B | 1.569 | 1.597 | x1.017 | level | 9 of 24 | - | - |
| blake3-servil-st / solo / OneMessage / 2304 B | 1.359 | 1.407 | x1.035 | level | 4 of 24 | - | - |
| blake3-servil-st / solo / OneMessage / 4 KiB | 0.691 | 0.737 | x1.067 | level | 4 of 24 | - | - |
| blake3-servil-st / solo / OneMessage / 16 KiB | 0.407 | 0.423 | x1.039 | level | 7 of 24 | - | - |
| blake3-servil-st / solo / OneMessage / 32 KiB | 0.257 | 0.268 | x1.041 | level | 6 of 24 | - | - |
| blake3-servil-st / solo / OneMessage / 64 KiB | 0.180 | 0.185 | x1.029 | level | 8 of 24 | - | - |
| blake3-servil-st / solo / IdleOneMessage / 4 KiB | 0.367 | 0.368 | x1.001 | level | 11 of 24 | - | - |
| blake3-servil-st / solo / BriefIdleOneMessage / 4 KiB | 0.347 | 0.348 | x1.003 | level | 6 of 24 | - | - |
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.851 | 0.843 | x0.990 | level | 14 of 24 | x0.990 | - |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.321 | 0.321 | x1.000 | level | 9 of 24 | x1.001 | - |
| blake3-official / solo / OneMessage / 64 B | 7.301 | 7.132 | x0.977 | level | 14 of 24 | - | - |
| blake3-official / solo / OneMessage / 1536 B | 1.870 | 1.866 | x0.998 | level | 8 of 24 | - | - |
| blake3-official / solo / OneMessage / 2304 B | 1.230 | 1.237 | x1.005 | level | 9 of 24 | - | - |
| blake3-official / solo / OneMessage / 4 KiB | 0.603 | 0.613 | x1.017 | level | 9 of 24 | - | - |
| blake3-official / solo / OneMessage / 16 KiB | 0.386 | 0.391 | x1.013 | level | 8 of 24 | - | - |
| blake3-official / solo / OneMessage / 32 KiB | 0.258 | 0.259 | x1.001 | level | 14 of 24 | - | - |
| blake3-official / solo / OneMessage / 64 KiB | 0.186 | 0.187 | x1.005 | level | 11 of 24 | - | - |
| blake3-official / solo / IdleOneMessage / 4 KiB | 0.364 | 0.364 | x1.000 | level | 11 of 24 | - | - |
| blake3-official / solo / BriefIdleOneMessage / 4 KiB | 0.344 | 0.344 | x0.999 | level | 13 of 24 | - | - |
| blake3-official / solo / ContinuousMessages / 64 B | 1.318 | 1.069 | x0.811 | faster | 21 of 24 | x0.811 | - |
| blake3-official / solo / ContinuousMessages / 4 KiB | 0.319 | 0.319 | x1.000 | level | 15 of 24 | x1.000 | - |
| sha256-ring / solo / OneMessage / 64 B | 9.462 | 9.444 | x0.998 | level | 12 of 24 | - | - |
| sha256-ring / solo / OneMessage / 1536 B | 0.983 | 0.968 | x0.985 | level | 14 of 24 | - | - |
| sha256-ring / solo / OneMessage / 2304 B | 0.767 | 0.775 | x1.010 | level | 9 of 24 | - | - |
| sha256-ring / solo / OneMessage / 4 KiB | 0.669 | 0.680 | x1.016 | level | 6 of 24 | - | - |
| sha256-ring / solo / OneMessage / 16 KiB | 0.515 | 0.515 | x1.000 | level | 9 of 24 | - | - |
| sha256-ring / solo / OneMessage / 32 KiB | 0.481 | 0.480 | x0.999 | level | 12 of 24 | - | - |
| sha256-ring / solo / OneMessage / 64 KiB | 0.466 | 0.466 | x1.000 | level | 12 of 24 | - | - |
| sha256-ring / solo / IdleOneMessage / 4 KiB | 0.491 | 0.491 | x1.000 | level | 10 of 24 | - | - |
| sha256-ring / solo / BriefIdleOneMessage / 4 KiB | 0.469 | 0.467 | x0.996 | level | 12 of 24 | - | - |
| sha256-ring / solo / ContinuousMessages / 64 B | 1.121 | 1.072 | x0.956 | faster | 23 of 24 | x0.956 | - |
| sha256-ring / solo / ContinuousMessages / 4 KiB | 0.442 | 0.442 | x0.999 | level | 19 of 24 | x0.999 | - |

compare: old side: bench c28044174c7d clean; servil 0145287bd520 clean
compare: new side: bench c28044174c7d clean; servil 63a89fb21bc8 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.696 | 0.704 | x1.011 | level | 3 of 16 | x1.011 | x1.017 |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 0.692 | 0.690 | x0.997 | level | 9 of 16 | x0.997 | x0.972 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.262 | 0.262 | x0.999 | level | 9 of 16 | x1.000 | x0.964 |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.188 | 0.188 | x1.002 | level | 8 of 16 | x1.002 | x1.035 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.278 | 0.271 | x0.978 | level | 13 of 16 | x0.975 | x0.971 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.0887 | 0.0898 | x1.012 | level | 4 of 16 | x1.023 | x1.013 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0523 | 0.0483 | x0.922 | faster | 16 of 16 | x0.996 | x0.936 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0464 | 0.0403 | x0.869 | faster | 16 of 16 | x1.004 | x0.943 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.286 | 0.280 | x0.979 | level | 12 of 16 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.109 | 0.106 | x0.969 | level | 13 of 16 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.0611 | 0.0615 | x1.006 | level | 9 of 16 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.0511 | 0.0466 | x0.911 | faster | 16 of 16 | - | - |

Load: busy: other programs kept 0.25 CPUs busy on average, 1.08 in the busiest window; busy in 1 of 478 windows (367.9-369.0 s). Runs: 15 rounds, each contender once on each input in each.

| input | warm: official | warm: b3sum | cold: official | cold: b3sum |
|---|---:|---:|---:|---:|
| 4 KiB | 1.25 ms | 1.22 ms ×0.976 | 1.67 ms | 1.44 ms ×0.915 |
| 64 KiB | 1.16 ms | 1.12 ms ×0.966 faster | 1.40 ms | 1.27 ms ×0.911 faster |
| 1 MiB | 1.17 ms | 1.26 ms ×1.074 slower | 2.11 ms | 1.79 ms ×0.849 faster |
| 16 MiB | 2.02 ms | 2.06 ms ×1.019 | 8.53 ms | 5.87 ms ×0.693 faster |
| 256 MiB | 15.7 ms | 13.4 ms ×0.853 faster | 141 ms | 79.1 ms ×0.560 faster |
| 1 GiB | 57.9 ms | 47.7 ms ×0.824 faster | 724 ms | 312 ms ×0.432 faster |
| 1000 x 16 KiB | 41.1 ms | 5.45 ms ×0.133 faster | 86.0 ms | 12.9 ms ×0.150 faster |
| 1000 x 16 KiB, a process each | 1.07 s | 1.05 s ×0.982 | 1.14 s | 1.11 s ×0.971 |
| mixed tree, 1000 files, 74 MiB | 35.3 ms | 7.35 ms ×0.208 faster | 154 ms | 31.4 ms ×0.203 faster |
| 16 x 64 MiB | 59.7 ms | 51.4 ms ×0.860 faster | 569 ms | 324 ms ×0.569 faster |

- **Faster there:** 64 KiB (warm and cold); 256 MiB (warm and cold); 1 GiB (warm and cold); 1000 x 16 KiB (warm and cold); mixed tree, 1000 files, 74 MiB (warm and cold); 16 x 64 MiB (warm and cold); 1 MiB (cold); 16 MiB (cold).
- **Level there:** 4 KiB (warm and cold); 16 MiB (warm); 1000 x 16 KiB, a process each (warm and cold).
- **Slower there:** 1 MiB (warm).

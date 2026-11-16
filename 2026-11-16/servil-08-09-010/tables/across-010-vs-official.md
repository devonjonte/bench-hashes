**b3sum 0.10 candidate against official b3sum 1.8.7** (6 machines; time ratio, below 1 is faster)

| input | warm: range | warm: machines faster / slower | cold: range | cold: machines faster / slower |
|---|---:|---:|---:|---:|
| 4 KiB | ×0.10–×0.46 | 6 / 0 | ×0.13–×0.49 | 6 / 0 |
| 64 KiB | ×0.11–×0.48 | 6 / 0 | ×0.14–×0.68 | 6 / 0 |
| 1 MiB | ×0.12–×0.60 | 6 / 0 | ×0.27–×0.82 | 6 / 0 |
| 16 MiB | ×0.33–×0.77 | 6 / 0 | ×0.42–×0.67 | 6 / 0 |
| 256 MiB | ×0.50–×0.86 | 6 / 0 | ×0.52–×0.71 | 6 / 0 |
| 1 GiB | ×0.52–×0.97 | 6 / 0 | ×0.50–×0.78 | 6 / 0 |
| 1000 x 16 KiB | ×0.11–×0.28 | 6 / 0 | ×0.04–×0.12 | 6 / 0 |
| 1000 x 16 KiB, a process each | ×0.08–×0.38 | 6 / 0 | ×0.11–×0.51 | 6 / 0 |
| mixed tree, 1000 files, 74 MiB | ×0.10–×0.37 | 6 / 0 | ×0.08–×0.14 | 6 / 0 |
| 16 x 64 MiB | ×0.35–×0.93 | 6 / 0 | ×0.41–×0.64 | 6 / 0 |

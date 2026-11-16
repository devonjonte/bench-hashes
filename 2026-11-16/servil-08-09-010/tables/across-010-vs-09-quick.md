**b3sum 0.10 candidate (ad163558) against b3sum 0.9.0 — quick suite (5 rounds, includes `100 x 16 KiB`)** (6 machines; time ratio, below 1 is faster)

| input | warm: range | warm: machines faster / slower | cold: range | cold: machines faster / slower |
|---|---:|---:|---:|---:|
| 4 KiB | ×0.88–×1.06 | 0 / 0 | ×0.93–×1.02 | 0 / 0 |
| 1 MiB | ×0.79–×0.93 | 3 / 0 | ×0.82–×1.06 | 1 / 0 |
| 16 MiB | ×0.94–×1.15 | 0 / 0 | ×0.69–×0.88 | 4 / 0 |
| 100 x 16 KiB | ×1.02–×1.08 | 0 / 3 | ×0.60–×1.30 | 0 / 2 |
| 100 x 16 KiB, a process each | ×1.01–×1.04 | 0 / 1 | ×1.00–×1.05 | 0 / 2 |
| mixed tree, 100 files, 5 MiB | ×0.89–×1.00 | 0 / 0 | ×0.92–×1.12 | 0 / 0 |
| 4 x 16 MiB | ×0.57–×1.01 | 3 / 0 | ×0.55–×0.68 | 6 / 0 |

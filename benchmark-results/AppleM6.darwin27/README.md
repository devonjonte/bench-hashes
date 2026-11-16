# Apple M6 measurements for bench-hashes 0.23

These runs are of the dedicated timing Mac, a rented machine that runs nothing
else. Its provider's remote-desktop agent stays, and other programs crossed
clocks' load limit in one or two windows of each run, so the recorded times may
be slightly slower than this machine runs when silent. The map's section
introductions and the overview show each run's own load.

| run | measured | other programs' load |
|---|---|---|
| library, job 3207 | November 16, 2026 | busy in 2 of 408 windows; mean 0.12 CPUs; peak 1.11 |
| b3sum, job 3208 | November 16, 2026 | busy in 1 of 478 windows; mean 0.25 CPUs; peak 1.08 |
| crowd, job 3209 | November 16, 2026 | the programs themselves |

All three ran on mains power with low-power mode off. The file paths name
the runner's home as `<runner-home>`; every measured value is as recorded.
Earlier releases' Apple M6 records were of a shared workstation of the same kind.

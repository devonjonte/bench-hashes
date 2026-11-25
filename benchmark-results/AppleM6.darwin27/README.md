# Apple M6 measurements for BLAKE3-Servil 0.11.0 (bench-hashes 0.24)

These runs are of the dedicated timing Mac, a rented machine that runs nothing
else. Its provider's remote-desktop agent stays. Each run's load read quiet; the
map's section introductions and the overview show each run's own load.

| run | measured | other programs' load |
|---|---|---|
| library (`20261125T061134Z-john-benchmark-rel011v2-b9aefc1`) | November 25, 2026 | quiet; mean 0.06 CPUs; peak 0.58 |
| b3sum (`20261125T061134Z-john-b3sum-rel011v2-b9aefc1`) | November 25, 2026 | quiet; mean 0.18 CPUs; peak 0.73 |
| crowd (`20261125T0654Z-devon-crowd-rel0110-b9aefc1-m6`) | November 25, 2026 | the programs themselves |

All three ran on mains power with low-power mode off at BLAKE3-Servil `0.11.0`
(`b9aefc11e1e422edf483f9b68cec57aaf04de560`) and `bench-hashes` `303fff16`.
The file paths name the runner's home as `<runner-home>`; every measured value
is as recorded. Earlier releases' Apple M6 records were of a shared workstation
of the same kind.

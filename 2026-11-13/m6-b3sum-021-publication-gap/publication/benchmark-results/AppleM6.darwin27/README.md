# Apple M6 measurements for bench-hashes 0.21

The library and file-command runs are **qualified workstation snapshots**.
Other programs crossed clocks' load limit in one window of each run. Their
recorded times may be slower than this machine runs when quiet. The map's
section introductions and the overview show each run's own load qualification.

| run | measured | other programs' load |
|---|---|---|
| library, job 3076 | November 12, 2026 | busy in 1 of 362 windows; mean 0.33 CPUs |
| b3sum, job 3095 | November 13, 2026 | busy in 1 of 486 windows; mean 0.26 CPUs; peak 1.37 |

Both use bench `9434d50e50de4b93dc962ccbf52346db5442358e`
(0.21.0+84236bf0f0c832f6619b8f99ce7bc878c7800ef0) and BLAKE3-Servil
`2037118ca1da85710aef55d7f13b3abd9095b485`. The file-command run completed all
15 rounds on mains power, with low-power mode off at both ends. Every cold run
read from storage by its counts. Child cycle counts are present; energy is
unobserved. This record supports qualified observations of these runs.

The earlier file-command run, job 3077, remains preserved with its 15/490-window
busy finding. The complete rerun record and original release evidence are on
the data branch:

- [Rerun, samples, power/source record and load windows](https://github.com/devonjonte/bench-hashes/tree/data/2026-11-13/m6-b3sum-021-publication-gap).
- [Original release records](https://github.com/devonjonte/bench-hashes/tree/data/2026-11-12/release-021-apple-m6).
- [Publication follow-up](https://github.com/servil-software-factory/bench-hashes/issues/201).

Derived map and overview use the historical 0.21 reader and library pin, with
presentation-only backports at
[`d2028f70`](https://github.com/devonjonte/bench-hashes/commit/d2028f70).
The renderer retains that release's samples reader, clocks and arithmetic.
Its overview matches the current presentation byte-for-byte, including all 308
plotted bar speeds. The map's data matches the pristine historical renderer
apart from load wording. The public b3sum files replace the runner's home path
with `<runner-home>`; measured values, counts and load windows stay unchanged.

The two manifests cover this folder's published files. Devon publishes this
snapshot with its visible load qualification rather than rerun indefinitely
for a quiet flag. The original evidence remains available for later study.

— Devon Jonte

The one-bench check has finished: candidate against 0.9.0 on the EPYC 7443 pair still measured mt OneMessage 64 B **+13.6%** over 64 pairs. That reading remains unresolved. My earlier suggestion that the two-bench control cleared the release marks exceeded its evidence.

I have [corrected the mechanism claims on bench-hashes #3](https://github.com/devonjonte/bench-hashes/issues/3#issuecomment-6960418528). The controls demonstrate benchmark-context sensitivity; code placement and a specific front-end cause still need isolation. A fixed-calibration replay now crosses snapshotted binaries with CPU/socket placement.

Next move: mine for that diagnosis and corrected evidence. John retains the release decision.

— Devon Jonte

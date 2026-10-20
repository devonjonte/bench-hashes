# BLAKE3 servil beside commonware's batch kernels, i7-12700K, October 20, 2026

One bench-hashes run (`--contenders blake3-servil-st,blake3-servil-mt,blake3-official,blake3-commonware`,
59 s, load quiet: 0.11 CPUs). Servil at devonjonte/BLAKE3 `servil` 76e8dc1; commonware's kernels from
commonwarexyz/monorepo pull request #4982 at 3aa183f0, in bench-hashes' `contenders/commonware-blake3`.

Result: in all 76 cells where commonware takes part (batches of 64-byte messages: now and then, nonstop,
lent, after a pause), servil is faster; servil's time as a share of commonware's runs 0.20 to 0.82, median 0.60.
Map: https://devonjonte.github.io/bench-hashes/beside/commonware-2026-10-20/bench-hashes.map.html

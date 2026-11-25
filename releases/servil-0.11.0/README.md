# BLAKE3-Servil 0.11.0 benchmarks

Measured on 2026-11-25 across five dedicated bare-metal machines using `bench-hashes` `303fff16dfcd7a7de6d5d3c3595285359ba32d84` (`0.24.0`):

- **Measured commit:** `b9aefc11e1e422edf483f9b68cec57aaf04de560` (`0.11.0+ea57cdd210ac501865d5f6d1ab20d3f4108de0dc`)
- **Final `0.11.0` release stamp:** `15ad383b5c9f849c548940b2181df66212a295cf` (`0.11.0+2c43b150bd18c89b6c08a133446c51a3fe6981bc`, byte-identical shipped library and `b3sum` code; the only diff from `b9aefc11` drops 6 newly-killed rows from `tools/mutants/*known-x86_64.txt`)

## Machines measured (all runs `quiet`)

| Machine | OS / CPUs | 64 KiB stream (`mt`) vs SHA-256 | 128 MiB (`mt`) vs SHA-256 | 1000 files `b3sum` vs `sha256sum` | Detailed map |
| --- | --- | --- | --- | --- | --- |
| **Apple M6** | macOS, 12 CPUs | 27 GB/s (**7.5×**) | 22 GB/s (**6.2×**) | 9.9 GB/s (**4.9×**) | [map](../../benchmark-results/AppleM6.darwin27/bench-hashes.map.html) |
| **AMD Ryzen 7 9700X** (Zen 5) | Linux, 16 CPUs | 35 GB/s (**13×**) | 13 GB/s (**5.8×**) | 20 GB/s (**9.3×**) | [map](../../benchmark-results/AMDRyzen79700X8CoreProcessor.linux70043generic/bench-hashes.map.html) |
| **AMD EPYC 9255** (Zen 5) | Linux, 48 CPUs | 27 GB/s (**13×**) | 29 GB/s (**15×**) | 21 GB/s (**13×**) | [map](../../benchmark-results/AMDEPYC925524CoreProcessor.linux70043generic/bench-hashes.map.html) |
| **AMD EPYC 7443** (Zen 3, node 0) | Linux, 96 CPUs (48 on node 0) | 20 GB/s (**11×**) | 13 GB/s (**7.7×**) | 9.9 GB/s (**8.2×**) | [map](../../benchmark-results/AMDEPYC744324CoreProcessor.linux70042generic/bench-hashes.map.html) |
| **Intel Xeon Gold 6330** (Ice Lake, node 0) | Linux, 112 CPUs (56 on node 0) | 14 GB/s (**18×**) | 9.8 GB/s (**14×**) | 11 GB/s (**17×**) | [map](../../benchmark-results/IntelRXeonRGold6330CPU200GHz.linux70043generic/bench-hashes.map.html) |

## Cropped announcement excerpts

Rendered directly from [`index.html`](../../index.html):

- [`blake3-servil-0.11.0-vs-sha256.png`](blake3-servil-0.11.0-vs-sha256.png): headline starburst summary plus per-workload comparison grid (BLAKE3-Servil `0.11.0` multi-threaded vs SHA-256 across Apple M6, AMD Ryzen 7 9700X, and Intel Xeon Gold 6330).
- [`blake3-servil-0.11.0-vs-sha256-hero.png`](blake3-servil-0.11.0-vs-sha256-hero.png): compact wide headline banner alone.

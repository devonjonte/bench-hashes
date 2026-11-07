# A part wakes a worker when none is looking (BLAKE3 next 85bf73a6 -> candidate/devon-busy-wake), i7-12700K, November 7, 2026

Suites 213 pass; the formerly hanging receiver test 0 hangs in 40 runs (about 1 in 3 before); Shuttle 10/10; check-builds every build; a change's mutation check 12 mutants, no new survivor; check --points over 11 cells (64 KiB, 1 MiB, 128 MiB, continuous 4 KiB and 64 KiB, interleaved and turn 256, lent 64 B, continuous batch 1024, receive saturated and 2 us): no cell slower in either stage.

— Devon Jonte

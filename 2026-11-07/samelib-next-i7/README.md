# The release gate's determinism test on bench-hashes next (i7-12700K, November 7, 2026)

Question: with the kept-buffer fix (bench-hashes #145), does the same library
retire the same instructions under two builds of the bench, as the release
procedure requires (CONTRIBUTING, Releases step 4: the same-library check's
"instructions moved" line must name no cell)?

`check --fork BLAKE3-m3 --new origin/main --against origin/main --old-bench
86f1ae66 --cells all` from bench next (fa6a661a), BLAKE3-Servil 6e0dffd3 on
both sides: **no cell slower** in the first stage or the 64-pair second, and
**no level cell's instructions moved beyond 0.5%** in either. The 64 B stream
cells that moved 3.6-3.9% on November 6 (bench-hashes #144) read level.

— Devon Jonte

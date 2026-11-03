# The i7-12700K's release runs at bench-hashes 0.20.0 (tag 74e3edaf), blake3-servil 0.8 (b5b988d8)

CONTRIBUTING "Releases" step 4, `run.sh` (all under run-bounded.py), then
`old-aa.sh`. Governor powersave with EPP performance (no root to set
`performance`; the same as the 0.8 and 0.19.3 records). Kernel 7.0.0-42;
tailscaled and nym-vpnd pinned to CPUs 16-19.

| run | result |
|---|---|
| full, `build-against`, `--all --expect-servil b5b988d8` | quiet (0.14 CPUs; 0.96 in the busiest window), 320 s; names 0.20.0 and b5b988d8 clean; `shared placements: one cache: CPUs 0 and 2; two caches: none` |
| b3sum, `LAYOUTS=4`, files on ext4 | quiet (0.16; 0.89), 517 s |
| crowd, 20 programs | 24 s; servil mt 23.5 GB/s x5.71 at 1 KiB, 29.7 x2.99 at 64 KiB; official mt 19.9 x1.10, 16.4 x2.07 |
| release check (the fork at b5b988d8 against itself, `--cells all`) | first stage no cell slower; **second stage SLOWER servil st IdleOneMessage 512 B +4.5%** over 64 pairs of the same code (pairs -12% to +51%): an after-pause cell's idle-state bimodality (bench-hashes #117), a false positive |
| same-library check, `--old-bench` 0.19.7 | **crashed**: 0.19.7 writes v7 samples and 0.20 reads v8 alone (fixed to stop at once, PR #121) |
| the 0.19.7 bench's own check of the same library (`old-aa.sh`, e2b29f98) | no cell slower, both stages, 36 min |

`records/` is the folder as the PR carries it (the map redrawn from the
three samples files; SHA-256 and BLAKE3 manifests). `check-pairs/` and
`old-aa-pairs/` hold the checks' samples (no binaries).

**Posted.** bench-hashes PR records/i7-0.20.0; #118.

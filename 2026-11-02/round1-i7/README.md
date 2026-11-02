# Round 1: current servil against the 0.8 release (i7-12700K, November 2)

**Question:** has `servil` moved since 0.8? bench 0.19.5 (dd6478f1),
`check --fork servil@057d1eec --against b5b988d8 --cells all`.
Command: `run.sh`.

**Verdict:** no cell slower, both stages (1833 s). The second stage's 8
suspects (idle 2, idle 32, idle 4 KiB, 1024, 3, 64, 64 KiB, continuous
16 MiB) read level on 64 pairs. The library's hashing code differs from
0.8 by #210 alone (ffi_partial's tables), which the x86 kernels never
reach for the cells here.

`check-spoiled.*`: a first attempt, no verdict (exit 2): my own cargo
builds beside it, named by the load line ("the busiest: cargo 6.62
CPUs"), the detector working as designed.

**Posted:** nowhere yet (the morning report).

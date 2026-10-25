# Every loop aligned to 64 bytes, the 0.8 integration against `servil` + #164, i7-12700K

**Question:** do the single-thread LentBatches cells at 64-1024 messages
read 1-4% slower because the new bench inlines the library's batch loop
somewhere new, so the loop lands at a new alignment (the #65/#69 family)?
With every loop aligned to 64 bytes on both sides, an alignment cause
would leave those cells level.

**Commits:** new, devonjonte/BLAKE3 `candidate/devon-release-0.8` 612e845
(bench d21cdf36); old, `candidate/devon-kernel-names-john` bfbda19 (bench
5be5f236). The new side was built from the 612e845 working tree while
the Windows cleanup (#169) was being edited there. On Linux those edits
change no compiled code: every branch they remove was Windows-only, and
`cfg(all(blake3_sse41_ffi, not(target_os = "windows")))` equals
`cfg(blake3_sse41_ffi)` off Windows.

**Command:** `RUSTFLAGS="-C llvm-args=-align-loops=64" bench-hashes check
--against bfbda19 --old-bench 5be5f236 --cells all --pairs 8 --keep
samples` under run-bounded.py, October 25, 22:22 UTC. `check` passes
RUSTFLAGS to both builds. `stage1-all-cells.txt` is `bench-hashes
compare` over the first stage's 8 pairs.

**Verdict, the question:** alignment is not the cause. With every loop
aligned, st solo LentBatches read 16: x0.985 (7 of 8 pairs faster), 64:
x1.022 (1 of 8), 256: x1.018 (1 of 8), 1024: x1.035 (0 of 8), 4096:
x0.985: the same pattern as the default layout.

**Verdict, a second finding, corrected:** the second stage (16 fresh
pairs) confirmed 7 cells: mt solo IdleManyMessages 2, 3, 4, 6, 16, 24 at
+8.0 to +13.9%, and mt solo ManyMessages 2 at +12.0%. Taken whole, this
first stage matches the default layout's (`../release-08-fanout-i7`): solo
after-a-pause cells median x1.002, 24% above +5% here; x1.007, 18% there.
The same IdleManyMessages cells read +8% to +22% in that run's first stage
too, and its second stage judged them level. So the difference between the
runs is bench-hashes #81's flicker at the threshold, with no visible part
for layout. (A first reading here, "the cost depends on layout", was
withdrawn on #125.) What remains is a possible cost in mt batches of 2-32
messages after a pause, measured next in `../idle-mt-i7`.

**Posted:** BLAKE3 #125.

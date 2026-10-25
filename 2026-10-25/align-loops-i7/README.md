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

**Verdict, a second finding:** under this layout the after-a-pause
cells at small counts read slower. The second stage (16 fresh pairs)
confirmed 7 cells: mt solo IdleManyMessages 2, 3, 4, 6, 16, 24 at +8.0
to +13.9%, and mt solo ManyMessages 2 at +12.0%. The same comparison
under the default layout (`../release-08-fanout-i7`) read the
after-a-pause cells level at the median (x1.007). So the cost of waking
after a pause depends on where the code lands, as a user's own build
can change it. One suspect mechanism: a spin or wait counted in
iterations, whose length then varies with the loop's speed.

**Posted:** BLAKE3 #125.

# The cold 3839 B one-message cost (BLAKE3 #119), found and fixed, i7-12700K

**Question:** 0.8 ships a +7-8% cost on one message of 3-4 KiB hashed
after other work (cache-cold), the library's, cause unlocated. Where is it?

**Probe** (`cold_probe.rs`, `build.sh`, `run.py`): the bench's OneMessage
cell in miniature: read 64 MiB, write the input, time one
`convenience::hash` (TSC), 200 a process, pinned to P core 2, processes
alternating between builds; the median of process medians.

**Findings:**
- `run-3839`: release b5b988d8 x1.079 against bfbda192: the cost
  reproduces. `run-mb`: their merge base c75daebf is fast (x1.008).
- `find`, `points`, `later`: no single commit; the cost drifts with commits
  that touch no one-message code (d34af741 x1.011, 58381c42 x1.053): a
  code-placement effect.
- `counters.py`: slow builds stall ~650-780 more cycles a round on
  instruction-cache misses, and miss ~50 more code lines than the base.
- perf sampling of L2 code-read misses: the misses sit in the partial-chunk
  pass (3 chunks + a partial): at the base the Rust-intrinsics kernel
  (11.7 KB), at the release the generated assembly (7.5 KB) plus its Rust
  wrapper `ffi_partial::hash_chunks_with_partial_sse41`: **20.6 KB**, its
  16-by-4 lens and flags tables unrolled entry by entry.
- **Fix** (devonjonte/BLAKE3 `candidate/devon-partial-params` f108640d):
  the tables filled whole and patched in three places: the wrapper 1.9 KB
  (AVX2's 3.2 -> 2.4 KB). `fix`: the cold call x0.979 of the base (servil
  x1.055). `check/`: `check --against servil --cells all`: no cell slower;
  mt OneMessage 3839 B -6.4%; mutation check: 9 mutants, no new survivor.

**Posted:** BLAKE3 #119.

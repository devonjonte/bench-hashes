# Sam's whole-composition mutation gate on an AVX2-only machine (BLAKE3 #325), i7-12700K

**Question.** The 1cbdf5d7 gate against 0b5bf7b7 found no new survivor on Sam's EPYC (AVX-512). Does it hold on an x86 machine without AVX-512?

**Run.** `BUILD-CONFIG.txt` has the source, command, tool versions, rustc cfg, CPU flags and build arguments. `run/` and `confirm/` hold every shard's outcomes.json, caught/missed/timeout/unviable lists and per-mutant nextest logs; `MISSED-PLACES.txt` lists every missed place from both stages.

**Result.** 163 mutants, 12 names with a new survivor, all in `src/ffi_output.rs` (`held_groups`, `input`, `lanes`). Some places of those names were caught: one, `held_groups` 130:22 `==`→`!=`, by a test killed with SIGILL, an AVX-512 instruction on this AVX2 CPU (`run/shard3/log/src__ffi_output.rs_line_130_col_22.log`). The missed places are the open coverage hold. Time: 406 s with the source's check.py; 383-384 s with devonjonte candidate/devon-mutants-reuse-worktrees.

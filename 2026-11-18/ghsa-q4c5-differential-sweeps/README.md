# Differential length sweeps, cold-verified b3sum sweeps, and #421/#455 controls (November 18, 2026)

## Questions

1. Across dense message lengths, batch shapes, `Pipeline` streams, mixed-size incremental updates, and XOF seeks, do `blake3-servil` **0.9.0** (`bf2da8b9`), **0.9.1** (`2c60420c`), and the **0.10.0** candidates (`2ef4c443`, `daef4ba8`) match official `blake3` 1.8.7 on x86-64 (AVX2, AVX-512), Arm NEON, and Apple M6 SME2 across thread-pool sizes?
2. Does `b3sum` (`0.9.0` and `0.10.0` candidate `2ef4c443`) match official `b3sum` 1.8.7 across ~8,000 file lengths (warm, `--num-threads 1`, `--no-mmap`, and `mincore`-verified cold) and 150 multi-file batches?
3. Do the runtime tree-coordinate and handoff invariants added in `d83c3eb9` (#421) and `021bed3d` / `daef4ba8` (#455) have test teeth when mutated clause by clause?

## Verdicts

- **Linux non-SME2 differential sweeps (`linux-sweeps/`):** **93,986,376 comparisons, 0 wrong** across `x86-9700x` (Ryzen 9700X), `x86-icelake-2` (2× Xeon Gold 6330), `x86-avx2` (2× EPYC 7443), `x86-workhorse` (Threadripper PRO 7975WX, 14 pool sizes from 2 to 64 threads), and `arm-vm` (AmpereOne). The initial `x86-workhorse/length-sweep-2ef4c443` run (exit 128 before cloning the repository) is preserved beside `-b`.
- **Apple M6 SME2 differential sweeps (`apple-m6/`):** **All 3 runs passed with 0 wrong digests** across 13 pool sizes (`own` = 12, plus explicit pools of 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14, and 16 threads):
  - `0029-v0.9.1-2c60420c`: published `v0.9.1+b01b322a` (`GHSA-q4c5-2759-8c8x` fix), 121/121 tests passed.
  - `0030-0.10-repair-23bf6371`: `2ef4c443` + bounded prefix-settling fix, 132/132 tests passed.
  - `3405-daef4ba8`: checked `Pipeline` and `Hasher` handoffs candidate `daef4ba8` (#455), 138/138 tests passed.
- **`b3sum` CLI sweeps (`b3sum-sweeps/`):**
  - Diagnostic `x86-9700x/b3sum-sweep-2ef4c443-d` showed that single-shot `POSIX_FADV_DONTNEED` immediately after a mapped `b3sum` child exited left pages resident (`10,230` of `23,580` drops), because kernel `exit_mmap` teardown races immediate advice.
  - Repeating `POSIX_FADV_DONTNEED` at 5 ms intervals until `mincore` reports 0 resident pages (`b3sum-sweep-2ef4c443-e`): **0 pages left cached after 2 s** on all four hosts (`x86-9700x`, `x86-epyc-9275f`, `x86-icelake-2`, `x86-avx2`), **36,408 runs per host (145,632 total), 0 wrong digests**.
- **Tree-coordinate and handoff controls (`tools/`, `review-455/`):**
  - `d83c3eb9` (`src/throughput.rs`): **38 of 38** assertion/place mutants caught (`tools/library-mutants.tsv`).
  - `021bed3d` + `daef4ba8`: all 4 Shuttle models and **9 of 9** planted concurrency faults in `pipeline_model_controls.py` caught (`review-455/check-builds.txt`), plus dense `length_sweep` passed on Threadripper (`review-455/length-sweep.txt`). Clause-level assertion mutation (`review-455/mutants-455-run.stdout.txt`) identified that testing `[left, left]` and `[right, right]` in `Hasher::update_with` / `update_each_with` closes the `&& -> ||` mutant in `Cv::halves_bytes` (reported on [BLAKE3 #455](https://github.com/servil-software-factory/BLAKE3/issues/455#issuecomment-6984022201)).

## Citations

- Advisory: [GHSA-q4c5-2759-8c8x](https://github.com/servil-software-factory/BLAKE3/security/advisories/GHSA-q4c5-2759-8c8x)
- Reviews: [BLAKE3 #421](https://github.com/servil-software-factory/BLAKE3/issues/421#issuecomment-6974819590), [BLAKE3 #455](https://github.com/servil-software-factory/BLAKE3/issues/455#issuecomment-6984022201)
- After-action report: [`chapters/08-after-action-wrong-hash-0.9.0.md`](https://github.com/devonjonte/zookos-software-engineering-style/blob/main/chapters/08-after-action-wrong-hash-0.9.0.md)

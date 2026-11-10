# Two mutation runs on the i7-12700K for BLAKE3 #342, November 10, 2026

**Question** (Sam Shackleton, [BLAKE3 #342](https://github.com/servil-software-factory/BLAKE3/issues/342)):
on a physical AVX2 machine with no AVX-512, (1) how long does the
composition's change-scoped mutation check take with the tool now on
`next`, and what does its survivor path print; (2) what do the mutants of
two x86 files on no list do?

## 1. The composition's check (`run1.sh`, `run1.stdout.txt`)

`python3 tools/mutants/check.py --since 0b5bf7b7` in
`samshackleton-tech/BLAKE3` at 720cf198, twice: with fresh shard
worktrees, then with them kept.

| | time | shard time: build, test | survivors' release builds |
|---|---|---|---|
| fresh | 268 s | 588 s, 206 s | 57 s |
| kept | 215 s | 397 s, 216 s | 48 s |

Both: 102 of the change's 163 mutants planted, **9 names with a new
survivor** (14 places), all in `src/ffi_output.rs`: `lanes` (the AVX-512
match arm deleted), `held_groups` (seven names), `input` (two names).
None of the 14 builds to the same code in a release build. Exit 1.
The EPYC 9255's figures in the issue are 60 s fresh and 35 s kept, with
no survivor.

## 2. The two unlisted files (`run2.sh`, `run2.stdout.txt`, `i7-unlisted.json`)

`unlisted-run.py` (from `samshackleton-tech/bench-hashes` at cbd3f5f7,
copied here) in a checkout of `next` 96c4e664, six shards, over
`src/ffi_chunk_root.rs` and `src/ffi_avx512_32.rs`: 20 mutants, 15
caught, 1 unviable, **4 survive**, no time-out:

- `src/ffi_avx512_32.rs`: `parent_entry` replaced with a default; `entries`
  replaced with defaults (two forms);
- `src/ffi_chunk_root.rs`: `test::variants` replaced with `vec![false]`
  (the one that survives on AVX-512 too).

**Machine.** i7-12700K, Linux, AVX2 and no AVX-512, 14 GiB; each run alone
on the machine under `run-bounded.py`.

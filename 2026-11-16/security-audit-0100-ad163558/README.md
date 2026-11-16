# Security audit record for `blake3-servil 0.10.0` baseline (`ad163558`)

Retained for [BLAKE3 #410 (retain independent deep security audits)](https://github.com/servil-software-factory/BLAKE3/issues/410) and indexed under [BLAKE3 #433 (Release 0.10.0 readiness index)](https://github.com/servil-software-factory/BLAKE3/issues/433).

## Metadata

| Field | Value |
|---|---|
| Agent and harness | Devon Jonte (`pi` coding agent harness) |
| Provider and model | `openrouter` / `google/gemini-4-carbon` (`2026-11-16T17:48:14Z` to `18:42:34Z`) |
| Repository | `servil-software-factory/BLAKE3` |
| Audited commit | `ad163558bd882ca7768e59764c6588fce0f285f9` (`release/0.10.0`, version `0.10.0+4e8634b71df01d406906025b4ccda17a828a2aa7`, code parent `4e8634b71df01d406906025b4ccda17a828a2aa7`) |

Verbatim prompt (Zooko, `2026-11-16T17:43:58Z`):

> Please do a security audit of the current candidate for blake3-servil 0.10. The goal is to find any bug, documentation error or omission, or unintentional "sharp edge" in an API, which could allow a well-intentioned but perhaps slightly careless user to be harmed by an attacker. Prioritize RCE/memory-misuse and wrong-hash-value-result as the important harms to prevent.

## Scope examined

| Area | Files read |
|---|---|
| `blake3-servil-core` (`src/`, `build.rs`) | `lib.rs`, `convenience.rs`, `throughput.rs`, `incremental.rs`, `hasher.rs`, `tree.rs`, `block.rs`, `many.rs`, `each.rs`, `pair.rs`, `io.rs`, `platform.rs`, `self_test.rs`, `ffi_avx512_32.rs`, `ffi_chunk_root.rs`, `ffi_neon_hybrid.rs`, `ffi_output.rs`, `ffi_partial.rs`, `ffi_sme2.rs` |
| `blake3-servil` (`threads/src/`) | `lib.rs`, `pipeline.rs`, `lanes.rs`, `waker.rs`, `park.rs`, `finish.rs` |
| `b3sums` CLI (`b3sum/`) | `src/main.rs`, `src/linux_pipe.rs`, `src/uring.rs`, `src/direct.rs`, `src/outboard.rs`, `README.md`, `what_does_check_do.md` |
| C API (`capi/`) | `b3.h`, `src/lib.rs`, `Cargo.toml`, `README.md` |
| Release pages | `README.md`, `CHANGELOG.md`, `QUALITY.md`, `docs/hazmat-removal.md` |

## Method and commands

1. Checked out a clean detached worktree at `ad163558bd882ca7768e59764c6588fce0f285f9`:
   ```sh
   git worktree add --detach <agent-home>/BLAKE3-security-010 ad163558bd882ca7768e59764c6588fce0f285f9
   ```
2. Reviewed `unsafe` blocks, lifetime bounds, `MaybeUninit` invariants, `debug_assert!` boundaries, and integer arithmetic near `u32`/`usize`/`u64` limits. Traced worker loans and `Room` reference-credit transitions in `threads/src/pipeline.rs`, `io_uring` buffer lifetimes and EOF handling in `b3sum/`, and alignment contracts in `capi/`.
3. Built `blake3-servil-core` with `--features zeroize` and disassembled `<Hasher as Zeroize>::zeroize` and `<CvStack as Zeroize>::zeroize` (`wipe_check.rs`):
   ```sh
   cargo build --release --features zeroize
   objdump -d -C target/release/libblake3_servil_core.rlib
   ```
   Verified that `key` and `ChunkState` (`288` bytes) emit volatile stores, whereas `Hasher::stage` (`16,384` bytes) and `CvStack::cvs` + `rows` (`9,952` bytes) compile to plain `memset` (`0x4000` and `0x26e0` bytes), which cross-crate bitcode LTO (`lto = true` / `lto = "thin"`) can eliminate as dead stores.

## Findings index (16 issues opened under milestone `0.10.0`)

| Issue | Finding |
|---|---|
| [#416](https://github.com/servil-software-factory/BLAKE3/issues/416) | b3sum: io_uring submit_and_wait errors free SmallSlot buffers and recycle Pipeline Rooms while kernel reads remain in flight (consolidated with [#409](https://github.com/servil-software-factory/BLAKE3/issues/409); adds `Room` recycling on `stream_fd_into_rooms` `?`) |
| [#417](https://github.com/servil-software-factory/BLAKE3/issues/417) | Pipeline::with_owners accepts borrowed slices without B: 'static, permitting safe-Rust use-after-free on leak |
| [#418](https://github.com/servil-software-factory/BLAKE3/issues/418) | Pipeline::commit of 0 bytes consumes ROOM_CREDITS without advancing room.offset, allowing aliased Room buffers |
| [#419](https://github.com/servil-software-factory/BLAKE3/issues/419) | hazmat and TreeHasher::subtree_cv_on expose target-feature and uninitialized-pointer UB as safe pub functions |
| [#420](https://github.com/servil-software-factory/BLAKE3/issues/420) | throughput::finalize_each with duplicate indices in which silently produces empty-message or platform-dependent digests in release builds |
| [#421](https://github.com/servil-software-factory/BLAKE3/issues/421) | TreeHasher accepts non-power-of-two left subtrees at chunk 0 and silently computes non-BLAKE3 root digests |
| [#422](https://github.com/servil-software-factory/BLAKE3/issues/422) | throughput::hash_many, Batch::digests_mut, and Packed::as_blocks Merkle docs omit leaf/node domain separation |
| [#423](https://github.com/servil-software-factory/BLAKE3/issues/423) | OutputReader::position wraps to 0 past u64::MAX, causing SeekFrom::Current to rewind XOF output to byte 0 |
| [#424](https://github.com/servil-software-factory/BLAKE3/issues/424) | b3sum: O_DIRECT pathname re-open TOCTOU, piece-boundary truncation, hint-based short EOF, and --keyed --outboard stdin (pathname overlap in [#408](https://github.com/servil-software-factory/BLAKE3/issues/408); piece-boundary EOF, `hint` short EOF, and `--keyed --outboard -` open) |
| [#425](https://github.com/servil-software-factory/BLAKE3/issues/425) | b3sum --outboard writes DIR/<hash>.obao4 with O_TRUNC and follows symlinks |
| [#426](https://github.com/servil-software-factory/BLAKE3/issues/426) | Pipeline aborts the process when an async task cancels or returns early via ? with work in flight |
| [#427](https://github.com/servil-software-factory/BLAKE3/issues/427) | Pipeline leaks PipeStorage past 16 concurrent instances (or late Room drop) and retains keys in static FREE_STORAGES |
| [#429](https://github.com/servil-software-factory/BLAKE3/issues/429) | Zeroize on Hasher and CvStack wipes 26 KiB with non-volatile slice::fill, allowing LTO dead-store elimination |
| [#430](https://github.com/servil-software-factory/BLAKE3/issues/430) | capi: b3.h and README advertise C++11, where new b3_hasher ignores alignas(64) and aborts 3 in 4 times |
| [#431](https://github.com/servil-software-factory/BLAKE3/issues/431) | Docs: convenience::hash claims automatic first-call self-test (actually panics without initialize), and Hasher::finalize comment is stale |
| [#432](https://github.com/servil-software-factory/BLAKE3/issues/432) | b3sum and READMEs: silent --no-mmap SIGBUS sharp edge, --check flags/control chars, and broken 0.10 links |

## Limitations

- This record covers one static and disassembly audit of `ad163558bd882ca7768e59764c6588fce0f285f9` by one agent and model (`google/gemini-4-carbon`). A second independent model audit remains open in [#410](https://github.com/servil-software-factory/BLAKE3/issues/410).
- Assembly kernels under `c/` were checked at their Rust FFI call boundaries (pointer validity, lengths, alignment, CPU feature gates, flag bits); instruction-level proofs live in `tools/verify/`.
- `threads/src/pipeline.rs` was reviewed by manual state and credit analysis; concurrent model-checking coverage is tracked in [#411](https://github.com/servil-software-factory/BLAKE3/issues/411).
- Fuzzing, fault-injected `io_uring_enter` runs, and hardware timing measurements were outside this session.
- `ad163558` predates the upcoming `0.10.0` remediation commits. Follow-up review is needed on those fixes and on the final release diff.

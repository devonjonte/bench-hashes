# Next steps

Read this file first. The work: make the servil fork the fastest BLAKE3 in
every situation a user meets, the streaming APIs first (AGENTS.md, "The
streaming APIs first"), natively on the Mac first, then in the VM,
measured by this benchmark. Prefer changes that are simpler and faster
together. The principles are in both repositories' `AGENTS.md`; the
fork's hardware facts, design, and rejected ideas are in its
`NOTES-servil.md` (read it before touching kernels or the pool); this
repository's are in `NOTES.md`, its settled questions under "What is
settled". Every open item is in one list: the fork's NOTES, "Future
work". This file says where the work stands; its history is in git.

## Where things stand (October 9, 2026)

- **The fork**: `servil` = 9d9f3d6; `candidate/no-linger` adds the proofs
  (the library's code unchanged but the SME2 message kernel's branch-free
  last-block length, 285ecf0; Mac jobs 1441-1442, no regression).
  `tools/verify` proves every AArch64 assembly kernel (hybrid, 327 cases;
  SME2, 34, and the chunk, parent, extended-output and message kernels at
  every group count by induction) and the library's Rust compression code
  (24) equal to the compression function of the Lean specification in
  `c2sp/BLAKE3`. The instruction models are proved equal to Arm's Sail
  specification: 136 of 137 NEON and integer forms, 19 of 23 streaming
  (`isla_check.py`). `tools/verify/tree` proves the tree walk and the
  Hasher's stack algorithm against the specification's tree, in Lean
  (Aeneas). Its README and the fork's NOTES (October 8) have the details.
- **The probe** `probe/wide-walk` (a1341ee, 4214925): the library's
  single-thread walk is `src/tree_core.rs`, the file `tools/verify/tree`
  proves, at every buffer size the library builds with. Mac A/B (jobs
  1443-1446, 1456-1479, mains): single-threaded within 1% everywhere;
  multithreaded 512 KiB x1.043, median of 14 pairs, 10 slower and 4
  faster (sign test p 0.18), cause unexplained (open); `perf_regress` on
  the Mac (1447) and the VM: no regression.
- **C2SP**: `c2sp/BLAKE3/` is a Lean specification of C2SP's BLAKE3;
  `c2sp/pr/` is the pull request, saved for Zooko's review. Filed:
  C2SP/C2SP#384 (a trace's chunk label), rems-project/isla#107 (the
  snapshot's `dup` index: Sail's fixed unsigned_subrange, not yet in the
  snapshot).
- **bench-hashes**: 0.16.1 on `main` with its records.

## Next

1. Done: the library's walk is the proved one (0156c58, Zooko's go-ahead),
   after `update_rayon`'s removal (0e156c8). `perf_regress` passes on the
   VM and the Mac (jobs 1497, 1498; battery, busy pairs rerun).
2. The Hasher's stack as code: `src/stack_core.rs` on probe/stack-array
   (an array made at the first push, in place of ArrayVec; no cost on the
   VM); its push and merge proved against `HasherProofs.lean` (e8a75e3).
   Mac jobs 1490-1496 (battery, every run busy): `perf_regress` passes,
   and the earlier slow cells read level (64 B x1.000, 2 messages
   x1.000). Merged (40663e0, Zooko's go-ahead). The VM's check held once
   at LentBatches|16 (+8.3%), a path that never reaches the stack, then
   passed four times. Mac, idle on mains (October 11): `perf_regress`
   passes (job 1500), and an A/B of three pairs (jobs 1502-1507) reads
   nonstop cells within 3% and the lent cells within 1.3%, both ways; the
   earlier busy runs' slower small cells do not reproduce.
   Then consider removing every use of `arrayvec` (the SIMD pointer
   tables, hazmat, the lanes, `to_hex`'s `ArrayString`, which is public
   API) for simplicity: one dependency fewer, and less unsafe code under
   the proofs; only where the result is simpler, not merely different.
3. Timing (the fork's QUALITY.md, "Timing and secrets", says where each
   condition stands; change it with every step here): whole `hash` calls
   are proved to run one path per length (the fork's
   `tools/verify/prove_timing.py`, 294 lengths, to 64 KiB on NEON and 4
   KiB on SME2). Next: `keyed_hash`, `derive_key`, the Hasher; SME2 past 4
   KiB (its pointer table in vector lanes); the new instruction forms
   against Isla; then measure DIT's cost (Zooko
   expects it too costly to be on by default, and an option's complexity
   too high for its benefit).
4. Complete the proofs, simplifying as we go (Zooko, October 10: remove
   what must be trusted; prefer removing a whole tool or step, unless that
   risks or slows completion). In order:
   - done: the binary tree walk's proofs removed (not library code);
   - done: the condensing loop (`children` in `tree_core.rs`) proved to
     return the root's two children (dc53411; Mac job 1501 passes);
   - done: the one-shot hash (`tree_core.rs`'s `hash`, which `hash`,
     `keyed_hash`, `derive_key` call) proved to return `Blake3.blake3 key
     mode input 32` given its kernels' contracts (bfb6150, HashProofs.lean;
     VM and Mac job 1508 pass);
   - done: the Hasher (`hasher_core.rs`'s fill, feed, final_node over the
     proved stack) proved: after any updates its root is the
     specification's over all their bytes, given its kernels' contracts
     (8fd2212, d7f78bc, HasherCoreProofs.lean; VM and Mac job 1510 pass);
   - done: a chunk's state (`chunk_core.rs`, the library's ChunkState)
     proved: after any bytes its fields are the specification's chunk node
     of them, given compress_in_place's and compress_blocks's contracts
     (671ac11, ChunkProofs.lean; VM and Mac job 1511 pass);
   - done: joined to the Hasher's proof (7381cc5): the Hasher's proof
     reads a chunk state through a relation, ChunkState's Chunk impl is in
     chunk_core.rs and meets the chunk contracts, and one Aeneas crate
     (hashercore) holds the stack, loop, and chunk state;
   - done: the Hasher on the library's kernels (7c0075a,
     OutputProofs.lean `hasher_hash`): Output, parent_output, and the
     Hasher's chunk, node, and parent kernels are core code (Kernels), and
     a new chunk state, any updates, and the root's 32 bytes are
     `Blake3.blake3`, given BlocksContracts (compress_in_place,
     compress_blocks) and HookContracts (ones, subtree_len, and the pool's
     and SME2's routes, subtree_cv and children); the contracts read
     through relations throughout (no `pf`); VM, Mac tests (1514), and Mac
     perf_regress from 671ac11 (1515, mains) pass;
   - in the working tree (October 12, not yet committed; VM checks
     running): ones and subtree_len are core code, proved (ones_spec,
     subtree_len_spec), so HookContracts is the pool's and SME2's routes
     alone; BlocksContracts is the machine-code proofs of
     `Platform::compress_in_place` and `compress_blocks` (1-16 blocks) on
     every platform; `hash_many` of chunks and parents is proved as
     machine code at every count on portable and NEON. The verify crate
     now builds the library with its default features (it had built it
     without std, whose paths differ: SHA-3 detection, the prefetch after
     a pause, the SME2 walk's thread-local scratch), so the executor
     models the timer, TLS, allocation and thread keys by their POSIX
     contracts, pointers in vector lanes, and more forms; the timing proof
     runs a thread's first and second call, after a pause and back to
     back, 612 of 612, SME2 now to 64 KiB. Executor fix: an addition's
     flags (adds, cmn) were a subtraction's of the negation (wrong carry
     for 0). To commit after cross_check, mutants, Isla and perf_regress;
   - then (Zooko, October 11: completion first, simplification after):
     the contracts' other side, left: SME2's `hash_many` (to 128 inputs:
     the Rust wrapper as machine code, its kernel calls by the kernels'
     own proved statements, one function per statement shared by the
     kernel's proof and the contract); the pool's and SME2's routes;
     HashProofs' kernels (tree.rs: chunks and parents over hash_many,
     chunk_root, parent_root); then the glue left (update_pooled's three
     lines, the Hasher's staging, platform detection), and one statement.
     Also: end each verify script with os._exit after its verdict (the
     teardown of its Z3 terms takes many minutes);
     Progress (tools/verify-dev, a scratch copy): SME2's hash_many proved
     at 16, 33, 128 chunks and 37, 128 parents with its kernels run by
     their proved statements (16 chunks 3.9 s; the comparison is
     immediate once both sides build their terms alike: lean_spec.join,
     simplified arguments). Parents only contiguous (as every caller lays
     them out: whether two separate buffers adjoin is a fact of the
     address space, not of the code). 127 chunks takes 240 s, its 15
     left over run on NEON instruction by instruction; NEON's own proof
     could stand for it the same way.
     Open, for Zooko: the contract proofs run one compiled copy. Generic
     and inlined code is compiled again at each use: the verify crate's
     calls get their own instances (symbols ending verify_entries), and
     the library's callers run others. So these proofs establish the
     source's meaning as one compiled copy computes it, not every copy
     users run; only the whole-call proofs (prove_timing on `hash`) run the
     library's own code. Closing it: prove whole calls' results as well as
     their paths (the timing proof's runs, compared with Blake3.blake3 at
     each length), or prove the library's own instances by symbol;
   - after completion: reduce what is trusted. A time-boxed probe was: the machine-code proofs in Lean on
     Arm's own specification (Sail's Lean output of sail-arm), one small
     kernel against `Blake3.lean`. If it works, it replaces Z3, the
     Python executor and its models, Isla, the CPU cross-checks, and the
     compress.json bridge. If it fails, stop and talk with Zooko before
     any fallback (a fallback may be avoidable complexity);
     Status (October 11, probe/sail-lean, `tools/verify/sail/README.md`):
     sliced to the instructions used, Arm's model proves BLAKE3's G as 14
     Arm instructions in Lean, any registers and any state, in under a
     second; two translation bugs found and fixed upstream (sail#1772,
     sail-arm#33). Open, for Zooko: where the theorem states that
     virtual memory behaves as memory (a load's slice is 1,461 functions,
     address translation among them); decoding (Arm's decoder is a
     2,542-line chain that Lean takes over an hour to build); UNKNOWN
     values (the ArchSem interface makes them explicit choices);
   - Kani's claims into Lean (the pool's piece arithmetic as a pure
     function, the batch table as safe indexing), and Kani removed.
   The description of what is proved is QUALITY.md's "Proofs"; keep it
   current. Its standard (Zooko): users and experts alike can read the
   English statement, map it to the Lean statement from the Lean source
   alone (C2SP's standard or the C code?), and run the checker and read
   its verdict.
5. The SME2 flat walk (`ffi_sme2::flat_walk`) as a kernel with a proved
   contract, the four streaming forms Isla needs over 50 GB for, and the
   ZA loads and stores against Arm's specification.
6. Promote `candidate/no-linger` once its CI passes. GitHub Actions is
   disabled for the fork (a dispatch answers "Actions has been disabled
   for this repository"; no run since dc56276, whose last job was
   cancelled at 02:00 UTC, October 9); Zooko to look at the fork's
   Actions settings or GitHub's mail; the settings show nothing, and the
   account's other repository runs, so only GitHub Support can lift it.
   Proposed first: the long SME2 proofs out of every push into a workflow
   started by hand before promotion (done: `sme2-every.yml`). The
   candidate changes the message kernel, so promotion needs those proofs:
   GitHub cannot run them, so run its six groups on the VM (stopped
   October 10 to save the Mac's battery; restart them on the tip).
   dc56276's two failures are fixed in
   63a6e26. The next runner job number is 1500.
7. SHA-256 as competitive as it can be on the benchmark (Zooko, October
   10): give the SHA-256 contenders (sha2, ring) their fastest builds and
   calls on each platform (the ARMv8 SHA-256 instructions, features and
   flags, batch or multi-buffer APIs where a crate has them), so every
   comparison is against SHA-256 at its best. A change to what the
   benchmark measures is Zooko's decision, recorded in FROZEN.md.
8. SME2 at every vector length (Zooko, October 10): the kernels and the
   library run SME2 only where the streaming vector length is 512 bits
   (Apple M4), and fall back to NEON elsewhere. Make them scalable, so
   future SME2 hardware with another length (128 to 2048 bits) runs
   SME2 too, with the proofs covering each length the code supports.

## Commands

From `/workspace` in the VM, after `sh /workspace/vm/setup.sh` once per boot:

    cargo test --release --lib [--features no_sme2 | --features pure]
    cargo test --release --doc
    cargo test --release --test api_plan
    cargo test --release --manifest-path test_vectors/Cargo.toml
    cargo test --release --manifest-path bench-hashes/Cargo.toml
    pypy3 tools/perf_regress.py check | compare OLD NEW
    RUSTFLAGS="-D warnings" cargo test --no-run [--no-default-features | --features pure]   # as CI builds

Judge each by its exit status. Release: `python3 tools/gen-ver.py X.Y.Z`
from a clean tree (two version commits and a lightweight tag; push the
branch, `servil` in the fork or `main` here, then the tag by name).
Never print the credential token (`/workspace/ghtokenclassic.txt`). Only
`/workspace` survives VM restarts. Commands for the user go on one line.

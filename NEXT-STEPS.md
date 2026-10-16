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

## Where things stand (October 15, 2026)

- **The fork**: `servil` = ed263f8: candidate/verify-std, Devon's #34,
  #33, #32, #26 (`initialize_multithreaded()` the multithreaded calls'
  precondition) and #11 (b3sum maps files from 512 KiB on Linux). The
  promotion gate (the fork's PROCEDURES.md): the suites, VM and Mac
  `perf_regress` for changes to AArch64 machine code,
  `tools/check-builds.sh` (no_std, warnings, x86-64/i686/wasm32 compile
  checks, the MSRV), the long proofs on the VM (`long-proofs.sh`, posted
  as the commit's status), and GitHub's CI by hand for candidates that
  change other targets' code (it alone runs their tests; it caught #28's
  MSRV break).
- **Candidates**: `candidate/devon-x86` (Devon's #25, #28, #29, #31, #36
  and his follow-ups, which fixed the LentBatches|16 slowdown: VM 4 of 4
  clean, Mac 1553 and 1554 pass; waiting on CI's x86 run).
  `candidate/flat-walk-proofs`: `prove_flat.py` proves the SME2 flat walk
  as compiled, the standard's tree over its kernels, and FlatProofs.lean
  that its shape is the Hasher's contract; from 256 chunks it waits on the
  hybrid kernel's induction (`x2_every`, running on the VM).
- **What is proved** (the fork's `QUALITY.md`, "Proofs"; issue #24 is the
  piece-by-piece meter): every AArch64 assembly kernel (the SME2 hybrid at
  1 and 2 groups so far), the Rust compression code, the tree walk and the
  Hasher (Lean, given their kernels), the pool's cuts, and whole calls at
  fixed lengths (2316 cases). Instruction models: 325 forms against the
  CPU, 322 against Arm's specification (Isla).
- **The SME2 hybrid kernel**: earns 5.5-6.5% single-threaded from 1 MiB
  (Mac jobs 1530-1537); Zooko: prove it.
- **bench-hashes**: 0.16.1 on `main`. The next runner job is 1555.

## Tonight (Zooko asleep; John works through the long waits)

In this order, each candidate through its whole gate (PROCEDURES.md),
none landed without it. Zooko's decisions of October 16 are in each PR's
thread.

0. Devon's `stream()` (fork #50) first, since it may replace the `Queue`
   (Zooko: "the way forward"). John's first review is on #50 (one
   digest handler; the two schedulers; `size_hint` stays, Zooko: a public
   API's callers are ours to spare a breaking change). Measure it
   against every FROZEN.md cell the queue serves, on the Mac and the VM:
   Devon's bench branch `devon-stream-cells` (9418988, fetched here as
   `review/stream-cells`; it carries his false-discovery `compare` and
   `regress`, the fresh layouts, and the leaves) against its parent
   897668a, the same BLAKE3 (`review/pr50`, a057ef5) on both sides,
   `regress --full` over 8 fresh-layout pairs. Devon's i7-12700K reads
   every streaming cell faster or level but two programs streaming 4-16
   MiB messages at once (x1.10-1.15).
   One scheduler, a sketch from reading the code (October 16): workers
   already take from both sources in one loop (`Pool::next_piece`: the
   task list first, then the jobs' slots), with one sleep. A job becomes
   one entry in the task list that carries a cursor: workers take its
   shrinking pieces as from today's slots, and it leaves the list when
   its last piece is taken. The jobs' 64 slots, their readers' counts,
   the scan (`take_piece`), and `register` go; one-shot calls keep their
   pieces' sizes. Then write
   the proposed change to what the benchmark asks, for Zooko's
   decision; first explain the stream's batch gap (4096-16384 messages
   x1.06-1.11 alone). Goal (Zooko): one scheduler, the one-shot calls on
   the stream's tasks, level on their cells. Until then, no test,
   mutation, or proof work on `queue.rs` or the pool's job scheduler
   (their mutants stay unclassified in the list).
1. `candidate/flat-walk-proofs` (af38bf4): when its long proofs pass
   (about 22:00-23:00), promote it; update #24 and QUALITY's meter;
   close #40 (its proof is on this branch).
2. `candidate/mutants-all` (86f1a14): a fresh mutant run (about 1 h) and
   its classification; check-builds; CI (the new AArch64 job included);
   `perf_regress` on the VM, then the Mac; promote; pin bench-hashes.
3. The cuts (item 15), as one candidate on the new `servil`, through the
   same gate.
4. Devon's approved PRs, each rebased and gated, once `servil` stops
   moving: #46 (benches/bench.rs goes), #22 (`#[inline]` on
   `root_bytes`), #55 (the x86 self-test, rebased onto mutants-all's
   self-test and `EXPECTED` regenerated), #49 (Mac gate; report the
   cells it slows), then #42 (rustfmt, width 160) before anyone branches
   again.
5. The measurement change (adopted): false-discovery control over every
   cell, and a random link layout per pair (fork #44, #45; bench-hashes
   #10-#13), as one candidate. Calibrate it on the Mac first (its
   `-order_file` path is unrun). AGENTS' "a run's mean, compared over
   pairs of runs" changes with it, worded for Zooko's approval. Then
   CPU time and energy (bench-hashes #16, fork #48, #43), yes in
   principle.


3. Timing (the fork's QUALITY.md, "Timing and secrets", says where each
   condition stands; change it with every step here): whole calls are
   proved to return the standard's result on one path per length (the
   fork's `tools/verify/prove_timing.py`: `hash` at 153 lengths to 64 KiB
   on NEON and SME2; `keyed_hash`, `derive_key`, and the Hasher in two
   updates to 4 KiB; 2316 cases), their instruction forms checked against
   Isla (322 of 325). Next: measure DIT's cost (Zooko
   expects it too costly to be on by default, and an option's complexity
   too high for its benefit).
4. Open: `perf_regress` holds `LentBatches|16` on unchanged library code.
   Mac job 1519 (October 14, idle, mains): +17.3% (-mt) and +14.1% (-st),
   pairs -12% to +43%, between builds of the same library source (servil
   9c9d171 against candidate/verify-std, which changes only tools and
   docs); job 1521, the same builds, passed. The VM held it once before
   (+8.3%, item 2). The cell's cost moves between processes of identical
   code; until we can say when and by how much, a hold there is
   unexplained: understand it (its pairs' spread, the process's layout or
   thread placement), then fix the cell or the rule.
   Since the afternoon of October 14 the Mac has a periodic load that
   blocks verdicts: benchmark jobs 15 s apart alternate quiet and busy
   (1.5-2.3 CPUs of other programs), so about 15 s of every 30, and every
   `perf_regress` job since (1538, 1540, 1541, 1543, 1544) met it and gave
   no verdict, with the VM idle. Its source is on the Mac (Activity
   Monitor during a job would name it).
5. Complete the proofs, simplifying as we go (Zooko, October 10: remove
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
     Night of October 12-13 (in the working tree, final checks running;
     to commit in two parts): whole calls of `hash` proved to return the
     standard's hash, not only to run one path, at 306 lengths to 64 KiB
     on NEON and SME2 (prove_timing, against whole.py, 40 lines checked
     on the official vectors), which closes the compiled-copies question
     for `hash` at those lengths; it took canon folding constants
     wherever a sum or xor gathers them (the zero padding). SME2's
     hash_many proved at every count to 128; the assembly kernels inside
     Rust paths and whole calls run by their own proofs' statements (one
     function each for proof and contract), only where the library's
     kernel bytes equal the proved object's; prove_rust and prove_timing
     run their cases in parallel workers. Isla's check was slow from
     handing Z3 every declaration on each parse (14 s a form now, against
     298); with that, pypy3 is as fast as CPython there, so one
     interpreter stays. Official vectors through the executor on `hash`:
     70 of 70 (to 100 KiB, NEON and SME2). Mutants: 32, three of them in
     whole calls (rotation, root flag, IV bit). cross_check: 312 forms;
     br/blr/mrs and flag forms join cmp's skip list (random states jump).
     Then: keyed_hash (symbolic key), derive_key, and a Hasher in two
     updates proved as whole calls to 4 KiB (2316 cases). Saved for
     resuming: the fork's tmp/night/STATE.md (what passed on which code,
     what is left to run, the commit-2 message). GitHub Actions is back.
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
6. The SME2 flat walk (`ffi_sme2::flat_walk`) as a kernel with a proved
   contract, the four streaming forms Isla needs over 50 GB for, and the
   ZA loads and stores against Arm's specification.
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
9. Zooko's optimized BLAKE3 for wasm and the web (a repository of his;
   Zooko, October 16): learn from it, and integrate what serves the fork's
   wasm32 path.
10. Show each cell's kernel in the results again (Zooko, October 16;
    the reports gain an "after a pause" entry for the pair kernel that a
    batch of 1 to 8 one-block messages runs then, and the legend's claim
    that a call after idling runs as after other work goes): an
    earlier display marked, at each cell, the kernel `kernel_report`
    names; a rewrite dropped it. Its lengths then need a check against the
    dispatch (the fork's mutation list holds them as open).
11. Concurrency tested by construction (Zooko, October 16): three loops in
    `tests/api_plan.rs` repeat 200-400 times to provoke scheduling races.
    Try Loom, which runs every interleaving of a small model of the
    threads' atomics and locks, in their place.
12. The AArch64 paths without SHA-3 and without SME2, tested (Zooko,
    October 16): no suite runs the std build on such a CPU (a Raspberry
    Pi 4, Graviton 2). Add a CI job on such a machine.
13. Mutation testing skips proved code (Zooko, October 16), and one
    figure says how much of the library is covered by a current proof or
    by mutation testing with every survivor explained.
14. Lessons from mutation testing and proofs, for Ode (Zooko, October 16):
    after reading samshackleton's Ode repository whole, write them into
    it, among them that benchmarking is first-class (timing, like halting,
    is part of correctness).
15. Cut what we do not stand behind (Zooko, October 16; AGENTS, "Support
    only what we stand behind"), after the in-flight candidates land, as
    one candidate: 32-bit x86 (i586, i686), x86 without SSE4.1 (the SSE2
    kernel, `no_sse2`, `no_sse41`), ARMv7, big-endian (PowerPC64, s390x),
    Windows GNU, and every Rust but the latest stable (the MSRV job and
    check-builds' MSRV copy go; nightly features we choose stay
    allowed). The README's servil preface points users of those to
    official BLAKE3. The features `neon` (NEON on 32-bit ARM) and
    `prefer_intrinsics` (x86 C intrinsics in place of assembly) go with
    them; `traits-preview` (the RustCrypto `digest` traits, through which
    generic Rust crypto code takes a hash) stays, John's recommendation,
    unless Zooko says otherwise.
16. The C library, first-class (Zooko, October 16: a de facto standard
    needs C), after item 15: C programs get servil's speed, tests, proofs,
    docs, and benchmark place as Rust programs do. Proposed design, for
    Zooko: the C API as a thin C-ABI layer over the Rust crate (a static
    and a shared library, one header), so one implementation carries
    every proof, in place of upstream's separate C implementation; its
    trade-off is that building from source needs a Rust compiler, which
    prebuilt libraries and distribution packages take away from users.

## Commands

From `/workspace/blake3-servil` in the VM, after `sh /workspace/blake3-servil/vm/setup.sh` once per boot:

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
Never print the credential token (`/workspace/blake3-servil/ghtokenclassic.txt`). Only
`/workspace` survives VM restarts. Commands for the user go on one line.

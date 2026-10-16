# Next steps

Read this file first. The work: make the servil fork the fastest BLAKE3 in
every situation a user meets, the streaming APIs first, natively on the
Mac first, then in the VM, measured by this benchmark; prove what users
rely on; keep everything as simple as it can be. The principles are in
both repositories' `AGENTS.md`; the fork's design and measurements in its
`NOTES-servil.md`, what is proved and tested in its `QUALITY.md`; this
repository's measurement design in `NOTES.md`. This file says where the
work stands and what comes next; its history is in git.

## Where things stand (October 16, 2026, evening)

- **`servil`** = beb9abe (Devon's x86 stack, the case-based tests, CI's
  lean x86 matrix). bench-hashes pins it.
- **Candidates**, in landing order:
  1. `candidate/flat-walk-proofs` (af38bf4): the SME2 flat walk proved as
     compiled, and the SME2 hybrid kernel at every group count. Long
     proofs running (`tmp/lp/tmp/long-proofs/af38bf4*`).
  2. `candidate/mutants-all` (6c4ced9): mutation testing over the whole
     library with every survivor listed and explained
     (`tools/mutants/`), the tests it called for, the kernel record (each
     kernel report checked against the dispatch, and the self-test's
     reach checked on every run), `guts` gone, CI on AArch64 without
     SME2 and without SHA-3, GCC 12 the oldest supported.
  3. `candidate/cuts` (564e241, on mutants-all): 32-bit x86, SSE2, ARMv7,
     big-endian, Windows GNU, Rust older than the latest stable, the C
     library (upstream's, byte for byte), `benches/bench.rs` (Devon's
     #46). CI green.
- **The gate** (the fork's `PROCEDURES.md`): the suites,
  `tools/check-builds.sh`, the long proofs for code and proof tools, CI
  for other targets' code, `perf_regress` on the VM, then the Mac, for
  AArch64 machine code.

## Tonight (Zooko asleep)

Each candidate through its whole gate, none landed without it:

1. Promote `candidate/flat-walk-proofs` when its long proofs pass; update
   #24 and QUALITY's meter; close #40 (its proof is on this branch).
2. `candidate/mutants-all`: a mutant run on its tip (the list must then
   need no change), check-builds, CI, `perf_regress` VM and Mac; promote;
   pin bench-hashes.
3. `candidate/cuts`: rebase, the same gate.
4. Devon's approved PRs, each rebased and gated once `servil` stops
   moving: #22 (`#[inline]` on `root_bytes`), #55 (the x86 self-test,
   onto mutants-all's; regenerate `EXPECTED`), #58 (one CPUID read;
   SIGILL kept), #49 (report the cells it slows), then #42 (rustfmt,
   width 160) before anyone branches again. Close #46 (landed with the
   cuts).
5. The measurement change (adopted): every cell judged at once with the
   false discovery rate controlled, and a random link layout per pair
   (fork #44, #45; bench-hashes #10-#13), one candidate. Calibrate it on
   the Mac first. AGENTS' "a run's mean, compared over pairs of runs"
   changes with it, worded for Zooko's approval.

## Next, in order

1. **The stream** (fork #50, Devon). Direction approved (Zooko, October
   16): digests written into the caller's memory (each submission names
   its place; one handler takes the places back in order), a batch's
   tasks pushed in one call with a wake check sized to the list, and a
   cheaper `wake_for` for the whole pool. Measure it when Devon says the
   design has settled: every FROZEN.md cell the queue serves, with his
   port of the streaming cells; then the contract change to Zooko. Then
   one scheduler (a job as one task-list entry with a cursor; Devon
   prototypes, John reviews and measures). Until then no test, mutation,
   or proof work on `queue.rs` or the job scheduler.
2. **Complete the proofs** (the fork's `QUALITY.md`, "Proofs"; issue #24):
   the glue between the proved parts (the Hasher's staging,
   `update_pooled`, platform detection), the pool's and SME2's routes,
   the batch APIs, the XOF reader, and one Lean statement joining the
   kernels' Z3 verdicts to Lean's. After completion, reduce what is
   trusted: the machine-code proofs on Arm's own specification in Lean
   (`probe/sail-lean`: G proved as 14 Arm instructions; open for Zooko:
   memory as virtual memory, decoding, UNKNOWN values), and Kani's claims
   into Lean. QUALITY.md's "Proofs" stays current, to Zooko's standard:
   users and experts alike can read each English statement, map it to
   the Lean statement from the Lean source alone, and run the checker and
   read its verdict.
3. **Mutation testing beside the proofs** (Zooko, October 16): skip what
   a current proof covers, and one figure: how much of the library a
   proof or mutation testing covers. Loom for the pool's interleavings
   (the "OPEN" survivors; `tests/api_plan.rs`'s repetition loops go).
4. **Show each cell's kernel in the results again** (Zooko): the reports
   gain an "after a pause" entry (a batch of 1 to 8 one-block messages
   runs the pair kernel then), and the legend's claim that a call after
   idling runs as after other work goes.
5. **CPU time and energy beside wall time** (bench-hashes #16, fork #48,
   #43; yes in principle), after the measurement change.
6. **The C library, first-class** (Zooko: a de facto standard needs C): a
   thin C-ABI layer over the Rust crate (static and shared libraries, one
   header), one implementation carrying every proof.
7. **Timing**: whole calls are proved to take one path per length
   (QUALITY.md, "Timing and secrets"); next, measure DIT's cost.
8. **SHA-256 at its best** in every comparison (Zooko, October 10): each
   SHA-256 contender's fastest build and calls on each platform.
9. **SME2 at every vector length**, the proofs covering each length the
   code supports; the SME2 flat walk as a kernel with a proved contract;
   the ZA forms Isla cannot run yet.
10. **Zooko's wasm and web BLAKE3**: learn from it (ask him for the
    repository when we start).
11. **Lessons for Ode**: after reading samshackleton's Ode whole, among
    them that benchmarking is first-class (timing, like halting, is part
    of correctness).
12. **One `Mode`** (Zooko, October 16): the crate's `Mode` and hazmat's
    `Mode` name the same modes differently; one type serves both, with
    `DeriveKeyMaterial` (a precomputed context key) beside `DeriveKey`.
    With it, hazmat's docs say its assertions panic (they are the
    contract; upstream's "best-effort, not guaranteed" goes). After the
    stream settles, since the queue takes a `Mode`.
13. **Watch**: `perf_regress` sometimes holds `LentBatches|16` on
    unchanged code (Mac job 1519, +14-17%); the measurement change should
    settle it, else find the cause.

## Commands

From `/workspace/blake3-servil` in the VM, after `sh vm/setup.sh` once per boot:

    cargo test --release --lib --tests [--features no_sme2 | --features pure]
    cargo test --release --doc
    cargo test --release --manifest-path test_vectors/Cargo.toml
    cargo test --release --manifest-path bench-hashes/Cargo.toml
    sh tools/check-builds.sh
    pypy3 tools/mutants/check.py
    pypy3 tools/perf_regress.py check | compare OLD NEW

Judge each by its exit status. Release: `python3 tools/gen-ver.py X.Y.Z`
from a clean tree (two version commits and a lightweight tag; push the
branch, `servil` in the fork or `main` here, then the tag by name).
Never print the credential token (`ghtokenclassic.txt`). Only `/workspace`
survives VM restarts. Commands for the user go on one line.

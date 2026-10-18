# Next steps

Read this file first. The work: make the servil fork the fastest BLAKE3 in
every situation a user meets, the streaming APIs first, natively on the
Mac first, then in the VM, measured by this benchmark; prove what users
rely on; keep everything as simple as it can be. The principles are in
both repositories' `AGENTS.md`; the fork's design and measurements in its
`NOTES-servil.md`, what is proved and tested in its `QUALITY.md`; this
repository's measurement design in `NOTES.md`. This file says where the
work stands and what comes next; its history is in git.

## Where things stand (October 18, 2026, morning)

- **`servil`** = c0e74e0. Every AArch64 assembly kernel is proved at
  every group count: the block loops are proved once a pass
  (`prove_block_loop.py`; `prove_hybrid_loop.py` for the kernel with an
  integer lane, closing #40), so the chunk kernel's induction takes 15
  minutes (was 4.3 hours), the message kernel's 3 (was about 16
  CPU-hours), the hybrid's 44. The long proofs, 368 cases, passed on
  f7c6d11 in 50 minutes; `x2_every` joins them from 3ce4f90. Windows
  builds take MSVC's assembler alone. #77 (1 MiB pool pieces) is
  reverted (#79, Devon: mt shared git objects +6.2% on the i7); b3sum is
  to meet the folio effect itself. A new test holds idle workers to
  parking while a stream is open. bench-hashes `main` pins 80aa44b.
- **The gate, by day** (Zooko, October 17): tests, `check-builds`, CI,
  `perf_regress` on the VM and the Mac, the change's mutants. **By night,
  on `servil`**: the long proofs, the whole mutation run, and any other
  job of hours; a failure is fixed forward first thing.
- **Open from the stream:** mt solo lent 1 MiB about 10% slower than the
  queue (VM +11.7%, Mac +9.7%; the spin about 2% of it on the Mac, job
  1587). Devon traces it; `job_trace` on the Mac shows the first worker
  joining at about 16 us, against 5 us on Linux.
- **Energy is a lab instrument**, out of the benchmark (item 6 below).

## Tonight, while Zooko sleeps

1. `sh tools/verify/long-proofs.sh servil`: the first whole run with
   `x2_every` (expect about an hour: it runs first, beside the rest).
2. The whole mutation run on `servil`, after the proofs and with nothing
   else running: beside other work the pool's chance survivors flip, and
   the check fails on noise. The list matches an idle run on fc9903b.

## Next, in order

1. **The lent 1 MiB gap** (above): understand it, then close it or
   document it (AGENTS.md, "we own every slowdown").
2. **Long proofs, faster still**: the hybrid kernel's group induction
   takes about 40 of its 44 minutes, against 15 for the chunk kernel's; its
   table's 144-byte stride (`URem`/`UDiv` in the entry function, where
   the chunk kernel masks with 127) is the likely cost, untested (NOTES-servil.md). Each
   obligation gets a time budget, reported when exceeded (Ode's lessons
   12-14).
3. **The kernel proofs, less trusted**: the ZA forms Isla cannot run
   yet, and the machine-code proofs on Arm's own specification in Lean
   (`probe/sail-lean`).
4. **Mutation testing**: Loom for the pool's interleavings (the "OPEN"
   survivors, which flip from run to run under load).
5. **Show each cell's kernel in the results again** (Zooko): the reports
   gain an "after a pause" entry (a batch of 1 to 8 one-block messages
   runs the pair kernel then), and the legend's claim that a call after
   idling runs as after other work goes.
6. **Energy: a lab instrument, out of the benchmark** (Zooko, October
   17). A number in every report becomes a goal (Goodhart), and a note
   about how to weigh it against wall time will not be read. So the
   benchmark, FROZEN, and the gate carry wall time and CPU time alone (CPU
   time shows work lingering after a call). Energy is measured only in
   experiments: the runner's `"powermetrics": true` (the chip's power;
   the per-process estimate errs by -16% to +30% with the instruction mix)
   and `examples/energy_probe.rs` on `probe/mac-energy`. Measured (jobs
   1579-1585): one thread on SME2 costs about a third of NEON's energy a
   byte (about 690 against 1990 pJ) and runs 1.6 times as fast; a
   multithreaded call is NEON on every worker in both builds. **The
   experiment, judged by wall time:** the M4 Max has three SME units (two
   P-clusters' and the E-cluster's); give a multithreaded call's work to
   them, and look for faster, or nearly as fast and much cheaper in energy
   (Zooko: no trading wall time away for energy, only a little for a lot).
   Newer Apple chips have more SME units. **Circled back** (Zooko, October
   17): energy chose the experiment (SME2 a third of NEON's energy a byte)
   and wall time decided it (2-4% faster: not built now); the instruments
   stay for experiments, on the Mac the runner's `powermetrics`, on Linux
   `clocks::energy` (#65).
7. **The C library, first-class** (Zooko: a de facto standard needs C):
   `candidate/c-api` (on the cuts) has `capi/b3.h`, a fresh design (Zooko:
   no compatibility with upstream's C API), over the crate, tested from
   Rust and from C. Next: the stream in C once it settles; Windows's C
   test; packaging (pkg-config, an install); its place in bench-hashes.
8. **Timing**: each kernel is proved to take one path per length
   (QUALITY.md, "Timing and secrets"); next, measure DIT's cost.
9. **SHA-256 at its best** in every comparison (Zooko, October 10): each
   SHA-256 contender's fastest build and calls on each platform.
10. **SME2 at every vector length**, the proofs covering each length the
   code supports; the SME2 flat walk as a kernel with a proved contract;
   the ZA forms Isla cannot run yet.
11. **Zooko's wasm and web BLAKE3**: learn from it (ask him for the
    repository when we start).
12. **Lessons for Ode**: after reading samshackleton's Ode whole, among
    them that benchmarking is first-class (timing, like halting, is part
    of correctness).
13. **One `Mode`** (Zooko, October 16): the crate's `Mode` and hazmat's
    `Mode` name the same modes differently; one type serves both, with
    `DeriveKeyMaterial` (a precomputed context key) beside `DeriveKey`.
    With it, hazmat's docs say its assertions panic (they are the
    contract; upstream's "best-effort, not guaranteed" goes). After the
    stream settles, since the queue takes a `Mode`.
14. **Watch**: `perf_regress` sometimes holds `LentBatches|16` on
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

# Next steps

Read this file first. The work: make the servil fork the fastest BLAKE3 in
every situation a user meets, the streaming APIs first, natively on the
Mac first, then in the VM, measured by this benchmark; prove what users
rely on; keep everything as simple as it can be. The principles are in
both repositories' `AGENTS.md`; the fork's design and measurements in its
`NOTES-servil.md`, what is proved and tested in its `QUALITY.md`; this
repository's measurement design in `NOTES.md`. This file says where the
work stands and what comes next; its history is in git.

## Where things stand (October 17, 2026, afternoon)

- **`servil`** = 4484730: the proofs keep to the assembly kernels; the
  stream replaced the queue (#59, with bench-hashes #20); the C library
  `libb3_servil`; Miri's CI step 3 minutes (the pool splits from 16 KiB
  under Miri); mutation testing on a change by its diff
  (`check.py --since servil`, seconds), the whole run by itself when a
  change removes or alters test code, and a listed missing test fails
  the check. bench-hashes `main` pins it.
- **The gate, by day** (Zooko, October 17): tests, `check-builds`, CI,
  `perf_regress` on the VM and the Mac, the change's mutants. **By night,
  on `servil`**: the long proofs (381 cases), the whole mutation run, and
  any other job of hours; a failure is fixed forward first thing.
- **Open from the stream:** mt solo lent 1 MiB about 10% slower than the
  queue (VM +11.7%, Mac +9.7%; the spin about 2% of it on the Mac, job
  1587). Devon traces it; `job_trace` on the Mac shows the first worker
  joining at about 16 us, against 5 us on Linux.
- **Energy is a lab instrument**, out of the benchmark (item 6 below).

## Tonight, while Zooko sleeps

1. `sh tools/verify/long-proofs.sh servil` (the narrowing's tools have
   not had a whole run; prove_hybrid now on every CPU, chunks_x2 back in
   the steps). Then the whole mutation run on `servil`.
2. **Build the block-loop proof** (item 2's design below: one pass of the
   message kernel's block loop proved once, the group loop's proof using
   it), then run it on the chunk and message kernels, and `x2_every`.

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
2. **Long proofs in an hour or two** (Zooko, October 16). With the Rust
   proofs gone, the run is the kernels' alone; its length is set by
   `prove_sme2`'s inductions: the chunk kernel's (`every`, 4.3 hours) and
   the message kernel's, one per message length, growing steeply with it
   (16 minutes at 5 blocks, 3.6 hours at 14). The growth points to the
   block loop inside each message being unrolled: an induction over the
   blocks too would prove one block's step once. The hybrid kernel's
   induction (`x2_every`, on `candidate/flat-walk-proofs`) never finished
   in 9 hours and goes the same way. Each obligation gets a time budget,
   reported when exceeded (Ode's lessons 12-14).

   **The design** (read October 17): the message kernel
   (`blake3_sme2_hash16_messages_512`, which the chunk kernel's entry
   jumps into) has a block loop inside its group loop, 0x21c to 0xcbc:
   `x7` counts blocks from 0, `x9` is the next block's offset (64 at the
   first arrival), `x6` the iterations (`cbz x6` skips the loop), the hash
   state in `z0`-`z7` (each iteration ends with the feed-forward `eor`s),
   and each iteration compresses the block already in ZA while it loads
   the next; the first block is loaded before the loop and the last
   compressed after it (0xcc0). The proofs know the block count, so they
   unroll this loop: n chained compressions per lane, built and compared.
   Instead, (a) prove the block loop's step once, for every message
   length: at the head, the hash state fresh symbols (what `Generalized`
   already makes of the positions that differ) and ZA block K's bytes;
   one iteration must leave the standard's compression of that state with
   block K under the flags of block K (start at K = 0); (b) in the group
   induction, check the loop starts at the key and block 0 and leaves after
   n blocks, and take its result as the step folded n times, which is how
   the standard defines a chunk's chaining value. No group-level
   compression terms are built. The missing piece: block K's bytes at a
   symbolic offset 64K. The message model (`chunk_byte` in
   `prove_messages_every`) reads only at concrete offsets within a group,
   so messages become arrays indexed by a symbolic offset (Z3's `Select`),
   with `canon` and the checks following. Expected: `every` and the fifteen
   `messages_every` cases, about 18 CPU-hours, in minutes.
   **And the hybrid kernels' step** (`prove_hybrid.py`): 327 cases, 3.1
   CPU-hours, on four workers of about 1 GB each, so 90 minutes on
   October 17; sixteen workers would take about 12 (its README's "2 min"
   is stale).
3. **The kernel proofs, complete**: the SME2 hybrid kernel at every
   group count (above), the ZA forms Isla cannot run yet, and then less
   trusted: the machine-code proofs on Arm's own specification in Lean
   (`probe/sail-lean`). `candidate/flat-walk-proofs` proves Rust (the SME2
   flat walk as compiled), so it leaves the plan with the narrowing;
   close #40 and the branch once Zooko agrees.
4. **Mutation testing**: Loom for the pool's interleavings (the "OPEN"
   survivors), and the queue's survivors go with the queue.
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

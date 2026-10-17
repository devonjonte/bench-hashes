# Next steps

Read this file first. The work: make the servil fork the fastest BLAKE3 in
every situation a user meets, the streaming APIs first, natively on the
Mac first, then in the VM, measured by this benchmark; prove what users
rely on; keep everything as simple as it can be. The principles are in
both repositories' `AGENTS.md`; the fork's design and measurements in its
`NOTES-servil.md`, what is proved and tested in its `QUALITY.md`; this
repository's measurement design in `NOTES.md`. This file says where the
work stands and what comes next; its history is in git.

## Where things stand (October 17, 2026, morning)

- **`servil`** = 4d4eecc: the measurement change (every cell judged at
  once, fresh layouts per pair, `regress` checking the load around its
  runs, `compare --bench`), mutation testing over the whole library, the
  cuts, and the C API. bench-hashes `main` pins it, with CPU time beside
  wall time (#21).
- **The proofs keep to the assembly kernels** (Zooko, October 16): the
  Rust is tested (mutation testing, coverage, Miri). `candidate/narrow-
  proofs` removes the Rust proofs (Aeneas, Kani, the whole-call and Rust
  machine-code proofs) and their tools, makes the old proved cores
  ordinary modules (`src/hasher.rs`, `src/tree.rs`), classifies their
  survivors, runs the mutation check in 44 minutes (was 62), and starts
  the long proofs' longest cases first, five at once. Its gate is done but
  the long proofs, running since 09:13 UTC
  (`tmp/wt-np/tmp/long-proofs/`, about six hours).
- **The Mac calibration passed**: identical code with fresh layouts read
  level on the gate's cells and on every cell (runner jobs 1560, 1561).
- **#59 on the Mac** (jobs 1562, 1563; fork #59 comment): against
  `servil`, 44 cells faster (continuous messages 15-70%), 3 slower (a
  lent 1 MiB message, a 16 Ki lent batch, a 64 Ki continuous batch, 8-10%;
  Devon traces them); one spinner costs 8-10% wall time on continuous
  messages there and saves 1-2% CPU time, from 4 quiet pairs (no verdict).
- **The Mac's busy windows**: 1-1.6 CPUs for a second or a few, every
  few minutes, with the VM idle and the assistant silent (job 1564 beside
  a log of the VM's own CPU). They cost full comparisons their verdicts.
  Source unknown; Zooko's `top` during a job would tell.

## Tonight, while Zooko sleeps (he asked, October 17)

1. Resume the paused long proofs of `candidate/narrow-proofs` (SIGCONT,
   `tmp/night/paused-pids.txt`) and promote it when they pass; then the
   stack on it (`candidate/after-narrow`, #59).
2. **Build the block-loop proof** (item 2's design below: one pass of the
   message kernel's block loop proved once, the group loop's proof using
   it), then run it on the chunk and message kernels, and `x2_every`.


1. The spin: on Linux one spinner saves 5-21% CPU time for up to 12%
   wall time; on the Mac it saves 1-2% for 8-10%. Keep the 5 us spin?
2. The queue's retirement (bench-hashes #20), on 1563's numbers.
3. The busy windows: `top -l 120 -s 1 -o cpu -n 8 -stats pid,command,cpu`
   on the Mac during a runner job, to name their source.
4. The library's name: `libb3` or `libb3_servil`.

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
   Newer Apple chips have more SME units. **Then circle back:** did the
   energy measurements change a decision? If not, drop the instrument too.
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

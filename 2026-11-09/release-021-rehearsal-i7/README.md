# bench-hashes 0.21 release rehearsal at the release candidate, i7-12700K

**Question.** Do 0.21's release runs pass at the release candidate: bench-hashes devonjonte `evidence/devon-release-021-f42e6302` (f42e6302), which is `next` with bench-hashes #157, #152 and the pipeline batch cells, the diagnostic events, the read-overhead line, `compare --markdown` and the notes? It pins BLAKE3-Servil dcc8ccff.

**Command.** `rehearse-3.sh`: the full run (`--all --expect-servil dcc8ccff`), the b3sum run (LAYOUTS=4) and the crowd run, on a quiet machine.

**Result.** Every run exits 0 (`rehearse3.stdout.txt`): full 499 s, b3sum 563 s, crowd 25 s. The full run's load reads quiet (0.15 CPUs on average). Its samples hold the pipeline's ContinuousBatches cells (14 rows, solo and shared) and its receive cells (6), the small-arrival turns (InterleavedTurn and its idle and brief-idle twins; the controlled twin needs root), and the `counts read overhead` line (P 494 cycles, 290 instructions; E 539, 290).

**Afterwards.** The candidate was rebuilt on `next` once #157 and #152 had landed there (7af3fb17). Its measuring code (`src/`, `clocks/`, `build.rs`, the lock) is identical to f42e6302's apart from `cargo fmt`; the differences are pinned-run's lifecycle fix (#152) and the maintainers' notes.

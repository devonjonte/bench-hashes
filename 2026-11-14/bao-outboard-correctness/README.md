# Bao outboard study: reference CLI and byte equality

November 14, 2026. [Study tracker](https://github.com/servil-software-factory/bench-hashes/issues/227);
Servil candidate branch of [the tree API work](https://github.com/servil-software-factory/BLAKE3/issues/378).

## What is established

Two complete commands produce identical output before any timing:

- **BLAKE3-Servil's** `b3sum --outboard`, candidate
  `ed4be078701083c6df85e0642982dc57d22e5923`, built from its clean clone with its
  lock; its 39 crate tests pass on the worker.
- **The study reference**, `tools/bao-reference` at
  `e08e2604fb9a400238dc28cc97e6faa658e6f061` on `probe/devon-bao-outboard`:
  a separate pinned Cargo project over bao-tree 0.17.0's public writer with
  official BLAKE3 1.8.7, one hashing thread, kept output storage and mapped
  immutable inputs. Its three CLI tests pass locally and on the worker.

Nine lengths cover empty, `abc`, group boundaries 16383/16384/16385, 32768,
50000, 1 MiB+1 and 12 MiB+17. For Servil thread settings 1 and 3 against the
one-thread reference, every printed root/path line and every `.obao4` byte agree,
with the expected `64 × (groups − 1)` sizes (`equality.json`). The fixed `abc`
root anchors the digests. Both `--version` outputs name the exact compiled
sources; locks and toolchain records are retained.

Both commands require an existing output directory and replace existing output
files; writes use ordinary completion without fsync. The reference records the
caller contract for this study; bao-tree keeps its own buffering strategy.

## Shared layout tooling

`tools/b3sum-contenders.py` now passes the relinker its build context and binary
name, with `b3sum` as the default, so the study reference can use the same
randomized-layout protocol. Fixed-contract tests cover the shuffle's whole-symbol
orders, static flags, retained-layout reuse, and the existing CLI's exact printed
names, artifacts and worktree. Build commands and defaults stay unchanged.

## Failures kept

- The first validation job stopped at the module path for the mutation helper;
  that belonged to the Ring study and is archived there.
- First reference build: E0282 on the generic outboard Default; corrected by
  the explicit Vec-backed type (`eac4dc74`).
- First equality job: Servil's command exits 1 when the output directory is
  absent, since each worker creates files in an existing directory. The run and
  a local control are retained; the reference now shares that precondition, and
  validation creates directories outside both timed commands.

## Timing pilot (TIMING-PLAN.md; `pilot/`)

The predeclared warm-scope pilot ran on the quiet EPYC 9275F at 21:00 UTC:
five contenders × four shared relinker layouts, standard files, five rounds,
`bao` (one-thread reference) as the report's base, every writer into its own
`{OUT}` directory emptied outside the timed child. The first attempt stopped on
its own wrong argument count (16 for 20) before measuring and is retained.
Load stayed at 0.00 CPUs average. These are complete-process costs: start, read,
hash, outboard writes, exit. Five rounds make a survey, not a release gate.

Warm highlights (mean per run; CPU/memory medians beside them in the report):

| Input | bao | servil-outboard | servil-hash | servil-1-outboard | servil-1-hash |
|---|---:|---:|---:|---:|---:|
| 4 KiB | 321 μs | ×1.64 | ×1.35 | ×1.27 | ×1.44 |
| 1 MiB | 374 μs | ×1.14 slower | ×1.04 | ×1.18 slower | ×1.32 |
| 16 MiB | 2.80 ms | ×0.45 faster | ×0.40 faster | ×1.00 | ×0.74 faster |
| 1 GiB | 165 ms | ×0.064 faster | ×0.041 faster | ×0.93 faster | ×0.69 faster |
| 1000×16 KiB, one run | 13.3 ms | ×0.61 faster | ×0.19 faster | ×0.77 faster | ×0.40 faster |
| 1000×16 KiB, a process each | 162 ms | ×1.63 slower | ×1.35 slower | ×1.49 slower | ×1.38 slower |

Readings to own:

- **Startup dominates small inputs.** The minimal reference's process costs about
  320 μs warm; Servil's b3sum costs 420–530 μs whatever the flags, so every
  per-process cell and 4 KiB–1 MiB cell reads slower. That cost belongs to the
  CLI, with the earlier C-API startup findings.
- **The outboard's added cost over hashing alone** (same binary, same budget):
  one-thread 1 GiB +34% (153 versus 114 ms); default threads 1 GiB +61%,
  256 MiB +33%, and the 1000-file tree 3.3× (8.15 versus 2.49 ms), where one
  `.obao4` file is created per input through two writer threads.
- **Large warm files favor Servil strongly**: ×0.064 at 1 GiB with default
  threads against the one-thread reference, ×0.93 at matched one-thread budget.
- Cold cells were collected and retained (storage reads checked); their study,
  including O_DIRECT behavior, keeps its own later plan.

## Scope and next move

Byte equality was established before timing, and the samples/report/map are under
`pilot/` for the standard readers. In-memory generation through the library
benchmark remains a separate scope. Next: post the pilot to the tracker, and
weigh with John whether the CLI startup and per-tree outboard write costs merit
library/CLI issues of their own before any promotion into standard cells.

`recipes/` holds the scripts/controls; each job folder holds its original logs,
versions, locks and `equality.json`. Executable binaries, generated inputs and
outboard payload files stay local. Both manifests bind this archive, excluding
themselves.

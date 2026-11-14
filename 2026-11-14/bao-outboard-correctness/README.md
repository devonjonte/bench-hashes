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

## Scope and next move

This is correctness/contract evidence only; no performance was collected and no
claim about relative speed is made. Timing needs a predeclared plan: in-memory
generation apart from complete commands, matched output policy, explicit thread
budgets, hash-only b3sum as the added-cost baseline, randomized layouts through
the shared relinker, and quiet-host locks. Devon owns that next step.

`recipes/` holds the scripts/controls; each job folder holds its original logs,
versions, locks and `equality.json`. Executable binaries, generated inputs and
outboard payload files stay local. Both manifests bind this archive, excluding
themselves.

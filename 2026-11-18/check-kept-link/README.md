# `check` links its layouts from one kept link (November 18, 2026)

**Question.** `bench-hashes check` gives each pair of runs a fresh link layout on each side, and each
layout was a compile of the bench crate. Can a side compile once a stage and run that link again for
its other layouts, with every executable the same bytes a compile would have given, on the machines
the checks run on? And what does a check then cost?

**Commits.** bench-hashes `candidate/devon-relink-kept-link`: `bfa51544` (the kept link), `41e00496`
(the second stage's 64 pairs each get a layout), `8e11ced7` (the margin is 5%; one memory node);
compared with bench-hashes 0.23.0 `cade30fd`. Libraries in every probe: BLAKE3-Servil `4483281c`
against `27eacce3`. Earlier revisions `61ad1c8a` and `e04c950e` appear in the Mac's failed tries.

**Verdict.** Yes on x86-64 Linux, aarch64 Linux and macOS.

| where | what ran | result |
|---|---|---|
| Ryzen 9700X (`runs/x86-9700x/`) | `check --probe '64 B' --layouts 16`, bench 0.23.0, then `bfa51544` | 13.5 minutes, then 3.0 (`progress.txt`); both exit 0 |
| Arm VM (`runs/arm-vm/`) | the same probe, `bfa51544` | exit 0 in 7.2 minutes: the kept link reproduced Cargo's bytes on aarch64 |
| Apple M6 (`runs/mac-m6-timing/3378-*`) | `check --probe '64 B' --layouts 4`, `bfa51544` | status ok, 2.5 minutes with its builds |
| Apple M6 (`3379-*`, a diagnostic build) | a layout compiled the old way beside its unstripped twin | all 19 code and data sections the same contents on both libraries; the symbol table's segment 393,216 bytes against 589,824 |
| local (`local-smoke/exit.txt`, an i7; its timings are no evidence) | the probe twice in a row, then today's compile of one later seed a side | both checks exit 0; each relinked executable equals the compile's, byte for byte |
| workhorse (`runs/x86-workhorse/`) | `cargo nextest run`, debug and release | 198 tests pass at `8e11ced7` (199 at `bfa51544`, which still had a test since removed) |

**What failed on the way, kept.** Mac job 3376: sourcing a kept `export -p` environment was a syntax
error in the Mac's `sh` (the environment is now `env`'s lines, given to `cc` directly). Mac job 3377:
the relink ran and gave other bytes, and the byte check stopped it: a Mach-O signature names its
file, and rustc strips debug symbols in a step after the link. The relink now writes where the first
link wrote, and macOS layouts are built with `-C strip=none`.

**Commands.** `scripts/host-probe.sh` (the measurement hosts), `scripts/smoke.sh` (local),
`scripts/workhorse-tests.sh`; the Mac jobs are `runs/mac-m6-timing/jobs/`.

**Posted.** The pull request on servil-software-factory/bench-hashes for `candidate/devon-relink-kept-link`;
investigation [devonjonte/bench-hashes #3](https://github.com/devonjonte/bench-hashes/issues/3).

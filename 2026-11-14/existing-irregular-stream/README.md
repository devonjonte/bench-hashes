# Existing irregular-stream coverage sees the staged-tail fix

November 14, 2026. Related: [irregular-update fix](https://github.com/servil-software-factory/BLAKE3/issues/393).

## Decision

**Reuse the existing workload for this first coverage milestone.** In this pilot,
the single-threaded saturated-receive case detects the known improvement. Retain
that coverage; an additional case needs a specific remaining gap. This finding
covers the declared caller and host, leaving other API paths and platforms to their
own evidence.

The existing `receive saturated` cell hashes a 16 MiB message through a fresh
incremental Hasher, copying 1448/4096/16384/65536-byte fragments into the kept 64 KiB
buffer. Its arrival spacing is zero. `continuous 16 MiB` uses that same adapter
and buffer with uniform 64 KiB pieces. Every byte and final digest is consumed.
They run in separate workload phases, so their cross-cell ratio alone does not
isolate fragmentation cost. The old/new comparison within each cell is primary.

## Results

Benchmark **da6fe3c478e3e25c23ab05514a1723e1e20f5e2f** throughout. Library parent
**8041bd858586abafa0857fb4ec5ed1f0767f67a4** versus fix
**ab256b0d9ebb44eececd71ce0ae37113e75634a5**; unchanged control uses the fix on both
sides with identical declared build/run settings. Each question has three fresh
layout pairs on EPYC 9275F, Servil st alone. All 12 accepted records report quiet.
Kernel NUMA balancing was 0; the job changed no memory policy. Cycles, instructions
and energy were unavailable; wall and process CPU time are retained.

| Case | Fixed/fixed wall ratio | Parent/fixed wall ratio | Parent/fixed CPU ratio |
|---|---:|---:|---:|
| Aligned continuous 16 MiB | 1.002, Level | 0.986, Level | 0.987 |
| Irregular saturated receive | 0.998, Level | **0.662, Faster** | 0.662 |

The changed receiving pairs take 33.7–33.9% less wall time. The aligned case's
wall-time estimate is 1.4% lower, with one of three pairs faster, and remains Level. Level is insufficient
evidence, not equivalence. The unchanged receiving wall-time estimate is 0.2% lower.
This is finite-scope sensitivity evidence, neither full-procedure calibration nor
a release gate. It leaves the adverse full-run readings in the library commit
under their original scope and owner's judgment.

## Inputs, execution and replay

The [plan](PLAN.md) and submitted script were committed before collection at
`3c2c04597` on the data branch. `run.sh` remains byte-identical to the delivered
script. It uses the existing `check --probe`, an explicit identical `--old-bench`
for the unchanged control, the host lock and quiet checks. Driver logs stay beside
new kept directories. There was no expanded search or repeat campaign.

The two comparison outputs reproduce byte for byte with the Rust reader. Its
`src/main.rs`, `src/check.rs`, `clocks/`, Cargo manifest and lock are byte-identical
to the producer's sources; the available executable was built at
`adc20bdd76f7346e263b4d533afc596c0de383d5`, whose additional changes concern UI.
`reader-source-match.txt` records the empty diff, and the replay script holds the
exact comparison commands. Python inspected header identity/load fields only.

The job finished at 18:23 UTC. Its timestamps span 3m49s for the six-run unchanged
question including preparation, and 2m24s for the changed question. These operational
timestamps are separate from hash-speed measurements. Original logs and all 12 raw
samples stay under `x86-epyc-9275f/`.
Source/work directory names must be fresh for a rerun. Both manifests bind this
record; raw TSV files retain their original bytes, with home prefixes redacted only
in textual logs and recipes. No executable binaries are published.

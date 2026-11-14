# Outboard timing pilot — predeclared before any sample

[Tracker](https://github.com/servil-software-factory/bench-hashes/issues/227).
Correctness record: data `dfb16879096a2ee2a7ea168c501ae5e5fe8b1b8c`.

## Question

What does each complete outboard command cost on warm files, and what does
producing the outboard add over hashing alone, for the programs just proved
byte-identical?

## Fixed design

- Programs, each with LAYOUTS=4 randomized function orders through the shared
  relinker, each contender one build per round:
  - `bao` → reference `bao-reference --outboard OUT` (always one thread),
    source branch head `e92716a60fc67b8a1f47abdac6b97e9980d205bc`, BAO_REFERENCE_SOURCE set.
  - `servil-outboard-1` → candidate b3sum `--num-threads 1 --outboard OUT`.
  - `servil-outboard` → candidate b3sum `--outboard OUT` (its own thread policy).
  - `servil-hash-1`, `servil-hash` → the same binary without `--outboard`:
    the added-cost baseline, same files, same budgets.
  - Library source `ed4be078701083c6df85e0642982dc57d22e5923` for every Servil form.
- Harness: the existing `bench-hashes b3sum` child-process runner at
  `5c0efb96b05fbc294769b967899a4c680d0ee7b2`, NAME=COMMAND contenders, its
  standard files/rounds. It measures complete processes with OS counts and load
  windows and draws its own report/map. The required addition is built and tested
  on the probe branch (`e92716a6`): a per-contender `{OUT}` placeholder whose
  directory the harness empties before each run, outside timed child processes,
  so output writes land on the machine's storage without accumulating.
- Scope: warm cache only in this pilot (`--rounds 5`); the cold path and
  O_DIRECT behavior get their own plan because eviction interacts with outputs.
- Host: EPYC 9275F under its lock via bench-submit; quiet rule as always;
  record NUMA/affinity; absent hardware counters stay an attribution limit.
- In-memory generation (no files) is a separate later scope through the
  library benchmark, not this pilot.

## Reading

Per-unit means and pairwise ratios come from the standard samples reader.
Primary comparisons: outboard command versus its own hash-only baseline
(added cost), and Servil one-thread outboard versus the reference (matched
budget). The default-thread form is reported beside them with its budget
explicit. Writes/syncs policy identical by construction. Report wall and CPU
with load qualification; one pilot run is a survey, not a release gate or a
general superiority claim.

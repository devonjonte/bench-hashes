# BLAKE3-Servil 0.8 → 0.9 → 0.10: measured performance

Measured November 16, 2026, on six x86-64 Linux machines with
[bench-hashes](https://github.com/servil-software-factory/bench-hashes) 0.23.
"0.10 candidate" is commit `7048303103c69b8609ffe9ca0361197ba318107c` of
[BLAKE3-Servil](https://github.com/servil-software-factory/BLAKE3), measured
before the 0.10.0 tag exists; b3sum is to be measured again at the tag.

Every number here is a **time ratio**. It divides the time one program takes by the
time another takes for the same work in the same run: ×0.66 means 34% less time, and
×1.00 means the same. A ratio counts as **faster** or **slower** when the run's
repeated pairs agree on it. Every other ratio is **level**: the runs give
insufficient evidence of a difference.

## b3sum: the part anyone can try

`b3sum FILE...` prints BLAKE3 digests of files. Each measurement times the whole
process, from its start to its exit, on ten inputs. Each input is measured **warm**
(the files are in the operating system's page cache) and **cold** (evicted first, so
they are read from storage). The three BLAKE3-Servil versions and official b3sum ran
in the same rounds on each machine, four separately linked copies of each.

### Against official b3sum 1.8.7

**b3sum 0.10 candidate against official b3sum 1.8.7** (6 machines; time ratio, below 1 is faster)

| input | warm: range | warm: machines faster / slower | cold: range | cold: machines faster / slower |
|---|---:|---:|---:|---:|
| 4 KiB | ×0.10–×0.46 | 6 / 0 | ×0.13–×0.49 | 6 / 0 |
| 64 KiB | ×0.11–×0.48 | 6 / 0 | ×0.14–×0.68 | 6 / 0 |
| 1 MiB | ×0.12–×0.60 | 6 / 0 | ×0.27–×0.82 | 6 / 0 |
| 16 MiB | ×0.33–×0.77 | 6 / 0 | ×0.42–×0.67 | 6 / 0 |
| 256 MiB | ×0.50–×0.86 | 6 / 0 | ×0.52–×0.71 | 6 / 0 |
| 1 GiB | ×0.52–×0.97 | 6 / 0 | ×0.50–×0.78 | 6 / 0 |
| 1000 x 16 KiB | ×0.11–×0.28 | 6 / 0 | ×0.04–×0.12 | 6 / 0 |
| 1000 x 16 KiB, a process each | ×0.08–×0.38 | 6 / 0 | ×0.11–×0.51 | 6 / 0 |
| mixed tree, 1000 files, 74 MiB | ×0.10–×0.37 | 6 / 0 | ×0.08–×0.14 | 6 / 0 |
| 16 x 64 MiB | ×0.35–×0.93 | 6 / 0 | ×0.41–×0.64 | 6 / 0 |

- **Faster on every input, warm and cold, on all 6 machines:** from ×0.97 to ×0.04.

#### On an Apple M6 (macOS)

One run on the dedicated timing Mac, the 0.10 candidate against official b3sum
1.8.7, both built there. The Mac queue builds one BLAKE3-Servil version a job, so
0.9.0 has no column here.

Load: busy: other programs kept 0.25 CPUs busy on average, 1.08 in the busiest window; busy in 1 of 478 windows (367.9-369.0 s). Runs: 15 rounds, each contender once on each input in each.

| input | warm: official | warm: b3sum | cold: official | cold: b3sum |
|---|---:|---:|---:|---:|
| 4 KiB | 1.25 ms | 1.22 ms ×0.976 | 1.67 ms | 1.44 ms ×0.915 |
| 64 KiB | 1.16 ms | 1.12 ms ×0.966 faster | 1.40 ms | 1.27 ms ×0.911 faster |
| 1 MiB | 1.17 ms | 1.26 ms ×1.074 slower | 2.11 ms | 1.79 ms ×0.849 faster |
| 16 MiB | 2.02 ms | 2.06 ms ×1.019 | 8.53 ms | 5.87 ms ×0.693 faster |
| 256 MiB | 15.7 ms | 13.4 ms ×0.853 faster | 141 ms | 79.1 ms ×0.560 faster |
| 1 GiB | 57.9 ms | 47.7 ms ×0.824 faster | 724 ms | 312 ms ×0.432 faster |
| 1000 x 16 KiB | 41.1 ms | 5.45 ms ×0.133 faster | 86.0 ms | 12.9 ms ×0.150 faster |
| 1000 x 16 KiB, a process each | 1.07 s | 1.05 s ×0.982 | 1.14 s | 1.11 s ×0.971 |
| mixed tree, 1000 files, 74 MiB | 35.3 ms | 7.35 ms ×0.208 faster | 154 ms | 31.4 ms ×0.203 faster |
| 16 x 64 MiB | 59.7 ms | 51.4 ms ×0.860 faster | 569 ms | 324 ms ×0.569 faster |

- **Faster there:** 64 KiB (warm and cold); 256 MiB (warm and cold); 1 GiB (warm and cold); 1000 x 16 KiB (warm and cold); mixed tree, 1000 files, 74 MiB (warm and cold); 16 x 64 MiB (warm and cold); 1 MiB (cold); 16 MiB (cold).
- **Level there:** 4 KiB (warm and cold); 16 MiB (warm); 1000 x 16 KiB, a process each (warm and cold).
- **Slower there:** 1 MiB (warm).

### Against b3sum 0.9.0

**b3sum 0.10 candidate against b3sum 0.9.0** (6 machines; time ratio, below 1 is faster)

| input | warm: range | warm: machines faster / slower | cold: range | cold: machines faster / slower |
|---|---:|---:|---:|---:|
| 4 KiB | ×0.98–×1.03 | 0 / 0 | ×0.98–×1.07 | 0 / 0 |
| 64 KiB | ×1.00–×1.14 | 0 / 0 | ×1.00–×1.09 | 0 / 0 |
| 1 MiB | ×0.77–×1.00 | 4 / 0 | ×0.98–×1.07 | 0 / 0 |
| 16 MiB | ×0.96–×1.10 | 0 / 0 | ×0.67–×0.87 | 6 / 0 |
| 256 MiB | ×0.95–×1.01 | 0 / 0 | ×0.60–×0.81 | 6 / 0 |
| 1 GiB | ×0.96–×1.03 | 0 / 0 | ×0.54–×0.81 | 6 / 0 |
| 1000 x 16 KiB | ×0.81–×0.89 | 6 / 0 | ×0.56–×1.05 | 3 / 1 |
| 1000 x 16 KiB, a process each | ×0.99–×1.02 | 0 / 0 | ×0.99–×1.02 | 0 / 0 |
| mixed tree, 1000 files, 74 MiB | ×0.86–×0.99 | 4 / 0 | ×0.66–×1.02 | 3 / 0 |
| 16 x 64 MiB | ×0.54–×0.86 | 6 / 0 | ×0.62–×0.81 | 6 / 0 |

- **Faster on all 6 machines:** 1000 x 16 KiB (warm); 16 x 64 MiB (warm and cold); 16 MiB (cold); 256 MiB (cold); 1 GiB (cold).
- **Faster on some machines:** 1 MiB (warm); mixed tree, 1000 files, 74 MiB (warm and cold); 1000 x 16 KiB (cold).
- **Level on every machine:** 4 KiB (warm and cold); 64 KiB (warm and cold); 16 MiB (warm); 256 MiB (warm); 1 GiB (warm); 1000 x 16 KiB, a process each (warm and cold); 1 MiB (cold).
- **Slower on a machine:** 1000 x 16 KiB (cold).

**A second run** of the same programs on 5 machines, each machine's 20 cells again: 38 cells are marked faster in both runs, 5 in the first only and 1 in the second only. Marked slower: `x86-avx2` 1000 x 16 KiB, cold (both runs).

### 0.8.0 against 0.9.0

In this table 0.8.0 is the program judged: below 1 means 0.8.0 took less time than
0.9.0.

**b3sum 0.8.0 against b3sum 0.9.0** (6 machines; time ratio, below 1 is faster)

| input | warm: range | warm: machines faster / slower | cold: range | cold: machines faster / slower |
|---|---:|---:|---:|---:|
| 4 KiB | ×0.95–×1.02 | 0 / 0 | ×0.96–×1.01 | 0 / 0 |
| 64 KiB | ×0.94–×1.06 | 3 / 0 | ×0.93–×1.07 | 0 / 0 |
| 1 MiB | ×0.97–×1.00 | 0 / 0 | ×0.91–×1.05 | 0 / 0 |
| 16 MiB | ×0.92–×1.01 | 3 / 0 | ×0.98–×1.03 | 0 / 0 |
| 256 MiB | ×0.93–×1.03 | 0 / 0 | ×0.98–×1.01 | 0 / 0 |
| 1 GiB | ×0.90–×1.06 | 1 / 0 | ×1.00–×1.00 | 0 / 0 |
| 1000 x 16 KiB | ×0.94–×1.02 | 1 / 0 | ×0.95–×1.02 | 1 / 0 |
| 1000 x 16 KiB, a process each | ×0.95–×0.96 | 6 / 0 | ×0.95–×0.97 | 3 / 0 |
| mixed tree, 1000 files, 74 MiB | ×0.89–×1.00 | 2 / 0 | ×0.95–×1.02 | 1 / 0 |
| 16 x 64 MiB | ×0.79–×1.01 | 0 / 0 | ×0.97–×1.00 | 0 / 0 |

- **Faster on all 6 machines:** 1000 x 16 KiB, a process each (warm).
- **Faster on some machines:** 64 KiB (warm); 16 MiB (warm); 1 GiB (warm); 1000 x 16 KiB (warm and cold); mixed tree, 1000 files, 74 MiB (warm and cold); 1000 x 16 KiB, a process each (cold).
- **Level on every machine:** 4 KiB (warm and cold); 1 MiB (warm and cold); 256 MiB (warm and cold); 16 x 64 MiB (warm and cold); 64 KiB (cold); 16 MiB (cold); 1 GiB (cold).
- **Slower on a machine:** no input, warm or cold.

The two are close. Where they differ, 0.8.0 is the faster one, most clearly when
every small file gets its own process; "Known costs" below says what that is.

Each machine's full tables, with the mean times: [`x86-9700x`](b3sum/x86-9700x.md), [`x86-avx2`](b3sum/x86-avx2.md), [`x86-epyc-9255`](b3sum/x86-epyc-9255.md), [`x86-epyc-9275f`](b3sum/x86-epyc-9275f.md), [`x86-icelake`](b3sum/x86-icelake.md), [`x86-icelake-2`](b3sum/x86-icelake-2.md). Each machine's
second run is beside its page (`b3sum/<machine>-second-run.md`).

### Try it yourself

These commands ran as written on a seventh machine (`evidence/recipe/`); the three
programs printed equal digests.

```sh
cargo install b3sum --version 1.8.7 --root official
RUSTFLAGS="-C target-feature=+crt-static" cargo install b3sums --version 0.9.0 \
    --target x86_64-unknown-linux-gnu --root servil-0.9
RUSTFLAGS="-C target-feature=+crt-static" cargo install b3sums \
    --git https://github.com/servil-software-factory/BLAKE3 \
    --rev 7048303103c69b8609ffe9ca0361197ba318107c \
    --target x86_64-unknown-linux-gnu --root servil-0.10
```

Then time them on a file of yours, for example with
[hyperfine](https://github.com/sharkdp/hyperfine):

```sh
hyperfine -N --warmup 3 'official/bin/b3sum FILE' 'servil-0.9/bin/b3sum FILE' \
    'servil-0.10/bin/b3sum FILE'
```

For the cold case, write the file out once and evict it before each run (checked
with `fincore`: no page of the file stays cached):

```sh
sync FILE
hyperfine -N --prepare 'dd of=FILE oflag=nocache conv=notrunc,fdatasync count=0' \
    'official/bin/b3sum FILE' 'servil-0.9/bin/b3sum FILE' 'servil-0.10/bin/b3sum FILE'
```

The measurements on this page come from `bench-hashes b3sum`, which alternates
the programs round by round, evicts the files itself, watches the machine's load
and judges the pairs; each machine's `run.sh` under `evidence/` is the exact
command.

## The library

bench-hashes measures the library's calls directly, in a few hundred **cells** per
form: each a use case at one size or count (one message, many messages, messages after
a pause, streams, batches, a Merkle tree, collections of real files), alone and
beside another busy program. The library has two forms: **one thread**, and
**every core**, which may use the machine's other cores. A release check measures
the old and the new library in alternating pairs and judges every cell.

- **0.8.0 → 0.9.0, one thread** (5 machines): 4 to 16 cells faster and 0 to 5 slower per machine, of 213.
- **0.9.0 → 0.10 candidate, one thread** (7 machines): 2 to 24 cells faster and 0 to 3 slower per machine, of 220 to 222.
- **0.9.0 → 0.10 candidate, every core** (7 machines): 0 to 78 cells faster and 0 to 11 slower per machine, of 226 to 265.
- **0.8.0 → 0.10 candidate, one thread** (6 machines): 7 to 18 cells faster and 0 to 2 slower per machine, of 213.

| host | step | form | cells | faster | slower | left out: the benchmark's call changed | largest gain |
|---|---|---|---:|---:|---:|---:|---|
| `x86-epyc-9275f` | 0.8.0 → 0.9.0 | one thread | 213 | 11 | 0 |  | solo · IdleOneMessage · 7935 B ×0.541 |
| `x86-epyc-9275f` | 0.9.0 → 0.10 candidate | one thread | 222 | 16 | 0 |  | solo · ReceivingMessage · saturated ×0.579 |
| `x86-epyc-9275f` | 0.9.0 → 0.10 candidate | every core | 265 | 47 | 11 | 69 | shared-one-cache · LentBatches · 16384 ×0.385 |
| `x86-epyc-9275f` | 0.8.0 → 0.10 candidate | one thread | 213 | 15 | 1 |  | solo · IdleOneMessage · 7935 B ×0.546 |
| `x86-epyc-9255` | 0.8.0 → 0.9.0 | one thread | 213 | 16 | 5 |  | solo · IdleOneMessage · 7935 B ×0.538 |
| `x86-epyc-9255` | 0.9.0 → 0.10 candidate | one thread | 220 | 11 | 1 | 2 | solo · ReceivingMessage · saturated ×0.579 |
| `x86-epyc-9255` | 0.9.0 → 0.10 candidate | every core | 260 | 50 | 10 | 74 | solo · BriefIdleManyMessages · 8192 ×0.408 |
| `x86-epyc-9255` | 0.8.0 → 0.10 candidate | one thread | 213 | 18 | 0 |  | solo · IdleOneMessage · 7935 B ×0.543 |
| `x86-9700x` | 0.8.0 → 0.9.0 | one thread | 213 | 14 | 3 |  | solo · BriefIdleOneMessage · 7935 B ×0.549 |
| `x86-9700x` | 0.9.0 → 0.10 candidate | one thread | 221 | 5 | 0 | 1 | solo · ReceivingMessage · saturated ×0.581 |
| `x86-9700x` | 0.9.0 → 0.10 candidate | every core | 230 | 0 | 1 | 48 |  |
| `x86-9700x` | 0.8.0 → 0.10 candidate | one thread | 213 | 16 | 2 |  | solo · BriefIdleOneMessage · 7935 B ×0.548 |
| `x86-icelake` | 0.8.0 → 0.9.0 | one thread | 213 | 10 | 1 |  | solo · OneMessage · 7935 B ×0.631 |
| `x86-icelake` | 0.9.0 → 0.10 candidate | one thread | 222 | 2 | 3 |  | solo · ReceivingMessage · saturated ×0.807 |
| `x86-icelake` | 0.9.0 → 0.10 candidate | every core | 262 | 50 | 3 | 72 | shared-two-caches · MerkleTree · 65536 x 32 B ×0.571 |
| `x86-icelake` | 0.8.0 → 0.10 candidate | one thread | 213 | 12 | 0 |  | solo · OneMessage · 7935 B ×0.636 |
| `x86-icelake-2` | 0.9.0 → 0.10 candidate | one thread | 222 | 2 | 1 |  | solo · ReceivingMessage · saturated ×0.806 |
| `x86-icelake-2` | 0.9.0 → 0.10 candidate | every core | 264 | 40 | 0 | 70 | shared-two-caches · MerkleTree · 65536 x 32 B ×0.607 |
| `x86-icelake-2` | 0.8.0 → 0.10 candidate | one thread | 213 | 15 | 1 |  | solo · OneMessage · 3839 B ×0.620 |
| `x86-avx2` | 0.8.0 → 0.9.0 | one thread | 213 | 4 | 1 |  | solo · ContinuousMessages · 64 B ×0.845 |
| `x86-avx2` | 0.9.0 → 0.10 candidate | one thread | 221 | 24 | 0 | 1 | solo · OneMessage · 4 MiB ×0.772 |
| `x86-avx2` | 0.9.0 → 0.10 candidate | every core | 265 | 78 | 1 | 69 | shared-one-cache · LentBatches · 65536 ×0.039 |
| `x86-avx2` | 0.8.0 → 0.10 candidate | one thread | 213 | 7 | 0 |  | solo · BriefIdleOneMessage · 3 KiB ×0.672 |
| `apple-m6` | 0.9.0 → 0.10 candidate | one thread | 221 | 5 | 0 | 1 | solo · ManyMessages · 1 ×0.888 |
| `apple-m6` | 0.9.0 → 0.10 candidate | every core | 226 | 4 | 0 | 52 | shared-os · ContinuousMessages · 16 KiB ×0.472 |

A cell's name reads scenario, use case, then size or count: `solo` is the program
alone, `shared-…` is beside another busy program.

Steps from 0.8.0 cover the one-thread form. Each library version is measured by
the bench release of its time, and only cells that both releases define are
compared. For 0.9.0 → 0.10 the same library was also measured under both bench
releases; the cells where that control already differs are the benchmark's own
change of call (the every-core stream cells moved to the library's Pipeline), and
the counts leave them out. Each machine's page lists them with both ratios.

Each machine's cells by use case, its slower cells by name and its ten largest
gains: [`apple-m6`](library/apple-m6.md), [`x86-9700x`](library/x86-9700x.md), [`x86-avx2`](library/x86-avx2.md), [`x86-epyc-9255`](library/x86-epyc-9255.md), [`x86-epyc-9275f`](library/x86-epyc-9275f.md), [`x86-icelake-2`](library/x86-icelake-2.md), [`x86-icelake`](library/x86-icelake.md).

## Known costs, each with its owner

- **Large one-shot calls on machines with several L3 caches** (John Servil,
  [BLAKE3 #401](https://github.com/servil-software-factory/BLAKE3/issues/401)).
  On the two machines whose cores span three L3 caches, the every-core form's
  one-shot calls of 32 MiB and more, and a few shared cells with them, read slower
  in the mean since the cache-topology pool (`3ec37f0e`); each is named on those
  machines' pages. The cost sits in six of each cell's first 24 calls, which take
  ×1.3 to ×1.8 as long; the other calls take the earlier time
  ([pattern and evidence](../topology-one-shot-pattern/README.md)).
- **The Pipeline with very large owned batches** (John Servil,
  [BLAKE3 #389](https://github.com/servil-software-factory/BLAKE3/issues/389)): batches
  of 16,384 and 65,536 messages take 22% to 196% longer through the Pipeline than
  through the synchronous call in the same-library control.
- **b3sum's start, 3% to 5% since 0.8.0** (John Servil,
  [BLAKE3 #375](https://github.com/servil-software-factory/BLAKE3/issues/375)): the
  row "a process each" above. A [profile](../b3sum-startup-profile/README.md) finds
  about 28,000 more user instructions and 12 more page faults per run in 0.9.0; b3sum's
  own share of a small run is about a tenth, the rest is process creation.
- **One message of about 4 KiB on Zen 5, 0.8.0 → 0.9.0**
  ([BLAKE3 #376](https://github.com/servil-software-factory/BLAKE3/issues/376)),
  recorded with 0.9.
- **b3sum on a thousand 16 KiB files read cold in one run, on the two-socket EPYC
  7443** (John Servil,
  [BLAKE3 #403](https://github.com/servil-software-factory/BLAKE3/issues/403)): ×1.05
  against 0.9.0 in both runs there, 10.4 → 10.9 ms, while keeping 5.9 CPUs busy where
  0.9.0 kept 8.7 to 8.9. The same input is faster or level on the other machines.
- **A turn of 1024 × 1 KiB messages on Ice Lake, 0.9.0 → 0.10** (John Servil,
  [BLAKE3 #404](https://github.com/servil-software-factory/BLAKE3/issues/404)): 2% to 5%
  slower on both Xeon pairs, in both forms; the same-library control and the AMD
  machines are level.
- **Every other slower cell** is listed by name on its machine's page.

## Scope

- **Machines:** x86-64 Linux: AMD Zen 5 (EPYC 9275F, EPYC 9255, Ryzen 9700X), AMD
  Zen 3 (two EPYC 7443), Intel Ice Lake (two pairs of Xeon Gold 6330). One Apple
  M6, for b3sum against official and for the library's 0.9.0 → 0.10 step. Arm Linux
  is still to be measured for the 0.10 candidate.
- **Storage:** cold results depend on the storage; each machine's b3sum page names
  the file system and device.
- **Programs:** every b3sum here is built from source by one toolchain on the
  machine that measured it.

## Evidence

- **This folder:** `evidence/<machine>/evolution-010/` holds each machine's b3sum
  report and samples, the kept runs of its 0.8.0 → 0.10 check, the versions and
  toolchain, and `run.sh`; `evidence/recipe/` holds the three runs of the commands
  above; `tools/` holds the scripts that wrote this page. `SHA256SUMS` and
  `BLAKE3SUMS` cover every file.
- **Apple M6:** its b3sum report and samples are in `evidence/apple-m6/`, as published
  in bench-hashes' `benchmark-results/AppleM6.darwin27/`.
- **0.8.0 → 0.9.0:** the release runs of bench-hashes 0.22,
  [`2026-11-13/release-022/`](../../2026-11-13/release-022/README.md).
- **0.9.0 → 0.10 candidate, the same-library control, and b3sum against official:**
  the release runs of bench-hashes 0.23,
  [`2026-11-16/release-023/`](../release-023/README.md); the same b3sum results are
  drawn on the [published overview](https://servil-software-factory.github.io/bench-hashes/).
- **Versions:** BLAKE3-Servil 0.8.0 `b5b988d8982bea9490c38c79ec4b8c5c2428270c`,
  0.9.0 `bf2da8b957f5e0c80babb57952de3e53f95c921a`, 0.10 candidate
  `7048303103c69b8609ffe9ca0361197ba318107c`; official b3sum 1.8.7; bench-hashes
  `0.23.0+ba147639c35454e648847adbb08e2435e450493e`.
- **How the tables are made:** b3sum cells are copied from each run's report; library
  verdicts are `bench-hashes compare`'s over the kept runs, with the second stage's
  verdict for the cells a check measured again. The scripts count and group; they
  judge nothing.

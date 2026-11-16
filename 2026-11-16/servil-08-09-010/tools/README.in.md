# BLAKE3-Servil 0.8 → 0.9 → 0.10: measured performance

Measured November 16, 2026, on six x86-64 Linux machines with
[bench-hashes](https://github.com/servil-software-factory/bench-hashes) 0.23.
"0.10 candidate" is commit `7048303103c69b8609ffe9ca0361197ba318107c` of
[BLAKE3-Servil](https://github.com/servil-software-factory/BLAKE3), measured
before the 0.10.0 tag exists; @@STATUS@@

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

@@across-010-vs-official@@

@@READING-OFFICIAL@@

### Against b3sum 0.9.0

@@across-010-vs-09@@

@@READING-09@@

@@AGAIN-09@@

### 0.8.0 against 0.9.0

In this table 0.8.0 is the program judged: below 1 means 0.8.0 took less time than
0.9.0.

@@across-08-vs-09@@

@@READING-08@@

The two are close. Where they differ, 0.8.0 is the faster one, most clearly when
every small file gets its own process; "Known costs" below says what that is.

Each machine's full tables, with the mean times: @@B3SUM-PAGES@@ Each machine's
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

@@COLD-RECIPE@@

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

@@READING-LIBRARY@@

@@library@@

A cell's name reads scenario, use case, then size or count: `solo` is the program
alone, `shared-…` is beside another busy program.

Steps from 0.8.0 cover the one-thread form. Each library version is measured by
the bench release of its time, and only cells that both releases define are
compared. For 0.9.0 → 0.10 the same library was also measured under both bench
releases; the cells where that control already differs are the benchmark's own
change of call (the every-core stream cells moved to the library's Pipeline), and
the counts leave them out. Each machine's page lists them with both ratios.

Each machine's cells by use case, its slower cells by name and its ten largest
gains: @@LIBRARY-PAGES@@

## Known costs, each with its owner

@@COSTS@@

## Scope

- **Machines:** x86-64 Linux: AMD Zen 5 (EPYC 9275F, EPYC 9255, Ryzen 9700X), AMD
  Zen 3 (two EPYC 7443), Intel Ice Lake (two pairs of Xeon Gold 6330). Apple
  silicon and Arm Linux numbers for the 0.10 candidate are still to be measured.
- **Storage:** cold results depend on the storage; each machine's b3sum page names
  the file system and device.
- **Programs:** every b3sum here is built from source by one toolchain on the
  machine that measured it.

## Evidence

@@EVIDENCE@@

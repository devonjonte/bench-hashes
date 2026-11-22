# Large messages off a 64-byte boundary: the cost on the AVX-512 machines (November 22, 2026)

**Question** (Sam Shackleton, [bench-hashes #261](https://github.com/servil-software-factory/bench-hashes/issues/261)). The wide kernels read each block with one unaligned 64-byte load, so for a message that starts off a 64-byte boundary every such load crosses a cache line. Where do the bench's large inputs lie, and what does a message 16 bytes past a boundary cost against one on it?

**Verdict.** The published large cells are the aligned case: the bench hands every contender its one-message and batch inputs at a 64-byte boundary. A message off the boundary costs about 2% on the two Zen 5 machines and 1.3% on the Ice Lake Xeon where this probe measures tightly (64 KiB, one thread or the threaded call, which takes one thread at that size). At 1 MiB and 16 MiB the probe cannot separate the cost from its own run-to-run movement: one thread reads between -2.7% and +4.9%. Nothing here reaches the 5% margin the regression check uses.

## Where the bench's inputs lie

`UseCase::in_blocks` (bench-hashes `src/main.rs`, at `7f2a0b21`) names the cells whose input reaches every contender at a 64-byte boundary with whole blocks behind it: the batches, and `OneMessage`, `IncrementalMessage`, `LentIncrementalMessage`, `LentMessages`, `ContinuousMessages`, `Collection`, `ContinuousCollection`. `assert_blocks_aligned` checks it at the contenders' door on every sample, and the test `every_batch_reaches_the_contenders_on_a_64_byte_boundary` feeds a source 16 bytes into a line, as glibc places one, and requires the realignment. The cells fed in pieces (`ReceivingMessage`, `Interleaved` and the turn cells) pass the Hasher whatever slices arrive; this probe did not look at them.

## The probe

- Library: BLAKE3-Servil 0.10.0, `2fd4ff6f643ef04f98f7a2e5f8ca0f096298827a`.
- Program: `probe.rs`, built as an example of `threads/`. Each host's `run.sh` holds the same source and the commands. One thread: `convenience::hash`. Threads: `throughput::update_multithreaded` on a fresh `Hasher`, then `finalize`.
- The same bytes copied to four placements in buffers of their own: on a 64-byte boundary, and 16, 32 and 1 byte past one. Each of 31 rounds times every placement, the order rotating, and the median is reported. Each host ran the program twice (`probe-1.txt`, `probe-2.txt`).
- Hosts, through `bench-submit` (one job at a time on a host): `x86-9700x`, `x86-epyc-9255`, `x86-icelake`.
- Limits: a probe with `Instant` timing, two runs, no load windows, no cycle counts, no pinning. Each placement has a buffer of its own, so its physical pages are a second difference between the arms.

## Results

Each cell gives the two runs. The offset-0 columns are medians in ns a byte. The others are the program's own ratio to offset 0.

| Machine | Message | one thread, offset 0 (ns/B) | 16 vs 0 | 32 vs 0 | 1 vs 0 | threads, offset 0 (ns/B) | 16 vs 0 | 32 vs 0 | 1 vs 0 |
|---|---|---|---|---|---|---|---|---|---|
| Ryzen 7 9700X (Zen 5) | 64 KiB | 0.0570, 0.0574 | +2.2%, +1.8% | +2.2%, +1.9% | +2.7%, +1.8% | 0.0577, 0.0579 | +1.9%, +1.8% | +1.9%, +1.6% | +2.3%, +1.6% |
| Ryzen 7 9700X (Zen 5) | 1 MiB | 0.0568, 0.0564 | +1.1%, +3.1% | +2.3%, +2.2% | +1.4%, +0.5% | 0.0156, 0.0149 | -2.7%, +3.0% | -1.6%, +6.9% | -3.2%, +4.6% |
| Ryzen 7 9700X (Zen 5) | 16 MiB | 0.0686, 0.0682 | +3.8%, +1.1% | +3.5%, +1.4% | +0.6%, +0.5% | 0.0113, 0.0113 | +1.1%, +1.0% | +1.1%, +1.0% | +0.2%, +0.7% |
| EPYC 9255 (Zen 5) | 64 KiB | 0.0711, 0.0711 | +1.9%, +2.2% | +2.2%, +1.8% | +2.1%, +1.8% | 0.0718, 0.0715 | +1.9%, +2.3% | +2.0%, +2.2% | +2.0%, +2.3% |
| EPYC 9255 (Zen 5) | 1 MiB | 0.0692, 0.0698 | +4.9%, +0.8% | +4.2%, +1.3% | +3.2%, +1.7% | 0.0182, 0.0193 | +1.6%, +1.4% | +1.9%, +2.5% | +1.9%, +2.5% |
| EPYC 9255 (Zen 5) | 16 MiB | 0.0801, 0.0807 | -1.6%, -2.5% | -1.7%, -2.7% | -1.6%, -2.7% | 0.0059, 0.0060 | -0.9%, -2.8% | +0.3%, -3.0% | -1.3%, -3.1% |
| 2 x Xeon Gold 6330 (Ice Lake) | 64 KiB | 0.2433, 0.2433 | +1.3%, +1.3% | +0.4%, +0.4% | +1.3%, +1.3% | 0.2456, 0.2454 | +1.3%, +1.4% | +0.3%, +0.4% | +1.3%, +1.4% |
| 2 x Xeon Gold 6330 (Ice Lake) | 1 MiB | 0.2411, 0.2403 | +1.2%, +1.2% | -0.2%, +0.4% | +1.4%, +1.5% | 0.0460, 0.0397 | +0.7%, +1.1% | +0.3%, +0.3% | +0.6%, +1.1% |
| 2 x Xeon Gold 6330 (Ice Lake) | 16 MiB | 0.2538, 0.2533 | +1.4%, +1.4% | +1.0%, +1.0% | +1.3%, +1.4% | 0.0134, 0.0141 | +1.9%, +0.7% | +1.2%, -2.3% | +2.2%, -1.1% |

## Reading

- 64 KiB is the tight measurement: the message stays in cache, and the two runs agree to a few tenths of a percent. Zen 5 pays 1.6% to 2.7% at every unaligned placement. Ice Lake pays 1.3% to 1.4% at 16 and at 1 byte past, and 0.3% to 0.4% at 32.
- At 1 MiB and 16 MiB the two runs of one machine differ by as much as the effect. On the EPYC 9255 at 16 MiB the unaligned placements read 1% to 3% faster in both runs, which the loads cannot explain and the separate buffers may. The threaded 1 MiB cell moves most. On the 9700X it reads -3.2% to +6.9%, with both signs at every placement. On the Xeon its offset-0 median differs by 16% between the two runs.
- For a user whose buffer is not aligned, a message that fits in cache costs about 2% more on these AMD machines and about 1% more on this Intel one. For larger messages the probe shows no more than that.

## Files

`probe.rs`, and for each host `run.sh` (the job as submitted), `toolchain.txt`, `probe-1.txt` and `probe-2.txt`.

**Posted:** [bench-hashes #261](https://github.com/servil-software-factory/bench-hashes/issues/261).

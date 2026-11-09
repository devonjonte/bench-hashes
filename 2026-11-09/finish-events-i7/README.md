# The finish-events study on the i7-12700K (bench-hashes #160, BLAKE3 #325)

**Question.** Mac job 2073 counted events around the final hashes of `0b5bf7b7` against `f1393337` (instructions identical, dispatch stalls rising with cycles). What do the same events say on x86?

**Instrument.** BLAKE3-Servil's `tools/studies/events_sampler.rs` and `events_judge.rs`, with a Linux path (devonjonte `probe/devon-events-linux` 0564cf30): the sampler reads the bench's new `clocks::events` (bench-hashes devonjonte `candidate/devon-release-021` b1efd23b, kept as `evidence/devon-events-b1efd23b`): cycles, instructions, L1 data and instruction misses, dTLB misses, backend stalls (CYCLE_ACTIVITY.STALLS_TOTAL on the P core), branch misses, user space, the calling thread. The same seven shapes, eight sets a bracket, 64 samples a shape; four pairs in alternating order, a fresh link layout a pair; every run pinned to P core 2 (`run.sh`). The judge is John's, unchanged: `clocks::summary::discoveries`, 5% FDR, 3% margin.

**Result** (`events-judgment.txt`).
- **Instructions: MORE in every shape, +8.8% to +9.1%.** For example plain 128 x 16 KiB 706.8 -> 770.8 a message. The Mac found them identical; on this AVX2 machine `f1393337` runs about 64 more instructions a message in the final hashes.
- **L1 data misses: FEWER in every shape**, -5% to -12%.
- **Cycles: level everywhere**, leaning up +2% to +6%; backend stalls level (+12% in mixed and plain 128 x 16 KiB, +7% in plain 512 x 16 KiB, level).
- dTLB, L1 instruction and branch misses level; wall level.
- The bracket around nothing: about 816-839 cycles and 1,089 instructions a sample (two group reads by system call).

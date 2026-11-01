# The same-library check's two slower cells, investigated (i7-12700K, November 1)

**Question:** bench-hashes #99's same-library check (0.18 1f4dfd63 against
0.19.3 a48ee6c7, both measuring blake3-servil 0.8 b5b988d8) read two cells
slower: servil mt shared LentMessages 64 MiB +5.5% and servil st solo
IdleManyMessages 16 +7.6%. Why? The 0.19.3 build against 0.8 throughout.
Commands: `run.sh`, `runB2.sh`.

**A, the 64 MiB cell: 0.18's shared reading was optimistic.**
- 0.19 reads 0.142 ns/B from its second sample on, flat for 300 samples
  (`A-settle-*`): no slowing under sustained load.
- In 0.18 the two copies, started together, took 9.64 ms and 8.1 ms
  (slower over faster 1.18, median); in 0.19 1.02. The slower copy takes
  9.64 ms in both: the cost of sharing. 0.18's mean of the two, 8.90 ms
  (0.132 ns/B), counts the faster copy's early finish, after which the
  other runs its tail with the whole pool.
- Over 0.18's 100 shared cells, the copies ran over 10% apart in 17
  (servil mt's); 0.19 in 4. Three stay uneven under 0.19: both Collection
  cells (1.44-1.48) and the 4 KiB stream (1.26), the pool serving two
  callers unevenly.

**B, the after-pause cell: bimodal, its mode set by what runs around it.**
- Each run sits in a fast mode (about 220 cycles a message) or a slow one
  (about 280-330), alone too (`B-*`: 2 of 4 runs fast).
- In the check, both sides sat in the slow mode, 0.19 about 6% higher.
- In full `--all` runs (`B2-*`), 0.19 as released sat in the fast mode
  (218-242 cycles), 0.19 measuring 0.18's way (`--train 0,1
  --nonstop-visits 6`) in the slow one (249-280): the opposite direction.
- **Found (`C-*`, `D-*`, `E-*`, `place-probe/`): the depth of the pause's
  idle state.** ASLR off (`setarch -R`, `C-*`) and pinning to CPU 2
  (`D-*`) leave the two modes; whole runs' idle-state counts (`E-*`) do
  not separate them. Within one process (`place-probe/place_probe.rs`,
  40 fresh allocations), the modes come in streaks across allocations.
  Per visit (`place-probe/idle_probe.rs`, 3000 visits pinned to CPU 2,
  CPU 2's cpuidle counters read around each 1 ms sleep): a pause that went
  no deeper than C1E, 1440 visits, median 13.5 ns a message; C6, 941,
  25.8; C8, 619, 58.2. Linux's `menu` governor chooses each pause's depth
  from recent history, so a run's mix, and its mode, follow what ran
  before it.

**The shared scenario's tail** (from `release-0193-i7/check-same`): in
0.19 the last of a train's 6 steps reads 3-8% faster than the first five
(servil mt 64 MiB x0.936, 16 MiB x0.969, 4 KiB x0.919; servil st 64 MiB
x0.969), its copies 1.09-1.13 apart where the others are 1.02: one copy
ends its train first. About 1% of a shared cell's figure. Taking the
slower copy of each step: servil st's 50 shared cells x1.002 (median),
servil mt's x1.013 (to x1.267 where the pool shares unevenly).

**Posted:** bench-hashes #99 and the issues it links.

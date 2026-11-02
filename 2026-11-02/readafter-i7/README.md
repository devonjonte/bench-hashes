# RETRACTED: the "pre-call syscalls" effect was my experiment's artifact (i7-12700K, November 2)

**Correction (run3, run4):** variant B had removed the bench's timing-path warm-up (a counts read and a clock read *before* the input's write, which keep the interval's own closing `now()` warm). Without it, the cold `Instant::now()` after 1 MiB of code eviction was measured inside the interval: about 430 ns, the whole "effect". With that warm-up kept and nothing between the write and the call (`regress4-warm`), every cell is level with the bench as it is (x0.93-1.00). Variants that put a perf read or a 2 us spin between write and call (`regress3-*`) read x3-6 slower for the same reason, the clock path colder still. The bench's design, and its comment ("warms its own timing path, so the interval measures the call"), were right. The original text follows for the record.

---


**Question** (from Sam's #106 finding that a read placed before the call
hid the Xeon's wake effect): does what `clocks::measure_after_gaps_prepared`
does between a gap and the timed call, two `Counts::read()` (perf
syscalls), two clock reads and the input's write, change what the call
measures? Two benches (0.19.7, the fork at 0.8): A, clocks as pinned
(ac9e6b7d); B, clocks 5a32cddc (branch `exp/devon-reads-after`): nothing
before the call but the write and one clock read, the counts read after.
`regress --pairs 8` servil st and mt (`regress/`), `--pairs 6` sha256-ring
and official (`regress2/`). Commands: `run.sh`, `run2.sh`.

**Answer:**
- **After a pause (idle):** level, every contender (x0.96-x1.07): the
  pre-call work hides nothing of the idle-state cost on the i7.
- **After other work (busy):** every contender's small calls read far
  slower without the pre-call syscalls, the whole distribution shifted
  (servil st 64 B: p10 8.2 -> 12.7, p50 9.7 -> 16.3 ns/B; about +430 ns
  a call):

| after other work | servil st | servil mt | official | sha256-ring |
|---|---|---|---|---|
| OneMessage 64 B | x1.68 | x1.59 | x1.69 | x1.52 |
| OneMessage 1 KiB | x1.54 | x1.52 | x1.47 | x1.57 |
| OneMessage 16 KiB | x1.11 | x1.07 | x1.11 | x1.03 |
| ManyMessages 2 | x1.42 | x1.38 | x1.46 | x1.40 |
| ManyMessages 16 | x1.58 | x1.44 | x1.41 | x1.22 |

So 2-5 us of the bench's own syscalls after the 1 MiB of other code and
the 128 MiB walk make the cold call about 430 ns cheaper, for every
library alike. Comparisons between contenders survive (they shift
together); the absolute cost of a call after other work on every
published map depends on it. The mechanism is unknown (a perf `read()`
after the eviction: what it restores for the hash is the question).

**Posted:** bench-hashes issue.

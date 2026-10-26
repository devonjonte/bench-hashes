# Small mt batches after a pause, John's candidate f1db8cd against `servil` + #164, i7-12700K

**Question (BLAKE3 #125, #119):** in two full checks of the 0.8
integration, mt solo IdleManyMessages at 2-32 messages (a batch of
64-byte messages after a 1 ms sleep) read +5% to +22% in the first stage,
and one second stage confirmed seven of them. Is the candidate slower
there, and which change made it so?

**Commits:** new, johnservil/BLAKE3 `candidate/release-0.8` f1db8cd
(bench d21cdf36); old, devonjonte/BLAKE3 `candidate/devon-kernel-names-john`
bfbda19 (bench 5be5f236). Bisect: 66732c5 (the integration before any
wake change), 399a8f2 (the owed-wake cascade back), ee4c0d7 (eight
direct wakes), all with bench d21cdf36.

**Commands, each under run-bounded.py, October 25-26:**
- `check.sh`: `check --against bfbda19 --old-bench 5be5f236 --cells all
  --pairs 8 --keep samples` at f1db8cd (23:41 UTC).
- `targeted.sh`: `regress` over the check's relinked builds, mt cells
  "idle 1" to "idle 32": f1db8cd against bfbda19 at 23 pairs (`t-main`),
  and two same-code controls at 12 pairs on disjoint layouts, old against
  old (`t-aa-old`) and new against new (`t-aa-new`).
- `bisect.sh`: plain builds (one layout each) of the five commits, each
  adjacent pair at 23 pairs (`b-*`), and the same executable against
  itself (`b-f1db8cd-f1db8cd`).
- `compare-*.txt`: `bench-hashes compare` over each folder.
  `states.txt`: `states.py`, a diagnostic (no verdict) splitting samples
  into a fast and a slow state.

**Verdicts:**
- The full check: "no cell slower" in both stages; mt IdleManyMessages 6
  and 24 among the suspects again.
- `t-main`: **9 of 10 cells slower**, +9.5% to +16.7%.
- The controls: no cell slower, the judgment being one-sided. Read
  whole, `t-aa-new` (same code, other layouts) reads x0.76 to x0.94 with
  up to 11 of 12 pairs faster, and the same executable against itself
  reads x1.00 to x1.11. So these cells move 10-25% between sets of runs
  with no change to the code, as much as `t-main`'s difference.
- The bisect: +15% at 2, 4 and 8 messages for bfbda19 -> 66732c5, -8% for
  66732c5 -> 399a8f2, +9-11% at 2 and 3 for 399a8f2 -> ee4c0d7, level for
  ee4c0d7 -> f1db8cd. Within the controls' spread, so this locates nothing.

**What the samples show** (`states.txt`): each cell's samples fall in
two states. At 2 messages a call takes about 250 ns or about 4 us. A slow
sample spends about 3.6 us more on the calling thread, at the full clock
by its user-space cycles (about 17,500 cycles more). These batches never
reach the pool (`lanes::hash_many` keeps inputs under MIN_SPLIT_LEN on the
caller), and the single-thread contender shows the same two states (21% to
88% slow per run). So the slow state is a cold start after the sleep,
whose share follows the machine's state over minutes; neighbouring pairs
share it, and the paired test then counts them as more evidence than they
are.

**Per state, `t-main`:** the candidate's fast state reads 3-8% slower at
every count (2 messages: 126 -> 136 ns per message), and its slow share is
4-7 points higher. At 2 and 4 messages both same-code controls read the
fast state within 2%, so a per-call cost of a few percent there is likely.
At 8-32 messages the controls' fast states spread x0.81 to x1.11, and
nothing is resolved there. LentBatches' +2-3.5% (`../align-loops-i7`)
points the same way for small calls. The wake changes are an unlikely
cause, since these calls wake nobody.

**Posted:** BLAKE3 #125 and bench-hashes #81.

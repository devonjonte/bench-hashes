# Next steps

Read this file first. The work: make the servil fork the fastest BLAKE3 in
every situation a user meets, the streaming APIs first (Zooko, September
27, replacing minimax: AGENTS.md, "The streaming APIs first"),
natively on the Mac first, then in the VM (the user's decision,
September 27, 2026: diagnose on the Mac), measured by this
benchmark. Prefer changes that are simpler and faster together. The
principles are in both repositories' `AGENTS.md`; the fork's hardware
facts, design, and rejected ideas are in its `NOTES-servil.md` (read it
before touching kernels or the pool); this repository's are in `NOTES.md`.

## Resume here (September 28, 2026, morning: Zooko's decisions, the two phases)

**Zooko's decisions (3:45 am):** the energy-saving form does not linger
(docs/api-design.md; to build with the time-or-energy argument on the
multithreaded synchronous calls); the split at 512 KiB, taken (fork
c46c57c; the CHANGELOG says so); the trades (lingering on four threads,
messages under 32 KiB gathered, subtree tasks of 32 KiB) still wait for
him.

**The continuous cells were measured at a low clock** (fixed, 9869b27;
NOTES "Threats to validity" 0): sampled in the same rounds as the calls
after the gap, they ran near 3.0-3.3 GHz on the Mac; alone, 4.4 GHz.
Every contender's continuous cells read 30-100% slow, which is why they
matched none of main's back-to-back tables. Now the run measures the
continuous use cases first, in a phase of their own. Mac, the fork at
c46c57c (jobs 740-741, two runs agreeing within 2%): SHA-256's messages
one after another 0.35-0.36 ns/B from 1 KiB (main's back to back 0.34,
plus the read's copy); servil mt 0.75 against 0.56 at 64 B, 0.19-0.20
against 0.37 at 256 B, 0.12 against 0.36 at 1 KiB, 0.056-0.060 from 16
KiB; batches one after another 5.3 -> 2.4 ns/msg against SHA-256's 31.
Every A/B of the continuous cells before 9869b27 ran at the low clock;
runs of those cells alone (the "alone" numbers below) did not.
**The calls after the gap now meet a program that only sleeps and
hashes:** full clock in 11% of solo samples (was 18%), and their medians
split two ways between runs by up to 2x (SHA-256 1 KiB 1.08|2.46 and
1.71|2.59); their CHECKS are mostly noise. What the program does in the
gap (sleep today) is Zooko's open question; a program that works in the
gap keeps its clock up.
**Measured again this morning** (Mac, the fixed benchmark; fork NOTES
"The trades, measured again" and "The 64-byte cell at full clock"):
members-32k, subtrees-32k, and linger-4 each still a trade (numbers
there); the 64-byte continuous cell's spread (0.54-2.3 ns/B a sample,
the fastest matching SHA-256) is stall cycles in the program's thread at
a steady clock and instruction count; `submit` costs about 320
instructions and 115 cycles a message; a slot prefetch was level. The
Mac's test job passed on c46c57c (job 756).
**VM, with the two phases** (full run, `/workspace/tmp/vm-phases/`;
built with `perf_regress.py build --side bench`: a plain `cargo build`
in bench-hashes links the fork from git, `candidate/api-plan`, not the
working tree, and reads 3-5x slow): continuous cells faster for every
contender (SHA-256 0.34-0.36 ns/B against last night's 0.41-0.45); servil
mt 1.13 against SHA-256's 0.52 at 64 B, 0.28 against 0.36 at 256 B, 0.17
at 1 KiB, 0.05 from 256 KiB.
**The runner:** restarted by Zooko (installs `perf_regress.py` with the
fix ed66897: the clocks patch followed the tool's own directory, not
`--root`); its perf_regress jobs work again (open item 4 below is done):
job 764, the split (c46c57c) against 80fed28 on the fixed benchmark, no
regression on the Mac (the VM's pre-commit check agreed).

## Resume here (handover, September 28-29, 2026, overnight session)

**For the next session (John Servil, September 29).** Start with `sh
/workspace/vm/setup.sh`; both repos are clean and pushed (fork
`candidate/api-plan-simple`, bench-hashes `candidate/benchmark-plan`).
The VM was not restarted, so nightly Rust (rust-src, for TSan and ASan)
and `linux-perf` are still installed in the guest (a restart would
remove them). Lessons of the night: trace before guessing
(`--trace-clocks`, and probes that time each stage found the calibration
defect, the task-list lock, and the part-filled-task loop); A/B on the
Mac with old/new/new/old and compare medians from the samples, since
two-speed labels mislead; the VM and the Mac disagreed more than once
(two task lists), so the Mac decides; contended words on lines of their
own paid three times. Scratch probes live in `/workspace/tmp/qlab`
(queue throughput with stage timers, VM) and `/workspace/tmp/idlecheck`
(CPU a process spends while idle).

**At a glance.** The benchmark asks the same of the fork (FROZEN.md
unchanged); five measurement defects in it are fixed (the queue's cells
timed a dozen messages, short streams paid a 64 KiB memset, batches an
allocation, cells freed each other's buffers, gap samples summed 50
gaps), and a full run takes 47 s on the Mac. The fork, measured alone on
the current benchmark (jobs 694-697): messages one after another 2-2.4x
faster, batches one after another 2.6-4x, long messages through
`update_multithreaded` 2.4x (lingering), synchronous calls level. Against SHA-256 on the Mac every continuous cell wins but
64-byte messages (at two speeds, 0.78|1.11 against 0.93 ns/B); the small
synchronous calls after the gap still lose (SHA-256's hardware below 8
KiB). Decisions waiting for Zooko: lingering's bound and energy (4-6x
the energy for 2.4x the speed), the 512 KiB split (Mac +40%, VM -25%),
and the trades listed below. Everything is on `candidate/api-plan-simple`
(fork) and `candidate/benchmark-plan` (bench-hashes), unmerged.

**Where things stand.** The fork's work is on `candidate/api-plan-simple`
(the API plan, `candidate/queue-simple` merged in, and tonight's
changes); bench-hashes' on `candidate/benchmark-plan`. The Mac runner
built every job from those branches (jobs 475-733). Nothing is merged to
`servil` or `main`; the gate (PROCEDURES.md) is still to run. Before
merging: point bench-hashes' Cargo.toml at the fork's `servil` once
`candidate/api-plan-simple` lands there (it names `candidate/api-plan`
for `clocks` today), and restart the Mac runner (`setup-mac.sh`) so its
installed `perf_regress.py` is the new one.

**What changed in the benchmark** (fixes to how it measures; what it asks
of the fork, FROZEN.md, is unchanged):
- The continuous cells were calibrated from one input: a queue's first
  input costs tens of microseconds, so a sample held 12 messages of 64 B,
  never the 1024 in flight FROZEN.md asks for. They now start calibration
  at twice the buffers in flight, and no sample holds fewer (servil mt 64
  B messages 97 -> 3.9 ns/B on the VM before any fork change).
- The streaming use case allocated and zeroed a 64 KiB read buffer per
  message (about 6 us after the gap, every contender alike: 64 B streams
  read 95-105 ns/B); the batch use cases allocated their digest array per
  call (256 KiB with page faults at 8192 messages, BLAKE3 contenders
  only). Both are kept from call to call now.
- The continuous cells' read buffers were one set shared by every cell,
  so each cell freed or grew the previous cell's inside its own sample;
  now a set per count and length.
- A synchronous cell's sample was sized from the call's time back to
  back (a 64-byte call's sample summed 50 calls, each after its own 1 ms
  gap); now from four calls timed after the gap. Run time: VM `--quick`
  46 -> 14 s, a full default run 32 s; Mac full run 96 -> 47 s (job 503),
  builds included.
- The report's opening names the tables it shows and how the program
  calls in each; README, METHODOLOGY, CONTRIBUTING describe the five use
  cases; the graph's door names today's calls.

**What changed in the fork** (fork NOTES, "The queue, as rebuilt" and
"Lingering between multithreaded updates", have the mechanisms and
numbers):
- The queue: submitters and the delivery thread share no lock on their
  common paths (entries chained in submission order), locks polled
  before parking, 64 short messages to a task, small `Queue::fixed`
  batches gathered into tasks. Mac, solo, the start of the night -> its
  end (runs of those cells alone): 64 B messages 2.6 -> 0.65-0.72 ns/B,
  256 B 0.63 -> 0.21, 16 KiB 0.165 -> 0.056; batches of 16 34 -> 5.5
  ns/msg, of 64 21 -> 5, of 256 11 -> 3.3; shared batches of 16 84 ->
  8-9. VM: continuous cells 2.3-2.6x faster (geometric mean),
  synchronous cells level within their noise.
- `Hasher::update_multithreaded` lingers (Zooko's decision in
  docs/api-design.md; the bound, 50 us, is his open question): long
  messages in 64 KiB pieces 2.4x faster (Mac 128 MiB 0.24 -> 0.098 ns/B,
  solo and shared), short ones level.
- The delivery thread hands over a part-filled task of short messages
  only after waiting 16 rounds on it: batches of 16 and 64 lose their
  slow speed (a fifth of the fast one in some samples), 1 KiB messages
  30% faster (Mac jobs 701-704).
- Contended words apart: the task list's lock and counts, and the
  queue's locks, each on lines of their own, and free slots reused
  oldest first: Mac 16 KiB messages 14% faster, 256 B-1 KiB 5-11%, 64 B
  9% (fork NOTES, "Hot words on lines of their own").
- The SME2 thread runs gathered tasks (short messages, small batches) on
  NEON: 64-byte messages and batches of 16 and 64 10-15% faster on the
  Mac; for subtree tasks its SME2 matches NEON in speed (jobs 604-607)
  and stays, for its lower energy per byte.
- Idle workers and the SME2 thread sleep after 50 us with nothing to
  take, even while a queue holds the pool (they polled until the stream
  drained): about 10% less CPU for the queue's short messages, speed
  level on both machines; the VM's continuous 64 B cell 3.9 -> 1.2-1.4
  ns/B.
- `perf_regress` knows the five use cases: after-gap cells at 20%,
  continuous 3% solo and 10% shared, 28 points, about 25-30 s of runs on
  the VM; a first calibration (fork NOTES, "perf_regress"). Advisory
  tonight (Zooko): most commits went in with `--no-verify`.
- `clocks::process_energy_nj` reads the process's energy on macOS (the
  counter probe/energy used), for stage 3; not validated for cells.
- A flaky test fixed: `tests/queue_no_alloc.rs` failed once in 60-100
  runs (half the time under TSan), from before tonight: the pool's task
  list grew with the threads' timing. Each queue now makes room in it for
  what its entries can have waiting; 0 failures in 150 runs and 8 under
  TSan. It also made the Mac's 64 B messages 22% faster (0.95 -> 0.74
  ns/B) and 256 B 13% (jobs 646-649).
- Tests: `tests/api_plan.rs` checks messages in pieces through
  `update_multithreaded` against the reference implementation, and one
  queue shared by several submitting threads; TSan (nightly,
  `-Zsanitizer=thread`) clean on api_plan, the library tests, and a
  million 64-byte messages through the queue; ASan clean on api_plan and
  queue_no_alloc; every suite passes on the VM (86 / 82 / 71 library
  tests, 22 doc, 14 api_plan, 1 queue_no_alloc, 2 vectors, 10 benchmark)
  and the Mac's test job (677; its runner predates the integration
  tests); on the Mac, probe/queue-check (job 678) compared 1.1 million of
  the queue's digests (every shape, many lengths, one queue shared by four
  threads, lingering streams) with the one-shot calls: all equal.
- Tried and left out tonight (fork NOTES has each with its numbers):
  slots on 128-byte lines, a delivery back-off, a short message's digest
  in its slot, grouping a task's short messages into one entry, linking a
  task's members through their entries (candidate/member-links), pollers
  pausing after a failed try_lock, wakes as a tree, the caller's later
  pieces on SME2, 4 KiB pieces, the minimax NEON plans after the gap, no
  SME2 thread, member blocks, the pool's threads at user-interactive QoS.
  Trades left for Zooko: the 512 KiB split, lingering on four threads,
  messages under 32 KiB gathered, subtree tasks of 32 KiB (large messages
  4-14% faster, 64 KiB 5% slower). Probes kept as `probe/*`
  branches, each cited there.

**The fork's night, measured alone** (Mac, the current benchmark on the
starting fork b467ba6 and the final one, full runs old/new/new/old, jobs
694-697, in `/workspace/tmp/overnight/`; geometric mean of new/old
medians by use case): messages one after another 0.49 solo and 0.42
shared, batches one after another 0.39 solo and 0.25 shared, a message
in pieces (servil mt) 0.89 solo and 0.81 shared (long messages 0.4), the
other synchronous cells 0.97-1.07 (their code is unchanged below the
split; single cells swing with the clock states after the gap, cells of
one code path moving opposite ways in st and mt, their 5th percentiles
level). One cell slower beyond that noise in the earlier comparison
(jobs 572-575): shared 256 KiB in pieces, +11% (both copies start
lingering after their second piece).

**VM standing** (full run of the final pair,
`/workspace/tmp/overnight/vm-full/`): the continuous cells win from 256 B
(0.43 against 0.52 ns/B; 1 MiB messages 0.077 against 0.35; batches 3.4-16
against 32-39 ns/msg) and lose at 64 B (1.40 against 0.74).

**Standing, Mac full run of the final pair (job 679,
`/workspace/tmp/overnight/mac-final/`):** the continuous cells all win
against SHA-256 but 64 B messages, which run at two speeds (servil
0.78|1.11 against 0.93 ns/B; shared 1.22 against 0.90; 0.65-0.72 against
0.56 in runs of those cells alone, where the machine stays warm between
samples: a handover's
cache lines cost about what SHA-256 spends on the whole message; the
harness's channel alone takes 25 ns; `Queue::fixed` is the API that
beats it). Streams of 64 KiB pieces win from 16 KiB. Synchronous calls
after the gap win from 16 KiB (one buffer, pieces) and from 12 messages
(batches); below they lose to SHA-256 by 1.3-2x.

**Open, ours to explain or decide:**
1. **Small synchronous calls after the gap** (128 B-8 KiB, batches of
   1-8): probe/after-gap (jobs 478-479) found the core after the 1 ms
   sleep at about 1.3 GHz and a quarter to half of the time on E-cores,
   for SHA-256 alike; servil's cycles per call rise 1.7x there (4 KiB:
   5300 -> 8900) where SHA-256's stay level (6260 -> 6390): the NEON
   hybrids lose more on E-cores than SHA-256's dedicated instructions.
   20 us of integer work before the call halves it (the clock ramp). Back
   to back SHA-256 already leads below about 3 KiB (open problem 1).
   The rejected "minimax" plans, measured again after the gap
   (probe/plans-pairs, jobs 568-571), trade the two clock states at 4 KiB
   and lose at 8 KiB; a first call's cold cost is SHA-256's too
   (probe/first-call). What is left is kernel work for E-cores and low
   clocks, or accepting SHA-256's hardware lead below 8 KiB.
2. **The queue's cells slow the next cell** (VM and Mac, reproduced
   alone): SHA-256's continuous 1 KiB cell runs 2-5% slower beside the
   new fork than beside b467ba6 (Mac jobs 524-527: same clock, 4.42 GHz,
   2-5% more cycles per byte), with no thread left running (a queue
   burst leaves 30 us of CPU). Bisected on the VM: all of it arrives with
   the merge of `candidate/queue-simple` (221ef23: 0.329 -> 0.335 ns/B);
   tonight's queue commits are level. A probe of SHA-256's own loop right
   after a queue burst, an SME2 burst, a NEON burst, or
   `hash_multithreaded` (probe/aftereffect, job 528) shows its cycles per
   byte level (1.538-1.547), so the effect lives in the benchmark's
   state around the cells (its heap, its buffers), not in the core. It
   makes `perf_regress compare` across queue-simple give no verdict on
   the VM (the control moves). Open: what queue-simple leaves in the
   harness's state. With the final fork (idle workers asleep, the task
   list's room fixed) it is about 2% on the VM (0.330 -> 0.337 ns/B).
3. **The lingering bound, and its energy** (Zooko's Q): 50 us, reasoned
   as a wake's cost. Measured (fork NOTES, "Lingering"; jobs 560-567):
   a long message in 64 KiB pieces through `update_multithreaded` is
   1.5-2.6x as fast as before and spends 4-6x the energy (1.7-2.6 nJ/B
   against 0.4-0.48 for `update`): about eight cores poll between
   updates. The time-saving form's trade to decide: keep, shorten the
   bound, cut a lingering job for four threads (probe/linger-4: 18% less
   energy, half the CPU, long streams 7-12% slower solo, 1 MiB 20%
   faster), or give the energy-saving form (stage 2's time or energy
   argument) no lingering. A lingering stream leaves about 1.6 ms of
   worker CPU behind in all, and seems to slow the cells run after it
   5-10% (fork NOTES, "WORKER_IDLE's length"). `clocks::process_energy_nj` (new, macOS)
   reads the counter the probes used; not validated for energy cells.
   It credits energy late: read after the threads have slept 10 ms, a
   64 MiB hash reads 384-412 pJ/B (7% spread); read at once, a third less
   and spread 1.5-3.4x (fork NOTES, "The energy counter's repeatability").
4. The runner's `perf_regress` jobs need the runner restarted.
5. **Shared 16 KiB messages** through the queue: the pair moves little
   more than one program alone. Found: `submit`'s push onto the task list
   (its lock contended by pushers and pollers, 2 KiB tasks copied under
   it; fork NOTES, "A ceiling near one 16 KiB task"). The contended
   words apart made 16 KiB 14% faster solo and 9% shared; two task lists
   (candidate/two-lists) made 64 B 50% slower on the Mac and were left
   out. Next: a lock-free task list; `probe/members-32k` (shared -37%,
   solo +6%) stays a trade.
6. **The multithreaded split at 512 KiB instead of 768** (Zooko's choice
   of September 27, fork NOTES at `MIN_SPLIT_LEN`, is the length where it
   pays on both machines): branch `probe/split-512`. Mac, after the gap
   (jobs 538-541): 512 KiB one message 0.35 -> 0.19-0.24 ns/B, batches of
   8192 22.5 -> 13.3 ns/msg (about 40% faster); VM: 512 KiB 20-30% slower
   than on the caller's thread (0.24-0.34 -> 0.30), 8192 level. A
   decision for Zooko (native first; a VM loss needs his decision).

**Next, in order:** Zooko reviews the two branches (the benchmark fixes
and the fork's changes); run the gate (all suites, `perf_regress` on the
VM and the Mac) and land them; then stage 2's remaining items (the time
or energy argument on the multithreaded synchronous calls) and stage 3
(the energy counter).

## Earlier checkpoint (September 28, 2026, night)


**Where things stand.** The new benchmark runs: bench-hashes branch
`candidate/benchmark-plan` (a41c99a, checked out in the VM), which
depends on the fork's `candidate/api-plan` (a11b990: the plan in
`docs/api-design.md`, `clocks::measure_after_gaps`, public
`Hasher::update_multithreaded`, perf_regress building both sides with the
working tree's `clocks`). `FROZEN.md` is refrozen (Zooko, September 28).
All 10 benchmark tests pass; a `--quick` run with the default contenders
takes 56 s in the VM (was about 10 s). Stage 1's remaining work, in order:

1. **perf_regress is stale; fix it before any fork commit that touches
   code** (the pre-commit hook runs it with this benchmark). It still
   knows the scenario `after-idle` (MARGIN, HOLDING) and the use cases
   by old names. Wanted: solo cells of the synchronous use cases (after
   the gap) at 20% (Zooko's default), solo continuous cells at 3%, shared
   reported at 10% (20% after the gap?); its POINTS and use cases for the
   new axes; and its run time measured (after-gap cells cost a 1 ms gap
   per call: keep the check near its old 16 s, e.g. fewer after-gap
   points).
2. **Run time**: measure a full default run and `--all` (VM, then the
   Mac); the after-gap cells cost `GAP_NS` per call, and `GAP_SAMPLE_NS`
   (2 us of calls per sample) sets how many. The previous sessions cut a
   full run from 5 minutes to 30 s; tune samples and points to get back
   near that, reporting what each cut costs in precision.
3. **Reread and fix the pages** as the three readers: the text report's
   opening lines (the pattern sentence reads awkwardly), the graph (a
   render: chips, subtitles, the "how it was made" door), README,
   METHODOLOGY, CONTRIBUTING, and the fork's PROCEDURES and NOTES where
   they describe the old use cases or the after-idle scenario. The Duo
   comment still says each copy reads the clock as its first act (each
   now sleeps the gap first).
4. **First findings to explain** (quick run, VM): after the gap a 64 B
   call costs about 500 ns (7.8 ns/B) against about 40 ns back to back,
   for every hash alike; the queue loses to SHA-256 for 64 B-4 KiB
   messages (3.3 against 1.3 ns/B at 64 B) and badly for batches of 16
   (630 against 46 ns/msg), and wins from 64 KiB messages and 64-message
   batches.
5. Then the Mac: a runner job on the branch pair (Zooko launches it).
6. Then stage 2 (the fork: `update_multithreaded` for 64 KiB pieces,
   which today stay on the caller's thread; the time or energy argument
   on the multithreaded synchronous calls; lingering between updates)
   and stage 3 (an energy counter, then the energy endings).

Before merging: point Cargo.toml back at the fork's `servil` branch once
`candidate/api-plan` lands there.

The quick run's results (VM, 24 rounds, default contenders) are in
`/workspace/tmp/new-benchmark-quick/` (Zooko looked at them there; host
path `~/piplayground/blake3-servil/tmp/new-benchmark-quick/`). Copy
results into `/workspace/tmp/` for him to see: the VM's `/tmp` is its own.

Open questions of the plan, each marked **Q** in `docs/api-design.md`:
how long lingering between `update` calls may last (after the rest of
the API is settled); the gap's length and what the program does in it
(sleep today); what saving energy means for a multithreaded synchronous
call, and the energy counter; batch lengths beyond 64 B (Remco's 256 B
leaves); the multithreaded `Hasher` form's name. Revisit after building
and measuring: whether "cannot tell? answer intermittent" still holds;
optimising the energy-saving modes for a shared machine.

## Earlier checkpoint (September 28, 2026, late)

**The question of the moment** (Zooko): can the streaming API (`Queue`)
be implemented so that it is *way faster* than any other API? If not,
it is abandoned. Zooko's framing, settled: the streaming API maximises
**throughput** (bytes or messages per second, or per joule) and spends
latency to buy it; wanting the lowest latency per input from the one-shot
forms is valid. Its throughput should be the hashing's, as long as
handovers never slow the hashing threads, provided the program keeps
enough in flight (Little's law: in flight = rate x round trip).

**Next: unfreeze, clarify, refreeze** (Zooko, agreed): the benchmark and
the API both need to say what they are trying to achieve, then be frozen
again in `FROZEN.md`. The new plan (September 28) is in the fork's
`docs/api-design.md`: three choices (the data's shape, intermittent or
continuous load, time or energy) lead to six calls; no thread budget;
the benchmark measures the six intermittent cells separately and the
continuous column in two use cases. Its open questions are marked **Q**.
Implementing it (September 28, overnight session; Zooko approved
the plan and these defaults): stage 1, the benchmark on today's calls (synchronous
calls measured only after the gap of 1 ms, their shared version two
copies after the gap at once; queue use cases "messages" and "batches"
with enough in flight, back to back, solo and shared); stage 2, the fork
(`Hasher::update_multithreaded`, a first simple version; the time or
energy argument on multithreaded synchronous calls; then lingering);
stage 3, an energy counter and the energy endings. perf_regress judges
after-gap cells at 20% to start (tightening toward 3% is its own work).
Timing stays in the `clocks` crate; reuse the current benchmark's
scheduling, made fast (5 min to 30 s) over two days. **Shared scenarios
stay for every use case** (Zooko): a sanity check against designs that
need the machine to themselves, and a pessimistic estimate; not
optimised for directly. To revisit: optimise the energy-saving modes for
a shared machine (background tasks), the time-saving ones for solo.
Earlier points to settle with him (now partly answered there):
- The many-inputs use case keeps four buffers in flight and blocks on
  the fifth: at small sizes that measures the round trip (latency), not
  throughput. Proposal: keep enough in flight to cover it (e.g. about
  1 MiB or about 1024 buffers, whichever is fewer); likewise consider the
  streamed use case (four 64 KiB buffers cap it near 0.1 ns/B).
- A per-message handler is serial by contract (in order, one call at a
  time): the program's own per-message costs (a channel send and receive,
  about 100 ns) bound `Queue::messages` below a `hash()` loop at 64 B. Tiny
  messages belong to `Queue::fixed` (one call per batch) or `hash_many`;
  the benchmark could measure `Queue::fixed` for them.
- Whether "one delivery thread" stays (Zooko's decision): calling a
  handler on the submitting thread would let one short input avoid the
  handover, at the contract's cost.

**State of the code (fork, all on branches; nothing merged since v0.3.0):**
- `candidate/queue-simple` (d95eccc): the fresh design, the one to go on
  with. `submit` cuts a submission into tasks on the caller's thread
  (whole subtrees of at most 64 KiB, `plan_subtrees`; a message is a
  stream of one piece; fixed-length batches as ranges of slots; messages
  under 16 KiB several to a task, 16 per batch, one-block ones side by
  side); one task list; an SME2 thread hashes tasks only on SME2 (under
  the turn), the workers only on NEON (Zooko's suggestion); one delivery
  thread replays and calls handlers, holding the pool while anything is
  in flight. No allocation after warm-up (`tests/queue_no_alloc.rs`, a
  counting global allocator). All suites pass; TSan clean on api_plan
  (before the last two commits: rerun). Needs: Mac gate, NOTES, and the
  VM gap below.
- `candidate/queue-speed` (feed design, earlier today): superseded by
  queue-simple on the Mac everywhere; drop it once queue-simple lands.
- Probe branches from today: `probe/queue-timeline`,
  `probe/queue-process-state`, `probe/queue-sme2-turn`,
  `probe/task-len-32`, `probe/task-len-16`, `probe/queue-throughput`
  (examples/host_lab.rs: many short messages in flight, the throughput
  probe to reuse).
- bench-hashes `main` 183010c: records on fork 61502ef (v0.3.0's code),
  the many-inputs use case, the graph's two-significant-digit labels.
  Runner jobs run to 474; the next number is 475.

**Measured, Mac, servil mt through the queue (queue-simple):**
- Benchmark as frozen (jobs 464-467), ns/B, against the best other API
  (hash / hash_multithreaded; Hasher for streams): many inputs 64 KiB
  0.109 (0.168), 256 KiB 0.065 (0.170), 1 MiB 0.043 (0.068), 4 MiB 0.035
  (0.037); streamed 256 KiB 0.152 (0.236), 32 MiB 0.107 (0.238); losing
  at 64 B-1 KiB inputs and the one-piece 64 KiB stream (latency-bound
  with four buffers).
- Throughput probe (job 474, many in flight): 1 KiB messages 3.7x a
  hash() loop, 16 KiB 1.9x (the VM 2.8x: something serial left on the
  Mac, unfound), 64 B 0.34x (the per-message serial path).
- Tried and lost today (details in the fork's NOTES): the feed with help
  rules; tasks of 16 or 32 KiB (16 KiB: streams 50% slower); a worker
  taking the SME2 turn per task; waking after a 512 KiB burst.
- The VM is behind the feed design on long streams (about 14%) and
  16 KiB inputs; unresolved.

**Open, ours to explain:** some benchmark processes run every servil mt
queue cell 1.1-3.5x slower on the Mac (jobs 440, 446, 448, 454 runs 6-7,
463), servil st level; not reproduced by probes in fresh processes
(jobs 450-451); `--trace-clocks` job 455 met no slow run.

**Lessons (this session):**
- Latency against throughput: a closed-loop program with k in flight
  gets at most k per round trip; decide which one a benchmark measures.
- Measure the stages before guessing: the queue's 1.7 us per message was
  batches of one pushed under a lock, found in one probe after several
  wrong guesses.
- In the VM a contended std Mutex parks the waiter (futex); use try_lock
  on paths that poll.
- Allocation-free claims need a test (a counting global allocator in its
  own test binary); growth must follow the program's in-flight work, not
  thread timing.

### Next, in order

0. **The streaming API: unfreeze, clarify, refreeze** (above), then
   land `candidate/queue-simple` (Mac gate, TSan rerun, the VM gap).
1. **After-idle margin, recalibrated on mains power** (20%, job 338, was
   calibrated when the Mac's power state was unknown); and servil's small
   streams running at two speeds solo (1 KiB streamed: some rounds 4.5x
   slower than SHA-256 where the median is 1.85x; record 405's CHECKS).
2. **The streaming mode**: built (item 0 has what remains); an optional
   io_uring layer and chaining stay in `docs/api-design.md` for later.
3. **servil behind BLAKE3 official**: 4 messages fixed (p4 as two scalars
   beside a pair, Zooko's decision despite E-cores +30%; Mac 20.3 against
   official's 21.6 ns/msg). Left: 12 messages shared (Mac 25.8 against
   21.7; solo 13.4 against 21.4): the copy without the SME2 turn runs
   p9 + p3 (p8 + p4 was level). A p4 kinder to E-cores stays welcome.
4. **SHA-256 at 3-8 KiB** (open problem 1): the only cells within 10% of
   SHA-256 on either machine (servil 2-9% behind at 3 KiB, 3839 B, 4 KiB,
   4470 B; a VM record's warm-up can move them by up to 8%). Elsewhere
   SHA-256 leads twice over below 3 KiB and servil far ahead from 8 KiB.
5. **Which part of the cycles-to-wall-time ratio is ours** (Zooko,
   September 26): reported times stay wall time, never scaled by cycles,
   until we know. Ours: SME2 waits, the power our code draws lowering its
   own clock. The machine's: heat, a host, a scheduler. Measure the
   warm-up to confirm it is the machine's and to size its effect on what
   users read: a traced Mac job of about 10 minutes of load
   (`--trace-clocks`, as job 332), cycles per ns over time by contender.
   Then have every benchmark run record cycles beside wall time (today
   only `--trace-clocks` does; the samples file would carry them).
6. The E-core cells: 2-chunk messages at 4 (p4 two pairs), 1000 B x 4;
   tails of 1-4 multi-block messages past SME2 groups (slow state).
7. **One cell's aftereffects slow the next** (open, ours to explain): on
   the VM, a long run of shimmed batch cells once made the next SHA-256
   64 B cell 3-6% slower; the mechanism is unexplained.
8. The text report's three-reader pass (CHECKS, TWO SPEEDS).
9. A second SME2 thread in the pool (two SME units reachable, job 187).
10. Open, smaller: hash(256 KiB)'s partial slow state; the VM's
   per-process two speeds; shared streamed 64 B two-speed on the VM.

### Remco (a potential user)

Merkle trees for a binary-field SNARK (WHIR), 2^16-2^24 leaves of 256 B,
inner nodes the standalone BLAKE3 hash of two 32-byte children (64 B).
His tree (`src/protocols/merkle_tree.rs` in worldfnd/whir) keeps every
node, pads to a power of two, chooses a hash engine per layer (recorded
in its config; nodes may use truncated permutations), and hashes each
layer through its `HashEngine` trait's `hash_many(size, input, out)`; his
BLAKE3 engine calls the official crate's hidden `Platform::hash_many`
sixteen messages at a time. A servil Merkle tree would change his
commitment format (see "Idea: a full-fledged Merkle tree API").

## How to work

The fork's `PROCEDURES.md` (the regression check, the gate to `servil`, the Mac runner, probes, the VM) and this repository's `PROCEDURES.md` (records, runs, graphs, its environment).

## Decisions made (don't re-ask)

- **The API plan, September 28** (Zooko; `docs/api-design.md` on the
  fork's `candidate/api-plan`): four questions lead a user to one call,
  the crate docs opening with them: several threads or not; the shape (a
  message in one buffer, a message in pieces, a batch); time or energy
  (several threads only); intermittent or continuous (several threads
  only; "when you finish hashing a message, will there typically be
  another one ready?", and "cannot tell" answers intermittent). Nine
  calls: `hash`, `Hasher::update`, `hash_many` (single-threaded, built
  for intermittent use, always saving time); their `_multithreaded`
  forms; and the queue in three shapes matching the shape question. No
  thread budget. `hash` keeps its name. The queue: event-based through
  handler traits, no polling, no blocking, zero copies, no allocation
  after warm-up. A `Hasher` between updates may linger (bounded; open).
- **The benchmark measures each call only as its contract says users
  call it** (Zooko, September 28): synchronous calls each after the gap
  (1 ms asleep), never back to back; the queue with enough in flight, in
  two use cases (messages, batches). Every cell summing calls shorter
  than a few clock ticks sums single readings (`clocks::measure_after_gaps`;
  the clock ticks at 24 MHz, 41.67 ns, on the M4 Max and the VM).
  perf_regress judges after-gap cells at 20% to start.
- **Shared scenarios stay for every use case** (Zooko, September 28): a
  sanity check against designs that need the machine to themselves, and
  a pessimistic estimate; not optimised for directly.
- **Every clock read for a measurement goes through the fork's `clocks`
  crate** (Zooko, September 28; AGENTS.md "Measuring"): it holds the
  decisions of two earlier sessions on which clocks and how to read them.
- **The VM configures itself with `sh /workspace/vm/setup.sh`**, once per
  session (AGENTS.md "Where to start"): git and cargo then work with no
  prefix (a system gitconfig includes `vm/home/.gitconfig`; cargo's
  config sets `CC=clang-19` and the target directory; the Mac's `HOME`
  and `TMPDIR`, which the shells inherit, are created). Nothing in the
  guest runs it by itself: the disk resets and the shells read no
  startup file.

- **The API plan, being settled one use case at a time** (Zooko,
  September 27; write down, implement only once every use case is
  settled). One-shot, synchronous, one message in memory:
  - `hash()` stays single-threaded (platforms without threads, programs
    whose other cores are busy, the least energy per byte).
  - The docs prominently recommend `hash_multithreaded()` instead: never
    slower, faster for big messages (it leaves the caller's thread from
    768 KiB); the energy advice (single-threaded spends less per byte)
    stays beside it.
  - `initialize()` runs the startup self-test alone; its docs and
    `hash()`'s say calling it early keeps that cost (under 200 µs on an
    Apple M4 Max: 130-165 µs measured) off the first `hash()`.
  - `initialize_multithreaded()` runs the self-test and starts the pool;
    its docs and `hash_multithreaded()`'s say calling it early keeps that
    cost (under 1 ms on an Apple M4 Max: 510-700 µs measured) off the first
    multithreaded call that leaves the caller's thread.
  - A behaviour change of `initialize()`: a minor version bump and a
    changelog entry; measure the pool's memory cost when it is built.
  Benchmarking the one-shot APIs (Zooko agreed): exactly two automated
  scenarios, back to back (perf_regress at 3%: small kernel regressions)
  and after idle (20%: the wake path and cold starts, which back to back
  cannot see, as the 5-8x after-idle pool slowdown showed); no warm-start
  gap scenario (no evidence it would catch anything). The graph plots back
  to back only; the rest stays behind a door. To be written into policy,
  procedure, and code comments once the whole plan is settled.
  The whole plan designs every interface together, consistent with the
  others, and for each says which users and use cases it serves and how
  the benchmark measures it (Zooko, September 27). Its dimensions:
  - the shape of the work: one-shot one message; one-shot batch (the
    padded batch contract, settled); streaming one message (input
    arriving in pieces: `Hasher`, `Stream`); streaming batches (a stream
    of separate inputs: the `Queue` design);
  - threads: single-threaded, multithreaded, and a thread budget;
  - energy efficiency against time efficiency (what each form spends,
    and how a user chooses);
  - the modes: plain, keyed, and key derivation, for every shape;
  - the Rust type signatures, one consistent style across all of them;
  - initialization (settled above), and the "built for" labels (to be
    reworded: the one-shot forms are the simple ones; top speed belongs
    to the streaming forms).
  Settled so far: one-shot one message; the batch contract. Proposed for
  batches (Zooko to confirm): the docs recommend hash_many_multithreaded
  as hash_multithreaded is recommended; output stays 32-byte arrays;
  perf_regress adds the 4- and 12-message points.
- The pool keeps nothing awake between calls (Zooko, September 27):
  its workers poll only while a job is registered and sleep when none
  is; waiting inside a call stays. Every call therefore meets sleeping
  workers, so a call wakes workers only when its input pays for the wake
  and otherwise runs on the caller's thread. The benchmark's back-to-back
  mt cells slow (they measured workers kept awake for a next call, which
  few real programs make); the benchmark gains a sweep of caller gaps
  (real work between calls, timed with them), and the pool is judged by
  the worst gap. Callers with a stream of inputs are told to use batches
  (and later a pipelined API).
- Benchmark time (Zooko, September 26): the caller keeps the machine
  quiet, and the benchmark detects and reports noise and wastes no time
  compensating for it; a small loss of reliability for a large saving
  of time is welcome. Streamed 32-128 MiB stay in `--all` (informative).
  BLAKE3 official mt runs only when named; BLAKE3 official stays in
  `--all` until servil beats it in every cell. The VM's warm-up gets no
  treatment beyond the note. Never change a tracked file and change it
  back (the lock is the side's own). PyPy over CPython wherever it runs.

- Contenders: at most two settings each (single-threaded, multithreaded
  uncapped); two scenarios (solo; shared = two copies of itself); wall
  time for everyone; tables per scenario; the text report keeps KERNELS;
  user views omit maintainer detail. BLAKE3 official's batches go through
  its hidden `Platform::hash_many`, sixteen per call, as programs that
  want its batch speed call it; the graph says so beside its name.
- The recommended usage first (fork AGENTS.md): one thread makes all
  calls; misuse and shared machines measured, reported, and cared for,
  no longer a veto.
- One SME2 call at a time per process (fork 30c599b): taken, costs in
  shared cells accepted. The overlap group for 13-15 one-block leftovers
  (fork 4d0751f): taken, its slowed cells accepted (Zooko, September 25).
- k8 as two scalars beside a quad and a pair (P -16%, E +7% at 8 KiB):
  taken. k4 as two pairs and the "minimax" plans: rejected.
- One batch API, one buffer (Zooko, September 26): `hash_many(input,
  message_len, out)` and its multithreaded forms.
- **The padded batch contract** (Zooko, September 26): message i starts
  at byte i x s, s = message_len rounded up to a multiple of 64 (64 for
  an empty message); the caller zeroes the bytes between one message's
  end and the next one's start (the caller's obligation, so the kernels
  never mask); any message length; `assert` on the lengths, `debug_assert`
  on the zero padding (hot path); no base alignment unless a measurement
  shows it pays. Public docs state it without a new term ("slot").
- The fork builds without SME2 (a warning) when the compiler cannot
  assemble it (Debian 12, Raspberry Pi OS).
- The README's warning (new, AI-written, unscrutinized, unused) stands in
  one place, the fork README's top; no copies elsewhere (Zooko).
- Branch naming `candidate/<topic>`; no promotion without the Mac verdict.
- The Mac runner is launched manually by Zooko; code from GitHub only.
- Name Zooko as "Zooko" alone, everywhere (AGENTS).
- The startup self-test: every assembly entry, at 0.1-0.2 ms once per
  process (option 4), over a smaller budget that leaves kernels out.
- No long random differential runs ("superstitious fuzzing"); no
  emulators, not even for unit tests.
- Time is discrete (every clock ticks): integers, kept as measured,
  lossy steps deferred to one rounding for the reader (AGENTS).
- The benchmark: no 256 B batches, ab-blake3, or commonware; SHA3-256 in
  `--all`. The README shows one speed chart (1 MiB, BLAKE3 every core and
  one core against the fastest SHA-256, SHA3-256, SHA-1), in cores alone,
  labelled by hash, with a "how it was made" door.
- The graph's header sits at the top of the page (the chips replace the
  following header); the page never gets shorter than it loaded.
- Releases follow semver; before 1.0 a breaking change bumps the minor
  version (0.1.0 to 0.2.0: hash_many's one-buffer API, Stream).
- perf_regress holds solo regressions and reports shared ones; a commit
  that slows a shared cell names it and its reason (Zooko, September 26).

## Idea: the `efficient` module (worth building, later; Zooko, September 26)

SME2 is the cheapest kernel per byte (fork NOTES, "Energy per byte"), so
an energy-efficient mode keeps it; single-threaded calls equal today's,
apart from the "minimax" NEON plans for 2-15 KiB (E-core cycles -16-24%,
P +17%). Multithreaded: the caller on SME2 with the E-cores' NEON helpers
at background QoS hashed 8 MiB 10-27% faster than hash() for a third less
energy, level at 1 MiB, slower below; it needs a second, sleeping pool.
The pool's idle workers poll through a call, which doubles the energy of
calls with a small thread budget.

## Idea: a truly streaming (pipelined) hasher (Zooko, September 25)

`Hasher::update` is synchronous: the caller waits while we hash, and our
resources idle while the caller produces the next piece, a pipeline
bubble at every call. A pipelined API buffers between the two: the caller
hands over pieces and returns at once while our threads (the SME2
streamer, NEON workers) hash behind it; `finalize` drains. BLAKE3 suits
this as SHA-256 cannot: every piece's place in the tree is known from its
offset, so pieces hash in parallel and out of order, and only the CV-stack
merge runs in order. Design points:
- Back-pressure: bounded buffers; when full, the producer blocks (simplest,
  the standard bounded-channel answer), or an async form returns Pending.
- Copying: `update(&[u8])` borrows, so hashing after return means copying,
  which on M4 costs about what hashing costs at mt speeds. Zero-copy
  forms: the caller fills our buffers (`buffer() -> &mut [u8]`, then
  `submit(n)`; blocking on `buffer()` is the back-pressure), or hands us
  owned buffers. Buffers of one power-of-two size make every piece a whole
  subtree.
- Contract: multithreaded by nature (another thread hashes); fits the
  "one caller thread, we spread under the hood" recommended usage.
- Benchmark: a use case where the producer does work per piece (a copy
  from a source buffer, as a read would), timed end to end, so the overlap
  shows; synchronous contenders run the same producer.

## Idea: a full-fledged Merkle tree API (worth building, later; Zooko, September 26)

A `servil::merkle` module that builds, opens, and verifies Merkle trees,
so a user like Remco calls one function per tree instead of looping
`hash_many` over layers. Write its trade-offs up for Zooko before
building. Design points, as we know them now:
- It rides on the batch API: leaves through `hash_many(leaves, leaf_len,
  ..)`, each node layer through `hash_many(previous_layer, 64, ..)`. A
  layer's digests lie back to back, so each pair of children is already
  one 64-byte message in place: zero copying from leaves to root, and
  the multithreaded forms split a layer over threads.
- Fused layers: hash the leaves and the lowest node layers together
  while the digests are still in cache (or in the SME2 unit's registers)
  instead of writing every layer to memory and reading it back.
- Domain separation between leaves and nodes (against second-preimage
  tricks): BLAKE3's keyed mode or `derive_key` contexts give it at no
  cost; a prefix byte would break the 64-byte alignment. An opinionated
  default and, perhaps, a mode that reproduces a plain-hash format such
  as Remco's (his commitments use plain BLAKE3 of the children), since
  changing a proof system's commitment format is its authors' call.
- What the caller gets back: the root alone, or every layer (openings
  need them); openings (authentication paths) and their verification.
- Leaf counts that are no power of two: pad to one, or carry an odd node
  up; the padded batch contract (Decisions) sets the leaf layout.

## Open problems

Each stays open until controlled, explained to users with how to control
it, or at least predicted (AGENTS.md, "we own every slowdown").

1. **2-4 KiB and 2304-4470 B against SHA-256** (the report's CHECKS we can win):
   2 KiB is one NEON pair's chain, 3 KiB a pair beside a free scalar
   chunk, 4 KiB two scalars beside a pair (integer-bound); ideas estimated,
   not built: parents and root inside k4 (about 3.6%), a direct small-tree
   path (1-2%); a faster pair chain would move 2-3 KiB.
2. **Benchmarks on hardware they cannot see or steer** (the VM): runs
   report other programs' load from OS counters, but this hypervisor
   reports no steal time, so host load stays invisible in the guest (a
   reference loop timed beside the samples would show it; NOTES.md, "Load
   from other programs"). The host
   places vCPUs on P- or E-cores at will; cells come out two-speed with
   run-to-run splits. Round-by-round pairing and two-speed reporting exist;
   to weigh: inferring each sample's core kind from a reference loop timed
   beside it, extending runs until each speed's share is known.
3. **P/E classification of every sample on the Mac** (the counters exist
   in `--trace-clocks`): tables from P-core samples, E shares in the
   maintainer report, `perf_regress` P against P.
4. **Judging two-speed changes**: `perf_regress` reports each cell's 90th
   percentile but judges the 5th; the turn got no verdict because it moves
   the control. A rule for such changes is open.
5. **Shared cells are coin tosses** under the turn (which copy holds it):
   records of identical code differ by up to 60% in shared small batches
   on the VM. Predict or control.
6. **NEON goes cold** after stretches without vector work (1000 one-block
   messages cost 23% more per message than 1024 in a tight loop). Probed
   September 25 (fork NOTES, "SME2 remainders"): the remainder's order is
   not the cause. The SME unit has a slow state (cycles per ns 3.2
   against 3.93) entered after idle time of about a quarter microsecond;
   what else enters it is open (fork NOTES, "SME2 remainders"). The
   overlap group for 13-15 one-block leftovers is in (4d0751f, a trade
   Zooko accepted). Next: measure the state machine directly (SME2 work,
   then X ns of other work, then SME2 work: speed against X, against the
   first stretch's length, and against the number of streaming sessions),
   then an overlap group inside one streaming session (a kernel entry).
7. **SME2 batch rates with work between calls** (about 12 ns/msg, not the
   benchmark's 10): whether batches should use SME2 from 16 messages.
8. **The E-core trigger's mechanism** (controlled by the turn; unexplained).
9. Later: `tools/promote.py` (check the gate, write the note, fast-forward;
   a pre-push hook refusing a `servil` tip without both verdicts); the
   Mac's serial 128 MiB rise; `many::TABLE` natively; a GPU kernel.

## Commands

From `/workspace` in the VM, after `sh /workspace/vm/setup.sh` once per boot:

    cargo test --release --lib [--features no_sme2 | --features pure]
    cargo test --release --doc
    cargo test --release --test api_plan
    cargo test --release --manifest-path test_vectors/Cargo.toml
    cargo test --release --manifest-path clocks/Cargo.toml && pypy3 tools/speeds.py
    pypy3 tools/ab.py OLD NEW NEW OLD   # runner jobs, speed with speed
    cargo test --release --manifest-path bench-hashes/Cargo.toml
    pypy3 tools/perf_regress.py check | compare OLD NEW
    cargo run --release --example host_lab

Expected: 86 / 82 / 71 library tests, 22 doc tests, 14 in `--test api_plan`, 2 vectors, 10 benchmark
tests. Release: `python3 tools/gen-ver.py X.Y.Z` from a clean tree (two
version commits and a lightweight tag; push the branch, `servil` in the
fork or `main` here, then the tag by name).
Never print the credential token (`/workspace/ghtokenclassic.txt`). Only
`/workspace` survives VM restarts. Commands for the user go on one line.

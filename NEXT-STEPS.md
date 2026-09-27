# Next steps

Read this file first. The work: make the servil fork the fastest BLAKE3 in
every situation a user meets (minimax: judge by the worst plausible case),
natively on the Mac first, then in the VM (the user's decision,
September 27, 2026: diagnose on the Mac), measured by this
benchmark. Prefer changes that are simpler and faster together. The
principles are in both repositories' `AGENTS.md`; the fork's hardware
facts, design, and rejected ideas are in its `NOTES-servil.md` (read it
before touching kernels or the pool); this repository's are in `NOTES.md`.

## Resume here (checkpoint, September 27, 2026, night; Zooko asleep)

**State.** Fork `servil` b30b7eb (library code as b9ec183: p4 as two
scalars beside a pair, Zooko's decision), the streaming design in `docs/` on top;
bench-hashes `main` pinned to b9ec183. Records (Mac job 403, mains power,
provenance fixed; VM) and the README chart on b9ec183. Runner restarted by
Zooko (September 27); jobs run to 403, the next number is 404. Solo,
servil now beats BLAKE3 official in every cell; shared 12 and 24 messages
remain (the SME2 turn). Both trees clean.

**Done this session** (September 27; details in the commits and the
fork's NOTES "Waking", "Holds", "Two aims", "Pauses slow the core's
clock", "The clock after a pause, measured"):
- Power state recorded everywhere (bench-hashes report, samples, graph;
  perf_regress's verdict; the runner's verdict.json). Battery power moves
  more calls after a pause onto E-cores; the clock's fall after a pause
  happens on mains too.
- The Mac's clock after a pause (jobs 358-359): sleeps of 500 µs-20 ms
  leave about 85 µs of work at 1.06 GHz; 100 ms longer; a 1 ms spin
  leaves 2.5 GHz. Told users in the crate docs.
- **The pool keeps nothing awake between calls** (1046c10, Zooko's
  decision and framing: a fix to the benchmark, not a slowdown users
  meet): workers poll only while a job or Hold is registered; a call
  wakes only the workers it can use (the caller one, the first woken the
  rest); MIN_SPLIT_LEN 768 KiB. After idle mt now equals st below the
  split and beats it above; back-to-back mt cells slowed (numbers in the
  commit message).
- **A multithreaded Stream holds the pool** while its next buffer waits
  (3d7102e): Mac streamed mt 32 MiB 0.065 -> 0.043 ns/B.
- API docs: each interface says whether it is built for top speed or a
  low worst case (3d4b863); the name of the second aim is Zooko's to
  settle.
- bench-hashes: a fifth dot shape; `--trace-clocks` also traces the
  after-idle bursts (3ef62fa).
- Tried and dropped: wake fan-out as a tree (level on both machines).

**Found, open, for Zooko:**
- **The after-idle CHECKS compare clock states, not code.** In the Mac
  record (380) every after-idle cell is two-speed (fast|slow about 2-2.5x
  apart, every contender): after some 1 ms sleeps the clock stays up,
  after others it falls. A traced run (381) caught the slow state every
  time: every contender at about 1.26 GHz against 4.44, cycles per call
  as back to back, so servil's ratio to SHA-256 after idle equals its
  ratio back to back. CHECKS judge at the worse round-by-round ratio,
  which pairs one contender's fast burst with another's slow one: its
  "servil st x5 slower than SHA-256 after idle" lines are the machine's.
  Proposed fix (AGENTS "Measuring": compare within one state): read the
  counts around every after-idle burst where the platform has them, keep
  each sample's state (cycles per ns) in the samples file, and compare
  after-idle cells within a state; report the state mix. A samples-format
  change (v4) and a CHECKS change: Zooko's review first.
- **The gap sweep** (a caller doing real work between calls) was
  proposed to judge lingering; with nothing kept awake every call meets
  sleeping workers at any gap, so it now measures only the clock state,
  which back to back and after idle already bracket. Worth building only
  for in-core effects such as the SME unit's slow state (open problem 7).
- The after-idle margin (20%, job 338) was calibrated when the Mac's power
  state was unknown; recalibrate on mains after the state fix above.

**Lessons (this guest).**
- Before promoting a kernel or plan change, measure E-cores (NOTES,
  "Rejected", p4: how on this Mac) and read the comments above the plan
  tables: perf_regress runs on P-cores, and its points skip some batch
  sizes (4 messages among them).
- `pkill -f PATTERN` matches the shell running it and kills the command;
  kill by PID (`cmd & PID=$!`, then `kill $PID`). Each tool call is a
  fresh shell: repeat the `HOME=... CARGO_TARGET_DIR=...` prefix on every
  command, or cargo builds into another target directory. Run verification tools (Kani, CBMC) under `timeout`: a
  symbolic divisor over all of usize ran 3.5 hours.
- A version bump makes cargo ignore a `[patch]` of a different version,
  with only a warning; perf_regress and the runner now lock the patched
  version first and fail stop unless the fork came from the checkout.
- gdb needs `SHELL=/bin/sh` and `set startup-with-shell off`; bash
  process substitution (`<(...)`) fails here (no /dev/fd): use files.
- The runner reruns any job it never finished; to clear one, move its
  file out of `runner/jobs/` (into `runner/jobs-archive/`). A job that
  never starts means the runner is stopped: ask Zooko, don't wait.
- Compare only measurements taken side by side (alternated): a sequence
  run earlier sat in another machine state (a quiet VM read solo spreads
  of 0.48% where the same code, alternated later, read 1.4-1.5%), and a
  conclusion drawn across the two was wrong.
- A fork change that a bench-hashes change depends on (a new crate, an
  API) is promoted first, with bench-hashes' edits stashed, since the
  pre-commit check builds bench-hashes' working tree against `servil`.

### Next, in order

1. **The after-idle state fix** (above, "Found, open"): after Zooko's
   review.
2. **A proper streaming mode with minimal pipeline bubbles** (Zooko,
   September 27): the caller hands over pieces and moves on while our
   threads hash behind it, so the engine never idles while the caller
   handles results or produces input; the interface callers with a
   stream of inputs are steered to, now that the pool keeps nothing
   awake between calls. `Stream` already covers one long input; the
   design for many inputs, each with its own digest, is written up for
   Zooko's review in the fork's `docs/design-pipelined-hashing.md` (a
   `Queue`: our buffers, submission-order digests, a byte budget as
   back-pressure, small inputs batched, a hold across inputs; five open
   questions). Build after his answers.
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

From `/workspace` in the VM, each with the prefix above:

    cargo test --release --lib [--features no_sme2 | --features pure]
    cargo test --release --doc
    cargo test --release --manifest-path test_vectors/Cargo.toml
    cargo test --release --manifest-path bench-hashes/Cargo.toml
    pypy3 tools/perf_regress.py check | compare OLD NEW
    cargo run --release --example host_lab

Expected: 89 / 85 / 74 library tests, 21 doc tests, 2 vectors, 5 benchmark
tests. Release: `python3 tools/gen-ver.py X.Y.Z` from a clean tree (two
version commits and a lightweight tag; push the branch, `servil` in the
fork or `main` here, then the tag by name).
Never print the credential token (`/workspace/ghtokenclassic.txt`). Only
`/workspace` survives VM restarts. Commands for the user go on one line.

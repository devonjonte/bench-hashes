# Next steps

Read this file first. The work: make the servil fork the fastest BLAKE3 in
every situation a user meets (minimax: judge by the worst plausible case),
natively on the Mac and in the VM (both first-class), measured by this
benchmark. Prefer changes that are simpler and faster together. The
principles are in both repositories' `AGENTS.md`; the fork's hardware
facts, design, and rejected ideas are in its `NOTES-servil.md` (read it
before touching kernels or the pool); this repository's are in `NOTES.md`.

## Resume here (checkpoint, September 26, 2026, late night)

**State.** Fork `servil` 13402d6 (code as f38786d: the flat walk's scratch
on a 4 KiB boundary); bench-hashes pinned to 5a783bc (same code), `main`
past it with the benchmark changes below; every promotion has its gate
note in `refs/notes/perf`. Records (VM and Mac `--all`) are still
bench-hashes ee956b7's, on servil f9d39b0: remake both on the tip (the
sampling, the roster, and the alignment changed). Runner jobs run to 326;
the next job number is 327.

**Waiting on Zooko.**
- Rerun `setup-mac.sh` (servil ad24649 installs perf_regress.py beside
  runner.py; job 327 failed without it): the runner now keeps its
  clones between jobs and builds through `perf_regress.py build`
  (servil 13402d6), and benchmark jobs take `"repeat": N`.
- Then the Mac calibration of perf_regress's 24-round rule: one benchmark
  job, contenders sha256, blake3-servil-st, blake3-servil-mt, perf_regress's
  29 points, `"rounds": 24`, `"repeat": 48`; simulate checks over
  consecutive runs as `/tmp/cal/sim2.py` did on the VM (the scripts are
  gone with the guest; the method is in the fork NOTES, "perf_regress").
  The Mac showed more open points after the first pair (22 of 29, job 325)
  than the VM (5-12).
- Try the graph on his iPhone (bench-hashes 20a87c6), a real x86-64
  machine, perf_regress's 256 B batch points, upstream issue #590 / PR
  #591: as before.

**Done this session** (details in the commits, the fork's NOTES
"perf_regress" and "The slow state, measured directly", and NOTES.md):
- The VM's 32-64 KiB two speeds traced to the flat walk's scratch
  placement (malloc chose its residue mod 4 KiB); aligned (f38786d).
- perf_regress: 95 s -> 17 s on the VM (curtailment, targeted
  confirmation, 24 rounds recalibrated, sides that own their builds and
  locks; `perf_regress.py build` for runs by hand); Mac gate jobs 104 s
  -> 38-47 s, less once the runner restarts.
- bench-hashes: a default full run 47 s -> 18.8 s (12 samples a cell, no
  "unsure" doubling); BLAKE3 official mt by request only (`BY_REQUEST`);
  `--rounds N` samples every cell in each round; build.rs watches tags in
  the common git directory (worktree builds had always rebuilt).
- Found, open (fork NOTES): the VM warms up over 3-4 minutes of load
  (SHA-256 +5-11%, BLAKE3 +2-6%; no user-facing action, Zooko); SME2
  batches of 16 switch between 10, 15, and 20 ns/msg for seconds at a time
  on the VM while SHA-256 holds (host programs sharing the SME unit?); a
  trivial change moved shared 32-64 KiB by 20-24% in all pairs (layout, or
  the SME2 lock's timing); a quarter of VM processes still run 32-64 KiB
  slow (the host's 16 KiB pages?).

**Lessons (this guest).**
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
  file out of `runner/jobs/` (into `runner/jobs-archive/`).

### Next, in order

1. **Weak cells** (minimax; both records): 64 B at 4 messages (Mac:
   servil 24-25 ns/msg against official 22-23; the hybrids against the C
   four-lane kernel); SHA-256 against BLAKE3 at 2-4 KiB single messages
   (open problem 1); servil mt's shared batches (CHECKS: 48 and 128
   messages, mt slower than st when two copies run).
2. The E-core cells: 2-chunk messages at 4 (p4 two pairs), 1000 B x 4;
   tails of 1-4 multi-block messages past SME2 groups (slow state).
3. **One cell's aftereffects slow the next** (open, ours to explain): on
   the VM, a long run of shimmed batch cells once made the next SHA-256
   64 B cell 3-6% slower; the mechanism is unexplained.
4. The text report's three-reader pass (CHECKS, TWO SPEEDS).
5. A second SME2 thread in the pool (two SME units reachable, job 187).
6. Open, smaller: hash(256 KiB)'s partial slow state; the VM's
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

- **VM setup** after a restart: `sh /workspace/vm/setup.sh` (clang-19,
  pypy3, rsvg, the guest's pre-commit hook). The graph check needs Node
  and jsdom: `apt-get install -y nodejs npm`, then `npm install jsdom@22`
  in `/tmp/gc` and `NODE_PATH=/tmp/gc/node_modules node
  tools/graph-check/check.js GRAPH.svg`.
- **Every `git` and `cargo` command** in the VM takes
  `HOME=/workspace/vm/home CARGO_TARGET_DIR=/tmp/target CC=clang-19 TMPDIR=/tmp`,
  `git commit` included (the hook builds; without `CC` it aborts the
  commit and leaves the branch where it was).
- **The gate to `servil`** (fork AGENTS.md "Branches"), for every change,
  a README's included: work on `candidate/<topic>`; every suite;
  `perf_regress compare servil candidate/<topic>` on the VM and as a Mac
  runner job; a fast-forward; the verdicts as a note in `refs/notes/perf`
  (`git notes --ref=perf add`, pushed with `servil`); delete the branch;
  pin here. Changes that trade one cell for another go to Zooko with
  their numbers.
- **`perf_regress` and older commits**: the benchmark calls the current
  fork API; `tools/perf_regress.py` shims older commits (renaming their
  old functions, forwarding or wrapping the new names). A comparison with
  a wrapped side measures and judges the one-message cells alone. A
  benchmark change that calls a new fork API needs a shim there.
- **The Mac** (fork `tools/runner/README.md`): Zooko starts the runner
  with `sh ~/piplayground/blake3-servil/tools/runner/setup-mac.sh`. Write
  `runner/jobs/NNN-name.json` naming pushed commits; wait with
  `pypy3 tools/runner/wait_for.py NNN-name`; results in
  `runner/results/`. A job runs once per file name: a rewritten job keeps
  its old result, so a changed job takes a new number. Keep the VM idle
  while a Mac job runs. A direct A/B is four `benchmark` jobs, old new
  new old, run back to back (spread apart, the control moves). Mac-only
  measurements (cycles by core kind, QoS) go in a `probe/<topic>` branch
  that replaces `examples/host_lab.rs` (fork NOTES, "Probes on the Mac");
  the `probe/*` branches on origin are those probes, each cited in the
  fork's NOTES where its finding is.
- **Records** measure the pinned fork commit: after a promotion,
  `cargo update -p blake3-servil` here and commit the lock; the VM's with
  `cargo run --release -- --all` from this directory (unpatched; writes
  `benchmark-results/` here); the Mac's as a runner job naming that fork
  commit, flags `["--all"]`, its files copied into
  `benchmark-results/AppleM4Max.darwin25/`. Run the graph check on both
  graphs before committing.
- **Exploratory runs** go in a scratch directory with the built
  executable (`cd /tmp/qr && /tmp/target/release/bench-hashes --quick
  ...`, or `$(pypy3 /workspace/tools/perf_regress.py build)` for the
  fork's working tree): a run from this directory overwrites the records.
- **Looking at a graph**: `rsvg-convert -w 1300 GRAPH.svg -o
  /tmp/g.png`, crop with `convert`, copy into `/workspace/tmp/`, and read
  it by its host path
  (`/Users/donaldturnworth/piplayground/blake3-servil/tmp/...`); the
  host sees a new file after a moment.

## Decisions made (don't re-ask)

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

Expected: 89 / 85 / 74 library tests, 21 doc tests, 2 vectors, 8 benchmark
tests. Release: `python3 tools/gen-ver.py X.Y.Z` from a clean tree (two
version commits and a lightweight tag; push the branch, `servil` in the
fork or `main` here, then the tag by name).
Never print the credential token (`/workspace/ghtokenclassic.txt`). Only
`/workspace` survives VM restarts. Commands for the user go on one line.

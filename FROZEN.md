# What the benchmark asks of the servil fork (frozen)

The servil team's contract with itself (Zooko and John Servil): bench-hashes
measures the fork through exactly the calls and usage patterns below, which
are the API plan (the fork's `docs/api-design.md`) turned into
measurements. The fork's work is to be as fast as possible under them.
Changing what the benchmark asks is a decision of Zooko's: edit this file
with the change, the date, and the reason, and the code with it; the test
`frozen_contract_matches_frozen_md` compares the block below with the
code's own tables and fails when they differ. Everything else about the
benchmark (the other contenders, the report, the graph) may change freely.

Why each piece is here (Zooko, September 28, 2026, replacing the contract
of September 27, whose queue cells measured a round trip rather than
throughput and whose synchronous cells measured calls back to back, which
their users seldom make):

- **Four questions lead a user to one call** (`docs/api-design.md`): can
  the program use several threads; the shape of the data (a message in
  one buffer, a message in pieces, a batch); time or energy (several
  threads only); and, with several threads, whether another message is
  usually ready when one finishes (continuous) or the program goes off
  and does other things (intermittent). The benchmark measures each call
  only as its contract says users call it.
- **The synchronous calls, each after the gap**: `hash`,
  `hash_multithreaded`, `hash_many`, `hash_many_multithreaded`, and
  `Hasher::update` and `update_multithreaded` per piece, each call (for
  pieces, each message) after 1 ms of the program's own work on its
  thread (integer arithmetic; Zooko, September 28, 2026, morning, in
  place of 1 ms asleep, whose clock states split every cell in two and
  left its results noisy), as a program that hashes and then does other
  things calls. None is measured
  back to back. Single-threaded calls are built for this use and save
  time.
- **The queue, one message or batch after another**, as fast as the
  program can, with enough in flight to cover the queue's round trip
  (about 1 MiB or 1024 buffers, whichever is fewer): messages of one
  length (one buffer each up to 64 KiB, pieces beyond), and batches of
  64-byte messages. Several threads only; efficient in time (the energy
  endings wait for an energy counter).
- **The program's side of the queue allocates nothing after warm-up**
  (Zooko, September 28, 2026, morning): the program makes its queue and
  a bounded channel for the returns once and keeps both, as a program
  makes one queue for its life, and the channel is a ring allocated when
  it is made. Until then each sample made a new queue (its slots
  allocated inside the sample) and returned buffers through an unbounded
  channel, which allocates a block every few dozen messages; the queue's
  own contract (no allocation after warm-up) was never reached.
- **Batches under the padded batch contract** (Zooko, September 26): the
  caller lays out and zero-pads the messages.
- **Shared scenarios for every use case** (Zooko, September 28): two
  copies at once, their calls after the gap starting together; a sanity
  check against designs that need the machine to themselves, and a
  pessimistic estimate of what users see; measured and reported, not
  optimised for directly. The graph plots solo and shared.
- **Planned, to add under this contract**: the energy endings
  (`Efficiency::Energy` on the queue and the multithreaded synchronous
  calls) once an energy counter is validated; keyed and derive-key spot
  checks in perf_regress.

```frozen
use case OneMessage: 64 B, 128 B, 256 B, 512 B, 1 KiB, 2 KiB, 2304 B, 3 KiB, 3839 B, 4 KiB, 4470 B, 7935 B, 8 KiB, 16 KiB, 32 KiB, 64 KiB, 128 KiB, 256 KiB, 512 KiB, 1 MiB, 2 MiB, 3 MiB, 4 MiB, 8 MiB, 32 MiB, 64 MiB, 128 MiB
use case ManyMessages: 1, 2, 3, 4, 6, 8, 12, 16, 24, 32, 48, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072, 262144
use case Streaming: 64 B, 128 B, 256 B, 512 B, 1 KiB, 2 KiB, 2304 B, 3 KiB, 3839 B, 4 KiB, 4470 B, 7935 B, 8 KiB, 16 KiB, 32 KiB, 64 KiB, 128 KiB, 256 KiB, 512 KiB, 1 MiB, 2 MiB, 3 MiB, 4 MiB, 8 MiB, 32 MiB, 64 MiB, 128 MiB
use case ContinuousMessages: 64 B, 256 B, 1 KiB, 4 KiB, 16 KiB, 64 KiB, 256 KiB, 1 MiB, 4 MiB, 16 MiB, 64 MiB
use case ContinuousBatches: 16, 64, 256, 1024, 4096, 16384, 65536
scenarios: solo, shared
graph plots: solo, shared
blake3-servil-st OneMessage: hash(input), each call after the gap
blake3-servil-st ManyMessages: hash_many(batch, 64, out), the padded batch contract, each call after the gap
blake3-servil-st Streaming: Hasher::update per 64 KiB piece, then finalize, each message after the gap
blake3-servil-mt OneMessage: hash_multithreaded(input), each call after the gap
blake3-servil-mt ManyMessages: hash_many_multithreaded(batch, 64, out), the padded batch contract, each call after the gap
blake3-servil-mt Streaming: Hasher::update_multithreaded per 64 KiB piece, then finalize, each message after the gap
blake3-servil-mt ContinuousMessages: Queue::messages(Mode::Hash, Efficiency::Time) for messages of up to 64 KiB, Queue::pieces(Mode::Hash, Efficiency::Time) in 64 KiB pieces for longer ones, one message after another, each read into free buffers of the program's, about 1 MiB or 1024 buffers in flight, whichever is fewer, cycled through the handler and a bounded channel with room for all of them (std::sync::mpsc::sync_channel, allocated when made), the queue and the channel made once and kept
blake3-servil-mt ContinuousBatches: Queue::fixed(64, Mode::Hash, Efficiency::Time), one batch after another, each read into a free buffer of the program's, submitted with its digests' space, about 1 MiB or 1024 buffers in flight, whichever is fewer, cycled through the handler and a bounded channel with room for all of them (std::sync::mpsc::sync_channel, allocated when made), the queue and the channel made once and kept
```

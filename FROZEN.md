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

- **Five questions lead a user to one call** (Zooko, September 28,
  evening, `docs/api-design.md`): several threads; data shape; whether
  the receiving thread keeps up; who controls the buffer; time or energy
  (the energy choice waits for a validated counter). The benchmark now
  measures the owned-buffer and lent-buffer columns separately.
- **Calls after the gap**: `hash`, `hash_multithreaded`, `hash_many`,
  `hash_many_multithreaded`, and `Hasher::update` per 64 KiB piece,
  each message or batch after at least 1 ms of the program's other work.
  The gap walks a kept 128 MiB buffer at 64-byte intervals, then spends
  any remaining millisecond on integer arithmetic. A complete sweep is
  required even when it lasts longer. The producer writes the input
  after the gap, before the call; its write is timed separately and
  excluded from the hashing sample (Zooko, September 28, evening: evict
  the preceding cell's cache state, then measure freshly produced input). A thread
  that keeps up with arriving pieces uses `update` in both servil
  contenders; its multithreaded incremental call belongs to the lent,
  continuous column. This changes servil mt's after-gap pieces cell
  (September 28, evening: the new table).
- **Continuous load, buffers owned**: the queue, one message or batch
  after another, with about 1 MiB or 1024 buffers in flight, whichever
  is fewer. Messages up to 64 KiB arrive in one buffer, longer messages
  in 64 KiB pieces. The other contenders use the same producer and
  synchronous calls, serving as the comparison for pipelining.
- **Continuous load, buffers lent** (Zooko, September 28, evening):
  three new axes, whole messages, messages in 64 KiB pieces, and batches,
  read and hashed back to back through synchronous calls. The producer's
  buffer is lent until each call returns; reads and hashing take turns.
  The servil single-threaded calls measure the one-thread column; its
  multithreaded calls measure the several-threads, lent-buffer column.
  Message lengths and batch counts match the owned-buffer continuous
  axes, so the comparisons use the same work quantities. Whole messages
  arrive in one buffer even beyond 64 KiB. Pieces use `update` on one
  thread and `update_multithreaded` on several threads.
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
use case LentMessages: 64 B, 256 B, 1 KiB, 4 KiB, 16 KiB, 64 KiB, 256 KiB, 1 MiB, 4 MiB, 16 MiB, 64 MiB
use case LentPieces: 64 B, 256 B, 1 KiB, 4 KiB, 16 KiB, 64 KiB, 256 KiB, 1 MiB, 4 MiB, 16 MiB, 64 MiB
use case LentBatches: 16, 64, 256, 1024, 4096, 16384, 65536
scenarios: solo, shared
graph plots: solo, shared
blake3-servil-st OneMessage: hash(input), each call after the gap
blake3-servil-st ManyMessages: hash_many(batch, 64, out), the padded batch contract, each call after the gap
blake3-servil-st Streaming: Hasher::update per 64 KiB piece, then finalize, each message after the gap
blake3-servil-mt OneMessage: hash_multithreaded(input), each call after the gap
blake3-servil-mt ManyMessages: hash_many_multithreaded(batch, 64, out), the padded batch contract, each call after the gap
blake3-servil-mt Streaming: Hasher::update per 64 KiB piece, then finalize, each message after the gap
blake3-servil-mt ContinuousMessages: Queue::messages(Mode::Hash, Efficiency::Time) for messages of up to 64 KiB, Queue::pieces(Mode::Hash, Efficiency::Time) in 64 KiB pieces for longer ones, one message after another, each read into free buffers of the program's, about 1 MiB or 1024 buffers in flight, whichever is fewer, cycled through the handler and a bounded channel with room for all of them (std::sync::mpsc::sync_channel, allocated when made), the queue and the channel made once and kept
blake3-servil-mt ContinuousBatches: Queue::fixed(64, Mode::Hash, Efficiency::Time), one batch after another, each read into a free buffer of the program's, submitted with its digests' space, about 1 MiB or 1024 buffers in flight, whichever is fewer, cycled through the handler and a bounded channel with room for all of them (std::sync::mpsc::sync_channel, allocated when made), the queue and the channel made once and kept
blake3-servil-st LentMessages: hash(input), one message after another, each read into a kept buffer and lent until the call returns
blake3-servil-st LentPieces: Hasher::update per 64 KiB piece, then finalize, messages one after another, each piece read into a kept buffer and lent until the update returns
blake3-servil-st LentBatches: hash_many(batch, 64, out), the padded batch contract, batches one after another, each read into a kept buffer and lent with kept digests until the call returns
blake3-servil-mt LentMessages: hash_multithreaded(input), one message after another, each read into a kept buffer and lent until the call returns
blake3-servil-mt LentPieces: Hasher::update_multithreaded per 64 KiB piece, then finalize, messages one after another, each piece read into a kept buffer and lent until the update returns
blake3-servil-mt LentBatches: hash_many_multithreaded(batch, 64, out), the padded batch contract, batches one after another, each read into a kept buffer and lent with kept digests until the call returns
```

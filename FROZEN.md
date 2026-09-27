# What the benchmark asks of the servil fork (frozen)

The servil team's contract with itself (Zooko and John Servil, September 27,
2026): bench-hashes measures the fork through exactly the calls and usage
patterns below, which are the API plan (the fork's `docs/api-design.md`)
turned into measurements. The fork's work is to be as fast as possible under
them. Changing what the benchmark asks is a decision of Zooko's: edit this
file with the change, the date, and the reason, and the code with it; the
test `frozen_contract_matches_frozen_md` compares the block below with the
code's own tables and fails when they differ. Everything else about the
benchmark (the other contenders, the report, the graph) may change freely.

Why each piece is here:

- **Two scenarios, back to back and after idle** (Zooko, September 27):
  back to back catches small regressions (perf_regress holds solo cells at
  3%); after idle catches the wake path and cold starts, which back to back
  cannot see (the pool's 5-8x after-idle slowdown went unnoticed until the
  scenario existed); no warm-start scenario, with no evidence it would
  catch anything. The graph plots back to back only (solo and shared); the
  rest stays behind a door.
- **One-shot calls, back to back**: `hash`, `hash_multithreaded`,
  `hash_many`, `hash_many_multithreaded`, the interfaces built for ease of
  use (never slower multithreaded than single-threaded).
- **Batches under the padded batch contract** (Zooko, September 26): the
  caller lays out and zero-pads the messages.
- **One input in pieces**: servil st through `Hasher` (ease of use); servil
  mt through the queue (built for efficiency; the streaming APIs come
  first, AGENTS.md), passing a fixed set of the program's buffers by
  ownership and getting them back through the handler.
- **Many inputs arriving** (planned under this contract, September 27;
  built September 28): separate inputs of one size, each read into a
  buffer (a memory copy) and hashed, a sample covering many of them timed
  end to end; servil st through `hash`, every other contender through its
  one-shot call, servil mt through `Queue::messages` with a fixed set of
  the program's buffers cycled through its handler. Sizes every factor of
  four from 64 B to 4 MiB (nine points; the one-message axis shows the
  sizes between).
- **Planned, to add under this contract**: `Queue::fixed` (messages of one
  length, many per buffer) in a use case of its own; keyed and derive-key
  spot checks in perf_regress.

```frozen
use case OneMessage: 64 B, 128 B, 256 B, 512 B, 1 KiB, 2 KiB, 2304 B, 3 KiB, 3839 B, 4 KiB, 4470 B, 7935 B, 8 KiB, 16 KiB, 32 KiB, 64 KiB, 128 KiB, 256 KiB, 512 KiB, 1 MiB, 2 MiB, 3 MiB, 4 MiB, 8 MiB, 32 MiB, 64 MiB, 128 MiB
use case ManyMessages: 1, 2, 3, 4, 6, 8, 12, 16, 24, 32, 48, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072, 262144
use case Streaming: 64 B, 128 B, 256 B, 512 B, 1 KiB, 2 KiB, 2304 B, 3 KiB, 3839 B, 4 KiB, 4470 B, 7935 B, 8 KiB, 16 KiB, 32 KiB, 64 KiB, 128 KiB, 256 KiB, 512 KiB, 1 MiB, 2 MiB, 3 MiB, 4 MiB, 8 MiB, 32 MiB, 64 MiB, 128 MiB
use case ManyInputs: 64 B, 256 B, 1 KiB, 4 KiB, 16 KiB, 64 KiB, 256 KiB, 1 MiB, 4 MiB
scenarios: solo, shared, after-idle
graph plots: solo, shared
blake3-servil-st OneMessage: hash(input), back to back
blake3-servil-st ManyMessages: hash_many(batch, 64, out), the padded batch contract
blake3-servil-st Streaming: Hasher::update per 64 KiB piece, then finalize
blake3-servil-st ManyInputs: hash(input) per input, each read into one buffer first
blake3-servil-mt OneMessage: hash_multithreaded(input), back to back
blake3-servil-mt ManyMessages: hash_many_multithreaded(batch, 64, out), the padded batch contract
blake3-servil-mt Streaming: Queue::pieces(Mode::Hash, Efficiency::Time), four 64 KiB buffers cycled through the handler, each piece copied into a free one, the digest through the handler after finish
blake3-servil-mt ManyInputs: Queue::messages(Mode::Hash, Efficiency::Time), four buffers cycled through the handler, each input copied into a free one, each digest through the handler with its buffer
```

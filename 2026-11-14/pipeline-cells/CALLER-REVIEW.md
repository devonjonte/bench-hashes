# Caller review before interpreting the Pipeline pilot

November 14, 2026. Candidate `55436819e`, library `f62bc6ac` (full pins in
README). This review concerns correct benchmark usage and visible costs;
it does not prove the library's implementation or establish a performance
cause from source alone.

## Inputs, ownership and completion

- `Messages::run` copies each input into Pipeline rooms. Its 64 KiB chunks
  fill a whole room for every nonfinal commit. A partial room can serve the
  next short message, while a long message starts with a whole room.
  `Message` tokens always reach `end`; every hash reaches `consume`.
- Receiving preserves the existing fragment/deadline trace. Fragments fill
  rooms directly, including a split when a fragment crosses a room boundary.
  The only partial commit is at message end. The hash is awaited before the
  next received message. The input length is not declared to the Pipeline.
- `Batches::new` calls `Batch::new(64, count)`, which owns its storage.
  `blocks_mut()` uses `Cow::to_mut`; on this owned batch it returns existing
  blocks. The producer makes one bulk copy. `Pipeline::batch` takes the
  Batch and digest box by value, and its event returns both. No batch clone,
  allocation, resize or per-message copy is added to the adapter's steady
  loop. Digests are consumed as a flat slice before storage re-enters `free`.
- The caller submits until its input buffers are occupied, consumes one
  completion, then submits again. It drains all remaining completions at
  the end. Input production and completion are inside the measured call.
- Existing collection tests exercise the actual dispatcher against each
  contender's expected per-item output. New tests cover fixed vectors,
  boundaries, receiving, reuse and shared producers. The corrupted-copy
  control fails, and restoration passes in release and debug builds.

## Budgets and sample sizes

Messages keep 16 rooms (1 MiB input storage) and 1024 message slots.
Batches use the existing `in_flight(input_bytes)` bound, from 2 to 1024.
The API-comparison `sizes.tsv` shows these iterations per sample:

| cell | input buffers / minimum inputs under existing rule | measured inputs |
|---|---|---:|
| 64 B messages | 1024 / 2048 | 18663 |
| 4 KiB messages | 256 / 512 | 760 |
| 64 KiB messages | 16 / 32 | 210 |
| 1 MiB messages | 16 rooms, 16 pieces/message / 2 messages | 12 |
| batches of 16 | 1024 / 2048 | 9210 |
| batches of 256 | 64 / 128 | 671 |
| batches of 4096 | 4 / 8 | 40 |

Both sides use the old side's sizes, as the current check specifies. These
are multiple rounds of input storage rather than a single submission and
wait. There are 100 ms warm-up trains. Collections are one full 2048-item
pass per sample; receiving is one complete 16 MiB message per sample.

## Why the costs remain open

Room-based hashing creates worker pieces and performs root assembly, while
the synchronous baseline's 64 KiB pieces run through incremental calls.
Batch submission creates message/event bookkeeping beside the batched
hashing. These are different execution paths, even with identical useful
bytes and outputs. Their overhead and useful overlap deserve measurement.

The harness keeps Pipeline objects per producer (and per batch size).
Library `lanes::sources::register` keeps them in its registered-source mask.
`opened` stays true until they are dropped. In this library version, an
open Pipeline enables workers to look for more work for up to 5 μs before
parking. This is a plausible contribution to the greater process CPU time,
and can affect synchronous cells run in the same process. The observation
is not a measured attribution of the whole difference to polling.

A program can keep pipelines and make synchronous calls in one process.
That interaction is useful evidence. A fresh-process diagnostic can isolate
it, but its result would supplement the mixed-process result. Deleting
unfavorable readings or silently changing the memory budget would weaken
the question the benchmark asks.

Recommended next steps:
1. John reviews whether the documented room and batch caller uses the API
   as intended, and identifies one specific cost to probe.
2. Devon keeps the same workload context for each before/after comparison.
   Separate-process or thread-budget diagnostics get their own declared
   scope and preserve this pilot.
3. Native Mac evidence tests the same caller contract on another platform.
   Hosted CI passing establishes build/test/liveness, not quiet speed.

The simpler design remains the default. A new adapter mechanism or library
optimization needs a demonstrated benefit before it enters the candidate.

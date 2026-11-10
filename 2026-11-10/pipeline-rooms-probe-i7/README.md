# A room each or back to back: a probe for the Pipeline's design (i7-12700K, November 10, 2026)

**Question** (BLAKE3 #356): the Pipeline gives a message's bytes rooms of
16 KiB. Today's stream lays short messages back to back in a 2 MiB ring.
What does a room a short message cost?

**How.** Today's stream and its lent call (`next` 013dc63f), 100,000
messages a stream, 41 alternating rounds a layout, medians. A probe of
the layout alone: the Pipeline's own calls and its wait for a room are no
part of it. `room_stride_probe.rs` (devonjonte/BLAKE3
`scratch/devon-room-probe`, 69bff299).

**Verdict: the stride is free; the room memory in rotation is what costs.
Rough magnitudes, one machine.**

- `probe1.stdout.txt` (the first version, `room_stride_probe-first.rs`):
  bytes already in place, 128 rooms (2 MiB) and 1,024 rooms (16 MiB)
  against back to back in 2 MiB: every ratio between x0.974 and x1.020.
- `probe2.stdout.txt`: 4,096 rooms (64 MiB) in rotation against back to
  back. Bytes in place: 64 B x1.054, 256 B x1.072, 1 KiB x1.013, 4 KiB
  x1.031. The program writing each message first: 64 B x1.150, 256 B
  x1.046, **4 KiB x1.496**, and 1 KiB x0.839, which I cannot explain (the
  back-to-back side may suffer there from where its copies land).

The probe's rooms rotate round-robin, so every room is as cold as the
set is large. Machine: i7-12700K (25 MiB shared cache), quiet.

# What the model checkers model (October 23, 2026)

Two one-file programs, run on the i7 with loom 0.7.2 and shuttle 0.8:

- `loom-dekker.rs`: store buffering under SeqCst (each thread stores its
  flag, then loads the other's). Loom reports a schedule where both
  loads read 0: it does not model SeqCst's total order. So the fork's
  Dekker-shaped handshakes (a flag stored, then a count loaded, on each
  side) cannot be checked by Loom as written; the finish handshake was
  rewritten as one word of read-modify-writes, which Loom checks.
- `shuttle-dekker.rs`: the same under Shuttle's PCT scheduler (5,000
  schedules), plus a park/unpark wait: both hold. Shuttle assumes
  sequential consistency, which SeqCst gives on every target the fork
  builds for, and models park and unpark, so it fits the park/wake
  handshake of the pool (BLAKE3 #140), whose shape cannot be one word.

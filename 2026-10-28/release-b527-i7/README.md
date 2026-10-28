# 0.8's version commit b52735e9 (Batch's methods inlined), i7-12700K

**Question:** the Mac found one-thread batches of 2-12 messages +11-21%
slower at e77fc67e (`Batch`'s small methods not inlined); John's fix is
b52735e9. Does the i7 show any cost at b52735e9?

**Commits:** johnservil/BLAKE3 b52735e9 (0.8.0+8abaf0c7), bench 0.18.3
nested; old 83d59db2 with bench 0.18.1 (the old API).

**Commands:** `run.sh`: `check --against 83d59db2 --old-bench 2c9633ae
--cells all`, then the Mac's six cells, 24 pairs, A/B (`ab/`) and old
against old (`aa/`); `probe.py`: warm `hash_many` over COUNT 64 B messages,
the old API against `Batch::from_blocks` built every call, P core 2.

**Verdict:** no cost.
- The check: no cell slower in either stage.
- After other work, ManyMessages 2-12 read x1.005-1.044 (A/A x0.996-1.051).
- After a pause, IdleManyMessages 2 read x1.118 slower, against A/A
  x0.883: a cell whose same-code spread is as large as the reading.
- Warm, every count runs exactly 2 more instructions a call (the
  every-build length check), and cycles are level (x0.986-1.024).

**Posted:** BLAKE3 #125.

# One 1 MiB message, seven ways, i7-12700K

**Question** (Zooko, October 24): do the performance APIs go faster than
`convenience::hash` on a 1 MiB input, and does the Hasher fed in chunks?

**Code:** devonjonte/BLAKE3 `api/two-kinds` 56d4053; `main.rs` here: one
1 MiB message in aligned Blocks, hashed seven ways in rotating order each
round (40 rounds, 32 calls a sample); `initialize_multithreaded(None)`, 20
threads; the machine quiet (load 0.3). Wall time only, a diagnostic outside
bench-hashes; raw samples in `run1.stdout.txt`.

| way | GB/s | against performance::hash_multithreaded |
|---|---|---|
| Hasher::update_multithreaded, the whole input | 36.1 | x1.12 |
| performance::hash_multithreaded | 32.4 | x1.00 |
| Hasher::update_multithreaded, 512 KiB pieces | 28.8 | x0.89 |
| convenience::hash | 5.4 | x0.17 |
| Hasher::update, 64 KiB pieces | 5.2 | x0.16 |
| Hasher::update_multithreaded, 64 KiB pieces | 5.2 | x0.16 |
| Hasher::update, 16 KiB pieces | 5.1 | x0.16 |

**Reading:** the performance API's gain at 1 MiB is the other cores (about
x6 here). A Hasher fed pieces under 512 KiB stays on one thread even with
`update_multithreaded` (each call decides on its own piece), about 4% under
the one-shot. The whole-input Hasher's x1.12 over the one-shot conflicts
with the dedicated alternating pairs of `2026-10-24/hasher-vs-oneshot-i7`
(level; 1 MiB about 1% slower), and the two ways' samples overlap widely
(24-39 and 23-35 GB/s): unresolved, not a finding.

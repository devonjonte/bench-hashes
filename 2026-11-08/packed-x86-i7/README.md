# Packed<32> and Packed<16> Merkle trees on x86-64 (i7-12700K, November 8, 2026)

Question (BLAKE3 #294): what does today's x86 path for packed 16- and 32-byte
leaves cost, and where would a packed kernel's win come from?

bench next 3f999e83 against BLAKE3-Servil next 597581e9, one quick run (4 rounds,
CPU 2), the Merkle cells over packed leaves, ns per byte of leaves:

| tree | servil st | official | SHA-256 ring |
|---|---|---|---|
| 65536 x 32 B | 1.750 | 1.805 | 5.222 |
| 1048576 x 32 B | 1.786 | 2.126 | 5.510 |
| 1048576 x 16 B | 3.514 | 3.633 | 10.535 |

perf, servil st, 1048576 x 32 B: 60% in `sse41_chunk_root` and 6% in
`chunk_root_partial` (the leaves), 20% in `hash_many_avx2` (the parents), 6% in
memmove. On x86 `hash_run_short` has no NEON plans and hashes each packed leaf
alone (`hash_serial_on`), so a leaf compression costs about 3.3 times a parent's
in the 8-lane kernel. Leaves at the parents' cost would take the tree from
about 1.79 to about 0.95 ns/B (about 1.9x), about 2.2x official.

— Devon Jonte

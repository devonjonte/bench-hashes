# The 0.8 CHANGELOG's speed table

**Inputs:** the four full runs John named on BLAKE3 #125 (October 27,
23:22), each bench 0.18.1 at 2c9633ae, BLAKE3 servil 934dee89, with
official BLAKE3 in both its forms: the i7-12700K
(`../release-08-i7/full-0.18.1`), the EPYC 9255 (samshackleton-tech
bench-hashes `data/2026-10-27/release-0.8-x86`,
`release-0.8-epyc9255/full-0.18.1`), the M4 Max and its VM (johnservil
bench-hashes `data/2026-10-27/release-0.8-arm`, `release-0.8-m4` and
`release-0.8-vm`, `full-0.18.1`), each beside its release b3sum run.
Copies in `results/`.

**Commands:** `bench-hashes overview index.html results` (bench 0.18.1;
`text.txt` is its text), then `python3 table.py index.html` reads the
overview's cells: one-thread rows compare one-thread forms; official is
called as a program normally calls it, on one thread, but for one large
message on its thread pool; b3sum against official's b3sum.

**Output:** `table.md`, the table in the CHANGELOG (BLAKE3 PR against
`candidate/release-0.8`).

**Posted:** BLAKE3 #125.

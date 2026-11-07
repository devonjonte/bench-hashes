# The Hasher as a convenience call (BLAKE3 #279, db3cab99) on the i7-12700K

Bench #143 (f24b6f4d, the new names) builds the new side; the bench at next
(415e7df3, the old names) builds the old side, against servil 8d6525c3:
`check --points "interleaved 256,turn 256,idle turn 256,brief idle turn 256,64 B,1 MiB"`.
**No cell slower** in the first stage or the 64-pair second; no level cell's
instructions moved beyond 0.5%. The Hasher's cells read x0.98-1.02. Suites: 180
tests (#279), 132 (bench #143). A change's mutation check: 3 mutants, no new
survivor, 8 s. The 64 B call after other work read x0.81-0.88 on the first
stage's pairs; the change does not touch that path, so read it as the cell's
known state spread, no claim.

— Devon Jonte

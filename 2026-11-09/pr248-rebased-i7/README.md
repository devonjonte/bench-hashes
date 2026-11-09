# #248 (lane rounding) rebased on next 5d966a0c, i7-12700K

**Commits.** 085b89a0 (`candidate/devon-round-up-lanes`, rebased) against next 5d966a0c. bench-hashes 49f45960.

**Gate 1** (`gate1.stdout.txt`, samples not kept): `check --points "3 KiB,7935 B,2304 B,4470 B,16 KiB,64 KiB,1 MiB,idle 3 KiB"`, 4 pairs, then 64 on four suspects. One cell slower: st one message 4470 B +3.3% (64 pairs). Faster: st 3 KiB -9.7%. Instructions moved only at 3 KiB (+9.9%, the rounded lanes' work).

**Gate 2** (`gate2.stdout.txt`, `gate2-runs`): `check --points "4470 B,4 KiB,3839 B,3 KiB" --layouts 16`, then 64 on the suspect. No cell slower: 4470 B x1.007 (5 of 16 pairs faster), 4 KiB x1.042 (5 of 16), 3839 B x1.002; 3 KiB -8.7% (64 pairs).

**Reading.** The 4470 B verdict of gate 1 did not repeat in gate 2. Its instructions are unchanged, so #248 runs the same code at 4470 B, and whatever moved is placement or cold code, not work. 4 KiB leans the same way. Both are recorded on BLAKE3 #248 for John's judgment.

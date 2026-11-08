# The ring fix's cost to the stream at short messages (BLAKE3 #303), i7-12700K

**Question.** The whole-stack gate (4f1dd19c against `next` 7ee5c1f8, `--cells all`) named one slower cell: servil mt ContinuousMessages 128 B, +6.6%. Does it come from the ring fix of #303?

**Runs.** bench-hashes 49f45960 (bench-hashes #157).
- `wholestack-gate.stdout.txt`: `check --new 4f1dd19c --against 7ee5c1f8 --cells all`. One cell slower (mt continuous 128 B +6.6%, 4 of 4 pairs); small-arrival turns -38% to -43%.
- `r303-cont.stdout.txt`: `check --new 40985bbc (#303 head) --against d4f675f4 (its base) --points "continuous 64 B,continuous 128 B,continuous 256 B,continuous 1 KiB,continuous batch 16"`. Two cells slower: mt continuous 64 B +8.2%, 128 B +5.7%, every pair.
- Three 3-pair probes (no verdict) of variants of #303: `ring-cas-probe` (the stream takes the slot with a compare-exchange), `ring-first-probe` (`next` first in the slot), `ring-store-probe` (the hand-back store alone, the stream's check removed). None removes the cost clearly; 3 pairs cannot say more.
- A counting probe (no samples kept): in continuous 64 B the stream never reaches the wait branch, so the cost lies in the hand-back itself.

- `r303-confirm.stdout.txt`: the same comparison at 16 pairs (`--layouts 16`) over continuous 64, 128 and 256 B: three cells slower, mt 64 B +7.8% (16 of 16 pairs), 128 B +3.8% (14 of 16), shared one-cache 64 B +7.8% (14 of 16); 256 B level.

**Verdict.** The ring fix makes BLAKE3-Servil mt's stream about 8% slower at 64 B messages and about 4% at 128 B (16 pairs) on the i7; 256 B and up read level. Posted on BLAKE3 #303 for John's judgment.

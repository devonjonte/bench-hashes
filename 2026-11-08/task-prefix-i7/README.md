# A stream's task enters the ring as its header and the members it holds (BLAKE3 #306), i7-12700K

**Question.** BLAKE3-Servil mt's stream is limited by its producer at short messages. Each task is 1,656 bytes: 64 members of 24 bytes plus a header. The stream built each task fresh (all 64 members written), and push copied all of it into the ring. Does writing less recover the ring fix's cost, and which half earns it?

**Commits.** Old: the ring integration 0df4fa7e. New: `candidate/devon-task-prefix` 859681d9 on devonjonte/BLAKE3 (one commit on 0df4fa7e). Variants for the split: `exp/devon-prefix-d` (both halves, the candidate's first form), `-a` (the task kept, the whole member array copied), `-c` (refilled each task, the used prefix copied). bench-hashes 49f45960.

**Runs and verdicts.**
- `split-probe.stdout.txt`, `split-{d,a,c}-runs`: `check --layouts 8` over continuous 64 B, 128 B, 1 KiB, 4 KiB, 1 MiB; no cell slower for any variant. Keeping the task alone (a): 64 B x0.938, 128 B x0.952, 4 KiB level. Copying the prefix alone (c): 64 B x0.974, 4 KiB x0.925. Both (d): 64 B x0.948, 128 B x0.929, 1 KiB x0.964, 4 KiB x0.910.
- `prefix-final.stdout.txt`: the candidate, `check` (4 pairs, then 64 on the suspect) over 20 points: stream messages 64 B to 16 MiB, batches, git objects, receive, interleaved, small-arrival turn, one message 64 B and 1 MiB. No cell slower.
- `prefix-batch.stdout.txt`: `--layouts 8` on continuous batch 16 and 65536, receive 2 us, continuous 16 KiB. No cell slower; mt 16 KiB -14.0% (8 of 8 pairs), shared one-cache -10.4%.
- `pipeline/`: the `blake3-servil-pipeline` contender, 6 alternating pairs (`ab.sh`): level solo; shared one-cache 2 us x0.953.

- `r88-probe.stdout.txt` (`r88-probe.sh`, `--layouts 8`, continuous 64 B to 16 KiB), on John's return-chain candidate 88e215ed and its base fbfb319f (the code before the ring fix):
  - 88e215ed against fbfb319f: two cells slower, mt 64 B +9.4%, 128 B +6.8% (0 of 8 pairs faster each).
  - 88e215ed with this change (28b18680, `candidate/devon-task-prefix` after the rebase) against fbfb319f: no cell slower; mt 4 KiB -7.3%, 16 KiB -13.4%, shared one-cache 1 KiB -5.8%, 16 KiB -12.6%, every pair; 64 to 256 B level.

Posted on BLAKE3 #306 and #314.

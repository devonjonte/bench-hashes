# check with deleted lines judged on the old side, i7-12700K

**Question:** with bench-hashes `check` fixed to select the cells that ran
a change's deleted lines on the old side, do the stream's member kernels
for 128 B and 256 B (`Task::run_members`' arms, each mutant deleting one)
reach their cells, and are those arms worth their place? Before the fix,
both read "nothing to measure" (`../bench-mutants-i7`).

**Commits:** each mutant on johnservil/BLAKE3 `candidate/release-0.8`
8c34ead, against 8c34ead. Bench: devonjonte/bench-hashes
`candidate/devon-check-deletions` a8883184 merged with
`candidate/devon-stream-batch-lengths` fc418678 (128 B and 512 B on the
continuous axis; the map's CPU lines).

**Command:** `bench_mutants.py` (`run5.sh`, 8 pairs), October 26,
13:55-14:35 UTC.

**Verdict:** each now selects exactly its cell, and each is **slower**
without its arm: 128 B arm, `continuous 128 B` shared +7.7%; 256 B arm,
`continuous 256 B` shared +12.3% (8 pairs each). The arms earn their
place; the fix finds what the new side alone missed.

**Posted:** bench-hashes PRs, BLAKE3 #183.

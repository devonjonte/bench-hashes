# The tree in 0.9's shape against next, every cell, on the rented x86-avx2 machine (November 11, 2026)

**Question** (BLAKE3 #357, step 2): does the two-crate tree in 0.9's shape
(`trial/two-crates-squashed`, dfc2bf2c: the split, the first pipeline
removed, no streaming API exported) make any cell slower than `next`
(0a23cb70) on x86-64?

**Command.** `run.sh`: `bench-hashes check --new origin/trial/two-crates-squashed
--against origin/next --cells all`, bench a55e5149 on both sides, under
the machine's lock.

**Verdict: no cell slower**, in both stages (`stdout.txt`). The machine
gives the account no instruction counts, so the second stage's eight
suspects were wall's alone, on 64 pairs. Three pairs were repeated for a
busy window. Samples in `kept/`.

**Machine.** Two EPYC 7443 (96 threads), AVX2 without AVX-512, Linux
7.0.0-42, governor `performance`; the first check measured there by Devon
Jonte, who measured on the i7-12700K until 0.21.

**Posted.** BLAKE3 #357.

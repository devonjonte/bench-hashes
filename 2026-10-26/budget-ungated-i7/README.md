# The tree-thread budget ungated, against no budget, i7-12700K (Sam's request, BLAKE3 #125)

**Question:** Sam's EPYC found the candidate's tree-thread budget (one
128 KiB piece a thread, at least two) safe enough ungated. What does it
do on the i7, with AVX2 (no wide kernel) and 20 threads on P and E cores?

**Commits:** new, samshackleton-tech/BLAKE3 `experiment/sam-budget-ungated`
7958582 (351c679 with the budget's x86/AVX-512/Linux gate removed); old,
johnservil/BLAKE3 351c679. Bench d21cdf36.

**Commands** (Sam's), under run-bounded.py, October 26, 08:43-09:06 UTC:
`check --against 351c679 --cells all` (`check/`), then `regress
--contenders blake3-servil-mt --points "512 KiB ... merkle 16384" --pairs
16` on the check's relinked builds (`regress/`, `regress-compare.txt`).

**Verdict:** **REGRESSION**, both times.
- check: second stage (16 pairs) judged mt LentMessages 1 MiB SLOWER solo
  (+9.4%) and shared (+13.8%), and mt Collection (Nix files) +13.3%.
- regress, 16 pairs: LentMessages 1 MiB x1.115 solo and x1.123 shared
  (1 and 2 of 16 pairs faster); one-shots 512 KiB x0.966, 1 MiB x1.027,
  2-8 MiB level; after a pause 4-8 MiB x0.96-0.98; Merkle x0.97-0.99.

**Reading:** on the i7 the budget's gains are small (3-4%, level) and
its cost is large at 1 MiB (8 threads of 20): keep it gated to the wide
kernel's machines.

**Posted:** BLAKE3 #125.

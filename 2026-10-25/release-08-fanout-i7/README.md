# The 0.8 integration with FANOUT 8, against `servil` + #164, i7-12700K: no cell slower

**Commits:** new, devonjonte/BLAKE3 `candidate/devon-release-0.8` 612e845
(John's integration with pair.rs, #164's names, #166, and FANOUT 8), bench
d21cdf36; old, `candidate/devon-kernel-names-john` bfbda19 (John's `servil`
with #164, so both sides run servil's own kernels), bench 5be5f236.

**Command:** `bench-hashes check --against bfbda19 --old-bench 5be5f236
--cells all --keep kept` under run-bounded.py, October 25, 21:56 UTC.

**Verdict:** "no cell slower" in both stages. First stage, solo cells:
after a pause (106) median x1.007, 18% above +5%, 13% below -5%; the rest
(198) median x1.001, 8% above, 10% below. Against the same-code controls
(`../aa-idle-i7`: about a tenth of after-a-pause cells above +5% by
chance), the after-a-pause cost stays about 1% at the median, as before
FANOUT.

**Posted:** BLAKE3 #125.

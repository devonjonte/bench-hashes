# The x86 mutation check at the 0.8 tag, i7-12700K

**Commit:** johnservil/BLAKE3 `v0.8.0+b3c5efc7c975d903762dea809066f7c0a0603861`
(b5b988d8), clean checkout.

**Command:** `python3 tools/mutants/check.py` (no `--write`), run-bounded.py,
October 29.

**Verdict:** exit 0: 639 survive, each known and explained; 31 time out,
each known. The x86 list holds at the release on a CPU without AVX-512 (the
EPYC 9255 confirmed the AVX-512 side at b223eab4).

**Posted:** BLAKE3 #125.

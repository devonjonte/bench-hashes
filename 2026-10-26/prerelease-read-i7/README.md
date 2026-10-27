# A pre-release read of 0.8 for bugs and bad docs, i7-12700K

**Question (Zooko, October 26):** anything in 0.8 that could harm a user,
or docs that are broken or wrong, to fix before the release?

**Commit:** johnservil/BLAKE3 `candidate/release-0.8` e7c5ef48; the fixes,
devonjonte/BLAKE3 `candidate/devon-prerelease-fixes` 6fb0f903 (BLAKE3 #190).

**Probes:**
- `fork_probe.rs` (an example, not committed): after
  `initialize_multithreaded(None)` and a 16 MiB hash, `fork()`; in the
  child, `hash_multithreaded`, `Hasher::update_multithreaded` and a stream
  of 256 messages ending in `finish` all give the right digests. A stream
  body waiting by looping on `collect()` got nothing back in 5 s in the
  child; the same loop in the parent returned in 73 us.
- `changelog_names.rs`: every API name in the CHANGELOG's migration notes,
  used once; all exist (the three errors were the probe's own guesses
  at signatures).
- Links: 30 live links in the README, CHANGELOG, QUALITY.md, b3sum and C
  READMEs, ANNOUNCE and the quality manual answer 200; every relative link
  resolves.
- Build stops (cargo check): no C compiler (`CC=/nonexistent/cc`) stopped
  nothing at e7c5ef48 (x86-64 fell back to portable Rust with a hidden
  warning); with the fix it stops; `pure` builds; a compiler refusing the
  AVX-512 flags stops; a normal one builds.

**Gate of the fixes:** `gate.sh` (`gate.stdout.txt`): GATE PASSED.

**Second commit** (fb2cbdaa, Zooko: users never run the portable Rust):
no `pure`; a CPU without SSE4.1 stops at `initialize`; Arm's extended
output on the x4 kernel. `miri.sh`: CI's Miri tests on the default build,
3 of 3 pass. `gate2.stdout.txt`: GATE PASSED. `mutants.sh`: `check.py
--since e7c5ef48`, no new survivor. `xof_probe.rs`: for the Mac, the
speed of 1 to 8 blocks of extended output on both commits.

**Posted:** BLAKE3 #190.

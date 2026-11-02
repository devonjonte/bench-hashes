# probe/l3-pool on a one-L3 machine (i7-12700K, November 2)

**Question** (John, BLAKE3 #196): on a machine with one L3 domain the
probe should read level with `servil`. `check --fork probe/l3-pool@9c25ed9e
--against 09d3bbc6 --cells all`, bench 0.19.7, the fork's one domain
(`/sys/.../index3/shared_cpu_list` 0-19). Command: `run.sh`.

**Verdict:** 3 cells slower, 2444 s. Stage 1 named 8 suspects; at 64
pairs (`second-compare.txt`):
- servil mt shared ContinuousMessages 64 B +5.3% (7 of 64 pairs faster),
  128 B +4.9% (4 of 64), solo 64 B +3.3% (8 of 64), 128 B +3.0%, 16 KiB
  +2.2-2.5%: a cost per publication that shrinks with message length.
- servil mt IdleManyMessages 48 +4.8% (noisy: 20 of 64 faster, pairs
  -17% to +44%), its st twin +3.3% level: the after-pause noise.
- Every servil st cell level (the pool runs none of them).

What the one-domain path adds on a stream's publish and take, against
servil: `pool()` and `domains.count` in `publish`, a `domain` store a
publication, `wake_one` through a `parks` slice and a branch, `find`'s
`mine != EVERY` test. Each is small; a 64 B stream call is about 17 ns
of wall a message over 20 threads, where every load on that path shows.

**Posted:** BLAKE3 #196.

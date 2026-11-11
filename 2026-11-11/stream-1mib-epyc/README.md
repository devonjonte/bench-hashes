# The stream of 1 MiB messages on two EPYC 7443: slower than 0.8, and where (BLAKE3 #368), November 11, 2026

**Question.** 0.21's release check read the multithreaded stream of 1 MiB
messages beside another program 74% slower than 0.8. Which change, and is
it the library's or the bench's (the release check crosses two benches)?

**Answers so far.**
- `first-cut.sh` (`stdout.txt`, 16 pairs): 0.8 -> 27717b3f, one bench:
  1 MiB level, 4 MiB slower (the long ring, BLAKE3 #349). 27717b3f -> the
  pin, two benches: 1 MiB slower.
- `two-benches.sh` (`two.stdout.txt`, 64 pairs each): the pin is slower
  than 27717b3f under bench 3363bee8 (14.8% one cache, 19.1% two caches,
  8.1% alone) and than 86b11263, the same code renamed, under bench
  8a153ce2 (34.2%, 11.8%, 9.8%). **The library's**, between 86b11263 and
  2037118c; the size loosely known.
- **The cause is not located.** `bisect.py` (`log.txt`, `step-*`) named
  3ab4584a; `confirm.sh` (that commit against its parent, one bench, 16
  pairs) read no cell slower. The bisect compared two benches at every
  step on cells whose pairs spread from -32% to +166%; its answer is
  wrong. `wall.sh` (16 pairs) gave a hint toward the bench that the
  64-pair runs did not bear out.

**Next.** A bisect with one bench on both sides of each step, 64 pairs.

**Machine.** Two EPYC 7443, 96 threads, Linux 7.0.0-42, `performance`.
**Posted.** BLAKE3 #368.

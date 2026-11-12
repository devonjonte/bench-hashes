# The two-crate library on next against 0.8, every cell, four x86-64 machines, November 12, 2026

**Question** (BLAKE3 #357, step 3): is any cell of `next` (c10d6804, the
two crates) slower than 0.8 (b5b988d8)?

**Command.** Each folder's `run.sh`: `bench-hashes check --new c10d6804
--against b5b988d8 --old-bench 3363bee8 --cells all`, bench next 774a6b63,
under the machine's lock. Both contenders, so the first stage alone ran
(a first stage with a slower cell names no suspects).

| machine | slower: multithreaded continuous cells (0.8's stream) | slower: any other | faster |
|---|---|---|---|
| EPYC 9275F | 18 | none | 29 |
| Ryzen 9700X | 43 | one at four pairs: single-threaded 4 MiB after a pause, +4.0% | 24 |
| EPYC 9255 | 25 | none | 28 |
| two Xeon Gold 6330 | 66 | none | 26 |

The 9700X's one other cell, by name with its neighbours (`idle.sh`,
`idle.stdout.txt`): no cell slower.

The multithreaded continuous cells compare two different calls: 0.8's
bench called the stream there, and today's makes one-shot calls, since
the library has no stream. Messages one after another take 1.2 to 25
times 0.8's time across these machines, batches 1.2 to 2.9 times.

**Next.** The checks that reach a second stage: the single-threaded
contender alone (`check --contenders blake3-servil-st`, the core's gate),
and the multithreaded one over the points that are not continuous.

**Posted.** BLAKE3 #357.

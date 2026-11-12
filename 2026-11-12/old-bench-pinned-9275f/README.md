# Checks across two benches ran unpinned: the cause of most "slower than 0.8" cells (EPYC 9275F), November 12, 2026

**Question.** The core's gate (next c10d6804 against 0.8, the
single-threaded contender, every cell) read five cells 3.2 to 6.5% slower
on this machine over 64 pairs: one message after other work, 2304 B to
32 KiB. The library's, the bench's, or the measurement's?

**Answer: the measurement's.** `check --old-bench` passed `--unpinned`
to `regress`, so each run's measuring thread went wherever the OS put
it, and these cells swing with the core (METHODOLOGY, "Each pair on one
core"). Pinned, they read level.

| folder | what | result |
|---|---|---|
| `core-gate-iso` 1 | next against the 0.21 pin (2037118c), one bench | no cell slower: the library is cleared |
| `core-gate-iso` 2 | today's bench against the 0.21 tag's, one library, unpinned | seven cells 11.9 to 21.4% slower (four pairs, each pair alike) |
| `bench-bisect` | today's bench against four later bench commits, one library, unpinned | each level; so the tag's alone differed, by one changed line no cell runs (on the i7 the two builds differ in one function, regress's own) |
| `sessions` | today against the tag, and against the tag's next commit (4bef90cc), three sessions each, unpinned | verdicts: level, one cell 11.3% faster, level, level, level, level; a side's 4 KiB median from 0.549 to 0.675 ns/B across these and the two rows above; in one "level" session the sides' medians differ by 22% |
| `sessions-pinned` | the same six sessions under the candidate that pins | no cell slower or faster in any; 4 KiB 0.581 to 0.645 ns/B |
| `sessions-pinned` gate | next against 0.8 (its bench 3363bee8), the gate's seven cells by name, pinned | no cell slower; 3 KiB 27.6% faster. 0.8's bench takes the pin |

**Fix.** bench-hashes #196 (`next` 77d4a765): a check across two benches
pins its pairs as every check does; `--unpinned` is an option.

**What it bears on.** Every release check against 0.8 so far ran
unpinned: 0.21's on every machine, BLAKE3 #369's two cells, the gates of
November 12. Their cells after a gap are to be read again pinned.

**Machine.** EPYC 9275F, 48 threads, Linux 7.0.0-42.
**Posted.** BLAKE3 #357, #369; bench-hashes #192, #196.

# Why does a ring word a task cost the 64 B stream 5 to 7%? One hour on the i7-12700K, November 10, 2026

**Question.** In `../../2026-11-09/task-places-i7/` (step 2), the stream's
tasks lived in places named by a ring of words, and the multithreaded
stream of 64 B messages ran about 7% slower than with the tasks in the
ring itself. Which mechanism costs that time?

**Verdict: unanswered, with three causes excluded and one lean.** The
hour was the budget. The measured cost stands (5 to 7% here, again).

| | new side | ns/B, base → new | P-core cycles | instructions | L1D load misses |
|---|---|---|---|---|---|
| `stat1` | 43836b15, the experiment as it was | 0.288 → 0.308 (x1.068) | x1.070 | x0.960 | x1.087 |
| `stat2-own-line` | f7434089: each ring word on a cache line of its own | 0.291 → 0.313 (x1.076) | x1.073 | x0.971 | x1.090 |
| `stat3-count-own-line` | e469b30e: the experiment's place counter on a line of its own | 0.293 → 0.308 (x1.051) | x1.051 | x0.961 | x1.057 |
| `stat4-word-unused` | 3f9c1553: the word still stored and loaded, the task addressed by its number as in the base | 0.292 → 0.300 (x1.027) | x1.099 | x0.978 | x1.129 |

Base: c7936a5f. Each figure is the median of six alternating runs of the
one cell under `perf stat` (`stat.py`); ns/B is the result file's first
64 B row. Six runs give leans, and the new side's 0.308, 0.313, 0.308
agree with each other more closely than the three ratios do.

**What is known.**
- The time goes to stalls: 4% fewer instructions, 5 to 7% more cycles.
- The extra L1D misses sit in the worker's claim loop, `Pool::serve`
  (4.48 M → 7.59 M a run; `misses-by-function-*.txt`), and hardly at all
  in the publisher.

**Excluded, each by a test.**
1. *Neighbouring ring words share a line, which bounces between the
   publisher's next store and the claimers' loads.* With every word on
   its own line the cost is the same (`stat2`).
2. *The publisher's every-build check reads `claimed`.* The base's `push`
   has the same read.
3. *False sharing with `lanes::sources::ACTIVE`.* The experiment's
   `static COUNT`, written at every task, was linked onto the line of
   `ACTIVE`, which every polling worker reads (`statics-*.txt`); its two
   loads were the hottest missing loads in the loop
   (`serve-hot-loads-new.txt`). Moving `COUNT` alone removed about a
   third of the extra misses and left the time where it was (`stat3`):
   those misses fell in idle polls, where a waiting worker loses nothing.
   So step 2 of the earlier study had a confound, and it did not change
   that study's conclusion.

**A lean, from the last test (`stat4`).** With the word still written at
each publication and read before each claim, and the task found by its
number as in the base, the cell reads 0.300 ns/B: between the base's
0.288 to 0.293 and the experiment's 0.308 to 0.313. So the word's own
traffic and following it to the task may each carry part of the cost.
Six runs a side cannot say how much: the three runs of the same
comparison above range from x1.051 to x1.076. That experiment has
BLAKE3 #302's race again (its two controls fail), so it is a
measurement only.

**Left to test,** if the question earns more time: the same four
executables over 32 pairs with `bench-hashes check`, so the split has a
verdict.

**A by-product.** `ACTIVE` shares its cache line with whatever the linker
puts beside it: in these executables, the bench's own statics. Here that
cost no measurable time, so no change is proposed.

**Branches** (fork devonjonte/BLAKE3): `exp/devon-places-in-order`
43836b15, `exp/devon-places-own-line-words` f7434089,
`exp/devon-places-count-own-line` e469b30e,
`exp/devon-places-word-unused` 3f9c1553. Bench: 0bb31ed5, built with
`build-against`. Machine: i7-12700K, Linux, quiet.

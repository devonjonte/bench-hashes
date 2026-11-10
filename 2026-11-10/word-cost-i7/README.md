# Why does a ring word a task cost the 64 B stream 5 to 7%? One hour on the i7-12700K, November 10, 2026

**Question.** In `../../2026-11-09/task-places-i7/` (step 2), the stream's
tasks lived in places named by a ring of words, and the multithreaded
stream of 64 B messages ran about 7% slower than with the tasks in the
ring itself. Which mechanism costs that time?

**Verdict: narrowed, not closed.** Over 32 pairs the cost is 4 to 8%,
and it stays when the word is stored and loaded but never followed. Three
causes are excluded by test. The hour was the budget.

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

## The verdicts: 32 pairs each (`pairs.stdout.txt`, samples in `pairs-*/`)

`bench-hashes check --layouts 32 --points "continuous 64 B"`, each new
side against the base c7936a5f (`pairs.sh`):

| new side | solo | shared, one cache |
|---|---|---|
| 43836b15: the experiment as it was, the word used | **+6.6% slower** | **+8.3% slower** |
| e469b30e: its counter moved off the workers' line | **+4.8% slower** | **+8.1% slower** |
| 3f9c1553: the word stored and loaded, but unused | **+4.3% slower** | **+7.5% slower** |

**What they say.** The cost stays when the word is no longer followed to
the task (the third row finds the task by its number, as the base does).
So following the word is a small part at most. What remains is common to
all three: the word's store at each publication and its load before each
claim, or the code shape those bring (a separate array of places beside
the ring, the claim loop's extra load).

**The six-run figures above understated the third row** (0.300 ns/B, a
lean of x1.027): over 32 pairs it is +4.3% and +7.5%. Leans from a few
runs mislead here; the pairs are the result.

**The one test left,** if the question earns more time: 43836b15 with the
word's store and load both deleted and everything else kept. Level with
the base would name the word's traffic; still slower would name the code
shape. About 18 minutes on the i7.

**A by-product.** `ACTIVE` shares its cache line with whatever the linker
puts beside it: in these executables, the bench's own statics. Here that
cost no measurable time, so no change is proposed.

**Branches** (fork devonjonte/BLAKE3): `exp/devon-places-in-order`
43836b15, `exp/devon-places-own-line-words` f7434089,
`exp/devon-places-count-own-line` e469b30e,
`exp/devon-places-word-unused` 3f9c1553. Bench: 0bb31ed5, built with
`build-against`. Machine: i7-12700K, Linux, quiet.

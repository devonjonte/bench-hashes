# Benchmarking the mutants the survivor lists call speed-only, i7-12700K (a first, by hand)

**Question (Zooko, October 26):** a survivor whose reason says "speed" or
"equally correct paths" claims something a benchmark can test. Applied
alone, does the mutant make a cell slower (the path earns its place),
leave every cell level (a candidate to delete), make one faster (an
improvement), or touch no cell at all (code no benchmark measures)?

**Commits:** each mutant (`*/mutant.diff`, from `cargo mutants --list
--json --diff`) applied to johnservil/BLAKE3 `candidate/release-0.8`
f448bb3, against f448bb3 itself; bench d21cdf36.

**Command:** `bench_mutants.py` (in this folder), one mutant at a time:
`bench-hashes check --against f448bb3 --pairs 8` from a worktree holding
the mutant, over the cells that execute its changed lines. `run2`: the
one that read faster, again at 23 pairs. October 26, 06:55-08:40 UTC.

**Verdicts** (`results-run1.tsv`; the first stage, `*/stage1.txt`):

| mutant | verdict | reading |
|---|---|---|
| `Task::run_members`: delete the 128, 256, 512 and CHUNK_LEN arms | **no cell runs it** | stream batches of 128 B to 1 KiB messages: no benchmark cell measures these specializations |
| `Platform::xof_many`: delete `!` | **no cell runs it** | |
| `sources::open` → false (workers never spin while a stream is open) | **slower**: stream cells +6% to +16% | the spin earns its place |
| `Hasher::held_group` → None (no held-group staging) | 8 pairs: shared and solo Interleaved x0.89-0.92; **23 pairs (run2): solo x1.03, shared x0.93, turns level** | a trade on the i7, not a waste; the 8-pair reading did not hold. SME2 (the Mac) is where it was designed to pay |
| `hasher::Feed::subtree_cv`, `HasherHooks::subtree_cv`, `PlatformKernels::subtree` → None | level | SME2's flat subtree hooks: the Mac decides |
| `poll_pause` → () | level | its reason is a two-CPU machine (29 us to 2 ms), which the i7 cannot show |

**Reading:** of eleven "speed-only" claims, one is now measured
(`sources::open`), five name code no benchmark runs (a gap to close by
a benchmark or by deleting the code: Zooko's call, FROZEN.md), and the
rest need the machine their reason names. An 8-pair first stage misled
once, as it has before: a "faster" needs 23 pairs.

**Posted:** BLAKE3 (the issue on automating this).

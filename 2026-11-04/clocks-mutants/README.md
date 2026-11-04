# Mutation tests over the measurement core, and the split of the tests (November 4, 2026)

Question (Zooko): can the load-sensitive clock tests give way to deterministic
ones, so a mutants run reports what the tests pin and runs fast?

`cargo mutants --test-tool nextest -p clocks` over lib.rs, linux_counts.rs,
load.rs, child.rs, energy.rs (546-570 mutants as the code grew), on the i7-12700K.

| run | bench | suite | time | caught | missed | note |
|---|---|---|---|---|---|---|
| round1 | 48821904 | all tests, -j 3 | 24 min | 469 | 40 | 9 of the "caught" were a load-sensitive test failing beside the mutant |
| round3/4 | be056820..a23cb443 | the code's suite alone, -j 3 | 4-5 min | 238→310 | 153→203 | the machine's tests moved to `mod machine` (nextest profile `machine`) |
| machine | a23cb443 | `-P machine`, -j 1 | 69 min | 162 | 145 | the platform code, judged by the machine's tests alone |
| round5 + machine2 | 99a4cd28 | both | 5 + 53 min | **479** (union) | **57** | 29 of the 57 are macOS-only code (a Mac's run); 28 reachable here, listed in union2-missed.txt |

The 28 reachable survivors at 99a4cd28: equivalent mutants (`|`→`^` on
disjoint bits, `<`→`<=` in busy_work, a pinned flag off, a leaked page),
two test helpers, three fixed by 12422f63 (an overdue tick, the average's
rounding, Counts::read in the machine test), /proc scanning's kernel-thread
filter and a busy window's report string (left).

What changed in the code for this (commits be056820..12422f63 on
candidate/devon-raw-clock): clocks::test_clock; the machine's tests apart;
pure functions with fixed-input tests for every piece of arithmetic the
machine tests had covered loosely; the machine profile requiring counts
and energy where the kernel offers them (the "counts unavailable" mutants
had passed every test).

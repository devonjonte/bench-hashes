# The topology pool's slower one-shot means are six calls in twenty-four

November 16, 2026. For [BLAKE3 #401](https://github.com/servil-software-factory/BLAKE3/issues/401).

**Question.** The 0.23 release check read the every-core form's large one-shot cells
slower on the two EPYCs whose cores span three L3 caches, and a repeat by name
isolated the cache-topology pool (`3ec37f0e` against its parent `6e498a96`). Is the
slower mean every call, or some calls? And do the slow calls follow the other points
in the schedule?

**What the kept runs already show** (`patterns.txt`, first two blocks; the runs are
in [`release-023/`](../release-023/README.md)). `topology_pattern.py` prints each
run's 24 samples of a cell in the order taken, `S` for a sample above 1.3 times the
run's lower-quartile sample:

```
parent    mt|solo|OneMessage|128 MiB      ........................   (every run, both machines)
3ec37f0e  mt|solo|OneMessage|32 MiB       .SSS.....SSS............
3ec37f0e  mt|solo|OneMessage|128 MiB      .SSS.....SSS............
3ec37f0e  mt|solo|IdleOneMessage|128 MiB  .......SSS..............
3ec37f0e  mt|solo|BriefIdleOneMessage     SSS.....................
```

- **The same positions in all four runs, on both machines**, with the caller on
  different CPUs.
- **The slow samples take ×1.71 to ×1.88 on the EPYC 9275F and ×1.32 to ×1.43 on
  the EPYC 9255**; the other eighteen take the parent's time, and the medians are
  equal. Six samples of 24 at ×1.78 give the +19.5% mean the check reported.
- The shared one-cache `lent 64 MiB` cell also reads slow in some samples, at
  positions that vary by run.

**The schedule experiment** (`topology-history.sh`, quiet, under the machine's
lock): the same two commits, the every-core form only, three schedules: 128 MiB
alone; 32, 64 and 128 MiB; those three with 256 B and 2304 B.

- **Every schedule keeps the positions.** On both machines, in all four runs of
  each schedule, every large size shows `.SSS.....SSS............`: 128 MiB
  measured alone, and 32, 64 and 128 MiB together or beside small points. (In the
  fourteen-point schedule 64 MiB was slow at samples 12 and 13.) Slow samples take
  ×1.72 to ×1.82 on the 9275F and ×1.31 to ×1.39 on the 9255, and the check reads
  each large cell slower in every schedule (`arms.txt`).
- **The parent shows no slow sample** in any run of any schedule.
- **Alone, the process does nothing else:** 24 calls about 24 ms apart, each after
  the harness's busy gap. Calls 2 to 4 and 10 to 12 are the slow ones.
- **Spreading the same 24 samples over ten times as many rounds moves them**
  (`topology-long-401`, one plain run per commit on the 9275F): four slow samples,
  at positions 6, 7, 22 and 23; the parent again has none.

**Reading.** The slow calls recur at the same places whenever the process runs the
same sequence of rounds, whatever other points the schedule holds, and a different
spacing of the same calls moves them. That fits a state the pool keeps and changes
by its own count of calls and by time. A narrower reach in steady state would slow
every call, and most calls here take the parent's time. What the state is, and
what a long-lived caller meets later, is John's to say from the code.

**Limits.** 24 samples a cell is all a check takes, so later calls are unmeasured.
The multithreaded cells record the calling thread's counters only (`topology_caller.py`),
so the number of busy cores in a slow call is unmeasured. The marks are a reading aid
with a fixed threshold; the verdicts are the check's own.

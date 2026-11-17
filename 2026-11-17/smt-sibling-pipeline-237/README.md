# Does a worker on the caller's SMT sibling slow the Pipeline's caller? (BLAKE3 #237)

November 17, 2026. Devon Jonte. For [BLAKE3 #237](https://github.com/servil-software-factory/BLAKE3/issues/237).

**Question.** #237 found that the old stream's caller copied messages about 20% slower in processes where a worker ran on the caller's SMT sibling. The stream is gone. Does the `Pipeline`'s caller, copying into rooms, meet the same?

**Verdict: yes.** On the EPYC 9255 the caller hashes about 36,600 messages a second with a worker busy on its sibling, and about 42,500 without: 14% fewer. Which of the two a process gets is settled as it starts.

**The probe** (`x86-epyc-9255/source/`, job `x86-epyc-9255/run.sh`, declared in its header before it ran). One caller pinned to CPU 0 copies 1 MiB messages into rooms, 8 in flight, 2 s a process; the library at `next` `a12a4d3503090ba3f35118e927acdb9130a1948e`. Each process prints its messages a second and, for every thread, the CPU it last ran on and its CPU time. 20 processes an arm, the arms in turn. CPU 0's sibling is CPU 24; CPUs 0-5 and 24-29 share one L3.

| arm (the CPUs the process may use) | processes | median messages/s | lowest | highest |
|---|---|---|---|---|
| with: 0-5, 24-28 (the sibling included) | 20 | 36,760 | 36,337 | 42,646 |
| without: 0-5, 25-29 (the sibling left out) | 20 | 42,505 | 42,151 | 42,782 |
| sam: 0-5, 24-29 (#237's own set) | 20 | 42,195 | 36,474 | 42,732 |

The first two arms have the same threads: a caller and 10 workers. Their medians' ratio is 0.865.

**Two levels, and the sibling decides.** Over the 40 processes of the two arms that include the sibling:

| a process's messages/s | processes | a worker last on CPU 24 with 1 s or more of CPU time | none, or under 1 s |
|---|---|---|---|
| under 38,500 | 18 | 18 | 0 |
| 38,500 to 41,000 | 2 | 1 | 1 |
| 41,000 or more | 20 | 0 | 20 |

**Limits.** One machine, one message size, one caller, a caller that never waits for input. "Last ran on" is where a thread was at the process's end; the CPU time beside it is the thread's whole. The effect's size on other machines and for callers that do other work is unmeasured.

`reading.txt` is `read.py`'s output on `x86-epyc-9255/runs.txt`. No binaries. Both manifests bind this folder, themselves excluded.

# Where next's ring-fix cost begins (BLAKE3 #306), i7-12700K

**Question.** The ring fix makes servil mt's stream about 8% slower at 64 B on `next` and costs nothing on `main` (ring-main-i7). Which change on `next` makes the difference?

**Method.** The fix applied to a commit, compared with that commit unfixed: `check --points "continuous 64 B,continuous 128 B" --layouts 6`. Each commit is measured with a bench speaking its API (bench-hashes 5c1a092f, a3e8ffa3, 1a7db178; `bis.sh`, `bis2.sh`). Main's version of the fix (b4989d6c) goes on commits before af5d5224; next's (cef8741e) on later ones.

| Commit | 64 B | 128 B |
|---|---|---|
| main 6e0dffd3 (ring-main-i7) | x0.993 level | x0.978 level |
| 149707e1 | x0.960 level | x0.948 level |
| 6fc30a3d | x1.006 level | x0.989 level |
| **85bf73a6** "The producer helps where no worker takes a task" | **x1.070 slower** (0 of 6 faster) | **x1.033 slower** |
| 4eda049c | x1.116 slower | x1.058 slower |
| next 0df4fa7e (task-prefix-i7, earlier) | +8% | +4% |

5b49ec22 does not compile (mid-series). Two controls on main and next: next's task size on main (`rmain-action`, an unused `action` field), level; the room check in debug builds alone on next (`rda`), still slower.

**Two tests of the reading** (`bis3.sh`; 85bf73a6 with the fix and a probe, against 85bf73a6 unfixed, `--layouts 6`):
- `take_task` forced inline (`exp/bis85-inline`; `symbols-85bf73a6-inline.txt` shows no `take_task` of its own): 64 B **x1.084 slower**, 128 B x1.054 slower, 0 of 6 pairs faster. The outlining is not the cause.
- #314's change on top (`exp/bis85-prefix`): 64 B x1.035 (judged level, 0 of 6 pairs faster), 128 B x1.001. Copying fewer bytes recovers most of the cost here, and all of it on next (task-prefix-i7).

**Reading.** The fix's cost depends on code around it that the stream never runs. It begins at 85bf73a6, which adds `Source::help` for the pipeline. Its cause is not located: the outlining of `take_task` that 85bf73a6 brings is ruled out. It lies in the task copies' cost, since writing fewer bytes removes most of it. Posted on BLAKE3 #306.

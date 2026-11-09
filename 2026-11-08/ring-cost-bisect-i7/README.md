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

**Reading.** 85bf73a6 adds `Source::help`, the pipeline's own help, and nothing on the stream's path. In the bench built at 85bf73a6, `Source::take_task` is a function of its own (`symbols-85bf73a6.txt`, 0x1a4 bytes); at 6fc30a3d it is inlined everywhere. So the cost comes from code generation around the 1,656-byte task's copies, not from the protocol. BLAKE3 #314 (fewer bytes copied) removes it on the i7.

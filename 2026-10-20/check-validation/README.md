# Validating `bench-hashes check` (bench-hashes #53)

`bench-hashes check` on the fork at f69d4ba (Devon Jonte's servil line),
i7-12700K, quiet, each a change in the working tree against HEAD:

| run | change | cells chosen | verdict | time |
|---|---|---|---|---|
| check2 | a line inside `Stream::submit_with` | 13 pipelined points | no cell slower | 6 min |
| check3 | `hash()` repeats a call when a 6%-a-call debt reaches one call | 73 points | 64 slower, none of servil mt | 15 min |
| check4 | `hash()` hashes its first 6% again (one block at least) | 73 points | 60 slower (+1% to +114%), none of servil mt | 14 min |
| check5 | `hash()` with the plant's line doing nothing (A/A) | 73 points | **no cell slower** (146 cells) | 14 min |
| check6 | the pool's split path (`lanes::hash_with_key`, 512 KiB up) hashes its first 6% again | 24 points | **28 slower**, every one servil mt at 512 KiB or more, after a gap among them | 10 min |

check6 is the case the fixed five-cell list (`REGRESS_POINTS`) could not
have seen in its cells after a gap, where #80's +18% was. A comment-only
change chose no cell and measured nothing (2 min, the coverage recording).

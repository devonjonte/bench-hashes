# bench-hashes 0.19 candidate 99eefde3: Devon's review runs (i7-12700K, October 31)

**Question.** bench-hashes #98: does the 0.19 candidate's `check` stay
quiet on identical code, catch the two plants and a real slowdown, read
load right, and serve cached sizes? The bench at
`99eefde3ebb6c9135a51336c46e823153a6a714d`; the fork's commits as below.

| run | command (`check --fork F ...`) | verdict | time |
|---|---|---|---|
| `aa` | F at 0.8 b5b988d8, `--against b5b988d8 --cells all` | no cell slower | 1551 s |
| `spin0` | F at plant/spin0 b894ae70, `--against b5b988d8` | every point measured; no cell slower (servil mt streams +4% to +8%, judged level, none a suspect) | 1914 s |
| `hash6` | F at plant/hash6 e4d32b61, `--against b5b988d8` | 85 cells slower (16 of them owned copies of lent cells) | 522 s |
| `known119-1`, `-2` | F at c21f58f3 (#119's cold cost), `--against a88ba52a` (its fix) | no cell slower, twice | 1868 s, 886 s |

`light/`: `light.sh`: the calibration cache (the second run's sizes came
from it), a user-time spinner beside a run (busy, 1.09 CPUs), and `dd
if=/dev/zero of=/dev/null` beside one (a whole CPU of system time; quiet,
0.08 CPUs). `dd-ab/`: `dd-ab.sh`, 6 alternating pairs quiet against beside
dd, all 12 runs quiet; `compare` in `ddab.stdout.txt`: servil mt
OneMessage 64 KiB x1.044 slower, its solo 1 MiB stream x1.061 (0 of 6
pairs faster), the streams' energy x1.11 to x1.44.

**Posted:** bench-hashes #98.

# Shared LentMessages 64 B against the duo threads' stack offset, i7-12700K

**Question** (Sam Shackleton, johnservil/bench-hashes #65): does the
shared 64 B cell's 4 KiB-aliasing bistability, 35–45% on the EPYC 9255,
show on Intel P- and E-cores, and how large is it?

**Binary.** The ordinary release build of bench-hashes 0.17.0
(7cd8ba3e) with its pinned contender, servil 082afa3; not relinked by
`check`. SHA-256 1c6b981f... (the binary itself is kept out of the
record).

**Commands.** `sweep.sh`: `GLIBC_TUNABLES=glibc.rtld.optional_static_tls=S
taskset -c CORES bench-hashes --contenders blake3-servil-st --points
'lent 64 B' --for-regression-check --rounds 96`, S from 448 to 4480 in
steps of 64 (one 4 KiB cycle), CORES 0-15 (P) and 16-19 (E). `sweep16.sh`:
the same on P cores in steps of 16. `confirm.sh`: three repeats of
3952–4080 and of 1008–1136, steps of 16. Columns: cores or repeat,
S, solo ns/B, shared ns/B. Machine otherwise idle; one job at a time.

**Verdict.**
- P cores: yes, smaller. Shared 64 B is 0.80 ns/B at S = 3984–4032 in
  every repeat (one 0.89), against 0.733 in the quiet window: about +9%.
  The neighbours 3952–3968 and 4048–4080 sit at 0.75–0.77 (+3–5%). Solo,
  on the main thread, stays at 0.73 throughout.
- E cores: nothing above noise at steps of 64 (shared 1.19–1.24 ns/B,
  isolated high readings that did not recur); steps of 16 not swept.

**Sam's offset_check.py on the i7** (samshackleton-tech/BLAKE3
8b25ac65, on servil 2e892e1; `offset-check-*`): exit 3 both with
`--coarse` (128-byte steps) and by default (64): "no control cell was
judged sensitive". Its scan steps over the i7's 48-byte window, and its
screen (worst above 1.10 times the median) sits just above the i7's
+9–11%, so the cells it confirmed were noise, each judged level.

**The same window at servil 2e892e1** (`sweep16-tip`, the binary the
tool built, SHA-256 a4f175b8...): shared 0.800–0.807 ns/B at S =
3984–4032 again, so the window held across the two builds.

**An unexplained solo episode.** Through all of `sweep16-tip` (257 runs,
about ten minutes) solo 64 B read 0.97–1.07 ns/B against 0.72–0.74 in
every other run before and after, at a P core's full clock (core counts:
4.9 GHz, 4.8 cycles a byte against 3.5). The main thread's stack through
a page (`sweep-main`, environment size in steps of 16) shows 16-byte
slow spots at three offsets for that build (to 0.95) and none for the
release build; re-running the sweep's own script, directories and
settings did not bring the episode back. Recorded, not attributed.

`summarize.py` reads the sweeps.

**A patch to offset_check.py** (devonjonte/BLAKE3
`candidate/devon-offset-check` 9145354; `patched/`). Three causes of
its blindness here, each fixed:
- steps of 64 jump over the 48-byte window: steps of 16;
- a 10% screen sits above a 9% effect: each cell's three worst offsets
  rescanned twice, ranked by the lowest of three readings;
- four pairs cannot clear Benjamini-Hochberg over 16 cells: in
  `patched/confirm-4-pairs` the slow offset ran 0.81-0.86 ns/B against
  0.71-0.77 in every one of four pairs (`run_means.py`), and regress
  judged it level. Confirmations now run eight pairs.
Main-thread offsets are left out: regress's command line differs from
the scan's, so a main-stack offset lands elsewhere when confirmed.
`repeat.py`: 5 of 8 runs exit 0 with three candidates a cell
(`patched/three-candidates`); `misses.py` shows why: a single quick
reading strays as high as the window reads, which ranked 1st to 10th of
256. With ten candidates a cell (`4f3e033`, `patched/ten-candidates`):
**8 of 8 runs exit 0**, about 97 s each, no batch cell judged sensitive;
shared lent 64 B found at +3472..+3520 in 7 runs, shared continuous 64 B
at +912..+960 in 6.

**Posted.** johnservil/bench-hashes #65.

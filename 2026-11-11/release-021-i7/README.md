# bench-hashes 0.21's release runs on the i7-12700K, at the tag (November 10-11, 2026)

**Question.** CONTRIBUTING's release step 4 for this machine: its runs at
the tag `v0.21.0+84236bf0f0c832f6619b8f99ce7bc878c7800ef0` (9434d50e),
pin BLAKE3-Servil 2037118c.

**Command.** `at-the-tag.sh`, from the night's queue, with nothing else
on the machine (`at-the-tag.stdout.txt`: every step exit 0).

**Result: clean.**

| run | result |
|---|---|
| full (`full/`) | 497 s; load quiet (0.08 CPUs on average, 0.33 in the busiest window); header `blake3-servil version: 0.8.0+dev.2037118c…` |
| b3sum (`b3sum/`) | 559 s; load quiet |
| crowd (`crowd/`) | 25 s |
| release check, the pin against BLAKE3-Servil 0.8, the long stream cells named (`check-long.*`) | no cell slower |
| the same over every cell (`check.*`, samples in `check/`) | no cell slower, in both stages |
| same-library check, bench 148827f3 against the tag's (`check-same.*`) | no cell slower; no level cell's instructions moved beyond +0.5% |

The old side of the release checks is built by bench 3363bee8, the last
that builds against 0.8.

**Published.** The results folder in bench-hashes `next` (3118ee93,
`benchmark-results/12thGenIntelRCoreTMi712700K.linux70042generic/`), and
bench-hashes #163.

**Machine.** i7-12700K, Linux 7.0.0-42, mains power, governor `powersave`
(no root here to set `performance`). This is the last release this machine
measures for: its author works on it, and twice on November 10 his own
commands put busy windows into a run. From 0.22 the x86-64 AVX2 row is a
rented machine's.

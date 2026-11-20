# The i7-12700K at bench-hashes 0.24.0, BLAKE3-Servil 0.10.0 (November 20, 2026)

**Question.** Zooko asked for the i7's release run for this release, so the overview's Intel column shows 0.10.0. Does 0.10.0 (`2fd4ff6f`) read slower than 0.9.1 (`2c60420c`) on this machine?

**Verdict.** A turn of 1024 messages fed 1 KiB each reads 6.1% to 6.8% slower than 0.9.1, with one benchmark on both sides over 16 layouts a side. Every other cell is level or faster.

| Run | Benches (old, new) | Result |
|---|---|---|
| Control, `control-check.stdout.txt` | 0.23, 0.24; library 0.10.0 on both | no cell slower; no level cell's instructions moved beyond +0.5% |
| Release check, `release-check.stdout.txt` | 0.22, 0.24 | 4 slower, 49 faster: three turn cells +7.0% to +8.8%; `mt shared-one-cache ContinuousBatches 65536` +8.5% |
| Named repeat, `repeat-turn-check.stdout.txt` | 0.22, 0.22; 16 layouts | four turn cells slower: `InterleavedTurn` st +6.2%, mt +6.1%; `IdleInterleavedTurn` st +6.5%, mt +6.8%. The batch cell is not marked. |

The turn cells are the family of [BLAKE3 #404](https://github.com/servil-software-factory/BLAKE3/issues/404), recorded there for the Xeon Gold 6330 and the AmpereOne VM at 2 to 5%.

**Commits.** bench-hashes 0.24.0 `3f3ef25130feadb67da742924dd6cfdc4c7886fb`; 0.23.0 `cade30fdb71682719f5fa3e586ff96146ae9fc25`; 0.22.0 `97c0fbcbedb8fe8f8395115647684dfde75d67a3`. BLAKE3-Servil 0.10.0 `2fd4ff6f643ef04f98f7a2e5f8ca0f096298827a`; 0.9.1 `2c60420c2bccbf6073e35e668691d98520f9b096`.

**Commands.** `records.sh` (the published record, in `benchmark-results/12thGenIntelRCoreTMi712700K.linux70043generic` of bench-hashes), `control.sh`, `release-check.sh`, `repeat-turn.sh`; each check's samples are in its `kept-*` folder.

**Conditions.** Mains power; governor `powersave` with the performance energy preference; no root, so no idle control. Each check ran with `--when-quiet`.

**A flaw in one file.** The release check's job log shared the name of the check's output, so the job's last line overwrote the first 40 bytes of `release-check.stdout.txt` (its "old side" line). The verdict lines and `kept-release/` are whole.

**Posted:** [BLAKE3 #433](https://github.com/servil-software-factory/BLAKE3/issues/433).

# bench-hashes 0.24.0 release evidence: the fleet's runs and checks (November 20, 2026)

**Question.** At bench-hashes 0.24.0 with BLAKE3-Servil 0.10.0, does the benchmark itself read the same as 0.23 (the control), and how does 0.10.0 read against 0.9.1 on each machine (the release check)?

**Verdict.** The control is clean on every machine: no cell slower, with one library under benches 0.23 and 0.24. The release check has a different bench on each side (0.22 and 0.24, since 0.24 does not build against 0.9.1), so its marks mix library and benchmark changes. Read the library's speed against 0.9.1 from the one-bench checks in [`servil-010`](../servil-010/).

| Machine | Control (benches 0.23, 0.24) | Release check (benches 0.22, 0.24) |
|---|---|---|
| `x86-9700x` | no cell slower | no cell slower, 51 faster |
| `x86-epyc-9255` | no cell slower | 4 slower, 118 faster: `mt shared-one-cache LentMessages 64 MiB` +16.7%, `mt OneMessage 32 MiB` +7.7%, `128 MiB` +7.1%, `mt shared-one-cache Collection Nix files` +5.5% |
| `x86-epyc-9275f` | no cell slower; the first stage named `st ManyMessages 1` instructions +1.3%, the second stage named none | 6 slower, 111 faster: `LentMessages 64 MiB` +25.9%, `mt shared-two-caches ContinuousBatches 16` +16.2%, `Collection Nix files` +14.2%, `OneMessage 128 MiB` +13.1%, `32 MiB` +10.1%, `Collection git objects` +8.5% |
| `x86-avx2` | no cell slower | 5 slower, 113 faster: `mt LentMessages 64 MiB` +19.6%, `mt shared-one-cache ContinuousBatches 65536` +10.3%, `st ManyMessages 1` +9.5%, `OneMessage 128 MiB` +6.9%, `32 MiB` +6.1% |
| `x86-icelake` | no cell slower | 7 slower, 51 faster, all `ManyMessages` at small counts: `st 4` +20.1%, `mt 3` +11.5%, `st 16` +10.4%, `st 12` +7.9%, `mt 6` +7.6%, `st 24` +7.1%, `st 6` +7.1% |
| `x86-icelake-2` | no cell slower | 3 slower, 49 faster: `st OneMessage 3839 B` +11.0%, `BriefIdleInterleavedTurn 1024 x 1 KiB` st and mt +5.4% |
| Apple M6 (timing Mac) | no regression (job 3552) | no regression (job 3553) |

- The large one-shot and lent cells on the three EPYCs are [BLAKE3 #401](https://github.com/servil-software-factory/BLAKE3/issues/401); the turn cells are [BLAKE3 #404](https://github.com/servil-software-factory/BLAKE3/issues/404).
- The batch, collection, small-count `ManyMessages` and 3839 B marks did not appear in the one-bench checks of the same morning. Since 0.23 the bench sends batch and collection cells through the `Pipeline`. Which benchmark change moves each cell is unexamined. On the i7-12700K a named one-bench repeat left its batch mark unmarked ([`release-024-i7`](../release-024-i7/)).

**Commits.** bench-hashes 0.24.0 `3f3ef25130feadb67da742924dd6cfdc4c7886fb` (tag `v0.24.0+70970a7414b5bbb1f14db73138a764dd84d3da18`); 0.23.0 `cade30fdb71682719f5fa3e586ff96146ae9fc25`; 0.22.0 `97c0fbcbedb8fe8f8395115647684dfde75d67a3`. BLAKE3-Servil 0.10.0 `2fd4ff6f643ef04f98f7a2e5f8ca0f096298827a`; 0.9.1 `2c60420c2bccbf6073e35e668691d98520f9b096`.

**Commands.** `release-024-linux.sh` (submitted by `submit-024.sh`): the machine tests, full run, `b3sum`, crowd, then the control. Its release check lacked `--old-bench` and could not build; `release-check-024.sh` ran it again with `--old-bench` 0.22. Each machine's folder holds `release-run/` (logs, `kept-control/`) and `release-check/` (`kept-release/`).

**Records.** The published folders are in bench-hashes `benchmark-results/` (pull requests 252 and 254). The Mac's jobs 3548 to 3553 are in the public `mac-runner` exchange under `results/`; job 3551 is the release check without `--old-bench`, which stopped at the build.

**Posted:** bench-hashes pull request [252](https://github.com/servil-software-factory/bench-hashes/pull/252).

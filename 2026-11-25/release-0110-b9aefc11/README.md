# BLAKE3-Servil 0.11.0 x86 fleet release records (2026-11-25)

- **Question:** Full bare-metal `bench-hashes --all`, `LAYOUTS=4 b3sum`, and `crowd` release records for BLAKE3-Servil `0.11.0` across the four x86 timing hosts (`x86-9700x`, `x86-epyc-9255`, `x86-avx2`, `x86-icelake`), combined with Apple M6 (`mac-m6-timing`) for publication at `https://servil-software-factory.github.io/bench-hashes/`.
- **Commits:**
  - `bench-hashes`: `303fff16dfcd7a7de6d5d3c3595285359ba32d84` (`0.24.0`)
  - `BLAKE3-Servil` measured: `b9aefc11e1e422edf483f9b68cec57aaf04de560` (`0.11.0+ea57cdd210ac501865d5f6d1ab20d3f4108de0dc`)
  - `BLAKE3-Servil` final `0.11.0` stamp: `15ad383b5c9f849c548940b2181df66212a295cf` (`0.11.0+2c43b150bd18c89b6c08a133446c51a3fe6981bc`, byte-identical shipped code)
- **Command:** `bench-submit` running `run.sh` (`bench-hashes --all`, `LAYOUTS=4 b3sum`, `crowd`) on each quiet host under `bench-turn`.
- **Verdict:** All 4 x86 runs exited 0 with `quiet` loads (`0.00` avg busy CPUs, max `0.00–0.09`).
- **Posted:** `servil-software-factory/bench-hashes#281` and PR `servil-software-factory/bench-hashes#282`.

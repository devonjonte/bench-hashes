# Nightly cumulative drift check: BLAKE3 0.11.0 (main) -> next (f1f7002d)

- **Question:** Does `BLAKE3` `next` (`f1f7002d094fab6ead1bf7200fe25ab394fe38f1`, including PR #558) regress anywhere against `0.11.0` `main` (`e1966b498bc769db3d51451a4ddc8188a19ed593`) across all cells (including the new `ContinuousLentMessages` and cold `Pipeline` create/drop lifecycle + peak RSS check from `bench-hashes` PR #304)?
- **Benchmark:** `servil-software-factory/bench-hashes@513619eccd86c98a9c746d6f67fba0e8e82a97b0`
- **Command:** `python3 tools/nightly_drift.py --submit default` (job `drift-e1966b49-f1f7002d-f7806305`, `--cells all`)
- **Verdict:** **4/4 bare-metal Linux hosts `no regression (exit 0)`** after Stage 2:
  - `x86-9700x` (Ryzen 7 9700X): `no regression (exit 0)`; lifecycle `wall 1.05 -> 1.05 ms; peak RSS 11.0 -> 11.0 MiB (level)`
  - `x86-epyc-9255` (EPYC 9255): `no regression (exit 0)`; lifecycle `wall 1.93 -> 2.13 ms; peak RSS 10.9 -> 10.9 MiB (level)`
  - `x86-avx2` (2x EPYC 7443): `no regression (exit 0)`; lifecycle `wall 9.11 -> 8.18 ms; peak RSS 10.6 -> 10.6 MiB (level)`
  - `x86-icelake` (2x Xeon Gold 6330): `no regression (exit 0)`; lifecycle `wall 6.27 -> 6.25 ms; peak RSS 12.4 -> 12.4 MiB (level)`
- **Posted on:** [servil-software-factory/bench-hashes#241](https://github.com/servil-software-factory/bench-hashes/issues/241)

## File hashes (SHA-256 + BLAKE3)

| File | SHA-256 | BLAKE3 |
| --- | --- | --- |
| `x86-9700x.txt` | `366d91090e298dd31eb4b8051ac81de910eafc412e25f4aaae5bc6f8bb94e2a4` | `cbdc4456464b90ec2a0c6a4c95be8c1aab11ba2951181081bbcc62270961f7fa` |
| `x86-epyc-9255.txt` | `e79ba9ec922d21fe7b0875176e544ba88d93dd9094d91b3f0fafe5000b906875` | `7d56f94f003d5f5f94999adc1a03c857b2e908ad83b24168cd554c32b9c2c459` |
| `x86-avx2.txt` | `a64de0669514a469c0096bb636f46da4e60a96741babf0e78fd1afe1d6326126` | `75bbd90047a495066d3e14aa7be6d4fdddc30894673d73cec6c3e17984333393` |
| `x86-icelake.txt` | `36aaa1922c9c078abcedb985355b8396c1e7d6c8a240a6d1799a22ff86309859` | `5a0f24bbf144e46253f79398c0d80110b129aa4311a5e1954c29c6266d16f6ff` |

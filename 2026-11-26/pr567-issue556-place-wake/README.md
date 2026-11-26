# BLAKE3 PR #567 / Issue #556: `Park::wake_if_place_asleep`

- **Question:** Why did 2x AMD EPYC 7443 `shared-two-caches|ContinuousMessages|64 B` remain `+18.5%..+26.6%` slower than `0.10.0` after PR `#558`, and does waking one local worker when a caller's cache place is asleep (`waiting == 1`) recover it without regressing any workload across all four bare-metal Linux hosts?
- **Commits:**
  - `0.10.0`: `2fd4ff6f643ef04f98f7a2e5f8ca0f096298827a` (pre-PR `#512` `d13e503783a3`)
  - Base (`BLAKE3` `next`): `f5c52f5e464eb675cbf9ea4f138b9698f91e1cb9`
  - All-cells candidate: `e61ea08385f0dc5e4da317b93818255783ce7e24`
  - Revised with zero-mask word skip (`mask != 0 && ...`): `cc313b7bf01f4393e7bfd319b58d9eb246e266f5` (rustfmt-only test tweak -> PR `#567` head `ee9d30d1976732cec38107def33045016369a4d5`, byte-identical production code)
  - `bench-hashes`: `fb859e387081367d1114a20ccef794241a62f9e8` (`--cells all`), `81c3529ecb58bf1a44075424d9fd32cb6b5c4303` (for direct `0.10.0` comparisons)
- **Root cause (`perf556v4-avx2.txt`):** On 2x EPYC 7443, `Source::publish_actions` woke a worker only at `waiting >= 2`. Under `shared-two-caches`, Caller 0 (L3 #0) and Caller 1 (L3 #1) published one action at a time (`waiting == 1`), so `blake3-worker-1` on L3 #0 stole Caller 1's work across L3 caches while L3 #1's workers stayed parked (`blake3-worker-2` hashing share dropped `-38%`).
- **Verdict:**
  - **4/4 bare-metal Linux `bench-hashes check --cells all` (`f5c52f5e -> e61ea083`):** `EXIT=0` (`no cell slower`, Stage 1 + 64-pair Stage 2, lifecycle RSS level on all 4 hosts: `x86-avx2`, `x86-epyc-9255`, `x86-icelake`, `x86-9700x`; EPYC 9255 `shared-two-caches|4 KiB` `-5.1%` faster across 64 pairs).
  - **2x EPYC 7443 direct `0.10.0 -> cc313b7b` (`final556-pw-avx2.txt`, 16 pairs):** `shared-two-caches|ContinuousMessages|64 B` **`-17.6%` faster than `0.10.0`** (`1.216 -> 1.001 ns/unit`, `14/16` pairs faster, cycles `-18.8%`), `solo|64 B` CPU time **`-32.8%` (`x0.672`)**; vs `next` `f5c52f5e` (12 pairs): `shared-two-caches|64 B` **`-23.5%` faster (`1.359 -> 1.041 ns/unit`, `11/12` faster)**, `solo|64 B` CPU time `-32.9%`.
  - **EPYC 9255 (`probe556-pw-epyc9255.txt`, 8 pairs):** `shared-two-caches|64 B` **`-29.1%` faster (`8/8`)**, `shared-two-caches|ContinuousBatches|1024` **`-10.5%` faster**, `solo|64 B` **`-7.0%` faster (`8/8`), CPU time `-15.0%`**.
- **Posted:** https://github.com/servil-software-factory/BLAKE3/pull/567 and https://github.com/servil-software-factory/BLAKE3/issues/556

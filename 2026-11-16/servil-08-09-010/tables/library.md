| host | step | form | cells | faster | slower | left out: the benchmark's call changed | largest gain |
|---|---|---|---:|---:|---:|---:|---|
| `x86-epyc-9275f` | 0.8.0 → 0.9.0 | one thread | 213 | 11 | 0 |  | solo · IdleOneMessage · 7935 B ×0.541 |
| `x86-epyc-9275f` | 0.9.0 → 0.10 candidate (ad163558) | one thread | 222 | 12 | 0 |  | solo · ReceivingMessage · saturated ×0.578 |
| `x86-epyc-9275f` | 0.9.0 → 0.10 candidate (ad163558) | every core | 271 | 51 | 6 | 63 | shared-one-cache · LentBatches · 16384 ×0.365 |
| `x86-epyc-9275f` | 0.8.0 → 0.10 earlier (70483031) | one thread | 213 | 15 | 1 |  | solo · IdleOneMessage · 7935 B ×0.546 |
| `x86-epyc-9255` | 0.8.0 → 0.9.0 | one thread | 213 | 16 | 5 |  | solo · IdleOneMessage · 7935 B ×0.538 |
| `x86-epyc-9255` | 0.9.0 → 0.10 candidate (ad163558) | one thread | 222 | 15 | 0 |  | solo · ReceivingMessage · saturated ×0.577 |
| `x86-epyc-9255` | 0.9.0 → 0.10 candidate (ad163558) | every core | 267 | 62 | 3 | 67 | solo · BriefIdleManyMessages · 8192 ×0.381 |
| `x86-epyc-9255` | 0.8.0 → 0.10 earlier (70483031) | one thread | 213 | 18 | 0 |  | solo · IdleOneMessage · 7935 B ×0.543 |
| `x86-9700x` | 0.8.0 → 0.9.0 | one thread | 213 | 14 | 3 |  | solo · BriefIdleOneMessage · 7935 B ×0.549 |
| `x86-9700x` | 0.9.0 → 0.10 candidate (ad163558) | one thread | 222 | 7 | 0 |  | solo · ReceivingMessage · saturated ×0.583 |
| `x86-9700x` | 0.9.0 → 0.10 candidate (ad163558) | every core | 231 | 1 | 0 | 47 | solo · InterleavedTurn · 256 ×0.844 |
| `x86-9700x` | 0.8.0 → 0.10 earlier (70483031) | one thread | 213 | 16 | 2 |  | solo · BriefIdleOneMessage · 7935 B ×0.548 |
| `x86-icelake` | 0.8.0 → 0.9.0 | one thread | 213 | 10 | 1 |  | solo · OneMessage · 7935 B ×0.631 |
| `x86-icelake` | 0.9.0 → 0.10 candidate (ad163558) | one thread | 222 | 2 | 2 |  | solo · ReceivingMessage · saturated ×0.804 |
| `x86-icelake` | 0.9.0 → 0.10 candidate (ad163558) | every core | 266 | 57 | 2 | 68 | shared-two-caches · MerkleTree · 65536 x 32 B ×0.581 |
| `x86-icelake` | 0.8.0 → 0.10 earlier (70483031) | one thread | 213 | 12 | 0 |  | solo · OneMessage · 7935 B ×0.636 |
| `x86-icelake-2` | 0.9.0 → 0.10 candidate (ad163558) | one thread | 222 | 2 | 1 |  | solo · ReceivingMessage · 2 μs ×0.801 |
| `x86-icelake-2` | 0.9.0 → 0.10 candidate (ad163558) | every core | 265 | 51 | 4 | 69 | shared-two-caches · MerkleTree · 65536 x 32 B ×0.585 |
| `x86-icelake-2` | 0.8.0 → 0.10 earlier (70483031) | one thread | 213 | 15 | 1 |  | solo · OneMessage · 3839 B ×0.620 |
| `x86-avx2` | 0.8.0 → 0.9.0 | one thread | 213 | 4 | 1 |  | solo · ContinuousMessages · 64 B ×0.845 |
| `x86-avx2` | 0.9.0 → 0.10 candidate (ad163558) | one thread | 222 | 23 | 1 |  | solo · OneMessage · 4 MiB ×0.761 |
| `x86-avx2` | 0.9.0 → 0.10 candidate (ad163558) | every core | 267 | 75 | 1 | 67 | shared-one-cache · LentBatches · 65536 ×0.052 |
| `x86-avx2` | 0.8.0 → 0.10 earlier (70483031) | one thread | 213 | 7 | 0 |  | solo · BriefIdleOneMessage · 3 KiB ×0.672 |
| `apple-m6` | 0.9.0 → 0.10 candidate (ad163558) | one thread | 222 | 6 | 3 |  | solo · ReceivingMessage · saturated ×0.913 |
| `apple-m6` | 0.9.0 → 0.10 candidate (ad163558) | every core | 232 | 9 | 3 | 46 | shared-os · ContinuousMessages · 16 KiB ×0.568 |

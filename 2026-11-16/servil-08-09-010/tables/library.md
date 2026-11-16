| host | step | form | cells | faster | slower | left out: the benchmark's call changed | largest gain |
|---|---|---|---:|---:|---:|---:|---|
| `x86-epyc-9275f` | 0.8.0 → 0.9.0 | one thread | 213 | 11 | 0 |  | solo · IdleOneMessage · 7935 B ×0.541 |
| `x86-epyc-9275f` | 0.9.0 → 0.10 candidate | one thread | 222 | 16 | 0 |  | solo · ReceivingMessage · saturated ×0.579 |
| `x86-epyc-9275f` | 0.9.0 → 0.10 candidate | every core | 265 | 47 | 11 | 69 | shared-one-cache · LentBatches · 16384 ×0.385 |
| `x86-epyc-9275f` | 0.8.0 → 0.10 candidate | one thread | 213 | 15 | 1 |  | solo · IdleOneMessage · 7935 B ×0.546 |
| `x86-epyc-9255` | 0.8.0 → 0.9.0 | one thread | 213 | 16 | 5 |  | solo · IdleOneMessage · 7935 B ×0.538 |
| `x86-epyc-9255` | 0.9.0 → 0.10 candidate | one thread | 220 | 11 | 1 | 2 | solo · ReceivingMessage · saturated ×0.579 |
| `x86-epyc-9255` | 0.9.0 → 0.10 candidate | every core | 260 | 50 | 10 | 74 | solo · BriefIdleManyMessages · 8192 ×0.408 |
| `x86-epyc-9255` | 0.8.0 → 0.10 candidate | one thread | 213 | 18 | 0 |  | solo · IdleOneMessage · 7935 B ×0.543 |
| `x86-9700x` | 0.8.0 → 0.9.0 | one thread | 213 | 14 | 3 |  | solo · BriefIdleOneMessage · 7935 B ×0.549 |
| `x86-9700x` | 0.9.0 → 0.10 candidate | one thread | 221 | 5 | 0 | 1 | solo · ReceivingMessage · saturated ×0.581 |
| `x86-9700x` | 0.9.0 → 0.10 candidate | every core | 230 | 0 | 1 | 48 |  |
| `x86-9700x` | 0.8.0 → 0.10 candidate | one thread | 213 | 16 | 2 |  | solo · BriefIdleOneMessage · 7935 B ×0.548 |
| `x86-icelake` | 0.8.0 → 0.9.0 | one thread | 213 | 10 | 1 |  | solo · OneMessage · 7935 B ×0.631 |
| `x86-icelake` | 0.9.0 → 0.10 candidate | one thread | 222 | 2 | 3 |  | solo · ReceivingMessage · saturated ×0.807 |
| `x86-icelake` | 0.9.0 → 0.10 candidate | every core | 262 | 50 | 3 | 72 | shared-two-caches · MerkleTree · 65536 x 32 B ×0.571 |
| `x86-icelake` | 0.8.0 → 0.10 candidate | one thread | 213 | 12 | 0 |  | solo · OneMessage · 7935 B ×0.636 |
| `x86-icelake-2` | 0.9.0 → 0.10 candidate | one thread | 222 | 2 | 1 |  | solo · ReceivingMessage · saturated ×0.806 |
| `x86-icelake-2` | 0.9.0 → 0.10 candidate | every core | 264 | 40 | 0 | 70 | shared-two-caches · MerkleTree · 65536 x 32 B ×0.607 |
| `x86-icelake-2` | 0.8.0 → 0.10 candidate | one thread | 213 | 15 | 1 |  | solo · OneMessage · 3839 B ×0.620 |
| `x86-avx2` | 0.8.0 → 0.9.0 | one thread | 213 | 4 | 1 |  | solo · ContinuousMessages · 64 B ×0.845 |
| `x86-avx2` | 0.9.0 → 0.10 candidate | one thread | 221 | 24 | 0 | 1 | solo · OneMessage · 4 MiB ×0.772 |
| `x86-avx2` | 0.9.0 → 0.10 candidate | every core | 265 | 78 | 1 | 69 | shared-one-cache · LentBatches · 65536 ×0.039 |
| `x86-avx2` | 0.8.0 → 0.10 candidate | one thread | 213 | 7 | 0 |  | solo · BriefIdleOneMessage · 3 KiB ×0.672 |

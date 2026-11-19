# Library cells, 0.9.1 → 0.10.0: 2× EPYC 7443 (`x86-avx2`)

One bench-hashes (0.22) built both libraries and measured them in alternating pairs. Verdicts come from `bench-hashes compare` over the check's kept runs (3% bench mark; 5% project margin).

`old side: bench 97c0fbcbedb8 clean; servil bf2da8b957f5 clean`; `new side: bench 97c0fbcbedb8 clean; servil 2ef4c4431d56 clean`

556 cells over 4 pairs: **60 faster, 3 slower**, the rest level.

| form | scenario | use case | cells | faster | slower | median time ratio | range |
|---|---|---|---:|---:|---:|---:|---|
| one thread | solo | OneMessage | 28 | 0 | 0 | ×0.994 | ×0.956–×1.109 |
| one thread | solo | ManyMessages | 24 | 0 | 0 | ×1.003 | ×0.922–×1.128 |
| one thread | solo | ManyLongMessages | 4 | 0 | 0 | ×0.986 | ×0.967–×1.001 |
| one thread | solo | IdleOneMessage | 28 | 0 | 0 | ×1.000 | ×0.964–×1.060 |
| one thread | solo | IdleManyMessages | 24 | 0 | 0 | ×1.002 | ×0.931–×1.049 |
| one thread | solo | BriefIdleOneMessage | 28 | 0 | 0 | ×0.999 | ×0.954–×1.040 |
| one thread | solo | BriefIdleManyMessages | 24 | 0 | 0 | ×0.998 | ×0.977–×1.077 |
| one thread | solo | ContinuousMessages | 13 | 0 | 0 | ×0.996 | ×0.980–×1.014 |
| one thread | solo | ContinuousBatches | 7 | 0 | 0 | ×0.994 | ×0.981–×1.001 |
| one thread | solo | LentMessages | 13 | 0 | 0 | ×0.999 | ×0.985–×1.014 |
| one thread | solo | Interleaved | 1 | 0 | 0 | ×1.008 | ×1.008–×1.008 |
| one thread | solo | Collection | 2 | 0 | 0 | ×0.994 | ×0.993–×0.996 |
| one thread | solo | LentBatches | 7 | 0 | 0 | ×0.994 | ×0.981–×1.001 |
| one thread | solo | ContinuousCollection | 2 | 0 | 0 | ×0.997 | ×0.987–×1.007 |
| one thread | solo | MerkleTree | 8 | 0 | 0 | ×0.998 | ×0.994–×1.006 |
| one thread | solo | InterleavedTurn | 2 | 0 | 0 | ×1.011 | ×1.008–×1.014 |
| one thread | solo | IdleInterleavedTurn | 2 | 0 | 0 | ×0.991 | ×0.981–×1.001 |
| one thread | solo | BriefIdleInterleavedTurn | 2 | 0 | 0 | ×1.018 | ×1.016–×1.020 |
| one thread | solo | ReceivingMessage | 3 | 2 | 0 | ×0.843 | ×0.843–×1.000 |
| every core | solo | OneMessage | 28 | 3 | 2 | ×0.996 | ×0.686–×1.080 |
| every core | solo | ManyMessages | 24 | 5 | 0 | ×0.990 | ×0.646–×1.122 |
| every core | solo | ManyLongMessages | 4 | 1 | 0 | ×0.988 | ×0.700–×1.004 |
| every core | solo | IdleOneMessage | 28 | 0 | 0 | ×0.986 | ×0.791–×1.028 |
| every core | solo | IdleManyMessages | 24 | 3 | 0 | ×0.985 | ×0.729–×1.061 |
| every core | solo | BriefIdleOneMessage | 28 | 1 | 0 | ×1.003 | ×0.641–×1.029 |
| every core | solo | BriefIdleManyMessages | 24 | 3 | 0 | ×1.000 | ×0.573–×1.051 |
| every core | solo | ContinuousMessages | 13 | 0 | 0 | ×0.992 | ×0.981–×1.002 |
| every core | solo | ContinuousBatches | 7 | 2 | 0 | ×0.985 | ×0.534–×0.998 |
| every core | solo | LentMessages | 13 | 3 | 1 | ×0.997 | ×0.581–×1.241 |
| every core | solo | Interleaved | 1 | 0 | 0 | ×0.999 | ×0.999–×0.999 |
| every core | solo | Collection | 2 | 1 | 0 | ×0.956 | ×0.950–×0.963 |
| every core | solo | LentBatches | 7 | 2 | 0 | ×0.985 | ×0.534–×0.998 |
| every core | solo | ContinuousCollection | 2 | 0 | 0 | ×0.984 | ×0.978–×0.991 |
| every core | solo | MerkleTree | 8 | 3 | 0 | ×0.956 | ×0.612–×1.032 |
| every core | solo | InterleavedTurn | 2 | 0 | 0 | ×1.010 | ×1.008–×1.013 |
| every core | solo | IdleInterleavedTurn | 2 | 0 | 0 | ×1.003 | ×0.976–×1.031 |
| every core | solo | BriefIdleInterleavedTurn | 2 | 0 | 0 | ×1.019 | ×1.012–×1.026 |
| every core | solo | ReceivingMessage | 3 | 2 | 0 | ×0.883 | ×0.882–×1.000 |
| every core | shared-one-cache | ContinuousMessages | 13 | 0 | 0 | ×0.995 | ×0.979–×1.005 |
| every core | shared-one-cache | ContinuousBatches | 7 | 2 | 0 | ×0.962 | ×0.531–×0.996 |
| every core | shared-one-cache | LentMessages | 13 | 3 | 0 | ×0.995 | ×0.629–×1.043 |
| every core | shared-one-cache | Interleaved | 1 | 0 | 0 | ×1.015 | ×1.015–×1.015 |
| every core | shared-one-cache | Collection | 2 | 0 | 0 | ×1.040 | ×0.990–×1.091 |
| every core | shared-one-cache | LentBatches | 7 | 2 | 0 | ×0.962 | ×0.531–×0.996 |
| every core | shared-one-cache | ContinuousCollection | 2 | 0 | 0 | ×0.994 | ×0.993–×0.996 |
| every core | shared-one-cache | MerkleTree | 8 | 4 | 0 | ×0.932 | ×0.688–×1.048 |
| every core | shared-one-cache | ReceivingMessage | 3 | 2 | 0 | ×0.891 | ×0.890–×1.000 |
| every core | shared-two-caches | ContinuousMessages | 13 | 0 | 0 | ×0.994 | ×0.979–×1.005 |
| every core | shared-two-caches | ContinuousBatches | 7 | 3 | 0 | ×0.960 | ×0.613–×0.998 |
| every core | shared-two-caches | LentMessages | 13 | 3 | 0 | ×0.995 | ×0.716–×1.005 |
| every core | shared-two-caches | Interleaved | 1 | 0 | 0 | ×1.002 | ×1.002–×1.002 |
| every core | shared-two-caches | Collection | 2 | 1 | 0 | ×0.956 | ×0.949–×0.964 |
| every core | shared-two-caches | LentBatches | 7 | 3 | 0 | ×0.960 | ×0.613–×0.998 |
| every core | shared-two-caches | ContinuousCollection | 2 | 0 | 0 | ×0.970 | ×0.949–×0.991 |
| every core | shared-two-caches | MerkleTree | 8 | 4 | 0 | ×0.905 | ×0.613–×1.001 |
| every core | shared-two-caches | ReceivingMessage | 3 | 2 | 0 | ×0.883 | ×0.882–×1.000 |

Slower cells (beyond 5% in bold):

- `blake3-servil-mt|solo|LentMessages|64 MiB`: **+24% slower** (4 pairs)
- `blake3-servil-mt|solo|OneMessage|32 MiB`: **+8% slower** (4 pairs)
- `blake3-servil-mt|solo|OneMessage|128 MiB`: **+7% slower** (4 pairs)

Ten largest gains:

- `blake3-servil-mt|shared-one-cache|ContinuousBatches|16384`: 1.9× faster
- `blake3-servil-mt|shared-one-cache|LentBatches|16384`: 1.9× faster
- `blake3-servil-mt|solo|ContinuousBatches|16384`: 1.9× faster
- `blake3-servil-mt|solo|LentBatches|16384`: 1.9× faster
- `blake3-servil-mt|solo|ContinuousBatches|65536`: 1.8× faster
- `blake3-servil-mt|solo|LentBatches|65536`: 1.8× faster
- `blake3-servil-mt|solo|BriefIdleManyMessages|8192`: 1.7× faster
- `blake3-servil-mt|solo|LentMessages|4 MiB`: 1.7× faster
- `blake3-servil-mt|solo|BriefIdleManyMessages|65536`: 1.7× faster
- `blake3-servil-mt|solo|BriefIdleManyMessages|16384`: 1.6× faster

# Library cells, 0.9.1 → 0.10.0: 2× Xeon Gold 6330 (b) (`x86-icelake-2`)

One bench-hashes (0.22) built both libraries and measured them in alternating pairs. Verdicts come from `bench-hashes compare` over the check's kept runs (3% bench mark; 5% project margin).

`old side: bench 97c0fbcbedb8 clean; servil bf2da8b957f5 clean`; `new side: bench 97c0fbcbedb8 clean; servil 2ef4c4431d56 clean`

556 cells over 4 pairs: **8 faster, 1 slower**, the rest level.

| form | scenario | use case | cells | faster | slower | median time ratio | range |
|---|---|---|---:|---:|---:|---:|---|
| one thread | solo | OneMessage | 28 | 0 | 0 | ×1.003 | ×0.960–×1.083 |
| one thread | solo | ManyMessages | 24 | 0 | 0 | ×1.003 | ×0.994–×1.066 |
| one thread | solo | ManyLongMessages | 4 | 0 | 0 | ×0.999 | ×0.993–×1.004 |
| one thread | solo | IdleOneMessage | 28 | 0 | 0 | ×1.000 | ×0.942–×1.062 |
| one thread | solo | IdleManyMessages | 24 | 0 | 0 | ×1.011 | ×0.977–×1.068 |
| one thread | solo | BriefIdleOneMessage | 28 | 0 | 0 | ×1.000 | ×0.982–×1.033 |
| one thread | solo | BriefIdleManyMessages | 24 | 0 | 0 | ×1.001 | ×0.983–×1.051 |
| one thread | solo | ContinuousMessages | 13 | 0 | 0 | ×0.992 | ×0.977–×1.000 |
| one thread | solo | ContinuousBatches | 7 | 0 | 0 | ×1.000 | ×0.994–×1.004 |
| one thread | solo | LentMessages | 13 | 0 | 0 | ×0.998 | ×0.990–×1.000 |
| one thread | solo | Interleaved | 1 | 0 | 0 | ×1.003 | ×1.003–×1.003 |
| one thread | solo | Collection | 2 | 0 | 0 | ×0.998 | ×0.998–×0.998 |
| one thread | solo | LentBatches | 7 | 0 | 0 | ×1.000 | ×0.994–×1.004 |
| one thread | solo | ContinuousCollection | 2 | 0 | 0 | ×0.998 | ×0.998–×0.998 |
| one thread | solo | MerkleTree | 8 | 0 | 0 | ×0.998 | ×0.987–×1.001 |
| one thread | solo | InterleavedTurn | 2 | 0 | 0 | ×1.020 | ×1.013–×1.027 |
| one thread | solo | IdleInterleavedTurn | 2 | 0 | 0 | ×1.014 | ×0.999–×1.030 |
| one thread | solo | BriefIdleInterleavedTurn | 2 | 0 | 0 | ×1.016 | ×1.003–×1.030 |
| one thread | solo | ReceivingMessage | 3 | 2 | 0 | ×0.806 | ×0.801–×1.000 |
| every core | solo | OneMessage | 28 | 0 | 0 | ×0.998 | ×0.924–×1.098 |
| every core | solo | ManyMessages | 24 | 0 | 0 | ×0.996 | ×0.884–×1.061 |
| every core | solo | ManyLongMessages | 4 | 0 | 0 | ×0.994 | ×0.958–×0.999 |
| every core | solo | IdleOneMessage | 28 | 0 | 0 | ×1.002 | ×0.937–×1.058 |
| every core | solo | IdleManyMessages | 24 | 0 | 0 | ×1.007 | ×0.934–×1.094 |
| every core | solo | BriefIdleOneMessage | 28 | 0 | 0 | ×0.999 | ×0.847–×1.015 |
| every core | solo | BriefIdleManyMessages | 24 | 0 | 0 | ×0.998 | ×0.964–×1.040 |
| every core | solo | ContinuousMessages | 13 | 0 | 0 | ×0.999 | ×0.986–×1.001 |
| every core | solo | ContinuousBatches | 7 | 0 | 0 | ×0.996 | ×0.957–×1.000 |
| every core | solo | LentMessages | 13 | 0 | 0 | ×0.998 | ×0.990–×1.001 |
| every core | solo | Interleaved | 1 | 0 | 0 | ×1.004 | ×1.004–×1.004 |
| every core | solo | Collection | 2 | 0 | 0 | ×1.007 | ×1.001–×1.013 |
| every core | solo | LentBatches | 7 | 0 | 0 | ×0.996 | ×0.957–×1.000 |
| every core | solo | ContinuousCollection | 2 | 0 | 0 | ×1.000 | ×0.998–×1.003 |
| every core | solo | MerkleTree | 8 | 0 | 0 | ×0.986 | ×0.957–×0.998 |
| every core | solo | InterleavedTurn | 2 | 0 | 1 | ×1.027 | ×1.011–×1.044 |
| every core | solo | IdleInterleavedTurn | 2 | 0 | 0 | ×1.022 | ×1.016–×1.029 |
| every core | solo | BriefIdleInterleavedTurn | 2 | 0 | 0 | ×1.022 | ×1.008–×1.037 |
| every core | solo | ReceivingMessage | 3 | 2 | 0 | ×0.855 | ×0.855–×1.000 |
| every core | shared-one-cache | ContinuousMessages | 13 | 0 | 0 | ×1.003 | ×0.987–×1.016 |
| every core | shared-one-cache | ContinuousBatches | 7 | 0 | 0 | ×0.986 | ×0.960–×1.002 |
| every core | shared-one-cache | LentMessages | 13 | 0 | 0 | ×1.002 | ×0.993–×1.029 |
| every core | shared-one-cache | Interleaved | 1 | 0 | 0 | ×0.993 | ×0.993–×0.993 |
| every core | shared-one-cache | Collection | 2 | 0 | 0 | ×1.019 | ×1.017–×1.021 |
| every core | shared-one-cache | LentBatches | 7 | 0 | 0 | ×0.986 | ×0.960–×1.002 |
| every core | shared-one-cache | ContinuousCollection | 2 | 0 | 0 | ×1.002 | ×1.002–×1.003 |
| every core | shared-one-cache | MerkleTree | 8 | 0 | 0 | ×0.996 | ×0.961–×1.001 |
| every core | shared-one-cache | ReceivingMessage | 3 | 2 | 0 | ×0.859 | ×0.859–×1.000 |
| every core | shared-two-caches | ContinuousMessages | 13 | 0 | 0 | ×1.002 | ×0.987–×1.017 |
| every core | shared-two-caches | ContinuousBatches | 7 | 0 | 0 | ×1.001 | ×0.980–×1.004 |
| every core | shared-two-caches | LentMessages | 13 | 0 | 0 | ×1.002 | ×0.996–×1.017 |
| every core | shared-two-caches | Interleaved | 1 | 0 | 0 | ×1.002 | ×1.002–×1.002 |
| every core | shared-two-caches | Collection | 2 | 0 | 0 | ×0.980 | ×0.945–×1.015 |
| every core | shared-two-caches | LentBatches | 7 | 0 | 0 | ×1.001 | ×0.980–×1.004 |
| every core | shared-two-caches | ContinuousCollection | 2 | 0 | 0 | ×1.004 | ×1.002–×1.006 |
| every core | shared-two-caches | MerkleTree | 8 | 0 | 0 | ×0.999 | ×0.979–×1.007 |
| every core | shared-two-caches | ReceivingMessage | 3 | 2 | 0 | ×0.858 | ×0.857–×1.000 |

Slower cells (beyond 5% in bold):

- `blake3-servil-mt|solo|InterleavedTurn|1024 x 1 KiB`: +4% slower (4 pairs)

Ten largest gains:

- `blake3-servil-st|solo|ReceivingMessage|saturated`: 1.2× faster
- `blake3-servil-st|solo|ReceivingMessage|2 μs`: 1.2× faster
- `blake3-servil-mt|solo|ReceivingMessage|saturated`: 1.2× faster
- `blake3-servil-mt|solo|ReceivingMessage|2 μs`: 1.2× faster
- `blake3-servil-mt|shared-two-caches|ReceivingMessage|saturated`: 1.2× faster
- `blake3-servil-mt|shared-two-caches|ReceivingMessage|2 μs`: 1.2× faster
- `blake3-servil-mt|shared-one-cache|ReceivingMessage|saturated`: 1.2× faster
- `blake3-servil-mt|shared-one-cache|ReceivingMessage|2 μs`: 1.2× faster

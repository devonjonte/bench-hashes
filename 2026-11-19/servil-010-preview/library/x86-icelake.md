# Library cells, 0.9.1 → 0.10.0: 2× Xeon Gold 6330 (a) (`x86-icelake`)

One bench-hashes (0.22) built both libraries and measured them in alternating pairs. Verdicts come from `bench-hashes compare` over the check's kept runs (3% bench mark; 5% project margin).

`old side: bench 97c0fbcbedb8 clean; servil bf2da8b957f5 clean`; `new side: bench 97c0fbcbedb8 clean; servil 2ef4c4431d56 clean`

556 cells over 4 pairs: **10 faster, 3 slower**, the rest level.

| form | scenario | use case | cells | faster | slower | median time ratio | range |
|---|---|---|---:|---:|---:|---:|---|
| one thread | solo | OneMessage | 28 | 0 | 0 | ×1.006 | ×0.884–×1.091 |
| one thread | solo | ManyMessages | 24 | 0 | 0 | ×0.998 | ×0.961–×1.037 |
| one thread | solo | ManyLongMessages | 4 | 0 | 0 | ×1.002 | ×0.996–×1.029 |
| one thread | solo | IdleOneMessage | 28 | 0 | 0 | ×1.001 | ×0.979–×1.066 |
| one thread | solo | IdleManyMessages | 24 | 0 | 0 | ×1.000 | ×0.939–×1.047 |
| one thread | solo | BriefIdleOneMessage | 28 | 0 | 0 | ×1.000 | ×0.950–×1.007 |
| one thread | solo | BriefIdleManyMessages | 24 | 0 | 0 | ×1.000 | ×0.971–×1.058 |
| one thread | solo | ContinuousMessages | 13 | 0 | 0 | ×0.999 | ×0.980–×1.015 |
| one thread | solo | ContinuousBatches | 7 | 0 | 0 | ×1.004 | ×0.988–×1.006 |
| one thread | solo | LentMessages | 13 | 0 | 0 | ×1.001 | ×0.998–×1.015 |
| one thread | solo | Interleaved | 1 | 0 | 0 | ×1.016 | ×1.016–×1.016 |
| one thread | solo | Collection | 2 | 0 | 0 | ×1.001 | ×1.000–×1.002 |
| one thread | solo | LentBatches | 7 | 0 | 0 | ×1.004 | ×0.988–×1.006 |
| one thread | solo | ContinuousCollection | 2 | 0 | 0 | ×1.002 | ×1.002–×1.003 |
| one thread | solo | MerkleTree | 8 | 0 | 0 | ×1.002 | ×1.000–×1.006 |
| one thread | solo | InterleavedTurn | 2 | 0 | 0 | ×1.012 | ×1.010–×1.014 |
| one thread | solo | IdleInterleavedTurn | 2 | 0 | 1 | ×1.028 | ×1.019–×1.037 |
| one thread | solo | BriefIdleInterleavedTurn | 2 | 0 | 1 | ×1.037 | ×1.029–×1.045 |
| one thread | solo | ReceivingMessage | 3 | 2 | 0 | ×0.806 | ×0.806–×1.000 |
| every core | solo | OneMessage | 28 | 0 | 0 | ×1.005 | ×0.954–×1.049 |
| every core | solo | ManyMessages | 24 | 0 | 0 | ×1.000 | ×0.982–×1.053 |
| every core | solo | ManyLongMessages | 4 | 0 | 0 | ×1.006 | ×0.998–×1.009 |
| every core | solo | IdleOneMessage | 28 | 1 | 0 | ×0.995 | ×0.953–×1.064 |
| every core | solo | IdleManyMessages | 24 | 0 | 0 | ×0.994 | ×0.947–×1.063 |
| every core | solo | BriefIdleOneMessage | 28 | 0 | 0 | ×0.999 | ×0.962–×1.025 |
| every core | solo | BriefIdleManyMessages | 24 | 0 | 0 | ×0.999 | ×0.973–×1.066 |
| every core | solo | ContinuousMessages | 13 | 0 | 0 | ×1.000 | ×0.986–×1.023 |
| every core | solo | ContinuousBatches | 7 | 0 | 0 | ×1.004 | ×0.979–×1.015 |
| every core | solo | LentMessages | 13 | 0 | 0 | ×1.009 | ×0.997–×1.023 |
| every core | solo | Interleaved | 1 | 0 | 0 | ×1.015 | ×1.015–×1.015 |
| every core | solo | Collection | 2 | 0 | 0 | ×0.994 | ×0.983–×1.004 |
| every core | solo | LentBatches | 7 | 0 | 0 | ×1.004 | ×0.979–×1.015 |
| every core | solo | ContinuousCollection | 2 | 0 | 0 | ×1.002 | ×1.001–×1.002 |
| every core | solo | MerkleTree | 8 | 0 | 0 | ×1.000 | ×0.984–×1.004 |
| every core | solo | InterleavedTurn | 2 | 0 | 0 | ×1.018 | ×1.006–×1.030 |
| every core | solo | IdleInterleavedTurn | 2 | 0 | 1 | ×1.024 | ×1.007–×1.042 |
| every core | solo | BriefIdleInterleavedTurn | 2 | 0 | 0 | ×1.019 | ×1.011–×1.027 |
| every core | solo | ReceivingMessage | 3 | 2 | 0 | ×0.858 | ×0.858–×1.000 |
| every core | shared-one-cache | ContinuousMessages | 13 | 0 | 0 | ×1.003 | ×0.987–×1.019 |
| every core | shared-one-cache | ContinuousBatches | 7 | 0 | 0 | ×0.996 | ×0.979–×1.002 |
| every core | shared-one-cache | LentMessages | 13 | 0 | 0 | ×1.001 | ×0.987–×1.019 |
| every core | shared-one-cache | Interleaved | 1 | 0 | 0 | ×0.996 | ×0.996–×0.996 |
| every core | shared-one-cache | Collection | 2 | 0 | 0 | ×0.988 | ×0.972–×1.005 |
| every core | shared-one-cache | LentBatches | 7 | 0 | 0 | ×0.996 | ×0.979–×1.002 |
| every core | shared-one-cache | ContinuousCollection | 2 | 0 | 0 | ×0.998 | ×0.998–×0.998 |
| every core | shared-one-cache | MerkleTree | 8 | 1 | 0 | ×0.994 | ×0.949–×1.003 |
| every core | shared-one-cache | ReceivingMessage | 3 | 2 | 0 | ×0.860 | ×0.857–×1.000 |
| every core | shared-two-caches | ContinuousMessages | 13 | 0 | 0 | ×1.001 | ×0.987–×1.016 |
| every core | shared-two-caches | ContinuousBatches | 7 | 0 | 0 | ×0.998 | ×0.979–×1.004 |
| every core | shared-two-caches | LentMessages | 13 | 0 | 0 | ×1.001 | ×0.994–×1.016 |
| every core | shared-two-caches | Interleaved | 1 | 0 | 0 | ×0.997 | ×0.997–×0.997 |
| every core | shared-two-caches | Collection | 2 | 0 | 0 | ×1.004 | ×1.004–×1.004 |
| every core | shared-two-caches | LentBatches | 7 | 0 | 0 | ×0.998 | ×0.979–×1.004 |
| every core | shared-two-caches | ContinuousCollection | 2 | 0 | 0 | ×1.000 | ×0.999–×1.000 |
| every core | shared-two-caches | MerkleTree | 8 | 0 | 0 | ×0.997 | ×0.961–×1.007 |
| every core | shared-two-caches | ReceivingMessage | 3 | 2 | 0 | ×0.859 | ×0.858–×1.000 |

Slower cells (beyond 5% in bold):

- `blake3-servil-st|solo|BriefIdleInterleavedTurn|1024 x 1 KiB`: +4% slower (4 pairs)
- `blake3-servil-mt|solo|IdleInterleavedTurn|1024 x 1 KiB`: +4% slower (4 pairs)
- `blake3-servil-st|solo|IdleInterleavedTurn|1024 x 1 KiB`: +4% slower (4 pairs)

Ten largest gains:

- `blake3-servil-st|solo|ReceivingMessage|saturated`: 1.2× faster
- `blake3-servil-st|solo|ReceivingMessage|2 μs`: 1.2× faster
- `blake3-servil-mt|shared-one-cache|ReceivingMessage|saturated`: 1.2× faster
- `blake3-servil-mt|solo|ReceivingMessage|saturated`: 1.2× faster
- `blake3-servil-mt|solo|ReceivingMessage|2 μs`: 1.2× faster
- `blake3-servil-mt|shared-two-caches|ReceivingMessage|saturated`: 1.2× faster
- `blake3-servil-mt|shared-two-caches|ReceivingMessage|2 μs`: 1.2× faster
- `blake3-servil-mt|shared-one-cache|ReceivingMessage|2 μs`: 1.2× faster
- `blake3-servil-mt|shared-one-cache|MerkleTree|65536 x 32 B`: 1.1× faster
- `blake3-servil-mt|solo|IdleOneMessage|3839 B`: 1.0× faster

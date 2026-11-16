# The library's cells, 0.8.0 → 0.9.0 → 0.10 candidate: `x86-icelake`

Every verdict is `bench-hashes compare`'s over the kept runs of a release check. A time ratio below 1 is faster. Faster and slower need the pairs to agree; every other cell is level, which means insufficient evidence of a difference.

## 0.8.0 → 0.9.0

`old side: bench 3363bee8ff5e clean; servil b5b988d8982b clean`; `new side: bench 97c0fbcbedb8 clean; servil bf2da8b957f5 clean`

213 cells over 4 pairs: **10 faster, 1 slower**, the rest level.

| form | scenario | use case | cells | faster | slower | median time ratio | range |
|---|---|---|---:|---:|---:|---:|---|
| one thread | solo | OneMessage | 28 | 3 | 0 | ×1.000 | ×0.631–×1.015 |
| one thread | solo | ManyMessages | 24 | 0 | 1 | ×1.004 | ×0.981–×1.049 |
| one thread | solo | ManyLongMessages | 4 | 0 | 0 | ×0.998 | ×0.993–×1.009 |
| one thread | solo | IdleOneMessage | 28 | 3 | 0 | ×1.003 | ×0.692–×1.046 |
| one thread | solo | IdleManyMessages | 24 | 0 | 0 | ×0.996 | ×0.944–×1.064 |
| one thread | solo | BriefIdleOneMessage | 28 | 3 | 0 | ×1.002 | ×0.704–×1.061 |
| one thread | solo | BriefIdleManyMessages | 24 | 0 | 0 | ×0.998 | ×0.982–×1.050 |
| one thread | solo | ContinuousMessages | 13 | 0 | 0 | ×0.993 | ×0.924–×1.019 |
| one thread | solo | ContinuousBatches | 7 | 0 | 0 | ×0.988 | ×0.977–×0.994 |
| one thread | solo | LentMessages | 13 | 0 | 0 | ×1.003 | ×0.924–×1.008 |
| one thread | solo | Interleaved | 1 | 0 | 0 | ×0.993 | ×0.993–×0.993 |
| one thread | solo | Collection | 2 | 0 | 0 | ×0.983 | ×0.981–×0.985 |
| one thread | solo | LentBatches | 7 | 0 | 0 | ×0.988 | ×0.977–×0.994 |
| one thread | solo | ContinuousCollection | 2 | 1 | 0 | ×0.971 | ×0.966–×0.976 |
| one thread | solo | MerkleTree | 5 | 0 | 0 | ×1.002 | ×0.997–×1.005 |
| one thread | solo | InterleavedTurn | 1 | 0 | 0 | ×0.990 | ×0.990–×0.990 |
| one thread | solo | IdleInterleavedTurn | 1 | 0 | 0 | ×1.009 | ×1.009–×1.009 |
| one thread | solo | BriefIdleInterleavedTurn | 1 | 0 | 0 | ×0.914 | ×0.914–×0.914 |

Slower cells, each by name:

- `blake3-servil-st|solo|ManyMessages|6`: ×1.042

The ten largest gains:

- `blake3-servil-st|solo|OneMessage|7935 B`: ×0.631
- `blake3-servil-st|solo|OneMessage|3839 B`: ×0.639
- `blake3-servil-st|solo|OneMessage|3 KiB`: ×0.654
- `blake3-servil-st|solo|IdleOneMessage|3 KiB`: ×0.692
- `blake3-servil-st|solo|BriefIdleOneMessage|3839 B`: ×0.704
- `blake3-servil-st|solo|BriefIdleOneMessage|7935 B`: ×0.712
- `blake3-servil-st|solo|IdleOneMessage|7935 B`: ×0.790
- `blake3-servil-st|solo|IdleOneMessage|3839 B`: ×0.798
- `blake3-servil-st|solo|BriefIdleOneMessage|4 KiB`: ×0.818
- `blake3-servil-st|solo|ContinuousCollection|Nix files`: ×0.966

## 0.9.0 → 0.10 candidate

`old side: bench d7723f110a6f clean; servil bf2da8b957f5 clean`; `new side: bench cade30fdb716 clean; servil 7048303103c6 clean`

484 cells over 4 pairs: **52 faster, 6 slower**, the rest level.

| form | scenario | use case | cells | faster | slower | median time ratio | range |
|---|---|---|---:|---:|---:|---:|---|
| one thread | solo | OneMessage | 28 | 0 | 0 | ×0.999 | ×0.910–×1.265 |
| one thread | solo | ManyMessages | 24 | 0 | 1 | ×1.013 | ×0.983–×1.194 |
| one thread | solo | ManyLongMessages | 4 | 0 | 0 | ×0.997 | ×0.987–×1.003 |
| one thread | solo | IdleOneMessage | 28 | 0 | 0 | ×0.994 | ×0.946–×1.011 |
| one thread | solo | IdleManyMessages | 24 | 0 | 0 | ×0.991 | ×0.926–×1.023 |
| one thread | solo | BriefIdleOneMessage | 28 | 0 | 0 | ×1.000 | ×0.971–×1.009 |
| one thread | solo | BriefIdleManyMessages | 24 | 0 | 2 | ×1.005 | ×0.974–×1.098 |
| one thread | solo | ContinuousMessages | 13 | 0 | 0 | ×0.994 | ×0.974–×1.001 |
| one thread | solo | ContinuousBatches | 7 | 0 | 0 | ×1.001 | ×0.985–×1.019 |
| one thread | solo | LentMessages | 13 | 0 | 0 | ×0.999 | ×0.993–×1.005 |
| one thread | solo | Interleaved | 1 | 0 | 0 | ×1.004 | ×1.004–×1.004 |
| one thread | solo | Collection | 2 | 0 | 0 | ×1.002 | ×1.000–×1.003 |
| one thread | solo | LentBatches | 7 | 0 | 0 | ×1.001 | ×0.985–×1.019 |
| one thread | solo | ContinuousCollection | 2 | 0 | 0 | ×0.998 | ×0.997–×0.999 |
| one thread | solo | MerkleTree | 8 | 0 | 0 | ×0.994 | ×0.990–×0.998 |
| one thread | solo | InterleavedTurn | 2 | 0 | 0 | ×1.039 | ×1.024–×1.055 |
| one thread | solo | IdleInterleavedTurn | 2 | 0 | 0 | ×1.026 | ×1.023–×1.028 |
| one thread | solo | BriefIdleInterleavedTurn | 2 | 0 | 0 | ×1.039 | ×1.028–×1.050 |
| one thread | solo | ReceivingMessage | 3 | 2 | 0 | ×0.808 | ×0.807–×1.000 |
| every core | solo | OneMessage | 28 | 1 | 0 | ×0.994 | ×0.905–×1.088 |
| every core | solo | ManyMessages | 23 | 0 | 0 | ×1.016 | ×0.942–×1.206 |
| every core | solo | ManyLongMessages | 4 | 0 | 0 | ×1.000 | ×0.998–×1.099 |
| every core | solo | IdleOneMessage | 28 | 2 | 0 | ×0.986 | ×0.873–×1.053 |
| every core | solo | IdleManyMessages | 24 | 3 | 0 | ×0.977 | ×0.805–×1.042 |
| every core | solo | BriefIdleOneMessage | 28 | 4 | 0 | ×0.998 | ×0.788–×1.027 |
| every core | solo | BriefIdleManyMessages | 24 | 5 | 0 | ×1.002 | ×0.643–×1.099 |
| every core | solo | LentMessages | 13 | 3 | 0 | ×1.002 | ×0.746–×1.007 |
| every core | solo | Interleaved | 1 | 0 | 0 | ×0.998 | ×0.998–×0.998 |
| every core | solo | Collection | 2 | 1 | 0 | ×0.957 | ×0.907–×1.007 |
| every core | solo | LentBatches | 7 | 2 | 0 | ×0.995 | ×0.650–×1.018 |
| every core | solo | MerkleTree | 8 | 6 | 0 | ×0.820 | ×0.642–×1.004 |
| every core | solo | InterleavedTurn | 2 | 0 | 1 | ×1.046 | ×1.037–×1.055 |
| every core | solo | IdleInterleavedTurn | 2 | 0 | 0 | ×1.026 | ×1.004–×1.047 |
| every core | solo | BriefIdleInterleavedTurn | 2 | 0 | 1 | ×1.037 | ×1.035–×1.039 |
| every core | solo | ReceivingMessage | 1 | 0 | 0 | ×1.002 | ×1.002–×1.002 |
| every core | shared-one-cache | ContinuousBatches | 1 | 1 | 0 | ×0.716 | ×0.716–×0.716 |
| every core | shared-one-cache | LentMessages | 12 | 4 | 0 | ×0.998 | ×0.791–×1.056 |
| every core | shared-one-cache | Interleaved | 1 | 0 | 0 | ×1.004 | ×1.004–×1.004 |
| every core | shared-one-cache | Collection | 2 | 0 | 0 | ×1.039 | ×1.035–×1.043 |
| every core | shared-one-cache | LentBatches | 7 | 2 | 0 | ×0.992 | ×0.676–×1.009 |
| every core | shared-one-cache | MerkleTree | 7 | 4 | 0 | ×0.818 | ×0.624–×1.075 |
| every core | shared-one-cache | ReceivingMessage | 1 | 0 | 0 | ×1.002 | ×1.002–×1.002 |
| every core | shared-two-caches | ContinuousMessages | 1 | 1 | 0 | ×0.831 | ×0.831–×0.831 |
| every core | shared-two-caches | ContinuousBatches | 2 | 2 | 0 | ×0.877 | ×0.812–×0.941 |
| every core | shared-two-caches | LentMessages | 12 | 3 | 1 | ×1.000 | ×0.787–×1.047 |
| every core | shared-two-caches | Interleaved | 1 | 0 | 0 | ×1.041 | ×1.041–×1.041 |
| every core | shared-two-caches | Collection | 2 | 0 | 0 | ×1.011 | ×0.986–×1.037 |
| every core | shared-two-caches | LentBatches | 7 | 2 | 0 | ×0.991 | ×0.663–×1.032 |
| every core | shared-two-caches | MerkleTree | 8 | 4 | 0 | ×0.782 | ×0.571–×1.042 |
| every core | shared-two-caches | ReceivingMessage | 1 | 0 | 0 | ×1.002 | ×1.002–×1.002 |

Slower cells, each by name:

- `blake3-servil-st|solo|ManyMessages|8`: ×1.118
- `blake3-servil-st|solo|BriefIdleManyMessages|4`: ×1.051
- `blake3-servil-st|solo|BriefIdleManyMessages|8`: ×1.030
- `blake3-servil-mt|solo|InterleavedTurn|1024 x 1 KiB`: ×1.037
- `blake3-servil-mt|solo|BriefIdleInterleavedTurn|1024 x 1 KiB`: ×1.039
- `blake3-servil-mt|shared-two-caches|LentMessages|64 MiB`: ×1.047

The ten largest gains:

- `blake3-servil-mt|shared-two-caches|MerkleTree|65536 x 32 B`: ×0.571
- `blake3-servil-mt|shared-one-cache|MerkleTree|65536 x 32 B`: ×0.624
- `blake3-servil-mt|solo|MerkleTree|65536 x 32 B`: ×0.642
- `blake3-servil-mt|solo|BriefIdleManyMessages|65536`: ×0.643
- `blake3-servil-mt|solo|LentBatches|65536`: ×0.650
- `blake3-servil-mt|solo|BriefIdleManyMessages|16384`: ×0.658
- `blake3-servil-mt|shared-two-caches|LentBatches|16384`: ×0.663
- `blake3-servil-mt|shared-one-cache|LentBatches|65536`: ×0.676
- `blake3-servil-mt|solo|LentBatches|16384`: ×0.686
- `blake3-servil-mt|shared-two-caches|LentBatches|65536`: ×0.693

### Cells that move with the benchmark's own call (72)

The two bench releases call the library differently in these cells: the same library (`bench cade30fdb716 clean; servil 7048303103c6 clean`) under both benches already differs, so the tables above leave them out. Each line: the release comparison's ratio, then the same-library control's.

- `blake3-servil-mt|solo|ManyMessages|48`: ×1.021 level; control ×1.064 slower
- `blake3-servil-mt|solo|ContinuousMessages|64 B`: ×0.706 faster; control ×0.732 faster
- `blake3-servil-mt|solo|ContinuousMessages|128 B`: ×0.389 faster; control ×0.391 faster
- `blake3-servil-mt|solo|ContinuousMessages|256 B`: ×0.227 faster; control ×0.231 faster
- `blake3-servil-mt|solo|ContinuousMessages|512 B`: ×0.158 faster; control ×0.155 faster
- `blake3-servil-mt|solo|ContinuousMessages|1 KiB`: ×0.128 faster; control ×0.126 faster
- `blake3-servil-mt|solo|ContinuousMessages|4 KiB`: ×0.227 faster; control ×0.226 faster
- `blake3-servil-mt|solo|ContinuousMessages|16 KiB`: ×0.365 faster; control ×0.349 faster
- `blake3-servil-mt|solo|ContinuousMessages|64 KiB`: ×0.294 faster; control ×0.290 faster
- `blake3-servil-mt|solo|ContinuousMessages|256 KiB`: ×0.265 faster; control ×0.264 faster
- `blake3-servil-mt|solo|ContinuousMessages|1 MiB`: ×0.299 faster; control ×0.300 faster
- `blake3-servil-mt|solo|ContinuousMessages|4 MiB`: ×0.322 faster; control ×0.321 faster
- `blake3-servil-mt|solo|ContinuousMessages|16 MiB`: ×0.319 faster; control ×0.319 faster
- `blake3-servil-mt|solo|ContinuousMessages|64 MiB`: ×0.369 faster; control ×0.370 faster
- `blake3-servil-mt|solo|ContinuousBatches|16`: ×0.704 faster; control ×0.677 faster
- `blake3-servil-mt|solo|ContinuousBatches|64`: ×0.515 faster; control ×0.512 faster
- `blake3-servil-mt|solo|ContinuousBatches|256`: ×0.412 faster; control ×0.413 faster
- `blake3-servil-mt|solo|ContinuousBatches|1024`: ×0.365 faster; control ×0.358 faster
- `blake3-servil-mt|solo|ContinuousBatches|4096`: ×0.370 faster; control ×0.367 faster
- `blake3-servil-mt|solo|ContinuousBatches|16384`: ×0.540 faster; control ×0.797 faster
- `blake3-servil-mt|solo|ContinuousBatches|65536`: ×0.811 faster; control ×1.260 slower
- `blake3-servil-mt|solo|ContinuousCollection|git objects`: ×0.346 faster; control ×0.344 faster
- `blake3-servil-mt|solo|ContinuousCollection|Nix files`: ×0.329 faster; control ×0.335 faster
- `blake3-servil-mt|solo|ReceivingMessage|saturated`: ×0.246 faster; control ×0.284 faster
- `blake3-servil-mt|solo|ReceivingMessage|2 μs`: ×0.249 faster; control ×0.287 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|64 B`: ×0.737 faster; control ×0.775 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|128 B`: ×0.415 faster; control ×0.464 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|256 B`: ×0.249 faster; control ×0.271 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|512 B`: ×0.183 faster; control ×0.187 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|1 KiB`: ×0.139 faster; control ×0.139 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|4 KiB`: ×0.262 faster; control ×0.257 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|16 KiB`: ×0.396 faster; control ×0.393 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|64 KiB`: ×0.320 faster; control ×0.300 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|256 KiB`: ×0.276 faster; control ×0.281 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|1 MiB`: ×0.315 faster; control ×0.314 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|4 MiB`: ×0.336 faster; control ×0.340 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|16 MiB`: ×0.340 faster; control ×0.346 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|64 MiB`: ×0.393 faster; control ×0.401 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|16`: ×0.726 faster; control ×0.732 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|64`: ×0.544 faster; control ×0.546 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|256`: ×0.451 faster; control ×0.456 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|1024`: ×0.389 faster; control ×0.383 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|4096`: ×0.395 faster; control ×0.396 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|16384`: ×0.539 faster; control ×0.733 faster
- `blake3-servil-mt|shared-one-cache|LentMessages|64 B`: ×1.000 level; control ×1.032 slower
- `blake3-servil-mt|shared-one-cache|ContinuousCollection|git objects`: ×0.383 faster; control ×0.382 faster
- `blake3-servil-mt|shared-one-cache|ContinuousCollection|Nix files`: ×0.375 faster; control ×0.381 faster
- `blake3-servil-mt|shared-one-cache|MerkleTree|262144`: ×0.901 faster; control ×1.031 slower
- `blake3-servil-mt|shared-one-cache|ReceivingMessage|saturated`: ×0.276 faster; control ×0.327 faster
- `blake3-servil-mt|shared-one-cache|ReceivingMessage|2 μs`: ×0.279 faster; control ×0.329 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|128 B`: ×0.473 faster; control ×0.503 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|256 B`: ×0.280 faster; control ×0.276 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|512 B`: ×0.199 faster; control ×0.207 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|1 KiB`: ×0.165 faster; control ×0.167 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|4 KiB`: ×0.367 faster; control ×0.367 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|16 KiB`: ×0.506 faster; control ×0.512 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|64 KiB`: ×0.394 faster; control ×0.397 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|256 KiB`: ×0.365 faster; control ×0.371 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|1 MiB`: ×0.402 faster; control ×0.410 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|4 MiB`: ×0.421 faster; control ×0.422 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|16 MiB`: ×0.415 faster; control ×0.417 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|64 MiB`: ×0.439 faster; control ×0.437 faster
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|64`: ×0.740 faster; control ×0.748 faster
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|256`: ×0.613 faster; control ×0.630 faster
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|1024`: ×0.513 faster; control ×0.511 faster
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|4096`: ×0.500 faster; control ×0.512 faster
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|16384`: ×0.597 faster; control ×0.944 faster
- `blake3-servil-mt|shared-two-caches|LentMessages|64 B`: ×1.000 level; control ×1.033 slower
- `blake3-servil-mt|shared-two-caches|ContinuousCollection|git objects`: ×0.430 faster; control ×0.431 faster
- `blake3-servil-mt|shared-two-caches|ContinuousCollection|Nix files`: ×0.423 faster; control ×0.426 faster
- `blake3-servil-mt|shared-two-caches|ReceivingMessage|saturated`: ×0.341 faster; control ×0.403 faster
- `blake3-servil-mt|shared-two-caches|ReceivingMessage|2 μs`: ×0.344 faster; control ×0.404 faster

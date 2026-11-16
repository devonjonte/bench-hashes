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

## 0.9.0 → 0.10 candidate (ad163558)

`old side: bench d7723f110a6f clean; servil bf2da8b957f5 clean`; `new side: bench cade30fdb716 clean; servil ad163558bd88 clean`

488 cells over 4 pairs: **59 faster, 4 slower**, the rest level.

| form | scenario | use case | cells | faster | slower | median time ratio | range |
|---|---|---|---:|---:|---:|---:|---|
| one thread | solo | OneMessage | 28 | 0 | 0 | ×1.002 | ×0.931–×1.247 |
| one thread | solo | ManyMessages | 24 | 0 | 1 | ×1.014 | ×0.985–×1.097 |
| one thread | solo | ManyLongMessages | 4 | 0 | 0 | ×0.998 | ×0.996–×1.002 |
| one thread | solo | IdleOneMessage | 28 | 0 | 0 | ×1.001 | ×0.941–×1.053 |
| one thread | solo | IdleManyMessages | 24 | 0 | 0 | ×0.994 | ×0.958–×1.062 |
| one thread | solo | BriefIdleOneMessage | 28 | 0 | 0 | ×1.000 | ×0.972–×1.006 |
| one thread | solo | BriefIdleManyMessages | 24 | 0 | 0 | ×0.991 | ×0.896–×1.008 |
| one thread | solo | ContinuousMessages | 13 | 0 | 0 | ×0.997 | ×0.980–×1.006 |
| one thread | solo | ContinuousBatches | 7 | 0 | 0 | ×1.010 | ×0.941–×1.013 |
| one thread | solo | LentMessages | 13 | 0 | 0 | ×1.001 | ×0.983–×1.007 |
| one thread | solo | Interleaved | 1 | 0 | 0 | ×1.002 | ×1.002–×1.002 |
| one thread | solo | Collection | 2 | 0 | 0 | ×1.001 | ×1.000–×1.002 |
| one thread | solo | LentBatches | 7 | 0 | 0 | ×1.010 | ×0.941–×1.013 |
| one thread | solo | ContinuousCollection | 2 | 0 | 0 | ×0.998 | ×0.995–×1.000 |
| one thread | solo | MerkleTree | 8 | 0 | 0 | ×1.003 | ×0.986–×1.010 |
| one thread | solo | InterleavedTurn | 2 | 0 | 0 | ×1.027 | ×1.016–×1.038 |
| one thread | solo | IdleInterleavedTurn | 2 | 0 | 1 | ×1.025 | ×1.016–×1.034 |
| one thread | solo | BriefIdleInterleavedTurn | 2 | 0 | 0 | ×1.077 | ×1.035–×1.118 |
| one thread | solo | ReceivingMessage | 3 | 2 | 0 | ×0.804 | ×0.804–×1.000 |
| every core | solo | OneMessage | 28 | 0 | 0 | ×0.996 | ×0.914–×1.180 |
| every core | solo | ManyMessages | 24 | 1 | 2 | ×1.018 | ×0.938–×1.217 |
| every core | solo | ManyLongMessages | 4 | 0 | 0 | ×1.005 | ×0.999–×1.140 |
| every core | solo | IdleOneMessage | 28 | 4 | 0 | ×0.982 | ×0.844–×1.061 |
| every core | solo | IdleManyMessages | 24 | 6 | 0 | ×0.994 | ×0.781–×1.525 |
| every core | solo | BriefIdleOneMessage | 28 | 5 | 0 | ×0.991 | ×0.790–×1.014 |
| every core | solo | BriefIdleManyMessages | 24 | 5 | 0 | ×0.944 | ×0.645–×1.009 |
| every core | solo | LentMessages | 13 | 3 | 0 | ×0.997 | ×0.772–×1.005 |
| every core | solo | Interleaved | 1 | 0 | 0 | ×1.005 | ×1.005–×1.005 |
| every core | solo | Collection | 2 | 1 | 0 | ×0.963 | ×0.931–×0.995 |
| every core | solo | LentBatches | 7 | 2 | 0 | ×1.000 | ×0.678–×1.128 |
| every core | solo | MerkleTree | 8 | 6 | 0 | ×0.832 | ×0.650–×1.008 |
| every core | solo | InterleavedTurn | 2 | 0 | 0 | ×1.041 | ×1.025–×1.057 |
| every core | solo | IdleInterleavedTurn | 2 | 0 | 0 | ×1.035 | ×1.026–×1.044 |
| every core | solo | BriefIdleInterleavedTurn | 2 | 0 | 0 | ×1.063 | ×1.049–×1.077 |
| every core | solo | ReceivingMessage | 1 | 0 | 0 | ×1.002 | ×1.002–×1.002 |
| every core | shared-one-cache | ContinuousBatches | 1 | 1 | 0 | ×0.664 | ×0.664–×0.664 |
| every core | shared-one-cache | LentMessages | 13 | 4 | 0 | ×0.998 | ×0.770–×1.002 |
| every core | shared-one-cache | Interleaved | 1 | 0 | 0 | ×1.003 | ×1.003–×1.003 |
| every core | shared-one-cache | Collection | 2 | 0 | 0 | ×1.088 | ×1.034–×1.142 |
| every core | shared-one-cache | LentBatches | 7 | 2 | 0 | ×0.996 | ×0.652–×1.001 |
| every core | shared-one-cache | MerkleTree | 8 | 5 | 0 | ×0.828 | ×0.611–×1.013 |
| every core | shared-one-cache | ReceivingMessage | 1 | 0 | 0 | ×1.002 | ×1.002–×1.002 |
| every core | shared-two-caches | ContinuousMessages | 1 | 1 | 0 | ×0.844 | ×0.844–×0.844 |
| every core | shared-two-caches | ContinuousBatches | 2 | 2 | 0 | ×0.887 | ×0.837–×0.936 |
| every core | shared-two-caches | LentMessages | 13 | 3 | 0 | ×0.998 | ×0.813–×1.028 |
| every core | shared-two-caches | Interleaved | 1 | 0 | 0 | ×1.003 | ×1.003–×1.003 |
| every core | shared-two-caches | Collection | 2 | 0 | 0 | ×1.035 | ×0.987–×1.083 |
| every core | shared-two-caches | LentBatches | 7 | 2 | 0 | ×0.993 | ×0.688–×1.002 |
| every core | shared-two-caches | MerkleTree | 8 | 4 | 0 | ×0.764 | ×0.581–×1.012 |
| every core | shared-two-caches | ReceivingMessage | 1 | 0 | 0 | ×1.002 | ×1.002–×1.002 |

Slower cells, each by name:

- `blake3-servil-st|solo|ManyMessages|3`: ×1.093
- `blake3-servil-st|solo|IdleInterleavedTurn|1024 x 1 KiB`: ×1.034
- `blake3-servil-mt|solo|ManyMessages|1`: ×1.109
- `blake3-servil-mt|solo|ManyMessages|8192`: ×1.217

The ten largest gains:

- `blake3-servil-mt|shared-two-caches|MerkleTree|65536 x 32 B`: ×0.581
- `blake3-servil-mt|shared-one-cache|MerkleTree|65536 x 32 B`: ×0.611
- `blake3-servil-mt|solo|BriefIdleManyMessages|65536`: ×0.645
- `blake3-servil-mt|solo|MerkleTree|65536 x 32 B`: ×0.650
- `blake3-servil-mt|shared-one-cache|LentBatches|65536`: ×0.652
- `blake3-servil-mt|solo|BriefIdleManyMessages|32768`: ×0.655
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|65536`: ×0.664
- `blake3-servil-mt|solo|LentBatches|65536`: ×0.678
- `blake3-servil-mt|solo|BriefIdleManyMessages|16384`: ×0.681
- `blake3-servil-mt|shared-one-cache|LentBatches|16384`: ×0.687

### Cells that move with the benchmark's own call (68)

The two bench releases call the library differently in these cells: the same library (`bench cade30fdb716 clean; servil 7048303103c6 clean`) under both benches already differs, so the tables above leave them out. Each line: the release comparison's ratio, then the same-library control's.

- `blake3-servil-mt|solo|ContinuousMessages|64 B`: ×0.783 level; control ×0.732 faster
- `blake3-servil-mt|solo|ContinuousMessages|128 B`: ×0.431 faster; control ×0.391 faster
- `blake3-servil-mt|solo|ContinuousMessages|256 B`: ×0.244 faster; control ×0.231 faster
- `blake3-servil-mt|solo|ContinuousMessages|512 B`: ×0.167 faster; control ×0.155 faster
- `blake3-servil-mt|solo|ContinuousMessages|1 KiB`: ×0.126 faster; control ×0.126 faster
- `blake3-servil-mt|solo|ContinuousMessages|4 KiB`: ×0.231 faster; control ×0.226 faster
- `blake3-servil-mt|solo|ContinuousMessages|16 KiB`: ×0.347 faster; control ×0.349 faster
- `blake3-servil-mt|solo|ContinuousMessages|64 KiB`: ×0.290 faster; control ×0.290 faster
- `blake3-servil-mt|solo|ContinuousMessages|256 KiB`: ×0.267 faster; control ×0.264 faster
- `blake3-servil-mt|solo|ContinuousMessages|1 MiB`: ×0.298 faster; control ×0.300 faster
- `blake3-servil-mt|solo|ContinuousMessages|4 MiB`: ×0.317 faster; control ×0.321 faster
- `blake3-servil-mt|solo|ContinuousMessages|16 MiB`: ×0.319 faster; control ×0.319 faster
- `blake3-servil-mt|solo|ContinuousMessages|64 MiB`: ×0.354 faster; control ×0.370 faster
- `blake3-servil-mt|solo|ContinuousBatches|16`: ×0.714 faster; control ×0.677 faster
- `blake3-servil-mt|solo|ContinuousBatches|64`: ×0.516 faster; control ×0.512 faster
- `blake3-servil-mt|solo|ContinuousBatches|256`: ×0.418 faster; control ×0.413 faster
- `blake3-servil-mt|solo|ContinuousBatches|1024`: ×0.362 faster; control ×0.358 faster
- `blake3-servil-mt|solo|ContinuousBatches|4096`: ×0.369 faster; control ×0.367 faster
- `blake3-servil-mt|solo|ContinuousBatches|16384`: ×0.584 faster; control ×0.797 faster
- `blake3-servil-mt|solo|ContinuousBatches|65536`: ×0.876 level; control ×1.260 slower
- `blake3-servil-mt|solo|ContinuousCollection|git objects`: ×0.336 faster; control ×0.344 faster
- `blake3-servil-mt|solo|ContinuousCollection|Nix files`: ×0.326 faster; control ×0.335 faster
- `blake3-servil-mt|solo|ReceivingMessage|saturated`: ×0.258 faster; control ×0.284 faster
- `blake3-servil-mt|solo|ReceivingMessage|2 μs`: ×0.259 faster; control ×0.287 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|64 B`: ×0.723 faster; control ×0.775 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|128 B`: ×0.407 faster; control ×0.464 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|256 B`: ×0.238 faster; control ×0.271 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|512 B`: ×0.179 faster; control ×0.187 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|1 KiB`: ×0.140 faster; control ×0.139 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|4 KiB`: ×0.256 faster; control ×0.257 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|16 KiB`: ×0.392 faster; control ×0.393 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|64 KiB`: ×0.301 faster; control ×0.300 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|256 KiB`: ×0.277 faster; control ×0.281 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|1 MiB`: ×0.308 faster; control ×0.314 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|4 MiB`: ×0.322 faster; control ×0.340 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|16 MiB`: ×0.330 faster; control ×0.346 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|64 MiB`: ×0.396 faster; control ×0.401 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|16`: ×0.737 faster; control ×0.732 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|64`: ×0.545 faster; control ×0.546 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|256`: ×0.458 faster; control ×0.456 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|1024`: ×0.393 faster; control ×0.383 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|4096`: ×0.409 faster; control ×0.396 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|16384`: ×0.513 faster; control ×0.733 faster
- `blake3-servil-mt|shared-one-cache|ContinuousCollection|git objects`: ×0.384 faster; control ×0.382 faster
- `blake3-servil-mt|shared-one-cache|ContinuousCollection|Nix files`: ×0.379 faster; control ×0.381 faster
- `blake3-servil-mt|shared-one-cache|ReceivingMessage|saturated`: ×0.279 faster; control ×0.327 faster
- `blake3-servil-mt|shared-one-cache|ReceivingMessage|2 μs`: ×0.279 faster; control ×0.329 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|128 B`: ×0.456 faster; control ×0.503 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|256 B`: ×0.271 faster; control ×0.276 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|512 B`: ×0.196 faster; control ×0.207 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|1 KiB`: ×0.153 faster; control ×0.167 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|4 KiB`: ×0.365 faster; control ×0.367 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|16 KiB`: ×0.517 faster; control ×0.512 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|64 KiB`: ×0.390 faster; control ×0.397 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|256 KiB`: ×0.363 faster; control ×0.371 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|1 MiB`: ×0.393 faster; control ×0.410 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|4 MiB`: ×0.409 faster; control ×0.422 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|16 MiB`: ×0.410 faster; control ×0.417 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|64 MiB`: ×0.432 faster; control ×0.437 faster
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|64`: ×0.755 faster; control ×0.748 faster
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|256`: ×0.610 faster; control ×0.630 faster
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|1024`: ×0.500 faster; control ×0.511 faster
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|4096`: ×0.508 faster; control ×0.512 faster
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|16384`: ×0.603 faster; control ×0.944 faster
- `blake3-servil-mt|shared-two-caches|ContinuousCollection|git objects`: ×0.429 faster; control ×0.431 faster
- `blake3-servil-mt|shared-two-caches|ContinuousCollection|Nix files`: ×0.418 faster; control ×0.426 faster
- `blake3-servil-mt|shared-two-caches|ReceivingMessage|saturated`: ×0.347 faster; control ×0.403 faster
- `blake3-servil-mt|shared-two-caches|ReceivingMessage|2 μs`: ×0.346 faster; control ×0.404 faster

## 0.8.0 → 0.10 earlier (70483031)

`old side: bench 3363bee8ff5e clean; servil b5b988d8982b clean`; `new side: bench cade30fdb716 clean; servil 7048303103c6 clean`

213 cells over 4 pairs (8 of them measured again over more pairs and link layouts): **12 faster, 0 slower**, the rest level.

| form | scenario | use case | cells | faster | slower | median time ratio | range |
|---|---|---|---:|---:|---:|---:|---|
| one thread | solo | OneMessage | 28 | 3 | 0 | ×0.992 | ×0.636–×1.044 |
| one thread | solo | ManyMessages | 24 | 0 | 0 | ×1.007 | ×0.971–×1.064 |
| one thread | solo | ManyLongMessages | 4 | 0 | 0 | ×1.000 | ×0.994–×1.008 |
| one thread | solo | IdleOneMessage | 28 | 3 | 0 | ×0.998 | ×0.675–×1.045 |
| one thread | solo | IdleManyMessages | 24 | 0 | 0 | ×1.002 | ×0.952–×1.088 |
| one thread | solo | BriefIdleOneMessage | 28 | 3 | 0 | ×1.002 | ×0.685–×1.028 |
| one thread | solo | BriefIdleManyMessages | 24 | 0 | 0 | ×1.008 | ×0.994–×1.106 |
| one thread | solo | ContinuousMessages | 13 | 1 | 0 | ×0.990 | ×0.970–×1.187 |
| one thread | solo | ContinuousBatches | 7 | 0 | 0 | ×1.002 | ×0.996–×1.005 |
| one thread | solo | LentMessages | 13 | 0 | 0 | ×1.007 | ×0.921–×1.187 |
| one thread | solo | Interleaved | 1 | 0 | 0 | ×1.000 | ×1.000–×1.000 |
| one thread | solo | Collection | 2 | 1 | 0 | ×0.976 | ×0.967–×0.984 |
| one thread | solo | LentBatches | 7 | 0 | 0 | ×1.002 | ×0.979–×1.005 |
| one thread | solo | ContinuousCollection | 2 | 1 | 0 | ×0.972 | ×0.969–×0.975 |
| one thread | solo | MerkleTree | 5 | 0 | 0 | ×1.003 | ×1.001–×1.026 |
| one thread | solo | InterleavedTurn | 1 | 0 | 0 | ×1.013 | ×1.013–×1.013 |
| one thread | solo | IdleInterleavedTurn | 1 | 0 | 0 | ×1.064 | ×1.064–×1.064 |
| one thread | solo | BriefIdleInterleavedTurn | 1 | 0 | 0 | ×0.988 | ×0.988–×0.988 |

The ten largest gains:

- `blake3-servil-st|solo|OneMessage|7935 B`: ×0.636
- `blake3-servil-st|solo|OneMessage|3839 B`: ×0.660
- `blake3-servil-st|solo|OneMessage|3 KiB`: ×0.663
- `blake3-servil-st|solo|IdleOneMessage|3 KiB`: ×0.675
- `blake3-servil-st|solo|BriefIdleOneMessage|3 KiB`: ×0.685
- `blake3-servil-st|solo|BriefIdleOneMessage|3839 B`: ×0.702
- `blake3-servil-st|solo|IdleOneMessage|3839 B`: ×0.718
- `blake3-servil-st|solo|BriefIdleOneMessage|7935 B`: ×0.722
- `blake3-servil-st|solo|IdleOneMessage|7935 B`: ×0.747
- `blake3-servil-st|solo|Collection|Nix files`: ×0.967

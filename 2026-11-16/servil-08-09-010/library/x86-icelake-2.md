# The library's cells, 0.8.0 → 0.9.0 → 0.10 candidate: `x86-icelake-2`

Every verdict is `bench-hashes compare`'s over the kept runs of a release check. A time ratio below 1 is faster. Faster and slower need the pairs to agree; every other cell is level, which means insufficient evidence of a difference.

## 0.9.0 → 0.10 candidate

`old side: bench d7723f110a6f clean; servil bf2da8b957f5 clean`; `new side: bench cade30fdb716 clean; servil 7048303103c6 clean`

486 cells over 4 pairs: **42 faster, 1 slower**, the rest level.

| form | scenario | use case | cells | faster | slower | median time ratio | range |
|---|---|---|---:|---:|---:|---:|---|
| one thread | solo | OneMessage | 28 | 0 | 0 | ×0.999 | ×0.936–×1.099 |
| one thread | solo | ManyMessages | 24 | 0 | 0 | ×1.011 | ×0.973–×1.084 |
| one thread | solo | ManyLongMessages | 4 | 0 | 0 | ×0.995 | ×0.984–×1.003 |
| one thread | solo | IdleOneMessage | 28 | 0 | 0 | ×0.998 | ×0.926–×1.056 |
| one thread | solo | IdleManyMessages | 24 | 0 | 0 | ×1.007 | ×0.960–×1.127 |
| one thread | solo | BriefIdleOneMessage | 28 | 0 | 0 | ×0.999 | ×0.971–×1.044 |
| one thread | solo | BriefIdleManyMessages | 24 | 0 | 1 | ×1.002 | ×0.978–×1.082 |
| one thread | solo | ContinuousMessages | 13 | 0 | 0 | ×0.999 | ×0.962–×1.004 |
| one thread | solo | ContinuousBatches | 7 | 0 | 0 | ×1.000 | ×0.983–×1.016 |
| one thread | solo | LentMessages | 13 | 0 | 0 | ×0.999 | ×0.962–×1.004 |
| one thread | solo | Interleaved | 1 | 0 | 0 | ×1.002 | ×1.002–×1.002 |
| one thread | solo | Collection | 2 | 0 | 0 | ×0.998 | ×0.997–×0.999 |
| one thread | solo | LentBatches | 7 | 0 | 0 | ×1.000 | ×0.983–×1.016 |
| one thread | solo | ContinuousCollection | 2 | 0 | 0 | ×0.996 | ×0.996–×0.996 |
| one thread | solo | MerkleTree | 8 | 0 | 0 | ×0.993 | ×0.990–×1.005 |
| one thread | solo | InterleavedTurn | 2 | 0 | 0 | ×0.964 | ×0.907–×1.020 |
| one thread | solo | IdleInterleavedTurn | 2 | 0 | 0 | ×1.071 | ×1.028–×1.115 |
| one thread | solo | BriefIdleInterleavedTurn | 2 | 0 | 0 | ×1.031 | ×1.027–×1.035 |
| one thread | solo | ReceivingMessage | 3 | 2 | 0 | ×0.808 | ×0.806–×1.000 |
| every core | solo | OneMessage | 28 | 0 | 0 | ×0.993 | ×0.934–×1.071 |
| every core | solo | ManyMessages | 24 | 0 | 0 | ×1.008 | ×0.910–×1.053 |
| every core | solo | ManyLongMessages | 4 | 0 | 0 | ×0.996 | ×0.842–×1.098 |
| every core | solo | IdleOneMessage | 28 | 1 | 0 | ×1.002 | ×0.915–×1.070 |
| every core | solo | IdleManyMessages | 24 | 1 | 0 | ×0.990 | ×0.811–×1.057 |
| every core | solo | BriefIdleOneMessage | 28 | 2 | 0 | ×0.992 | ×0.817–×1.081 |
| every core | solo | BriefIdleManyMessages | 24 | 4 | 0 | ×0.998 | ×0.671–×1.058 |
| every core | solo | LentMessages | 13 | 2 | 0 | ×1.001 | ×0.741–×1.008 |
| every core | solo | Interleaved | 1 | 0 | 0 | ×1.004 | ×1.004–×1.004 |
| every core | solo | Collection | 2 | 0 | 0 | ×0.992 | ×0.990–×0.995 |
| every core | solo | LentBatches | 7 | 2 | 0 | ×1.000 | ×0.620–×1.014 |
| every core | solo | MerkleTree | 8 | 5 | 0 | ×0.799 | ×0.631–×1.008 |
| every core | solo | InterleavedTurn | 2 | 0 | 0 | ×1.123 | ×1.017–×1.229 |
| every core | solo | IdleInterleavedTurn | 2 | 0 | 0 | ×1.074 | ×1.023–×1.125 |
| every core | solo | BriefIdleInterleavedTurn | 2 | 0 | 0 | ×1.038 | ×1.027–×1.048 |
| every core | solo | ReceivingMessage | 1 | 0 | 0 | ×1.002 | ×1.002–×1.002 |
| every core | shared-one-cache | ContinuousBatches | 1 | 1 | 0 | ×0.671 | ×0.671–×0.671 |
| every core | shared-one-cache | LentMessages | 12 | 3 | 0 | ×0.998 | ×0.746–×1.015 |
| every core | shared-one-cache | Interleaved | 1 | 0 | 0 | ×0.994 | ×0.994–×0.994 |
| every core | shared-one-cache | Collection | 2 | 0 | 0 | ×1.087 | ×1.062–×1.113 |
| every core | shared-one-cache | LentBatches | 7 | 2 | 0 | ×0.991 | ×0.675–×1.052 |
| every core | shared-one-cache | MerkleTree | 8 | 5 | 0 | ×0.838 | ×0.628–×1.045 |
| every core | shared-one-cache | ReceivingMessage | 1 | 0 | 0 | ×1.002 | ×1.002–×1.002 |
| every core | shared-two-caches | ContinuousMessages | 1 | 1 | 0 | ×0.860 | ×0.860–×0.860 |
| every core | shared-two-caches | ContinuousBatches | 1 | 1 | 0 | ×0.836 | ×0.836–×0.836 |
| every core | shared-two-caches | LentMessages | 13 | 4 | 0 | ×0.998 | ×0.800–×1.000 |
| every core | shared-two-caches | Interleaved | 1 | 0 | 0 | ×0.997 | ×0.997–×0.997 |
| every core | shared-two-caches | Collection | 2 | 0 | 0 | ×1.000 | ×0.981–×1.019 |
| every core | shared-two-caches | LentBatches | 7 | 2 | 0 | ×0.990 | ×0.712–×1.002 |
| every core | shared-two-caches | MerkleTree | 8 | 4 | 0 | ×0.808 | ×0.607–×1.086 |
| every core | shared-two-caches | ReceivingMessage | 1 | 0 | 0 | ×1.002 | ×1.002–×1.002 |

Slower cells, each by name:

- `blake3-servil-st|solo|BriefIdleManyMessages|8`: ×1.040

The ten largest gains:

- `blake3-servil-mt|shared-two-caches|MerkleTree|65536 x 32 B`: ×0.607
- `blake3-servil-mt|solo|LentBatches|65536`: ×0.620
- `blake3-servil-mt|shared-one-cache|MerkleTree|65536 x 32 B`: ×0.628
- `blake3-servil-mt|solo|MerkleTree|65536 x 32 B`: ×0.631
- `blake3-servil-mt|solo|LentBatches|16384`: ×0.638
- `blake3-servil-mt|solo|BriefIdleManyMessages|65536`: ×0.671
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|65536`: ×0.671
- `blake3-servil-mt|solo|MerkleTree|16384`: ×0.672
- `blake3-servil-mt|shared-one-cache|LentBatches|65536`: ×0.675
- `blake3-servil-mt|solo|BriefIdleManyMessages|32768`: ×0.679

### Cells that move with the benchmark's own call (70)

The two bench releases call the library differently in these cells: the same library (`bench cade30fdb716 clean; servil 7048303103c6 clean`) under both benches already differs, so the tables above leave them out. Each line: the release comparison's ratio, then the same-library control's.

- `blake3-servil-mt|solo|ContinuousMessages|64 B`: ×0.713 faster; control ×0.735 faster
- `blake3-servil-mt|solo|ContinuousMessages|128 B`: ×0.415 faster; control ×0.395 faster
- `blake3-servil-mt|solo|ContinuousMessages|256 B`: ×0.225 faster; control ×0.232 faster
- `blake3-servil-mt|solo|ContinuousMessages|512 B`: ×0.156 faster; control ×0.163 faster
- `blake3-servil-mt|solo|ContinuousMessages|1 KiB`: ×0.130 faster; control ×0.130 faster
- `blake3-servil-mt|solo|ContinuousMessages|4 KiB`: ×0.221 faster; control ×0.225 faster
- `blake3-servil-mt|solo|ContinuousMessages|16 KiB`: ×0.363 faster; control ×0.361 faster
- `blake3-servil-mt|solo|ContinuousMessages|64 KiB`: ×0.294 faster; control ×0.290 faster
- `blake3-servil-mt|solo|ContinuousMessages|256 KiB`: ×0.266 faster; control ×0.264 faster
- `blake3-servil-mt|solo|ContinuousMessages|1 MiB`: ×0.296 faster; control ×0.297 faster
- `blake3-servil-mt|solo|ContinuousMessages|4 MiB`: ×0.313 faster; control ×0.320 faster
- `blake3-servil-mt|solo|ContinuousMessages|16 MiB`: ×0.315 faster; control ×0.320 faster
- `blake3-servil-mt|solo|ContinuousMessages|64 MiB`: ×0.352 faster; control ×0.366 faster
- `blake3-servil-mt|solo|ContinuousBatches|16`: ×0.661 faster; control ×0.694 faster
- `blake3-servil-mt|solo|ContinuousBatches|64`: ×0.507 faster; control ×0.514 faster
- `blake3-servil-mt|solo|ContinuousBatches|256`: ×0.402 faster; control ×0.403 faster
- `blake3-servil-mt|solo|ContinuousBatches|1024`: ×0.363 faster; control ×0.362 faster
- `blake3-servil-mt|solo|ContinuousBatches|4096`: ×0.369 faster; control ×0.367 faster
- `blake3-servil-mt|solo|ContinuousBatches|16384`: ×0.531 faster; control ×0.834 faster
- `blake3-servil-mt|solo|ContinuousBatches|65536`: ×0.760 level; control ×1.221 slower
- `blake3-servil-mt|solo|ContinuousCollection|git objects`: ×0.333 faster; control ×0.334 faster
- `blake3-servil-mt|solo|ContinuousCollection|Nix files`: ×0.325 faster; control ×0.325 faster
- `blake3-servil-mt|solo|ReceivingMessage|saturated`: ×0.257 faster; control ×0.296 faster
- `blake3-servil-mt|solo|ReceivingMessage|2 μs`: ×0.256 faster; control ×0.296 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|64 B`: ×0.727 faster; control ×0.747 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|128 B`: ×0.434 faster; control ×0.418 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|256 B`: ×0.261 faster; control ×0.244 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|512 B`: ×0.183 faster; control ×0.177 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|1 KiB`: ×0.142 faster; control ×0.142 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|4 KiB`: ×0.237 faster; control ×0.243 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|16 KiB`: ×0.409 faster; control ×0.394 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|64 KiB`: ×0.301 faster; control ×0.300 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|256 KiB`: ×0.280 faster; control ×0.283 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|1 MiB`: ×0.309 faster; control ×0.306 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|4 MiB`: ×0.317 faster; control ×0.314 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|16 MiB`: ×0.329 faster; control ×0.323 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|64 MiB`: ×0.398 faster; control ×0.389 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|16`: ×0.692 faster; control ×0.720 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|64`: ×0.543 faster; control ×0.525 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|256`: ×0.438 faster; control ×0.425 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|1024`: ×0.387 faster; control ×0.379 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|4096`: ×0.412 faster; control ×0.400 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|16384`: ×0.523 faster; control ×0.725 faster
- `blake3-servil-mt|shared-one-cache|LentMessages|64 B`: ×0.998 level; control ×1.031 slower
- `blake3-servil-mt|shared-one-cache|ContinuousCollection|git objects`: ×0.380 faster; control ×0.376 faster
- `blake3-servil-mt|shared-one-cache|ContinuousCollection|Nix files`: ×0.375 faster; control ×0.374 faster
- `blake3-servil-mt|shared-one-cache|ReceivingMessage|saturated`: ×0.278 faster; control ×0.321 faster
- `blake3-servil-mt|shared-one-cache|ReceivingMessage|2 μs`: ×0.279 faster; control ×0.322 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|128 B`: ×0.493 faster; control ×0.480 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|256 B`: ×0.282 faster; control ×0.280 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|512 B`: ×0.205 faster; control ×0.199 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|1 KiB`: ×0.164 faster; control ×0.162 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|4 KiB`: ×0.363 faster; control ×0.360 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|16 KiB`: ×0.508 faster; control ×0.490 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|64 KiB`: ×0.390 faster; control ×0.394 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|256 KiB`: ×0.361 faster; control ×0.369 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|1 MiB`: ×0.396 faster; control ×0.399 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|4 MiB`: ×0.406 faster; control ×0.406 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|16 MiB`: ×0.408 faster; control ×0.405 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|64 MiB`: ×0.433 faster; control ×0.429 faster
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|16`: ×0.906 faster; control ×0.945 faster
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|64`: ×0.739 faster; control ×0.758 faster
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|256`: ×0.598 faster; control ×0.592 faster
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|1024`: ×0.510 faster; control ×0.506 faster
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|4096`: ×0.514 faster; control ×0.507 faster
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|16384`: ×0.607 faster; control ×0.862 faster
- `blake3-servil-mt|shared-two-caches|ContinuousCollection|git objects`: ×0.433 faster; control ×0.425 faster
- `blake3-servil-mt|shared-two-caches|ContinuousCollection|Nix files`: ×0.425 faster; control ×0.414 faster
- `blake3-servil-mt|shared-two-caches|ReceivingMessage|saturated`: ×0.344 faster; control ×0.401 faster
- `blake3-servil-mt|shared-two-caches|ReceivingMessage|2 μs`: ×0.344 faster; control ×0.401 faster

## 0.8.0 → 0.10 candidate

`old side: bench 3363bee8ff5e clean; servil b5b988d8982b clean`; `new side: bench cade30fdb716 clean; servil 7048303103c6 clean`

213 cells over 4 pairs: **15 faster, 1 slower**, the rest level.

| form | scenario | use case | cells | faster | slower | median time ratio | range |
|---|---|---|---:|---:|---:|---:|---|
| one thread | solo | OneMessage | 28 | 3 | 0 | ×1.000 | ×0.620–×1.019 |
| one thread | solo | ManyMessages | 24 | 0 | 0 | ×0.998 | ×0.967–×1.030 |
| one thread | solo | ManyLongMessages | 4 | 0 | 0 | ×1.008 | ×1.005–×1.013 |
| one thread | solo | IdleOneMessage | 28 | 3 | 0 | ×1.003 | ×0.679–×1.073 |
| one thread | solo | IdleManyMessages | 24 | 0 | 0 | ×0.976 | ×0.792–×1.021 |
| one thread | solo | BriefIdleOneMessage | 28 | 4 | 0 | ×1.002 | ×0.664–×1.017 |
| one thread | solo | BriefIdleManyMessages | 24 | 0 | 0 | ×1.016 | ×0.979–×1.127 |
| one thread | solo | ContinuousMessages | 13 | 2 | 0 | ×0.992 | ×0.942–×1.007 |
| one thread | solo | ContinuousBatches | 7 | 0 | 0 | ×0.997 | ×0.975–×1.001 |
| one thread | solo | LentMessages | 13 | 2 | 0 | ×1.002 | ×0.942–×1.011 |
| one thread | solo | Interleaved | 1 | 0 | 0 | ×1.001 | ×1.001–×1.001 |
| one thread | solo | Collection | 2 | 0 | 0 | ×0.978 | ×0.971–×0.985 |
| one thread | solo | LentBatches | 7 | 0 | 0 | ×0.997 | ×0.975–×1.001 |
| one thread | solo | ContinuousCollection | 2 | 1 | 0 | ×0.974 | ×0.969–×0.978 |
| one thread | solo | MerkleTree | 5 | 0 | 1 | ×1.002 | ×1.000–×1.098 |
| one thread | solo | InterleavedTurn | 1 | 0 | 0 | ×1.057 | ×1.057–×1.057 |
| one thread | solo | IdleInterleavedTurn | 1 | 0 | 0 | ×1.047 | ×1.047–×1.047 |
| one thread | solo | BriefIdleInterleavedTurn | 1 | 0 | 0 | ×1.006 | ×1.006–×1.006 |

Slower cells, each by name:

- `blake3-servil-st|solo|MerkleTree|65536`: ×1.098

The ten largest gains:

- `blake3-servil-st|solo|OneMessage|3839 B`: ×0.620
- `blake3-servil-st|solo|OneMessage|3 KiB`: ×0.653
- `blake3-servil-st|solo|OneMessage|7935 B`: ×0.659
- `blake3-servil-st|solo|BriefIdleOneMessage|3 KiB`: ×0.664
- `blake3-servil-st|solo|IdleOneMessage|3 KiB`: ×0.679
- `blake3-servil-st|solo|BriefIdleOneMessage|3839 B`: ×0.705
- `blake3-servil-st|solo|BriefIdleOneMessage|7935 B`: ×0.719
- `blake3-servil-st|solo|IdleOneMessage|7935 B`: ×0.736
- `blake3-servil-st|solo|IdleOneMessage|3839 B`: ×0.784
- `blake3-servil-st|solo|BriefIdleOneMessage|4 KiB`: ×0.931

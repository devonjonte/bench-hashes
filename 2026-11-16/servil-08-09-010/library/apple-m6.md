# The library's cells, 0.8.0 → 0.9.0 → 0.10 candidate: `apple-m6`

Every verdict is `bench-hashes compare`'s over the kept runs of a release check. A time ratio below 1 is faster. Faster and slower need the pairs to agree; every other cell is level, which means insufficient evidence of a difference.

## 0.9.0 → 0.10 candidate (ad163558)

`old side: bench d7723f110a6f clean; servil bf2da8b957f5 clean`; `new side: bench cade30fdb716 clean; servil ad163558bd88 clean`

454 cells over 4 pairs (16 of them measured again over more pairs and link layouts): **15 faster, 6 slower**, the rest level.

| form | scenario | use case | cells | faster | slower | median time ratio | range |
|---|---|---|---:|---:|---:|---:|---|
| one thread | solo | OneMessage | 28 | 0 | 0 | ×1.004 | ×0.991–×1.032 |
| one thread | solo | ManyMessages | 24 | 0 | 2 | ×1.000 | ×0.967–×1.047 |
| one thread | solo | ManyLongMessages | 4 | 0 | 0 | ×0.996 | ×0.987–×1.009 |
| one thread | solo | IdleOneMessage | 28 | 0 | 0 | ×0.998 | ×0.970–×1.046 |
| one thread | solo | IdleManyMessages | 24 | 0 | 1 | ×0.996 | ×0.922–×1.030 |
| one thread | solo | BriefIdleOneMessage | 28 | 0 | 0 | ×1.000 | ×0.955–×1.033 |
| one thread | solo | BriefIdleManyMessages | 24 | 0 | 0 | ×0.980 | ×0.817–×1.022 |
| one thread | solo | ContinuousMessages | 13 | 0 | 0 | ×1.001 | ×0.974–×1.129 |
| one thread | solo | ContinuousBatches | 7 | 0 | 0 | ×1.001 | ×0.997–×1.002 |
| one thread | solo | LentMessages | 13 | 1 | 0 | ×1.001 | ×0.968–×1.077 |
| one thread | solo | Interleaved | 1 | 1 | 0 | ×0.950 | ×0.950–×0.950 |
| one thread | solo | Collection | 2 | 0 | 0 | ×0.994 | ×0.992–×0.995 |
| one thread | solo | LentBatches | 7 | 0 | 0 | ×1.001 | ×0.997–×1.002 |
| one thread | solo | ContinuousCollection | 2 | 0 | 0 | ×1.092 | ×1.082–×1.102 |
| one thread | solo | MerkleTree | 8 | 0 | 0 | ×0.997 | ×0.993–×1.001 |
| one thread | solo | InterleavedTurn | 2 | 1 | 0 | ×0.989 | ×0.958–×1.020 |
| one thread | solo | IdleInterleavedTurn | 2 | 0 | 0 | ×0.980 | ×0.955–×1.006 |
| one thread | solo | BriefIdleInterleavedTurn | 2 | 1 | 0 | ×0.982 | ×0.963–×1.000 |
| one thread | solo | ReceivingMessage | 3 | 2 | 0 | ×0.913 | ×0.913–×1.000 |
| every core | solo | OneMessage | 28 | 0 | 1 | ×1.002 | ×0.977–×1.047 |
| every core | solo | ManyMessages | 24 | 0 | 2 | ×1.018 | ×0.969–×1.108 |
| every core | solo | ManyLongMessages | 4 | 0 | 0 | ×1.000 | ×0.970–×1.002 |
| every core | solo | IdleOneMessage | 28 | 0 | 0 | ×0.997 | ×0.955–×1.079 |
| every core | solo | IdleManyMessages | 24 | 0 | 0 | ×0.998 | ×0.937–×1.013 |
| every core | solo | BriefIdleOneMessage | 28 | 2 | 0 | ×1.006 | ×0.868–×1.033 |
| every core | solo | BriefIdleManyMessages | 24 | 2 | 0 | ×0.972 | ×0.797–×1.011 |
| every core | solo | LentMessages | 13 | 2 | 0 | ×1.002 | ×0.941–×1.062 |
| every core | solo | Interleaved | 1 | 1 | 0 | ×0.951 | ×0.951–×0.951 |
| every core | solo | Collection | 2 | 0 | 0 | ×1.000 | ×0.985–×1.016 |
| every core | solo | LentBatches | 7 | 0 | 0 | ×1.000 | ×0.996–×1.004 |
| every core | solo | MerkleTree | 8 | 0 | 0 | ×0.994 | ×0.834–×1.009 |
| every core | solo | InterleavedTurn | 2 | 1 | 0 | ×0.989 | ×0.962–×1.017 |
| every core | solo | IdleInterleavedTurn | 2 | 0 | 0 | ×0.989 | ×0.965–×1.013 |
| every core | solo | BriefIdleInterleavedTurn | 2 | 0 | 0 | ×0.994 | ×0.978–×1.010 |
| every core | solo | ReceivingMessage | 1 | 0 | 0 | ×1.000 | ×1.000–×1.000 |
| every core | shared-os | ContinuousMessages | 1 | 1 | 0 | ×0.568 | ×0.568–×0.568 |
| every core | shared-os | ContinuousBatches | 1 | 0 | 0 | ×0.993 | ×0.993–×0.993 |
| every core | shared-os | LentMessages | 13 | 0 | 0 | ×1.001 | ×0.948–×1.140 |
| every core | shared-os | Interleaved | 1 | 0 | 0 | ×0.984 | ×0.984–×0.984 |
| every core | shared-os | Collection | 2 | 0 | 0 | ×0.985 | ×0.983–×0.987 |
| every core | shared-os | LentBatches | 7 | 0 | 0 | ×1.002 | ×0.996–×1.030 |
| every core | shared-os | MerkleTree | 8 | 0 | 0 | ×1.001 | ×0.948–×1.017 |
| every core | shared-os | ReceivingMessage | 1 | 0 | 0 | ×1.000 | ×1.000–×1.000 |

Slower cells, each by name:

- `blake3-servil-st|solo|ManyMessages|2`: ×1.032
- `blake3-servil-st|solo|ManyMessages|24`: ×1.047
- `blake3-servil-st|solo|IdleManyMessages|2`: ×1.030
- `blake3-servil-mt|solo|OneMessage|64 B`: ×1.039
- `blake3-servil-mt|solo|ManyMessages|2`: ×1.049
- `blake3-servil-mt|solo|ManyMessages|24`: ×1.043

The ten largest gains:

- `blake3-servil-mt|shared-os|ContinuousMessages|16 KiB`: ×0.568
- `blake3-servil-mt|solo|BriefIdleManyMessages|8192`: ×0.817
- `blake3-servil-mt|solo|BriefIdleOneMessage|1 MiB`: ×0.868
- `blake3-servil-mt|solo|BriefIdleOneMessage|512 KiB`: ×0.872
- `blake3-servil-mt|solo|BriefIdleManyMessages|16384`: ×0.912
- `blake3-servil-st|solo|ReceivingMessage|saturated`: ×0.913
- `blake3-servil-st|solo|ReceivingMessage|2 μs`: ×0.913
- `blake3-servil-mt|solo|LentMessages|1 MiB`: ×0.941
- `blake3-servil-st|solo|Interleaved|256`: ×0.950
- `blake3-servil-mt|solo|Interleaved|256`: ×0.951

### Cells that move with the benchmark's own call (46)

The two bench releases call the library differently in these cells: the same library (`bench cade30fdb716 clean; servil 7048303103c6 clean`) under both benches already differs, so the tables above leave them out. Each line: the release comparison's ratio, then the same-library control's.

- `blake3-servil-mt|solo|ContinuousMessages|64 B`: ×0.460 faster; control ×0.460 faster
- `blake3-servil-mt|solo|ContinuousMessages|128 B`: ×0.255 faster; control ×0.275 faster
- `blake3-servil-mt|solo|ContinuousMessages|256 B`: ×0.261 faster; control ×0.269 faster
- `blake3-servil-mt|solo|ContinuousMessages|512 B`: ×0.185 faster; control ×0.178 faster
- `blake3-servil-mt|solo|ContinuousMessages|1 KiB`: ×0.202 faster; control ×0.177 faster
- `blake3-servil-mt|solo|ContinuousMessages|4 KiB`: ×0.197 faster; control ×0.190 faster
- `blake3-servil-mt|solo|ContinuousMessages|16 KiB`: ×0.202 faster; control ×0.198 faster
- `blake3-servil-mt|solo|ContinuousMessages|64 KiB`: ×0.223 faster; control ×0.223 faster
- `blake3-servil-mt|solo|ContinuousMessages|256 KiB`: ×0.313 faster; control ×0.249 faster
- `blake3-servil-mt|solo|ContinuousMessages|1 MiB`: ×0.266 faster; control ×0.267 faster
- `blake3-servil-mt|solo|ContinuousMessages|4 MiB`: ×0.212 faster; control ×0.210 faster
- `blake3-servil-mt|solo|ContinuousMessages|16 MiB`: ×0.202 faster; control ×0.202 faster
- `blake3-servil-mt|solo|ContinuousMessages|64 MiB`: ×0.204 faster; control ×0.201 faster
- `blake3-servil-mt|solo|ContinuousBatches|16`: ×0.290 faster; control ×0.258 faster
- `blake3-servil-mt|solo|ContinuousBatches|64`: ×0.195 faster; control ×0.197 faster
- `blake3-servil-mt|solo|ContinuousBatches|256`: ×0.300 faster; control ×0.292 faster
- `blake3-servil-mt|solo|ContinuousBatches|1024`: ×0.341 faster; control ×0.334 faster
- `blake3-servil-mt|solo|ContinuousBatches|4096`: ×0.382 faster; control ×0.387 faster
- `blake3-servil-mt|solo|ContinuousBatches|16384`: ×0.509 faster; control ×0.531 faster
- `blake3-servil-mt|solo|ContinuousBatches|65536`: ×0.689 faster; control ×0.700 faster
- `blake3-servil-mt|solo|ContinuousCollection|git objects`: ×0.210 faster; control ×0.191 faster
- `blake3-servil-mt|solo|ContinuousCollection|Nix files`: ×0.232 faster; control ×0.216 faster
- `blake3-servil-mt|solo|ReceivingMessage|saturated`: ×0.161 faster; control ×0.174 faster
- `blake3-servil-mt|solo|ReceivingMessage|2 μs`: ×0.354 faster; control ×0.388 faster
- `blake3-servil-mt|shared-os|ContinuousMessages|64 B`: ×0.516 faster; control ×0.468 faster
- `blake3-servil-mt|shared-os|ContinuousMessages|128 B`: ×0.355 faster; control ×0.348 faster
- `blake3-servil-mt|shared-os|ContinuousMessages|256 B`: ×0.313 faster; control ×0.312 faster
- `blake3-servil-mt|shared-os|ContinuousMessages|512 B`: ×0.373 faster; control ×0.368 faster
- `blake3-servil-mt|shared-os|ContinuousMessages|1 KiB`: ×0.380 faster; control ×0.387 faster
- `blake3-servil-mt|shared-os|ContinuousMessages|4 KiB`: ×0.502 faster; control ×0.505 faster
- `blake3-servil-mt|shared-os|ContinuousMessages|64 KiB`: ×0.370 faster; control ×0.355 faster
- `blake3-servil-mt|shared-os|ContinuousMessages|256 KiB`: ×0.345 faster; control ×0.359 faster
- `blake3-servil-mt|shared-os|ContinuousMessages|1 MiB`: ×0.348 faster; control ×0.351 faster
- `blake3-servil-mt|shared-os|ContinuousMessages|4 MiB`: ×0.359 faster; control ×0.340 faster
- `blake3-servil-mt|shared-os|ContinuousMessages|16 MiB`: ×0.406 faster; control ×0.343 faster
- `blake3-servil-mt|shared-os|ContinuousMessages|64 MiB`: ×0.405 faster; control ×0.360 faster
- `blake3-servil-mt|shared-os|ContinuousBatches|16`: ×0.289 faster; control ×0.301 faster
- `blake3-servil-mt|shared-os|ContinuousBatches|64`: ×0.336 faster; control ×0.330 faster
- `blake3-servil-mt|shared-os|ContinuousBatches|256`: ×0.317 faster; control ×0.313 faster
- `blake3-servil-mt|shared-os|ContinuousBatches|1024`: ×0.327 faster; control ×0.325 faster
- `blake3-servil-mt|shared-os|ContinuousBatches|4096`: ×0.358 faster; control ×0.359 faster
- `blake3-servil-mt|shared-os|ContinuousBatches|16384`: ×0.902 level; control ×0.886 faster
- `blake3-servil-mt|shared-os|ContinuousCollection|git objects`: ×0.488 faster; control ×0.438 faster
- `blake3-servil-mt|shared-os|ContinuousCollection|Nix files`: ×0.560 faster; control ×0.493 faster
- `blake3-servil-mt|shared-os|ReceivingMessage|saturated`: ×0.310 faster; control ×0.315 faster
- `blake3-servil-mt|shared-os|ReceivingMessage|2 μs`: ×0.356 faster; control ×0.373 faster

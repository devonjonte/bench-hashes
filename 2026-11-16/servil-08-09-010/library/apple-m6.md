# The library's cells, 0.8.0 → 0.9.0 → 0.10 candidate: `apple-m6`

Every verdict is `bench-hashes compare`'s over the kept runs of a release check. A time ratio below 1 is faster. Faster and slower need the pairs to agree; every other cell is level, which means insufficient evidence of a difference.

## 0.9.0 → 0.10 candidate

`old side: bench d7723f110a6f clean; servil bf2da8b957f5 clean`; `new side: bench cade30fdb716 clean; servil 7048303103c6 clean`

447 cells over 4 pairs (14 of them measured again over more pairs and link layouts): **9 faster, 0 slower**, the rest level.

| form | scenario | use case | cells | faster | slower | median time ratio | range |
|---|---|---|---:|---:|---:|---:|---|
| one thread | solo | OneMessage | 28 | 1 | 0 | ×0.992 | ×0.893–×1.022 |
| one thread | solo | ManyMessages | 24 | 1 | 0 | ×0.998 | ×0.888–×1.042 |
| one thread | solo | ManyLongMessages | 4 | 0 | 0 | ×1.007 | ×0.998–×1.028 |
| one thread | solo | IdleOneMessage | 27 | 0 | 0 | ×1.007 | ×0.983–×1.033 |
| one thread | solo | IdleManyMessages | 24 | 0 | 0 | ×1.003 | ×0.958–×1.117 |
| one thread | solo | BriefIdleOneMessage | 28 | 0 | 0 | ×1.007 | ×0.980–×1.041 |
| one thread | solo | BriefIdleManyMessages | 24 | 0 | 0 | ×0.998 | ×0.918–×1.011 |
| one thread | solo | ContinuousMessages | 13 | 0 | 0 | ×1.001 | ×0.994–×1.025 |
| one thread | solo | ContinuousBatches | 7 | 0 | 0 | ×1.000 | ×0.998–×1.003 |
| one thread | solo | LentMessages | 13 | 0 | 0 | ×1.000 | ×0.994–×1.025 |
| one thread | solo | Interleaved | 1 | 1 | 0 | ×0.968 | ×0.968–×0.968 |
| one thread | solo | Collection | 2 | 0 | 0 | ×1.000 | ×0.998–×1.002 |
| one thread | solo | LentBatches | 7 | 0 | 0 | ×1.000 | ×0.998–×1.003 |
| one thread | solo | ContinuousCollection | 2 | 0 | 0 | ×1.000 | ×0.997–×1.002 |
| one thread | solo | MerkleTree | 8 | 0 | 0 | ×1.000 | ×0.995–×1.002 |
| one thread | solo | InterleavedTurn | 2 | 0 | 0 | ×1.000 | ×0.989–×1.010 |
| one thread | solo | IdleInterleavedTurn | 2 | 0 | 0 | ×0.974 | ×0.962–×0.985 |
| one thread | solo | BriefIdleInterleavedTurn | 2 | 0 | 0 | ×0.999 | ×0.984–×1.014 |
| one thread | solo | ReceivingMessage | 3 | 2 | 0 | ×0.913 | ×0.911–×1.000 |
| every core | solo | OneMessage | 28 | 0 | 0 | ×0.996 | ×0.909–×1.056 |
| every core | solo | ManyMessages | 24 | 0 | 0 | ×0.990 | ×0.929–×1.029 |
| every core | solo | ManyLongMessages | 4 | 0 | 0 | ×1.007 | ×0.971–×1.031 |
| every core | solo | IdleOneMessage | 28 | 0 | 0 | ×0.998 | ×0.944–×1.044 |
| every core | solo | IdleManyMessages | 24 | 0 | 0 | ×0.992 | ×0.954–×1.187 |
| every core | solo | BriefIdleOneMessage | 26 | 0 | 0 | ×1.008 | ×0.984–×1.028 |
| every core | solo | BriefIdleManyMessages | 22 | 1 | 0 | ×0.998 | ×0.909–×1.026 |
| every core | solo | LentMessages | 12 | 0 | 0 | ×1.002 | ×0.994–×1.021 |
| every core | solo | Interleaved | 1 | 1 | 0 | ×0.968 | ×0.968–×0.968 |
| every core | solo | Collection | 2 | 1 | 0 | ×0.976 | ×0.959–×0.992 |
| every core | solo | LentBatches | 7 | 0 | 0 | ×1.001 | ×0.991–×1.038 |
| every core | solo | MerkleTree | 7 | 0 | 0 | ×0.998 | ×0.942–×1.007 |
| every core | solo | InterleavedTurn | 2 | 0 | 0 | ×0.992 | ×0.979–×1.005 |
| every core | solo | IdleInterleavedTurn | 2 | 0 | 0 | ×0.974 | ×0.974–×0.975 |
| every core | solo | BriefIdleInterleavedTurn | 2 | 0 | 0 | ×1.006 | ×0.991–×1.021 |
| every core | solo | ReceivingMessage | 1 | 0 | 0 | ×1.000 | ×1.000–×1.000 |
| every core | shared-os | ContinuousMessages | 1 | 1 | 0 | ×0.472 | ×0.472–×0.472 |
| every core | shared-os | ContinuousBatches | 1 | 0 | 0 | ×1.002 | ×1.002–×1.002 |
| every core | shared-os | LentMessages | 13 | 0 | 0 | ×1.000 | ×0.988–×1.025 |
| every core | shared-os | Interleaved | 1 | 0 | 0 | ×0.985 | ×0.985–×0.985 |
| every core | shared-os | Collection | 2 | 0 | 0 | ×0.974 | ×0.953–×0.994 |
| every core | shared-os | LentBatches | 7 | 0 | 0 | ×0.999 | ×0.988–×1.013 |
| every core | shared-os | MerkleTree | 8 | 0 | 0 | ×0.996 | ×0.959–×1.027 |
| every core | shared-os | ReceivingMessage | 1 | 0 | 0 | ×1.000 | ×1.000–×1.000 |

The ten largest gains:

- `blake3-servil-mt|shared-os|ContinuousMessages|16 KiB`: ×0.472
- `blake3-servil-st|solo|ManyMessages|1`: ×0.888
- `blake3-servil-st|solo|OneMessage|64 B`: ×0.893
- `blake3-servil-mt|solo|BriefIdleManyMessages|16384`: ×0.909
- `blake3-servil-st|solo|ReceivingMessage|2 μs`: ×0.911
- `blake3-servil-st|solo|ReceivingMessage|saturated`: ×0.913
- `blake3-servil-mt|solo|Collection|Nix files`: ×0.959
- `blake3-servil-st|solo|Interleaved|256`: ×0.968
- `blake3-servil-mt|solo|Interleaved|256`: ×0.968

### Cells that move with the benchmark's own call (53)

The two bench releases call the library differently in these cells: the same library (`bench cade30fdb716 clean; servil 7048303103c6 clean`) under both benches already differs, so the tables above leave them out. Each line: the release comparison's ratio, then the same-library control's.

- `blake3-servil-st|solo|IdleOneMessage|64 B`: ×0.993 level; control ×1.030 slower
- `blake3-servil-mt|solo|BriefIdleOneMessage|512 KiB`: ×0.878 faster; control ×0.852 faster
- `blake3-servil-mt|solo|BriefIdleOneMessage|1 MiB`: ×0.879 faster; control ×0.876 faster
- `blake3-servil-mt|solo|BriefIdleManyMessages|1`: ×0.995 level; control ×0.953 faster
- `blake3-servil-mt|solo|BriefIdleManyMessages|8192`: ×0.832 faster; control ×0.799 faster
- `blake3-servil-mt|solo|ContinuousMessages|64 B`: ×0.452 faster; control ×0.460 faster
- `blake3-servil-mt|solo|ContinuousMessages|128 B`: ×0.266 faster; control ×0.275 faster
- `blake3-servil-mt|solo|ContinuousMessages|256 B`: ×0.268 faster; control ×0.269 faster
- `blake3-servil-mt|solo|ContinuousMessages|512 B`: ×0.188 faster; control ×0.178 faster
- `blake3-servil-mt|solo|ContinuousMessages|1 KiB`: ×0.173 faster; control ×0.177 faster
- `blake3-servil-mt|solo|ContinuousMessages|4 KiB`: ×0.190 faster; control ×0.190 faster
- `blake3-servil-mt|solo|ContinuousMessages|16 KiB`: ×0.200 faster; control ×0.198 faster
- `blake3-servil-mt|solo|ContinuousMessages|64 KiB`: ×0.221 faster; control ×0.223 faster
- `blake3-servil-mt|solo|ContinuousMessages|256 KiB`: ×0.312 faster; control ×0.249 faster
- `blake3-servil-mt|solo|ContinuousMessages|1 MiB`: ×0.252 faster; control ×0.267 faster
- `blake3-servil-mt|solo|ContinuousMessages|4 MiB`: ×0.210 faster; control ×0.210 faster
- `blake3-servil-mt|solo|ContinuousMessages|16 MiB`: ×0.202 faster; control ×0.202 faster
- `blake3-servil-mt|solo|ContinuousMessages|64 MiB`: ×0.202 faster; control ×0.201 faster
- `blake3-servil-mt|solo|ContinuousBatches|16`: ×0.275 faster; control ×0.258 faster
- `blake3-servil-mt|solo|ContinuousBatches|64`: ×0.178 faster; control ×0.197 faster
- `blake3-servil-mt|solo|ContinuousBatches|256`: ×0.303 faster; control ×0.292 faster
- `blake3-servil-mt|solo|ContinuousBatches|1024`: ×0.339 faster; control ×0.334 faster
- `blake3-servil-mt|solo|ContinuousBatches|4096`: ×0.378 faster; control ×0.387 faster
- `blake3-servil-mt|solo|ContinuousBatches|16384`: ×0.538 faster; control ×0.531 faster
- `blake3-servil-mt|solo|ContinuousBatches|65536`: ×0.686 faster; control ×0.700 faster
- `blake3-servil-mt|solo|LentMessages|1 MiB`: ×0.934 faster; control ×0.930 faster
- `blake3-servil-mt|solo|ContinuousCollection|git objects`: ×0.191 faster; control ×0.191 faster
- `blake3-servil-mt|solo|ContinuousCollection|Nix files`: ×0.216 faster; control ×0.216 faster
- `blake3-servil-mt|solo|MerkleTree|65536 x 32 B`: ×0.773 faster; control ×0.788 faster
- `blake3-servil-mt|solo|ReceivingMessage|saturated`: ×0.158 faster; control ×0.174 faster
- `blake3-servil-mt|solo|ReceivingMessage|2 μs`: ×0.354 faster; control ×0.388 faster
- `blake3-servil-mt|shared-os|ContinuousMessages|64 B`: ×0.487 faster; control ×0.468 faster
- `blake3-servil-mt|shared-os|ContinuousMessages|128 B`: ×0.340 faster; control ×0.348 faster
- `blake3-servil-mt|shared-os|ContinuousMessages|256 B`: ×0.316 faster; control ×0.312 faster
- `blake3-servil-mt|shared-os|ContinuousMessages|512 B`: ×0.368 faster; control ×0.368 faster
- `blake3-servil-mt|shared-os|ContinuousMessages|1 KiB`: ×0.376 faster; control ×0.387 faster
- `blake3-servil-mt|shared-os|ContinuousMessages|4 KiB`: ×0.490 faster; control ×0.505 faster
- `blake3-servil-mt|shared-os|ContinuousMessages|64 KiB`: ×0.339 faster; control ×0.355 faster
- `blake3-servil-mt|shared-os|ContinuousMessages|256 KiB`: ×0.341 faster; control ×0.359 faster
- `blake3-servil-mt|shared-os|ContinuousMessages|1 MiB`: ×0.345 faster; control ×0.351 faster
- `blake3-servil-mt|shared-os|ContinuousMessages|4 MiB`: ×0.344 faster; control ×0.340 faster
- `blake3-servil-mt|shared-os|ContinuousMessages|16 MiB`: ×0.347 faster; control ×0.343 faster
- `blake3-servil-mt|shared-os|ContinuousMessages|64 MiB`: ×0.360 faster; control ×0.360 faster
- `blake3-servil-mt|shared-os|ContinuousBatches|16`: ×0.300 faster; control ×0.301 faster
- `blake3-servil-mt|shared-os|ContinuousBatches|64`: ×0.324 faster; control ×0.330 faster
- `blake3-servil-mt|shared-os|ContinuousBatches|256`: ×0.317 faster; control ×0.313 faster
- `blake3-servil-mt|shared-os|ContinuousBatches|1024`: ×0.330 faster; control ×0.325 faster
- `blake3-servil-mt|shared-os|ContinuousBatches|4096`: ×0.356 faster; control ×0.359 faster
- `blake3-servil-mt|shared-os|ContinuousBatches|16384`: ×0.878 faster; control ×0.886 faster
- `blake3-servil-mt|shared-os|ContinuousCollection|git objects`: ×0.413 faster; control ×0.438 faster
- `blake3-servil-mt|shared-os|ContinuousCollection|Nix files`: ×0.490 faster; control ×0.493 faster
- `blake3-servil-mt|shared-os|ReceivingMessage|saturated`: ×0.309 faster; control ×0.315 faster
- `blake3-servil-mt|shared-os|ReceivingMessage|2 μs`: ×0.350 faster; control ×0.373 faster

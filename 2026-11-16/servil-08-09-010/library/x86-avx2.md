# The library's cells, 0.8.0 → 0.9.0 → 0.10 candidate: `x86-avx2`

Every verdict is `bench-hashes compare`'s over the kept runs of a release check. A time ratio below 1 is faster. Faster and slower need the pairs to agree; every other cell is level, which means insufficient evidence of a difference.

## 0.8.0 → 0.9.0

`old side: bench 3363bee8ff5e clean; servil b5b988d8982b clean`; `new side: bench 97c0fbcbedb8 clean; servil bf2da8b957f5 clean`

213 cells over 4 pairs: **4 faster, 1 slower**, the rest level.

| form | scenario | use case | cells | faster | slower | median time ratio | range |
|---|---|---|---:|---:|---:|---:|---|
| one thread | solo | OneMessage | 28 | 0 | 0 | ×1.007 | ×0.820–×1.103 |
| one thread | solo | ManyMessages | 24 | 0 | 0 | ×1.034 | ×0.983–×1.153 |
| one thread | solo | ManyLongMessages | 4 | 0 | 0 | ×1.008 | ×0.987–×1.021 |
| one thread | solo | IdleOneMessage | 28 | 0 | 0 | ×1.009 | ×0.676–×1.063 |
| one thread | solo | IdleManyMessages | 24 | 0 | 0 | ×1.011 | ×0.956–×1.052 |
| one thread | solo | BriefIdleOneMessage | 28 | 0 | 0 | ×1.010 | ×0.708–×1.068 |
| one thread | solo | BriefIdleManyMessages | 24 | 0 | 0 | ×1.002 | ×0.940–×1.034 |
| one thread | solo | ContinuousMessages | 13 | 2 | 0 | ×1.002 | ×0.845–×1.032 |
| one thread | solo | ContinuousBatches | 7 | 0 | 0 | ×0.995 | ×0.991–×1.010 |
| one thread | solo | LentMessages | 13 | 2 | 0 | ×0.997 | ×0.845–×1.019 |
| one thread | solo | Interleaved | 1 | 0 | 0 | ×0.973 | ×0.973–×0.973 |
| one thread | solo | Collection | 2 | 0 | 0 | ×0.933 | ×0.887–×0.980 |
| one thread | solo | LentBatches | 7 | 0 | 0 | ×0.995 | ×0.991–×1.010 |
| one thread | solo | ContinuousCollection | 2 | 0 | 0 | ×0.967 | ×0.959–×0.975 |
| one thread | solo | MerkleTree | 5 | 0 | 0 | ×1.002 | ×1.000–×1.014 |
| one thread | solo | InterleavedTurn | 1 | 0 | 1 | ×1.149 | ×1.149–×1.149 |
| one thread | solo | IdleInterleavedTurn | 1 | 0 | 0 | ×0.919 | ×0.919–×0.919 |
| one thread | solo | BriefIdleInterleavedTurn | 1 | 0 | 0 | ×0.985 | ×0.985–×0.985 |

Slower cells, each by name:

- `blake3-servil-st|solo|InterleavedTurn|256`: ×1.149

The ten largest gains:

- `blake3-servil-st|solo|ContinuousMessages|64 B`: ×0.845
- `blake3-servil-st|solo|LentMessages|64 B`: ×0.845
- `blake3-servil-st|solo|ContinuousMessages|128 B`: ×0.915
- `blake3-servil-st|solo|LentMessages|128 B`: ×0.915

## 0.9.0 → 0.10 candidate (ad163558)

`old side: bench d7723f110a6f clean; servil bf2da8b957f5 clean`; `new side: bench cade30fdb716 clean; servil ad163558bd88 clean`

489 cells over 4 pairs (18 of them measured again over more pairs and link layouts): **98 faster, 2 slower**, the rest level.

| form | scenario | use case | cells | faster | slower | median time ratio | range |
|---|---|---|---:|---:|---:|---:|---|
| one thread | solo | OneMessage | 28 | 7 | 0 | ×0.978 | ×0.761–×1.104 |
| one thread | solo | ManyMessages | 24 | 7 | 0 | ×0.940 | ×0.772–×1.025 |
| one thread | solo | ManyLongMessages | 4 | 1 | 0 | ×0.986 | ×0.873–×1.006 |
| one thread | solo | IdleOneMessage | 28 | 0 | 0 | ×0.996 | ×0.939–×1.033 |
| one thread | solo | IdleManyMessages | 24 | 1 | 0 | ×1.000 | ×0.914–×1.304 |
| one thread | solo | BriefIdleOneMessage | 28 | 1 | 0 | ×0.993 | ×0.950–×1.407 |
| one thread | solo | BriefIdleManyMessages | 24 | 3 | 0 | ×1.006 | ×0.882–×1.072 |
| one thread | solo | ContinuousMessages | 13 | 0 | 0 | ×0.992 | ×0.846–×1.010 |
| one thread | solo | ContinuousBatches | 7 | 0 | 0 | ×0.966 | ×0.783–×0.996 |
| one thread | solo | LentMessages | 13 | 0 | 0 | ×0.995 | ×0.846–×1.010 |
| one thread | solo | Interleaved | 1 | 0 | 0 | ×1.010 | ×1.010–×1.010 |
| one thread | solo | Collection | 2 | 0 | 0 | ×0.983 | ×0.980–×0.986 |
| one thread | solo | LentBatches | 7 | 0 | 0 | ×0.966 | ×0.783–×0.996 |
| one thread | solo | ContinuousCollection | 2 | 0 | 0 | ×0.890 | ×0.862–×0.918 |
| one thread | solo | MerkleTree | 8 | 0 | 1 | ×0.996 | ×0.938–×1.050 |
| one thread | solo | InterleavedTurn | 2 | 1 | 0 | ×0.891 | ×0.819–×0.963 |
| one thread | solo | IdleInterleavedTurn | 2 | 0 | 0 | ×0.942 | ×0.910–×0.973 |
| one thread | solo | BriefIdleInterleavedTurn | 2 | 0 | 0 | ×1.040 | ×1.011–×1.070 |
| one thread | solo | ReceivingMessage | 3 | 2 | 0 | ×0.848 | ×0.844–×1.000 |
| every core | solo | OneMessage | 28 | 8 | 0 | ×0.973 | ×0.322–×1.044 |
| every core | solo | ManyMessages | 24 | 6 | 0 | ×0.933 | ×0.283–×1.027 |
| every core | solo | ManyLongMessages | 4 | 1 | 0 | ×0.964 | ×0.337–×0.991 |
| every core | solo | IdleOneMessage | 28 | 6 | 1 | ×0.976 | ×0.421–×1.082 |
| every core | solo | IdleManyMessages | 24 | 6 | 0 | ×0.978 | ×0.352–×1.061 |
| every core | solo | BriefIdleOneMessage | 28 | 6 | 0 | ×0.986 | ×0.282–×1.031 |
| every core | solo | BriefIdleManyMessages | 24 | 6 | 0 | ×1.003 | ×0.244–×1.027 |
| every core | solo | ContinuousBatches | 1 | 1 | 0 | ×0.142 | ×0.142–×0.142 |
| every core | solo | LentMessages | 13 | 2 | 0 | ×0.995 | ×0.239–×1.006 |
| every core | solo | Interleaved | 1 | 0 | 0 | ×1.006 | ×1.006–×1.006 |
| every core | solo | Collection | 2 | 1 | 0 | ×0.684 | ×0.538–×0.830 |
| every core | solo | LentBatches | 7 | 2 | 0 | ×0.960 | ×0.138–×0.996 |
| every core | solo | MerkleTree | 8 | 7 | 0 | ×0.446 | ×0.088–×1.006 |
| every core | solo | InterleavedTurn | 2 | 0 | 0 | ×0.978 | ×0.973–×0.984 |
| every core | solo | IdleInterleavedTurn | 2 | 0 | 0 | ×0.938 | ×0.874–×1.002 |
| every core | solo | BriefIdleInterleavedTurn | 2 | 0 | 0 | ×1.002 | ×0.995–×1.008 |
| every core | solo | ReceivingMessage | 1 | 0 | 0 | ×1.000 | ×1.000–×1.000 |
| every core | shared-one-cache | ContinuousBatches | 1 | 1 | 0 | ×0.116 | ×0.116–×0.116 |
| every core | shared-one-cache | LentMessages | 13 | 3 | 0 | ×0.993 | ×0.115–×1.006 |
| every core | shared-one-cache | Interleaved | 1 | 0 | 0 | ×1.011 | ×1.011–×1.011 |
| every core | shared-one-cache | Collection | 2 | 0 | 0 | ×0.944 | ×0.943–×0.944 |
| every core | shared-one-cache | LentBatches | 7 | 2 | 0 | ×0.963 | ×0.052–×1.004 |
| every core | shared-one-cache | MerkleTree | 8 | 4 | 0 | ×0.755 | ×0.100–×0.995 |
| every core | shared-one-cache | ReceivingMessage | 1 | 0 | 0 | ×1.000 | ×1.000–×1.000 |
| every core | shared-two-caches | ContinuousMessages | 1 | 1 | 0 | ×0.661 | ×0.661–×0.661 |
| every core | shared-two-caches | ContinuousBatches | 2 | 1 | 0 | ×0.460 | ×0.087–×0.834 |
| every core | shared-two-caches | LentMessages | 13 | 3 | 0 | ×0.989 | ×0.099–×1.005 |
| every core | shared-two-caches | Interleaved | 1 | 0 | 0 | ×0.986 | ×0.986–×0.986 |
| every core | shared-two-caches | Collection | 2 | 0 | 0 | ×0.954 | ×0.933–×0.974 |
| every core | shared-two-caches | LentBatches | 7 | 2 | 0 | ×0.941 | ×0.077–×0.985 |
| every core | shared-two-caches | MerkleTree | 8 | 6 | 0 | ×0.734 | ×0.093–×1.040 |
| every core | shared-two-caches | ReceivingMessage | 1 | 0 | 0 | ×1.000 | ×1.000–×1.000 |

Slower cells, each by name:

- `blake3-servil-st|solo|MerkleTree|1048576 x 32 B`: ×1.050
- `blake3-servil-mt|solo|IdleOneMessage|3839 B`: ×1.082

The ten largest gains:

- `blake3-servil-mt|shared-one-cache|LentBatches|65536`: ×0.052
- `blake3-servil-mt|shared-two-caches|LentBatches|65536`: ×0.077
- `blake3-servil-mt|shared-two-caches|LentBatches|16384`: ×0.081
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|16384`: ×0.087
- `blake3-servil-mt|solo|MerkleTree|65536`: ×0.088
- `blake3-servil-mt|shared-one-cache|LentBatches|16384`: ×0.090
- `blake3-servil-mt|shared-two-caches|MerkleTree|16384`: ×0.093
- `blake3-servil-mt|shared-two-caches|LentMessages|1 MiB`: ×0.099
- `blake3-servil-mt|shared-one-cache|MerkleTree|16384`: ×0.100
- `blake3-servil-mt|shared-one-cache|LentMessages|4 MiB`: ×0.115

### Cells that move with the benchmark's own call (67)

The two bench releases call the library differently in these cells: the same library (`bench cade30fdb716 clean; servil 7048303103c6 clean`) under both benches already differs, so the tables above leave them out. Each line: the release comparison's ratio, then the same-library control's.

- `blake3-servil-mt|solo|ContinuousMessages|64 B`: ×0.683 faster; control ×0.674 faster
- `blake3-servil-mt|solo|ContinuousMessages|128 B`: ×0.366 faster; control ×0.356 faster
- `blake3-servil-mt|solo|ContinuousMessages|256 B`: ×0.201 faster; control ×0.204 faster
- `blake3-servil-mt|solo|ContinuousMessages|512 B`: ×0.137 faster; control ×0.131 faster
- `blake3-servil-mt|solo|ContinuousMessages|1 KiB`: ×0.101 faster; control ×0.099 faster
- `blake3-servil-mt|solo|ContinuousMessages|4 KiB`: ×0.234 faster; control ×0.233 faster
- `blake3-servil-mt|solo|ContinuousMessages|16 KiB`: ×0.277 faster; control ×0.253 faster
- `blake3-servil-mt|solo|ContinuousMessages|64 KiB`: ×0.243 faster; control ×0.232 faster
- `blake3-servil-mt|solo|ContinuousMessages|256 KiB`: ×0.241 faster; control ×0.239 faster
- `blake3-servil-mt|solo|ContinuousMessages|1 MiB`: ×0.235 faster; control ×0.233 faster
- `blake3-servil-mt|solo|ContinuousMessages|4 MiB`: ×0.208 faster; control ×0.210 faster
- `blake3-servil-mt|solo|ContinuousMessages|16 MiB`: ×0.205 faster; control ×0.208 faster
- `blake3-servil-mt|solo|ContinuousMessages|64 MiB`: ×0.242 faster; control ×0.264 faster
- `blake3-servil-mt|solo|ContinuousBatches|16`: ×0.375 faster; control ×0.378 faster
- `blake3-servil-mt|solo|ContinuousBatches|64`: ×0.361 level; control ×0.310 faster
- `blake3-servil-mt|solo|ContinuousBatches|256`: ×0.267 faster; control ×0.274 faster
- `blake3-servil-mt|solo|ContinuousBatches|1024`: ×0.251 faster; control ×0.245 faster
- `blake3-servil-mt|solo|ContinuousBatches|4096`: ×0.285 faster; control ×0.290 faster
- `blake3-servil-mt|solo|ContinuousBatches|65536`: ×0.352 faster; control ×2.019 slower
- `blake3-servil-mt|solo|ContinuousCollection|git objects`: ×0.198 faster; control ×0.257 faster
- `blake3-servil-mt|solo|ContinuousCollection|Nix files`: ×0.214 faster; control ×0.271 faster
- `blake3-servil-mt|solo|ReceivingMessage|saturated`: ×0.173 faster; control ×0.187 faster
- `blake3-servil-mt|solo|ReceivingMessage|2 μs`: ×0.339 faster; control ×0.387 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|64 B`: ×0.708 faster; control ×0.701 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|128 B`: ×0.372 faster; control ×0.373 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|256 B`: ×0.226 faster; control ×0.217 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|512 B`: ×0.153 faster; control ×0.149 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|1 KiB`: ×0.111 faster; control ×0.122 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|4 KiB`: ×0.375 faster; control ×0.372 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|16 KiB`: ×0.453 faster; control ×0.420 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|64 KiB`: ×0.340 faster; control ×0.356 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|256 KiB`: ×0.343 faster; control ×0.350 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|1 MiB`: ×0.332 faster; control ×0.359 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|4 MiB`: ×0.352 faster; control ×0.376 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|16 MiB`: ×0.324 faster; control ×0.323 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|64 MiB`: ×0.310 faster; control ×0.329 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|16`: ×0.423 faster; control ×0.459 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|64`: ×0.408 faster; control ×0.420 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|256`: ×0.394 faster; control ×0.399 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|1024`: ×0.372 faster; control ×0.394 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|4096`: ×0.461 faster; control ×0.471 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|65536`: ×0.106 faster; control ×2.186 slower
- `blake3-servil-mt|shared-one-cache|ContinuousCollection|git objects`: ×0.278 faster; control ×0.347 faster
- `blake3-servil-mt|shared-one-cache|ContinuousCollection|Nix files`: ×0.239 faster; control ×0.400 faster
- `blake3-servil-mt|shared-one-cache|ReceivingMessage|saturated`: ×0.263 faster; control ×0.307 faster
- `blake3-servil-mt|shared-one-cache|ReceivingMessage|2 μs`: ×0.325 faster; control ×0.373 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|64 B`: ×1.050 level; control ×1.216 slower
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|256 B`: ×0.401 faster; control ×0.392 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|512 B`: ×0.204 faster; control ×0.200 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|1 KiB`: ×0.160 faster; control ×0.155 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|4 KiB`: ×0.358 faster; control ×0.364 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|16 KiB`: ×0.426 faster; control ×0.419 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|64 KiB`: ×0.405 faster; control ×0.426 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|256 KiB`: ×0.413 faster; control ×0.428 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|1 MiB`: ×0.384 faster; control ×0.430 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|4 MiB`: ×0.401 faster; control ×0.417 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|16 MiB`: ×0.401 faster; control ×0.415 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|64 MiB`: ×0.422 faster; control ×0.431 faster
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|64`: ×0.639 faster; control ×0.649 faster
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|256`: ×0.585 faster; control ×0.588 faster
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|1024`: ×0.504 faster; control ×0.534 faster
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|4096`: ×0.546 faster; control ×0.562 faster
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|65536`: ×0.190 faster; control ×2.963 slower
- `blake3-servil-mt|shared-two-caches|ContinuousCollection|git objects`: ×0.336 faster; control ×0.400 faster
- `blake3-servil-mt|shared-two-caches|ContinuousCollection|Nix files`: ×0.299 faster; control ×0.415 faster
- `blake3-servil-mt|shared-two-caches|ReceivingMessage|saturated`: ×0.335 faster; control ×0.392 faster
- `blake3-servil-mt|shared-two-caches|ReceivingMessage|2 μs`: ×0.379 faster; control ×0.447 faster

## 0.8.0 → 0.10 earlier (70483031)

`old side: bench 3363bee8ff5e clean; servil b5b988d8982b clean`; `new side: bench cade30fdb716 clean; servil 7048303103c6 clean`

213 cells over 4 pairs (8 of them measured again over more pairs and link layouts): **7 faster, 0 slower**, the rest level.

| form | scenario | use case | cells | faster | slower | median time ratio | range |
|---|---|---|---:|---:|---:|---:|---|
| one thread | solo | OneMessage | 28 | 1 | 0 | ×1.013 | ×0.857–×1.080 |
| one thread | solo | ManyMessages | 24 | 0 | 0 | ×1.012 | ×0.951–×1.120 |
| one thread | solo | ManyLongMessages | 4 | 0 | 0 | ×1.009 | ×0.996–×1.033 |
| one thread | solo | IdleOneMessage | 28 | 1 | 0 | ×1.007 | ×0.724–×1.059 |
| one thread | solo | IdleManyMessages | 24 | 0 | 0 | ×1.007 | ×0.937–×1.105 |
| one thread | solo | BriefIdleOneMessage | 28 | 1 | 0 | ×1.006 | ×0.672–×1.197 |
| one thread | solo | BriefIdleManyMessages | 24 | 0 | 0 | ×1.008 | ×0.973–×1.042 |
| one thread | solo | ContinuousMessages | 13 | 2 | 0 | ×1.003 | ×0.848–×1.044 |
| one thread | solo | ContinuousBatches | 7 | 0 | 0 | ×1.013 | ×1.010–×1.116 |
| one thread | solo | LentMessages | 13 | 1 | 0 | ×1.003 | ×0.825–×1.022 |
| one thread | solo | Interleaved | 1 | 0 | 0 | ×0.997 | ×0.997–×0.997 |
| one thread | solo | Collection | 2 | 0 | 0 | ×0.944 | ×0.894–×0.993 |
| one thread | solo | LentBatches | 7 | 0 | 0 | ×1.013 | ×1.010–×1.116 |
| one thread | solo | ContinuousCollection | 2 | 0 | 0 | ×0.973 | ×0.962–×0.984 |
| one thread | solo | MerkleTree | 5 | 0 | 0 | ×1.006 | ×0.954–×1.015 |
| one thread | solo | InterleavedTurn | 1 | 0 | 0 | ×1.137 | ×1.137–×1.137 |
| one thread | solo | IdleInterleavedTurn | 1 | 1 | 0 | ×0.734 | ×0.734–×0.734 |
| one thread | solo | BriefIdleInterleavedTurn | 1 | 0 | 0 | ×0.953 | ×0.953–×0.953 |

The ten largest gains:

- `blake3-servil-st|solo|BriefIdleOneMessage|3 KiB`: ×0.672
- `blake3-servil-st|solo|IdleOneMessage|3 KiB`: ×0.724
- `blake3-servil-st|solo|IdleInterleavedTurn|256`: ×0.734
- `blake3-servil-st|solo|ContinuousMessages|64 B`: ×0.848
- `blake3-servil-st|solo|ContinuousMessages|128 B`: ×0.906
- `blake3-servil-st|solo|LentMessages|128 B`: ×0.906
- `blake3-servil-st|solo|OneMessage|3 KiB`: ×0.911

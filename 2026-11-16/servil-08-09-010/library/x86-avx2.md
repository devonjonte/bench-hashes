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

## 0.9.0 → 0.10 candidate

`old side: bench d7723f110a6f clean; servil bf2da8b957f5 clean`; `new side: bench cade30fdb716 clean; servil 7048303103c6 clean`

486 cells over 4 pairs (16 of them measured again over more pairs and link layouts): **102 faster, 1 slower**, the rest level.

| form | scenario | use case | cells | faster | slower | median time ratio | range |
|---|---|---|---:|---:|---:|---:|---|
| one thread | solo | OneMessage | 28 | 6 | 0 | ×0.985 | ×0.772–×1.079 |
| one thread | solo | ManyMessages | 24 | 8 | 0 | ×0.954 | ×0.821–×1.107 |
| one thread | solo | ManyLongMessages | 4 | 3 | 0 | ×0.951 | ×0.880–×0.959 |
| one thread | solo | IdleOneMessage | 28 | 1 | 0 | ×0.986 | ×0.882–×1.045 |
| one thread | solo | IdleManyMessages | 24 | 0 | 0 | ×0.996 | ×0.933–×1.078 |
| one thread | solo | BriefIdleOneMessage | 28 | 0 | 0 | ×0.991 | ×0.914–×1.028 |
| one thread | solo | BriefIdleManyMessages | 24 | 2 | 0 | ×0.992 | ×0.884–×1.059 |
| one thread | solo | ContinuousMessages | 13 | 1 | 0 | ×0.991 | ×0.949–×1.009 |
| one thread | solo | ContinuousBatches | 7 | 0 | 0 | ×1.002 | ×0.888–×1.036 |
| one thread | solo | LentMessages | 12 | 0 | 0 | ×0.992 | ×0.912–×1.009 |
| one thread | solo | Interleaved | 1 | 0 | 0 | ×0.998 | ×0.998–×0.998 |
| one thread | solo | Collection | 2 | 0 | 0 | ×0.995 | ×0.991–×0.999 |
| one thread | solo | LentBatches | 7 | 0 | 0 | ×1.002 | ×0.888–×1.036 |
| one thread | solo | ContinuousCollection | 2 | 0 | 0 | ×0.986 | ×0.982–×0.990 |
| one thread | solo | MerkleTree | 8 | 1 | 0 | ×0.995 | ×0.924–×1.019 |
| one thread | solo | InterleavedTurn | 2 | 0 | 0 | ×1.163 | ×0.976–×1.351 |
| one thread | solo | IdleInterleavedTurn | 2 | 0 | 0 | ×0.994 | ×0.978–×1.010 |
| one thread | solo | BriefIdleInterleavedTurn | 2 | 0 | 0 | ×1.048 | ×1.013–×1.084 |
| one thread | solo | ReceivingMessage | 3 | 2 | 0 | ×0.853 | ×0.851–×0.999 |
| every core | solo | OneMessage | 27 | 10 | 0 | ×0.966 | ×0.311–×1.054 |
| every core | solo | ManyMessages | 23 | 6 | 0 | ×0.946 | ×0.291–×0.998 |
| every core | solo | ManyLongMessages | 4 | 3 | 0 | ×0.946 | ×0.318–×0.952 |
| every core | solo | IdleOneMessage | 28 | 8 | 0 | ×0.964 | ×0.408–×1.041 |
| every core | solo | IdleManyMessages | 24 | 6 | 0 | ×0.958 | ×0.377–×1.068 |
| every core | solo | BriefIdleOneMessage | 28 | 7 | 0 | ×0.984 | ×0.291–×1.023 |
| every core | solo | BriefIdleManyMessages | 24 | 6 | 0 | ×0.992 | ×0.235–×1.040 |
| every core | solo | ContinuousBatches | 1 | 1 | 0 | ×0.093 | ×0.093–×0.093 |
| every core | solo | LentMessages | 13 | 3 | 0 | ×0.999 | ×0.215–×1.004 |
| every core | solo | Interleaved | 1 | 0 | 0 | ×0.980 | ×0.980–×0.980 |
| every core | solo | Collection | 2 | 0 | 0 | ×0.901 | ×0.874–×0.928 |
| every core | solo | LentBatches | 7 | 2 | 0 | ×1.002 | ×0.081–×1.063 |
| every core | solo | MerkleTree | 8 | 6 | 0 | ×0.492 | ×0.126–×1.003 |
| every core | solo | InterleavedTurn | 2 | 0 | 0 | ×1.117 | ×0.983–×1.251 |
| every core | solo | IdleInterleavedTurn | 2 | 0 | 0 | ×0.990 | ×0.984–×0.995 |
| every core | solo | BriefIdleInterleavedTurn | 2 | 0 | 0 | ×1.015 | ×1.009–×1.022 |
| every core | solo | ReceivingMessage | 1 | 0 | 0 | ×1.000 | ×1.000–×1.000 |
| every core | shared-one-cache | ContinuousBatches | 1 | 1 | 0 | ×0.084 | ×0.084–×0.084 |
| every core | shared-one-cache | LentMessages | 13 | 2 | 0 | ×0.992 | ×0.103–×1.004 |
| every core | shared-one-cache | Interleaved | 1 | 0 | 0 | ×1.029 | ×1.029–×1.029 |
| every core | shared-one-cache | Collection | 2 | 1 | 0 | ×0.885 | ×0.884–×0.887 |
| every core | shared-one-cache | LentBatches | 7 | 2 | 0 | ×1.004 | ×0.039–×1.064 |
| every core | shared-one-cache | MerkleTree | 8 | 3 | 0 | ×0.732 | ×0.079–×1.049 |
| every core | shared-one-cache | ReceivingMessage | 1 | 0 | 0 | ×1.000 | ×1.000–×1.000 |
| every core | shared-two-caches | ContinuousMessages | 1 | 1 | 0 | ×0.639 | ×0.639–×0.639 |
| every core | shared-two-caches | ContinuousBatches | 2 | 1 | 0 | ×0.434 | ×0.074–×0.795 |
| every core | shared-two-caches | LentMessages | 13 | 3 | 1 | ×0.988 | ×0.091–×1.094 |
| every core | shared-two-caches | Interleaved | 1 | 0 | 0 | ×0.960 | ×0.960–×0.960 |
| every core | shared-two-caches | Collection | 2 | 1 | 0 | ×0.845 | ×0.774–×0.915 |
| every core | shared-two-caches | LentBatches | 7 | 2 | 0 | ×0.999 | ×0.075–×1.069 |
| every core | shared-two-caches | MerkleTree | 8 | 3 | 0 | ×0.708 | ×0.091–×0.996 |
| every core | shared-two-caches | ReceivingMessage | 1 | 0 | 0 | ×1.000 | ×1.000–×1.000 |

Slower cells, each by name:

- `blake3-servil-mt|shared-two-caches|LentMessages|64 MiB`: ×1.094

The ten largest gains:

- `blake3-servil-mt|shared-one-cache|LentBatches|65536`: ×0.039
- `blake3-servil-mt|shared-one-cache|LentBatches|16384`: ×0.073
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|16384`: ×0.074
- `blake3-servil-mt|shared-two-caches|LentBatches|16384`: ×0.075
- `blake3-servil-mt|shared-one-cache|MerkleTree|16384`: ×0.079
- `blake3-servil-mt|shared-two-caches|LentBatches|65536`: ×0.079
- `blake3-servil-mt|solo|LentBatches|65536`: ×0.081
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|16384`: ×0.084
- `blake3-servil-mt|shared-two-caches|LentMessages|4 MiB`: ×0.091
- `blake3-servil-mt|shared-two-caches|MerkleTree|16384`: ×0.091

### Cells that move with the benchmark's own call (70)

The two bench releases call the library differently in these cells: the same library (`bench cade30fdb716 clean; servil 7048303103c6 clean`) under both benches already differs, so the tables above leave them out. Each line: the release comparison's ratio, then the same-library control's.

- `blake3-servil-st|solo|LentMessages|16 MiB`: ×0.976 level; control ×1.031 slower
- `blake3-servil-mt|solo|OneMessage|2 KiB`: ×0.894 level; control ×1.136 slower
- `blake3-servil-mt|solo|ManyMessages|32768`: ×0.313 faster; control ×0.837 faster
- `blake3-servil-mt|solo|ContinuousMessages|64 B`: ×0.756 faster; control ×0.674 faster
- `blake3-servil-mt|solo|ContinuousMessages|128 B`: ×0.363 faster; control ×0.356 faster
- `blake3-servil-mt|solo|ContinuousMessages|256 B`: ×0.209 faster; control ×0.204 faster
- `blake3-servil-mt|solo|ContinuousMessages|512 B`: ×0.132 faster; control ×0.131 faster
- `blake3-servil-mt|solo|ContinuousMessages|1 KiB`: ×0.102 faster; control ×0.099 faster
- `blake3-servil-mt|solo|ContinuousMessages|4 KiB`: ×0.240 faster; control ×0.233 faster
- `blake3-servil-mt|solo|ContinuousMessages|16 KiB`: ×0.269 faster; control ×0.253 faster
- `blake3-servil-mt|solo|ContinuousMessages|64 KiB`: ×0.227 faster; control ×0.232 faster
- `blake3-servil-mt|solo|ContinuousMessages|256 KiB`: ×0.225 faster; control ×0.239 faster
- `blake3-servil-mt|solo|ContinuousMessages|1 MiB`: ×0.227 faster; control ×0.233 faster
- `blake3-servil-mt|solo|ContinuousMessages|4 MiB`: ×0.217 faster; control ×0.210 faster
- `blake3-servil-mt|solo|ContinuousMessages|16 MiB`: ×0.201 faster; control ×0.208 faster
- `blake3-servil-mt|solo|ContinuousMessages|64 MiB`: ×0.251 faster; control ×0.264 faster
- `blake3-servil-mt|solo|ContinuousBatches|16`: ×0.375 faster; control ×0.378 faster
- `blake3-servil-mt|solo|ContinuousBatches|64`: ×0.291 faster; control ×0.310 faster
- `blake3-servil-mt|solo|ContinuousBatches|256`: ×0.264 faster; control ×0.274 faster
- `blake3-servil-mt|solo|ContinuousBatches|1024`: ×0.249 faster; control ×0.245 faster
- `blake3-servil-mt|solo|ContinuousBatches|4096`: ×0.276 faster; control ×0.290 faster
- `blake3-servil-mt|solo|ContinuousBatches|65536`: ×0.159 faster; control ×2.019 slower
- `blake3-servil-mt|solo|ContinuousCollection|git objects`: ×0.251 faster; control ×0.257 faster
- `blake3-servil-mt|solo|ContinuousCollection|Nix files`: ×0.224 faster; control ×0.271 faster
- `blake3-servil-mt|solo|ReceivingMessage|saturated`: ×0.159 faster; control ×0.187 faster
- `blake3-servil-mt|solo|ReceivingMessage|2 μs`: ×0.339 faster; control ×0.387 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|64 B`: ×0.713 faster; control ×0.701 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|128 B`: ×0.374 faster; control ×0.373 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|256 B`: ×0.230 faster; control ×0.217 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|512 B`: ×0.148 faster; control ×0.149 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|1 KiB`: ×0.116 faster; control ×0.122 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|4 KiB`: ×0.359 faster; control ×0.372 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|16 KiB`: ×0.413 faster; control ×0.420 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|64 KiB`: ×0.341 faster; control ×0.356 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|256 KiB`: ×0.344 faster; control ×0.350 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|1 MiB`: ×0.340 faster; control ×0.359 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|4 MiB`: ×0.346 faster; control ×0.376 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|16 MiB`: ×0.313 faster; control ×0.323 faster
- `blake3-servil-mt|shared-one-cache|ContinuousMessages|64 MiB`: ×0.323 faster; control ×0.329 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|16`: ×0.458 faster; control ×0.459 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|64`: ×0.420 faster; control ×0.420 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|256`: ×0.412 faster; control ×0.399 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|1024`: ×0.374 faster; control ×0.394 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|4096`: ×0.464 faster; control ×0.471 faster
- `blake3-servil-mt|shared-one-cache|ContinuousBatches|65536`: ×0.086 faster; control ×2.186 slower
- `blake3-servil-mt|shared-one-cache|ContinuousCollection|git objects`: ×0.306 faster; control ×0.347 faster
- `blake3-servil-mt|shared-one-cache|ContinuousCollection|Nix files`: ×0.271 faster; control ×0.400 faster
- `blake3-servil-mt|shared-one-cache|ReceivingMessage|saturated`: ×0.272 faster; control ×0.307 faster
- `blake3-servil-mt|shared-one-cache|ReceivingMessage|2 μs`: ×0.328 faster; control ×0.373 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|64 B`: ×1.299 slower; control ×1.216 slower
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|256 B`: ×0.388 faster; control ×0.392 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|512 B`: ×0.211 faster; control ×0.200 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|1 KiB`: ×0.157 faster; control ×0.155 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|4 KiB`: ×0.350 faster; control ×0.364 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|16 KiB`: ×0.431 faster; control ×0.419 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|64 KiB`: ×0.418 faster; control ×0.426 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|256 KiB`: ×0.412 faster; control ×0.428 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|1 MiB`: ×0.373 faster; control ×0.430 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|4 MiB`: ×0.420 faster; control ×0.417 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|16 MiB`: ×0.414 faster; control ×0.415 faster
- `blake3-servil-mt|shared-two-caches|ContinuousMessages|64 MiB`: ×0.440 faster; control ×0.431 faster
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|64`: ×0.652 faster; control ×0.649 faster
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|256`: ×0.588 faster; control ×0.588 faster
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|1024`: ×0.524 faster; control ×0.534 faster
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|4096`: ×0.540 faster; control ×0.562 faster
- `blake3-servil-mt|shared-two-caches|ContinuousBatches|65536`: ×0.196 faster; control ×2.963 slower
- `blake3-servil-mt|shared-two-caches|ContinuousCollection|git objects`: ×0.361 faster; control ×0.400 faster
- `blake3-servil-mt|shared-two-caches|ContinuousCollection|Nix files`: ×0.317 faster; control ×0.415 faster
- `blake3-servil-mt|shared-two-caches|ReceivingMessage|saturated`: ×0.339 faster; control ×0.392 faster
- `blake3-servil-mt|shared-two-caches|ReceivingMessage|2 μs`: ×0.395 faster; control ×0.447 faster

## 0.8.0 → 0.10 candidate

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

# Guided runs (BLAKE3 #87)

`lib*`: `perf_regress compare c7b8111 3fcb8b8`, no cell slower. `b3sum/`:
the b3sum suite, 4 layouts a build: 256 MiB from storage 82.4 -> 79.5 ms
(official 80.1), 1 GiB 334 -> 327 (official 325), 1 GiB cached 36.7 ->
31.2.

# v0.8 release check on x86-64: candidate/minimalism-0.8 (BLAKE3 #94, #99)

i7-12700K, Linux 7.0, quiet. The candidate at 7334cbe with BLAKE3 #99's two
commits (collect() wakes a worker for a waiting task; a doc link).

- `matrix.stdout.txt`: every suite, GCC and Clang, ASan, TSan, Miri; the C
  API's test hung on 20 threads before #99 (`from_c`, the caller spinning in
  b3_stream_collect, every worker parked), and passes with it.
- `check-collect.*`: `bench-hashes check` of #99 against 7334cbe, every
  point (the manifest changed): no cell slower.
- `check-release.*`, `samples/`: `bench-hashes check --against servil
  --pairs 8` (servil 13d1216 against the candidate with #99), every point,
  servil st and mt: no cell slower, 308 cells.

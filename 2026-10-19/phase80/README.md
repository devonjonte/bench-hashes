# #29's phase split, measured (BLAKE3 #80, bench-hashes #29)

`perf_regress compare dea45dc dea45dc --bench 425821f8 61951fcb`: the same
code under the bench with and without the phase split; no cell differs,
so #80's +18% belongs to the code.

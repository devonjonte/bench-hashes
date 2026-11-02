# The pool's wake after a pause, by input size (i7-12700K)

**Question.** Sam's after-pause protocol (bench-hashes #117) read servil
mt's 1 MiB call at x3.6 its steady time after a 20 us pause. What does
waking the pool cost by pause length and input size, and where does the
split threshold (MIN_SPLIT_LEN, 512 KiB) pay after a pause on this machine?

**Commits.** blake3-servil f6f9db16 (0.8 plus docs; lanes.rs as at 0.8).
`wake_probe.rs` (examples/, in the data): after a pause of 0, 20, 200,
1000 or 5000 us (a sleep), one call on 64 KiB-4 MiB, multithreaded
(performance::hash_multithreaded) and on the caller's thread alone
(performance::hash), shuffled, 200 visits each; the caller on CPU 2.

**Result** (`analysis.txt`, medians in us):

| size | steady mt / st | 20 us | 200 us | 1 ms | 5 ms |
|---|---|---|---|---|---|
| 256 KiB | 49.5 / 49.5 | 52 / 52 | 51 / 51 | 49 / 50 | 57 / 57 |
| 512 KiB | 21.0 / 99 (x0.21) | 30 / 104 (x0.29) | 69 / 102 (x0.67) | 88 / 101 (x0.87) | 101 / 111 (x0.91) |
| 1 MiB | 33.1 / 199 (x0.17) | 48 / 208 (x0.23) | 91 / 204 (x0.44) | 103 / 201 (x0.51) | 118 / 222 (x0.53) |
| 4 MiB | 106 / 799 (x0.13) | 128 / 829 (x0.15) | 155 / 819 (x0.19) | 188 / 835 (x0.22) | 209 / 882 (x0.24) |

- Below 512 KiB the two read alike: the caller hashes alone, as
  MIN_SPLIT_LEN says.
- The pool's extra time after a pause, at 1 MiB: +15 us after 20 us,
  +58 after 200 us, +70 after 1 ms, +85 after 5 ms. The wake itself is
  the first figure; the rest grows with the pause, which is how deeply
  the workers' cores slept (the caller's own core enters C1E alone up to
  200 us, bench-hashes #117).
- At 512 KiB the split pays x0.87 after 1 ms and x0.91 after 5 ms on
  this machine: the threshold holds here, with little margin.
- The single-threaded call itself slows after 5 ms (1 MiB 199 -> 222
  us): the caller's core's own clock and cache after the deep state.

**Posted.** BLAKE3 #118.

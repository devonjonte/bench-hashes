# BLAKE3 #138 on the i7-12700K: the native P/E control (October 23, 2026)

Sam Shackleton's `candidate/sam-native-cycle-counts` (`11c6c92`,
`67a2c42`) merged on Devon's line (`a112b48`). `pr138-i7-native.txt`:
the clocks suite (34 pass, 3 skipped), then
`counts_fall_on_the_kind_that_ran` pinned to CPU 3 (`cpu_core`, 0-15)
with CLOCKS_EXPECT_KIND=P, and to CPU 17 (`cpu_atom`, 16-19) with E: both
pass, the test ran (10.0 µs a call at 4767 MHz on P; 10.1 µs at 3748 MHz
on E), perf_event_paranoid 0. `gate6-suites.stdout.txt`: every suite on
the merged tip. Speed gate skipped (no hashing code); mutation check
skipped (clocks is outside the mutated files).

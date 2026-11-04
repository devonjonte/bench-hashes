# No periodic stall in the i7's after-pause cells (November 4, 2026)

Question: the 0.20 record's after-pause cells (i7-12700K, 1 ms pause) had
means above their medians from single high samples; is a periodic stall
(60 Hz was the guess) behind them?

Method: period.py over `2026-11-03/release-020-i7` full run's samples
(v8: start ms per sample): the 29 samples above three times their cell's
median among 4,800 after-pause samples, their start times' phase at
candidate periods (Rayleigh test), the gaps between them.

Verdict: no period (Rayleigh z under 2.2 at 16.67, 10, 20, 33.3, 100, 250,
1000 and 4 ms); the "stalls" are x3.6 in the median, the deep-against-
shallow ratio of a call after a pause, and the cells show three or four
idle depths among their twelve samples (servil st 64 B: 1.3 to 16.6 ns/B).
The 1 ms pause sat on the i7's transition between states; the two pauses
of 0.21 replace it. Posted on bench-hashes #117.

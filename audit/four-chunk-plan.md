# Four-chunk batch experiment

October 2, 2026, about 05:00 UTC. Predeclared before changing hashing again.
The frozen expanded benchmark6047dcd already measures4096-byte batches.

The two-chunk helper918722b fills SIMD lanes across independent messages.
Generalize that one mechanism to two and four whole chunks: hash each chunk
index across messages, then each balanced tree level; ROOT only at the last
level. Retain the existing cutoff of four messages and the original path for
other lengths/platforms. Compile-time chunk counts bound stack space; preserve
keys, counters, flags and independent per-message tree roots. If this fails
correctness or loses materially at2048 B, retain the two-chunk helper and the
failed experiment; no criterion rescue.

Freeze a supplementary probe revision that appends4096-byte messages to the
existing point list. Build old and new from the exact same probe, clocks and
resolved dependencies. Collect fresh CPU0 and CPU16 direct-caller ABBA plus
expanded default-placement ABBA (12 processes), old/new and same-side repeats
through the frozen Rust reader, and stock14-point diagnostic before committing.
Require10% wall gain in both4096-byte direct repetitions for a target claim;
all other sizes/states/costs remain reported. Queue variability from the prior
study stays open even if the new target is faster. No favorable retries.

Independent references and published4096-byte anchors exercise all modes,
all byte alignments, lane/table boundaries and output sentinels. Run default,
pure,no_sme2,official vectors,docs and portable-anchor Miri. All runs bounded.
This remains provisional Linux optimization; original reliability acceptance
and general no-regression claims remain unpassed.

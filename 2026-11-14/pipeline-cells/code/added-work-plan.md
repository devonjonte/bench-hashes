# Positive control: additional hashing work in the Pipeline producer

Declared November 14, 2026, before measurement.

Use the exact pilot's 19-cell selected scope and the same library pin.
Baseline: candidate 55436819e59a20eaa47a79f81e6594872ea40ff4.
Plant: before every sixteenth room-fed message (including the first), hash
that input once with official BLAKE3 on the producer thread and black_box the
result. Ordinary Pipeline inputs, outputs and completion stay identical.
Only Messages::run changes; receiving, batches and lent calls are controls.

This adds a known amount of hashing work, approximately 1/16 of message
bytes when iteration counts are large. It does NOT prescribe a 6.25% wall
slowdown: synchronous hashing, per-sample rounding and concurrency affect
its time. Collections' first-every-16 selection can have a different byte
share. Report the observed effects, including any unexpected improvements.

Four fresh-layout pairs through check --probe --layouts 4, same scope as
the pilot, under the EPYC lock, no adaptive second stage. Before timing,
run the delivery/ownership tests on the plant: outputs must stay identical.
The control establishes responsiveness only at the observed effect sizes.
If A/A spread obscures small added costs, keep small candidate differences
unresolved. A larger observed effect alone does not validate small-effect
sensitivity. No release acceptance follows from this pilot.

The plant is an experiment branch only. Never merge it into production.

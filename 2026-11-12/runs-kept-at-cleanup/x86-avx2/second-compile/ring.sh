#!/bin/sh
# The control for "a second compilation" (thin LTO, 16 codegen units, both sides): a change that really costs
# must still read slower under it. The 8 MiB long ring (2037118c^) against the 2 MiB one (2037118c), the 4 MiB
# stream, bench 4fcff35f. Under the bench's own profile with varied inliner thresholds it read +42.6% (one
# cache) and +14.1% (alone) over 64 pairs.
set -eu
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/second-compile; cd $HOME/work/bench-4fcff35f; test -x ./target/release/bench-hashes
set +e
CARGO_PROFILE_RELEASE_LTO=thin CARGO_PROFILE_RELEASE_CODEGEN_UNITS=16 ./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new 2037118c^ --against 2037118c --points "continuous 4 MiB" --when-quiet --keep $O/kept-thin-ring
echo "check exit $? $(date -u +%H:%M)"

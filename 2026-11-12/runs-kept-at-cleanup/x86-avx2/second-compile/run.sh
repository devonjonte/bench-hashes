#!/bin/sh
# A probe for "a second compilation as a control": BLAKE3 #368's removal against its base (b6377425 against
# 0a23cb70), bench 4fcff35f, the 1 MiB stream point. Under the bench's own profile (fat LTO, one codegen unit)
# it read 7.6 to 15% slower alone over 64 pairs, six times. Here both sides are compiled another way: thin LTO
# and 16 codegen units, by Cargo's environment overrides. Does the verdict survive a second compilation?
set -eu
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/second-compile; mkdir -p $O; cd $HOME/work/bench-4fcff35f; test -x ./target/release/bench-hashes
set +e
CARGO_PROFILE_RELEASE_LTO=thin CARGO_PROFILE_RELEASE_CODEGEN_UNITS=16 ./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new b6377425 --against 0a23cb70 --points "continuous 1 MiB" --when-quiet --keep $O/kept-thin
echo "check exit $? $(date -u +%H:%M)"

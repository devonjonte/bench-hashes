#!/bin/sh
# bench #191's held cell (the multithreaded tree of 16384 leaves, two programs on two caches: +20.6% and +13.2%
# against the bench before it, one library) under a second compilation of both sides (thin LTO, 16 units):
# CONTRIBUTING's step 2. Slower again: the candidate's own doing. Level: this build's.
set -eu
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/own-code-2; cd $HOME/work/bench-own-code; test -x ./target/release/bench-hashes
set +e
CARGO_PROFILE_RELEASE_LTO=thin CARGO_PROFILE_RELEASE_CODEGEN_UNITS=16 ./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new e9da0a1e --against e9da0a1e --old-bench a4c76fee --points "merkle 16384,merkle 4096,continuous 64 B" --when-quiet --keep $O/kept-thin
echo "check exit $? $(date -u +%H:%M)"

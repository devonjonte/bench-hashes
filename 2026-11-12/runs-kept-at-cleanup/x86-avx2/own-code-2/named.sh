#!/bin/sh
# The bench candidate (every cell a function of its own, 1d745525) against the bench before it (a4c76fee), one
# library: the cell the every-cell check flagged slower (the multithreaded tree of 16384 leaves, two programs on
# two caches, +20.6% over 64 pairs, from -27% to +195%) by name, and the 64 B cells it read 9 to 11% faster.
set -eu
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/own-code-2; cd $HOME/work/bench-own-code; test -x ./target/release/bench-hashes
set +e
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new e9da0a1e --against e9da0a1e --old-bench a4c76fee --points "merkle 16384,merkle 4096,continuous 64 B,continuous 128 B" --when-quiet --keep $O/kept-named
echo "check exit $? $(date -u +%H:%M)"

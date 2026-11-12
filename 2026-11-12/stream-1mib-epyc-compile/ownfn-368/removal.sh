#!/bin/sh
# BLAKE3 #368: under the bench whose stream loop is a function of its own (e6ba47fd), the whole removal
# (b6377425 against 0a23cb70), which under bench 4fcff35f read 7.6% slower alone and 13.5% two caches (64 pairs).
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/ownfn-368; cd $HOME/work/bench-ownfn
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new b6377425 --against 0a23cb70 --points "continuous 1 MiB" --when-quiet --keep $O/kept-removal
echo "check exit $? $(date -u +%H:%M)"

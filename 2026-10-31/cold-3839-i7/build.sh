#!/bin/sh
# Build the cold probe at commit $1 (the one-message call by the commit's API).
set -eu
D=/home/agent/bench-hashes-validation/cold-3839-i7; W=/home/agent/BLAKE3-review08; C=$(git -C $W rev-parse "$1")
[ -x $D/target-$C/release/examples/cold ] && { echo $D/target-$C/release/examples/cold; exit 0; }
git -C $W checkout -q --detach $C
if [ -f $W/src/convenience.rs ]; then CALL=blake3_servil::convenience::hash; else CALL=blake3_servil::hash; fi
mkdir -p $W/examples
sed "s|^use std::hint::black_box;|use std::hint::black_box;\nconst HASH: fn(\&[u8]) -> blake3_servil::Hash = $CALL;|" $D/cold_probe.rs > $W/examples/cold.rs
(cd $W && cargo build -q --release --example cold --target-dir $D/target-$C >&2)
rm -rf $W/examples
echo $D/target-$C/release/examples/cold

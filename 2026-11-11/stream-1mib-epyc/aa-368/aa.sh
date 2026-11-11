#!/bin/sh
# BLAKE3 #368: the control that should have come first. 0a23cb70 against itself with a black_box in Hasher::new (which the stream cells never call) and one character in
# an assert's message in stream.rs (scratch/devon-aa-368: the instructions the cells run are the same), one
# bench (4fcff35f), the point "continuous 1 MiB", 64 pairs, asked both ways round.
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/aa-368; cd $HOME/work/bench-4fcff35f
git -C $HOME/work/BLAKE3 fetch -q devon scratch/devon-aa-368
echo "== a: new the control, old 0a23cb70"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new 1b6dd866ed71118220712aca970d0f154c41bad8 --against 0a23cb70 --points "continuous 1 MiB" --layouts 64 --when-quiet --keep $O/kept-a
echo "check exit $? $(date -u +%H:%M)"
echo "== b: new 0a23cb70, old the control"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new 0a23cb70 --against 1b6dd866ed71118220712aca970d0f154c41bad8 --points "continuous 1 MiB" --layouts 64 --when-quiet --keep $O/kept-b
echo "check exit $? $(date -u +%H:%M)"
echo "== done"

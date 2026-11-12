#!/bin/sh
# BLAKE3 #368: the removal's first half again, with take_task and run_task never inlined on both sides
# (exp/devon-368-base-pinned 83959074 against exp/devon-368-r1-pinned fbce4351). Then the stream's own
# functions compile alike on both sides; what still differs is the bench's hash_continuous_messages.
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/pinned-368; mkdir -p $O
cd $HOME/work/BLAKE3 && git fetch -q devon exp/devon-368-base-pinned exp/devon-368-r1-pinned
[ -d $HOME/work/bench-4fcff35f ] || git -C $HOME/work/bench-hashes worktree add -q --detach $HOME/work/bench-4fcff35f 4fcff35f
cd $HOME/work/bench-4fcff35f && cargo build --release 2>&1 | tail -1
bench-turn ./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new fbce43512e57a4ba1f3ef5cac3b63e923113fb06 --against 83959074fb4f516c0fe2a536d324f20ca70aff75 --points "continuous 1 MiB" --when-quiet --keep $O/kept
echo "check exit $? $(date -u +%H:%M)"

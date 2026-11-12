#!/bin/sh
set -eu
export PATH=$HOME/.cargo/bin:$PATH
cd $HOME/work/bench-hashes; git fetch -q devon candidate/devon-old-bench-pinned; test "$(git rev-parse FETCH_HEAD)" = b8a32a536e150e1a956307f94bbcf1b35cc4f2c4
[ -d $HOME/work/bench-pinned ] || git worktree add -q --detach $HOME/work/bench-pinned b8a32a536e150e1a956307f94bbcf1b35cc4f2c4
cd $HOME/work/bench-pinned && git checkout -q --detach b8a32a536e150e1a956307f94bbcf1b35cc4f2c4 && cargo build --release 2>&1 | tail -1
cd $HOME/runs/sessions-pinned && python3 sessions-pinned.py
cat log.txt

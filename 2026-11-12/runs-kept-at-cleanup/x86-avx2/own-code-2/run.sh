#!/bin/sh
# bench-hashes candidate "every cell's timed code in a function of its own" (1d74552536af84f7d06fd9c3a16ecc8b6e82b0ac) against the bench it is based
# on (a4c76fee), the same library on both sides (BLAKE3 next e9da0a1e), every cell.
# (A first attempt on this machine checked another bench commit: its fetch had failed and the script went on.)
set -eu
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/own-code-2; mkdir -p $O
git -C $HOME/work/BLAKE3 fetch -q origin
cd $HOME/work/bench-hashes
git remote | grep -q devon || git remote add devon https://github.com/devonjonte/bench-hashes.git
git fetch -q origin; git fetch -q devon candidate/devon-cell-own-code
test "$(git rev-parse FETCH_HEAD)" = 1d74552536af84f7d06fd9c3a16ecc8b6e82b0ac
[ -d $HOME/work/bench-own-code ] || git worktree add -q --detach $HOME/work/bench-own-code 1d74552536af84f7d06fd9c3a16ecc8b6e82b0ac
cd $HOME/work/bench-own-code && git checkout -q --detach 1d74552536af84f7d06fd9c3a16ecc8b6e82b0ac && cargo build --release 2>&1 | tail -1
set +e
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new e9da0a1e --against e9da0a1e --old-bench a4c76fee --cells all --when-quiet --keep $O/kept
echo "check exit $? $(date -u +%H:%M)"

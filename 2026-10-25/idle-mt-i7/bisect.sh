#!/bin/sh
# Which change between bfbda19 and f1db8cd costs mt batches of 2-32
# messages after a pause? Plain builds (one layout each; the effect,
# 10-17%, stands well above the layout spread the same-code controls
# show), adjacent commits compared at 23 pairs, plus a same-code control.
set -eu
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
unset RUSTFLAGS
W=/home/agent/bisect-idle
K=/home/agent/bench-hashes-validation/idle-mt-i7
NEWB=/home/agent/BLAKE3-rel08/bench-hashes
OLDB=/home/agent/BLAKE3-rel08/target/check/old-bench
build() { # commit bench: the bench cloned inside the commit's worktree, as its build.rs requires
  c=$1; b=$2
  [ -d $W/fork-$c ] || git -C /home/agent/BLAKE3-rel08 worktree add -q --detach $W/fork-$c $c
  [ -d $W/fork-$c/bench-hashes/.git ] || { rm -rf $W/fork-$c/bench-hashes; git clone -q --shared $b $W/fork-$c/bench-hashes; git -C $W/fork-$c/bench-hashes checkout -q --detach $(git -C $b rev-parse HEAD); }
  (cd $W/fork-$c/bench-hashes && CARGO_TARGET_DIR=$W/target-$c cargo build -q --release --config 'patch."https://github.com/devonjonte/BLAKE3".blake3-servil.path=".."')
  cp $W/target-$c/release/bench-hashes $W/bench-$c
  echo "built $c with bench $(git -C $W/fork-$c/bench-hashes rev-parse --short HEAD)"
}
build bfbda19 $OLDB
for c in 66732c5 399a8f2 ee4c0d7 f1db8cd; do build $c $NEWB; done
P="idle 1,idle 2,idle 3,idle 4,idle 6,idle 8,idle 12,idle 16,idle 24,idle 32"
rep() { for i in $(seq 23); do printf '%s ' "$1"; done; }
cmpr() { # old new
  echo "== $1 -> $2, 23 pairs"
  $W/bench-$2 regress --pairs 23 --contenders blake3-servil-mt --points "$P" --keep $K/b-$1-$2 $(rep $W/bench-$1) -- $(rep $W/bench-$2) || true
}
cd $NEWB
cmpr bfbda19 66732c5
cmpr 66732c5 399a8f2
cmpr 399a8f2 ee4c0d7
cmpr ee4c0d7 f1db8cd
cmpr f1db8cd f1db8cd

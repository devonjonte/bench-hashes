#!/bin/sh
# The finish-events study of Mac job 2073, on the i7-12700K: old 0b5bf7b7 against new f1393337,
# four pairs in alternating order, a fresh link layout a pair (-C metadata), each run pinned to one P core.
# The sampler and judge are BLAKE3-Servil's tools/studies (devonjonte probe/devon-events-linux), the
# events the bench's clocks::events (bench-hashes candidate/devon-release-021).
set -eu
export PATH=/home/agent/.cargo/bin:$PATH TMPDIR=/home/agent/tmp
R=/home/agent/bench-hashes-validation/events-linux
W=$R/work; mkdir -p $W
LIB=/home/agent/BLAKE3-m3; BENCH=/home/agent/bench-0194
OLD=0b5bf7b71cb5f850067fa4182d9a3c724d7e5710; NEW=f13933376c8b8236adaeffe6aa9d25ad25f2af24
STUDY=$(git -C $LIB rev-parse probe/devon-events-linux)
CORE=${CORE:-2}
{ echo "old $OLD"; echo "new $NEW"; echo "study $STUDY"; echo "bench $(git -C $BENCH rev-parse HEAD) $(git -C $BENCH status --porcelain | wc -l) changed files"; rustc --version; echo "core $CORE"; } > $R/events-identity.txt
for side in old new; do
  c=$OLD; [ $side = new ] && c=$NEW
  rm -rf $W/lib-$side; git -C $LIB worktree remove --force $W/lib-$side 2>/dev/null || true
  git -C $LIB worktree add -q --detach $W/lib-$side $c
  mkdir -p $W/sampler-$side/src
  printf '[package]\nname = "events-sampler"\nversion = "0.1.0"\nedition = "2021"\n[dependencies]\nblake3-servil = { path = "%s" }\nclocks = { path = "%s" }\n[profile.release]\ndebug = false\n' $W/lib-$side $BENCH/clocks > $W/sampler-$side/Cargo.toml
  git -C $LIB show $STUDY:tools/studies/events_sampler.rs > $W/sampler-$side/src/main.rs
done
mkdir -p $W/judge/src
printf '[package]\nname = "events-judge"\nversion = "0.1.0"\nedition = "2021"\n[dependencies]\nclocks = { path = "%s" }\n' $BENCH/clocks > $W/judge/Cargo.toml
git -C $LIB show $STUDY:tools/studies/events_judge.rs > $W/judge/src/main.rs
(cd $W/judge && cargo build -q --release)
FILES=""
for pair in 0 1 2 3; do
  order="old new"; [ $((pair % 2)) = 1 ] && order="new old"
  for side in $order; do
    (cd $W/sampler-$side && CARGO_TARGET_DIR=$W/target-$side-$pair RUSTFLAGS="-C metadata=events_pair_$pair" cargo build -q --release)
    taskset -c $CORE $W/target-$side-$pair/release/events-sampler > $R/events-$side-$pair.tsv 2> $R/events-$side-$pair.tsv.err
    echo "pair $pair $side done"
  done
  FILES="$FILES $R/events-old-$pair.tsv $R/events-new-$pair.tsv"
done
$W/judge/target/release/events-judge $FILES > $R/events-judgment.txt
cat $R/events-judgment.txt

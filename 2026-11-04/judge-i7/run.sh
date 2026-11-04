#!/bin/sh
# Which quantity detects what (bench-hashes #127): check (bench candidate/devon-raw-clock, samples v9) on
# known plants and an A/A, every cell, pairs kept; then compare --judge-by wall|cycles|instructions on each
# run's kept pairs (judge.sh). One job at a time.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/judge-i7
B=/home/agent/bench-0194
run() { name=$1; fork=$2; against=$3
  cd $B; s=$(date +%s)
  cargo run -q --release -- check --fork $fork --against $against --cells all --keep $O/$name > $O/$name.stdout.txt 2> $O/$name.stderr.txt
  echo "== $name exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
  git checkout -q -- Cargo.lock 2>/dev/null
}
run aa        /home/agent/BLAKE3-rel019 b5b988d8982bea9490c38c79ec4b8c5c2428270c
run known119  /home/agent/BLAKE3-rel019 f108640d0b5240ae2e146d99e77027a0d262412c
run spin450   /home/agent/BLAKE3-p1     70ddb67663c00d25376af82014b5bf6cccf5282c
run cold450   /home/agent/BLAKE3-plant  70ddb67663c00d25376af82014b5bf6cccf5282c
run hash3     /home/agent/BLAKE3-p3     75413329
echo "== done $(date -u +%H:%M)"

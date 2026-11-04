#!/bin/sh
# Does the instruction-pointed second stage catch #119 (bench b0d8510d, samples v10)? check on the known119
# plant (the cells it reaches, as a real check would) and the A/A, pairs kept.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/judge2-i7
B=/home/agent/bench-0194
run() { name=$1; fork=$2; against=$3
  cd $B; s=$(date +%s)
  cargo run -q --release -- check --fork $fork --against $against --keep $O/$name > $O/$name.stdout.txt 2> $O/$name.stderr.txt
  echo "== $name exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
  git checkout -q -- Cargo.lock 2>/dev/null
}
run known119  /home/agent/BLAKE3-rel019 f108640d0b5240ae2e146d99e77027a0d262412c
run aa        /home/agent/BLAKE3-rel019 b5b988d8982bea9490c38c79ec4b8c5c2428270c
echo "== done $(date -u +%H:%M)"

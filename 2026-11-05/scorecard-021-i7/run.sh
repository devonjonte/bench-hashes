#!/bin/sh
# 0.21's scorecard, part (a): the check's A/A over every cell (bench candidate/devon-raw-clock, servil 0.8 b5b988d8
# against itself), then the three plants (#119 cold code, 450-tick spin, 450-tick cold spin), the cells each reaches.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/aa-021-i7
B=/home/agent/bench-0194
run() { name=$1; fork=$2; against=$3; shift 3
  cd $B; s=$(date +%s)
  cargo run -q --release -- check --fork $fork --against $against "$@" --keep $O/$name > $O/$name.stdout.txt 2> $O/$name.stderr.txt
  echo "== $name exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
  git checkout -q -- Cargo.lock 2>/dev/null
}
run aa        /home/agent/BLAKE3-rel019 b5b988d8982bea9490c38c79ec4b8c5c2428270c --cells all
run known119  /home/agent/BLAKE3-rel019 f108640d0b5240ae2e146d99e77027a0d262412c
run spin450   /home/agent/BLAKE3-p1     70ddb67663c00d25376af82014b5bf6cccf5282c
run cold450   /home/agent/BLAKE3-plant  70ddb67663c00d25376af82014b5bf6cccf5282c
echo "== done $(date -u +%H:%M)"

#!/bin/sh
# Mutation tests over the measurement core (clocks: the sampler, the counters, the load watcher, the child
# runner, energy), after the judge's (judge-mutants). One heavy job; no cargo builds beside it.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/clocks-mutants
cd /home/agent/bench-0194
s=$(date +%s)
cargo mutants --test-tool nextest -p clocks -f clocks/src/lib.rs -f clocks/src/linux_counts.rs -f clocks/src/load.rs -f clocks/src/child.rs -f clocks/src/energy.rs -j 3 --timeout 300 -o $O/clocks > $O/clocks.stdout.txt 2> $O/clocks.stderr.txt
echo "== clocks exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
echo "== done $(date -u +%H:%M)"

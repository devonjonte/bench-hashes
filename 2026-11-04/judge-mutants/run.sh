#!/bin/sh
# Mutation tests over the judge (Zooko, November 4): clocks/src/summary.rs (the verdict rule), then the bench's
# judging functions in src/main.rs. One heavy job; no cargo builds beside it.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/judge-mutants
cd /home/agent/bench-0194
s=$(date +%s)
cargo mutants --test-tool nextest -p clocks -f clocks/src/summary.rs -j 3 --timeout 300 -o $O/summary > $O/summary.stdout.txt 2> $O/summary.stderr.txt
echo "== summary.rs exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
s=$(date +%s)
cargo mutants --test-tool nextest --copy-vcs true -f src/main.rs --re 'instructions_moved|instructions_tell|cell_means|judge_once|describe_effective_idle_states|describe_idle_states|IdleControl::|Roster::new|cell_wants_sample|Mean::' -j 3 --timeout 600 -o $O/judge > $O/judge.stdout.txt 2> $O/judge.stderr.txt
echo "== judge functions exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
echo "== done $(date -u +%H:%M)"

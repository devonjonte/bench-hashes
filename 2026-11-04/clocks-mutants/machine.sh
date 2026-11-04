#!/bin/sh
# The platform code's mutants under the machine profile alone, one at a time (its tests are load-sensitive).
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/clocks-mutants
cd /home/agent/bench-0194
s=$(date +%s)
cargo mutants --test-tool nextest -p clocks -f clocks/src/lib.rs -f clocks/src/load.rs -f clocks/src/child.rs -f clocks/src/energy.rs -f clocks/src/linux_counts.rs --re 'imp::|Mapped|Group|open|attr|read_with|rusage|watch|wait_exited|process_cpu_ns|raw_ns|tight_timers|scan|ours|busiest|package_nj|running_|own_times|until_due|Counts::read|set_qos|read ->' -j 1 --timeout 300 -o $O/machine -- -P machine > $O/machine.stdout.txt 2> $O/machine.stderr.txt
echo "== machine exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"

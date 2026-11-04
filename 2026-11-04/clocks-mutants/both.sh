#!/bin/sh
# Both runs over clocks' five files: the code's suite at -j 3, then the platform code under the machine profile at -j 1.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/clocks-mutants
cd /home/agent/bench-0194
F="-f clocks/src/lib.rs -f clocks/src/load.rs -f clocks/src/child.rs -f clocks/src/energy.rs -f clocks/src/linux_counts.rs"
s=$(date +%s)
cargo mutants --test-tool nextest -p clocks $F -j 3 --timeout 120 -o $O/round5 > $O/round5.stdout.txt 2>&1
echo "== code suite exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
s=$(date +%s)
cargo mutants --test-tool nextest -p clocks $F --re 'imp::|Mapped|Group|open|attr|read_with|rusage|watch|wait_exited|process_cpu_ns|raw_ns|tight_timers|scan|ours|busiest|package_nj|running_|own_times|until_due|Counts::read|set_qos|read ->' -j 1 --timeout 300 -o $O/machine2 -- -P machine > $O/machine2.stdout.txt 2>&1
echo "== machine exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"

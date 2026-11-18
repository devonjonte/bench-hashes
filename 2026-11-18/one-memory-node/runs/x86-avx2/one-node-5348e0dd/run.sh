#!/bin/sh
# Declared before running (November 18, 2026, UTC): bench-hashes keeping itself to one memory node
# (candidate/devon-one-memory-node, 5348e0dd) on a two-socket machine, with no numactl anywhere.
# 1. Where a process runs: started anywhere, its CPUs are one node's and its pages are there; started
#    on the far node's CPU, it stays on that one CPU and that node; a copy of the program whose file
#    was written from the far node has its pages on the near node once it runs.
# 2. A probe through `check` (16 layouts a side, 64 B), which also runs the kept link here.
# 3. Identical code: `regress` over the new side's 16 layouts against themselves, the ten small cells,
#    16 pairs, then 48 more over the four cells after other work. Expectation from the same machine
#    under numactl (issue3-arms-c, bound-policy): no cell marked, one pair's spread 4% to 12%; unbound
#    (issue3-arms-a) it marked cells both ways with spreads of 34% to 42%.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
if [ "${BOUNDED_NODE:-}" != yes ]; then
  export BOUNDED_NODE=yes
  status=0
  timeout --kill-after=30s 5400s sh "$0" || status=$?
  printf 'NODE_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=16 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
ulimit -c 0
R="$HOME/work/bench-release-023"
M="$HOME/work/lib-release-023"
BENCH=5348e0dd27a1a2093f0c506df088dda78755ac17
NEW=27eacce3a5c2e03043f4fcd347c178a80f9d911c
OLD=4483281c45eab341ca6f829de508e91d6c381e85
B="$HOME/work/bench-one-node"
W="$HOME/work/one-node-scratch"
stamp() { printf '%s %s\n' "$(date -u +%T)" "$*" | tee -a "$O/progress.txt"; }
{ uname -srm; ls /sys/devices/system/node | tr '\n' ' '; echo; for n in /sys/devices/system/node/node[0-9]*; do echo "$n cpus $(cat "$n/cpulist")"; done; cat /proc/sys/kernel/numa_balancing 2> /dev/null; } > "$O/machine.txt" 2>&1
git -C "$R" cat-file -e "$BENCH^{commit}" 2> /dev/null || git -C "$R" fetch -q origin candidate/devon-one-memory-node
git -C "$M" cat-file -e "$OLD^{commit}" 2> /dev/null || git -C "$M" fetch -q origin
[ -d "$B" ] || git -C "$R" worktree add -q --detach "$B" "$BENCH"
git -C "$B" checkout -q --detach "$BENCH"
stamp "build the bench ($BENCH)"
(cd "$B" && cargo build --release --quiet) > "$O/bench-build.txt" 2>&1
E="$B/target/release/bench-hashes"
rm -rf "$W"; mkdir -p "$W"

# 1. Where a process runs. `quiet` reads the machine for ten seconds: long enough to look at it.
look() { # name, command...
  name=$1; shift
  "$@" > "$O/where-$name.stdout.txt" 2> "$O/where-$name.stderr.txt" &
  pid=$!
  sleep 3
  {
    grep -E 'Cpus_allowed_list|Mems_allowed_list' "/proc/$pid/status"
    awk '{ for (i = 1; i <= NF; i++) if ($i ~ /^N[0-9]+=/) { split($i, a, "="); pages[a[1]] += a[2] } } END { for (n in pages) printf "all mappings: %s pages on %s\n", pages[n], n }' "/proc/$pid/numa_maps"
    grep 'file=.*bench-hashes' "/proc/$pid/numa_maps" | awk '{ for (i = 1; i <= NF; i++) if ($i ~ /^N[0-9]+=/) { split($i, a, "="); pages[a[1]] += a[2] } } END { for (n in pages) printf "the program file: %s pages on %s\n", pages[n], n }'
    awk '{ print $2 }' "/proc/$pid/numa_maps" | sort | uniq -c | sed 's/^/policies: /'
  } > "$O/where-$name.txt" 2>&1 || true
  wait "$pid" || true
}
far_cpu=$(cut -d, -f1 /sys/devices/system/node/node1/cpulist | cut -d- -f1)
stamp "where a process runs (the far node's first CPU is $far_cpu)"
look anywhere "$E" quiet
look far-start taskset -c "$far_cpu" "$E" quiet
taskset -c "$far_cpu" cp "$E" "$W/bench-hashes-written-far"
look far-file "$W/bench-hashes-written-far" quiet
if [ -x "$R/target/release/bench-hashes" ]; then
  taskset -c "$far_cpu" cp "$R/target/release/bench-hashes" "$W/bench-hashes-0.23-written-far"
  look old-bench-far-file "$W/bench-hashes-0.23-written-far" quiet
fi

# 2. A probe through check.
stamp "probe through check, 16 layouts a side: start"
status=0
(cd "$B" && "$E" check --fork "$M" --new "$NEW" --against "$OLD" --probe '64 B' --layouts 16 --when-quiet --keep "$O/kept-probe") \
  > "$O/probe.stdout.txt" 2> "$O/probe.stderr.txt" || status=$?
stamp "probe exit $status"
echo "probe: check exit $status" >> "$O/exit.txt"

# 3. Identical code.
side="$M/target/check/new"
exes=$(ls "$side"/bench-hashes-[0-9]* | sort -V | head -16 | tr '\n' ' ')
echo "$exes" | tr ' ' '\n' > "$O/null.programs.txt"
null() { # name, pairs, points
  stamp "$1: $2 pairs over $3: start"
  status=0
  # shellcheck disable=SC2086
  (cd "$B" && "$E" regress --pairs "$2" --contenders blake3-servil-st,blake3-servil-mt --points "$3" --keep "$O/kept-$1" $exes -- $exes) \
    > "$O/$1.stdout.txt" 2> "$O/$1.stderr.txt" || status=$?
  stamp "$1: regress exit $status"
  echo "$1: regress exit $status" >> "$O/exit.txt"
}
null null 16 "idle 64 B,idle 128 B,idle 256 B,64 B,128 B"
null null-more 48 "64 B,128 B"
rm -rf "$W"
git -C "$R" worktree remove --force "$B" 2> /dev/null || true
stamp "done"

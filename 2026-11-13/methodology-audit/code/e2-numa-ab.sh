#!/bin/sh
# Methodology audit E2 (declared before running): do the two-socket hosts' slow samples come from the kernel's
# automatic NUMA balancing (its sampling faults and page migrations landing inside timed calls)?
# The same by-name check in four arms: as now; with an explicit memory policy on the process (the kernel then
# leaves its pages alone); confined to node 0's CPUs; both. Predictions if the cause is NUMA balancing:
# P1 with the policy, vmstat's numa_hint_faults stop growing during the arm; P2 the turn-of-256 samples lose
# their slow episodes (as the one-socket hosts have none); P3 pairs spread less. Then every cell once in the
# clean arm, where the turn of 256 read +13% and +15% on November 12 and 13.
set -u
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/@RUN@; M=$HOME/work/BLAKE3; TAG=97c0fbcbedb8fe8f8395115647684dfde75d67a3
cd $HOME/work
git -C BLAKE3 fetch -q --all --tags; git -C bench-hashes fetch -q --all --tags
[ -d bench-022 ] || git -C bench-hashes worktree add -q --detach ../bench-022 $TAG
B=$HOME/work/bench-022; git -C $B checkout -q --detach $TAG; test "$(git -C $B rev-parse HEAD)" = $TAG || { echo "bench checkout differs"; exit 1; }
cd $B; cargo build --release 2>&1 | tail -1
echo "== facts: numa_balancing $(cat /proc/sys/kernel/numa_balancing 2>&1); nodes $(ls /sys/devices/system/node | grep -c '^node[0-9]'); node0 cpus $(cat /sys/devices/system/node/node0/cpulist); node1 cpus $(cat /sys/devices/system/node/node1/cpulist 2>/dev/null); THP $(cat /sys/kernel/mm/transparent_hugepage/enabled); kernel $(uname -r); governor $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null)"
cat > $O/mempol.c <<'CEOF'
#define _GNU_SOURCE
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/syscall.h>
/* Give the process an explicit memory policy (bind to every node it is allowed), then run the command.
   A task with a policy of its own is skipped by automatic NUMA balancing's scanner. --print shows the
   current policy and exits. */
int main(int argc, char **argv) {
    unsigned long mask[16]; int mode = -1;
    memset(mask, 0, sizeof mask);
    if (argc > 1 && !strcmp(argv[1], "--print")) {
        if (syscall(SYS_get_mempolicy, &mode, mask, 1024UL, 0, 0UL) != 0) { perror("get_mempolicy"); return 110; }
        printf("policy mode %d (0 default, 2 bind) nodes 0x%lx\n", mode, mask[0]); return 0;
    }
    if (syscall(SYS_get_mempolicy, &mode, mask, 1024UL, 0, 4UL) != 0) { perror("get_mempolicy(MEMS_ALLOWED)"); return 111; }
    if (syscall(SYS_set_mempolicy, 2, mask, 1024UL) != 0) { perror("set_mempolicy"); return 112; }
    if (argc < 2) return 0;
    execvp(argv[1], argv + 1); perror("execvp"); return 113;
}
CEOF
cc -O2 -o $O/mempol $O/mempol.c || exit 1
echo "== policy now: $($O/mempol --print); under the wrapper: $($O/mempol $O/mempol --print)"
if $O/mempol true; then POL=yes; else POL=no; echo "== the kernel refuses set_mempolicy here: the policy arms are skipped"; fi
N0=$(cat /sys/devices/system/node/node0/cpulist)
vm() { grep -E '^numa_(pte_updates|hint_faults|hint_faults_local|pages_migrated) ' /proc/vmstat | tr '\n' ' '; }
P="turn 256,idle turn 256,brief idle turn 256,64 B,256 B,4 KiB,64 KiB,128,brief idle 3 KiB,idle 3839 B"
arm() { name=$1; shift; echo "== $name start $(date -u +%T) $(vm)"; s=$(date +%s)
  "$@" ./target/release/bench-hashes check --fork $M --new bf2da8b957f5e0c80babb57952de3e53f95c921a --against b5b988d8 --old-bench 3363bee8 --contenders blake3-servil-st --points "$P" --when-quiet --keep $O/kept-$name > $O/$name.stdout.txt 2> $O/$name.stderr.txt
  echo "== $name exit $? in $(( $(date +%s) - s )) s end $(date -u +%T) $(vm)"; }
arm normal env
[ $POL = yes ] && arm policy-node0 taskset -c $N0 $O/mempol
[ $POL = yes ] && arm policy $O/mempol
arm node0 taskset -c $N0
echo "== every cell, policy and node 0: start $(date -u +%T) $(vm)"; s=$(date +%s)
W=$O/mempol; [ $POL = yes ] || W=env
taskset -c $N0 $W ./target/release/bench-hashes check --fork $M --new bf2da8b957f5e0c80babb57952de3e53f95c921a --against b5b988d8 --old-bench 3363bee8 --contenders blake3-servil-st --cells all --when-quiet --keep $O/kept-all-policy-node0 > $O/all-policy-node0.stdout.txt 2> $O/all-policy-node0.stderr.txt
echo "== every cell, policy and node 0: exit $? in $(( $(date +%s) - s )) s end $(date -u +%T) $(vm)"
echo "== done $(date -u +%H:%M)"

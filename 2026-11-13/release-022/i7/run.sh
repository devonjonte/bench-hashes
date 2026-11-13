#!/bin/sh
# bench-hashes 0.22's release runs on the i7-12700K, at the tag v0.22.0+d7723f11 (97c0fbcb), pin BLAKE3-Servil 0.9.0 (bf2da8b9):
# the full run, b3sum, crowd, the core's check against 0.8, and the same-library check against 0.21's bench.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
export GIT_SSH_COMMAND="ssh -F /dev/null -i /home/agent/.ssh/id_ed25519_github_devonjonte -o IdentitiesOnly=yes -o UserKnownHostsFile=/home/agent/.ssh/known_hosts -o Hostname=ssh.github.com -p 443 -o StrictHostKeyChecking=yes -o ConnectTimeout=20"
O=/home/agent/bench-hashes-validation/release-022/i7/at-the-tag; mkdir -p $O
B=/home/agent/bench-022; F=/home/agent/BLAKE3-090; M=/home/agent/BLAKE3-m3
C=bf2da8b957f5e0c80babb57952de3e53f95c921a
test "$(git -C $B rev-parse HEAD)" = 97c0fbcbedb8fe8f8395115647684dfde75d67a3 || exit 1
cd $B; echo "== bench $(git log --oneline -1 | cut -c1-60); library checkout $(git -C $F rev-parse --short=8 HEAD); governor $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor) $(date -u +%H:%M)"
EXE=$(./target/release/bench-hashes build-against $F 2> $O/build-against.stderr.txt | tail -1); echo "built: $EXE"
git checkout -q -- Cargo.lock 2>/dev/null
./target/release/bench-hashes quiet --wait > /dev/null 2>&1
rm -rf $O/full; mkdir -p $O/full; cd $O/full
s=$(date +%s); $EXE --all --expect-servil $C > report.txt 2> stderr.txt; echo "== full exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
cd $B
s=$(date +%s); LAYOUTS=4 python3 tools/b3sum-contenders.py $F /home/agent/b3c-090 > $O/b3sum-contenders.txt 2> $O/b3sum-contenders.stderr.txt; echo "== contenders exit $? in $(( $(date +%s) - s )) s"
./target/release/bench-hashes quiet --wait > /dev/null 2>&1
rm -rf $O/b3sum; mkdir -p $O/b3sum
s=$(date +%s); tr '\n' '\0' < $O/b3sum-contenders.txt | (cd $O/b3sum && xargs -0 $EXE b3sum --files /home/agent/b3sum-files > report.txt 2> stderr.txt); echo "== b3sum exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
./target/release/bench-hashes quiet --wait > /dev/null 2>&1
rm -rf $O/crowd; mkdir -p $O/crowd; cd $O/crowd
s=$(date +%s); $EXE crowd > report.txt 2> stderr.txt; echo "== crowd exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
cd $B
s=$(date +%s); ./target/release/bench-hashes check --fork $M --new $C --against b5b988d8 --old-bench 3363bee8 --contenders blake3-servil-st --cells all --when-quiet --keep $O/kept-core > $O/check-core.stdout.txt 2> $O/check-core.stderr.txt; echo "== release check: the core (single-threaded) against 0.8, every cell: exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
s=$(date +%s); ./target/release/bench-hashes check --fork $M --new 2037118ca1da85710aef55d7f13b3abd9095b485 --against 2037118ca1da85710aef55d7f13b3abd9095b485 --old-bench 9434d50e --contenders blake3-servil-st --cells all --when-quiet --keep $O/kept-same > $O/check-same.stdout.txt 2> $O/check-same.stderr.txt; echo "== same-library check (library 2037118c on both sides; this bench against 0.21's): exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
echo "== done $(date -u +%H:%M)"

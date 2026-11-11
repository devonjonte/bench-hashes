#!/bin/sh
# bench-hashes 0.21's release runs on the i7-12700K, AT THE TAG v0.21.0+84236bf0 (9434d50e), pin BLAKE3-Servil 2037118c. CONTRIBUTING "Releases" step 4's runs for this machine:
# the full run, the b3sum run, the crowd run, the library's release check against 0.8, and the same-library check.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
export GIT_SSH_COMMAND="ssh -F /dev/null -i /home/agent/.ssh/id_ed25519_github_devonjonte -o IdentitiesOnly=yes -o UserKnownHostsFile=/home/agent/.ssh/known_hosts -o Hostname=ssh.github.com -p 443 -o StrictHostKeyChecking=yes -o ConnectTimeout=20"
O=/home/agent/bench-hashes-validation/release-021-i7/at-the-tag; mkdir -p $O
B=/home/agent/bench-021tag; F=/home/agent/BLAKE3-pin; M=/home/agent/BLAKE3-m3
C=2037118ca1da85710aef55d7f13b3abd9095b485
cd $B; echo "== bench $(git log --oneline -1 | cut -c1-60); library checkout $(git -C $F rev-parse --short=8 HEAD); governor $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor) $(date -u +%H:%M)"
EXE=$(./target/release/bench-hashes build-against $F 2> $O/build-against.stderr.txt | tail -1); echo "built: $EXE"
git checkout -q -- Cargo.lock 2>/dev/null
./target/release/bench-hashes quiet --wait > /dev/null 2>&1
rm -rf $O/full; mkdir -p $O/full; cd $O/full
s=$(date +%s); $EXE --all --expect-servil $C > report.txt 2> stderr.txt; echo "== full exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
cd $B
s=$(date +%s); LAYOUTS=4 python3 tools/b3sum-contenders.py $F /home/agent/b3c-pin > $O/b3sum-contenders.txt 2> $O/b3sum-contenders.stderr.txt; echo "== contenders exit $? in $(( $(date +%s) - s )) s"
./target/release/bench-hashes quiet --wait > /dev/null 2>&1
rm -rf $O/b3sum; mkdir -p $O/b3sum
s=$(date +%s); tr '\n' '\0' < $O/b3sum-contenders.txt | (cd $O/b3sum && xargs -0 $EXE b3sum --files /home/agent/b3sum-files > report.txt 2> stderr.txt); echo "== b3sum exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
./target/release/bench-hashes quiet --wait > /dev/null 2>&1
rm -rf $O/crowd; mkdir -p $O/crowd; cd $O/crowd
s=$(date +%s); $EXE crowd > report.txt 2> stderr.txt; echo "== crowd exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
cd $B
s=$(date +%s); ./target/release/bench-hashes check --fork $M --new $C --against b5b988d8 --old-bench 3363bee8 --points "continuous 1 MiB,continuous 4 MiB,continuous 16 MiB" --when-quiet --keep $O/check-long > $O/check-long.stdout.txt 2> $O/check-long.stderr.txt; echo "== release check, the long stream cells named (the pin against BLAKE3-Servil 0.8) exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
s=$(date +%s); ./target/release/bench-hashes check --fork $M --new $C --against b5b988d8 --old-bench 3363bee8 --cells all --when-quiet --keep $O/check > $O/check.stdout.txt 2> $O/check.stderr.txt; echo "== release check (the pin against BLAKE3-Servil 0.8) exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
s=$(date +%s); ./target/release/bench-hashes check --fork $M --new $C --against $C --old-bench 148827f3 --cells all --when-quiet --keep $O/check-same > $O/check-same.stdout.txt 2> $O/check-same.stderr.txt; echo "== same-library check (the pin on both sides, bench 148827f3 against this one) exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
echo "== done $(date -u +%H:%M)"

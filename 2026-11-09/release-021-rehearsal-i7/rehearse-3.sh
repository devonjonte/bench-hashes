#!/bin/sh
# Rehearsal of the 0.21 release runs at the release candidate (bench candidate/devon-release-021, BLAKE3-Servil dcc8ccff, the pin): full, b3sum, crowd.
# the full run, the b3sum run and the crowd run. The checks ran today already (samelib-next-i7).
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
export GIT_SSH_COMMAND="ssh -F /dev/null -i /home/agent/.ssh/id_ed25519_github_devonjonte -o IdentitiesOnly=yes -o UserKnownHostsFile=/home/agent/.ssh/known_hosts -o Hostname=ssh.github.com -p 443 -o StrictHostKeyChecking=yes -o ConnectTimeout=20"
O=/home/agent/bench-hashes-validation/release-021-i7/rehearsal-3; mkdir -p $O
B=/home/agent/bench-0194; F=/home/agent/BLAKE3-pin; C=dcc8ccff5d567f5e666b4c90bcb76cb78f0cf59b
cd $B; echo "== bench $(git log --oneline -1 | cut -c1-40); governor $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor) $(date -u +%H:%M)"
EXE=$(cargo run -q --release -- build-against $F 2> $O/build-against.stderr.txt | tail -1); echo "built: $EXE"
git checkout -q -- Cargo.lock 2>/dev/null
rm -rf $O/full; mkdir -p $O/full; cd $O/full
s=$(date +%s); $EXE --all --expect-servil $C > report.txt 2> stderr.txt; echo "== full exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
cd $B
s=$(date +%s); LAYOUTS=4 python3 tools/b3sum-contenders.py $F /home/agent/b3c-pin > $O/b3sum-contenders.txt 2> $O/b3sum-contenders.stderr.txt; echo "== contenders exit $? in $(( $(date +%s) - s )) s"
rm -rf $O/b3sum; mkdir -p $O/b3sum
s=$(date +%s); tr '\n' '\0' < $O/b3sum-contenders.txt | (cd $O/b3sum && xargs -0 $EXE b3sum --files /home/agent/b3sum-files > report.txt 2> stderr.txt); echo "== b3sum exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
rm -rf $O/crowd; mkdir -p $O/crowd; cd $O/crowd
s=$(date +%s); $EXE crowd > report.txt 2> stderr.txt; echo "== crowd exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
echo "== done $(date -u +%H:%M)"

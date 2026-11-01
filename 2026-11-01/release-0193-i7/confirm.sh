#!/bin/sh
# The same-library check's two slower cells, 16 fresh pairs from its kept
# links (4 a side, each run 4 times), judged on those two; then b3sum again.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
O=/home/agent/bench-hashes-validation/release-0193-i7
OLD=""; NEW=""
for r in 1 2 3 4; do for s in 0 1 2 3; do OLD="$OLD /home/agent/BLAKE3-rel019/target/check/old/bench-hashes-$s"; NEW="$NEW /home/agent/BLAKE3-rel019/target/check/new/bench-hashes-$((s+4))"; done; done
cd /home/agent/bench-0193
s=$(date +%s); /home/agent/BLAKE3-rel019/target/check/new/bench-hashes-4 regress --pairs 16 --contenders blake3-servil-mt,blake3-servil-st --points "lent 64 MiB,idle 16" --judge "blake3-servil-mt|shared|LentMessages|64 MiB;blake3-servil-st|solo|IdleManyMessages|16" --keep $O/confirm $OLD -- $NEW > $O/confirm.stdout.txt 2> $O/confirm.stderr.txt; echo "== confirm exit $? in $(( $(date +%s) - s )) s"
rm -rf $O/b3sum-2; mkdir -p $O/b3sum-2
s=$(date +%s); tr '\n' '\0' < $O/b3sum-contenders.txt | (cd $O/b3sum-2 && xargs -0 /home/agent/bench-0193/target/release/bench-hashes b3sum --files /home/agent/bench-hashes-validation/b3sum-linux/files > report.txt 2> stderr.txt); echo "== b3sum-2 exit $? in $(( $(date +%s) - s )) s"

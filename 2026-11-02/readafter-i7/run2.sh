#!/bin/sh
# The same A/B for sha256-ring and official (st), after-other-work small cells: is the 40-68% servil's or the bench's?
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
O=/home/agent/bench-hashes-validation/readafter-i7
OLD=""; NEW=""; for i in 1 2 3 4 5 6; do OLD="$OLD $O/bench-A"; NEW="$NEW $O/bench-B"; done
s=$(date +%s); $O/bench-A regress --pairs 6 --contenders sha256-ring,blake3-official --points "64 B,1 KiB,16 KiB,2,16,idle 64 B,idle 1 KiB" --keep $O/regress2 $OLD -- $NEW > $O/regress2.stdout.txt 2> $O/regress2.stderr.txt; echo "regress2 exit $? in $(( $(date +%s) - s )) s"

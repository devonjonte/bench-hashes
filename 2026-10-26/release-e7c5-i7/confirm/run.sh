#!/bin/sh
# st solo "idle 3839 B": e7c5ef48 against bfbda19 on the release check's
# relinked builds (those it made today, 20 a side), then two same-code
# controls on disjoint halves.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
C=/home/agent/BLAKE3-rel08/target/check
B=/home/agent/BLAKE3-rel08/bench-hashes/target/release/bench-hashes
cd /home/agent/BLAKE3-rel08/bench-hashes
pick() { python3 -c "
import glob,os,sys,time
fs=[f for f in glob.glob('$C/'+sys.argv[1]+'/bench-hashes-*') if os.path.getmtime(f)>time.time()-12*3600]
print(' '.join(sorted(fs,key=lambda f:int(f.rsplit('-',1)[1]))))" $1; }
O=$(pick old); N=$(pick new)
echo "old: $(echo $O | wc -w) builds; new: $(echo $N | wc -w)"
P="idle 3839 B,3839 B,idle 4 KiB,idle 3 KiB"
K=/home/agent/bench-hashes-validation/confirm-3839
n=$(echo $O | wc -w); h=$((n/2))
echo "== e7c5ef48 vs bfbda19, $n pairs"
$B regress --pairs $n --contenders blake3-servil-st --points "$P" --keep $K/main $O -- $N || true
echo "== control old vs old, $h pairs"
$B regress --pairs $h --contenders blake3-servil-st --points "$P" --keep $K/aa-old $(echo $O | cut -d' ' -f1-$h) -- $(echo $O | cut -d' ' -f$((h+1))-$n) || true
echo "== control new vs new, $h pairs"
$B regress --pairs $h --contenders blake3-servil-st --points "$P" --keep $K/aa-new $(echo $N | cut -d' ' -f1-$h) -- $(echo $N | cut -d' ' -f$((h+1))-$n) || true

#!/bin/sh
set -eu
W=$HOME/tmp/relink-proof
cd $HOME/bench-icache
nm target/release/bench-hashes | awk 'NF==3 && ($2=="t" || $2=="T") {print $3}' | sort -u > $W/symbols.txt
python3 - <<'PY'
import random
s=open('$HOME/tmp/relink-proof/symbols.txt').read().split()
for name,seed in (('A',1),('B',2)):
    t=s[:]; random.Random(seed).shuffle(t); open(f'$HOME/tmp/relink-proof/order-{name}.txt','w').write('\n'.join(t)+'\n')
print(len(s),'function symbols')
PY
link() { printf '%s\n' -Clink-arg=-fuse-ld=lld -Clink-arg=-B$W/lld -Clink-arg=-Wl,--symbol-ordering-file=$W/order-$1.txt -Clink-arg=-Wl,--no-warn-symbol-ordering; }
for o in A B; do
  s=$(date +%s.%N)
  cargo rustc --release --quiet --bin bench-hashes -- $(link $o)
  e=$(date +%s.%N); cp target/release/bench-hashes $W/today-$o
  echo "today's relink $o: $(echo "$e - $s" | bc) s"
done
s=$(date +%s.%N)
RELINK_KEEP=$W/keep cargo rustc --release --quiet --bin bench-hashes -- -Clinker=$W/linkwrap.py $(link A)
e=$(date +%s.%N); cp target/release/bench-hashes $W/captured-A
echo "captured build A: $(echo "$e - $s" | bc) s"
s=$(date +%s.%N)
python3 $W/relink.py $W/keep $W/order-B.txt $W/relinked-B
e=$(date +%s.%N)
echo "relink from the kept objects, B: $(echo "$e - $s" | bc) s"
sha256sum $W/today-A $W/captured-A $W/today-B $W/relinked-B | sed "s#$W/##"
cmp $W/today-A $W/captured-A && echo "captured A is today's A, byte for byte"
cmp $W/today-B $W/relinked-B && echo "relinked B is today's B, byte for byte"
ls $W/keep | head; du -sh $W/keep | cut -f1

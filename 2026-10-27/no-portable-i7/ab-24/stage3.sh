set -u
cd /home/agent/BLAKE3-np/bench-hashes
B=target/release/bench-hashes
C=/home/agent/BLAKE3-np/target/check
P=/home/agent/bench-hashes-validation/no-portable
OLD=$(ls $C/old | grep -E '^bench-hashes-[0-9]+$' | sort -V | sed "s|^|$C/old/|"); NEW=$(ls $C/new | grep -E '^bench-hashes-[0-9]+$' | sort -V | sed "s|^|$C/new/|")
N=$(echo "$OLD" | wc -l); H=$((N / 2)); OLDA=$(echo "$OLD" | head -$H); OLDB=$(echo "$OLD" | tail -$H)
PTS="1,128 B,16,3,512,512 B,idle 6"
echo "== A/B, 24 pairs"
$B regress --contenders blake3-servil-mt,blake3-servil-st --points "$PTS" --pairs 24 --keep $P/stage3-ab $OLD -- $NEW; echo "rc=$?"
echo "== A/A (old layouts against old layouts), 24 pairs"
$B regress --contenders blake3-servil-mt,blake3-servil-st --points "$PTS" --pairs 24 --keep $P/stage3-aa $OLDA -- $OLDB; echo "rc=$?"

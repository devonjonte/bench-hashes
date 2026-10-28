set -u
B=/home/agent/BLAKE3-fixes/bench-hashes/target/release/bench-hashes; C=/home/agent/BLAKE3-fixes/target/check; O=/home/agent/bench-hashes-validation/fixes-7c87-i7
OLD=$(ls $C/old | grep -E '^bench-hashes-[0-9]+$' | sort -V | sed "s|^|$C/old/|"); NEW=$(ls $C/new | grep -E '^bench-hashes-[0-9]+$' | sort -V | sed "s|^|$C/new/|")
H=$(( $(echo "$OLD" | wc -l) / 2 )); PTS="256 B,512 B,2 KiB,4 KiB,idle 512 B,idle 32"
$B regress --contenders blake3-servil-st --points "$PTS" --pairs 24 --keep $O/confirm-ab $OLD -- $NEW; echo "ab rc=$?"
$B regress --contenders blake3-servil-st --points "$PTS" --pairs 24 --keep $O/confirm-aa $(echo "$OLD" | head -$H) -- $(echo "$OLD" | tail -$H); echo "aa rc=$?"

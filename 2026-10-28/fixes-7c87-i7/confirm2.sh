set -u
B=/home/agent/BLAKE3-fixes/bench-hashes/target/release/bench-hashes; C=/home/agent/BLAKE3-fixes/target/check; O=/home/agent/bench-hashes-validation/fixes-7c87-i7
OLD=$(ls $C/old | grep -E '^bench-hashes-[0-9]+$' | sort -V | sed "s|^|$C/old/|"); NEW=$(ls $C/new | grep -E '^bench-hashes-[0-9]+$' | sort -V | sed "s|^|$C/new/|")
H=$(( $(echo "$OLD" | wc -l) / 2 )); PTS="idle 256 B,idle 512 B,idle 1 KiB"
$B regress --contenders blake3-servil-st --points "$PTS" --pairs 32 --keep $O/confirm2-ab $OLD -- $NEW; echo "ab rc=$?"
$B regress --contenders blake3-servil-st --points "$PTS" --pairs 32 --keep $O/confirm2-aa-old $(echo "$OLD" | head -$H) -- $(echo "$OLD" | tail -$H); echo "aa-old rc=$?"
$B regress --contenders blake3-servil-st --points "$PTS" --pairs 32 --keep $O/confirm2-aa-new $(echo "$NEW" | head -$H) -- $(echo "$NEW" | tail -$H); echo "aa-new rc=$?"

set -u
B=/home/agent/BLAKE3-pad/bench-hashes/target/release/bench-hashes; C=/home/agent/BLAKE3-fill/target/check; P=/home/agent/bench-hashes-validation/fill-204
OLD=$(ls $C/old | grep -E '^bench-hashes-[0-9]+$' | sort -V | sed "s|^|$C/old/|"); NEW=$(ls $C/new | grep -E '^bench-hashes-[0-9]+$' | sort -V | sed "s|^|$C/new/|")
H=$(( $(echo "$OLD" | wc -l) / 2 )); PTS="idle 16,idle 48,idle 2304 B"
$B regress --contenders blake3-servil-mt --points "$PTS" --pairs 24 --keep $P/confirm-ab $OLD -- $NEW; echo "ab rc=$?"
$B regress --contenders blake3-servil-mt --points "$PTS" --pairs 24 --keep $P/confirm-aa $(echo "$OLD" | head -$H) -- $(echo "$OLD" | tail -$H); echo "aa rc=$?"

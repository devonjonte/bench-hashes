set -u
cd /home/agent/BLAKE3-rel08/bench-hashes
B=target/release/bench-hashes; C=/home/agent/BLAKE3-rel08/target/check
P=/home/agent/bench-hashes-validation/release-check-4d3a
OLD=$(ls $C/old | grep -E '^bench-hashes-[0-9]+$' | sort -V | sed "s|^|$C/old/|"); NEW=$(ls $C/new | grep -E '^bench-hashes-[0-9]+$' | sort -V | sed "s|^|$C/new/|")
echo "== A/B, 24 pairs"
$B regress --contenders blake3-servil-mt,blake3-servil-st --points "32,4 KiB" --pairs 24 --keep $P/confirm-ab $OLD -- $NEW; echo "rc=$?"
echo "== A/A old, 24 pairs"
$B regress --contenders blake3-servil-mt,blake3-servil-st --points "32,4 KiB" --pairs 24 --keep $P/confirm-aa-old $(echo "$OLD" | head -2) -- $(echo "$OLD" | tail -2); echo "rc=$?"
echo "== A/A new, 24 pairs"
$B regress --contenders blake3-servil-mt,blake3-servil-st --points "32,4 KiB" --pairs 24 --keep $P/confirm-aa-new $(echo "$NEW" | head -2) -- $(echo "$NEW" | tail -2); echo "rc=$?"

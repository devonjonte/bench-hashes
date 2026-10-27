set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/release-08-i7
cd /home/agent/BLAKE3-rel08/bench-hashes
echo "== release check again, for its builds $(date -u +%H:%M)"
cargo run -q --release -- check --against bfbda1920283335ff3802723db11c209159f47fc --old-bench 5be5f23699ee7146ada56a08777173a4ee1c7bde --cells all --keep $O/release-check-2
echo "== exit $? $(date -u +%H:%M)"
B=target/release/bench-hashes; C=/home/agent/BLAKE3-rel08/target/check
OLD=$(ls $C/old | grep -E '^bench-hashes-[0-9]+$' | sort -V | sed "s|^|$C/old/|"); NEW=$(ls $C/new | grep -E '^bench-hashes-[0-9]+$' | sort -V | sed "s|^|$C/new/|")
N=$(echo "$OLD" | wc -l); H=$((N / 2))
PTS="idle 3839 B,continuous 256 KiB,idle 1536 B,idle 4 KiB,4 KiB"
for run in "ab|$OLD|$NEW" "aa-old|$(echo "$OLD" | head -$H)|$(echo "$OLD" | tail -$H)" "aa-new|$(echo "$NEW" | head -$H)|$(echo "$NEW" | tail -$H)"; do
  name=${run%%|*}; rest=${run#*|}; a=${rest%%|*}; b=${rest#*|}
  echo "== $name, 24 pairs $(date -u +%H:%M)"
  $B regress --contenders blake3-servil-mt,blake3-servil-st --points "$PTS" --pairs 24 --keep $O/confirm-$name $a -- $b; echo "rc=$?"
done

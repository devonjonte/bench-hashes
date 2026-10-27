set -u
cd /home/agent/BLAKE3-np/bench-hashes
P=/home/agent/bench-hashes-validation/no-portable
cargo run --release -q -- check --against 2907ea5d --cells all --keep $P/check-noinline-keep; echo "check rc=$?"
B=target/release/bench-hashes; C=/home/agent/BLAKE3-np/target/check
OLD=$(ls $C/old | grep -E '^bench-hashes-[0-9]+$' | sort -V | sed "s|^|$C/old/|"); NEW=$(ls $C/new | grep -E '^bench-hashes-[0-9]+$' | sort -V | sed "s|^|$C/new/|")
for e in $(echo "$NEW" | head -1); do nm -C $e | grep -c 'pair::hash_many_blocks' | sed 's/^/hash_many_blocks symbols in new: /'; done
$B regress --contenders blake3-servil-mt,blake3-servil-st --points "1,3,16" --pairs 24 --keep $P/stage4-ab $OLD -- $NEW; echo "regress rc=$?"

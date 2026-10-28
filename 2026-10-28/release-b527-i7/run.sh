set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/release-b527-i7
cd /home/agent/BLAKE3-fixes/bench-hashes
cargo run -q --release -- check --against 83d59db22f6d606d96a5e38223d411123e8cbd18 --old-bench 2c9633ae69712b2e40363584387ba5665261997b --cells all --keep $O/check-keep > $O/check.stdout.txt 2> $O/check.stderr.txt; echo "check exit $?"
git checkout -q -- Cargo.lock 2>/dev/null
B=target/release/bench-hashes; C=/home/agent/BLAKE3-fixes/target/check
OLD=$(ls $C/old | grep -E '^bench-hashes-[0-9]+$' | sort -V | sed "s|^|$C/old/|"); NEW=$(ls $C/new | grep -E '^bench-hashes-[0-9]+$' | sort -V | sed "s|^|$C/new/|")
H=$(( $(echo "$OLD" | wc -l) / 2 )); PTS="2,4,6,12,idle 2,idle 3"
$B regress --contenders blake3-servil-st --points "$PTS" --pairs 24 --keep $O/ab $OLD -- $NEW; echo "ab rc=$?"
$B regress --contenders blake3-servil-st --points "$PTS" --pairs 24 --keep $O/aa $(echo "$OLD" | head -$H) -- $(echo "$OLD" | tail -$H); echo "aa rc=$?"

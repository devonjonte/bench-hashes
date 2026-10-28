set -u
O=/home/agent/bench-hashes-validation/fixes-d34a-i7
bash $O/suites.sh > $O/suites.stdout.txt 2> $O/suites.stderr.txt; echo "== suites done $(date -u +%H:%M)"
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
cd /home/agent/BLAKE3-fixes/bench-hashes
cargo run -q --release -- check --against 83d59db22f6d606d96a5e38223d411123e8cbd18 --old-bench 2c9633ae69712b2e40363584387ba5665261997b --cells all --keep $O/check-keep > $O/check.stdout.txt 2> $O/check.stderr.txt; echo "== check exit $? $(date -u +%H:%M)"
git checkout -q -- Cargo.lock 2>/dev/null
cd /home/agent/BLAKE3-fixes
python3 tools/mutants/check.py --write > $O/mutants.stdout.txt 2> $O/mutants.stderr.txt; echo "== mutants exit $? $(date -u +%H:%M)"

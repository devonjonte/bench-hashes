set -u
cd /home/agent/BLAKE3-np
export RUSTFLAGS="-D warnings"
cargo nextest run --features=serde,zeroize; echo "STEP features rc=$?"
cargo test --doc --features=serde,zeroize; echo "STEP doc rc=$?"
cargo nextest run --no-default-features; echo "STEP nostd rc=$?"
cargo nextest run --features= --release; echo "STEP release rc=$?"
(cd test_vectors && cargo nextest run); echo "STEP vectors rc=$?"
(cd capi && cargo nextest run --release); echo "STEP capi rc=$?"
(cd b3sum && cargo nextest run); echo "STEP b3sum rc=$?"

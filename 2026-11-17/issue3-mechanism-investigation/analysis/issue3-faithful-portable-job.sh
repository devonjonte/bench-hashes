#!/bin/sh
# Negative control with the released clocks crate's actual gap/brackets.
# Empty callback, one hash, eight hashes, and a dependent arithmetic chain.
# One core-only probe binary, four processes on each of CPUs 0 and 24.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
if [ "${ISSUE3_FAITHFUL_BOUNDED:-}" != yes ]; then
  export ISSUE3_FAITHFUL_BOUNDED=yes
  status=0
  timeout --kill-after=15s 900s sh "$O/run.sh" || status=$?
  printf 'FAITHFUL_PROBE_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
mkdir "$O/source"
base64 --decode <<'SOURCE_BASE64' | tar xzf - -C "$O/source"
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
0n8B52C2cgBQAAA=
SOURCE_BASE64
export CARGO_TARGET_DIR="$HOME/work/${O##*/}-target"
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0
unset RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
cargo build --release --locked --manifest-path "$O/source/Cargo.toml" > "$O/build.log" 2>&1
cargo metadata --locked --format-version 1 --manifest-path "$O/source/Cargo.toml" > "$O/selected-sources.json"
export O
python3 - <<'PY_SOURCES'
import json,os,pathlib
p=pathlib.Path(os.environ['O'])
data=json.loads((p/'selected-sources.json').read_text())
wanted={'clocks':'cade30fdb71682719f5fa3e586ff96146ae9fc25','blake3-servil-core':'27eacce3a5c2e03043f4fcd347c178a80f9d911c'}
for name,rev in wanted.items():
    selected=[x for x in data['packages'] if x['name']==name]
    assert len(selected)==1,(name,selected)
    assert selected[0]['source'].endswith('#'+rev),selected[0]
PY_SOURCES
EXE="$CARGO_TARGET_DIR/release/issue3-faithful-probe"
sha256sum "$EXE" > "$O/executable.SHA256SUMS"
# Portable file-identity plumbing: the pinned core dependency is already built.
# This helper is outside the measurement, and its known digest was checked
# against independent b3sum before dispatch.
cat > "$O/hash-files.rs" <<'HASH_SOURCE'
// File-identity plumbing, outside every measurement. The second digest
// is SHA-256, supplied by sha256sum. Anchor this library's empty digest.
fn main() {
    blake3_servil_core::initialize();
    assert_eq!(blake3_servil_core::convenience::hash(b"").to_hex().as_str(),
        "af1349b9f5f9a1a6a0404dea36dcc9499bcb25c9adc112b7cc9a93cae41f3262");
    for path in std::env::args().skip(1) {
        let bytes = std::fs::read(&path).unwrap();
        println!("{}  {}", blake3_servil_core::convenience::hash(&bytes).to_hex(), path);
    }
}
HASH_SOURCE
CORE=$(find "$CARGO_TARGET_DIR/release/deps" -maxdepth 1 -name 'libblake3_servil_core-*.rlib' -print)
test -f "$CORE"
rustc --edition 2021 --crate-name issue3_hash_files -C panic=abort -C lto=fat "$O/hash-files.rs" --extern "blake3_servil_core=$CORE" -L "dependency=$CARGO_TARGET_DIR/release/deps" -o "$CARGO_TARGET_DIR/release/hash-files"
"$CARGO_TARGET_DIR/release/hash-files" "$EXE" > "$O/executable.BLAKE3SUMS"
rustc -Vv > "$O/compiler.txt"
lscpu -e=CPU,CORE,SOCKET,NODE,ONLINE > "$O/topology.txt"
cat > "$O/quiet.rs" <<'QUIET_SOURCE'
fn main() { clocks::load::wait_until_quiet(); println!("quiet"); }
QUIET_SOURCE
CLOCKS=$(find "$CARGO_TARGET_DIR/release/deps" -maxdepth 1 -name 'libclocks-*.rlib' -print)
test -f "$CLOCKS"
rustc --edition 2021 --crate-name issue3_quiet -C panic=abort -C lto=fat "$O/quiet.rs" --extern "clocks=$CLOCKS" -L "dependency=$CARGO_TARGET_DIR/release/deps" -o "$CARGO_TARGET_DIR/release/quiet"
timeout 90 "$CARGO_TARGET_DIR/release/quiet" > "$O/quiet.txt" 2>&1
for repeat in 0 1 2 3; do
  if [ $((repeat % 2)) = 0 ]; then cpus='0 24'; else cpus='24 0'; fi
  for cpu in $cpus; do
    timeout --kill-after=5s 60s taskset -c "$cpu" "$EXE" > "$O/run-$repeat-cpu$cpu.tsv" 2> "$O/run-$repeat-cpu$cpu.stderr.txt"
  done
done
printf 'Completed 8 processes: one executable, 2 CPUs x 4 repeats.\n'

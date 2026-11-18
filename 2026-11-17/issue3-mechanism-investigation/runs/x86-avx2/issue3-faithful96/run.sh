#!/bin/sh
# Negative control with the released clocks crate's actual gap/brackets.
# 96 fixed rounds: >=1.536 s of gaps/process, so clocks observes load windows.
# The 24-round pilot lasted under a second and remains qualified as unobserved.
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

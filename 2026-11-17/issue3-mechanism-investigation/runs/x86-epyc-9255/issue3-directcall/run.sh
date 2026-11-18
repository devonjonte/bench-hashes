#!/bin/sh
# Predeclared call-binding intervention, November 17, 2026.
# Eight alternating pairs on CPU 0. Change only two verified FFI call
# instructions in place, holding the inode and every relative code address.
# Four cases: empty, one hash, eight hashes, arithmetic. Shared clocks,
# observed load, standard paired judgment; one build, no release claim.
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
/wssNXS/AHgAAA==
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
TRIAL="$CARGO_TARGET_DIR/release/experiment"
cp "$EXE" "$TRIAL"
export TRIAL
python3 "$O/source/patch_calls.py" prepare "$TRIAL" "$O/call-bindings.json" "$CARGO_TARGET_DIR/release/hash-files" > "$O/patch-preflight.txt"
python3 - <<'PAIRED_RUNS'
import os,pathlib,subprocess,sys
out=pathlib.Path(os.environ['O'])
trial=pathlib.Path(os.environ['TRIAL'])
hasher=trial.parent/'hash-files'
with (out/'schedule.tsv').open('w') as log:
    log.write('pair\torder\tmode\tcpu\tstatus\n')
    for pair in range(8):
        order=['indirect','direct'] if pair%2==0 else ['direct','indirect']
        for position,mode in enumerate(order):
            subprocess.run([sys.executable,str(out/'source/patch_calls.py'),'set',mode,str(trial),str(out/'call-bindings.json'),str(hasher)],check=True)
            name=f'pair-{pair:02}-{mode}'
            with (out/(name+'.tsv')).open('w') as stdout,(out/(name+'.stderr.txt')).open('w') as stderr:
                result=subprocess.run(['timeout','--kill-after=5s','60s','taskset','-c','0',str(trial)],stdout=stdout,stderr=stderr)
            log.write(f'{pair}\t{position}\t{mode}\t0\t{result.returncode}\n')
            log.flush()
            assert result.returncode==0,(pair,mode,result.returncode)
# Restore the source-generated bytes after the experiment.
subprocess.run([sys.executable,str(out/'source/patch_calls.py'),'set','indirect',str(trial),str(out/'call-bindings.json'),str(hasher)],check=True)
old=[str(out/f'pair-{i:02}-indirect.tsv') for i in range(8)]
new=[str(out/f'pair-{i:02}-direct.tsv') for i in range(8)]
with (out/'comparison.tsv').open('w') as f:
    subprocess.run([str(trial.parent/'compare'),*old,'--',*new],stdout=f,check=True)
print('Completed eight paired processes, four cases; private executable restored to indirect calls.')
PAIRED_RUNS

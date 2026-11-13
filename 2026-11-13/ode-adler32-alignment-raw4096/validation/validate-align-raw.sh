#!/bin/sh
set -eu
export PATH=<development-home>/.cargo/bin:<development-home>/bin:$PATH TMPDIR=<development-home>/tmp
E=<development-home>/BLAKE3-ode-read/tools/verify/machine/experiments/adler32
V=<development-home>/bench-hashes-validation/ode-adler-fast
B=$V/build-align-raw
SDE=<development-home>/bench-hashes-validation/x86-kernels-20261022/sde-external-10.13.1-2026-07-28-lin/sde64
python3 "$E/prepare_bench.py" <development-home>/bench-0194 <development-home>/bench-hashes-validation/ode-design-reading/adler-proof-committed <development-home>/adler-comparison-deps "$B" --skip-proof
cargo build --release --manifest-path "$B/Cargo.toml" > "$V/align-raw-build.txt" 2>&1
"$SDE" -future -- "$B/target/release/ode-adler-observer" --validate > "$V/align-raw-emulated-validation.txt" 2>&1
if (ulimit -c 0; "$SDE" -future -- "$B/target/release/ode-adler-observer" --overread-control) > "$V/align-raw-overread-control.txt" 2>&1; then
 echo 'planted overread survived' >&2; exit 1
else
 code=$?; test "$code" -eq 139; echo 'planted overread: SIGSEGV as required' >> "$V/align-raw-overread-control.txt"
fi
cp "$B/raw4096.S" "$V/raw4096.saved.S"
trap 'cp "$V/raw4096.saved.S" "$B/raw4096.S"' EXIT
python3 - "$B/raw4096.S" <<'PY'
from pathlib import Path
import sys
p=Path(sys.argv[1]); s=p.read_text(); old='vpslld zmm8, zmm8, 7'; assert s.count(old)==1
p.write_text(s.replace(old,'vpslld zmm8, zmm8, 6'))
PY
cargo build --release --manifest-path "$B/Cargo.toml" > "$V/align-raw-mutation-build.txt" 2>&1
if "$SDE" -future -- "$B/target/release/ode-adler-observer" --validate > "$V/align-raw-mutation-validation.txt" 2>&1; then
 echo 'wrong weighted shift survived' >&2; exit 1
else
 code=$?; test "$code" -eq 101; echo 'wrong weighted shift: raw fixed anchor fails as required' >> "$V/align-raw-mutation-validation.txt"
fi
cp "$V/raw4096.saved.S" "$B/raw4096.S"
cargo build --release --manifest-path "$B/Cargo.toml" > "$V/align-raw-restored-build.txt" 2>&1
"$SDE" -future -- "$B/target/release/ode-adler-observer" --validate > "$V/align-raw-restored-validation.txt" 2>&1
trap - EXIT
cargo nextest run --release --manifest-path "$B/Cargo.toml" --no-default-features > "$V/align-raw-reader-tests.txt" 2>&1
python3 - "$V" "$B" <<'PY'
from pathlib import Path
import subprocess,sys
v,b=map(Path,sys.argv[1:])
for name in ['probe512','probe512_one','probe256','probe256_one','probe512_r32']:
 def object_in(root):
  paths=list((root/'target/release/build').glob('ode-adler-observer-*/out/'+name+'.o')); assert len(paths)==1,paths
  return paths[0]
 old=object_in(v/'build-followup'); new=object_in(b)
 for flag in ['-s','-h','-r']:
  def snap(p): return subprocess.check_output(['objdump',flag,p],text=True).replace(str(p),'OBJECT')
  assert snap(old)==snap(new),(name,flag)
print('all five earlier probe objects retain exact section bytes/headers/relocations')
PY
echo 'emulated validation, guard and changed-kernel controls, restored validation, reader tests and same-code object checks complete'

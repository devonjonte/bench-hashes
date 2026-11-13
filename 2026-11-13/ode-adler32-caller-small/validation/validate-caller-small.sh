#!/bin/sh
set -eu
export PATH=<development-home>/.elan/bin:<development-home>/.cargo/bin:<development-home>/bin:$PATH TMPDIR=<development-home>/tmp
E=<development-home>/BLAKE3-ode-read/tools/verify/machine/experiments/adler32
V=<development-home>/bench-hashes-validation/ode-adler-fast
B=$V/build-caller-small
SDE=<development-home>/bench-hashes-validation/x86-kernels-20261022/sde-external-10.13.1-2026-07-28-lin/sde64
(cd "$E/../../lang" && lake env lean "$E/Block_adler32.lean")
python3 "$E/prepare_bench.py" <development-home>/bench-0194 <development-home>/bench-hashes-validation/ode-design-reading/adler-proof-committed <development-home>/adler-comparison-deps "$B" --skip-proof
cargo build --release --manifest-path "$B/Cargo.toml" > "$V/caller-small-build.txt" 2>&1
"$SDE" -future -- "$B/target/release/ode-adler-observer" --validate > "$V/caller-small-emulated-validation.txt" 2>&1
cp "$B/probe4096.c" "$V/caller.saved.c"
cp "$B/probe.c" "$V/probe-small.saved.c"
trap 'cp "$V/caller.saved.c" "$B/probe4096.c"; cp "$V/probe-small.saved.c" "$B/probe.c"' EXIT
python3 - "$B/probe4096.c" <<'PY'
from pathlib import Path
import sys
p=Path(sys.argv[1]);s=p.read_text();old='b = bb % 65521;';assert s.count(old)==1
p.write_text(s.replace(old,'b = (uint32_t)bb % 65521;'))
PY
cargo build --release --manifest-path "$B/Cargo.toml" > "$V/caller-small-truncation-build.txt" 2>&1
if "$SDE" -future -- "$B/target/release/ode-adler-observer" --validate > "$V/caller-small-truncation-control.txt" 2>&1; then
 echo 'truncated weighted sum survived' >&2; exit 1
else
 code=$?; test "$code" -eq 101; echo 'truncated weighted sum refused' >> "$V/caller-small-truncation-control.txt"
fi
cp "$V/caller.saved.c" "$B/probe4096.c"
python3 - "$B/probe.c" <<'PY'
from pathlib import Path
import sys
p=Path(sys.argv[1]);s=p.read_text();old='if (len > 22) b%=65521;';assert s.count(old)==1
p.write_text(s.replace(old,'if (len > 23) b%=65521;'))
PY
cargo build --release --manifest-path "$B/Cargo.toml" > "$V/caller-small-threshold-build.txt" 2>&1
if "$SDE" -future -- "$B/target/release/ode-adler-observer" --validate > "$V/caller-small-threshold-control.txt" 2>&1; then
 echo 'wrong small threshold survived' >&2; exit 1
else
 code=$?; test "$code" -eq 101; echo 'wrong small threshold refused by independent23-byte all-255 anchor' >> "$V/caller-small-threshold-control.txt"
fi
cp "$V/probe-small.saved.c" "$B/probe.c"
cargo build --release --manifest-path "$B/Cargo.toml" > "$V/caller-small-restored-build.txt" 2>&1
"$SDE" -future -- "$B/target/release/ode-adler-observer" --validate > "$V/caller-small-restored-validation.txt" 2>&1
trap - EXIT
cargo nextest run --release --manifest-path "$B/Cargo.toml" --no-default-features > "$V/caller-small-reader-tests.txt" 2>&1
python3 - "$V" "$B" <<'PY'
from pathlib import Path
import subprocess,sys
v,b=map(Path,sys.argv[1:])
for name in ['probe512.o','probe512_one.o','probe256.o','probe256_one.o','probe512_r32.o','probe512_align.o','probe4096.c.o','raw4096.S.o']:
 def object_in(root):
  paths=list((root/'target/release/build').glob('ode-adler-observer-*/out/'+name));assert len(paths)==1,paths
  return paths[0]
 old=object_in(v/'build-align-raw');new=object_in(b)
 for flag in ['-s','-h','-r']:
  def snap(p):return subprocess.check_output(['objdump',flag,p],text=True).replace(str(p),'OBJECT')
  assert snap(old)==snap(new),(name,flag)
print('all eight earlier native objects retain exact section contents/headers/relocations')
PY
echo 'caller/small candidates: bounds,16-engine execution/guards, both mutation controls, restored control and reader/object checks pass'

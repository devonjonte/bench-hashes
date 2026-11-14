#!/bin/sh
set -eu
export PATH=<development-home>/.elan/bin:<development-home>/.cargo/bin:<development-home>/bin:$PATH TMPDIR=<development-home>/tmp
E=<development-home>/BLAKE3-ode-read/tools/verify/machine/experiments/adler32
V=<development-home>/bench-hashes-validation/ode-adler-fast
B=$V/build-cleanup-dispatch
SDE=<development-home>/bench-hashes-validation/x86-kernels-20261022/sde-external-10.13.1-2026-07-28-lin/sde64
python3 "$E/prepare_bench.py" <development-home>/bench-0194 <development-home>/bench-hashes-validation/ode-design-reading/adler-proof-committed <development-home>/adler-comparison-deps "$B" --skip-proof
cargo build --release --manifest-path "$B/Cargo.toml" > "$V/cleanup-dispatch-build.txt" 2>&1
"$SDE" -future -- "$B/target/release/ode-adler-observer" --validate > "$V/cleanup-dispatch-emulated-validation.txt" 2>&1
cp "$B/probe.c" "$V/probe-dispatch.saved.c"
trap 'cp "$V/probe-dispatch.saved.c" "$B/probe.c"' EXIT
python3 - "$B/probe.c" <<'PY'
from pathlib import Path
import sys
p=Path(sys.argv[1]);s=p.read_text();old='return probe512_align(p,len);';assert s.count(old)==1
p.write_text(s.replace(old,'return probe512_align(p,len-1);'))
PY
cargo build --release --manifest-path "$B/Cargo.toml" > "$V/cleanup-dispatch-mutation-build.txt" 2>&1
if "$SDE" -future -- "$B/target/release/ode-adler-observer" --validate > "$V/cleanup-dispatch-mutation-control.txt" 2>&1; then
 echo 'wrong dispatch length survived' >&2; exit 1
else
 code=$?; test "$code" -eq 101; echo 'wrong dispatch length refused' >> "$V/cleanup-dispatch-mutation-control.txt"
fi
cp "$V/probe-dispatch.saved.c" "$B/probe.c"
cargo build --release --manifest-path "$B/Cargo.toml" > "$V/cleanup-dispatch-restored-build.txt" 2>&1
"$SDE" -future -- "$B/target/release/ode-adler-observer" --validate > "$V/cleanup-dispatch-restored-validation.txt" 2>&1
trap - EXIT
cargo nextest run --release --manifest-path "$B/Cargo.toml" --no-default-features > "$V/cleanup-dispatch-reader-tests.txt" 2>&1
python3 "$V/capture-raw-image.py" "$B/target/release/ode-adler-observer" "$V/cleanup-image-original" "$B" "$E/../.."
python3 "$V/capture-raw-image.py" "$B/target/release/ode-adler-observer" "$V/cleanup-image-dirty" "$B" "$E/../.." b3ldirty_raw4096 1898
python3 - "$V" "$B" <<'PY'
from pathlib import Path
import subprocess,re,sys
v,b=map(Path,sys.argv[1:])
for name in ['probe512.o','probe512_one.o','probe256.o','probe256_one.o','probe512_r32.o','probe512_align.o','probe512_small.o','probe4096.c.o','probe4096_batch.c.o','probe4096_entry.c.o','raw4096.S.o']:
 def object_in(root):
  paths=list((root/'target/release/build').glob('ode-adler-observer-*/out/'+name));assert len(paths)==1,paths
  return paths[0]
 old=object_in(v/'build-caller-small');new=object_in(b)
 for flag in ['-s','-h','-r']:
  def snap(p):return subprocess.check_output(['objdump',flag,p],text=True).replace(str(p),'OBJECT')
  assert snap(old)==snap(new),(name,flag)
print('all eleven earlier native objects retain exact section contents/headers/relocations')
listing=subprocess.check_output(['objdump','-d','-Mintel','--disassemble=probe4096_cleanup',b/'target/release/ode-adler-observer'],text=True)
(v/'cleanup-caller.listing').write_text(listing)
assert listing.count('vzeroupper')==1
assert not re.search(r'\b(?:xmm|ymm|zmm)\d+\b',listing)
print('cleanup caller contains only word code between block calls and one final vzeroupper')
PY
echo 'cleanup/dispatch:18-engine execution/guards, mutation/restored controls, reader, image and unchanged-object checks pass'

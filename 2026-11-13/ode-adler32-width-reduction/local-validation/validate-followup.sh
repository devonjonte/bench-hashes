#!/bin/sh
set -eu
export PATH=<development-home>/.cargo/bin:<development-home>/bin:$PATH
export TMPDIR=<development-home>/tmp
E=<development-home>/BLAKE3-ode-read/tools/verify/machine/experiments/adler32
V=<development-home>/bench-hashes-validation/ode-adler-fast
B=$V/build-followup
python3 "$E/prepare_bench.py" <development-home>/bench-0194 <development-home>/bench-hashes-validation/ode-design-reading/adler-proof-committed <development-home>/adler-comparison-deps "$B" --skip-proof
cargo build --release --manifest-path "$B/Cargo.toml"
SDE=<development-home>/bench-hashes-validation/x86-kernels-20261022/sde-external-10.13.1-2026-07-28-lin/sde64
"$SDE" -future -- "$B/target/release/ode-adler-observer" --validate > "$V/followup-emulated-validation.txt" 2>&1
if (ulimit -c 0; "$SDE" -future -- "$B/target/release/ode-adler-observer" --overread-control) > "$V/followup-overread-control.txt" 2>&1; then
 echo 'planted overread survived' >&2; exit 1
else
 code=$?
 # SDE reports the target SIGSEGV as exit 139.
 test "$code" -eq 139
 echo 'planted overread: SIGSEGV as required' >> "$V/followup-overread-control.txt"
fi
cargo nextest run --release --manifest-path "$B/Cargo.toml" --no-default-features > "$V/followup-reader-tests.txt" 2>&1
python3 - "$E" "$B" <<'PY'
import importlib.util,sys,subprocess,shutil
from pathlib import Path
spec=importlib.util.spec_from_file_location('prepare',Path(sys.argv[1])/'prepare_bench.py'); p=importlib.util.module_from_spec(spec);spec.loader.exec_module(p)
b=Path(sys.argv[2]); original=b/'native/libdeflate/libdeflate.a'; exposed=original.with_name('libdeflate-wide.a')
p.verify_archive_sections(original,exposed)
control=b/'exposure-control'; control.mkdir()
obj=control/'adler32.c.o'; obj.write_bytes(subprocess.check_output(['ar','p',exposed,'adler32.c.o']))
text=control/'text.bin'; subprocess.run(['objcopy','--dump-section',f'.text={text}',obj],check=True)
t=bytearray(text.read_bytes()); t[0]^=1; text.write_bytes(t)
subprocess.run(['objcopy','--update-section',f'.text={text}',obj],check=True)
changed=control/'changed.a'; shutil.copyfile(exposed,changed); subprocess.run(['ar','r',changed,obj],check=True)
try: p.verify_archive_sections(original,changed)
except AssertionError: print('archive exposure verification rejects changed text')
else: raise AssertionError('changed text passed')
print('follow-up build, emulated validation, guard control, reader tests and exposure control pass')
PY

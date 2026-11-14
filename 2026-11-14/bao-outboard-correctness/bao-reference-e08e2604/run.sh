#!/bin/sh
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/bao-reference-e08e2604"
export O
if [ "${BOUNDED_BAO_VALIDATE:-}" != yes ]; then
  export BOUNDED_BAO_VALIDATE=yes
  status=0
  timeout --kill-after=15s 1800s sh "$O/run.sh" || status=$?
  printf 'BAO_VALIDATE_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=4 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
B="$HOME/work/bench-devon-bao-reference-e08e2604"
M="$HOME/work/lib-devon-outboard-ed4be078-v2"
C=e08e2604fb9a400238dc28cc97e6faa658e6f061
LIB=ed4be078701083c6df85e0642982dc57d22e5923
export B M C LIB BAO_REFERENCE_SOURCE="$C"
git clone --filter=blob:none --single-branch --branch probe/devon-bao-outboard https://github.com/devonjonte/bench-hashes "$B"
git -C "$B" checkout --detach "$C"
git clone --filter=blob:none --single-branch --branch candidate/b3sum-outboard https://github.com/servil-software-factory/BLAKE3 "$M"
git -C "$M" checkout --detach "$LIB"
test -z "$(git -C "$B" status --porcelain)"
test -z "$(git -C "$M" status --porcelain)"
{ rustc -Vv; cc --version; printf 'reference %s\nservil %s\n' "$C" "$LIB"; } > "$O/toolchain.txt"
cargo nextest run --release --locked --manifest-path "$B/tools/bao-reference/Cargo.toml" -j 4 > "$O/reference-tests.txt" 2>&1
cargo build --release --locked --manifest-path "$B/tools/bao-reference/Cargo.toml" > "$O/reference-build.txt" 2>&1
cargo nextest run --release --manifest-path "$M/b3sum/Cargo.toml" -j 4 --no-fail-fast > "$O/servil-tests.txt" 2>&1
cargo build --release --locked --manifest-path "$M/b3sum/Cargo.toml" > "$O/servil-build.txt" 2>&1
python3 - <<'PY'
import json,os,pathlib,shutil,subprocess
out=pathlib.Path(os.environ['O'])
for manifest,binary,kept in [(pathlib.Path(os.environ['B'])/'tools/bao-reference/Cargo.toml','bao-reference','bao-reference'),(pathlib.Path(os.environ['M'])/'b3sum/Cargo.toml','b3sum','servil-b3sum')]:
 m=json.loads(subprocess.check_output(['cargo','metadata','--locked','--no-deps','--format-version','1','--manifest-path',str(manifest)],text=True))
 shutil.copyfile(pathlib.Path(m['target_directory'])/'release'/binary,out/kept)
 (out/kept).chmod(0o755)
PY
cp "$B/tools/bao-reference/Cargo.lock" "$O/reference-Cargo.lock"
cp "$M/b3sum/Cargo.lock" "$O/servil-Cargo.lock"
"$O/bao-reference" --version > "$O/reference-version.txt"
"$O/servil-b3sum" --version > "$O/servil-version.txt"
python3 - <<'PY'
from pathlib import Path
import json,os,subprocess
root=Path(os.environ['O']);inputs=root/'inputs';inputs.mkdir()
lens=[(12<<20)+17,3,0,16383,16384,16385,32768,50000,(1<<20)+1]
paths=[]
for i,n in enumerate(lens):
 p=inputs/f'input-{i}';p.write_bytes(b'abc' if n==3 else (bytes(range(251))*(n//251+1))[:n]);paths.append(p)
results=[]
for threads in [1,3]:
 theirs=root/f'bao-{threads}';ours=root/f'servil-{threads}';theirs.mkdir();ours.mkdir()
 commands=[['bao-reference','--outboard',str(theirs)],['servil-b3sum','--num-threads',str(threads),'--outboard',str(ours)]]
 outputs=[]
 for name,*args in commands:
  result=subprocess.run([str(root/name),*args,*map(str,paths)],capture_output=True,text=True,timeout=120)
  (root/f'{name}-{threads}.stdout.txt').write_text(result.stdout);(root/f'{name}-{threads}.stderr.txt').write_text(result.stderr)
  assert result.returncode==0,(name,threads,result.returncode,result.stderr)
  outputs.append(result.stdout)
 assert outputs[0]==outputs[1],(threads,outputs)
 assert len(outputs[0].splitlines())==len(paths)
 for n,line in zip(lens,outputs[0].splitlines()):
  digest=line.split()[0]
  if n==3:assert digest=='6437b3ac38465133ffb63b75273a8db548c558465d79db03fd359c6cd5bd9d85'
  a=(theirs/(digest+'.obao4')).read_bytes();b=(ours/(digest+'.obao4')).read_bytes()
  assert a==b,(n,threads)
  assert len(a)==64*max(0,(n+16383)//16384-1),(n,len(a))
  results.append({'input_bytes':n,'servil_threads':threads,'reference_threads':1,'outboard_bytes':len(a),'equal':True})
(root/'equality.json').write_text(json.dumps(results,indent=2)+'\n')
# Generated inputs are reproducible from this script, not performance evidence.
import shutil
shutil.rmtree(inputs)
print('Complete CLI outputs agree for both thread settings; no timing collected')
PY
printf 'DONE: two programs built and output-validated; binaries stay local to the validation inbox\n'

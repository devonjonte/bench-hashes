#!/bin/sh
set -eu
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH
export TMPDIR=/home/agent/tmp
export CARGO_BUILD_JOBS=2
cd /home/agent/bench-layout-repeat-assessment
test "$(git rev-parse HEAD)" = 06b4453824d22ae8ffd617159ee4f32750a34aff
cargo build --release --locked
python3 - <<'PY'
from pathlib import Path
import subprocess
exe='/home/agent/bench-layout-repeat-assessment/target/release/bench-hashes'
root=Path('/home/agent/bench-hashes-validation/inbox/x86-epyc-9275f/repeat-null-2c867684/kept-repeats')
old=sorted(root.glob('run-*-old.tsv')); new=sorted(root.glob('run-*-new.tsv'))
assert len(old)==len(new)==64
out=Path('/home/agent/bench-hashes-validation/autonomous-20261114')
for name,args in [('fresh-null-compare',['compare','--markdown',*map(str,old),'--',*map(str,new)]),('fresh-null-dependence',['layout-audit',str(root)])]:
 with (out/(name+'.txt')).open('w') as stdout,(out/(name+'.stderr.txt')).open('w') as stderr:
  subprocess.run([exe,*args],stdout=stdout,stderr=stderr,check=True,timeout=60)
print('fresh null: 64 pairs read by producer-matched comparison and dependence diagnostic')
PY

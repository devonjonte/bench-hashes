#!/bin/sh
set -eu
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH
export TMPDIR=/home/agent/tmp
export CARGO_BUILD_JOBS=2
cd /home/agent/bench-repeat-records
test "$(git rev-parse HEAD)" = aef48a1dcab7e582eeb0e5a42dd0c949d863f467
cargo build --release --locked
python3 - <<'PY'
from pathlib import Path
import json, subprocess
base=Path('/home/agent/bench-hashes-data')
roots=[base/'2026-11-13/release-022',base/'2026-11-13/methodology-audit']
records=[]; included=[]
for root in roots:
 for d in sorted(root.rglob('second')):
  if not d.is_dir(): continue
  old=len(list(d.glob('run-*-old.tsv'))); new=len(list(d.glob('run-*-new.tsv')))
  name=str(d.relative_to(base)); eligible=(old==new==64)
  records.append(dict(directory=name,old=old,new=new,included=eligible,reason='complete 16x4 stage' if eligible else 'outside complete-stage contract'))
  if eligible: included.append(name)
out=Path('/home/agent/bench-hashes-validation/autonomous-20261114/record-manifest.json')
out.write_text(json.dumps({'reader_base':'97c0fbcbedb8fe8f8395115647684dfde75d67a3','diagnostic':'aef48a1dcab7e582eeb0e5a42dd0c949d863f467','records':records},indent=2)+'\n')
print(f'# {len(included)} complete stages; {len(records)-len(included)} outside contract',flush=True)
assert included
subprocess.run(['/home/agent/bench-repeat-records/target/release/bench-hashes','layout-audit',*included],cwd=base,check=True,timeout=120)
PY

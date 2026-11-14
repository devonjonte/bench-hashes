#!/usr/bin/env python3
"""Archive the declared UI checks and failures; keep executables local."""
from pathlib import Path
import shutil,subprocess,sys

head=sys.argv[1]
root=Path('<development-home>');v=root/'bench-hashes-validation/provenance-visibility'
d=root/'bench-hashes-data/2026-11-14/provenance-disclosure';d.mkdir(exist_ok=False)
repo=root/'bench-provenance-door'
assert subprocess.check_output(['git','rev-parse','HEAD'],cwd=repo,text=True).strip()==head
assert not subprocess.check_output(['git','status','--porcelain'],cwd=repo,text=True).strip()

def copy(source,target):
    raw=source.read_bytes()
    if source.suffix not in {'.png','.html'}:
        raw=raw.replace(b'<development-home>',b'<development-home>').replace(b'<worker-home>',b'<worker-home>')
    target.parent.mkdir(parents=True,exist_ok=True);target.write_bytes(raw)

for p in v.rglob('*'):
    if p.is_file() and p.suffix in {'.txt','.json','.png','.html','.js','.cjs','.sh','.py','.md','.css','.patch','.rs'}:
        copy(p,d/'validation'/p.relative_to(v))
for name in ['provenance-door-adf9fc85','provenance-door-9e831b8f','provenance-door-9418b5b5','provenance-door-adc20bdd']:
    source=root/'bench-hashes-validation/inbox/x86-workhorse'/name
    assert 'PROVENANCE_EXIT=' in (source/'stdout.txt').read_text(), name
    for p in source.iterdir():
        if p.is_file() and p.name!='renderer':copy(p,d/'builds'/name/p.name)
for name in ['src/map.rs','src/map.html','src/overview.rs','src/overview.html','tools/graph-check/overview.js','tools/graph-check/map.js','tools/graph-check/README.md']:
    copy(repo/name,d/'source'/name)
copy(repo/'index.html',d/'index.html')
copy(root/'bench-hashes-validation/autonomous-20261114/zoom-layout/historical-targets.js',d/'validation/historical-targets.js')
(d/'SOURCE.txt').write_text(head+'\n')
(d/'change.diff').write_bytes(subprocess.check_output(['git','diff','da6fe3c478e3e25c23ab05514a1723e1e20f5e2f',head],cwd=repo))
print('Archived source, rendered page, checks and failed attempts. Add README and paired manifests before publication.')

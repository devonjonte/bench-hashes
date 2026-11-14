#!/usr/bin/env python3
"""Preserve the bounded assessment; original input records stay at their pinned data commit."""
from pathlib import Path
import hashlib, json, shutil, subprocess
h=Path('/home/agent'); work=h/'bench-hashes-validation/autonomous-20261114'
data=h/'bench-hashes-data'; out=data/'2026-11-14/repeated-layout-assessment'
out.mkdir(parents=True,exist_ok=True)
for folder in ['code','analysis','fresh-null','fresh-finalize']:(out/folder).mkdir(exist_ok=True)
for name in ['assessment-plan.md','fresh-repeat-plan.md','run-repeat-control.sh','run-record-assessment.sh','read-fresh-null.sh','repeat-null.sh','repeat-finalize.sh']:
 shutil.copyfile(work/name,out/'code'/name)
for name in ['layout-repeat-control.stdout.txt','layout-repeat-control.stderr.txt','repeated-records.stdout.txt','repeated-records.stderr.txt','record-manifest.json','fresh-null-compare.txt','fresh-null-dependence.txt','fresh-finalize-compare.txt','fresh-finalize-dependence.txt']:
 shutil.copyfile(work/name,out/'analysis'/name)
for repo,base,rev,name in [
 ('bench-repeat-records','97c0fbcbedb8fe8f8395115647684dfde75d67a3','aef48a1dcab7e582eeb0e5a42dd0c949d863f467','release-reader.patch'),
 ('bench-layout-repeat-assessment','2c8676842feab053fa7855d4cb3393bdea26ed4a','06b4453824d22ae8ffd617159ee4f32750a34aff','fresh-reader-and-fixture.patch')]:
 (out/'code'/name).write_bytes(subprocess.check_output(['git','-C',str(h/repo),'diff',base,rev]))
for run,dest in [('repeat-null-2c867684','fresh-null'),('repeat-finalize-2c867684','fresh-finalize')]:
 source=h/'bench-hashes-validation/inbox/x86-epyc-9275f'/run
 for p in source.rglob('*'):
  if p.is_file() and p.suffix in ['.tsv','.txt','.json','.sh']:
   target=out/dest/p.relative_to(source);target.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(p,target)
# Bind the older, already-published accepted files without duplicating them.
source_commit='8337532ced037238b749bebcf5d8bb20632c6e3c'
subprocess.run(['git','-C',str(data),'diff','--exit-code',source_commit,'HEAD','--','2026-11-13/release-022','2026-11-13/methodology-audit'],check=True,stdout=subprocess.DEVNULL)
files=[]
for record in json.loads((work/'record-manifest.json').read_text())['records']:
 if record['included']:
  root=data/record['directory'];files+=sorted(root.glob('run-*-old.tsv'))+sorted(root.glob('run-*-new.tsv'))
files=sorted(files)
(out/'INPUT-DATA-COMMIT.txt').write_text(source_commit+'\n')
(out/'INPUT-SHA256SUMS').write_text(''.join(hashlib.sha256(p.read_bytes()).hexdigest()+'  '+str(p.relative_to(data))+'\n' for p in files))
with (out/'INPUT-BLAKE3SUMS').open('wb') as f:
 subprocess.run(['b3sum',*[str(p.relative_to(data)) for p in files]],cwd=data,stdout=f,check=True)
subprocess.run(['sha256sum','--check','--quiet',str(out/'INPUT-SHA256SUMS')],cwd=data,check=True)
subprocess.run(['b3sum','--check','--quiet',str(out/'INPUT-BLAKE3SUMS')],cwd=data,check=True,stdout=subprocess.DEVNULL)
print(f'preserved two fresh bundles and bound {len(files)} historical accepted inputs; both digests verified')

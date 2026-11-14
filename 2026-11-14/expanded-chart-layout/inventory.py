#!/usr/bin/env python3
from pathlib import Path
import subprocess,re,hashlib,json,difflib
root=Path('<development-home>/bench-zoom-layout');out=Path('<development-home>/bench-hashes-validation/autonomous-20261114/zoom-layout')
base=(root/'src/map.html').read_bytes()
def hashes(data):
 return dict(sha256=hashlib.sha256(data).hexdigest(),blake3=subprocess.check_output(['b3sum'],input=data).split()[0].decode())
groups={};records=[]
for name in subprocess.check_output(['git','ls-files','*.map.html'],cwd=root,text=True).splitlines():
 if not name.startswith(('benchmark-results/','beside/')):continue
 data=(root/name).read_bytes();matches=list(re.finditer(rb'^const SECTIONS = (.*);$',data,re.M));assert len(matches)==1,name
 m=matches[0];payload=m.group(1);template=data[:m.start(1)]+b'@SECTIONS@'+data[m.end(1):]
 digest=hashlib.sha256(template).hexdigest()
 if digest not in groups:
  group=len(groups)+1;groups[digest]=dict(number=group,template=hashes(template),files=[])
  (out/f'template-{group}.html').write_bytes(template)
  (out/f'template-{group}.diff').write_text(''.join(difflib.unified_diff(base.decode().splitlines(True),template.decode().splitlines(True),fromfile='src/map.html',tofile=f'template-{group}')))
 g=groups[digest];g['files'].append(name)
 records.append(dict(path=name,group=g['number'],payload=hashes(payload)))
(out/'template-inventory.json').write_text(json.dumps(dict(base=subprocess.check_output(['git','rev-parse','HEAD'],cwd=root,text=True).strip(),groups=list(groups.values()),maps=records),indent=2)+'\n')
for group in groups.values():print('template',group['number'],len(group['files']),'maps',group['files'][0])

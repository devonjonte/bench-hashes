#!/usr/bin/env python3
"""Apply the source layout diff to source-compatible copies; data stays opaque."""
from pathlib import Path
import subprocess,json,re,sys
root=Path('<development-home>/bench-zoom-layout');base=Path('<development-home>/bench-hashes-validation/autonomous-20261114/zoom-layout')
out=base/sys.argv[1];out.mkdir(exist_ok=False)
patch=subprocess.check_output(['git','diff','--unified=1','--','src/map.html'],cwd=root)
(out/'source.patch').write_bytes(patch)
inventory=json.loads((base/'template-inventory.json').read_text())
records=[]
for record in inventory['maps']:
 if record['group']>4:continue
 name=record['path'];src=root/name;target=out/name;target.parent.mkdir(parents=True,exist_ok=True)
 before=src.read_bytes();target.write_bytes(before)
 result=subprocess.run(['patch','--batch','--fuzz=0','--no-backup-if-mismatch',str(target),str(out/'source.patch')],text=True,capture_output=True,timeout=20)
 (target.parent/'patch.txt').write_text(result.stdout+result.stderr)
 assert result.returncode==0,(name,result.stdout,result.stderr)
 after=target.read_bytes()
 payload=lambda text:re.search(rb'^const SECTIONS = (.*);$',text,re.M).group(1)
 assert payload(before)==payload(after),name
 records.append(dict(path=name,group=record['group'],payload_unchanged=True))
assert len(records)==15
(out/'receipt.json').write_text(json.dumps(records,indent=2)+'\n')
print('15 source-compatible previews patched without fuzz; every data payload stays byte-identical')

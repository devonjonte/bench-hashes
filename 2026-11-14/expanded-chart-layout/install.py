#!/usr/bin/env python3
"""Install the checked, exact source patches; keep every measurement payload intact."""
from pathlib import Path
import subprocess,json,hashlib,re
root=Path('<development-home>/bench-zoom-layout');out=Path('<development-home>/bench-hashes-validation/autonomous-20261114/zoom-layout');preview=out/'trial-4'
assert subprocess.check_output(['git','diff','--unified=1','--','src/map.html'],cwd=root)==(preview/'source.patch').read_bytes()
subprocess.run(['git','diff','--exit-code','--','benchmark-results','beside'],cwd=root,check=True)
checks=json.loads((out/'final-full/results.json').read_text());assert len(checks)==15 and all(c['exit']==0 for c in checks)
records=json.loads((preview/'receipt.json').read_text());assert len(records)==15
assert len({str(Path(r['path']).parent) for r in records})==15

def hashes(data):
 return dict(sha256=hashlib.sha256(data).hexdigest(),blake3=subprocess.check_output(['b3sum'],input=data).split()[0].decode())
def verify(folder):
 subprocess.run(['sha256sum','--check','--quiet','SHA256SUMS'],cwd=folder,check=True)
 subprocess.run(['b3sum','--check','--quiet','BLAKE3SUMS'],cwd=folder,check=True,stdout=subprocess.DEVNULL)

updates={};receipt=[]
for record in records:
 relative=Path(record['path']);target=root/relative;verify(target.parent)
 before=target.read_bytes();after=(preview/relative).read_bytes()
 payload=lambda data:re.search(rb'^const SECTIONS = (.*);$',data,re.M).group(1)
 assert payload(before)==payload(after),relative
 reverse=out/'reverse-check.html';reverse.write_bytes(after)
 run=subprocess.run(['patch','--batch','--reverse','--fuzz=0','--no-backup-if-mismatch',str(reverse),str(preview/'source.patch')],capture_output=True,text=True,timeout=20)
 assert run.returncode==0,(relative,run.stdout,run.stderr)
 assert reverse.read_bytes()==before,relative
 reverse.unlink()
 old,new=hashes(before),hashes(after)
 receipt.append(dict(path=str(relative),before=old,after=new,payload=hashes(payload(before)),reverse_patch_exact=True))
 updates[target]=after
 for name,algorithm in [('SHA256SUMS','sha256'),('BLAKE3SUMS','blake3')]:
  manifest=target.parent/name;lines=manifest.read_bytes().splitlines(keepends=True)
  at=[i for i,line in enumerate(lines) if line[64:].strip()==target.name.encode()];assert len(at)==1
  i=at[0];assert lines[i][:64].decode()==old[algorithm]
  lines[i]=new[algorithm].encode()+lines[i][64:];updates[manifest]=b''.join(lines)
for p,contents in updates.items():p.write_bytes(contents)
for record in records:verify((root/record['path']).parent)
(out/'installed-receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
print('15 maps installed; payloads exact, source patches reverse exactly, paired manifests verify')

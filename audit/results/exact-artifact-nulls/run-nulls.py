import hashlib,json,os,shutil,subprocess
from pathlib import Path
root=Path('/home/agent'); base=root/'bench-hashes-validation/trust-audit/nulls';base.mkdir(exist_ok=True)
source=Path((root/'bench-hashes-validation/trust-audit/null-build.stdout.txt').read_text().strip());exe=base/'bench-hashes';shutil.copy2(source,exe)
sha=hashlib.sha256(exe.read_bytes()).hexdigest()
points='64 B,4 KiB,idle 64 B,idle 4 KiB,continuous 1 KiB,continuous batch 16,continuous batch 4096,lent 1 MiB,lent pieces 64 MiB'
blocks=[('default-1',None),('default-2',None),('ponly','0-15'),('p0','0')]
manifest={'sha256':sha,'binary':str(exe),'benchmark_commit':'547e82e','hashing_commit':'8825450','clocks_commit':'08d9dc3 (clocks unchanged from 8825450)','points':points,'rounds':24,'contenders':'sha256,blake3-servil-st,blake3-servil-mt','run_deadline_seconds':120,'blocks':blocks,'runs':[]}
(base/'manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
for block,affinity in blocks:
 for name in ['old-1','new-1','new-2','old-2']:
  d=base/block/name;d.mkdir(parents=True,exist_ok=True)
  assert hashlib.sha256(exe.read_bytes()).hexdigest()==sha
  cmd=([ 'taskset','-c',affinity] if affinity else [])+[str(exe),'--contenders',manifest['contenders'],'--points',points,'--rounds','24','--trace-clocks','clocks.csv']
  status=subprocess.run(['python3',str(root/'bench-hashes-validation/run-bounded.py'),'120',str(d/'run'),*cmd],cwd=d).returncode
  record={'block':block,'run':name,'exit':status,'sha256':sha};manifest['runs'].append(record);(base/'manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
  if status:continue
  folder=next(d.glob('benchmark-results/*'))
  for label,command in [('accounting',['python3',str(root/'bench-hashes-trust/tools/check-trace-accounting.py'),str(folder/'bench-hashes.samples.tsv'),str(d/'clocks.csv'),'--reader',str(root/'BLAKE3-trust/tools/samples.py'),'--explicit-rounds']),('report',['python3',str(root/'bench-hashes-trust/tools/check-report.py'),str(folder),'--rules',str(root/'BLAKE3-trust/tools/speeds.py')])]:
   with (d/(label+'.stdout.txt')).open('w') as out,(d/(label+'.stderr.txt')).open('w') as err:subprocess.run(command,stdout=out,stderr=err,check=True,env={**os.environ,'PYTHONDONTWRITEBYTECODE':'1'})
 for records in [manifest['runs'][-4:]]:
  if any(r['exit'] for r in records):continue
  files=[str(next((base/block/n).glob('benchmark-results/*/*.samples.tsv'))) for n in ['old-1','new-1','new-2','old-2']]
  with (base/block/'comparison.txt').open('w') as out:subprocess.run(['python3',str(root/'bench-hashes-trust/tools/compare-runs.py'),*files,'--rules',str(root/'BLAKE3-trust/tools/speeds.py')],stdout=out,check=True,env={**os.environ,'PYTHONDONTWRITEBYTECODE':'1'})
print('All predeclared runs retained; manifest:',base/'manifest.json')

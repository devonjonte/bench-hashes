#!/usr/bin/env pypy3
"""Same-artifact calibration-mode controls, unchanged Rust regression rule."""
import json,hashlib,os,signal,subprocess,sys,datetime
from pathlib import Path
root=Path(__file__).resolve().parent/'mixed';root.mkdir(exist_ok=True)
exe=Path(__file__).resolve().parent/'frozen/mixed-probe'
assert os.getpgrp()==os.getpid()
checks=[('effect-default',None,0,1),('null-primed-default',None,1,1),('effect-separate-p','0,2,4,6',0,1)]
manifest={'plan':'audit/cause-mixed-confirmation-plan.md','artifact_sha256':hashlib.sha256(exe.read_bytes()).hexdigest(),'state':'running','checks':[]}
def save():(root/'manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
save()
end=datetime.datetime(2026,10,2,18,35,tzinfo=datetime.timezone.utc)
for name,cpus,a,b in checks:
 remaining=int((end-datetime.datetime.now(datetime.timezone.utc)).total_seconds())
 if remaining<180:manifest['state']='budget-ended';save();sys.exit(0)
 folder=root/name;folder.mkdir()
 for side,mode in [('old',a),('new',b)]:
  code='#!%s\nimport os,subprocess,sys\nfrom pathlib import Path\nPath("priming-mode.txt").write_text(%r)\nenv={**os.environ,"CAUSE_PRIME_CALIBRATION":%r}\nsys.exit(subprocess.call([%r]+sys.argv[1:],env=env))\n'%(sys.executable,str(mode)+'\n',str(mode),str(exe))
  (folder/side).write_text(code);(folder/side).chmod(0o755)
 command=(['taskset','-c',cpus] if cpus else [])+[str(exe),'regress',str(folder/'old'),str(folder/'new')]
 row={'name':name,'cpus':cpus,'old_mode':a,'new_mode':b,'command':command};manifest['checks'].append(row);save()
 with (folder/'stdout.txt').open('wb') as out,(folder/'stderr.txt').open('wb') as err:
  child=subprocess.Popen(command,cwd=folder,stdout=out,stderr=err)
  print(name,'pid',child.pid,flush=True)
  try:row['exit']=child.wait(timeout=min(1200,remaining-130))
  except subprocess.TimeoutExpired:row['exit']=124;manifest['state']='timeout';save();os.killpg(os.getpgrp(),signal.SIGTERM);sys.exit(124)
 row['finished']=datetime.datetime.now(datetime.timezone.utc).isoformat();save()
 if row['exit'] not in [0,1,2]:manifest['state']='execution-failed';save();sys.exit(1)
manifest['state']='completed';manifest['artifacts_unchanged']=manifest['artifact_sha256']==hashlib.sha256(exe.read_bytes()).hexdigest();save()

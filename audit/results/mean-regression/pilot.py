#!/usr/bin/env pypy3
"""Bounded process orchestration; Rust owns all statistical decisions."""
import argparse,hashlib,json,os,signal,subprocess,sys
from pathlib import Path
root=Path(__file__).resolve().parent

def wrapper(extra,batches,args):
    r=subprocess.run([str(root/'frozen/work-control'),str(extra),str(batches),'0'],stdout=subprocess.PIPE,stderr=subprocess.PIPE)
    Path('probe.stdout.txt').write_bytes(r.stdout);Path('probe.stderr.txt').write_bytes(r.stderr)
    folder=Path('benchmark-results/control');folder.mkdir(parents=True)
    if r.returncode==0:(folder/'bench-hashes.samples.tsv').write_bytes(r.stdout)
    return r.returncode
if len(sys.argv)>1 and sys.argv[1]=='wrapper':sys.exit(wrapper(int(sys.argv[2]),int(sys.argv[3]),sys.argv[4:]))
assert os.getpgrp()==os.getpid(),'use whole-group supervisor'
checks=[('null-2',None,128,0),('work-null',0,128,0),('work-six',6,128,0),('work-twelve',12,128,0),('work-double',100,128,0),('short',0,8,0),('busy',0,128,2)]
manifest={'plan':'audit/mean-regression-plan.md','state':'running','artifacts':{name:hashlib.sha256((root/'frozen'/name).read_bytes()).hexdigest() for name in ['bench','work-control']},'checks':[]}
def save():(root/'pilot.json').write_text(json.dumps(manifest,indent=2)+'\n')
save()
for name,extra,batches,busy in checks:
 folder=root/name;folder.mkdir()
 exe=str(root/'frozen/bench')
 if extra is None:old=new=exe
 else:
  for side,value in [('old',0),('new',extra)]:
   code='#!%s\nimport subprocess,sys\nsys.exit(subprocess.call(%r+sys.argv[1:]))\n'%(sys.executable,[sys.executable,str(Path(__file__).resolve()),'wrapper',str(value),str(batches)])
   (folder/side).write_text(code);(folder/side).chmod(0o755)
  old,new=str(folder/'old'),str(folder/'new')
 workers=[];row={'name':name,'extra_per100':extra,'batches':batches,'busy_workers':busy};manifest['checks'].append(row);save()
 try:
  for i in range(busy):workers.append(subprocess.Popen([sys.executable,'-c','x=1\nwhile True: x=(1664525*x+1013904223)&0xffffffff']))
  with (folder/'stdout.txt').open('wb') as out,(folder/'stderr.txt').open('wb') as err:
   child=subprocess.Popen([exe,'regress',old,new],cwd=folder,stdout=out,stderr=err)
   print(name,'pid',child.pid,flush=True)
   try:row['exit']=child.wait(timeout=1200)
   except subprocess.TimeoutExpired:
    row['exit']=124;manifest['state']='timeout';save();os.killpg(os.getpgrp(),signal.SIGTERM);sys.exit(124)
 finally:
  for worker in workers:
   worker.terminate()
   try:worker.wait(timeout=5)
   except subprocess.TimeoutExpired:worker.kill();worker.wait()
 save()
 if row['exit'] not in [0,1,2]:manifest['state']='execution-failed';save();sys.exit(1)
manifest['state']='completed';manifest['artifacts_unchanged']=manifest['artifacts']=={name:hashlib.sha256((root/'frozen'/name).read_bytes()).hexdigest() for name in manifest['artifacts']};save()

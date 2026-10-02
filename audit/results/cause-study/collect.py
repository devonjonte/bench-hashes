#!/usr/bin/env pypy3
"""Fixed process/affinity schedule; Rust owns inputs, timing and statistics."""
import hashlib,json,os,signal,subprocess,sys,datetime,time
from pathlib import Path
root=Path(__file__).resolve().parent
assert os.getpgrp()==os.getpid(),'run under whole-group supervisor'
exe=root/'frozen/probe'
rows=[]
contexts=[('separate-p','0,2,4,6'),('smt','0,1,2,3'),('e','16-19'),('default',None)]
for repeat in range(1,9):
 for label,cpus in contexts:
  for case in ['queue64','mt1m','st1m','sha1m'] if cpus else ['queue64','mt1m']:
   rows.append({'folder':f'{label}-{case}-{repeat:02d}','context':label,'cpus':cpus,'case':case,'repeat':repeat,'metadata':True})
  if repeat<=4 and label in ['default','separate-p']:
   for case in ['queue64','mt1m']:
    rows.append({'folder':f'{label}-{case}-plain-{repeat:02d}','context':label,'cpus':cpus,'case':case,'repeat':repeat,'metadata':False})
assert len(rows)==128
manifest={'plan':'audit/cause-placement-plan.md','started':datetime.datetime.now(datetime.timezone.utc).isoformat(),'state':'running','artifact_sha256':hashlib.sha256(exe.read_bytes()).hexdigest(),'runs':rows}
def save():(root/'manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
save()
stop=datetime.datetime(2026,10,2,18,35,tzinfo=datetime.timezone.utc)
for row in rows:
 if (stop-datetime.datetime.now(datetime.timezone.utc)).total_seconds()<130:manifest['state']='time-budget-ended';save();sys.exit(0)
 folder=root/'runs'/row['folder'];folder.mkdir(parents=True)
 command=(['taskset','-c',row['cpus']] if row['cpus'] else [])+[str(exe),'cause-probe',row['case'],'2048','metadata' if row['metadata'] else 'plain']
 row['command']=command;row['started']=datetime.datetime.now(datetime.timezone.utc).isoformat();save()
 with (folder/'stdout.txt').open('wb') as out,(folder/'stderr.txt').open('wb') as err:
  child=subprocess.Popen(command,cwd=folder,stdout=out,stderr=err)
  print(row['folder'],'pid',child.pid,flush=True)
  try:row['exit']=child.wait(timeout=120)
  except subprocess.TimeoutExpired:
   row['exit']=124;manifest['state']='timeout';save();os.killpg(os.getpgrp(),signal.SIGTERM);sys.exit(124)
 row['finished']=datetime.datetime.now(datetime.timezone.utc).isoformat();save()
 if row['exit']:manifest['state']='execution-failed';save();sys.exit(1)
manifest['state']='completed';manifest['artifacts_unchanged']=manifest['artifact_sha256']==hashlib.sha256(exe.read_bytes()).hexdigest();save()

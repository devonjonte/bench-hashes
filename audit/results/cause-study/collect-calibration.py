#!/usr/bin/env pypy3
"""Fixed cold/warm calibration intervention; timing and statistics stay Rust."""
import hashlib,json,os,signal,subprocess,sys,datetime
from pathlib import Path
root=Path(__file__).resolve().parent/'calibration';root.mkdir(exist_ok=True)
assert os.getpgrp()==os.getpid()
exe=Path(__file__).resolve().parent/'frozen/probe-v2'
rows=[]
for block in range(1,9):
 for context,cpus in [('default',None),('separate-p','0,2,4,6')]:
  for position,mode in enumerate(['cold','warm','warm','cold'],1):
   rows.append({'folder':f'{context}-{block:02d}-{position}-{mode}','context':context,'cpus':cpus,'block':block,'position':position,'mode':mode})
manifest={'plan':'audit/cause-calibration-plan.md','state':'running','artifact_sha256':hashlib.sha256(exe.read_bytes()).hexdigest(),'runs':rows}
def save():(root/'manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
save()
end=datetime.datetime(2026,10,2,18,35,tzinfo=datetime.timezone.utc)
for row in rows:
 if (end-datetime.datetime.now(datetime.timezone.utc)).total_seconds()<130:manifest['state']='budget-ended';save();sys.exit(0)
 folder=root/'runs'/row['folder'];folder.mkdir(parents=True)
 command=(['taskset','-c',row['cpus']] if row['cpus'] else [])+[str(exe),'cause-probe','queue64','16384','metadata',row['mode']]
 row['command']=command;row['started']=datetime.datetime.now(datetime.timezone.utc).isoformat();save()
 with (folder/'stdout.txt').open('wb') as out,(folder/'stderr.txt').open('wb') as err:
  child=subprocess.Popen(command,cwd=folder,stdout=out,stderr=err)
  print(row['folder'],'pid',child.pid,flush=True)
  try:row['exit']=child.wait(timeout=120)
  except subprocess.TimeoutExpired:row['exit']=124;manifest['state']='timeout';save();os.killpg(os.getpgrp(),signal.SIGTERM);sys.exit(124)
 row['finished']=datetime.datetime.now(datetime.timezone.utc).isoformat();save()
 if row['exit']:manifest['state']='execution-failed';save();sys.exit(1)
manifest['state']='completed';manifest['artifacts_unchanged']=manifest['artifact_sha256']==hashlib.sha256(exe.read_bytes()).hexdigest();save()

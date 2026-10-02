#!/usr/bin/env pypy3
"""Bounded unattended null controls and independently anchored queue stress.
Python only supervises and retains records; Rust alone computes speed decisions.
All children inherit this campaign's process group, including regression wrappers.
"""
import argparse
import datetime
import hashlib
import itertools
import json
import os
from pathlib import Path
import re
import shutil
import signal
import subprocess
import sys
import time

LOCAL = Path(__file__).resolve().parent

def sha(path): return hashlib.sha256(Path(path).read_bytes()).hexdigest()
def utc(): return datetime.datetime.now(datetime.timezone.utc).isoformat()

def wrapper(config, side, arguments):
    c=json.loads(Path(config).read_text()); root=Path(c['folder'])
    index=len(list(root.glob('run-*')))+1
    folder=root/('run-%02d-%s'%(index,side));folder.mkdir()
    request={'side':side,'arguments':arguments,'temporary_cwd':os.getcwd(),'source':'1e50159','binary':c[side]}
    (folder/'request.json').write_text(json.dumps(request,indent=2)+'\n')
    with (folder/'stdout.txt').open('wb') as out,(folder/'stderr.txt').open('wb') as err:
        status=subprocess.run([c[side]]+arguments,stdout=out,stderr=err).returncode
    request['exit']=status;(folder/'request.json').write_text(json.dumps(request,indent=2)+'\n')
    if Path('benchmark-results').exists():shutil.copytree('benchmark-results',folder/'benchmark-results')
    return status

if len(sys.argv)>1 and sys.argv[1]=='wrapper':
    sys.exit(wrapper(sys.argv[2],sys.argv[3],sys.argv[4:]))

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('--publication',type=Path,required=True)
p.add_argument('--until',default='2026-10-02T12:30:00+00:00')
p.add_argument('--smoke',action='store_true')
a=p.parse_args()
assert os.getpgrp()==os.getpid(), 'run the campaign under the bounded supervisor in its own process group'
repo=a.publication.resolve();root=repo/'audit/results/afk-validation';root.mkdir(parents=True,exist_ok=False)
artifacts={n:LOCAL/'frozen'/n for n in ['stress','stress-asan','bench-a','bench-b']}
end=datetime.datetime.fromisoformat(a.until)
remaining=(end-datetime.datetime.now(datetime.timezone.utc)).total_seconds()
assert remaining>0
stop=time.monotonic()+(600 if a.smoke else remaining)
manifest={'plan':'audit/afk-validation-plan.md','started':utc(),'until':a.until,'smoke':a.smoke,'hashing_source':'1e50159','hashing_runtime':'a02bc35','benchmark_runtime':'6047dcd','clocks_runtime':'2a2cb9c','controller_pid':os.getpid(),'controller_pgid':os.getpgrp(),'artifacts':{n:sha(path) for n,path in artifacts.items()},'state':'running','signal':None,'nulls':[],'stress':[],'publications':[]}
active=None
cancelled=False

def save():
    tmp=root/'manifest.json.tmp';tmp.write_text(json.dumps(manifest,indent=2)+'\n');tmp.replace(root/'manifest.json')
    (LOCAL/'status.json').write_text(json.dumps({'state':manifest['state'],'updated':utc(),'controller_pid':os.getpid(),'pgid':os.getpgrp(),'publication':str(repo),'null_attempts':len(manifest['nulls']),'stress_attempts':len(manifest['stress'])},indent=2)+'\n')

def interrupted(number,_frame):
    global cancelled
    if cancelled:return
    cancelled=True
    manifest['state']='interrupted';manifest['signal']=number
    # The controller handles TERM; every owned descendant inherits this
    # group and terminates. The guard prevents recursive self-signalling.
    os.killpg(os.getpgrp(),signal.SIGTERM)
for n in [signal.SIGTERM,signal.SIGINT]:signal.signal(n,interrupted)

def bounded(folder,command,seconds=180):
    global active,cancelled
    folder.mkdir(parents=True,exist_ok=False)
    with (folder/'stdout.txt').open('wb') as out,(folder/'stderr.txt').open('wb') as err:
        active=subprocess.Popen(command,cwd=folder,stdout=out,stderr=err,start_new_session=False,env={**os.environ,'ASAN_OPTIONS':'detect_leaks=0'})
        (folder/'process.json').write_text(json.dumps({'pid':active.pid,'pgid':os.getpgid(active.pid),'command':command,'deadline_seconds':seconds,'started':utc()},indent=2)+'\n')
        try: status=active.wait(timeout=seconds)
        except subprocess.TimeoutExpired:
            # Fail-stop the entire inherited group: Rust regress may have
            # wrappers/children, so killing only its leader is insufficient.
            manifest['state']='failed';manifest['failure']='attempt timeout';save()
            os.killpg(os.getpgrp(),signal.SIGTERM)
            try:active.wait(timeout=5)
            except subprocess.TimeoutExpired:active.kill();active.wait()
            status=124
        active=None
    return status

def publish(final=False):
    save()
    if a.smoke:return
    note='Finish autonomous Linux validation' if final else 'Retain autonomous Linux validation progress'
    commands=[['git','add','--','audit/results/afk-validation'],['git','commit','--quiet','-m',note],['git','push','--quiet','fork','candidate/devon-linux-afk-validation']]
    receipt={'at':utc(),'final':final,'steps':[]}
    for command in commands:
        try:
            r=subprocess.run(command,cwd=repo,stdout=subprocess.PIPE,stderr=subprocess.PIPE,text=True,timeout=60)
            receipt['steps'].append({'exit':r.returncode,'stdout':r.stdout[-1000:],'stderr':r.stderr[-1000:]})
            if r.returncode:break
        except subprocess.TimeoutExpired:
            receipt['steps'].append({'timeout':True});break
    manifest['publications'].append(receipt);save()

def null(number):
    kind='artifact' if number%2 else 'rebuild'
    folder=root/('null-%02d-%s'%(number,kind))
    folder.mkdir()
    old=artifacts['bench-a'];new=old if kind=='artifact' else artifacts['bench-b']
    config=folder/'config.json';config.write_text(json.dumps({'folder':str(folder),'old':str(old),'new':str(new)},indent=2)+'\n')
    for side in ['old','new']:
        code='#!%s\nimport subprocess,sys\nsys.exit(subprocess.call(%r+sys.argv[1:]))\n'%(sys.executable,[sys.executable,str(Path(__file__).resolve()),'wrapper',str(config),side])
        (folder/side).write_text(code);(folder/side).chmod(0o755)
    row={'number':number,'kind':kind,'folder':folder.name,'old_sha256':sha(old),'new_sha256':sha(new),'started':utc()};manifest['nulls'].append(row);save()
    row['exit']=bounded(folder/'gate',[str(old),'regress',str(folder/'old'),str(folder/'new')])
    text=(folder/'gate/stdout.txt').read_text()
    # Printed decisions, never a Python samples/statistics implementation.
    row['subject_decisions']=[line for line in text.splitlines() if re.match(r'^\s*(?:faster\s+)?blake3-servil-',line)]
    row['finished']=utc();save()
    if row['exit'] not in [0,1,2]:raise RuntimeError('abnormal null execution: %s'%folder.name)

matrix=list(itertools.product([None,'0','0,2','0,1','16-19','0-15'],[1,2,8,24],[8,32,128]))

def stress(number):
    cpus,threads,blocks=matrix[(number-1)%len(matrix)]
    sanitizer=number%12==0
    if a.smoke:threads,blocks=2,2
    binary=artifacts['stress-asan' if sanitizer else 'stress']
    folder=root/('stress-%05d'%number)
    command=(['taskset','-c',cpus] if cpus else [])+[str(binary),str(threads),str(blocks)]
    row={'number':number,'cpus':cpus,'threads':threads,'blocks':blocks,'asan':sanitizer,'folder':folder.name,'started':utc()};manifest['stress'].append(row);save()
    row['exit']=bounded(folder,command)
    text=(folder/'stdout.txt').read_text();m=re.search(r'validated (\d+) digests',text)
    row['validated_digests']=int(m[1]) if m else None;row['finished']=utc();save()
    if row['exit'] or m is None:raise RuntimeError('stress failed: %s'%folder.name)

save()
try:
    stress_index=0
    for number in range(1,2 if a.smoke else 67):
        if cancelled or stop-time.monotonic()<240:break
        null(number)
        for _ in range(1 if a.smoke else 4):
            if cancelled or stop-time.monotonic()<240:break
            stress_index+=1;stress(stress_index)
        if number%6==0:publish()
    while not a.smoke and not cancelled and stop-time.monotonic()>=240:
        stress_index+=1;stress(stress_index)
        if stress_index%72==0:publish()
    if not cancelled:manifest['state']='completed' if len(manifest['nulls'])==(1 if a.smoke else 66) else 'budget-ended-with-incomplete-nulls'
except BaseException as error:
    manifest['state']='interrupted' if cancelled and manifest.get('failure')!='attempt timeout' else 'failed'
    manifest['failure']=manifest.get('failure',repr(error))
finally:
    if active is not None and active.poll() is None:
        active.terminate()
        try:active.wait(timeout=5)
        except subprocess.TimeoutExpired:active.kill();active.wait()
    manifest['finished']=utc()
    manifest['null_valid_verdicts']=sum(r.get('exit') in [0,1] for r in manifest['nulls'])
    manifest['null_false_decisions']=sum(len(r.get('subject_decisions',[])) for r in manifest['nulls'])
    manifest['validated_digests']=sum(r.get('validated_digests') or 0 for r in manifest['stress'])
    manifest['artifacts_unchanged']=manifest['artifacts']=={n:sha(path) for n,path in artifacts.items()}
    manifest['null_count_requirement_passed']=len(manifest['nulls'])==66 and manifest['null_valid_verdicts']>=60 and manifest['null_false_decisions']==0
    manifest['original_acceptance_passed']=False
    save();publish(final=True)
    print(json.dumps({k:manifest[k] for k in ['state','finished','null_valid_verdicts','null_false_decisions','validated_digests','artifacts_unchanged','null_count_requirement_passed','original_acceptance_passed']},indent=2),flush=True)
    sys.exit(0 if manifest['state'] in ['completed','budget-ended-with-incomplete-nulls'] else 1)

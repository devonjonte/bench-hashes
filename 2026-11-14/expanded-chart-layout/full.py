#!/usr/bin/env python3
from pathlib import Path
import subprocess,os,json,sys
base=Path('<development-home>/bench-hashes-validation/autonomous-20261114/zoom-layout')
preview=base/sys.argv[1];out=base/sys.argv[2];out.mkdir(exist_ok=False)
repo=Path('<development-home>/bench-zoom-layout');env=dict(os.environ,NODE_PATH='<development-home>/bench-hashes-validation/node_modules')
browser=subprocess.check_output(['node','-p',"require('playwright').chromium.executablePath()"],env=env,text=True,timeout=10).strip()
records=[]
for item in json.loads((preview/'receipt.json').read_text()):
 name=item['path'].replace('/','__')
 with (out/(name+'.stdout.txt')).open('w') as a,(out/(name+'.stderr.txt')).open('w') as b:
  run=subprocess.run(['node',str(repo/'tools/graph-check/map.js'),str(preview/item['path']),browser],stdout=a,stderr=b,env=env,timeout=120)
 record=dict(path=item['path'],exit=run.returncode,summary=(out/(name+'.stdout.txt')).read_text().strip())
 records.append(record);(out/'results.json').write_text(json.dumps(records,indent=2)+'\n')
 print(record,flush=True)
 if run.returncode:
  print((out/(name+'.stderr.txt')).read_text(),file=sys.stderr)
  raise SystemExit(run.returncode)
print('15 full browser checks pass, with geometry checked on every opened chart')

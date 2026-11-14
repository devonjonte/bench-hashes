#!/usr/bin/env python3
"""Run existing chart checks; this recipe adds no renderer compatibility mode."""
from pathlib import Path
import json,os,subprocess
repo=Path('<development-home>/bench-provenance-door')
out=Path('<development-home>/bench-hashes-validation/provenance-visibility/map-regressions');out.mkdir(exist_ok=False)
pinned=Path('<development-home>/bench-hashes-validation/autonomous-20261114/grid-input/current')
env=dict(os.environ,NODE_PATH=str(pinned/'node_modules'),PLAYWRIGHT_BROWSERS_PATH=str(pinned/'browsers'))
browser=subprocess.check_output(['node','-p',"require('playwright').chromium.executablePath()"],cwd=pinned,env=env,text=True).strip()
records=[]
for p in sorted(repo.glob('benchmark-results/*/bench-hashes.map.html')):
 name=p.parent.name
 with (out/(name+'.stdout.txt')).open('w') as a,(out/(name+'.stderr.txt')).open('w') as b:
  r=subprocess.run(['node',str(repo/'tools/graph-check/map.js'),str(p),browser],env=env,stdout=a,stderr=b,timeout=120)
 record={'path':str(p.relative_to(repo)),'exit':r.returncode,'summary':(out/(name+'.stdout.txt')).read_text().strip()}
 records.append(record);(out/'results.json').write_text(json.dumps(records,indent=2)+'\n');print(record,flush=True)
 if r.returncode:raise SystemExit(r.returncode)
assert len(records)==15

#!/usr/bin/env python3
from pathlib import Path
import json, os, subprocess, sys
root=Path('<development-home>/bench-phone-published')
out=Path('<development-home>/bench-hashes-validation/autonomous-20261114/phone-publication')
env=dict(os.environ, NODE_PATH='<development-home>/bench-hashes-validation/node_modules')
browser=subprocess.check_output(['node','-p',"require('playwright').chromium.executablePath()"],env=env,text=True,timeout=10).strip()
records=json.loads((out/'all-maps/refresh-receipt.json').read_text())['maps']
assert len(records)==20
checks=[]
for record in records:
    relative=record['path']; name=relative.replace('/','__')
    stdout=out/'browser'/f'{name}.stdout.txt';stderr=out/'browser'/f'{name}.stderr.txt'
    stdout.parent.mkdir(exist_ok=True)
    with stdout.open('w') as a, stderr.open('w') as b:
        run=subprocess.run(['node',str(root/'tools/graph-check/map.js'),str(root/relative),browser],env=env,stdout=a,stderr=b,timeout=120)
    text=stdout.read_text().strip()
    checks.append(dict(map=relative,exit=run.returncode,summary=text))
    (out/'browser-results.json').write_text(json.dumps(checks,indent=2)+'\n')
    print(relative,run.returncode,text,flush=True)
    if run.returncode:
        print(stderr.read_text(),file=sys.stderr)
        raise SystemExit(run.returncode)
print(f'{len(checks)} published maps pass the full browser check',flush=True)

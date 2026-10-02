#!/usr/bin/env pypy3
"""Retain raw cause-study evidence and exact diagnostic source, no statistics."""
from pathlib import Path
import hashlib,json,shutil,tarfile,subprocess
root=Path(__file__).resolve().parent
out=Path('/home/agent/bench-hashes-mean-regression/audit/results/cause-study');out.mkdir(parents=True,exist_ok=True)
metadata={}
for name in ['manifest.json','calibration/manifest.json','mixed/manifest.json']:
 m=json.loads((root/name).read_text());assert m['state']=='completed',m['state'];metadata[name]=m
assert len(metadata['manifest.json']['runs'])==128
assert len(metadata['calibration/manifest.json']['runs'])==64
assert len(metadata['mixed/manifest.json']['checks'])==3
for p in root.glob('*.txt'):shutil.copyfile(p,out/p.name)
for p in root.glob('*.py'):shutil.copyfile(p,out/p.name)
for p in root.glob('*.patch'):shutil.copyfile(p,out/p.name)
shutil.copytree(root/'audit',out/'audit',dirs_exist_ok=True)
source=root/'source-receipts';source.mkdir(exist_ok=True)
for name in ['cause_audit.rs','counter_audit.rs','probe_audit.rs','calibration_audit.rs','core_proxy_audit.rs','mixed_audit.rs']:
 shutil.copyfile(root/'reader/src'/name,source/name)
for name in ['cause_probe.rs','cause_probe-v2.rs']:
 shutil.copyfile(root/'frozen'/name,source/name)
shutil.copyfile(root/'primed/src/main.rs',source/'mixed-main.rs')
shutil.copyfile(root/'probe/Cargo.toml',source/'Cargo.toml');shutil.copyfile(root/'probe/Cargo.lock',source/'Cargo.lock')
shutil.copyfile(root/'core-type.c',source/'core-type.c')
files={}
for folder in ['runs','calibration','mixed','source-receipts']:
 for p in (root/folder).rglob('*'):
  if p.is_file():files[str(p.relative_to(root))]=hashlib.sha256(p.read_bytes()).hexdigest()
archive=out/'raw-cause-study.tar.gz'
with tarfile.open(archive,'w:gz',compresslevel=6) as tar:
 for name in ['runs','calibration','mixed','source-receipts','manifest.json','probe.patch','mixed-probe.patch','files.txt']:
  tar.add(root/name,arcname=name)
(out/'receipt.json').write_text(json.dumps({'fresh_process_attempts':384,'earlier_null_processes_audited':64,'archive_sha256':hashlib.sha256(archive.read_bytes()).hexdigest(),'archive_bytes':archive.stat().st_size,'artifacts':{name:hashlib.sha256((root/'frozen'/name).read_bytes()).hexdigest() for name in ['probe','probe-v2','mixed-probe']},'metadata':metadata,'file_sha256':files},indent=2)+'\n')
print('Retained384freshprocesses,64earlierprocess audits;archive bytes',archive.stat().st_size)

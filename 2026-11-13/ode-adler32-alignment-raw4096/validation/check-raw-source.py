from pathlib import Path
import os
import shutil
import subprocess

v = Path('<development-home>/bench-hashes-validation/ode-adler-fast')
m = Path('<development-home>/BLAKE3-ode-read/tools/verify/machine')
c = v / 'raw-source-control' / 'machine'
a = c / 'experiments/adler32'
shutil.copytree(m / 'experiments/adler32', a, ignore=shutil.ignore_patterns('__pycache__'))
(c / 'lang').mkdir()
shutil.copyfile(m / 'lang/odec.py', c / 'lang/odec.py')
shutil.copyfile(m / 'observe.py', c / 'observe.py')
s = (a / 'raw4096.S').read_text()
assert s.count('vpslld zmm8, zmm8, 7') == 1
(a / 'raw4096.S').write_text(s.replace('vpslld zmm8, zmm8, 7', 'vpslld zmm8, zmm8, 6'))
out = v / 'raw-source-control/refused-workspace'
p = subprocess.run(['python3', str(a / 'prepare_bench.py'), '<development-home>/bench-0194',
    '<development-home>/bench-hashes-validation/ode-design-reading/adler-proof-committed',
    '<development-home>/adler-comparison-deps', str(out), '--skip-proof'], capture_output=True, text=True, timeout=60)
print(p.stdout, end=''); print(p.stderr, end='')
assert p.returncode != 0 and 'regenerate raw4096.S from its Ode source' in p.stderr
assert not out.exists()
print('stale generated assembly refused before creating a workspace or building dependencies')
for name in ['probe.c', 'align.h', 'probe4096.c', 'raw4096.ode', 'raw4096.S']:
    assert (m / 'experiments/adler32' / name).read_bytes() == (v / 'build-align-raw' / name).read_bytes(), name
print('all executable candidate source files equal the SDE-validated copies')

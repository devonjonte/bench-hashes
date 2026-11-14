#!/usr/bin/env python3
"""Bind four reviewed historical folders before refreshing their presentation."""
from pathlib import Path
import hashlib, subprocess
root = Path('<development-home>/bench-phone-published')
out = Path('<development-home>/bench-hashes-validation/autonomous-20261114/phone-publication/legacy-before')
expected = {'AMDEPYC7443P24CoreProcessor.linux70038generic',
            'AMDEPYC925424CoreProcessor.linux70038generic',
            'AMDRyzen79700X8CoreProcessor.linux70038generic',
            'IntelRXeonRCPUE51650v4360GHz.linux70038generic'}
missing = set()
for mapfile in sorted((root/'benchmark-results').glob('*/bench-hashes.map.html')):
    directory = mapfile.parent
    a, b = directory/'SHA256SUMS', directory/'BLAKE3SUMS'
    assert a.exists() == b.exists(), directory
    if a.exists():
        subprocess.run(['sha256sum', '--check', '--quiet', a.name], cwd=directory, check=True)
        subprocess.run(['b3sum', '--check', '--quiet', b.name], cwd=directory, check=True,
                       stdout=subprocess.DEVNULL)
    else:
        missing.add(directory.name)
assert missing == expected, missing
subprocess.run(['git', 'diff', '--exit-code', '--', 'benchmark-results'], cwd=root, check=True)
for name in sorted(expected):
    directory = root/'benchmark-results'/name
    files = sorted(p.name for p in directory.iterdir() if p.is_file())
    tracked = subprocess.check_output(['git', 'ls-files', '-z', '--', str(directory.relative_to(root))], cwd=root).decode().split('\0')
    assert sorted(Path(p).name for p in tracked if p) == files
    sha = ''.join(hashlib.sha256((directory/f).read_bytes()).hexdigest()+'  '+f+'\n' for f in files).encode()
    b3 = subprocess.check_output(['b3sum', *files], cwd=directory)
    (out/name).mkdir(parents=True, exist_ok=True)
    for filename, contents in [('SHA256SUMS', sha), ('BLAKE3SUMS', b3)]:
        assert not (directory/filename).exists()
        (directory/filename).write_bytes(contents)
        (out/name/filename).write_bytes(contents)
    subprocess.run(['sha256sum', '--check', '--quiet', 'SHA256SUMS'], cwd=directory, check=True)
    subprocess.run(['b3sum', '--check', '--quiet', 'BLAKE3SUMS'], cwd=directory, check=True,
                   stdout=subprocess.DEVNULL)
    print(name, len(files), 'existing files bound; no file contents changed')

#!/usr/bin/env python3
"""Bind the explicitly named, tracked result folders; existing files stay exact."""
from pathlib import Path
import hashlib, subprocess, sys
root = Path('<development-home>/bench-phone-published')
out = Path('<development-home>/bench-hashes-validation/autonomous-20261114/phone-publication/compared-before')
folders = [root/p for p in sys.argv[1:]]
assert folders
for directory in folders:
    assert not (directory/'SHA256SUMS').exists() and not (directory/'BLAKE3SUMS').exists()
    subprocess.run(['git', 'diff', '--exit-code', '--', str(directory.relative_to(root))], cwd=root, check=True)
    files = sorted(p.name for p in directory.iterdir() if p.is_file())
    tracked = subprocess.check_output(['git', 'ls-files', '-z', '--', str(directory.relative_to(root))], cwd=root).decode().split('\0')
    assert sorted(Path(p).name for p in tracked if p) == files
    sha = ''.join(hashlib.sha256((directory/f).read_bytes()).hexdigest()+'  '+f+'\n' for f in files).encode()
    b3 = subprocess.check_output(['b3sum', *files], cwd=directory)
    saved = out/directory.relative_to(root); saved.mkdir(parents=True, exist_ok=True)
    for filename, contents in [('SHA256SUMS', sha), ('BLAKE3SUMS', b3)]:
        (directory/filename).write_bytes(contents)
        (saved/filename).write_bytes(contents)
    subprocess.run(['sha256sum', '--check', '--quiet', 'SHA256SUMS'], cwd=directory, check=True)
    subprocess.run(['b3sum', '--check', '--quiet', 'BLAKE3SUMS'], cwd=directory, check=True,
                   stdout=subprocess.DEVNULL)
    print(directory.relative_to(root), len(files), 'existing files bound; no file contents changed')

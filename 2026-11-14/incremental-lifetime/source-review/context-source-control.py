#!/usr/bin/env python3
"""Alter one copied header; the source/configuration check must reject it."""
from pathlib import Path
import shutil
import subprocess
import sys

checker, repo, evidence, fixture = map(Path, sys.argv[1:])
fixture.mkdir(exist_ok=False)
for relative in ['pilot/kept-harness', 'shared-followup/kept-samecode-common', 'shared-followup/kept-harness-repeat']:
    source = evidence/'x86-epyc-9275f'/relative
    target = fixture/'x86-epyc-9275f'/relative
    target.mkdir(parents=True)
    for p in [*source.glob('run-*.tsv'), source/'sizes.tsv']:
        shutil.copyfile(p, target/p.name)
p = next((fixture/'x86-epyc-9275f/pilot/kept-harness').glob('run-*.tsv'))
text = p.read_text()
old = '# shared placements: one cache: CPUs 0 and 1; two caches: CPUs 0 and 3'
assert text.count(old) == 1
p.write_text(text.replace(old, old.replace('0 and 3', '0 and 99')))
result = subprocess.run([sys.executable, str(checker), str(repo), str(fixture)], capture_output=True, text=True, timeout=30)
print(result.stderr, end='')
assert result.returncode == 1 and 'AssertionError' in result.stderr
print('PASS: altered shared-placement header is rejected; original records were untouched')

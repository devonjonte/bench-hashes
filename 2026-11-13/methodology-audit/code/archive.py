#!/usr/bin/env python3
"""Copy delivered audit evidence, excluding executables and private ops notes.
Sample interpretation belongs to bench-hashes compare; this only copies files
and invokes that reader on the original old/new pairs of each stage.
"""
from pathlib import Path
import shutil
import subprocess

home = Path('/home/agent')
source = home / 'bench-hashes-validation/inbox'
audit = home / 'bench-hashes-validation/method-audit'
out = home / 'bench-hashes-data/2026-11-13/methodology-audit'
reader = home / 'bench-022/target/release/bench-hashes'
jobs = {
    'x86-epyc-9255': ['xbench-ref'],
    'x86-epyc-9275f': ['xbench-ref', 'align-probe'],
    'x86-9700x': ['align-probe', 'hasher-probe'],
    'x86-avx2': ['numa-ab', 'align-probe'],
    'x86-icelake-2': ['numa-ab', 'align-probe'],
}
for host, runs in jobs.items():
    for run in runs:
        root = source / host / run
        for p in sorted(root.rglob('*')):
            if not p.is_file() or p.suffix not in {'.txt', '.tsv', '.sh', '.c', '.json', '.log'}:
                continue
            dest = out / host / run / p.relative_to(root)
            dest.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(p, dest)
        dest = out / host / run
        for stage in sorted({p.parent for p in dest.rglob('run-*-old.tsv')}):
            old = sorted(stage.glob('run-*-old.tsv'))
            new = sorted(stage.glob('run-*-new.tsv'))
            assert len(old) == len(new) and len(old) >= 3, stage
            args = ['compare', '--markdown', *[str(p.relative_to(out)) for p in old], '--', *[str(p.relative_to(out)) for p in new]]
            with (stage / 'replayed-compare.md').open('w') as stdout, (stage / 'replayed-compare.stderr.txt').open('w') as stderr:
                subprocess.run([str(reader), *args], cwd=out, stdout=stdout, stderr=stderr, check=True, timeout=30)
            print(host, run, stage.relative_to(dest), len(old), 'pairs replayed')
code = out / 'code'
code.mkdir(parents=True, exist_ok=True)
for rev, path in [
    ('973cf428c20a54b63edda2a9dc0d4e39abacd859', 'examples/align_probe.rs'),
    ('900d8c9279a001cf74dbd4b389581d61e2eacc44', 'examples/hasher_probe.rs'),
]:
    (code / Path(path).name).write_bytes(subprocess.check_output(['git', '-C', str(home / 'bench-022'), 'show', f'{rev}:{path}']))
for p in sorted(audit.glob('*.py')):
    shutil.copyfile(p, code / p.name)
for p in sorted((audit / 'jobs').glob('*.sh')):
    shutil.copyfile(p, code / p.name)
for name in ['restored-rule-check.stdout.txt', 'restored-rule-check.stderr.txt', 'rebuild-reader.sh']:
    shutil.copyfile(audit / name, code / name)

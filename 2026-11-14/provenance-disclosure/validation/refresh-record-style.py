#!/usr/bin/env python3
"""Apply the canonical record-style change, preserving every other stored byte.
Uses the phone-publication recipe's manifest-preserving update and dual checks.
"""
from pathlib import Path
import hashlib, json, subprocess, sys

root, out = map(Path, sys.argv[1:])
out.mkdir(parents=True, exist_ok=True)
subprocess.run(['git', 'diff', '--exit-code', '--', 'benchmark-results', 'beside'], cwd=root, check=True)
template = (root/'src/map.html').read_bytes()
base = 'da6fe3c478e3e25c23ab05514a1723e1e20f5e2f'
before_template = subprocess.check_output(['git', 'show', base+':src/map.html'], cwd=root)
def record_style(html):
    start = html.index(b'.run {')
    return html[start:html.index(b'.legend {', start)]
anchor = record_style(before_template)
repair = record_style(template)
assert anchor != repair


def hashes(data):
    return dict(sha256=hashlib.sha256(data).hexdigest(),
                blake3=subprocess.check_output(['b3sum'], input=data).split()[0].decode())


def verify(directory):
    subprocess.run(['sha256sum', '--check', '--quiet', 'SHA256SUMS'], cwd=directory, check=True)
    subprocess.run(['b3sum', '--check', '--quiet', 'BLAKE3SUMS'], cwd=directory, check=True,
                   stdout=subprocess.DEVNULL)


tracked = subprocess.check_output(['git', 'ls-files', '-z', '*.map.html'], cwd=root).decode().split('\0')
maps = sorted(root/name for name in tracked if name.startswith(('benchmark-results/', 'beside/')))
assert len(maps) == 20, 'the declared publication scope'
directories = sorted({p.parent for p in maps})
for directory in directories:
    verify(directory)
updates, records, digests = {}, [], {}
for path in maps:
    before = path.read_bytes()
    assert before.count(anchor) == 1, path
    assert repair not in before, path
    after = before.replace(anchor, repair, 1)
    assert after.replace(repair, anchor, 1) == before, 'every other HTML byte stays exact'
    old_hash, new_hash = hashes(before), hashes(after)
    updates[path] = after
    digests[path] = (old_hash, new_hash)
    records.append(dict(path=str(path.relative_to(root)), before=old_hash, after=new_hash,
                        other_html_bytes_unchanged=True))

# One manifest update per directory, including folders containing two maps.
for directory in directories:
    selected = {p.name: digests[p] for p in maps if p.parent == directory}
    for name, algorithm in [('SHA256SUMS', 'sha256'), ('BLAKE3SUMS', 'blake3')]:
        manifest = directory/name
        entries = manifest.read_bytes().splitlines(keepends=True)
        revised, changed = entries.copy(), []
        for i, line in enumerate(entries):
            filename = line[64:].strip().decode()
            if filename in selected:
                old_hash, new_hash = selected[filename]
                assert line[:64].decode() == old_hash[algorithm]
                revised[i] = new_hash[algorithm].encode()+line[64:]
                changed.append(i)
        assert sorted(entries[i][64:].strip().decode() for i in changed) == sorted(selected), manifest
        assert [line for i, line in enumerate(revised) if i not in changed] == [line for i, line in enumerate(entries) if i not in changed]
        updates[manifest] = b''.join(revised)

# Every input and its manifests passed before any output changes.
for path, contents in updates.items():
    path.write_bytes(contents)
for directory in directories:
    verify(directory)
(out/'record-style-before.css').write_bytes(anchor)
(out/'record-style-after.css').write_bytes(repair)
receipt = dict(base=base, source=subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=root, text=True).strip(),
               template=hashes(template), maps=records,
               rule='Only the canonical record-style block and each map checksum entry change.')
(out/'refresh-receipt.json').write_text(json.dumps(receipt, indent=2)+'\n')
print(f'{len(maps)} maps in {len(directories)} folders refreshed; all other HTML bytes and manifest entries stay exact; dual checks pass')

#!/usr/bin/env python3
"""Apply the existing template's phone repair to stored maps, preserving all other bytes."""
from pathlib import Path
import hashlib, json, subprocess, sys

root, out = map(Path, sys.argv[1:])
out.mkdir(parents=True, exist_ok=True)
subprocess.run(['git', 'diff', '--exit-code', '--', 'benchmark-results'], cwd=root, check=True)
template = (root/'src/map.html').read_bytes()
lines = template.splitlines(keepends=True)
indices = [i for i, line in enumerate(lines) if line.startswith(b'a.doc {')]
assert len(indices) == 1
index = indices[0]
anchor = lines[index]
repair = b''.join(lines[index+1:index+4])
assert repair.startswith(b'/* Under a finger')
assert repair.endswith(b'@media (pointer: coarse) { .cell a.doc { pointer-events: none; } }\n')
assert lines[index+4].startswith(b'.zoom {')


def hashes(data):
    return dict(sha256=hashlib.sha256(data).hexdigest(),
                blake3=subprocess.check_output(['b3sum'], input=data).split()[0].decode())


def verify(directory):
    subprocess.run(['sha256sum', '--check', '--quiet', 'SHA256SUMS'], cwd=directory, check=True)
    subprocess.run(['b3sum', '--check', '--quiet', 'BLAKE3SUMS'], cwd=directory, check=True,
                   stdout=subprocess.DEVNULL)


maps = sorted((root/'benchmark-results').glob('*/bench-hashes.map.html'))
assert len(maps) == 15, 'the declared publication scope'
updates, records = [], []
for path in maps:
    verify(path.parent)
    before = path.read_bytes()
    assert before.count(anchor) == 1, path
    assert repair not in before, path
    after = before.replace(anchor, anchor+repair, 1)
    assert after.replace(repair, b'', 1) == before, 'every other HTML byte stays exact'
    old_hash, new_hash = hashes(before), hashes(after)
    updates.append((path, after))
    records.append(dict(path=str(path.relative_to(root)), before=old_hash, after=new_hash,
                        other_html_bytes_unchanged=True))
    for name, algorithm in [('SHA256SUMS', 'sha256'), ('BLAKE3SUMS', 'blake3')]:
        manifest = path.parent/name
        entries = manifest.read_bytes().splitlines(keepends=True)
        selected = [i for i, line in enumerate(entries) if line[64:].strip() == path.name.encode()]
        assert len(selected) == 1, manifest
        at = selected[0]
        assert entries[at][:64].decode() == old_hash[algorithm]
        revised = entries.copy()
        revised[at] = new_hash[algorithm].encode()+entries[at][64:]
        assert revised[:at]+revised[at+1:] == entries[:at]+entries[at+1:]
        updates.append((manifest, b''.join(revised)))

# Every input and its manifests passed before any output changes.
for path, contents in updates:
    path.write_bytes(contents)
for path in maps:
    verify(path.parent)
(out/'repair.css').write_bytes(repair)
receipt = dict(base=subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=root, text=True).strip(),
               template=hashes(template), maps=records,
               rule='Only the canonical repair block and each map checksum entry change.')
(out/'refresh-receipt.json').write_text(json.dumps(receipt, indent=2)+'\n')
print(f'{len(maps)} maps refreshed; all other HTML bytes and manifest entries stay exact; dual checks pass')

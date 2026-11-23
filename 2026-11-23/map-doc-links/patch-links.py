#!/usr/bin/env python3
"""Repair the documentation links of stored maps, preserving every other byte.

A stored map of bench-hashes 0.22 or 0.24 names its calls in BLAKE3-Servil's `throughput` module and
links their pages under the module's former name, `performance`, where no page answers. This rewrites
exactly those links (a call named `throughput::NAME` whose link is `.../performance/fn.NAME.html`),
then binds the folder's two manifests to the new file.

    patch-links.py REPOSITORY           what it would change
    patch-links.py REPOSITORY --write   change it
"""
import hashlib, re, subprocess, sys
from pathlib import Path

root = Path(sys.argv[1])
write = '--write' in sys.argv[2:]
BASE = b'https://servil-software-factory.github.io/BLAKE3/blake3_servil/'
PAIR = re.compile(rb'"call":"([^"]*)","doc":"' + re.escape(BASE) + rb'([^"]*)"')


def manifests_hold(directory):
    subprocess.run(['sha256sum', '--check', '--quiet', 'SHA256SUMS'], cwd=directory, check=True)
    subprocess.run(['b3sum', '--check', '--quiet', 'BLAKE3SUMS'], cwd=directory, check=True, stdout=subprocess.DEVNULL)


def bind(manifest, name, digest):
    """The manifest's line for `name` takes `digest`; its other lines keep their bytes."""
    lines = manifest.read_bytes().splitlines(keepends=True)
    at = [i for i, line in enumerate(lines) if line.split(b'  ', 1)[1].rstrip(b'\n') == name.encode()]
    assert len(at) == 1, (manifest, name)
    lines[at[0]] = digest.encode() + b'  ' + name.encode() + b'\n'
    manifest.write_bytes(b''.join(lines))


subprocess.run(['git', 'diff', '--exit-code', '--quiet', '--', 'benchmark-results', 'beside'], cwd=root, check=True)
tracked = subprocess.check_output(['git', 'ls-files', '-z', '*.map.html'], cwd=root).decode().split('\0')
changed = 0
for name in sorted(n for n in tracked if n):
    path = root / name
    before = path.read_bytes()

    def repaired(match):
        call, page = match.group(1), match.group(2)
        function = call[len(b'throughput::'):]
        if call.startswith(b'throughput::') and page == b'performance/fn.' + function + b'.html':
            return b'"call":"' + call + b'","doc":"' + BASE + b'throughput/fn.' + function + b'.html"'
        return match.group(0)

    after, pairs = PAIR.subn(repaired, before)
    links = sum(1 for a, b in zip(PAIR.findall(before), PAIR.findall(after)) if a != b)
    left = [(c, p) for c, p in PAIR.findall(after) if c.split(b'::')[0] != p.split(b'/')[0]]
    assert not left, (name, left[:3])
    if links == 0:
        continue
    # Nothing else differs: the old bytes with those links' module renamed are the new bytes.
    assert len(after) == len(before) - links * (len(b'performance') - len(b'throughput'))
    assert after.replace(BASE + b'throughput/fn.', BASE + b'performance/fn.') == before.replace(BASE + b'throughput/fn.', BASE + b'performance/fn.')
    version = re.search(rb'bench-hashes (\d+\.\d+\.\d+)', before).group(1).decode()
    changed += 1
    print(f'{name}: bench-hashes {version}, {links} of {pairs} links repaired, sha256 {hashlib.sha256(before).hexdigest()[:12]} -> {hashlib.sha256(after).hexdigest()[:12]}')
    if write:
        manifests_hold(path.parent)
        path.write_bytes(after)
        bind(path.parent / 'SHA256SUMS', path.name, hashlib.sha256(after).hexdigest())
        bind(path.parent / 'BLAKE3SUMS', path.name, subprocess.check_output(['b3sum', '--no-names', str(path)]).decode().strip())
        manifests_hold(path.parent)
print(f'{changed} maps {"repaired" if write else "to repair"}')

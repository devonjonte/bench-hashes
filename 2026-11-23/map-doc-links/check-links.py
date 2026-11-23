#!/usr/bin/env python3
"""Which documentation links of the stored maps answer today: check-links.py REPOSITORY

For every tracked map, each distinct (call, page) pair it links under BLAKE3-Servil's documentation
site, with whether the page answers 200 and holds the link's anchor. A page is fetched once.
"""
import collections, re, subprocess, sys, urllib.error, urllib.request
from pathlib import Path

root = Path(sys.argv[1])
BASE = 'https://servil-software-factory.github.io/BLAKE3/blake3_servil/'
PAIR = re.compile(r'"call":"([^"]*)","doc":"' + re.escape(BASE) + r'([^"]*)"')
pages = {}


def answers(link):
    page, _, anchor = link.partition('#')
    if page not in pages:
        try:
            with urllib.request.urlopen(BASE + page, timeout=30) as reply:
                pages[page] = (reply.status, reply.read().decode('utf-8', 'replace'))
        except urllib.error.HTTPError as error:
            pages[page] = (error.code, '')
    status, html = pages[page]
    return status == 200 and (not anchor or f'id="{anchor}"' in html), status


seen = collections.defaultdict(lambda: collections.Counter())
tracked = subprocess.check_output(['git', 'ls-files', '-z', '*.map.html'], cwd=root).decode().split('\0')
maps = 0
for name in sorted(n for n in tracked if n):
    text = (root / name).read_text()
    pairs = PAIR.findall(text)
    if not pairs:
        continue
    maps += 1
    version = re.search(r'bench-hashes (\d+\.\d+)', text).group(1)
    for pair in pairs:
        seen[pair][version] += 1
dead = 0
for (call, link), versions in sorted(seen.items()):
    live, status = answers(link)
    dead += 0 if live else sum(versions.values())
    where = ', '.join(f'{count} in {version}' for version, count in sorted(versions.items()))
    print(f"{'answers' if live else 'DEAD   '} {status} {call:42s} {link:58s} {where}")
print(f'{maps} maps link this site; {sum(sum(v.values()) for v in seen.values())} links, {dead} dead')

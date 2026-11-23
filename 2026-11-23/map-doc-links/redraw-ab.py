#!/usr/bin/env python3
"""A stored record's map drawn again by two programs: what differs?

    redraw-ab.py OLD_PROGRAM NEW_PROGRAM RECORD_FOLDER... 

Each record folder is copied twice, each program draws its copy's map again (`bench-hashes map DIR`),
and the two maps are compared: the calls and pages each links, and whether the old map with the
module of its function links renamed (performance to throughput) is the new map, byte for byte.
"""
import collections, re, shutil, subprocess, sys, tempfile
from pathlib import Path

old_program, new_program, *records = sys.argv[1:]
BASE = 'https://servil-software-factory.github.io/BLAKE3/blake3_servil/'
PAIR = re.compile(r'"call":"([^"]*)","doc":"' + re.escape(BASE) + r'([^"]*)"')
with tempfile.TemporaryDirectory(dir=Path.home() / 'tmp') as scratch:
    for record in map(Path, records):
        maps = {}
        for side, program in (('old', old_program), ('new', new_program)):
            copy = Path(scratch) / side / record.name
            shutil.copytree(record, copy)
            subprocess.run([program, 'map', str(copy)], check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            maps[side] = (copy / 'bench-hashes.map.html').read_text()
        pairs = {side: collections.Counter(PAIR.findall(text)) for side, text in maps.items()}
        print(f'{record.name}: {sum(pairs["old"].values())} links drawn by each program' if sum(pairs['old'].values()) == sum(pairs['new'].values()) else f'{record.name}: LINK COUNTS DIFFER')
        for pair in sorted(set(pairs['old']) ^ set(pairs['new'])):
            print(f"  {'old' if pair in pairs['old'] else 'new'} only: {pair[0]} -> {pair[1]}")
        renamed = maps['old'].replace(BASE + 'performance/fn.', BASE + 'throughput/fn.')
        print(f"  the old map with performance/fn. renamed is the new map, byte for byte: {renamed == maps['new']}")

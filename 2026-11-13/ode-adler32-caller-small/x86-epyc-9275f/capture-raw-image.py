#!/usr/bin/env python3
"""Capture the UNVERIFIED linked kernel image and check its two constant tables.

This records bytes, not a machine theorem. No clocks or samples are read.
"""
from pathlib import Path
import json
import re
import subprocess
import sys

exe, prefix, scratch, machine = map(Path, sys.argv[1:])
sys.path.insert(0, str(machine))
from observe import digest

symbols = subprocess.check_output(['nm', '-an', exe], text=True)
starts = [int(m[1], 16) for m in re.finditer(r'^([0-9a-f]+) [tT] _?b3l_raw4096$', symbols, re.M)]
assert len(starts) == 2 and len(set(starts)) == 1
start, length = starts[0], 1901
headers = subprocess.check_output(['readelf', '-WS', exe], text=True)
sections = [(m[1], *[int(m[k], 16) for k in [2, 3, 4]]) for m in re.finditer(
    r'\]\s+(\S+)\s+PROGBITS\s+([0-9a-f]+)\s+([0-9a-f]+)\s+([0-9a-f]+)', headers)]
image = exe.read_bytes()
def read(address, n, section):
    matches = [(a, off, size) for name, a, off, size in sections if name == section and a <= address and address + n <= a + size]
    assert len(matches) == 1, (address, n, section)
    a, off, _ = matches[0]
    return image[off + address - a:off + address - a + n]

code = read(start, length, '.text')
listing = subprocess.check_output(['objdump', '-d', '-Mintel', '--start-address='+hex(start), '--stop-address='+hex(start+length), exe], text=True)
tables = []
for reg, expected in [(12, bytes(range(64, 0, -1))), (13, bytes([1] * 64))]:
    rows = [line for line in listing.splitlines() if re.search(r'\bvmovdqa64\s+zmm'+str(reg)+r',.*\[rip', line)]
    assert len(rows) == 1, (reg, rows)
    target = int(re.search(r'#\s*([0-9a-f]+)', rows[0])[1], 16)
    actual = read(target, 64, '.rodata')
    assert actual == expected, (reg, target)
    p = scratch / ('table'+str(reg)+'.bin'); p.write_bytes(actual)
    tables.append({'register': reg, 'address': target, 'hex': actual.hex(), 'digest': digest(p)})
p = scratch / 'raw-linked-text.bin'; p.write_bytes(code)
record = {'scope': 'UNVERIFIED kernel image observation; constants checked against source values; no machine theorem',
          'text_address': start, 'text_bytes': length, 'text_hex': code.hex(), 'text_digest': digest(p), 'tables': tables}
prefix.with_suffix('.json').write_text(json.dumps(record, indent=2)+'\n')
prefix.with_suffix('.listing').write_text(listing)
print('linked raw4096 text captured; both read-only constant tables match source values')

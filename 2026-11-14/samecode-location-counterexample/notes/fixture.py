#!/usr/bin/env python3
"""Fixed valid ELF64 objects: one compiler build ID and one application note."""
from pathlib import Path
import struct

def image(build_id, value):
    data = bytearray(416)
    data[:8] = b'\x7fELF\x02\x01\x01\0'
    struct.pack_into('<HHIQQQIHHHHHH', data, 16,
                     1, 62, 1, 0, 0, 160, 0, 64, 0, 0, 64, 4, 1)
    data[64:104] = b'\0.shstrtab\0.note.gnu.build-id\0.note.app\0'
    struct.pack_into('<III4s16s', data, 104, 4, 16, 3, b'GNU\0', bytes([build_id])*16)
    struct.pack_into('<III4sI', data, 136, 4, 4, 1, b'APP\0', value)
    for i, fields in enumerate([
        (1, 3, 0, 0, 64, 40, 0, 0, 1, 0),
        (11, 7, 2, 0, 104, 32, 0, 0, 4, 0),
        (30, 7, 2, 0, 136, 20, 0, 0, 4, 0),
    ], 1):
        struct.pack_into('<IIQQQQIIQQ', data, 160 + i*64, *fields)
    return data

for name, ident, value in [('base', 1, 111), ('id', 2, 111), ('app', 1, 222)]:
    Path(__file__).with_name(f'fixture-{name}.o').write_bytes(image(ident, value))

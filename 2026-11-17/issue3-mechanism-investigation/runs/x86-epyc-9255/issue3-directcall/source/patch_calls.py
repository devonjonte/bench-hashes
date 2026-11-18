#!/usr/bin/env python3
"""Diagnostic only: flip two verified local FFI calls in one owned ELF inode.

Linux x86-64 PIE, six-byte RIP-relative GOT calls from hash_serial_cold to
its SSE4.1/AVX-512 chunk-root kernels. Replace them with six-byte addr32
relative calls, the standard linker-relaxation form. Every relative code
address and return address stays fixed. Requires exclusive use of the file;
this tool changes a private experimental executable, never a library artifact.

prepare EXE MANIFEST HASH_TOOL
set direct|indirect EXE MANIFEST HASH_TOOL
"""
import hashlib
import json
import os
from pathlib import Path
import re
import struct
import subprocess
import sys


def hashes(path, tool):
    data = path.read_bytes()
    return {"sha256": hashlib.sha256(data).hexdigest(),
            "blake3": subprocess.check_output([tool, str(path)], text=True).split()[0]}


def write_sites(path, sites, mode):
    with path.open("r+b") as f:
        for s in sites:
            f.seek(s["file_offset"])
            f.write(bytes.fromhex(s[mode]))
        f.flush()
        os.fsync(f.fileno())


def prepare(path, manifest, tool):
    data = path.read_bytes()
    assert data[:6] == b"\x7fELF\x02\x01", "ELF64 little-endian"
    assert struct.unpack_from("<HH", data, 16) == (3, 62), "x86-64 PIE"
    phoff = struct.unpack_from("<Q", data, 32)[0]
    phsize, phnum = struct.unpack_from("<HH", data, 54)
    assert phsize == 56
    loads = []
    for i in range(phnum):
        kind, flags, off, va, _, size, _, _ = struct.unpack_from("<IIQQQQQQ", data, phoff+i*phsize)
        if kind == 1:
            loads.append((flags, off, va, size))

    def offset(va, size):
        found = [off + va-base for flags,off,base,n in loads if flags & 1 and base <= va and va+size <= base+n]
        assert len(found) == 1, (va, size, found)
        return found[0]

    nm = subprocess.check_output(["nm", "-n", "-S", "-C", str(path)], text=True)
    functions = [l.split() for l in nm.splitlines() if l.endswith(" blake3_servil_core::hash_serial_cold")]
    assert len(functions) == 1, functions
    start, size = int(functions[0][0],16), int(functions[0][1],16)
    names = {"blake3_servil_sse41_chunk_root", "blake3_servil_avx512_chunk_root"}
    roots = {int(l.split()[0],16):l.split()[-1] for l in nm.splitlines() if l.split() and l.split()[-1] in names}
    assert len(roots) == 2
    relocs = subprocess.check_output(["readelf", "-rW", str(path)], text=True)
    got = {}
    for line in relocs.splitlines():
        fields = line.split()
        if len(fields) == 4 and fields[2] == "R_X86_64_RELATIVE":
            target = int(fields[3],16)
            if target in roots:
                got[int(fields[0],16)] = target
    assembly = subprocess.check_output(["objdump", "-d", f"--start-address={start}", f"--stop-address={start+size}", str(path)],text=True)
    sites = []
    for line in assembly.splitlines():
        m = re.match(r"\s*([0-9a-f]+):\s+((?:[0-9a-f]{2}\s+)+)\s+callq?\s+\*",line)
        if not m:
            continue
        pc = int(m[1],16)
        old = bytes.fromhex(m[2])
        if len(old) != 6 or old[:2] != b"\xff\x15":
            continue
        slot = pc+6+struct.unpack_from("<i",old,2)[0]
        if slot not in got:
            continue
        target = got[slot]
        new = b"\x67\xe8"+struct.pack("<i",target-(pc+6))
        off = offset(pc,6)
        assert data[off:off+6] == old
        sites.append({"pc":pc,"file_offset":off,"target":target,"symbol":roots[target],"got_slot":slot,"indirect":old.hex(),"direct":new.hex()})
    assert len(sites) == 2 and {s["target"] for s in sites} == set(roots), sites
    before = hashes(path,tool)
    identity = [path.stat().st_dev,path.stat().st_ino]
    write_sites(path,sites,"direct")
    direct = hashes(path,tool)
    expected = bytearray(data)
    for s in sites:
        off=s["file_offset"]
        expected[off:off+6]=bytes.fromhex(s["direct"])
    assert path.read_bytes() == expected, "only the declared instruction bytes changed"
    write_sites(path,sites,"indirect")
    assert path.read_bytes() == data and hashes(path,tool) == before
    manifest.write_text(json.dumps({"inode":identity,"sites":sites,"indirect":before,"direct":direct},indent=2)+"\n")
    print(f"Prepared {len(sites)} local call sites; original bytes restored, inode {identity}.")


def set_mode(mode,path,manifest,tool):
    assert mode in ("direct","indirect")
    m=json.loads(manifest.read_text())
    assert [path.stat().st_dev,path.stat().st_ino] == m["inode"], "same experimental inode"
    assert hashes(path,tool) in [m["direct"],m["indirect"]], "one of the two complete known byte sequences"
    write_sites(path,m["sites"],mode)
    assert hashes(path,tool) == m[mode], "the complete declared executable identity"


if __name__ == "__main__":
    if len(sys.argv)==5 and sys.argv[1]=="prepare":
        prepare(Path(sys.argv[2]),Path(sys.argv[3]),sys.argv[4])
    elif len(sys.argv)==6 and sys.argv[1]=="set":
        set_mode(sys.argv[2],Path(sys.argv[3]),Path(sys.argv[4]),sys.argv[5])
    else:
        raise SystemExit(__doc__)

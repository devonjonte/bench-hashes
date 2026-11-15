#!/usr/bin/env python3
"""Link Sam's checked Adler-32 object into libdeflate and check the shipped library.

The adapter follows the earlier experiment (reuse_libdeflate.py): libdeflate's two
whole-buffer zlib checksum calls route to the checked function; the object's bytes
join the shared library unchanged, carrying their .ode.proof section.
"""
import ctypes as C
import difflib
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys
import zlib

KCHECK = Path("<development-home>/BLAKE3-sam-kcheck/tools/verify/machine/kcheck")
OBJECT = KCHECK / "programs/adler32/odeadler32.o"
SPEC = KCHECK / "programs/adler32/adler32.spec"
SOURCE = Path("<development-home>/adler-comparison-deps/libdeflate")
out = Path(sys.argv[1])
out.mkdir(parents=True)
modified = out / "libdeflate"
shutil.copytree(SOURCE, modified)
changes = []
# The contract takes (input, len) in the System V order, seed 1 fixed, as the
# two whole-buffer call sites use it.
for name, old, new in [
    ("lib/zlib_compress.c", "libdeflate_adler32(1, in, in_nbytes)", "(u32)ode_adler32(in, in_nbytes)"),
    ("lib/zlib_decompress.c", "libdeflate_adler32(1, out, actual_out_nbytes)", "(u32)ode_adler32(out, actual_out_nbytes)"),
]:
    path = modified / name
    original = path.read_text()
    assert original.count(old) == 1, (name, old)
    changed = original.replace(old, new).replace('#include "zlib_constants.h"', '#include "zlib_constants.h"\n#include "ode_adler32.h"')
    path.write_text(changed)
    changes.extend(difflib.unified_diff(original.splitlines(True), changed.splitlines(True), fromfile="a/" + name, tofile="b/" + name))
header = modified / "lib/ode_adler32.h"
header.write_text(
    "/* Sam's checked Adler-32 (kcheck programs/adler32), seed 1, readable buffer. */\n"
    "#include <stdint.h>\n#include <stddef.h>\n"
    '_Static_assert(sizeof(size_t) == sizeof(uint64_t), "the contract takes a 64-bit length");\n'
    "extern uint64_t ode_adler32(const void *input, uint64_t length);\n"
)
changes.extend(difflib.unified_diff([], header.read_text().splitlines(True), fromfile="/dev/null", tofile="b/lib/ode_adler32.h"))
cmake = modified / "CMakeLists.txt"
original = cmake.read_text()
cmake.write_text(original + '\n# Experiment: link the checked object as it is shipped.\ntarget_sources(libdeflate_shared PRIVATE "${ODE_ADLER_OBJECT}")\n')
changes.extend(difflib.unified_diff(original.splitlines(True), cmake.read_text().splitlines(True), fromfile="a/CMakeLists.txt", tofile="b/CMakeLists.txt"))
(out / "changes.diff").write_text("".join(changes))

build = out / "build"
subprocess.run(["cmake", "-S", str(modified), "-B", str(build), "-DCMAKE_BUILD_TYPE=Release", f"-DODE_ADLER_OBJECT={OBJECT}"], check=True, stdout=(out / "cmake.txt").open("w"), stderr=subprocess.STDOUT)
subprocess.run(["cmake", "--build", str(build), "--target", "libdeflate_shared", "-j4"], check=True, stdout=(out / "build.txt").open("w"), stderr=subprocess.STDOUT)
library = next(build.glob("libdeflate.so*[0-9]"))
shutil.copyfile(library, out / "libdeflate-ode.so")
library = out / "libdeflate-ode.so"

# The shipped library, checked against the reader's specification.
check = subprocess.run([sys.executable, str(KCHECK / "programs/check_file.py"), str(library), str(SPEC), "--json", str(out / "check.json")], capture_output=True, text=True)
(out / "check.txt").write_text(check.stdout + check.stderr)
print(check.stdout, end="")
assert check.returncode == 0, check.returncode

# The linked library computes zlib's checksums end to end.
deflate = C.CDLL(str(library))
deflate.libdeflate_alloc_compressor.restype = C.c_void_p
deflate.libdeflate_zlib_compress_bound.restype = C.c_size_t
deflate.libdeflate_zlib_compress_bound.argtypes = [C.c_void_p, C.c_size_t]
deflate.libdeflate_zlib_compress.restype = C.c_size_t
deflate.libdeflate_zlib_compress.argtypes = [C.c_void_p, C.c_void_p, C.c_size_t, C.c_void_p, C.c_size_t]
adler = getattr(deflate, "ode_adler32", None)
rounds = []
for length in [0, 1, 3, 255, 5551, 5552, 5553, 70000, 1 << 20]:
    data = bytes((i * 31 ^ (i >> 9)) & 0xFF for i in range(length))
    compressor = deflate.libdeflate_alloc_compressor(6)
    bound = deflate.libdeflate_zlib_compress_bound(compressor, len(data))
    room = C.create_string_buffer(bound)
    made = deflate.libdeflate_zlib_compress(compressor, data, len(data), room, bound)
    assert made > 0
    assert zlib.decompress(room.raw[:made]) == data
    stored = int.from_bytes(room.raw[made - 4:made], "big")
    assert stored == zlib.adler32(data), (length, hex(stored))
    rounds.append({"length": length, "zlib_adler32_in_stream": hex(stored)})
(out / "round-trips.json").write_text(json.dumps({
    "library_sha256": hashlib.sha256(library.read_bytes()).hexdigest(),
    "object_sha256": hashlib.sha256(OBJECT.read_bytes()).hexdigest(),
    "exported_ode_symbol": adler is not None,
    "cases": rounds}, indent=2) + "\n")
print(f"{len(rounds)} zlib streams round-trip with the checked checksum in place")

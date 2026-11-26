#!/usr/bin/env python3
"""Verify a file against BOTH its pinned SHA-256 and BLAKE3 digests.

Bootstrap-independent (Python stdlib only; no third-party crates or external
`b3sum` required): implements the BLAKE3 specification alongside `hashlib.sha256`
so CI tool downloads enforce the project's two-digest rule (`AGENTS.md`).

Usage:
    python3 tools/verify_digests.py FILE SHA256_HEX BLAKE3_HEX
"""

from __future__ import annotations

import hashlib
import re
import struct
import sys
from pathlib import Path

HEX64 = re.compile(r"^[0-9a-f]{64}$")

_IV = (
    0x6A09E667,
    0xBB67AE85,
    0x3C6EF372,
    0xA54FF53A,
    0x510E527F,
    0x9B05688C,
    0x1F83D9AB,
    0x5BE0CD19,
)
_CHUNK_START = 1 << 0
_CHUNK_END = 1 << 1
_PARENT = 1 << 2
_ROOT = 1 << 3
_MSG_PERM = (2, 6, 3, 10, 7, 0, 4, 13, 1, 11, 12, 5, 9, 14, 15, 8)
_MASK = 0xFFFFFFFF


def _compress(cv: list[int], block_words: list[int], counter: int, block_len: int, flags: int) -> list[int]:
    s0, s1, s2, s3, s4, s5, s6, s7 = cv
    s8, s9, s10, s11 = _IV[0], _IV[1], _IV[2], _IV[3]
    s12 = counter & _MASK
    s13 = (counter >> 32) & _MASK
    s14 = block_len
    s15 = flags
    m = block_words

    for r in range(7):
        # Columns
        s0 = (s0 + s4 + m[0]) & _MASK; s12 ^= s0; s12 = ((s12 >> 16) | (s12 << 16)) & _MASK
        s8 = (s8 + s12) & _MASK; s4 ^= s8; s4 = ((s4 >> 12) | (s4 << 20)) & _MASK
        s0 = (s0 + s4 + m[1]) & _MASK; s12 ^= s0; s12 = ((s12 >> 8) | (s12 << 24)) & _MASK
        s8 = (s8 + s12) & _MASK; s4 ^= s8; s4 = ((s4 >> 7) | (s4 << 25)) & _MASK

        s1 = (s1 + s5 + m[2]) & _MASK; s13 ^= s1; s13 = ((s13 >> 16) | (s13 << 16)) & _MASK
        s9 = (s9 + s13) & _MASK; s5 ^= s9; s5 = ((s5 >> 12) | (s5 << 20)) & _MASK
        s1 = (s1 + s5 + m[3]) & _MASK; s13 ^= s1; s13 = ((s13 >> 8) | (s13 << 24)) & _MASK
        s9 = (s9 + s13) & _MASK; s5 ^= s9; s5 = ((s5 >> 7) | (s5 << 25)) & _MASK

        s2 = (s2 + s6 + m[4]) & _MASK; s14 ^= s2; s14 = ((s14 >> 16) | (s14 << 16)) & _MASK
        s10 = (s10 + s14) & _MASK; s6 ^= s10; s6 = ((s6 >> 12) | (s6 << 20)) & _MASK
        s2 = (s2 + s6 + m[5]) & _MASK; s14 ^= s2; s14 = ((s14 >> 8) | (s14 << 24)) & _MASK
        s10 = (s10 + s14) & _MASK; s6 ^= s10; s6 = ((s6 >> 7) | (s6 << 25)) & _MASK

        s3 = (s3 + s7 + m[6]) & _MASK; s15 ^= s3; s15 = ((s15 >> 16) | (s15 << 16)) & _MASK
        s11 = (s11 + s15) & _MASK; s7 ^= s11; s7 = ((s7 >> 12) | (s7 << 20)) & _MASK
        s3 = (s3 + s7 + m[7]) & _MASK; s15 ^= s3; s15 = ((s15 >> 8) | (s15 << 24)) & _MASK
        s11 = (s11 + s15) & _MASK; s7 ^= s11; s7 = ((s7 >> 7) | (s7 << 25)) & _MASK

        # Diagonals
        s0 = (s0 + s5 + m[8]) & _MASK; s15 ^= s0; s15 = ((s15 >> 16) | (s15 << 16)) & _MASK
        s10 = (s10 + s15) & _MASK; s5 ^= s10; s5 = ((s5 >> 12) | (s5 << 20)) & _MASK
        s0 = (s0 + s5 + m[9]) & _MASK; s15 ^= s0; s15 = ((s15 >> 8) | (s15 << 24)) & _MASK
        s10 = (s10 + s15) & _MASK; s5 ^= s10; s5 = ((s5 >> 7) | (s5 << 25)) & _MASK

        s1 = (s1 + s6 + m[10]) & _MASK; s12 ^= s1; s12 = ((s12 >> 16) | (s12 << 16)) & _MASK
        s11 = (s11 + s12) & _MASK; s6 ^= s11; s6 = ((s6 >> 12) | (s6 << 20)) & _MASK
        s1 = (s1 + s6 + m[11]) & _MASK; s12 ^= s1; s12 = ((s12 >> 8) | (s12 << 24)) & _MASK
        s11 = (s11 + s12) & _MASK; s6 ^= s11; s6 = ((s6 >> 7) | (s6 << 25)) & _MASK

        s2 = (s2 + s7 + m[12]) & _MASK; s13 ^= s2; s13 = ((s13 >> 16) | (s13 << 16)) & _MASK
        s8 = (s8 + s13) & _MASK; s7 ^= s8; s7 = ((s7 >> 12) | (s7 << 20)) & _MASK
        s2 = (s2 + s7 + m[13]) & _MASK; s13 ^= s2; s13 = ((s13 >> 8) | (s13 << 24)) & _MASK
        s8 = (s8 + s13) & _MASK; s7 ^= s8; s7 = ((s7 >> 7) | (s7 << 25)) & _MASK

        s3 = (s3 + s4 + m[14]) & _MASK; s14 ^= s3; s14 = ((s14 >> 16) | (s14 << 16)) & _MASK
        s9 = (s9 + s14) & _MASK; s4 ^= s9; s4 = ((s4 >> 12) | (s4 << 20)) & _MASK
        s3 = (s3 + s4 + m[15]) & _MASK; s14 ^= s3; s14 = ((s14 >> 8) | (s14 << 24)) & _MASK
        s9 = (s9 + s14) & _MASK; s4 ^= s9; s4 = ((s4 >> 7) | (s4 << 25)) & _MASK

        if r != 6:
            m = [m[i] for i in _MSG_PERM]

    return [
        s0 ^ s8,
        s1 ^ s9,
        s2 ^ s10,
        s3 ^ s11,
        s4 ^ s12,
        s5 ^ s13,
        s6 ^ s14,
        s7 ^ s15,
    ]


def blake3_bytes(data: bytes) -> str:
    """Return the 64-char lowercase hex BLAKE3 digest of `data`."""
    unpack16 = struct.Struct("<16I").unpack_from
    pack8 = struct.Struct("<8I").pack
    iv = list(_IV)

    def compress_chunk(chunk: memoryview, chunk_idx: int, root: bool) -> list[int]:
        cv = iv
        n = len(chunk)
        if n == 0:
            flags = _CHUNK_START | _CHUNK_END | (_ROOT if root else 0)
            return _compress(cv, [0] * 16, chunk_idx, 0, flags)
        off = 0
        while off < n:
            end = off + 64
            if end < n:
                words = list(unpack16(chunk, off))
                blen = 64
                flags = _CHUNK_START if off == 0 else 0
            else:
                tail = bytes(chunk[off:n])
                blen = len(tail)
                if blen < 64:
                    tail = tail + b"\x00" * (64 - blen)
                words = list(unpack16(tail, 0))
                flags = (_CHUNK_START if off == 0 else 0) | _CHUNK_END | (_ROOT if root else 0)
            cv = _compress(cv, words, chunk_idx, blen, flags)
            off = end
        return cv

    mv = memoryview(data)
    total = len(mv)
    if total <= 1024:
        return pack8(*compress_chunk(mv, 0, True)).hex()

    stack: list[list[int]] = []
    n_chunks = (total + 1023) // 1024
    for idx in range(n_chunks - 1):
        cv = compress_chunk(mv[idx * 1024 : (idx + 1) * 1024], idx, False)
        total_chunks = idx + 1
        while (total_chunks & 1) == 0:
            left = stack.pop()
            cv = _compress(iv, left + cv, 0, 64, _PARENT)
            total_chunks >>= 1
        stack.append(cv)

    last_idx = n_chunks - 1
    right = compress_chunk(mv[last_idx * 1024 :], last_idx, False)
    while len(stack) > 1:
        left = stack.pop()
        right = _compress(iv, left + right, 0, 64, _PARENT)
    left = stack.pop()
    root_cv = _compress(iv, left + right, 0, 64, _PARENT | _ROOT)
    return pack8(*root_cv).hex()


def file_digests(path: Path) -> tuple[str, str]:
    data = path.read_bytes()
    return hashlib.sha256(data).hexdigest(), blake3_bytes(data)


def validate_hex64(value: str, label: str) -> str:
    value = value.strip().lower()
    if not HEX64.match(value):
        raise ValueError(f"{label} must be 64 lowercase hex characters, got {value!r}")
    return value


def verify_file(path: Path, expected_sha256: str, expected_blake3: str) -> None:
    want_sha = validate_hex64(expected_sha256, "expected SHA-256")
    want_b3 = validate_hex64(expected_blake3, "expected BLAKE3")
    got_sha, got_b3 = file_digests(path)
    errors = []
    if got_sha != want_sha:
        errors.append(f"SHA-256 mismatch for {path}: expected {want_sha}, got {got_sha}")
    if got_b3 != want_b3:
        errors.append(f"BLAKE3 mismatch for {path}: expected {want_b3}, got {got_b3}")
    if errors:
        raise ValueError("; ".join(errors))


def main(argv: list[str] | None = None) -> int:
    args = sys.argv[1:] if argv is None else argv
    if len(args) != 3:
        print("usage: verify_digests.py FILE SHA256_HEX BLAKE3_HEX", file=sys.stderr)
        return 2
    path, want_sha, want_b3 = Path(args[0]), args[1], args[2]
    try:
        verify_file(path, want_sha, want_b3)
    except (OSError, ValueError) as exc:
        print(f"verify_digests: {exc}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

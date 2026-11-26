#!/usr/bin/env python3
"""Unit tests and negative controls for tools/verify_digests.py."""

import tempfile
import unittest
from pathlib import Path

import verify_digests as vd

# Official BLAKE3 test vectors: input of length N is bytes(i % 251 for i in range(N)).
OFFICIAL_BLAKE3_VECTORS = {
    0: "af1349b9f5f9a1a6a0404dea36dcc9499bcb25c9adc112b7cc9a93cae41f3262",
    1: "2d3adedff11b61f14c886e35afa036736dcd87a74d27b5c1510225d0f592e213",
    64: "4eed7141ea4a5cd4b788606bd23f46e212af9cacebacdc7d1f4c6dc7f2511b98",
    1024: "42214739f095a406f3fc83deb889744ac00df831c10daa55189b5d121c855af7",
    1025: "d00278ae47eb27b34faecf67b4fe263f82d5412916c1ffd97c8cb7fb814b8444",
    2048: "e776b6028c7cd22a4d0ba182a8bf62205d2ef576467e838ed6f2529b85fba24a",
    2049: "5f4d72f40d7a5f82b15ca2b2e44b1de3c2ef86c426c95c1af0b6879522563030",
    4096: "015094013f57a5277b59d8475c0501042c0b642e531b0a1c8f58d2163229e969",
    102400: "bc3e3d41a1146b069abffad3c0d44860cf664390afce4d9661f7902e7943e085",
}


class VerifyDigestsTests(unittest.TestCase):
    def test_blake3_matches_official_test_vectors(self):
        for length, expected in OFFICIAL_BLAKE3_VECTORS.items():
            data = bytes(i % 251 for i in range(length))
            self.assertEqual(vd.blake3_bytes(data), expected, f"length={length}")

    def test_verify_file_accepts_matching_pair_and_rejects_either_mismatch(self):
        with tempfile.TemporaryDirectory() as td:
            p = Path(td) / "artifact.bin"
            p.write_bytes(bytes(i % 251 for i in range(2049)))
            good_sha, good_b3 = vd.file_digests(p)
            self.assertEqual(good_b3, OFFICIAL_BLAKE3_VECTORS[2049])

            # Both matching -> succeeds (exit 0).
            self.assertEqual(vd.main([str(p), good_sha, good_b3]), 0)

            # Wrong SHA-256 with right BLAKE3 -> fails (exit 1).
            bad_sha = ("0" if good_sha[0] != "0" else "1") + good_sha[1:]
            self.assertEqual(vd.main([str(p), bad_sha, good_b3]), 1)

            # Right SHA-256 with wrong BLAKE3 -> fails (exit 1).
            bad_b3 = ("0" if good_b3[0] != "0" else "1") + good_b3[1:]
            self.assertEqual(vd.main([str(p), good_sha, bad_b3]), 1)

            # Mutated file -> fails (exit 1).
            p.write_bytes(b"tampered")
            self.assertEqual(vd.main([str(p), good_sha, good_b3]), 1)


if __name__ == "__main__":
    unittest.main()

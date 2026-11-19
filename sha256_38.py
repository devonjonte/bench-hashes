#!/usr/bin/env python3
"""Research only: SHA-256 with the first 38 rounds per block."""

import argparse
import struct

MASK = 0xFFFFFFFF
IV = (
    0x6A09E667, 0xBB67AE85, 0x3C6EF372, 0xA54FF53A,
    0x510E527F, 0x9B05688C, 0x1F83D9AB, 0x5BE0CD19,
)
K = (
    0x428A2F98, 0x71374491, 0xB5C0FBCF, 0xE9B5DBA5,
    0x3956C25B, 0x59F111F1, 0x923F82A4, 0xAB1C5ED5,
    0xD807AA98, 0x12835B01, 0x243185BE, 0x550C7DC3,
    0x72BE5D74, 0x80DEB1FE, 0x9BDC06A7, 0xC19BF174,
    0xE49B69C1, 0xEFBE4786, 0x0FC19DC6, 0x240CA1CC,
    0x2DE92C6F, 0x4A7484AA, 0x5CB0A9DC, 0x76F988DA,
    0x983E5152, 0xA831C66D, 0xB00327C8, 0xBF597FC7,
    0xC6E00BF3, 0xD5A79147, 0x06CA6351, 0x14292967,
    0x27B70A85, 0x2E1B2138, 0x4D2C6DFC, 0x53380D13,
    0x650A7354, 0x766A0ABB,
)


def rotr(x, n):
    return ((x >> n) | (x << (32 - n))) & MASK


def sha256_38(message):
    size = len(message)
    padded = message + b"\x80" + bytes((55 - size) % 64)
    padded += struct.pack(">Q", size * 8)
    state = IV

    for offset in range(0, len(padded), 64):
        w = list(struct.unpack_from(">16I", padded, offset))
        for i in range(16, len(K)):
            x, y = w[i - 15], w[i - 2]
            s0 = rotr(x, 7) ^ rotr(x, 18) ^ (x >> 3)
            s1 = rotr(y, 17) ^ rotr(y, 19) ^ (y >> 10)
            w.append((w[i - 16] + s0 + w[i - 7] + s1) & MASK)

        a, b, c, d, e, f, g, h = state
        for k, word in zip(K, w):
            s1 = rotr(e, 6) ^ rotr(e, 11) ^ rotr(e, 25)
            choose = (e & f) ^ (~e & g)
            t1 = (h + s1 + choose + k + word) & MASK
            s0 = rotr(a, 2) ^ rotr(a, 13) ^ rotr(a, 22)
            majority = (a & b) ^ (a & c) ^ (b & c)
            t2 = (s0 + majority) & MASK
            a, b, c, d, e, f, g, h = (
                (t1 + t2) & MASK, a, b, c, (d + t1) & MASK, e, f, g
            )

        state = tuple(
            (old + new) & MASK
            for old, new in zip(state, (a, b, c, d, e, f, g, h))
        )

    return struct.pack(">8I", *state).hex()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("hex_message", nargs="+", help="message bytes as hex")
    args = parser.parse_args()
    for text in args.hex_message:
        try:
            message = bytes.fromhex(text)
        except ValueError as error:
            parser.error(str(error))
        print(sha256_38(message))

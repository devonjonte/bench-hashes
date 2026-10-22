"""AVX2 full-group induction pilot; run from BLAKE3-x86-counts.
Remainders and other ISAs remain separate obligations.
"""
import sys
sys.path.insert(0, 'tools/verify')
import prove_x86 as p
import induction as ind
import lean_spec as spec
import aarch64 as arm
from prove_hybrid import byte_symbols, same, table_cvs
from aarch64 import Region, Ptr, Unproved
from z3 import Array, BitVecSort, BitVec, BitVecVal, Concat, Select, ZeroExt, Extract, ULT, ULE, UGE, simplify

W, blocks = 8, 1
so = sys.argv[1] if len(sys.argv) > 1 else p.assemble('avx2', False)
key = byte_symbols('key', 32)
g, k = BitVec('len_groups', 64), BitVec('len_k', 64)
data = Array('inputs', BitVecSort(64), BitVecSort(8))

def table_byte(offset):
    if isinstance(offset, int):
        return (Ptr('inputs', offset // 8 * 64 * blocks), offset % 8)
    j = ind.forced(arm._machine[0], arm.as_bv(offset) & 7)
    if j is None:
        raise Unproved('table read byte is unconstrained')
    entry = simplify((arm.as_bv(offset) - j) * (8 * blocks), som=True, bv_sort_ac=True)
    return (Ptr('inputs', entry), j)

regions = {
    'inputs': Region('inputs', g * (W * 64 * blocks), False, lambda o: Select(data, arm.as_bv(o))),
    'table': Region('table', g * (W * 8), False, table_byte),
    'key': Region('key', 32, False, lambda o: key[o]),
    'out': Region('out', g * (32 * W), True, None),
}
for name in ('inputs', 'table'):
    regions[name].symbolic_initial = True
counter = BitVec('counter', 64)
flags, start, end = p.u8('flags'), p.u8('start'), p.u8('end')
args = [Ptr('table', 0), g * W, BitVecVal(blocks, 64), Ptr('key', 0), counter,
        BitVecVal(1, 64), ZeroExt(56, flags), ZeroExt(56, start), ZeroExt(56, end), Ptr('out', 0)]
s = p.Setup(so, 'blake3_hash_many_avx2', regions, args, False)
m = s.m
m.lengths = {'len_groups', 'len_k', 'counter'}
bound = ((1 << 64) - 1) // (W * 64 * blocks)
m.assumptions = [UGE(g, 2), ULE(g, bound)]
head = 0x14a3

def check_group(machine, group):
    group = arm.as_bv(group)
    inputs = [[Select(data, simplify((group * W + lane) * (64 * blocks) + j, som=True, bv_sort_ac=True))
               for j in range(64 * blocks)] for lane in range(W)]
    cvs = table_cvs(inputs, key, [counter + group * W + lane for lane in range(W)],
                    flags, start, end, BitVecVal(64, 8), blocks)
    out = machine.regions['out']
    expected = set()
    for lane in range(W):
        offsets = [arm.key(group * (32 * W) + 32 * lane + j) for j in range(32)]
        expected.update(offsets)
        if any(o not in out.bytes for o in offsets):
            raise Unproved(f'lane {lane} output incomplete')
        got = spec.words([out.bytes[o] for o in offsets])
        for word in range(8):
            if not same(got[word], cvs[lane][word]):
                raise Unproved(f'lane {lane}, word {word}, differs')
    # The abstract previous output is forgotten between iterations, so
    # require this iteration to write precisely its own group.
    actual = {o for o, value in out.bytes.items() if value is not None}
    if actual != expected:
        raise Unproved('iteration writes outside its output group')

s0 = ind.run_to(m, s.entry, head)
s1 = ind.run_to(ind.snapshot(s0), head, head)
check_group(s1, 0)
print('base group correct over independent array bytes', flush=True)
gen = ind.Generalized(s0, s1, k)
slot = s0.x['rsp'].offset + 0x240
for half in range(2):
    lanes = [Extract(32 * half + 31, 32 * half, counter + W * k + lane) for lane in range(W)]
    for pair in range(W // 2):
        word = Concat(lanes[2 * pair + 1], lanes[2 * pair])
        for j in range(8):
            gen.mem['stack'][slot + half * (4 * W) + 8 * pair + j] = ('word', word, j)
base_bad = ind.mismatches(s0, gen, BitVecVal(0, 64))
if base_bad:
    raise Unproved(f'explicit invariant differs at entry: {base_bad}')
print('explicit counter invariant holds at entry', flush=True)

def check(machine, how):
    check_group(machine, k)
    if how == 'return':
        if not arm.holds(machine, g == k + 1):
            raise Unproved('returns before the last group')
        p.check_abi(machine, False)

kinds = ind.loop_step(gen, s0, k, list(s0.assumptions) + [ULT(k, g), ULE(k, bound - 1)], head, check)
print('proved full-group induction:', kinds, flush=True)

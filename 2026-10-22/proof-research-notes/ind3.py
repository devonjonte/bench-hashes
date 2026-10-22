import sys
sys.path.insert(0,'tools/verify')
import prove_x86, induction, lean_spec as spec, aarch64
from prove_hybrid import byte_symbols, same, table_cvs
from aarch64 import Region, Ptr, Unproved
from z3 import BitVec, BitVecVal, ZeroExt, Extract, LShR, ULT, ULE, UGE, simplify
so = prove_x86.assemble('avx2', False)
W, blocks = 8, 1
words = [BitVec(f"inw{w}", 32) for w in range(W * 16)]
key = byte_symbols("key", 32)
g, k = BitVec("len_groups", 64), BitVec("len_k", 64)
def in_byte(offset):
    if isinstance(offset, int):
        grp, within = offset // (W * 64), offset % (W * 64)
        w = words[within // 4] + grp
        return Extract(8 * (within % 4) + 7, 8 * (within % 4), w)
    mach = aarch64._machine[0]
    within = induction.forced(mach, aarch64.as_bv(offset) & (W * 64 - 1))
    if within is None:
        raise Unproved("a read of inputs whose place in its group the lengths leave open")
    first = simplify(aarch64.as_bv(offset) - within, som=True, bv_sort_ac=True)
    grp = simplify(Extract(31, 0, LShR(first, 9)), som=True, bv_sort_ac=True)
    w = simplify(words[within // 4] + grp, som=True, bv_sort_ac=True)
    return Extract(8 * (within % 4) + 7, 8 * (within % 4), w)
def table_byte(offset):
    if isinstance(offset, int):
        return (Ptr("inputs", (offset // 8) * 64 * blocks), offset % 8)
    mach = aarch64._machine[0]
    j = induction.forced(mach, aarch64.as_bv(offset) & 7)
    if j is None:
        raise Unproved("a table read whose byte the lengths leave open")
    entry = simplify(LShR(aarch64.as_bv(offset) - j, 3) * (64 * blocks), som=True, bv_sort_ac=True)
    return (Ptr("inputs", entry), j)
regions = {"inputs": Region("inputs", g * (W * 64 * blocks), False, in_byte),
           "table": Region("table", g * (W * 8), False, table_byte),
           "key": Region("key", 32, False, lambda o: key[o]),
           "out": Region("out", g * (32 * W), True, None)}
regions["inputs"].symbolic_initial = True
regions["table"].symbolic_initial = True
counter = BitVec("counter", 64)
flags, start, end = prove_x86.u8("flags"), prove_x86.u8("start"), prove_x86.u8("end")
args = [Ptr("table", 0), g * W, BitVecVal(blocks, 64), Ptr("key", 0), counter,
        BitVecVal(1, 64), ZeroExt(56, flags), ZeroExt(56, start), ZeroExt(56, end), Ptr("out", 0)]
s = prove_x86.Setup(so, "blake3_hash_many_avx2", regions, args, False)
m = s.m
m.lengths = {"len_groups", "len_k", "counter"}
m.assumptions = [UGE(g, 2), ULE(g, 1 << 39)]
head = 0x14a3
def group_inputs(kval):
    grp = BitVecVal(kval, 32) if isinstance(kval, int) else Extract(31, 0, kval)
    out = []
    for lane in range(W):
        bs = []
        for j in range(64):
            w = simplify(words[lane * 16 + j // 4] + grp, som=True, bv_sort_ac=True)
            bs.append(Extract(8 * (j % 4) + 7, 8 * (j % 4), w))
        out.append(bs)
    return out
def check_group(mach, kval):
    out = mach.regions["out"]
    base = BitVecVal(kval * 32 * W, 64) if isinstance(kval, int) else aarch64.as_bv(kval * (32 * W))
    cvs = table_cvs(group_inputs(kval), key, [counter + kval * W + lane for lane in range(W)], flags, start, end, BitVecVal(64, 8), blocks)
    keys = set()
    for lane in range(W):
        offs = [aarch64.key(base + 32 * lane + j) for j in range(32)]
        keys.update(offs)
        if any(o not in out.bytes for o in offs):
            raise Unproved(f"group output {lane} is not wholly written")
        got = spec.words([out.bytes[o] for o in offs])
        for w in range(8):
            if not same(got[w], cvs[lane][w]):
                raise Unproved(f"group output {lane}, word {w}, differs")
    return keys
s0 = induction.run_to(m, s.entry, head)
print('at head, out bytes:', len(s0.regions["out"].bytes), flush=True)
s1 = induction.run_to(induction.snapshot(s0), head, head)
print('one pass done', flush=True)
check_group(s1, 0)
print('group 0 right', flush=True)
gen = induction.Generalized(s0, s1, k)
def check(endm, how):
    keys = check_group(endm, k)
    if how == "return":
        if not aarch64.holds(endm, g == k + 1):
            raise Unproved("a path leaves the pass loop before the last group")
        prove_x86.check_abi(endm, False)
kinds = induction.loop_step(gen, s0, k, list(s0.assumptions) + [ULT(k, g), ULE(k, 1 << 39)], head, check)
print(f"{kinds['head']} paths back to the head, {kinds['return']} out of it")

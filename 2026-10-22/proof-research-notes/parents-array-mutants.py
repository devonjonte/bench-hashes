"""Two wrong group strides, using the existing executor and worker harness."""
import sys
sys.path.insert(0, 'tools/verify')
import aarch64
import prove_sme2 as p
import workers
from unittest.mock import patch


def run(case):
    label, reg, before, after, obj = case
    symbols = aarch64.symbols(obj)
    start = symbols['blake3_sme2_hash16_parents_512']
    end = min(pc for pc in symbols.values() if pc > start)
    code = {pc: (mnem, list(ops)) for pc, (mnem, ops) in aarch64.disassemble(obj, start, end, llvm=True).items()}
    found = [pc for pc, (mnem, ops) in code.items() if start <= pc < end and mnem == 'add'
             and ops[:2] == [reg, reg] and int(ops[2].lstrip('#'), 0) == before]
    assert len(found) == 1, (label, found)
    code[found[0]][1][2] = f'#{after}'
    with patch.object(aarch64, 'disassemble', return_value=code):
        try:
            p.prove_parents_every(obj)
        except aarch64.Unproved as e:
            return label, True, str(e)
    return label, False, 'wrong kernel proved'


if __name__ == '__main__':
    cases = [('input stride', 'x9', 1024, 512, sys.argv[1]),
             ('output stride', 'x4', 512, 256, sys.argv[1])]
    bad = 0
    for label, rejected, why in workers.each(run, cases, 2):
        print('REJECTED' if rejected else 'ACCEPTED', label, why, flush=True)
        bad += not rejected
    sys.exit(bool(bad))

"""Bound externally; use existing workers.each with two fresh processes."""
import ast
import sys
sys.path.insert(0, 'tools/verify')
import prove_x86 as p
import prove_x86_loop as loop
import workers
from aarch64 import Unproved


def run(case):
    import faulthandler
    faulthandler.dump_traceback_later(120, repeat=True)
    isa, windows, blocks, increment = case
    print('START', repr(case), flush=True)
    try:
        kinds = loop.prove(p.assemble(isa, windows), isa, windows, blocks, increment)
    except Unproved as e:
        return case, False, str(e)
    return case, True, repr(kinds)


if __name__ == '__main__':
    cases = ast.literal_eval(sys.argv[1])
    failures = 0
    for case, passed, details in workers.each(run, cases, 2):
        print('PROVED' if passed else 'NOT PROVED', repr(case), details, flush=True)
        failures += not passed
    print(len(cases) - failures, 'of', len(cases), 'all-count cases proved', flush=True)
    sys.exit(bool(failures))

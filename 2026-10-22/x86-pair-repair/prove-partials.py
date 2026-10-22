import sys
import multiprocessing
from pathlib import Path
sys.path.insert(0, str(Path.cwd() / 'tools/verify'))
import prove_x86 as p

if __name__ == '__main__':
    isa = sys.argv[1]
    lo, hi = map(int, sys.argv[2:4])
    cases = [c for c in p.cases({'partial'}) if c[2] == 'partial' and c[3][0] == isa and lo <= c[3][1] < hi]
    failures = 0
    with multiprocessing.Pool(2, maxtasksperchild=1) as pool:
        for case, verdict in pool.imap_unordered(p.prove_case, cases):
            print(repr(case), verdict, flush=True)
            failures += verdict.startswith('NOT')
    print(f'{len(cases) - failures}/{len(cases)} proved', flush=True)
    sys.exit(bool(failures))

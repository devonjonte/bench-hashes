"""Resume only unfinished proof cases after the bounded first batch."""
import ast
import sys
sys.path.insert(0, 'tools/verify')
import prove_x86 as p
import workers
from pathlib import Path

if __name__ == '__main__':
    expected = [c for c in p.cases(set()) if c[0] == 'avx512']
    expected += [('avx512', w, 'hash_many', (16, 16, False)) for w in (False, True)]
    done = set()
    for line in Path(sys.argv[1]).read_text().splitlines():
        if line.startswith("('avx512',"):
            assert ' proved ' in line, line
            done.add(ast.literal_eval(line.split(' proved ')[0]))
    assert done <= set(expected)
    todo = [c for c in expected if c not in done]
    print('RESUME', len(done), 'completed;', len(todo), 'remaining of', len(expected), flush=True)
    failed = 0
    for case, verdict in workers.each(p.prove_case, todo, 2):
        print(case, verdict, flush=True)
        failed += not verdict.startswith('proved')
    print('RESULT', len(todo)-failed, 'of', len(todo), 'remaining cases proved', flush=True)
    sys.exit(bool(failed))

"""Isolated assembled mutants of the all-count AVX2 proof; bound externally."""
from pathlib import Path
import subprocess
import sys
import types
sys.path.insert(0, 'tools/verify')
import prove_x86 as p
import prove_x86_loop as loop
import workers
from aarch64 import Unproved

ROOT = Path('/home/agent/bench-hashes-validation/x86-kernels-20261022/count-mutants')
SOURCE = Path('c/blake3_avx2_x86-64_unix.S').read_text()
MUTANTS = {
    'input-stride': ('        add     rdi, 64\n', '        add     rdi, 56\n'),
    'output-stride': ('        add     rbx, 256\n', '        add     rbx, 224\n'),
    'counter-direction': ('        vpaddd  ymm1, ymm0, ymmword ptr [rsp+0x240]\n',
                          '        vpsubd  ymm1, ymm0, ymmword ptr [rsp+0x240]\n'),
    'tail-output-stride': ('        add     rbx, 128\n', '        add     rbx, 96\n'),
    'nonterminating': ('        sub     rsi, 8\n', '        add     rsi, 8\n        sub     rsi, 8\n'),
    'input-overread': ('        vpbroadcastd ymm7, dword ptr [rcx+0x1C]\n        mov     r8, qword ptr [rdi]\n',
                       '        vpbroadcastd ymm7, dword ptr [rcx+0x1C]\n        mov     r8, qword ptr [rdi]\n        vmovdqu xmm15, xmmword ptr [r8+64]\n'),
}


def run(name):
    old, new = MUTANTS[name]
    assert SOURCE.count(old) == 1, (name, SOURCE.count(old))
    directory = ROOT / name
    directory.mkdir(parents=True, exist_ok=True)
    src, obj = directory/'mutant.S', directory/'mutant.o'
    src.write_text(SOURCE.replace(old, new))
    subprocess.run([p.CLANG, '-c', '--target=x86_64-linux-gnu', str(src), '-o', str(obj)], check=True)
    so = p.x86.link(str(obj))
    print('START MUTANT', name, flush=True)
    try:
        result = loop.prove(so, 'avx2', False, 1, True)
    except Unproved as e:
        print('REJECTED', name, str(e), flush=True)
    else:
        return name, False, 'accepted: ' + repr(result)
    if name == 'nonterminating':
        # The prior shared walker checked state equality without requiring
        # its induction domain to hold for the successor.
        previous = subprocess.check_output(['git', 'show', 'fbde8a2:tools/verify/induction.py'], text=True)
        prior = types.ModuleType('prior_induction')
        exec(compile(previous, 'prior_induction.py', 'exec'), prior.__dict__)
        current = loop.ind
        loop.ind = prior
        try:
            result = loop.prove(so, 'avx2', False, 1, True)
            assert result == {'head': 1, 'return': 0}, result
            print('PRIOR WALKER ACCEPTED NONTERMINATING MUTANT', result, flush=True)
        finally:
            loop.ind = current
    return name, True, 'rejected'


if __name__ == '__main__':
    failed = 0
    for name, caught, detail in workers.each(run, list(MUTANTS), 2):
        print('RESULT', name, caught, detail, flush=True)
        failed += not caught
    sys.exit(bool(failed))

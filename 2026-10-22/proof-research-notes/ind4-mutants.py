"""Reject isolated assembly mutants; leave the repository's source intact."""
from pathlib import Path
import os
import subprocess
import sys
sys.path.insert(0, 'tools/verify')
import x86

root = Path(__file__).resolve().parent
src = Path('c/blake3_avx2_x86-64_unix.S').read_text()
mutants = {
    'input-pointer': ('        add     rdi, 64\n', '        add     rdi, 72\n'),
    'output-pointer': ('        add     rbx, 256\n', '        add     rbx, 288\n'),
    'counter-direction': ('        vpaddd  ymm1, ymm0, ymmword ptr [rsp+0x240]\n',
                          '        vpsubd  ymm1, ymm0, ymmword ptr [rsp+0x240]\n'),
}
for name, (old, new) in mutants.items():
    assert src.count(old) == 1, name
    assembly = root / f'ind4-mutant-{name}.S'
    obj = root / f'ind4-mutant-{name}.o'
    assembly.write_text(src.replace(old, new))
    subprocess.run([x86.tool('clang'), '-c', '--target=x86_64-linux-gnu', str(assembly), '-o', str(obj)], check=True)
    so = x86.link(str(obj))
    print('Checking', name, flush=True)
    command = [sys.executable, '-u', str(root / 'ind4.py'), so]
    with (root / f'ind4-mutant-{name}.log').open('w') as log:
        result = subprocess.run(command, stdout=log, stderr=subprocess.STDOUT, timeout=150)
    text = (root / f'ind4-mutant-{name}.log').read_text()
    if result.returncode != 1 or 'aarch64.Unproved:' not in text:
        raise RuntimeError(f'{name}: expected a proof rejection, got {result.returncode}: {text[-1000:]}')
    print(name, 'rejected:', text.splitlines()[-1], flush=True)

#!/bin/sh
# Read the existing last common-scope comparison binaries under the lock.
# No timing or rebuild: preserve symbol sizes and selected disassembly.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/incremental-callers-2c867684"
export O
if [ "${BOUNDED_CALLER_INSPECT:-}" != yes ]; then
    export BOUNDED_CALLER_INSPECT=yes
    status=0
    timeout --kill-after=10s 120s sh "$O/run.sh" || status=$?
    printf 'INSPECT_EXIT=%s\n' "$status"
    exit "$status"
fi
CACHE="$HOME/work/BLAKE3/target/check"
export CACHE
python3 - <<'PY'
import os, pathlib, subprocess, re
out=pathlib.Path(os.environ['O']); cache=pathlib.Path(os.environ['CACHE'])
for side, seed, bench in [('old',0,'8d9eb92ada88'),('new',4,'2c8676842fea')]:
    exe=cache/side/f'bench-hashes-{seed}'
    provenance=subprocess.check_output([str(exe),'provenance'],text=True).strip()
    assert provenance == f'bench {bench} clean; servil f62bc6ac0bc1 clean', provenance
    (out/f'{side}.provenance.txt').write_text(provenance+'\n')
    nm=subprocess.check_output(['nm','-S','-C','--size-sort',str(exe)],text=True)
    wanted=lambda s: any(x in s for x in ['bench_hashes::pipeline','bench_hashes::timed_cell','bench_hashes::Duo','blake3_servil::pipeline'])
    (out/f'{side}.symbols.txt').write_text('\n'.join(l for l in nm.splitlines() if wanted(l))+'\n')
    p=subprocess.Popen(['objdump','-d','-C',str(exe)],text=True,stdout=subprocess.PIPE)
    keep=False
    with (out/f'{side}.asm.txt').open('w') as f:
        for line in p.stdout:
            m=re.match(r'^[0-9a-f]+ <(.+)>:',line)
            if m: keep=wanted(m.group(1))
            if keep: f.write(line)
    assert p.wait()==0
PY

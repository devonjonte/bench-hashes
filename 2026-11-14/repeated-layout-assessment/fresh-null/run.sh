#!/bin/sh
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/repeat-null-2c867684"
export O
if [ "${BOUNDED_REPEAT:-}" != yes ]; then
    export BOUNDED_REPEAT=yes
    status=0
    timeout --kill-after=15s 2700s sh "$O/run.sh" || status=$?
    printf 'REPEAT_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
    exit "$status"
fi
B="$HOME/work/bench-incremental-pilot"
M="$HOME/work/BLAKE3"
C=2c8676842feab053fa7855d4cb3393bdea26ed4a
OLD=f62bc6ac0bc1c86861659d61ffbf4e9546bc8aec
NEW=f62bc6ac0bc1c86861659d61ffbf4e9546bc8aec
P='64 B,4 KiB,16 KiB,32 KiB,lent 64 B,lent 1 KiB,lent incremental 64 B,lent incremental 1 KiB'
export B M C OLD NEW P
test "$(git -C "$B" rev-parse HEAD)" = "$C"
test -z "$(git -C "$B" status --porcelain)"
cd "$B"
printf 'START %s\n' "$(date -u +%FT%TZ)"
./target/release/bench-hashes check --fork "$M" --against "$OLD" --new "$NEW" \
    --old-bench "$C" --contenders blake3-servil-st --probe "$P" --layouts 16 --when-quiet \
    --keep "$O/kept-survey" > "$O/survey.stdout.txt" 2> "$O/survey.stderr.txt"
python3 - <<'PY'
import os, pathlib, subprocess, json
out=pathlib.Path(os.environ['O']); cache=pathlib.Path(os.environ['M'])/'target/check'
old=[cache/'old'/f'bench-hashes-{i}' for i in range(16)]
new=[cache/'new'/f'bench-hashes-{i}' for i in range(16,32)]
manifest=[]
for side, exes, revision in [('old',old,os.environ['OLD']),('new',new,os.environ['NEW'])]:
 for exe in exes:
  p=subprocess.check_output([str(exe),'provenance'],text=True).strip()
  assert p==f"bench {os.environ['C'][:12]} clean; servil {revision[:12]} clean",p
  manifest.append(dict(side=side,file=exe.name,provenance=p))
(out/'layouts.json').write_text(json.dumps(manifest,indent=2)+'\n')
cmd=[os.environ['B']+'/target/release/bench-hashes','regress','--pairs','64','--contenders','blake3-servil-st','--points',os.environ['P'],'--keep',str(out/'kept-repeats'),*[str(p) for p in old],'--',*[str(p) for p in new]]
with (out/'quiet-before-repeats.txt').open('w') as quiet:
 subprocess.run([os.environ['B']+'/target/release/bench-hashes','quiet','--wait'],stdout=quiet,stderr=quiet,check=True)
with (out/'repeats.stdout.txt').open('w') as stdout,(out/'repeats.stderr.txt').open('w') as stderr:
 r=subprocess.run(cmd,stdout=stdout,stderr=stderr)
print(f'REGRESS_EXIT={r.returncode}',flush=True)
raise SystemExit(r.returncode)
PY
printf 'DONE %s\n' "$(date -u +%FT%TZ)"

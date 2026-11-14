#!/bin/sh
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/ring-assertions-8a6c53a7-v2"
export O
if [ "${BOUNDED_RING_PILOT:-}" != yes ]; then
  export BOUNDED_RING_PILOT=yes
  status=0
  timeout --kill-after=15s 1800s sh "$O/run.sh" || status=$?
  printf 'RING_PILOT_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
B="$HOME/work/lib-devon-ring-assertions-8a6c53a7"
BASE=0de3ffa4e34984d4eeb6eb23dd46b8514d474a9e
C=8a6c53a790b5a093eccb9e709047f66ddd9b72af
export B BASE C CARGO_BUILD_JOBS=4
export TMPDIR="$HOME/work/ring-assertions-8a6c53a7-scratch"
test -d "$TMPDIR"
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
test "$(git -C "$B" rev-parse HEAD)" = "$BASE"
test -z "$(git -C "$B" status --porcelain)"
cd "$B"
{ rustc -Vv; cargo nextest --version; cargo mutants --version; } > "$O/toolchain.txt"
python3 - <<'PY'
import os,subprocess
old,new=[subprocess.check_output(['git','show',os.environ[k]+':threads/src/pipeline.rs'],text=True) for k in ['BASE','C']]
marker='#[cfg(test)]\nmod test {'
assert marker in old and marker in new
assert old.split(marker)[0]==new.split(marker)[0]
print('Production prefix before the test module stays byte-identical')
PY
cat > "$O/pilot.py" <<'PY'
import importlib.util,json,os,pathlib,shutil,subprocess,sys
root=pathlib.Path.cwd();out=pathlib.Path(os.environ['O']);arm=os.environ['ARM']
sys.path.insert(0,str(root/'tools/mutants'))
sys.argv=['check.py','--crate','threads']
spec=importlib.util.spec_from_file_location('mutation_check',root/'tools/mutants/check.py')
m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
pattern=r'replace (\+= with -= in Ring<X>::push_back|-= with (\+=|/=) in Ring<X>::pop_front)$'
selected=json.loads(subprocess.check_output(['cargo','mutants',*m.BUILD,'--file','src/pipeline.rs','--re',pattern,'--list','--json'],cwd=m.CRATE_DIR,text=True))
assert len(selected)==3, len(selected)
(out/(arm+'-selected.json')).write_text(json.dumps(selected,indent=2)+'\n')
missed,functions,timed=m.run(['src/pipeline.rs'],extra=['--re',pattern],shards=1,label='ring-'+arm)
summary={'source':subprocess.check_output(['git','rev-parse','HEAD'],text=True).strip(),'missed':dict(missed),'timed':dict(timed),'functions':[{'file':f,'function':n,'outcomes':v} for (f,n),v in functions.items()]}
(out/(arm+'-summary.json')).write_text(json.dumps(summary,indent=2)+'\n')
shutil.copytree(pathlib.Path(m.last())/('ring-'+arm),out/(arm+'-outcomes'))
for name in ['Cargo.lock','threads/Cargo.lock']:
 p=root/name
 if p.exists():shutil.copyfile(p,out/(arm+'-'+name.replace('/','-')))
print(json.dumps(summary,indent=2))
PY
for ARM in before after; do
 export ARM
 case "$ARM" in before) rev=$BASE;; after) rev=$C;; esac
 git checkout --detach "$rev"
 test -z "$(git status --porcelain)"
 printf 'ARM %s START %s\n' "$ARM" "$(date -u +%FT%TZ)"
 python3 "$O/pilot.py" > "$O/$ARM.stdout.txt" 2> "$O/$ARM.stderr.txt"
 printf 'ARM %s DONE %s\n' "$ARM" "$(date -u +%FT%TZ)"
done
printf 'DONE: existing mutation runner, three selected variants per arm; no policy or list change\n'

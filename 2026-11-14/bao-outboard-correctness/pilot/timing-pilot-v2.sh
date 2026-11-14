#!/bin/sh
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/bao-outboard-pilot-e92716a6-v2"
export O
if [ "${BOUNDED_BAO_PILOT:-}" != yes ]; then
  export BOUNDED_BAO_PILOT=yes
  status=0
  timeout --kill-after=15s 5400s sh "$O/run.sh" || status=$?
  printf 'BAO_PILOT_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0 LAYOUTS=4
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
B="$HOME/work/bench-devon-bao-pilot-e92716a6"
M="$HOME/work/lib-devon-bao-pilot-ed4be078"
C=e92716a60fc67b8a1f47abdac6b97e9980d205bc
LIB=ed4be078701083c6df85e0642982dc57d22e5923
export B M C LIB BAO_REFERENCE_SOURCE="$C"
test "$(git -C "$B" rev-parse HEAD)" = "$C"
test "$(git -C "$M" rev-parse HEAD)" = "$LIB"
test -z "$(git -C "$B" status --porcelain)"
test -z "$(git -C "$M" status --porcelain)"
cd "$B"
{ rustc -Vv; cc --version; printf 'bench %s\nreference-source %s\nservil %s\nLAYOUTS %s\n' "$C" "$C" "$LIB" "$LAYOUTS"; } > "$O/toolchain.txt"
cargo build --release --locked > "$O/bench-build.txt" 2>&1
cargo build --release --locked --manifest-path tools/bao-reference/Cargo.toml > "$O/reference-build.txt" 2>&1
BINS="$O/contender-builds"
mkdir "$BINS"
# The first attempt stopped on its own wrong count (16 for 20 lines) before
# measuring; the same declared design runs here with the count corrected.
python3 tools/b3sum-contenders.py "$M" "$BINS" > "$O/servil-contenders.txt" 2> "$O/servil-contenders.log"
python3 - <<'PY' > "$O/contenders.txt"
import importlib.util,os,pathlib,shutil,subprocess,sys
root=pathlib.Path(os.environ['B']);bins=pathlib.Path(os.environ['O'])/'contender-builds'
spec=importlib.util.spec_from_file_location('contender_builds',root/'tools/b3sum-contenders.py')
module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
host=next(l.split(': ',1)[1] for l in module.out('rustc','-vV').splitlines() if l.startswith('host: '))
static='-C target-feature=+crt-static' if host.endswith('-linux-gnu') else ''
target=str(root/'target/b3sum-contenders')
built=bins/'bao-reference'
shutil.copy(root/'tools/bao-reference/target/release/bao-reference',built)
# The reference crate relinks like the b3sum contenders, through the shared relinker.
os.environ.setdefault('RUSTFLAGS','')
reference=module.relink('bao',str(root/'tools/bao-reference/Cargo.toml'),str(built),static,target=target,host=host,layouts=int(os.environ['LAYOUTS']),binary='bao-reference')
servil=[line for line in (pathlib.Path(os.environ['O'])/'servil-contenders.txt').read_text().splitlines() if line.startswith(('b3sum=','b3sum-1-thread='))]
assert len(servil)==2*int(os.environ['LAYOUTS']),servil
lines=[line+' --outboard {OUT}' for line in reference]
for line in servil:
 name,command=line.split('=',1)
 base={'b3sum':'servil','b3sum-1-thread':'servil-1'}[name]
 lines.append(f'{base}-outboard={command} --outboard {{OUT}}')
 lines.append(f'{base}-hash={command}')
print('\n'.join(lines))
PY
cat "$O/contenders.txt" >&2
RUNS="$HOME/work/bao-pilot-scratch-e92716a6-v2"
mkdir "$RUNS"
cd "$RUNS"
set --
while IFS= read -r line; do set -- "$@" "$line"; done < "$O/contenders.txt"
test "$#" -eq 20
"$B/target/release/bench-hashes" b3sum --rounds 5 --files "$HOME/b3sum-bench-files" "$@" > "$O/b3sum.stdout.txt" 2> "$O/b3sum.stderr.txt"
cp -r benchmark-results "$O/benchmark-results"
printf 'DONE: warm cells are the pilot scope; cold cells retained as collected\n'

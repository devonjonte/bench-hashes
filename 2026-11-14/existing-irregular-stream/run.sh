#!/bin/sh
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/existing-stream-ab256b0d"
export O
if [ "${BOUNDED_EXISTING_STREAM:-}" != yes ]; then
  export BOUNDED_EXISTING_STREAM=yes
  status=0
  timeout --kill-after=15s 1800s sh "$O/run.sh" || status=$?
  printf 'PROBE_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=2 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS CARGO_PROFILE_RELEASE_LTO CARGO_PROFILE_RELEASE_CODEGEN_UNITS CARGO_PROFILE_RELEASE_DEBUG
C=da6fe3c478e3e25c23ab05514a1723e1e20f5e2f
OLD=8041bd858586abafa0857fb4ec5ed1f0767f67a4
NEW=ab256b0d9ebb44eececd71ce0ae37113e75634a5
B="$HOME/work/bench-devon-existing-stream-da6fe3c4"
M="$HOME/work/lib-devon-existing-stream-ab256b0d"
export C OLD NEW B M
git clone --filter=blob:none --no-checkout https://github.com/servil-software-factory/bench-hashes "$B"
git -C "$B" checkout --detach "$C"
git clone --filter=blob:none --no-checkout https://github.com/servil-software-factory/BLAKE3 "$M"
git -C "$M" checkout --detach "$NEW"
test -z "$(git -C "$B" status --porcelain)"
test -z "$(git -C "$M" status --porcelain)"
cd "$B"
{ printf 'bench %s\nold %s\nnew %s\n' "$C" "$OLD" "$NEW"; rustc -Vv; cc --version; } > "$O/toolchain.txt"
git -C "$M" diff --stat "$OLD" "$NEW" > "$O/library-change.txt"
python3 - <<'PY'
import json,os,pathlib
p=pathlib.Path('/proc/sys/kernel/numa_balancing')
(pathlib.Path(os.environ['O'])/'environment.json').write_text(json.dumps({'numa_balancing':p.read_text().strip(),'allowed_cpus':sorted(os.sched_getaffinity(0))},indent=2)+'\n')
PY
cargo build --release --locked > "$O/build.txt" 2>&1
P='continuous 16 MiB,receive saturated'
for arm in unchanged changed; do
  case "$arm" in unchanged) against=$NEW;; changed) against=$OLD;; esac
  printf 'ARM %s START %s\n' "$arm" "$(date -u +%FT%TZ)"
  # The explicit identical old-bench makes the unchanged-code control run.
  # Both arms then use the same setup path and declared workload context.
  ./target/release/bench-hashes check --fork "$M" --against "$against" --new "$NEW" \
      --old-bench "$C" --probe "$P" --contenders blake3-servil-st --layouts 3 \
      --when-quiet --keep "$O/kept-$arm" > "$O/$arm.stdout.txt" 2> "$O/$arm.stderr.txt"
  python3 - "$O/kept-$arm" <<'PY'
from pathlib import Path
import sys
p=Path(sys.argv[1]);files=sorted(p.glob('run-*.tsv'))
assert len(files)==6,(p,len(files))
print('Accepted files:',len(files))
PY
  printf 'ARM %s DONE %s\n' "$arm" "$(date -u +%FT%TZ)"
done
printf 'DONE: existing workloads only; no source or statistical-rule change\n'

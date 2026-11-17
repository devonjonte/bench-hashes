#!/bin/sh
# Diagnostic replay, declared November 17, 2026.
# Cross eight cached executables with CPUs 0 and 24, twice each; retain the
# original five-point/two-contender context and exact second-stage sizes.
# This separates CPU/socket and executable identity before PMU attribution.
# Cache identity was not hashed in the original check: these snapshots name
# this replay's binaries, with provenance checked against that check's sources.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
if [ "${ISSUE3_FIXED_BOUNDED:-}" != yes ]; then
  export ISSUE3_FIXED_BOUNDED=yes
  status=0
  timeout --kill-after=15s 1200s sh "$O/run.sh" || status=$?
  printf 'FIXED_CONTEXT_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
CACHE="$HOME/work/lib-release-023/target/check"
SNAP="$HOME/work/$(basename "$O")-executables"
export O SNAP
mkdir "$SNAP"
mkdir -p "$O/kept" "$O/identities"
command -v b3sum > /dev/null
for side in old new; do
  if [ "$side" = old ]; then seeds='8 9 10 11'; bench=d7723f110a6f; else seeds='24 25 26 27'; bench=483230437ac0; fi
  for seed in $seeds; do
    name="$side-$seed"
    cp "$CACHE/$side/bench-hashes-$seed" "$SNAP/$name"
    "$SNAP/$name" provenance > "$O/identities/$name.provenance.txt"
    grep -q "$bench" "$O/identities/$name.provenance.txt"
    grep -q '27eacce3a5c2' "$O/identities/$name.provenance.txt"
    (cd "$SNAP" && sha256sum "$name") >> "$O/identities/executables.SHA256SUMS"
    (cd "$SNAP" && b3sum "$name") >> "$O/identities/executables.BLAKE3SUMS"
    readelf -n "$SNAP/$name" > "$O/identities/$name.notes.txt"
    nm -n "$SNAP/$name" > "$O/identities/$name.symbols.txt"
  done
done
lscpu -e=CPU,CORE,SOCKET,NODE,ONLINE > "$O/topology.txt"
numactl --hardware > "$O/numa.txt" 2>&1 || true
uname -a > "$O/kernel.txt"
cat > "$O/sizes.tsv" <<'SIZES'
# bench-hashes sizes v1
## Source: issue3-icache2-avx2 kept/second/sizes.tsv; original measured calibration.
blake3-servil-mt	64 B	6
blake3-servil-mt	128 B	3
blake3-servil-mt	idle 64 B	6
blake3-servil-mt	idle 128 B	5
blake3-servil-mt	idle 256 B	3
blake3-servil-st	64 B	4
blake3-servil-st	128 B	3
blake3-servil-st	idle 64 B	7
blake3-servil-st	idle 128 B	5
blake3-servil-st	idle 256 B	3
SIZES
# Same load rule as regress; the host's bench-turn lock serializes this job.
timeout 90 "$SNAP/new-24" quiet --wait > "$O/quiet.txt" 2>&1
python3 - <<'PY'
import os, pathlib, shutil, subprocess
out = pathlib.Path(os.environ['O'])
snap = pathlib.Path(os.environ['SNAP'])
# Counterbalance CPU blocks, layouts, and the sides' order. Each combination
# occurs twice. This is a diagnostic, not a new statistical acceptance rule.
schedule = []
for repeat in range(2):
    for cpu in ([0,24] if repeat == 0 else [24,0]):
        layouts = range(4) if cpu == 0 else range(3,-1,-1)
        for layout in layouts:
            pair = [('old', 8+layout), ('new', 24+layout)]
            if (repeat + layout + (cpu == 24)) % 2:
                pair.reverse()
            for side, seed in pair:
                schedule.append((repeat, cpu, side, seed))
with (out/'schedule.tsv').open('w') as log:
    log.write('run\trepeat\tcpu\tside\tseed\tstatus\n')
    for index, (repeat, cpu, side, seed) in enumerate(schedule,1):
        name = f'run-{index:03}-{side}-{seed}-cpu{cpu}'
        work = out/'work'/name
        work.mkdir(parents=True)
        env = dict(os.environ, BENCH_HASHES_PIN_CPU=str(cpu))
        with (out/(name+'.stdout.txt')).open('w') as stdout, (out/(name+'.stderr.txt')).open('w') as stderr:
            result = subprocess.run([
                'timeout','--kill-after=5s','60s',str(snap/f'{side}-{seed}'),
                '--contenders','blake3-servil-mt,blake3-servil-st',
                '--points','idle 64 B,idle 128 B,idle 256 B,64 B,128 B',
                '--rounds','24','--sizes',str(out/'sizes.tsv')
            ],env=env,cwd=work,stdout=stdout,stderr=stderr)
        log.write(f'{name}\t{repeat}\t{cpu}\t{side}\t{seed}\t{result.returncode}\n')
        log.flush()
        assert result.returncode == 0, (name,result.returncode)
        files = list(work.glob('benchmark-results/*/bench-hashes.samples.tsv'))
        assert len(files)==1, (name,files)
        shutil.copyfile(files[0],out/'kept'/(name+'.tsv'))
        shutil.rmtree(work)
print('Completed',len(schedule),'runs: eight binaries x two CPUs x two repeats.')
PY

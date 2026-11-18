#!/bin/sh
# Predeclared diagnostic: same executable bytes and virtual link layout,
# two observed backing-memory nodes, fully crossed with CPUs 0 and 24.
# Eight repeats/combination; original two-contender/five-point context and
# exact calibration. This tests executable-page locality, not a library fix.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
if [ "${ISSUE3_NUMA_BOUNDED:-}" != yes ]; then
  export ISSUE3_NUMA_BOUNDED=yes
  status=0
  timeout --kill-after=15s 1200s sh "$O/run.sh" || status=$?
  printf 'EXECUTABLE_NUMA_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
SOURCE="$HOME/work/issue3-fixed-context3-executables"
SNAP="$HOME/work/$(basename "$O")-executables"
export O SNAP SOURCE
mkdir "$SNAP"
mkdir "$O/kept" "$O/identities"
cp "$SOURCE/hash-blake3" "$SNAP/hash-blake3"
cp "$HOME/runs/issue3-fixed-context3/sizes.tsv" "$O/sizes.tsv"
lscpu -e=CPU,CORE,SOCKET,NODE,ONLINE > "$O/topology.txt"
python3 - <<'PY'
import hashlib,os,pathlib,subprocess
source=pathlib.Path(os.environ['SOURCE'])/'old-8'
assert hashlib.sha256(source.read_bytes()).hexdigest()=='aaebdf9a506856b0cb47af275c10afae3917f78fb05a5a49db3ab81c2a5e09c7'
assert subprocess.check_output([str(source.parent/'hash-blake3'),str(source)],text=True).split()[0]=='2ed06de017ad3587ddda19e8a91bde16efec187609146f0f71ea81f5b02fad5f'
PY
cat > "$O/place-pages.py" <<'PY'
import mmap,os,pathlib,re,sys
out=pathlib.Path(os.environ['O'])
snap=pathlib.Path(os.environ['SNAP'])
source=pathlib.Path(os.environ['SOURCE'])/'old-8'
node,cpu,action=int(sys.argv[1]),int(sys.argv[2]),sys.argv[3]
os.sched_setaffinity(0,{cpu})
path=snap/f'node{node}'
if action=='create':
    data=source.read_bytes()
    with path.open('xb') as f:
        f.write(data)
        f.flush()
        os.fsync(f.fileno())
    path.chmod(0o755)
with path.open('rb') as f, mmap.mmap(f.fileno(),0,access=mmap.ACCESS_READ) as pages:
    sum(pages[i] for i in range(0,len(pages),4096))
    lines=[l for l in pathlib.Path('/proc/self/numa_maps').read_text().splitlines() if str(path) in l]
    assert len(lines)==1, lines
    counts={int(n):int(p) for n,p in re.findall(r'\bN(\d+)=(\d+)',lines[0])}
    assert counts.get(node,0)>0 and sum(counts.values())==counts[node], (node,counts)
    print(f'node={node} writer_cpu={cpu} action={action} affinity={os.sched_getaffinity(0)}\t'+lines[0])
PY
python3 "$O/place-pages.py" 0 0 create > "$O/identities/pages-before.txt"
python3 "$O/place-pages.py" 1 24 create >> "$O/identities/pages-before.txt"
for name in node0 node1; do
  "$SNAP/$name" provenance > "$O/identities/$name.provenance.txt"
  grep -q 'bench d7723f110a6f clean; servil 27eacce3a5c2 clean' "$O/identities/$name.provenance.txt"
  (cd "$SNAP" && sha256sum "$name") >> "$O/identities/executables.SHA256SUMS"
  (cd "$SNAP" && ./hash-blake3 "$name") >> "$O/identities/executables.BLAKE3SUMS"
done
cmp "$SNAP/node0" "$SNAP/node1"
timeout 90 "$SNAP/node0" quiet --wait > "$O/quiet.txt" 2>&1
python3 - <<'PY'
import os,pathlib,shutil,subprocess
out=pathlib.Path(os.environ['O'])
snap=pathlib.Path(os.environ['SNAP'])
schedule=[]
for repeat in range(8):
    for cpu in ([0,24] if repeat%2==0 else [24,0]):
        nodes=[0,1] if (repeat+(cpu==24))%2==0 else [1,0]
        for node in nodes:
            schedule.append((repeat,cpu,node))
with (out/'schedule.tsv').open('w') as log:
    log.write('run\trepeat\tcpu\texecutable_node\tstatus\n')
    for index,(repeat,cpu,node) in enumerate(schedule,1):
        name=f'run-{index:03}-node{node}-cpu{cpu}'
        work=out/'work'/name
        work.mkdir(parents=True)
        env=dict(os.environ,BENCH_HASHES_PIN_CPU=str(cpu))
        with (out/(name+'.stdout.txt')).open('w') as stdout,(out/(name+'.stderr.txt')).open('w') as stderr:
            result=subprocess.run([
                'timeout','--kill-after=5s','60s',str(snap/f'node{node}'),
                '--contenders','blake3-servil-mt,blake3-servil-st',
                '--points','idle 64 B,idle 128 B,idle 256 B,64 B,128 B',
                '--rounds','24','--sizes',str(out/'sizes.tsv')
            ],cwd=work,env=env,stdout=stdout,stderr=stderr)
        log.write(f'{name}\t{repeat}\t{cpu}\t{node}\t{result.returncode}\n')
        log.flush()
        assert result.returncode==0,(name,result.returncode)
        files=list(work.glob('benchmark-results/*/bench-hashes.samples.tsv'))
        assert len(files)==1,(name,files)
        shutil.copyfile(files[0],out/'kept'/(name+'.tsv'))
        shutil.rmtree(work)
print('Completed',len(schedule),'runs: identical ELF bytes x two backing nodes x two CPUs x eight repeats.')
PY
python3 "$O/place-pages.py" 0 0 verify > "$O/identities/pages-after.txt"
python3 "$O/place-pages.py" 1 24 verify >> "$O/identities/pages-after.txt"
(cd "$SNAP" && sha256sum -c "$O/identities/executables.SHA256SUMS") > "$O/identities/verified-after.txt"
for name in node0 node1; do
  (cd "$SNAP" && ./hash-blake3 "$name")
done > "$O/identities/executables-after.BLAKE3SUMS"
cmp "$O/identities/executables.BLAKE3SUMS" "$O/identities/executables-after.BLAKE3SUMS"
